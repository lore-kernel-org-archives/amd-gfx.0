Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9F6CA5FDD
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Oct 2026 06:38:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1E5B10E750;
	Sat,  3 Oct 2026 06:38:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MNNVxsDP";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0566A10E750
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Oct 2026 06:38:22 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-4a003bd18e5so2430105e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Oct 2026 23:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791009501; x=1791614301; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/EGDVj/JX49MDewUpmkRIx4iJb4U7DfFprD/EuooNYI=;
 b=MNNVxsDPpOyxB6dg31nPcYvrA39kt+W/H+t+o/nW/28xem8M/Tfo4p71JCJx1FeQIK
 Y/NCJ+Cp71C4A9qpBPJcuTnqI37CnqTErSxbS43Wtq227tAnIMtEa/7Vzxnz/gYZZzQ5
 yMDcps2or4c/pM9VRud9D7XWMw7S8jZ2duJBxvodoQ3Xd//mxgEmsYx1d1cUwWT/+0bh
 0Cd84wLchoQF4bcgkyFviBieO8mvjXKUVxoghar56un8911CxSCn8f4BdAe0tGP2YgZR
 V8ZnUOOCoObiIU7ag6tXfNWaGIYSQYWGqi0gvdyiYhwM19GtMk5fjDxgQ1Yo/80LcaIo
 2Axg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791009501; x=1791614301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/EGDVj/JX49MDewUpmkRIx4iJb4U7DfFprD/EuooNYI=;
 b=LFcVLxzoIi16EPp/XPVNBT021MEjCO164CQT7OG2jCSOM8E5MZGsZw7yGPpoK0Sf/r
 Xyzl8DX6TYdrBWkrFKCj92iJVLCdFVhMo08YuAwiHC8z9KwtA+gChhijdsDEcJqeuPSm
 Pm796203i4s7Y2VH+Vl4JO4fbHwdo4ygfJIxoSjzETYaXJiUw6R6qtinwm5W/E9iyv06
 2JuWf/SY3peCapIeDHRRZEsQg51kSsmZRLRm6JAN5EHE6exLfsE8T/dUdli+KYsBie4i
 C+tBzOuuIvcQpnEDbSnOgbi3D/VF5t6G7PhILhjssN9mWHetRA126a7mH3YTthgtuFBT
 qX0w==
X-Gm-Message-State: AFuF++l8zSAQWVHEEXL4LLJTIAMt4LekUII/RbZmwJwRQ3sEv454jd56
 v4T2RTIKRbQHxIIzJfln3hvhEihWuXa0HftOo+vb36nvePNjgY/dJQA8XO9QAA==
X-Gm-Gg: AYBFou2JgTb/3QtiVJSFCszKYw9wzyGtvpYBUcpRmqiNcOFiItQD2fMo75DuY0PJv9f
 njL/4c9a4Yvp9gl5xrnqW7uL2SL7HvRSNFMti7kKO7KUlE1tcIUH9O1M5LICVqA40AbeG/+Qay1
 J/rWGN5W2YP7bEJp6Mr/YGFzve52hxPyrOrpWkWVz0bFx6tec0GD6m05c48T4e/FAja0P65hw3Y
 Qj7V/IJPDXzeFLk7DZytp6YFBcpoNeGeWHPRB6pB/jalbzlLSUK0CO1D8lTaHwsp8Ekzljwcltq
 xaK5rXaJLTjpW7KFwSOBmuoiFtqBCB3wm/w2DkoK2BkDbWVZlXz5Tlm1rbEvOnvi8Rmc4+Sc6iS
 PPV9cYQd1CzivDd8ejyRTerEcMftimjJBLCNXwKVqBm2syDIYYKWB0VQ699QG48rYyx15/fYqAH
 zyImhIkuDSuf+FAIe6uwvtO/3kZeVvqjmSE3I4/8K0tHE+AmpCOi0WFUnOT6iJRcgyYmTZXw5dx
 ZPVVCleY5NExIb6gJ0WlAmWIJJye6mH2SHjJAaL2HZqdDUCt5CjXWoSHukZaIFa47pn1BOM7sd9
 illZwmA0KDDL+n691BEvEp5ynncys1lTzPmXQIU7UzA1USzhkFp5LvUOPwqjJs78CbeaQtiXmyz
 BWtXB7Faur/2/i8CexJUzCozHqlOgHpfmt3lw5yXL2TkzYdUYfM9kxKHxakUgPYo1aH8LgCi1cG
 Ozkts9dPTSUBvSp+g=
X-Received: by 2002:a05:600c:3e07:b0:49f:df99:ff1a with SMTP id
 5b1f17b1804b1-4a02759770dmr79699845e9.17.1791009500990; 
 Fri, 02 Oct 2026 23:38:20 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:416e:c95d:c72:8d01:9941:d6d0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027735be1sm200215285e9.11.2026.10.02.23.38.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 Oct 2026 23:38:20 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: xiaogang.chen@amd.com, felix.kuehling@amd.com, christian.koenig@amd.com,
 alexander.deucher@amd.com, Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Subject: [PATCH 2/2] drm/amdkfd: stop userptr restore retries on device unplug
Date: Sat,  3 Oct 2026 08:38:17 +0200
Message-ID: <20261003063817.36606-3-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261003063817.36606-1-olivier.kaloudoff@gmail.com>
References: <20261003063817.36606-1-olivier.kaloudoff@gmail.com>
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
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 22 ++++++++++++++-----
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index d668816..6c040ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2827,6 +2827,7 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 	struct task_struct *usertask;
 	struct mm_struct *mm;
 	uint32_t evicted_bos;
+	int ret = 0;
 
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
@@ -2886,11 +2889,18 @@ unlock_out:
 
 	/* If validation failed, reschedule another attempt */
 	if (evicted_bos) {
-		queue_delayed_work(system_freezable_wq,
-			&process_info->restore_userptr_work,
-			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
+		if (ret == -ENODEV) {
+			/* Device is gone for good, stop retrying */
+			pr_warn_once("%s: device unplugged, aborting userptr restore (pid %d, %s)\n",
+				     __func__, pid_nr(process_info->pid),
+				     usertask->comm);
+		} else {
+			queue_delayed_work(system_freezable_wq,
+				&process_info->restore_userptr_work,
+				msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
 
-		kfd_smi_event_queue_restore_rescheduled(mm);
+			kfd_smi_event_queue_restore_rescheduled(mm);
+		}
 	}
 	mmput(mm);
 	put_task_struct(usertask);
-- 
2.54.0 (Apple Git-157)

