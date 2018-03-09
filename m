From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Move IH clientid defs to separate file
Date: Fri, 9 Mar 2018 17:41:03 +0000
Message-ID: <BN6PR12MB1652273C2A0DA9F2405181D9F7DE0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1520551491-29948-1-git-send-email-Oak.Zeng@amd.com>
 <4107d6b6-d969-478f-6b25-b9cf693292b2@gmail.com>,
 <BN6PR12MB16513DCEDF0969EEBBE0A0CB80DE0@BN6PR12MB1651.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0243736669=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB16513DCEDF0969EEBBE0A0CB80DE0-/b2+HYfkarRSqX7PDniLCgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, Oak Zeng <zengshanjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0243736669==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652273C2A0DA9F2405181D9F7DE0BN6PR12MB1652namp_"

--_000_BN6PR12MB1652273C2A0DA9F2405181D9F7DE0BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

SOC15 refers to the SOC design we started with vega10.  It differs from pre=
vious SOC design from previous asics.  I think it was designed in ~2015, so=
 SOC15.  The soc15 name is fine with me.


Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Zeng, Oa=
k <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, March 9, 2018 9:52:06 AM
To: Koenig, Christian; Oak Zeng; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: RE: [PATCH] drm/amdgpu: Move IH clientid defs to separate file

Thanks Alex, Christian and David for the feedback.

I will:
1. keep AMDGPU_IH_CLIENTID_LEGACY in amdgpu_ih.h
2. Change other client ID's prefix to SOC15
3. Regarding the file name, I think those client ID are introduced since Ve=
ga10 and also apply for navi10. Is SOC15 the proper file name? Actually can=
 anybody explain what is SOC15? Or any suggestion for a better file name?

Thanks,
Oak


