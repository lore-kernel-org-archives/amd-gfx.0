From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: fix addr handling in
 amdgpu_vm_bo_update_mapping
Date: Mon, 26 Sep 2016 15:19:55 +0000
Message-ID: <MWHPR12MB16946020DD39CF8A45EF99CCF7CD0@MWHPR12MB1694.namprd12.prod.outlook.com>
References: <1474797313-1994-1-git-send-email-deathsimple@vodafone.de>
 <20160926071900.GF9691@flora> <20160926091624.GG9691@flora>
 <5336fe95-9645-0c9c-e948-1e51811ad907@vodafone.de>
 <CY4PR12MB1768C24C35861367BAD1BA07F7CD0@CY4PR12MB1768.namprd12.prod.outlook.com>
 <c6238048-9393-e20c-2b03-6ff11c82ea45@vodafone.de>
 <MWHPR12MB16940A99EBD2BCB0A5F687C3F7CD0@MWHPR12MB1694.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0221308552=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB16940A99EBD2BCB0A5F687C3F7CD0-Gy0DoCVfaSW4WA4dJ5YXGAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, =?iso-8859-1?Q?=27Christian_K=F6nig=27?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "StDenis,
 Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "Cui, Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>
Cc: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0221308552==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB16946020DD39CF8A45EF99CCF7CD0MWHPR12MB1694namp_"

--_000_MWHPR12MB16946020DD39CF8A45EF99CCF7CD0MWHPR12MB1694namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Wait, nevermind.  It would be good to add a comment that addr needs to be r=
eset to 0 in this case since it's used below in the amdgpu_vm_frag_ptes().

The patch is:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf Of D=
eucher, Alexander
Sent: Monday, September 26, 2016 11:17 AM
To: 'Christian K=F6nig'; StDenis, Tom; Cui, Flora
Cc: Huang, Ray; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: RE: [PATCH] drm/amdgpu: fix addr handling in amdgpu_vm_bo_update_m=
apping

Maybe it would be cleaner to just pass 0 to amdgpu_vm_frag_ptes() or remove=
 the parameter altogether.

Alex

From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf Of C=
hristian K=F6nig
Sent: Monday, September 26, 2016 11:12 AM
To: StDenis, Tom; Cui, Flora
Cc: Huang, Ray; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org>
Subject: Re: [PATCH] drm/amdgpu: fix addr handling in amdgpu_vm_bo_update_m=
apping

The function called is either amdgpu_vm_do_set_ptes() or amdgpu_vm_do_copy_=
ptes().

But that is actually rather unrelated to the local handling of addr in the =
function changed.

The point here is we have handled the address offset by giving it to amdgpu=
_vm_map_gart() and so we shouldn't add the address again.

Regards,
Christian.

Am 26.09.2016 um 15:46 schrieb StDenis, Tom:

I'm reading through the amdgpu_vm.c to try and see if the patch is correct =
but I'm not that familiar with the VM side of things.  It seems to boil dow=
n to calling params->func() with a new dst value of NULL but that's where I=
'm stopped at the moment since I don't know what func() is.  Nothing up to =
that point looks overtly wrong (like trying to use that address as a source=
 for a read/write).



Tom

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Christian K=F6nig <deathsimple@vodafo=
ne.de><mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Sent: Monday, September 26, 2016 09:29
To: Cui, Flora
Cc: Huang, Ray; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org>
Subject: Re: [PATCH] drm/amdgpu: fix addr handling in amdgpu_vm_bo_update_m=
apping

Yeah, that wouldn't really help but just make the problem more unlikely
to happen once more.

Anyway Tom St confirmed that the patch seems to work for the open stack.

Anybody brave enough to throw an rb on this so that I can commit it?

Thanks,
Christian.

