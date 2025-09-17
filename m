Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F5ACAC59D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 14:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65D8910E886;
	Wed, 17 Sep 2025 14:55:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="X71LwXEi";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B88B610E858
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 14:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=F/9f8O9OjItrfflFbBEKctR81MvqtHHzY0BUxvflxfg=; b=X71LwXEi1NV9hZl8nF9aAH1OkD
 InLwDuuBxGyuJok5PdQnG00PHcx21zRQQMT9afdzf0ELdyBjSdE8nWTQ5S+ezJ1GZTvbHuZlhW6Cb
 wDRg5EEC+X4f29dhZ45/VY5lLvsGtP4p2YyVWTX2l94X2mvEO5a3QjhQ8H/OUtiQYvrbF72IBmBYs
 evdl1j9hUhXmd0lt+YwKRZtkAwDLkOjAXUzryumW5eHJAlxy+2B75tHqdqmVsGYQTARcRyDeP4xbZ
 /k43oWD4Ndit78N1y9/F40rbvv33FqZ4F6IC7fv2gIXpl4LI61lhnQa9Lx25bmrEZfcinGjHab1aG
 +F6b1i7Q==;
Received: from [84.66.36.92] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uytYf-00Cke8-2U; Wed, 17 Sep 2025 16:54:57 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 1/6] drm/amd/pm: Remove unnecessary local variable initialization
Date: Wed, 17 Sep 2025 15:54:44 +0100
Message-ID: <20250917145450.3000-2-tvrtko.ursulin@igalia.com>
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

Quite a few instances of local variables needlessly initialized -
remove it.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 62 ++++++++++++++----------------
 1 file changed, 28 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 96590c1da553..4503220c09aa 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -444,7 +444,7 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	struct pp_states_info data = {0};
 	enum amd_pm_state_type pm = 0;
-	int i = 0, ret = 0;
+	int i, ret;
 
 	ret = amdgpu_pm_get_access_if_active(adev);
 	if (ret)
@@ -490,7 +490,7 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	enum amd_pm_state_type state = 0;
+	enum amd_pm_state_type state;
 	struct pp_states_info data;
 	unsigned long idx;
 	int ret;
@@ -583,7 +583,7 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	int ret = 0;
+	int ret;
 
 	ret = amdgpu_pm_get_access(adev);
 	if (ret < 0)
@@ -992,7 +992,7 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	int size = 0;
-	int ret = 0;
+	int ret;
 
 	ret = amdgpu_pm_get_access_if_active(adev);
 	if (ret)
@@ -1229,7 +1229,7 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	uint32_t value = 0;
+	uint32_t value;
 	int ret;
 
 	ret = amdgpu_pm_get_access_if_active(adev);
@@ -1275,7 +1275,7 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	uint32_t value = 0;
+	uint32_t value;
 	int ret;
 
 	ret = amdgpu_pm_get_access_if_active(adev);
@@ -1376,7 +1376,7 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 	char *tmp_str;
 	uint32_t i = 0;
 	char tmp[2];
-	long int profile_mode = 0;
+	long int profile_mode;
 	const char delimiter[3] = {' ', '\n', '\0'};
 
 	tmp[0] = *(buf);
