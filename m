Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C672ACAC599
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 14:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A2A410E889;
	Wed, 17 Sep 2025 14:55:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="jvDcQcbm";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23CD410E0CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 14:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0JGE+1RFK/V/H6Fj/i5CuxxrVEymgTH7aBWZ7jhmzu0=; b=jvDcQcbmDL31rpnNtdtP5gqhBN
 q1CSfC8b4JYb6Y7uOZAxg0ntWbspiOc1rJJtTRVoOHFqk6Ki6xY8ect8aGXxl1HjPWI2iNWO5+fcd
 P73wKo0cQNbvCTyrxUqT3kiga2qf4iU5Rwk6lUioe9+AZ6CkAolnHzb5S+3n8ncoHEpU1aXgUSuu5
 e+oXV6c0kXCrg/UKVnczPYHI0lrxWDhZR2weHnWkvWgIt3Zp8TnJaTw5oYlUCMbs2mDmid8l6fS+/
 omSNdld9BjlyRikAmaEC61LZ6kn/6CVnE+erdceJFvoUDYjXJof8re/MiWvxMlk+0b+wmP2X0jRMX
 5+KBVyWg==;
Received: from [84.66.36.92] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uytYg-00Ckep-F0; Wed, 17 Sep 2025 16:54:58 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 3/6] drm/amd/display: Align data types in debugfs code
Date: Wed, 17 Sep 2025 15:54:46 +0100
Message-ID: <20250917145450.3000-4-tvrtko.ursulin@igalia.com>
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

Align data type usage from a mix of explicit widths and native types, and
a mix of signed and unsigned, to always using native int.

