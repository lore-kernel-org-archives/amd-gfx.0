Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5FBC55838
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 06:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF9BF10F0E1;
	Thu,  6 Aug 2026 06:55:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pcKNH6Na";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2598C10EE06
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 11:53:27 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso990763a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Aug 2026 04:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785930807; x=1786535607; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wZmAv5CS5wcrTilv9n4wgwTnIXxRxgyS644EofS64Tg=;
 b=pcKNH6Na2G9eZHwhnLJizTtIwzqHQIwasIm5oeDeLtAhflATECLY78J9bRXRS2kqoT
 l1CT2NdAYmrPb9otspvOZ69BNhrB0jAKvtIkj8r1qN2MY1TxXCXZZqVkr6WIeq8bjBJ3
 vb9xJ8TVNIRmZ9S7ab2Wem/8bGuDiIKW3H6xAeWkFQfDy/0ekbi6DcEJB0qA5hf9k4sH
 KHMhVHO8WJHjo6/2+vs+xs+m9zG45e7DZ7h2kDt7v51c/wrvy6zYd4HNPCTK7qdn8bwK
 7QWCJU3pFp7RZw3fry+0PkbENHZekjvdq9B+k8xI06S739RBuN1jSJAEEih5Yetn10qu
 bimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785930807; x=1786535607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wZmAv5CS5wcrTilv9n4wgwTnIXxRxgyS644EofS64Tg=;
 b=X/HtCR6Mda77YQkbs3FLLjxwr1jFptRQYmfLC/cosYMR3MpC4IEW49erkUtHTJcEMN
 BNhN7cR3qV5F8y+FZsrak8o7KIv5obwyWjpFy9YIuTawFqBhEscy5P7ffyOQPI7+eGwE
 F3KP1ZKYfnXMJRw8TmT+J3HFVnTK1Opxb7H70KdppMHESCXA8QQOoq+Cmm9E6w9iC3PY
 mLXVK+T3sWuSnLVFTolPEOF0gOkuFE+vnxQGQVhST5FtQP1JlkxZCKI+AdFUdD/cLf3T
 aulpdlcQR7XwC2yNFLI8A/5UsFrxnyOb+m86i/6Ef+2guqpVxA3u5E3/IP9ryUeIbKXB
 NPJQ==
X-Gm-Message-State: AOJu0Yw6AMHtA9qezBwhuS1bftFoQCysRuZ12d2AwUTOimDGHdMTRm0D
 zvEPg53xD+eSkVkpeDPNUFlcvuQKNERsx721/AVs2hm6A5bH25TO2sWGceWHhiQPyNA=
X-Gm-Gg: AR+sD1005kF6SQjKxH76xMFdaxKhFRmILQZ96CTYUUvoVWLFnPTawTUe4jUiJBaeMrP
 qydadDD4KZZOkoN6CvU/zSzpa+H/6h+VQ4PQAsUDLjbEO8xB2ZkU3ps6TGqfGy6KNYYyfjAwRYN
 8G8IhccNP4PcQ1yCNbOcKAs3+kqiFwkM/6P62BS6Z6ndC7JkwPcKxMs8LvWN+Re73bFof4puYQA
 rvKy/gtvSXtsypV88x8bY9/DkqcqPci42Abnlsj2tn9kozGOR+iRxTnwCnarLgxCW8eqHasehLF
 VUKIwM9+O4vO3Sq4r3nvjIOLkw4wStoPw6Qbi+FcIt1J3PuXb3P4fUbtMdNDkNNTNrXk+pnplMO
 VRQ64WMHafV9kfG8mpQ3n1JdH/paSOFdBJvKrjBq+twUMx8/aV45tOJ6hKKx160reZAXelpzJA2
 g9nR4D77os5Jnjp/nijAH/tqsnscCyUTBPzbEh4S2EONJdGxeFmBwGctG5I2riHhMn5ABKTX/zd
 ad9YVrhiTgHGoSK6YRHJMn5
X-Received: by 2002:a17:90b:1c0a:b0:380:105f:8ffd with SMTP id
 98e67ed59e1d1-3903c5dc172mr5224983a91.16.1785930806631; 
 Wed, 05 Aug 2026 04:53:26 -0700 (PDT)
Received: from localhost ([64.176.39.245]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38febfdae56sm4667245a91.2.2026.08.05.04.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 04:53:26 -0700 (PDT)
From: David Weber <weber.aulendorf@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 someguy@effective-light.com, David Weber <weber.aulendorf@gmail.com>
Subject: [RFC PATCH 3/5] drm/amd/display: invalidate PSR request cache after
 DMUB reset
Date: Wed,  5 Aug 2026 13:52:46 +0200
Message-ID: <74f249d9212e7ada4c3e6eaa5961d9c54943648d.1785929873.git.weber.aulendorf@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785929873.git.weber.aulendorf@gmail.com>
References: <cover.1785929873.git.weber.aulendorf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2026 06:55:48 +0000
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

The cached PSR allow-active request is used to suppress redundant
firmware programming. A DMUB reset or resume can discard firmware state
without destroying the corresponding dc_link, leaving that request cache
stale.

Invalidate the allow-active cache whenever DMUB is reset or resumed.
Require a valid cache in direct PSR control so the next request can
reestablish the firmware state.

Preserve cache validity alongside the clock manager's saved PSR request
and do not restore an invalid snapshot. Replay restore remains unchanged;
the PSR validity flag does not describe Replay state.

Fixes: 3c108046e1d6 ("drm/amd/display: Add power module on Linux")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: David Weber <weber.aulendorf@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++++++++++++++
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c |  9 +++++++--
 drivers/gpu/drm/amd/display/dc/core/dc.c         |  6 ++++--
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h  |  1 +
 4 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9c564cd5edee..ee3d65226a69 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1304,6 +1304,19 @@ static  void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int pin)
 	}
 }
 
