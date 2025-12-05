Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A216D2F7F8
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 13:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8B2F10E18A;
	Fri,  5 Dec 2025 13:40:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="W30tYrlv";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5746210EB39
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 13:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LnAskB4+CsH1tmDtnwUcQETY/u9FdoD2PJfTICwS9MM=; b=W30tYrlvuYsn55Xs30M3/Eb3PB
 wt86E5gxqTSPCZrXrfY+kHttIPmRnlyFVe3OJX+s4X+Us3hdqIEvMycah21tGQOKswXjLBKO2Kb4p
 Tq1ggZXlaai73tn8K2mrQZpqI37n4H8kSDsMpeZBnqP6AjSfk4XDI9NbBtTDf7i7f0eYMJKbbl9b9
 xZVh/VDVo3R/woTdWnyxdAJbRQC+bBc5Q93oidHEoErRfjQVmOF+fHqVEA4E8lb1It6yD5zqIwIAM
 3fb2Eg76DeqzKMJKUpaNOcYtDaX/yHcjbyPGLOlyOXXbMstzFwcB987+AQmVtw7+ssR2Jvpfqn6zd
 NI2OewXA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with utf8esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vRW38-0095h8-KI; Fri, 05 Dec 2025 14:40:42 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 07/12] drm/amdgpu/userq: Use memdup_array_user in
 amdgpu_userq_signal_ioctl
Date: Fri,  5 Dec 2025 13:40:30 +0000
Message-ID: <20251205134035.91551-8-tvrtko.ursulin@igalia.com>
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

Use the existing helper instead of multiplying the size.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index f979e896c714..6bddba2d8ba1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -471,8 +471,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	u64 wptr;
 
 	num_syncobj_handles = args->num_syncobj_handles;
-	syncobj_handles = memdup_user(u64_to_user_ptr(args->syncobj_handles),
-				      size_mul(sizeof(u32), num_syncobj_handles));
+	syncobj_handles = memdup_array_user(u64_to_user_ptr(args->syncobj_handles),
+					    num_syncobj_handles, sizeof(u32));
 	if (IS_ERR(syncobj_handles))
 		return PTR_ERR(syncobj_handles);
 
-- 
2.51.1

