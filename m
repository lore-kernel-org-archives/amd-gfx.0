From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PART1 PATCH v4 7/8] drm/amdgpu: add get clockgating_state method
 for uvd v5&v6
Date: Mon, 9 Jan 2017 14:50:37 +0000
Message-ID: <CY4PR12MB1768D65E3065C4D143C3513BF7640@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1483930814-23529-1-git-send-email-ray.huang@amd.com>
 <1483930814-23529-2-git-send-email-ray.huang@amd.com>
 <364cc068-e347-5f77-b4ff-414f8e8b4fdb@amd.com>
 <CY4PR12MB176846FDA72EF232B6825609F7640@CY4PR12MB1768.namprd12.prod.outlook.com>
 <20170109144614.GA3743@hr-amur2>,
 <523a8df8-2573-0c56-e6c7-5ac74f77f1f3@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1418388937=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <523a8df8-2573-0c56-e6c7-5ac74f77f1f3-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>
Cc: "Fu, Ping" <Ping.Fu-5C7GfCeVMHo@public.gmane.org>, "Mao, David" <David.Mao-5C7GfCeVMHo@public.gmane.org>, "Kuehling,
 Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============1418388937==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1768D65E3065C4D143C3513BF7640CY4PR12MB1768namp_"

--_000_CY4PR12MB1768D65E3065C4D143C3513BF7640CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Yes, holding pm.mutex will prevent PP/DPM from entering/leaving PG states a=
nd is used as a means to probe power/clock related signals reliably (except=
 for VCE clock signals which aren't part of an AON tile).


You just can't take it from a "set" state function since the higher up API =
will take it.


Tom


________________________________
From: Koenig, Christian
Sent: Monday, January 9, 2017 09:45
To: Huang, Ray; StDenis, Tom
Cc: Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Zhu, Rex; Mao, David=
; Fu, Ping; Zhang, Hawking; Kuehling, Felix
Subject: Re: [PART1 PATCH v4 7/8] drm/amdgpu: add get clockgating_state met=
hod for uvd v5&v6

Am 09.01.2017 um 15:46 schrieb Huang Rui:
> On Mon, Jan 09, 2017 at 07:29:00PM +0800, StDenis, Tom wrote:
>> Yup it's held by both amdgpu_dpm_enable_uvd() and amdgpu_dpm_enable_vce(=
)
>>
>> Tom
>>
> <snip>
>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/am=
d/
>> amdgpu/uvd_v5_0.c
>>> index 03a35d9..e647d3e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>>> @@ -781,16 +781,48 @@ static int uvd_v5_0_set_powergating_state(void *h=
andle,
>>>          * the smc and the hw blocks
>>>          */
>>>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>> +     int ret =3D 0;
>>>
>>>         if (!(adev->pg_flags & AMD_PG_SUPPORT_UVD))
>>>                 return 0;
>>>
>>> +     mutex_lock(&adev->pm.mutex);
>> Might be that I'm wrong, but didn't Tom said the mutex is taken anyway
>> when this function is called?
>>
>> If that's true we would certainly run into problem when we try to
>> acquire it again.
>>
> OK, I see. Actually, pm.mutex is already held on upper layer call
> (amdgpu_dpm_enable_uvd). So we should not hold it again here.
>
>>> +
>>> +static void uvd_v5_0_get_clockgating_state(void *handle, u32 *flags)
>>> +{
>>> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>> +     int data;
>>> +
>>> +     mutex_lock(&adev->pm.mutex);
>>> +
> We just need keep pm.mutex here in set_clockgating_state, that's enough.
>
> Christian, Tom, am I right?

Yes, I think so.

Christian.

>
> Thanks,
> Rui



--_000_CY4PR12MB1768D65E3065C4D143C3513BF7640CY4PR12MB1768namp_
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
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>Yes, holding pm.mutex will prevent PP/DPM from entering/leaving PG state=
s and is used as a means to probe power/clock related signals reliably (exc=
ept for VCE clock signals which aren't part of an AON tile).</p>
<p><br>
</p>
<p>You just can't take it from a &quot;set&quot; state function since the h=
igher up API will take it.</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Koenig, Christian<b=
r>
<b>Sent:</b> Monday, January 9, 2017 09:45<br>
<b>To:</b> Huang, Ray; StDenis, Tom<br>
<b>Cc:</b> Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Zhu, Rex; Mao=
, David; Fu, Ping; Zhang, Hawking; Kuehling, Felix<br>
<b>Subject:</b> Re: [PART1 PATCH v4 7/8] drm/amdgpu: add get clockgating_st=
ate method for uvd v5&amp;v6</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Am 09.01.2017 um 15:46 schrieb Huang Rui:<br>
&gt; On Mon, Jan 09, 2017 at 07:29:00PM &#43;0800, StDenis, Tom wrote:<br>
&gt;&gt; Yup it's held by both amdgpu_dpm_enable_uvd() and amdgpu_dpm_enabl=
e_vce()<br>
&gt;&gt;<br>
&gt;&gt; Tom<br>
&gt;&gt;<br>
&gt; &lt;snip&gt;<br>
&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/g=
pu/drm/amd/<br>
&gt;&gt; amdgpu/uvd_v5_0.c<br>
&gt;&gt;&gt; index 03a35d9..e647d3e 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c<br>
&gt;&gt;&gt; @@ -781,16 &#43;781,48 @@ static int uvd_v5_0_set_powergating_=
state(void *handle,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the sm=
c and the hw blocks<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
device *adev =3D (struct amdgpu_device *)handle;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt=
;pg_flags &amp; AMD_PG_SUPPORT_UVD))<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;pm.mute=
x);<br>
&gt;&gt; Might be that I'm wrong, but didn't Tom said the mutex is taken an=
yway<br>
&gt;&gt; when this function is called?<br>
&gt;&gt;<br>
&gt;&gt; If that's true we would certainly run into problem when we try to<=
br>
&gt;&gt; acquire it again.<br>
&gt;&gt;<br>
&gt; OK, I see. Actually, pm.mutex is already held on upper layer call<br>
&gt; (amdgpu_dpm_enable_uvd). So we should not hold it again here.<br>
&gt;<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;static void uvd_v5_0_get_clockgating_state(void *handle, =
u32 *flags)<br>
&gt;&gt;&gt; &#43;{<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (=
struct amdgpu_device *)handle;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int data;<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;pm.mute=
x);<br>
&gt;&gt;&gt; &#43;<br>
&gt; We just need keep pm.mutex here in set_clockgating_state, that's enoug=
h.<br>
&gt;<br>
&gt; Christian, Tom, am I right?<br>
<br>
Yes, I think so.<br>
<br>
Christian.<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Rui<br>
<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB1768D65E3065C4D143C3513BF7640CY4PR12MB1768namp_--

--===============1418388937==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1418388937==--
