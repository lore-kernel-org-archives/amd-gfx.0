Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B62C9830D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 08:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 232EE10EA2D;
	Fri, 25 Sep 2026 08:29:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="TTjP7yNE";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1135910EA0D
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 08:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=E8JmK+f4y8QiruYkRJj6wuXXGgcE18PEzF+QePkv+X8=; b=TTjP7yNEwMb3Pzw51p7+79+NtE
 Lpx8Tx95ufG0Df3HoN4/MIhqM1OG2LFZ6HzqshGOb6RrWL4LD1CkvlDis924CLcdKprxZ1Nz2P68W
 uDkYQLbAdONldwDC+WmZMYWeYo8h5l1ieZ8LAQgp1UxAWdJ+I6eZ55ooUZ2+CP6yasnge1O0JWQPU
 i5dw75wqSOrq+IwI5bSKzesYHUSt53Her1kMII426iISNZ0qm7etrg0NpP0aZyGAwv9Wrr9JVRWBG
 sYKBZ142Yn1udyRcparrshdZJcg/ohWFCyZISFj0eo4EJ08dyu/wglKcuQ03Fz1/FmDc0fuL3NXSP
 5uL7ipQw==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xA1JU-0073XA-KH; Fri, 25 Sep 2026 10:29:48 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH v2 2/2] drm/amd/display: Simplify debugfs token parsing
Date: Fri, 25 Sep 2026 09:29:46 +0100
Message-ID: <20260925082946.65157-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924114049.55201-3-tvrtko.ursulin@igalia.com>
References: <20260924114049.55201-3-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The current token parsing is complicated, conflicting with itself, broken,
and also results in a lot of duplicated code throughout.

Lets simplify it by replacing the two pass (count arguments + parse them)
with a single strsep driven pass. The current two passes disagree on the
set of separators and this makes it consistent.

Then we also pull all of the repeated boiler plate into the helper -
buffer allocation, copying, checking pre- and post-conditions. This
removes a lot of the error handling from all the callers.

And another bug fixed, lucikly mostly harmless, where copy_from_user was
always copying a hardcoded lenght regardless of what the userspace had
actually written. Assuming the userspace memory was backed it would copy
neighbouring garbage into the string to be passed, or -EFAULT in theory
but probably none of the exercised callers to date constructed their
buffers in a way that can hit the latter.

There are some behavioural differences though to call out:

 * Before tabs were counted as separators but never split on. Now they
   become full separators.

 * Previously argument counting stopped on a newline but parsing was
   considering them as separators. Now they are always considered
   separators.

 * kstrotol failures used to be logged but assumed zero argument. Now the
   code errors out.

 * dp_dsc_passthrough_set had no error handling and writes with no
   parameters but not otherwise invalid would silently result in a
   successful disable of dsc_force_disable_passthrough. Now the debugfs
   write would fail.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
---
v2:
 * Fixed buffer leak.
 * Improved commit text.
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 548 ++++--------------
 1 file changed, 128 insertions(+), 420 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 969e1361a5da..50526b51c40b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -67,76 +67,46 @@ static const char *const mst_progress_status[] = {
 	"clear_allocated_payload",
 };
 
-/* parse_write_buffer_into_params - Helper function to parse debugfs write buffer into an array
+/* parse_params - Helper function to parse debugfs write buffer into an array
  *
- * Function takes in attributes passed to debugfs write entry
- * and writes into param array.
- * The user passes max_param_num to identify maximum number of
- * parameters that could be parsed.
+ * Function takes in attributes passed to debugfs write entry and writes into
+ * param array.
  *
+ * The user passes max_param_num to identify maximum number of parameters that
+ * could be parsed.
+ *
+ * Returns zero on success or a negative error code.
  */
