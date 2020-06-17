Return-Path: <SRS0=VPxi=76=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1375BC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 19:02:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8DBA214DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 19:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1/NSAKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8DBA214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 878BF6E152;
	Wed, 17 Jun 2020 19:02:23 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F7AF6E152
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 19:02:22 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id fc4so1589298qvb.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 12:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VMfur56M45uz451VjgLslUNU7pTErj1hpee6S7Cu6Ac=;
 b=H1/NSAKzBhDbxlRoLQYw0egkAr4BP9ZX7WlZNERCbLFtwm0r4fyIlIl4r4EEcKZC5w
 K9PJTUFfn1P2bO745madh4EeU82oJpAZcu5M8SXGUCF7nVL6sgtH0L6s4dExrtiIH25c
 PI31DKPs/FDfhf7Lzowfv1IPyi7PfS6YxF9waj6gPij5j13WhiNEogRRLh73jhHNwVXo
 IM0IeaHMvXIeVpO1Jd9lgzd2gRNB7IF6JNR3Jx4pBWyiFN34R1W6TNc68pMnyFsd7oXL
 c6CCYRS8A5erFZCunCmhDjnaSwq4NZWn43VIwShiu864VA4MkIXR0dk2aoHGxw6EqfCJ
 ZnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VMfur56M45uz451VjgLslUNU7pTErj1hpee6S7Cu6Ac=;
 b=jAFWim1h32MzM4y26y2eOd1deQ4wQVg87bGUoQKiXWV0Hem1IQHU+YDk7fwkTg1CZn
 SoZipS/N3MryonAiWGkOMVtU5mQnhdr9TnAdandPmet75hXDT5uk6zFb7tl+hG/9AqXa
 DNyrAwoF9IyFni8hdvkdrr2x1amhiPe3MxNczpoeuLMe4QMsAxlHdKaEj+LbQqAERq6t
 xXNpeUp5RympxhJxINCcH7JJ2AAbRmD4EeidlB+yTejsKhexOHoRcoa+Q5S+rea80TdF
 NxErX9fjtXfoYCjGCgdGCBD5hIGuWOin7xyIsHQH47Ro/4zcIMDhXgSH3krXWJ59H88V
 GHaw==
X-Gm-Message-State: AOAM5325YvXBMF90GbKHLalSctPaCKcGuJP//7vPjADY7jqADFgA1ltV
 ghi1MRYSc/6mTkalFlaETslP0/Rb
X-Google-Smtp-Source: ABdhPJxHhVAZ7S3+/R0RmBKdIuXEmHSCXZB7yNr7Nw+nnBYl69hgANI8BUNeNU4mHSOMX2CloYMaIA==
X-Received: by 2002:a0c:bece:: with SMTP id f14mr88916qvj.19.1592420541074;
 Wed, 17 Jun 2020 12:02:21 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id v59sm705056qte.96.2020.06.17.12.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 12:02:20 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu/debugfs: fix ref count leak when
 pm_runtime_get_sync fails
Date: Wed, 17 Jun 2020 15:02:09 -0400
Message-Id: <20200617190212.3519907-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The call to pm_runtime_get_sync increments the counter even in case of
failure, leading to incorrect ref count.
In case of failure, decrement the ref count before returning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 95 +++++++++++++++------
 1 file changed, 70 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 0ac9aab69497..aeada7c9fbea 100644
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
@@ -981,6 +1017,7 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 	return result;
 
 err:
+	pm_runtime_put_autosuspend(adev->ddev->dev);
 	kfree(data);
 	return r;
 }
@@ -1006,8 +1043,10 @@ static ssize_t amdgpu_debugfs_gfxoff_write(struct file *f, const char __user *bu
 		return -EINVAL;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	while (size) {
 		uint32_t value;
@@ -1143,8 +1182,10 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
 	int r = 0, i;
 
 	r = pm_runtime_get_sync(dev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	/* Avoid accidently unparking the sched thread during GPU reset */
 	mutex_lock(&adev->lock_reset);
@@ -1200,8 +1241,10 @@ static int amdgpu_debugfs_evict_vram(struct seq_file *m, void *data)
 	int r;
 
 	r = pm_runtime_get_sync(dev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	seq_printf(m, "(%d)\n", amdgpu_bo_evict_vram(adev));
 
@@ -1219,8 +1262,10 @@ static int amdgpu_debugfs_evict_gtt(struct seq_file *m, void *data)
 	int r;
 
 	r = pm_runtime_get_sync(dev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	seq_printf(m, "(%d)\n", ttm_bo_evict_mm(&adev->mman.bdev, TTM_PL_TT));
 
@@ -1410,16 +1455,16 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
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
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
