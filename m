From: "Francis, David" <David.Francis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 17/26] drm/amd/display: implement PERF_TRACE on Linux
Date: Mon, 15 Oct 2018 14:51:46 +0000
Message-ID: <DM3PR1201MB1039270D0084B96880F3552FEFFD0@DM3PR1201MB1039.namprd12.prod.outlook.com>
References: <20181010220922.3864-1-Bhawanpreet.Lakha@amd.com>
 <20181010220922.3864-19-Bhawanpreet.Lakha@amd.com>
 <116c2a95-a249-88c7-ad6a-1b688f03b2c9@daenzer.net>,
 <d1083156-4246-1af2-1bb2-5bdb54455b99@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1303871173=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d1083156-4246-1af2-1bb2-5bdb54455b99-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1303871173==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_DM3PR1201MB1039270D0084B96880F3552FEFFD0DM3PR1201MB1039_"

--_000_DM3PR1201MB1039270D0084B96880F3552FEFFD0DM3PR1201MB1039_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Fully agreed.  Will redesign this.

________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: October 13, 2018 1:40:24 PM
To: Michel D=E4nzer; Lakha, Bhawanpreet
Cc: Francis, David; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 17/26] drm/amd/display: implement PERF_TRACE on Linux

Am 12.10.2018 um 18:56 schrieb Michel D=E4nzer:
> On 2018-10-11 12:09 a.m., Bhawanpreet Lakha wrote:
>> From: David Francis <David.Francis-5C7GfCeVMHo@public.gmane.org>
>>
>> [Why]
>> A quick-and-dirty way of getting performance data for the amdgpu
>> driver would make performance improvements easier
>>
>> [How]
>> The PERF_TRACE functionality is a tic-toc style debug method.
>> Put PERF_TRACE calls on either side of the code you want to test.
>> PERF_TRACE requires access to struct dc_context.  PERF_TRACE()
>> will pick up the CTX macro, and PERF_TRACE_CTX(struct dc_context)
>> allows you to pass the context explicitly.
>>
>> The last 20 results can be read through the debugfs entry
>> amdgpu_perf_trace.  Each result contains the time in ns and
>> number of GPU read/writes since the result before it.
>>
>> In my experimentation, each PERF_TRACE() call uses at most 700ns
> Should this use the Linux tracing infrastructure?

Yeah, agree that looks like reimplementing the tracing infrastructure to
me as well.

Christian.

--_000_DM3PR1201MB1039270D0084B96880F3552FEFFD0DM3PR1201MB1039_
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
<p style=3D"margin-top:0;margin-bottom:0">Fully agreed.&nbsp; Will redesign=
 this.&nbsp;&nbsp;</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> October 13, 2018 1:40:24 PM<br>
<b>To:</b> Michel D=E4nzer; Lakha, Bhawanpreet<br>
<b>Cc:</b> Francis, David; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 17/26] drm/amd/display: implement PERF_TRACE on =
Linux</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 12.10.2018 um 18:56 schrieb Michel D=E4nzer:<br=
>
&gt; On 2018-10-11 12:09 a.m., Bhawanpreet Lakha wrote:<br>
&gt;&gt; From: David Francis &lt;David.Francis-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt;<br>
&gt;&gt; [Why]<br>
&gt;&gt; A quick-and-dirty way of getting performance data for the amdgpu<b=
r>
&gt;&gt; driver would make performance improvements easier<br>
&gt;&gt;<br>
&gt;&gt; [How]<br>
&gt;&gt; The PERF_TRACE functionality is a tic-toc style debug method.<br>
&gt;&gt; Put PERF_TRACE calls on either side of the code you want to test.<=
br>
&gt;&gt; PERF_TRACE requires access to struct dc_context.&nbsp; PERF_TRACE(=
)<br>
&gt;&gt; will pick up the CTX macro, and PERF_TRACE_CTX(struct dc_context)<=
br>
&gt;&gt; allows you to pass the context explicitly.<br>
&gt;&gt;<br>
&gt;&gt; The last 20 results can be read through the debugfs entry<br>
&gt;&gt; amdgpu_perf_trace.&nbsp; Each result contains the time in ns and<b=
r>
&gt;&gt; number of GPU read/writes since the result before it.<br>
&gt;&gt;<br>
&gt;&gt; In my experimentation, each PERF_TRACE() call uses at most 700ns<b=
r>
&gt; Should this use the Linux tracing infrastructure?<br>
<br>
Yeah, agree that looks like reimplementing the tracing infrastructure to <b=
r>
me as well.<br>
<br>
Christian.<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM3PR1201MB1039270D0084B96880F3552FEFFD0DM3PR1201MB1039_--

--===============1303871173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1303871173==--
