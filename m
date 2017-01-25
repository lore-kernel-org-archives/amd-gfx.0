From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: header should be defining
 _SMU7_CLOCK_POWER_GATING_H_
Date: Wed, 25 Jan 2017 12:25:23 +0000
Message-ID: <CY4PR12MB1687B81C6D6283794359C0BAFB740@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <20170125120732.25126-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0206866672=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170125120732.25126-1-colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
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
To: Colin King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>, "Daenzer,
 Michel" <Michel.Daenzer-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

--===============0206866672==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687B81C6D6283794359C0BAFB740CY4PR12MB1687namp_"

--_000_CY4PR12MB1687B81C6D6283794359C0BAFB740CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks.


Reviewed-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>


Best Regards

Rex

________________________________
From: Colin King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Sent: Wednesday, January 25, 2017 8:07 PM
To: Deucher, Alexander; Koenig, Christian; David Airlie; Wang, Ken; Daenzer=
, Michel; Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dri-devel-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: [PATCH] drm/amd/powerplay: header should be defining _SMU7_CLOCK_P=
OWER_GATING_H_

From: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>

_SMU7_CLOCK_POWER_GATING_H_ is being used as a header guard, followed by
a #define of a different macro.  Define _SMU7_CLOCK_POWER_GATING_H_ instead
to fix this.

Signed-off-by: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.h b/=
drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.h
index d52a28c..c96ed9e 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.h
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.h
@@ -22,7 +22,7 @@
  */

 #ifndef _SMU7_CLOCK_POWER_GATING_H_
-#define _SMU7_CLOCK__POWER_GATING_H_
+#define _SMU7_CLOCK_POWER_GATING_H_

 #include "smu7_hwmgr.h"
 #include "pp_asicblocks.h"
--
2.10.2


--_000_CY4PR12MB1687B81C6D6283794359C0BAFB740CY4PR12MB1687namp_
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
<p>Thanks.&nbsp;</p>
<p><br>
</p>
<p>Reviewed-by:&nbsp;<span style=3D"font-size: 12pt;">Rex Zhu &lt;Rex.Z</sp=
an><span style=3D"font-size: 12pt;">hu-5C7GfCeVMHo@public.gmane.org&gt;</span></p>
<p><span style=3D"font-size: 12pt;"><br>
</span></p>
<p><span style=3D"font-size: 12pt;">Best Regards</span></p>
<p><span style=3D"font-size: 12pt;">Rex</span></p>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Colin King &lt;coli=
n.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, January 25, 2017 8:07 PM<br>
<b>To:</b> Deucher, Alexander; Koenig, Christian; David Airlie; Wang, Ken; =
Daenzer, Michel; Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dri-devel@lists.f=
reedesktop.org<br>
<b>Cc:</b> kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br=
>
<b>Subject:</b> [PATCH] drm/amd/powerplay: header should be defining _SMU7_=
CLOCK_POWER_GATING_H_</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">From: Colin Ian King &lt;colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org&=
gt;<br>
<br>
_SMU7_CLOCK_POWER_GATING_H_ is being used as a header guard, followed by<br=
>
a #define of a different macro.&nbsp; Define _SMU7_CLOCK_POWER_GATING_H_ in=
stead<br>
to fix this.<br>
<br>
Signed-off-by: Colin Ian King &lt;colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.h | 2 &#43;=
-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.h b/=
drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.h<br>
index d52a28c..c96ed9e 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating=
.h<br>
@@ -22,7 &#43;22,7 @@<br>
&nbsp; */<br>
&nbsp;<br>
&nbsp;#ifndef _SMU7_CLOCK_POWER_GATING_H_<br>
-#define _SMU7_CLOCK__POWER_GATING_H_<br>
&#43;#define _SMU7_CLOCK_POWER_GATING_H_<br>
&nbsp;<br>
&nbsp;#include &quot;smu7_hwmgr.h&quot;<br>
&nbsp;#include &quot;pp_asicblocks.h&quot;<br>
-- <br>
2.10.2<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB1687B81C6D6283794359C0BAFB740CY4PR12MB1687namp_--

--===============0206866672==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0206866672==--