-static int parse_write_buffer_into_params(char *wr_buf, uint32_t wr_buf_size,
-					  long *param, int max_param_num,
-					  uint8_t *param_nums)
+static int parse_params(const char __user *ubuf, size_t size,
+			long *param, unsigned int max_params)
 {
-	char *wr_buf_ptr = NULL;
-	uint32_t wr_buf_count = 0;
-	int r;
-	char *sub_str = NULL;
-	const char delimiter[3] = {' ', '\n', '\0'};
-	uint8_t param_index = 0;
+	char *buf, *tmp, *token;
+	int ret = -EINVAL;
+	unsigned int i;
 
-	*param_nums = 0;
+	if (size == 0)
+		return -EINVAL;
 
-	wr_buf_ptr = wr_buf;
+	buf = memdup_user_nul(ubuf, size);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
 
-	/* check number of parameters. isspace could not differ space and \n */
-	while ((*wr_buf_ptr != 0xa) && (wr_buf_count < wr_buf_size)) {
-		/* skip space*/
-		while (isspace(*wr_buf_ptr) && (wr_buf_count < wr_buf_size)) {
-			wr_buf_ptr++;
-			wr_buf_count++;
-			}
+	i = 0;
+	tmp = buf;
+	while ((token = strsep(&tmp, " \t\r\n")) != NULL) {
+		if (!*token)
+			continue;
 
-		if (wr_buf_count == wr_buf_size)
+		if (i == max_params)
 			break;
 
-		/* skip non-space*/
-		while ((!isspace(*wr_buf_ptr)) && (wr_buf_count < wr_buf_size)) {
-			wr_buf_ptr++;
-			wr_buf_count++;
-		}
-
-		(*param_nums)++;
-
-		if (wr_buf_count == wr_buf_size)
+		ret = kstrtol(token, 16, &param[i++]);
+		if (ret)
 			break;
 	}
 
-	if (*param_nums > max_param_num)
-		*param_nums = max_param_num;
-
-	wr_buf_ptr = wr_buf; /* reset buf pointer */
-	wr_buf_count = 0; /* number of char already checked */
-
-	while (isspace(*wr_buf_ptr) && (wr_buf_count < wr_buf_size)) {
-		wr_buf_ptr++;
-		wr_buf_count++;
-	}
-
-	while (param_index < *param_nums) {
-		/* after strsep, wr_buf_ptr will be moved to after space */
-		sub_str = strsep(&wr_buf_ptr, delimiter);
-
-		r = kstrtol(sub_str, 16, &(param[param_index]));
-
-		if (r)
-			DRM_DEBUG_DRIVER("string to int convert error code: %d\n", r);
-
-		param_index++;
-	}
-
-	return 0;
+	kfree(buf);
+	return ret;
 }
 
 /* function description
@@ -248,36 +218,18 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
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
+	bool valid_input = true;
 	/* 0: lane_count; 1: link_rate */
-	int max_param_num = 2;
-	uint8_t param_nums = 0;
 	long param[2];
-	char *wr_buf;
-	bool valid_input = true;
+	int r;
 
-	if (size == 0)
-		return -EINVAL;
-
-	wr_buf = memdup_user_nul(buf, wr_buf_size);
-	if (IS_ERR(wr_buf))
-		return PTR_ERR(wr_buf);
-
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
-					   param, max_param_num, &param_nums)) {
-		kfree(wr_buf);
-		return -EINVAL;
-	}
-
-	if (param_nums <= 0) {
-		kfree(wr_buf);
-		DRM_DEBUG_DRIVER("user data not be read\n");
-		return -EINVAL;
-	}
+	r = parse_params(buf, size, param, 2);
+	if (r)
+		return r;
 
 	switch (param[0]) {
 	case LANE_COUNT_ONE:
@@ -308,7 +260,6 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 	}
 
 	if (!valid_input) {
-		kfree(wr_buf);
 		DRM_DEBUG_DRIVER("Invalid Input value No HW will be programmed\n");
 		mutex_lock(&adev->dm.dc_lock);
 		dc_link_set_preferred_training_settings(dc, NULL, NULL, link, false);
@@ -328,7 +279,6 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 	dc_link_set_preferred_training_settings(dc, &prefer_link_settings, NULL, link, false);
 	mutex_unlock(&adev->dm.dc_lock);
 
-	kfree(wr_buf);
 	return size;
 }
 