Sort declaration blocks by width while at it and drop a few unnecessary
initializations.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 178 +++++++++---------
 1 file changed, 89 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 3a348e868f5d..a2d6e298489f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -73,16 +73,18 @@ static const char *const mst_progress_status[] = {
  * parameters that could be parsed.
  *
  */
-static int parse_write_buffer_into_params(char *wr_buf, uint32_t wr_buf_size,
-					  long *param, int max_param_num,
-					  uint8_t *param_nums)
+static int parse_write_buffer_into_params(char *wr_buf,
+					  unsigned int wr_buf_size,
+					  long *param,
+					  unsigned int max_param_num,
+					  unsigned int *param_nums)
 {
+	const char delimiter[3] = {' ', '\n', '\0'};
+	unsigned int wr_buf_count = 0;
+	unsigned int param_index = 0;
 	char *wr_buf_ptr = NULL;
-	uint32_t wr_buf_count = 0;
-	int r;
 	char *sub_str = NULL;
-	const char delimiter[3] = {' ', '\n', '\0'};
-	uint8_t param_index = 0;
+	int r;
 
 	*param_nums = 0;
 
@@ -250,17 +252,17 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 				 size_t size, loff_t *pos)
 {
 	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
-	struct dc_link *link = connector->dc_link;
 	struct amdgpu_device *adev = drm_to_adev(connector->base.dev);
-	struct dc *dc = (struct dc *)link->dc;
 	struct dc_link_settings prefer_link_settings = {0};
-	const uint32_t wr_buf_size = 40;
+	struct dc_link *link = connector->dc_link;
+	struct dc *dc = (struct dc *)link->dc;
+	const unsigned int max_param_num = 2;
+	const unsigned int wr_buf_size = 40;
+	unsigned int param_nums = 0;
+	bool valid_input = true;
 	/* 0: lane_count; 1: link_rate */
-	int max_param_num = 2;
-	uint8_t param_nums = 0;
 	long param[2];
 	char *wr_buf;
-	bool valid_input = true;
 
 	if (size == 0)
 		return -EINVAL;
@@ -379,17 +381,17 @@ static ssize_t dp_mst_link_setting(struct file *f, const char __user *buf,
 				 size_t size, loff_t *pos)
 {
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
-	struct dc_link *link = aconnector->dc_link;
 	struct amdgpu_device *adev = drm_to_adev(aconnector->base.dev);
-	struct dc *dc = (struct dc *)link->dc;
 	struct dc_link_settings prefer_link_settings = {0};
-	const uint32_t wr_buf_size = 40;
+	struct dc_link *link = aconnector->dc_link;
+	struct dc *dc = (struct dc *)link->dc;
+	const unsigned int max_param_num = 2;
+	const unsigned int wr_buf_size = 40;
 	/* 0: lane_count; 1: link_rate */
-	int max_param_num = 2;
-	uint8_t param_nums = 0;
+	unsigned int param_nums = 0;
+	bool valid_input = true;
 	long param[2];
 	char *wr_buf;
-	bool valid_input = true;
 
 	if (!dp_mst_is_end_device(aconnector))
 		return -EINVAL;
@@ -598,16 +600,16 @@ static ssize_t dp_phy_settings_write(struct file *f, const char __user *buf,
 				 size_t size, loff_t *pos)
 {
 	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
-	struct dc_link *link = connector->dc_link;
-	struct dc *dc = (struct dc *)link->dc;
-	uint32_t wr_buf_size = 40;
-	long param[3];
-	bool use_prefer_link_setting;
 	struct link_training_settings link_lane_settings = {0};
-	int max_param_num = 3;
-	uint8_t param_nums = 0;
+	struct dc_link *link = connector->dc_link;
+	struct dc *dc = (struct dc *)link->dc;
+	const unsigned int max_param_num = 3;
+	const unsigned int wr_buf_size = 40;
+	unsigned int param_nums = 0;
+	bool use_prefer_link_setting;
+	long param[3];
 	char *wr_buf;
-	int r = 0;
+	int r;
 
 
 	if (size == 0)
@@ -739,24 +741,22 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 				 size_t size, loff_t *pos)
 {
 	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
-	struct dc_link *link = connector->dc_link;
-	uint32_t wr_buf_size = 100;
-	long param[11] = {0x0};
-	int max_param_num = 11;
+	struct dc_link_settings prefer_link_settings =
+		{LANE_COUNT_UNKNOWN, LINK_RATE_UNKNOWN, LINK_SPREAD_DISABLED};
+	struct dc_link_settings cur_link_settings =
+		{LANE_COUNT_UNKNOWN, LINK_RATE_UNKNOWN, LINK_SPREAD_DISABLED};
 	enum dp_test_pattern test_pattern = DP_TEST_PATTERN_UNSUPPORTED;
-	bool disable_hpd = false;
-	bool valid_test_pattern = false;
-	uint8_t param_nums = 0;
 	/* init with default 80bit custom pattern */
-	uint8_t custom_pattern[10] = {
-			0x1f, 0x7c, 0xf0, 0xc1, 0x07,
-			0x1f, 0x7c, 0xf0, 0xc1, 0x07
-			};
-	struct dc_link_settings prefer_link_settings = {LANE_COUNT_UNKNOWN,
-			LINK_RATE_UNKNOWN, LINK_SPREAD_DISABLED};
-	struct dc_link_settings cur_link_settings = {LANE_COUNT_UNKNOWN,
-			LINK_RATE_UNKNOWN, LINK_SPREAD_DISABLED};
+	uint8_t custom_pattern[10] = { 0x1f, 0x7c, 0xf0, 0xc1, 0x07,
+				       0x1f, 0x7c, 0xf0, 0xc1, 0x07 };
 	struct link_training_settings link_training_settings = {0};
+	struct dc_link *link = connector->dc_link;
+	const unsigned int max_param_num = 11;
+	const unsigned int wr_buf_size = 100;
+	bool valid_test_pattern = false;
+	unsigned int param_nums = 0;
+	bool disable_hpd = false;
+	long param[11] = {0x0};
 	char *wr_buf;
 	int i;
 
@@ -1183,11 +1183,11 @@ static ssize_t dp_dsc_passthrough_set(struct file *f, const char __user *buf,
 				 size_t size, loff_t *pos)
 {
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
-	uint32_t wr_buf_size = 42;
-	int max_param_num = 1;
+	const unsigned int max_param_num = 1;
+	const unsigned int wr_buf_size = 42;
+	unsigned int param_nums = 0;
+	char *wr_buf;
 	long param;
-	uint8_t param_nums = 0;
-	char *wr_buf;
 
 	if (size == 0)
 		return -EINVAL;
@@ -1414,16 +1414,15 @@ static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
 							size_t size, loff_t *pos)
 {
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
-	struct drm_connector *connector = &aconnector->base;
-	struct dc_link *link = NULL;
-	struct drm_device *dev = connector->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
 	enum dc_connection_type new_connection_type = dc_connection_none;
-	uint32_t wr_buf_size = 42;
-	int max_param_num = 1;
+	struct drm_connector *connector = &aconnector->base;
+	struct drm_device *dev = connector->dev;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	const unsigned int max_param_num = 1;
+	const unsigned int wr_buf_size = 42;
+	struct dc_link *link = NULL;
+	unsigned int param_nums = 0;
 	long param[1] = {0};
-	uint8_t param_nums = 0;
-	bool ret = false;
 	char *wr_buf;
 
 	if (!aconnector->dc_link)
@@ -1458,6 +1457,7 @@ static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
 	}
 
 	if (param[0] == 1) {
+		bool ret;
 
 		if (!dc_link_detect_connection_type(aconnector->dc_link, &new_connection_type) &&
 			new_connection_type != dc_connection_none)
@@ -1611,15 +1611,15 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
 	struct drm_connector *connector = &aconnector->base;
 	struct drm_device *dev = connector->dev;
-	struct drm_crtc *crtc = NULL;
-	struct dm_crtc_state *dm_crtc_state = NULL;
+	const unsigned int max_param_num = 1;
+	const unsigned int wr_buf_size = 42;
+	struct dm_crtc_state *dm_crtc_state;
+	unsigned int param_nums = 0;
 	struct pipe_ctx *pipe_ctx;
-	int i;
-	uint32_t wr_buf_size = 42;
-	int max_param_num = 1;
+	struct drm_crtc *crtc;
 	long param[1] = {0};
-	uint8_t param_nums = 0;
 	char *wr_buf;
+	int i;
 
 	if (size == 0)
 		return -EINVAL;
@@ -1788,17 +1788,17 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
 				     size_t size, loff_t *pos)
 {
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
-	struct pipe_ctx *pipe_ctx;
 	struct drm_connector *connector = &aconnector->base;
 	struct drm_device *dev = connector->dev;
-	struct drm_crtc *crtc = NULL;
-	struct dm_crtc_state *dm_crtc_state = NULL;
-	int i;
-	uint32_t wr_buf_size = 42;
-	int max_param_num = 1;
+	const unsigned int max_param_num = 1;
+	const unsigned int wr_buf_size = 42;
+	struct dm_crtc_state *dm_crtc_state;
+	unsigned int param_nums = 0;
+	struct pipe_ctx *pipe_ctx;
+	struct drm_crtc *crtc;
 	long param[1] = {0};
-	uint8_t param_nums = 0;
 	char *wr_buf;
+	int i;
 
 	if (size == 0)
 		return -EINVAL;
@@ -1969,15 +1969,15 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
 	struct drm_connector *connector = &aconnector->base;
 	struct drm_device *dev = connector->dev;
-	struct drm_crtc *crtc = NULL;
-	struct dm_crtc_state *dm_crtc_state = NULL;
+	const unsigned int max_param_num = 1;
+	const unsigned int wr_buf_size = 42;
+	struct dm_crtc_state *dm_crtc_state;
+	unsigned int param_nums = 0;
 	struct pipe_ctx *pipe_ctx;
-	int i;
-	uint32_t wr_buf_size = 42;
-	int max_param_num = 1;
-	uint8_t param_nums = 0;
+	struct drm_crtc *crtc;
 	long param[1] = {0};
 	char *wr_buf;
+	int i;
 
 	if (size == 0)
 		return -EINVAL;
@@ -2141,15 +2141,15 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
 	struct drm_connector *connector = &aconnector->base;
 	struct drm_device *dev = connector->dev;
-	struct drm_crtc *crtc = NULL;
-	struct dm_crtc_state *dm_crtc_state = NULL;
+	const unsigned int max_param_num = 1;
+	const unsigned int wr_buf_size = 42;
+	struct dm_crtc_state *dm_crtc_state;
 	struct pipe_ctx *pipe_ctx;
-	int i;
-	uint32_t wr_buf_size = 42;
-	int max_param_num = 1;
-	uint8_t param_nums = 0;
+	struct drm_crtc *crtc;
+	unsigned int param_nums = 0;
 	long param[1] = {0};
 	char *wr_buf;
+	int i;
 
 	if (size == 0)
 		return -EINVAL;
@@ -2566,12 +2566,12 @@ static ssize_t dp_max_bpc_write(struct file *f, const char __user *buf,
 {
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
 	struct drm_connector *connector = &aconnector->base;
-	struct dm_connector_state *state;
 	struct drm_device *dev = connector->dev;
-	uint32_t wr_buf_size = 42;
-	int max_param_num = 1;
+	const unsigned int max_param_num = 1;
+	const unsigned int wr_buf_size = 42;
+	struct dm_connector_state *state;
+	unsigned int param_nums = 0;
 	long param[1] = {0};
-	uint8_t param_nums = 0;
 	char *wr_buf;
 
 	if (size == 0)
@@ -3380,16 +3380,16 @@ static ssize_t edp_ilr_write(struct file *f, const char __user *buf,
 				 size_t size, loff_t *pos)
 {
 	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
-	struct dc_link *link = connector->dc_link;
 	struct amdgpu_device *adev = drm_to_adev(connector->base.dev);
-	struct dc *dc = (struct dc *)link->dc;
 	struct dc_link_settings prefer_link_settings;
-	const uint32_t wr_buf_size = 40;
+	struct dc_link *link = connector->dc_link;
+	struct dc *dc = (struct dc *)link->dc;
+	const unsigned int max_param_num = 2;
+	const unsigned int wr_buf_size = 40;
 	/* 0: lane_count; 1: link_rate */
-	int max_param_num = 2;
-	uint8_t param_nums = 0;
-	long param[2];
+	unsigned int param_nums = 0;
 	bool valid_input = true;
+	long param[2];
 	char *wr_buf;
 
 	if (size == 0)
-- 
2.48.0

