Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC5AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 00:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE0E110FA99;
	Tue, 12 Apr 2022 00:44:28 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CC3310E651;
 Tue, 12 Apr 2022 00:44:27 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4D532617B6;
 Tue, 12 Apr 2022 00:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AC7C385A4;
 Tue, 12 Apr 2022 00:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649724265;
 bh=bjCjhv8haIP+MHw/BiUZCXR2FoFiviSuC5QqBleHCf0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Q9nXT6KdbSeElXWTgMqgOakxkplwFBO/zioNdQ6OucigbdeXxnnh3Tft/oLlHlbBm
 dywm5FTxrEO1zKQy/NUY44lnPo/Qegb1n6zDkfEXPV0QSYYNu6Y5fTUBHHPQQndWf2
 Ud9UMKayVGW+LVXt2XJcCwslVhTkQ48+2ijRDv805sqMVOVyLYk/zlEhJvpcjQ917T
 WPjZmbrj4iO3pctuFvUiJ3Cc+MtL/gkb17S+6SRDN1SK7bPx3uLhA0C7XR5fKLeeyt
 sJfXleU3jxEU2FnnuHD2hnm/a3tSoSIzI8aV9gnif0CkM3kHLcQSx5IYT+yHnyJUFw
 4R7UnZ3aVUqTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.17 05/49] drm/amdgpu: conduct a proper cleanup of
 PDB bo
Date: Mon, 11 Apr 2022 20:43:23 -0400
Message-Id: <20220412004411.349427-5-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412004411.349427-1-sashal@kernel.org>
References: <20220412004411.349427-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, tao.zhou1@amd.com,
 Guchun Chen <guchun.chen@amd.com>, airlied@linux.ie, Xinhui.Pan@amd.com,
 amd-gfx@lists.freedesktop.org, YiPeng.Chai@amd.com,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
 Alex Deucher <alexander.deucher@amd.com>, victor.skvortsov@amd.com,
 john.clements@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Guchun Chen <guchun.chen@amd.com>

[ Upstream commit 2d505453f38e18d42ba7d5428aaa17aaa7752c65 ]

Use amdgpu_bo_free_kernel instead of amdgpu_bo_unref to
perform a proper cleanup of PDB bo.

v2: update subject to be more accurate

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 88c1eb9ad068..34ee75cf7954 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1684,7 +1684,7 @@ static int gmc_v9_0_sw_fini(void *handle)
 	amdgpu_gem_force_release(adev);
 	amdgpu_vm_manager_fini(adev);
 	amdgpu_gart_table_vram_free(adev);
-	amdgpu_bo_unref(&adev->gmc.pdb0_bo);
+	amdgpu_bo_free_kernel(&adev->gmc.pdb0_bo, NULL, &adev->gmc.ptr_pdb0);
 	amdgpu_bo_fini(adev);
 
 	return 0;
-- 
2.35.1

