Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2137EA4FAE
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 12:41:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 463DA10E390;
	Mon, 23 Feb 2026 12:41:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="MsUcDV7E";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21AB110E382
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 12:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=64zQje8HQ2bC3nTNb40nw60Ch4w5bLuGu90/LuzA7y4=; b=MsUcDV7EU36D7cYHsxzzwEUARD
 eC8GcEyfl3VrrZZ2cp/w4vp+DMDb1cM7/Dd/f8oXiA26WJ57ppO4a44o2Wx0Sl84NujIHR4tGABNw
 haze9xbI4zHADS2T1xMMhKENMqXplCMoOZz4COZcN2Y6UWd+Vq+Gg4nkN1vhqydUMdR73T/J6R3ml
 gRgQaUEnjKlv+LSfV4i94Fd2d4QPpfrQLRYIjSY+MWGDDFF+awwJ6k55Z6gkmllupNqnsJQC251Be
 pb94FuWhRKXib3LcQmDgxckr0ENRQvyy6n3g0sRj2ZjCaTl8CnwoA/FnzHIbRmO+hiRMGonJHBkGx
 PFnabPWw==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vuVG5-004EKz-Du; Mon, 23 Feb 2026 13:41:53 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v2 09/12] drm/amdgpu/userq: No need to xa_erase before
 destroying the xarray
Date: Mon, 23 Feb 2026 12:41:38 +0000
Message-ID: <20260223124141.10641-10-tvrtko.ursulin@igalia.com>
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

xa_destroy will free all internal xarray memory so no need to do it
manually.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a136289103a9..e8389dab8444 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -130,11 +130,8 @@ static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
 		return;
 
 	xa_lock(xa);
-	xa_for_each(xa, index, fence_drv) {
-		__xa_erase(xa, index);
+	xa_for_each(xa, index, fence_drv)
 		amdgpu_userq_fence_driver_put(fence_drv);
-	}
-
 	xa_unlock(xa);
 }
 
-- 
2.52.0

