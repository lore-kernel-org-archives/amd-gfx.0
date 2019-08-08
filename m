From: "Yin, Tianci (Rico)" <Tianci.Yin-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] md/powerplay: re-define smu interface version for smu
 v11
Date: Thu, 8 Aug 2019 05:41:33 +0000
Message-ID: <MN2PR12MB29744ED8B694F460A72835D395D70@MN2PR12MB2974.namprd12.prod.outlook.com>
References: <1565241947-31011-1-git-send-email-tianci.yin@amd.com>,
 <CADnq5_NTKEkxdFAQU-TEW-KjWP-HWdRrPPXT05460EFc3bGutA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0790597734=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_NTKEkxdFAQU-TEW-KjWP-HWdRrPPXT05460EFc3bGutA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "Wang,
 Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "Yuan,
 Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

--===============0790597734==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB29744ED8B694F460A72835D395D70MN2PR12MB2974namp_"

--_000_MN2PR12MB29744ED8B694F460A72835D395D70MN2PR12MB2974namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks Alex! I'll fix that.
________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, August 8, 2019 13:33
To: Yin, Tianci (Rico) <Tianci.Yin-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Xiao, Jack <Jack.Xiao@amd=
.com>; Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>; Zhang, Hawking <Hawking.Zha=
ng-5C7GfCeVMHo@public.gmane.org>; Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; Yuan, Xiaojie <Xiaojie.Yuan@am=
d.com>
Subject: Re: [PATCH 1/2] md/powerplay: re-define smu interface version for =
smu v11

The a in amd got cut off in your patch title.

Alex

