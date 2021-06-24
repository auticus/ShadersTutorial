Basic Data Types

float - highest precision value - 32 bits - world positions and texture coordinations

half - half float.  16 bits - used for short vectors, directions, dynamic color range

fixed - lowest precision 11 bits, used for regular colors and simple color opreations

int - used for counters and indices

Texture Data Types
===================
sampler2D

samplerCube

Packed Arrays
=============
fixed4 color1 = (0,1,1,0);
accessed via r,g,b, or a  OR x,y,z,w
color1.a = 1
color1.x = 1 - same thing

fixed3 color3;
color3 = color1.rgb  ... OR swizzle color1.bgr for example

Masking - color1.rg = color2.gr

Packed Matrices
=================
float4x4 matrix;
float myValue = matrix._m00;

int3x3 matrix;
matrix._m20 is the third row first column (0 based)
matrix._m00 is the first row first column
so the numbers are row,column

fixed4 color = matrix._m00_m01_m02_m03;  this is getting all four of those values via chaining
fixed4 color = matrix[0] - gets the entire first row

NORMALS
========
stick out 90 degrees to show you what the front is

The arrays we look at in any given mesh:
Vertex Array - list of all the points that make up the triangles
Normal Array - list of all the normal vertices that show the face
UV Array - list that shows how texures wrap around each triangle
Triangle Array - each individual polygon triangle

UV represents a point of a texture mapped to a point on a triangle
UV represented by u, v, w.  UV is typically a 2D value
They fall between 0 and 1 no matter how big the texture.
Ordered in counter clockwise

If you only want top left corner, you'd have a 0.5, 1

Meshes can have multiple UVs.  If you have more than one image each has a UV.  In Unity we can use two UVs.

in the INPUT section of the shader:
=====================================
https://docs.unity3d.com/Manual/SL-SurfaceShaders.html

uv or uv2 can get a hold of the uv values to put texture on mesh
float2 uv_MainTex;
float2 uv2_MainTex;

float3 viewDir;  contains view direction, for computing rim lighting, etc
float3 worldPos - world space position - to show or not to show based on world location
float3 worldRefl - reflection data.  shiny objects that have mirror finished

Can combine them in the input struct to get the shader effect.  Do not use ones not used.  they are costly.  

PROPERTIES
============
how we get data into the shader
Color - color picture
Texture box - image
Cube - cube map
float - multiplier
Vector - four float values together
Range - a range of values
3D - a 3d image you can do in code - to perform 3d color correction

Texture Tiling
==============
1 by 1 tiling is a 1 for one, 1 copy of the texture
increasing the size of tiling, if you want 4 squares of texture, you'd make it 2x2... four copies wrapped around.

Offset moves the starting location of the UV

