From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: eDP fast bootup does not work for
 pre-raven asic
Date: Tue, 15 Jan 2019 17:18:17 +0000
Message-ID: <BN6PR12MB1809D016156DD31C51A185F5F7810@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1547505375-13003-1-git-send-email-sunpeng.li@amd.com>
 <BN6PR12MB1809BE511C1770BED3E4349DF7810@BN6PR12MB1809.namprd12.prod.outlook.com>
 <DM5PR1201MB255383E2B49EFBE55ABA16D4FD810@DM5PR1201MB2553.namprd12.prod.outlook.com>
 <CADnq5_Mbw7ptXuXSM15P6oNcs1hQfmk6B+8C5D0G7m92VBG1fA@mail.gmail.com>,
 <DM5PR1201MB2553FF75089AC4B01F05962CFD810@DM5PR1201MB2553.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1244693139=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR1201MB2553FF75089AC4B01F05962CFD810-grEf7a3NxMAXo4eMau56LGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Wu, Hersen" <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1244693139==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809D016156DD31C51A185F5F7810BN6PR12MB1809namp_"

--_000_BN6PR12MB1809D016156DD31C51A185F5F7810BN6PR12MB1809namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

So 95f05a3a2e6895ecfd8b4f64b5d6c6 is still valid even with your patch and w=
e should keep it?  Thanks


Alex

________________________________
From: Wu, Hersen
Sent: Tuesday, January 15, 2019 12:04:30 PM
To: Alex Deucher
Cc: Deucher, Alexander; Li, Sun peng (Leo); amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; =
Wentland, Harry
Subject: RE: [PATCH] drm/amd/display: eDP fast bootup does not work for pre=
-raven asic

My change will NOT revert 95f05a3a2e6895ecfd8b4f64b5d6c6.

Thanks
Hersen



-----Original Message-----
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, January 15, 2019 12:01 PM
To: Wu, Hersen <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>
Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Li, Sun peng (Leo) <Sun=
peng.Li-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Wentland, Harry <Harry.Wen=
tland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: eDP fast bootup does not work for pre=
-raven asic

I'm not sure I understand.  If we were to apply your proposed patch, could =
we revert 95f05a3a2e6895ecfd8b4f64b5d6c6 ?

Thanks,

Alex

