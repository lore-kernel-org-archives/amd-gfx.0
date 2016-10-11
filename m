From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Allow broadcast on debugfs read (v2)
Date: Tue, 11 Oct 2016 12:32:42 +0000
Message-ID: <BN6PR12MB1764A6A7F768C662DC5866EBF7DA0@BN6PR12MB1764.namprd12.prod.outlook.com>
References: <20161009115808.12776-1-tom.stdenis@amd.com>
 <a2035199-429c-d377-b354-bf42148d3820@mailbox.org>
 <CY4PR12MB176836D549B404152F5A1040F7DA0@CY4PR12MB1768.namprd12.prod.outlook.com>,
 <942ca6f5-fb0b-5f6f-7a87-1ffd6335be5d@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1362298042=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <942ca6f5-fb0b-5f6f-7a87-1ffd6335be5d-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, =?iso-8859-1?Q?Michel_D=E4nzer?= <michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1362298042==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1764A6A7F768C662DC5866EBF7DA0BN6PR12MB1764namp_"

--_000_BN6PR12MB1764A6A7F768C662DC5866EBF7DA0BN6PR12MB1764namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

It's used by the UMD though they read from 0/*/* when reading the RASTER_CO=
NFIG registers (which may be a bug...)


I only added it because the previous interface was either */*/* or x/y/z (w=
here none are *).  Now it supports arbitrary bank selections.


Tom


________________________________
From: Christian K=F6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Sent: Tuesday, October 11, 2016 08:30
To: StDenis, Tom; Michel D=E4nzer
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amd/amdgpu: Allow broadcast on debugfs read (v2)

I briefly remember reading in some hardware doc that this actually has a de=
fined behavior.

It was something about applying either bit wise "and" or "or" on the result=
ing bits and returning that to the reader.

This way you can check with a single broadcast read if an error occurred or=
 if any of the instances are busy.

But if you don't actually use it I suggest to not implement this.

Regards,
Christian.

Am 11.10.2016 um 12:26 schrieb StDenis, Tom:

That actually makes sense.  It came up because mmPA_SC_RASTER_CONFIG (and _=
1) are read by libdrm with a selection of 0/*/* for se/sh/instance so I wan=
ted to be able to reproduce that via the debugfs interface for testing.


But ya, if you use the broadcast bit who are you reading from then ... hmm.=
.


Tom


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Michel D=E4nzer <michel.daenzer@mailb=
ox.org><mailto:michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>
Sent: Monday, October 10, 2016 23:52
To: Tom St Denis
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Allow broadcast on debugfs read (v2)

On 09/10/16 08:58 PM, Tom St Denis wrote:
> Allow any of the se/sh/instance fields to be
> specified as a broadcast by submitting 0x3FF.
>
> (v2) Fix broadcast range checking
>
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org><mailto:tom.stdenis@amd.=
com>

I'm not sure how a "broadcast read" is supposed to work? I can only see
the register specs talking about broadcast in connection with writes.


--
Earthling Michel D=E4nzer               |               http://www.amd.com
Graphics, Processors and Immersive VR Solutions | AMD <http://www.amd.com/>
www.amd.com<http://www.amd.com>
Explore a wide range of innovative next generation computing processors, gr=
aphics, and Immersive VR solutions by Advanced Micro Devices (AMD). Visit A=
MD.com now!



Libre software enthusiast             |             Mesa and X developer
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - lists.freedesktop.org<https://lists.freedesktop.org/mai=
lman/listinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...






_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--_000_BN6PR12MB1764A6A7F768C662DC5866EBF7DA0BN6PR12MB1764namp_
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
-family:Calibri,Arial,Helvetica,sans-serif;">
<p>It's used by the UMD though they read from 0/*/* when reading the RASTER=
_CONFIG registers (which may be a bug...)</p>
<p><br>
</p>
<p>I only added it because the previous interface was either */*/* or x/y/z=
 (where none are *). &nbsp;Now it supports arbitrary bank selections.</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Christian K=F6nig &lt=
;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, October 11, 2016 08:30<br>
<b>To:</b> StDenis, Tom; Michel D=E4nzer<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amd/amdgpu: Allow broadcast on debugfs read=
 (v2)</font>
<div>&nbsp;</div>
</div>
<div>
<div class=3D"moz-cite-prefix">I briefly remember reading in some hardware =
doc that this actually has a defined behavior.<br>
<br>
It was something about applying either bit wise &quot;and&quot; or &quot;or=
&quot; on the resulting bits and returning that to the reader.<br>
<br>
This way you can check with a single broadcast read if an error occurred or=
 if any of the instances are busy.<br>
<br>
But if you don't actually use it I suggest to not implement this.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 11.10.2016 um 12:26 schrieb StDenis, Tom:<br>
</div>
<blockquote type=3D"cite">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt; color:#000000; fo=
nt-family:Calibri,Arial,Helvetica,sans-serif">
<p>That actually makes sense. &nbsp;It came up because&nbsp;<span>mmPA_SC_R=
ASTER_CONFIG (and _1) are read by libdrm with a selection of 0/*/* for se/s=
h/instance so I wanted to be able to reproduce that via the debugfs interfa=
ce for testing.</span></p>
<p><span><br>
</span></p>
<p><span>But ya, if you use the broadcast bit who are you reading from then=
 ... hmm..</span></p>
