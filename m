From: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Make amdgpu_bo_reserve use uninterruptible
 waits for cleanup
Date: Tue, 2 May 2017 14:35:49 +0000
Message-ID: <MWHPR1201MB0045EC1F62D7FDABDC976CC3F2170@MWHPR1201MB0045.namprd12.prod.outlook.com>
References: <mailman.1551.1493369856.21890.amd-gfx@lists.freedesktop.org>
 <MWHPR1201MB0045C097101B0EDA13F28BD9F2130@MWHPR1201MB0045.namprd12.prod.outlook.com>
 <73b82af4-7903-512e-fe61-f05ebf18381f@daenzer.net>
 <MWHPR1201MB004532EF4E87E5503BEAC217F2140@MWHPR1201MB0045.namprd12.prod.outlook.com>,
 <064b2ea6-1b57-0c4d-0818-6eb017887e55@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1914385262=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <064b2ea6-1b57-0c4d-0818-6eb017887e55-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1914385262==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR1201MB0045EC1F62D7FDABDC976CC3F2170MWHPR1201MB0045_"

--_000_MWHPR1201MB0045EC1F62D7FDABDC976CC3F2170MWHPR1201MB0045_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I just realised that there are some stress test that sends huge amount of s=
ignals. I used those tests in the pass 2 years...


-Alex Bin

________________________________
From: Christian K=F6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Sent: Monday, May 1, 2017 10:28 AM
To: Xie, AlexBin; Michel D=E4nzer
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amdgpu: Make amdgpu_bo_reserve use uninterruptible=
 waits for cleanup

Am 01.05.2017 um 02:13 schrieb Xie, AlexBin:

On 28/04/17 11:12 PM, Xie, AlexBin wrote:

>> Am 28.04.2017 um 10:47 schrieb Michel D=E4nzer:
>>> From: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org><mailto:michel.daenzer@am=
d.com>
>>>
>>> Some of these paths probably cannot be interrupted by a signal anyway.
>>> Those that can would fail to clean up things if they actually got
>>> interrupted.
>>>
>>> Signed-off-by: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org><mailto:michel.d=
aenzer-5C7GfCeVMHo@public.gmane.org>
>>
>> Reviewed-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org><mailto:christi=
an.koenig-5C7GfCeVMHo@public.gmane.org>
>
> Alex X: Just a reminder: amdgpu_unpin_work_func is called by work queue.
> Signal is blocked already. un-interruptible waiting might slow thing
> down very slightly.

How so?

Alex X: I said "might". If you think it is not slower, it is fine for me.
My real concern is that the signals are blocked for work queue already. We =
don't need this change to avoid unnecessary risk.
In theory, I am not against this change.

I have to agree with that. For waits from work queues it is usually best to=
 implicitly use un-interruptible waits for documentation purposes.

In other words even when we are sure that the code can't receive a signal w=
e should write it conservatively.

Christian.


--
Earthling Michel D=E4nzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer



_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--_000_MWHPR1201MB0045EC1F62D7FDABDC976CC3F2170MWHPR1201MB0045_
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
<p>I just realised that&nbsp;there are&nbsp;some&nbsp;stress test that send=
s huge amount of signals. I used those tests in the pass 2 years...</p>
<p><br>
</p>
<p><span style=3D"font-size: 12pt;">-Alex Bin</span><br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Christian K=F6nig &lt=
;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, May 1, 2017 10:28 AM<br>
<b>To:</b> Xie, AlexBin; Michel D=E4nzer<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Make amdgpu_bo_reserve use uninterr=
uptible waits for cleanup</font>
<div>&nbsp;</div>
</div>
<div>
<div class=3D"moz-cite-prefix">Am 01.05.2017 um 02:13 schrieb Xie, AlexBin:=
<br>
</div>
<blockquote type=3D"cite">
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p><span style=3D"font-size:10pt">On 28/04/17 11:12 PM, Xie, AlexBin wrote:=
</span><br>
</p>
<div style=3D"color:rgb(0,0,0)"><font size=3D"2"><span style=3D"font-size:1=
0pt">
<div class=3D"PlainText">&gt;&gt; Am 28.04.2017 um 10:47 schrieb Michel D=
=E4nzer:<br>
&gt;&gt;&gt; From: Michel D=E4nzer <a class=3D"moz-txt-link-rfc2396E" href=
=3D"mailto:michel.daenzer-5C7GfCeVMHo@public.gmane.org">
&lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Some of these paths probably cannot be interrupted by a signal=
 anyway.<br>
&gt;&gt;&gt; Those that can would fail to clean up things if they actually =
got<br>
&gt;&gt;&gt; interrupted.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Michel D=E4nzer <a class=3D"moz-txt-link-rfc239=
6E" href=3D"mailto:michel.daenzer-5C7GfCeVMHo@public.gmane.org">
&lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
&gt;&gt; <br>
&gt;&gt; Reviewed-by: Christian K=F6nig <a class=3D"moz-txt-link-rfc2396E" =
href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">
&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
&gt; <br>
&gt; Alex X: Just a reminder: amdgpu_unpin_work_func is called by work queu=
e.<br>
&gt; Signal is blocked already. un-interruptible waiting might slow thing<b=
r>
&gt; down very slightly.<br>
<br>
How so?<br>
<br>
Alex X: I said &quot;might&quot;. If you think it is not slower, it is fine=
 for me.</div>
<div class=3D"PlainText">My real concern is that the signals are blocked fo=
r work queue already. We don't need this change to avoid unnecessary risk.<=
/div>
<div class=3D"PlainText">In theory,&nbsp;I am not&nbsp;against this change.=
</div>
</span></font></div>
</div>
</blockquote>
<br>
I have to agree with that. For waits from work queues it is usually best to=
 implicitly use un-interruptible waits for documentation purposes.<br>
<br>
In other words even when we are sure that the code can't receive a signal w=
e should write it conservatively.<br>
<br>
Christian.<br>
<br>
<blockquote type=3D"cite">
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<div style=3D"color:rgb(0,0,0)"><font size=3D"2"><span style=3D"font-size:1=
0pt">
<div class=3D"PlainText"><br>
-- <br>
Earthling Michel D=E4nzer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"http://www.amd.com=
" id=3D"LPlnk108541" previewremoved=3D"true">
http://www.amd.com</a><br>
Libre software enthusiast&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; Mesa and X developer<br>
</div>
</span></font></div>
</div>
<br>
<fieldset class=3D"mimeAttachmentHeader"></fieldset> <br>
<pre>_______________________________________________=0A=
amd-gfx mailing list=0A=
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>=0A=
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.freedesktop.org/ma=
ilman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-=
gfx</a>=0A=
</pre>
</blockquote>
<p><br>
</p>
</div>
</div>
</div>
</body>
</html>

--_000_MWHPR1201MB0045EC1F62D7FDABDC976CC3F2170MWHPR1201MB0045_--

--===============1914385262==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1914385262==--
