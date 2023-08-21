Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FFCEE49A0
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Aug 2023 06:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E2A610E1CF;
	Mon, 21 Aug 2023 06:21:02 +0000 (UTC)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4718F10E1C7;
 Mon, 21 Aug 2023 06:21:00 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-26b7bf38f53so179962a91.0; 
 Sun, 20 Aug 2023 23:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692598859; x=1693203659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fr3/zx/1/mwG0XIIQAkV8/bN6FVmc6iezYoOjzmg46U=;
 b=UFRzU4tij81CImjlYMxUo1jGNcXa4+9kPlVETglPuSbKCaM752rWCd3Oqt13cIRWy+
 p3FX75LHKagnaJTOC+i3OubXf1zLhwPmQkIzMbXYYV4Sg8WumqADZAn0UGBCfMmNx35j
 xgdqHmGGoi+wDpIDRXHpUWq9dEyw3sZzgj3I2bx1f68y4wOVKJWelCKGeVCXzv3kqEdV
 v7V/qKOzH9PcKpgkvfCqXF45Mf5GKhzmXS+c7JcjIJC1m7pDy0EWj2qO+l9yxh2++3qC
 IEZKRFSwaUK1S8mK3Cvd+HCLNhfv208yzbL19QkOVx97Qk11dil9tHYUiOLH07xuoTZD
 nZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692598859; x=1693203659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fr3/zx/1/mwG0XIIQAkV8/bN6FVmc6iezYoOjzmg46U=;
 b=NtgB6EAV6uWom9KQrGehfjCwTBJDNXsELSVn2zV+h6qFxSlZXqnWr3J10Fuxo4cGYx
 ecGPglOO2CaYv05wqAhIUXBicW8bL38fzlQph1uCU0vLzWW4nCEPolN9H8vxciNk8gna
 4tJhCQeRSr03QtDk/vc9QtS3xtC04mwhBQE9bTeVgdGy3VJqydSoASllt8QqDEoE8WrO
 ee9m5CeAhWZbUip5XdtgX0I8FxwteOQVb3lxAkD6TssM/ILLFu9K6NGp9c6tJSNZ3HTK
 QSo2CFoGiDToai+5VsyyK+ghLzd9PlFv6Gy2wv2ENlt/gEeVyyK+EQt4Vx2gy56E/JeW
 ISIA==
X-Gm-Message-State: AOJu0Yz5hjTUDMndRhivA2KYpMkQP6vRjhpvXNfIsmf7vpY1a3E2PyWf
 mqM+5WTCXKDmR3KRCgxMNEfgxRaFEfd8iAxJ
X-Google-Smtp-Source: AGHT+IFx3fr356Lp3puLhWPFqRyUER0LW5zfx4MDXQENjHdDM86EMSOrZdjvmZtchxT4khdujoE4Fg==
X-Received: by 2002:a17:90a:7524:b0:26b:27f6:9027 with SMTP id
 q33-20020a17090a752400b0026b27f69027mr5099617pjk.1.1692598859303; 
 Sun, 20 Aug 2023 23:20:59 -0700 (PDT)
Received: from localhost (zz20184013906F627101.userreverse.dion.ne.jp.
 [111.98.113.1]) by smtp.gmail.com with ESMTPSA id
 d24-20020a17090ac25800b00263e1db8460sm7155225pjx.9.2023.08.20.23.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Aug 2023 23:20:58 -0700 (PDT)
From: Tatsuyuki Ishi <ishitatsuyuki@gmail.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 2/4] drm/amdgpu: Allow explicit sync for VM ops.
Date: Mon, 21 Aug 2023 15:20:03 +0900
Message-ID: <20230821062005.109771-3-ishitatsuyuki@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821062005.109771-1-ishitatsuyuki@gmail.com>
References: <20230821062005.109771-1-ishitatsuyuki@gmail.com>
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
Cc: Tatsuyuki Ishi <ishitatsuyuki@gmail.com>, christian.koenig@amd.com,
 daniel@ffwll.ch, bas@basnieuwenhuizen.nl
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>

This should be okay because moves themselves use KERNEL usage and
hence still sync with BOOKKEEP usage. Then any later submits still
wait on any pending VM operations.

(i.e. we only made VM ops not wait on BOOKKEEP submits, not the other
 way around)

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Signed-off-by: Tatsuyuki Ishi <ishitatsuyuki@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index f10332e1c6c0..e898a549f86d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -51,7 +51,8 @@ static int amdgpu_vm_cpu_prepare(struct amdgpu_vm_update_params *p,
 	if (!resv)
 		return 0;
 
-	return amdgpu_bo_sync_wait_resv(p->adev, resv, sync_mode, sync_mode, p->vm, true);
+	return amdgpu_bo_sync_wait_resv(p->adev, resv, sync_mode,
+					AMDGPU_SYNC_EXPLICIT, p->vm, true);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index e259a51e7c56..8cb427710d66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -98,7 +98,8 @@ static int amdgpu_vm_sdma_prepare(struct amdgpu_vm_update_params *p,
 		return 0;
 
 	amdgpu_sync_create(&sync);
-	r = amdgpu_sync_resv(p->adev, &sync, resv, sync_mode, sync_mode, p->vm);
+	r = amdgpu_sync_resv(p->adev, &sync, resv, sync_mode,
+				AMDGPU_SYNC_EXPLICIT, p->vm);
 	if (!r)
 		r = amdgpu_sync_push_to_job(&sync, p->job);
 	amdgpu_sync_free(&sync);
-- 
2.41.0