On Tue, Jan 15, 2019 at 11:57 AM Wu, Hersen <hersenxs.wu-5C7GfCeVMHo@public.gmane.org> wrote:
>
> Hi, Alex,
>
>
>
> Hersen=92s change is for older version of eDP fast boot up ( bios_get_vga=
_enabled_displays  is called).
>
> Chrome tree source still use bios_get_vga_enabled_displays for fast boot =
up.
>
>
>
>
>
> Harry=92s change is new implementation of eDP fast boot up.
>
>
>
> Hersen=92s change will not revert Harry=92s change.
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
> From: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
> Sent: Tuesday, January 15, 2019 10:43 AM
> To: Li, Sun peng (Leo) <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>;
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Wentland, Harry <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>; Wu, Hersen
> <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>
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
> Author: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> Date:   Thu Aug 16 15:35:21 2018 -0500
>
>     drm/amdgpu/display: disable eDP fast boot optimization on DCE8
>
>     Seems to cause blank screens.
>
>     Bug: https://bugs.freedesktop.org/show_bug.cgi?id=3D106940
>     Reviewed-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
>     Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>
> Other than that, it looks good to me.
>
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>
> ________________________________
>
> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of
> sunpeng.li-5C7GfCeVMHo@public.gmane.org <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
> Sent: Monday, January 14, 2019 5:36:15 PM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Wentland, Harry; Wu, Hersen
> Subject: [PATCH] drm/amd/display: eDP fast bootup does not work for
> pre-raven asic
>
>
>
> From: hersen wu <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>
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
> CC: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: hersen wu <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>
> Reviewed-by: Charlene Liu <Charlene.Liu-5C7GfCeVMHo@public.gmane.org>
> Acked-by: Yongqiang Sun <yongqiang.sun-5C7GfCeVMHo@public.gmane.org>
> Acked-by: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809D016156DD31C51A185F5F7810BN6PR12MB1809namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">So <font size=3D"2"><span style=
=3D"font-size:11pt;">95f05a3a2e6895ecfd8b4f64b5d6c6</span></font> is still =
valid even with your patch and we should keep it?&nbsp; Thanks</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wu, Hersen<br>
<b>Sent:</b> Tuesday, January 15, 2019 12:04:30 PM<br>
<b>To:</b> Alex Deucher<br>
<b>Cc:</b> Deucher, Alexander; Li, Sun peng (Leo); amd-gfx-PD4FTy7X32lNgt0PjOBp9w@public.gmane.org=
p.org; Wentland, Harry<br>
<b>Subject:</b> RE: [PATCH] drm/amd/display: eDP fast bootup does not work =
for pre-raven asic</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">My change will NOT revert 95f05a3a2e6895ecfd8b4f64=
b5d6c6.<br>
<br>
Thanks<br>
Hersen<br>
<br>
<br>
<br>
-----Original Message-----<br>
From: Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt; <br>
Sent: Tuesday, January 15, 2019 12:01 PM<br>
To: Wu, Hersen &lt;hersenxs.wu-5C7GfCeVMHo@public.gmane.org&gt;<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Li, Sun peng (Leo=
) &lt;Sunpeng.Li-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Wentland, Harr=
y &lt;Harry.Wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
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
On Tue, Jan 15, 2019 at 11:57 AM Wu, Hersen &lt;hersenxs.wu-5C7GfCeVMHo@public.gmane.org&gt; wro=
te:<br>
&gt;<br>
&gt; Hi, Alex,<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Hersen=92s change is for older version of eDP fast boot up ( bios_get_=
vga_enabled_displays&nbsp; is called).<br>
&gt;<br>
&gt; Chrome tree source still use bios_get_vga_enabled_displays for fast bo=
ot up.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Harry=92s change is new implementation of eDP fast boot up.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Hersen=92s change will not revert Harry=92s change.<br>
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
&gt; From: Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Sent: Tuesday, January 15, 2019 10:43 AM<br>
&gt; To: Li, Sun peng (Leo) &lt;Sunpeng.Li-5C7GfCeVMHo@public.gmane.org&gt;; <br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Wentland, Harry &lt;Harry.Wentland-5C7GfCeVMHo@public.gmane.org&gt;; Wu, Hersen <br>
&gt; &lt;hersenxs.wu-5C7GfCeVMHo@public.gmane.org&gt;<br>
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
&gt; Author: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
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
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Reviewed-by: Harry Wentland &lt;harry.wentland=
@amd.com&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Signed-off-by: Alex Deucher &lt;alexander.deuc=
her-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;<br>
&gt; Other than that, it looks good to me.<br>
&gt;<br>
&gt; Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;<br>
&gt; ________________________________<br>
&gt;<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf =
of <br>
&gt; sunpeng.li-5C7GfCeVMHo@public.gmane.org &lt;sunpeng.li-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Sent: Monday, January 14, 2019 5:36:15 PM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Wentland, Harry; Wu, Hersen<br>
&gt; Subject: [PATCH] drm/amd/display: eDP fast bootup does not work for <b=
r>
&gt; pre-raven asic<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; From: hersen wu &lt;hersenxs.wu-5C7GfCeVMHo@public.gmane.org&gt;<br>
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
&gt; CC: Harry Wentland &lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Signed-off-by: hersen wu &lt;hersenxs.wu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Reviewed-by: Charlene Liu &lt;Charlene.Liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Acked-by: Yongqiang Sun &lt;yongqiang.sun-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Acked-by: Leo Li &lt;sunpeng.li-5C7GfCeVMHo@public.gmane.org&gt;<br>
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
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809D016156DD31C51A185F5F7810BN6PR12MB1809namp_--

--===============1244693139==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1244693139==--
