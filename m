Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE94C79FB7
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 05:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB2D210E8C2;
	Thu, 10 Sep 2026 05:46:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N5NajTRI";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62EBF10E8C2
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 05:45:59 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc4ab4fe290so186447a12.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Sep 2026 22:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789019159; x=1789623959; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YkmKEwjSzJzm/ZcQfO9s4H31K3Ko5LXj6dOZ0ec6uns=;
 b=N5NajTRIvweJajMFSrqh6OVXj0H7rFmc+MnUoZAurAWISyS02nTWzQPhS5t4rkfsQg
 +kVsOhMlQXBLuWAvZURv960JZf3zpGxMvoiKLnlSw0s1IS0BqZcsbEE1ODOv1FdHdUMe
 6MhMoHYvX4qSgPe0f3jewgOWqbOop0XmnEu7ON8gfs7v4zLm5fcOOxLb7twCeyVNr/Mt
 ZI/DaqkVy3XNtC2N5bpF4rh0kiUCjTeEOu3U/uy2A6ayDg2y4HObn4ZuI1RvzRrUXuRl
 R2YZYnnbIlkqi1cdybbpXaKiy2NW/RB2HzR72YT26e+DY/azlj/NCL2qyMo/h54gH361
 T+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789019159; x=1789623959;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YkmKEwjSzJzm/ZcQfO9s4H31K3Ko5LXj6dOZ0ec6uns=;
 b=JqTphZhCVSGEbbV1uX81TFpfmEnGHLNy9dr45yLYToKmgXTNCePjcynO4SZ5SbEhHm
 yklFly7+qZC2y8sn2ExZGQs8A1iDbSTHV/UD6bZ1KmrRvNFAvySxjvofbcMMg1bjLt+2
 2lfLSbxv9XhErYwMVCQa7wr4K/5v4W23XaaJLTKlK2/yZZigT18i3ko4K6p+qVegNdoG
 JuGQoXLRvVAd34ktaWPlzrtSvvHErYmKaJdRsjQCKrd8rtxhhiTrwIGWg9d+/jtfKksq
 o/mQi2NTLtI7LMvKsUsUEmyUBZPLOr/EIuC3plDou39v0cG6+/O01/E1W2gSEOWMWRXw
 fcFw==
X-Gm-Message-State: AFuF++kdnDfqpk0kL5/iXn8KjaJOCxSb+ueoHNqeNXNdvPZNGzZiuVWm
 eAlPbjxKXABdgXMhDZY9IknFAb2OS60bmq38iC1HFD8hZEUWTtWVB2g=
X-Gm-Gg: AYBFou1j+GpgVJAy8Cb/4kmbl93ZcDPbzmwxZ5dHYTPnEDqnWCKG2mSklGjCOpLYifP
 rDv1Mxs7tK1hPvL3iCVJLCON/X5HqyV1RM3tm/wF07AUjlq9h5VtW7JhTVdEfU06V2dyXkl6UcX
 rw2K0/MDdAXissXxwRbSL/YqPqSl+yIeHbkK0yU6dAKItvWMDXQBSWmoVugxP1A+XOihVul6g4C
 OE+hiO/xCXjaXCkweVEMD730c6ELRAJneK3loEzVOOc/V6nUmWf9X96lW2JcYCadalNqSly2Vtf
 kvznLkjDYz8YU0DkJ1g1ppksiM1w35FyGfD2GxMZ0BoXJDDeV1nvWz/t+yJ2VccHHcgk2G3476y
 O+jThXNvoBwMEqLqW3+xvqB3xWOfSJ8LvoKLinal0PmrcyiwUV1cj4ifod58zJzUQ4JdTwHFFhm
 xN3JQhAYdA2WabWNh3vnIn9u1YQ4GLt2qt/16pSgt62+ZKjw//clBfuAWufZQiC4hn/kqCVLPeH
 F4DhflL5zyzPSn5aDei0iFW/Q==
X-Received: by 2002:a17:90a:fc47:b0:38e:6d55:b1a6 with SMTP id
 98e67ed59e1d1-39d7799fcc2mr2492773a91.3.1789019158573; 
 Wed, 09 Sep 2026 22:45:58 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA
 ([2001:2d8:7f04:fd2a:f01d:1dc7:1e5:47d8])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d7e77b1afsm2310421a91.5.2026.09.09.22.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 22:45:57 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, donggeunyoo.kernel@gmail.com
Subject: [PATCH] drm/amdgpu: don't release the fence reference consumed by the
 scheduler
Date: Thu, 10 Sep 2026 14:45:51 +0900
Message-ID: <20260910054551.634054-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
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

drm_sched_job_add_dependency() consumes the fence reference in both the
success and the error case. The kernel-doc has said so since commit
ebd5f74255b9 ("drm/sched: Add dependency tracking") added the function,
and sched_main.c does the dma_fence_put() itself when its xa_alloc()
fails.

