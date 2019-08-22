From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amd/powerplay: correct the pp_feature output on
 Arcturus
Date: Thu, 22 Aug 2019 11:42:03 +0000
Message-ID: <MN2PR12MB32963C565726A29BCFCB126BA2A50@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20190821084143.25713-1-evan.quan@amd.com>
 <20190821084143.25713-2-evan.quan@amd.com>,
 <MN2PR12MB3344D88565FD9A38CF442F7EE4A50@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0549601324=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3344D88565FD9A38CF442F7EE4A50-rweVpJHSKToDMgCC8P//OwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============0549601324==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB32963C565726A29BCFCB126BA2A50MN2PR12MB3296namp_"

--_000_MN2PR12MB32963C565726A29BCFCB126BA2A50MN2PR12MB3296namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Quan, Ev=
an <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, August 22, 2019 6:20 PM
To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx@=
lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 2/2] drm/amd/powerplay: correct the pp_feature output o=
n Arcturus

Ping..

> -----Original Message-----
> From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
> Sent: Wednesday, August 21, 2019 4:42 PM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
> Subject: [PATCH 2/2] drm/amd/powerplay: correct the pp_feature output on
> Arcturus
>
> Fix for the commit below:
> drm/amd/powerplay: implment sysfs feature status function in smu
>
> Change-Id: Id9a373f8d8866b97450be0aef0ba19d0835d40d8
> Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 2 ++
> drivers/gpu/drm/amd/powerplay/inc/smu_types.h | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index dd6563358e8e..f1f072012fac 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -141,6 +141,7 @@ static struct smu_11_0_cmn2aisc_mapping
> arcturus_feature_mask_map[SMU_FEATURE_CO
>        FEA_MAP(DPM_SOCCLK),
>        FEA_MAP(DPM_FCLK),
>        FEA_MAP(DPM_MP0CLK),
> +     ARCTURUS_FEA_MAP(SMU_FEATURE_XGMI_BIT,
> FEATURE_DPM_XGMI_BIT),
>        FEA_MAP(DS_GFXCLK),
>        FEA_MAP(DS_SOCCLK),
>        FEA_MAP(DS_LCLK),
> @@ -149,6 +150,7 @@ static struct smu_11_0_cmn2aisc_mapping
> arcturus_feature_mask_map[SMU_FEATURE_CO
>        FEA_MAP(GFX_ULV),
>        ARCTURUS_FEA_MAP(SMU_FEATURE_VCN_PG_BIT,
> FEATURE_DPM_VCN_BIT),
>        FEA_MAP(RSMU_SMN_CG),
> +     FEA_MAP(WAFL_CG),
>        FEA_MAP(PPT),
>        FEA_MAP(TDC),
>        FEA_MAP(APCC_PLUS),
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
> b/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
> index 72962e842d69..c3c74098f614 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
> @@ -207,6 +207,7 @@ enum smu_clk_type {
>         __SMU_DUMMY_MAP(TEMP_DEPENDENT_VMIN),                  \
>         __SMU_DUMMY_MAP(MMHUB_PG),                             \
>         __SMU_DUMMY_MAP(ATHUB_PG),                             \
> +       __SMU_DUMMY_MAP(WAFL_CG),
>
>  #undef __SMU_DUMMY_MAP
>  #define __SMU_DUMMY_MAP(feature)
>        SMU_FEATURE_##feature##_BIT
> --
> 2.23.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB32963C565726A29BCFCB126BA2A50MN2PR12MB3296namp_
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
Reviewed-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,<br>
Kevin</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Quan, Evan &lt;Evan.Quan@amd.=
com&gt;<br>
<b>Sent:</b> Thursday, August 22, 2019 6:20 PM<br>
<b>To:</b> Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amd/powerplay: correct the pp_feature o=
utput on Arcturus</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Ping..<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Sent: Wednesday, August 21, 2019 4:42 PM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Subject: [PATCH 2/2] drm/amd/powerplay: correct the pp_feature output =
on<br>
&gt; Arcturus<br>
&gt; <br>
&gt; Fix for the commit below:<br>
&gt; drm/amd/powerplay: implment sysfs feature status function in smu<br>
&gt; <br>
&gt; Change-Id: Id9a373f8d8866b97450be0aef0ba19d0835d40d8<br>
&gt; Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/arcturus_ppt.c&nbsp; | 2 &#43;&#43=
;<br>
&gt; drivers/gpu/drm/amd/powerplay/inc/smu_types.h | 1 &#43;<br>
&gt;&nbsp; 2 files changed, 3 insertions(&#43;)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&gt; index dd6563358e8e..f1f072012fac 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&gt; @@ -141,6 &#43;141,7 @@ static struct smu_11_0_cmn2aisc_mapping<br>
&gt; arcturus_feature_mask_map[SMU_FEATURE_CO<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(DPM_SOCCLK),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(DPM_FCLK),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(DPM_MP0CLK),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ARCTURUS_FEA_MAP(SMU_FEATURE_XGMI_BIT,<b=
r>
&gt; FEATURE_DPM_XGMI_BIT),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(DS_GFXCLK),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(DS_SOCCLK),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(DS_LCLK),<br>
&gt; @@ -149,6 &#43;150,7 @@ static struct smu_11_0_cmn2aisc_mapping<br>
&gt; arcturus_feature_mask_map[SMU_FEATURE_CO<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(GFX_ULV),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ARCTURUS_FEA_MAP(SMU_FEATURE=
_VCN_PG_BIT,<br>
&gt; FEATURE_DPM_VCN_BIT),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(RSMU_SMN_CG),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(WAFL_CG),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(PPT),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(TDC),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(APCC_PLUS),<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_types.h<br>
&gt; b/drivers/gpu/drm/amd/powerplay/inc/smu_types.h<br>
&gt; index 72962e842d69..c3c74098f614 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/inc/smu_types.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smu_types.h<br>
&gt; @@ -207,6 &#43;207,7 @@ enum smu_clk_type {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(TEMP_D=
EPENDENT_VMIN),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(MMHUB_=
PG),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(ATHUB_=
PG),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(WAFL_CG),<br=
>
&gt; <br>
&gt;&nbsp; #undef __SMU_DUMMY_MAP<br>
&gt;&nbsp; #define __SMU_DUMMY_MAP(feature)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_FEATURE_##feature##_BIT<=
br>
&gt; --<br>
&gt; 2.23.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB32963C565726A29BCFCB126BA2A50MN2PR12MB3296namp_--

--===============0549601324==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0549601324==--
