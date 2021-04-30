Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92E6C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 14:15:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F4E561450
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 14:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4E561450
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EAF36F530;
	Fri, 30 Apr 2021 14:15:58 +0000 (UTC)
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 442436F525;
 Fri, 30 Apr 2021 09:45:11 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id AC1D45800D7;
 Fri, 30 Apr 2021 05:45:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Fri, 30 Apr 2021 05:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=+1jVcZdjfORyp
 rwDU8d7SzSPEQYAqkZClde0yfqzLq4=; b=jcJfqu+yfkofKEq6OAhV3P/ojh66h
 AKwMz4VJR5Eh7AFt/iCNux6zabsBKGY/rrB39PyF48kkcSRf/w4tBtYOxF/vTXlr
 HuxWhlpm7a770c7qXQ/0I1z1ITQbM6ZS8TZTrsrEdoYYsi4RaCzQzg9NK64FeVkZ
 Sox6ywrndPB03eJQHmvYd8yvMTRCi25CMi9xhf2OEjE9xOSxTy56nbNFmHo/UpLM
 0UbyDymBWBM9qT6UxgV89kueVr4WcATDZUagIxklphFvEcSTI4NnxYGJXnuMr3I+
 GyPLXSh5gHtvMbtbiG0k1ALKvPEJeuEgIeVtXZbxGVE7++gonlk8GhMxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=+1jVcZdjfORyprwDU8d7SzSPEQYAqkZClde0yfqzLq4=; b=Msa9nCat
 bPWQ9xl1pljP9Qxdnj3eGhocRTpYCl0DGWF+ve5gCOBLJNNOADTWBnT1qtckRQeN
 Wymt6YHz9fxcpNREdkajMWFF6zfb6ecio+KMj9fgTs9f+ZLRCpWT0RStlswTV4l+
 eQJaCBGd/HyRa2bfUisUbAZBIVYLs0mHwFPVTQRHVeL6QPv8fhp25km2KZEqssvC
 1pJigUX0q0QpwrEWiV/NlXKeoww4FEB5fdwLxt2Mlf3ORE+DSHmeJQE38OQyioxk
 CforjQj2yikTbqudTZ7rt1HnX8trK6+FYMMCzZdCoJszdDyZrWW1EFO0q0Io5GSI
 chV/V1nJMyscnQ==
X-ME-Sender: <xms:ptGLYGuMw2jPo4DXmebqO63tNBLp3vxLzzSRr3ohgLFTn9NWI8xszg>
 <xme:ptGLYLcHBdCOF6w0FC83wSQPiDSludwn8WrannYB4V3tn4BYtOoBjyh_39VTO3SM8
 ukw2SjCPmNw_bH4ffo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddviedgudelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
 vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
 htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
 hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:ptGLYBwLJ90G_soKRBipo0VcEyfG_fXy8vERY2H5jr7g3cdwSeEPdg>
 <xmx:ptGLYBNPTghXWUS6BBrwWZProxg4gQofIaV-aHuo45lu8mpUDHkkmA>
 <xmx:ptGLYG-BKoADuw3ZoM0d3T4jmqFXF_PishVOM27hCSRbO4AMyCcmYQ>
 <xmx:ptGLYKRIuuIqkeXJNivuq4EWHDvbVkWGe0LVYzXgKcftrWBzD_0U6g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Fri, 30 Apr 2021 05:45:09 -0400 (EDT)
From: Maxime Ripard <maxime@cerno.tech>
To: dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>,
 David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v3 5/5] drm/vc4: hdmi: Signal the proper colorimetry info in
 the infoframe
Date: Fri, 30 Apr 2021 11:44:51 +0200
Message-Id: <20210430094451.2145002-5-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210430094451.2145002-1-maxime@cerno.tech>
References: <20210430094451.2145002-1-maxime@cerno.tech>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 30 Apr 2021 14:15:56 +0000
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
Cc: Tim Gover <tim.gover@raspberrypi.com>,
 Neil Armstrong <narmstrong@baylibre.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Andrzej Hajda <a.hajda@samsung.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Phil Elwell <phil@raspberrypi.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, amd-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>, Jonas Karlman <jonas@kwiboo.se>,
 Leo Li <sunpeng.li@amd.com>, intel-gfx@lists.freedesktop.org,
 Jani Nikula <jani.nikula@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Jernej Skrabec <jernej.skrabec@siol.net>, Dom Cobley <dom@raspberrypi.com>,
 Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org,
 Robert Foss <robert.foss@linaro.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Our driver while supporting HDR didn't send the proper colorimetry info
in the AVI infoframe.

Let's add the property needed so that the userspace can let us know what
the colorspace is supposed to be.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>

---

Changes from v2:
  - Rebased on current drm-misc-next

Changes from v1:
  - New patch
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index a33fa1662588..a22e17788074 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -226,7 +226,8 @@ static int vc4_hdmi_connector_atomic_check(struct drm_connector *connector,
 	if (!crtc)
 		return 0;
 
-	if (!drm_connector_atomic_hdr_metadata_equal(old_state, new_state)) {
+	if (old_state->colorspace != new_state->colorspace ||
+	    !drm_connector_atomic_hdr_metadata_equal(old_state, new_state)) {
 		struct drm_crtc_state *crtc_state;
 
 		crtc_state = drm_atomic_get_crtc_state(state, crtc);
@@ -316,6 +317,11 @@ static int vc4_hdmi_connector_init(struct drm_device *dev,
 	if (ret)
 		return ret;
 
+	ret = drm_mode_create_hdmi_colorspace_property(connector);
+	if (ret)
+		return ret;
+
+	drm_connector_attach_colorspace_property(connector);
 	drm_connector_attach_tv_margin_properties(connector);
 	drm_connector_attach_max_bpc_property(connector, 8, 12);
 
@@ -424,7 +430,7 @@ static void vc4_hdmi_set_avi_infoframe(struct drm_encoder *encoder)
 					   vc4_encoder->limited_rgb_range ?
 					   HDMI_QUANTIZATION_RANGE_LIMITED :
 					   HDMI_QUANTIZATION_RANGE_FULL);
-
+	drm_hdmi_avi_infoframe_colorspace(&frame.avi, cstate);
 	drm_hdmi_avi_infoframe_bars(&frame.avi, cstate);
 
 	vc4_hdmi_write_infoframe(encoder, &frame);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
