Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E3E606A319
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=NdJFAu6J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D2F710E9FA;
	Tue, 20 Oct 2026 13:27:51 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41C3410F583
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 13:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=vBDCdHT8YwdIk682TigQWUd1YnBKs09E+dEg4BTAJdc=; b=NdJFAu6Ji4sdQ9Yu5Ibb1AcmnI
 zScOQJNCupDrUXDlw1Jr8n93JLX59uv7kC1kKKrFISRs2MAUHoxOvYDDCeT46u5UmafBk7XB8v8FT
 QH6O0OVAdC0Z4GqywdD+3cnsV1iNapHsOmfX3BXd7OWL2c9L8MfETgbOQys8fsun0w3XTOOp6klnA
 AdrE6kYWqvOIvW4yQgkb7zxgyt89WNLKFhfI5h8gDDvpclcm49MYA/DS69DFZr0fLaCEl9bj6jyL2
 U3UwDuL9OacYbNHMDqv+vqPy8xRfuoVVdKs4thdePDxKViR+W8Y22tBnNSQz+g+iACEOmKU/HDwWB
 ns4+YNgA==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJ9sU-004c6I-D4; Tue, 20 Oct 2026 15:27:42 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/3] drm/amdgpu: Size the buffer_funcs array by maximum number
 of SDMA instances
Date: Tue, 20 Oct 2026 14:27:37 +0100
Message-ID: <20261020132739.31852-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020132739.31852-1-tvrtko.ursulin@igalia.com>
References: <20261020132739.31852-1-tvrtko.ursulin@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The array is populated from a loop capped by adev->sdma.num_instances so
it makes sense to size it using AMDGPU_MAX_SDMA_INSTANCES and save some
memory.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index adb6cfae5052..9856a2fc2d08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -30,6 +30,7 @@
 #include "amdgpu_vram_mgr.h"
 #include "amdgpu_hmm.h"
 #include "amdgpu_gmc.h"
+#include "amdgpu_sdma_types.h"
 
 #define AMDGPU_PL_GDS		(TTM_PL_PRIV + 0)
 #define AMDGPU_PL_GWS		(TTM_PL_PRIV + 1)
@@ -89,7 +90,7 @@ struct amdgpu_mman {
 
 	/* buffer handling */
 	const struct amdgpu_buffer_funcs	*buffer_funcs;
-	struct drm_gpu_scheduler		*buffer_funcs_scheds[AMDGPU_MAX_RINGS];
+	struct drm_gpu_scheduler		*buffer_funcs_scheds[AMDGPU_MAX_SDMA_INSTANCES];
 	u32					num_buffer_funcs_scheds;
 	bool					buffer_funcs_enabled;
 
-- 
2.56.0

