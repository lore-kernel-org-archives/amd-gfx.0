From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: remove duplicate evict_vram in suspend path
Date: Sun, 09 Oct 2016 17:54:45 +0000
Message-ID: <CAAzXoRKnei7U3hvUCosvpOB8z9kM6CL1Lg5GduyzfUpW9ZrxKQ@mail.gmail.com>
References: <1475696538-24754-1-git-send-email-alexander.deucher@amd.com>
 <5f17b1d4-b088-4ed7-06b7-86b4c85bd4f0@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0648068439=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5f17b1d4-b088-4ed7-06b7-86b4c85bd4f0-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

--===============0648068439==
Content-Type: multipart/alternative; boundary=001a114edc0055fb90053e7257e0

--001a114edc0055fb90053e7257e0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Yup that's what I said in another part of the thread :-)

i'm a trailblazer of bad ideas at times :-) hehehehe

Tom

On Sun, Oct 9, 2016 at 11:13 AM Christian K=C3=B6nig <deathsimple@vodafone.=
de>
wrote:

> Am 05.10.2016 um 21:42 schrieb Alex Deucher:
> > Looks like fallout from a rebase or merge.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>
> NAK, this is done on purpose and is for evicting the GART table using
> memcpy.
>
> Tom wanted to remove that as well and it makes resume then fail horrible
> on dGPUs.
>
> We should probably add a comment why this is necessary.
>
> Christian.
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---
> >   1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 45259b5..c2f70be 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -1956,9 +1956,6 @@ int amdgpu_device_suspend(struct drm_device *dev,
> bool suspend, bool fbcon)
> >
> >       r =3D amdgpu_suspend(adev);
> >
> > -     /* evict remaining vram memory */
> > -     amdgpu_bo_evict_vram(adev);
> > -
> >       pci_save_state(dev->pdev);
> >       if (suspend) {
> >               /* Shut down the device */
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--001a114edc0055fb90053e7257e0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yup that&#39;s what I said in another part of the thread :=
-)<div><br></div><div>i&#39;m a trailblazer of bad ideas at times :-) heheh=
ehe</div><div><br></div><div>Tom</div></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr">On Sun, Oct 9, 2016 at 11:13 AM Christian K=C3=B6nig &lt;<=
a href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">Am 05.10.2016 um 21:42 schrie=
b Alex Deucher:<br class=3D"gmail_msg">
&gt; Looks like fallout from a rebase or merge.<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@am=
d.com" class=3D"gmail_msg" target=3D"_blank">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&=
gt;<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
NAK, this is done on purpose and is for evicting the GART table using<br cl=
ass=3D"gmail_msg">
memcpy.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Tom wanted to remove that as well and it makes resume then fail horrible<br=
 class=3D"gmail_msg">
on dGPUs.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
We should probably add a comment why this is necessary.<br class=3D"gmail_m=
sg">
<br class=3D"gmail_msg">
Christian.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
&gt; ---<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---<br clas=
s=3D"gmail_msg">
&gt;=C2=A0 =C2=A01 file changed, 3 deletions(-)<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br class=3D"gmail_msg">
&gt; index 45259b5..c2f70be 100644<br class=3D"gmail_msg">
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br class=3D"gmail_msg=
">
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br class=3D"gmail_msg=
">
&gt; @@ -1956,9 +1956,6 @@ int amdgpu_device_suspend(struct drm_device *dev=
, bool suspend, bool fbcon)<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_suspend(adev);<br class=3D"gmai=
l_msg">
&gt;<br class=3D"gmail_msg">
&gt; -=C2=A0 =C2=A0 =C2=A0/* evict remaining vram memory */<br class=3D"gma=
il_msg">
&gt; -=C2=A0 =C2=A0 =C2=A0amdgpu_bo_evict_vram(adev);<br class=3D"gmail_msg=
">
&gt; -<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pci_save_state(dev-&gt;pdev);<br class=3D"gm=
ail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (suspend) {<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Shut down the=
 device */<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
_______________________________________________<br class=3D"gmail_msg">
amd-gfx mailing list<br class=3D"gmail_msg">
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" class=3D"gmail_msg" target=
=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br class=3D"gmail_msg">
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" class=3D"gmail_msg" target=3D"_blank">https://lists.freedesktop.=
org/mailman/listinfo/amd-gfx</a><br class=3D"gmail_msg">
</blockquote></div>

--001a114edc0055fb90053e7257e0--

--===============0648068439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0648068439==--
