Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84BFC33CA3
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 23:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EF0320721
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 23:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/xABvfE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF0320721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 848E389CDE;
	Fri, 10 Jan 2020 23:45:24 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EACAD89C28
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 23:45:22 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id w127so3586447qkb.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 15:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YVC4YnzlhLzi37qpQhueqgfpSLyE3VBXdCzyoU1PN2c=;
 b=j/xABvfEoqNRqfdKESXvPBycygEeaIIRdzZmNq/jpAijuCWzEsnzGqcFy3rUjJOWP+
 Fixe78SuqVCXx0C8ZqivTyyaqhBdPggNixNWnPZZXBsMHA43QzmtRyn18DCcJqXJ5dqo
 p5IdPFF15PokKizbTN74WKldJ2m/10hrooY8MOw6gf97xcqRL2aFn1VfZOxl3Jf6POJj
 gY5mAa4tHSIE7+AOJ+hhU5o/HkqMK2EeTIm8EscFyPRbUqQi0ZW7WBZz49a15iwpbGSb
 2klAfM3Bhmwi22u1mZ3IPYIFIHY1bDT8HyXepKhppvlOCtPeLdIKJMkgGo9pxy0ceD4n
 bfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YVC4YnzlhLzi37qpQhueqgfpSLyE3VBXdCzyoU1PN2c=;
 b=phxXa5jwT/bFEhKOA46j7cD9K1RC8UpEukQqkPNxj6QZMJLKemR4Cff2NBKyprCElP
 KnpX/oZYmpy2lXX4Iudx2DX02BQQ0No4zl0DfKR59klTbhINO4E6G32PxYvIqwzpS5YO
 WoPU0b7D4t+nshxFqZg6PsrKOj5UokAem/7ZVzfAHvW+Oqr7Rs9rMnc/qIqkN3wDPDH1
 iaW7UrPwhu9XDmHsHKl+5RxG3voaEpEn+R2FvButG9eKEt+Mvp7yTC4cDEZhwCI30cBh
 fZw6GKDeB91KVEHJXJ/6ymtFbDfCK5mocmR1FMwx3lfRg76yU36P4yNtr5sG2B9Vy1jY
 gG1A==
X-Gm-Message-State: APjAAAU3SN6nLOrGip8ENnDEDfZ3EBnep5ganR8xJ2l9vPAMVIxeMBHh
 sWRZxZ6iwqUvUUvp6xoydt8D0o/8
X-Google-Smtp-Source: APXvYqwc9l+Sl7gsqCUwpPYL7VFujKSdWHQiY95p1W8Lt5iQITCTpBA1BtcHkLR3tmwaCa9aAajwMw==
X-Received: by 2002:a05:620a:796:: with SMTP id
 22mr5659229qka.419.1578699921782; 
 Fri, 10 Jan 2020 15:45:21 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id o187sm1586045qkf.26.2020.01.10.15.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2020 15:45:21 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/debugfs: properly handle runtime pm
Date: Fri, 10 Jan 2020 18:45:09 -0500
Message-Id: <20200110234509.4195-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110234509.4195-1-alexander.deucher@amd.com>
References: <20200110234509.4195-1-alexander.deucher@amd.com>
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

If driver debugfs files are accessed, power up the GPU
when necessary.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 133 ++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   |   8 ++
 2 files changed, 134 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 63343bb43049..f24ed9a1a3e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -26,6 +26,7 @@
 #include <linux/kthread.h>
 #include <linux/pci.h>
 #include <linux/uaccess.h>
+#include <linux/pm_runtime.h>
 
 #include <drm/drm_debugfs.h>
 
@@ -144,10 +145,17 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 
 	*pos &= (1UL << 22) - 1;
 
+	r = pm_runtime_get_sync(adev->ddev->dev);
+	if (r < 0)
+		return r;
+
 	if (use_bank) {
 		if ((sh_bank != 0xFFFFFFFF && sh_bank >= adev->gfx.config.max_sh_per_se) ||
-		    (se_bank != 0xFFFFFFFF && se_bank >= adev->gfx.config.max_shader_engines))
+		    (se_bank != 0xFFFFFFFF && se_bank >= adev->gfx.config.max_shader_engines)) {
+			pm_runtime_mark_last_busy(adev->ddev->dev);
+			pm_runtime_put_autosuspend(adev->ddev->dev);
 			return -EINVAL;
+		}
 		mutex_lock(&adev->grbm_idx_mutex);
 		amdgpu_gfx_select_se_sh(adev, se_bank,
 					sh_bank, instance_bank);
@@ -193,6 +201,9 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 	if (pm_pg_lock)
 		mutex_unlock(&adev->pm.mutex);
 