Three amdgpu callers take an extra reference for the callee and then put
it again when the callee returns an error, dropping a reference they no
longer own. The refcount ends up one short of the number of owners, so a
later put consumes someone else's reference and the fence is freed while
that owner still points at it.

In amdgpu_sync_push_to_job() the fence usually comes from
amdgpu_sync_resv(), which walks a BO's dma_resv and hands each fence to
amdgpu_sync_fence(), where the sync entry takes a reference of its own.
The fence stays installed in that dma_resv, so once the entry's reference
is gone amdgpu_sync_free() eats the reservation object's instead and the
fence is freed underneath a dma_resv that still lists it. The
use-after-free lands in an unrelated thread.

amdgpu_vm_sdma_update() is cross-thread by construction. It walks with
dma_resv_for_each_fence_unlocked(), whose cursor holds exactly one
reference, and the dma_resv_iter_end() on the same error path drops it a
second time.

amdgpu_cs_submit() stays local: the extra put takes the gang member's
scheduled fence to zero, handing the whole drm_sched_fence to call_rcu()
while its finished half is still live.

The extra get is correct at all three sites and stays. Only the put on
the error path is wrong.

Every other drm_sched_job_add_dependency() caller in the tree - etnaviv,
imagination, msm, nouveau, panthor, v3d, xe - hands the reference over
and returns the error untouched, as does
drm_sched_job_add_resv_dependencies() in the scheduler itself.

The trigger is xa_alloc() failing during command submission or a VM
update.

Measured on a Radeon 780M (GC 11.0.1) with a forced -ENOMEM return from
drm_sched_job_add_dependency(), printing the fence's reference count in
amdgpu_sync_push_to_job() on entry, after the failed call, and as the
error is returned:

  unpatched  entry=5 after_call=5 on_return=4
             entry=6 after_call=6 on_return=5
  patched    entry=5 after_call=5 on_return=5
             entry=6 after_call=6 on_return=6

after_call equals entry in both, which is the callee consuming the
reference the caller took for it. Unpatched, the dma_fence_put() that
follows takes it one below where it started, and that reference is the
sync entry's own; patched, there is no put left to make and the count
leaves the function as it arrived.

Fixes: 41cc108b2451 ("drm/amdgpu: fix missing dma_fence_put in error path")
Fixes: ed21f6c3fe42 ("drm/amdgpu: fix another missing fence reference in the CS code")
Fixes: c1c4a8b21721 ("drm/amdgpu: grab extra fence reference for drm_sched_job_add_dependency")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Resent: the original reached lkml but not dri-devel/amd-gfx - I was not
subscribed at the time. Apologies to those seeing it twice.

Tested on a Radeon 780M (GC 11.0.1) running 7.3-rc2 with KASAN, lockdep
and DEBUG_LIST on, driving compute submissions through radeonsi. The
-ENOMEM was forced by a temporary module parameter on gpu-sched that
makes drm_sched_job_add_dependency() fail after N calls, consuming the
fence on the way out exactly as the xa_alloc() failure does; the counts
above come from a probe printed in amdgpu_sync_push_to_job(), with the
unpatched and patched drivers run through the same harness. Neither
produced a KASAN report or a refcount warning: at the point of the extra
put the fence still had four or five other owners, so it is not freed
there. Observing the use-after-free itself needs the stolen reference to
be the last one, which this workload does not arrange.

Only the amdgpu_sync_push_to_job() site is reachable from a plain
compute workload. amdgpu_cs_submit() skips its loop body unless the
submission is a gang of more than one job, and amdgpu_vm_sdma_update()
was not reached; both are fixed here on the same reasoning.

No Cc: stable. I believe this qualifies under
Documentation/process/stable-kernel-rules.rst:19 - it is a use-after-free,
not the theoretical race condition line 27 excludes - but I have not
observed the failure itself, so I am leaving the tag off rather than
claiming more than I measured. No objection if you want to add it.

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c    | 4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 1 -
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 03b41f803520..12ec031c0812 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1303,10 +1303,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 		fence = &p->jobs[i]->base.s_fence->scheduled;
 		dma_fence_get(fence);
 		r = drm_sched_job_add_dependency(&leader->base, fence);
-		if (r) {
-			dma_fence_put(fence);
+		if (r)
 			return r;
-		}
 	}
 
 	if (p->gang_size > 1) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index d6ae9974c952..4f31021b2152 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -447,10 +447,8 @@ int amdgpu_sync_push_to_job(struct amdgpu_sync *sync, struct amdgpu_job *job)
 
 		dma_fence_get(f);
 		r = drm_sched_job_add_dependency(&job->base, f);
-		if (r) {
-			dma_fence_put(f);
+		if (r)
 			return r;
-		}
 	}
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 50cc0779c340..c070c4a032eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -234,7 +234,6 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 		dma_fence_get(fence);
 		r = drm_sched_job_add_dependency(&p->job->base, fence);
 		if (r) {
-			dma_fence_put(fence);
 			dma_resv_iter_end(&cursor);
 			return r;
 		}
-- 
2.53.0