On Thu, Aug 8, 2019 at 1:27 AM Tianci Yin <tianci.yin-5C7GfCeVMHo@public.gmane.org> wrote:
>
> From: tiancyin <tianci.yin-5C7GfCeVMHo@public.gmane.org>
>
> [why]
> navi14 share same defination of smu interface version with navi10,
> anyone of them update the version may break the other one's
> version checking.
>
> [how]
> create different version defination, so that they can
> update their version separately.
>
> Signed-off-by: tiancyin <tianci.yin-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if.h      |  4 +++-
>  .../gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h   |  4 +++-
>  drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h            |  5 +++++
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c               |  1 -
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c                | 16 ++++++++++=
++++++
>  drivers/gpu/drm/amd/powerplay/vega20_ppt.c               |  1 -
>  6 files changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if.h b/driver=
s/gpu/drm/amd/powerplay/inc/smu11_driver_if.h
> index 755d51f..fdc6b7a 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if.h
> @@ -27,7 +27,9 @@
>  // *** IMPORTANT ***
>  // SMU TEAM: Always increment the interface version if
>  // any structure is changed in this file
> -#define SMU11_DRIVER_IF_VERSION 0x13
> +// Be aware of that the version should be updated in
> +// smu_v11_0.h, rename is also needed.
> +// #define SMU11_DRIVER_IF_VERSION 0x13
>
>  #define PPTABLE_V20_SMU_VERSION 3
>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h b=
/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h
> index adbbfeb..6d9e79e 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h
> @@ -26,7 +26,9 @@
>  // *** IMPORTANT ***
>  // SMU TEAM: Always increment the interface version if
>  // any structure is changed in this file
> -#define SMU11_DRIVER_IF_VERSION 0x33
> +// Be aware of that the version should be updated in
> +// smu_v11_0.h, maybe rename is also needed.
> +// #define SMU11_DRIVER_IF_VERSION 0x33
>
>  #define PPTABLE_NV10_SMU_VERSION 8
>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/=
drm/amd/powerplay/inc/smu_v11_0.h
> index fcb5801..97605e9 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> @@ -25,6 +25,11 @@
>
>  #include "amdgpu_smu.h"
>
> +#define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF
> +#define SMU11_DRIVER_IF_VERSION_VG20 0x13
> +#define SMU11_DRIVER_IF_VERSION_NV10 0x33
> +#define SMU11_DRIVER_IF_VERSION_NV14 0x33
> +
>  /* MP Apertures */
>  #define MP0_Public                     0x03800000
>  #define MP0_SRAM                       0x03900000
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm=
/amd/powerplay/navi10_ppt.c
> index be88c5d..fdc7db0 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -1630,6 +1630,5 @@ void navi10_set_ppt_funcs(struct smu_context *smu)
>         struct smu_table_context *smu_table =3D &smu->smu_table;
>
>         smu->ppt_funcs =3D &navi10_ppt_funcs;
> -       smu->smc_if_version =3D SMU11_DRIVER_IF_VERSION;
>         smu_table->table_count =3D TABLE_COUNT;
>  }
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/=
amd/powerplay/smu_v11_0.c
> index c078bf4..91dfae1 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -271,6 +271,22 @@ static int smu_v11_0_check_fw_version(struct smu_con=
text *smu)
>         smu_minor =3D (smu_version >> 8) & 0xff;
>         smu_debug =3D (smu_version >> 0) & 0xff;
>
> +       switch (smu->adev->asic_type) {
> +       case CHIP_VEGA20:
> +               smu->smc_if_version =3D SMU11_DRIVER_IF_VERSION_VG20;
> +               break;
> +       case CHIP_NAVI10:
> +               smu->smc_if_version =3D SMU11_DRIVER_IF_VERSION_NV10;
> +               break;
> +       case CHIP_NAVI14:
> +               smu->smc_if_version =3D SMU11_DRIVER_IF_VERSION_NV14;
> +               break;
> +       default:
> +               pr_err("smu unsuported asic type:%d.\n",smu->adev->asic_t=
ype);
> +               smu->smc_if_version =3D SMU11_DRIVER_IF_VERSION_INV;
> +               break;
> +       }
> +
>         /*
>          * 1. if_version mismatch is not critical as our fw is designed
>          * to be backward compatible.
> diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm=
/amd/powerplay/vega20_ppt.c
> index 52c8fc9..e28c004 100644
> --- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> @@ -3173,6 +3173,5 @@ void vega20_set_ppt_funcs(struct smu_context *smu)
>         struct smu_table_context *smu_table =3D &smu->smu_table;
>
>         smu->ppt_funcs =3D &vega20_ppt_funcs;
> -       smu->smc_if_version =3D SMU11_DRIVER_IF_VERSION;
>         smu_table->table_count =3D TABLE_COUNT;
>  }
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB29744ED8B694F460A72835D395D70MN2PR12MB2974namp_
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
Thanks Alex! I'll fix that.<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, August 8, 2019 13:33<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;; Xiao, Jack &=
lt;Jack.Xiao-5C7GfCeVMHo@public.gmane.org&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;; Zh=
ang, Hawking &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;; Quan, Evan &lt;Evan.Quan-urvtwAKJhsc@public.gmane.org=
m&gt;; Yuan, Xiaojie &lt;Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] md/powerplay: re-define smu interface versi=
on for smu v11</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The a in amd got cut off in your patch title.<br>
<br>
Alex<br>
<br>
On Thu, Aug 8, 2019 at 1:27 AM Tianci Yin &lt;tianci.yin-5C7GfCeVMHo@public.gmane.org&gt; wrote:=
<br>
&gt;<br>
&gt; From: tiancyin &lt;tianci.yin-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;<br>
&gt; [why]<br>
&gt; navi14 share same defination of smu interface version with navi10,<br>
&gt; anyone of them update the version may break the other one's<br>
&gt; version checking.<br>
&gt;<br>
&gt; [how]<br>
&gt; create different version defination, so that they can<br>
&gt; update their version separately.<br>
&gt;<br>
&gt; Signed-off-by: tiancyin &lt;tianci.yin-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if.h&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; |&nbsp; 4 &#43;&#43;&#43;-<br>
&gt;&nbsp; .../gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h&nbsp;&nbs=
p; |&nbsp; 4 &#43;&#43;&#43;-<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 5 &#43;&#43;&#43;&#=
43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/navi10_ppt.c&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 -<=
br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/smu_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 16 &#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/vega20_ppt.c&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 -<=
br>
&gt;&nbsp; 6 files changed, 27 insertions(&#43;), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if.h b/dri=
vers/gpu/drm/amd/powerplay/inc/smu11_driver_if.h<br>
&gt; index 755d51f..fdc6b7a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if.h<=
br>
&gt; @@ -27,7 &#43;27,9 @@<br>
&gt;&nbsp; // *** IMPORTANT ***<br>
&gt;&nbsp; // SMU TEAM: Always increment the interface version if<br>
&gt;&nbsp; // any structure is changed in this file<br>
&gt; -#define SMU11_DRIVER_IF_VERSION 0x13<br>
&gt; &#43;// Be aware of that the version should be updated in<br>
&gt; &#43;// smu_v11_0.h, rename is also needed.<br>
&gt; &#43;// #define SMU11_DRIVER_IF_VERSION 0x13<br>
&gt;<br>
&gt;&nbsp; #define PPTABLE_V20_SMU_VERSION 3<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.=
h b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h<br>
&gt; index adbbfeb..6d9e79e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_na=
vi10.h<br>
&gt; @@ -26,7 &#43;26,9 @@<br>
&gt;&nbsp; // *** IMPORTANT ***<br>
&gt;&nbsp; // SMU TEAM: Always increment the interface version if<br>
&gt;&nbsp; // any structure is changed in this file<br>
&gt; -#define SMU11_DRIVER_IF_VERSION 0x33<br>
&gt; &#43;// Be aware of that the version should be updated in<br>
&gt; &#43;// smu_v11_0.h, maybe rename is also needed.<br>
&gt; &#43;// #define SMU11_DRIVER_IF_VERSION 0x33<br>
&gt;<br>
&gt;&nbsp; #define PPTABLE_NV10_SMU_VERSION 8<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/g=
pu/drm/amd/powerplay/inc/smu_v11_0.h<br>
&gt; index fcb5801..97605e9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h<br>
&gt; @@ -25,6 &#43;25,11 @@<br>
&gt;<br>
&gt;&nbsp; #include &quot;amdgpu_smu.h&quot;<br>
&gt;<br>
&gt; &#43;#define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF<br>
&gt; &#43;#define SMU11_DRIVER_IF_VERSION_VG20 0x13<br>
&gt; &#43;#define SMU11_DRIVER_IF_VERSION_NV10 0x33<br>
&gt; &#43;#define SMU11_DRIVER_IF_VERSION_NV14 0x33<br>
&gt; &#43;<br>
&gt;&nbsp; /* MP Apertures */<br>
&gt;&nbsp; #define MP0_Public&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x03800000<br>
&gt;&nbsp; #define MP0_SRAM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x03900000<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/=
drm/amd/powerplay/navi10_ppt.c<br>
&gt; index be88c5d..fdc7db0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&gt; @@ -1630,6 &#43;1630,5 @@ void navi10_set_ppt_funcs(struct smu_context=
 *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_conte=