@@ -1609,7 +1609,7 @@ static ssize_t amdgpu_set_thermal_throttling_logging(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	long throttling_logging_interval;
-	int ret = 0;
+	int ret;
 
 	ret = kstrtol(buf, 0, &throttling_logging_interval);
 	if (ret)
@@ -1720,7 +1720,7 @@ static ssize_t amdgpu_get_pm_metrics(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	ssize_t size = 0;
+	ssize_t size;
 	int ret;
 
 	ret = amdgpu_pm_get_access_if_active(adev);
@@ -1753,7 +1753,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	void *gpu_metrics;
-	ssize_t size = 0;
+	ssize_t size;
 	int ret;
 
 	ret = amdgpu_pm_get_access_if_active(adev);
@@ -1781,7 +1781,7 @@ static int amdgpu_show_powershift_percent(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	uint32_t ss_power;
-	int r = 0, i;
+	int r, i;
 
 	r = amdgpu_hwmon_get_sensor_generic(adev, sensor, (void *)&ss_power);
 	if (r == -EOPNOTSUPP) {
@@ -1850,11 +1850,7 @@ static ssize_t amdgpu_get_smartshift_bias(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
 {
-	int r = 0;
-
-	r = sysfs_emit(buf, "%d\n", amdgpu_smartshift_bias);
-
-	return r;
+	return sysfs_emit(buf, "%d\n", amdgpu_smartshift_bias);
 }
 
 static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
@@ -1863,8 +1859,7 @@ static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	int r = 0;
-	int bias = 0;
+	int r, bias;
 
 	r = kstrtoint(buf, 10, &bias);
 	if (r)
@@ -2529,11 +2524,11 @@ static int amdgpu_device_attr_create(struct amdgpu_device *adev,
 				     struct amdgpu_device_attr *attr,
 				     uint32_t mask, struct list_head *attr_list)
 {
-	int ret = 0;
 	enum amdgpu_device_attr_states attr_states = ATTR_STATE_SUPPORTED;
 	struct amdgpu_device_attr_entry *attr_entry;
 	struct device_attribute *dev_attr;
 	const char *name;
+	int ret;
 
 	int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
 			   uint32_t mask, enum amdgpu_device_attr_states *states) = default_attr_update;
@@ -2590,21 +2585,19 @@ static int amdgpu_device_attr_create_groups(struct amdgpu_device *adev,
 					    uint32_t mask,
 					    struct list_head *attr_list)
 {
-	int ret = 0;
-	uint32_t i = 0;
+	uint32_t i;
+	int ret;
 
 	for (i = 0; i < counts; i++) {
-		ret = amdgpu_device_attr_create(adev, &attrs[i], mask, attr_list);
-		if (ret)
-			goto failed;
+		ret = amdgpu_device_attr_create(adev, &attrs[i], mask,
+						attr_list);
+		if (ret) {
+			amdgpu_device_attr_remove_groups(adev, attr_list);
+			return ret;
+		}
 	}
 
 	return 0;
-
-failed:
-	amdgpu_device_attr_remove_groups(adev, attr_list);
-
-	return ret;
 }
 
 static void amdgpu_device_attr_remove_groups(struct amdgpu_device *adev,
@@ -2726,7 +2719,7 @@ static ssize_t amdgpu_hwmon_show_temp_emergency(struct device *dev,
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	int channel = to_sensor_dev_attr(attr)->index;
-	int temp = 0;
+	int temp;
 
 	if (channel >= PP_TEMP_MAX)
 		return -EINVAL;
@@ -2741,6 +2734,8 @@ static ssize_t amdgpu_hwmon_show_temp_emergency(struct device *dev,
 	case PP_TEMP_MEM:
 		temp = adev->pm.dpm.thermal.max_mem_emergency_temp;
 		break;
+	default:
+		temp = 0;
 	}
 
 	return sysfs_emit(buf, "%d\n", temp);
@@ -3718,8 +3713,7 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
 				       enum pp_clock_type od_type,
 				       char *buf)
 {
-	int size = 0;
-	int ret;
+	int size, ret;
 
 	ret = amdgpu_pm_get_access_if_active(adev);
 	if (ret)
@@ -4530,7 +4524,7 @@ static int amdgpu_od_set_init(struct amdgpu_device *adev)
 int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 {
 	enum amdgpu_sriov_vf_mode mode;
-	uint32_t mask = 0;
+	uint32_t mask;
 	int ret;
 
 	if (adev->pm.sysfs_initialized)
@@ -4847,7 +4841,7 @@ static ssize_t amdgpu_pm_prv_buffer_read(struct file *f, char __user *buf,
 	struct amdgpu_device *adev = file_inode(f)->i_private;
 	size_t smu_prv_buf_size;
 	void *smu_prv_buf;
-	int ret = 0;
+	int ret;
 
 	ret = amdgpu_pm_dev_state_check(adev, true);
 	if (ret)
-- 
2.48.0

