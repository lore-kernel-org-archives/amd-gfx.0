From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: don't read registers if gfxoff is enabled (v2)
Date: Wed, 13 Nov 2019 13:54:41 +0000
Message-ID: <CY4PR12MB1813FAB578D07C4FB3C30320F7760@CY4PR12MB1813.namprd12.prod.outlook.com>
References: <20191112151327.108438-1-alexander.deucher@amd.com>,
 <MN2PR12MB3344C97B5167EAC63AF5796FE4760@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1161191373=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3344C97B5167EAC63AF5796FE4760-rweVpJHSKToDMgCC8P//OwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Content-Language: en-US
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1161191373==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1813FAB578D07C4FB3C30320F7760CY4PR12MB1813namp_"

--_000_CY4PR12MB1813FAB578D07C4FB3C30320F7760CY4PR12MB1813namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I can send a patch for that.  Thanks!

Alex
________________________________
From: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, November 12, 2019 9:09 PM
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: don't read registers if gfxoff is enabled =
(v2)

This patch is reviewed-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
However, i just find we need a separate patch to clear PP_GFXOFF_MASK suppo=
rt from Arcturus.
Can you do that or you want me to do that?

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, November 12, 2019 11:13 PM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
> Subject: [PATCH] drm/amdgpu: don't read registers if gfxoff is enabled (v=
2)
>
> When gfxoff is enabled, accessing gfx registers via MMIO
> can lead to a hang.
>
> v2: return cached registers properly.
>
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=3D205497
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c    | 27 ++++++++++++++++----------
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 31 ++++++++++++++++++------------
>  2 files changed, 36 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
> b/drivers/gpu/drm/amd/amdgpu/nv.c
> index af68f9815f28..7283d6198b89 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -201,17 +201,25 @@ static uint32_t nv_read_indexed_register(struct
> amdgpu_device *adev, u32 se_num,
>        return val;
>  }
>
> -static uint32_t nv_get_register_value(struct amdgpu_device *adev,
> +static int nv_get_register_value(struct amdgpu_device *adev,
>                                      bool indexed, u32 se_num,
> -                                   u32 sh_num, u32 reg_offset)
> +                                   u32 sh_num, u32 reg_offset,
> +                                   u32 *value)
>  {
>        if (indexed) {
> -             return nv_read_indexed_register(adev, se_num, sh_num,
> reg_offset);
> +             if (adev->pm.pp_feature & PP_GFXOFF_MASK)
> +                     return -EINVAL;
> +             *value =3D nv_read_indexed_register(adev, se_num, sh_num,
> reg_offset);
>        } else {
> -             if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0,
> mmGB_ADDR_CONFIG))
> -                     return adev->gfx.config.gb_addr_config;
> -             return RREG32(reg_offset);
> +             if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0,
> mmGB_ADDR_CONFIG)) {
> +                     *value =3D adev->gfx.config.gb_addr_config;
> +             } else {
> +                     if (adev->pm.pp_feature & PP_GFXOFF_MASK)
> +                             return -EINVAL;
> +                     *value =3D RREG32(reg_offset);
> +             }
>        }
> +     return 0;
>  }
>
>  static int nv_read_register(struct amdgpu_device *adev, u32 se_num,
> @@ -227,10 +235,9 @@ static int nv_read_register(struct amdgpu_device
> *adev, u32 se_num,
>                    (adev->reg_offset[en->hwip][en->inst][en->seg] + en-
> >reg_offset))
>                        continue;
>
> -             *value =3D nv_get_register_value(adev,
> -
> nv_allowed_read_registers[i].grbm_indexed,
> -                                            se_num, sh_num, reg_offset);
> -             return 0;
> +             return nv_get_register_value(adev,
> +
> nv_allowed_read_registers[i].grbm_indexed,
> +                                          se_num, sh_num, reg_offset, va=
lue);
>        }
>        return -EINVAL;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 305ad3eec987..2cc16e9f39fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -363,19 +363,27 @@ static uint32_t soc15_read_indexed_register(struct
> amdgpu_device *adev, u32 se_n
>        return val;
>  }
>
> -static uint32_t soc15_get_register_value(struct amdgpu_device *adev,
> +static int soc15_get_register_value(struct amdgpu_device *adev,
>                                         bool indexed, u32 se_num,
> -                                      u32 sh_num, u32 reg_offset)
> +                                      u32 sh_num, u32 reg_offset,
> +                                      u32 *value)
>  {
>        if (indexed) {
> -             return soc15_read_indexed_register(adev, se_num, sh_num,
> reg_offset);
> +             if (adev->pm.pp_feature & PP_GFXOFF_MASK)
> +                     return -EINVAL;
> +             *value =3D soc15_read_indexed_register(adev, se_num, sh_num=
,
> reg_offset);
>        } else {
> -             if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0,
> mmGB_ADDR_CONFIG))
> -                     return adev->gfx.config.gb_addr_config;
> -             else if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0,
> mmDB_DEBUG2))
> -                     return adev->gfx.config.db_debug2;
> -             return RREG32(reg_offset);
> +             if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0,
> mmGB_ADDR_CONFIG)) {
> +                     *value =3D adev->gfx.config.gb_addr_config;
> +             } else if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0,
> mmDB_DEBUG2)) {
> +                     *value =3D adev->gfx.config.db_debug2;
> +             } else {
> +                     if (adev->pm.pp_feature & PP_GFXOFF_MASK)
> +                             return -EINVAL;
> +                     *value =3D RREG32(reg_offset);
> +             }
>        }
> +     return 0;
>  }
>
>  static int soc15_read_register(struct amdgpu_device *adev, u32 se_num,
> @@ -391,10 +399,9 @@ static int soc15_read_register(struct amdgpu_device
> *adev, u32 se_num,
>                                        + en->reg_offset))
>                        continue;
>
> -             *value =3D soc15_get_register_value(adev,
> -
> soc15_allowed_read_registers[i].grbm_indexed,
> -                                               se_num, sh_num, reg_offse=
t);
> -             return 0;
> +             return soc15_get_register_value(adev,
> +
>        soc15_allowed_read_registers[i].grbm_indexed,
> +                                             se_num, sh_num, reg_offset,
> value);
>        }
>        return -EINVAL;
>  }
> --
> 2.23.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB1813FAB578D07C4FB3C30320F7760CY4PR12MB1813namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I can send a patch for that.&nbsp; Thanks!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, November 12, 2019 9:09 PM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: don't read registers if gfxoff is e=
nabled (v2)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This patch is reviewed-by: Evan Quan &lt;evan.quan=
@amd.com&gt;<br>
However, i just find we need a separate patch to clear PP_GFXOFF_MASK suppo=
rt from Arcturus.<br>
Can you do that or you want me to do that?<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; On Behalf =
Of Alex<br>
&gt; Deucher<br>
&gt; Sent: Tuesday, November 12, 2019 11:13 PM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Subject: [PATCH] drm/amdgpu: don't read registers if gfxoff is enabled=
 (v2)<br>
