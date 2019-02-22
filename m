From: Bruno Milreu <bmilreu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Use vrr friendly pageflip throttling in
 DC
Date: Fri, 22 Feb 2019 00:30:17 -0300
Message-ID: <CAHryUMfZXZDUwr=Ykoj5eBtkvSDJukNXCuyogfjsPohnyHCmmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1322163453=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1322163453==
Content-Type: multipart/alternative; boundary="0000000000005e201e0582733683"

--0000000000005e201e0582733683
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2/9/19 1:52 AM, Mario Kleiner wrote:
> In VRR mode, keep track of the vblank count of the last
> completed pageflip in amdgpu_crtc->last_flip_vblank, as
> recorded in the pageflip completion handler after each
> completed flip.
>
> Use that count to prevent mmio programming a new pageflip
> within the same vblank in which the last pageflip completed,
> iow. to throttle pageflips to at most one flip per video
> frame, while at the same time allowing to request a flip
> not only before start of vblank, but also anywhere within
> vblank.
>
> The old logic did the same, and made sense for regular fixed
> refresh rate flipping, but in vrr mode it prevents requesting
> a flip anywhere inside the possibly huge vblank, thereby
> reducing framerate in vrr mode instead of improving it, by
> delaying a slightly delayed flip requests up to a maximum
> vblank duration + 1 scanout duration. This would limit VRR
> usefulness to only help applications with a very high GPU
> demand, which can submit the flip request before start of
> vblank, but then have to wait long for fences to complete.
>
> With this method a flip can be both requested and - after
> fences have completed - executed, ie. it doesn't matter if
> the request (amdgpu_dm_do_flip()) gets delayed until deep
> into the extended vblank due to cpu execution delays. This
> also allows clients which want to regulate framerate within
> the vrr range a much more fine-grained control of flip timing,
> a feature that might be useful for video playback, and is
> very useful for neuroscience/vision research applications.
>
> In regular non-VRR mode, retain the old flip submission
> behavior. This to keep flip scheduling for fullscreen X11/GLX
> OpenGL clients intact, if they use the GLX_OML_sync_control
> extensions glXSwapBufferMscOML(, ..., target_msc,...) function
> with a specific target_msc target vblank count.
>
> glXSwapBuffersMscOML() or DRI3/Present PresentPixmap() will
> not flip at the proper target_msc for a non-zero target_msc
> if VRR mode is active with this patch. They'd often flip one
> frame too early. However, this limitation should not matter
> much in VRR mode, as scheduling based on vblank counts is
> pretty futile/unusable under variable refresh duration
> anyway, so no real extra harm is done.
>
> According to some testing already done with this patch by
> Nicholas on top of my tests, IGT tests didn't report any
> problems. If fixes stuttering and flickering when flipping
> at rates below the minimum vrr refresh rate.
>
> Fixes: bb47de736661 ("drm/amdgpu: Set FreeSync state using drm VRR
> properties")
> Signed-off-by: Mario Kleiner <mario.kleiner.de at gmail.com>
> Cc: <stable at vger.kernel.org>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas at amd.com>
> Cc: Harry Wentland <harry.wentland at amd.com>
> Cc: Alex Deucher <alexander.deucher at amd.com>
> Cc: Michel D=C3=A4nzer <michel at daenzer.net>

This gets rid of stuttering with FreeSync for me. The current behavior
shows constant periodic stutters at lower than maximum framerates. Please
try pushing this into 5.1.

Tested-by: Bruno Filipe<bmilreu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--0000000000005e201e0582733683
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On 2/9/19 1:52 AM, Mario Kleiner wrote:<br>&gt; In VRR mod=
e, keep track of the vblank count of the last<br>&gt; completed pageflip in=
 amdgpu_crtc-&gt;last_flip_vblank, as<br>&gt; recorded in the pageflip comp=
letion handler after each<br>&gt; completed flip.<br>&gt; <br>&gt; Use that=
 count to prevent mmio programming a new pageflip<br>&gt; within the same v=
blank in which the last pageflip completed,<br>&gt; iow. to throttle pagefl=
ips to at most one flip per video<br>&gt; frame, while at the same time all=
owing to request a flip<br>&gt; not only before start of vblank, but also a=
nywhere within<br>&gt; vblank.<br>&gt; <br>&gt; The old logic did the same,=
 and made sense for regular fixed<br>&gt; refresh rate flipping, but in vrr=
 mode it prevents requesting<br>&gt; a flip anywhere inside the possibly hu=
ge vblank, thereby<br>&gt; reducing framerate in vrr mode instead of improv=
ing it, by<br>&gt; delaying a slightly delayed flip requests up to a maximu=
m<br>&gt; vblank duration + 1 scanout duration. This would limit VRR<br>&gt=
; usefulness to only help applications with a very high GPU<br>&gt; demand,=
 which can submit the flip request before start of<br>&gt; vblank, but then=
 have to wait long for fences to complete.<br>&gt; <br>&gt; With this metho=
d a flip can be both requested and - after<br>&gt; fences have completed - =
executed, ie. it doesn&#39;t matter if<br>&gt; the request (amdgpu_dm_do_fl=
ip()) gets delayed until deep<br>&gt; into the extended vblank due to cpu e=
xecution delays. This<br>&gt; also allows clients which want to regulate fr=
amerate within<br>&gt; the vrr range a much more fine-grained control of fl=
ip timing,<br>&gt; a feature that might be useful for video playback, and i=
s<br>&gt; very useful for neuroscience/vision research applications.<br>&gt=
; <br>&gt; In regular non-VRR mode, retain the old flip submission<br>&gt; =
behavior. This to keep flip scheduling for fullscreen X11/GLX<br>&gt; OpenG=
L clients intact, if they use the GLX_OML_sync_control<br>&gt; extensions g=
lXSwapBufferMscOML(, ..., target_msc,...) function<br>&gt; with a specific =
target_msc target vblank count.<br>&gt; <br>&gt; glXSwapBuffersMscOML() or =
DRI3/Present PresentPixmap() will<br>&gt; not flip at the proper target_msc=
 for a non-zero target_msc<br>&gt; if VRR mode is active with this patch. T=
