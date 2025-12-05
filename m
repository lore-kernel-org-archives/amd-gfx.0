Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7E7D2F7F9
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 13:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB21710EB39;
	Fri,  5 Dec 2025 13:40:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="rU1NAvB3";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDE7610EB39
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 13:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EG5nZm08yCwUSGjeygmlTFxYfKOgtZVlXi7B2hF3qnQ=; b=rU1NAvB3QNU7nwgnmLIDEUbBYe
 yo83+uQr5q4Y83OINvuDy3dsIORXJ8GT0QpfTUcVNQk1/K6gkWLu97kLUiaAho+3lMTY4MANL+jWj
 c492CXcVgSCXVU9tTsOeGCdLYM4eJF1Hkcz47CvyKFvn2tmNspOMac/mfhroyNhh6mEXwRwDcbxkg
 6iAakI9fQhLMl9lpJ7tWmFROefpiA62h3NTqv8TkTrFc/x3HMbT1SXojGdBXRaLqrFqaMHQ0zhUdp
 uaMZJ8HP85QZOFolU9IXmzkY/9A7HWeS3/WWeZMFXPNhm2xrd/n7F3Z8FFz2RBNWco3IYtCXdzAqa
 j8NKBADQ==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with utf8esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vRW3A-0095hQ-3y; Fri, 05 Dec 2025 14:40:44 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 09/12] drm/amdgpu/userq: No need to xa_erase before destroying
 the xarray
Date: Fri,  5 Dec 2025 13:40:32 +0000
Message-ID: <20251205134035.91551-10-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251205134035.91551-1-tvrtko.ursulin@igalia.com>
References: <20251205134035.91551-1-tvrtko.ursulin@igalia.com>
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
index 11992d05f8d4..a96b84c48acb 100644
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
2.51.1

