From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: do not execute 0-sized IBs
Date: Thu, 3 Oct 2019 13:12:01 +0000
Message-ID: <BN6PR12MB1809256856DE153A35FD7EF6F79F0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20191003080306.3514-1-pierre-eric.pelloux-prayer@amd.com>
 <12e0b546-faaf-38c3-c0fc-1e713348b62e@gmail.com>,
 <a8d4871c-4b00-3a72-1cff-50878e1d8818@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2082011708=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a8d4871c-4b00-3a72-1cff-50878e1d8818-5C7GfCeVMHo@public.gmane.org>
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
To: "Pelloux-prayer, Pierre-eric" <Pierre-eric.Pelloux-prayer-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2082011708==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809256856DE153A35FD7EF6F79F0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809256856DE153A35FD7EF6F79F0BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Does some variant of the patch on this thread help?
https://patchwork.freedesktop.org/patch/333068/

Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Pelloux-=
prayer, Pierre-eric <Pierre-eric.Pelloux-prayer-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, October 3, 2019 4:25 AM
To: Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp93gSJqDPrsil@public.gmane.org=
.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: do not execute 0-sized IBs


On 03/10/2019 10:09, Christian K=F6nig wrote:
> Am 03.10.19 um 10:03 schrieb Pelloux-prayer, Pierre-eric:
>> This can be safely skipped entirely.
>> This seems to help with https://bugs.freedesktop.org/show_bug.cgi?id=3D1=
11481.
>
> NAK, please instead fix gmc_v10_0_flush_gpu_tlb to include at least some =
NOP in the submitted IBs.

Is there any interest in executing an empty (or only filled with NOPs) IB?

Anyway I can modify the patch to do this.

Thanks,
Pierre-Eric

>
> Christian.
>
>>
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@am=
d.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ib.c
>> index 60655834d649..aa163e679f1f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> @@ -227,6 +227,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, un=
signed num_ibs,
>>               !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble =
CE ib must be inserted anyway */
>>               continue;
>>   +        if (ib->length_dw =3D=3D 0) {
>> +            /* On Navi gmc_v10_0_flush_gpu_tlb emits 0 sized IB */
>> +            continue;
>> +        }
>> +
>>           amdgpu_ring_emit_ib(ring, job, ib, status);
>>           status &=3D ~AMDGPU_HAVE_CTX_SWITCH;
>>       }
>
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809256856DE153A35FD7EF6F79F0BN6PR12MB1809namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Does some variant of the patch on this thread help?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<a href=3D"https://patchwork.freedesktop.org/patch/333068/" id=3D"LPlnk1082=
71">https://patchwork.freedesktop.org/patch/333068/</a></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Pelloux-prayer, Pierre-eric=
 &lt;Pierre-eric.Pelloux-prayer-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, October 3, 2019 4:25 AM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx@list=
s.freedesktop.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: do not execute 0-sized IBs</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText"><br>
On 03/10/2019 10:09, Christian K=F6nig wrote:<br>
&gt; Am 03.10.19 um 10:03 schrieb Pelloux-prayer, Pierre-eric:<br>
&gt;&gt; This can be safely skipped entirely.<br>
&gt;&gt; This seems to help with <a href=3D"https://bugs.freedesktop.org/sh=
ow_bug.cgi?id=3D111481">
https://bugs.freedesktop.org/show_bug.cgi?id=3D111481</a>.<br>
&gt; <br>
&gt; NAK, please instead fix gmc_v10_0_flush_gpu_tlb to include at least so=
me NOP in the submitted IBs.<br>
<br>
Is there any interest in executing an empty (or only filled with NOPs) IB?<=
br>
<br>
Anyway I can modify the patch to do this.<br>
<br>
Thanks,<br>
Pierre-Eric<br>
<br>
&gt; <br>
&gt; Christian.<br>
&gt; <br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Pierre-Eric Pelloux-Prayer &lt;pierre-eric.pelloux-=
prayer-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 5 &#43;&#43;&#43;&=
#43;&#43;<br>
&gt;&gt; &nbsp; 1 file changed, 5 insertions(&#43;)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_ib.c<br>
&gt;&gt; index 60655834d649..aa163e679f1f 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
&gt;&gt; @@ -227,6 &#43;227,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring=
 *ring, unsigned num_ibs,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE i=
b must be inserted anyway */<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; continue;<br>
&gt;&gt; &nbsp; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ib-&gt;=
length_dw =3D=3D 0) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; /* On Navi gmc_v10_0_flush_gpu_tlb emits 0 sized IB */<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; continue;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &#43;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring=
_emit_ib(ring, job, ib, status);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status &amp=
;=3D ~AMDGPU_HAVE_CTX_SWITCH;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809256856DE153A35FD7EF6F79F0BN6PR12MB1809namp_--

--===============2082011708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============2082011708==--
