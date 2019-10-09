From: "Yin, Tianci (Rico)" <Tianci.Yin-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 7/8] drm/amdgpu: reserve vram for memory training
Date: Wed, 9 Oct 2019 11:12:35 +0000
Message-ID: <SN1PR12MB2544F1BE7D37DEC4721AF95D95950@SN1PR12MB2544.namprd12.prod.outlook.com>
References: <20191008192934.5481-1-alexander.deucher@amd.com>
 <20191008192934.5481-8-alexander.deucher@amd.com>,
 <a9d04519-0ec0-41f6-289f-be156caccf76@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1176885956=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a9d04519-0ec0-41f6-289f-be156caccf76-5C7GfCeVMHo@public.gmane.org>
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
To: "Tuikov, Luben" <Luben.Tuikov-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============1176885956==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN1PR12MB2544F1BE7D37DEC4721AF95D95950SN1PR12MB2544namp_"

--_000_SN1PR12MB2544F1BE7D37DEC4721AF95D95950SN1PR12MB2544namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Here is where you definitively set "ret" so DO NOT preinitialize it to 0,
just to avoid "pesky compiler unininitialized variable warnings"--those
are helpful to make the code more secure: a variable should be intentionall=
y
initialized in all paths.

Rico: Still in confusion, pre-initialization can avoid "uninitialized varia=
ble", why should we can't pre-initialize?
________________________________
From: Tuikov, Luben <Luben.Tuikov-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, October 9, 2019 11:44
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Yin, Tianci (Rico) <Tia=
nci.Yin-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 7/8] drm/amdgpu: reserve vram for memory training

On 2019-10-08 3:29 p.m., Alex Deucher wrote:
> From: "Tianci.Yin" <tianci.yin-5C7GfCeVMHo@public.gmane.org>
>
> memory training using specific fixed vram segment, reserve these
> segments before anyone may allocate it.
>
> Change-Id: I1436755813a565608a2857a683f535377620a637
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Tianci.Yin <tianci.yin-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 96 +++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 74a9bd94f10c..0819721af16e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1667,6 +1667,93 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct =
amdgpu_device *adev)
>                                          &adev->fw_vram_usage.va);
>  }
>
> +/*
> + * Memoy training reservation functions
> + */

Include an empty line between the two comments, just as you would
a paragraph in written text.

> +/**
> + * amdgpu_ttm_training_reserve_vram_fini - free memory training reserved=
 vram
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * free memory training reserved vram if it has been reserved.
> + */
> +static int amdgpu_ttm_training_reserve_vram_fini(struct amdgpu_device *a=
dev)
> +{
> +     int ret =3D 0;
> +     struct psp_memory_training_context *ctx =3D &adev->psp.mem_train_ct=
x;
> +
> +     ctx->init =3D PSP_MEM_TRAIN_NOT_SUPPORT;
> +     if(ctx->c2p_bo) {

Space after keywords, according to LKCS:
if (...)

> +             amdgpu_bo_free_kernel(&ctx->c2p_bo, NULL, NULL);
> +             ctx->c2p_bo =3D NULL;
> +     }
> +     if(ctx->p2c_bo) {

Space after keywords, according to LKCS:
if (...)

> +             amdgpu_bo_free_kernel(&ctx->p2c_bo, NULL, NULL);
> +             ctx->p2c_bo =3D NULL;
> +     }
> +
> +     return ret;
> +}

Get rid of "ret" variable altogether as it is not used in this function.