@@ -380,39 +330,21 @@ static ssize_t dp_mst_link_setting(struct file *f, const char __user *buf,
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
 	/* 0: lane_count; 1: link_rate */
-	int max_param_num = 2;
-	uint8_t param_nums = 0;
-	long param[2];
-	char *wr_buf;
 	bool valid_input = true;
+	long param[2];
+	int r;
 
 	if (!dp_mst_is_end_device(aconnector))
 		return -EINVAL;
 
-	if (size == 0)
-		return -EINVAL;
-
-	wr_buf = memdup_user_nul(buf, wr_buf_size);
-	if (IS_ERR(wr_buf))
-		return PTR_ERR(wr_buf);
-
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
-					   param, max_param_num, &param_nums)) {
-		kfree(wr_buf);
-		return -EINVAL;
-	}
-
-	if (param_nums <= 0) {
-		kfree(wr_buf);
-		DRM_DEBUG_DRIVER("user data not be read\n");
-		return -EINVAL;
-	}
+	r = parse_params(buf, size, param, 2);
+	if (r)
+		return r;
 
 	switch (param[0]) {
 	case LANE_COUNT_ONE:
@@ -440,7 +372,6 @@ static ssize_t dp_mst_link_setting(struct file *f, const char __user *buf,
 	}
 
 	if (!valid_input) {
-		kfree(wr_buf);
 		DRM_DEBUG_DRIVER("Invalid Input value No HW will be programmed\n");
 		mutex_lock(&adev->dm.dc_lock);
 		dc_link_set_preferred_training_settings(dc, NULL, NULL, link, false);
@@ -473,7 +404,6 @@ static ssize_t dp_mst_link_setting(struct file *f, const char __user *buf,
 	mutex_unlock(&aconnector->base.dev->mode_config.mutex);
 	drm_kms_helper_hotplug_event(aconnector->base.dev);
 
-	kfree(wr_buf);
 	return size;
 }
 
@@ -599,41 +529,20 @@ static ssize_t dp_phy_settings_write(struct file *f, const char __user *buf,
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
-	char *wr_buf;
-	int r = 0;
-
-
-	if (size == 0)
-		return -EINVAL;
-
-	wr_buf = memdup_user_nul(buf, wr_buf_size);
-	if (IS_ERR(wr_buf))
-		return PTR_ERR(wr_buf);
-
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
-					   param, max_param_num, &param_nums)) {
-		kfree(wr_buf);
-		return -EINVAL;
-	}
-
-	if (param_nums <= 0) {
-		kfree(wr_buf);
-		DRM_DEBUG_DRIVER("user data not be read\n");
-		return -EINVAL;
-	}
+	struct dc_link *link = connector->dc_link;
+	struct dc *dc = (struct dc *)link->dc;
+	bool use_prefer_link_setting;
+	long param[3];
+	int r;
+
+	r = parse_params(buf, size, param, 3);
+	if (r)
+		return r;
 
 	if ((param[0] > VOLTAGE_SWING_MAX_LEVEL) ||
 			(param[1] > PRE_EMPHASIS_MAX_LEVEL) ||
 			(param[2] > POST_CURSOR2_MAX_LEVEL)) {
-		kfree(wr_buf);
 		DRM_DEBUG_DRIVER("Invalid Input No HW will be programmed\n");
 		return size;
 	}
@@ -674,7 +583,6 @@ static ssize_t dp_phy_settings_write(struct file *f, const char __user *buf,
 	/* program ASIC registers and DPCD registers */
 	dc_link_set_drive_settings(dc, &link_lane_settings, link);
 
-	kfree(wr_buf);
 	return size;
 }
 
@@ -740,47 +648,25 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
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
+	struct dc_link *link = connector->dc_link;
 	bool supports_hpd = link->irq_source_hpd != DC_IRQ_SOURCE_INVALID;
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
-	char *wr_buf;
-	int i;
-
-	if (size == 0)
-		return -EINVAL;
-
-	wr_buf = memdup_user_nul(buf, wr_buf_size);
-	if (IS_ERR(wr_buf))
-		return PTR_ERR(wr_buf);
-
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
-					   param, max_param_num, &param_nums)) {
-		kfree(wr_buf);
-		return -EINVAL;
-	}
-
-	if (param_nums <= 0) {
-		kfree(wr_buf);
-		DRM_DEBUG_DRIVER("user data not be read\n");
-		return -EINVAL;
-	}
-
+	bool valid_test_pattern = false;
+	bool disable_hpd = false;
+	long param[11] = {0x0};
+	int i, r;
+
+	r = parse_params(buf, size, param, 11);
+	if (r)
+		return r;
 
 	test_pattern = param[0];
 
