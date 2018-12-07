From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Workaround build failure due to trace conflict
Date: Fri, 7 Dec 2018 22:10:09 +0000
Message-ID: <BN6PR12MB1809D11DF645B6B1C18A06DCF7AA0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1544220417-11264-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1016485668=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1544220417-11264-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1016485668==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809D11DF645B6B1C18A06DCF7AA0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809D11DF645B6B1C18A06DCF7AA0BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Kuehling=
, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, December 7, 2018 5:07 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Kuehling, Felix
Subject: [PATCH] drm/amdgpu: Workaround build failure due to trace conflict

Avoid including mmu_context.h in amdgpu_amdkfd.h since that may be
included in other header files that define traces. This leads to
conflicts due to traces defined in other headers included via
mmu_context.h.

Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h        | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 1 +
 4 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index bcf587b..86cf1a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -27,7 +27,6 @@

 #include <linux/types.h>
 #include <linux/mm.h>
-#include <linux/mmu_context.h>
 #include <linux/workqueue.h>
 #include <kgd_kfd_interface.h>
 #include <drm/ttm/ttm_execbuf_util.h>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
index 72a357d..ff7fac7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
@@ -23,6 +23,7 @@
 #include <linux/fdtable.h>
 #include <linux/uaccess.h>
 #include <linux/firmware.h>
+#include <linux/mmu_context.h>
 #include <drm/drmP.h>
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
index 0e2a56b..56ea929 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
@@ -24,6 +24,7 @@
 #include <linux/fdtable.h>
 #include <linux/uaccess.h>
 #include <linux/firmware.h>
+#include <linux/mmu_context.h>
 #include <drm/drmP.h>
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 03b604c..5c51d491 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -26,6 +26,7 @@
 #include <linux/fdtable.h>
 #include <linux/uaccess.h>
 #include <linux/firmware.h>
+#include <linux/mmu_context.h>
 #include <drm/drmP.h>
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809D11DF645B6B1C18A06DCF7AA0BN6PR12MB1809namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Kuehling, Felix &lt;Felix.K=
uehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, December 7, 2018 5:07 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Kuehling, Felix<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Workaround build failure due to trace c=
onflict</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Avoid including mmu_context.h in amdgpu_amdkfd.h s=
ince that may be<br>
included in other header files that define traces. This leads to<br>
conflicts due to traces defined in other headers included via<br>
mmu_context.h.<br>
<br>
Signed-off-by: Felix Kuehling &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; | 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c | 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c | 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 1 &#43;<br>
&nbsp;4 files changed, 3 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h<br>
index bcf587b..86cf1a4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
@@ -27,7 &#43;27,6 @@<br>
&nbsp;<br>
&nbsp;#include &lt;linux/types.h&gt;<br>
&nbsp;#include &lt;linux/mm.h&gt;<br>
-#include &lt;linux/mmu_context.h&gt;<br>
&nbsp;#include &lt;linux/workqueue.h&gt;<br>
&nbsp;#include &lt;kgd_kfd_interface.h&gt;<br>
&nbsp;#include &lt;drm/ttm/ttm_execbuf_util.h&gt;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c<br>
index 72a357d..ff7fac7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c<br>
@@ -23,6 &#43;23,7 @@<br>
&nbsp;#include &lt;linux/fdtable.h&gt;<br>
&nbsp;#include &lt;linux/uaccess.h&gt;<br>
&nbsp;#include &lt;linux/firmware.h&gt;<br>
&#43;#include &lt;linux/mmu_context.h&gt;<br>
&nbsp;#include &lt;drm/drmP.h&gt;<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_amdkfd.h&quot;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c<br>
index 0e2a56b..56ea929 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c<br>
@@ -24,6 &#43;24,7 @@<br>
&nbsp;#include &lt;linux/fdtable.h&gt;<br>
&nbsp;#include &lt;linux/uaccess.h&gt;<br>
&nbsp;#include &lt;linux/firmware.h&gt;<br>
&#43;#include &lt;linux/mmu_context.h&gt;<br>
&nbsp;#include &lt;drm/drmP.h&gt;<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_amdkfd.h&quot;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
index 03b604c..5c51d491 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
@@ -26,6 &#43;26,7 @@<br>
&nbsp;#include &lt;linux/fdtable.h&gt;<br>
&nbsp;#include &lt;linux/uaccess.h&gt;<br>
&nbsp;#include &lt;linux/firmware.h&gt;<br>
&#43;#include &lt;linux/mmu_context.h&gt;<br>
&nbsp;#include &lt;drm/drmP.h&gt;<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_amdkfd.h&quot;<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk426367" class=3D"OWAAutoLink" previewremoved=3D"true">https://lists.free=
desktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB1809D11DF645B6B1C18A06DCF7AA0BN6PR12MB1809namp_--

--===============1016485668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1016485668==--
