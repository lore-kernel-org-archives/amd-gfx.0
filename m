Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93E1CA5FFC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 18:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB7CF10F733;
	Wed,  7 Oct 2026 18:09:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G1+WTvTI";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E56110E02B
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 18:09:15 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a02718da81so17720765e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2026 11:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791396553; x=1792001353; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ztb8Y6wumQTVuBYcZRHZu1vdynWoho89NtzZ0FG62lU=;
 b=G1+WTvTIkDkT7bwmjTP1keGFpdrhoEJPr/LGsYV/EbouD/6HBJ2zoK4ToOb/DZdWtP
 p1DoHIi/Lhsfq1B9xhslNwAy4MVoum3Xv3HbbzzAStUGUGvIUxlakBdbaFF6CuXmYMSI
 ME9GYWTEFP+QU1t12LKN2gLFBPP7bTy4ZWfjG60qCQAap0/xSS1U8s1K8hICbCriz6Oo
 pUpsXdWnfu6iuLgOY7Ft/+6AE39iRVWGnIZEW+5PvtQWRac4LeXRtYx256o/7RWyst64
 YX+Jkq98lS8K0J930PoLg3Su1IpOkw0isNtF8eMP9qgA5Pj5oF9C0Ihmx1U1fkuz9n2q
 PTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791396553; x=1792001353;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ztb8Y6wumQTVuBYcZRHZu1vdynWoho89NtzZ0FG62lU=;
 b=fYJUrhcN6Kp4XAbIkhzTNrBd0Yj5aGuSWibx2QBeTzbXYyS/JBj+nCX/TJ48bTqDue
 UMfSCpWSM7jsOyki4MAKjmidb0D/qz0QzFSAI8K4ZFFK2mb1Wn8wQlR/kpeutJDwhy5d
 qVFT7YiTbevnYiT9Mag4TVPjC5U7creiZcCibpSE/Z3FdFOkIgacEuWg2Vd9FoHRq3J/
 C8gAb/18FkhHVUfqNUJyDXKEqrNHztQZJJZPUB/rgWhl66aPmpQi9DILPtUCQzS9YoBe
 RMLBNAIIJ35lV9F5vecKf5qVoXEv5ZpzH/XhYbRvZlo5gb4QE+siBoUI2rbvyvT83xM4
 it+A==
X-Gm-Message-State: AFuF++lwVN4KxDLH872577dvt1CKjkV9mQeYjfyFT2eeTQzFFY91Ic4W
 fB5L1dYr9xfsaP63n4DBT2svS1DZXqrKFqIhIA4w9vPASXGW1atxMqbahXOpGDtU
X-Gm-Gg: AYBFou1AvxfziLlv77KU9rTfAdWAoDlNM2nGrrfe4w5VSfHnQXeS/O5LIoQNmHC5FWM
 BD41WBCK3VzTIRC03sWQjQHi8+28X55I4l4N8YXFBt0wrKeuaHVeulP3vqmQJ48whRKgGhIrFZt
 jkBA0qTaXXZYC8tmgdIhUCet61nyL9PhkYQYfzKP8o1TvL3VZBJ5kGNgz+Q3ubdgQGwgznDGmSI
 a9wtHWjUy5Mt68G8+OLqidd5QBlDqb2jrjfRD8r19uovAFohue6LKRP5IZgl0uB8J2AAQmz5vU8
 OJdqqS9EZi2KtTSKnQxetFyW3DgzP9Yd1p4cN/I40kbcMLQrnvcSJ1AhqXCAgDFc2GeOPcmbNmb
 nFRRDUYhf+2FQIBiLHOQwgsOXqPBnUTKSfsf3QvwcdQ7aIjYz/Tu04rEYGnCYQBwafalhVpL9Vw
 cTJfP0/TahD3b/qZaPdVeCK/As8TLtjZ7zwt1JopADyR6tCeU3aCsUbWSBLGqeKc3UTjQbYHtbE
 UmlzoRM24X5/Fh7NlnCQ7p8ZtS+7oaLOy7zzPINGIE0PxQ+ESkNTUStOLt2303QiMDTEMSPUY9p
 QVuEQtVbjEjp5yJpmH/FQK7PGpYyIu6kBQaePZD6O+seuToTEKVJL30h5oeuMus6K2/LH1XfvLj
 aXH92rqBBB8KAREZAyZow7fpQR/pbTzn3ZchzxPttfGVQD4pqZTCB523xBdfPr3MmgpC2ZEvFO1
 vu5gsXzu7GCqA+euQ=
