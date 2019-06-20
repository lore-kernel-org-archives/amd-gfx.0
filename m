From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: amdgpu vce crash
Date: Thu, 20 Jun 2019 14:30:42 +0000
Message-ID: <BN6PR12MB18093551FEFE5590951747C8F7E40@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <tencent_969412320833AB29CB6FA2732FC516257905@qq.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1771031347=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <tencent_969412320833AB29CB6FA2732FC516257905-9uewiaClKEY@public.gmane.org>
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
To: CCXIAOP <664296544-9uewiaClKEY@public.gmane.org>, amd-gfx <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1771031347==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18093551FEFE5590951747C8F7E40BN6PR12MB1809namp_"

--_000_BN6PR12MB18093551FEFE5590951747C8F7E40BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

If any of the engines hang, you can end up with a deadlock if you schedule =
dependencies across rings since one of the engines is hung.  If you try a n=
ewer kernel, GPU reset is enabled and you should be able to recover after a=
 hang.  At that point, you can either restart your applications or use a re=
levant robustness API to properly handle a reset.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of CCXIAOP =
<664296544-9uewiaClKEY@public.gmane.org>
Sent: Wednesday, June 19, 2019 5:28 AM
To: amd-gfx
Subject: amdgpu vce crash

We are using wx5100 for rendering and encoding operations, but sometimes we=
 encounter vce timeout and crash.
Is vce not a independent module in gpu?Why does it affect the rendering mod=
ule?
We hope that vce will not affect the rendering module when crashing.
Can I prevent the use of the rendering module from being affected?

linux kernel :4.19.34
mesa: 18.3.5
llvm: 7.0
firmware:18.50


As logs=1B$B!'=1B(B

2019-06-15T15:33:32.133842+08:00|err|kernel[-]|[315248.172603] [drm:amdgpu_=
job_timedout [amdgpu]] *ERROR* ring vce0 timeout, signaled seq=3D1173730, e=
mitted seq=3D1173732
2019-06-15T15:33:32.133939+08:00|info|kernel[-]|[315248.172607] [drm] GPU r=
ecovery disabled.


--_000_BN6PR12MB18093551FEFE5590951747C8F7E40BN6PR12MB1809namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
If any of the engines hang, you can end up with a deadlock if you schedule =
dependencies across rings since one of the engines is hung.&nbsp; If you tr=
y a newer kernel, GPU reset is enabled and you should be able to recover af=
ter a hang.&nbsp; At that point, you can either
 restart your applications or use a relevant robustness API to properly han=
dle a reset.</div>
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
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of CCXIAOP &lt;664296544-9uewiaClKEY@public.gmane.org&=
gt;<br>
<b>Sent:</b> Wednesday, June 19, 2019 5:28 AM<br>
<b>To:</b> amd-gfx<br>
<b>Subject:</b> amdgpu vce crash</font>
<div>&nbsp;</div>
</div>
<div>
<div>We are using wx5100 for rendering and encoding operations, but sometim=
es we encounter vce timeout and crash.</div>
<div>Is vce not a independent module in gpu?Why does it affect the renderin=
g module?<br>
</div>
We hope that vce will not affect the rendering module when crashing.<br>
<div>Can I prevent the use of the rendering module from being affected?</di=
v>
<div><br>
</div>
<div>linux kernel :4.19.34</div>
<div>mesa: 18.3.5</div>
<div>llvm: 7.0</div>
<div>firmware:18.50<br>
</div>
<div><br>
</div>
<br>
As logs=1B$B!'=1B(B<br>
<br>
2019-06-15T15:33:32.133842&#43;08:00|err|kernel[-]|[315248.172603] [drm:amd=
gpu_job_timedout [amdgpu]] *ERROR* ring vce0 timeout, signaled seq=3D117373=
0, emitted seq=3D1173732<br>
2019-06-15T15:33:32.133939&#43;08:00|info|kernel[-]|[315248.172607] [drm] G=
PU recovery disabled.<br>
<br>
</div>
</body>
</html>

--_000_BN6PR12MB18093551FEFE5590951747C8F7E40BN6PR12MB1809namp_--

--===============1771031347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1771031347==--
