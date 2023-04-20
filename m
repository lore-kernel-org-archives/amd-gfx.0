Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49866C77B73
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 11:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E5A210EC04;
	Thu, 20 Apr 2023 11:58:03 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D21B310E253
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 11:57:58 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id kt6so5980126ejb.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 04:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681991877; x=1684583877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8pUCIfL14thJxgsuQU0QiMkgd8dm1YXXT0nyxOGKO6c=;
 b=SaQ3N86LxIGttQ0dqBBXB2T7IR9EZzK0flGsOg6uKLIvLr76NdyJcyHXSyK9kY0mON
 SLYTf3vNpXmb9LP6k6IQgic3wE9pIA4CyN8LItFkP2tGMedvisGXF9bAdS6RSbQxtrVA
 5PpUyKv3OjXdZ6hPfqJbEo8sQI37oq8O1u5fzfn5+Gp1+JyKY++GGRjNR/S7tM2NQW9V
 yvVboEvPeDwj7tgF8jqY4g05X17Qo+Fkgh9XUQlaAJxe+25/V68Fno6CU6JuEbJSf6zZ
 2XZeT5Vnm11avxZgxV/5zzNAwgaYIiaodIoQdrnwSgKROWIa/rqLfYCV5I19w/tZyitg
 bGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681991877; x=1684583877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8pUCIfL14thJxgsuQU0QiMkgd8dm1YXXT0nyxOGKO6c=;
 b=aAuSkDyfJ8BAQDSMUDSi4IVnlSa0Z/mqxKiVeHFluuFV59KEoPWYZOnePGF29Qk889
 A/MsvcpAWbnIeEYseNA3IF3D6yY5LyaP6H8r12b8cjoLA7h44mXzneSNFooaNDu9X6vE
 eF4vWMv/JE/QyQQifrXaSs8clhVXrSCbBmiUdaL6r4MPjcdMN4H/Sep2l32TAi1wOnex
 kSngNs28SwPnelCWBPTQAXJB19PToN1EP3eiIkp0RlQQZW9am6JdmPLJHPQllDyVPt36
 fmd2/poGiOmA9FotvqM2DfLnpzxfhSyoiRm3KIToVn/S2TiDvbKTlHQc1EcYHBIrfVQv
 EhJQ==
X-Gm-Message-State: AAQBX9cg/uUxb1+WQDMiAh1475kahswUxyU8TpLpVvMXq9k3SjgoWmJJ
 kWndGH6IQp6QZDrXaPQXaG1WTm8jK2rO+g==
X-Google-Smtp-Source: AKy350ZG9HxTZKtKAv7dRs8VIw5uogyzMQCHNlttCoHIfUoUPe40RhnrGhZI097IKLnrm4F+D7S9Iw==
X-Received: by 2002:a17:906:1c42:b0:930:2e3c:c6aa with SMTP id
 l2-20020a1709061c4200b009302e3cc6aamr1386787ejg.49.1681991876739; 
 Thu, 20 Apr 2023 04:57:56 -0700 (PDT)
Received: from able.fritz.box (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a170906645400b0095342bfb701sm689385ejn.16.2023.04.20.04.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Apr 2023 04:57:56 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/8] drm/amdgpu: add amdgpu_error_* debugfs file
Date: Thu, 20 Apr 2023 13:57:47 +0200
Message-Id: <20230420115752.31470-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420115752.31470-1-christian.koenig@amd.com>
References: <20230420115752.31470-1-christian.koenig@amd.com>
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
Cc: luben.tuikov@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This allows us to insert some error codes into the bottom of the pipeline
on an engine.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 24 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 15 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  1 +
 3 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index f52d0ba91a77..877fae84b8ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -693,6 +693,30 @@ void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
 	}
 }
 
+/**
+ * amdgpu_fence_driver_set_error - set error code on fences
+ * @ring: the ring which contains the fences
+ * @error: the error code to set
+ *
+ * Set an error code to all the fences pending on the ring.
+ */
+void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error)
+{
+	struct amdgpu_fence_driver *drv = &ring->fence_drv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&drv->lock, flags);
+	for (unsigned int i = 0; i <= drv->num_fences_mask; ++i) {
+		struct dma_fence *fence;
+
+		fence = rcu_dereference_protected(drv->fences[i],
+						  lockdep_is_held(&drv->lock));
+		if (fence && !dma_fence_is_signaled_locked(fence))
+			dma_fence_set_error(fence, error);
+	}
+	spin_unlock_irqrestore(&drv->lock, flags);
+}
+
 /**
  * amdgpu_fence_driver_force_completion - force signal latest fence of ring
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index f676c236b657..d3ad29d932b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -507,6 +507,17 @@ static const struct file_operations amdgpu_debugfs_ring_fops = {
 	.llseek = default_llseek
 };
 
+static int amdgpu_debugfs_ring_error(void *data, u64 val)
+{
+	struct amdgpu_ring *ring = data;
+
+	amdgpu_fence_driver_set_error(ring, val);
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE_SIGNED(amdgpu_debugfs_error_fops, NULL,
+				amdgpu_debugfs_ring_error, "%lld\n");
+
 #endif
 
 void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
@@ -522,6 +533,10 @@ void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
 				 &amdgpu_debugfs_ring_fops,
 				 ring->ring_size + 12);
 
+	sprintf(name, "amdgpu_error_%s", ring->name);
+	debugfs_create_file(name, 0200, root, ring,
+			    &amdgpu_debugfs_error_fops);
+
 #endif
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index e0d02cd8e63c..04ac055c3942 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -125,6 +125,7 @@ struct amdgpu_fence_driver {
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 
 void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
+void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
-- 
2.34.1

