Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F9CCA5FFC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 18:02:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE15F10E78F;
	Tue,  6 Oct 2026 18:02:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aNMOTmQ9";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA82810E3BA
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 18:02:47 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso628500f8f.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Oct 2026 11:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791309766; x=1791914566; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nER9q+oVz+Q8+kmLfgKEf4UYLpDDAdm7eNmqrrqqDPQ=;
 b=aNMOTmQ9LPh63qWRtC3GVlYj0wZ8EQD6/Uo4Kga9kQ8l4pwppN5vHYyd2udtJ7X3jh
 gIwE0vsljQx9tZIwNzAGm/t8sbOVD8o4p4t1IZEpK/9P2TQ8gLlaYHOMvE1cSr+d2he8
 FWRjSe0W+WWgzWZeiVFZ3aMN7HiVoC9gQODgnhQquxKgPXdmdhz+ZW6vXSg54JwJu+d7
 D1QEAxmmO0L2d4h3Gl7n+qhqyNi+2iivDKryS+l0czKJ/ZRpzj4GUty3KfG8fOXPuHpl
 IVqHulugmrRDM2udhdEef7CkFeGf+CEY24WhKsHqDuD+1LdNfC4t0CFJm/Mjg+HA4gGq
 tszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791309766; x=1791914566;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nER9q+oVz+Q8+kmLfgKEf4UYLpDDAdm7eNmqrrqqDPQ=;
 b=gi1RsW8qe6FssYcrvaOXke77XUyLzYHZYevM2mdPb7Pvkvq+/I1E+pwQDQ9SI26wtu
 LG1Ok0GoUH/w/vCakh4M4+AyPnQkM8vEiAKeZl1Vaf85V/17U0SBJHniMMnOIPN114+/
 aP/jJWLtoo4PeZNk/Zm7OhuijpDYlS61Ro5lyLaBLYHrecVSHyqDD6fpxC16vP876aO5
 FDaRd6YWMXs7me6E8YQPxxqTuU0VeLDxj8N+R18vE7Kx7R4Ffoop89liQssNEjc0M3dK
 3oY/ejDAlvkzLIHGxSAeXtzBHI/ybhLLbkQ609B1o54h0598nxM6o2qHm5Ve9ECyKM6b
 HAwQ==
X-Gm-Message-State: AFq9FYKbG7qolz6QRcyrnxK5OTzaqEH54/4B9K6LfZVMeerFumMt8xF+
 a/9U/1ZDWgbsQ8xB3cqbiIil031cHM+vhgExfaeN+leKHDNjbo72ltrk/GzVmw==
X-Gm-Gg: AYBFou39Irogfk0fNHlbo68kFp7NPXAm/WlJ96EZRVOdZ+pVaf+yJGlswszbwf2NTDX
 MLc6QWhF4iStDCBIn5/HFehQrJxLq9vaj97EnaZx/bIBsbjArWIWsMVvkOD+2c18d+wLzG/qO3n
 JGzpLQVahYxeFtnyYovj2dhxo8NyzLGXgkpaWKGHPf/V4SLya7GXpYLP+Q4xVLsK56pq6lgj4z2
 5e+ztLONeUa0VMVwbHkFpc0iVRSONwT6Urt9R4LsNR+CCwubdFrOEhVXvd/RcWCPEMXLVliM/wT
 nOsBlEnSbLyyiQApsBqU6WIpYWAUUovcaWgdB1v26AsMMUC50lso9+Cci/1yc+2iOwEQZMm+ahz
 yeNU8afKosl1F0yIXeq+mmNXxHrenjO9ir6FUhsEVVBKZWOLzJt0kfH/hGG0psb2I3R0n+dcLJx
 xE5/XJ4FbMEB/263MeBAX+X3TMCGBkH2YGZG2UXldJCrWzcoZurxQ6vmkhK41KDxayf12aiaFN1
 EL6ZMr10zKQslQyY2UAOUA/Kpjmc4o2H0EpWauWXFejNUidUtA+jzR4VhNbuZ/Uf7aVhfLP5jh2
 MUJRdKYkWSiLdzT6VWDmPWr6I5dS3Zp6L6Pf5a8lDeF9vMn/FE7F5qA+gWrvkOoPhmXYmnjf+dy
 jQVBBprd17Xo1DQc3Ogk0G5RQiTaj+Chf31CwqD5HtlubCv4xqb6RdfcK4GcUFvhgeJexOkffPv
 mD9k8fLEFdqW1Dbj4=
