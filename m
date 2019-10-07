From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: simplify gds_compute_max_wave_id computation
Date: Mon, 7 Oct 2019 14:05:18 -0400
Message-ID: <CAAxE2A7rOodqyZVWCQYcbx6Xsc=XQ_EsVCF+G_tFOWcB7omMmA@mail.gmail.com>
References: <20190925203502.30996-1-maraeo@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0695047305=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190925203502.30996-1-maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0695047305==
Content-Type: multipart/alternative; boundary="0000000000002eb187059455e735"

--0000000000002eb187059455e735
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping

On Wed, Sep 25, 2019 at 4:35 PM Marek Ol=C5=A1=C3=A1k <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wr=
ote:

> From: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
>
> Signed-off-by: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index ca01643fa0c8..73cd254449b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -5275,29 +5275,26 @@ static void gfx_v10_0_set_rlc_funcs(struct
> amdgpu_device *adev)
>         case CHIP_NAVI12:
>                 adev->gfx.rlc.funcs =3D &gfx_v10_0_rlc_funcs;
>                 break;
>         default:
>                 break;
>         }
>  }
>
>  static void gfx_v10_0_set_gds_init(struct amdgpu_device *adev)
>  {
> -       /* init asic gds info */
> -       switch (adev->asic_type) {
> -       case CHIP_NAVI10:
> -       default:
> -               adev->gds.gds_size =3D 0x10000;
> -               adev->gds.gds_compute_max_wave_id =3D 0x4ff;
> -               break;
> -       }
> +       unsigned total_cu =3D adev->gfx.config.max_cu_per_sh *
> +                           adev->gfx.config.max_sh_per_se *
> +                           adev->gfx.config.max_shader_engines;
>
> +       adev->gds.gds_size =3D 0x10000;
> +       adev->gds.gds_compute_max_wave_id =3D total_cu * 32 - 1;
>         adev->gds.gws_size =3D 64;
>         adev->gds.oa_size =3D 16;
>  }
>
>  static void gfx_v10_0_set_user_wgp_inactive_bitmap_per_sh(struct
> amdgpu_device *adev,
>                                                           u32 bitmap)
>  {
>         u32 data;
>
>         if (!bitmap)
> --
> 2.17.1
>
>

--0000000000002eb187059455e735
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">ping<br></div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Wed, Sep 25, 2019 at 4:35 PM Marek Ol=C5=A1=C3=
=A1k &lt;<a href=3D"mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Marek Ol=
=C5=A1=C3=A1k &lt;<a href=3D"mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">=
marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
Signed-off-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:marek.olsak@amd.=
com" target=3D"_blank">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 13 +++++--------<br>
=C2=A01 file changed, 5 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index ca01643fa0c8..73cd254449b3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -5275,29 +5275,26 @@ static void gfx_v10_0_set_rlc_funcs(struct amdgpu_d=
evice *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case CHIP_NAVI12:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;gfx.rlc.fu=
ncs =3D &amp;gfx_v10_0_rlc_funcs;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0static void gfx_v10_0_set_gds_init(struct amdgpu_device *adev)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* init asic gds info */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (adev-&gt;asic_type) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0case CHIP_NAVI10:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gds_si=
ze =3D 0x10000;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gds_co=
mpute_max_wave_id =3D 0x4ff;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned total_cu =3D adev-&gt;gfx.config.max_c=
u_per_sh *<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfx.config.max_sh_per_se *<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfx.config.max_shader_engines;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gds_size =3D 0x10000;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gds.gds_compute_max_wave_id =3D total_=
cu * 32 - 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;gds.gws_size =3D 64;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;gds.oa_size =3D 16;<br>
=C2=A0}<br>
<br>
=C2=A0static void gfx_v10_0_set_user_wgp_inactive_bitmap_per_sh(struct amdg=
pu_device *adev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 bitmap)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 data;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!bitmap)<br>
-- <br>
2.17.1<br>
<br>
</blockquote></div>

--0000000000002eb187059455e735--

--===============0695047305==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0695047305==--
