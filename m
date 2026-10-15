Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B63ACCA465
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 19:30:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD4FA112455;
	Thu, 15 Oct 2026 19:30:19 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F59A10E4CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 19:30:13 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so16559985e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 12:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792092611; x=1792697411; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HLD9iVIZ163U9jFvBO1ehanu99qPbM6uZlGnS0s+nMg=;
 b=n5KO/TJtfgNHWzTVAw0dptofIqEnprrFW+1mQId31zeTOtLmvEX0n0J/Fn9SF+FBZj
 e1br4F7gMqOB35MKS2obB81c/lUen3SO8N0jfBuTfHDt+HCPrDeVeMN1uzIcYWiMCPbM
 5R+O0aI3IMahmEZK/GWP5bmdKRphjsY6d2Iblud+iy73MWEfsH+i3IXRms4n3G4Qo2fH
 uzfUfbKENZ7/dctNQ+aJxZD71vXECTTxWhSwuKvfo+uWG3dGL4AHtva99vt1FqypPL1p
 z3dgbBGJVc9zNaDCCH2/aWIx1o/kcIF9PVAirC1YSSIYrh9WVGJV+vF26ik7NJ8FlGpn
 5E4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092611; x=1792697411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HLD9iVIZ163U9jFvBO1ehanu99qPbM6uZlGnS0s+nMg=;
 b=C7F6OysLxlykwEvvLJi20dh8+h4gzOveGy1I7rsHeYkNTXnvxQJ0F+guIxTaRr25/P
 Bo470Xh/WpOfgLn41jmE0rPJTNlfeOmzcyivoPpKRaHw0q7L0ExGdB1bTytKg2fhVv+O
 VbzzFMXPwi7JMZH7dR56YPDDBlgipA7ET4kGcHKR14+Ol4ZroFZitOD97rmnOqLmI5F0
 3AEq/FzGddBfSQ40hzFQVlfmdVenqrLkEqLKT9kbWwjNleThbi+aY4Q/14zEKKAWplZ1
 LA/ThZHR5mRxSDja50S7WyCO5Wuq6HwrI7K9hBU/+YAzEwnRwGIq3Ve4kKp1l3ec+Eab
 bH7w==
X-Gm-Message-State: AFq9FYJ/3ZwqzCnMPTeVoqPnwcB3xPBB2+f25WsKEsQfTvpln5Cl9zCo
 XrYS21QZAghn+oe0YHSrNFR6DaNsnptERRWiqbX6dTvv/2rjJRGgMp/pTkImUQ==
X-Gm-Gg: AYBFou1WyAv3+kI2CNOuKtP2lyUC+NFHTYZgSOhEyDBrP0GqyEeHy6lLlyRXIXqzbei
 34zFW4+xXSOuqc/LNOrpB8zvdbN04QQhTsUmo2UmLdxbV1taHWbt19PjWYbZpjd+kP2nyyxI4Sw
 UMG9QsaaCT5XejLoBJe/FQB/lhy/AhiyGMdMxE89IpM6OIJBrKPlIwY4wXVjyuMa26F5V3H9RPX
 Bvwk3+5g9wjH2UuMmtDXSOLljnsoFvGBIXsENaJY0DPk6oO5TqJflG7FShukvoWMI48MHcQOrHY
 dTN6Zta+4rpo0nmk/nddV/W01j5ACiAPX5KrO4Bqa0dkur8GMHhdhZvy2CuhoGLCik+nlWg6cYI
 sqAalcOCAMH1bnqwEtWDbi1XE2VBfjdWdbQ8aWRG7LX5m9Zd2l2TVnCjejGxbzi0sAEaCOE/Fj6
 CMWJZyLwpRklhRfhCZOPOTrRf25I8YomNTCKdBPsTz7b2Y2ohCfNixeuWwmUNsyxYMekAHWXhMV
 pwyubo47t+6AUsUAWc0KMXPhVDoWU5oqPMQFAnbjUeox2PK2offt2yg3+Rh57mqB4QOqpKbORts
 hAEscAyX1KzmrFgJ5QyNBs4hWlIwP3i55rwK+ote3y62kuJCNv3oM09Bww8jonL8fFhVwpF7V+1
 mB/SvcpdyvaUxkRwKsIYju1jlkxvgYIpq+3UOraTqivhb6CHpx7z71Iqyr25cFkDDkYoYad5W5G
 3meqzAdRTpCsUYxew=
X-Received: by 2002:a05:600c:c16f:b0:49f:cbf1:e765 with SMTP id
 5b1f17b1804b1-4a18e3ef314mr400758105e9.0.1792092611386; 
 Thu, 15 Oct 2026 12:30:11 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:e487:41be:7420:c1d9:bb43:318e:b925])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9a88bbsm94694375e9.3.2026.10.15.12.30.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Oct 2026 12:30:10 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, felix.kuehling@amd.com,
 alexander.deucher@amd.com, xiaogang.chen@amd.com,
 Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Subject: [PATCH v6 2/3] drm/amdkfd: stop restore retries on device unplug
Date: Thu, 15 Oct 2026 21:30:06 +0200
Message-ID: <20261015193007.86066-3-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015193007.86066-1-olivier.kaloudoff@gmail.com>
References: <20261015193007.86066-1-olivier.kaloudoff@gmail.com>
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
