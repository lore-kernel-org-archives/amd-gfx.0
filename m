From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/7] drm/amdgpu: Doorbell index initialization for ASICs
 before vega10
Date: Mon, 26 Nov 2018 18:05:11 +0000
Message-ID: <BN6PR12MB180984ED83658483DE627A2FF7D70@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1542837620-13571-1-git-send-email-ozeng@amd.com>
 <1542837620-13571-4-git-send-email-ozeng@amd.com>
 <CADnq5_P=pN349ch33MSWNTM3QcXJtcnFiq=FP5wQT7SijDVRZQ@mail.gmail.com>
 <CADnq5_OUGOecJAvQiCEcdBsk9DmjZkd-yd6aEyGvPMc1+4MsXg@mail.gmail.com>,
 <BN6PR12MB165126A9513105183F63194880D70@BN6PR12MB1651.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0902515125=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB165126A9513105183F63194880D70-/b2+HYfkarRSqX7PDniLCgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0902515125==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180984ED83658483DE627A2FF7D70BN6PR12MB1809namp_"

--_000_BN6PR12MB180984ED83658483DE627A2FF7D70BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Correct.  SI does not use doorbells.


Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Zeng, Oa=
k <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, November 26, 2018 12:20:10 PM
To: Alex Deucher
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: RE: [PATCH 4/7] drm/amdgpu: Doorbell index initialization for ASIC=
s before vega10

Ok, I can change it legacy_doorbell_index_init(). I will keep this function=
 in vi.c. The reason I don't want to put it in cik.c is cik.c is only compi=
led optionally.

Another thing I want to know is, my understanding is si doesn't use doorbel=
l, does it?

thanks,
Oak

-----Original Message-----
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Sunday, November 25, 2018 1:46 PM
To: Zeng, Oak <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
Subject: Fwd: [PATCH 4/7] drm/amdgpu: Doorbell index initialization for ASI=
Cs before vega10

---------- Forwarded message ---------
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, Nov 21, 2018 at 5:40 PM
Subject: Re: [PATCH 4/7] drm/amdgpu: Doorbell index initialization for ASIC=
s before vega10
To: <ozeng-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Oak Zeng <Oak.Zeng-urvtwAKJhsc@public.gmane.org=
m>


On Wed, Nov 21, 2018 at 5:00 PM Oak Zeng <ozeng-5C7GfCeVMHo@public.gmane.org> wrote:
>
> v2: Use enum definition instead of hardcoded number
>
> Change-Id: Id64eb98f5b1c24b51eb2fd5a083086fc3515813d
> Signed-off-by: Oak Zeng <ozeng-5C7GfCeVMHo@public.gmane.org>
> Suggested-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
> Suggested-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

