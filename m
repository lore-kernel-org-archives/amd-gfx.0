Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22340E77199
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 08:56:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C360310E817;
	Wed,  8 Jan 2025 08:56:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ySnGA+tY";
	dkim-atps=neutral
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 548D310E817
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 08:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736326578; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=Jx5PzYEjmdUeWX/zhNSxJrKq906S64oP7fUHHUBatho=;
 b=ySnGA+tYZptQUHFRdB4h6xb9KeP1BaMocM1aWUZtF4hD/2baXDvvoQ7LOQMaT6oFvu0J34H9N/Tl7NAZMFmJhAo5cjYa+eXkj3tvTQi/cmfRcAo4HSFAu/T3cbBZ62PqgBUkTDA3mHVWPAeBg1BQzpdZ3zUg1vrT/GkQNpXS47M=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNDU-xx_1736326578 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 08 Jan 2025 16:56:18 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 Jun.Ma2@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [v3 6/6] drm/amdgpu: get rid of false warnings caused by
 amdgpu_irq_put()
Date: Wed,  8 Jan 2025 16:56:04 +0800
Message-ID: <55f6e8e3d14c639d869a76adae932075b443685e.1736325561.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1736325561.git.gerry@linux.alibaba.com>
References: <cover.1736325561.git.gerry@linux.alibaba.com>
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

If error happens before amdgpu_fence_driver_hw_init() gets called during
device probe, it will trigger a false warning in amdgpu_irq_put() as
below:
[ 1209.300996] ------------[ cut here ]------------
[ 1209.301061] WARNING: CPU: 48 PID: 293 at /tmp/amd.Rc9jFrl7/amd/amdgpu/amdgpu_irq.c:633 amdgpu_irq_put+0x45/0x70 [amdgpu]
[ 1209.301062] Modules linked in: ...
[ 1209.301093] CPU: 48 PID: 293 Comm: kworker/48:1 Kdump: loaded Tainted: G        W  OE     5.10.134-17.2.al8.x86_64 #1
[ 1209.301094] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
[ 1209.301095] Workqueue: events work_for_cpu_fn
[ 1209.301159] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu]
[ 1209.301160] Code: 48 8b 4e 10 48 83 39 00 74 2c 89 d1 48 8d 04 88 8b 08 85 c9 74 14 f0 ff 08 b8 00 00 00 00 74 05 c3 cc cc cc cc e9 8b fd ff ff <0f> 0b b8 ea ff ff ff c3 cc cc cc cc b8 ea ff ff ff c3 cc cc cc cc
[ 1209.301162] RSP: 0018:ffffb08a99c8fd88 EFLAGS: 00010246
[ 1209.301162] RAX: ffff9efe1bcbf500 RBX: ffff9efe1cc3e400 RCX: 0000000000000000
[ 1209.301163] RDX: 0000000000000000 RSI: ffff9efe1cc3b108 RDI: ffff9efe1cc00000
[ 1209.301163] RBP: ffff9efe1cc10818 R08: 0000000000000001 R09: 000000000000000d
[ 1209.301164] R10: ffffb08a99c8fb48 R11: ffffffffa2068018 R12: ffff9efe1cc109d0
[ 1209.301164] R13: ffff9efe1cc00010 R14: ffff9efe1cc00000 R15: ffff9efe1cc3b108
[ 1209.301165] FS:  0000000000000000(0000) GS:ffff9ff9fce00000(0000) knlGS:0000000000000000
[ 1209.301165] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1209.301165] CR2: 00007fd0f6e860d0 CR3: 0000010092baa003 CR4: 0000000002770ee0
[ 1209.301166] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1209.301166] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[ 1209.301167] PKRU: 55555554
[ 1209.301167] Call Trace:
[ 1209.301225]  amdgpu_fence_driver_hw_fini+0xda/0x110 [amdgpu]
[ 1209.301284]  amdgpu_device_fini_hw+0xaf/0x200 [amdgpu]
[ 1209.301342]  amdgpu_driver_load_kms+0x7f/0xc0 [amdgpu]
[ 1209.301400]  amdgpu_pci_probe+0x1cd/0x4a0 [amdgpu]
[ 1209.301401]  local_pci_probe+0x40/0xa0
[ 1209.301402]  work_for_cpu_fn+0x13/0x20
[ 1209.301403]  process_one_work+0x1ad/0x380
[ 1209.301404]  worker_thread+0x1c8/0x310
[ 1209.301405]  ? process_one_work+0x380/0x380
[ 1209.301406]  kthread+0x118/0x140
[ 1209.301407]  ? __kthread_bind_mask+0x60/0x60
[ 1209.301408]  ret_from_fork+0x1f/0x30
[ 1209.301410] ---[ end trace 733f120fe2ab13e5 ]---
[ 1209.301418] ------------[ cut here ]------------

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 9 +++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index b5e87b515139..0e41a535e05f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -614,9 +614,11 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
 
 		if (!drm_dev_is_unplugged(adev_to_drm(adev)) &&
 		    ring->fence_drv.irq_src &&
-		    amdgpu_fence_need_ring_interrupt_restore(ring))
+		    ring->fence_drv.irq_enabled) {
 			amdgpu_irq_put(adev, ring->fence_drv.irq_src,
 				       ring->fence_drv.irq_type);
+		        ring->fence_drv.irq_enabled = false;
+		}
 
 		del_timer_sync(&ring->fence_drv.fallback_timer);
 	}
@@ -693,9 +695,12 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
 
 		/* enable the interrupt */
 		if (ring->fence_drv.irq_src &&
-		    amdgpu_fence_need_ring_interrupt_restore(ring))
+		    !ring->fence_drv.irq_enabled &&
+		    amdgpu_fence_need_ring_interrupt_restore(ring)) {
 			amdgpu_irq_get(adev, ring->fence_drv.irq_src,
 				       ring->fence_drv.irq_type);
+		        ring->fence_drv.irq_enabled = true;
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index dee5a1b4e572..959d474a0516 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -118,6 +118,7 @@ struct amdgpu_fence_driver {
 	uint32_t			sync_seq;
 	atomic_t			last_seq;
 	bool				initialized;
+	bool				irq_enabled;
 	struct amdgpu_irq_src		*irq_src;
 	unsigned			irq_type;
 	struct timer_list		fallback_timer;
-- 
2.43.5

