From: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: Re: More specific libdrm error message
Date: Mon, 16 Jan 2017 22:00:41 +0000
Message-ID: <CY4PR12MB1640989B7A281937181286D4F27D0@CY4PR12MB1640.namprd12.prod.outlook.com>
References: <CY4PR12MB1640D019595EC5A1C6D1F670F2660@CY4PR12MB1640.namprd12.prod.outlook.com>
 <CY4PR12MB16409A6D631EA457A365ECF0F2660@CY4PR12MB1640.namprd12.prod.outlook.com>
 <CY4PR12MB16405027D18941DAF1D35A22F2660@CY4PR12MB1640.namprd12.prod.outlook.com>
 <2e756ad0-f6b9-7838-c09d-149d7624c529@folklore1984.net>,
 <CACvgo53sAL5p=jTzrZNP7T_8aSc6KyO4Phfkwy95j_r_0HbBLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2022064600=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CACvgo53sAL5p=jTzrZNP7T_8aSc6KyO4Phfkwy95j_r_0HbBLQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2022064600==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1640989B7A281937181286D4F27D0CY4PR12MB1640namp_"

--_000_CY4PR12MB1640989B7A281937181286D4F27D0CY4PR12MB1640namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Emil,


Thanks for the advice. I noticed that you have changed some tests using drm=
GetDevices2.

I mark this to my to do list.


Thanks,

Alex Bin Xie

________________________________
From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, January 12, 2017 2:26 PM
To: Edward O'Callaghan
Cc: Xie, AlexBin; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: More specific libdrm error message

On 12 January 2017 at 01:29, Edward O'Callaghan
<funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org> wrote:
> Hi Xie,
>
> Perhaps you want to use `fprintf(stderr, "...")` over `printf("..")` and
> lose the space before the start parenthesis. Also, line wrap
> your commit message.
>
> Side note, use git send-email so that the patch is inline and not a HTML
> email for easy review and application of the patch.
>
Thanks Edward.

Xie, suggesting to run almost anything as root is a bad idea ;-)
Instead one could auth, in order to have the correct permissions.
Alternatively can use the renderD node all together.

Idea for future work:
Would be even better to use drmGetDevices2 to fetch all the devices
and use the correct node since card0/renderD128 is not guaranteed to
be a amdgpu one. Or maybe even run all the amdgpu devices through the
tests ?

Please correctly wrap commit messages and code.

Thanks
Emil

--_000_CY4PR12MB1640989B7A281937181286D4F27D0CY4PR12MB1640namp_
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
<p>Hi Emil,</p>
<p><br>
</p>
<p>Thanks for the advice. I noticed that you have changed some tests using =
<span>
drmGetDevices2</span>.</p>
<p>I mark this to my to do list.<br>
</p>
<p><br>
</p>
<p>Thanks,</p>
<p>Alex Bin Xie<br>
</p>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Emil Velikov &lt;em=
il.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, January 12, 2017 2:26 PM<br>
<b>To:</b> Edward O'Callaghan<br>
<b>Cc:</b> Xie, AlexBin; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: More specific libdrm error message</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On 12 January 2017 at 01:29, Edward O'Callaghan<br=
>
&lt;funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org&gt; wrote:<br>
&gt; Hi Xie,<br>
&gt;<br>
&gt; Perhaps you want to use `fprintf(stderr, &quot;...&quot;)` over `print=
f(&quot;..&quot;)` and<br>
&gt; lose the space before the start parenthesis. Also, line wrap<br>
&gt; your commit message.<br>
&gt;<br>
&gt; Side note, use git send-email so that the patch is inline and not a HT=
ML<br>
&gt; email for easy review and application of the patch.<br>
&gt;<br>
Thanks Edward.<br>
<br>
Xie, suggesting to run almost anything as root is a bad idea ;-)<br>
Instead one could auth, in order to have the correct permissions.<br>
Alternatively can use the renderD node all together.<br>
<br>
Idea for future work:<br>
Would be even better to use drmGetDevices2 to fetch all the devices<br>
and use the correct node since card0/renderD128 is not guaranteed to<br>
be a amdgpu one. Or maybe even run all the amdgpu devices through the<br>
tests ?<br>
<br>
Please correctly wrap commit messages and code.<br>
<br>
Thanks<br>
Emil<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB1640989B7A281937181286D4F27D0CY4PR12MB1640namp_--

--===============2022064600==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2022064600==--