+	pm_runtime_mark_last_busy(adev->ddev->dev);
+	pm_runtime_put_autosuspend(adev->ddev->dev);
+
 	return result;
 }
 
@@ -237,13 +248,20 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
+	r = pm_runtime_get_sync(adev->ddev->dev);
+	if (r < 0)
+		return r;
+
 	while (size) {
 		uint32_t value;
 
 		value = RREG32_PCIE(*pos >> 2);
 		r = put_user(value, (uint32_t *)buf);
-		if (r)
+		if (r) {
+			pm_runtime_mark_last_busy(adev->ddev->dev);
+			pm_runtime_put_autosuspend(adev->ddev->dev);
 			return r;
+		}
 
 		result += 4;
 		buf += 4;
@@ -251,6 +269,9 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
 		size -= 4;
 	}
 
+	pm_runtime_mark_last_busy(adev->ddev->dev);
+	pm_runtime_put_autosuspend(adev->ddev->dev);
+
 	return result;
 }
 
@@ -276,12 +297,19 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
+	r = pm_runtime_get_sync(adev->ddev->dev);
+	if (r < 0)
+		return r;
+
 	while (size) {
 		uint32_t value;
 
 		r = get_user(value, (uint32_t *)buf);
-		if (r)
+		if (r) {
+			pm_runtime_mark_last_busy(adev->ddev->dev);
+			pm_runtime_put_autosuspend(adev->ddev->dev);
 			return r;
+		}
 
 		WREG32_PCIE(*pos >> 2, value);
 
@@ -291,6 +319,9 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
 		size -= 4;
 	}
 
+	pm_runtime_mark_last_busy(adev->ddev->dev);
+	pm_runtime_put_autosuspend(adev->ddev->dev);
+
 	return result;
 }
 
@@ -316,13 +347,20 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
+	r = pm_runtime_get_sync(adev->ddev->dev);
+	if (r < 0)
+		return r;
+
 	while (size) {
 		uint32_t value;
 
 		value = RREG32_DIDT(*pos >> 2);
 		r = put_user(value, (uint32_t *)buf);
-		if (r)
+		if (r) {
+			pm_runtime_mark_last_busy(adev->ddev->dev);
+			pm_runtime_put_autosuspend(adev->ddev->dev);
 			return r;
+		}
 
 		result += 4;
 		buf += 4;
@@ -330,6 +368,9 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
 		size -= 4;
 	}
 
+	pm_runtime_mark_last_busy(adev->ddev->dev);
+	pm_runtime_put_autosuspend(adev->ddev->dev);
+
 	return result;
 }
 
@@ -355,12 +396,19 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
+	r = pm_runtime_get_sync(adev->ddev->dev);
+	if (r < 0)
+		return r;
+
 	while (size) {
 		uint32_t value;
 
 		r = get_user(value, (uint32_t *)buf);
-		if (r)
+		if (r) {
+			pm_runtime_mark_last_busy(adev->ddev->dev);
+			pm_runtime_put_autosuspend(adev->ddev->dev);
 			return r;
+		}
 
 		WREG32_DIDT(*pos >> 2, value);
 
@@ -370,6 +418,9 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
 		size -= 4;
 	}
 
+	pm_runtime_mark_last_busy(adev->ddev->dev);
+	pm_runtime_put_autosuspend(adev->ddev->dev);
+
 	return result;
 }
 
@@ -395,13 +446,20 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
+	r = pm_runtime_get_sync(adev->ddev->dev);
+	if (r < 0)
+		return r;
+
 	while (size) {
 		uint32_t value;
 
 		value = RREG32_SMC(*pos);
 		r = put_user(value, (uint32_t *)buf);
-		if (r)
+		if (r) {
+			pm_runtime_mark_last_busy(adev->ddev->dev);
+			pm_runtime_put_autosuspend(adev->ddev->dev);
 			return r;
+		}
 
 		result += 4;
 		buf += 4;
@@ -409,6 +467,9 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
 		size -= 4;
 	}
 
+	pm_runtime_mark_last_busy(adev->ddev->dev);
+	pm_runtime_put_autosuspend(adev->ddev->dev);
+
 	return result;
 }
 
@@ -434,12 +495,19 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
+	r = pm_runtime_get_sync(adev->ddev->dev);
+	if (r < 0)
+		return r;
+
 	while (size) {
 		uint32_t value;
 
 		r = get_user(value, (uint32_t *)buf);
-		if (r)
+		if (r) {
+			pm_runtime_mark_last_busy(adev->ddev->dev);
+			pm_runtime_put_autosuspend(adev->ddev->dev);
 			return r;
+		}
 
 		WREG32_SMC(*pos, value);
 
@@ -449,6 +517,9 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
 		size -= 4;
 	}
 