&gt; <br>
&gt; When gfxoff is enabled, accessing gfx registers via MMIO<br>
&gt; can lead to a hang.<br>
&gt; <br>
&gt; v2: return cached registers properly.<br>
&gt; <br>
&gt; Bug: <a href=3D"https://bugzilla.kernel.org/show_bug.cgi?id=3D205497">=
https://bugzilla.kernel.org/show_bug.cgi?id=3D205497</a><br>
&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp; | 27 &#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;----=
------<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/soc15.c | 31 &#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---------=
---<br>
&gt;&nbsp; 2 files changed, 36 insertions(&#43;), 22 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt; index af68f9815f28..7283d6198b89 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt; @@ -201,17 &#43;201,25 @@ static uint32_t nv_read_indexed_register(str=
uct<br>
&gt; amdgpu_device *adev, u32 se_num,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return val;<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt; -static uint32_t nv_get_register_value(struct amdgpu_device *adev,<br>
&gt; &#43;static int nv_get_register_value(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; bool indexed, u32 se_num,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 sh_num, u3=
2 reg_offset)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 sh_num=
, u32 reg_offset,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *value=
)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (indexed) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return nv_read_indexed_register(adev, se_num, sh_num,<br>
&gt; reg_offset);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (adev-&gt;pm.pp_feature &amp; PP_GFXOFF_MASK)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; *value =3D nv_read_indexed_register(adev, se_num, sh_num,<br>
&gt; reg_offset);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0,<br>
&gt; mmGB_ADDR_CONFIG))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return adev-&gt;gfx.con=
fig.gb_addr_config;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return RREG32(reg_offset);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0,<br>
&gt; mmGB_ADDR_CONFIG)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D adev-&gt=
;gfx.config.gb_addr_config;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pp_=
feature &amp; PP_GFXOFF_MASK)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D RREG32(r=
eg_offset);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt;&nbsp; static int nv_read_register(struct amdgpu_device *adev, u32 se_n=
um,<br>
&gt; @@ -227,10 &#43;235,9 @@ static int nv_read_register(struct amdgpu_dev=
ice<br>
&gt; *adev, u32 se_num,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;reg_offset[en-&gt;hwi=
p][en-&gt;inst][en-&gt;seg] &#43; en-<br>
&gt; &gt;reg_offset))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continu=
e;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *value =3D nv_get_register_value(adev,<br>
&gt; -<br>
&gt; nv_allowed_read_registers[i].grbm_indexed,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; se_num, sh_num, reg_offset);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return nv_get_register_value(adev,<br>
&gt; &#43;<br>
&gt; nv_allowed_read_registers[i].grbm_indexed,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; se_num, sh_num, reg_offset, value);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; index 305ad3eec987..2cc16e9f39fb 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; @@ -363,19 &#43;363,27 @@ static uint32_t soc15_read_indexed_register(=
struct<br>
&gt; amdgpu_device *adev, u32 se_n<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return val;<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt; -static uint32_t soc15_get_register_value(struct amdgpu_device *adev,<=
br>
&gt; &#43;static int soc15_get_register_value(struct amdgpu_device *adev,<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; bool indexed, u32 se_num,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; u32 sh_num, u32 reg_offset)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; u32 sh_num, u32 reg_offset,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; u32 *value)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (indexed) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return soc15_read_indexed_register(adev, se_num, sh_num,<br>
&gt; reg_offset);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (adev-&gt;pm.pp_feature &amp; PP_GFXOFF_MASK)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; *value =3D soc15_read_indexed_register(adev, se_num, sh_num,<br>
&gt; reg_offset);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0,<br>
&gt; mmGB_ADDR_CONFIG))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return adev-&gt;gfx.con=
fig.gb_addr_config;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; else if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0,<br>
&gt; mmDB_DEBUG2))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return adev-&gt;gfx.con=
fig.db_debug2;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return RREG32(reg_offset);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0,<br>
&gt; mmGB_ADDR_CONFIG)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D adev-&gt=
;gfx.config.gb_addr_config;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; } else if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0,<br>
&gt; mmDB_DEBUG2)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D adev-&gt=
;gfx.config.db_debug2;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pp_=
feature &amp; PP_GFXOFF_MASK)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D RREG32(r=
eg_offset);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt;&nbsp; static int soc15_read_register(struct amdgpu_device *adev, u32 s=
e_num,<br>
&gt; @@ -391,10 &#43;399,9 @@ static int soc15_read_register(struct amdgpu_=
device<br>
&gt; *adev, u32 se_num,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; &#43; en-&gt;reg_offset))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continu=
e;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *value =3D soc15_get_register_value(adev,<br>
&gt; -<br>
&gt; soc15_allowed_read_registers[i].grbm_indexed,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; se_num, sh_num, r=
eg_offset);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return soc15_get_register_value(adev,<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc15_allowed_read_registers=
[i].grbm_indexed,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; se_num, sh_num, reg_offse=
t,<br>
&gt; value);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&nbsp; }<br>
&gt; --<br>
&gt; 2.23.0<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB1813FAB578D07C4FB3C30320F7760CY4PR12MB1813namp_--

--===============1161191373==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1161191373==--
