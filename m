Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6BFD0BB7A
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 09:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4070910E8DC;
	Thu, 24 Oct 2024 09:23:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="rukmjX8Z";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B11410E8D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 09:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ISDYs3Nbb0/YrdYCrJ055OB6gWltwFVdCKFq4Sbpfy4=; b=rukmjX8ZtCdcvpYeTN1GdU+ufU
 lSnzur2nR7OCzlJuQA2AcD18VMWyXotj1WTl5FYql4nRpH3YC6fHynRChDz80Ne8et3kMgeLKzTfj
 8T88VQxooz/uuOhsnx0E8fRgEQ4ERh64nCGYhMnDDTu+2oYluMx8HO1Av6azBNkrHGmhJ3Pcdim42
 0o6YhaBm2cwj+k0kbkJXMskufucIaiNg2nIEAr/Ulx9xwJvtzIPSZS9GKvepyjBCzi9fY/xdO3moR
 K1htBHJprcma0zgKdIkgnZEinUur2planH3BsO6CASCoCFY2lQ8D/XwWS1zHBHqMjde1FtXC7i8gZ
 UAHmz/pQ==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1t3u4J-00ERFI-JW; Thu, 24 Oct 2024 11:23:47 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Yunxiang Li <Yunxiang.Li@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH 3/4] drm/amdgpu: Stop reporting special chip memory pools as
 CPU memory in fdinfo
Date: Thu, 24 Oct 2024 10:23:40 +0100
Message-ID: <20241024092342.98760-4-tursulin@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241024092342.98760-1-tursulin@igalia.com>
References: <20241024092342.98760-1-tursulin@igalia.com>
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

So far these specialized on chip memory pools were reported as system
memory (aka 'cpu') which is not correct and misleading. Lets remove that
and consider later making them visible as their own thing.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Yunxiang Li <Yunxiang.Li@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 0d3fb6b4212e..b5f65ef1efcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1209,17 +1209,6 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
 		type = res->mem_type;
 	}
 
-	/* Squash some into 'cpu' to keep the legacy userspace view. */
-	switch (type) {
-	case TTM_PL_VRAM:
-	case TTM_PL_TT:
-	case TTM_PL_SYSTEM:
-		break;
-	default:
-		type = TTM_PL_SYSTEM;
-		break;
-	}
-
 	if (drm_WARN_ON_ONCE(&adev->ddev, type >= sz))
 		return;
 
-- 
2.46.0

