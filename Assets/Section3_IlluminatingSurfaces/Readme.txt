Lambert

Lighting model used to calculate life reflected from surface

Vector normal, vector to viewer, vector from light source
Calculates color and intensity of the light to the viewer

Lambert defines relationship between brightness of surface and its orientation to the light source
Simplest lighting model, only considers one angle.  source to normal

Normal Mapping
==============
modify normal to make it look like raised surface
normal map is a normal per pixel.  it changes their direction.  this gives a different brightness value.  This is only for visual effect.  the geometry of the mesh does not change.

Texture (diffuse map) is just a flat texture we use to put colors on a mesh.  Lambert lighting will make it look flat.  The normal map is what makes things raise and lower.  
Red: 0 to 255 maps to X: -1 to 1
Green: 0 to 255 maps to Y: -1 to 1
Blue: 128 to 255 -> maps to Z: 0 to -1 (gives the texture its blue tinge)

X and Y are flat, Z goes through the screen (its height)
Ex: a pixel whose normal map is RGB(97,100,248) translates to a vector of XYZ(-0.2, -0.2, -0.9)
A light pink pixel RGP(196,129,235) translates to vector XYZ(0.5,0,-0.9)
The less blue, the more flat. 

Bump Mapping produces great visual results, but no geometrical changes.  
Detail in depth for very little cost to processing.


WORLD REFLECTION 
================
worldRefl - contains the world reflection vector.  It is the world space direction of a mirror reflection using the vertex interpolated surface normal.
It does not work if your surface shader uses o.Normal because you presumably want the reflection to use the per-pixel normal calculated in the surf function, not the per vertex one.

It is usually used with cube maps because the most common use of cube maps is to store a 360 world space image when sampled using world reflection vector produces a believable reflection.

ILLUMINATION MODELS
===================
Flat - simplest - uses single normal to shade each polygon, the polygon's normal.  This will make each polygon look flat. 

Gourad - the color of pixels across polygon are interpolated by each normal at each vector (the three of a triangle).  Does not blend well with lighting

Phong - flat appears curve by modifying the normals on a per pixel basis.  Blended shading across each polygon.  Smooth appearance.  Used by unity by default.

If you want to change the model used, in the model you are bringing in - set under Normals & Tangents - the Normals to Calculate and Smoothing Angle = 0, and then Apply.

BUFFERS AND RENDER QUEUES
==========================
Typically render front to back.  Anything behind something is ignored.
You can turn zed buffer off preventing depth information recorded.  

Do this by saying ZWriteOff

Background (1000), Geometry (2000), AlphaTest (2450), Transparent (3000), Overlay (4000) queues exist
Render Queue - you can set a value over when it gets drawn

Tags {"Queue" = "Geometry"} tells it what queue to add it to to draw it
Stating "Geometry+100" changes its order in the queue to be drawn

G-BUFFER - the Geometry Buffer
==============================
