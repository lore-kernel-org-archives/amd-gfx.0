Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F40CAC5A0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 14:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65C2610E0CB;
	Wed, 17 Sep 2025 14:55:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="S5WZybJR";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7953710E0CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 14:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RL+o2YNimgEie1faXHp8zVQGHn9HLqO3+KehCEIgjbQ=; b=S5WZybJRJ+Ya05M54pAZiQatzT
 VbHZVk+VtdL5VsIh/Ju7mjTw+Eb63/ndmd8iGg/oCdLFxEZwjnYn/oywPYvj1hALNwmoD1WPARvj3
 kif9p/ein6i7i+6+RCUVC7rk4Nb/T0h2LhQJk1A5vwBy3BE0PjJ1TKB0Wdumre9r7o5nIXyqs6Z02
 +Y74xCGCAI1uauRsk8TbT2YcrPes4aCs6c5R1WINI1I2o/KjBq2E/1JYY+Tj4J44TI0M817fmL/4s
 VSxTWc3t8MJI5JgYtAGIza+sdCxMCHkb6C546Q8Lvncq4V8Z23KB8YZv8C0FyCRDhg4Cqo2TD2BMU
 T5VleXcg==;
Received: from [84.66.36.92] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uytYf-00CkeV-Oq; Wed, 17 Sep 2025 16:54:57 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 2/6] drm/amd/display: Use memdup_user
Date: Wed, 17 Sep 2025 15:54:45 +0100
Message-ID: <20250917145450.3000-3-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250917145450.3000-1-tvrtko.ursulin@igalia.com>
References: <20250917145450.3000-1-tvrtko.ursulin@igalia.com>
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

Replace kcalloc + copy_from_user with memdup_user.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 173 ++++++------------
 1 file changed, 61 insertions(+), 112 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index f263e1a4537e..3a348e868f5d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -74,8 +74,7 @@ static const char *const mst_progress_status[] = {
  *
  */
 static int parse_write_buffer_into_params(char *wr_buf, uint32_t wr_buf_size,
-					  long *param, const char __user *buf,
-					  int max_param_num,
+					  long *param, int max_param_num,
 					  uint8_t *param_nums)
 {
 	char *wr_buf_ptr = NULL;
@@ -89,12 +88,6 @@ static int parse_write_buffer_into_params(char *wr_buf, uint32_t wr_buf_size,
 
 	wr_buf_ptr = wr_buf;
 
-	/* r is bytes not be copied */
-	if (copy_from_user(wr_buf_ptr, buf, wr_buf_size)) {
-		DRM_DEBUG_DRIVER("user data could not be read successfully\n");
-		return -EFAULT;
-	}
-
 	/* check number of parameters. isspace could not differ space and \n */
 	while ((*wr_buf_ptr != 0xa) && (wr_buf_count < wr_buf_size)) {
 		/* skip space*/
@@ -261,25 +254,23 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 	struct amdgpu_device *adev = drm_to_adev(connector->base.dev);
 	struct dc *dc = (struct dc *)link->dc;
 	struct dc_link_settings prefer_link_settings = {0};
-	char *wr_buf = NULL;
 	const uint32_t wr_buf_size = 40;
 	/* 0: lane_count; 1: link_rate */
 	int max_param_num = 2;
 	uint8_t param_nums = 0;
 	long param[2];
+	char *wr_buf;
 	bool valid_input = true;
 
 	if (size == 0)
 		return -EINVAL;
 
-	wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
-	if (!wr_buf)
-		return -ENOSPC;
+	wr_buf = memdup_user(buf, wr_buf_size);
+	if (IS_ERR(wr_buf))
+		return PTR_ERR(wr_buf);
 
 	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
-					   (long *)param, buf,
-					   max_param_num,
-					   &param_nums)) {
+					   param, max_param_num, &param_nums)) {
 		kfree(wr_buf);
 		return -EINVAL;
 	}
@@ -392,12 +383,12 @@ static ssize_t dp_mst_link_setting(struct file *f, const char __user *buf,
 	struct amdgpu_device *adev = drm_to_adev(aconnector->base.dev);
 	struct dc *dc = (struct dc *)link->dc;
 	struct dc_link_settings prefer_link_settings = {0};
-	char *wr_buf = NULL;
 	const uint32_t wr_buf_size = 40;
 	/* 0: lane_count; 1: link_rate */
 	int max_param_num = 2;
 	uint8_t param_nums = 0;
 	long param[2];
+	char *wr_buf;
 	bool valid_input = true;
 
 	if (!dp_mst_is_end_device(aconnector))
@@ -406,14 +397,12 @@ static ssize_t dp_mst_link_setting(struct file *f, const char __user *buf,
 	if (size == 0)
 		return -EINVAL;
 
-	wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
-	if (!wr_buf)
-		return -ENOSPC;
+	wr_buf = memdup_user(buf, wr_buf_size);
+	if (IS_ERR(wr_buf))
+		return PTR_ERR(wr_buf);
 
 	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
-					   (long *)param, buf,
-					   max_param_num,
-					   &param_nums)) {
+					   param, max_param_num, &param_nums)) {
 		kfree(wr_buf);
 		return -EINVAL;
 	}