<p><span><br>
</span></p>
<p><span>Tom</span></p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font color=3D"#000000" face=3D"Cal=
ibri,=0A=
                sans-serif" style=3D"font-size:11pt"><b>From:</b> amd-gfx
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:amd-gfx-bounces-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org">
&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on behalf of Michel D=E4n=
zer <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:michel.daenzer@mailbo=
x.org">
&lt;michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org&gt;</a><br>
<b>Sent:</b> Monday, October 10, 2016 23:52<br>
<b>To:</b> Tom St Denis<br>
<b>Cc:</b> <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@lis=
ts.freedesktop.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH] drm/amd/amdgpu: Allow broadcast on debugfs read=
 (v2)</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt">
<div class=3D"PlainText">On 09/10/16 08:58 PM, Tom St Denis wrote:<br>
&gt; Allow any of the se/sh/instance fields to be<br>
&gt; specified as a broadcast by submitting 0x3FF.<br>
&gt; <br>
&gt; (v2) Fix broadcast range checking<br>
&gt; <br>
&gt; Signed-off-by: Tom St Denis <a class=3D"moz-txt-link-rfc2396E" href=3D=
"mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org">
&lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<br>
I'm not sure how a &quot;broadcast read&quot; is supposed to work? I can on=
ly see<br>
the register specs talking about broadcast in connection with writes.<br>
<br>
<br>
-- <br>
Earthling Michel D=E4nzer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"http://www.amd.com=
" id=3D"LPlnk365128" previewremoved=3D"true">
http://www.amd.com</a>
<div id=3D"LPBorder_GT_14761814794940.12544022877196426" style=3D"margin-bo=
ttom:20px; overflow:auto; width:100%; text-indent:0px" contenteditable=3D"f=
alse">
<table id=3D"LPContainer_14761814794910.48081554222867373" cellspacing=3D"0=
" style=3D"width:90%; background-color:rgb(255,255,255); overflow:auto; pad=
ding-top:20px; padding-bottom:20px; margin-top:20px; border-top:1px dotted =
rgb(200,200,200); border-bottom:1px dotted rgb(200,200,200)">
<tbody>
<tr valign=3D"top" style=3D"border-spacing:0px">
<td id=3D"TextCell_14761814794930.6330030561431497" colspan=3D"2" style=3D"=
vertical-align:top; padding:0px; display:table-cell">
<div id=3D"LPTitle_14761814794930.0860209784141206" style=3D""><a id=3D"LPU=
rlAnchor_14761814794930.01359389598361771" href=3D"http://www.amd.com/" tar=
get=3D"_blank" style=3D"text-decoration:none">Graphics, Processors and Imme=
rsive VR Solutions | AMD
</a></div>
<div id=3D"LPMetadata_14761814794940.4677118614629565" style=3D""><a class=
=3D"moz-txt-link-abbreviated" href=3D"http://www.amd.com">www.amd.com</a></=
div>
<div id=3D"LPDescription_14761814794940.37923242485275344" style=3D"display=
:block; color:rgb(102,102,102); font-weight:normal; font-family:wf_segoe-ui=
_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif; =
font-size:14px; line-height:20px; max-height:100px; overflow:hidden">
Explore a wide range of innovative next generation computing processors, gr=
aphics, and Immersive VR solutions by Advanced Micro Devices (AMD). Visit A=
MD.com now!</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br>
Libre software enthusiast&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; Mesa and X developer<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk287571" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_14761815380460.6817372487984479" style=3D"margin-bot=
tom:20px; overflow:auto; width:100%; text-indent:0px" contenteditable=3D"fa=
lse">
<table id=3D"LPContainer_14761815380420.37970165615775286" cellspacing=3D"0=
" style=3D"width:90%; background-color:rgb(255,255,255); overflow:auto; pad=
ding-top:20px; padding-bottom:20px; margin-top:20px; border-top:1px dotted =
rgb(200,200,200); border-bottom:1px dotted rgb(200,200,200)">
<tbody>
<tr valign=3D"top" style=3D"border-spacing:0px">
<td id=3D"TextCell_14761815380430.2899884346376056" colspan=3D"2" style=3D"=
vertical-align:top; padding:0px; display:table-cell">
<div id=3D"LPTitle_14761815380440.5311884203741501" style=3D""><a id=3D"LPU=
rlAnchor_14761815380450.40820370331518996" href=3D"https://lists.freedeskto=
p.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-decoration:=
none">amd-gfx Info Page - lists.freedesktop.org</a></div>
<div id=3D"LPMetadata_14761815380450.487355067260703" style=3D"">lists.free=
desktop.org</div>
<div id=3D"LPDescription_14761815380450.7331276341568305" style=3D"display:=
block; color:rgb(102,102,102); font-weight:normal; font-family:wf_segoe-ui_=
normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif; f=
ont-size:14px; line-height:20px; max-height:100px; overflow:hidden">
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
</div>
</span></font></div>
</div>
<br>
<fieldset class=3D"mimeAttachmentHeader"></fieldset> <br>
<pre>_______________________________________________=0A=
amd-gfx mailing list=0A=
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>=0A=
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.freedesktop.org/ma=
ilman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-=
gfx</a>=0A=
</pre>
</blockquote>
<p><br>
</p>
</div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB1764A6A7F768C662DC5866EBF7DA0BN6PR12MB1764namp_--

--===============1362298042==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1362298042==--