@@ -811,7 +697,6 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 	}
 
 	if (!valid_test_pattern) {
-		kfree(wr_buf);
 		DRM_DEBUG_DRIVER("Invalid Test Pattern Parameters\n");
 		return size;
 	}
@@ -878,8 +763,6 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 	if (valid_test_pattern && supports_hpd && disable_hpd)
 		dc_link_disable_hpd(link);
 
-	kfree(wr_buf);
-
 	return size;
 }
 
@@ -1185,29 +1068,15 @@ static ssize_t dp_dsc_passthrough_set(struct file *f, const char __user *buf,
 				 size_t size, loff_t *pos)
 {
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
-	uint32_t wr_buf_size = 42;
-	int max_param_num = 1;
 	long param;
-	uint8_t param_nums = 0;
-	char *wr_buf;
+	int r;
 
-	if (size == 0)
-		return -EINVAL;
-
-	wr_buf = memdup_user_nul(buf, wr_buf_size);
-	if (IS_ERR(wr_buf))
-		return PTR_ERR(wr_buf);
-
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
-					   &param, max_param_num,
-					   &param_nums)) {
-		kfree(wr_buf);
-		return -EINVAL;
-	}
+	r = parse_params(buf, size, &param, 1);
+	if (r)
+		return r;
 
 	aconnector->dsc_settings.dsc_force_disable_passthrough = param;
 
-	kfree(wr_buf);
 	return 0;
 }
 
@@ -1440,40 +1309,20 @@ static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
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
+	struct dc_link *link = NULL;
 	long param[1] = {0};
-	uint8_t param_nums = 0;
-	bool ret = false;
-	char *wr_buf;
+	int r;
 
 	if (!aconnector->dc_link)
 		return -EINVAL;
 
-	if (size == 0)
-		return -EINVAL;
-
-	wr_buf = memdup_user_nul(buf, wr_buf_size);
-	if (IS_ERR(wr_buf))
-		return PTR_ERR(wr_buf);
-
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
-					   param, max_param_num, &param_nums)) {
-		kfree(wr_buf);
-		return -EINVAL;
-	}
-
-	kfree(wr_buf);
-
-	if (param_nums <= 0) {
-		DRM_DEBUG_DRIVER("user data not be read\n");
-		return -EINVAL;
-	}
+	r = parse_params(buf, size, param, 1);
+	if (r)
+		return r;
 
 	mutex_lock(&aconnector->hpd_lock);
 