@@ -611,27 +600,25 @@ static ssize_t dp_phy_settings_write(struct file *f, const char __user *buf,
 	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
 	struct dc_link *link = connector->dc_link;
 	struct dc *dc = (struct dc *)link->dc;
-	char *wr_buf = NULL;
 	uint32_t wr_buf_size = 40;
 	long param[3];
 	bool use_prefer_link_setting;
 	struct link_training_settings link_lane_settings = {0};
 	int max_param_num = 3;
 	uint8_t param_nums = 0;
+	char *wr_buf;
 	int r = 0;
 
 
 	if (size == 0)
 		return -EINVAL;
 
-	wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
-	if (!wr_buf)
-		return -ENOSPC;
+	wr_buf = memdup_user(buf, wr_buf_size);
+	if (IS_ERR(wr_buf))
+		return PTR_ERR(wr_buf);
 
 	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
-					   (long *)param, buf,
-					   max_param_num,
-					   &param_nums)) {
+					   param, max_param_num, &param_nums)) {
 		kfree(wr_buf);
 		return -EINVAL;
 	}
@@ -753,7 +740,6 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 {
 	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
 	struct dc_link *link = connector->dc_link;
-	char *wr_buf = NULL;
 	uint32_t wr_buf_size = 100;
 	long param[11] = {0x0};
 	int max_param_num = 11;
@@ -771,19 +757,18 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 	struct dc_link_settings cur_link_settings = {LANE_COUNT_UNKNOWN,
 			LINK_RATE_UNKNOWN, LINK_SPREAD_DISABLED};
 	struct link_training_settings link_training_settings = {0};
+	char *wr_buf;
 	int i;
 
 	if (size == 0)
 		return -EINVAL;
 
-	wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
-	if (!wr_buf)
-		return -ENOSPC;
+	wr_buf = memdup_user(buf, wr_buf_size);
+	if (IS_ERR(wr_buf))
+		return PTR_ERR(wr_buf);
 
 	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
-					   (long *)param, buf,
-					   max_param_num,
-					   &param_nums)) {
+					   param, max_param_num, &param_nums)) {
 		kfree(wr_buf);
 		return -EINVAL;
 	}
