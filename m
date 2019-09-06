From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm: add drm device name
Date: Fri, 6 Sep 2019 18:15:41 -0400
Message-ID: <CAAxE2A45N4gMYrcETDpznGKyxLztuwenFasL19a81QQmBkYiww@mail.gmail.com>
References: <20190903214040.2386-1-sonny.jiang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1697656043=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190903214040.2386-1-sonny.jiang-5C7GfCeVMHo@public.gmane.org>
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
To: dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Jiang, Sonny" <Sonny.Jiang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1697656043==
Content-Type: multipart/alternative; boundary="0000000000008d9f850591e9c93b"

--0000000000008d9f850591e9c93b
Content-Type: text/plain; charset="UTF-8"

+ dri-devel

On Tue, Sep 3, 2019 at 5:41 PM Jiang, Sonny <Sonny.Jiang-5C7GfCeVMHo@public.gmane.org> wrote:

> Add DRM device name and use DRM_IOCTL_VERSION ioctl drmVersion::desc
> passing it to user space
> instead of unused DRM driver name descriptor.
>
> Change-Id: I809f6d3e057111417efbe8fa7cab8f0113ba4b21
> Signed-off-by: Sonny Jiang <sonny.jiang-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 ++
>  drivers/gpu/drm/drm_drv.c                  | 17 +++++++++++++++++
>  drivers/gpu/drm/drm_ioctl.c                |  2 +-
>  include/drm/drm_device.h                   |  3 +++
>  include/drm/drm_drv.h                      |  1 +
>  5 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 67b09cb2a9e2..8f0971cea363 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2809,6 +2809,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         /* init the mode config */
>         drm_mode_config_init(adev->ddev);
>
> +       drm_dev_set_name(adev->ddev, amdgpu_asic_name[adev->asic_type]);
> +
>         r = amdgpu_device_ip_init(adev);
>         if (r) {
>                 /* failed in exclusive mode due to timeout */
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 862621494a93..6c33879bb538 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -802,6 +802,7 @@ void drm_dev_fini(struct drm_device *dev)
>         mutex_destroy(&dev->struct_mutex);
>         drm_legacy_destroy_members(dev);
>         kfree(dev->unique);
> +       kfree(dev->name);
>  }
>  EXPORT_SYMBOL(drm_dev_fini);
>
> @@ -1078,6 +1079,22 @@ int drm_dev_set_unique(struct drm_device *dev,
> const char *name)
>  }
>  EXPORT_SYMBOL(drm_dev_set_unique);
>
> +/**
> + * drm_dev_set_name - Set the name of a DRM device
> + * @dev: device of which to set the name
> + * @name: name to be set
> + *
> + * Return: 0 on success or a negative error code on failure.
> + */
> +int drm_dev_set_name(struct drm_device *dev, const char *name)
> +{
> +       kfree(dev->name);
> +       dev->name = kstrdup(name, GFP_KERNEL);
> +
> +       return dev->name ? 0 : -ENOMEM;
> +}
> +EXPORT_SYMBOL(drm_dev_set_name);
> +
>  /*
>   * DRM Core
>   * The DRM core module initializes all global DRM objects and makes them
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index 2263e3ddd822..61f02965106b 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -506,7 +506,7 @@ int drm_version(struct drm_device *dev, void *data,
>                                 dev->driver->date);
>         if (!err)
>                 err = drm_copy_field(version->desc, &version->desc_len,
> -                               dev->driver->desc);
> +                               dev->name);
>
>         return err;
>  }
> diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
> index 7f9ef709b2b6..e29912c484e4 100644
> --- a/include/drm/drm_device.h
> +++ b/include/drm/drm_device.h
> @@ -123,6 +123,9 @@ struct drm_device {
>         /** @unique: Unique name of the device */
>         char *unique;
>
> +       /** @name: device name */
> +       char *name;
> +
>         /**
>          * @struct_mutex:
>          *
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index 68ca736c548d..f742e2bde467 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -798,6 +798,7 @@ static inline bool drm_drv_uses_atomic_modeset(struct
> drm_device *dev)
>
>
>  int drm_dev_set_unique(struct drm_device *dev, const char *name);
> +int drm_dev_set_name(struct drm_device *dev, const char *name);
>
>
>  #endif
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--0000000000008d9f850591e9c93b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">+ dri-devel<br></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 3, 2019 at 5:41 PM Jiang, Sonny=
 &lt;<a href=3D"mailto:Sonny.Jiang-5C7GfCeVMHo@public.gmane.org">Sonny.Jiang-5C7GfCeVMHo@public.gmane.org</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Add DRM devi=
ce name and use DRM_IOCTL_VERSION ioctl drmVersion::desc passing it to user=
 space<br>
instead of unused DRM driver name descriptor.<br>
<br>
Change-Id: I809f6d3e057111417efbe8fa7cab8f0113ba4b21<br>
Signed-off-by: Sonny Jiang &lt;<a href=3D"mailto:sonny.jiang-5C7GfCeVMHo@public.gmane.org" targe=
t=3D"_blank">sonny.jiang-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |=C2=A0 2 ++<br>
=C2=A0drivers/gpu/drm/drm_drv.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | 17 +++++++++++++++++<br>
=C2=A0drivers/gpu/drm/drm_ioctl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0include/drm/drm_device.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +++<br>
=C2=A0include/drm/drm_drv.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A05 files changed, 24 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 67b09cb2a9e2..8f0971cea363 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2809,6 +2809,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* init the mode config */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 drm_mode_config_init(adev-&gt;ddev);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_dev_set_name(adev-&gt;ddev, amdgpu_asic_nam=
e[adev-&gt;asic_type]);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D amdgpu_device_ip_init(adev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* failed in exclus=
ive mode due to timeout */<br>
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c<br>
index 862621494a93..6c33879bb538 100644<br>
--- a/drivers/gpu/drm/drm_drv.c<br>
+++ b/drivers/gpu/drm/drm_drv.c<br>
@@ -802,6 +802,7 @@ void drm_dev_fini(struct drm_device *dev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_destroy(&amp;dev-&gt;struct_mutex);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 drm_legacy_destroy_members(dev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(dev-&gt;unique);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(dev-&gt;name);<br>
=C2=A0}<br>
=C2=A0EXPORT_SYMBOL(drm_dev_fini);<br>
<br>
@@ -1078,6 +1079,22 @@ int drm_dev_set_unique(struct drm_device *dev, const=
 char *name)<br>
=C2=A0}<br>
=C2=A0EXPORT_SYMBOL(drm_dev_set_unique);<br>
<br>
+/**<br>
+ * drm_dev_set_name - Set the name of a DRM device<br>
+ * @dev: device of which to set the name<br>
+ * @name: name to be set<br>
+ *<br>
+ * Return: 0 on success or a negative error code on failure.<br>
+ */<br>
+int drm_dev_set_name(struct drm_device *dev, const char *name)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(dev-&gt;name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&gt;name =3D kstrdup(name, GFP_KERNEL);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return dev-&gt;name ? 0 : -ENOMEM;<br>
+}<br>
+EXPORT_SYMBOL(drm_dev_set_name);<br>
+<br>
=C2=A0/*<br>
=C2=A0 * DRM Core<br>
=C2=A0 * The DRM core module initializes all global DRM objects and makes t=
hem<br>
diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c<br>
index 2263e3ddd822..61f02965106b 100644<br>
--- a/drivers/gpu/drm/drm_ioctl.c<br>
+++ b/drivers/gpu/drm/drm_ioctl.c<br>
@@ -506,7 +506,7 @@ int drm_version(struct drm_device *dev, void *data,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;driver-&gt;date);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!err)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D drm_copy_fi=
eld(version-&gt;desc, &amp;version-&gt;desc_len,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&gt;driver-&gt;desc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&gt;name);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;<br>
=C2=A0}<br>
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h<br>
index 7f9ef709b2b6..e29912c484e4 100644<br>
--- a/include/drm/drm_device.h<br>
+++ b/include/drm/drm_device.h<br>
@@ -123,6 +123,9 @@ struct drm_device {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /** @unique: Unique name of the device */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *unique;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/** @name: device name */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0char *name;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /**<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* @struct_mutex:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*<br>
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h<br>
index 68ca736c548d..f742e2bde467 100644<br>
--- a/include/drm/drm_drv.h<br>
+++ b/include/drm/drm_drv.h<br>
@@ -798,6 +798,7 @@ static inline bool drm_drv_uses_atomic_modeset(struct d=
rm_device *dev)<br>
<br>
<br>
=C2=A0int drm_dev_set_unique(struct drm_device *dev, const char *name);<br>
+int drm_dev_set_name(struct drm_device *dev, const char *name);<br>
<br>
<br>
=C2=A0#endif<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a></blockquote></div>

--0000000000008d9f850591e9c93b--

--===============1697656043==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1697656043==--
