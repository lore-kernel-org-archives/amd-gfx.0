Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA431CC6B1D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 12:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2154410FD7E;
	Wed, 14 Oct 2026 12:47:48 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6740110E9AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 18:53:20 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso2387135f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791917598; x=1792522398; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HLD9iVIZ163U9jFvBO1ehanu99qPbM6uZlGnS0s+nMg=;
 b=iXHlqU3poAAUm/IlGvBGN9UC0MYm1fyKfhrHhiXAFme0/iMaxRP6ucMacytRpD6blq
 Smzz3THJMysLP+ck7grwXlPCQOvtzNlXefH9xPJG5W0MYfvoc8LkSzxKnDISa09OjJy8
 pZDmrZ0x6mM+5vvJOAKsWhfOkn8epOXvDcb3/Eh4yPYYdYTFXm/RQXMVWh6+OFhu0fxY
 W7N685EU2fhRdrxYPvxWM5p7uh2/RXq0GX9Z7djXwdaehW9x/FHo78OJ/OzccXjBbH9o
 z/e8LTx3DL9xnO2shfQchuQ2aGIRndVkaLbV7+EYhNcsLfE56ShN2L0sWrnLl/sdDQ3W
 L5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791917598; x=1792522398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HLD9iVIZ163U9jFvBO1ehanu99qPbM6uZlGnS0s+nMg=;
 b=yVu9bpx4Vc7G8BdwNS6qtC5xmCC6VsMDnAwGMJXgpgwOoUvNzKDNCzZbHtL6HxPeWv
 AzrbVzMb485AHHGSnb/Tgn+nbD7Yh0LCH6ajCmYXHtgPbeNpK/u60m4PshLsv0wwB5Wg
 jxIOVDzB8OusYY1H1ZLDpdb5e3tMVqRdIIcHqboQy26GynwucqOeTgF4/81Mekr9J/30
 cSY5arkXpL6Jdh/j6tFsS71mCzzf36OxfoDSsKqlDF5HgQkBDz9OoWmy8uh0amLkNsHG
 g43ysXS62VWjGq7XYstr1KR8qozM4A/LA8Sx7c8Spx46VAbxBBb6p7DSLRLGqoxAwPDk
 fysQ==
X-Gm-Message-State: AFq9FYI0R5n3xRKn3pM0lc7iZAeG8YLLqxBUsnf9QT3J2xjmPp+6Es1t
 0FfDDXIrcwrHpSK49ADM3Qbi2B20tsAfSngAVtgA2wWsv6mCEcPK0BZ701sPFA==
X-Gm-Gg: AYBFou2d65slct4dO4qgsprDXSlez8ITIEVMrME3C3nPe5Xh2ZEDm/iEi0wj0ki8f1n
 88j19DLmHBOmlbbkasbsLQ6SJjYZnCWvLveYKl1Lz/a1PfgS1XqylX45w6SK0UKPlfZNteXG3Ry
 q1HIs1BBZ3sMzxCmE9ydhHJPuogIez510WBMKGYyaBLGl2BkAxcAkkyzUJLiwjWDc/rmESomBs3
 pE6kJ7YNj5N8l8DcEMprg1b0tSTON9CrgpsAt6++fDS+97hdouI9FL1g9agB6AXStJO+Uby/BXX
 sWfpEIFeccGV99NPxbCPeF6mGBIOnz9izl2px9Z3pGq0kiIwyFn9HNaNVMyZigcDLpEX2zyWeDQ
 YI2Odze9uvjlJ1ouCw5MWSnPDXrIDx5izZrWSqAL4WKvcGSwq5AYru6eOU44+1CDfJbc0I+Lk9K
 C3ncQOxnoaDiCE4CvcI2rlzD803voPO4Ju5aCpYpYPj6enX0iQFeh/3GHSqem3m8Bpn7Zo3LJKa
 /pC/Y8GjzeBr5BLLJeHVMWfPPD7jp+g21+nk0+dyelH6nhwQHaK3WRnTKuuvIWZ9mBpBSunM2yr
 dLGZLXGVrmAnAVzV4/kAxACXCdKfwRRrm5QOAVvQw0LzO21fJh9gEU3fF7I1fREu/xCzjfHL+X9
 RqZJ9/btG3sH6zJJ9IIz2njok/w+vaPWnBw16RyHtRreHHdT4uG5BYxQ7QaHhJoBHCPaH9acfdG
 g27BtNfSPh7sF5PA==
X-Received: by 2002:a05:600c:a0d:b0:4a1:b187:1314 with SMTP id
 5b1f17b1804b1-4a1b1871350mr16165995e9.7.1791917598387; 
 Tue, 13 Oct 2026 11:53:18 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:412d:e9fb:680d:a947:4b50:d9e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18d12fe05sm12340585e9.4.2026.10.13.11.53.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Oct 2026 11:53:17 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, felix.kuehling@amd.com,
 alexander.deucher@amd.com, xiaogang.chen@amd.com,
 Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Subject: [PATCH v6 2/3] drm/amdkfd: stop restore retries on device unplug
Date: Tue, 13 Oct 2026 20:53:12 +0200
Message-ID: <20261013185313.33496-3-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261013185313.33496-1-olivier.kaloudoff@gmail.com>
References: <20261013185313.33496-1-olivier.kaloudoff@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 12:47:38 +0000
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

amdgpu_amdkfd_restore_userptr_worker() and svm_range_restore_work()
reschedule themselves when validation fails with evicted objects
pending. After a surprise removal the restore paths fail with -ENODEV
permanently, so rescheduling just spins the worker uselessly until
cancel_delayed_work_sync() in fini finally stops it - which can take
a while, since process teardown itself is delayed by the dead device.

Treat -ENODEV as terminal in both workers and also stop setting
evicted_bos after it.

Cc: Xiaogang Chen <xiaogang.chen@amd.com>
Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
---
Changes in v6: none
Changes in v5: none
Changes in v4:
- moved the svm_range_restore_work() change here from the SVM
  migration patch (Felix Kuehling)
- assign ret on the evicted_bos-mismatch and confirm_valid-WARN paths,
  fixing a latent uninitialized read introduced in v2
Changes in v3:
- retitled; now covers both restore workers
Changes in v2:
- new
---
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
-- 
2.47.3
