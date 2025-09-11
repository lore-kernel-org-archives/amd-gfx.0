Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64ACFCAC58E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 17:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C59410E3C7;
	Thu, 11 Sep 2025 17:31:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="I7p3dkA3";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78AA610E3C7;
 Thu, 11 Sep 2025 17:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0bWmdsnF/4zPxDlqWWRGjB3WSJanqOjltr1gn9fFtjo=; b=I7p3dkA3V8LUiaWsFZMsavUSUs
 YnGWD787vB5rUURiFcdXKbdkh0DgD/ASwWBtYQ9P0L6m//3QjuDphrpEII0qeUNwX2//d0eizSKHV
 nDpHkOfSmZfXuZ0aqk5Uj1YYBOmB1XLU+CiGpesW2pcvjtDV+9lAWZq5NVMYd70Ts9oZ6FjwujPVx
 6cwYlpuPKk+3sqVJuik2zCcyAe1aXP6Pxp2lvJJCAaPzKA4CHopM0PduZVCMcc38DzU4TjQfF3ba2
 PuZ4U+3WaMtmWJyXJyIvKy0amk0zN3rEeb2e+luIH3jODc6fyEGQ8uVLUlqP+xCUV61a8QvRhoGAn
 RQUl7uFg==;
Received: from [189.6.16.239] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uwl8c-009uA8-Uc; Thu, 11 Sep 2025 19:31:15 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com
Cc: Xaver Hugl <xaver.hugl@gmail.com>,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
 Christopher Snowhill <kode54@gmail.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
Subject: [PATCH v3 1/2] drm/amd/display: update color on atomic commit time
Date: Thu, 11 Sep 2025 14:21:19 -0300
Message-ID: <20250911173101.1960156-2-mwen@igalia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250911173101.1960156-1-mwen@igalia.com>
References: <20250911173101.1960156-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use `atomic_commit_setup` to change the DC stream state. It's a
preparation to remove from `atomic_check` changes in CRTC color
components of DC stream state and prevent DC to commit TEST_ONLY
changes.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4444
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 36 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fadc6098eaee..f6462ff7251f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -233,6 +233,7 @@ static int amdgpu_dm_encoder_init(struct drm_device *dev,
 
 static int amdgpu_dm_connector_get_modes(struct drm_connector *connector);
 
+static int amdgpu_dm_atomic_setup_commit(struct drm_atomic_state *state);
 static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state);
 
 static int amdgpu_dm_atomic_check(struct drm_device *dev,
@@ -3641,7 +3642,7 @@ static const struct drm_mode_config_funcs amdgpu_dm_mode_funcs = {
 
 static struct drm_mode_config_helper_funcs amdgpu_dm_mode_config_helperfuncs = {
 	.atomic_commit_tail = amdgpu_dm_atomic_commit_tail,
-	.atomic_commit_setup = drm_dp_mst_atomic_setup_commit,
+	.atomic_commit_setup = amdgpu_dm_atomic_setup_commit,
 };
 
 static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
@@ -10272,6 +10273,39 @@ static void amdgpu_dm_update_hdcp(struct drm_atomic_state *state)
 	}
 }
 
+static int amdgpu_dm_atomic_setup_commit(struct drm_atomic_state *state)
+{
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
+	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
+	int i, ret;
+
+	ret = drm_dp_mst_atomic_setup_commit(state);
+	if (ret)
+		return ret;
+
+	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
+		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
+		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
+		/*
+		 * Color management settings. We also update color properties
+		 * when a modeset is needed, to ensure it gets reprogrammed.
+		 */
+		if (dm_new_crtc_state->base.active && dm_new_crtc_state->stream &&
+		    (dm_new_crtc_state->base.color_mgmt_changed ||
+		     dm_old_crtc_state->regamma_tf != dm_new_crtc_state->regamma_tf ||
+		     drm_atomic_crtc_needs_modeset(new_crtc_state))) {
+			ret = amdgpu_dm_update_crtc_color_mgmt(dm_new_crtc_state);
+			if (ret) {
+				drm_dbg_atomic(state->dev, "Failed to update color state\n");
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
 /**
  * amdgpu_dm_atomic_commit_tail() - AMDgpu DM's commit tail implementation.
  * @state: The atomic state to commit
-- 
2.47.2

