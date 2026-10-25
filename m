Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BF8606A31E
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SgEXdrRg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1690E10ECB0;
	Mon, 26 Oct 2026 08:43:52 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E47C910E594
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Oct 2026 10:03:45 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c38ac26cc5dso309467366b.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Oct 2026 03:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792922624; x=1793527424; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0Yxeotn9elHO28Le0gR3TB0nelJehzXUOqHvl8ZvmtE=;
 b=SgEXdrRgVfwbldTnQUvRTRpwFWEZ5xU3wC4RAXzcvIKdxQh6mmZ+/gGlXhZLL3I0TR
 ptC64hvGSXGJ4GDZgYDjwiRBFDXqKm9Dw1m/itQUpvvqe3wYNEmPlriT3MOgxMgD9EzY
 paXqZ6LDHkT4njlmkoR5KbevmpYg/7WUftlCNVGPa84XkWaSKTl8mNXKbVIMC9qof6Xr
 eKL3/u5Iro02xLKxP5igtVcEIrZszrv9J61zoXCGxI2KrlVs2moySFGPJ16Yl264evaB
 r1qDOf+hBNeJXmBFzb7YPso+4RpLyLh197Y229Ke2rrglvA+kYZQ5gBknuvRDbk34OSc
 mRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792922624; x=1793527424;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0Yxeotn9elHO28Le0gR3TB0nelJehzXUOqHvl8ZvmtE=;
 b=Rbcexd1qGwt4v191Dx+7LSbLQVO3DnR2JF+vUprA91LXzSJp3RXmrCDWiDJrUpZhAG
 Nc2NkoP9ilbCHU7RKgesjRxsUyx6rfNWdeHVKr/FUzCfU4EfhLcfvPkIM+DCa+s0fLfv
 jSDoGkSyix66bNPAkbs0bcLMCvew7vflcITgKnxHkChZqZA+lt4g1c/AyEWRo6t/MM0N
 2b8ywc6ritl50XjAmUMJvWuQ5zp8O5bfnItbXs98E6CQeAlUOqqbgjJpNQ03RQoWiZDr
 PeJhHknmToKYN1h7uTxSYzbQxSpdo204CuTk0ovpPKGBCwWRXFGGIqK2T0fHTl0GkJLS
 UAeg==
X-Gm-Message-State: AFq9FYI6NXJ9lBnj2P/BoSzy/yRSMedpjjztP1uaFVBXVthziNTuRy/l
 ge2hAMPqHZx0+QdQ1HlzRDDKxEMRWvdr6KNVfof0ckkyo4W0iZGMISjtPX2sWv25
X-Gm-Gg: AYBFou3rHHVOcEIExU6x9YNaVFme/eyI+UQfU68S4wm9JXwXJ4JjUf3+Gond5YxNtuK
 96VpD+chq/kI0fjVVanJOv5mu7m6KSKG/O3mW69ztVwkcAWAl17Q1z8RQVxBEyJsDMAIqa7nnuB
 BA+Am6uA59upBoVJ8L+Cc5DXsx/lzVFM/SIIN+cfm9AyImnaiGMD3FxQbPOf9zuzqLFMEqsZar/
 2Az5mcKIIpg3TFCHmJijMeBcm4xPCHOeIDDJwq9DQgbzkRlAsNf7vL/lMdXp/VCB0B1KJZun1Yq
 gkylSHjAPvfig1aDNEu6lGr1Ja/tU1Zcks40pLYVq69eZd1fFEvkTnVATRvVFbU0AnIIzZPDB9D
 qUpdXJ7HwyKfCsHAQ4UXBAo233gQmnpU3oZX4SXqsPEwQw2OEhmb67sZJuUXGrMhkRa7d57XiWh
 JthMFPZKueVxn+VJd8W7g3giIe70G7/cbVwIFCGrY7hnKPbifYodfZeVJHGPhOi80p1g6SZOu+6
 Yyv9aByKuyOuV4Mf9A73NswYfm4nTDJzVcRO2800OQxSexnXXHFlx4yeLclI/X86gk4LT40Qcgs
 VVw7YzzhM+J+Es7uf+52dwYPWWYjFtBM/vMK2SbWOV8eFdFw27F1OWVwdPy3u4unWA/4WLl7get
 3kM+mosJrcXqO5Uzzn4FpZx1DaoDTw15GEpzvG7YfPBZ726jgX5BA/guppVot+wUB6Ittv/nTdS
 HbJ5je+aC81+vEbhPofAmdFeF2xuO5iNf907DoNfoUA8O78pJKYNS8LWTzYSGs0VTWQOn4VanX8
 PtUED8jQDoT+B9MN7oK4jbBouoHgTzxEcDaxWN0BXmDh2Zjq2LqZQR8GrQzpcccRNs0rsVxzKVe
 MvpJLVPC44E=
X-Received: by 2002:a17:906:1012:20b0:c48:9228:bdcb with SMTP id
 a640c23a62f3a-c489228c5eemr32892066b.3.1792922623969; 
 Sun, 25 Oct 2026 03:03:43 -0700 (PDT)
Received: from albatros (ip-091-065-217-039.vkd74.pools.vodafone-ip.de.
 [91.65.217.39]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd66fa1asm186335166b.62.2026.10.25.03.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 03:03:43 -0700 (PDT)
From: Erhan Bilgili <erhan.bilgili@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Jack.Xiao@amd.com,
 Erhan Bilgili <erhan.bilgili@gmail.com>
Subject: [PATCH] drm/amdgpu: Fix duplicate dependency fence releases
Date: Sun, 25 Oct 2026 11:03:32 +0100
Message-ID: <20261025100332.110933-1-erhan.bilgili@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:43:34 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_sched_job_add_dependency() consumes its fence reference on success
and failure. Do not release the fence again if
drm_sched_job_add_dependency() fails.

Fixes: 41cc108b2451 ("drm/amdgpu: fix missing dma_fence_put in error path")
Fixes: c1c4a8b21721 ("drm/amdgpu: grab extra fence reference for drm_sched_job_add_dependency")
Signed-off-by: Erhan Bilgili <erhan.bilgili@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c    | 4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index d6ae9974c952..4f31021b2152 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -447,10 +447,8 @@ int amdgpu_sync_push_to_job(struct amdgpu_sync *sync, struct amdgpu_job *job)
 
 		dma_fence_get(f);
 		r = drm_sched_job_add_dependency(&job->base, f);
-		if (r) {
-			dma_fence_put(f);
+		if (r)
 			return r;
-		}
 	}
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 1f44c1cc2bd5..c44b02580dd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -235,7 +235,6 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 		dma_fence_get(fence);
 		r = drm_sched_job_add_dependency(&p->job->base, fence);
 		if (r) {
-			dma_fence_put(fence);
 			dma_resv_iter_end(&cursor);
 			return r;
 		}
-- 
2.56.0

