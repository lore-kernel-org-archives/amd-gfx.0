From: "Bridgman, John" <John.Bridgman-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Add place holder for soc15 asic init on
 emulation
Date: Tue, 6 Feb 2018 22:02:03 +0000
Message-ID: <BN6PR12MB13485AFD9FE75C268018E82BE8FD0@BN6PR12MB1348.namprd12.prod.outlook.com>
References: <1517953287-22026-1-git-send-email-Shaoyun.Liu@amd.com>
 <CADnq5_PFej=MAbD-ZOoqHwiNk82A+qg304_5c7rXHOLJS9He+A@mail.gmail.com>,
 <DM5PR12MB117937BE7328E6634A4DA6B1F4FD0@DM5PR12MB1179.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1158181485=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB117937BE7328E6634A4DA6B1F4FD0-2J9CzHegvk8p/eksZXEfgQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Content-Language: en-CA
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
To: "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1158181485==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB13485AFD9FE75C268018E82BE8FD0BN6PR12MB1348namp_"

--_000_BN6PR12MB13485AFD9FE75C268018E82BE8FD0BN6PR12MB1348namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Yes, I made that suggestion in order to make it easy for us to replace the =
massive function we use in emulation with a stub function for upstream. I f=
igured if we had that function in a separate file it would be cleaner, but =
maybe that is not the case.


I was thinking that we could replace the upstream stub file with an NPI-spe=
cific file for most of our emulator work, then go back to the stub file onc=
e VBIOS was enabled and we no longer needed the SOC init sequence from HW.


I guess from a CM perspective it doesn't make a lot of difference whether w=
e add 20,000 lines to a file and delete them later or replace a short file =
with a 20,000 line file and then replace it again later... so maybe we don'=
t need to move the function out after all.


________________________________
From: Liu, Shaoyun
Sent: February 6, 2018 4:55 PM
To: Alex Deucher; Bridgman, John
Cc: amd-gfx list
Subject: RE: [PATCH] drm/amdgpu: Add place holder for soc15 asic init on em=
ulation

Ye, I  try to put  the asic specific  register sequences for emulation in a=
 separate emu_soc.c file, I think it's suggested by John or you ?  The asic=
 specific code will  be  keep in separate bring up branch , but a common pl=
ace to add them  seems  not bad to me .

Shaoyun.liu

