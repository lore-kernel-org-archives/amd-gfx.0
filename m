Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADBBD2F7F1
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 13:40:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4045B10EB3C;
	Fri,  5 Dec 2025 13:40:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="dxaD8/BF";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DA0C10E18A
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 13:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KnSVcnEckdgCaLRd57/XeUu9c2VnxNKDi3XK6Yp3qLk=; b=dxaD8/BFDO/xvkxlD5SWl8dRD/
 rpTSARaKjx+BLYnOBU34jVSiNXGEGyVzBSJGNxEPu2DaxwPSOXowNZLQiOj3hL5rPdNH16uCxp0WE
 UdpgXtqbz6Wg4/OOGs72Wi+Lf7Gl7HqYd+oJhTwOADBGN8n1X190xBgEwkmJwtuDmM6hKsv+DIo2j
 yZXU7AZRZ9ensKc9lyTx4zRzGIMhzMlo7Sbx8KT6TikQ2zhVxy7w5vKJXsqS3G3UrjzZspQquMBGo
 A0ubrq0kZMKiq0r3wkUY5vs5HW8g9ReFpbXRCSkFbPQQVPxwWvgYworNk/8eKF7YTxhsBf8mpYUh+
 ioqGFKTA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with utf8esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vRW3A-0095hX-S0; Fri, 05 Dec 2025 14:40:44 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 10/12] drm/amdgpu/userq: Use more appropriate lock in
 amdgpu_userq_fence_driver_alloc
Date: Fri,  5 Dec 2025 13:40:33 +0000
Message-ID: <20251205134035.91551-11-tvrtko.ursulin@igalia.com>
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

amdgpu_userq_fence_driver_alloc is always called from user context so use
xa_store_irq to streamline it a bit.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a96b84c48acb..38d120c72edf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -79,7 +79,6 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq)
 {
 	struct amdgpu_userq_fence_driver *fence_drv;
-	unsigned long flags;
 	int r;
 
 	fence_drv = kzalloc(sizeof(*fence_drv), GFP_KERNEL);
@@ -102,10 +101,8 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	fence_drv->context = dma_fence_context_alloc(1);
 	get_task_comm(fence_drv->timeline_name, current);
 
-	xa_lock_irqsave(&adev->userq_xa, flags);
-	r = xa_err(__xa_store(&adev->userq_xa, userq->doorbell_index,
-			      fence_drv, GFP_KERNEL));
-	xa_unlock_irqrestore(&adev->userq_xa, flags);
+	r = xa_err(xa_store_irq(&adev->userq_xa, userq->doorbell_index,
+				fence_drv, GFP_KERNEL));
 	if (r)
 		goto free_seq64;
 
-- 
2.51.1

