From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Add DCC flags for GFX9 amdgpu_bo
Date: Tue, 23 Oct 2018 14:28:32 -0400
Message-ID: <CAAxE2A4DUXVptR-jLoRmxU+HzjHYR=dJmGjc0M+42Fs0VgyX_g@mail.gmail.com>
References: <20181023140454.23097-1-nicholas.kazlauskas@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0182295613=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181023140454.23097-1-nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
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
To: nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org
Cc: Harry Wentland <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0182295613==
Content-Type: multipart/alternative; boundary="0000000000009d97ea0578e98b22"

--0000000000009d97ea0578e98b22
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>

Marek

On Tue, Oct 23, 2018 at 10:05 AM Nicholas Kazlauskas <
nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org> wrote:

> [Why]
> Hardware support for Delta Color Compression (DCC) decompression is
> available in DC for GFX9 but there's no way for userspace to enable
> the feature.
>
> Enabling the feature can provide improved GFX performance and
> power savings in many situations.
>
> [How]
> Extend the GFX9 tiling flags to include DCC parameters. These are
> logically grouped together with tiling flags even if they are
> technically distinct.
>
> This trivially maintains backwards compatibility with existing
> users of amdgpu_gem_metadata. No new IOCTls or data structures are
> needed to support DCC.
>
> This patch helps expose DCC attributes to both libdrm and amdgpu_dm.
>
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
> ---
>  include/uapi/drm/amdgpu_drm.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 6a0d77dcfc47..faaad04814e4 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -329,6 +329,12 @@ struct drm_amdgpu_gem_userptr {
>  /* GFX9 and later: */
>  #define AMDGPU_TILING_SWIZZLE_MODE_SHIFT               0
>  #define AMDGPU_TILING_SWIZZLE_MODE_MASK                        0x1f
> +#define AMDGPU_TILING_DCC_OFFSET_256B_SHIFT            5
> +#define AMDGPU_TILING_DCC_OFFSET_256B_MASK             0xFFFFFF
> +#define AMDGPU_TILING_DCC_PITCH_MAX_SHIFT              29
> +#define AMDGPU_TILING_DCC_PITCH_MAX_MASK               0x3FFF
> +#define AMDGPU_TILING_DCC_INDEPENDENT_64B_SHIFT                43
> +#define AMDGPU_TILING_DCC_INDEPENDENT_64B_MASK         0x1
>
>  /* Set/Get helpers for tiling flags. */
>  #define AMDGPU_TILING_SET(field, value) \
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--0000000000009d97ea0578e98b22
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Reviewed-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mai=
lto:marek.olsak-5C7GfCeVMHo@public.gmane.org">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;</div><div><br></div><d=
iv>Marek<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On =
Tue, Oct 23, 2018 at 10:05 AM Nicholas Kazlauskas &lt;<a href=3D"mailto:nic=
holas.kazlauskas-5C7GfCeVMHo@public.gmane.org">nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">[Why]<br>
Hardware support for Delta Color Compression (DCC) decompression is<br>
available in DC for GFX9 but there&#39;s no way for userspace to enable<br>
the feature.<br>
<br>
Enabling the feature can provide improved GFX performance and<br>
power savings in many situations.<br>
<br>
[How]<br>
Extend the GFX9 tiling flags to include DCC parameters. These are<br>
logically grouped together with tiling flags even if they are<br>
technically distinct.<br>
<br>
This trivially maintains backwards compatibility with existing<br>
users of amdgpu_gem_metadata. No new IOCTls or data structures are<br>
needed to support DCC.<br>
<br>
This patch helps expose DCC attributes to both libdrm and amdgpu_dm.<br>
<br>
Signed-off-by: Nicholas Kazlauskas &lt;<a href=3D"mailto:nicholas.kazlauska=
s@amd.com" target=3D"_blank">nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0include/uapi/drm/amdgpu_drm.h | 6 ++++++<br>
=C2=A01 file changed, 6 insertions(+)<br>
<br>
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h<=
br>
index 6a0d77dcfc47..faaad04814e4 100644<br>
--- a/include/uapi/drm/amdgpu_drm.h<br>
+++ b/include/uapi/drm/amdgpu_drm.h<br>
@@ -329,6 +329,12 @@ struct drm_amdgpu_gem_userptr {<br>
=C2=A0/* GFX9 and later: */<br>
=C2=A0#define AMDGPU_TILING_SWIZZLE_MODE_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
=C2=A0#define AMDGPU_TILING_SWIZZLE_MODE_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1f<br>
+#define AMDGPU_TILING_DCC_OFFSET_256B_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 5<br>
+#define AMDGPU_TILING_DCC_OFFSET_256B_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00xFFFFFF<br>
+#define AMDGPU_TILING_DCC_PITCH_MAX_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 29<br>
+#define AMDGPU_TILING_DCC_PITCH_MAX_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A00x3FFF<br>
+#define AMDGPU_TILING_DCC_INDEPENDENT_64B_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 43<br>
+#define AMDGPU_TILING_DCC_INDEPENDENT_64B_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x1<br>
<br>
=C2=A0/* Set/Get helpers for tiling flags. */<br>
=C2=A0#define AMDGPU_TILING_SET(field, value) \<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>

--0000000000009d97ea0578e98b22--

--===============0182295613==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0182295613==--
