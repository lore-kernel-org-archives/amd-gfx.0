Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399A6CA5FD4
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 16:13:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B891310F722;
	Thu,  1 Oct 2026 16:13:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b77y2NFv";
	dkim-atps=neutral
Received: from mail-wr2-f31.google.com (mail-wr2-f31.google.com
 [74.125.225.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B39EA10F722
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2026 16:13:14 +0000 (UTC)
Received: by mail-wr2-f31.google.com with SMTP id
 ffacd0b85a97d-488811c9ebaso3547666f8f.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Oct 2026 09:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790871193; x=1791475993; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xxTwMfazHg4OhXQmp8bfTWmzcQ9awyaH5gqiIGZuF/0=;
 b=b77y2NFvtCug9rhxCk0XK/KOV6c3VNmwbnD34Lgw9Jq0ZzKs0S8miEyEpQWDISe679
 N+Lj0GTn6yt0BEwsbrHnizYd149su6o+HfyybR5FDXppdzCQ3nURJTJxs8MEeO5M6etS
 SH4WjEhPoku238tnvJChlFuSE79nWUUtMeWuS/J/4pbADiROUwICox3ziYA8twzAC0XQ
 qI5P9uhaedOIHp0cfZPwMDH/ARM501jurfKNjjYVrbNZSENZA6Lwg2iT6R6ioO0wiMAC
 /bk2pc/T15hCHvLqSB2FKKCFskaTuNu8O4RM5mBX0kDQLc0/mMBSxETrlz+adOQbZ/IN
 4pOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790871193; x=1791475993;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xxTwMfazHg4OhXQmp8bfTWmzcQ9awyaH5gqiIGZuF/0=;
 b=fUzeN3qBHXjvjPua5WME3ykr1kvWpdOkXlAlNvY+ZtGTAlWZk1qDsLQK2J8UXrtayM
 AB5Ds6gfTKxiV+9WkIWgvcVJ3P7nNr+PcSifKAI/0u6PYoo23ldUes7CHwISQsNk5HP1
 OGdToxhGjh2teCyl8AdWX61DQE8y4SZZGem73egBtlCSU3duleyf+w1qFnSCofdZhvEo
 TP/phRLgCqpzVi0/cIoLTMMLWpurU2I8s+NxLPqdUR1o+K/DRGyL97pPjxtVl5lG1egl
 B3MQz/dnhurMn/04EggQQUfdAiy0XT3qE/VjqEzblYVaDOkzDZ682olHaAkjlUnV49wL
 PLMw==
X-Gm-Message-State: AFq9FYL7ADAP+BKDbRT3/GANBUciZ30vYPBpzsgjIgclUVbm2N1DStj3
 v5dfVZGx4wsEZbQLV4HK0vK4c3grS3VtyCNkf5L3zNwKSr3R0IMRUAN9A/M7zNjpq+jaurmf
X-Gm-Gg: AYBFou2KiTCDg8AY/kUGnAVuazzY+UP7mrTWEYG/GoA37Lc4YWb89BIKcZmwH1/NXhJ
 vqh23QZ29X9aocm/idjfv/ugptaG8RkGapD5voaZkRnHGmtUmvhTRzHiNMBRbvW8nah6E67F/iu
 ZTVHbvbxCYtwbbcT/55Yswm1NtY8Go8wH7vL5gDkvZjyqT2Fp8HdtDOu5xB/FOW1XEIboD3Zl5Y
 jGhK2q4CKuoXRomynUpRxDol2cL3FatUtgogf1rYk8CMFBswVH8eoDoHuZkQGnC7hT+AHyP7D2K
 FjN2g/Fn/SueucC6JD7aa8SPjj+J2iYHQhOfWwjR890g8T102FU6EbV1f2JwceyW75/flTIqpqo
 aRjKZuEAETYNO4czwpqmfxkkuUk+OHrlR+zqDAdwf4LHMm9vcs+NJspzuKkvIyVcuDy8TfIKZ/F
 iTr0Vn1UVAc6kOduyTb6e6CE3yHqj5jZBe8CWRoUpIzRYBLhJ7Wp3ba4e/XZ/iGGRFJefZ7eCMX
 MMQIPvDim3QRf6gKG2rKWESkjZyPOjABS+rZHKCrvCDDqghRicX4EpdSw64s5RBqA6DaKY=
X-Received: by 2002:a05:6000:4a14:b0:488:79d6:a4a6 with SMTP id
 ffacd0b85a97d-48b126f158bmr199843f8f.8.1790871192689; 
 Thu, 01 Oct 2026 09:13:12 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b0db6a3b7sm4130254f8f.41.2026.10.01.09.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 09:13:12 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 vitaly.prosyak@amd.com, tom.stdenis@amd.com,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v2] drm/amdgpu: copy debugfs register data outside the
 GRBM/SRBM locks
Date: Thu,  1 Oct 2026 21:13:07 +0500
Message-ID: <20261001161307.24649-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
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
inside those locks. The lock hierarchy in amdgpu_lockdep.c puts
srbm_mutex and grbm_idx_mutex below notifier_lock, which
amdgpu_cs_submit() takes with the BO reservations held, and
dma_resv_lockdep() orders the reservations inside mmap_lock. So
mmap_lock is outside grbm_idx_mutex and srbm_mutex, and these two
debugfs paths nest it the other way round. The copies under the locks
are as old as the bank selection in both files; commit 1d0f5838b126
("drm/amdgpu: Add lockdep annotations for lock ordering validation")
only made them visible to lockdep.

Copy the user buffer in before any of the locks is taken and the result
out after all of them are dropped, as amdgpu_debugfs_wave_read(),
amdgpu_debugfs_gpr_read() and amdgpu_debugfs_gprwave_read() already do.
The buffer is sized by the count passed to read() or write(), so an
access larger than PAGE_SIZE is now rejected with -EINVAL; umr reads and
writes one register at a time. A fault on the user buffer of a write now
fails with -EFAULT before any register is written, instead of after a
partial write.

Fixes: 566281595037 ("drm/amd/amdgpu: Add bank selection for MMIO debugfs (v3)")
Fixes: 37df9560cd3e ("drm/amd/amdgpu: New debugfs interface for MMIO registers (v5)")
Acked-by: Christian König <christian.koenig@amd.com>
Acked-by: Tom St Denis <tom.stdenis@amd.com>
Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---

Notes:
    v2:
    - Fixes: point at the commits that introduced the user copies under the
      locks, not at the lockdep annotation that made them visible
      (Christian).
    - Reject an access larger than PAGE_SIZE before allocating the buffer
      (Vitaly); umr only does 4-byte accesses (Tom).
    - Allocate the buffer with kmalloc() instead of kvmalloc() (Christian).
    - amdgpu_debugfs_gprwave_read() needs no change: it already calls
      put_user() after dropping grbm_idx_mutex.
    - Christian's and Tom's Acked-by were given on v1; the size check and
      kmalloc() are the only code changes since.
    - The test notes went out as a separate reply to v1; they are part of
      the patch mail now.
    
    v1: https://lore.kernel.org/amd-gfx/20260930154934.27981-1-mikhail.v.gavrilov@gmail.com/
    
    Tested v2 on Navi 31 (gfx1100), 7.3.0-rc5 at 551c722f4080, with lockdep.
    
    Without this patch the first GRBM-banked access through amdgpu_regs2
    produces the report above: from the write branch when umr halts
    waves, and from the read branch for a single
    "umr -b x x x -r '*.gfx1100.regGRBM_STATUS'" on a fresh boot.
    
    With this patch, and with the chain from reservation_ww_class_mutex
    through &amdgpu_notifier_lock_key down to &amdgpu_grbm_lock_key present
    in /proc/lockdep, none of the following produced a report, and
    debug_locks stayed 1:
    - the banked read of GRBM_STATUS* above;
    - "umr -O halt_waves -wa gfx_0.0.0" (banked SQ_CMD writes);
    - writing SCRATCH_REG0 and reading it back through amdgpu_regs2 with
      GRBM broadcast, and through amdgpu_regs with the bank bits in the
      offset; both reads returned the value written.
    A 4100-byte read of amdgpu_regs and of amdgpu_regs2 fails with EINVAL.

 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 77 ++++++++++++---------
 1 file changed, 46 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index aca1a8045a..ab7ccfaea2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -121,6 +121,20 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 
 	*pos &= (1UL << 22) - 1;
 
+	if (size > PAGE_SIZE)
+		return -EINVAL;
+
+	/*
+	 * Access the user buffer only while none of the locks below are held:
+	 * a fault takes mmap_lock, and grbm_idx_mutex and srbm_mutex nest
+	 * inside it.
+	 */
+	u32 *data __free(kfree) = kmalloc(size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	if (!read && copy_from_user(data, buf, size))
+		return -EFAULT;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -152,28 +166,16 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
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
@@ -188,6 +190,10 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
 	amdgpu_virt_disable_access_debugfs(adev);
+
+	if (read && copy_to_user(buf, data, result))
+		return -EFAULT;
+
 	return result;
 }
 
@@ -238,11 +244,24 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
 	struct amdgpu_device *adev = rd->adev;
 	ssize_t result = 0;
 	int r;
-	uint32_t value;
 
 	if (size & 0x3 || offset & 0x3)
 		return -EINVAL;
 
+	if (size > PAGE_SIZE)
+		return -EINVAL;
+
+	/*
+	 * Access the user buffer only while none of the locks below are held:
+	 * a fault takes mmap_lock, and grbm_idx_mutex and srbm_mutex nest
+	 * inside it.
+	 */
+	u32 *data __free(kfree) = kmalloc(size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	if (write_en && copy_from_user(data, buf, size))
+		return -EFAULT;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -281,24 +300,16 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
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
@@ -317,6 +328,10 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
 	amdgpu_virt_disable_access_debugfs(adev);
+
+	if (!write_en && copy_to_user(buf, data, result))
+		return -EFAULT;
+
 	return result;
 }
 

base-commit: 551c722f40809618230001baccf219193e22fc5a
-- 
2.43.0

