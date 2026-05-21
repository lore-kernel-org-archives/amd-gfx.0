Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F16CD5BB1
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 12:55:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE90C10E146;
	Thu, 21 May 2026 12:55:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W3tcpBQc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B59F10E146
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 12:55:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with UTF8SMTP id A55CE60222;
 Thu, 21 May 2026 12:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 79CE91F00A3C;
 Thu, 21 May 2026 12:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779368141;
 bh=LxGC1B7DAV1HdZqcMb7F/9K2fH3zWjguvwIMEgXj2es=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=W3tcpBQctoBmEWtjhxwuA0cIBfH8yIiZtsUSfyh3/cE9lsnHtVgly4zT/Ql/Dd00U
 9i+R1r/q3bxE0RQy/Fk4DVr2ZyROnK11FbmFripRDdD+mdBZX8nancFGLQTWGRqnV2
 tewSANC6jZIvC2rkUKOYMnr+uKtkwtQKYhZhSi6gT2wohQElrCUXk/rE3jE3Uo6JRH
 Tccy49lbV6VE+ElZhvkG+9mi2X2jlPCgrq7FAG6nBBipuagKSL4g214qwueSz34/8B
 hbnJT5tSvTf1tPV4Abx2ylKzWk0n5pzCebZVdYoF3hB34M8V96sbAYJsXKPCQEc8Xi
 4IFjiqGAbfvcg==
From: Thomas Gleixner <tglx@kernel.org>
To: Bert Karwatzki <spasswolf@web.de>
Cc: linux-kernel@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH] amd/amdkfd: Initialize kfd_dev::profiler lock early
In-Reply-To: <878q9dvzh0.ffs@tglx>
References: <20260520225245.2962-1-spasswolf@web.de>
 <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>
 <s7cu3dpioidx6mepmai6eyj2pxjs4skbw7v534zbzs6g2fwcis@cvokidcxy3xa>
 <4f548d61b2dd12e01f401ce4b8c865f238f7b23c.camel@web.de>
 <878q9dvzh0.ffs@tglx>
Date: Thu, 21 May 2026 14:55:37 +0200
Message-ID: <87wlwwvs52.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
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

Bert reported the following lockdep splat:

 DEBUG_LOCKS_WARN_ON(lock->magic != lock)
 WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0x586/0x10c0, CPU#17: (udev-worker)/331
 RIP: 0010:__mutex_lock+0x58d/0x10c0
  init_mqd+0x122/0x190 [amdgpu]
  init_mqd_hiq+0xd/0x20 [amdgpu]
  kq_initialize.constprop.0+0x2b8/0x370 [amdgpu]
  kernel_queue_init+0x3f/0x60 [amdgpu]
  pm_init+0x6b/0x100 [amdgpu]
  start_cpsch+0x1d6/0x270 [amdgpu]
  kgd2kfd_device_init.cold+0x7b9/0xa1a [amdgpu]
  amdgpu_amdkfd_device_init+0x190/0x260 [amdgpu]
  amdgpu_device_init.cold+0x1952/0x1c79 [amdgpu]
  amdgpu_driver_load_kms+0x14/0x80 [amdgpu]

Some implementations of init_mqd() acquire kfd_dev->profile_lock, which is
initialized in kgd2kfd_device_init() after init_mqd() was invoked via the
above callchain. So init_mqd() tries to lock an uninitialized mutex.

Move the initialization to the beginning of kgd2kfd_device_init() to cure
that.

Fixes: a789761de305 ("amd/amdkfd: Add kfd_ioctl_profiler to contain profiler kernel driver changes")
Reported-by: Bert Karwatzki <spasswolf@web.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Benjamin Welton <bewelton@amd.com>
Closes: https://lore.kernel.org/lkml/4f548d61b2dd12e01f401ce4b8c865f238f7b23c.camel@web.de/
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -744,6 +744,9 @@ bool kgd2kfd_device_init(struct kfd_dev
 			KGD_ENGINE_SDMA1);
 	kfd->shared_resources = *gpu_resources;
 
+	kfd->profiler_process = NULL;
+	mutex_init(&kfd->profiler_lock);
+
 	kfd->num_nodes = amdgpu_xcp_get_num_xcp(kfd->adev->xcp_mgr);
 
 	if (kfd->num_nodes == 0) {
@@ -936,9 +939,6 @@ bool kgd2kfd_device_init(struct kfd_dev
 
 	svm_range_set_max_pages(kfd->adev);
 
-	kfd->profiler_process = NULL;
-	mutex_init(&kfd->profiler_lock);
-
 	kfd->init_complete = true;
 	dev_info(kfd_device, "added device %x:%x\n", kfd->adev->pdev->vendor,
 		 kfd->adev->pdev->device);