X-Received: by 2002:a05:6000:41d9:b0:488:8525:4985 with SMTP id
 ffacd0b85a97d-48c727869ebmr426608f8f.24.1791309766257; 
 Tue, 06 Oct 2026 11:02:46 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:41ef:ba36:bd76:1e3c:1e5:c273])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d1f3f7sm813630f8f.32.2026.10.06.11.02.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Oct 2026 11:02:46 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH v3 2/3] drm/amdkfd: stop userptr restore retries on device
 unplug
Date: Tue,  6 Oct 2026 20:02:41 +0200
Message-ID: <20261006180242.52809-3-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261006180242.52809-1-olivier.kaloudoff@gmail.com>
References: <20261006180242.52809-1-olivier.kaloudoff@gmail.com>
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

amdgpu_amdkfd_restore_userptr_worker() reschedules itself every
AMDGPU_USERPTR_RESTORE_DELAY_MS whenever validation of invalidated
userptr BOs fails. On PCIe surprise removal the VM update paths
already fail fast: amdgpu_vm_update_pdes() and amdgpu_vm_update_range()
return -ENODEV when drm_dev_enter() fails, which propagates up through
process_update_pds()/update_gpuvm_pte()/validate_invalid_user_pages().
The worker ignores the error code and reschedules unconditionally,
producing an endless retry loop on a device that is permanently gone.

Observed on MI50 eGPU TB3 surprise removal: ~11k rescheduled restore
cycles, the worker holding reclaim-related locks until the system
soft-locked up.

Stop rescheduling when the validation failure is -ENODEV: the device
is gone for good and the affected processes are being torn down
anyway. Other errors keep the existing retry behavior, as they may be
transient.

Cc: Xiaogang Chen <xiaogang.chen@amd.com>
Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
---
Changes in v3: resubmission, unchanged from the v2 already posted.

Changes in v2:
- Don't pre-initialize ret; every path to the reschedule check is
  dominated by an assignment (Christian König)
- Drop the pr_warn_once; hot removal is a normal abort condition for
  the worker (Christian König)
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index d668816..dc94d32 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2827,6 +2827,7 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 	struct task_struct *usertask;
 	struct mm_struct *mm;
 	uint32_t evicted_bos;
+	int ret;
 
 	mutex_lock(&process_info->notifier_lock);
 	evicted_bos = process_info->evicted_bos;
@@ -2846,14 +2847,16 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 
 	mutex_lock(&process_info->lock);
 
-	if (update_invalid_user_pages(process_info, mm))
+	ret = update_invalid_user_pages(process_info, mm);
+	if (ret)
 		goto unlock_out;
 	/* userptr_inval_list can be empty if all evicted userptr BOs
 	 * have been freed. In that case there is nothing to validate
 	 * and we can just restart the queues.
 	 */
 	if (!list_empty(&process_info->userptr_inval_list)) {
-		if (validate_invalid_user_pages(process_info))
+		ret = validate_invalid_user_pages(process_info);
+		if (ret)
 			goto unlock_out;
 	}
 	/* Final check for concurrent evicton and atomic update. If
@@ -2885,7 +2888,7 @@ unlock_out:
 	mutex_unlock(&process_info->lock);
 
 	/* If validation failed, reschedule another attempt */
-	if (evicted_bos) {
+	if (evicted_bos && ret != -ENODEV) {
 		queue_delayed_work(system_freezable_wq,
 			&process_info->restore_userptr_work,
 			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
-- 
2.47.3

