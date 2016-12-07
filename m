From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: GPR read support via debugfs (v2)
Date: Wed, 7 Dec 2016 17:49:40 +0000
Message-ID: <CY4PR12MB1768C0C95CA7F8A50E07C28AF7850@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <20161206145014.9140-1-tom.stdenis@amd.com>
 <b0979deb-7d97-f81f-65af-3a0800d55e4b@folklore1984.net>
 <CY4PR12MB1768F2C7EF86AE04BB957AEAF7850@CY4PR12MB1768.namprd12.prod.outlook.com>,
 <CADnq5_OJJFGDLt405YdQN3k6O5jbM_t0miDo=ZenMp9jG9QjcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0024504729=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_OJJFGDLt405YdQN3k6O5jbM_t0miDo=ZenMp9jG9QjcA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Haehnle, Nicolai" <Nicolai.Haehnle-5C7GfCeVMHo@public.gmane.org>, "Olsak, Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0024504729==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1768C0C95CA7F8A50E07C28AF7850CY4PR12MB1768namp_"

--_000_CY4PR12MB1768C0C95CA7F8A50E07C28AF7850CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Alex,


I'll wait on pushing it until I hear back from one of them.


Cheers,

Tom


________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Wednesday, December 7, 2016 12:32
To: StDenis, Tom
Cc: Edward O'Callaghan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: GPR read support via debugfs (v2)

Patches look fine to me.  Assuming they are useful to Marek and Nicolai, th=
e patches are:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org<mailto:alexander.deuch=
er-5C7GfCeVMHo@public.gmane.org>>

On Wed, Dec 7, 2016 at 12:05 PM, StDenis, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org<mailto:T=
om.StDenis-5C7GfCeVMHo@public.gmane.org>> wrote:

Thanks.


Could use a RB/NAK from Christian or Alex when they get the time :-)


Tom


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Edward O'Callaghan <funfunctor@folklo=
re1984.net<mailto:funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>>
Sent: Tuesday, December 6, 2016 17:15
To: Tom St Denis; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org>
Subject: Re: GPR read support via debugfs (v2)

This series is,
Acked-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org<mailto:funfunctor=
@folklore1984.net>>

On 12/07/2016 01:50 AM, Tom St Denis wrote:
> These patches introduce debugfs access to read GPRs (SGPRs for now).
>
> (v2): Fixes white space, addressing is in dwords not bytes, and removes
>       the buggy sanity checking.
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - lists.freedesktop.org<https://lists.freedesktop.org/mai=
lman/listinfo/amd-gfx>
lists.freedesktop.org<http://lists.freedesktop.org>
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...



>


_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--_000_CY4PR12MB1768C0C95CA7F8A50E07C28AF7850CY4PR12MB1768namp_
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
<p>Hi Alex,</p>
<p><br>
</p>
<p>I'll wait on pushing it until I hear back from one of them.</p>
<p><br>
</p>
<p>Cheers,</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Alex Deucher &lt;alex=
deucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, December 7, 2016 12:32<br>
<b>To:</b> StDenis, Tom<br>
<b>Cc:</b> Edward O'Callaghan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: GPR read support via debugfs (v2)</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"ltr">
<div>Patches look fine to me.&nbsp; Assuming they are useful to Marek and N=
icolai, the patches are:<br>
</div>
Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">=
alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<div>
<div>
<div>
<div class=3D"gmail_extra"><br>
<div class=3D"gmail_quote">On Wed, Dec 7, 2016 at 12:05 PM, StDenis, Tom <s=
pan dir=3D"ltr">
&lt;<a href=3D"mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Tom.StDenis@am=
d.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex; border-left:1=
px #ccc solid; padding-left:1ex">
<div dir=3D"ltr">
<div id=3D"m_1549130000763319934divtagdefaultwrapper" dir=3D"ltr" style=3D"=
font-size:12pt; color:#000000; font-family:Calibri,Arial,Helvetica,sans-ser=
if">
<p>Thanks.</p>
<p><br>
</p>
<p>Could use a RB/NAK from Christian or Alex when they get the time :-)</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<div>
<hr style=3D"display:inline-block; width:98%">
<div id=3D"m_1549130000763319934x_divRplyFwdMsg" dir=3D"ltr"><font color=3D=
"#000000" face=3D"Calibri, sans-serif" style=3D"font-size:11pt"><b>From:</b=
> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" targ=
et=3D"_blank">amd-gfx-bounces@lists.<wbr>freedesktop.org</a>&gt;
 on behalf of Edward O'Callaghan &lt;<a href=3D"mailto:funfunctor@folklore1=
