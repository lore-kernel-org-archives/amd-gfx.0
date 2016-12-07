From: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: just suspend the hw on pci shutdown
Date: Wed, 07 Dec 2016 04:59:34 +0000
Message-ID: <CAHbf0-HB02ASxouwHyG9X5EdK3hz03OGVY7pyGgtzVEUd34=wg@mail.gmail.com>
References: <1481064901-15982-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0938622661=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1481064901-15982-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--===============0938622661==
Content-Type: multipart/alternative; boundary=047d7bae4532b8b12105430a6302

--047d7bae4532b8b12105430a6302
Content-Type: text/plain; charset=UTF-8

Feel free to add a reported and tested by flag

Thanks for sorting this

On Tue, 6 Dec 2016 at 22:55 Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> We can't just reuse pci_remove as there may be userspace still
> doing things.
>
> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=98638
> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=97980
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 5 ++++-
>  3 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 946dfcc..123f8152 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1714,6 +1714,7 @@ void amdgpu_driver_postclose_kms(struct drm_device
> *dev,
>                                  struct drm_file *file_priv);
>  void amdgpu_driver_preclose_kms(struct drm_device *dev,
>                                 struct drm_file *file_priv);
> +int amdgpu_suspend(struct amdgpu_device *adev);
>  int amdgpu_device_suspend(struct drm_device *dev, bool suspend, bool
> fbcon);
>  int amdgpu_device_resume(struct drm_device *dev, bool resume, bool fbcon);
>  u32 amdgpu_get_vblank_counter_kms(struct drm_device *dev, unsigned int
> pipe);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4701d94..8b39fd3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1530,7 +1530,7 @@ static int amdgpu_fini(struct amdgpu_device *adev)
>         return 0;
>  }
>
> -static int amdgpu_suspend(struct amdgpu_device *adev)
> +int amdgpu_suspend(struct amdgpu_device *adev)
>  {
>         int i, r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 3210081..6e4e3a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -486,12 +486,15 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>  static void
>  amdgpu_pci_shutdown(struct pci_dev *pdev)
>  {
> +       struct drm_device *dev = pci_get_drvdata(pdev);
> +       struct amdgpu_device *adev = dev->dev_private;
> +
>         /* if we are running in a VM, make sure the device
>          * torn down properly on reboot/shutdown.
>          * unfortunately we can't detect certain
>          * hypervisors so just do this all the time.
>          */
> -       amdgpu_pci_remove(pdev);
> +       amdgpu_suspend(adev);
>  }
>
>  static int amdgpu_pmops_suspend(struct device *dev)
> --
> 2.5.5
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--047d7bae4532b8b12105430a6302
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Feel free to add a reported and tested by flag<div><br></d=
iv><div>Thanks for sorting this</div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr">On Tue, 6 Dec 2016 at 22:55 Alex Deucher &lt;<a href=3D"mai=
lto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">We can&#39;t just reuse pci_remove as there ma=
y be userspace still<br class=3D"gmail_msg">
doing things.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Bugzilla: <a href=3D"https://bugs.freedesktop.org/show_bug.cgi?id=3D98638" =
rel=3D"noreferrer" class=3D"gmail_msg" target=3D"_blank">https://bugs.freed=
esktop.org/show_bug.cgi?id=3D98638</a><br class=3D"gmail_msg">
Bugzilla: <a href=3D"https://bugs.freedesktop.org/show_bug.cgi?id=3D97980" =
rel=3D"noreferrer" class=3D"gmail_msg" target=3D"_blank">https://bugs.freed=
esktop.org/show_bug.cgi?id=3D97980</a><br class=3D"gmail_msg">
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org=
" class=3D"gmail_msg" target=3D"_blank">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<b=
r class=3D"gmail_msg">
Cc: <a href=3D"mailto:stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" class=3D"gmail_msg" target=3D=
"_blank">stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br class=3D"gmail_msg">
---<br class=3D"gmail_msg">
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 +<=
br class=3D"gmail_msg">
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-<br class=3D"gmail_m=
sg">
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c=C2=A0 =C2=A0 | 5 ++++-<br cla=
ss=3D"gmail_msg">
=C2=A03 files changed, 6 insertions(+), 2 deletions(-)<br class=3D"gmail_ms=
g">
<br class=3D"gmail_msg">
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br class=3D"gmail_msg">
index 946dfcc..123f8152 100644<br class=3D"gmail_msg">
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br class=3D"gmail_msg">
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br class=3D"gmail_msg">
@@ -1714,6 +1714,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *d=
ev,<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_file *file_priv);<b=
r class=3D"gmail_msg">
=C2=A0void amdgpu_driver_preclose_kms(struct drm_device *dev,<br class=3D"g=
mail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_file *file_priv);<br clas=
s=3D"gmail_msg">
+int amdgpu_suspend(struct amdgpu_device *adev);<br class=3D"gmail_msg">
=C2=A0int amdgpu_device_suspend(struct drm_device *dev, bool suspend, bool =
fbcon);<br class=3D"gmail_msg">
=C2=A0int amdgpu_device_resume(struct drm_device *dev, bool resume, bool fb=
con);<br class=3D"gmail_msg">
=C2=A0u32 amdgpu_get_vblank_counter_kms(struct drm_device *dev, unsigned in=
t pipe);<br class=3D"gmail_msg">
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br class=3D"gmail_msg">
index 4701d94..8b39fd3 100644<br class=3D"gmail_msg">
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br class=3D"gmail_msg">
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br class=3D"gmail_msg">
@@ -1530,7 +1530,7 @@ static int amdgpu_fini(struct amdgpu_device *adev)<br=
 class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br class=3D"gmail_msg">
=C2=A0}<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
-static int amdgpu_suspend(struct amdgpu_device *adev)<br class=3D"gmail_ms=
g">
+int amdgpu_suspend(struct amdgpu_device *adev)<br class=3D"gmail_msg">
=C2=A0{<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i, r;<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br class=3D"gmail_msg">
index 3210081..6e4e3a1 100644<br class=3D"gmail_msg">
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br class=3D"gmail_msg">
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br class=3D"gmail_msg">
@@ -486,12 +486,15 @@ amdgpu_pci_remove(struct pci_dev *pdev)<br class=3D"g=
mail_msg">
=C2=A0static void<br class=3D"gmail_msg">
=C2=A0amdgpu_pci_shutdown(struct pci_dev *pdev)<br class=3D"gmail_msg">
=C2=A0{<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_device *dev =3D pci_get_drvdata(pdev=
);<br class=3D"gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev =3D dev-&gt;dev_priv=
ate;<br class=3D"gmail_msg">
+<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* if we are running in a VM, make sure the dev=
ice<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* torn down properly on reboot/shutdown.<=
br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* unfortunately we can&#39;t detect certa=
in<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* hypervisors so just do this all the tim=
e.<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_pci_remove(pdev);<br class=3D"gmail_msg"=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_suspend(adev);<br class=3D"gmail_msg">
=C2=A0}<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0static int amdgpu_pmops_suspend(struct device *dev)<br class=3D"gmail=
_msg">
--<br class=3D"gmail_msg">
2.5.5<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
_______________________________________________<br class=3D"gmail_msg">
amd-gfx mailing list<br class=3D"gmail_msg">
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" class=3D"gmail_msg" target=
=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br class=3D"gmail_msg">
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" class=3D"gmail_msg" target=3D"_blank">https://lists.freedesktop.=
org/mailman/listinfo/amd-gfx</a><br class=3D"gmail_msg">
</blockquote></div>

--047d7bae4532b8b12105430a6302--

--===============0938622661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0938622661==--
