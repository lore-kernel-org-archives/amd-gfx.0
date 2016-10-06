From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: remove duplicate evict_vram in suspend path
Date: Thu, 06 Oct 2016 01:10:43 +0000
Message-ID: <CAAzXoRJTTXa=1Y-=z-7Q-Bjw5+VuJ09dQsekwYL4vHbHFtL9Hg@mail.gmail.com>
References: <1475696538-24754-1-git-send-email-alexander.deucher@amd.com>
 <CAPM=9txmXEg-i7=gPs+6pQebxJ7nRkFDAtv32uvyiG+Cb6Wo4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1658701911=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAPM=9txmXEg-i7=gPs+6pQebxJ7nRkFDAtv32uvyiG+Cb6Wo4A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1658701911==
Content-Type: multipart/alternative; boundary=94eb2c149866183399053e27f74e

--94eb2c149866183399053e27f74e
Content-Type: text/plain; charset=UTF-8

I proposed to remove that when running into SDMA job out-of-order issues
and Christian K very strongly NAK'ed that (a couple of times).

So I suspect he'll do it again.

Tom


On Wed, Oct 5, 2016 at 8:10 PM Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On 6 October 2016 at 05:42, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > Looks like fallout from a rebase or merge.
>
> Nearly sure we do it twice on purpose, at least radeon does it as well.
>
> so NAK without a better explaination.
>
> Dave.
>
> >
> > Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 45259b5..c2f70be 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -1956,9 +1956,6 @@ int amdgpu_device_suspend(struct drm_device *dev,
> bool suspend, bool fbcon)
> >
> >         r = amdgpu_suspend(adev);
> >
> > -       /* evict remaining vram memory */
> > -       amdgpu_bo_evict_vram(adev);
> > -
> >         pci_save_state(dev->pdev);
> >         if (suspend) {
> >                 /* Shut down the device */
> > --
> > 2.5.5
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--94eb2c149866183399053e27f74e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I proposed to remove that when running into SDMA job out-o=
f-order issues and Christian K very strongly NAK&#39;ed that (a couple of t=
imes).<div><br></div><div>So I suspect he&#39;ll do it again.</div><div><br=
></div><div>Tom</div><div><br></div></div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr">On Wed, Oct 5, 2016 at 8:10 PM Dave Airlie &lt;<a href=3D"ma=
ilto:airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">On 6 October 2016 at 05:42, Alex Deucher &lt;<a href=
=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" class=3D"gmail_msg" target=3D"_blank">ale=
xdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br class=3D"gmail_msg">
&gt; Looks like fallout from a rebase or merge.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Nearly sure we do it twice on purpose, at least radeon does it as well.<br =
class=3D"gmail_msg">
<br class=3D"gmail_msg">
so NAK without a better explaination.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Dave.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@am=
d.com" class=3D"gmail_msg" target=3D"_blank">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&=
gt;<br class=3D"gmail_msg">
&gt; ---<br class=3D"gmail_msg">
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---<br class=3D"g=
mail_msg">
&gt;=C2=A0 1 file changed, 3 deletions(-)<br class=3D"gmail_msg">
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
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_suspend(adev);<br class=
=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0/* evict remaining vram memory */<br class=
=3D"gmail_msg">
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_bo_evict_vram(adev);<br class=3D"gm=
ail_msg">
&gt; -<br class=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_save_state(dev-&gt;pdev);<br clas=
s=3D"gmail_msg">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (suspend) {<br class=3D"gmail_msg"=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Shut d=
own the device */<br class=3D"gmail_msg">
&gt; --<br class=3D"gmail_msg">
&gt; 2.5.5<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; _______________________________________________<br class=3D"gmail_msg"=
>
&gt; amd-gfx mailing list<br class=3D"gmail_msg">
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" class=3D"gmail_msg" t=
arget=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br class=3D"gmail_msg">
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" class=3D"gmail_msg" target=3D"_blank">https://lists.freedes=
ktop.org/mailman/listinfo/amd-gfx</a><br class=3D"gmail_msg">
_______________________________________________<br class=3D"gmail_msg">
amd-gfx mailing list<br class=3D"gmail_msg">
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" class=3D"gmail_msg" target=
=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br class=3D"gmail_msg">
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" class=3D"gmail_msg" target=3D"_blank">https://lists.freedesktop.=
org/mailman/listinfo/amd-gfx</a><br class=3D"gmail_msg">
</blockquote></div>

--94eb2c149866183399053e27f74e--

--===============1658701911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1658701911==--