Am 26.09.2016 um 11:16 schrieb Flora Cui:
> please ignore this patch. it actually revert the gtt mgr changes.
>
> On Mon, Sep 26, 2016 at 03:19:01PM +0800, Flora Cui wrote:
>> On Sun, Sep 25, 2016 at 11:55:13AM +0200, Christian K=F6nig wrote:
>>> From: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org><mailto:christian.koe=
nig-5C7GfCeVMHo@public.gmane.org>
>>>
>>> Otherwise we will look at the wrong place in the IB when GART
>>> mappings are split into smaller updates.
>>>
>>> Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org><mailto:chri=
stian.koenig-5C7GfCeVMHo@public.gmane.org>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
>>> index 2bb78dc..da31189 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -1017,6 +1017,7 @@ static int amdgpu_vm_bo_update_mapping(struct amd=
gpu_device *adev,
>>>                                                  AMDGPU_GPU_PAGE_SIZE);
>>>                      pte[i] |=3D flags;
>>>              }
>>> +           addr =3D 0;
>>>      }
>>>
>>>      r =3D amdgpu_sync_fence(adev, &job->sync, exclusive);
>>> --
>>> 2.5.0
>>>
>>>
>> IMHO this could fix the vmfault issue.
>>
>> 8<---
>>  From cc7b5618665defd88e2adcd6f735562ecd784298 Mon Sep 17 00:00:00 2001
>> From: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org><mailto:Flora.Cui-5C7GfCeVMHo@public.gmane.org>
>> Date: Mon, 26 Sep 2016 15:14:02 +0800
>> Subject: [PATCH] drm/amdgpu: add ttm_bind in amdgpu_vm_bo_update()
>>
>> Change-Id: If73d5b06e9188e40250ccdfd1a2a659ed1ef52a6
>> Signed-off-by: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org><mailto:Flora.Cui-5C7GfCeVMHo@public.gmane.org>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vm.c
>> index 2bb78dc..7f17127 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1166,6 +1166,8 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev=
,
>>                       ttm =3D container_of(bo_va->bo->tbo.ttm, struct
>>                                          ttm_dma_tt, ttm);
>>                       pages_addr =3D ttm->dma_address;
>> +                    amdgpu_ttm_bind(&bo_va->bo->tbo, mem);
>> +                    addr =3D (u64)mem->start << PAGE_SHIFT;
>>                       break;
>>
>>               case TTM_PL_VRAM:
>> --
>> 2.7.4
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - lists.freedesktop.org<https://lists.freedesktop.org/mai=
lman/listinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...



> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--_000_MWHPR12MB16946020DD39CF8A45EF99CCF7CD0MWHPR12MB1694namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";
	color:black;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";
	color:black;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";
	color:black;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";
	color:black;}
span.EmailStyle20
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
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
<body bgcolor=3D"white" lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Wait, nevermind.&nbsp; It=
 would be good to add a comment that addr needs to be reset to 0 in this ca=
se since it's used below in the amdgpu_vm_frag_ptes().<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">The patch is:<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Reviewed-by: Alex Deucher=
 &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;;color:windowtext">From:</span></b><spa=
n style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif=
&quot;;color:windowtext"> amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp93gSJqDPrsil@public.gmane.org=
.org]
<b>On Behalf Of </b>Deucher, Alexander<br>
<b>Sent:</b> Monday, September 26, 2016 11:17 AM<br>
<b>To:</b> 'Christian K=F6nig'; StDenis, Tom; Cui, Flora<br>
<b>Cc:</b> Huang, Ray; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: fix addr handling in amdgpu_vm_bo_u=
pdate_mapping<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Maybe it would be cleaner=
 to just pass 0 to amdgpu_vm_frag_ptes() or remove the parameter altogether=
