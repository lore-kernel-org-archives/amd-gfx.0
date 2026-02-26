Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BD4FD8FCE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 15:49:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C034E10E994;
	Thu, 26 Feb 2026 15:49:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="j9lHhMRZ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CCF210E994
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 15:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NgDl/hJSalVp4GkPkSRdvWEtQrDC4lg+qG/rKDrUm3Y=; b=j9lHhMRZoUb3akzs//dDs4WUAJ
 8mjAvhopgvveTQUl4c0p41wBmrQ37Iz8kzqrz0MVixZlwBS0Hsyq9IRUhoiqoLKmjZTESn+KsV4fT
 bZ+LIgjn2V6d8ozap1NrVUptNszfWaxC7ggqrGe2tBxmlZt64oRolB9OR8sMaJcyNzuT6B8vmDWDH
 OKkRc/Mb2nfMhBORFdc4E71L9FhJUCG8LFjfUaPyTRPbIjIuuxrBIbp5JMoE52Bz/Mwz0R7vXRgGc
 D0x5zI2pqnkUvrB1WY3TYer7lw75ZPVMeW9hIHhuJ+zHLy9EOPG2sE4GxsKTun3z31FSpOnLuRA3b
 NcnmMl/Q==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vvdcK-005jvq-HY; Thu, 26 Feb 2026 16:49:32 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 kernel test robot <lkp@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu/userq: Remove impossible NULL check from
 amdgpu_userq_signal_ioctl
Date: Thu, 26 Feb 2026 15:49:18 +0000
Message-ID: <20260226154918.84354-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
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

LKP reports two suspicious NULL pointer checks, triggered by
4ca06f6fb45d ("drm/amdgpu/userq: Use drm_gem_objects_lookup in amdgpu_userq_signal_ioctl")
but these checks were redundant even before. Remove them.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202602262219.UY2pqzl2-lkp@intel.com/
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index ba128b2a2d49..0f941021fcf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -548,7 +548,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	}
 
 	for (i = 0; i < num_read_bo_handles; i++) {
-		if (!gobj_read || !gobj_read[i]->resv)
+		if (!gobj_read[i]->resv)
 			continue;
 
 		dma_resv_add_fence(gobj_read[i]->resv, fence,
@@ -556,7 +556,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	}
 
 	for (i = 0; i < num_write_bo_handles; i++) {
-		if (!gobj_write || !gobj_write[i]->resv)
+		if (!gobj_write[i]->resv)
 			continue;
 
 		dma_resv_add_fence(gobj_write[i]->resv, fence,
-- 
2.52.0

