From: "Francis, David" <David.Francis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] amd/dc/dce100: On dce100, set clocks to 0 on suspend
Date: Thu, 12 Jul 2018 14:29:13 +0000
Message-ID: <MWHPR12MB145499B669E900D08C641195EF590@MWHPR12MB1454.namprd12.prod.outlook.com>
References: <20180712140749.7706-1-David.Francis@amd.com>
 <2d781fe6-b6e4-efbc-43fe-1249e211300d@amd.com>,
 <1d3973cb-75c5-10e1-866e-e323b175a6de@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1339938251=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1d3973cb-75c5-10e1-866e-e323b175a6de-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1339938251==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB145499B669E900D08C641195EF590MWHPR12MB1454namp_"

--_000_MWHPR12MB145499B669E900D08C641195EF590MWHPR12MB1454namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Upon closer inspection, this does not match any FDO bug.  The FDO bug I tho=
ught this was related to was fixed by Michel Danzer, and this fixes an enti=
rely separate issue.

________________________________
From: Michel D=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Sent: July 12, 2018 10:18:34 AM
To: Wentland, Harry; Francis, David; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] amd/dc/dce100: On dce100, set clocks to 0 on suspend

On 2018-07-12 04:13 PM, Harry Wentland wrote:
> On 2018-07-12 10:07 AM, David Francis wrote:
>> [Why]
>> When a dce100 asic was suspended, the clocks were not set to 0.
>> Upon resume, the new clock was compared to the existing clock,
>> they were found to be the same, and so the clock was not set.
>> This resulted in a pernicious blackscreen.
>>
>> [How]
>> In atomic commit, check to see if there are any active pipes.
>> If no, set clocks to 0
>>
>
> Please add Fixes: tag with link to freedesktop bugzilla bug that this fix=
es.

That would be

Bugzilla: https://...

(the Fixes tag is for referencing another commit which is fixed by this one=
)


--
Earthling Michel D=E4nzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--_000_MWHPR12MB145499B669E900D08C641195EF590MWHPR12MB1454namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Upon closer inspection, this does=
 not match any FDO bug.&nbsp; The FDO bug I thought this was related to was=
 fixed by Michel Danzer, and this fixes an entirely separate issue.</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Michel D=E4nzer &lt;m=
ichel-otUistvHUpPR7s880joybQ@public.gmane.org&gt;<br>
<b>Sent:</b> July 12, 2018 10:18:34 AM<br>
<b>To:</b> Wentland, Harry; Francis, David; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<b=
r>
<b>Subject:</b> Re: [PATCH] amd/dc/dce100: On dce100, set clocks to 0 on su=
spend</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2018-07-12 04:13 PM, Harry Wentland wrote:<br>
&gt; On 2018-07-12 10:07 AM, David Francis wrote:<br>
&gt;&gt; [Why]<br>
&gt;&gt; When a dce100 asic was suspended, the clocks were not set to 0.<br=
>
&gt;&gt; Upon resume, the new clock was compared to the existing clock,<br>
&gt;&gt; they were found to be the same, and so the clock was not set.<br>
&gt;&gt; This resulted in a pernicious blackscreen.<br>
&gt;&gt;<br>
&gt;&gt; [How]<br>
&gt;&gt; In atomic commit, check to see if there are any active pipes.<br>
&gt;&gt; If no, set clocks to 0<br>
&gt;&gt;<br>
&gt; <br>
&gt; Please add Fixes: tag with link to freedesktop bugzilla bug that this =
fixes.<br>
<br>
That would be<br>
<br>
Bugzilla: <a href=3D"https://">https://</a>...<br>
<br>
(the Fixes tag is for referencing another commit which is fixed by this one=
)<br>
<br>
<br>
-- <br>
Earthling Michel D=E4nzer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"http://www.amd.com=
">
http://www.amd.com</a><br>
Libre software enthusiast&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; Mesa and X developer<br>
</div>
</span></font></div>
</body>
</html>

--_000_MWHPR12MB145499B669E900D08C641195EF590MWHPR12MB1454namp_--

--===============1339938251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1339938251==--
