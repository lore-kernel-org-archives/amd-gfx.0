From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Change mmhub_9_4_0_ headers to
 mmhub_1_0_ ones.
Date: Wed, 20 Nov 2019 19:48:35 +0000
Message-ID: <CY4PR12MB181368C333873890203006A6F74F0@CY4PR12MB1813.namprd12.prod.outlook.com>
References: <20191120194345.10267-1-zhan.liu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0183788549=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191120194345.10267-1-zhan.liu-5C7GfCeVMHo@public.gmane.org>
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
To: "Liu, Zhan" <Zhan.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Li, Dennis" <Dennis.Li-5C7GfCeVMHo@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Zhou1, Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>

--===============0183788549==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB181368C333873890203006A6F74F0CY4PR12MB1813namp_"

--_000_CY4PR12MB181368C333873890203006A6F74F0CY4PR12MB1813namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Zhan Liu=
 <zhan.liu-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, November 20, 2019 2:43 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Liu, Zha=
n <Zhan.Liu-5C7GfCeVMHo@public.gmane.org>; Li, Dennis <Dennis.Li-5C7GfCeVMHo@public.gmane.org>; Zhang, Hawking <Hawki=
ng.Zhang-5C7GfCeVMHo@public.gmane.org>; Zhou1, Tao <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/display: Change mmhub_9_4_0_ headers to mmhub_1_0_=
 ones.

[Why]
Kernal won't compile without this patch. That is because
mmhub_9_4_0_ headers are obsolete. All contents within
mmhub_9_4_0_ headers are inherited by their corresponding
mmhub_1_0_ ones.

[How]
Change mmhub_9_4_0_ headers to their corresponding mmhub_1_0_ ones.

Signed-off-by: Zhan Liu <zhan.liu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
index 305bb0841563..53ab88ef71f5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
@@ -63,8 +63,8 @@
 #include "soc15_hw_ip.h"
 #include "vega10_ip_offset.h"
 #include "nbio/nbio_6_1_offset.h"
-#include "mmhub/mmhub_9_4_0_offset.h"
-#include "mmhub/mmhub_9_4_0_sh_mask.h"
+#include "mmhub/mmhub_1_0_offset.h"
+#include "mmhub/mmhub_1_0_sh_mask.h"
 #include "reg_helper.h"

 #include "dce100/dce100_resource.h"
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB181368C333873890203006A6F74F0CY4PR12MB1813namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Zhan Liu &lt;zhan.liu-5C7GfCeVMHo@public.gmane.org=
&gt;<br>
<b>Sent:</b> Wednesday, November 20, 2019 2:43 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;; Liu, Zhan &lt;Zhan.Liu-5C7GfCeVMHo@public.gmane.org&gt;; Li, Dennis &lt;Dennis.Li-5C7GfCeVMHo@public.gmane.org&g=
t;; Zhang, Hawking &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;; Zhou1, Tao &lt;Tao.Zhou1@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Change mmhub_9_4_0_ headers to mmh=
ub_1_0_ ones.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
Kernal won't compile without this patch. That is because<br>
mmhub_9_4_0_ headers are obsolete. All contents within<br>
mmhub_9_4_0_ headers are inherited by their corresponding<br>
mmhub_1_0_ ones.<br>
<br>
[How]<br>
Change mmhub_9_4_0_ headers to their corresponding mmhub_1_0_ ones.<br>
<br>
Signed-off-by: Zhan Liu &lt;zhan.liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 4 &#43;&#43=
;--<br>
&nbsp;1 file changed, 2 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dce120/dce120_resource.c<br>
index 305bb0841563..53ab88ef71f5 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c<b=
r>
@@ -63,8 &#43;63,8 @@<br>
&nbsp;#include &quot;soc15_hw_ip.h&quot;<br>
&nbsp;#include &quot;vega10_ip_offset.h&quot;<br>
&nbsp;#include &quot;nbio/nbio_6_1_offset.h&quot;<br>
-#include &quot;mmhub/mmhub_9_4_0_offset.h&quot;<br>
-#include &quot;mmhub/mmhub_9_4_0_sh_mask.h&quot;<br>
&#43;#include &quot;mmhub/mmhub_1_0_offset.h&quot;<br>
&#43;#include &quot;mmhub/mmhub_1_0_sh_mask.h&quot;<br>
&nbsp;#include &quot;reg_helper.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;dce100/dce100_resource.h&quot;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB181368C333873890203006A6F74F0CY4PR12MB1813namp_--

--===============0183788549==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0183788549==--
