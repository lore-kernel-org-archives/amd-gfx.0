From: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
Subject: RE: Deadlock on PTEs update for HMM
Date: Fri, 29 Nov 2019 00:35:15 +0000
Message-ID: <SN1PR12MB25916EE076E6BF5F5CBE3F8B80460@SN1PR12MB2591.namprd12.prod.outlook.com>
References: <SN6PR12MB26216A095D9839500242F489FD440@SN6PR12MB2621.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0895116236=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <SN6PR12MB26216A095D9839500242F489FD440-kxOKjb6HO/GMiSxbuvOENgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0895116236==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN1PR12MB25916EE076E6BF5F5CBE3F8B80460SN1PR12MB2591namp_"

--_000_SN1PR12MB25916EE076E6BF5F5CBE3F8B80460SN1PR12MB2591namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Is kmalloc with GFP_NOWAIT an option here?

Regards,
Oak

From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of Sierra G=
uiza, Alejandro (Alex)
Sent: Wednesday, November 27, 2019 9:55 AM
To: Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>; Kuehling, Felix <Felix.Ku=
ehling-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Deadlock on PTEs update for HMM

Hi Christian,
As you know, we're working on the HMM enablement. Im working on the dGPU pa=
ge table entries invalidation on the userptr mapping case. Currently, the M=
MU notifiers handle stops all user mode queues, schedule a delayed worker t=
o re-validate userptr mappings and restart the queues.
Part of the HMM functionality, we need to invalidate the page table entries=
 instead of stopping the queues. At the same time we need to move the reval=
idation of the userptr mappings into the page fault handler.
We're seeing a deadlock warning after we try to invalidate the PTEs inside =
the MMU notifier handler. More specific, when we try to update the BOs to i=
nvalidate PTEs using amdgpu_vm_bo_update. This uses kmalloc on the amdgpu_j=
ob_alloc which seems to be causing this problem.
Based on @Kuehling, Felix<mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org> comments, kmalloc =
without any special flags can cause memory reclaim. Doing that inside an MM=
U notifier is problematic, because an MMU notifier may be called inside a m=
emory-reclaim operation itself. That would result in recursion. Also, recla=
im shouldn't be done while holding a lock that can be taken in an MMU notif=
ier for the same reason. If you cause a reclaim while holding that lock, th=
en an MMU notifier called by the reclaim can deadlock trying to take the sa=
me lock.
Please let us know if you have any advice to enable this the right way

Thanks in advanced,
Alejandro


--_000_SN1PR12MB25916EE076E6BF5F5CBE3F8B80460SN1PR12MB2591namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:8.0pt;
	margin-left:0in;
	line-height:105%;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0in;margin-bottom:.0001pt;lin=
e-height:normal">
<o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Is kmalloc with GFP_NOWAIT an option here?<o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:0in;margin-bottom:.0001pt;lin=
e-height:normal">
Regards,<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:0in;margin-bottom:.0001pt;lin=
e-height:normal">
Oak<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:0in;margin-bottom:.0001pt;lin=
e-height:normal">
<b>From:</b> amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; <b>On Be=
half Of </b>
Sierra Guiza, Alejandro (Alex)<br>
<b>Sent:</b> Wednesday, November 27, 2019 9:55 AM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;; Kuehling, Fe=
lix &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Deadlock on PTEs update for HMM<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi Christian,<o:p></o:p></p>
<p class=3D"MsoNormal">As you know, we&#8217;re working on the HMM enableme=
nt. Im working on the dGPU page table entries invalidation on the userptr m=
apping case. Currently, the MMU notifiers handle stops all user mode queues=
, schedule a delayed worker to re-validate
 userptr mappings and restart the queues. <o:p></o:p></p>
<p class=3D"MsoNormal">Part of the HMM functionality, we need to invalidate=
 the page table entries instead of stopping the queues. At the same time we=
 need to move the revalidation of the userptr mappings into the page fault =
handler.<o:p></o:p></p>
<p class=3D"MsoNormal">We&#8217;re seeing a deadlock warning after we try t=
o invalidate the PTEs inside the MMU notifier handler. More specific, when =
we try to update the BOs to invalidate PTEs using amdgpu_vm_bo_update. This=
 uses kmalloc on the amdgpu_job_alloc which
 seems to be causing this problem.<o:p></o:p></p>
<p class=3D"MsoNormal">Based on <a id=3D"OWAAMBC6F9A316D814AE993661FC111776=
926" href=3D"mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org">
<span style=3D"font-family:&quot;Calibri&quot;,sans-serif;text-decoration:n=
one">@Kuehling, Felix</span></a> comments,
<span style=3D"font-size:10.5pt;line-height:105%;font-family:&quot;Segoe UI=
&quot;,sans-serif">
kmalloc without any special flags can cause memory reclaim. Doing that insi=
de an MMU notifier is problematic, because an MMU notifier may be called in=
side a memory-reclaim operation itself. That would result in recursion. Als=
o, reclaim shouldn't be done while
 holding a lock that can be taken in an MMU notifier for the same reason. I=
f you cause a reclaim while holding that lock, then an&nbsp;MMU notifier ca=
lled by the reclaim can&nbsp;deadlock trying to take the same lock.<o:p></o=
:p></span></p>
<p class=3D"MsoNormal">Please let us know if you have any advice to enable =
this the right way<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks in advanced,<o:p></o:p></p>
<p class=3D"MsoNormal">Alejandro<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_SN1PR12MB25916EE076E6BF5F5CBE3F8B80460SN1PR12MB2591namp_--

--===============0895116236==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0895116236==--
