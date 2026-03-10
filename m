Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A144CFD4F2E
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 19:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 110EF10E77B;
	Tue, 10 Mar 2026 19:13:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FIrQriVZ";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57E2110E2D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 19:13:35 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-48532925a4bso16435725e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 12:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773170014; x=1773774814; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jlXZHHdt/oICHBsl2HK1w1/qmNJA2+smUO2Y1M1WtHI=;
 b=FIrQriVZ/rhbdezxKiw/sYw5Uo8sRhLpsES92Mba4GF3kuADTxVvuMWDIxdqCC6kvW
 2QNv8lN7ozAqcTa7YSMdCj5zuHotQxveT53giFMngkpi9tDDJjDvpKiFI0zytNda6/pj
 Dgitlohg8dNzurh1LKXW53pX4I4HOwUcSHrtDtCdPJdyNecxRsvVdjXFMqgBhJ+mxfDS
 Wc/7Flk7rniFL2GoAI1xRxA0m3lkOCSCK1QZLwS64TVQO3oUHqd+ruCdHpiL0RANEzsP
 Oe+s1pQwyR4NnFcUVJc75lHSf8nUqZIExV8bqP5/VfvBYnzSeWomhHQwKJuAgXVln6UM
 4nKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773170014; x=1773774814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jlXZHHdt/oICHBsl2HK1w1/qmNJA2+smUO2Y1M1WtHI=;
 b=gLtrVtBokpTFbukdf/uBaWRsH2ixYOXUQ0WNLKFCMwROOVq1rIeBHkyswHZc6UukKL
 LFw5lfyZJV1nzpKv9qVVsm0UWG51xn0ZWZDd9cdXFMFYJGcbf8LN4EGw/CCiVAbZC4O+
 obulEsc2tbVQkG3wk9xqnchp4o0vo8p+ZKhAAp4ygnMiWI3In1gT1bUi4gKjnF53fIfE
 0zj5YtxdNA0gUNTJieMLdH6flf9i2/mfbxVHiGlZ1Ey2++k1TEkkqjnJU5//leeAdQmX
 vHwycKuXvEpd61YX7tD/Q7vRehfkRzoqGVLCKFQv1OvASTiMzN0P5JK+icq5qzidCIjt
 JJwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiHKP06pnFlToe9DFk4udzH15EYQnLwc/le+xuCkH/wG5CCT8Fz+15UJhPdTrFyPReCVnem1F1@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx6BquMyxunHQ8m36kmaKNuLGTeFjRC+Mvsi4Pq8DD0JtEdh93D
 z3ylTrtrfXN4IYf950WTF+IL6w/xBedhV1xLSgd3aWlWD4ds4vkBzXJK
X-Gm-Gg: ATEYQzwTFGnUgVXfCuGl7DTz0MfdRxKN3e+dLtChl0cAyqoNXdp7Fj252K47IUV/ind
 UFzKNnEdIWCNbUUHAxp12XRTqvVsQW1BFdmCzD1PIRm8yKvpYMJeK94pn44sP19ztWHg08qQxvI
 gVmw7B8VaZcxddBZNUwyRk8ojfR+2vB3v/bTkYgLKrhaFczTTH5ymSkQyi+nbEdjplZpPalwuig
 DwkwpOT9I62zXWLdLuwrsQiRhTMqWsQn3XsScMWMPO3v3Aq6LcDV1F81FawFpsdvQi0CbsNEiWp
 bt2zKauW4m0bYe53oadTlZGuYaqNa8kwHy7mPWs0UprbCmcqlKuvVT2GYETvsznTbYuAZPzVA7A
 OP+ppw35bo2XouKrQCmYoSGYOFYH3MN+lZjFmFqjoJqpM6/9L7M/FixS5wieFvfoUXTDd+P57HO
 4o1+BtomKJZPDNSPUxr6tZuKxXval8bbikfgY=
X-Received: by 2002:a05:600c:1c0d:b0:485:38fc:7069 with SMTP id
 5b1f17b1804b1-48538fc72d5mr176527785e9.23.1773170013773; 
 Tue, 10 Mar 2026 12:13:33 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d0:d800:5198:df3e:59ca:cf4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854a3079efsm2601625e9.7.2026.03.10.12.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 12:13:33 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/11] drm/amdgpu: fix eviction fence and userq manager
 shutdown
Date: Tue, 10 Mar 2026 20:13:21 +0100
Message-ID: <20260310191327.2279-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310191327.2279-1-christian.koenig@amd.com>
References: <20260310191327.2279-1-christian.koenig@amd.com>
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

That is a really complicated dance and wasn't implemented fully correct.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 8 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          | 1 +
 5 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 67b8c33d5ee3..d99e80aa3204 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2953,6 +2953,8 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
 
 	if (fpriv && drm_dev_enter(dev, &idx)) {
 		amdgpu_evf_mgr_shutdown(&fpriv->evf_mgr);
+		amdgpu_userq_mgr_cancel_resume(&fpriv->userq_mgr);
+		amdgpu_evf_mgr_flush_suspend(&fpriv->evf_mgr);
 		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
 		amdgpu_evf_mgr_fini(&fpriv->evf_mgr);
 		drm_dev_exit(idx);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 8fe9f91f9551..ef4da6f2e2a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -146,13 +146,19 @@ void amdgpu_evf_mgr_init(struct amdgpu_eviction_fence_mgr *evf_mgr)
 void amdgpu_evf_mgr_shutdown(struct amdgpu_eviction_fence_mgr *evf_mgr)
 {
 	evf_mgr->shutdown = true;
+	/* Make sure that the shutdown is visible to the suspend work */
 	flush_work(&evf_mgr->suspend_work);
 }
 
-void amdgpu_evf_mgr_fini(struct amdgpu_eviction_fence_mgr *evf_mgr)
+void amdgpu_evf_mgr_flush_suspend(struct amdgpu_eviction_fence_mgr *evf_mgr)
 {
 	dma_fence_wait(rcu_dereference_protected(evf_mgr->ev_fence, true),
 		       false);
+	/* Make sure that we are done with the last suspend work */
 	flush_work(&evf_mgr->suspend_work);
+}
+
+void amdgpu_evf_mgr_fini(struct amdgpu_eviction_fence_mgr *evf_mgr)
+{
 	dma_fence_put(evf_mgr->ev_fence);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
index 527de3a23583..132a13a5dc1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
@@ -66,6 +66,7 @@ void amdgpu_evf_mgr_detach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
 				 struct amdgpu_bo *bo);
 void amdgpu_evf_mgr_init(struct amdgpu_eviction_fence_mgr *evf_mgr);
 void amdgpu_evf_mgr_shutdown(struct amdgpu_eviction_fence_mgr *evf_mgr);
+void amdgpu_evf_mgr_flush_suspend(struct amdgpu_eviction_fence_mgr *evf_mgr);
 void amdgpu_evf_mgr_fini(struct amdgpu_eviction_fence_mgr *evf_mgr);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 67ba46851c2b..23e4c5f99f67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1344,6 +1344,11 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 	return 0;
 }
 
+void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr)
+{
+	cancel_delayed_work_sync(&userq_mgr->resume_work);
+}
+
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 {
 	struct amdgpu_usermode_queue *queue;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 82306d489064..f0abc16d02cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -123,6 +123,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
 			  struct amdgpu_device *adev);
 
+void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr);
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
 
 int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
-- 
2.43.0

