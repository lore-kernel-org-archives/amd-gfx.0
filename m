Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B47CCA5FC7
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 15:49:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1204610E184;
	Wed, 30 Sep 2026 15:49:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jkOD2M7u";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E0E010E184
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 15:49:50 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912df756so42935565e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 08:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790783388; x=1791388188; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eryavSC9Mq+IbIe9IYvlTJODUywMaOaLGazdRydfD7M=;
 b=jkOD2M7uuK/scVvN2073xOkXm2KMaHxqxsz7cOQFluS7Zh0gLxE9rhvQPmcA090WuR
 ZXPcmTzPYGoZVaDPDGcURP70nQaVrojNhKhHhfdTAvl3k4IAIz0tkslUEQvJ5orNDQgZ
 +E76WfogeEayqYKwSGecGkUAaWvVFnw7Xy1lbuOIYlkIJ4JXaB6ACShi5kXgJRBFXe1x
 4Wbmu7rCN9+lsXzxSq3xPD7+6dpt0ViGW7wVjBcvxKswydLA7iRwRw8ESGVVXhubImZm
 xti3IzeKePX4oLC2oUfeA1JOISv19sWV+2dxZZdclx/O4g6Vsaj6shcP5U0dp+m5zGih
 IqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790783388; x=1791388188;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eryavSC9Mq+IbIe9IYvlTJODUywMaOaLGazdRydfD7M=;
 b=P4lIWroCHEJZM+G7+ocbu72qtP2UwdQhAIYMaQLPLf1eoG3VpsICcw62xSWQQyBaDa
 mz42vUkKASARPuqffl7G8UMuZrcEqpri6J8tjt4mWc+9ii+DjINBTo8ywr3JYW1LuPgW
 kcExkE13sBfEIVGaAXtZlkF44qp4xL0ye80HwsLq4WgLbQeujQmVZs3M9YzSFscQxEXx
 +YHNi1y/fmcGEC0JZc9W/y+sKUMyJYATuVVwWflhb9HHH28o1f4iQc3q46syA9bt6cmX
 7pBHbymh7Yc/0nIYs1ufdRO+21h5vusRu6/YWq3DwQOOmOZ84Bmio/tR/bbJOuyU2CBn
 V84w==
X-Gm-Message-State: AFuF++m5NamzOiSG6dp0h6npwpHWuWFW4+2ip6coJUQCV2gjACDSdj3Q
 /r6T7MGcOB8Jo2zOs5d+YEICB2QB3n9TuWtpzJIvbFSY7q+NQEKRnKQIXetldDS9Qabwce7c
X-Gm-Gg: AYBFou2ahy28XYe7b/0d9nDMKR+9p5wkh7w9bOvizUhq9PuvALQ19hmpIbE2mRGFH5l
 L2P66qCceCaHyEYDxcSkPG4zZn7grEh2cw/nQ+/nt0dQ4Jgmn6aXHxH9uylbKAAPbOAjiI+b4Bf
 DIA1Bu1zhTWRbu25RMZsUgpK6Yr9M/aqkGzJkXo8t/mYPQ09JHBkgHhOBOuJXytMHh82OSwtWBw
 8tNbsZzXlqKBcBOQg7rb8i2rQci/kWsOMqZljB9hbcBIuqLwUaT1BDbLImpAOSyL9VWXJPMRuYS
 GZFmxBBdGuS1M/K1U0cYyWhxVoNOM34pJoh96TnMxMcCW6zcPbOagfWvqmbM/5jkh/nIPXhGEf5
 NJFzDL6HoKawNXg3VIAHkHiU8Y/XS27EtQfuW1oUxAYMhsE9tZQhfYtFh4TNsuE++n5TX1GKmw8
 CDNkc6TCki5QSUaVq/gwn7L6Zt6Ud7TmfD8woo1bymZfbMGBQ/T/4icO6ff/aLdtXS6923gmJqG
 /xtyWZXYTUMSG8+jXd6bbx2C4AUf2R5UvqLN7gjVUyfk87p3JSohocwiQ58Y4M2iK+GX/vOXIiK
 lTYszw==
X-Received: by 2002:a05:600c:3e1b:b0:4a0:159b:d2a9 with SMTP id
 5b1f17b1804b1-4a01b126300mr34590075e9.24.1790783388035; 
 Wed, 30 Sep 2026 08:49:48 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01ccf92d2sm12506965e9.1.2026.09.30.08.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:49:46 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 vitaly.prosyak@amd.com, tom.stdenis@amd.com,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] drm/amdgpu: copy debugfs register data outside the GRBM/SRBM
 locks