X-Received: by 2002:a05:600c:4e43:b0:4a0:2391:6529 with SMTP id
 5b1f17b1804b1-4a180455415mr49625975e9.29.1791396553319; 
 Wed, 07 Oct 2026 11:09:13 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:e487:413e:676b:9d85:c07d:dc5e:c7c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a181aeaea2sm59416855e9.5.2026.10.07.11.09.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 11:09:13 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: xiaogang.chen@amd.com, Felix.Kuehling@amd.com, christian.koenig@amd.com,
 alexander.deucher@amd.com, Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Subject: [PATCH v4 2/3] drm/amdkfd: stop restore retries on device unplug
Date: Wed,  7 Oct 2026 20:09:08 +0200
Message-ID: <20261007180909.34013-3-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261007180909.34013-1-olivier.kaloudoff@gmail.com>
References: <20261007180909.34013-1-olivier.kaloudoff@gmail.com>
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
userptr BOs fails, and svm_range_restore_work() likewise reschedules
itself every AMDGPU_SVM_RANGE_RESTORE_DELAY_MS when range validation
fails. On PCIe surprise removal the underlying update/migration paths
fail fast with -ENODEV (amdgpu_vm_update_pdes() and
amdgpu_vm_update_range() return -ENODEV when drm_dev_enter() fails,
which propagates up through validate_invalid_user_pages(); the SVM
validation paths get -ENODEV once the migration paths check for a
gone device, see patch 3). Both workers ignore the error code and
reschedule unconditionally, producing endless retry loops on a device
that is permanently gone. The worker cancel in the teardown paths only
runs at last-VM/process destroy, which itself can be delayed
arbitrarily on unplug.

Observed on MI50 eGPU TB3 surprise removal: ~11k rescheduled userptr
restore cycles, the worker holding reclaim-related locks until the
system soft-locked up.

Stop rescheduling when the failure is -ENODEV: the device is gone for
good and the affected processes are being torn down anyway. Other
errors keep the existing retry behavior, as they may be transient.

Cc: Xiaogang Chen <xiaogang.chen@amd.com>
Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
---
Changes in v4:
- also stop the svm_range_restore_work() retries on -ENODEV (moved
  from patch 3, per Felix Kuehling)
- assign ret on the evicted_bos-mismatch and confirm_valid_user_pages
  paths: posted v2 read ret uninitialized on those two paths before
  the reschedule check
- retitle to cover both restore workers

Changes in v3: resubmission, unchanged from the v2 already posted.

Changes in v2:
- Don't pre-initialize ret; every path to the reschedule check is
  dominated by an assignment (Christian König)
- Drop the pr_warn_once; hot removal is a normal abort condition for
  the worker (Christian König)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index d668816..2ad6777 100644
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
@@ -2862,11 +2865,14 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 	 * reference counting inside KFD will handle this case.
 	 */
 	mutex_lock(&process_info->notifier_lock);
-	if (process_info->evicted_bos != evicted_bos)
+	if (process_info->evicted_bos != evicted_bos) {
+		ret = -EAGAIN;
 		goto unlock_notifier_out;
+	}
 
 	if (confirm_valid_user_pages_locked(process_info)) {
 		WARN(1, "User pages unexpectedly invalid");
+		ret = -EINVAL;
 		goto unlock_notifier_out;
 	}
 
@@ -2884,8 +2890,10 @@ unlock_notifier_out:
 unlock_out:
 	mutex_unlock(&process_info->lock);
 
-	/* If validation failed, reschedule another attempt */
-	if (evicted_bos) {
+	/* If validation failed, reschedule another attempt, unless the
+	 * device is gone for good
+	 */
+	if (evicted_bos && ret != -ENODEV) {
 		queue_delayed_work(system_freezable_wq,
 			&process_info->restore_userptr_work,
 			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index fa4054d..3dab456 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2013,8 +2013,10 @@ out_reschedule:
 	mmap_write_unlock(mm);
 	mutex_unlock(&process_info->lock);
 
-	/* If validation failed, reschedule another attempt */
-	if (evicted_ranges) {
+	/* If validation failed, reschedule another attempt, unless the
+	 * device is gone for good
+	 */
+	if (evicted_ranges && r != -ENODEV) {
 		pr_debug("reschedule to restore svm range\n");
 		queue_delayed_work(system_freezable_wq, &svms->restore_work,
 			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