@@ -1198,25 +1183,21 @@ static ssize_t dp_dsc_passthrough_set(struct file *f, const char __user *buf,
 				 size_t size, loff_t *pos)
 {
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
-	char *wr_buf = NULL;
 	uint32_t wr_buf_size = 42;
 	int max_param_num = 1;
 	long param;
 	uint8_t param_nums = 0;
+	char *wr_buf;
 
 	if (size == 0)
 		return -EINVAL;
 
-	wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
-
-	if (!wr_buf) {
-		DRM_DEBUG_DRIVER("no memory to allocate write buffer\n");
-		return -ENOSPC;
-	}
+	wr_buf = memdup_user(buf, wr_buf_size);
+	if (IS_ERR(wr_buf))
+		return PTR_ERR(wr_buf);
 
 	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
-					   &param, buf,
-					   max_param_num,
+					   &param, max_param_num,
 					   &param_nums)) {
 		kfree(wr_buf);
 		return -EINVAL;
@@ -1438,12 +1419,12 @@ static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
 	struct drm_device *dev = connector->dev;
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	enum dc_connection_type new_connection_type = dc_connection_none;
-	char *wr_buf = NULL;
 	uint32_t wr_buf_size = 42;
 	int max_param_num = 1;
 	long param[1] = {0};
 	uint8_t param_nums = 0;
 	bool ret = false;
+	char *wr_buf;
 
 	if (!aconnector->dc_link)
 		return -EINVAL;
@@ -1451,17 +1432,12 @@ static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
 	if (size == 0)
 		return -EINVAL;
 
-	wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
-
-	if (!wr_buf) {
-		DRM_DEBUG_DRIVER("no memory to allocate write buffer\n");
-		return -ENOSPC;
-	}
+	wr_buf = memdup_user(buf, wr_buf_size);
+	if (IS_ERR(wr_buf))
+		return PTR_ERR(wr_buf);
 
 	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
-						(long *)param, buf,
-						max_param_num,
-						&param_nums)) {
+					   param, max_param_num, &param_nums)) {
 		kfree(wr_buf);
 		return -EINVAL;
 	}
@@ -1639,26 +1615,21 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
 	struct dm_crtc_state *dm_crtc_state = NULL;
 	struct pipe_ctx *pipe_ctx;
 	int i;
-	char *wr_buf = NULL;
 	uint32_t wr_buf_size = 42;
 	int max_param_num = 1;
 	long param[1] = {0};
 	uint8_t param_nums = 0;
+	char *wr_buf;
 
 	if (size == 0)
 		return -EINVAL;
 
-	wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
-
-	if (!wr_buf) {
-		DRM_DEBUG_DRIVER("no memory to allocate write buffer\n");
-		return -ENOSPC;
-	}
+	wr_buf = memdup_user(buf, wr_buf_size);
+	if (IS_ERR(wr_buf))
+		return PTR_ERR(wr_buf);
 
 	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
-					    (long *)param, buf,
-					    max_param_num,
-					    &param_nums)) {
+					   param, max_param_num, &param_nums)) {
 		kfree(wr_buf);
 		return -EINVAL;
 	}
@@ -1823,26 +1794,21 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
 	struct drm_crtc *crtc = NULL;
 	struct dm_crtc_state *dm_crtc_state = NULL;
 	int i;
-	char *wr_buf = NULL;
 	uint32_t wr_buf_size = 42;
 	int max_param_num = 1;
 	long param[1] = {0};
 	uint8_t param_nums = 0;
+	char *wr_buf;
 
 	if (size == 0)
 		return -EINVAL;
 
-	wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
-
-	if (!wr_buf) {
-		DRM_DEBUG_DRIVER("no memory to allocate write buffer\n");
-		return -ENOSPC;
-	}
+	wr_buf = memdup_user(buf, wr_buf_size);
+	if (IS_ERR(wr_buf))
+		return PTR_ERR(wr_buf);
 
 	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
-					    (long *)param, buf,
-					    max_param_num,
-					    &param_nums)) {
+					   param, max_param_num, &param_nums)) {
 		kfree(wr_buf);
 		return -EINVAL;
 	}
@@ -2007,26 +1973,21 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
 	struct dm_crtc_state *dm_crtc_state = NULL;
 	struct pipe_ctx *pipe_ctx;
 	int i;
-	char *wr_buf = NULL;
 	uint32_t wr_buf_size = 42;
 	int max_param_num = 1;
 	uint8_t param_nums = 0;
 	long param[1] = {0};
