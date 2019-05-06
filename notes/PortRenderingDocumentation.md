# Everywhere OpenGL is currently used:
Since it is a rendering dependency, it shouldn't be integrated into the actual engine logic 
but the backend logic.

This is where it's used outside of a backend:

- Engine.hx               haxepunk/Engine.hx
- FrameBuffer.hx            haxepunk/graphics/hardware/FrameBuffer
- HardwareRenderer.hx       haxepunk/graphics/hardware/HardwareRenderer
- GL.hx                     haxepunk/graphics/hardware/opengl
- GLBuffer.hx               haxepunk/graphics/hardware
- GLFramebuffer.hx          haxepunk\graphics\hardware\opengl\GLFramebuffer.hx
- GLInternal.hx             haxepunk\graphics\hardware\opengl\GLInternal.hx
- GLProgram.hx              haxepunk\graphics\hardware\opengl\GLProgram.hx
- GLShader.hx               haxepunk\graphics\hardware\opengl\GLShader.hx
- GLTexture.hx              haxepunk\graphics\hardware\opengl\GLTexture.hx
- GLUniformLocation.hx      haxepunk\graphics\hardware\opengl\GLUniformLocation.hx
- GLUtils.hx                haxepunk\graphics\hardware\opengl\GLUtils.hx
- RenderBuffer.hx           haxepunk\graphics\hardware\RenderBuffer.hx
- SceneShader.hx            haxepunk\graphics\shader\SceneShader.hx
- Shader.hx                 haxepunk\graphics\shader\Shader.hx

- template\.vscode\completion-openfl.hxml

# Use of GL Implementions

`++`: means used externally

- HardwareRenderer.hx   : (ButtonTray.hx) (Console.hx) (Engine.hx)                                  ++
- GL.hx                 : (Shader.hx) (SceneShader.hx) (HardwareRenderer.hx)
- GLBuffer.hx           : (RenderBuffer.hx) (GL.hx)
- GLFrameBuffer         : (FrameBuffer) (GL.hx) (HardwareRenderer.hx)
- GLInternal            : (GLUtils.hx)
- GLProgram             : (Shader.hx) (GL.hx)
- GLShader              : (GL.hx) (Shader.hx)
- GLTexture             : (FrameBuffer.hx) (GL.hx) (GLTexture.hx)
- GLUniformLocation     : (GL.hx) (SceneShader.hx) (Shader.hx)
- GLUtils               : (FrameBuffer) (HardwareRenderer) (GLInternal) (RenderBuffer)
                          (SceneShader) (Shader)
- RenderBuffer          : (HardwareRenderer) (Shader)
- SceneShader           : (HardwareRenderer.hx) (Scene.hx) (asteroids example) (PixelArtScaler)     ++
- Shader                : (Graphic.hx) (Atlas, AtlasData, AtlasRegion, AtlasResolutions,            ++
                          IAtlasRegion) (DrawCommand) (DrawCommandBatch) (RenderBuffer )
                          (RenderBuffer) (Draw) (DrawContext)


# Notes:

5/3: 
I'm trying to learn how the application actually enters.

What I've learned so far is that HaxePunk _actually_ does depend on OpenGL, which
makes porting over to Kha more problematic.

I'm lost on how `Engine` works. It has a function which instantiates 
"App" but App looks like it's a stub; the only clue is that "FlashApp" has a similar structure -
but nothing indicates that it implicitly gets used as "App".

Okay. Found out that there is actually another definition for "class App" under the same package.
This clears some things up, but now I need to figure out what this behavior actually is or where 
it is coming from.

I am fairly confident it has something to do with https://haxe.org/manual/type-system-resolution-order.html/ but the order in which they are imported by a project is kind of ambiguous to me. I'm just going to assume for now that the engine module is before (at the top) and the backend comes after (bottom) and that's why it happens.

FOLLOW-UP NOTE: @Gamma11
> "packages can be spread across different directories on the file system / different -cp arguments
> if two directories (of the same package) have a module of the same name, the module is "shadowed" by the most recent occurence
> both of those things are very much intentional features"

Going Forward: HaxePunk currently has a heavy internal reliance on OpenGL. This makes porting
to Kha much more komplicated and error prone. It's a decision between touching the actual engine
rendering code or just making a shim between Kha's Graphics4 API in the backend itself.

Both of them would require a lot of work to do, but I suppose the one that makes the most sense
to start with is attempting to make a G4 shell of OpenGL. Hopefully later on it would be possible 
to refactor all of the OpenGL depedency out but that may have some breaking changes on the 
HaxePunk engine itself which is left for another time.

---

Quick Conclusion:
If all goes according to plan, I should be "able" to simply have a Kha _backend_ which mimics the
other HP backends. The additional part, vs the existing backends, is creating an OpenGL API. This 
should be easier than re-writing the entire rendering system of HaxePunk.

Problems:
- The HaxePunk rendering code may actually need to be altered
    - This is probably going to be required if I can't support 100% of all the OpenGL features.
- Any code that's using shaders will need to be refactored 
    - Kha needs to pre-process the shaders; HaxePunk leaves it all in the Haxe files.