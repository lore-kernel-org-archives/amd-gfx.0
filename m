From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amd: Fix Kconfig indentation
Date: Thu, 21 Nov 2019 16:13:22 +0000
Message-ID: <CY4PR12MB1813D2AE8B11E5F190581995F74E0@CY4PR12MB1813.namprd12.prod.outlook.com>
References: <20191121132930.29544-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0849829786=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191121132930.29544-1-krzk@kernel.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: David Airlie <airlied@linux.ie>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

--===============0849829786==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1813D2AE8B11E5F190581995F74E0CY4PR12MB1813namp_"

--_000_CY4PR12MB1813D2AE8B11E5F190581995F74E0CY4PR12MB1813namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Krzysztof Kozlowski <krzk@kernel.org>
Sent: Thursday, November 21, 2019 8:29 AM
To: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>; Deucher, Alexander <Alexander.De=
ucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhou, David(C=
hunMing) <David1.Zhou@amd.com>; David Airlie <airlied@linux.ie>; Daniel Vet=
ter <daniel@ffwll.ch>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedes=
ktop.org>; dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org=
>
Subject: [PATCH] drm/amd: Fix Kconfig indentation

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
        $ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/gpu/drm/amd/acp/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/acp/Kconfig b/drivers/gpu/drm/amd/acp/Kcon=
fig
index d968c2471412..19bae9100da4 100644
--- a/drivers/gpu/drm/amd/acp/Kconfig
+++ b/drivers/gpu/drm/amd/acp/Kconfig
@@ -2,11 +2,11 @@
 menu "ACP (Audio CoProcessor) Configuration"

 config DRM_AMD_ACP
-       bool "Enable AMD Audio CoProcessor IP support"
-       depends on DRM_AMDGPU
-       select MFD_CORE
-       select PM_GENERIC_DOMAINS if PM
-       help
+       bool "Enable AMD Audio CoProcessor IP support"
+       depends on DRM_AMDGPU
+       select MFD_CORE
+       select PM_GENERIC_DOMAINS if PM
+       help
         Choose this option to enable ACP IP support for AMD SOCs.
         This adds the ACP (Audio CoProcessor) IP driver and wires
         it up into the amdgpu driver.  The ACP block provides the DMA
--
2.17.1


--_000_CY4PR12MB1813D2AE8B11E5F190581995F74E0CY4PR12MB1813namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Krzysztof Kozlowski &=
lt;krzk@kernel.org&gt;<br>
<b>Sent:</b> Thursday, November 21, 2019 8:29 AM<br>
<b>To:</b> linux-kernel@vger.kernel.org &lt;linux-kernel@vger.kernel.org&gt=
;<br>
<b>Cc:</b> Krzysztof Kozlowski &lt;krzk@kernel.org&gt;; Deucher, Alexander =
&lt;Alexander.Deucher@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@a=
md.com&gt;; Zhou, David(ChunMing) &lt;David1.Zhou@amd.com&gt;; David Airlie=
 &lt;airlied@linux.ie&gt;; Daniel Vetter &lt;daniel@ffwll.ch&gt;; amd-gfx@l=
ists.freedesktop.org
 &lt;amd-gfx@lists.freedesktop.org&gt;; dri-devel@lists.freedesktop.org &lt=
;dri-devel@lists.freedesktop.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amd: Fix Kconfig indentation</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Adjust indentation from spaces to tab (&#43;option=
al two spaces) as in<br>
coding style with command like:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $ sed -e 's/^&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; /\t/' -i */Kconfig<br>
<br>
Signed-off-by: Krzysztof Kozlowski &lt;krzk@kernel.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/acp/Kconfig | 10 &#43;&#43;&#43;&#43;&#43;-----<b=
r>
&nbsp;1 file changed, 5 insertions(&#43;), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/acp/Kconfig b/drivers/gpu/drm/amd/acp/Kcon=
fig<br>
index d968c2471412..19bae9100da4 100644<br>
--- a/drivers/gpu/drm/amd/acp/Kconfig<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/acp/Kconfig<br>
@@ -2,11 &#43;2,11 @@<br>
&nbsp;menu &quot;ACP (Audio CoProcessor) Configuration&quot;<br>
&nbsp;<br>
&nbsp;config DRM_AMD_ACP<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;Enable AMD Audio CoProcess=
or IP support&quot;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on DRM_AMDGPU<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; select MFD_CORE<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; select PM_GENERIC_DOMAINS if PM<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;Enable AMD Audio CoPro=
cessor IP support&quot;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on DRM_AMDGPU<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; select MFD_CORE<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; select PM_GENERIC_DOMAINS if PM<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Choose this option to enab=
le ACP IP support for AMD SOCs.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; This adds the ACP (Audio C=
oProcessor) IP driver and wires<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; it up into the amdgpu driv=
er.&nbsp; The ACP block provides the DMA<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB1813D2AE8B11E5F190581995F74E0CY4PR12MB1813namp_--

--===============0849829786==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============0849829786==--
