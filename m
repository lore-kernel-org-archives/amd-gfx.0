Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F145FCA6012
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 17:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8158E10FACF;
	Thu,  8 Oct 2026 17:33:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="giFN96+p";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAC5610FACF
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 17:33:55 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a1698ea378so28766515e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Oct 2026 10:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791480834; x=1792085634; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZFeXVnMa01Yx8K1Ht084j6gFWGB8XHILwWuL26E9y1c=;
 b=giFN96+pcQPI2TMFHnBAYe33U6aKK6FG5cCwLy7WBlTfhU2NTmfoxLwqAapdEiivfH
 mT+VRIVaieJqWp8lQxkJWY7HJSAmUTVkY3GXrR6ysQI596nzn7v4ypF3S7mR9H2ZwQ0v
 pfWyaoEDIye6zfetV3D0DidEhM/yuoIaFV6dFvqTTul07hUYByL4Ti11OrlITPBlqkwu
 GwVSGuKDPeF0Va5evLNRIxwbEtE6ZE6Q6slGEeDehJ3q4iN8hgNvp22GtVHrG/6f0cHO
 me0WqnoXbkBJHKzqurVZBiAitNyVcliCNKxPhwhemUYVxItfLottuI024UiBilQI5mWE
 3lKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791480834; x=1792085634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZFeXVnMa01Yx8K1Ht084j6gFWGB8XHILwWuL26E9y1c=;
 b=E6DOohvgB3v5B+mFYtCHdg67SWCGQmgPjT9bFP03ZXVxzRkx5BPy26TK0a078YzJAi
 rnysweY2hSKGEduEvWlfgq1rXkxsowmVPM9qadkQTxVDqZplWrVcX5+YKU6vuMU4EeKY
 FRwPsPB+UG2C3KlUPFWmbO/+NLyYZmme5CAts4b7bDMI63+j7IF/47aeopVjT6prcSHy
 whjT4DNaM/sCPbj6gICBsL5UXmqi8FbfjH4bdkoQKRtdI3FQO/r4cKjD3Zn8QfW93hDi
 4A/+cCPvoW4s/VRQUXopBKAQKMPgA9zbnYhq8u3pxEDfUFcOXjH/TVbZsJ+dtFggjZho
 xBcw==
X-Gm-Message-State: AFuF++lNOeeNznVgMMpRXyEY/54sqxzxlyC9/TJTs7882gj4+APlPFJP
 FMm2FjigdvuIBeKRW3EVQCFSkukUlNNCyf7jTno7sqPo1jGUldJTHajR9FSOHE1cI1w=
X-Gm-Gg: AYBFou2SbvWjuRpv+FRWmUAFvuu8Ahq4NkdSCPPFGKTF/uw384ZsZBN16NCGLtbxiDY
 KYr/LlKrSH4ivgZVywQa4D11N0g5KXGbmdwsQOTpS/auWoeckfDKUEFjta6bEf5eBmC2JZfrLiB
 SjRtY5jE4nAXxhKII5FRJ8/rfzIRiGE6aH+LKcYEe/5AwjFSE7klnCb6qGk/yPoBfMgED1hawsK
 i7B+4pGjKkjXzACQMl/YRZ47G1extXsyE7ixoaLrXASDkAOVUyLbtnTX5LqDn9AlSGN+N0STd0K
 N6pjPymzENMvK/DuynrpDb7OtoHbvdCXB0RKsVSmvNg8hAIoTzWO6EOqTyIekqQHbAou/3w8l4Q
 L+/MfR85hhmibMgvkGjsFspTVD35M6PIXCAod7NJNIF1bh39hDr45/9AP//tL84IU+dAqCWk4CA
 wLnBegnA6WtZAc7MKmqMxaV95labnNlqasBHlmLwPdl1lGgxxCkuEbpc4B/eL5OvIEc56ut1BaW
 Gv6s4LiJm8rrqo2tt0C8Gt3hmam/YHFg5wC6Ule1Kf23TuoWxDTlmZ6TixFMAIPaEsJOYEUHPb3
 yqSnwJGO8/bCqvyPB1ZkU5WuChLWs0w75pO9TvJZvBg+XJdKw2OwYCKVTrUGkbfROwlp8C/38qh
 kCv1CXAt5+axpFDMQDDWo7OlB1lvRcA5r+qh40xISK3lEkiGXBkAAKRRAio72NH7t8g74S56zvy
 NdvP1d6Wt/aS69PC8=
X-Received: by 2002:a05:600c:3f08:b0:4a0:1723:2d8e with SMTP id
 5b1f17b1804b1-4a1800ca17amr106372225e9.2.1791480834019; 
 Thu, 08 Oct 2026 10:33:54 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:e487:415e:bf71:e574:69b7:f11e:4204])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db652e593sm659451f8f.34.2026.10.08.10.33.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Oct 2026 10:33:53 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>,
 Olivier Kaloudoff <kaloudoff@icloud.com>
Subject: [PATCH v5 2/3] drm/amdkfd: stop restore retries on device unplug
Date: Thu,  8 Oct 2026 19:33:49 +0200
Message-ID: <20261008173350.40455-3-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261008173350.40455-1-olivier.kaloudoff@gmail.com>
References: <20261008173350.40455-1-olivier.kaloudoff@gmail.com>
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
Changes in v5:
- none

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
