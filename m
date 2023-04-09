Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9E2C77B61
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Apr 2023 19:02:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99A7610E1F1;
	Sun,  9 Apr 2023 19:02:07 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6549310E1F1
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Apr 2023 19:02:05 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-94a34c33e88so9614766b.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Apr 2023 12:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1681066920; x=1683658920;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oLmzVq0hxpZo50dklapmsCpWXglsYbkSNUJFkSRsb9s=;
 b=eQRKfRYki7z4v8KgGgEHJ6tb9SdppAnHEMZa2mxVv5QYK30XdWFckb48FHLZLksjfs
 zVUBCiYKUQWefWUXWYnA/ZeAfbD6xMJ8/jLFpF6AyhxwP/Bu0cbqR2n6kbvfwfIe4Ldp
 qFLpN8PSkYE8DohzGYOUd2DWuzPiaBdPvDyh3CMDYKlQdQr3MyQZEBCTmFLXLtZDTjzn
 IyljdagTUgrjeZ1gFReKm8Z3ojMvXfHahaIk4kF5W2IJYtHzbdwoJtehKnH7AqxLfkQg
 qrVgVXZcORXsBsYzmTyLPVGiq5RJv//Js8M+9ZS15J7eIer121drQ+WXO/oLe1tPqIa1
 CeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681066920; x=1683658920;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oLmzVq0hxpZo50dklapmsCpWXglsYbkSNUJFkSRsb9s=;
 b=tavCZ//x0O6q6zEHOA1f0O5u3xWLv9NoBMuZWtQ8bR+9F6k5y470YvOVIwTN4sI4TK
 QNTGWQaKAnqPtaJEY+7Wazypm4U6+M/krrD4T8TorMDDt2oJ/0KuhsMyZRjUJTfZfGsY
 MLQZ9CGObrobkTKBK3SaRPJGaWPeKKTXjSz0aWFzTOc772e93IIxPubjrH8H9xXqRksD
 dsuMYkzhC2iLARN5nM1keUmsf9mWcP9I2LxthKj8VV1Gzp3gC6HTDqlhMLOsnkN8VF/H
 RIU7jvd0cOi6U+9TDhnK/OzbuPSRu7PYTegxoArj1UtfBtDzOY3cToHJIw2PLQSdR3hF
 gIRA==
X-Gm-Message-State: AAQBX9dh5Wg2yQw3mF4ZRU2IeeeEGUzrWow815Mlta0yGhTIvmR3Y57L
 GDR9DAgEIny8j5dFm/VFmuZlnBlSC/DM85Sf3TZysA==
X-Google-Smtp-Source: AKy350Z0qPzF3od/YYHonXnI7Ir+hEoDMImez//0+HZ9WBSX41P9DpWKET6fnza4vdSz3nmww1DPFA==
X-Received: by 2002:a17:906:51cd:b0:94a:5f0d:d9d6 with SMTP id
 v13-20020a17090651cd00b0094a5f0dd9d6mr2880159ejk.4.1681066920303; 
 Sun, 09 Apr 2023 12:02:00 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a782:cc00::ab])
 by smtp.gmail.com with ESMTPSA id
 xb4-20020a170907070400b0094a71869153sm730693ejb.46.2023.04.09.12.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Apr 2023 12:01:59 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 1/3] drm/amdgpu: Reject submissions with too many IBs.
Date: Sun,  9 Apr 2023 20:59:54 +0200
Message-Id: <20230409185956.725016-1-bas@basnieuwenhuizen.nl>
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

