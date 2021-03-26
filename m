Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382B8C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 20:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23ED161945
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 20:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23ED161945
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E478F6F4C6;
	Fri, 26 Mar 2021 20:40:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C272C6F4BC
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 20:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616791202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fsHuKp62g6hI184+2qHzJYxOaWwL5I8FKOj2XVUcHtg=;
 b=ONlO/H0BRrthjCUxdQrET/exYLeyexCnzfS0Kf78MOE+txHgXOMMAcPo/3mMlH8BolAeXz
 sMVgsdnIw5kA0ifS51frzhH7ngtiBtYQuG+GXfpr9R9JwzquULK2RFE2BOTluppNelxeXK
 5K6mW4Xgk+OoCqxcuC/YZPvv1v2bXM0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-KLBOjqwhMLSETuQq4jEwnw-1; Fri, 26 Mar 2021 16:39:58 -0400
X-MC-Unique: KLBOjqwhMLSETuQq4jEwnw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 112921009E42;
 Fri, 26 Mar 2021 20:39:56 +0000 (UTC)
Received: from Whitewolf.lyude.net (ovpn-114-133.rdu2.redhat.com
 [10.10.114.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 246DF5DAA5;
 Fri, 26 Mar 2021 20:39:52 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Subject: [PATCH v2 15/20] drm/dp_dual_mode: Pass drm_device to
 drm_lspcon_(get|set)_mode()
Date: Fri, 26 Mar 2021 16:38:02 -0400
Message-Id: <20210326203807.105754-16-lyude@redhat.com>
In-Reply-To: <20210326203807.105754-1-lyude@redhat.com>
References: <20210326203807.105754-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@linux.ie>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>, Uma Shankar <uma.shankar@intel.com>,
 Maxime Ripard <mripard@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So that we can start using drm_dbg_*() throughout the DRM DP helpers.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_dual_mode_helper.c   |  8 +++++---
 drivers/gpu/drm/i915/display/intel_lspcon.c | 12 +++++++-----
 include/drm/drm_dp_dual_mode_helper.h       |  4 ++--
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_dual_mode_helper.c b/drivers/gpu/drm/drm_dp_dual_mode_helper.c
index c9c2952bcad2..dbf9b1fdec63 100644
--- a/drivers/gpu/drm/drm_dp_dual_mode_helper.c
+++ b/drivers/gpu/drm/drm_dp_dual_mode_helper.c
@@ -430,6 +430,7 @@ EXPORT_SYMBOL(drm_dp_get_dual_mode_type_name);
 /**
  * drm_lspcon_get_mode: Get LSPCON's current mode of operation by
  * reading offset (0x80, 0x41)
+ * @dev: &drm_device to use
  * @adapter: I2C-over-aux adapter
  * @mode: current lspcon mode of operation output variable
  *
@@ -437,7 +438,7 @@ EXPORT_SYMBOL(drm_dp_get_dual_mode_type_name);
  * 0 on success, sets the current_mode value to appropriate mode
  * -error on failure
  */
-int drm_lspcon_get_mode(struct i2c_adapter *adapter,
+int drm_lspcon_get_mode(const struct drm_device *dev, struct i2c_adapter *adapter,
 			enum drm_lspcon_mode *mode)
 {
 	u8 data;
@@ -477,13 +478,14 @@ EXPORT_SYMBOL(drm_lspcon_get_mode);
 /**
  * drm_lspcon_set_mode: Change LSPCON's mode of operation by
  * writing offset (0x80, 0x40)
+ * @dev: &drm_device to use
  * @adapter: I2C-over-aux adapter
  * @mode: required mode of operation
  *
  * Returns:
  * 0 on success, -error on failure/timeout
  */
-int drm_lspcon_set_mode(struct i2c_adapter *adapter,
+int drm_lspcon_set_mode(const struct drm_device *dev, struct i2c_adapter *adapter,
 			enum drm_lspcon_mode mode)
 {
 	u8 data = 0;
@@ -508,7 +510,7 @@ int drm_lspcon_set_mode(struct i2c_adapter *adapter,
 	 * so wait and retry until time out or done.
 	 */
 	do {
-		ret = drm_lspcon_get_mode(adapter, &current_mode);
+		ret = drm_lspcon_get_mode(dev, adapter, &current_mode);
 		if (ret) {
 			DRM_ERROR("can't confirm LSPCON mode change\n");
 			return ret;
diff --git a/drivers/gpu/drm/i915/display/intel_lspcon.c b/drivers/gpu/drm/i915/display/intel_lspcon.c
index ca25044e7d1b..ec0048024746 100644
--- a/drivers/gpu/drm/i915/display/intel_lspcon.c
+++ b/drivers/gpu/drm/i915/display/intel_lspcon.c
@@ -139,10 +139,11 @@ void lspcon_detect_hdr_capability(struct intel_lspcon *lspcon)
 
 static enum drm_lspcon_mode lspcon_get_current_mode(struct intel_lspcon *lspcon)
 {
+	struct intel_dp *intel_dp = lspcon_to_intel_dp(lspcon);
 	enum drm_lspcon_mode current_mode;
-	struct i2c_adapter *adapter = &lspcon_to_intel_dp(lspcon)->aux.ddc;
+	struct i2c_adapter *adapter = &intel_dp->aux.ddc;
 
-	if (drm_lspcon_get_mode(adapter, &current_mode)) {
+	if (drm_lspcon_get_mode(intel_dp->aux.drm_dev, adapter, &current_mode)) {
 		DRM_DEBUG_KMS("Error reading LSPCON mode\n");
 		return DRM_LSPCON_MODE_INVALID;
 	}
@@ -175,11 +176,12 @@ static enum drm_lspcon_mode lspcon_wait_mode(struct intel_lspcon *lspcon,
 static int lspcon_change_mode(struct intel_lspcon *lspcon,
 			      enum drm_lspcon_mode mode)
 {
+	struct intel_dp *intel_dp = lspcon_to_intel_dp(lspcon);
 	int err;
 	enum drm_lspcon_mode current_mode;
-	struct i2c_adapter *adapter = &lspcon_to_intel_dp(lspcon)->aux.ddc;
+	struct i2c_adapter *adapter = &intel_dp->aux.ddc;
 
-	err = drm_lspcon_get_mode(adapter, &current_mode);
+	err = drm_lspcon_get_mode(intel_dp->aux.drm_dev, adapter, &current_mode);
 	if (err) {
 		DRM_ERROR("Error reading LSPCON mode\n");
 		return err;
@@ -190,7 +192,7 @@ static int lspcon_change_mode(struct intel_lspcon *lspcon,
 		return 0;
 	}
 
-	err = drm_lspcon_set_mode(adapter, mode);
+	err = drm_lspcon_set_mode(intel_dp->aux.drm_dev, adapter, mode);
 	if (err < 0) {
 		DRM_ERROR("LSPCON mode change failed\n");
 		return err;
diff --git a/include/drm/drm_dp_dual_mode_helper.h b/include/drm/drm_dp_dual_mode_helper.h
index 01eec9ff5962..7ee482265087 100644
--- a/include/drm/drm_dp_dual_mode_helper.h
+++ b/include/drm/drm_dp_dual_mode_helper.h
@@ -114,8 +114,8 @@ int drm_dp_dual_mode_set_tmds_output(const struct drm_device *dev, enum drm_dp_d
 				     struct i2c_adapter *adapter, bool enable);
 const char *drm_dp_get_dual_mode_type_name(enum drm_dp_dual_mode_type type);
 
-int drm_lspcon_get_mode(struct i2c_adapter *adapter,
+int drm_lspcon_get_mode(const struct drm_device *dev, struct i2c_adapter *adapter,
 			enum drm_lspcon_mode *current_mode);
-int drm_lspcon_set_mode(struct i2c_adapter *adapter,
+int drm_lspcon_set_mode(const struct drm_device *dev, struct i2c_adapter *adapter,
 			enum drm_lspcon_mode reqd_mode);
 #endif
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
