From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Bump amdgpu version for per-flip plane tiling
 updates
Date: Thu, 28 Feb 2019 16:08:17 -0500
Message-ID: <CAAxE2A78K=mQnm=XoAcBsn76EbKW3iC5au2Fu1uPR21Sm6yEVA@mail.gmail.com>
References: <20190228145937.8495-1-nicholas.kazlauskas@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1584248105=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190228145937.8495-1-nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
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
To: Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1584248105==
Content-Type: multipart/alternative; boundary="000000000000b4f65e0582fab2c5"

--000000000000b4f65e0582fab2c5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>

Marek

On Thu, Feb 28, 2019 at 9:59 AM Nicholas Kazlauskas <
nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org> wrote:

> To help xf86-video-amdgpu and mesa know DC supports updating the
> tiling attributes for a framebuffer per-flip.
>
> Cc: Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
> Cc: Marek Ol=C5=A1=C3=A1k <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 223013ef8466..ae4e3eeb4ae2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -74,9 +74,10 @@
>   * - 3.28.0 - Add AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES
>   * - 3.29.0 - Add AMDGPU_IB_FLAG_RESET_GDS_MAX_WAVE_ID
>   * - 3.30.0 - Add AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE.
> + * - 3.31.0 - Add support for per-flip tiling attribute changes with DC
>   */
>  #define KMS_DRIVER_MAJOR       3
> -#define KMS_DRIVER_MINOR       30
> +#define KMS_DRIVER_MINOR       31
>  #define KMS_DRIVER_PATCHLEVEL  0
>
>  int amdgpu_vram_limit =3D 0;
> --
> 2.17.1
>
>

--000000000000b4f65e0582fab2c5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Reviewed-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mai=
lto:marek.olsak-5C7GfCeVMHo@public.gmane.org">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;</div><div><br></div><d=
iv>Marek<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Thu, Feb 28, 2019 at 9:59 AM Nicholas Kazlauskas &lt;<=
a href=3D"mailto:nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org">nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">To=
 help xf86-video-amdgpu and mesa know DC supports updating the<br>
tiling attributes for a framebuffer per-flip.<br>
<br>
Cc: Michel D=C3=A4nzer &lt;<a href=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org" target=3D"=
_blank">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt;<br>
Cc: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D=
"_blank">maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
Signed-off-by: Nicholas Kazlauskas &lt;<a href=3D"mailto:nicholas.kazlauska=
s@amd.com" target=3D"_blank">nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 223013ef8466..ae4e3eeb4ae2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -74,9 +74,10 @@<br>
=C2=A0 * - 3.28.0 - Add AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES<br>
=C2=A0 * - 3.29.0 - Add AMDGPU_IB_FLAG_RESET_GDS_MAX_WAVE_ID<br>
=C2=A0 * - 3.30.0 - Add AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE.<br>
+ * - 3.31.0 - Add support for per-flip tiling attribute changes with DC<br=
>
=C2=A0 */<br>
=C2=A0#define KMS_DRIVER_MAJOR=C2=A0 =C2=A0 =C2=A0 =C2=A03<br>
-#define KMS_DRIVER_MINOR=C2=A0 =C2=A0 =C2=A0 =C2=A030<br>
+#define KMS_DRIVER_MINOR=C2=A0 =C2=A0 =C2=A0 =C2=A031<br>
=C2=A0#define KMS_DRIVER_PATCHLEVEL=C2=A0 0<br>
<br>
=C2=A0int amdgpu_vram_limit =3D 0;<br>
-- <br>
2.17.1<br>
<br>
</blockquote></div>

--000000000000b4f65e0582fab2c5--

--===============1584248105==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1584248105==--