-----Original Message-----
From: Alex Deucher [mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
Sent: Tuesday, February 06, 2018 4:46 PM
To: Liu, Shaoyun
Cc: amd-gfx list
Subject: Re: [PATCH] drm/amdgpu: Add place holder for soc15 asic init on em=
ulation

On Tue, Feb 6, 2018 at 4:41 PM, Shaoyun Liu <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org> wrote:
> Change-Id: I6ff04e1199d1ebdbdb31d0e7e8ca3c240c61ab3a
> Signed-off-by: Shaoyun Liu <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>

What is the purpose of this?  If it's just as a hint the the driver writer =
as to where to add the emulation register sequences from the IP teams, I do=
n't see much value in it.  Just add a comment.

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile  |  2 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu.h  |  2 ++
> drivers/gpu/drm/amd/amdgpu/emu_soc.c | 33 +++++++++++++++++++++++++++++++=
++
>  drivers/gpu/drm/amd/amdgpu/soc15.c   |  4 ++++
>  4 files changed, 40 insertions(+), 1 deletion(-)  create mode 100644
> drivers/gpu/drm/amd/amdgpu/emu_soc.c
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
> b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 1f6d43e..6f5db5e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -41,7 +41,7 @@ amdgpu-$(CONFIG_DRM_AMDGPU_CIK)+=3D cik.o cik_ih.o
> kv_smc.o kv_dpm.o \  amdgpu-$(CONFIG_DRM_AMDGPU_SI)+=3D si.o gmc_v6_0.o
> gfx_v6_0.o si_ih.o si_dma.o dce_v6_0.o si_dpm.o si_smc.o
>
>  amdgpu-y +=3D \
> -       vi.o mxgpu_vi.o nbio_v6_1.o soc15.o mxgpu_ai.o nbio_v7_0.o vega10=
_reg_init.o vega20_reg_init.o nbio_v7_4.o
> +       vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o
> + nbio_v7_0.o vega10_reg_init.o vega20_reg_init.o nbio_v7_4.o
>
>  # add GMC block
>  amdgpu-y +=3D \
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index d417cfb..13aa8a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1740,6 +1740,8 @@ void amdgpu_mm_wreg(struct amdgpu_device *adev,
> uint32_t reg, uint32_t v,  bool amdgpu_device_asic_has_dc_support(enum
> amd_asic_type asic_type);  bool amdgpu_device_has_dc_support(struct
> amdgpu_device *adev);
>
> +int emu_soc_asic_init(struct amdgpu_device *adev);
> +
>  /*
>   * Registers read & write functions.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/emu_soc.c
> b/drivers/gpu/drm/amd/amdgpu/emu_soc.c
> new file mode 100644
> index 0000000..d72c25c
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/emu_soc.c
> @@ -0,0 +1,33 @@
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


Is there an expectation that MAM block features will become available under=
 virtualization at some point in the future, eg Navi10 ?

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
> +#include "amdgpu.h"
> +#include "soc15.h"
> +
> +#include "soc15_common.h"
> +#include "soc15_hw_ip.h"
> +
> +int emu_soc_asic_init(struct amdgpu_device *adev) {
> +       return 0;
> +}
> +
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 22cd84f..6a3d108 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -747,6 +747,10 @@ static int soc15_common_hw_init(void *handle)  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>
> +       /* Add asic specific init sequence for emulation */
> +       if (amdgpu_emu_mode =3D=3D 1)
> +               emu_soc_asic_init(adev);
> +
>         /* enable pcie gen2/3 link */
>         soc15_pcie_gen3_enable(adev);
>         /* enable aspm */
> --
> 1.9.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB13485AFD9FE75C268018E82BE8FD0BN6PR12MB1348namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Yes, I made that suggestion in or=
der to make it easy for us to replace the massive function we use in emulat=
ion with a stub function for upstream. I figured if we had that function in=
 a separate file it would be cleaner,
 but maybe that is not the case. <br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">I was thinking that we could repl=
ace the upstream stub file with an NPI-specific file for most of our emulat=
or work, then go back to the stub file once VBIOS was enabled and we no lon=
ger needed the SOC init sequence from
 HW.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">I guess from a CM perspective it =
doesn't make a lot of difference whether we add 20,000 lines to a file and =
delete them later or replace a short file with a 20,000 line file and then =
replace it again later... so maybe
 we don't need to move the function out after all.<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> Liu, Shaoyun<br>
<b>Sent:</b> February 6, 2018 4:55 PM<br>
<b>To:</b> Alex Deucher; Bridgman, John<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Add place holder for soc15 asic ini=
t on emulation</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Ye, I&nbsp; try to put&nbsp; the asic specific&nbs=
p; register sequences for emulation in a separate emu_soc.c file, I think i=
t's suggested by John or you ?&nbsp; The asic specific code will&nbsp; be&n=
bsp; keep in separate bring up branch , but a common place to add
 them&nbsp; seems&nbsp; not bad to me . <br>
<br>
Shaoyun.liu<br>
<br>
-----Original Message-----<br>
From: Alex Deucher [<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">mailto:alexdeu=
cher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>]
<br>
Sent: Tuesday, February 06, 2018 4:46 PM<br>
To: Liu, Shaoyun<br>
Cc: amd-gfx list<br>
Subject: Re: [PATCH] drm/amdgpu: Add place holder for soc15 asic init on em=
ulation<br>
<br>
On Tue, Feb 6, 2018 at 4:41 PM, Shaoyun Liu &lt;Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org&gt; wro=
te:<br>
&gt; Change-Id: I6ff04e1199d1ebdbdb31d0e7e8ca3c240c61ab3a<br>
&gt; Signed-off-by: Shaoyun Liu &lt;Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
What is the purpose of this?&nbsp; If it's just as a hint the the driver wr=
iter as to where to add the emulation register sequences from the IP teams,=
 I don't see much value in it.&nbsp; Just add a comment.<br>
<br>
Alex<br>
<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/Makefile&nbsp; |&nbsp; 2 &#43;-&nbsp;=
 <br>
&gt; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp; |&nbsp; 2 &#43;&#43;&nbsp; <=
br>
&gt; drivers/gpu/drm/amd/amdgpu/emu_soc.c | 33 &#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp; |&nbsp; 4 &#43;&#=
43;&#43;&#43;<br>
&gt;&nbsp; 4 files changed, 40 insertions(&#43;), 1 deletion(-)&nbsp; creat=
e mode 100644 <br>
&gt; drivers/gpu/drm/amd/amdgpu/emu_soc.c<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/Makefile<br>
&gt; index 1f6d43e..6f5db5e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/Makefile<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/Makefile<br>
&gt; @@ -41,7 &#43;41,7 @@ amdgpu-$(CONFIG_DRM_AMDGPU_CIK)&#43;=3D cik.o ci=
k_ih.o <br>
&gt; kv_smc.o kv_dpm.o \&nbsp; amdgpu-$(CONFIG_DRM_AMDGPU_SI)&#43;=3D si.o =
gmc_v6_0.o <br>
&gt; gfx_v6_0.o si_ih.o si_dma.o dce_v6_0.o si_dpm.o si_smc.o<br>
&gt;<br>
&gt;&nbsp; amdgpu-y &#43;=3D \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vi.o mxgpu_vi.o nbio_v6_1.o soc1=
5.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o vega20_reg_init.o nbio_v7_4.o<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vi.o mxgpu_vi.o nbio_v6_1.o =
soc15.o emu_soc.o mxgpu_ai.o <br>
&gt; &#43; nbio_v7_0.o vega10_reg_init.o vega20_reg_init.o nbio_v7_4.o<br>
&gt;<br>
&gt;&nbsp; # add GMC block<br>
&gt;&nbsp; amdgpu-y &#43;=3D \<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; index d417cfb..13aa8a8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -1740,6 &#43;1740,8 @@ void amdgpu_mm_wreg(struct amdgpu_device *ad=
ev, <br>
&gt; uint32_t reg, uint32_t v,&nbsp; bool amdgpu_device_asic_has_dc_support=
(enum <br>
&gt; amd_asic_type asic_type);&nbsp; bool amdgpu_device_has_dc_support(stru=
ct <br>
&gt; amdgpu_device *adev);<br>
&gt;<br>
&gt; &#43;int emu_soc_asic_init(struct amdgpu_device *adev);<br>
&gt; &#43;<br>
&gt;&nbsp; /*<br>
&gt;&nbsp;&nbsp; * Registers read &amp; write functions.<br>
&gt;&nbsp;&nbsp; */<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/emu_soc.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/emu_soc.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..d72c25c<br>
&gt; --- /dev/null<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/emu_soc.c<br>
&gt; @@ -0,0 &#43;1,33 @@<br>
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
&gt; &#43; * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
<div>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
Is there an expectation that MAM block features will become available under=
 virtualization at some point in the future, eg Navi10 ?
</div>
<br>
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
&gt; &#43;#include &quot;amdgpu.h&quot;<br>
&gt; &#43;#include &quot;soc15.h&quot;<br>
&gt; &#43;<br>
&gt; &#43;#include &quot;soc15_common.h&quot;<br>
&gt; &#43;#include &quot;soc15_hw_ip.h&quot;<br>
&gt; &#43;<br>
&gt; &#43;int emu_soc_asic_init(struct amdgpu_device *adev) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; index 22cd84f..6a3d108 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; @@ -747,6 &#43;747,10 @@ static int soc15_common_hw_init(void *handle)=
&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *=
adev =3D (struct amdgpu_device *)handle;<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add asic specific init se=
quence for emulation */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_emu_mode =3D=3D 1=
)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; emu_soc_asic_init(adev);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable pcie gen2/3 =
link */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc15_pcie_gen3_enable=
(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable aspm */<br>
&gt; --<br>
&gt; 1.9.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB13485AFD9FE75C268018E82BE8FD0BN6PR12MB1348namp_--

--===============1158181485==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1158181485==--
