From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: regression in dcn linked to -msse2
Date: Tue, 29 Jan 2019 15:29:07 +0000
Message-ID: <BN6PR12MB1809AE3868C23EBAC01ABD69F7970@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <c4dcefcd-1eab-1915-c3aa-30524e275bf7@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0822453259=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c4dcefcd-1eab-1915-c3aa-30524e275bf7-5C7GfCeVMHo@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0822453259==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809AE3868C23EBAC01ABD69F7970BN6PR12MB1809namp_"

--_000_BN6PR12MB1809AE3868C23EBAC01ABD69F7970BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

See:

https://bugs.freedesktop.org/show_bug.cgi?id=3D109487


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of StDenis,=
 Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, January 29, 2019 8:44:03 AM
To: Wentland, Harry; amd-gfx mailing list
Cc: Deucher, Alexander
Subject: regression in dcn linked to -msse2

Testing with the new 5.0.0-rc1 amd-staging-drm-next branch results in
this commit causing the attached lockup on init with my Raven + Polaris
system:

10117450735c7a7c0858095fb46a860e7037cb9a is the first bad commit
commit 10117450735c7a7c0858095fb46a860e7037cb9a
Author: ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org <ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Date:   Thu Jan 24 16:52:59 2019 -0800

     drm/amd/display: add -msse2 to prevent Clang from emitting libcalls
to undefined SW FP routines

     arch/x86/Makefile disables SSE and SSE2 for the whole kernel.  The
     AMDGPU drivers modified in this patch re-enable SSE but not SSE2.  Tur=
n
     on SSE2 to support emitting double precision floating point
instructions
     rather than calls to non-existent (usually available from gcc_s or
     compiler_rt) floating point helper routines.

     Link:
https://gcc.gnu.org/onlinedocs/gccint/Soft-float-library-routines.html
     Link: https://github.com/ClangBuiltLinux/linux/issues/327
     Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org # 4.19
     Reported-by: S, Shirish <Shirish.S-5C7GfCeVMHo@public.gmane.org>
     Reported-by: Matthias Kaehlcke <mka-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
     Suggested-by: James Y Knight <jyknight-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
     Suggested-by: Nathan Chancellor <natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
     Signed-off-by: Nick Desaulniers <ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
     Tested-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
     Tested-by:  Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
     Tested-by: Nathan Chancellor <natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
     Reviewed-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
     Signed-off-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
     Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

:040000 040000 39f89ea177b8a69a3a2aa098aef8b1a7e58056b9
71edb262be0608ffae0996253f47492b2e714b5c M      drivers


Cheers,
Tom

--_000_BN6PR12MB1809AE3868C23EBAC01ABD69F7970BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">See:</p>
<p style=3D"margin-top:0;margin-bottom:0"><a href=3D"https://bugs.freedeskt=
op.org/show_bug.cgi?id=3D109487" class=3D"OWAAutoLink" id=3D"LPlnk459832" p=
reviewremoved=3D"true">https://bugs.freedesktop.org/show_bug.cgi?id=3D10948=
7</a></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of StDenis, Tom &lt;Tom.StDenis@=
amd.com&gt;<br>
<b>Sent:</b> Tuesday, January 29, 2019 8:44:03 AM<br>
<b>To:</b> Wentland, Harry; amd-gfx mailing list<br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> regression in dcn linked to -msse2</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Testing with the new 5.0.0-rc1 amd-staging-drm-nex=
t branch results in
<br>
this commit causing the attached lockup on init with my Raven &#43; Polaris=
 <br>
system:<br>
<br>
10117450735c7a7c0858095fb46a860e7037cb9a is the first bad commit<br>
commit 10117450735c7a7c0858095fb46a860e7037cb9a<br>
Author: ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org &lt;ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org&gt;<br>
Date:&nbsp;&nbsp; Thu Jan 24 16:52:59 2019 -0800<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; drm/amd/display: add -msse2 to prevent Clang from =
emitting libcalls <br>
to undefined SW FP routines<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; arch/x86/Makefile disables SSE and SSE2 for the wh=
ole kernel.&nbsp; The<br>
&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU drivers modified in this patch re-enable SS=
E but not SSE2.&nbsp; Turn<br>
&nbsp;&nbsp;&nbsp;&nbsp; on SSE2 to support emitting double precision float=
ing point <br>
instructions<br>
&nbsp;&nbsp;&nbsp;&nbsp; rather than calls to non-existent (usually availab=
le from gcc_s or<br>
&nbsp;&nbsp;&nbsp;&nbsp; compiler_rt) floating point helper routines.<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; Link: <br>
<a href=3D"https://gcc.gnu.org/onlinedocs/gccint/Soft-float-library-routine=
s.html">https://gcc.gnu.org/onlinedocs/gccint/Soft-float-library-routines.h=
tml</a><br>
&nbsp;&nbsp;&nbsp;&nbsp; Link: <a href=3D"https://github.com/ClangBuiltLinu=
x/linux/issues/327">https://github.com/ClangBuiltLinux/linux/issues/327</a>=
<br>
&nbsp;&nbsp;&nbsp;&nbsp; Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org # 4.19<br>
&nbsp;&nbsp;&nbsp;&nbsp; Reported-by: S, Shirish &lt;Shirish.S-5C7GfCeVMHo@public.gmane.org&gt;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp; Reported-by: Matthias Kaehlcke &lt;mka-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org&=
gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp; Suggested-by: James Y Knight &lt;jyknight@google.c=
om&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp; Suggested-by: Nathan Chancellor &lt;natechancellor=
@gmail.com&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp; Signed-off-by: Nick Desaulniers &lt;ndesaulniers@g=
oogle.com&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp; Tested-by: Guenter Roeck &lt;linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org&gt=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp; Tested-by:&nbsp; Matthias Kaehlcke &lt;mka@chromiu=
m.org&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp; Tested-by: Nathan Chancellor &lt;natechancellor@gm=
ail.com&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp; Reviewed-by: Harry Wentland &lt;harry.wentland@amd=
.com&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp; Signed-off-by: Harry Wentland &lt;harry.wentland@a=
md.com&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp; Signed-off-by: Alex Deucher &lt;alexander.deucher@=
amd.com&gt;<br>
<br>
:040000 040000 39f89ea177b8a69a3a2aa098aef8b1a7e58056b9 <br>
71edb262be0608ffae0996253f47492b2e714b5c M&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dr=
ivers<br>
<br>
<br>
Cheers,<br>
Tom<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809AE3868C23EBAC01ABD69F7970BN6PR12MB1809namp_--

--===============0822453259==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0822453259==--