Date: Wed, 30 Sep 2026 20:49:34 +0500
Message-ID: <20260930154934.27981-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Reading or writing a register through the amdgpu_regs2 debugfs file
with GRBM bank selection, which umr does for every banked access (a
single "umr -b x x x -r <reg>" is enough, as is the wave dump with
"-O halt_waves"), makes lockdep report a circular locking dependency,
after which lockdep stays off until reboot:

  WARNING: possible circular locking dependency detected
  umr/63306 is trying to acquire lock:
  ffff8882cf4b8350 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0x9b/0x140
  but task is already holding lock:
  ffff8881aec010d0 (&amdgpu_grbm_lock_key){+.+.}-{4:4}, at: amdgpu_debugfs_regs2_op.isra.0+0x20d/0xd00 [amdgpu]
  ...
  Chain exists of:
    &mm->mmap_lock --> &amdgpu_srbm_lock_key --> &amdgpu_grbm_lock_key
  ...
   __might_fault+0xc5/0x140
   amdgpu_debugfs_regs2_op.isra.0+0x441/0xd00 [amdgpu]
   full_proxy_write+0x10e/0x1d0
   vfs_write+0x1d0/0xf50
   ksys_write+0x116/0x250

amdgpu_debugfs_regs2_op() and amdgpu_debugfs_process_reg_op() call
get_user()/put_user() for every dword while holding grbm_idx_mutex or
srbm_mutex, and pm.mutex if requested, so a fault there takes mmap_lock
inside those locks. The lock hierarchy declared in amdgpu_lockdep.c since
commit 1d0f5838b126
("drm/amdgpu: Add lockdep annotations for lock ordering validation") puts
srbm_mutex and grbm_idx_mutex below notifier_lock, which
amdgpu_cs_submit() takes with the BO reservations held, and
dma_resv_lockdep() orders the reservations inside mmap_lock. So
mmap_lock is outside grbm_idx_mutex and srbm_mutex, and these two
debugfs paths nest it the other way round.

Copy the user buffer in before any of the locks is taken and the result
out after all of them are dropped, as amdgpu_debugfs_wave_read(),
amdgpu_debugfs_gpr_read() and amdgpu_debugfs_gprwave_read() already do.
A fault on the user buffer of a write now fails with -EFAULT before any
register is written, instead of after a partial write.

Fixes: 1d0f5838b126 ("drm/amdgpu: Add lockdep annotations for lock ordering validation")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 71 ++++++++++++---------
 1 file changed, 40 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index aca1a8045afa..5618bd3e2610 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -121,6 +121,17 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 
 	*pos &= (1UL << 22) - 1;
 
+	/*
+	 * Access the user buffer only while none of the locks below are held:
+	 * a fault takes mmap_lock, and grbm_idx_mutex and srbm_mutex nest
+	 * inside it.
+	 */
+	u32 *data __free(kvfree) = kvmalloc(size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	if (!read && copy_from_user(data, buf, size))
+		return -EFAULT;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -152,28 +163,16 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 		mutex_lock(&adev->pm.mutex);
 
 	while (size) {
-		uint32_t value;
-
-		if (read) {
-			value = RREG32(*pos >> 2);
-			r = put_user(value, (uint32_t *)buf);
-		} else {
-			r = get_user(value, (uint32_t *)buf);
-			if (!r)
-				amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, value, 0);
-		}
-		if (r) {
-			result = r;
-			goto end;
-		}
+		if (read)
+			data[result >> 2] = RREG32(*pos >> 2);
+		else
+			amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, data[result >> 2], 0);
 
 		result += 4;
-		buf += 4;
 		*pos += 4;
 		size -= 4;
 	}
 
-end:
 	if (use_bank) {
 		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 		mutex_unlock(&adev->grbm_idx_mutex);
@@ -188,6 +187,10 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
 	amdgpu_virt_disable_access_debugfs(adev);
+
+	if (read && copy_to_user(buf, data, result))
+		return -EFAULT;
+
 	return result;
 }
 
@@ -238,11 +241,21 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
 	struct amdgpu_device *adev = rd->adev;
 	ssize_t result = 0;
 	int r;
-	uint32_t value;
 
 	if (size & 0x3 || offset & 0x3)
 		return -EINVAL;
 
+	/*
+	 * Access the user buffer only while none of the locks below are held:
+	 * a fault takes mmap_lock, and grbm_idx_mutex and srbm_mutex nest
+	 * inside it.
+	 */
+	u32 *data __free(kvfree) = kvmalloc(size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	if (write_en && copy_from_user(data, buf, size))
+		return -EFAULT;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -281,24 +294,16 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
 		mutex_lock(&adev->pm.mutex);
 
 	while (size) {
-		if (!write_en) {
-			value = RREG32(offset >> 2);
-			r = put_user(value, (uint32_t *)buf);
-		} else {
-			r = get_user(value, (uint32_t *)buf);
-			if (!r)
-				amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, value, rd->id.xcc_id);
-		}
-		if (r) {
-			result = r;
-			goto end;
-		}
+		if (!write_en)
+			data[result >> 2] = RREG32(offset >> 2);
+		else
+			amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, data[result >> 2],
+						rd->id.xcc_id);
 		offset += 4;
 		size -= 4;
 		result += 4;
-		buf += 4;
 	}
-end:
+
 	if (rd->id.use_grbm) {
 		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, rd->id.xcc_id);
 		mutex_unlock(&adev->grbm_idx_mutex);
@@ -317,6 +322,10 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
 	amdgpu_virt_disable_access_debugfs(adev);
+
+	if (!write_en && copy_to_user(buf, data, result))
+		return -EFAULT;
+
 	return result;
 }
 
-- 
2.55.0