+	char *wr_buf;
 
 	if (size == 0)
 		return -EINVAL;
 
-	wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
-
-	if (!wr_buf) {
-		DRM_DEBUG_DRIVER("no memory to allocate write buffer\n");
-		return -ENOSPC;
-	}
+	wr_buf = memdup_user(buf, wr_buf_size);
+	if (IS_ERR(wr_buf))
+		return PTR_ERR(wr_buf);
 
 	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
-					    (long *)param, buf,
-					    max_param_num,
-					    &param_nums)) {
+					   param, max_param_num, &param_nums)) {
 		kfree(wr_buf);
 		return -EINVAL;
 	}
@@ -2184,26 +2145,21 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
 	struct dm_crtc_state *dm_crtc_state = NULL;
 	struct pipe_ctx *pipe_ctx;
 	int i;
-	char *wr_buf = NULL;
 	uint32_t wr_buf_size = 42;
 	int max_param_num = 1;
 	uint8_t param_nums = 0;
 	long param[1] = {0};
+	char *wr_buf;
 
 	if (size == 0)
 		return -EINVAL;
 
-	wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
-
-	if (!wr_buf) {
-		DRM_DEBUG_DRIVER("no memory to allocate write buffer\n");
-		return -ENOSPC;
-	}
+	wr_buf = memdup_user(buf, wr_buf_size);
+	if (IS_ERR(wr_buf))
+		return PTR_ERR(wr_buf);
 
 	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
-					    (long *)param, buf,
-					    max_param_num,
-					    &param_nums)) {
+					   param, max_param_num, &param_nums)) {
 		kfree(wr_buf);
 		return -EINVAL;
 	}
@@ -2612,26 +2568,21 @@ static ssize_t dp_max_bpc_write(struct file *f, const char __user *buf,
 	struct drm_connector *connector = &aconnector->base;
 	struct dm_connector_state *state;
 	struct drm_device *dev = connector->dev;
-	char *wr_buf = NULL;
 	uint32_t wr_buf_size = 42;
 	int max_param_num = 1;
 	long param[1] = {0};
 	uint8_t param_nums = 0;
+	char *wr_buf;
 
 	if (size == 0)
 		return -EINVAL;
 
-	wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
-
-	if (!wr_buf) {
-		DRM_DEBUG_DRIVER("no memory to allocate write buffer\n");
-		return -ENOSPC;
-	}
+	wr_buf = memdup_user(buf, wr_buf_size);
+	if (IS_ERR(wr_buf))
+		return PTR_ERR(wr_buf);
 
 	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
-					   (long *)param, buf,
-					   max_param_num,
-					   &param_nums)) {
+					   param, max_param_num, &param_nums)) {
 		kfree(wr_buf);
 		return -EINVAL;
 	}
@@ -3433,25 +3384,23 @@ static ssize_t edp_ilr_write(struct file *f, const char __user *buf,
 	struct amdgpu_device *adev = drm_to_adev(connector->base.dev);
 	struct dc *dc = (struct dc *)link->dc;
 	struct dc_link_settings prefer_link_settings;
-	char *wr_buf = NULL;
 	const uint32_t wr_buf_size = 40;
 	/* 0: lane_count; 1: link_rate */
 	int max_param_num = 2;
 	uint8_t param_nums = 0;
 	long param[2];
 	bool valid_input = true;
+	char *wr_buf;
 
 	if (size == 0)
 		return -EINVAL;
 
-	wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
-	if (!wr_buf)
-		return -ENOMEM;
+	wr_buf = memdup_user(buf, wr_buf_size);
+	if (IS_ERR(wr_buf))
+		return PTR_ERR(wr_buf);
 
 	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
-					   (long *)param, buf,
-					   max_param_num,
-					   &param_nums)) {
+					   param, max_param_num, &param_nums)) {
 		kfree(wr_buf);
 		return -EINVAL;
 	}
-- 
2.48.0

