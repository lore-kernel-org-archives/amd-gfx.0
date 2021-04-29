Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1801C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 14:13:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36961610A0
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 14:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36961610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADF986EEA0;
	Thu, 29 Apr 2021 14:13:01 +0000 (UTC)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DDA36EE9E;
 Thu, 29 Apr 2021 13:39:54 +0000 (UTC)
Received: from 1-171-217-32.dynamic-ip.hinet.net ([1.171.217.32]
 helo=localhost) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>)
 id 1lc6tS-00049f-TU; Thu, 29 Apr 2021 13:39:51 +0000
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Subject: [PATCH] drm/radeon/dpm: Disable sclk switching when two 4K 60Hz
 monitors are connected
Date: Thu, 29 Apr 2021 21:39:40 +0800
Message-Id: <20210429133941.531730-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 29 Apr 2021 14:13:00 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Screen flickers rapidly when two 4K 60Hz monitors are connected to an
Oland card. This issue doesn't happen when one monitor is 4K 60Hz
(pixelclock 594MHz) and another one is 4K 30Hz (pixelclock 297MHz).

The issue is gone after setting "power_dpm_force_performance_level" to
"high". Following the lead, we found that the issue only occurs when
sclk is too low.

So resolve the issue by disabling sclk switching when there are two
monitors that requires high pixelclock (> 297MHz).

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/gpu/drm/radeon/radeon.h    | 1 +
 drivers/gpu/drm/radeon/radeon_pm.c | 8 ++++++++
 drivers/gpu/drm/radeon/si_dpm.c    | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 42281fce552e6..56ed5634cebef 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -1549,6 +1549,7 @@ struct radeon_dpm {
 	void                    *priv;
 	u32			new_active_crtcs;
 	int			new_active_crtc_count;
+	int			high_pixelclock_count;
 	u32			current_active_crtcs;
 	int			current_active_crtc_count;
 	bool single_display;
diff --git a/drivers/gpu/drm/radeon/radeon_pm.c b/drivers/gpu/drm/radeon/radeon_pm.c
index 0c1950f4e146f..3861c0b98fcf3 100644
--- a/drivers/gpu/drm/radeon/radeon_pm.c
+++ b/drivers/gpu/drm/radeon/radeon_pm.c
@@ -1767,6 +1767,7 @@ static void radeon_pm_compute_clocks_dpm(struct radeon_device *rdev)
 	struct drm_device *ddev = rdev->ddev;
 	struct drm_crtc *crtc;
 	struct radeon_crtc *radeon_crtc;
+	struct radeon_connector *radeon_connector;
 
 	if (!rdev->pm.dpm_enabled)
 		return;
@@ -1776,6 +1777,7 @@ static void radeon_pm_compute_clocks_dpm(struct radeon_device *rdev)
 	/* update active crtc counts */
 	rdev->pm.dpm.new_active_crtcs = 0;
 	rdev->pm.dpm.new_active_crtc_count = 0;
+	rdev->pm.dpm.high_pixelclock_count = 0;
 	if (rdev->num_crtc && rdev->mode_info.mode_config_initialized) {
 		list_for_each_entry(crtc,
 				    &ddev->mode_config.crtc_list, head) {
@@ -1783,6 +1785,12 @@ static void radeon_pm_compute_clocks_dpm(struct radeon_device *rdev)
 			if (crtc->enabled) {
 				rdev->pm.dpm.new_active_crtcs |= (1 << radeon_crtc->crtc_id);
 				rdev->pm.dpm.new_active_crtc_count++;
+				if (!radeon_crtc->connector)
+					continue;
+
+				radeon_connector = to_radeon_connector(radeon_crtc->connector);
+				if (radeon_connector->pixelclock_for_modeset > 297000)
+					rdev->pm.dpm.high_pixelclock_count++;
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index 9186095518047..be6fa3257d1bc 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -2995,6 +2995,9 @@ static void si_apply_state_adjust_rules(struct radeon_device *rdev,
 	    ni_dpm_vblank_too_short(rdev))
 		disable_mclk_switching = true;
 
+	if (rdev->pm.dpm.high_pixelclock_count > 1)
+		disable_sclk_switching = true;
+
 	if (rps->vclk || rps->dclk) {
 		disable_mclk_switching = true;
 		disable_sclk_switching = true;
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