Since this covers cik and vi, maybe call it cik_doorbell_index_init() or le=
gacy_doorbell_index_init()?

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile      |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vi.h          |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vi_reg_init.c | 43
> ++++++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+), 2 deletions(-)  create mode 100644
> drivers/gpu/drm/amd/amdgpu/vi_reg_init.c
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
> b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 1cef9e1..ae29bf5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -63,7 +63,7 @@ amdgpu-$(CONFIG_DRM_AMDGPU_SI)+=3D si.o gmc_v6_0.o
> gfx_v6_0.o si_ih.o si_dma.o dce
>
>  amdgpu-y +=3D \
>         vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_=
0.o vega10_reg_init.o \
> -       vega20_reg_init.o nbio_v7_4.o vega12_reg_init.o
> +       vega20_reg_init.o nbio_v7_4.o vega12_reg_init.o vi_reg_init.o
>
>  # add DF block
>  amdgpu-y +=3D \
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.h
> b/drivers/gpu/drm/amd/amdgpu/vi.h index 0429fe3..abcb52e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.h
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.h
> @@ -29,5 +29,5 @@
>  void vi_srbm_select(struct amdgpu_device *adev,
>                     u32 me, u32 pipe, u32 queue, u32 vmid);  int
> vi_set_ip_blocks(struct amdgpu_device *adev);
> -
> +void vi_doorbell_index_init(struct amdgpu_device *adev);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi_reg_init.c
> b/drivers/gpu/drm/amd/amdgpu/vi_reg_init.c
> new file mode 100644
> index 0000000..cdeb88d
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/vi_reg_init.c
> @@ -0,0 +1,43 @@
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
> +#include "amdgpu.h"
> +
> +void vi_doorbell_index_init(struct amdgpu_device *adev) {
> +       adev->doorbell_index.kiq =3D AMDGPU_DOORBELL_KIQ;
> +       adev->doorbell_index.mec_ring0 =3D AMDGPU_DOORBELL_MEC_RING0;
> +       adev->doorbell_index.mec_ring1 =3D AMDGPU_DOORBELL_MEC_RING1;
> +       adev->doorbell_index.mec_ring2 =3D AMDGPU_DOORBELL_MEC_RING2;
> +       adev->doorbell_index.mec_ring3 =3D AMDGPU_DOORBELL_MEC_RING3;
> +       adev->doorbell_index.mec_ring4 =3D AMDGPU_DOORBELL_MEC_RING4;
> +       adev->doorbell_index.mec_ring5 =3D AMDGPU_DOORBELL_MEC_RING5;
> +       adev->doorbell_index.mec_ring6 =3D AMDGPU_DOORBELL_MEC_RING6;
> +       adev->doorbell_index.mec_ring7 =3D AMDGPU_DOORBELL_MEC_RING7;
> +       adev->doorbell_index.gfx_ring0 =3D AMDGPU_DOORBELL_GFX_RING0;
> +       adev->doorbell_index.sdma_engine0 =3D AMDGPU_DOORBELL_sDMA_ENGINE=
0;
> +       adev->doorbell_index.sdma_engine1 =3D AMDGPU_DOORBELL_sDMA_ENGINE=
1;
> +       adev->doorbell_index.ih =3D AMDGPU_DOORBELL_IH;
> +       adev->doorbell_index.max_assignment =3D
> +AMDGPU_DOORBELL_MAX_ASSIGNMENT; }
> +
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180984ED83658483DE627A2FF7D70BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Correct.&nbsp; SI does not use do=
orbells.</p>
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
<b>Sent:</b> Monday, November 26, 2018 12:20:10 PM<br>
<b>To:</b> Alex Deucher<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> RE: [PATCH 4/7] drm/amdgpu: Doorbell index initialization f=
or ASICs before vega10</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Ok, I can change it legacy_doorbell_index_init(). =
I will keep this function in vi.c. The reason I don't want to put it in cik=
.c is cik.c is only compiled optionally.
<br>
<br>
Another thing I want to know is, my understanding is si doesn't use doorbel=
l, does it?<br>
<br>
thanks,<br>
Oak<br>
<br>
-----Original Message-----<br>
From: Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt; <br>
Sent: Sunday, November 25, 2018 1:46 PM<br>
To: Zeng, Oak &lt;Oak.Zeng-5C7GfCeVMHo@public.gmane.org&gt;<br>
Subject: Fwd: [PATCH 4/7] drm/amdgpu: Doorbell index initialization for ASI=
Cs before vega10<br>
<br>
---------- Forwarded message ---------<br>
From: Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
Date: Wed, Nov 21, 2018 at 5:40 PM<br>
Subject: Re: [PATCH 4/7] drm/amdgpu: Doorbell index initialization for ASIC=
s before vega10<br>
To: &lt;ozeng-5C7GfCeVMHo@public.gmane.org&gt;<br>
Cc: amd-gfx list &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;, Oak Zeng &lt;Oak.Ze=
ng-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
<br>
On Wed, Nov 21, 2018 at 5:00 PM Oak Zeng &lt;ozeng-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt;<br>
&gt; v2: Use enum definition instead of hardcoded number<br>
&gt;<br>
&gt; Change-Id: Id64eb98f5b1c24b51eb2fd5a083086fc3515813d<br>
&gt; Signed-off-by: Oak Zeng &lt;ozeng-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Suggested-by: Felix Kuehling &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Suggested-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Since this covers cik and vi, maybe call it cik_doorbell_index_init() or le=
gacy_doorbell_index_init()?<br>
<br>
Alex<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 2 &#43;-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/vi.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 &#43;-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/vi_reg_init.c | 43 <br>
&gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;<br>
&gt;&nbsp; 3 files changed, 45 insertions(&#43;), 2 deletions(-)&nbsp; crea=
te mode 100644 <br>
&gt; drivers/gpu/drm/amd/amdgpu/vi_reg_init.c<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/Makefile<br>
&gt; index 1cef9e1..ae29bf5 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/Makefile<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/Makefile<br>
&gt; @@ -63,7 &#43;63,7 @@ amdgpu-$(CONFIG_DRM_AMDGPU_SI)&#43;=3D si.o gmc_=
v6_0.o <br>
&gt; gfx_v6_0.o si_ih.o si_dma.o dce<br>
&gt;<br>
&gt;&nbsp; amdgpu-y &#43;=3D \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vi.o mxgpu_vi.o nbio_v=
6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega20_reg_init.o nbio_v7_4.o ve=
ga12_reg_init.o<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega20_reg_init.o nbio_v7_4.=
o vega12_reg_init.o vi_reg_init.o<br>
&gt;<br>
&gt;&nbsp; # add DF block<br>
&gt;&nbsp; amdgpu-y &#43;=3D \<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vi.h <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/vi.h index 0429fe3..abcb52e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vi.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vi.h<br>
&gt; @@ -29,5 &#43;29,5 @@<br>
&gt;&nbsp; void vi_srbm_select(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 me, u32 pipe, u32 que=
ue, u32 vmid);&nbsp; int <br>
&gt; vi_set_ip_blocks(struct amdgpu_device *adev);<br>
&gt; -<br>
&gt; &#43;void vi_doorbell_index_init(struct amdgpu_device *adev);<br>
&gt;&nbsp; #endif<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vi_reg_init.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/vi_reg_init.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..cdeb88d<br>
&gt; --- /dev/null<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vi_reg_init.c<br>
&gt; @@ -0,0 &#43;1,43 @@<br>
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
&gt; &#43;#include &quot;amdgpu.h&quot;<br>
&gt; &#43;<br>
&gt; &#43;void vi_doorbell_index_init(struct amdgpu_device *adev) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.kiq =
=3D AMDGPU_DOORBELL_KIQ;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.mec_=
ring0 =3D AMDGPU_DOORBELL_MEC_RING0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.mec_=
ring1 =3D AMDGPU_DOORBELL_MEC_RING1;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.mec_=
ring2 =3D AMDGPU_DOORBELL_MEC_RING2;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.mec_=
ring3 =3D AMDGPU_DOORBELL_MEC_RING3;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.mec_=
ring4 =3D AMDGPU_DOORBELL_MEC_RING4;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.mec_=
ring5 =3D AMDGPU_DOORBELL_MEC_RING5;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.mec_=
ring6 =3D AMDGPU_DOORBELL_MEC_RING6;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.mec_=
ring7 =3D AMDGPU_DOORBELL_MEC_RING7;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.gfx_=
ring0 =3D AMDGPU_DOORBELL_GFX_RING0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.sdma=
_engine0 =3D AMDGPU_DOORBELL_sDMA_ENGINE0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.sdma=
_engine1 =3D AMDGPU_DOORBELL_sDMA_ENGINE1;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.ih =
=3D AMDGPU_DOORBELL_IH;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.max_=
assignment =3D <br>
&gt; &#43;AMDGPU_DOORBELL_MAX_ASSIGNMENT; }<br>
&gt; &#43;<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB180984ED83658483DE627A2FF7D70BN6PR12MB1809namp_--

--===============0902515125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0902515125==--
