Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB08ECA5FFC
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 16:56:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63AAA10E26A;
	Mon,  5 Oct 2026 16:56:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FaspzogL";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1C2010E322
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2026 16:56:41 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so1591599f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Oct 2026 09:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791219400; x=1791824200; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Qry2Ln4Z2h9BtE4t/h1ALGOBUGa+Z1sLazs3I9vc934=;
 b=FaspzogL92xM7kxoxaBxA+OllcMy2hU3jgpa4Z91R7cATIi2j1dt+V3ofbzCD57z88
 L+pi00QyHdM1XKoBMGLMVcvlP7/82VzK/Md18SdKJItris+sWfUZyDI5KUuh3dkrHfVv
 +w4AkInpihf7/hfv6LxVyzWnfki0Qa+NXcj6aQv6unodWoQQbJPR5oWduK9zr0Lql6n7
 PDDhDH5fgBZ+ZTabC+SPSqrweVLayPJfKG7Ovt23aZHb5sdnwkFsWGJwcnJ0wqGRqVlC
 qKFvBITeT/2fi2o5pE3X1zjukdhHfj94Ox4OrceRz5O0i6GIFfA4fHX8wdcovLoA8GEz
 /3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791219400; x=1791824200;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Qry2Ln4Z2h9BtE4t/h1ALGOBUGa+Z1sLazs3I9vc934=;
 b=SQR4Ex75umolwxrdoUOUY9mw9HPruDFrLQKfSXfvT6ZKy+PsaSdi8n32x8wHd8MffI
 0HODCo3C9EUfxgjTWJB5JBW4imot2Fcznyo2i3MU5jLzQbw5k3GMZqKicMOHLKeNRDWL
 JuYRN6pB1Q9QqdLMX66C7Tk4WcOaTMRcPu1KswNvUDKvBF1Sb2wIX87pgU9fHVGwj/cL
 suxdy+qLvd87TP4aWTR/IWVWeofZKeiduKWBcHdZ2qk6svgeVqeZKTR1dH2rs7jzBUl4
 8uMNAy0+NlXfSdKDrh1WeSrG6YYyEPLBa94xvaHFr4Fu5tvTGLzg4PpmjcY9iSAQ1zkz
 L26A==
X-Gm-Message-State: AFq9FYLKw5I6ofwvxVEqvVtkG2IW7GBscG8bHiwAzx/vstxqwgcSGSL+
 j6sU4wQGycjuSHMGiXe4B5lrLGvpbW89cTIvFl0IkMl/GiVDjBTgQArPKdSgjA9u
X-Gm-Gg: AYBFou0jrDHqBR3Du1f04L7oi2AJh0zB5SAzbNq7jCsQI42WplM8pDqap+cMUGMvfvU
 rE4oUNnhLCb4imEhmOieJlHTeDnYWWXHwOeqjzyiTcvQVu5jMnemr6xLHqg0bZojs9LLdxAXQH4
 gVw+/E82Ss2Qf3wnGfRDL8iqCD+izEJlgzPsHqYHotcIO3Z3RaGQHAHS2CH2GGd8p8drQSpIdnm
 Moq4knZG3HmYG7phj2nmBTdSNDeYAJp2dZT0v1Giu23VmSPLwlaJ/PAFY7yJLaXxxSL0gN5YZmN
 ZrhHGDCNi8PSG3PYbTIKMPdZSkAMOcgdCv8hPdPJzuHPMMPhboX5VxhdJZs8Cdd9940oRmyzExQ
 FjL0bPsjPmPoMPvsVYorcvf+g2F38VKPbQEdcuQyAvG6hGGAMSlBfX/JCFrfQZAgpe8eUDYj8Yx
 L1/N05fFXMWaVLQWeEjXPqXGKRjipwFkDfGXayl3CZl1QVYn0vc+IfhER0gF03dMAmKx8grfEeg
 fZeGcOiOQoHZtDVPzs1b0cPsRa4UbOxEdX9IZy2jGrHx04pEBlzbMZ0mAW5ka3UxUoJ8EkoJtiG
 hETW9jO/yXg1NlREUZ9Q3D4ZejARtdrkVGpnemS/FN92tb/Bq/qRI302nGQkfacsgzWYRtzvb39
 30yz3TI7ke4ZeglCfu0LN7VvdtzFmNk8SXv+wT9QaxCMAP5szjJiYUduvNCqtqgwACd++wIwLPh
 DOMaTW1QgF7WG+dT4=
X-Received: by 2002:a05:6000:400b:b0:48c:4442:54e with SMTP id
 ffacd0b85a97d-48c47fdc0acmr12494769f8f.30.1791219400006; 
 Mon, 05 Oct 2026 09:56:40 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:418f:dfa:759c:a4bd:ccc9:9d41])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab326sm4791527f8f.35.2026.10.05.09.56.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Oct 2026 09:56:39 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: xiaogang.chen@amd.com, felix.kuehling@amd.com, christian.koenig@amd.com,
 alexander.deucher@amd.com, Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Subject: [PATCH v2 2/2] drm/amdkfd: stop userptr restore retries on device
 unplug
Date: Mon,  5 Oct 2026 18:56:38 +0200
Message-ID: <20261005165638.28961-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261003063817.36606-3-olivier.kaloudoff@gmail.com>
References: <20261003063817.36606-3-olivier.kaloudoff@gmail.com>
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
Changes in v2:
- Don't pre-initialize ret; every path to the reschedule check is
  dominated by an assignment (Christian König)
- Drop the pr_warn_once; hot removal is a normal abort condition for
  the worker (Christian König)

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  9 ++++++---
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
@@ -2884,8 +2887,8 @@ unlock_notifier_out:
 unlock_out:
 	mutex_unlock(&process_info->lock);
 
 	/* If validation failed, reschedule another attempt */
-	if (evicted_bos) {
+	if (evicted_bos && ret != -ENODEV) {
 		queue_delayed_work(system_freezable_wq,
 			&process_info->restore_userptr_work,
 			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
-- 
2.54.0 (Apple Git-157)
