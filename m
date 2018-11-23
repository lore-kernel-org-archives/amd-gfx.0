From: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 7/7] drm/amdgpu: Use new doorbell layout for vega20 and
 future asic
Date: Fri, 23 Nov 2018 19:38:15 +0000
Message-ID: <BN6PR12MB165194EF202C47EE0C8487BE80D40@BN6PR12MB1651.namprd12.prod.outlook.com>
References: <1542815518-8124-1-git-send-email-ozeng@amd.com>
 <1542815518-8124-7-git-send-email-ozeng@amd.com>
 <CADnq5_M6+jQpJGF0wscUP917QWbDSwCQTF4TYMTtTXp2vsKXEQ@mail.gmail.com>
 <BN6PR12MB1651198C70B58BE69A44EBFF80DA0@BN6PR12MB1651.namprd12.prod.outlook.com>
 <CADnq5_Omgd=yLKuqpb8-ZsrBJdjkEord0OL0WwVpXXcntQaB1A@mail.gmail.com>,
 <5a171836-f0bc-4edf-db9d-51746e8c9c4e@gmail.com>
 <BN6PR12MB180946F99B5AA562E542C4EBF7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0913434652=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB180946F99B5AA562E542C4EBF7D40-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0913434652==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB165194EF202C47EE0C8487BE80D40BN6PR12MB1651namp_"

--_000_BN6PR12MB165194EF202C47EE0C8487BE80D40BN6PR12MB1651namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

It is strange I didn't get your email on Wednesday. I will add one patch to=
 move all the doorbell definitions to a separate amdgpu_doorbell.h

Regards,
Oak

From: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, November 23, 2018 1:57 PM
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Zeng, Oak <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>; Koe=
nig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH 7/7] drm/amdgpu: Use new doorbell layout for vega20 and=
 future asic


The main idea is to be able to use different layouts on different asics tha=
t may share the same IP code.



Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Christian K=F6nig <ckoenig.leichtzume=
rken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
Sent: Thursday, November 22, 2018 4:26:53 AM
To: Alex Deucher; Zeng, Oak
Cc: amd-gfx list
Subject: Re: [PATCH 7/7] drm/amdgpu: Use new doorbell layout for vega20 and=
 future asic

Am 21.11.18 um 17:39 schrieb Alex Deucher:
> On Wed, Nov 21, 2018 at 11:37 AM Zeng, Oak <Oak.Zeng-5C7GfCeVMHo@public.gmane.org<mailto:Oak.Z=
eng-5C7GfCeVMHo@public.gmane.org>> wrote:
>>> No need to add a new file for this.  Just add this to vega20_reg_init.c=
.
>> Agreed.
>>
>>> Also, please use the doorbell enums rather than hardcoding the numbers.
>> Ok. Where should I put the doorbell enums for vega20? In amdgpu.h or in =
vega20_reg_init.c?
> Maybe add amdgpu_doorbell.h and move all of the enums there?

Mhm, isn't part of the goal of this work to get rid of the enums?

I mean when we have a structure to hold the indexes to we really need
the enums any more? I don't think so.

Christian.

