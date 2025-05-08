Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6F4C3ABC0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 12:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B88810E8F4;
	Thu,  8 May 2025 12:05:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bDfCK9N/";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25FEF10E8F4
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 12:05:06 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-43d04ea9d9aso4720055e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 May 2025 05:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746705904; x=1747310704; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=DTCnTSa/5uYuDNNojvixfto9eXhE4J158SLNzgrVp+0=;
 b=bDfCK9N/vHUodDkECT4Esb8fVoho8h3dFhiy6IIkVUelDQDTkvyAtZaBzkIkrQhz6W
 YwnXWMM5zXj/jwTIMYLeam/iQA/pXc2QXirjl+77+5cimL1OYswyBb5br1/tEefNVvpm
 51xsmOGSEFXvGzpOmMm6YzLOu/UCddsEP1J/LhBYgTIa5Q0K66V+EtR/qyF3LONfwW2D
 5ls93mpII3URtw/eAHP7/hbXb2KQ3/8UM68oXz8yXbGpOnix82o9y+aR93q04cPnMB0n
 nsIIOvKYGRk15aJgZSW6CtQyj7Y/K4I4NuKC7GNPIC2ceoaW3kJzjsOLCTlEluLBYjMF
 yhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746705904; x=1747310704;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DTCnTSa/5uYuDNNojvixfto9eXhE4J158SLNzgrVp+0=;
 b=UbYqcdBXc3OeH6Kib9+yiIFoRts0/WLJB92Vmm62bF4exReZN6baR5GoHD3eYwoOr3
 rZ9YcbWVYYVbjxCpmNCrd7MmDEbcfuWbLJTkDl18L73xuupNBZstFe9lDqtb6k9c7sYE
 izDV7Vj61jbKVjKLgPKw+IkaSGwtOHczvy117yXRL2iNs3JLBzV0kE8lJxikbAmIJs7L
 uKvl9Fqo+/4Vt8YtCOB56TJ3Q7BG8yfCyJYLPLBmgKLayec+QWnoVlZPnMr4ViqlSnM8
 4E16KwTg/beEzy1ksyh/ZfLXQHdEZMGTkvjx73SjhwnPpIWTYOY8OhLNnZ65RrFR9tgI
 Zo4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7NeThw7iY0tM9KAjn/ZcahvWs+V6CZFuXo36kN85HO++CT9+fbt+JBeJs+DW/v+yntxruV2wN@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxLEADPV2zpci21EqDminn7ptxY0uJLC26nHH6nQeBwzK8T+qKF
 jzG567Gx9GkUw3R2kQA0D+YXH8Em0bORam64pg8FyEPGrFd0QmRRtQVCHA==
X-Gm-Gg: ASbGncvz/izLPsQ5ykoIphlycDU7+P6sxeC94odeQV8KwbKnO21a/nJ0fJBZ/I+pB0Q
 Y47opKrHt6EzcIClhOx2KzJoY6e+2eUT4l9pcUNmwn6pStMVAEe0kWnSTg8/JKqGyk1PehYbrJZ
 bfXAGC2PibZNQLagfGVKisEZm0guPGZ3UP8uVaRmYgh4l2vP7kq4ki6V9dNy0RPIuDqJDTarTQh
 DcBmjBbMqcj2IDQQhqwrByCISAo5o4vAkInpNQP4r+8G/YHB12+0AaKHkabxd1+HSywAK1GdkxV
 FjhCKxItWFfiJENUGf8yD8uT6nKZnAUv+zBAFATIX5D3ZBaIj68=
X-Google-Smtp-Source: AGHT+IHzuWaJnebVUnHCvbpp1m9b9UQ7pv9BK04UFtepMCGA2OV6/ZDrIdLtgcXjwpYZ0HQOpp9Ttg==
X-Received: by 2002:a05:600c:5249:b0:43d:10c:2f60 with SMTP id
 5b1f17b1804b1-441d44dd270mr60233815e9.24.1746705903898; 
 Thu, 08 May 2025 05:05:03 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1523:6000:25d8:9e9:d5ee:d76])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae0cafsm20255087f8f.19.2025.05.08.05.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 05:05:03 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: revert "always sync the GFX pipe on ctx
 switch"
Date: Thu,  8 May 2025 14:05:01 +0200
Message-Id: <20250508120502.1467-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
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

Not needed any more with the updated cleaner shader code.

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
index 3911c78f8282..0a80c011e678 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -801,7 +801,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		patch = amdgpu_ring_init_cond_exec(ring,
 						   ring->cond_exe_gpu_addr);
 
-	if (need_pipe_sync)
+	if (need_pipe_sync || cleaner_shader_needed)
 		amdgpu_ring_emit_pipeline_sync(ring);
 
 	if (cleaner_shader_needed)
-- 
2.34.1