.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">&nbsp;</span><o:p></o:p><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Alex</span><o:p></o:p></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">&nbsp;</span><o:p></o:p><=
/p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;;color:windowtext">From:</span></b><spa=
n style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif=
&quot;;color:windowtext"> amd-gfx [<a href=3D"mailto:amd-gfx-bounces@lists.=
freedesktop.org">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]
<b>On Behalf Of </b>Christian K=F6nig<br>
<b>Sent:</b> Monday, September 26, 2016 11:12 AM<br>
<b>To:</b> StDenis, Tom; Cui, Flora<br>
<b>Cc:</b> Huang, Ray; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix addr handling in amdgpu_vm_bo_u=
pdate_mapping</span><o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">The function called is either amdgpu_vm_do_set_ptes(=
) or amdgpu_vm_do_copy_ptes().<br>
<br>
But that is actually rather unrelated to the local handling of addr in the =
function changed.<br>
<br>
The point here is we have handled the address offset by giving it to amdgpu=
_vm_map_gart() and so we shouldn't add the address again.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 26.09.2016 um 15:46 schrieb StDenis, Tom:<o:p></o:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<div id=3D"divtagdefaultwrapper">
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;">I'm reading through the amdgpu_vm.c to try and se=
e if the patch is correct but I'm not that familiar with the VM side of thi=
ngs. &nbsp;It seems to boil down to calling params-&gt;func() with
 a new dst value of NULL but that's where I'm stopped at the moment since I=
 don't know what func() is. &nbsp;Nothing up to that point looks overtly wr=
