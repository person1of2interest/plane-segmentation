import numpy as np
import open3d as o3d
from sys import argv
from sklearn import linear_model

name=argv[1]
name=input()
name=name[2:]

pcd=o3d.io.read_point_cloud(name)

# Convert Open3D.o3d.geometry.PointCloud to numpy array
xyz=np.asarray(pcd.points)

# Create an array with color values for each point
pcd_colors=np.asarray(pcd.colors)

# Select all the colors
colors=np.unique(pcd_colors, axis=0)

# Eliminate black dots 
colors=sorted(colors, key=lambda colors: (colors[0], colors[1], colors[2]))
colors=colors[1:]

# Create a list, the elements of which are lists of points belonging to the same plane (avoiding points with coordinates (0;0;0))
sep_lst=[]
for k in range(len(colors)):
    sep_lst.append([])

for point in range(len(xyz)):
    for it in range(len(colors)):
        if pcd_colors[point][0]==colors[it][0] and pcd_colors[point][1]==colors[it][1] and pcd_colors[point][2]==colors[it][2]:
            if not (xyz[point][0]==xyz[point][1]==xyz[point][2]==0):
                sep_lst[it].append(xyz[point])
            break

# Remove the empty list (which was created for points with coordinates (0;0;0), since they are the same color)
for j in range(len(sep_lst)):
    if not len(sep_lst[j]):
        sep_lst.pop(j)
        break


# A function that takes a list of points from the plane, applies RANSAC and colors the outliers black
def fransac(points):

    X=np.array(points)
    y=np.negative(np.ones((X.shape[0],1)))
    
    X_colors=[]

    ransac=linear_model.RANSACRegressor(residual_threshold=0.003, max_trials=200)
    ransac.set_params(**{'base_estimator':linear_model.LinearRegression(fit_intercept=False)})
    ransac.fit(X,y)

    color=np.random.sample([3])
    
    for point in range(X.shape[0]):
        
        if not ransac.inlier_mask_[point]:
            X_colors.append(np.array([0., 0., 0.,])) 
        else:
            X_colors.append(color)

    return np.array([X, X_colors])


# Apply fransac to each plane and create a general list of points and a general list of their colors
lst_pts=[]
lst_col=[]
for plane in range(len(sep_lst)):
    if plane!=0:
        lst_pts=np.vstack((lst_pts, fransac(sep_lst[plane])[0]))
        lst_col=np.vstack((lst_col, fransac(sep_lst[plane])[1]))
    else:
        lst_pts=fransac(sep_lst[plane])[0]
        lst_col=fransac(sep_lst[plane])[1]
      
# Create a pcd file similar to the original one, but with improved planes
pcd_ransac=o3d.geometry.PointCloud()
pcd_ransac.points=o3d.utility.Vector3dVector(lst_pts)
pcd_ransac.colors=o3d.utility.Vector3dVector(lst_col)
o3d.io.write_point_cloud("my_out/ref"+name, pcd_ransac)


