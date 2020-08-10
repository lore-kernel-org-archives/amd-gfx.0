Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4C1C433E5
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 19:09:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 012EE22D04
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 19:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONjXPj8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012EE22D04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7405E89C7F;
	Mon, 10 Aug 2020 19:09:48 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69BC589EFF;
 Mon, 10 Aug 2020 19:09:47 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7A7DD22CAF;
 Mon, 10 Aug 2020 19:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597086587;
 bh=6GjrX3vgGRkDhD7NBWNBJhQdyA9DGy1SvAWjflW4pFk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ONjXPj8/l9HV66FKKUsbSbvZ650l90RJlBcyUHsWbiXri9LHlzEeIEOU6JJ1xz19n
 otGaxhkoamLJ8xENrSOtyETbCxBxzxib6WqkdUGFzBcrS3QSfXQh+JWEC0iuslXlR5
 9q3opwYv5+2B6o8/Q7TPocyDctGSBXOb6jiUgI6E=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 35/64] drm/amdgpu/debugfs: fix ref count leak when
 pm_runtime_get_sync fails
Date: Mon, 10 Aug 2020 15:08:30 -0400
Message-Id: <20200810190859.3793319-35-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810190859.3793319-1-sashal@kernel.org>
References: <20200810190859.3793319-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 Evan Quan <evan.quan@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 9eee152aab56d374edb9ad21b3db05f5cdda2fe6 ]

The call to pm_runtime_get_sync increments the counter even in case of
failure, leading to incorrect ref count.
In case of failure, decrement the ref count before returning.

Acked-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 95 +++++++++++++++------
 1 file changed, 70 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index a414da22a359c..386b979e08522 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -223,12 +223,16 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 	*pos &= (1UL << 22) - 1;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	r = amdgpu_virt_enable_access_debugfs(adev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	if (use_bank) {
 		if ((sh_bank != 0xFFFFFFFF && sh_bank >= adev->gfx.config.max_sh_per_se) ||
@@ -332,12 +336,16 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
 		return -EINVAL;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	r = amdgpu_virt_enable_access_debugfs(adev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	while (size) {
 		uint32_t value;
@@ -387,12 +395,16 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
 		return -EINVAL;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	r = amdgpu_virt_enable_access_debugfs(adev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	while (size) {
 		uint32_t value;
@@ -443,12 +455,16 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
 		return -EINVAL;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	r = amdgpu_virt_enable_access_debugfs(adev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	while (size) {
 		uint32_t value;
@@ -498,12 +514,16 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
 		return -EINVAL;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	r = amdgpu_virt_enable_access_debugfs(adev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	while (size) {
 		uint32_t value;
@@ -554,12 +574,16 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
 		return -EINVAL;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	r = amdgpu_virt_enable_access_debugfs(adev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	while (size) {
 		uint32_t value;
@@ -609,12 +633,16 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
 		return -EINVAL;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	r = amdgpu_virt_enable_access_debugfs(adev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	while (size) {
 		uint32_t value;
@@ -764,12 +792,16 @@ static ssize_t amdgpu_debugfs_sensor_read(struct file *f, char __user *buf,
 	valuesize = sizeof(values);
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	r = amdgpu_virt_enable_access_debugfs(adev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	r = amdgpu_dpm_read_sensor(adev, idx, &values[0], &valuesize);
 
@@ -842,12 +874,16 @@ static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf,
 	simd = (*pos & GENMASK_ULL(44, 37)) >> 37;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	r = amdgpu_virt_enable_access_debugfs(adev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	/* switch to the specific se/sh/cu */
 	mutex_lock(&adev->grbm_idx_mutex);
@@ -977,6 +1013,7 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 	}
 
 err:
+	pm_runtime_put_autosuspend(adev->ddev->dev);
 	kfree(data);
 	amdgpu_virt_disable_access_debugfs(adev);
 	return result;
@@ -1003,8 +1040,10 @@ static ssize_t amdgpu_debugfs_gfxoff_write(struct file *f, const char __user *bu
 		return -EINVAL;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	while (size) {
 		uint32_t value;
@@ -1140,8 +1179,10 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
 	int r = 0, i;
 
 	r = pm_runtime_get_sync(dev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	/* Avoid accidently unparking the sched thread during GPU reset */
 	mutex_lock(&adev->lock_reset);
@@ -1197,8 +1238,10 @@ static int amdgpu_debugfs_evict_vram(struct seq_file *m, void *data)
 	int r;
 
 	r = pm_runtime_get_sync(dev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	seq_printf(m, "(%d)\n", amdgpu_bo_evict_vram(adev));
 
@@ -1216,8 +1259,10 @@ static int amdgpu_debugfs_evict_gtt(struct seq_file *m, void *data)
 	int r;
 
 	r = pm_runtime_get_sync(dev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	seq_printf(m, "(%d)\n", ttm_bo_evict_mm(&adev->mman.bdev, TTM_PL_TT));
 
@@ -1417,16 +1462,16 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
 		return -EINVAL;
 
 	ret = pm_runtime_get_sync(adev->ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev)) {
 		ret = smu_get_dpm_freq_range(&adev->smu, SMU_SCLK, &min_freq, &max_freq, true);
 		if (ret || val > max_freq || val < min_freq)
 			return -EINVAL;
 		ret = smu_set_soft_freq_range(&adev->smu, SMU_SCLK, (uint32_t)val, (uint32_t)val, true);
-	} else {
-		return 0;
 	}
 
 	pm_runtime_mark_last_busy(adev->ddev->dev);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