@@ -1484,6 +1333,7 @@ static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
 	}
 
 	if (param[0] == 1) {
+		bool ret;
 
 		if (!dc_link_detect_connection_type(aconnector->dc_link, &new_connection_type) &&
 			new_connection_type != dc_connection_none)
@@ -1637,34 +1487,15 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
 	struct drm_connector *connector = &aconnector->base;
 	struct drm_device *dev = connector->dev;
-	struct drm_crtc *crtc = NULL;
-	struct dm_crtc_state *dm_crtc_state = NULL;
+	struct dm_crtc_state *dm_crtc_state;
 	struct pipe_ctx *pipe_ctx;
-	int i;
-	uint32_t wr_buf_size = 42;
-	int max_param_num = 1;
+	struct drm_crtc *crtc;
 	long param[1] = {0};
-	uint8_t param_nums = 0;
-	char *wr_buf;
+	int i, r;
 
-	if (size == 0)
-		return -EINVAL;
-
-	wr_buf = memdup_user_nul(buf, wr_buf_size);
-	if (IS_ERR(wr_buf))
-		return PTR_ERR(wr_buf);
-
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
-					   param, max_param_num, &param_nums)) {
-		kfree(wr_buf);
-		return -EINVAL;
-	}
-
-	if (param_nums <= 0) {
-		DRM_DEBUG_DRIVER("user data not be read\n");
-		kfree(wr_buf);
-		return -EINVAL;
-	}
+	r = parse_params(buf, size, param, 1);
+	if (r)
+		return r;
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
@@ -1676,7 +1507,7 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
 	}
 
 	if (!pipe_ctx->stream)
-		goto done;
+		return size;
 
 	// Get CRTC state
 	mutex_lock(&dev->mode_config.mutex);
@@ -1712,8 +1543,6 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
 	drm_modeset_unlock(&dev->mode_config.connection_mutex);
 	mutex_unlock(&dev->mode_config.mutex);
 
-done:
-	kfree(wr_buf);
 	return size;
 }
 
@@ -1814,36 +1643,17 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
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
+	struct dm_crtc_state *dm_crtc_state;
+	struct pipe_ctx *pipe_ctx;
+	struct drm_crtc *crtc;
 	long param[1] = {0};
-	uint8_t param_nums = 0;
-	char *wr_buf;
+	int i, r;
 
-	if (size == 0)
-		return -EINVAL;
-
-	wr_buf = memdup_user_nul(buf, wr_buf_size);
-	if (IS_ERR(wr_buf))
-		return PTR_ERR(wr_buf);
-
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
-					   param, max_param_num, &param_nums)) {
-		kfree(wr_buf);
-		return -EINVAL;
-	}
-
-	if (param_nums <= 0) {
-		DRM_DEBUG_DRIVER("user data not be read\n");
-		kfree(wr_buf);
-		return -EINVAL;
-	}
+	r = parse_params(buf, size, param, 1);
+	if (r)
+		return r;
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
@@ -1855,7 +1665,7 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
 	}
 
 	if (!pipe_ctx->stream)
-		goto done;
+		return size;
 
 	// Safely get CRTC state
 	mutex_lock(&dev->mode_config.mutex);
@@ -1891,8 +1701,6 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
 	drm_modeset_unlock(&dev->mode_config.connection_mutex);
 	mutex_unlock(&dev->mode_config.mutex);
 
-done:
-	kfree(wr_buf);
 	return size;
 }
 
@@ -1995,34 +1803,15 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
 	struct drm_connector *connector = &aconnector->base;
 	struct drm_device *dev = connector->dev;
-	struct drm_crtc *crtc = NULL;
-	struct dm_crtc_state *dm_crtc_state = NULL;
+	struct dm_crtc_state *dm_crtc_state;
 	struct pipe_ctx *pipe_ctx;
-	int i;
-	uint32_t wr_buf_size = 42;
-	int max_param_num = 1;
-	uint8_t param_nums = 0;
+	struct drm_crtc *crtc;
 	long param[1] = {0};
-	char *wr_buf;
+	int i, r;
 
-	if (size == 0)
-		return -EINVAL;
-
-	wr_buf = memdup_user_nul(buf, wr_buf_size);
-	if (IS_ERR(wr_buf))
-		return PTR_ERR(wr_buf);
-
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
-					   param, max_param_num, &param_nums)) {
-		kfree(wr_buf);
-		return -EINVAL;
-	}
-
-	if (param_nums <= 0) {
-		DRM_DEBUG_DRIVER("user data not be read\n");
-		kfree(wr_buf);
-		return -EINVAL;
-	}
+	r = parse_params(buf, size, param, 1);
+	if (r)
+		return r;
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
@@ -2034,7 +1823,7 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
 	}
 
 	if (!pipe_ctx->stream)