hey&#39;d often flip one<br>&gt; frame too early. However, this limitation =
should not matter<br>&gt; much in VRR mode, as scheduling based on vblank c=
ounts is<br>&gt; pretty futile/unusable under variable refresh duration<br>=
&gt; anyway, so no real extra harm is done.<br>&gt; <br>&gt; According to s=
ome testing already done with this patch by<br>&gt; Nicholas on top of my t=
ests, IGT tests didn&#39;t report any<br>&gt; problems. If fixes stuttering=
 and flickering when flipping<br>&gt; at rates below the minimum vrr refres=
h rate.<br>&gt; <br>&gt; Fixes: bb47de736661 (&quot;drm/amdgpu: Set FreeSyn=
c state using drm VRR<br>&gt; properties&quot;)<br>&gt; Signed-off-by: Mari=
o Kleiner &lt;<a href=3D"http://mario.kleiner.de">mario.kleiner.de</a> at <=
a href=3D"http://gmail.com">gmail.com</a>&gt;<br>&gt; Cc: &lt;stable at <a =
href=3D"http://vger.kernel.org">vger.kernel.org</a>&gt;<br>&gt; Cc: Nichola=
s Kazlauskas &lt;nicholas.kazlauskas at <a href=3D"http://amd.com">amd.com<=
/a>&gt;<br>&gt; Cc: Harry Wentland &lt;harry.wentland at <a href=3D"http://=
amd.com">amd.com</a>&gt;<br>&gt; Cc: Alex Deucher &lt;alexander.deucher at =
<a href=3D"http://amd.com">amd.com</a>&gt;<br>&gt; Cc: Michel D=C3=A4nzer &=
lt;michel at <a href=3D"http://daenzer.net">daenzer.net</a>&gt;<div><br><di=
v>This gets rid of stuttering with FreeSync for me. The current behavior sh=
ows constant periodic stutters at lower than maximum framerates. Please try=
 pushing this into 5.1.</div><div><br></div><div>Tested-by: Bruno Filipe&lt=
;<a href=3D"mailto:bmilreu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">bmilreu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</div></div>=
</div>

--0000000000005e201e0582733683--

--===============1322163453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1322163453==--
