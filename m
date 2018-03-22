From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Add CM_TEST_DEBUG regs for DCN
Date: Thu, 22 Mar 2018 20:03:38 +0000
Message-ID: <BN6PR12MB180984AD1B4E6E54F2479A57F7A90@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20180319174522.6691-1-harry.wentland@amd.com>,
 <b1e3006c-33db-04d0-544d-74c585de9f19@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0185236889=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b1e3006c-33db-04d0-544d-74c585de9f19-5C7GfCeVMHo@public.gmane.org>
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Cheng, Tony" <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>

--===============0185236889==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180984AD1B4E6E54F2479A57F7A90BN6PR12MB1809namp_"

--_000_BN6PR12MB180984AD1B4E6E54F2479A57F7A90BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: Wentland, Harry
Sent: Thursday, March 22, 2018 3:53:57 PM
To: amd-gfx mailing list
Cc: Cheng, Tony; Deucher, Alexander
Subject: Re: [PATCH] drm/amdgpu: Add CM_TEST_DEBUG regs for DCN

Ping.

Wonder if I can get an RB or AB for this.

Harry

On 2018-03-19 01:45 PM, Harry Wentland wrote:
> We'd like to use them for reading DCN debug status.
>
> Signed-off-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
> ---
>
> See patch for where we use them http://git.amd.com:8080/#/c/137151/1
>
> Tony can comment on details.
>
> Harry
>
>  .../gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_offset.h | 19 +++++++++++++=
+++---
>  .../drm/amd/include/asic_reg/dcn/dcn_1_0_sh_mask.h    |  8 ++++++++
>  2 files changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_offset.h b/=
drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_offset.h
> index 4ccf9681c45d..721c61171045 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_offset.h
> @@ -3895,6 +3895,10 @@
>  #define mmCM0_CM_MEM_PWR_CTRL_BASE_IDX                                  =
                               2
>  #define mmCM0_CM_MEM_PWR_STATUS                                         =
                               0x0d33
>  #define mmCM0_CM_MEM_PWR_STATUS_BASE_IDX                                =
                               2
> +#define mmCM0_CM_TEST_DEBUG_INDEX                                       =
                               0x0d35
> +#define mmCM0_CM_TEST_DEBUG_INDEX_BASE_IDX                              =
                               2
> +#define mmCM0_CM_TEST_DEBUG_DATA                                        =
                               0x0d36
> +#define mmCM0_CM_TEST_DEBUG_DATA_BASE_IDX                               =
                               2
>
>
>  // addressBlock: dce_dc_dpp0_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
> @@ -4367,7 +4371,10 @@
>  #define mmCM1_CM_MEM_PWR_CTRL_BASE_IDX                                  =
                               2
>  #define mmCM1_CM_MEM_PWR_STATUS                                         =
                               0x0e4e
>  #define mmCM1_CM_MEM_PWR_STATUS_BASE_IDX                                =
                               2
> -
> +#define mmCM1_CM_TEST_DEBUG_INDEX                                       =
                               0x0e50
> +#define mmCM1_CM_TEST_DEBUG_INDEX_BASE_IDX                              =
                               2
> +#define mmCM1_CM_TEST_DEBUG_DATA                                        =
                               0x0e51
> +#define mmCM1_CM_TEST_DEBUG_DATA_BASE_IDX                               =
                               2
>
>  // addressBlock: dce_dc_dpp1_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
>  // base address: 0x399c
> @@ -4839,7 +4846,10 @@
>  #define mmCM2_CM_MEM_PWR_CTRL_BASE_IDX                                  =
                               2
>  #define mmCM2_CM_MEM_PWR_STATUS                                         =
                               0x0f69
>  #define mmCM2_CM_MEM_PWR_STATUS_BASE_IDX                                =
                               2
> -
> +#define mmCM2_CM_TEST_DEBUG_INDEX                                       =
                               0x0f6b
> +#define mmCM2_CM_TEST_DEBUG_INDEX_BASE_IDX                              =
                               2
> +#define mmCM2_CM_TEST_DEBUG_DATA                                        =
                               0x0f6c
> +#define mmCM2_CM_TEST_DEBUG_DATA_BASE_IDX                               =
                               2
>
>  // addressBlock: dce_dc_dpp2_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
>  // base address: 0x3e08
> @@ -5311,7 +5321,10 @@
>  #define mmCM3_CM_MEM_PWR_CTRL_BASE_IDX                                  =
                               2
>  #define mmCM3_CM_MEM_PWR_STATUS                                         =
                               0x1084
>  #define mmCM3_CM_MEM_PWR_STATUS_BASE_IDX                                =
                               2
