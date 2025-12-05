Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D59D2F7EF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 13:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0475210EB40;
	Fri,  5 Dec 2025 13:40:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Vz1AJ1QG";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B50710EB3C
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 13:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1bCuWsWIgYS42M8q499eGmUXlKLc/2YhCsM0VLRCLUQ=; b=Vz1AJ1QGlJw88pTxDpXx60rcjT
 iCZSlk1fpVgFbYyAW3w24/1v9WxefMUJV+fTNuS8V8jVxHdvbmybwmjXPTYL6zRN3BS7/ey4MteCV
 0KO4kze+Y5mZYI6isIDMPemZSr5rBPe9dQfe5BnjwZuqnX7bx6P0217qMacjCxfHdIqrMMw0D2+Ba
 x+MusoGRzaRxMXadDYJPCLTzLYUEIjsbiTSeeDZpA8kKqH8xj8v1ZY8v8yUmQ5OYn2hq0v9aHoA3X
 t7H207oJVNW5D1GBosgLOYehFP+MytnHUUhQLln61763/p7MjO4jUmh2zQWVWFd9Umxi6jXRiaNaT
 I9sWz53g==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with utf8esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vRW3B-0095hn-Jg; Fri, 05 Dec 2025 14:40:45 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 11/12] drm/amdgpu/userq: Stop looking after finding ourselves
Date: Fri,  5 Dec 2025 13:40:34 +0000
Message-ID: <20251205134035.91551-12-tvrtko.ursulin@igalia.com>
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

When amdgpu_userq_fence_driver_destroy walks the xarray of registered
fence drivers in order to remove itself from it, it can stop iterating
once it has found itself.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 38d120c72edf..8ec7f6b65d51 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -200,8 +200,10 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
 
 	xa_lock_irqsave(xa, flags);
 	xa_for_each(xa, index, xa_fence_drv)
-		if (xa_fence_drv == fence_drv)
+		if (xa_fence_drv == fence_drv) {
 			__xa_erase(xa, index);
+			break;
+		}
 	xa_unlock_irqrestore(xa, flags);
 
 	/* Free seq64 memory */
-- 
2.51.1

