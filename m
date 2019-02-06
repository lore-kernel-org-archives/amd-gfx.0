From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amdgpu: Fix a typo in vega10_ih_set_rptr()
Date: Wed, 6 Feb 2019 20:08:52 +0000
Message-ID: <SN1PR12MB2365B75DE8EE5EB4FF3724B3F06F0@SN1PR12MB2365.namprd12.prod.outlook.com>
References: <20190206154921.14463-1-Yong.Zhao@amd.com>
 <20190206154921.14463-2-Yong.Zhao@amd.com>
 <DM5PR12MB1707AB38B8039A41F07FC1E7926F0@DM5PR12MB1707.namprd12.prod.outlook.com>
 <SN1PR12MB23657F8FB9109F776FD56F46F06F0@SN1PR12MB2365.namprd12.prod.outlook.com>
 <CADnq5_P0VfVkk5cepB=Jbm0dJWDPCY00Gu+220yoCVfwP_qVHw@mail.gmail.com>,
 <83f8b6a8-996b-fec5-54e9-ae402034cad6@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1543103565=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <83f8b6a8-996b-fec5-54e9-ae402034cad6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1543103565==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN1PR12MB2365B75DE8EE5EB4FF3724B3F06F0SN1PR12MB2365namp_"

--_000_SN1PR12MB2365B75DE8EE5EB4FF3724B3F06F0SN1PR12MB2365namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I see. I will drop this. How about the other two patches?

Regards,
Yong
________________________________
From: Christian K?nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Wednesday, February 6, 2019 1:20 PM
To: Alex Deucher; Zhao, Yong
Cc: Kuehling, Felix; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 2/3] drm/amdgpu: Fix a typo in vega10_ih_set_rptr()

Am 06.02.19 um 19:17 schrieb Alex Deucher:
> On Wed, Feb 6, 2019 at 12:01 PM Zhao, Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org> wrote:
>> Not too sure about this, but it looks strange in the code when all other=
 similar code uses 64-bit.
> It's worth double checking, but Felix is right.  A number of IPs still
> used 32 bit doorbells on vega10.  E.g., multi-media for example.

I agree, the IH is certainly a 32bit doorbell on Vega10.

Christian.

>
> Alex
>
>> "Maybe it makes more sense to think of 64-bit doorbells as using 2 doorb=
ell indexes". You mean the alternative is to multiply all the current 64 do=
orbell index constants with 2, right? That might be easier and cleaner, and=
 we need to make sure that the *2 and << 1 conversions from 64-bit index to=
 dword index are all removed.
>>
>> Regards,
>> Yong
>> ________________________________
>> From: Kuehling, Felix
>> Sent: Wednesday, February 6, 2019 11:26 AM
>> To: Zhao, Yong; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> Subject: Re: [PATCH 2/3] drm/amdgpu: Fix a typo in vega10_ih_set_rptr()
>>
>> Are you sure about this? Typically 64-bit doorbells don't wrap around. B=
ut this one does. If the IH doorbell wraps around, there is no reason why i=
t needs to be 64-bit, so I suspect it may still be a 32-bit doorbell.
>>
>> AFAIK, not all doorbells on Vega10 are 64-bit. It depends on the IP bloc=
k. Therefore, maybe some of your other renaming changes should be reconside=
red if they assume that all doorbells are 64-bit. Maybe it makes more sense=
 to think of 64-bit doorbells as using 2 doorbell indexes.
>>
>> Regards,
>>    Felix
>>
>> ________________________________________
>> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Zhao,=
 Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
>> Sent: Wednesday, February 6, 2019 10:49 AM
>> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> Cc: Zhao, Yong
>> Subject: [PATCH 2/3] drm/amdgpu: Fix a typo in vega10_ih_set_rptr()
>>
>> Clearly, it should be a 64-bit doorbell operation.
>>
>> Change-Id: I644a2ebcb18c2ede24ee15692a6189efad10a35c
>> Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/am=
d/amdgpu/vega10_ih.c
>> index 796004896661..36f0e3cada30 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>> @@ -377,7 +377,7 @@ static void vega10_ih_set_rptr(struct amdgpu_device =
*adev,
>>          if (ih->use_doorbell) {
>>                  /* XXX check if swapping is necessary on BE */
>>                  *ih->rptr_cpu =3D ih->rptr;
>> -               WDOORBELL32(ih->doorbell_idx_in_dw, ih->rptr);
>> +               WDOORBELL64(ih->doorbell_idx_in_dw, ih->rptr);
>>          } else if (ih =3D=3D &adev->irq.ih) {
>>                  WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, ih->rptr);
>>          } else if (ih =3D=3D &adev->irq.ih1) {
>> --
>> 2.17.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--_000_SN1PR12MB2365B75DE8EE5EB4FF3724B3F06F0SN1PR12MB2365namp_
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
I see. I will drop this. How about the other two patches?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Yong</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K&ouml;nig =
&lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, February 6, 2019 1:20 PM<br>
<b>To:</b> Alex Deucher; Zhao, Yong<br>
<b>Cc:</b> Kuehling, Felix; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 2/3] drm/amdgpu: Fix a typo in vega10_ih_set_rpt=
r()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 06.02.19 um 19:17 schrieb Alex Deucher:<br>
&gt; On Wed, Feb 6, 2019 at 12:01 PM Zhao, Yong &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt; w=
rote:<br>
&gt;&gt; Not too sure about this, but it looks strange in the code when all=
 other similar code uses 64-bit.<br>