+static void dm_invalidate_psr_request_caches(struct amdgpu_device *adev)
+{
+	struct dc *dc = adev->dm.dc;
+	int i;
+
+	if (!dc)
+		return;
+
+	for (i = 0; i < dc->link_count; i++)
+		if (dc->links[i])
+			dc->links[i]->psr_settings.psr_allow_active_valid = false;
+}
+
 static int dm_dmub_hw_init(struct amdgpu_device *adev)
 {
 	const struct dmcub_firmware_header_v1_0 *hdr;
@@ -1354,6 +1367,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	status = dmub_srv_hw_reset(dmub_srv);
 	if (status != DMUB_STATUS_OK)
 		drm_warn(adev_to_drm(adev), "Error resetting DMUB HW: %d\n", status);
+	dm_invalidate_psr_request_caches(adev);
 
 	hdr = (const struct dmcub_firmware_header_v1_0 *)dmub_fw->data;
 
@@ -1505,6 +1519,8 @@ static void dm_dmub_hw_resume(struct amdgpu_device *adev)
 		return;
 	}
 
+	dm_invalidate_psr_request_caches(adev);
+
 	status = dmub_srv_is_hw_init(dmub_srv, &init);
 	if (status != DMUB_STATUS_OK)
 		drm_warn(adev_to_drm(adev), "DMUB hardware init check failed: %d\n", status);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 2a1353cb7e7d..2c587cb0f5e1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -114,6 +114,8 @@ void clk_mgr_exit_optimized_pwr_state(const struct dc *dc, struct clk_mgr *clk_m
 			if (!edp_link->psr_settings.psr_feature_enabled)
 				continue;
 			clk_mgr->psr_allow_active_cache = edp_link->psr_settings.psr_allow_active;
+			clk_mgr->psr_allow_active_cache_valid =
+				edp_link->psr_settings.psr_allow_active_valid;
 			dc->link_srv->edp_set_psr_allow_active(edp_link, &allow_active, false, false, NULL);
 			dc->link_srv->edp_set_replay_allow_active(edp_link, &allow_active, false, false, NULL);
 		}
@@ -134,8 +136,11 @@ void clk_mgr_optimize_pwr_state(const struct dc *dc, struct clk_mgr *clk_mgr)
 			edp_link = edp_links[panel_inst];
 			if (!edp_link->psr_settings.psr_feature_enabled)
 				continue;
-			dc->link_srv->edp_set_psr_allow_active(edp_link,
-					&clk_mgr->psr_allow_active_cache, false, false, NULL);
+			if (clk_mgr->psr_allow_active_cache_valid)
+				dc->link_srv->edp_set_psr_allow_active(edp_link,
+						&clk_mgr->psr_allow_active_cache,
+						false, false, NULL);
+			/* PSR cache validity does not describe Replay state. */
 			dc->link_srv->edp_set_replay_allow_active(edp_link,
 					&clk_mgr->psr_allow_active_cache, false, false, NULL);
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e25b94b65dac..8d76101a17a3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6308,11 +6308,13 @@ bool dc_set_psr_allow_active(struct dc *dc, bool enable)
 			continue;
 
 		if (link->psr_settings.psr_feature_enabled) {
-			if (enable && !link->psr_settings.psr_allow_active) {
+			if (enable && (!link->psr_settings.psr_allow_active_valid ||
+				       !link->psr_settings.psr_allow_active)) {
 				allow_active = true;
 				if (!dc_link_set_psr_allow_active(link, &allow_active, false, false, NULL))
 					return false;
-			} else if (!enable && link->psr_settings.psr_allow_active) {
+			} else if (!enable && (!link->psr_settings.psr_allow_active_valid ||
+					      link->psr_settings.psr_allow_active)) {
 				allow_active = false;
 				if (!dc_link_set_psr_allow_active(link, &allow_active, true, false, NULL))
 					return false;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index f829ce3f70e5..e351f3dee8ff 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -412,6 +412,7 @@ struct clk_mgr {
 	struct clk_mgr_funcs *funcs;
 	struct dc_clocks clks;
 	bool psr_allow_active_cache;
+	bool psr_allow_active_cache_valid;
 	bool force_smu_not_present;
 	bool dc_mode_softmax_enabled;
 	int dprefclk_khz; // Used by program pixel clock in clock source funcs, need to figureout where this goes
-- 
2.54.0

