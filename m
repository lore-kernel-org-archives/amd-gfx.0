Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68633C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 21:55:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F5A464E24
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 21:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5A464E24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABE156EC7B;
	Fri, 19 Feb 2021 21:55:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 765196EC7C
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 21:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613771739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vBMpTSf+1wxxAa88q83KnT8hkYgEz51qR1QFgOu1w3Q=;
 b=fSHm2altUIrzSUitp8pnJ82mGeLwjViMdL1YyvyxFHCRlgH9Av9EdeiX3nJ/1q5ztcn16t
 KhOS6AiUSrhLxlvVJ+kz3wcz4VtZ1DTiyEVDBRVsGmEsY2RF7bZMLXqv/UWsm40LxZLJ1q
 wGoHYbiowTh+eN2AI1C8izPen9DFGgU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-E2fIfTOtPHCkPSUXadBGIQ-1; Fri, 19 Feb 2021 16:55:37 -0500
X-MC-Unique: E2fIfTOtPHCkPSUXadBGIQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFA5A8710E4;
 Fri, 19 Feb 2021 21:55:34 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-118-5.rdu2.redhat.com [10.10.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B069C6A03C;
 Fri, 19 Feb 2021 21:55:32 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 23/30] drm/dp_dual_mode: Pass drm_device to
 drm_dp_dual_mode_set_tmds_output()
Date: Fri, 19 Feb 2021 16:53:19 -0500
Message-Id: <20210219215326.2227596-24-lyude@redhat.com>
In-Reply-To: <20210219215326.2227596-1-lyude@redhat.com>
References: <20210219215326.2227596-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, David Airlie <airlied@linux.ie>,
 Ramalingam C <ramalingam.c@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Uma Shankar <uma.shankar@intel.com>, Sean Paul <seanpaul@chromium.org>,
 Daniel Vetter <daniel@ffwll.ch>, Anshuman Gupta <anshuman.gupta@intel.com>,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Another function that we'll need to pass a drm_device (and not drm_dp_aux)
down to so that we can move over to using drm_dbg_*().

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_dual_mode_helper.c | 3 ++-
 drivers/gpu/drm/i915/display/intel_hdmi.c | 3 +--
 include/drm/drm_dp_dual_mode_helper.h     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_dual_mode_helper.c b/drivers/gpu/drm/drm_dp_dual_mode_helper.c
index 9ee75c568c37..a63d7de85309 100644
--- a/drivers/gpu/drm/drm_dp_dual_mode_helper.c
+++ b/drivers/gpu/drm/drm_dp_dual_mode_helper.c
@@ -336,6 +336,7 @@ EXPORT_SYMBOL(drm_dp_dual_mode_get_tmds_output);
 
 /**
  * drm_dp_dual_mode_set_tmds_output - Enable/disable TMDS output buffers in the DP dual mode adaptor
+ * @dev: &drm_device to use
  * @type: DP dual mode adaptor type
  * @adapter: I2C adapter for the DDC bus
  * @enable: enable (as opposed to disable) the TMDS output buffers
@@ -349,7 +350,7 @@ EXPORT_SYMBOL(drm_dp_dual_mode_get_tmds_output);
  * Returns:
  * 0 on success, negative error code on failure
  */
-int drm_dp_dual_mode_set_tmds_output(enum drm_dp_dual_mode_type type,
+int drm_dp_dual_mode_set_tmds_output(const struct drm_device *dev, enum drm_dp_dual_mode_type type,
 				     struct i2c_adapter *adapter, bool enable)
 {
 	uint8_t tmds_oen = enable ? 0 : DP_DUAL_MODE_TMDS_DISABLE;
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 52d99fec2435..b2442148b7f1 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -1270,8 +1270,7 @@ void intel_dp_dual_mode_set_tmds_output(struct intel_hdmi *hdmi, bool enable)
 	drm_dbg_kms(&dev_priv->drm, "%s DP dual mode adaptor TMDS output\n",
 		    enable ? "Enabling" : "Disabling");
 
-	drm_dp_dual_mode_set_tmds_output(hdmi->dp_dual_mode.type,
-					 adapter, enable);
+	drm_dp_dual_mode_set_tmds_output(&dev_priv->drm, hdmi->dp_dual_mode.type, adapter, enable);
 }
 
 static int intel_hdmi_hdcp_read(struct intel_digital_port *dig_port,
diff --git a/include/drm/drm_dp_dual_mode_helper.h b/include/drm/drm_dp_dual_mode_helper.h
index 23ce849152f3..8cb0dcd98a99 100644
--- a/include/drm/drm_dp_dual_mode_helper.h
+++ b/include/drm/drm_dp_dual_mode_helper.h
@@ -110,7 +110,7 @@ int drm_dp_dual_mode_max_tmds_clock(enum drm_dp_dual_mode_type type,
 				    struct i2c_adapter *adapter);
 int drm_dp_dual_mode_get_tmds_output(enum drm_dp_dual_mode_type type,
 				     struct i2c_adapter *adapter, bool *enabled);
-int drm_dp_dual_mode_set_tmds_output(enum drm_dp_dual_mode_type type,
+int drm_dp_dual_mode_set_tmds_output(const struct drm_device *dev, enum drm_dp_dual_mode_type type,
 				     struct i2c_adapter *adapter, bool enable);
 const char *drm_dp_get_dual_mode_type_name(enum drm_dp_dual_mode_type type);
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
