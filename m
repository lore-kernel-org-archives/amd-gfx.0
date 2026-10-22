Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCE7606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 10:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WU0+ou+4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF2E81124EB;
	Thu, 22 Oct 2026 10:55:20 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D34DA1124E6
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 10:55:12 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48b042c0728so562992f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 03:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792666511; x=1793271311; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HLD9iVIZ163U9jFvBO1ehanu99qPbM6uZlGnS0s+nMg=;
 b=WU0+ou+4lmjzzOo9JDTQYCeacSMJVU+AbWRqlKlN2OTrREsPxLIk7d1lQEor7VFizQ
 t4wKoKcIg+uUgqvvU2AbXCRai1KyTRMqTutyaWGLDxnkEZ1h9jj3SeJ9uMmcfFcm7LUt
 hTXcsXX4VqoSVN5bJ+ypb4uNngtRlfz4cw4E/+vm/sU61CZ4O/fCeqVBtXL/EuancK9i
 oCTV6d5qxecIMCmrIcypXDhuInEH9Zlc092E5Yo2RElMIhGs9BgiYAvjV7GuxJghkAW3
 w7BYIlxp8pkxjRaw5zh23GNaRnP0vkl1fc7LOTPF1nSvGO/6+Ad7g8GgwiNs3xjgtjJi
 vG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792666511; x=1793271311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HLD9iVIZ163U9jFvBO1ehanu99qPbM6uZlGnS0s+nMg=;
 b=f/+xEDU97XW3KnsJzW8zjXPiDLVz9jPUMYenHCiUm1+EFMltYIsZ192CI6OIycq8Cv
 VLWsncbVBSy9VNMgrmSEIvwJkvXeAA9JC3Lz2IYjvKNoGSJ+NFshQuv8Q2vgc8OnKEqR
 Ge0QJlwqCe/8vgoReK6CYaIaWMZYLywwbs3Uqd6mgIUXnf7j8LBxPj7VVSWhw1QOn3dv
 UTrSSN7VekAMdbijg0vzwjofyzGqPIUnlLCHLGklSrtcXSnYwhIbTy/iSgW0vJ1Rr5f3
 oKYIn4EpxUguNtUtQf6+Vaw1oCR+sv+neSmRJqkdT6yaAbAZUEoyJYdzrSmsKn8Zp6hO
 KLSg==
X-Gm-Message-State: AFq9FYJiqETfDAhI4aw1c4x0Xp4OLqcxjeZXdx5T5/NEbSWO4RwVUyNS
 kQ8bZySIGjgWyy1dM39mbSK21AK13LdDOk7UwzIYGbRsnir1jjcM3/gH7V3rFyuC
X-Gm-Gg: AYBFou3JyeknFxGLAS5p08Z9IkknBy3GyfqqbRSd0wUilfYnss74g4ALXBc293fFosz
 FJhuwX6d/Dy8UwJrAvVdkmjmpXen3RKttSwnl8Ea4VnjO6fdsuyW1KbMMJb+/QZ0V9m7Cw2O31Z
 v4G6WlqvDO14dd0fbYe4WgiABWOKC12HlTpoY3aiADwC2NgCawDsyUlAzQAA88yIwTYAtK+4CvD
 lhn9e3FjujvbExlnXA0NPtv5gm6Bx1WcAc+/EAmSNFrJusTne3qmeN5z19JPD0qIqs1Dxrqj3iu
 u08UFx2cNduuKfdX4AsSYegVLAyieDPwDIHjdVAOhuuCONP1QV447zzBwbIZYoFHEnP0uUDbjTr
 2TXU8gyc+k1/AnpWFTk4rFNJN5kgQ1ByM0iKuGNslFgp5Cqb1RDc8QIVrl4zKuPLEmL2xtoTDvY
 fU6GJv5gdMt3TpZ90VAUlJTN1eL3l7DAmnZvKagqtH8WuEfwixkoKM4EQG0pCLokpQQvuVFiEb1
 Q6LR8Zg6Zuf+i7sDtykpkTJwyQNfZdEfs6JhhxztZIm+c/tB5vPd5esAHazOTvtfX8ZNG84oUdG
 AgR4y6RPiupf3Oq3gYnGuKyNbzc1LWyypgvb7GN58bUolS6K/5z8CzdfpjZM82Y5fZYZahK6V47
 vOioZkRRHmJBG3pHOYyC5nctVg1jtcxe7YxYB2v7hFB9kdWFIRPt3lhbDYkpEst12vwyqaAp4GV
 weLZOmTTCkoYb/jrScoqHFmC5Gu3NY3h9s3RGf6ZNzVevXjDAexDHYPJ/SyeD8CuLNP+RUj8uVN
 4BVNUtmymB9ng==
X-Received: by 2002:a05:6000:160a:b0:48e:c0:9441 with SMTP id
 ffacd0b85a97d-48e264a979dmr6837259f8f.29.1792666511055; 
 Thu, 22 Oct 2026 03:55:11 -0700 (PDT)
Received: from localhost.localdomain (188.42.205.77.rev.sfr.net.
 [77.205.42.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2583e25asm12227393f8f.46.2026.10.22.03.55.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 03:55:10 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, felix.kuehling@amd.com,
 alexander.deucher@amd.com, xiaogang.chen@amd.com,
 Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Subject: [PATCH v7 2/3] drm/amdkfd: stop restore retries on device unplug
Date: Thu, 22 Oct 2026 12:55:02 +0200
Message-ID: <20261022105503.60372-3-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022105503.60372-1-olivier.kaloudoff@gmail.com>
References: <20261022105503.60372-1-olivier.kaloudoff@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
