Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE97FCD6E45
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 09:23:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9149910FBB5;
	Fri, 29 May 2026 09:23:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Rg02szv4";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0520A10FBB5
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 09:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Rgj1YdP9tGy2Kb+4Teg2cq6YrMYW/vBpH2Z2YCgf814=; b=Rg02szv4JeMp9EczK93aYw/KbI
 nRLW55tfxkGcFVKD6hiXJu8PijX+PwCx/y7N8UeZ/W/fTn3xpTK9ZltNri9vnPMwkqIhi0E9MMTg3
 i/ZKznTiRZ3EksXwUcZc2G59qGHJglky8Sy2Ff5OpeKAlDaDhvsPl69OPcbJc5nsLRgz+IvmN8Ih3
 xTfxwQjGhdC3BOeGDyh3S0VwrgxB4mBu5YUonUfYQd4jQDmFQFpxgL3PsCjczw9vyegObSDV3Os/K
 VxSQS2aHJ4vcTLmQOLSx+QzD50pgAiI6XmfO2lBgH3c3FG3Vq4H0VADXB4RG64ZvOrCpocBf2mkn7
 hIyFiFug==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wStR9-009nFc-72; Fri, 29 May 2026 11:23:27 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Benjamin Welton <benjamin.welton@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 Kent Russell <kent.russell@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH] amd/amdkfd: Fix profiler lock init order
Date: Fri, 29 May 2026 10:23:22 +0100
Message-ID: <20260529092322.81977-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
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

A call chain at driver probe exists where profiler lock is used before it
is initialized:

[   12.131440] kfd kfd: Allocated 3969056 bytes on gart
[   12.131561] kfd kfd: Total number of KFD nodes to be created: 1
[   12.132691] ------------[ cut here ]------------
[   12.132703] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
[   12.132705] WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0x616/0x1150, CPU#0: (udev-worker)/569
...
[   12.133051] Call Trace:
[   12.133055]  <TASK>
[   12.133059]  ? mark_held_locks+0x40/0x70
[   12.133068]  ? init_mqd+0xe1/0x1b0 [amdgpu 5154987db73e842b9b4f761e2bd86e17c7ada65c]
[   12.133671]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[   12.133683]  ? init_mqd+0xe1/0x1b0 [amdgpu 5154987db73e842b9b4f761e2bd86e17c7ada65c]
[   12.134235]  init_mqd+0xe1/0x1b0 [amdgpu 5154987db73e842b9b4f761e2bd86e17c7ada65c]
[   12.134781]  init_mqd_hiq+0x12/0x30 [amdgpu 5154987db73e842b9b4f761e2bd86e17c7ada65c]
[   12.135340]  kq_initialize.constprop.0+0x309/0x400 [amdgpu 5154987db73e842b9b4f761e2bd86e17c7ada65c]
[   12.135898]  kernel_queue_init+0x44/0x80 [amdgpu 5154987db73e842b9b4f761e2bd86e17c7ada65c]
[   12.136439]  pm_init+0x70/0x100 [amdgpu 5154987db73e842b9b4f761e2bd86e17c7ada65c]
[   12.136984]  start_cpsch+0x1dc/0x280 [amdgpu 5154987db73e842b9b4f761e2bd86e17c7ada65c]
[   12.137525]  kgd2kfd_device_init+0x70f/0xd10 [amdgpu 5154987db73e842b9b4f761e2bd86e17c7ada65c]
[   12.138070]  amdgpu_amdkfd_device_init+0x172/0x230 [amdgpu 5154987db73e842b9b4f761e2bd86e17c7ada65c]
[   12.138618]  amdgpu_device_init+0x246a/0x2960 [amdgpu 5154987db73e842b9b4f761e2bd86e17c7ada65c]

The human readable call chain is:

kgd2kfd_device_init
  kfd_init_node
    kfd_resume
      node->dqm->ops.start

Where start can be start_cpsch, which calls pm_init, etc, which ends up
calling kq->mqd_mgr->init_mqd, which takes the profiler lock:

init_mqd()
{
...
	mutex_lock(&mm->dev->kfd->profiler_lock);
...

Fix it by initializing the mutext at the top of kgd2kfd_device_init().

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: a789761de305 ("amd/amdkfd: Add kfd_ioctl_profiler to contain profiler kernel driver changes")
Cc: Benjamin Welton <benjamin.welton@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>
Cc: Kent Russell <kent.russell@amd.com>
Cc: Yifan Zhang <yifan1.zhang@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index c2c59781feee..1c57e11220a7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -736,6 +736,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	int partition_mode;
 	int xcp_idx;
 
+	kfd->profiler_process = NULL;
+	mutex_init(&kfd->profiler_lock);
+
 	kfd->mec_fw_version = amdgpu_amdkfd_get_fw_version(kfd->adev,
 			KGD_ENGINE_MEC1);
 	kfd->mec2_fw_version = amdgpu_amdkfd_get_fw_version(kfd->adev,
@@ -936,9 +939,6 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	svm_range_set_max_pages(kfd->adev);
 
-	kfd->profiler_process = NULL;
-	mutex_init(&kfd->profiler_lock);
-
 	kfd->init_complete = true;
 	dev_info(kfd_device, "added device %x:%x\n", kfd->adev->pdev->vendor,
 		 kfd->adev->pdev->device);
-- 
2.54.0

