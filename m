Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D94EA4FAE
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 12:42:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9524510E398;
	Mon, 23 Feb 2026 12:42:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="MKe3Q6hK";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F3710E38E
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 12:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=elohd8CHo20brlbaUdw+aCDYCZp0EKT3AzS1BMYGrck=; b=MKe3Q6hKlPWrh8QhR/u8HoQ+f/
 9s45zIrDWdQ7CRz6bZJ0Ghc9qbtt2wnmo4FY6ViynJ6fcj5eSwoCOjPxR28ZRKBRGtxUd/FzFndLD
 +cF86B7+r8yPPiXaE9FXuxDPrfaP1zaQZ1q5vRZXsUa2PdX1lAxVpbZTyKnx/f/8FDl750kDVtger
 hqjtDStWp5fEmJqCsJbDlyTh28pMaFEUfMZJkmBHCoNSnsp/Wvx5lwC2k6tweENzVoxi/IUNQ19BQ
 yC2YGugAkXp5wcUT/TQ/tytPZ/cHyDgPqp7foZBukaJ2p0pr8Nhwun9MJ+Iv6z9CbSlM/fBaDGrJy
 i+J4YN2Q==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vuVG7-004ELP-IC; Mon, 23 Feb 2026 13:41:55 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v2 12/12] drm/amdgpu/userq: Drop redundant conditional from
 the irq path
Date: Mon, 23 Feb 2026 12:41:41 +0000
Message-ID: <20260223124141.10641-13-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260223124141.10641-1-tvrtko.ursulin@igalia.com>
References: <20260223124141.10641-1-tvrtko.ursulin@igalia.com>
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

amdgpu_userq_fence_driver_process callers always pass in valid fence_drv
so the function itself does not have to do it.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 1328fd87c10e..3d591fa99dce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -151,9 +151,6 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
 	u64 rptr;
 	int i;
 
-	if (!fence_drv)
-		return;
-
 	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
 	rptr = amdgpu_userq_fence_read(fence_drv);
 
-- 
2.52.0