> -
> +#define mmCM3_CM_TEST_DEBUG_INDEX                                       =
                               0x1086
> +#define mmCM3_CM_TEST_DEBUG_INDEX_BASE_IDX                              =
                               2
> +#define mmCM3_CM_TEST_DEBUG_DATA                                        =
                               0x1087
> +#define mmCM3_CM_TEST_DEBUG_DATA_BASE_IDX                               =
                               2
>
>  // addressBlock: dce_dc_dpp3_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
>  // base address: 0x4274
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_sh_mask.h b=
/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_sh_mask.h
> index e2a2f114bd8e..e7c0cad41081 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_sh_mask.h
> @@ -14049,6 +14049,14 @@
>  #define CM0_CM_MEM_PWR_STATUS__RGAM_MEM_PWR_STATE__SHIFT                =
                                      0x2
>  #define CM0_CM_MEM_PWR_STATUS__SHARED_MEM_PWR_STATE_MASK                =
                                      0x00000003L
>  #define CM0_CM_MEM_PWR_STATUS__RGAM_MEM_PWR_STATE_MASK                  =
                                      0x0000000CL
> +//CM0_CM_TEST_DEBUG_INDEX
> +#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_INDEX__SHIFT             =
                                      0x0
> +#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_WRITE_EN__SHIFT          =
                                      0x8
> +#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_INDEX_MASK               =
                                      0x000000FFL
> +#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_WRITE_EN_MASK            =
                                      0x00000100L
> +//CM0_CM_TEST_DEBUG_DATA
> +#define CM0_CM_TEST_DEBUG_DATA__CM_TEST_DEBUG_DATA__SHIFT               =
                                      0x0
> +#define CM0_CM_TEST_DEBUG_DATA__CM_TEST_DEBUG_DATA_MASK                 =
                                      0xFFFFFFFFL
>
>
>  // addressBlock: dce_dc_dpp0_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
>

