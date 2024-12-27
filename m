Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5C5E7718F
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Dec 2024 11:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 403BF10E3A2;
	Fri, 27 Dec 2024 11:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="sVdsuO0y";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB1110E07E
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Dec 2024 11:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+HNhWYQu/oHR6XaDYm/fM63JB4TPo9VvG729Khs413k=; b=sVdsuO0yBx8lpkTSAj61lxfhX3
 V6ptZFsukUqhtSkmo4f4IClL+75y98cckLP1ITMEeQ97s7hOalBB6UYNMciznKYyC/3Nz57+A/rrm
 QmRMTt1Sv6Ix2FzbZS15kZXuJtoR4vSR7pH/1/v+G5hJxAtdStAzTTR+V+cgS1kAnyjhLvYuGbq00
 IIIiSLMcmzGDDN2z3wha6nmLEi66zG3qHDlncCO5dy7LU2/JXzfWot8IiNI8luc5sJQf9n7YHPfv3
 i8JIy+U1jaEIqYtuGY8fQSwAsAuiBXaB8t71pT71iTkup/AWVsdzjIgIRhlj4Q8GmPaWUfiIPBTBw
 ORIE82yw==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tR8Nl-008EGm-U3; Fri, 27 Dec 2024 12:19:54 +0100
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 06/12] drm/amdgpu: Use amdgpu_ring_fill() for VPE padding
Date: Fri, 27 Dec 2024 11:19:32 +0000
Message-ID: <20241227111938.22974-7-tursulin@igalia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241227111938.22974-1-tursulin@igalia.com>
References: <20241227111938.22974-1-tursulin@igalia.com>
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Equally as with SDMA, the padding requirements for VPE are not great (16)
so this is only done for consistency.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 121ee17b522b..6c20ea754618 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -459,14 +459,13 @@ static int vpe_resume(struct amdgpu_ip_block *ip_block)
 
 static void vpe_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	int i;
+	const u32 nop = ring->funcs->nop;
 
-	for (i = 0; i < count; i++)
-		if (i == 0)
-			amdgpu_ring_write(ring, ring->funcs->nop |
-				VPE_CMD_NOP_HEADER_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
+	if (count == 0)
+		return;
+
+	amdgpu_ring_write(ring, nop | VPE_CMD_NOP_HEADER_COUNT(--count));
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 static uint64_t vpe_get_csa_mc_addr(struct amdgpu_ring *ring, uint32_t vmid)
-- 
2.47.1

