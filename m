Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0100DC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 09:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82E1210E231;
	Wed,  3 Jan 2024 09:58:34 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4165E10E1C4
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 04:30:31 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d4b650bc9cso16565585ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jan 2024 20:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704256230; x=1704861030; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qVUiudBZUdb1uSPPsgXwU95+QiMyNR9J0Fh7R6Wj/Zc=;
 b=HsR2CwV5z00knoMH3uIO8j40E1/ADa0oT9Ko5Z+fNm10v2ymUhQk996CPGZbFXXSY/
 lv4A6csIQFQF3+WWvmTHx0jstcQ2A+mVqZcog3uYv5NioMT3OH+lR0gC/kBFhRPUKlAG
 EmgF4Esu8zu9QlEM2bxWFqbQa3v/x+lDhIkjZpgKhYb95ts/AdV0b3KehJlM4VZzg3s5
 0HFKwqSFQRg4r+MMGVVbhd3YcLUpvbG/4l5DSAXoehhGbGr6kddz25z6IpktBx+VHEcV
 QfewlUXmZb5H70qO9Qpq4UFJzF827GhfKymqWQdHTVe8reidzktoBEAns/7SGc5jkz/d
 2i6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704256230; x=1704861030;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qVUiudBZUdb1uSPPsgXwU95+QiMyNR9J0Fh7R6Wj/Zc=;
 b=YOguUj9T2YVMLo7VmZdqLZFOHnJA10wyHKDErNwWD8GeXgORnZrq+7mfJflN9uS7SW
 NrSHMDL6WvtTMcVo+f8vor3dcUZYhckNfHpFmnMokFwO2cWma1USYGJzftXqVhLz9u7H
 In74jWgFP2b3gqlm/Ed5CUDy+KfSN7yS2b0xAnVxvdQmqlThUkvOJe42632w9FpYO40F
 wioMDYoJhtJGicQ1fIjaeQMyupNZFkHAXp9YAg8gBzQ9df5yGnZmo7eIB1FPMY1i0PAR
 F89B840RUaJZc40/xBZeR2dTJ2vPOlaOJtXkMMTSgfjjiQQZkNih1/GfT9V+GMfcUj0e
 QYpA==
X-Gm-Message-State: AOJu0Yy+17se5a9Ev+nEPYGankTx3ZEj5CsY2fxMGJxQG6is64R/2cnj
 PLV88HhT4ZBacvAexnMNnGPPzsYpQ39sflHT0lzi3A==
X-Google-Smtp-Source: AGHT+IGTmROd+q7yry3y7X9Flihq2US+ndWrABOYh95CffBLPDB4gW80yy7uklzKA/XVt+NSmZwkng==
X-Received: by 2002:a17:902:ebcd:b0:1d4:91ac:ce9a with SMTP id
 p13-20020a170902ebcd00b001d491acce9amr12515964plg.135.1704256229747; 
 Tue, 02 Jan 2024 20:30:29 -0800 (PST)
Received: from localhost.localdomain ([47.243.86.188])
 by smtp.gmail.com with ESMTPSA id
 e12-20020a17090301cc00b001d052d1aaf2sm16563169plh.101.2024.01.02.20.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 20:30:29 -0800 (PST)
From: Kaibo Ma <ent3rm4n@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amdkfd: Relocate TBA/TMA to opposite side of VM
 hole"
Date: Wed,  3 Jan 2024 12:29:56 +0800
Message-ID: <20240103043000.23971-1-ent3rm4n@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 03 Jan 2024 09:58:33 +0000
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
Cc: Kaibo Ma <ent3rm4n@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

That commit causes NULL pointer dereferences in dmesgs when
running applications using ROCm, including clinfo, blender,
and PyTorch, since v6.6.1. Revert it to fix blender again.

This reverts commit 96c211f1f9ef82183493f4ceed4e347b52849149.

Closes: https://github.com/ROCm/ROCm/issues/2596
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2991
Signed-off-by: Kaibo Ma <ent3rm4n@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 26 ++++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index 62b205dac..6604a3f99 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -330,12 +330,6 @@ static void kfd_init_apertures_vi(struct kfd_process_device *pdd, uint8_t id)
 	pdd->gpuvm_limit =
 		pdd->dev->kfd->shared_resources.gpuvm_size - 1;
 
-	/* dGPUs: the reserved space for kernel
-	 * before SVM
-	 */
-	pdd->qpd.cwsr_base = SVM_CWSR_BASE;
-	pdd->qpd.ib_base = SVM_IB_BASE;
-
 	pdd->scratch_base = MAKE_SCRATCH_APP_BASE_VI();
 	pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
 }
@@ -345,18 +339,18 @@ static void kfd_init_apertures_v9(struct kfd_process_device *pdd, uint8_t id)
 	pdd->lds_base = MAKE_LDS_APP_BASE_V9();
 	pdd->lds_limit = MAKE_LDS_APP_LIMIT(pdd->lds_base);
 
-	pdd->gpuvm_base = PAGE_SIZE;
+        /* Raven needs SVM to support graphic handle, etc. Leave the small
+         * reserved space before SVM on Raven as well, even though we don't
+         * have to.
+         * Set gpuvm_base and gpuvm_limit to CANONICAL addresses so that they
+         * are used in Thunk to reserve SVM.
+         */
+        pdd->gpuvm_base = SVM_USER_BASE;
 	pdd->gpuvm_limit =
 		pdd->dev->kfd->shared_resources.gpuvm_size - 1;
 
 	pdd->scratch_base = MAKE_SCRATCH_APP_BASE_V9();
 	pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
-
-	/*
-	 * Place TBA/TMA on opposite side of VM hole to prevent
-	 * stray faults from triggering SVM on these pages.
-	 */
-	pdd->qpd.cwsr_base = pdd->dev->kfd->shared_resources.gpuvm_size;
 }
 
 int kfd_init_apertures(struct kfd_process *process)
@@ -413,6 +407,12 @@ int kfd_init_apertures(struct kfd_process *process)
 					return -EINVAL;
 				}
 			}
+
+                        /* dGPUs: the reserved space for kernel
+                         * before SVM
+                         */
+                        pdd->qpd.cwsr_base = SVM_CWSR_BASE;
+                        pdd->qpd.ib_base = SVM_IB_BASE;
 		}
 
 		dev_dbg(kfd_device, "node id %u\n", id);
-- 
2.42.0

