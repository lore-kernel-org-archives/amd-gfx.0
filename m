From: "Zhu, Rex" <Rex.Zhu@amd.com>
Subject: Re: [PATCH] drm/amd/pp: Fix uninitialized variable
Date: Mon, 18 Jun 2018 11:42:34 +0000
Message-ID: <CY4PR12MB1687C56D02C99719379909B1FB710@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1529307062-21787-1-git-send-email-rajan.vaja@softnautics.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1580497569=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1529307062-21787-1-git-send-email-rajan.vaja@softnautics.com>
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
To: "rajan.vaja@gmail.com" <rajan.vaja@gmail.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "StDenis, Tom" <Tom.StDenis@amd.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

--===============1580497569==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687C56D02C99719379909B1FB710CY4PR12MB1687namp_"

--_000_CY4PR12MB1687C56D02C99719379909B1FB710CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Applied. Thanks.


Best Regards

Rex


________________________________
From: rajan.vaja@gmail.com <rajan.vaja@gmail.com>
Sent: Monday, June 18, 2018 3:31 PM
To: Deucher, Alexander; Koenig, Christian; Zhou, David(ChunMing); Zhu, Rex;=
 StDenis, Tom
Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-k=
ernel@vger.kernel.org; Rajan Vaja
Subject: [PATCH] drm/amd/pp: Fix uninitialized variable

From: Rajan Vaja <rajan.vaja@gmail.com>

Initialize variable to 0 before performing logical OR operation.

Signed-off-by: Rajan Vaja <rajan.vaja@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c b/drive=
rs/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
index a9efd855..bde01d4 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
@@ -1090,7 +1090,7 @@ static int vega10_disable_se_edc_config(struct pp_hwm=
gr *hwmgr)
 static int vega10_enable_psm_gc_edc_config(struct pp_hwmgr *hwmgr)
 {
         struct amdgpu_device *adev =3D hwmgr->adev;
-       int result;
+       int result =3D 0;
         uint32_t num_se =3D 0;
         uint32_t count, data;

--
2.7.4


--_000_CY4PR12MB1687C56D02C99719379909B1FB710CY4PR12MB1687namp_
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
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Applied. Thanks.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> rajan.vaja@gmail.com=
 &lt;rajan.vaja@gmail.com&gt;<br>
<b>Sent:</b> Monday, June 18, 2018 3:31 PM<br>
<b>To:</b> Deucher, Alexander; Koenig, Christian; Zhou, David(ChunMing); Zh=
u, Rex; StDenis, Tom<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; =
linux-kernel@vger.kernel.org; Rajan Vaja<br>
<b>Subject:</b> [PATCH] drm/amd/pp: Fix uninitialized variable</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Rajan Vaja &lt;rajan.vaja@gmail.com&gt;<br>
<br>
Initialize variable to 0 before performing logical OR operation.<br>
<br>
Signed-off-by: Rajan Vaja &lt;rajan.vaja@gmail.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c b/drive=
rs/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c<br>
index a9efd855..bde01d4 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c<br=
>
@@ -1090,7 &#43;1090,7 @@ static int vega10_disable_se_edc_config(struct pp=
_hwmgr *hwmgr)<br>
&nbsp;static int vega10_enable_psm_gc_edc_config(struct pp_hwmgr *hwmgr)<br=
>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D hwmgr-&gt;adev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t num_se =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t count, data;<br>
&nbsp;<br>
-- <br>
2.7.4<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1687C56D02C99719379909B1FB710CY4PR12MB1687namp_--

--===============1580497569==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1580497569==--
