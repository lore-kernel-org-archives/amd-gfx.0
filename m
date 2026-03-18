Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB18FCD0C5
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 07:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D489010E6A4;
	Wed, 18 Mar 2026 07:47:21 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8002310E6A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 07:47:20 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 62I7lAmf2078561; Wed, 18 Mar 2026 13:17:10 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 62I7l9qW2078554;
 Wed, 18 Mar 2026 13:17:09 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argument
 validation"
Date: Wed, 18 Mar 2026 13:17:08 +0530
Message-Id: <20260318074708.2078535-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
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

This reverts commit 0cdff8eb31c139dde4716e4aa37198c16364629e.

The patch has caused regression for userqueues where user is stuck
and is waiting for fences and a gpu reset is triggered in kernel.
Also for any of the parameters when count is zero, the driver does
not read from the pointer and having that check is overkill.

Application:
MESA: error: amdgpu: getting wait num_fences failed
MESA: error: amdgpu: getting wait fences failed
MESA: error: amdgpu: getting wait num_fences failed
MESA: error: amdgpu: getting wait fences failed

Dmesg:
[  122.668493] amdgpu 0000:0a:00.0: sq_intr: error, detail 0x00000000, type 1, sh 1, priv 0, wave_id 0, simd_id 0, wgp_id 0
[  122.668504] amdgpu 0000:0a:00.0: sq_intr: error, detail 0x00000000, type 1, sh 1, priv 0, wave_id 0, simd_id 0, wgp_id 0
[  124.687518] amdgpu 0000:0a:00.0: Dumping IP State
[  124.688351] amdgpu 0000:0a:00.0: Dumping IP State Completed
[  124.688355] amdgpu 0000:0a:00.0: [drm] AMDGPU device coredump file has been created
[  124.688357] amdgpu 0000:0a:00.0: [drm] Check your /sys/class/drm/card0/device/devcoredump/data
[  124.688361] amdgpu 0000:0a:00.0: ring gfx_0.0.0 timeout, signaled seq=569, emitted seq=571
[  124.688366] amdgpu 0000:0a:00.0:  Process Xwayland pid 3471 thread Xwayland:cs0 pid 3479
[  124.688369] amdgpu 0000:0a:00.0: Starting gfx_0.0.0 ring reset
[  126.560451] amdgpu 0000:0a:00.0: MES(0) failed to respond to msg=RESET
[  126.560456] amdgpu 0000:0a:00.0: failed to detect and reset
[  126.560460] amdgpu 0000:0a:00.0: Failed to detect and reset queues, err (-110)
[  128.789840] amdgpu 0000:0a:00.0: Ring gfx_0.0.0 reset failed
[  128.789848] amdgpu 0000:0a:00.0: GPU reset begin!. Source:  1
[  128.790161] amdgpu 0000:0a:00.0: Guilty job already signaled, skipping HW reset
[  128.790174] amdgpu 0000:0a:00.0: GPU reset(1) succeeded!
[  128.804538] amdgpu 0000:0a:00.0: [drm] device wedged, but recovered through reset
[  128.804574] amdgpu 0000:0a:00.0: GPU reset begin!. Source:  6
[  128.816663] amdgpu 0000:0a:00.0: Dumping IP State
[  128.817458] amdgpu 0000:0a:00.0: Dumping IP State Completed
[  130.963939] amdgpu 0000:0a:00.0: MES(1) failed to respond to msg=REMOVE_QUEUE
[  130.963949] amdgpu 0000:0a:00.0: failed to unmap legacy queue

Cc: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 29 -------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 3fcd70a38374..0d9a13081f2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -484,16 +484,6 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	    args->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
 		return -EINVAL;
 
-	/* Reject non-NULL pointers paired with a zero count. */
-	if (!args->num_syncobj_handles && args->syncobj_handles)
-		return -EINVAL;
-
-	if (!args->num_bo_read_handles && args->bo_read_handles)
-		return -EINVAL;
-
-	if (!args->num_bo_write_handles && args->bo_write_handles)
-		return -EINVAL;
-
 	num_syncobj_handles = args->num_syncobj_handles;
 	syncobj_handles = memdup_array_user(u64_to_user_ptr(args->syncobj_handles),
 					    num_syncobj_handles, sizeof(u32));
@@ -950,25 +940,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	    wait_info->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
 		return -EINVAL;
 
-	/* Reject non-NULL pointers paired with a zero count: the pointer
-	 * is meaningless and indicates inconsistent input from userspace.
-	 */
-	if (!wait_info->num_syncobj_handles && wait_info->syncobj_handles)
-		return -EINVAL;
-
-	if (!wait_info->num_syncobj_timeline_handles &&
-	    (wait_info->syncobj_timeline_handles || wait_info->syncobj_timeline_points))
-		return -EINVAL;
-
-	if (!wait_info->num_bo_read_handles && wait_info->bo_read_handles)
-		return -EINVAL;
-
-	if (!wait_info->num_bo_write_handles && wait_info->bo_write_handles)
-		return -EINVAL;
-
-	if (!wait_info->num_fences && wait_info->out_fences)
-		return -EINVAL;
-
 	num_syncobj = wait_info->num_syncobj_handles;
 	ptr = u64_to_user_ptr(wait_info->syncobj_handles);
 	syncobj_handles = memdup_array_user(ptr, num_syncobj, sizeof(u32));
-- 
2.34.1