>
> Alex
>
>> thanks,
>> Oak
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-boun=
ces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>> On Behalf Of Alex Deucher
>> Sent: Wednesday, November 21, 2018 11:22 AM
>> To: Zeng, Oak <Oak.Zeng-5C7GfCeVMHo@public.gmane.org<mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org>>
>> Cc: Zeng, Oak <Oak.Zeng-5C7GfCeVMHo@public.gmane.org<mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org>>; amd-gfx list =
<amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>
>> Subject: Re: [PATCH 7/7] drm/amdgpu: Use new doorbell layout for vega20 =
and future asic
>>
>> On Wed, Nov 21, 2018 at 10:52 AM Oak Zeng <ozeng-5C7GfCeVMHo@public.gmane.org<mailto:ozeng@am=
d.com>> wrote:
>>> Change-Id: I04d22fb717ac50483c0835f160a2e860e344f358
>>> Signed-off-by: Oak Zeng <ozeng-5C7GfCeVMHo@public.gmane.org<mailto:ozeng-5C7GfCeVMHo@public.gmane.org>>
>>> Suggested-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org<mailto:Felix.Kuehl=
ing-5C7GfCeVMHo@public.gmane.org>>
>>> Suggested-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org<mailto:alexander.=
deucher-5C7GfCeVMHo@public.gmane.org>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/Makefile                |  4 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  4 +-
>>>   drivers/gpu/drm/amd/amdgpu/soc15.h                 |  1 +
>>>   .../drm/amd/amdgpu/vega20_doorbell_index_init.c    | 64 +++++++++++++=
+++++++++
>>>   4 files changed, 70 insertions(+), 3 deletions(-)  create mode 100644
>>> drivers/gpu/drm/amd/amdgpu/vega20_doorbell_index_init.c
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
>>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> index 3ab8eba..b3b150b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> @@ -63,8 +63,8 @@ amdgpu-$(CONFIG_DRM_AMDGPU_SI)+=3D si.o gmc_v6_0.o
>>> gfx_v6_0.o si_ih.o si_dma.o dce
>>>
>>>   amdgpu-y +=3D \
>>>          vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_=
v7_0.o vega10_reg_init.o \
>>> -       vega20_reg_init.o nbio_v7_4.o vega10_doorbell_index_init.o vega=
12_doorbell_index_init.o \
>>> -       vi_doorbell_index_init.o
>>> +       vega20_reg_init.o nbio_v7_4.o vi_doorbell_index_init.o vega10_d=
oorbell_index_init.o \
>>> +       vega12_doorbell_index_init.o vega20_doorbell_index_init.o
>>>
>>>   # add DF block
>>>   amdgpu-y +=3D \
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 3ffd8f5..19f2149 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -517,8 +517,10 @@ static int amdgpu_device_doorbell_init(struct amdg=
pu_device *adev)
>>>                  vi_doorbell_index_init(adev);
>>>          else if (adev->asic_type =3D=3D CHIP_VEGA10)
>>>                  vega10_doorbell_index_init(adev);
>>> -       else
>>> +       else if (adev->asic_type =3D=3D CHIP_VEGA12 || adev->asic_type =
=3D=3D
>>> + CHIP_RAVEN)
>>>                  vega12_doorbell_index_init(adev);
>>> +       else
>>> +               vega20_doorbell_index_init(adev);
>>>
>>>          /* No doorbell on SI hardware generation */
>>>          if (adev->asic_type < CHIP_BONAIRE) { diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/soc15.h
>>> b/drivers/gpu/drm/amd/amdgpu/soc15.h
>>> index 939c0e8..6ba0d26 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
>>> @@ -60,4 +60,5 @@ int vega20_reg_base_init(struct amdgpu_device
>>> *adev);
>>>
>>>   void vega10_doorbell_index_init(struct amdgpu_device *adev);  void
>>> vega12_doorbell_index_init(struct amdgpu_device *adev);
>>> +void vega20_doorbell_index_init(struct amdgpu_device *adev);
>>>   #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_doorbell_index_init.c
>>> b/drivers/gpu/drm/amd/amdgpu/vega20_doorbell_index_init.c
>>> new file mode 100644
>>> index 0000000..dcaef7f
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_doorbell_index_init.c
>>> @@ -0,0 +1,64 @@
>>> +/*
>>> + * Copyright 2018 Advanced Micro Devices, Inc.
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person
>>> +obtaining a
>>> + * copy of this software and associated documentation files (the
>>> +"Software"),
>>> + * to deal in the Software without restriction, including without
>>> +limitation
>>> + * the rights to use, copy, modify, merge, publish, distribute,
>>> +sublicense,
>>> + * and/or sell copies of the Software, and to permit persons to whom
>>> +the
>>> + * Software is furnished to do so, subject to the following conditions=
:
>>> + *
>>> + * The above copyright notice and this permission notice shall be
>>> +included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>> +EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>>> +MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
>>> +SHALL
>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>>> +DAMAGES OR
>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>>> +OTHERWISE,
>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
>>> +OR
>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>> + *
>>> + */
>>> +
>>> +#include "amdgpu.h"
>>> +
>>> +void vega20_doorbell_index_init(struct amdgpu_device *adev) {
>>> +       /* Compute + GFX: 0~255 */
>>> +       adev->doorbell_index.kiq =3D 0x00;
>>> +       adev->doorbell_index.mec_ring0 =3D 0x03;
>>> +       adev->doorbell_index.mec_ring1 =3D 0x04;
>>> +       adev->doorbell_index.mec_ring2 =3D 0x05;
>>> +       adev->doorbell_index.mec_ring3 =3D 0x06;
>>> +       adev->doorbell_index.mec_ring4 =3D 0x07;
>>> +       adev->doorbell_index.mec_ring5 =3D 0x08;
>>> +       adev->doorbell_index.mec_ring6 =3D 0x09;
>>> +       adev->doorbell_index.mec_ring7 =3D 0x0a;
>>> +       adev->doorbell_index.userqueue_start =3D 0x0b;
>>> +       adev->doorbell_index.userqueue_end =3D 0x8a;
>>> +       adev->doorbell_index.gfx_ring0 =3D 0x8b;
>>> +       /* SDMA:256~335*/
>>> +       adev->doorbell_index.sdma_engine0 =3D 0x100;
>>> +       adev->doorbell_index.sdma_engine1 =3D 0x10a;
>>> +       adev->doorbell_index.sdma_engine2 =3D 0x114;
>>> +       adev->doorbell_index.sdma_engine3 =3D 0x11e;
>>> +       adev->doorbell_index.sdma_engine4 =3D 0x128;
>>> +       adev->doorbell_index.sdma_engine5 =3D 0x132;
>>> +       adev->doorbell_index.sdma_engine6 =3D 0x13C;
>>> +       adev->doorbell_index.sdma_engine7 =3D 0x146;
>>> +       /* IH: 376~391 */
>>> +       adev->doorbell_index.ih =3D 0x178;
>>> +       /* MMSCH: 392~407 */
>>> +       adev->doorbell_index.uvd_vce.uvd_ring0_1 =3D 0x188;
>>> +       adev->doorbell_index.uvd_vce.uvd_ring2_3 =3D 0x189;
>>> +       adev->doorbell_index.uvd_vce.uvd_ring4_5 =3D 0x18a;
>>> +       adev->doorbell_index.uvd_vce.uvd_ring6_7 =3D 0x18b;
>>> +       adev->doorbell_index.uvd_vce.vce_ring0_1 =3D 0x18c;
>>> +       adev->doorbell_index.uvd_vce.vce_ring2_3 =3D 0x18d;
>>> +       adev->doorbell_index.uvd_vce.vce_ring4_5 =3D 0x18e;
>>> +       adev->doorbell_index.uvd_vce.vce_ring6_7 =3D 0x18f;
>>> +       /* In unit of dword doorbell */
>>> +       adev->doorbell_index.max_assignment =3D 0x18f << 1; }
>> No need to add a new file for this.  Just add this to vega20_reg_init.c.=
  Also, please use the doorbell enums rather than hardcoding the numbers.
>>
>> Alex
>>
>>> +
>>> --
>>> 2.7.4
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB165194EF202C47EE0C8487BE80D40BN6PR12MB1651namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
<p class=3D"MsoNormal">Hi Alex,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">It is strange I didn&#8217;t get your email on Wedne=
sday. I will add one patch to move all the doorbell definitions to a separa=
te amdgpu_doorbell.h
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Oak<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Friday, November 23, 2018 1:57 PM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;; Zeng, Oak &lt;Oak.Ze=
ng-5C7GfCeVMHo@public.gmane.org&gt;; Koenig, Christian &lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH 7/7] drm/amdgpu: Use new doorbell layout for veg=
a20 and future asic<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-size:12.0pt;color:black">The main idea is to be able=
 to use different layouts on different asics that may share the same IP cod=
