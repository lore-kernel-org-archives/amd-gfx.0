From: Umang Raghuvanshi <u@umangis.me>
Subject: [PATCH 1/1] drm/radeon: Fix GPU lockups for the R7 M270
Date: Mon, 13 Mar 2017 13:49:53 +0530
Message-ID: <20170313081953.8306-2-u@umangis.me>
References: <20170313081953.8306-1-u@umangis.me>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1091969192=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170313081953.8306-1-u@umangis.me>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: David Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Umang Raghuvanshi <u@umangis.me>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

This is a multi-part message in MIME format...

--===============1091969192==
Content-type: multipart/alternative; boundary="----------=_1489393223-24309-18"

This is a multi-part message in MIME format...

------------=_1489393223-24309-18

Commit 3a69adfe5617 ("drm/radeon: drop oland quirks") removed
quirks for Oland but also caused a regression where M270 GPUs
would go into a lock-up when OpenGL intensive applications were used.
This reverts the change only for the M270 and fixes the lock-ups.

Signed-off-by: Umang Raghuvanshi <u@umangis.me>
---
 drivers/gpu/drm/radeon/si_dpm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index 2944916f7102..fc2f998bdbf0 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -3017,6 +3017,11 @@ static void si_apply_state_adjust_rules(struct radeon_device *rdev,
 		    (rdev->pdev->device == 0x6667)) {
 			max_sclk = 75000;
 		}
+	} else if (rdev->family == CHIP_OLAND && rdev->pdev->device == 0x6604 &&
+		   rdev->pdev->revision == 0) {
+		// Fix max_sclk and max_mclk for the Radeon R7 M270
+		max_sclk = 75000;
+		max_mclk = 80000;
 	}
 	/* Apply dpm quirks */
 	while (p && p->chip_device != 0) {
-- 
2.12.0


------------=_1489393223-24309-18
Content-Type: text/html
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

<html><body>
<p>Commit 3a69adfe5617 (&quot;drm/radeon: drop oland quirks&quot;) removed =
quirks for Oland but also caused a regression where M270 GPUs would go into=
 a lock-up when OpenGL intensive applications were used. This reverts the c=
hange only for the M270 and fixes the lock-ups.</p>
<h3>Signed-off-by: Umang Raghuvanshi &lt;u@umangis.me&gt;</h3>
<pre>drivers/gpu/drm/radeon/si_dpm.c | 5 +++++
1 file changed, 5 insertions(+)</pre>
<p>diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si=
_dpm.c index 2944916f7102..fc2f998bdbf0 100644 --- a/drivers/gpu/drm/radeon=
/si_dpm.c +++ b/drivers/gpu/drm/radeon/si_dpm.c @@ -3017,6 +3017,11 @@ stat=
ic void si_apply_state_adjust_rules(struct radeon_device *rdev,</p>
<pre>    (rdev-&gt;pdev-&gt;device =3D=3D 0x6667)) {
	max_sclk =3D 75000;
}</pre>
<p>+	} else if (rdev-&gt;family =3D=3D CHIP_OLAND &amp;&amp; rdev-&gt;pdev-=
&gt;device =3D=3D 0&times;6604 &amp;&amp; +		   rdev-&gt;pdev-&gt;revision =
=3D=3D 0) { +		// Fix max_sclk and max_mclk for the Radeon R7 M270 +		max_s=
clk =3D 75000; +		max_mclk =3D 80000;</p>
<pre>}
/* Apply dpm quirks */
while (p &amp;&amp; p-&gt;chip_device !=3D 0) {</pre>
<p>&mdash; 2.12.0</p>

<img src=3D"https://u4914032.ct.sendgrid.net/wf/open?upn=3DfsWdnASKOjVAY-2B=
ZFE2xi1fwAZcbRCnZQ5h6lQPrK11KnK8deIHF2HWde0VQyn86xB2JFabjvRbrrFHOx0-2BNCCzj=
FYMKd4DqgAyFHkaWG2CI29OFR-2BqkElPcJKcaG3gupZl90WoCemXbDm1sS1U5tu5l3EPSm0fYz=
oSWMyY6WuI2N4yxKHmygXWbQ94qQ-2B6UPfyZ4D07hw5knFHrw-2FloFPRn6Q6TiXoXH7IPJFNH=
fJjs-3D" alt=3D"" width=3D"1" height=3D"1" border=3D"0" style=3D"height:1px=
 !important;width:1px !important;border-width:0 !important;margin-top:0 !im=
portant;margin-bottom:0 !important;margin-right:0 !important;margin-left:0 =
!important;padding-top:0 !important;padding-bottom:0 !important;padding-rig=
ht:0 !important;padding-left:0 !important;"/>
</body></html>

------------=_1489393223-24309-18--

--===============1091969192==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1091969192==--
