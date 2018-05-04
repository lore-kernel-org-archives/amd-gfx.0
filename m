From: "Abramov, Slava" <Slava.Abramov-5C7GfCeVMHo@public.gmane.org>
Subject: Re: GPU hang trying to run OpenCL kernels on x86_64
Date: Fri, 4 May 2018 18:18:54 +0000
Message-ID: <CY4PR12MB13045EA9BCBFAB20D698BA86FE860@CY4PR12MB1304.namprd12.prod.outlook.com>
References: <CAEzXK1p3SnOnduP0nL1D1pNWH1LTWwApEs7QnQPTFDdBBiHLXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1415799302=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAEzXK1p3SnOnduP0nL1D1pNWH1LTWwApEs7QnQPTFDdBBiHLXA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?iso-8859-1?Q?Lu=EDs_Mendes?= <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>

--===============1415799302==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB13045EA9BCBFAB20D698BA86FE860CY4PR12MB1304namp_"

--_000_CY4PR12MB13045EA9BCBFAB20D698BA86FE860CY4PR12MB1304namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Luis,


Can you please provide more details on your system environment and steps on=
 configuring the software and reproducing the issue?



Slava A

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Lu=EDs M=
endes <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, May 4, 2018 12:27:47 PM
To: amd-gfx list; Koenig, Christian; Michel D=E4nzer
Subject: GPU hang trying to run OpenCL kernels on x86_64

Hi,

I am a collaborator with Syncleus/aparapi project on github and I've
been testing OpenCL on AMD and NVIDIA cards.

Currently I have a set of kernels that hang the GPU (AMD RX 460 and
AMD RX 550) across all compute units on x86_64 running vanilla kernel
4.16.7 on Ubuntu 18.04, also on Ubuntu 16.04.4 with AMDGPU PRO 17.50
and 18.10 show the same problems, in fact, AMDGPU-PRO 18.10 is even
worse.

However the same set of kernels run happily on armhf with vanilla
Linux 4.16.7 and mesa 18.0 (mesa-opencl-icd and libclc for amdgcn),
Ubuntu 17.10, on an AMD RX460 and an AMD RX 550.

Lu=EDs Mendes
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB13045EA9BCBFAB20D698BA86FE860CY4PR12MB1304namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Luis,</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Can you please provide more detai=
ls on your system environment and steps on configuring the software and rep=
roducing the issue?</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Slava A</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Lu=EDs Mendes &lt;luis.p.mend=
es-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, May 4, 2018 12:27:47 PM<br>
<b>To:</b> amd-gfx list; Koenig, Christian; Michel D=E4nzer<br>
<b>Subject:</b> GPU hang trying to run OpenCL kernels on x86_64</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi,<br>
<br>
I am a collaborator with Syncleus/aparapi project on github and I've<br>
been testing OpenCL on AMD and NVIDIA cards.<br>
<br>
Currently I have a set of kernels that hang the GPU (AMD RX 460 and<br>
AMD RX 550) across all compute units on x86_64 running vanilla kernel<br>
4.16.7 on Ubuntu 18.04, also on Ubuntu 16.04.4 with AMDGPU PRO 17.50<br>
and 18.10 show the same problems, in fact, AMDGPU-PRO 18.10 is even<br>
worse.<br>
<br>
However the same set of kernels run happily on armhf with vanilla<br>
Linux 4.16.7 and mesa 18.0 (mesa-opencl-icd and libclc for amdgcn),<br>
Ubuntu 17.10, on an AMD RX460 and an AMD RX 550.<br>
<br>
Lu=EDs Mendes<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB13045EA9BCBFAB20D698BA86FE860CY4PR12MB1304namp_--

--===============1415799302==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1415799302==--
