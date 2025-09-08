Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0F6CAC588
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 23:22:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C030810E5F9;
	Mon,  8 Sep 2025 23:22:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="gjt8vWig";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08F3210E5F9
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 23:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BuDeNydw0Lg6xXr+fDVvqRRq3iI7+7v6+tyFCBeBQ2s=; b=gjt8vWigfQfCpCAayAdEi3TGJD
 N3sWewoIm1McgfKX7r5Zu+Q5trTD0xPdpwDHWg4c1q2Y4XjLKYI4LtqyE2d86B6q9MYTOjM7JvEOs
 37FzVwTIBBmtYs33HSFh8ReTpyW/pzgH0jKkkc7gK1h1pcHE8xKlorqx5PSk3yKO0Hpbh25hkI6OI
 t0CrMbxMHJtD9C6dIzqbiFaf2zGfyrzRELSuf2oLEuLP/xloVM4/U/VKLTiSY2LY7owweCFH8WryT
 X1hIXU5NWpuxbQ7JGaoVyN2ijIOMSdna9UQR8RzfogAikt2vk/OW0cxxq5QnElrYFbL+fJ9aFq/og
 +/tSJYaA==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uvlBg-008iqD-VX; Tue, 09 Sep 2025 01:22:17 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 4/5] drm/amdgpu: Remove volatile from amdgpu and amdgpu_ih
 headers
Date: Mon,  8 Sep 2025 17:15:39 -0600
Message-ID: <20250908232134.2223198-5-siqueira@igalia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250908232134.2223198-1-siqueira@igalia.com>
References: <20250908232134.2223198-1-siqueira@igalia.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove the unnecessary use of volatile in some of the amdgpu.h and
amdgpu_ih.h headers.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h    | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 6d123172bb0a..0e6a09651bbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -721,7 +721,7 @@ int amdgpu_cs_wait_fences_ioctl(struct drm_device *dev, void *data,
 /* VRAM scratch page for HDP bug, default vram page */
 struct amdgpu_mem_scratch {
 	struct amdgpu_bo		*robj;
-	volatile uint32_t		*ptr;
+	uint32_t			*ptr;
 	u64				gpu_addr;
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index 7f7ea046e209..f58b6be7fccc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -56,14 +56,14 @@ struct amdgpu_ih_ring {
 	bool			use_bus_addr;
 
 	struct amdgpu_bo	*ring_obj;
-	volatile uint32_t	*ring;
+	uint32_t		*ring;
 	uint64_t		gpu_addr;
 
 	uint64_t		wptr_addr;
-	volatile uint32_t	*wptr_cpu;
+	uint32_t		*wptr_cpu;
 
 	uint64_t		rptr_addr;
-	volatile uint32_t	*rptr_cpu;
+	uint32_t		*rptr_cpu;
 
 	bool                    enabled;
 	unsigned		rptr;
-- 
2.50.1

