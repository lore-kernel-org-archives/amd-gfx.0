Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A5FC4707B
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Jan 2024 14:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D958B10E0A8;
	Sat, 13 Jan 2024 14:02:17 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 940C710E0A6
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Jan 2024 14:02:16 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33765009941so5877435f8f.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Jan 2024 06:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1705154535; x=1705759335; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L9b2y71JQ/rv7KyOs+L9oV8vduucSu03AVFujHy9XAM=;
 b=LdYBGdUrc4gh785RVK8X9lp7SeL8/8nlmWVfm28GPe7BngE7WTasDBHdCfHVAw81v5
 cGRZSQ64qsPk7XBrbySklae6Mj1AO4Zat+eI6Sa0GPEaaRyuW907vqY7MgxrCz+pzKBQ
 7+fgR4Uf18dxgGE+lqDSgVAJe+VN3suyRlezmu8YXjZKWSxp9Y+HNWxiWMT7b0RN5uae
 6OkbsxWy++rY6yoNu4QXkMuzC+ZGnk9kCfICYkVNGyR9p9MiRoosuB3BjOH0VYUX9VvN
 +BHpX/YFqsx0l5Gwh8hjrnLex/MYEqaTL4736u45qDK0WeQ4kEJmV4B6EkQi/3xgI2s+
 oabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705154535; x=1705759335;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L9b2y71JQ/rv7KyOs+L9oV8vduucSu03AVFujHy9XAM=;
 b=G0Qtzl1dOKz/XKDvIALDpw6e1+PKGtmdyeprJG8kukvVyDBfoRjo7aOVodpMeg21BU
 4sUObuugeb62eD8voDHGS647lGkGtwZYntDy07+O/1mY7/4n3P0rYPpyybd0czoLjNGi
 iqndXyX0qjGtqmB59OikqD6frz9pS4FznHj+205BA/3zDF+5OGwlbtAIHWo33x8MUG7Z
 3ngmQOFEDTIg6rBfADO7G4rx0b1bq79AP+FrNc3EJpeBC+krJ4qRlJoJ+//5nvlV9tK4
 Aww1i8UZBixxdIZr1as7rL0vH6m2cJ+vIipOcZUchu7Jugc31Y+2qV5llXwhNNtYOtyM
 WOpA==
X-Gm-Message-State: AOJu0YwAKx2gV5hG0PvwqkwV3QJTtLKh1Tdyx0dEIah+cYbUKNQ/BNuM
 8hSva4WpE3MFsBRPFYDwpZXqqJ3Q7GvRtKKU82HXH5tHadI=
X-Google-Smtp-Source: AGHT+IGJr9EkzuMM1pESlHnrgGakKr5k2LoOBYPyvcYTyAs4lRuS+mD2XB/lOqA84Y1jiHAic0yW1w==
X-Received: by 2002:a05:6000:1084:b0:336:81b:7b3e with SMTP id
 y4-20020a056000108400b00336081b7b3emr1606885wrw.84.1705154534804; 
 Sat, 13 Jan 2024 06:02:14 -0800 (PST)
Received: from localhost.localdomain
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a056000111100b003377cb92901sm6756540wrw.83.2024.01.13.06.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jan 2024 06:02:14 -0800 (PST)
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: Pass amdgpu_job directly to
 amdgpu_ring_soft_recovery
Date: Sat, 13 Jan 2024 14:02:03 +0000
Message-ID: <20240113140206.2383133-1-joshua@froggi.es>
X-Mailer: git-send-email 2.43.0
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
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 Friedrich Vock <friedrich.vock@gmx.de>, stable@vger.kernel.org,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We will need this to change the karma in the future.

Signed-off-by: Joshua Ashton <joshua@froggi.es>

Cc: Friedrich Vock <friedrich.vock@gmx.de>
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: Christian König <christian.koenig@amd.com>
Cc: André Almeida <andrealmeid@igalia.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 9 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 3 +--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 78476bc75b4e..c1af7ca25912 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -52,7 +52,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	adev->job_hang = true;
 
 	if (amdgpu_gpu_recovery &&
-	    amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->parent)) {
+	    amdgpu_ring_soft_recovery(ring, job)) {
 		DRM_ERROR("ring %s timeout, but soft recovered\n",
 			  s_job->sched->name);
 		goto exit;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 45424ebf9681..25209ce54552 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -425,14 +425,13 @@ void amdgpu_ring_emit_reg_write_reg_wait_helper(struct amdgpu_ring *ring,
  * amdgpu_ring_soft_recovery - try to soft recover a ring lockup
  *
  * @ring: ring to try the recovery on
- * @vmid: VMID we try to get going again
- * @fence: timedout fence
+ * @job: the locked-up job
  *
  * Tries to get a ring proceeding again when it is stuck.
  */
-bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
-			       struct dma_fence *fence)
+bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, struct amdgpu_job *job)
 {
+	struct dma_fence *fence = job->base.s_fence->parent;
 	unsigned long flags;
 	ktime_t deadline;
 
@@ -452,7 +451,7 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
 	atomic_inc(&ring->adev->gpu_reset_counter);
 	while (!dma_fence_is_signaled(fence) &&
 	       ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
-		ring->funcs->soft_recovery(ring, vmid);
+		ring->funcs->soft_recovery(ring, job->vmid);
 
 	return dma_fence_is_signaled(fence);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index bbb53720a018..734df88f22d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -354,8 +354,7 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring);
 void amdgpu_ring_emit_reg_write_reg_wait_helper(struct amdgpu_ring *ring,
 						uint32_t reg0, uint32_t val0,
 						uint32_t reg1, uint32_t val1);
-bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
-			       struct dma_fence *fence);
+bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, struct amdgpu_job *job);
 
 static inline void amdgpu_ring_set_preempt_cond_exec(struct amdgpu_ring *ring,
 							bool cond_exec)
-- 
2.43.0

