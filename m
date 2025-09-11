Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FAACA1016
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 12:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB14410EAE7;
	Thu, 11 Sep 2025 12:09:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gCJNdQnO";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1584D10EAEA
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 12:09:55 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-45b9814efbcso10990895e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 05:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757592593; x=1758197393; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LYf8izv2m816T/PJsMkEqU0AQGqCuAZ29iF0iSxRaf0=;
 b=gCJNdQnOBiyDkjrIB2lNWKBnh+5z6OZ0G/yGyYSdYcGow2V60UbTLjRy0KXpzk3Qtq
 b9f+0RglN8/hYhj4LOVbhdan9v9z7u4SeXTXJ5dIcY1Pnk6r+zP7XB4TOSF2a+Fz2dmW
 p0gcyUJMdLG1OZm63w+SP4I2djnh6ZtsXMlZlPIi1vTM4NJWb+1PahgQ30/PdouyTpvW
 oQXP27ol+42Vc0a0dr6DuS+O1LPRlmFMkJRP1h6lYTc/hf38yQLPQXgdzLFOPyNH0so2
 ws6qq6tLAIXrZFfI/TMVPD1iJHed4HIqFD2o/EES0dPsIS21b5X3hdXB1IZCdw72Cul7
 3JWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757592593; x=1758197393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LYf8izv2m816T/PJsMkEqU0AQGqCuAZ29iF0iSxRaf0=;
 b=pdKodf0G7bjhWk3kIW6Sm/jjY57c4XLLIIS6VLOowtkp82ckDHS+b3zN9PCMfqEfst
 0uhWNVoLkXroacDiEkE65paTHJwsuSGKBsfur5ItgfBzSRGo+Fk9spC+P9xi5EiQvX0x
 cHkX2nrfNVgjw90iwkueo7pkTyyfpJmyoKcG4C1I2NC4xG+WWH2Zm7c4QpKeat0FLSlJ
 aqLTPVBaqXZqN2DfZQO3STBtUz7349W6JIJS6jjisx4+IFK4lHSIk52/Uh764yFcqQHg
 RAFU4q/G2ROquR1olk808MDeT9RQQHMbtOEb5irmeT2VXCinLTMtCLdNed6RaYVScoGS
 88dQ==
X-Gm-Message-State: AOJu0YybdrnptD5RlmxvS9GhXN9h/E2lxNRIacKP++rNiYQBrdQ6D8ij
 GL0QkfiBiWty0QA66wI5I/niI1vkbZzzJ51IF87enRT8c1N5RymL9iBf
X-Gm-Gg: ASbGncsmFPEFW5PEydztBhjSwApnmNm/huhX3gExreuDdtrcxAWD1GS+PvXxGKWAh7W
 UbUvz96BALlPtuDuWRzAO1LwmGyeRt+bytWVaBbeMNUh6JOxrqsgXsHgNHiyZm0SpUbfdlh4Wlg
 ZqUG5F/ECP1vEGd7jOygXMV/3MWMsQE8jAjH52OEvdZ81Ipr7zKHh5EX5XwpfHUyVHP1OVfLtQL
 Rmqd9HPEgkUqowGB9B7JZepllHJyg8Ra8F0s5FuCvZ1sCdnc2ZXzct0SpwpSX/NBstvlEniUsAY
 uGZfoaVwn6U7NnijCF7iFRPUJrv+kz0ploC/7W3EtWeTfYAElHTTxW/JkXXrFTnF3WevLTnKvRC
 BJ2hxouiALxsYWKeisAPraxdEAjst8yLFgB1T
X-Google-Smtp-Source: AGHT+IGNB945RgK5uQwkhympkMRAmqCpX65YfCOqXUisBJfugRZ2TvJpIoQj2xAk/ff5QzL+NOE5Bg==
X-Received: by 2002:a05:6000:2501:b0:3d8:8f86:7afc with SMTP id
 ffacd0b85a97d-3e75e0f7e78mr3280999f8f.21.1757592593266; 
 Thu, 11 Sep 2025 05:09:53 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1539:fb00:efcb:f439:6900:a9d9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7607e1400sm2224744f8f.55.2025.09.11.05.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 05:09:52 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexdeucher@gmail.com, Sunil.Khatri@amd.com, Philip.Yang@amd.com,
 Prike.Liang@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: re-order and document VM code
Date: Thu, 11 Sep 2025 14:09:49 +0200
Message-ID: <20250911120950.3343-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911120950.3343-1-christian.koenig@amd.com>
References: <20250911120950.3343-1-christian.koenig@amd.com>
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

Re-order fields in the VM structure and try to improve the
documentation a bit.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 30 ++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 3409904b5c63..74e61e45778e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -349,12 +349,16 @@ struct amdgpu_vm {
 	/* Memory statistics for this vm, protected by status_lock */
 	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
 
+	/*
+	 * The following lists contain amdgpu_vm_bo_base objects for either
+	 * PDs, PTs or per VM BOs. The state transits are:
+	 *
+	 * evicted -> relocated (PDs, PTs) or moved (per VM BOs) -> idle
+	 */
+
 	/* Per-VM and PT BOs who needs a validation */
 	struct list_head	evicted;
 
-	/* BOs for user mode queues that need a validation */
-	struct list_head	evicted_user;
-
 	/* PT BOs which relocated and their parent need an update */
 	struct list_head	relocated;
 
@@ -364,15 +368,29 @@ struct amdgpu_vm {
 	/* All BOs of this VM not currently in the state machine */
 	struct list_head	idle;
 
+	/*
+	 * The following lists contain amdgpu_vm_bo_base objects for BOs which
+	 * have their own dma_resv object and not depend on the root PD. Their
+	 * state transits are:
+	 *
+	 * evicted_user or invalidated -> done
+	 */
+
+	/* BOs for user mode queues that need a validation */
+	struct list_head	evicted_user;
+
 	/* regular invalidated BOs, but not yet updated in the PT */
 	struct list_head	invalidated;
 
-	/* BO mappings freed, but not yet updated in the PT */
-	struct list_head	freed;
-
 	/* BOs which are invalidated, has been updated in the PTs */
 	struct list_head        done;
 
+	/*
+	 * This list contains amdgpu_bo_va_mapping objects which have been freed
+	 * but not updated in the PTs
+	 */
+	struct list_head	freed;
+
 	/* contains the page directory */
 	struct amdgpu_vm_bo_base     root;
 	struct dma_fence	*last_update;
-- 
2.43.0

