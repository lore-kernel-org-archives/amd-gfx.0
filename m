From: Hillf Danton <hdanton-k+cT0dCbe1g@public.gmane.org>
Subject: Re: gnome-shell stuck because of amdgpu driver [5.3 RC5]
Date: Wed, 4 Sep 2019 09:17:16 +0800
Message-ID: <20190904071704.F315489B4D@gabe.freedesktop.org>
References: <20190830032948.13516-1-hdanton@sina.com>
 <CABXGCsNywbo90+wgiZ64Srm-KexypTbjiviwTW_BsO9Pm11GKQ@mail.gmail.com>
 <5d6e2298.1c69fb81.b5532.8395SMTPIN_ADDED_MISSING@mx.google.com>
 <CABXGCsMG2YrybO4_5jHaFQQxy2ywB53pY63qRfXK=ZKx5qc2Bw@mail.gmail.com>
 <CAKMK7uH9q09XadTV5Ezm=9aODErD=w_+8feujviVnF5LO_fggA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0602678665=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAKMK7uH9q09XadTV5Ezm=9aODErD=w_+8feujviVnF5LO_fggA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Mikhail Gavrilov <mikhail.v.gavrilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--===============0602678665==
Content-Type: multipart/alternative;
	boundary="_FEA7D873-6F97-49AA-B05D-696E54FDDE7C_"


--_FEA7D873-6F97-49AA-B05D-696E54FDDE7C_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
>>
>> Now 11:01pm and "gnome shell stuck warning" not appear since 19:17. So
>> looks like issue happens only when computer blocked and monitor in
>> power save mode.
>
> I'd bet on runtime pm or some other power saving feature in amdgpu
> shutting the interrupt handling down before we've handled all the
> interrupts. That would then result in a stuck fence.
>
> Do we already know which fence is stuck?

It is welcomed to shed a thread of light on how to collect/print that info.
Say line:xxx-yyy in path/to/amdgpu/zzz.c

Thanks
Hillf


--_FEA7D873-6F97-49AA-B05D-696E54FDDE7C_
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
><span lang=3DEN-US>Daniel Vetter &lt;daniel-/w4YWyX8dFk@public.gmane.org&gt;<o:p></o:p></span>=
</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt;&gt;<o:p>&nbsp;</o:p=
></span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt;&gt; Now 11:01pm an=
d &quot;gnome shell stuck warning&quot; not appear since 19:17. So</span></=
p><p class=3DMsoNormal><span lang=3DEN-US>&gt;&gt; looks like issue happens=
 only when computer blocked and monitor in</span></p><p class=3DMsoNormal><=
span lang=3DEN-US>&gt;&gt; power save mode.</span></p><p class=3DMsoNormal>=
<span lang=3DEN-US>&gt;<o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><sp=
an lang=3DEN-US>&gt; I'd bet on runtime pm or some other power saving featu=
re in amdgpu</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; shuttin=
g the interrupt handling down before we've handled all the</span></p><p cla=
ss=3DMsoNormal><span lang=3DEN-US>&gt; interrupts. That would then result i=
n a stuck fence.</span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt;<o:p=
>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>&gt; Do we =
already know which fence is stuck?</span></p><p class=3DMsoNormal><span lan=
g=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-=
US>It is welcomed to shed a thread of light on how to collect/print that in=
fo.</span></p><p class=3DMsoNormal><span lang=3DEN-US>Say line:xxx-yyy in p=
ath/to/amdgpu/zzz.c</span></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>=
&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>Thanks</span=
></p><p class=3DMsoNormal><span lang=3DEN-US>Hillf</span></p><p class=3DMso=
Normal><span class=3DDefaultFontHxMailStyle><span lang=3DEN-US><o:p>&nbsp;<=
/o:p></span></span></p></div></body></html>=

--_FEA7D873-6F97-49AA-B05D-696E54FDDE7C_--



--===============0602678665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0602678665==--
