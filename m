From: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix no irq process when evict vram
Date: Wed, 13 Dec 2017 11:23:24 +0000
Message-ID: <CAHbf0-HJr=5UJ0rnNvuURQoT8Ze6JnZkc8-_7ysoopUyBPXzwA@mail.gmail.com>
References: <1513136263-9908-1-git-send-email-yttao@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1983713680=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1513136263-9908-1-git-send-email-yttao-5C7GfCeVMHo@public.gmane.org>
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
To: Yintian Tao <yttao-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1983713680==
Content-Type: multipart/alternative; boundary="f403045d70fa8904ef056036ffb0"

--f403045d70fa8904ef056036ffb0
Content-Type: text/plain; charset="UTF-8"

Is this a follow on to
https://cgit.freedesktop.org/~agd5f/linux/commit/?h=drm-next-4.16-wip&id=b9141cd3930e390f156739829ca9589fda7926e4


On Wed, 13 Dec 2017 at 07:11 Yintian Tao <yttao-5C7GfCeVMHo@public.gmane.org> wrote:

> When unload amdgpu driver we use sdma to evict vram but there is no
> irq process after sdma completed work which raises that waiting for the
> fence costs 2s which will trigger VFLR under SRIOV and at last make
> unload driver failed.The reason is that the shutdown varible in adev
> is set to true before evict vram, it cause ISR directly return without
> processing.Therefore, we need set the varible after evict vram.
>
> Change-Id: I7bf75481aa0744b99c41672b49670adc70b478bd
> Signed-off-by: Yintian Tao <yttao-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a269bbc..80934ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2458,7 +2458,6 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>         int r;
>
>         DRM_INFO("amdgpu: finishing device.\n");
> -       adev->shutdown = true;
>         if (adev->mode_info.mode_config_initialized)
>                 drm_crtc_force_disable_all(adev->ddev);
>
> @@ -2466,6 +2465,7 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>         amdgpu_fence_driver_fini(adev);
>         amdgpu_fbdev_fini(adev);
>         r = amdgpu_fini(adev);
> +       adev->shutdown = true;
>         if (adev->firmware.gpu_info_fw) {
>                 release_firmware(adev->firmware.gpu_info_fw);
>                 adev->firmware.gpu_info_fw = NULL;
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--f403045d70fa8904ef056036ffb0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Is this a follow on to=C2=A0<a href=3D"https://cgit.freede=
sktop.org/~agd5f/linux/commit/?h=3Ddrm-next-4.16-wip&amp;id=3Db9141cd3930e3=
90f156739829ca9589fda7926e4">https://cgit.freedesktop.org/~agd5f/linux/comm=
it/?h=3Ddrm-next-4.16-wip&amp;id=3Db9141cd3930e390f156739829ca9589fda7926e4=
</a>=C2=A0</div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed, 13 =
Dec 2017 at 07:11 Yintian Tao &lt;<a href=3D"mailto:yttao-5C7GfCeVMHo@public.gmane.org">yttao@am=
d.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">When unload am=
dgpu driver we use sdma to evict vram but there is no<br>
irq process after sdma completed work which raises that waiting for the<br>
fence costs 2s which will trigger VFLR under SRIOV and at last make<br>
unload driver failed.The reason is that the shutdown varible in adev<br>
is set to true before evict vram, it cause ISR directly return without<br>
processing.Therefore, we need set the varible after evict vram.<br>
<br>
Change-Id: I7bf75481aa0744b99c41672b49670adc70b478bd<br>
Signed-off-by: Yintian Tao &lt;<a href=3D"mailto:yttao-5C7GfCeVMHo@public.gmane.org" target=3D"_=
blank">yttao-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index a269bbc..80934ee 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2458,7 +2458,6 @@ void amdgpu_device_fini(struct amdgpu_device *adev)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int r;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DRM_INFO(&quot;amdgpu: finishing device.\n&quot=
;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;shutdown =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (adev-&gt;mode_info.mode_config_initialized)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drm_crtc_force_disa=
ble_all(adev-&gt;ddev);<br>
<br>
@@ -2466,6 +2465,7 @@ void amdgpu_device_fini(struct amdgpu_device *adev)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_fence_driver_fini(adev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_fbdev_fini(adev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D amdgpu_fini(adev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;shutdown =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (adev-&gt;firmware.gpu_info_fw) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 release_firmware(ad=
ev-&gt;firmware.gpu_info_fw);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;firmware.g=
pu_info_fw =3D NULL;<br>
--<br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>

--f403045d70fa8904ef056036ffb0--

--===============1983713680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1983713680==--
