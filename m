Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D8DCA5FED
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 18:02:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C377110F31E;
	Tue,  6 Oct 2026 18:02:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ba8YFV6E";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8C6A10E3DA
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 18:02:48 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48c4649b3aaso689624f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Oct 2026 11:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791309767; x=1791914567; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fFT4oyz0pKYoowJD8BTUfotX4ssYOptsVATr0kF+LoY=;
 b=ba8YFV6EwCMJaO5iHUtAE7gudXRLY/kMpdJQQ+l14FxE29for+Mb2n5CPhSrNk5B3b
 M5xJZovV7AwvhJ6e5DVTy1RSDm2GEH4BVvHi4dae1km1MvqwG7JMA2X8qdiekL5LA74u
 gLOcVTClnCARLOBtHsb14YClzJ/IpTlFa1OvrsFuj7BxYZuF6+oUZvXyZq3AJ/DXn8GV
 Gsb/pn7IuuMh+R08mkf+j5lcVKBxOKeoJv2XWwxoczBXs2+EHa7Bvi5HsADjYxdXv6ds
 ZVPLrxSdopUm3lbsvsMdb9tFFFcITL3DZSZFtaBTYASc5VmhSmUsPWh8fMOdVYx3a7eX
 qdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791309767; x=1791914567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fFT4oyz0pKYoowJD8BTUfotX4ssYOptsVATr0kF+LoY=;
 b=w2wAOKOOI/FKJLNQYdE+8UWZdOnqWkeCkUZsvhwZnyn/s/DnqS7S5SSSSO0MFstSqa
 6q+OJJKb0ah1HYiXc/lJ1kfRTpgyNfAbv5v8qOCKf7kiKMorArExuoHCbD0f2L/uyiuJ
 ByOQT3Ab5IBOfFq7xXlv05JL/3AbrG87uzgzqxCPOc/6rw6TVcx4WcPGJMZgE1hqIHsA
 SWQLLPct//CZR4jWusBSJc9PJST8zsoODUqtcTCPg5VarDbV8XW8TDBtiqoHPhmmm+vq
 PAtJEWaW7Ywfz5+m1aXo72P05ZdmDjrhWp4Buw8OjShTKoWP87SD2qGKRIZISbYazyVm
 EXsw==
X-Gm-Message-State: AFq9FYJ0Cbh7nSqvitZfbOzbOkq4FNWD7M+nwMPYRUkmrMOMJlecuE/B
 c5dxhHtpNRQthCU6jtD0VLGEIBX89HNJtjcVu4nnG5S4oyk5uN/oA9cQSXUwHA==
X-Gm-Gg: AYBFou2LKSp24qjiuVwIQLc6YQAM5D7Uh5kEioozqGorr4mkEXZAropNJtYQxH51cJw
 +/NO1iVN3j6Iewff9BbRrTk9Wtl7pWeEYDoSmTjdtoiWKQfYg7eoeN95TLaK3kmQK+1iCeBzx0y
 F6So4A7Z9kzn0LyLB+imVFIRb0eY31FXs1Rzt2dOKjKYpCtOvaoE7qlEzb/Ofy5F7n9PvhacqoK
 x1y9f2tK5YDk4s86EgZ2yjkqDZkZ5HvJ+x7gRUsJvAfZ3HKX963BLxfDZBiTvoQvHovmyLhggAI
 9StgnrZjXtHNTzBiWlFUylfqB0e+VpuwqNs3tZco52JK7nNsrJlFTqkPaQNl6U71m+2vjRtGl3B
 plYheHGdTl8rZZSVho90sBRzjcofkKglDaYppqN8TXOQzuZFbbbCsg+aUFzV30Of7PuanlNTF2T
 u/Pwtxfe9rDWKHM48B3snaKirljK9ZZBnSMIqbnEZ03W3RD9sg22OSeUxqC/ePJmp3uLzYPnUKq
 7IkzdI3NTl88cOQlXZx/kVTzVdK2ZSL6zBhzESj9SL+XIANQn8INz7xVuRRX07yUnnrnwvVygA+
 nNmHW0CabAgOu+dD7aCnacoaoa1BUwfIz0z9ifynpqc2n/f2eOtBGPY8wZ5VvOLVYw6ziAavrOc
 YBpy3MU2u2djPqtUY1uSwclZlyPSpSBEgXekBupRtKBIQbFmzBnM0czzSZLjt61SE7dw0W/H+jR
 ZaYfj41EjOdirWlpNJ
X-Received: by 2002:a05:6000:440d:b0:48a:fba3:d5b6 with SMTP id
 ffacd0b85a97d-48c728a6e14mr292650f8f.56.1791309766991; 
 Tue, 06 Oct 2026 11:02:46 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:41ef:ba36:bd76:1e3c:1e5:c273])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d1f3f7sm813630f8f.32.2026.10.06.11.02.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Oct 2026 11:02:46 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH v3 3/3] drm/amdkfd: fail fast on unplugged device in SVM
 migration paths