-		goto done;
+		return size;
 
 	// Get CRTC state
 	mutex_lock(&dev->mode_config.mutex);
@@ -2070,8 +1859,6 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
 	drm_modeset_unlock(&dev->mode_config.connection_mutex);
 	mutex_unlock(&dev->mode_config.mutex);
 
-done:
-	kfree(wr_buf);
 	return size;
 }
 
@@ -2167,34 +1954,15 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
 	struct drm_connector *connector = &aconnector->base;
 	struct drm_device *dev = connector->dev;
-	struct drm_crtc *crtc = NULL;
-	struct dm_crtc_state *dm_crtc_state = NULL;
+	struct dm_crtc_state *dm_crtc_state;
 	struct pipe_ctx *pipe_ctx;
-	int i;
-	uint32_t wr_buf_size = 42;
-	int max_param_num = 1;
-	uint8_t param_nums = 0;
+	struct drm_crtc *crtc;
 	long param[1] = {0};
-	char *wr_buf;
+	int i, r;
 
-	if (size == 0)
-		return -EINVAL;
-
-	wr_buf = memdup_user_nul(buf, wr_buf_size);
-	if (IS_ERR(wr_buf))
-		return PTR_ERR(wr_buf);
-
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
-					   param, max_param_num, &param_nums)) {
-		kfree(wr_buf);
-		return -EINVAL;
-	}
-
-	if (param_nums <= 0) {
-		DRM_DEBUG_DRIVER("user data not be read\n");
-		kfree(wr_buf);
-		return -EINVAL;
-	}
+	r = parse_params(buf, size, param, 1);
+	if (r)
+		return r;
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
@@ -2206,7 +1974,7 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
 	}
 
 	if (!pipe_ctx->stream)
-		goto done;
+		return size;
 
 	// Get CRTC state
 	mutex_lock(&dev->mode_config.mutex);
@@ -2237,8 +2005,6 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
 	drm_modeset_unlock(&dev->mode_config.connection_mutex);
 	mutex_unlock(&dev->mode_config.mutex);
 
-done:
-	kfree(wr_buf);
 	return size;
 }
 
@@ -2592,36 +2358,17 @@ static ssize_t dp_max_bpc_write(struct file *f, const char __user *buf,
 {
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
 	struct drm_connector *connector = &aconnector->base;
-	struct dm_connector_state *state;
 	struct drm_device *dev = connector->dev;
-	uint32_t wr_buf_size = 42;
-	int max_param_num = 1;
+	struct dm_connector_state *state;
 	long param[1] = {0};
-	uint8_t param_nums = 0;
-	char *wr_buf;
+	int r;
 
-	if (size == 0)
-		return -EINVAL;
-
-	wr_buf = memdup_user_nul(buf, wr_buf_size);
-	if (IS_ERR(wr_buf))
-		return PTR_ERR(wr_buf);
-
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
-					   param, max_param_num, &param_nums)) {
-		kfree(wr_buf);
-		return -EINVAL;
-	}
-
-	if (param_nums <= 0) {
-		DRM_DEBUG_DRIVER("user data not be read\n");
-		kfree(wr_buf);
-		return -EINVAL;
-	}
+	r = parse_params(buf, size, param, 1);
+	if (r)
+		return r;
 
 	if (param[0] < 6 || param[0] > 16) {
 		DRM_DEBUG_DRIVER("bad max_bpc value\n");
-		kfree(wr_buf);
 		return -EINVAL;
 	}
 
@@ -2637,7 +2384,6 @@ static ssize_t dp_max_bpc_write(struct file *f, const char __user *buf,
 	drm_modeset_unlock(&dev->mode_config.connection_mutex);
 	mutex_unlock(&dev->mode_config.mutex);
 
-	kfree(wr_buf);
 	return size;
 }
 
