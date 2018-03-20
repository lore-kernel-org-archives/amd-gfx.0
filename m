From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: disable job timeout on GPU reset disabled
Date: Tue, 20 Mar 2018 14:16:35 +0000
Message-ID: <DM5PR12MB1820FEE50DE4EBD1E44B676BF7AB0@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <1521439692-14823-1-git-send-email-evan.quan@amd.com>
 <d7a88e66-6533-9c12-c36c-9b3ea569e354@gmail.com>
 <DM5PR1201MB248999A09FAAC36F90204EF9E4AB0@DM5PR1201MB2489.namprd12.prod.outlook.com>,
 <fffd20df-cbcb-51ae-7de2-915804fce17f@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1654736712=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <fffd20df-cbcb-51ae-7de2-915804fce17f-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1654736712==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1820FEE50DE4EBD1E44B676BF7AB0DM5PR12MB1820namp_"

--_000_DM5PR12MB1820FEE50DE4EBD1E44B676BF7AB0DM5PR12MB1820namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

My concern was that compute will always have the timeout disabled with no w=
ay to override it even if you enable GPU reset.  I guess we can address tha=
t down the road.


Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: Koenig, Christian
Sent: Tuesday, March 20, 2018 6:14:29 AM
To: Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander
Subject: Re: [PATCH] drm/amdgpu: disable job timeout on GPU reset disabled

Hi Evan,

that one is perfect if you ask me. Just reading up on the history of
that patch, Alex what was your concern with that?

Regarding printing this as error, that's a really good point as well. We
should probably reduce it to a warning or even info severity.

Regards,
Christian.

Am 20.03.2018 um 03:11 schrieb Quan, Evan:
> Hi Christian,
>
> The messages prompted on timeout are Errors not just Warnings although we=
 did not see any real problem(for the dgemm special case). That's why we sa=
y it confusing.
> And i suppose you want a fix like my previous patch(see attachment).
>
> Regards,
> Evan
>> -----Original Message-----
>> From: Christian K=F6nig [mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
>> Sent: Monday, March 19, 2018 5:42 PM
>> To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
>> Subject: Re: [PATCH] drm/amdgpu: disable job timeout on GPU reset
>> disabled
>>
>> Am 19.03.2018 um 07:08 schrieb Evan Quan:
>>> Since under some heavy computing environment(dgemm test), it takes the
>>> asic over 10+ seconds to finish the dispatched single job which will
>>> trigger the timeout. It's quite confusing although it does not seem to
>>> bring any real problems.
>>> As a quick workround, we choose to disable timeout when GPU reset is
>>> disabled.
>> NAK, I enabled those warning intentionally even when the GPU recovery is
>> disabled to have a hint in the logs what goes wrong.
>>
>> Please only increase the timeout for the compute queue and/or add a
>> separate timeout for them.
>>
>> Regards,
>> Christian.
>>
>>
>>> Change-Id: I3a95d856ba4993094dc7b6269649e470c5b053d2
>>> Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
>>>    1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 8bd9c3f..9d6a775 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -861,6 +861,13 @@ static void
>> amdgpu_device_check_arguments(struct amdgpu_device *adev)
>>>              amdgpu_lockup_timeout =3D 10000;
>>>      }
>>>
>>> +   /*
>>> +    * Disable timeout when GPU reset is disabled to avoid confusing
>>> +    * timeout messages in the kernel log.
>>> +    */
>>> +   if (amdgpu_gpu_recovery =3D=3D 0 || amdgpu_gpu_recovery =3D=3D -1)
>>> +           amdgpu_lockup_timeout =3D INT_MAX;
>>> +
>>>      adev->firmware.load_type =3D amdgpu_ucode_get_load_type(adev,
>> amdgpu_fw_load_type);
>>>    }
>>>


--_000_DM5PR12MB1820FEE50DE4EBD1E44B676BF7AB0DM5PR12MB1820namp_
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
<p style=3D"margin-top:0;margin-bottom:0">My concern was that compute will =
always have the timeout disabled with no way to override it even if you ena=
ble GPU reset.&nbsp; I guess we can address that down the road.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Koenig, Christian<br>
<b>Sent:</b> Tuesday, March 20, 2018 6:14:29 AM<br>
<b>To:</b> Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: disable job timeout on GPU reset di=
sabled</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Evan,<br>
<br>
that one is perfect if you ask me. Just reading up on the history of <br>
that patch, Alex what was your concern with that?<br>
<br>
Regarding printing this as error, that's a really good point as well. We <b=
r>
should probably reduce it to a warning or even info severity.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 20.03.2018 um 03:11 schrieb Quan, Evan:<br>
&gt; Hi Christian,<br>
&gt;<br>
&gt; The messages prompted on timeout are Errors not just Warnings although=
 we did not see any real problem(for the dgemm special case). That's why we=
 say it confusing.<br>
&gt; And i suppose you want a fix like my previous patch(see attachment).<b=
r>
&gt;<br>
&gt; Regards,<br>
&gt; Evan<br>
&gt;&gt; -----Original Message-----<br>
&gt;&gt; From: Christian K=F6nig [<a href=3D"mailto:ckoenig.leichtzumerken@=
gmail.com">mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>]<br>
&gt;&gt; Sent: Monday, March 19, 2018 5:42 PM<br>
&gt;&gt; To: Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9w@public.gmane.org=
p.org<br>
&gt;&gt; Cc: Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt; Subject: Re: [PATCH] drm/amdgpu: disable job timeout on GPU reset<=
br>
&gt;&gt; disabled<br>
&gt;&gt;<br>
&gt;&gt; Am 19.03.2018 um 07:08 schrieb Evan Quan:<br>
&gt;&gt;&gt; Since under some heavy computing environment(dgemm test), it t=
akes the<br>
&gt;&gt;&gt; asic over 10&#43; seconds to finish the dispatched single job =
which will<br>
&gt;&gt;&gt; trigger the timeout. It's quite confusing although it does not=
 seem to<br>
&gt;&gt;&gt; bring any real problems.<br>
&gt;&gt;&gt; As a quick workround, we choose to disable timeout when GPU re=
set is<br>
&gt;&gt;&gt; disabled.<br>
&gt;&gt; NAK, I enabled those warning intentionally even when the GPU recov=
ery is<br>
&gt;&gt; disabled to have a hint in the logs what goes wrong.<br>
&gt;&gt;<br>
&gt;&gt; Please only increase the timeout for the compute queue and/or add =
a<br>
&gt;&gt; separate timeout for them.<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Christian.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt; Change-Id: I3a95d856ba4993094dc7b6269649e470c5b053d2<br>
&gt;&gt;&gt; Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |=
 7 &#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; 1 file changed, 7 insertions(&#43;)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt;&gt; index 8bd9c3f..9d6a775 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<b=
r>
&gt;&gt;&gt; @@ -861,6 &#43;861,13 @@ static void<br>
&gt;&gt; amdgpu_device_check_arguments(struct amdgpu_device *adev)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_lockup_timeout =3D 10000;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; /*<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; * Disable timeout when GPU reset is di=
sabled to avoid confusing<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; * timeout messages in the kernel log.<=
br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp; if (amdgpu_gpu_recovery =3D=3D 0 || amdgpu_g=
pu_recovery =3D=3D -1)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_lockup_timeout =3D INT_MAX;<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.load_type =3D =
amdgpu_ucode_get_load_type(adev,<br>
&gt;&gt; amdgpu_fw_load_type);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM5PR12MB1820FEE50DE4EBD1E44B676BF7AB0DM5PR12MB1820namp_--

--===============1654736712==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1654736712==--
