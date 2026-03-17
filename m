Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D16FD7075
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 10:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EB0E10E584;
	Tue, 17 Mar 2026 10:55:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mU/QGFJy";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DBD010E1D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 10:55:06 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4852fdb36a8so65347465e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 03:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773744905; x=1774349705; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5THTP3tkmhDsLCIubw07HgT/H4mtUPnwzCrs4Y2RYm8=;
 b=mU/QGFJyatqWggSGxmfuhhi3HgicRDiWM/yAZYJiBS+DS2v/EDbZ/h7pQm+KRZSHRE
 YNbVX43OsjN4MJKwT7jAS6C4o91KkHuyjBWq8mkaydgq+NdwVqKWxWcPF0GkwabvoHOQ
 cphX2WbmUXcRmCb3oonMvQEPkaRUJyhTNezd7SNBius8O26/u8uUSDYSC43r8UTio1MW
 8xpmI+HKY7j8kAWzXSLu1S115ygERT2UU352RhO4Y2ZpI7hHmmmA9OOMzxDKWtu86xfy
 wiiwVyi/ZVOdh1cU67g/oMZhj4nR5qoNjuIVNfFc6X7iTMo2Ccump9XXzMpKdr+0w7n9
 GKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773744905; x=1774349705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5THTP3tkmhDsLCIubw07HgT/H4mtUPnwzCrs4Y2RYm8=;
 b=ONJLJ2kOF0RKvPmesQw13/A5MWB/eJXTOkQBMcfjqPKX1EJz1xOy00/hTbsBGftKya
 KfSeE6Jwi/9p7cV6h4wpHSLMXYlM65bSxQbqtMCsClqJ1h/HNm9fxBOH4+ADVw4Fzw8q
 26osq9cPw24S9qHjiVJXsPoBE8VnRtR29Oy23ZwEznduDFhLG19a3ZHGbr9B6u4cmRyJ
 ndtWLJOxDsB+9xTn/JPzkblzD0gsIg+mGYIWO3dh/uRBbiZmZMolKDRv+8Ro6b3dU6UX
 5Izje4QcE2LCtwqzX/5sR4bCnP+dGcg/abQVaBmhNhyG3EFsa10Unp2PndztVC4k9Pww
 76eg==
X-Gm-Message-State: AOJu0YzaUDNSjOvZ7teJ1TD+v54S/JrWVjmeEktsf329XO61MX0jdP+k
 Kq8wc9UrtvzSszpdwkbCFOy1wJ/PgrKlhSDY1+8IvQsfpCw/Hz8kB3uA
X-Gm-Gg: ATEYQzyZeKT0Emife6Et1LaWnz1dejQyVhphOqGkZEDE/A0j5Wgm2gPhoPs9NCIT734
 lpYDW/hZT0sUMqjaIkq+FPyQFtmoItfYn5UhziCLIiLuIWiZKSRXXRv/meZ/JeFdI9Yx0ZlafHf
 9qeF/BwLq7CE8VqTlmWkPV8ngiNTXdwzrmVXabAVfGtDvLunvJb32bSKBWlKZxZnBgexOYddmVD
 8MckDWLnHpIugOBRB1W8aJiXNXOvB6EmBVpAudYFAlgqDUWiM3xUsxYOTBepPMJnV8p/cPBY3s9
 gGnPh/HiEUMMYeFitWkYEpTWskCByyA1lj5fr8LJ49gj7t7LpaIG5uPX1WXsUWbAwAszqXPbLSP
 cWx+kAHNp6sC8afhfAJlg2R/G9Ap8g9QeArHQJlOs+/n+NALndnR6pSxnrL8u/igk0GK5bLryhn
 Gt0SB8K7QI4jBf4pybIP30thkBbOGi9RHOVHVv
X-Received: by 2002:a05:600c:c0c3:20b0:485:5981:1411 with SMTP id
 5b1f17b1804b1-4855981166bmr188573465e9.23.1773744904381; 
 Tue, 17 Mar 2026 03:55:04 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1570:2300:fbdd:8811:84b7:347c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20bd9csm49852223f8f.21.2026.03.17.03.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 03:55:03 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: sukhatri@amd.com, tursulin@ursulin.net, Alexander.Deucher@amd.com,
 Prike.Liang@amd.com, SRINIVASAN.SHANMUGAM@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/10] drm/amdgpu: fix eviction fence and userq manager
 shutdown
Date: Tue, 17 Mar 2026 11:54:52 +0100
Message-ID: <20260317105501.21479-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317105501.21479-1-christian.koenig@amd.com>
References: <20260317105501.21479-1-christian.koenig@amd.com>
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
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 8 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          | 1 +
 5 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index bc0c62c312ff..a44baa9ee78d 100644
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
index 69698cb60778..ccbdb3068b6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -143,13 +143,19 @@ void amdgpu_evf_mgr_init(struct amdgpu_eviction_fence_mgr *evf_mgr)
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
index 5bc804636015..2c1b8bbbc903 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1345,6 +1345,11 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
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

