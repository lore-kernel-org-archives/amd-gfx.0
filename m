From: Christopher James Halse Rogers <christopher.halse.rogers-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: Re: [PATCH 3/6] drm/amdgpu: Fail fb creation from imported dma-bufs.
Date: Wed, 29 Mar 2017 03:41:43 +0000
Message-ID: <CAPMmPExAf+SyBNaTRFC286xxiH+Vv4rheyBfhko=L+nn9oSYhg@mail.gmail.com>
References: <20170329002720.11445-1-raof@ubuntu.com>
 <20170329002720.11445-4-raof@ubuntu.com>
 <4a950f45-3ad5-2d63-c434-0474e8cfda37@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0420585641=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <4a950f45-3ad5-2d63-c434-0474e8cfda37-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, raof-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0420585641==
Content-Type: multipart/alternative; boundary=f403045d9ab27f0a6a054bd65b99

--f403045d9ab27f0a6a054bd65b99
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Mar 2017 at 13:04 Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org> wrote:

> On 29/03/17 09:27 AM, raof-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org wrote:
> > From: Christopher James Halse Rogers <
> christopher.halse.rogers-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
> >
> > Any use of the framebuffer will migrate it to VRAM, which is not
> sensible for
> > an imported dma-buf.
> >
> > Signed-off-by: Christopher James Halse Rogers <
> christopher.halse.rogers-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
> > CC: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > index 39fc388f222a..e7c3cc5b7d62 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > @@ -612,6 +612,12 @@ amdgpu_user_framebuffer_create(struct drm_device
> *dev,
> >               return ERR_PTR(-ENOENT);
> >       }
> >
> > +     /* Handle is imported dma-buf, so cannot be migrated to VRAM for
> scanout */
>
> Newer APUs support scanout from GTT, though they still impose some
> restrictions which will probably not be satisfied in general by BOs
> imported from other drivers. So this is probably okay for now.
>

As far as I can tell amdgpu unconditionally migrates to VRAM when trying to
scanout at the moment. When that changes, so can this check :).



> > +     if (obj->import_attach) {
> > +             dev_err(&dev->pdev->dev, "Cannot create framebuffer from
> imported dma_buf\n");
>
> This should probably be something like DRM_DEBUG, so userspace can't
> spam dmesg by default. Same for patch 5.
>
> Ta. v2 incoming.

--f403045d9ab27f0a6a054bd65b99
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed, 29 Mar=
 2017 at 13:04 Michel D=C3=A4nzer &lt;<a href=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org"=
>michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
On 29/03/17 09:27 AM, <a href=3D"mailto:raof-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org" class=3D"gmail_msg=
" target=3D"_blank">raof-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org</a> wrote:<br class=3D"gmail_msg">
&gt; From: Christopher James Halse Rogers &lt;<a href=3D"mailto:christopher=
.halse.rogers-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org" class=3D"gmail_msg" target=3D"_blank">christop=
her.halse.rogers-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org</a>&gt;<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; Any use of the framebuffer will migrate it to VRAM, which is not sensi=
ble for<br class=3D"gmail_msg">
&gt; an imported dma-buf.<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; Signed-off-by: Christopher James Halse Rogers &lt;<a href=3D"mailto:ch=
ristopher.halse.rogers-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org" class=3D"gmail_msg" target=3D"_blank"=
>christopher.halse.rogers-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org</a>&gt;<br class=3D"gmail_msg">
&gt; CC: <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" class=3D"gmail_ms=
g" target=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br class=3D"gmail_ms=
g">
&gt; ---<br class=3D"gmail_msg">
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 6 ++++++<br class=
=3D"gmail_msg">
&gt;=C2=A0 1 file changed, 6 insertions(+)<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_display.c<br class=3D"gmail_msg">
&gt; index 39fc388f222a..e7c3cc5b7d62 100644<br class=3D"gmail_msg">
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br class=3D"gmail_ms=
g">
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br class=3D"gmail_ms=
g">
&gt; @@ -612,6 +612,12 @@ amdgpu_user_framebuffer_create(struct drm_device =
*dev,<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_PTR(-=
ENOENT);<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; +=C2=A0 =C2=A0 =C2=A0/* Handle is imported dma-buf, so cannot be migra=
ted to VRAM for scanout */<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Newer APUs support scanout from GTT, though they still impose some<br class=
=3D"gmail_msg">
restrictions which will probably not be satisfied in general by BOs<br clas=
s=3D"gmail_msg">
imported from other drivers. So this is probably okay for now.<br class=3D"=
gmail_msg"></blockquote><div><br></div><div>As far as I can tell amdgpu unc=
onditionally migrates to VRAM when trying to scanout at the moment. When th=
at changes, so can this check :).<br></div><div><br>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0if (obj-&gt;import_attach) {<br class=3D"gmail_ms=
g">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;dev-&gt;=
pdev-&gt;dev, &quot;Cannot create framebuffer from imported dma_buf\n&quot;=
);<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
This should probably be something like DRM_DEBUG, so userspace can&#39;t<br=
 class=3D"gmail_msg">
spam dmesg by default. Same for patch 5.<br class=3D"gmail_msg">
<br class=3D"gmail_msg"></blockquote>Ta. v2 incoming.<br></div></div>

--f403045d9ab27f0a6a054bd65b99--

--===============0420585641==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0420585641==--
