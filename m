Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109A9E77180
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 08:53:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD64210EF66;
	Fri, 13 Dec 2024 08:53:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vhu0cr9O";
	dkim-atps=neutral
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A94E10EF66
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 08:53:00 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-434ab938e37so10638745e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 00:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734079979; x=1734684779; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WknFLcktsG9Y7JrtG1ZkUSeTmHt0mMOzXtdeo6fLyng=;
 b=Vhu0cr9O/RZDIPcB8TSSBIP/iX+0M6TEV/+leIlHnvqlb366FGsNLQHc//swCdLQBK
 Bl39AtxY/7klvWmInVksnFuGxhkd/d98zTE5yr2KL1vxj2AYgx9aOAX0F9cGZcz+G+Ss
 zgovWd6EegHFe5hPfQmfe2BmyPUBmyKOzRw1yvRqvu5Zs5Ebazs6osGprykOdLnNBQBJ
 E15I5BQFgd7eowOR6WpzhgCcc2jwcQbhchIn9AlTyuwYODmEUXtPQDwH7iju25rpuXXk
 f8YDbpjK4tufmKIHgc5CpxO3BY2BnC4ZE/6vsnZo9XG/BW68CC8MUhKRJF9kaKJ9nrqP
 HakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734079979; x=1734684779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WknFLcktsG9Y7JrtG1ZkUSeTmHt0mMOzXtdeo6fLyng=;
 b=OvwfUkF15mLWiquXFRMFwDyMrfds9KElgf6AC8Z0/tgYUdPN5lvU7DkUhUnzYAK1AX
 ehzgAeCe1RiZ+nczV12/64JLdDEnUXA2gib+iGhru9GNzaYN7uxlv9kkUDKpGc5r2RyI
 i5GqAGtWnBSfhPALgDlR2ue/YqshoeVcGlwX4EXkkTc9x6tTjvAaiP3Q3hgCn+66s6EK
 hOFqX/G2KeWrwjU3k9DX+4YGFJ4xBza4NBbifEqeCN81YPWeuKNEOeXch20QYJQnXmiP
 AuH/XwQ7flgYYXAGgJihTS6U9fBRR0ggpD26sRR+/1PxEyfmb/S/3m7PFuhVbprd8xWF
 WM4g==
X-Gm-Message-State: AOJu0YydPYhLgjaNcAb9rke4SZvk+v4N2JuWkMD3wZdqvm96vbFoWkT7
 l9jafyIEcaoSM7rskbAOiQZJMpVY0pEfJPWsCQcBu8W25T4uU8QTWvhjaA==
X-Gm-Gg: ASbGnct3Z/PqFsaK9yMFShqztbRoJs0PdDoG42yJtBATkyK4E3LI3dSB49ePXxO4wKC
 ZVYZFoZdYqSnxKUS0HqsUesHzn3snhFtSCMQL6BvHjk8knwgYN76EfomNvdy8otw3MgFqMoGERq
 C1WTL+qFsiVRXD6mi623M7pgMb/sHZ/98WF8AUhbpV/kd5rvafDRJkob3lNkcKCD6VaO8VMcdwv
 XUtnWzGWQI4gR/KmfRPa0SoCGjYTQ1AAY2gOM2Q00UjFbKOMeDpxPtkjrTVYu1FJaj09A==
X-Google-Smtp-Source: AGHT+IGOHYbbliSm6G53gH9HwoLoOspLTvEbAEh6WP9NjhHcDsK9rAMhXnsDgIts3G2FEgUoZmI3Kw==
X-Received: by 2002:a05:600c:1e21:b0:434:9499:9e87 with SMTP id
 5b1f17b1804b1-4362aaa9d7emr11279595e9.25.1734079978643; 
 Fri, 13 Dec 2024 00:52:58 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15a3:f300:e495:bece:6ecb:efbd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824cab97sm6392473f8f.62.2024.12.13.00.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 00:52:58 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
Subject: [PATCH 3/3] drm/amdgpu: partially revert "reduce reset time"
Date: Fri, 13 Dec 2024 09:52:55 +0100
Message-Id: <20241213085255.1449-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213085255.1449-1-christian.koenig@amd.com>
References: <20241213085255.1449-1-christian.koenig@amd.com>
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

This partially reverts commit 194eb174cbe4fe2b3376ac30acca2dc8c8beca00.

This commit introduced a new state variable into adev without even
remotely worrying about CPU barriers.

Since we already have the amdgpu_in_reset() function exactly for this
use case partially revert that.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 3 ---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 2 +-
 5 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7051b697530b..5e55a44f9eef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1192,7 +1192,6 @@ struct amdgpu_device {
 
 	struct work_struct		reset_work;
 
-	bool                            job_hang;
 	bool                            dc_enabled;
 	/* Mask of active clusters */
 	uint32_t			aid_mask;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 503051352922..dca5a4ef2734 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -836,7 +836,7 @@ int amdgpu_amdkfd_unmap_hiq(struct amdgpu_device *adev, u32 doorbell_off,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	if (!kiq_ring->sched.ready || adev->job_hang)
+	if (!kiq_ring->sched.ready || amdgpu_in_reset(adev))
 		return 0;
 
 	ring_funcs = kzalloc(sizeof(*ring_funcs), GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a4dde54512b1..2e6829e1554b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -515,7 +515,7 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	if (!kiq_ring->sched.ready || adev->job_hang || amdgpu_in_reset(adev))
+	if (!kiq_ring->sched.ready || amdgpu_in_reset(adev))
 		return 0;
 
 	spin_lock(&kiq->ring_lock);
@@ -567,7 +567,7 @@ int amdgpu_gfx_disable_kgq(struct amdgpu_device *adev, int xcc_id)
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	if (!adev->gfx.kiq[0].ring.sched.ready || adev->job_hang)
+	if (!adev->gfx.kiq[0].ring.sched.ready || amdgpu_in_reset(adev))
 		return 0;
 
 	if (amdgpu_gfx_is_master_xcc(adev, xcc_id)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 7fdf7b047317..6cc44eb2586f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -102,8 +102,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		return DRM_GPU_SCHED_STAT_ENODEV;
 	}
 
-	adev->job_hang = true;
-
 	/*
 	 * Do the coredump immediately after a job timeout to get a very
 	 * close dump/snapshot/representation of GPU's current error status
@@ -181,7 +179,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	}
 
 exit:
-	adev->job_hang = false;
 	drm_dev_exit(idx);
 	return DRM_GPU_SCHED_STAT_NOMINAL;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index c4e15418e187..714a6caeb679 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5957,7 +5957,7 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu_device *adev, bool enable)
 	else
 		WREG32_SOC15(GC, 0, mmCP_ME_CNTL, tmp);
 
-	if (adev->job_hang && !enable)
+	if (amdgpu_in_reset(adev) && !enable)
 		return 0;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
-- 
2.34.1

