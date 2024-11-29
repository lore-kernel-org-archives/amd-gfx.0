Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457D9D729E7
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2024 15:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C4A210E4EE;
	Fri, 29 Nov 2024 15:17:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hgPyL/F3";
	dkim-atps=neutral
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
 [209.85.208.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8301110E4EE
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2024 15:17:08 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-2ffdf564190so23039981fa.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2024 07:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732893427; x=1733498227; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zU/sDYwVdz5Zv0Y/eiAXcxydJfMlKxuQlK2x/BfM9Pc=;
 b=hgPyL/F3jhhMAFJ2Eku7wTJ+knRhNSD7SI1Z6yjtyq+RXmYJZEqTBT3BcbE782Pe5O
 CqMoMSVKHnEEcW8na5ZeIyXDEMz1j0fpowcJB9udoPrOFbtgVoybqCOFktlerPoA9FZg
 iXsz8/OuY6qqWeFfV2BRYzzTx3hp4MCXaZqn5EZbywWfsQRzRR9T4gFDM/Tfzas2W64j
 oGGjUhVzfhXLHfN6YDOkDOWdu9Up75lIW56Wgv5k39QFW/UAAgXak/hbqpIka40ZFhBe
 7m2B0G89/Ce3KMce1syj61NYYO2McmwiaUFTnukACP13E3DLdXrsFRG0QGuvtV7bckxD
 UGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732893427; x=1733498227;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zU/sDYwVdz5Zv0Y/eiAXcxydJfMlKxuQlK2x/BfM9Pc=;
 b=Ce90GRXmvxCXO7DJwn6I0vAV1tolt2b6dorXXuqkQD2zw4HSAh2i3OgsUX0fCRDUGH
 zxIuoOShn3AbdlPDTxcONc0jDjjm3cX1i2vONJdy94nnqUVWI+aSKlxDBSLzgw/F4ZcX
 D/I4RszT1zfUPoDD3gT1MuT+OedTvqVycLxOIVpjhuUjBbGnKuqSupFsAklU6GGrWUO8
 UmoqVt0meh2zSsOm+v3NVaEPw4YvCxOWwgztHeFboL96F+Id/dwyoWqnlIIyIsqhmH9m
 pC4lWDNL3WZabl0Lt/mD74Ig9yLY8CDaiVX/rDvydrwPapMSougfz0JYFaYV+LLr5xwI
 bXgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnC4C+QZe4wHsQyDd9qnvIp4Vi8vzZrjgfdyJotJX8dY0qEtkOuHVOJC9ZFgWwtsObi7V16NB+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxkgakaviJ5x31sbi1aaOBwnOcl28OQlpP4xcBx33zS/DwL3d0I
 jKtwl2fnQXNlrWRwdJAr4lRApjFKnk6j3U62wtBFIa2kV7ZL2gfx8gwN6XQcfJ0=
X-Gm-Gg: ASbGncvxLQvM5QsY0PdARRfWyB25Ki5icY4jqG/VOT4iy7gEyfwGWmAXjf3VLsj/htG
 YPVWVgS8M/c+qh6Qppuq9Vr/Mi8LFUx/jL8n9gdzd+eh++Aj+c9tRbdBMDgM2gtNtkbS+6q+Dba
 u4nuf0b8hnW3H0gyz/l6p6yFdPEin++tvGccmavIthioerN9mjvkfhXFNgwFV9K7PnJal4pb0+f
 k8mvpBXgqe5sc41Se2ky6wx52NirgCRrA9J+PoZPyCp7NoFN/6KrhrpBdOZag==
X-Google-Smtp-Source: AGHT+IElalCXNUH/+KZur1MK4139Dff0ckUmPxqc2IeKXrWdMQM2LptF+AUjxvblOTUsjUo+52chLA==
X-Received: by 2002:a17:906:3d31:b0:a9a:61d:7084 with SMTP id
 a640c23a62f3a-aa581065dd5mr822482866b.50.1732892937171; 
 Fri, 29 Nov 2024 07:08:57 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:1561:8f00:5e1d:ebce:50d:d557])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5999731d5sm181572166b.200.2024.11.29.07.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2024 07:08:56 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Arunpravin.PaneerSelvam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix UVD contiguous CS mapping problem
Date: Fri, 29 Nov 2024 16:08:55 +0100
Message-Id: <20241129150855.2187-1-christian.koenig@amd.com>
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

When starting the mpv player, Radeon R9 users are observing
the below error in dmesg.

[drm:amdgpu_uvd_cs_pass2 [amdgpu]]
*ERROR* msg/fb buffer ff00f7c000-ff00f7e000 out of 256MB segment!

The patch tries to set the TTM_PL_FLAG_CONTIGUOUS for both user
flag(AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) set and not set cases.

v2: Make the TTM_PL_FLAG_CONTIGUOUS mandatory for user BO's.
v3: revert back to v1, but fix the check instead (chk).

Closes:https://gitlab.freedesktop.org/drm/amd/-/issues/3599
Closes:https://gitlab.freedesktop.org/drm/amd/-/issues/3501
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 17 +++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c |  2 ++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index d891ab779ca7..5df21529b3b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1801,13 +1801,18 @@ int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
 	if (dma_resv_locking_ctx((*bo)->tbo.base.resv) != &parser->exec.ticket)
 		return -EINVAL;
 
+	/* Make sure VRAM is allocated contigiously */
 	(*bo)->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
-	amdgpu_bo_placement_from_domain(*bo, (*bo)->allowed_domains);
-	for (i = 0; i < (*bo)->placement.num_placement; i++)
-		(*bo)->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
-	r = ttm_bo_validate(&(*bo)->tbo, &(*bo)->placement, &ctx);
-	if (r)
-		return r;
+	if ((*bo)->tbo.resource->mem_type == TTM_PL_VRAM &&
+	    !((*bo)->tbo.resource->placement & TTM_PL_FLAG_CONTIGUOUS)) {
+
+		amdgpu_bo_placement_from_domain(*bo, (*bo)->allowed_domains);
+		for (i = 0; i < (*bo)->placement.num_placement; i++)
+			(*bo)->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
+		r = ttm_bo_validate(&(*bo)->tbo, &(*bo)->placement, &ctx);
+		if (r)
+			return r;
+	}
 
 	return amdgpu_ttm_alloc_gart(&(*bo)->tbo);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 31fd30dcd593..65bb26215e86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -551,6 +551,8 @@ static void amdgpu_uvd_force_into_uvd_segment(struct amdgpu_bo *abo)
 	for (i = 0; i < abo->placement.num_placement; ++i) {
 		abo->placements[i].fpfn = 0 >> PAGE_SHIFT;
 		abo->placements[i].lpfn = (256 * 1024 * 1024) >> PAGE_SHIFT;
+		if (abo->placements[i].mem_type == TTM_PL_VRAM)
+			abo->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
 	}
 }
 
-- 
2.34.1