xt *smu_table =3D &amp;smu-&gt;smu_table;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;ppt_funcs =3D =
&amp;navi10_ppt_funcs;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smc_if_version =3D SMU11=
_DRIVER_IF_VERSION;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;table_co=
unt =3D TABLE_COUNT;<br>
&gt;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/d=
rm/amd/powerplay/smu_v11_0.c<br>
&gt; index c078bf4..91dfae1 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&gt; @@ -271,6 &#43;271,22 @@ static int smu_v11_0_check_fw_version(struct =
smu_context *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_minor =3D (smu_ver=
sion &gt;&gt; 8) &amp; 0xff;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_debug =3D (smu_ver=
sion &gt;&gt; 0) &amp; 0xff;<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (smu-&gt;adev-&gt;asi=
c_type) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA20:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; smu-&gt;smc_if_version =3D SMU11_DRIVER_IF_VERSION_VG20=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI10:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; smu-&gt;smc_if_version =3D SMU11_DRIVER_IF_VERSION_NV10=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; smu-&gt;smc_if_version =3D SMU11_DRIVER_IF_VERSION_NV14=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pr_err(&quot;smu unsuported asic type:%d.\n&quot;,smu-&=
gt;adev-&gt;asic_type);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; smu-&gt;smc_if_version =3D SMU11_DRIVER_IF_VERSION_INV;=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 1. if_version =
mismatch is not critical as our fw is designed<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to be backward=
 compatible.<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/=
drm/amd/powerplay/vega20_ppt.c<br>
&gt; index 52c8fc9..e28c004 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
&gt; @@ -3173,6 &#43;3173,5 @@ void vega20_set_ppt_funcs(struct smu_context=
 *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_conte=
xt *smu_table =3D &amp;smu-&gt;smu_table;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;ppt_funcs =3D =
&amp;vega20_ppt_funcs;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smc_if_version =3D SMU11=
_DRIVER_IF_VERSION;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;table_co=
unt =3D TABLE_COUNT;<br>
&gt;&nbsp; }<br>
&gt; --<br>
&gt; 2.7.4<br>
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

--_000_MN2PR12MB29744ED8B694F460A72835D395D70MN2PR12MB2974namp_--

--===============0790597734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0790597734==--
