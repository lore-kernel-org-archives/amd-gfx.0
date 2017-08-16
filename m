From: "Yu, Xiangliang" <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 1/1] drm/ttm: Fix accounting error when fail to get pages
 for pool
Date: Wed, 16 Aug 2017 08:28:17 +0000
Message-ID: <BY2PR1201MB0935DB65B882D9D3B69A065AEB820@BY2PR1201MB0935.namprd12.prod.outlook.com>
References: <1502868046-32511-1-git-send-email-Xiangliang.Yu@amd.com>
 <BLUPR12MB044923B80FB13FACC4DA726E84820@BLUPR12MB0449.namprd12.prod.outlook.com>
 <8f64cef6-e7f7-e245-93b9-a0d1bbc411aa@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1090531276=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <8f64cef6-e7f7-e245-93b9-a0d1bbc411aa-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

--===============1090531276==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY2PR1201MB0935DB65B882D9D3B69A065AEB820BY2PR1201MB0935_"

--_000_BY2PR1201MB0935DB65B882D9D3B69A065AEB820BY2PR1201MB0935_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Ok, CC stable.

From: Christian K=F6nig [mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org]
Sent: Wednesday, August 16, 2017 3:55 PM
To: Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>; Yu, Xiangliang <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>; a=
kpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org; labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; dri-devel-PD4FTy7X32lNgt0PjOBp93rCq3LdnpKM@public.gmane.org=
rg; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 1/1] drm/ttm: Fix accounting error when fail to get pag=
es for pool

CC stable?

Reviewed-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org><mailto:christian.=
koenig-5C7GfCeVMHo@public.gmane.org>

Am 16.08.2017 um 09:25 schrieb Liu, Monk:

Reviewed-by: Monk Liu <monk.liu-5C7GfCeVMHo@public.gmane.org><mailto:monk.liu-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Xiangliang.Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>=
<mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, August 16, 2017 3:20:46 PM
To: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org<mailto:akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>; labbott@re=
dhat.com<mailto:labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto=
:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Yu, Xiangliang
Subject: [PATCH 1/1] drm/ttm: Fix accounting error when fail to get pages f=
or pool

When fail to get needed page for pool, need to put allocated pages
into pool. But current code has a miscalculation of allocated pages,
correct it.

Signed-off-by: Xiangliang.Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org><mailto:Xiangliang.Yu@a=
md.com>
---
 drivers/gpu/drm/ttm/ttm_page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc.c b/drivers/gpu/drm/ttm/ttm=
_page_alloc.c
index eeddc1e..8715998 100644
--- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
@@ -615,7 +615,7 @@ static void ttm_page_pool_fill_locked(struct ttm_page_p=
ool *pool,
                 } else {
                         pr_err("Failed to fill pool (%p)\n", pool);
                         /* If we have any pages left put them to the pool.=
 */
-                       list_for_each_entry(p, &pool->list, lru) {
+                       list_for_each_entry(p, &new_pages, lru) {
                                 ++cpages;
                         }
                         list_splice(&new_pages, &pool->list);
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx




_______________________________________________

amd-gfx mailing list

amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--_000_BY2PR1201MB0935DB65B882D9D3B69A065AEB820BY2PR1201MB0935_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	color:black;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	color:black;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";
	color:black;}
p.emailquote, li.emailquote, div.emailquote
	{mso-style-name:emailquote;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:1.0pt;
	margin-bottom:.0001pt;
	border:none;
	padding:0in;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	color:black;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;
	color:black;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body bgcolor=3D"white" lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">Ok, CC stable.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:windowtext">From:</span></b><span style=3D"=
font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtex=
t"> Christian K=F6nig [mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org]
<br>
<b>Sent:</b> Wednesday, August 16, 2017 3:55 PM<br>
<b>To:</b> Liu, Monk &lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;; Yu, Xiangliang &lt;Xianglian=
g.Yu-5C7GfCeVMHo@public.gmane.org&gt;; akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org; labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; dri-devel@=
lists.freedesktop.org; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 1/1] drm/ttm: Fix accounting error when fail to =
get pages for pool<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">CC stable?<br>
<br>
Reviewed-by: Christian K=F6nig <a href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">=
&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<br>
Am 16.08.2017 um 09:25 schrieb Liu, Monk:<o:p></o:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<div>
<div id=3D"x_divtagdefaultwrapper">
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif">Reviewed-by: =
Monk Liu <a href=3D"mailto:monk.liu-5C7GfCeVMHo@public.gmane.org">
&lt;monk.liu-5C7GfCeVMHo@public.gmane.org&gt;</a><o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> amd-gfx
<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounce=
s@lists.freedesktop.org&gt;</a> on behalf of Xiangliang.Yu
<a href=3D"mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org">&lt;Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org&gt;</a><=
br>
<b>Sent:</b> Wednesday, August 16, 2017 3:20:46 PM<br>
<b>To:</b> <a href=3D"mailto:akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org">akpm@linux-foundati=
on.org</a>;
<a href=3D"mailto:labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>; <a href=3D"ma=
ilto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; <a href=3D"mailto:amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> Yu, Xiangliang<br>
<b>Subject:</b> [PATCH 1/1] drm/ttm: Fix accounting error when fail to get =
pages for pool</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">When fail to get ne=
eded page for pool, need to put allocated pages<br>
into pool. But current code has a miscalculation of allocated pages,<br>
correct it.<br>
<br>
Signed-off-by: Xiangliang.Yu <a href=3D"mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org">&lt;X=
iangliang.Yu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
---<br>
&nbsp;drivers/gpu/drm/ttm/ttm_page_alloc.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc.c b/drivers/gpu/drm/ttm/ttm=
_page_alloc.c<br>
index eeddc1e..8715998 100644<br>
--- a/drivers/gpu/drm/ttm/ttm_page_alloc.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/ttm/ttm_page_alloc.c<br>
@@ -615,7 &#43;615,7 @@ static void ttm_page_pool_fill_locked(struct ttm_pa=
ge_pool *pool,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_er=
r(&quot;Failed to fill pool (%p)\n&quot;, pool);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If=
 we have any pages left put them to the pool. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_en=
try(p, &amp;pool-&gt;list, lru) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_eac=
h_entry(p, &amp;new_pages, lru) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &#43;&#43;cpages;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_=
splice(&amp;new_pages, &amp;pool-&gt;list);<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><br>
<br>
<br>
<o:p></o:p></p>
<pre>_______________________________________________<o:p></o:p></pre>
<pre>amd-gfx mailing list<o:p></o:p></pre>
<pre><a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org</a><o:p></o:p></pre>
<pre><a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></pre>
</blockquote>
<p><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_BY2PR1201MB0935DB65B882D9D3B69A065AEB820BY2PR1201MB0935_--

--===============1090531276==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1090531276==--
