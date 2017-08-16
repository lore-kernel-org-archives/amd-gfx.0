From: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/1] drm/ttm: Fix accounting error when fail to get pages
 for pool
Date: Wed, 16 Aug 2017 07:25:54 +0000
Message-ID: <BLUPR12MB044923B80FB13FACC4DA726E84820@BLUPR12MB0449.namprd12.prod.outlook.com>
References: <1502868046-32511-1-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1852865500=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1502868046-32511-1-git-send-email-Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
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
To: "Yu, Xiangliang" <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1852865500==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BLUPR12MB044923B80FB13FACC4DA726E84820BLUPR12MB0449namp_"

--_000_BLUPR12MB044923B80FB13FACC4DA726E84820BLUPR12MB0449namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Monk Liu <monk.liu-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Xianglia=
ng.Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, August 16, 2017 3:20:46 PM
To: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org; labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; dri-devel-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Yu, Xiangliang
Subject: [PATCH 1/1] drm/ttm: Fix accounting error when fail to get pages f=
or pool

When fail to get needed page for pool, need to put allocated pages
into pool. But current code has a miscalculation of allocated pages,
correct it.

Signed-off-by: Xiangliang.Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
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
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BLUPR12MB044923B80FB13FACC4DA726E84820BLUPR12MB0449namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p>Reviewed-by: Monk Liu &lt;monk.liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Xiangliang.Yu &lt;Xianglian=
g.Yu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, August 16, 2017 3:20:46 PM<br>
<b>To:</b> akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org; labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; dri-devel@lists.f=
reedesktop.org; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Yu, Xiangliang<br>
<b>Subject:</b> [PATCH 1/1] drm/ttm: Fix accounting error when fail to get =
pages for pool</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">When fail to get needed page for pool, need to put=
 allocated pages<br>
into pool. But current code has a miscalculation of allocated pages,<br>
correct it.<br>
<br>
Signed-off-by: Xiangliang.Yu &lt;Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org&gt;<br>
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
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font>
</body>
</html>

--_000_BLUPR12MB044923B80FB13FACC4DA726E84820BLUPR12MB0449namp_--

--===============1852865500==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1852865500==--