> +
> +/**
> + * amdgpu_ttm_training_reserve_vram_init - create bo vram reservation fr=
om memory training
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * create bo vram reservation from memory training.
> + */
> +static int amdgpu_ttm_training_reserve_vram_init(struct amdgpu_device *a=
dev)
> +{
> +     int ret =3D 0;

DO NOT preinitialize ret.

> +     struct psp_memory_training_context *ctx =3D &adev->psp.mem_train_ct=
x;
> +
> +     memset(ctx, 0, sizeof(*ctx));
> +     if(!adev->fw_vram_usage.mem_train_support) {

Space after keywords: "if (".

> +             DRM_DEBUG("memory training does not support!\n");
> +             return 0;
> +     }
> +
> +     ctx->c2p_train_data_offset =3D adev->fw_vram_usage.mem_train_fb_loc=
;
> +     ctx->p2c_train_data_offset =3D (adev->gmc.mc_vram_size - GDDR6_MEM_=
TRAINING_OFFSET);
> +     ctx->train_data_size =3D GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;
> +
> +     DRM_DEBUG("train_data_size:%llx,p2c_train_data_offset:%llx,c2p_trai=
n_data_offset:%llx.\n",
> +               ctx->train_data_size,
> +               ctx->p2c_train_data_offset,
> +               ctx->c2p_train_data_offset);
> +
> +     ret =3D amdgpu_bo_create_kernel_at(adev,

Here is where you definitively set "ret" so DO NOT preinitialize it to 0,
just to avoid "pesky compiler unininitialized variable warnings"--those
are helpful to make the code more secure: a variable should be intentionall=
y
initialized in all paths.

> +                                      ctx->p2c_train_data_offset,
> +                                      ctx->train_data_size,
> +                                      AMDGPU_GEM_DOMAIN_VRAM,
> +                                      &ctx->p2c_bo,
> +                                      NULL);
> +     if(ret) {

Space after keywords "if (".

> +             DRM_ERROR("alloc p2c_bo failed(%d)!\n", ret);
> +             ret =3D -ENOMEM;
> +             goto err_out;
> +     }
> +
> +     ret =3D amdgpu_bo_create_kernel_at(adev,
> +                                      ctx->c2p_train_data_offset,
> +                                      ctx->train_data_size,
> +                                      AMDGPU_GEM_DOMAIN_VRAM,
> +                                      &ctx->c2p_bo,
> +                                      NULL);
> +     if(ret) {

Space after keywords: "if (", according to LKCS.

Regards,
Luben

> +             DRM_ERROR("alloc c2p_bo failed(%d)!\n", ret);
> +             ret =3D -ENOMEM;
> +             goto err_out;
> +     }
> +
> +     ctx->init =3D PSP_MEM_TRAIN_RESERVE_SUCCESS;
> +     return 0;
> +
> +err_out:
> +     amdgpu_ttm_training_reserve_vram_fini(adev);
> +     return ret;
> +}
> +
>  /**
>   * amdgpu_ttm_init - Init the memory management (ttm) as well as various
>   * gtt/vram related fields.
> @@ -1740,6 +1827,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>                return r;
>        }
>
> +     /*
> +      *The reserved vram for memory training must be pinned to the speci=
fied
> +      *place on the VRAM, so reserve it early.
> +      */
> +     r =3D amdgpu_ttm_training_reserve_vram_init(adev);
> +     if (r)
> +             return r;
> +
>        /* allocate memory as required for VGA
>         * This is used for VGA emulation and pre-OS scanout buffers to
>         * avoid display artifacts while transitioning between pre-OS
> @@ -1825,6 +1920,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>                return;
>
>        amdgpu_ttm_debugfs_fini(adev);
> +     amdgpu_ttm_training_reserve_vram_fini(adev);
>        amdgpu_ttm_fw_reserve_vram_fini(adev);
>        if (adev->mman.aper_base_kaddr)
>                iounmap(adev->mman.aper_base_kaddr);
>


--_000_SN1PR12MB2544F1BE7D37DEC4721AF95D95950SN1PR12MB2544namp_
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
<font size=3D"2"><span style=3D"font-size:11pt">Here is where you definitiv=
ely set &quot;ret&quot; so DO NOT preinitialize it to 0,<br>
</span></font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt">just to avoid &quot;pesky c=
ompiler unininitialized variable warnings&quot;--those<br>
are helpful to make the code more secure: a variable should be intentionall=
y<br>
initialized in all paths.</span></font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(12, 100, 192);">Rico: Still in confusion, pre-ini=
tialization can avoid &quot;uninitialized variable&quot;, why should we can=
't pre-initialize?
</span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Tuikov, Luben &lt;Lub=
en.Tuikov-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, October 9, 2019 11:44<br>
<b>To:</b> Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Yin, Tianc=
i (Rico) &lt;Tianci.Yin-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH 7/8] drm/amdgpu: reserve vram for memory trainin=
g</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2019-10-08 3:29 p.m., Alex Deucher wrote:<br>
&gt; From: &quot;Tianci.Yin&quot; &lt;tianci.yin-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; <br>
&gt; memory training using specific fixed vram segment, reserve these<br>
&gt; segments before anyone may allocate it.<br>
&gt; <br>
&gt; Change-Id: I1436755813a565608a2857a683f535377620a637<br>
&gt; Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Signed-off-by: Tianci.Yin &lt;tianci.yin-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 96 &#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; 1 file changed, 96 insertions(&#43;)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ttm.c<br>
&gt; index 74a9bd94f10c..0819721af16e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt; @@ -1667,6 &#43;1667,93 @@ static int amdgpu_ttm_fw_reserve_vram_init(=
struct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;fw_vram_usage.va);<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; &#43;/*<br>
&gt; &#43; * Memoy training reservation functions<br>
&gt; &#43; */<br>
<br>
Include an empty line between the two comments, just as you would<br>
a paragraph in written text.<br>
<br>
&gt; &#43;/**<br>
&gt; &#43; * amdgpu_ttm_training_reserve_vram_fini - free memory training r=
eserved vram<br>
&gt; &#43; *<br>
&gt; &#43; * @adev: amdgpu_device pointer<br>
&gt; &#43; *<br>
&gt; &#43; * free memory training reserved vram if it has been reserved.<br=
>
&gt; &#43; */<br>
&gt; &#43;static int amdgpu_ttm_training_reserve_vram_fini(struct amdgpu_de=
vice *adev)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_memory_training_context *ctx =
=3D &amp;adev-&gt;psp.mem_train_ctx;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;init =3D PSP_MEM_TRAIN_NOT_SUPPO=
RT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if(ctx-&gt;c2p_bo) {<br>
<br>
Space after keywords, according to LKCS:<br>
if (...)<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; amdgpu_bo_free_kernel(&amp;ctx-&gt;c2p_bo, NULL, NULL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ctx-&gt;c2p_bo =3D NULL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if(ctx-&gt;p2c_bo) {<br>
<br>
Space after keywords, according to LKCS:<br>
if (...)<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; amdgpu_bo_free_kernel(&amp;ctx-&gt;p2c_bo, NULL, NULL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ctx-&gt;p2c_bo =3D NULL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;}<br>
<br>
Get rid of &quot;ret&quot; variable altogether as it is not used in this fu=
nction.<br>
<br>
&gt; &#43;<br>
&gt; &#43;/**<br>
&gt; &#43; * amdgpu_ttm_training_reserve_vram_init - create bo vram reserva=
tion from memory training<br>
&gt; &#43; *<br>
&gt; &#43; * @adev: amdgpu_device pointer<br>
&gt; &#43; *<br>
&gt; &#43; * create bo vram reservation from memory training.<br>
&gt; &#43; */<br>
&gt; &#43;static int amdgpu_ttm_training_reserve_vram_init(struct amdgpu_de=
vice *adev)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
<br>
DO NOT preinitialize ret.<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_memory_training_context *ctx =
=3D &amp;adev-&gt;psp.mem_train_ctx;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; memset(ctx, 0, sizeof(*ctx));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if(!adev-&gt;fw_vram_usage.mem_train_sup=
port) {<br>
<br>
Space after keywords: &quot;if (&quot;.<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_DEBUG(&quot;memory training does not support!\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;c2p_train_data_offset =3D adev-&=
gt;fw_vram_usage.mem_train_fb_loc;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;p2c_train_data_offset =3D (adev-=
&gt;gmc.mc_vram_size - GDDR6_MEM_TRAINING_OFFSET);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;train_data_size =3D GDDR6_MEM_TR=
AINING_DATA_SIZE_IN_BYTES;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;train_data_size:%llx,p2c=
_train_data_offset:%llx,c2p_train_data_offset:%llx.\n&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;train_data_size,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;p2c_train_data_offset,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;c2p_train_data_offset);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_kernel_at(adev,=
<br>
<br>
Here is where you definitively set &quot;ret&quot; so DO NOT preinitialize =
it to 0,<br>
just to avoid &quot;pesky compiler unininitialized variable warnings&quot;-=
-those<br>
are helpful to make the code more secure: a variable should be intentionall=
y<br>
initialized in all paths.<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ctx-&gt;p2c_train_data_offset,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ctx-&gt;train_data_size,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; AMDGPU_GEM_DOMAIN_VRAM,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &amp;ctx-&gt;p2c_bo,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; NULL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if(ret) {<br>
<br>
Space after keywords &quot;if (&quot;.<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_ERROR(&quot;alloc p2c_bo failed(%d)!\n&quot;, ret);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D -ENOMEM;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; goto err_out;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_kernel_at(adev,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ctx-&gt;c2p_train_data_offset,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ctx-&gt;train_data_size,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; AMDGPU_GEM_DOMAIN_VRAM,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &amp;ctx-&gt;c2p_bo,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; NULL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if(ret) {<br>
<br>
Space after keywords: &quot;if (&quot;, according to LKCS.<br>
<br>
Regards,<br>
Luben<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_ERROR(&quot;alloc c2p_bo failed(%d)!\n&quot;, ret);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D -ENOMEM;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; goto err_out;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;init =3D PSP_MEM_TRAIN_RESERVE_S=
UCCESS;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;<br>
&gt; &#43;err_out:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ttm_training_reserve_vram_fini(ad=
ev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; /**<br>
&gt;&nbsp;&nbsp; * amdgpu_ttm_init - Init the memory management (ttm) as we=
ll as various<br>
&gt;&nbsp;&nbsp; * gtt/vram related fields.<br>
&gt; @@ -1740,6 &#43;1827,14 @@ int amdgpu_ttm_init(struct amdgpu_device *a=
dev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *The reserved vram for memory trai=
ning must be pinned to the specified<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *place on the VRAM, so reserve it =
early.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ttm_training_reserve_vram_i=
nit(adev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return r;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* allocate memory as requir=
ed for VGA<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * This is used for VGA=
 emulation and pre-OS scanout buffers to<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * avoid display artifa=
cts while transitioning between pre-OS<br>
&gt; @@ -1825,6 &#43;1920,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *a=
dev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ttm_debugfs_fini(adev=
);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ttm_training_reserve_vram_fini(ad=
ev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ttm_fw_reserve_vram_f=
ini(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;mman.aper_base_=
kaddr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; iounmap(adev-&gt;mman.aper_base_kaddr);<br>
&gt; <br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SN1PR12MB2544F1BE7D37DEC4721AF95D95950SN1PR12MB2544namp_--

--===============1176885956==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1176885956==--
