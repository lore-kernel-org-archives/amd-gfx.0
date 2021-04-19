Return-Path: <SRS0=FsAh=JQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952D7C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 22:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 626C760FF1
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 22:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626C760FF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E33556E44F;
	Mon, 19 Apr 2021 22:57:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A956A6E466
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Apr 2021 22:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618873030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YMmr5Ouhvh6nm+wTQmmPynlw/HQvORWYNdyjVzafLV4=;
 b=B5i17ZBXfwAg1cHnMh9gMo2gwQOxE0WUibH7XcTUuU0qhWd7InBj7ANJcSUM/yPXusiG3F
 /GgfcXqKqq+5llLQ2dUnsZBBt8XBVhqPk+qRyV+w4dHfDtKERrsYfRFHKXghN1F1fsM9nO
 6nDzS8YU6DQoL5rpGYOGfQudkxUShOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-Cy6vB_jXPCml40vMmb-1OQ-1; Mon, 19 Apr 2021 18:57:06 -0400
X-MC-Unique: Cy6vB_jXPCml40vMmb-1OQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47BCD817469;
 Mon, 19 Apr 2021 22:57:03 +0000 (UTC)
Received: from Ruby.lyude.net (ovpn-119-153.rdu2.redhat.com [10.10.119.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4014C5C1C4;
 Mon, 19 Apr 2021 22:56:59 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v3 08/20] drm/dp: Pass drm_dp_aux to
 drm_dp_link_train_clock_recovery_delay()
Date: Mon, 19 Apr 2021 18:55:10 -0400
Message-Id: <20210419225523.184856-9-lyude@redhat.com>
In-Reply-To: <20210419225523.184856-1-lyude@redhat.com>
References: <20210419225523.184856-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: David Airlie <airlied@linux.ie>, Imre Deak <imre.deak@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Oleg Vasilev <oleg.vasilev@intel.com>, Tanmay Shah <tanmay@codeaurora.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Lee Jones <lee.jones@linaro.org>, Chandan Uddaraju <chandanu@codeaurora.org>,
 Michal Simek <michal.simek@xilinx.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Thierry Reding <treding@nvidia.com>, Jeevan B <jeevan.b@intel.com>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <swboyd@chromium.org>,
 Kuogee Hsieh <khsieh@codeaurora.org>, Sean Paul <sean@poorly.run>,
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
 Hyun Kwon <hyun.kwon@xilinx.com>, open list <linux-kernel@vger.kernel.org>,
 Manasi Navare <manasi.d.navare@intel.com>, Rob Clark <robdclark@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <freedreno@lists.freedesktop.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So that we can start using drm_dbg_*() in
drm_dp_link_train_clock_recovery_delay().

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/amd/amdgpu/atombios_dp.c              | 2 +-
 drivers/gpu/drm/drm_dp_helper.c                       | 3 ++-
 drivers/gpu/drm/i915/display/intel_dp_link_training.c | 2 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c                      | 2 +-
 drivers/gpu/drm/msm/edp/edp_ctrl.c                    | 2 +-
 drivers/gpu/drm/radeon/atombios_dp.c                  | 2 +-
 drivers/gpu/drm/xlnx/zynqmp_dp.c                      | 2 +-
 include/drm/drm_dp_helper.h                           | 4 +++-
 8 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_dp.c b/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
index 14a097322238..b0eaeb6afd29 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
@@ -617,7 +617,7 @@ amdgpu_atombios_dp_link_train_cr(struct amdgpu_atombios_dp_link_train_info *dp_i
 	dp_info->tries = 0;
 	voltage = 0xff;
 	while (1) {
-		drm_dp_link_train_clock_recovery_delay(dp_info->dpcd);
+		drm_dp_link_train_clock_recovery_delay(dp_info->aux, dp_info->dpcd);
 
 		if (drm_dp_dpcd_read_link_status(dp_info->aux,
 						 dp_info->link_status) <= 0) {
diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index b197fdac2334..3a3c4cfb9ac6 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -132,7 +132,8 @@ u8 drm_dp_get_adjust_request_post_cursor(const u8 link_status[DP_LINK_STATUS_SIZ
 }
 EXPORT_SYMBOL(drm_dp_get_adjust_request_post_cursor);
 
-void drm_dp_link_train_clock_recovery_delay(const u8 dpcd[DP_RECEIVER_CAP_SIZE])
+void drm_dp_link_train_clock_recovery_delay(const struct drm_dp_aux *aux,
+					    const u8 dpcd[DP_RECEIVER_CAP_SIZE])
 {
 	unsigned long rd_interval = dpcd[DP_TRAINING_AUX_RD_INTERVAL] &
 					 DP_TRAINING_AUX_RD_MASK;
diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
index 591ddc4b876c..198ddb3c173a 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
@@ -513,7 +513,7 @@ static void intel_dp_link_training_clock_recovery_delay(struct intel_dp *intel_d
 							enum drm_dp_phy dp_phy)
 {
 	if (dp_phy == DP_PHY_DPRX)
-		drm_dp_link_train_clock_recovery_delay(intel_dp->dpcd);
+		drm_dp_link_train_clock_recovery_delay(&intel_dp->aux, intel_dp->dpcd);
 	else
 		drm_dp_lttpr_link_train_clock_recovery_delay();
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 1390f3547fde..264a9eae87d3 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1103,7 +1103,7 @@ static int dp_ctrl_link_train_1(struct dp_ctrl_private *ctrl,
 	tries = 0;
 	old_v_level = ctrl->link->phy_params.v_level;
 	for (tries = 0; tries < maximum_retries; tries++) {
-		drm_dp_link_train_clock_recovery_delay(ctrl->panel->dpcd);
+		drm_dp_link_train_clock_recovery_delay(ctrl->aux, ctrl->panel->dpcd);
 
 		ret = dp_ctrl_read_link_status(ctrl, link_status);
 		if (ret)
diff --git a/drivers/gpu/drm/msm/edp/edp_ctrl.c b/drivers/gpu/drm/msm/edp/edp_ctrl.c
index 57af3d8b6699..6501598448b4 100644
--- a/drivers/gpu/drm/msm/edp/edp_ctrl.c
+++ b/drivers/gpu/drm/msm/edp/edp_ctrl.c
@@ -608,7 +608,7 @@ static int edp_start_link_train_1(struct edp_ctrl *ctrl)
 	tries = 0;
 	old_v_level = ctrl->v_level;
 	while (1) {
-		drm_dp_link_train_clock_recovery_delay(ctrl->dpcd);
+		drm_dp_link_train_clock_recovery_delay(ctrl->drm_aux, ctrl->dpcd);
 
 		rlen = drm_dp_dpcd_read_link_status(ctrl->drm_aux, link_status);
 		if (rlen < DP_LINK_STATUS_SIZE) {
diff --git a/drivers/gpu/drm/radeon/atombios_dp.c b/drivers/gpu/drm/radeon/atombios_dp.c
index c50c504bad50..299b9d8da376 100644
--- a/drivers/gpu/drm/radeon/atombios_dp.c
+++ b/drivers/gpu/drm/radeon/atombios_dp.c
@@ -680,7 +680,7 @@ static int radeon_dp_link_train_cr(struct radeon_dp_link_train_info *dp_info)
 	dp_info->tries = 0;
 	voltage = 0xff;
 	while (1) {
-		drm_dp_link_train_clock_recovery_delay(dp_info->dpcd);
+		drm_dp_link_train_clock_recovery_delay(dp_info->aux, dp_info->dpcd);
 
 		if (drm_dp_dpcd_read_link_status(dp_info->aux,
 						 dp_info->link_status) <= 0) {
diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index e8efbab5ae69..6ef2d9b3884c 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -713,7 +713,7 @@ static int zynqmp_dp_link_train_cr(struct zynqmp_dp *dp)
 		if (ret)
 			return ret;
 
-		drm_dp_link_train_clock_recovery_delay(dp->dpcd);
+		drm_dp_link_train_clock_recovery_delay(&dp->aux, dp->dpcd);
 		ret = drm_dp_dpcd_read_link_status(&dp->aux, link_status);
 		if (ret < 0)
 			return ret;
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 417b2c101a1e..9900c93e4f2c 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -29,6 +29,7 @@
 #include <drm/drm_connector.h>
 
 struct drm_device;
+struct drm_dp_aux;
 
 /*
  * Unless otherwise noted, all values are from the DP 1.1a spec.  Note that
@@ -1482,7 +1483,8 @@ u8 drm_dp_get_adjust_request_post_cursor(const u8 link_status[DP_LINK_STATUS_SIZ
 #define DP_LTTPR_COMMON_CAP_SIZE	8
 #define DP_LTTPR_PHY_CAP_SIZE		3
 
-void drm_dp_link_train_clock_recovery_delay(const u8 dpcd[DP_RECEIVER_CAP_SIZE]);
+void drm_dp_link_train_clock_recovery_delay(const struct drm_dp_aux *aux,
+					    const u8 dpcd[DP_RECEIVER_CAP_SIZE]);
 void drm_dp_lttpr_link_train_clock_recovery_delay(void);
 void drm_dp_link_train_channel_eq_delay(const u8 dpcd[DP_RECEIVER_CAP_SIZE]);
 void drm_dp_lttpr_link_train_channel_eq_delay(const u8 caps[DP_LTTPR_PHY_CAP_SIZE]);
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
