Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C4BCAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 14:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76A9B10E88C;
	Wed, 17 Sep 2025 14:55:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="a50b0VMS";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E88A410E0CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 14:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+4ETFjTL9PKLqKj02D0iUeA8D1QsiQgceA/J/aVfiCs=; b=a50b0VMSII3Kh1ehZsleZ1Q2Db
 cztui111Y8K6oS1YNuwQ2NKPZ3UoM5HyCIMYZrAEKRHLVHmVZRn6BDf4ErhA/NEgpi6APi654BeZh
 5ef4+7Wwmvrx8O6YeQBbvl4xsPRwLCuMHxMXjWbkLsB7FbQSvgIjY75KZyGw9FHC6Fd+YOVaXFfrF
 Xpmzr/thAxtj5lxuZLm58hCwqx5SxKuRzz1IZIfPacflkeklot7t58pMZ1L8Pc5Z97Ai4ScLFlSy4
 MxZreKJszj8wNn4IGr9Gwc63u2vgv6l0o9CdoyQ80vMDhTAb+Z0q+we6nFu2cOQOq/GHTST6/sY0j
 spFi3TWA==;
Received: from [84.66.36.92] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uytYh-00Ckf5-7u; Wed, 17 Sep 2025 16:54:59 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 4/6] drm/amd/display: Simplify debugfs token parsing
Date: Wed, 17 Sep 2025 15:54:47 +0100
Message-ID: <20250917145450.3000-5-tvrtko.ursulin@igalia.com>
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

