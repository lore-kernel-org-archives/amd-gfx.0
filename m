Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F630C77B71
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Apr 2023 14:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF4B910E140;
	Sun,  9 Apr 2023 14:46:55 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D5FA10E140
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Apr 2023 14:46:55 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-94706a972f3so45718666b.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Apr 2023 07:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1681051609; x=1683643609;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oLmzVq0hxpZo50dklapmsCpWXglsYbkSNUJFkSRsb9s=;
 b=J5ozYpbWYRhytESbBGfF7C6PIBL4XNPPlifYH1bgFhMcjuWUAc+XznOsfPioO3QeBl
 58ZtZlcQsTCV1yAY3uSbigidE9zqvsg+v306e6b4wacJ9DiGUAYfuYYPWe8vPbT0nlR/
 l8P8BN7WiIudTGPTli1V+TBdzXdfaRHxPfyrklqp/hEAKuE2HETbJdxhXZLf1k0urWnU
 IZcU1+g/dq8xFlr85CgXegNBSj6eSV0Yx6vhK5fpFHK+CPB43WrpHWOzKBY3ALVn9CWa
 P1JwxeyDgXsHYrMVvoY9WcvfdV9BkMdk3i1/djjBE2W0lyuxTCt4QKlwA84Vp87sLSOM
 bbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681051609; x=1683643609;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oLmzVq0hxpZo50dklapmsCpWXglsYbkSNUJFkSRsb9s=;
 b=DZtNduqGJ3sZI8Ne5TIcYW7h1TxJvQ9Lz29ucf1Vd/jMr8ja/Eqh7lXx4A48Nj3cQW
 qskd6BwZHrSlOp1pz29iNtUeRByLRqb3EEE6Hi6uLqkJSzyn9CNdD+5TbsbbztUV5jyy
 oAjrE9KK5bMlMBqeZVDmdzRRyK3amGAn7F2+yOPE8nGd3fV4g3Z5Xo6+iAvPo8oDpY98
 Kaz780sQp8kXGLWtmCv/IuFweGE+DRG+xFPjMfZcydZsJWMCUZcRsLFgNtcjMdRyf0bY
 HpKiWOe/Xo8SyL1q8rouBTfjei7Tc1TxMdFtuxqImtUH+N/LfVVzAlIbHd39hzEbiMkH
 su7g==
X-Gm-Message-State: AAQBX9c3aQYzDyfPibn9HvDHZbtRRKMTCVmqHsjwCVAtrwcvcNDx6f8U
 lns1X2HylDKH8eZIxodbLTzYbkDNP/+KnYs1yufumw==
X-Google-Smtp-Source: AKy350bl6C/FVhEhpM4F0TpucjoV8ehXC8p42PaObXMxfd2MOzzkPTYXwzcICqcb1ZoSGHmAiMEnfQ==
X-Received: by 2002:a17:906:73ca:b0:93b:dddf:4be2 with SMTP id
 n10-20020a17090673ca00b0093bdddf4be2mr4370529ejl.3.1681051609676; 
 Sun, 09 Apr 2023 07:46:49 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a782:cc00::ab])
 by smtp.gmail.com with ESMTPSA id
 xj5-20020a170906db0500b00924d38bbdc0sm4155587ejb.105.2023.04.09.07.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Apr 2023 07:46:48 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: Reject submissions with too many IBs.
Date: Sun,  9 Apr 2023 16:44:43 +0200
Message-Id: <20230409144445.374816-1-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.40.0
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
Cc: alexander.deucher@amd.com, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 christian.koenig@amd.com, maraeo@gmail.com, timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of failing somewhere in the scheduler after the
ioctl has already succeeded.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2498
Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
 3 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 995ee9ff65c9..8db6618b9049 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -113,6 +113,15 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (!entity)
 		return 0;
 
+	if (entity->rq && entity->rq->sched) {
+		struct amdgpu_ring *ring = to_amdgpu_ring(entity->rq->sched);
+
+		if (num_ibs > ring->max_ibs) {
+			DRM_DEBUG("Rejected a submission with too many IBs");
+			return -EINVAL;
+		}
+	}
+
 	return drm_sched_job_init(&(*job)->base, entity, owner);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index dc474b809604..933cb95a0e30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -324,6 +324,11 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	ring->max_dw = max_dw;
 	ring->hw_prio = hw_prio;
 
+	if (ring->funcs->emit_ib_size) {
+		ring->max_ibs =
+			(max_dw - ring->funcs->emit_frame_size) / ring->funcs->emit_ib_size;
+	}
+
 	if (!ring->no_scheduler) {
 		hw_ip = ring->funcs->type;
 		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 3989e755a5b4..7a295d80728b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -245,6 +245,7 @@ struct amdgpu_ring {
 	unsigned		ring_size;
 	unsigned		max_dw;
 	int			count_dw;
+	unsigned		max_ibs;
 	uint64_t		gpu_addr;
 	uint64_t		ptr_mask;
 	uint32_t		buf_mask;
-- 
2.40.0