e.<o:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p><span style=3D"font-size:12.0pt;color:black">Alex<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"3" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt; on behalf o=
f Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"=
>ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Thursday, November 22, 2018 4:26:53 AM<br>
<b>To:</b> Alex Deucher; Zeng, Oak<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> Re: [PATCH 7/7] drm/amdgpu: Use new doorbell layout for veg=
a20 and future asic</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">Am 21.11.18 um 17:39 schrieb Alex Deucher:<br>
&gt; On Wed, Nov 21, 2018 at 11:37 AM Zeng, Oak &lt;<a href=3D"mailto:Oak.Z=
eng-5C7GfCeVMHo@public.gmane.org">Oak.Zeng-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;&gt; No need to add a new file for this.&nbsp; Just add this to veg=
a20_reg_init.c.<br>
&gt;&gt; Agreed.<br>
&gt;&gt;<br>
&gt;&gt;&gt; Also, please use the doorbell enums rather than hardcoding the=
 numbers.<br>
&gt;&gt; Ok. Where should I put the doorbell enums for vega20? In amdgpu.h =
or in vega20_reg_init.c?<br>
&gt; Maybe add amdgpu_doorbell.h and move all of the enums there?<br>
<br>
Mhm, isn't part of the goal of this work to get rid of the enums?<br>
<br>
I mean when we have a structure to hold the indexes to we really need <br>
the enums any more? I don't think so.<br>
<br>
Christian.<br>
<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt;&gt; thanks,<br>
&gt;&gt; Oak<br>
&gt;&gt;<br>
&gt;&gt; -----Original Message-----<br>
&gt;&gt; From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt; On Behalf Of Alex De=
ucher<br>
&gt;&gt; Sent: Wednesday, November 21, 2018 11:22 AM<br>
&gt;&gt; To: Zeng, Oak &lt;<a href=3D"mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org">Oak.Zeng@amd=
.com</a>&gt;<br>
&gt;&gt; Cc: Zeng, Oak &lt;<a href=3D"mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org">Oak.Zeng@amd=
.com</a>&gt;; amd-gfx list &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;<br>
&gt;&gt; Subject: Re: [PATCH 7/7] drm/amdgpu: Use new doorbell layout for v=
ega20 and future asic<br>
&gt;&gt;<br>
&gt;&gt; On Wed, Nov 21, 2018 at 10:52 AM Oak Zeng &lt;<a href=3D"mailto:oz=
eng-5C7GfCeVMHo@public.gmane.org">ozeng-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;&gt; Change-Id: I04d22fb717ac50483c0835f160a2e860e344f358<br>
&gt;&gt;&gt; Signed-off-by: Oak Zeng &lt;<a href=3D"mailto:ozeng-5C7GfCeVMHo@public.gmane.org">o=
zeng-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt;&gt;&gt; Suggested-by: Felix Kuehling &lt;<a href=3D"mailto:Felix.Kuehl=
ing-5C7GfCeVMHo@public.gmane.org">Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt;&gt;&gt; Suggested-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deu=
cher-5C7GfCeVMHo@public.gmane.org">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/Makefile&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 |&nbsp; 4 &#43;-<br>
&gt;&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 &#43;-<br>
&gt;&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/soc15.h&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; |&nbsp; 1 &#43;<br>
&gt;&gt;&gt;&nbsp;&nbsp; .../drm/amd/amdgpu/vega20_doorbell_index_init.c&nb=
sp;&nbsp;&nbsp; | 64 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&gt;&gt;&nbsp;&nbsp; 4 files changed, 70 insertions(&#43;), 3 deletions=
(-)&nbsp; create mode 100644<br>
&gt;&gt;&gt; drivers/gpu/drm/amd/amdgpu/vega20_doorbell_index_init.c<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile<br>
&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/Makefile<br>
&gt;&gt;&gt; index 3ab8eba..b3b150b 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/Makefile<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/Makefile<br>
&gt;&gt;&gt; @@ -63,8 &#43;63,8 @@ amdgpu-$(CONFIG_DRM_AMDGPU_SI)&#43;=3D s=
i.o gmc_v6_0.o<br>
&gt;&gt;&gt; gfx_v6_0.o si_ih.o si_dma.o dce<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp; amdgpu-y &#43;=3D \<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vi.o mxg=
pu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_ini=
t.o \<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega20_reg_init.o nbio_v=
7_4.o vega10_doorbell_index_init.o vega12_doorbell_index_init.o \<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vi_doorbell_index_init.o=
<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega20_reg_init.o nb=
io_v7_4.o vi_doorbell_index_init.o vega10_doorbell_index_init.o \<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_doorbell_inde=
x_init.o vega20_doorbell_index_init.o<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp; # add DF block<br>
&gt;&gt;&gt;&nbsp;&nbsp; amdgpu-y &#43;=3D \<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt;&gt; index 3ffd8f5..19f2149 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<b=
r>
&gt;&gt;&gt; @@ -517,8 &#43;517,10 @@ static int amdgpu_device_doorbell_ini=
t(struct amdgpu_device *adev)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vi_doorbell_index_init(adev);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if =
(adev-&gt;asic_type =3D=3D CHIP_VEGA10)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_doorbell_index_init(adev);<b=
r>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;as=
ic_type =3D=3D CHIP_VEGA12 || adev-&gt;asic_type =3D=3D<br>
&gt;&gt;&gt; &#43; CHIP_RAVEN)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_doorbell_index_init(adev);<b=
r>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; vega20_doorbell_index_init(adev);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* No do=
orbell on SI hardware generation */<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev=
-&gt;asic_type &lt; CHIP_BONAIRE) { diff --git<br>
&gt;&gt;&gt; a/drivers/gpu/drm/amd/amdgpu/soc15.h<br>
&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/soc15.h<br>
&gt;&gt;&gt; index 939c0e8..6ba0d26 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/soc15.h<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/soc15.h<br>
&gt;&gt;&gt; @@ -60,4 &#43;60,5 @@ int vega20_reg_base_init(struct amdgpu_d=
evice<br>
&gt;&gt;&gt; *adev);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp; void vega10_doorbell_index_init(struct amdgpu_devi=
ce *adev);&nbsp; void<br>
&gt;&gt;&gt; vega12_doorbell_index_init(struct amdgpu_device *adev);<br>
&gt;&gt;&gt; &#43;void vega20_doorbell_index_init(struct amdgpu_device *ade=
v);<br>
&gt;&gt;&gt;&nbsp;&nbsp; #endif<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_doorbell_index_=
init.c<br>
&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/vega20_doorbell_index_init.c<br>
&gt;&gt;&gt; new file mode 100644<br>
&gt;&gt;&gt; index 0000000..dcaef7f<br>
&gt;&gt;&gt; --- /dev/null<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vega20_doorbell_i=
ndex_init.c<br>
&gt;&gt;&gt; @@ -0,0 &#43;1,64 @@<br>
&gt;&gt;&gt; &#43;/*<br>
&gt;&gt;&gt; &#43; * Copyright 2018 Advanced Micro Devices, Inc.<br>
&gt;&gt;&gt; &#43; *<br>
&gt;&gt;&gt; &#43; * Permission is hereby granted, free of charge, to any p=
erson<br>
&gt;&gt;&gt; &#43;obtaining a<br>
&gt;&gt;&gt; &#43; * copy of this software and associated documentation fil=
es (the<br>
&gt;&gt;&gt; &#43;&quot;Software&quot;),<br>
&gt;&gt;&gt; &#43; * to deal in the Software without restriction, including=
 without<br>
&gt;&gt;&gt; &#43;limitation<br>
&gt;&gt;&gt; &#43; * the rights to use, copy, modify, merge, publish, distr=
ibute,<br>
&gt;&gt;&gt; &#43;sublicense,<br>
&gt;&gt;&gt; &#43; * and/or sell copies of the Software, and to permit pers=
ons to whom<br>
&gt;&gt;&gt; &#43;the<br>
&gt;&gt;&gt; &#43; * Software is furnished to do so, subject to the followi=
ng conditions:<br>
&gt;&gt;&gt; &#43; *<br>
&gt;&gt;&gt; &#43; * The above copyright notice and this permission notice =
shall be<br>
&gt;&gt;&gt; &#43;included in<br>
&gt;&gt;&gt; &#43; * all copies or substantial portions of the Software.<br=
>
&gt;&gt;&gt; &#43; *<br>
&gt;&gt;&gt; &#43; * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WA=
RRANTY OF ANY KIND,<br>
&gt;&gt;&gt; &#43;EXPRESS OR<br>
&gt;&gt;&gt; &#43; * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES O=
F<br>
&gt;&gt;&gt; &#43;MERCHANTABILITY,<br>
&gt;&gt;&gt; &#43; * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&=
nbsp; IN NO EVENT<br>
&gt;&gt;&gt; &#43;SHALL<br>
&gt;&gt;&gt; &#43; * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY=
 CLAIM,<br>
&gt;&gt;&gt; &#43;DAMAGES OR<br>
&gt;&gt;&gt; &#43; * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TOR=
T OR<br>
&gt;&gt;&gt; &#43;OTHERWISE,<br>
&gt;&gt;&gt; &#43; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWAR=
E OR THE USE<br>
&gt;&gt;&gt; &#43;OR<br>
&gt;&gt;&gt; &#43; * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt;&gt;&gt; &#43; *<br>
&gt;&gt;&gt; &#43; */<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;#include &quot;amdgpu.h&quot;<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;void vega20_doorbell_index_init(struct amdgpu_device *ade=
v) {<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Compute &#43; GFX=
: 0~255 */<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.kiq =3D 0x00;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.mec_ring0 =3D 0x03;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.mec_ring1 =3D 0x04;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.mec_ring2 =3D 0x05;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.mec_ring3 =3D 0x06;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.mec_ring4 =3D 0x07;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.mec_ring5 =3D 0x08;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.mec_ring6 =3D 0x09;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.mec_ring7 =3D 0x0a;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.userqueue_start =3D 0x0b;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.userqueue_end =3D 0x8a;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.gfx_ring0 =3D 0x8b;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* SDMA:256~335*/<br=
>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.sdma_engine0 =3D 0x100;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.sdma_engine1 =3D 0x10a;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.sdma_engine2 =3D 0x114;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.sdma_engine3 =3D 0x11e;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.sdma_engine4 =3D 0x128;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.sdma_engine5 =3D 0x132;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.sdma_engine6 =3D 0x13C;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.sdma_engine7 =3D 0x146;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IH: 376~391 */<br=
>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.ih =3D 0x178;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* MMSCH: 392~407 */=
<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.uvd_vce.uvd_ring0_1 =3D 0x188;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.uvd_vce.uvd_ring2_3 =3D 0x189;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.uvd_vce.uvd_ring4_5 =3D 0x18a;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.uvd_vce.uvd_ring6_7 =3D 0x18b;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.uvd_vce.vce_ring0_1 =3D 0x18c;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.uvd_vce.vce_ring2_3 =3D 0x18d;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.uvd_vce.vce_ring4_5 =3D 0x18e;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.uvd_vce.vce_ring6_7 =3D 0x18f;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* In unit of dword =
doorbell */<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_in=
dex.max_assignment =3D 0x18f &lt;&lt; 1; }<br>
&gt;&gt; No need to add a new file for this.&nbsp; Just add this to vega20_=
reg_init.c.&nbsp; Also, please use the doorbell enums rather than hardcodin=
g the numbers.<br>
&gt;&gt;<br>
&gt;&gt; Alex<br>
&gt;&gt;<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; 2.7.4<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; _______________________________________________<br>
&gt;&gt;&gt; amd-gfx mailing list<br>
&gt;&gt;&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists=
.freedesktop.org</a><br>
&gt;&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-=
gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org</a><br>
&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
>https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB165194EF202C47EE0C8487BE80D40BN6PR12MB1651namp_--

--===============0913434652==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0913434652==--