@@ -2959,31 +2705,13 @@ static ssize_t hdmi_automation_enable(struct file *f, const char __user *buf,
 	size_t size, loff_t *pos)
 {
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
-	const uint32_t wr_buf_size = 40;
-	int max_param_num = 1;
-	uint8_t param_nums = 0;
 	bool hdmi_comp_auto;
-	long param[2];
-	char *wr_buf;
+	long param[1] = {};
+	int r;
 
-	if (size == 0)
-		return -EINVAL;
-
-	wr_buf = memdup_user_nul(buf, wr_buf_size);
-	if (IS_ERR(wr_buf))
-		return PTR_ERR(wr_buf);
-
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
-					   param, max_param_num, &param_nums)) {
-		kfree(wr_buf);
-		return -EINVAL;
-	}
-
-	if (param_nums <= 0) {
-		kfree(wr_buf);
-		DRM_DEBUG_DRIVER("user data not be read\n");
-		return -EINVAL;
-	}
+	r = parse_params(buf, size, param, 1);
+	if (r)
+		return r;
 
 	switch (param[0]) {
 	case 0:
@@ -2998,7 +2726,6 @@ static ssize_t hdmi_automation_enable(struct file *f, const char __user *buf,
 	/* Persist setting across sink re-detection/hotplug. */
 	aconnector->hdmi_comp_auto = hdmi_comp_auto;
 
-	kfree(wr_buf);
 	return size;
 }
 
@@ -3768,39 +3495,22 @@ static ssize_t edp_ilr_write(struct file *f, const char __user *buf,
 				 size_t size, loff_t *pos)
 {
 	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
-	struct dc_link *link = connector->dc_link;
 	struct amdgpu_device *adev = drm_to_adev(connector->base.dev);
-	struct dc *dc = (struct dc *)link->dc;
 	struct dc_link_settings prefer_link_settings;
-	const uint32_t wr_buf_size = 40;
-	/* 0: lane_count; 1: link_rate */
-	int max_param_num = 2;
-	uint8_t param_nums = 0;
-	long param[2];
-	bool valid_input = true;
-	uint8_t supported_link_rates[16] = {0};
-	uint32_t entry = 0;
+	struct dc_link *link = connector->dc_link;
+	struct dc *dc = (struct dc *)link->dc;
+	uint8_t supported_link_rates[16] = {};
 	uint32_t link_rate_in_khz = 0;
+	/* 0: lane_count; 1: link_rate */
+	bool valid_input = true;
 	uint8_t dpcd_rev = 0;
-	char *wr_buf;
+	uint32_t entry = 0;
+	long param[2];
+	int r;
 
-	if (size == 0)
-		return -EINVAL;
-
-	wr_buf = memdup_user_nul(buf, wr_buf_size);
-	if (IS_ERR(wr_buf))
-		return PTR_ERR(wr_buf);
-
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
-					   param, max_param_num, &param_nums)) {
-		kfree(wr_buf);
-		return -EINVAL;
-	}
-
-	if (param_nums <= 0) {
-		kfree(wr_buf);
-		return -EINVAL;
-	}
+	r = parse_params(buf, size, param, 2);
+	if (r)
+		return r;
 
 	switch (param[0]) {
 	case LANE_COUNT_ONE:
@@ -3816,7 +3526,6 @@ static ssize_t edp_ilr_write(struct file *f, const char __user *buf,
 		valid_input = false;
 
 	if (!valid_input) {
-		kfree(wr_buf);
 		DRM_DEBUG_DRIVER("Invalid Input value. No HW will be programmed\n");
 		prefer_link_settings.use_link_rate_set = false;
 		mutex_lock(&adev->dm.dc_lock);
@@ -3853,7 +3562,6 @@ static ssize_t edp_ilr_write(struct file *f, const char __user *buf,
 						NULL, link, false);
 	mutex_unlock(&adev->dm.dc_lock);
 
-	kfree(wr_buf);
 	return size;
 }
 
-- 
2.55.0