-----Original Message-----
From: Christian K=F6nig [mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
Sent: Friday, March 09, 2018 2:49 AM
To: Oak Zeng; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zeng, Oak
Subject: Re: [PATCH] drm/amdgpu: Move IH clientid defs to separate file

Am 09.03.2018 um 00:24 schrieb Oak Zeng:
> This is preparation for sharing client ID definitions between amdgpu
> and amdkfd
>
> Change-Id: Ie0b7b14c9c2366fd896745a51b74a9ba97ee3224
> Signed-off-by: Oak Zeng <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h          | 44 +--------------
>   drivers/gpu/drm/amd/include/soc15_ih_clientid.h | 72 ++++++++++++++++++=
+++++++
>   2 files changed, 73 insertions(+), 43 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/include/soc15_ih_clientid.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> index b8a7dba..62a9869 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> @@ -25,51 +25,9 @@
>   #define __AMDGPU_IH_H__
>
>   #include <linux/chash.h>
> +#include "soc15_ih_clientid.h"
>
>   struct amdgpu_device;
> - /*
> -  * vega10+ IH clients
> - */
> -enum amdgpu_ih_clientid
> -{
> -    AMDGPU_IH_CLIENTID_IH        =3D 0x00,
> -    AMDGPU_IH_CLIENTID_ACP       =3D 0x01,
> -    AMDGPU_IH_CLIENTID_ATHUB     =3D 0x02,
> -    AMDGPU_IH_CLIENTID_BIF       =3D 0x03,
> -    AMDGPU_IH_CLIENTID_DCE       =3D 0x04,
> -    AMDGPU_IH_CLIENTID_ISP       =3D 0x05,
> -    AMDGPU_IH_CLIENTID_PCIE0     =3D 0x06,
> -    AMDGPU_IH_CLIENTID_RLC       =3D 0x07,
> -    AMDGPU_IH_CLIENTID_SDMA0     =3D 0x08,
> -    AMDGPU_IH_CLIENTID_SDMA1     =3D 0x09,
> -    AMDGPU_IH_CLIENTID_SE0SH     =3D 0x0a,
> -    AMDGPU_IH_CLIENTID_SE1SH     =3D 0x0b,
> -    AMDGPU_IH_CLIENTID_SE2SH     =3D 0x0c,
> -    AMDGPU_IH_CLIENTID_SE3SH     =3D 0x0d,
> -    AMDGPU_IH_CLIENTID_SYSHUB            =3D 0x0e,
> -    AMDGPU_IH_CLIENTID_THM       =3D 0x0f,
> -    AMDGPU_IH_CLIENTID_UVD       =3D 0x10,
> -    AMDGPU_IH_CLIENTID_VCE0      =3D 0x11,
> -    AMDGPU_IH_CLIENTID_VMC       =3D 0x12,
> -    AMDGPU_IH_CLIENTID_XDMA      =3D 0x13,
> -    AMDGPU_IH_CLIENTID_GRBM_CP           =3D 0x14,
> -    AMDGPU_IH_CLIENTID_ATS       =3D 0x15,
> -    AMDGPU_IH_CLIENTID_ROM_SMUIO    =3D 0x16,
> -    AMDGPU_IH_CLIENTID_DF        =3D 0x17,
> -    AMDGPU_IH_CLIENTID_VCE1      =3D 0x18,
> -    AMDGPU_IH_CLIENTID_PWR       =3D 0x19,
> -    AMDGPU_IH_CLIENTID_UTCL2     =3D 0x1b,
> -    AMDGPU_IH_CLIENTID_EA        =3D 0x1c,
> -    AMDGPU_IH_CLIENTID_UTCL2LOG          =3D 0x1d,
> -    AMDGPU_IH_CLIENTID_MP0       =3D 0x1e,
> -    AMDGPU_IH_CLIENTID_MP1       =3D 0x1f,
> -
> -    AMDGPU_IH_CLIENTID_MAX,
> -
> -    AMDGPU_IH_CLIENTID_VCN       =3D AMDGPU_IH_CLIENTID_UVD
> -};
> -
> -#define AMDGPU_IH_CLIENTID_LEGACY 0
>
>   #define AMDGPU_PAGEFAULT_HASH_BITS 8
>   struct amdgpu_retryfault_hashtable { diff --git
> a/drivers/gpu/drm/amd/include/soc15_ih_clientid.h
> b/drivers/gpu/drm/amd/include/soc15_ih_clientid.h
> new file mode 100644
> index 0000000..e2e8c63
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/include/soc15_ih_clientid.h
> @@ -0,0 +1,72 @@
> +/*
> + * Copyright 2018 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person
> +obtaining a
> + * copy of this software and associated documentation files (the
> +"Software"),
> + * to deal in the Software without restriction, including without
> +limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> +sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom
> +the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> +included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> +EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> +SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> +DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> +OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> +OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __SOC15_IH_CLIENTID_H__
> +#define __SOC15_IH_CLIENTID_H__
> +
> + /*
> +  * vega10+ IH clients
> + */
> +enum amdgpu_ih_clientid {
> +     AMDGPU_IH_CLIENTID_IH           =3D 0x00,
> +     AMDGPU_IH_CLIENTID_ACP          =3D 0x01,
> +     AMDGPU_IH_CLIENTID_ATHUB        =3D 0x02,
> +     AMDGPU_IH_CLIENTID_BIF          =3D 0x03,
> +     AMDGPU_IH_CLIENTID_DCE          =3D 0x04,
> +     AMDGPU_IH_CLIENTID_ISP          =3D 0x05,
> +     AMDGPU_IH_CLIENTID_PCIE0        =3D 0x06,
> +     AMDGPU_IH_CLIENTID_RLC          =3D 0x07,
> +     AMDGPU_IH_CLIENTID_SDMA0        =3D 0x08,
> +     AMDGPU_IH_CLIENTID_SDMA1        =3D 0x09,
> +     AMDGPU_IH_CLIENTID_SE0SH        =3D 0x0a,
> +     AMDGPU_IH_CLIENTID_SE1SH        =3D 0x0b,
> +     AMDGPU_IH_CLIENTID_SE2SH        =3D 0x0c,
> +     AMDGPU_IH_CLIENTID_SE3SH        =3D 0x0d,
> +     AMDGPU_IH_CLIENTID_SYSHUB       =3D 0x0e,
> +     AMDGPU_IH_CLIENTID_THM          =3D 0x0f,
> +     AMDGPU_IH_CLIENTID_UVD          =3D 0x10,
> +     AMDGPU_IH_CLIENTID_VCE0         =3D 0x11,
> +     AMDGPU_IH_CLIENTID_VMC          =3D 0x12,
> +     AMDGPU_IH_CLIENTID_XDMA         =3D 0x13,
> +     AMDGPU_IH_CLIENTID_GRBM_CP      =3D 0x14,
> +     AMDGPU_IH_CLIENTID_ATS          =3D 0x15,
> +     AMDGPU_IH_CLIENTID_ROM_SMUIO    =3D 0x16,
> +     AMDGPU_IH_CLIENTID_DF           =3D 0x17,
> +     AMDGPU_IH_CLIENTID_VCE1         =3D 0x18,
> +     AMDGPU_IH_CLIENTID_PWR          =3D 0x19,
> +     AMDGPU_IH_CLIENTID_UTCL2        =3D 0x1b,
> +     AMDGPU_IH_CLIENTID_EA           =3D 0x1c,
> +     AMDGPU_IH_CLIENTID_UTCL2LOG     =3D 0x1d,
> +     AMDGPU_IH_CLIENTID_MP0          =3D 0x1e,
> +     AMDGPU_IH_CLIENTID_MP1          =3D 0x1f,
> +
> +     AMDGPU_IH_CLIENTID_MAX,
> +
> +     AMDGPU_IH_CLIENTID_VCN          =3D AMDGPU_IH_CLIENTID_UVD
> +};
> +
> +#define AMDGPU_IH_CLIENTID_LEGACY 0

Please keep AMDGPU_IH_CLIENTID_LEGACY in amdgpu_ih.h, since that isn't rela=
ted to SOC15 in any way.

Additional to that the other client IDs could use a new prefix if you move =
them around, but that isn't mandatory.

Christian.

> +
> +#endif
> +
> +

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1652273C2A0DA9F2405181D9F7DE0BN6PR12MB1652namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">SOC15 refers to the SOC design we=
 started with vega10.&nbsp; It differs from previous SOC design from previo=
us asics.&nbsp; I think it was designed in ~2015, so SOC15.&nbsp; The soc15=
 name is fine with me.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Zeng, Oak &lt;Oak.Zeng-urvtwAKJhsc@public.gmane.org=
m&gt;<br>
<b>Sent:</b> Friday, March 9, 2018 9:52:06 AM<br>
<b>To:</b> Koenig, Christian; Oak Zeng; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Move IH clientid defs to separate f=
ile</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Thanks Alex, Christian and David for the feedback.=
<br>
<br>
I will: <br>
1. keep AMDGPU_IH_CLIENTID_LEGACY in amdgpu_ih.h<br>
2. Change other client ID's prefix to SOC15<br>
3. Regarding the file name, I think those client ID are introduced since Ve=
ga10 and also apply for navi10. Is SOC15 the proper file name? Actually can=
 anybody explain what is SOC15? Or any suggestion for a better file name?<b=
r>
<br>
Thanks,<br>
Oak<br>
<br>
<br>
-----Original Message-----<br>
From: Christian K=F6nig [<a href=3D"mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
">mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>]
<br>
Sent: Friday, March 09, 2018 2:49 AM<br>
To: Oak Zeng; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
Cc: Zeng, Oak<br>
Subject: Re: [PATCH] drm/amdgpu: Move IH clientid defs to separate file<br>
<br>
Am 09.03.2018 um 00:24 schrieb Oak Zeng:<br>
&gt; This is preparation for sharing client ID definitions between amdgpu <=
br>
&gt; and amdkfd<br>
&gt;<br>
&gt; Change-Id: Ie0b7b14c9c2366fd896745a51b74a9ba97ee3224<br>
&gt; Signed-off-by: Oak Zeng &lt;Oak.Zeng-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 44 &#43;--------------<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/include/soc15_ih_clientid.h | 72 &#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; 2 files changed, 73 insertions(&#43;), 43 deletions(-)<br>
&gt;&nbsp;&nbsp; create mode 100644 drivers/gpu/drm/amd/include/soc15_ih_cl=
ientid.h<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h<br>
&gt; index b8a7dba..62a9869 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h<br>
&gt; @@ -25,51 &#43;25,9 @@<br>
&gt;&nbsp;&nbsp; #define __AMDGPU_IH_H__<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #include &lt;linux/chash.h&gt;<br>
&gt; &#43;#include &quot;soc15_ih_clientid.h&quot;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; struct amdgpu_device;<br>
&gt; - /*<br>
&gt; -&nbsp; * vega10&#43; IH clients<br>
&gt; - */<br>
&gt; -enum amdgpu_ih_clientid<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_IH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =3D 0x00,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_ACP&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D 0x01,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_ATHUB&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0x02,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_BIF&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D 0x03,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_DCE&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D 0x04,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_ISP&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D 0x05,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_PCIE0&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0x06,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_RLC&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D 0x07,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_SDMA0&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0x08,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_SDMA1&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0x09,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_SE0SH&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0x0a,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_SE1SH&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0x0b,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_SE2SH&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0x0c,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_SE3SH&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0x0d,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_SYSHUB&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x0e,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_THM&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D 0x0f,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_UVD&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D 0x10,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_VCE0&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =3D 0x11,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_VMC&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D 0x12,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_XDMA&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =3D 0x13,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_GRBM_CP&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x14,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_ATS&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D 0x15,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_ROM_SMUIO&nbsp;&nbsp;&nbsp; =3D=
 0x16,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_DF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =3D 0x17,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_VCE1&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =3D 0x18,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_PWR&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D 0x19,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_UTCL2&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0x1b,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_EA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =3D 0x1c,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_UTCL2LOG&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x1d,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_MP0&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D 0x1e,<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_MP1&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D 0x1f,<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_MAX,<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_VCN&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; =3D AMDGPU_IH_CLIENTID_UVD<br>
&gt; -};<br>
&gt; -<br>
&gt; -#define AMDGPU_IH_CLIENTID_LEGACY 0<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #define AMDGPU_PAGEFAULT_HASH_BITS 8<br>
&gt;&nbsp;&nbsp; struct amdgpu_retryfault_hashtable { diff --git <br>
&gt; a/drivers/gpu/drm/amd/include/soc15_ih_clientid.h <br>
&gt; b/drivers/gpu/drm/amd/include/soc15_ih_clientid.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000..e2e8c63<br>
&gt; --- /dev/null<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/include/soc15_ih_clientid.h<br>
&gt; @@ -0,0 &#43;1,72 @@<br>
&gt; &#43;/*<br>
&gt; &#43; * Copyright 2018 Advanced Micro Devices, Inc.<br>
&gt; &#43; *<br>
&gt; &#43; * Permission is hereby granted, free of charge, to any person <b=
r>
&gt; &#43;obtaining a<br>
&gt; &#43; * copy of this software and associated documentation files (the =
<br>
&gt; &#43;&quot;Software&quot;),<br>
&gt; &#43; * to deal in the Software without restriction, including without=
 <br>
&gt; &#43;limitation<br>
&gt; &#43; * the rights to use, copy, modify, merge, publish, distribute, <=
br>
&gt; &#43;sublicense,<br>
&gt; &#43; * and/or sell copies of the Software, and to permit persons to w=
hom <br>
&gt; &#43;the<br>
&gt; &#43; * Software is furnished to do so, subject to the following condi=
tions:<br>
&gt; &#43; *<br>
&gt; &#43; * The above copyright notice and this permission notice shall be=
 <br>
&gt; &#43;included in<br>
&gt; &#43; * all copies or substantial portions of the Software.<br>
&gt; &#43; *<br>
&gt; &#43; * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY O=
F ANY KIND, <br>
&gt; &#43;EXPRESS OR<br>
&gt; &#43; * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF <br>
&gt; &#43;MERCHANTABILITY,<br>
&gt; &#43; * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN=
 NO EVENT <br>
&gt; &#43;SHALL<br>
&gt; &#43; * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, =
<br>
&gt; &#43;DAMAGES OR<br>
&gt; &#43; * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR <br=
>
&gt; &#43;OTHERWISE,<br>
&gt; &#43; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE=
 USE <br>
&gt; &#43;OR<br>
&gt; &#43; * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; &#43; *<br>
&gt; &#43; */<br>
&gt; &#43;<br>
&gt; &#43;#ifndef __SOC15_IH_CLIENTID_H__<br>
&gt; &#43;#define __SOC15_IH_CLIENTID_H__<br>
&gt; &#43;<br>
&gt; &#43; /*<br>
&gt; &#43;&nbsp; * vega10&#43; IH clients<br>
&gt; &#43; */<br>
&gt; &#43;enum amdgpu_ih_clientid {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_IH&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x00,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_ACP&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x01,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_ATHUB&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x02,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_BIF&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x03,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_DCE&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x04,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_ISP&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x05,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_PCIE0&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x06,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_RLC&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x07,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_SDMA0&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x08,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_SDMA1&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x09,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_SE0SH&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x0a,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_SE1SH&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x0b,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_SE2SH&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x0c,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_SE3SH&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x0d,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_SYSHUB&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; =3D 0x0e,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_THM&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x0f,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_UVD&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x10,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_VCE0&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x11,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_VMC&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x12,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_XDMA&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x13,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_GRBM_CP&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; =3D 0x14,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_ATS&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x15,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_ROM_SMUIO&nbsp;&nbsp;=
&nbsp; =3D 0x16,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_DF&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x17,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_VCE1&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x18,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_PWR&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x19,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_UTCL2&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x1b,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_EA&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x1c,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_UTCL2LOG&nbsp;&nbsp;&=
nbsp;&nbsp; =3D 0x1d,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_MP0&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x1e,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_MP1&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x1f,<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_MAX,<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_IH_CLIENTID_VCN&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D AMDGPU_IH_CLIENTID_UVD<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;#define AMDGPU_IH_CLIENTID_LEGACY 0<br>
<br>
Please keep AMDGPU_IH_CLIENTID_LEGACY in amdgpu_ih.h, since that isn't rela=
ted to SOC15 in any way.<br>
<br>
Additional to that the other client IDs could use a new prefix if you move =
them around, but that isn't mandatory.<br>
<br>
Christian.<br>
<br>
&gt; &#43;<br>
&gt; &#43;#endif<br>
&gt; &#43;<br>
&gt; &#43;<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1652273C2A0DA9F2405181D9F7DE0BN6PR12MB1652namp_--

--===============0243736669==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0243736669==--