Simplify debugfs token parsing by noticing there is no need to pre-
validate the string. We can let the main strsep driven loop skip
delimiters and check for the maximum supported number of arguments as it
goes through the string.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 87 +++++--------------
 1 file changed, 24 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index a2d6e298489f..c18c4df6126f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -73,68 +73,29 @@ static const char *const mst_progress_status[] = {
  * parameters that could be parsed.
  *
  */
-static int parse_write_buffer_into_params(char *wr_buf,
-					  unsigned int wr_buf_size,
+static int parse_write_buffer_into_params(char *buf,
 					  long *param,
 					  unsigned int max_param_num,
 					  unsigned int *param_nums)
 {
-	const char delimiter[3] = {' ', '\n', '\0'};
-	unsigned int wr_buf_count = 0;
-	unsigned int param_index = 0;
-	char *wr_buf_ptr = NULL;
-	char *sub_str = NULL;
-	int r;
+	char *token, *tmp = buf;
+	unsigned int i = 0;
 
-	*param_nums = 0;
+	while ((token = strsep(&tmp, " \n")) != NULL) {
+		int ret;
 
-	wr_buf_ptr = wr_buf;
+		if (!strlen(token))
+			continue;
 
-	/* check number of parameters. isspace could not differ space and \n */
-	while ((*wr_buf_ptr != 0xa) && (wr_buf_count < wr_buf_size)) {
-		/* skip space*/
-		while (isspace(*wr_buf_ptr) && (wr_buf_count < wr_buf_size)) {
-			wr_buf_ptr++;
-			wr_buf_count++;
-			}
-
-		if (wr_buf_count == wr_buf_size)
-			break;
-
-		/* skip non-space*/
-		while ((!isspace(*wr_buf_ptr)) && (wr_buf_count < wr_buf_size)) {
-			wr_buf_ptr++;
-			wr_buf_count++;
-		}
-
-		(*param_nums)++;
-
-		if (wr_buf_count == wr_buf_size)
+		if (i == max_param_num)
 			break;
-	}
 
-	if (*param_nums > max_param_num)
-		*param_nums = max_param_num;
-
-	wr_buf_ptr = wr_buf; /* reset buf pointer */
-	wr_buf_count = 0; /* number of char already checked */
-
-	while (isspace(*wr_buf_ptr) && (wr_buf_count < wr_buf_size)) {
-		wr_buf_ptr++;
-		wr_buf_count++;
+		ret = kstrtol(token, 16, &param[i++]);
+		if (ret)
+			return ret;
 	}
 
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
+	*param_nums = i;
 
 	return 0;
 }
@@ -271,7 +232,7 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 	if (IS_ERR(wr_buf))
 		return PTR_ERR(wr_buf);
 
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
+	if (parse_write_buffer_into_params(wr_buf,
 					   param, max_param_num, &param_nums)) {
 		kfree(wr_buf);
 		return -EINVAL;
@@ -403,7 +364,7 @@ static ssize_t dp_mst_link_setting(struct file *f, const char __user *buf,
 	if (IS_ERR(wr_buf))
 		return PTR_ERR(wr_buf);
 
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
+	if (parse_write_buffer_into_params(wr_buf,
 					   param, max_param_num, &param_nums)) {
 		kfree(wr_buf);
 		return -EINVAL;
@@ -619,7 +580,7 @@ static ssize_t dp_phy_settings_write(struct file *f, const char __user *buf,
 	if (IS_ERR(wr_buf))
 		return PTR_ERR(wr_buf);
 
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
+	if (parse_write_buffer_into_params(wr_buf,
 					   param, max_param_num, &param_nums)) {
 		kfree(wr_buf);
 		return -EINVAL;
@@ -767,7 +728,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 	if (IS_ERR(wr_buf))
 		return PTR_ERR(wr_buf);
 
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
+	if (parse_write_buffer_into_params(wr_buf,
 					   param, max_param_num, &param_nums)) {
 		kfree(wr_buf);
 		return -EINVAL;
@@ -1196,7 +1157,7 @@ static ssize_t dp_dsc_passthrough_set(struct file *f, const char __user *buf,
 	if (IS_ERR(wr_buf))
 		return PTR_ERR(wr_buf);
 
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
+	if (parse_write_buffer_into_params(wr_buf,
 					   &param, max_param_num,
 					   &param_nums)) {
 		kfree(wr_buf);
@@ -1435,7 +1396,7 @@ static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
 	if (IS_ERR(wr_buf))
 		return PTR_ERR(wr_buf);
 
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
+	if (parse_write_buffer_into_params(wr_buf,
 					   param, max_param_num, &param_nums)) {
 		kfree(wr_buf);
 		return -EINVAL;
@@ -1628,7 +1589,7 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
 	if (IS_ERR(wr_buf))
 		return PTR_ERR(wr_buf);
 
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
+	if (parse_write_buffer_into_params(wr_buf,
 					   param, max_param_num, &param_nums)) {
 		kfree(wr_buf);
 		return -EINVAL;
@@ -1807,7 +1768,7 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
 	if (IS_ERR(wr_buf))
 		return PTR_ERR(wr_buf);
 
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
+	if (parse_write_buffer_into_params(wr_buf,
 					   param, max_param_num, &param_nums)) {
 		kfree(wr_buf);
 		return -EINVAL;
@@ -1986,7 +1947,7 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
 	if (IS_ERR(wr_buf))
 		return PTR_ERR(wr_buf);
 
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
+	if (parse_write_buffer_into_params(wr_buf,
 					   param, max_param_num, &param_nums)) {
 		kfree(wr_buf);
 		return -EINVAL;
@@ -2158,7 +2119,7 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
 	if (IS_ERR(wr_buf))
 		return PTR_ERR(wr_buf);
 
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
+	if (parse_write_buffer_into_params(wr_buf,
 					   param, max_param_num, &param_nums)) {
 		kfree(wr_buf);
 		return -EINVAL;
@@ -2581,7 +2542,7 @@ static ssize_t dp_max_bpc_write(struct file *f, const char __user *buf,
 	if (IS_ERR(wr_buf))
 		return PTR_ERR(wr_buf);
 
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
+	if (parse_write_buffer_into_params(wr_buf,
 					   param, max_param_num, &param_nums)) {
 		kfree(wr_buf);
 		return -EINVAL;
@@ -3399,7 +3360,7 @@ static ssize_t edp_ilr_write(struct file *f, const char __user *buf,
 	if (IS_ERR(wr_buf))
 		return PTR_ERR(wr_buf);
 
-	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
+	if (parse_write_buffer_into_params(wr_buf,
 					   param, max_param_num, &param_nums)) {
 		kfree(wr_buf);
 		return -EINVAL;
-- 
2.48.0