--_000_BN6PR12MB180984AD1B4E6E54F2479A57F7A90BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wentland, Harry<br>
<b>Sent:</b> Thursday, March 22, 2018 3:53:57 PM<br>
<b>To:</b> amd-gfx mailing list<br>
<b>Cc:</b> Cheng, Tony; Deucher, Alexander<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Add CM_TEST_DEBUG regs for DCN</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Ping.<br>
<br>
Wonder if I can get an RB or AB for this.<br>
<br>
Harry<br>
<br>
On 2018-03-19 01:45 PM, Harry Wentland wrote:<br>
&gt; We'd like to use them for reading DCN debug status.<br>
&gt; <br>
&gt; Signed-off-by: Harry Wentland &lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt; <br>
&gt; See patch for where we use them <a href=3D"http://git.amd.com:8080/#/c=
/137151/1">
http://git.amd.com:8080/#/c/137151/1</a><br>
&gt; <br>
&gt; Tony can comment on details.<br>
&gt; <br>
&gt; Harry<br>
&gt; <br>
&gt;&nbsp; .../gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_offset.h | 19 &#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
---<br>
&gt;&nbsp; .../drm/amd/include/asic_reg/dcn/dcn_1_0_sh_mask.h&nbsp;&nbsp;&n=
bsp; |&nbsp; 8 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; 2 files changed, 24 insertions(&#43;), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_offset.h=
 b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_offset.h<br>
&gt; index 4ccf9681c45d..721c61171045 100644<br>
&gt; --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_offset.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_off=
set.h<br>
&gt; @@ -3895,6 &#43;3895,10 @@<br>
&gt;&nbsp; #define mmCM0_CM_MEM_PWR_CTRL_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&gt;&nbsp; #define mmCM0_CM_MEM_PWR_STATUS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0x0d33<br>
&gt;&nbsp; #define mmCM0_CM_MEM_PWR_STATUS_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&gt; &#43;#define mmCM0_CM_TEST_DEBUG_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0x0d35<br>
&gt; &#43;#define mmCM0_CM_TEST_DEBUG_INDEX_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&gt; &#43;#define mmCM0_CM_TEST_DEBUG_DATA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 0x0d36<br>
&gt; &#43;#define mmCM0_CM_TEST_DEBUG_DATA_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&gt;&nbsp; <br>
&gt;&nbsp; <br>
&gt;&nbsp; // addressBlock: dce_dc_dpp0_dispdec_dpp_dcperfmon_dc_perfmon_di=
spdec<br>
&gt; @@ -4367,7 &#43;4371,10 @@<br>
&gt;&nbsp; #define mmCM1_CM_MEM_PWR_CTRL_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&gt;&nbsp; #define mmCM1_CM_MEM_PWR_STATUS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0x0e4e<br>
&gt;&nbsp; #define mmCM1_CM_MEM_PWR_STATUS_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&gt; -<br>
&gt; &#43;#define mmCM1_CM_TEST_DEBUG_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0x0e50<br>
&gt; &#43;#define mmCM1_CM_TEST_DEBUG_INDEX_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&gt; &#43;#define mmCM1_CM_TEST_DEBUG_DATA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 0x0e51<br>
&gt; &#43;#define mmCM1_CM_TEST_DEBUG_DATA_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&gt;&nbsp; <br>
&gt;&nbsp; // addressBlock: dce_dc_dpp1_dispdec_dpp_dcperfmon_dc_perfmon_di=
spdec<br>
&gt;&nbsp; // base address: 0x399c<br>
&gt; @@ -4839,7 &#43;4846,10 @@<br>
&gt;&nbsp; #define mmCM2_CM_MEM_PWR_CTRL_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&gt;&nbsp; #define mmCM2_CM_MEM_PWR_STATUS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0x0f69<br>
&gt;&nbsp; #define mmCM2_CM_MEM_PWR_STATUS_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&gt; -<br>
&gt; &#43;#define mmCM2_CM_TEST_DEBUG_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0x0f6b<br>
&gt; &#43;#define mmCM2_CM_TEST_DEBUG_INDEX_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&gt; &#43;#define mmCM2_CM_TEST_DEBUG_DATA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 0x0f6c<br>
&gt; &#43;#define mmCM2_CM_TEST_DEBUG_DATA_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&gt;&nbsp; <br>
&gt;&nbsp; // addressBlock: dce_dc_dpp2_dispdec_dpp_dcperfmon_dc_perfmon_di=
spdec<br>
&gt;&nbsp; // base address: 0x3e08<br>
&gt; @@ -5311,7 &#43;5321,10 @@<br>
&gt;&nbsp; #define mmCM3_CM_MEM_PWR_CTRL_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&gt;&nbsp; #define mmCM3_CM_MEM_PWR_STATUS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0x1084<br>
&gt;&nbsp; #define mmCM3_CM_MEM_PWR_STATUS_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&gt; -<br>
&gt; &#43;#define mmCM3_CM_TEST_DEBUG_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0x1086<br>
&gt; &#43;#define mmCM3_CM_TEST_DEBUG_INDEX_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&gt; &#43;#define mmCM3_CM_TEST_DEBUG_DATA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 0x1087<br>
&gt; &#43;#define mmCM3_CM_TEST_DEBUG_DATA_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&gt;&nbsp; <br>
&gt;&nbsp; // addressBlock: dce_dc_dpp3_dispdec_dpp_dcperfmon_dc_perfmon_di=
spdec<br>
&gt;&nbsp; // base address: 0x4274<br>
&gt; diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_sh_mask.=
h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_sh_mask.h<br>
&gt; index e2a2f114bd8e..e7c0cad41081 100644<br>
&gt; --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_sh_mask.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_1_0_sh_=
mask.h<br>
&gt; @@ -14049,6 &#43;14049,14 @@<br>
&gt;&nbsp; #define CM0_CM_MEM_PWR_STATUS__RGAM_MEM_PWR_STATE__SHIFT&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0x2<br>
&gt;&nbsp; #define CM0_CM_MEM_PWR_STATUS__SHARED_MEM_PWR_STATE_MASK&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0x00000003L<br>
&gt;&nbsp; #define CM0_CM_MEM_PWR_STATUS__RGAM_MEM_PWR_STATE_MASK&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x0000000CL<br>
&gt; &#43;//CM0_CM_TEST_DEBUG_INDEX<br>
&gt; &#43;#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_INDEX__SHIFT&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0<b=
r>
&gt; &#43;#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_WRITE_EN__SHIFT&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8<br>
&gt; &#43;#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_INDEX_MASK&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x000000FFL<br>
&gt; &#43;#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_WRITE_EN_MASK&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000100=
L<br>
&gt; &#43;//CM0_CM_TEST_DEBUG_DATA<br>
&gt; &#43;#define CM0_CM_TEST_DEBUG_DATA__CM_TEST_DEBUG_DATA__SHIFT&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x0<br>
&gt; &#43;#define CM0_CM_TEST_DEBUG_DATA__CM_TEST_DEBUG_DATA_MASK&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0xFFFFFFFFL<br>
&gt;&nbsp; <br>
&gt;&nbsp; <br>
&gt;&nbsp; // addressBlock: dce_dc_dpp0_dispdec_dpp_dcperfmon_dc_perfmon_di=
spdec<br>
&gt; <br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB180984AD1B4E6E54F2479A57F7A90BN6PR12MB1809namp_--

--===============0185236889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0185236889==--
