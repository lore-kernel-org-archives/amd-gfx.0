Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DD7C3600C
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Apr 2025 07:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 632AE10E914;
	Thu,  3 Apr 2025 07:29:20 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D85FE10E914
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Apr 2025 07:29:18 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 5337TBCM555333; Thu, 3 Apr 2025 12:59:11 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 5337TBe8555332;
 Thu, 3 Apr 2025 12:59:11 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the comment to avoid warning
Date: Thu,  3 Apr 2025 12:59:10 +0530
Message-Id: <20250403072910.555319-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
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

Fix the below comment warning
drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c:541:
warning: Function parameter or struct member 'adev'
not described in 'amdgpu_sdma_register_on_reset_callbacks'

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 0a9893fee828..c3c6f03190c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -531,6 +531,7 @@ bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_rin
 
 /**
  * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks
+ * @adev: Pointer to the AMDGPU device
  * @funcs: Pointer to the callback structure containing pre_reset and post_reset functions
  *
  * This function allows KFD and AMDGPU to register their own callbacks for handling
-- 
2.34.1

