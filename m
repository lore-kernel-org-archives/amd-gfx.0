From: Hillf Danton <hdanton-k+cT0dCbe1g@public.gmane.org>
Subject: Re: gnome-shell stuck because of amdgpu driver [5.3 RC5]
Date: Tue, 3 Sep 2019 16:21:42 +0800
Message-ID: <20190904071657.C338B89307@gabe.freedesktop.org>
References: <20190830032948.13516-1-hdanton@sina.com>
 <CABXGCsNywbo90+wgiZ64Srm-KexypTbjiviwTW_BsO9Pm11GKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0156928893=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CABXGCsNywbo90+wgiZ64Srm-KexypTbjiviwTW_BsO9Pm11GKQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Mikhail Gavrilov <mikhail.v.gavrilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--===============0156928893==
Content-Type: multipart/alternative;
	boundary="_32C85ED2-0338-4B2A-A8C8-E35FD2FB74F0_"


--_32C85ED2-0338-4B2A-A8C8-E35FD2FB74F0_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tue, 3 Sep 2019 11:48:12 +0500 From:   Mikhail Gavrilov <mikhail.v.gavri=
lov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> On Fri, 30 Aug 2019 at 08:30, Hillf Danton <hdanton-k+cT0dCbe1g@public.gmane.org> wrote:
> >
> > Add a warning to show if it makes sense in field: neither regression no=
r
> > problem will have been observed with the warning printed.
>
> I caught the problem.
>=20
>
> [21793.094289] ------------[ cut here ]------------
> [21793.094296] gnome shell stuck warning
> [21793.094391] WARNING: CPU: 14 PID: 1768 at
> drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:332
>
Thanks Mike.

Describe the problems you are experiencing please.
Say is the screen locked up? Machine lockedup?=20
Anything unnormal after you see the warning?

Hillf

--_32C85ED2-0338-4B2A-A8C8-E35FD2FB74F0_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="utf-8"

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta ht=
tp-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8"><meta name=
=3DGenerator content=3D"Microsoft Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:DengXian;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.DefaultFontHxMailStyle
	{mso-style-name:"Default Font HxMail Style";
	font-family:DengXian;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
.MsoChpDefault
	{mso-style-type:export-only;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style></head><body lang=3DZH-CN link=3Dblue vlink=3D"#954F72"><div cla=
ss=3DWordSection1><p class=3DMsoNormal><span class=3DDefaultFontHxMailStyle=
><span lang=3DEN-US>On Tue, 3 Sep 2019 11:48:12 +0500 From:=C2=A0=C2=A0 Mik=
hail Gavrilov &lt;mikhail.v.gavrilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<o:p></o:p></span></span>=
</p><p class=3DMsoNormal><span lang=3DEN-US>&gt; On Fri, 30 Aug 2019 at 08:=
30, Hillf Danton &lt;hdanton-k+cT0dCbe1g@public.gmane.org&gt; wrote:</span></p><p class=3DMsoNo=
rmal><span lang=3DEN-US>&gt; &gt;</span></p><p class=3DMsoNormal><span lang=
=3DEN-US>&gt; &gt; Add a warning to show if it makes sense in field: neithe=
r regression nor</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; &gt=
; problem will have been observed with the warning printed.</span></p><p cl=
ass=3DMsoNormal><span lang=3DEN-US>&gt;<o:p>&nbsp;</o:p></span></p><p class=
=3DMsoNormal><span lang=3DEN-US>&gt; I caught the problem.</span></p><p cla=
ss=3DMsoNormal><span lang=3DEN-US>&gt; </span></p><p class=3DMsoNormal><spa=
n lang=3DEN-US>&gt;<o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span l=
ang=3DEN-US>&gt; [21793.094289] ------------[ cut here ]------------</span>=
</p><p class=3DMsoNormal><span lang=3DEN-US>&gt; [21793.094296] gnome shell=
 stuck warning</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; [2179=
3.094391] WARNING: CPU: 14 PID: 1768 at</span></p><p class=3DMsoNormal><spa=
n lang=3DEN-US>&gt; drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:332</span></p=
><p class=3DMsoNormal><span lang=3DEN-US>&gt;<o:p>&nbsp;</o:p></span></p><p=
 class=3DMsoNormal><span lang=3DEN-US>Thanks Mike.</span></p><p class=3DMso=
Normal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal>=
<span class=3DDefaultFontHxMailStyle><span lang=3DEN-US>Describe the proble=
ms you are experiencing please.<o:p></o:p></span></span></p><p class=3DMsoN=
ormal><span class=3DDefaultFontHxMailStyle><span lang=3DEN-US>Say is the sc=
reen locked up? Machine lockedup? <o:p></o:p></span></span></p><p class=3DM=
soNormal><span class=3DDefaultFontHxMailStyle><span lang=3DEN-US>Anything u=
nnormal after you see the warning?<o:p></o:p></span></span></p><p class=3DM=
soNormal><span class=3DDefaultFontHxMailStyle><span lang=3DEN-US><o:p>&nbsp=
;</o:p></span></span></p><p class=3DMsoNormal><span class=3DDefaultFontHxMa=
ilStyle><span lang=3DEN-US>Hillf<o:p></o:p></span></span></p></div></body><=
/html>=

--_32C85ED2-0338-4B2A-A8C8-E35FD2FB74F0_--



--===============0156928893==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0156928893==--