ong (like trying to use that address as a source for a read/write).</span><=
o:p></o:p></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;">&nbsp;</span><o:p></o:p></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;">Tom</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Calibri&quot;,&quot;sans-serif&quot;">&nbsp;</span><o:p></o:p></p>
<div>
<div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center;backgr=
ound:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal" style=3D"background:white"><b><span style=3D"font-si=
ze:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;">From:</sp=
an></b><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;"> amd-gfx
<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounce=
s@lists.freedesktop.org&gt;</a> on behalf of Christian K=F6nig
<a href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;<=
/a><br>
<b>Sent:</b> Monday, September 26, 2016 09:29<br>
<b>To:</b> Cui, Flora<br>
<b>Cc:</b> Huang, Ray; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix addr handling in amdgpu_vm_bo_u=
pdate_mapping</span><span style=3D"font-family:&quot;Calibri&quot;,&quot;sa=
ns-serif&quot;">
</span><o:p></o:p></p>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Calibri&quot;,&quot;sans-serif&quot;">&nbsp;</span><o:p></o:p></p>
</div>
</div>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;">Yeah, that w=
ouldn't really help but just make the problem more unlikely
<br>
to happen once more.<br>
<br>
Anyway Tom St confirmed that the patch seems to work for the open stack.<br=
>
<br>
Anybody brave enough to throw an rb on this so that I can commit it?<br>
<br>
Thanks,<br>
Christian.<br>
<br>
Am 26.09.2016 um 11:16 schrieb Flora Cui:<br>
&gt; please ignore this patch. it actually revert the gtt mgr changes.<br>
&gt;<br>
&gt; On Mon, Sep 26, 2016 at 03:19:01PM &#43;0800, Flora Cui wrote:<br>
&gt;&gt; On Sun, Sep 25, 2016 at 11:55:13AM &#43;0200, Christian K=F6nig wr=
ote:<br>
&gt;&gt;&gt; From: Christian K=F6nig <a href=3D"mailto:christian.koenig@amd=
.com">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Otherwise we will look at the wrong place in the IB when GART<=
br>
&gt;&gt;&gt; mappings are split into smaller updates.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Christian K=F6nig <a href=3D"mailto:christian.k=
oenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 &#43;<b=
r>
&gt;&gt;&gt;&nbsp;&nbsp; 1 file changed, 1 insertion(&#43;)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt;&gt;&gt; index 2bb78dc..da31189 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt;&gt;&gt; @@ -1017,6 &#43;1017,7 @@ static int amdgpu_vm_bo_update_mappi=
ng(struct amdgpu_device *adev,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; AMDGPU_GPU_PAGE_SIZE);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pte[i] |=3D=
 flags;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; addr =3D 0;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_sync_fence(adev, &a=
mp;job-&gt;sync, exclusive);<br>
&gt;&gt;&gt; -- <br>
&gt;&gt;&gt; 2.5.0<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt; IMHO this could fix the vmfault issue.<br>
&gt;&gt;<br>
&gt;&gt; 8&lt;---<br>
&gt;&gt;&nbsp; From cc7b5618665defd88e2adcd6f735562ecd784298 Mon Sep 17 00:=
00:00 2001<br>
&gt;&gt; From: Flora Cui <a href=3D"mailto:Flora.Cui-5C7GfCeVMHo@public.gmane.org">&lt;Flora.Cui=
@amd.com&gt;</a><br>
&gt;&gt; Date: Mon, 26 Sep 2016 15:14:02 &#43;0800<br>
&gt;&gt; Subject: [PATCH] drm/amdgpu: add ttm_bind in amdgpu_vm_bo_update()=
<br>
&gt;&gt;<br>
&gt;&gt; Change-Id: If73d5b06e9188e40250ccdfd1a2a659ed1ef52a6<br>
&gt;&gt; Signed-off-by: Flora Cui <a href=3D"mailto:Flora.Cui-5C7GfCeVMHo@public.gmane.org">&lt;=
Flora.Cui-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 &#43;&#43;<=
br>
&gt;&gt;&nbsp;&nbsp; 1 file changed, 2 insertions(&#43;)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_vm.c<br>
&gt;&gt; index 2bb78dc..7f17127 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt;&gt; @@ -1166,6 &#43;1166,8 @@ int amdgpu_vm_bo_update(struct amdgpu_de=
vice *adev,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm =3D c=
ontainer_of(bo_va-&gt;bo-&gt;tbo.ttm, struct<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_dma_tt, ttm);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pages_add=
r =3D ttm-&gt;dma_address;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ttm_bind(&amp;=
bo_va-&gt;bo-&gt;tbo, mem);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr =3D (u64)mem-&gt=
;start &lt;&lt; PAGE_SHIFT;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br=
>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; case TTM_PL_VRAM:<br>
&gt;&gt; -- <br>
&gt;&gt; 2.7.4<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org</a><br>
&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 id=3D"LPlnk752113">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a> </span><o:p></o:=
p></p>
<div style=3D"margin-bottom:15.0pt;overflow:auto" id=3D"LPBorder_GT_1474897=
4921180.061148974248180776">
<table class=3D"MsoNormalTable" border=3D"1" cellspacing=3D"0" cellpadding=
=3D"0" width=3D"90%" style=3D"width:90.0%;border-top:dotted #C8C8C8 1.0pt;b=
order-left:none;border-bottom:dotted #C8C8C8 1.0pt;border-right:none">
<tbody>
<tr>
<td valign=3D"top" style=3D"border:none;padding:0in 0in 0in 0in">
<div id=3D"LPTitle_14748974921170.667584414663523">
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;mso-line-height-alt:15.75=
pt"><span style=3D"font-size:16.0pt;font-family:&quot;Tahoma&quot;,&quot;sa=
ns-serif&quot;;color:#3B5777"><a href=3D"https://lists.freedesktop.org/mail=
man/listinfo/amd-gfx" target=3D"_blank"><span style=3D"text-decoration:none=
">amd-gfx
 Info Page - lists.freedesktop.org</span></a></span><o:p></o:p></p>
</div>
<div style=3D"margin-top:7.5pt;margin-bottom:12.0pt" id=3D"LPMetadata_14748=
974921170.8198680036506909">
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;line-height:10.5pt"><span=
 style=3D"font-size:10.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&q=
uot;;color:#666666">lists.freedesktop.org</span><o:p></o:p></p>
</div>
<div id=3D"LPDescription_14748974921180.08916125964466382">
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;line-height:15.0pt"><span=
 style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,&quot;sans-seri=
f&quot;">To see the collection of prior postings to the list, visit the amd=
-gfx Archives. Using amd-gfx: To post a message to all the
 list members, send email ...</span><o:p></o:p></p>
</div>
</td>
</tr>
</tbody>
</table>
</div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;"><br>
<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></span><o:p></o:p></p>
</div>
</div>
</div>
</blockquote>
<p>&nbsp;<o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_MWHPR12MB16946020DD39CF8A45EF99CCF7CD0MWHPR12MB1694namp_--

--===============0221308552==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0221308552==--
