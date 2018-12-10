From: "Bridgman, John" <John.Bridgman-5C7GfCeVMHo@public.gmane.org>
Subject: Re: amdkfd build regression if HSA_AMD is disabled
Date: Mon, 10 Dec 2018 16:25:58 +0000
Message-ID: <BLUPR12MB0417CFE7A884631B15F60C3FE8A50@BLUPR12MB0417.namprd12.prod.outlook.com>
References: <83a3516c-b517-97d8-6ccf-b439e3ec742e@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1156537705=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <83a3516c-b517-97d8-6ccf-b439e3ec742e-5C7GfCeVMHo@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: "Huang, JinHuiEric" <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1156537705==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_BLUPR12MB0417CFE7A884631B15F60C3FE8A50BLUPR12MB0417namp_"

--_000_BLUPR12MB0417CFE7A884631B15F60C3FE8A50BLUPR12MB0417namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Do we still need the HSA_AMD option ?


Seems to me that KFD stopped being "something we only sometimes include" a =
long time ago.


Thanks,
John

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of StDenis,=
 Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Sent: December 10, 2018 10:02 AM
To: Kuehling, Felix
Cc: Huang, JinHuiEric; Deucher, Alexander; amd-gfx mailing list
Subject: amdkfd build regression if HSA_AMD is disabled

Hi All,

The commit:

commit 62f65d3cb34a8300bf1e07fc478e03c3c02634d4
Refs: v4.20-rc3-524-g62f65d3cb34a
Author:     Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
AuthorDate: Mon Nov 19 20:05:54 2018 -0500
Commit:     Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
CommitDate: Fri Dec 7 17:17:11 2018 -0500

     drm/amdgpu: Add KFD VRAM limit checking

     We don't want KFD processes evicting each other over VRAM usage.
     Therefore prevent overcommitting VRAM among KFD applications with
     a per-GPU limit. Also leave enough room for page tables on top
     of the application memory usage.

     Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
     Reviewed-by: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
     Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

Breaks the build if HSA_AMD is not enabled:

scripts/kconfig/conf  --syncconfig Kconfig
   DESCEND  objtool
   CALL    scripts/checksyscalls.sh
   CHK     include/generated/compile.h
   Building modules, stage 2.
   MODPOST 63 modules
Kernel: arch/x86/boot/bzImage is ready  (#58)
ERROR: "amdgpu_amdkfd_unreserve_memory_limit"
[drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
make[1]: *** [scripts/Makefile.modpost:92: __modpost] Error 1
make: *** [Makefile:1271: modules] Error 2

This is because the function being used is not included in the build
(the previous function called was part of amdgpu_amdkfd.c which is
unconditionally built).

Cheers,
Tom
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BLUPR12MB0417CFE7A884631B15F60C3FE8A50BLUPR12MB0417namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Do we still need the HSA_AMD opti=
on ? <br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Seems to me that KFD stopped bein=
g &quot;something we only sometimes include&quot; a long time ago.
<br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Thanks,<br>
John<br>
</p>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of StDenis, Tom &lt;Tom.StDeni=
s@amd.com&gt;<br>
<b>Sent:</b> December 10, 2018 10:02 AM<br>
<b>To:</b> Kuehling, Felix<br>
<b>Cc:</b> Huang, JinHuiEric; Deucher, Alexander; amd-gfx mailing list<br>
<b>Subject:</b> amdkfd build regression if HSA_AMD is disabled</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi All,<br>
<br>
The commit:<br>
<br>
commit 62f65d3cb34a8300bf1e07fc478e03c3c02634d4<br>
Refs: v4.20-rc3-524-g62f65d3cb34a<br>
Author:&nbsp;&nbsp;&nbsp;&nbsp; Felix Kuehling &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
AuthorDate: Mon Nov 19 20:05:54 2018 -0500<br>
Commit:&nbsp;&nbsp;&nbsp;&nbsp; Felix Kuehling &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
CommitDate: Fri Dec 7 17:17:11 2018 -0500<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; drm/amdgpu: Add KFD VRAM limit checking<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; We don't want KFD processes evicting each other ov=
er VRAM usage.<br>
&nbsp;&nbsp;&nbsp;&nbsp; Therefore prevent overcommitting VRAM among KFD ap=
plications with<br>
&nbsp;&nbsp;&nbsp;&nbsp; a per-GPU limit. Also leave enough room for page t=
ables on top<br>
&nbsp;&nbsp;&nbsp;&nbsp; of the application memory usage.<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; Signed-off-by: Felix Kuehling &lt;Felix.Kuehling@a=
md.com&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp; Reviewed-by: Eric Huang &lt;JinHuiEric.Huang@amd.c=
om&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp; Acked-by: Alex Deucher &lt;alexander.deucher@amd.c=
om&gt;<br>
<br>
Breaks the build if HSA_AMD is not enabled:<br>
<br>
scripts/kconfig/conf&nbsp; --syncconfig Kconfig<br>
&nbsp;&nbsp; DESCEND&nbsp; objtool<br>
&nbsp;&nbsp; CALL&nbsp;&nbsp;&nbsp; scripts/checksyscalls.sh<br>
&nbsp;&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; include/generated/compile.h<br>
&nbsp;&nbsp; Building modules, stage 2.<br>
&nbsp;&nbsp; MODPOST 63 modules<br>
Kernel: arch/x86/boot/bzImage is ready&nbsp; (#58)<br>
ERROR: &quot;amdgpu_amdkfd_unreserve_memory_limit&quot; <br>
[drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!<br>
make[1]: *** [scripts/Makefile.modpost:92: __modpost] Error 1<br>
make: *** [Makefile:1271: modules] Error 2<br>
<br>
This is because the function being used is not included in the build <br>
(the previous function called was part of amdgpu_amdkfd.c which is <br>
unconditionally built).<br>
<br>
Cheers,<br>
Tom<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BLUPR12MB0417CFE7A884631B15F60C3FE8A50BLUPR12MB0417namp_--

--===============1156537705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1156537705==--
