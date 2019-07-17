From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix offset for vmid selection in debugfs
 interface
Date: Wed, 17 Jul 2019 13:50:47 +0000
Message-ID: <BN6PR12MB1809B374579E8D82EBFCC151F7C90@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190716112434.29017-1-tom.stdenis@amd.com>
 <e6bc6d43-d4ac-467f-22b3-2be79619b93e@gmail.com>,
 <4d8fb065-f31b-d730-04d0-6c6e83b3a171@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0516494687=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <4d8fb065-f31b-d730-04d0-6c6e83b3a171-5C7GfCeVMHo@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0516494687==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809B374579E8D82EBFCC151F7C90BN6PR12MB1809namp_"

--_000_BN6PR12MB1809B374579E8D82EBFCC151F7C90BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

RB,

thanks,

Alex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of StDenis,=
 Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, July 17, 2019 8:44 AM
To: Koenig, Christian; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amd/amdgpu: Fix offset for vmid selection in debug=
fs interface

Thanks.


Alex can I grab an R-b please?


Cheers,

Tom

On 2019-07-16 7:30 a.m., Christian K=F6nig wrote:
> Am 16.07.19 um 13:24 schrieb StDenis, Tom:
>> The register debugfs interface was using the wrong bitmask for vmid
>> selection for GFX_CNTL.
>>
>> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
>
> Acked-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 87b32873046f..59849ed9797d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -132,7 +132,7 @@ static int amdgpu_debugfs_process_reg_op(bool
>> read, struct file *f,
>>           me =3D (*pos & GENMASK_ULL(33, 24)) >> 24;
>>           pipe =3D (*pos & GENMASK_ULL(43, 34)) >> 34;
>>           queue =3D (*pos & GENMASK_ULL(53, 44)) >> 44;
>> -        vmid =3D (*pos & GENMASK_ULL(48, 45)) >> 54;
>> +        vmid =3D (*pos & GENMASK_ULL(58, 54)) >> 54;
>>             use_ring =3D 1;
>>       } else {
>
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809B374579E8D82EBFCC151F7C90BN6PR12MB1809namp_
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
RB,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
thanks,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of StDenis, Tom &lt;Tom.StDenis@=
amd.com&gt;<br>
<b>Sent:</b> Wednesday, July 17, 2019 8:44 AM<br>
<b>To:</b> Koenig, Christian; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amd/amdgpu: Fix offset for vmid selection i=
n debugfs interface</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Thanks.<br>
<br>
<br>
Alex can I grab an R-b please?<br>
<br>
<br>
Cheers,<br>
<br>
Tom<br>
<br>
On 2019-07-16 7:30 a.m., Christian K=F6nig wrote:<br>
&gt; Am 16.07.19 um 13:24 schrieb StDenis, Tom:<br>
&gt;&gt; The register debugfs interface was using the wrong bitmask for vmi=
d<br>
&gt;&gt; selection for GFX_CNTL.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Tom St Denis &lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;<br>
&gt; Acked-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 &#43;-<br>
&gt;&gt; &nbsp; 1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
&gt;&gt; index 87b32873046f..59849ed9797d 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
&gt;&gt; @@ -132,7 &#43;132,7 @@ static int amdgpu_debugfs_process_reg_op(b=
ool <br>
&gt;&gt; read, struct file *f,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; me =3D (*po=
s &amp; GENMASK_ULL(33, 24)) &gt;&gt; 24;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe =3D (*=
pos &amp; GENMASK_ULL(43, 34)) &gt;&gt; 34;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue =3D (=
*pos &amp; GENMASK_ULL(53, 44)) &gt;&gt; 44;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vmid =3D (*pos &amp; G=
ENMASK_ULL(48, 45)) &gt;&gt; 54;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vmid =3D (*pos &am=
p; GENMASK_ULL(58, 54)) &gt;&gt; 54;<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; use_=
ring =3D 1;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809B374579E8D82EBFCC151F7C90BN6PR12MB1809namp_--

--===============0516494687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0516494687==--