&gt; It's worth double checking, but Felix is right.&nbsp; A number of IPs =
still<br>
&gt; used 32 bit doorbells on vega10.&nbsp; E.g., multi-media for example.<=
br>
<br>
I agree, the IH is certainly a 32bit doorbell on Vega10.<br>
<br>
Christian.<br>
<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt;&gt; &quot;Maybe it makes more sense to think of 64-bit doorbells as us=
ing 2 doorbell indexes&quot;. You mean the alternative is to multiply all t=
he current 64 doorbell index constants with 2, right? That might be easier =
and cleaner, and we need to make sure that the *2
 and &lt;&lt; 1 conversions from 64-bit index to dword index are all remove=
d.<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Yong<br>
&gt;&gt; ________________________________<br>
&gt;&gt; From: Kuehling, Felix<br>
&gt;&gt; Sent: Wednesday, February 6, 2019 11:26 AM<br>
&gt;&gt; To: Zhao, Yong; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt; Subject: Re: [PATCH 2/3] drm/amdgpu: Fix a typo in vega10_ih_set_r=
ptr()<br>
&gt;&gt;<br>
&gt;&gt; Are you sure about this? Typically 64-bit doorbells don't wrap aro=
und. But this one does. If the IH doorbell wraps around, there is no reason=
 why it needs to be 64-bit, so I suspect it may still be a 32-bit doorbell.=
<br>
&gt;&gt;<br>
&gt;&gt; AFAIK, not all doorbells on Vega10 are 64-bit. It depends on the I=
P block. Therefore, maybe some of your other renaming changes should be rec=
onsidered if they assume that all doorbells are 64-bit. Maybe it makes more=
 sense to think of 64-bit doorbells as
 using 2 doorbell indexes.<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; Felix<br>
&gt;&gt;<br>
&gt;&gt; ________________________________________<br>
&gt;&gt; From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on beh=
alf of Zhao, Yong &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt; Sent: Wednesday, February 6, 2019 10:49 AM<br>
&gt;&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt; Cc: Zhao, Yong<br>
&gt;&gt; Subject: [PATCH 2/3] drm/amdgpu: Fix a typo in vega10_ih_set_rptr(=
)<br>
&gt;&gt;<br>
&gt;&gt; Clearly, it should be a 64-bit doorbell operation.<br>
&gt;&gt;<br>
&gt;&gt; Change-Id: I644a2ebcb18c2ede24ee15692a6189efad10a35c<br>
&gt;&gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 2 &#43;-<br>
&gt;&gt;&nbsp;&nbsp; 1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/=
drm/amd/amdgpu/vega10_ih.c<br>
&gt;&gt; index 796004896661..36f0e3cada30 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c<br>
&gt;&gt; @@ -377,7 &#43;377,7 @@ static void vega10_ih_set_rptr(struct amdg=
pu_device *adev,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ih-&gt;u=
se_doorbell) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* XXX check if swapping is necessary o=
n BE */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ih-&gt;rptr_cpu =3D ih-&gt;rptr;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; WDOORBELL32(ih-&gt;doorbell_idx_in_dw, ih-&gt;rptr);<br=
>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; WDOORBELL64(ih-&gt;doorbell_idx_in_dw, ih-&gt;rptr)=
;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (i=
h =3D=3D &amp;adev-&gt;irq.ih) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, i=
h-&gt;rptr);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (i=
h =3D=3D &amp;adev-&gt;irq.ih1) {<br>
&gt;&gt; --<br>
&gt;&gt; 2.17.1<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
>https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
>https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SN1PR12MB2365B75DE8EE5EB4FF3724B3F06F0SN1PR12MB2365namp_--

--===============1543103565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1543103565==--