Date: Tue,  6 Oct 2026 20:02:42 +0200
Message-ID: <20261006180242.52809-4-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261006180242.52809-1-olivier.kaloudoff@gmail.com>
References: <20261006180242.52809-1-olivier.kaloudoff@gmail.com>
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

On surprise removal the killed process's own exit path can fault on
its SVM managed ranges: SIGBUS -> coredump -> get_dump_page() ->
__get_user_pages() -> do_swap_page() -> svm_migrate_to_ram(). Without
an unplug check, svm_migrate_vram_to_ram() submits an SDMA copy job to
an already-killed drm_sched entity (observed as
"drm_sched_rq_add_entity: Trying to push to a killed entity" plus
refcount_t saturation warnings), then svm_migrate_copy_done() waits
uninterruptibly on a job fence that can never signal. The task dies in
D state holding svms->lock, which wedges svm_range_restore_work() on
the rwsem writer side, so kfd_processes_count never drains and the
pciehp removal thread wedges for good.

Fail fast instead of submitting work to a dead GPU. Check both
drm_dev_is_unplugged() and pci_dev_is_disconnected(): the PCI flag is
set as soon as the link drops, which can be well before
drm_dev_unplug() runs in the removal path.

- svm_migrate_vram_to_ram / svm_migrate_ram_to_vram: return -ENODEV
  for a gone device, so the fault path turns it into VM_FAULT_SIGBUS
  and the dying task can die
- svm_migrate_copy_done: skip the fence wait on a gone device, and
  bound the wait to 10s otherwise to survive unplug racing in between
  job submit and wait
- svm_range_restore_work: do not reschedule on -ENODEV, mirroring the
  userptr restore worker fix

Verified on MI50 behind Thunderbolt: with these checks the workload
takes SIGBUS, coredump completes, kfd_processes_count drains in ~4s,
pciehp removal finishes, and the device re-enumerates cleanly on slot
re-power. Previously the same repro wedged the host.

Cc: Xiaogang Chen <xiaogang.chen@amd.com>
Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
---
New in v3.
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 30 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     |  2 +-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 253365a..3568eb2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -202,7 +202,21 @@ svm_migrate_copy_done(struct amdgpu_device *adev, struct dma_fence *mfence)
 	int r = 0;
 
 	if (mfence) {
-		r = dma_fence_wait(mfence, false);
+		/* Job fences on a dead device never signal */
+		if (drm_dev_is_unplugged(adev_to_drm(adev)) ||
+		    pci_dev_is_disconnected(adev->pdev)) {
+			r = -ENODEV;
+		} else {
+			long ret;
+
+			/* survive unplug between submit and wait */
+			ret = dma_fence_wait_timeout(mfence, false,
+					msecs_to_jiffies(10000));
+			if (!ret)
+				r = -ETIMEDOUT;
+			else if (ret < 0)
+				r = ret;
+		}
 		dma_fence_put(mfence);
 		pr_debug("sdma copy memory fence done\n");
 	}
@@ -507,6 +521,13 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 		pr_debug("failed to get kfd node by id 0x%x\n", best_loc);
 		return -ENODEV;
 	}
+	/* Fail the migration on a device that is gone for good */
+	if (drm_dev_is_unplugged(adev_to_drm(node->adev)) ||
+	    pci_dev_is_disconnected(node->adev->pdev)) {
+		pr_debug("gpu 0x%x unplugged, skip migration to vram\n",
+			 best_loc);
+		return -ENODEV;
+	}
 
 	pr_debug("svms 0x%p [0x%lx 0x%lx] in [0x%lx 0x%lx] to gpu 0x%x\n",
 		prange->svms, start_mgr, last_mgr, prange->start, prange->last,
@@ -841,6 +862,13 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 		pr_debug("failed to get kfd node by id 0x%x\n", prange->actual_loc);
 		return -ENODEV;
 	}
+	/* Fail the migration on a device that is gone for good */
+	if (drm_dev_is_unplugged(adev_to_drm(node->adev)) ||
+	    pci_dev_is_disconnected(node->adev->pdev)) {
+		pr_debug("gpu 0x%x unplugged, skip migration to ram\n",
+			 prange->actual_loc);
+		return -ENODEV;
+	}
 	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] from gpu 0x%x to ram\n",
 		 prange->svms, prange, start_mgr, last_mgr,
 		 prange->actual_loc);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index fa4054d..e209ed7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2014,7 +2014,7 @@ out_reschedule:
 	mutex_unlock(&process_info->lock);
 
 	/* If validation failed, reschedule another attempt */
-	if (evicted_ranges) {
+	if (evicted_ranges && r != -ENODEV) {
 		pr_debug("reschedule to restore svm range\n");
 		queue_delayed_work(system_freezable_wq, &svms->restore_work,
 			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
-- 
2.47.3