+	pm_runtime_mark_last_busy(adev->ddev->dev);
+	pm_runtime_put_autosuspend(adev->ddev->dev);
+
 	return result;
 }
 
@@ -572,7 +643,16 @@ static ssize_t amdgpu_debugfs_sensor_read(struct file *f, char __user *buf,
 	idx = *pos >> 2;
 
 	valuesize = sizeof(values);
+
+	r = pm_runtime_get_sync(adev->ddev->dev);
+	if (r < 0)
+		return r;
+
 	r = amdgpu_dpm_read_sensor(adev, idx, &values[0], &valuesize);
+
+	pm_runtime_mark_last_busy(adev->ddev->dev);
+	pm_runtime_put_autosuspend(adev->ddev->dev);
+
 	if (r)
 		return r;
 
@@ -633,6 +713,10 @@ static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf,
 	wave = (*pos & GENMASK_ULL(36, 31)) >> 31;
 	simd = (*pos & GENMASK_ULL(44, 37)) >> 37;
 
+	r = pm_runtime_get_sync(adev->ddev->dev);
+	if (r < 0)
+		return r;
+
 	/* switch to the specific se/sh/cu */
 	mutex_lock(&adev->grbm_idx_mutex);
 	amdgpu_gfx_select_se_sh(adev, se, sh, cu);
@@ -644,6 +728,9 @@ static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf,
 	amdgpu_gfx_select_se_sh(adev, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
+	pm_runtime_mark_last_busy(adev->ddev->dev);
+	pm_runtime_put_autosuspend(adev->ddev->dev);
+
 	if (!x)
 		return -EINVAL;
 
@@ -711,6 +798,10 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 	if (!data)
 		return -ENOMEM;
 
+	r = pm_runtime_get_sync(adev->ddev->dev);
+	if (r < 0)
+		return r;
+
 	/* switch to the specific se/sh/cu */
 	mutex_lock(&adev->grbm_idx_mutex);
 	amdgpu_gfx_select_se_sh(adev, se, sh, cu);
@@ -726,6 +817,9 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 	amdgpu_gfx_select_se_sh(adev, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
+	pm_runtime_mark_last_busy(adev->ddev->dev);
+	pm_runtime_put_autosuspend(adev->ddev->dev);
+
 	while (size) {
 		uint32_t value;
 
@@ -859,6 +953,10 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
 	struct amdgpu_device *adev = dev->dev_private;
 	int r = 0, i;
 
+	r = pm_runtime_get_sync(dev->dev);
+	if (r < 0)
+		return r;
+
 	/* Avoid accidently unparking the sched thread during GPU reset */
 	mutex_lock(&adev->lock_reset);
 
@@ -889,6 +987,9 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
 
 	mutex_unlock(&adev->lock_reset);
 
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
+
 	return 0;
 }
 
@@ -907,8 +1008,17 @@ static int amdgpu_debugfs_evict_vram(struct seq_file *m, void *data)
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *dev = node->minor->dev;
 	struct amdgpu_device *adev = dev->dev_private;
+	int r;
+
+	r = pm_runtime_get_sync(dev->dev);
+	if (r < 0)
+		return r;
 
 	seq_printf(m, "(%d)\n", amdgpu_bo_evict_vram(adev));
+
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
+
 	return 0;
 }
 
@@ -917,8 +1027,17 @@ static int amdgpu_debugfs_evict_gtt(struct seq_file *m, void *data)
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *dev = node->minor->dev;
 	struct amdgpu_device *adev = dev->dev_private;
+	int r;
+
+	r = pm_runtime_get_sync(dev->dev);
+	if (r < 0)
+		return r;
 
 	seq_printf(m, "(%d)\n", ttm_bo_evict_mm(&adev->mman.bdev, TTM_PL_TT));
+
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index e9efee04ca23..3c01252b1e0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -741,10 +741,18 @@ static int amdgpu_debugfs_gpu_recover(struct seq_file *m, void *data)
 	struct drm_info_node *node = (struct drm_info_node *) m->private;
 	struct drm_device *dev = node->minor->dev;
 	struct amdgpu_device *adev = dev->dev_private;
+	int r;
+
+	r = pm_runtime_get_sync(dev->dev);
+	if (r < 0)
+		return 0;
 
 	seq_printf(m, "gpu recover\n");
 	amdgpu_device_gpu_recover(adev, NULL);
 
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
+
 	return 0;
 }
 
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
