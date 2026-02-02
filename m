Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209B5E7315D
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 12:51:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74F3110E4BD;
	Mon,  2 Feb 2026 12:51:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ch3eigsS";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 698F710E4B8
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 12:51:55 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4806d23e9f1so49268655e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 04:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770036714; x=1770641514; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/yDrVITbUxW5XVjKd1Ld5iyKm6IuQ4XT4Nd8Bw5o2/8=;
 b=Ch3eigsSxj0ePE89w0ziyw8xskIGt1+8bMYFARuvAW+yXoHJ1n0SAvYxpbchww3RMa
 5kACTGHOyFyZ3bBsWU6flx7PxwTz+raLUoEcYJn2gaeqnmtq5JC70+IpUvYigNZhLWed
 AkXIRFC/dfq5nTU38Pc35Y557/HFMs31vWkxeU4/Udq/LHsXan9CQi2vIRdV/scAfrQ4
 cxhal3ogN/cdH8n55XSco+Ja8AJHHTD+uo8LEGdUgjtxWNXOxmJstZzDka3LHURyYoC6
 1wW5IrnzeQVGfUqkcVIAYsI4fCkLk/8BnZmznwoLdHZT1VJP7BwI4eeUlgCvkP038Xph
 5Lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770036714; x=1770641514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/yDrVITbUxW5XVjKd1Ld5iyKm6IuQ4XT4Nd8Bw5o2/8=;
 b=w49cC6Pm5eqYzCcpLz+ibUSmPSFcKNEyYvlA8ePfBY4bEC2Y/fIuItIgRW1srPEksH
 on/5OGbMtdFyW57ITSNorIr438hK2yhsJFpfmyyrRmCDalwFkLV3Bdifm5yacZXZRIOY
 7odanzkZRij6iaPFzn0SCCe6Vx4WbMheU7oflUNdU4vr62JslDe+rQCa4djbC4BNGv6w
 zZp8bZIkneegFugvUKo7Q5u/Wrv3Ka8OSB1YnrWUXQv7mlc983/lCWYfvEvChrbUrf/L
 yykrm8MEXF2xLNtIPpSlJAeblXfsmxjI/3QathKcohuj4+CZ/eub1fKNORfh4743Kqpn
 xYYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdJ1bIfRbrQoXOdMEN4zpCNtv1ox7/MLzOkKCTH+dGIOm4s9EUEWQnPC4Lt4LvN7ZD55U429rC@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQ7gRNvz5RTzFTCQWMihJB46N1IZLQ4ImGPct+KWsQSdlzyBeA
 dWagxPIbYUnRIasQSgjTcdb5ovBWO4PtR0OWwHbOPsZKZhXeSVCmJL7L
X-Gm-Gg: AZuq6aKf6W51zFrEzBY+VJhx+wmvkI7a6oVSd0gbbYZ1XyJxFDNFsDfuffCC7Ur7uNr
 qIMInsVzHaGH5DkFrFduck/78sZ6jj/RJIAqa7T5Yf3j2+QsQghTTwm7MgDvNj+CBKTZKuExqUk
 tOSPXhppGpYH1WoF7zQd+P1s2ALXJdsu5goUv3fyVeqEgKCz3AmgstWfjfFARuvUz/ky1UPTGmE
 MjMKXT44ZKsRhhlwnFRy25hkDSctBLjmRkbW7TRzLUxI12lRh9WpDxlsYsd4Tr7O1qfy/VqzFHK
 pFbUKe23Ob4YfWOBN6fFhK/d0F1Ii1asdTBfXV2oWbovCn7wQjz9uKSeVwPW9Zll6UlpuVT+TBX
 0IaA3MOoLwfQwAe6ZUksBQchbRLBvyNsq0D01Fdz49n3TxRJ5BLtsm3z5JXKVLxgRFL/t2AAcZD
 g1v1W2oWTEbaijCchceHoH01M=
X-Received: by 2002:a05:600c:6214:b0:480:4a90:1b06 with SMTP id
 5b1f17b1804b1-482db49dbd5mr134622515e9.34.1770036713830; 
 Mon, 02 Feb 2026 04:51:53 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:1570:8200:7824:9bef:268:2d37])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482da6a042csm126165535e9.0.2026.02.02.04.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 04:51:53 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/9] drm/amdgpu: fix eviction fence and userq manager shutdown
Date: Mon,  2 Feb 2026 13:51:45 +0100
Message-ID: <20260202125149.2067-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202125149.2067-1-christian.koenig@amd.com>
References: <20260202125149.2067-1-christian.koenig@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 7 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          | 1 +
 5 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 02abe85624a6..9cd44be45861 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2976,6 +2976,8 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
 
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
index e007f10a6c1c..60e8a993557a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1350,13 +1350,16 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
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
 	unsigned long queue_id;
 
-	cancel_delayed_work_sync(&userq_mgr->resume_work);
-
 	mutex_lock(&userq_mgr->userq_mutex);
 	amdgpu_userq_detect_and_reset_queues(userq_mgr);
 	xa_for_each(&userq_mgr->userq_xa, queue_id, queue) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 095c09f3d96c..13f4e356728b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -117,6 +117,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
 			  struct amdgpu_device *adev);
 
+void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr);
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
 
 int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
-- 
2.43.0

