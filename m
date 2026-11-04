Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089A1606A31B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=GHoH0KEC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B14D10E10A;
	Wed,  4 Nov 2026 12:03:42 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 719E810E279
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 12:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=m/z1NKuHyqRt5dptug7kZpJvZ/hu7TGpdtWeJ5rtgNM=; t=1793793816; x=2109153816; 
 b=GHoH0KECwRCwWLw3JTHczG1RGQ/AaU978f33ao43BaAiTOQOxR0KfuKbN4UxuLknmGjbabe8Ew8
 QYZByOKnwMaB0N+uU4lL6B1vxMW7s3f2w+nVpDUSs1c/QnzxtFI5rGWPVq2xQXmDaID7Kk3w6RDXR
 C4UT4Llgb2VuZ1waxLefIeyi/ZuL+rZ17BysQo1Y9968WcNnQu6BqcyEH0e/gaQNB0nWeawF8bscK
 +zlZFud97reukGFPAJOtoJ5bZqxWaCaeorKVMtoGfxKSAB54WIVp6iZBVHf8F0mY8lpFmw97OlXjs
 2kH22670moifPXQFq3nyol60SFG2cHt+evzQ==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xOZiI-002EGy-J8; Wed, 04 Nov 2026 13:03:34 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH v5 1/2] drm/amd/display: Use memdup_user_nul in debugfs code
Date: Wed,  4 Nov 2026 12:03:31 +0000
Message-ID: <20261104120332.34405-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104120332.34405-1-tvrtko.ursulin@igalia.com>
References: <20261104120332.34405-1-tvrtko.ursulin@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace kcalloc + copy_from_user with memdup_user_nul for more compact and
safer code.

Otherwise, and currently, there is scope for out of bounds reads in
parse_write_buffer_into_params because it checks for newline before it
checks for end of buffer:

 while ((*wr_buf_ptr != 0xa) && (wr_buf_count < wr_buf_size)) {

With other examples lower down in the loop. Culminating in the strsep
pass which does no checking for buffer size at all.

Ensuring null termination seems like the simplest fix.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: 04111850cf56 ("drm/amd/display: Reuse parsing code of debugfs write buffer")
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
---
v2:
 *  Rebased for e3b643d7864d ("drm/amd/display: Simplify hdmi_automation debugfs with debugfs_create_bool").
---
The Fixes: target is perhaps approximate I did not extensively check if
before the consolidation it was safe. It is debugfs after all so I thought
its good enough like this.
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 175 +++++++-----------
 1 file changed, 62 insertions(+), 113 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 0cef66e20a86..fab4362c3e23 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -76,8 +76,7 @@ static const char *const mst_progress_status[] = {
  *
  */
 static int parse_write_buffer_into_params(char *wr_buf, uint32_t wr_buf_size,
-					  long *param, const char __user *buf,
-					  int max_param_num,
+					  long *param, int max_param_num,
 					  uint8_t *param_nums)
 {
 	char *wr_buf_ptr = NULL;
@@ -91,13 +90,7 @@ static int parse_write_buffer_into_params(char *wr_buf, uint32_t wr_buf_size,
 
 	wr_buf_ptr = wr_buf;
 
-	/* r is bytes not be copied */
-	if (copy_from_user(wr_buf_ptr, buf, wr_buf_size)) {
-		DRM_DEBUG_DRIVER("user data could not be read successfully\n");
-		return -EFAULT;
-	}
-
-	/* check number of parameters. isspace could not differ space and\n */
+	/* check number of parameters. isspace could not differ space and \n */
 	while ((*wr_buf_ptr != 0xa) && (wr_buf_count < wr_buf_size)) {
 		/* skip space*/
 		while (isspace(*wr_buf_ptr) && (wr_buf_count < wr_buf_size)) {
@@ -259,25 +252,23 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
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
+	wr_buf = memdup_user_nul(buf, wr_buf_size);
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
@@ -393,12 +384,12 @@ static ssize_t dp_mst_link_setting(struct file *f, const char __user *buf,
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
@@ -407,14 +398,12 @@ static ssize_t dp_mst_link_setting(struct file *f, const char __user *buf,
 	if (size == 0)
 		return -EINVAL;
 
-	wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
-	if (!wr_buf)
-		return -ENOSPC;
+	wr_buf = memdup_user_nul(buf, wr_buf_size);
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
@@ -612,27 +601,25 @@ static ssize_t dp_phy_settings_write(struct file *f, const char __user *buf,
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
+	wr_buf = memdup_user_nul(buf, wr_buf_size);
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
@@ -754,7 +741,6 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 {
 	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
 	struct dc_link *link = connector->dc_link;
-	char *wr_buf = NULL;
 	uint32_t wr_buf_size = 100;
 	long param[11] = {0x0};
 	int max_param_num = 11;
@@ -773,19 +759,18 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
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
+	wr_buf = memdup_user_nul(buf, wr_buf_size);
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
@@ -1200,25 +1185,21 @@ static ssize_t dp_dsc_passthrough_set(struct file *f, const char __user *buf,
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
+	wr_buf = memdup_user_nul(buf, wr_buf_size);
+	if (IS_ERR(wr_buf))
+		return PTR_ERR(wr_buf);
 
 	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
-					   &param, buf,
-					   max_param_num,
+					   &param, max_param_num,
 					   &param_nums)) {
 		kfree(wr_buf);
 		return -EINVAL;
@@ -1464,12 +1445,12 @@ static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
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
@@ -1477,17 +1458,12 @@ static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
 	if (size == 0)
 		return -EINVAL;
 
-	wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
-
-	if (!wr_buf) {
-		DRM_DEBUG_DRIVER("no memory to allocate write buffer\n");
-		return -ENOSPC;
-	}
+	wr_buf = memdup_user_nul(buf, wr_buf_size);
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
@@ -1665,26 +1641,21 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
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
+	wr_buf = memdup_user_nul(buf, wr_buf_size);
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
@@ -1849,26 +1820,21 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
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
+	wr_buf = memdup_user_nul(buf, wr_buf_size);
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
@@ -2033,26 +1999,21 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
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
+	wr_buf = memdup_user_nul(buf, wr_buf_size);
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
@@ -2210,26 +2171,21 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
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
+	wr_buf = memdup_user_nul(buf, wr_buf_size);
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
@@ -2638,26 +2594,21 @@ static ssize_t dp_max_bpc_write(struct file *f, const char __user *buf,
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
+	wr_buf = memdup_user_nul(buf, wr_buf_size);
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
@@ -3759,7 +3710,6 @@ static ssize_t edp_ilr_write(struct file *f, const char __user *buf,
 	struct amdgpu_device *adev = drm_to_adev(connector->base.dev);
 	struct dc *dc = (struct dc *)link->dc;
 	struct dc_link_settings prefer_link_settings;
-	char *wr_buf = NULL;
 	const uint32_t wr_buf_size = 40;
 	/* 0: lane_count; 1: link_rate */
 	int max_param_num = 2;
@@ -3770,18 +3720,17 @@ static ssize_t edp_ilr_write(struct file *f, const char __user *buf,
 	uint32_t entry = 0;
 	uint32_t link_rate_in_khz = 0;
 	uint8_t dpcd_rev = 0;
+	char *wr_buf;
 
 	if (size == 0)
 		return -EINVAL;
 
-	wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
-	if (!wr_buf)
-		return -ENOMEM;
+	wr_buf = memdup_user_nul(buf, wr_buf_size);
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
2.56.0

