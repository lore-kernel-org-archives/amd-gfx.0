From: "Wu, Hersen" <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amd/display: eDP fast bootup does not work for
 pre-raven asic
Date: Tue, 15 Jan 2019 17:20:23 +0000
Message-ID: <DM5PR1201MB2553DFC7EC50BA698BE597E3FD810@DM5PR1201MB2553.namprd12.prod.outlook.com>
References: <1547505375-13003-1-git-send-email-sunpeng.li@amd.com>
 <BN6PR12MB1809BE511C1770BED3E4349DF7810@BN6PR12MB1809.namprd12.prod.outlook.com>
 <DM5PR1201MB255383E2B49EFBE55ABA16D4FD810@DM5PR1201MB2553.namprd12.prod.outlook.com>
 <CADnq5_Mbw7ptXuXSM15P6oNcs1hQfmk6B+8C5D0G7m92VBG1fA@mail.gmail.com>,
 <DM5PR1201MB2553FF75089AC4B01F05962CFD810@DM5PR1201MB2553.namprd12.prod.outlook.com>
 <BN6PR12MB1809D016156DD31C51A185F5F7810@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1491279789=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1809D016156DD31C51A185F5F7810-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1491279789==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR1201MB2553DFC7EC50BA698BE597E3FD810DM5PR1201MB2553_"

--_000_DM5PR1201MB2553DFC7EC50BA698BE597E3FD810DM5PR1201MB2553_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi, Alex,

You are right!

Thanks,
Hersen


From: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, January 15, 2019 12:18 PM
To: Wu, Hersen <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>; Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Li, Sun peng (Leo) <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org;=
 Wentland, Harry <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: eDP fast bootup does not work for pre=
-raven asic


So 95f05a3a2e6895ecfd8b4f64b5d6c6 is still valid even with your patch and w=
e should keep it?  Thanks



Alex

________________________________
From: Wu, Hersen
Sent: Tuesday, January 15, 2019 12:04:30 PM
To: Alex Deucher
Cc: Deucher, Alexander; Li, Sun peng (Leo); amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<m=
ailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Wentland, Harry
Subject: RE: [PATCH] drm/amd/display: eDP fast bootup does not work for pre=
-raven asic

My change will NOT revert 95f05a3a2e6895ecfd8b4f64b5d6c6.

Thanks
Hersen



-----Original Message-----
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
Sent: Tuesday, January 15, 2019 12:01 PM
To: Wu, Hersen <hersenxs.wu-5C7GfCeVMHo@public.gmane.org<mailto:hersenxs.wu-5C7GfCeVMHo@public.gmane.org>>
Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org<mailto:Alexander.Deucher@=
amd.com>>; Li, Sun peng (Leo) <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org<mailto:Sunpeng.Li-5C7GfCeVMHo@public.gmane.org=
>>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; We=
ntland, Harry <Harry.Wentland-5C7GfCeVMHo@public.gmane.org<mailto:Harry.Wentland-5C7GfCeVMHo@public.gmane.org>>
Subject: Re: [PATCH] drm/amd/display: eDP fast bootup does not work for pre=
-raven asic

I'm not sure I understand.  If we were to apply your proposed patch, could =
we revert 95f05a3a2e6895ecfd8b4f64b5d6c6 ?

Thanks,

Alex