984.net" target=3D"_blank">funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Tuesday, December 6, 2016 17:15<br>
<b>To:</b> Tom St Denis; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" t=
arget=3D"_blank">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: GPR read support via debugfs (v2)</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt">
<div class=3D"m_1549130000763319934PlainText">
<div>
<div class=3D"h5">This series is,<br>
Acked-by: Edward O'Callaghan &lt;<a href=3D"mailto:funfunctor@folklore1984.=
net" target=3D"_blank">funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org</a>&gt;<br>
<br>
On 12/07/2016 01:50 AM, Tom St Denis wrote:<br>
&gt; These patches introduce debugfs access to read GPRs (SGPRs for now).<b=
r>
&gt; <br>
&gt; (v2): Fixes white space, addressing is in dwords not bytes, and remove=
s<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the buggy sanity checking.<br>
&gt; <br>
&gt; ______________________________<wbr>_________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=
=3D"m_1549130000763319934LPlnk539856" target=3D"_blank">
https://lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a> </div>
</div>
<div id=3D"m_1549130000763319934LPBorder_GT_14811303134020.3066773959785267=
" style=3D"margin-bottom:20px; overflow:auto; width:100%; text-indent:0px">
<table id=3D"m_1549130000763319934LPContainer_14811303133990.72732021653537=
94" cellspacing=3D"0" style=3D"width:90%; background-color:rgb(255,255,255)=
; overflow:auto; padding-top:20px; padding-bottom:20px; margin-top:20px; bo=
rder-top:1px dotted rgb(200,200,200); border-bottom:1px dotted rgb(200,200,=
200)">
<tbody>
<tr valign=3D"top" style=3D"border-spacing:0px">
<td id=3D"m_1549130000763319934TextCell_14811303134010.6228712278926285" co=
lspan=3D"2" style=3D"vertical-align:top; padding:0px; display:table-cell">
<div id=3D"m_1549130000763319934LPRemovePreviewContainer_14811303134010.667=
042105097579">
</div>
<div id=3D"m_1549130000763319934LPTitle_14811303134010.2987133567172171" st=
yle=3D"color:rgb(59,87,119); font-weight:normal; font-size:21px; font-famil=
y:wf_segoe-ui_light,&quot;Segoe UI Light&quot;,&quot;Segoe WP Light&quot;,&=
quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif; line-heig=
ht:21px">
<a id=3D"m_1549130000763319934LPUrlAnchor_14811303134010.6835253784315398" =
href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_=
blank" style=3D"text-decoration:none">amd-gfx Info Page - lists.freedesktop=
.org</a></div>
<div id=3D"m_1549130000763319934LPMetadata_14811303134010.9344851329159858"=
 style=3D"margin:10px 0px 16px; color:rgb(102,102,102); font-weight:normal;=
 font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,T=
ahoma,Arial,sans-serif; font-size:14px; line-height:14px">
<a href=3D"http://lists.freedesktop.org" target=3D"_blank">lists.freedeskto=
p.org</a></div>
<div id=3D"m_1549130000763319934LPDescription_14811303134020.77404254103671=
78" style=3D"display:block; color:rgb(102,102,102); font-weight:normal; fon=
t-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahom=
a,Arial,sans-serif; font-size:14px; line-height:20px; max-height:100px; ove=
rflow:hidden">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br>
&gt; <br>
<br>
</div>
</span></font></div>
</div>
</div>
<br>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
<br>
</blockquote>
</div>
<br>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1768C0C95CA7F8A50E07C28AF7850CY4PR12MB1768namp_--

--===============0024504729==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0024504729==--
