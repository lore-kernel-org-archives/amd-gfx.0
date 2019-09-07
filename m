From: =?UTF-8?Q?Nils_Wallm=C3=A9nius?= <nils.wallmenius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Allow to reset to EERPOM table.
Date: Sat, 7 Sep 2019 10:53:05 +0200
Message-ID: <CA+nq7DtM7uSx3n_pMp==SqxjcBc0TGKcYQnidi7hvY47wkOfWQ@mail.gmail.com>
References: <1567782810-22378-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1255588425=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1567782810-22378-1-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
To: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: Tao.Zhou1-5C7GfCeVMHo@public.gmane.org, Guchun.Chen-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1255588425==
Content-Type: multipart/alternative; boundary="000000000000a13dff0591f2af71"

--000000000000a13dff0591f2af71
Content-Type: text/plain; charset="UTF-8"

Hi Andrey, spotted a typo below, also typo in the title s/EERPOM/EEPROM/

Regards
Nils

Den fre 6 sep. 2019 17:13Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
skrev:

> The table grows quickly during debug/development effort when
> multiple RAS errors are injected. Allow to avoid this by setting
> table header back to empty if needed.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h            | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c        | 8 ++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 3 ++-
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 0d11aa8..405c55a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -169,6 +169,7 @@ extern int amdgpu_discovery;
>  extern int amdgpu_mes;
>  extern int amdgpu_noretry;
>  extern int amdgpu_force_asic_type;
> +extern int amdgpu_ras_eeprom_reset;
>
>  #ifdef CONFIG_DRM_AMDGPU_SI
>  extern int amdgpu_si_support;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 5a7f929..6e101a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -145,6 +145,7 @@ int amdgpu_discovery = -1;
>  int amdgpu_mes = 0;
>  int amdgpu_noretry = 1;
>  int amdgpu_force_asic_type = -1;
> +int amdgpu_ras_eeprom_reset = -1;
>
>  struct amdgpu_mgpu_info mgpu_info = {
>         .mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
> @@ -530,6 +531,13 @@ MODULE_PARM_DESC(ras_mask, "Mask of RAS features to
> enable (default 0xffffffff),
>  module_param_named(ras_mask, amdgpu_ras_mask, uint, 0444);
>
>  /**
> + * DOC: ras_eeprom_reset (int)
> + * Reset EEPROM table to zerro entries.
> + */
> +MODULE_PARM_DESC(ras_eeprom_reset, "Reset RAS EEPROM table to zerro
> entries (1 = reset, -1 = auto (default - don't reset)");
>

s/zerro/zero/ in two places

+module_param_named(ras_eeprom_reset, amdgpu_ras_eeprom_reset, int, 0444);
> +
> +/**
>   * DOC: si_support (int)
>   * Set SI support driver. This parameter works after set config
> CONFIG_DRM_AMDGPU_SI. For SI asic, when radeon driver is enabled,
>   * set value 0 to use radeon driver, while set value 1 to use amdgpu
> driver. The default is using radeon driver when it available,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 43dd4ab..75c6fc0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -140,7 +140,8 @@ int amdgpu_ras_eeprom_init(struct
> amdgpu_ras_eeprom_control *control)
>
>         __decode_table_header_from_buff(hdr, &buff[2]);
>
> -       if (hdr->header == EEPROM_TABLE_HDR_VAL) {
> +       if (amdgpu_ras_eeprom_reset != 1 &&
> +           hdr->header == EEPROM_TABLE_HDR_VAL) {
>                 control->num_recs = (hdr->tbl_size -
> EEPROM_TABLE_HEADER_SIZE) /
>                                     EEPROM_TABLE_RECORD_SIZE;
>                 DRM_DEBUG_DRIVER("Found existing EEPROM table with %d
> records",
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--000000000000a13dff0591f2af71
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi Andrey, spotted a typo below, also typo in the ti=
tle s/EERPOM/EEPROM/</div><div dir=3D"auto"><br></div><div dir=3D"auto">Reg=
ards</div><div dir=3D"auto">Nils<br><br><div class=3D"gmail_quote" dir=3D"a=
uto"><div dir=3D"ltr" class=3D"gmail_attr">Den fre 6 sep. 2019 17:13Andrey =
Grodzovsky &lt;<a href=3D"mailto:andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org">andrey.grodzovs=
ky-5C7GfCeVMHo@public.gmane.org</a>&gt; skrev:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">The tabl=
e grows quickly during debug/development effort when<br>
multiple RAS errors are injected. Allow to avoid this by setting<br>
table header back to empty if needed.<br>
<br>
Signed-off-by: Andrey Grodzovsky &lt;<a href=3D"mailto:andrey.grodzovsky@am=
d.com" target=3D"_blank" rel=3D"noreferrer">andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org</a>&g=
t;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | 1 +<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
8 ++++++++<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 3 ++-<br>
=C2=A03 files changed, 11 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 0d11aa8..405c55a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -169,6 +169,7 @@ extern int amdgpu_discovery;<br>
=C2=A0extern int amdgpu_mes;<br>
=C2=A0extern int amdgpu_noretry;<br>
=C2=A0extern int amdgpu_force_asic_type;<br>
+extern int amdgpu_ras_eeprom_reset;<br>
<br>
=C2=A0#ifdef CONFIG_DRM_AMDGPU_SI<br>
=C2=A0extern int amdgpu_si_support;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 5a7f929..6e101a5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -145,6 +145,7 @@ int amdgpu_discovery =3D -1;<br>
=C2=A0int amdgpu_mes =3D 0;<br>
=C2=A0int amdgpu_noretry =3D 1;<br>
=C2=A0int amdgpu_force_asic_type =3D -1;<br>
+int amdgpu_ras_eeprom_reset =3D -1;<br>
<br>
=C2=A0struct amdgpu_mgpu_info mgpu_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .mutex =3D __MUTEX_INITIALIZER(mgpu_info.mutex)=
,<br>
@@ -530,6 +531,13 @@ MODULE_PARM_DESC(ras_mask, &quot;Mask of RAS features =
to enable (default 0xffffffff),<br>
=C2=A0module_param_named(ras_mask, amdgpu_ras_mask, uint, 0444);<br>
<br>
=C2=A0/**<br>
+ * DOC: ras_eeprom_reset (int)<br>
+ * Reset EEPROM table to zerro entries.<br>
+ */<br>
+MODULE_PARM_DESC(ras_eeprom_reset, &quot;Reset RAS EEPROM table to zerro e=
ntries (1 =3D reset, -1 =3D auto (default - don&#39;t reset)&quot;);<br></b=
lockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">s/zerro=
/zero/ in two places</div><div dir=3D"auto"><br></div><div dir=3D"auto"><di=
v class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+module_param_named(ras_eeprom_reset, amdgpu_ras_eeprom_reset, int, 0444);<=
br>
+<br>
+/**<br>
=C2=A0 * DOC: si_support (int)<br>
=C2=A0 * Set SI support driver. This parameter works after set config CONFI=
G_DRM_AMDGPU_SI. For SI asic, when radeon driver is enabled,<br>
=C2=A0 * set value 0 to use radeon driver, while set value 1 to use amdgpu =
driver. The default is using radeon driver when it available,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
index 43dd4ab..75c6fc0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
@@ -140,7 +140,8 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_con=
trol *control)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __decode_table_header_from_buff(hdr, &amp;buff[=
2]);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (hdr-&gt;header =3D=3D EEPROM_TABLE_HDR_VAL)=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_ras_eeprom_reset !=3D 1 &amp;&amp;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hdr-&gt;header =3D=3D EEPROM_TABL=
E_HDR_VAL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 control-&gt;num_rec=
s =3D (hdr-&gt;tbl_size - EEPROM_TABLE_HEADER_SIZE) /<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EEPROM_TABLE_RECORD_SI=
ZE;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DRM_DEBUG_DRIVER(&q=
uot;Found existing EEPROM table with %d records&quot;,<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank" rel=3D"n=
oreferrer">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailm=
an/listinfo/amd-gfx</a></blockquote></div></div></div>

--000000000000a13dff0591f2af71--

--===============1255588425==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1255588425==--