On Tue, Jan 15, 2019 at 11:57 AM Wu, Hersen <hersenxs.wu-5C7GfCeVMHo@public.gmane.org<mailto:her=
senxs.wu-5C7GfCeVMHo@public.gmane.org>> wrote:
>
> Hi, Alex,
>
>
>
> Hersen's change is for older version of eDP fast boot up ( bios_get_vga_e=
nabled_displays  is called).
>
> Chrome tree source still use bios_get_vga_enabled_displays for fast boot =
up.
>
>
>
>
>
> Harry's change is new implementation of eDP fast boot up.
>
>
>
> Hersen's change will not revert Harry's change.
>
>
>
> Thanks,
>
> Hersen
>
>
>
>
>
> From: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org<mailto:Alexander.Deuc=
her-5C7GfCeVMHo@public.gmane.org>>
> Sent: Tuesday, January 15, 2019 10:43 AM
> To: Li, Sun peng (Leo) <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org<mailto:Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>>;
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> Cc: Wentland, Harry <Harry.Wentland-5C7GfCeVMHo@public.gmane.org<mailto:Harry.Wentland-5C7GfCeVMHo@public.gmane.org=
>>; Wu, Hersen
> <hersenxs.wu-5C7GfCeVMHo@public.gmane.org<mailto:hersenxs.wu-5C7GfCeVMHo@public.gmane.org>>
> Subject: Re: [PATCH] drm/amd/display: eDP fast bootup does not work
> for pre-raven asic
>
>
>
> Can this patch be reverted with this change?
>
>
>
> commit 95f05a3a2e6895ecfd8b4f64b5d6c6cf0b6a3f4a
> Author: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org<mailto:alexander.deucher@=
amd.com>>
> Date:   Thu Aug 16 15:35:21 2018 -0500
>
>     drm/amdgpu/display: disable eDP fast boot optimization on DCE8
>
>     Seems to cause blank screens.
>
>     Bug: https://bugs.freedesktop.org/show_bug.cgi?id=3D106940
>     Reviewed-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org<mailto:harry.went=
land-5C7GfCeVMHo@public.gmane.org>>
>     Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org<mailto:alexand=
er.deucher-5C7GfCeVMHo@public.gmane.org>>
>
> Other than that, it looks good to me.
>
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org<mailto:alexander.deu=
cher-5C7GfCeVMHo@public.gmane.org>>
>
> ________________________________
>
> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounc=
es-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>> on behalf of
> sunpeng.li-5C7GfCeVMHo@public.gmane.org<mailto:sunpeng.li-5C7GfCeVMHo@public.gmane.org> <sunpeng.li-5C7GfCeVMHo@public.gmane.org<mailto:=
sunpeng.li-5C7GfCeVMHo@public.gmane.org>>
> Sent: Monday, January 14, 2019 5:36:15 PM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> Cc: Wentland, Harry; Wu, Hersen
> Subject: [PATCH] drm/amd/display: eDP fast bootup does not work for
> pre-raven asic
>
>
>
> From: hersen wu <hersenxs.wu-5C7GfCeVMHo@public.gmane.org<mailto:hersenxs.wu-5C7GfCeVMHo@public.gmane.org>>
>
> [Why] bios will light up eDP before sw driver loaded. sw driver will
> check if eDP lighted up by bios by reading BIOS_SCRATCH_3. If yes, sw
> driver will not power down eDP power, phy to save time.
> definition of BIOS_SCRATCH_3 are missed for pre-raven asic. this cuase
> eDP fast boot up not work. for some eDP panel, even AMD dp tx send
> NoVideoStream_flag =3D1 and dpcd 0x600=3D2, eDP rx may not handle
> properly. this may cause short period flash on screen.
>
> [How] add definition of BIOS_SCRATCH_3 for all asic
>
> CC: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org<mailto:harry.wentland-5C7GfCeVMHo@public.gmane.org>=
>
> Signed-off-by: hersen wu <hersenxs.wu-5C7GfCeVMHo@public.gmane.org<mailto:hersenxs.wu-5C7GfCeVMHo@public.gmane.org>=
>
> Reviewed-by: Charlene Liu <Charlene.Liu-5C7GfCeVMHo@public.gmane.org<mailto:Charlene.Liu@amd.c=
om>>
> Acked-by: Yongqiang Sun <yongqiang.sun-5C7GfCeVMHo@public.gmane.org<mailto:yongqiang.sun@amd.c=
om>>
> Acked-by: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org<mailto:sunpeng.li-5C7GfCeVMHo@public.gmane.org>>
> ---
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c | 3 +--
> drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c  | 2 ++
> drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c  | 2 ++
> drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c  | 2 ++
> drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c  | 1 +
>  drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c    | 2 ++
>  6 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c
> b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c
> index fdda8aa..d8275ceb 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c
> @@ -83,8 +83,7 @@ uint32_t bios_get_vga_enabled_displays(  {
>          uint32_t active_disp =3D 1;
>
> -       if (bios->regs->BIOS_SCRATCH_3) /*follow up with other asic, todo=
*/
> -               active_disp =3D REG_READ(BIOS_SCRATCH_3) & 0XFFFF;
> +       active_disp =3D REG_READ(BIOS_SCRATCH_3) & 0XFFFF;
>          return active_disp;
>  }
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> index c3f616a..23044e6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> @@ -76,6 +76,7 @@
>
>  #ifndef mmBIOS_SCRATCH_2
>          #define mmBIOS_SCRATCH_2 0x05CB
> +       #define mmBIOS_SCRATCH_3 0x05CC
>          #define mmBIOS_SCRATCH_6 0x05CF  #endif
>
> @@ -365,6 +366,7 @@ static const struct dce_abm_mask abm_mask =3D {
> #define DCFE_MEM_PWR_CTRL_REG_BASE 0x1b03
>
>  static const struct bios_registers bios_regs =3D {
> +       .BIOS_SCRATCH_3 =3D mmBIOS_SCRATCH_3,
>          .BIOS_SCRATCH_6 =3D mmBIOS_SCRATCH_6  };
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> index 7d46eb7..7549ada 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> @@ -84,6 +84,7 @@
>
>  #ifndef mmBIOS_SCRATCH_2
>          #define mmBIOS_SCRATCH_2 0x05CB
> +       #define mmBIOS_SCRATCH_3 0x05CC
>          #define mmBIOS_SCRATCH_6 0x05CF  #endif
>
> @@ -369,6 +370,7 @@ static const struct dce110_clk_src_mask cs_mask =3D
> {  };
>
>  static const struct bios_registers bios_regs =3D {
> +       .BIOS_SCRATCH_3 =3D mmBIOS_SCRATCH_3,
>          .BIOS_SCRATCH_6 =3D mmBIOS_SCRATCH_6  };
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> index d930e09..ea3065d6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> @@ -76,6 +76,7 @@
>
>  #ifndef mmBIOS_SCRATCH_2
>          #define mmBIOS_SCRATCH_2 0x05CB
> +       #define mmBIOS_SCRATCH_3 0x05CC
>          #define mmBIOS_SCRATCH_6 0x05CF  #endif
>
> @@ -376,6 +377,7 @@ static const struct dce110_clk_src_mask cs_mask =3D
> {  };
>
>  static const struct bios_registers bios_regs =3D {
> +       .BIOS_SCRATCH_3 =3D mmBIOS_SCRATCH_3,
>          .BIOS_SCRATCH_6 =3D mmBIOS_SCRATCH_6  };
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> index 23d7d4d..312a0ae 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> @@ -442,6 +442,7 @@ struct dce_i2c_hw *dce120_i2c_hw_create(
>          return dce_i2c_hw;
>  }
>  static const struct bios_registers bios_regs =3D {
> +       .BIOS_SCRATCH_3 =3D mmBIOS_SCRATCH_3 +
> + NBIO_BASE(mmBIOS_SCRATCH_3_BASE_IDX),
>          .BIOS_SCRATCH_6 =3D mmBIOS_SCRATCH_6 +
> NBIO_BASE(mmBIOS_SCRATCH_6_BASE_IDX)
>  };
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> index e0bba0bc..2eca81b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> @@ -77,6 +77,7 @@
>
>  #ifndef mmBIOS_SCRATCH_2
>          #define mmBIOS_SCRATCH_2 0x05CB
> +       #define mmBIOS_SCRATCH_3 0x05CC
>          #define mmBIOS_SCRATCH_6 0x05CF  #endif
>
> @@ -358,6 +359,7 @@ static const struct dce110_clk_src_mask cs_mask =3D
> {  };
>
>  static const struct bios_registers bios_regs =3D {
> +       .BIOS_SCRATCH_3 =3D mmBIOS_SCRATCH_3,
>          .BIOS_SCRATCH_6 =3D mmBIOS_SCRATCH_6  };
>
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR1201MB2553DFC7EC50BA698BE597E3FD810DM5PR1201MB2553_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi, Alex,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">You are right!<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Hersen<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Tuesday, January 15, 2019 12:18 PM<br>
<b>To:</b> Wu, Hersen &lt;hersenxs.wu-5C7GfCeVMHo@public.gmane.org&gt;; Alex Deucher &lt;alexdeu=
cher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Cc:</b> Li, Sun peng (Leo) &lt;Sunpeng.Li-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org; Wentland, Harry &lt;Harry.Wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/display: eDP fast bootup does not work =
for pre-raven asic<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-size:12.0pt;color:black">So </span><span style=3D"co=
lor:black">95f05a3a2e6895ecfd8b4f64b5d6c6</span><span style=3D"font-size:12=
.0pt;color:black"> is still valid even with your patch and we should keep i=
t?&nbsp; Thanks<o:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p><span style=3D"font-size:12.0pt;color:black">Alex<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Wu, Hersen<br>
<b>Sent:</b> Tuesday, January 15, 2019 12:04:30 PM<br>
<b>To:</b> Alex Deucher<br>
<b>Cc:</b> Deucher, Alexander; Li, Sun peng (Leo); <a href=3D"mailto:amd-gf=
x@lists.freedesktop.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Wentland, Harry<br>
<b>Subject:</b> RE: [PATCH] drm/amd/display: eDP fast bootup does not work =
for pre-raven asic</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">My change will NOT revert 95f05a3a2e6895ecfd8b4f64b5=
d6c6.<br>
<br>
Thanks<br>
Hersen<br>
<br>
<br>
<br>
-----Original Message-----<br>
From: Alex Deucher &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">alexdeucher=
@gmail.com</a>&gt;
<br>
Sent: Tuesday, January 15, 2019 12:01 PM<br>
To: Wu, Hersen &lt;<a href=3D"mailto:hersenxs.wu-5C7GfCeVMHo@public.gmane.org">hersenxs.wu@amd.c=
om</a>&gt;<br>
Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">Ale=
xander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;; Li, Sun peng (Leo) &lt;<a href=3D"mailto:Su=
npeng.Li-5C7GfCeVMHo@public.gmane.org">Sunpeng.Li-5C7GfCeVMHo@public.gmane.org</a>&gt;;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a>; Wentland, Harry &lt;<a href=3D"mailto:Harry.Wentland-5C7GfCeVMHo@public.gmane.org">Harr=
y.Wentland-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Subject: Re: [PATCH] drm/amd/display: eDP fast bootup does not work for pre=
-raven asic<br>
<br>
I'm not sure I understand.&nbsp; If we were to apply your proposed patch, c=
ould we revert 95f05a3a2e6895ecfd8b4f64b5d6c6 ?<br>
<br>
Thanks,<br>
<br>
Alex<br>
<br>
On Tue, Jan 15, 2019 at 11:57 AM Wu, Hersen &lt;<a href=3D"mailto:hersenxs.=
wu-5C7GfCeVMHo@public.gmane.org">hersenxs.wu-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi, Alex,<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Hersen&#8217;s change is for older version of eDP fast boot up ( bios_=
get_vga_enabled_displays&nbsp; is called).<br>
&gt;<br>
&gt; Chrome tree source still use bios_get_vga_enabled_displays for fast bo=
ot up.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Harry&#8217;s change is new implementation of eDP fast boot up.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Hersen&#8217;s change will not revert Harry&#8217;s change.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Hersen<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; From: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; Sent: Tuesday, January 15, 2019 10:43 AM<br>
&gt; To: Li, Sun peng (Leo) &lt;<a href=3D"mailto:Sunpeng.Li-5C7GfCeVMHo@public.gmane.org">Sunpe=
ng.Li-5C7GfCeVMHo@public.gmane.org</a>&gt;;
<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org</a><br>
&gt; Cc: Wentland, Harry &lt;<a href=3D"mailto:Harry.Wentland-5C7GfCeVMHo@public.gmane.org">Harr=
y.Wentland-5C7GfCeVMHo@public.gmane.org</a>&gt;; Wu, Hersen
<br>
&gt; &lt;<a href=3D"mailto:hersenxs.wu-5C7GfCeVMHo@public.gmane.org">hersenxs.wu-5C7GfCeVMHo@public.gmane.org</a>&gt;=
<br>
&gt; Subject: Re: [PATCH] drm/amd/display: eDP fast bootup does not work <b=
r>
&gt; for pre-raven asic<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Can this patch be reverted with this change?<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; commit 95f05a3a2e6895ecfd8b4f64b5d6c6cf0b6a3f4a<br>
&gt; Author: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">=
alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; Date:&nbsp;&nbsp; Thu Aug 16 15:35:21 2018 -0500<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; drm/amdgpu/display: disable eDP fast boot opti=
mization on DCE8<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Seems to cause blank screens.<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Bug: <a href=3D"https://bugs.freedesktop.org/s=
how_bug.cgi?id=3D106940">https://bugs.freedesktop.org/show_bug.cgi?id=3D106=
940</a><br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Reviewed-by: Harry Wentland &lt;<a href=3D"mai=
lto:harry.wentland-5C7GfCeVMHo@public.gmane.org">harry.wentland-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Signed-off-by: Alex Deucher &lt;<a href=3D"mai=
lto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt;<br>
&gt; Other than that, it looks good to me.<br>
&gt;<br>
&gt; Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.=
com">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt;<br>
&gt; ________________________________<br>
&gt;<br>
&gt; From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt; on behalf of
<br>
&gt; <a href=3D"mailto:sunpeng.li-5C7GfCeVMHo@public.gmane.org">sunpeng.li-5C7GfCeVMHo@public.gmane.org</a> &lt;<a hr=
ef=3D"mailto:sunpeng.li-5C7GfCeVMHo@public.gmane.org">sunpeng.li-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; Sent: Monday, January 14, 2019 5:36:15 PM<br>
&gt; To: <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org</a><br>
&gt; Cc: Wentland, Harry; Wu, Hersen<br>
&gt; Subject: [PATCH] drm/amd/display: eDP fast bootup does not work for <b=
r>
&gt; pre-raven asic<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; From: hersen wu &lt;<a href=3D"mailto:hersenxs.wu-5C7GfCeVMHo@public.gmane.org">hersenxs.wu=
@amd.com</a>&gt;<br>
&gt;<br>
&gt; [Why] bios will light up eDP before sw driver loaded. sw driver will <=
br>
&gt; check if eDP lighted up by bios by reading BIOS_SCRATCH_3. If yes, sw =
<br>
&gt; driver will not power down eDP power, phy to save time.<br>
&gt; definition of BIOS_SCRATCH_3 are missed for pre-raven asic. this cuase=
 <br>
&gt; eDP fast boot up not work. for some eDP panel, even AMD dp tx send <br=
>
&gt; NoVideoStream_flag =3D1 and dpcd 0x600=3D2, eDP rx may not handle <br>
&gt; properly. this may cause short period flash on screen.<br>
&gt;<br>
&gt; [How] add definition of BIOS_SCRATCH_3 for all asic<br>
&gt;<br>
&gt; CC: Harry Wentland &lt;<a href=3D"mailto:harry.wentland-5C7GfCeVMHo@public.gmane.org">harry=
.wentland-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; Signed-off-by: hersen wu &lt;<a href=3D"mailto:hersenxs.wu-5C7GfCeVMHo@public.gmane.org">he=
rsenxs.wu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; Reviewed-by: Charlene Liu &lt;<a href=3D"mailto:Charlene.Liu-5C7GfCeVMHo@public.gmane.org">=
Charlene.Liu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; Acked-by: Yongqiang Sun &lt;<a href=3D"mailto:yongqiang.sun-5C7GfCeVMHo@public.gmane.org">y=
ongqiang.sun-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; Acked-by: Leo Li &lt;<a href=3D"mailto:sunpeng.li-5C7GfCeVMHo@public.gmane.org">sunpeng.li@=
amd.com</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c | 3 &#4=
3;--&nbsp; <br>
&gt; drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c&nbsp; | 2 &#43=
;&#43;&nbsp; <br>
&gt; drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c&nbsp; | 2 &#43=
;&#43;&nbsp; <br>
&gt; drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c&nbsp; | 2 &#43=
;&#43;&nbsp; <br>
&gt; drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c&nbsp; | 1 &#43=
;<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c&nbsp;&nbsp=
;&nbsp; | 2 &#43;&#43;<br>
&gt;&nbsp; 6 files changed, 10 insertions(&#43;), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c =
<br>
&gt; b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c<br>
&gt; index fdda8aa..d8275ceb 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_help=
er.c<br>
&gt; @@ -83,8 &#43;83,7 @@ uint32_t bios_get_vga_enabled_displays(&nbsp; {<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t active_=
disp =3D 1;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bios-&gt;regs-&gt;BIOS_SCRAT=
CH_3) /*follow up with other asic, todo*/<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; active_disp =3D REG_READ(BIOS_SCRATCH_3) &amp; 0XFFFF;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; active_disp =3D REG_READ(BIO=
S_SCRATCH_3) &amp; 0XFFFF;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return active_di=
sp;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c <=
br>
&gt; b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c<br>
&gt; index c3f616a..23044e6 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resourc=
e.c<br>
&gt; @@ -76,6 &#43;76,7 @@<br>
&gt;<br>
&gt;&nbsp; #ifndef mmBIOS_SCRATCH_2<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define mmBIOS_S=
CRATCH_2 0x05CB<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define mmBIOS_SCRATCH_3 0x0=
5CC<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define mmBIOS_S=
CRATCH_6 0x05CF&nbsp; #endif<br>
&gt;<br>
&gt; @@ -365,6 &#43;366,7 @@ static const struct dce_abm_mask abm_mask =3D =
{&nbsp; <br>
&gt; #define DCFE_MEM_PWR_CTRL_REG_BASE 0x1b03<br>
&gt;<br>
&gt;&nbsp; static const struct bios_registers bios_regs =3D {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .BIOS_SCRATCH_3 =3D mmBIOS_S=
CRATCH_3,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .BIOS_SCRATCH_6 =
=3D mmBIOS_SCRATCH_6&nbsp; };<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c <=
br>
&gt; b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c<br>
&gt; index 7d46eb7..7549ada 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resourc=
e.c<br>
&gt; @@ -84,6 &#43;84,7 @@<br>
&gt;<br>
&gt;&nbsp; #ifndef mmBIOS_SCRATCH_2<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define mmBIOS_S=
CRATCH_2 0x05CB<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define mmBIOS_SCRATCH_3 0x0=
5CC<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define mmBIOS_S=
CRATCH_6 0x05CF&nbsp; #endif<br>
&gt;<br>
&gt; @@ -369,6 &#43;370,7 @@ static const struct dce110_clk_src_mask cs_mas=
k =3D <br>
&gt; {&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static const struct bios_registers bios_regs =3D {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .BIOS_SCRATCH_3 =3D mmBIOS_S=
CRATCH_3,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .BIOS_SCRATCH_6 =
=3D mmBIOS_SCRATCH_6&nbsp; };<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c <=
br>
&gt; b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c<br>
&gt; index d930e09..ea3065d6 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resourc=
e.c<br>
&gt; @@ -76,6 &#43;76,7 @@<br>
&gt;<br>
&gt;&nbsp; #ifndef mmBIOS_SCRATCH_2<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define mmBIOS_S=
CRATCH_2 0x05CB<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define mmBIOS_SCRATCH_3 0x0=
5CC<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define mmBIOS_S=
CRATCH_6 0x05CF&nbsp; #endif<br>
&gt;<br>
&gt; @@ -376,6 &#43;377,7 @@ static const struct dce110_clk_src_mask cs_mas=
k =3D <br>
&gt; {&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static const struct bios_registers bios_regs =3D {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .BIOS_SCRATCH_3 =3D mmBIOS_S=
CRATCH_3,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .BIOS_SCRATCH_6 =
=3D mmBIOS_SCRATCH_6&nbsp; };<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c <=
br>
&gt; b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c<br>
&gt; index 23d7d4d..312a0ae 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resourc=
e.c<br>
&gt; @@ -442,6 &#43;442,7 @@ struct dce_i2c_hw *dce120_i2c_hw_create(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return dce_i2c_h=
w;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; static const struct bios_registers bios_regs =3D {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .BIOS_SCRATCH_3 =3D mmBIOS_S=
CRATCH_3 &#43; <br>
&gt; &#43; NBIO_BASE(mmBIOS_SCRATCH_3_BASE_IDX),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .BIOS_SCRATCH_6 =
=3D mmBIOS_SCRATCH_6 &#43; <br>
&gt; NBIO_BASE(mmBIOS_SCRATCH_6_BASE_IDX)<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c <br=
>
&gt; b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c<br>
&gt; index e0bba0bc..2eca81b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.=
c<br>
&gt; @@ -77,6 &#43;77,7 @@<br>
&gt;<br>
&gt;&nbsp; #ifndef mmBIOS_SCRATCH_2<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define mmBIOS_S=
CRATCH_2 0x05CB<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define mmBIOS_SCRATCH_3 0x0=
5CC<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define mmBIOS_S=
CRATCH_6 0x05CF&nbsp; #endif<br>
&gt;<br>
&gt; @@ -358,6 &#43;359,7 @@ static const struct dce110_clk_src_mask cs_mas=
k =3D <br>
&gt; {&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static const struct bios_registers bios_regs =3D {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .BIOS_SCRATCH_3 =3D mmBIOS_S=
CRATCH_3,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .BIOS_SCRATCH_6 =
=3D mmBIOS_SCRATCH_6&nbsp; };<br>
&gt;<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR1201MB2553DFC7EC50BA698BE597E3FD810DM5PR1201MB2553_--

--===============1491279789==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1491279789==--
