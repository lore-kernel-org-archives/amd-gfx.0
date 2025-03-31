Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5286EC36010
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Mar 2025 13:02:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A86410E121;
	Mon, 31 Mar 2025 13:01:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L7HuTHxK";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2086C10E036
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Mar 2025 13:01:58 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-5efe8d9ebdfso1493025a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Mar 2025 06:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743426117; x=1744030917; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ptwsooYawCv1qPQk6h6711+LQgiatbFGaayfaDSJYu4=;
 b=L7HuTHxKRB30ERFVJJvizSOsMiNkSNQasSUXM4x+9sw5ubvckRU4u82Rao4NqJGGQy
 ykNz/KAFZrYHdWyml4tGt5iMK39uKrnsQgEULLze+o6jZWXWi0KqNEuWD4k8iFvrK3k8
 6me912jFxCFCuwisMqb8LVgcUaFfFB9//Ml+XfZIHx8reKbxGsF6gqGQ0nrTDJcF6IXF
 Tcg5L533IavjbDeR06Oyqg7yV/gVuuXwmSY46RiWXzn9OGjdRpiEZCMVsg03s51U2eNe
 BqkSe6V1Q7fS7NwQ4WBGo6agDgrETuf7GfZr/xfZ1LI93eGdkdw74o7nJSDrkbZvKV8g
 B0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743426117; x=1744030917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ptwsooYawCv1qPQk6h6711+LQgiatbFGaayfaDSJYu4=;
 b=IkO+2LSgq5kMI3Vi9hEUN3kxoKiWlaFmM6NfVZB9J4CP8JQspXn5oJFv4+Li6gUr6E
 Gzv3DCY5f7XhLEOS9+BpPyQ3WdefjFK8NPjXIZG6WBq53xrmAiscECG17lOOtFql0yQc
 ILHH2zKqecfToMA+5lcJJPmakV3CENYOgaPSH7J/w2bQbm2skMO6dJWFTPWhfcocx8F3
 nuyNyapn/s+/vEI2eyldVX6a97yVtA6LnEGDG5sq/Dg1y1AZ/r1wMnxqiBQkoGxra/Fl
 E0fRLeFy8263ED/aIEZOa7cB8m0xT+5HlPJNZ9sIYq708sLhZrFYByKTnzyT74Sxq9DA
 DwNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVToOn1qNc0j3q3i346drDX967pcEy7U9qOlyedfTFMi9+Rrdh3zvhQ8eie816JeDmJYYl5/CR+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzNuBGt4S3zyXC3kcTBylDGNTtA2W+rl4wSiI2eRZkx0XD20ajF
 sN5dQ8HPvBEVwVtYWShcDDy7h+4xfWPA2cYUsiywd2KzxgjNCk+UOdGFgMoa
X-Gm-Gg: ASbGncvrRxrChJVLWO/35vmNttPop9iKD35OmrBuh6ALTfdfSQHW2fTXM+dFFXOGhBb
 621xygWMI92+uHD5KWPbz1J9DoqF5y/yDONmR/mv8ubpktNaD6wiPdXOMRsjnACeHIAbeCbialH
 LvTTo60HISK9lfEPma/PSWswN0b18rws4eIi9cdLO+S5oOLQhLStxG6wETRWQ53jE/p7bpzfnuq
 aXgvYeuTl+rOBlkOI3Ac980etBuRb77avEZTFF0EfXtvNrESJLH955iAXsre72sLHbSEY5VYDsW
 B0tr01yytV1aKIQ7hpS13Re9hoKq7WNN6kTxyBL+h3V/kK8SebN1kdXQ9w==
X-Google-Smtp-Source: AGHT+IFC68Oq0GFMr7VMDqg5cd0vuddY944vgPW12yuLkApvzFkQXnlBaFN+nKe2A+RSIRy6dpsm6g==
X-Received: by 2002:a05:6402:4403:b0:5e5:bcd6:4ad8 with SMTP id
 4fb4d7f45d1cf-5edfce94945mr6705633a12.9.1743426115834; 
 Mon, 31 Mar 2025 06:01:55 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1526:9900:4cdf:63ca:5640:79f6])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5edc16ed61esm5598206a12.34.2025.03.31.06.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:01:55 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: revert "always sync the GFX pipe on ctx
 switch"
Date: Mon, 31 Mar 2025 15:01:52 +0200
Message-Id: <20250331130152.2342-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250331130152.2342-1-christian.koenig@amd.com>
References: <20250331130152.2342-1-christian.koenig@amd.com>
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

This reverts commit c2cc3648ba517a6c270500b5447d5a1efdad5936.

Turned out that this has some negative consequences for some workloads.
Instead check if the cleaner shader should run directly.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 802743efa3b3..5eab1c1a380c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -191,8 +191,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	need_ctx_switch = ring->current_ctx != fence_ctx;
 	if (ring->funcs->emit_pipeline_sync && job &&
 	    ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
-	     need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, job))) {
-
+	     (amdgpu_sriov_vf(adev) && need_ctx_switch) ||
+	     amdgpu_vm_need_pipeline_sync(ring, job))) {
 		need_pipe_sync = true;
 
 		if (tmp)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b5ddfcbbc9fc..5f0f9e4beea9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -689,7 +689,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		patch = amdgpu_ring_init_cond_exec(ring,
 						   ring->cond_exe_gpu_addr);
 
-	if (need_pipe_sync)
+	if (need_pipe_sync || cleaner_shader_needed)
 		amdgpu_ring_emit_pipeline_sync(ring);
 
 	if (cleaner_shader_needed)
-- 
2.34.1

