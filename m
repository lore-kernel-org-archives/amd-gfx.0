Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B997CF2565
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 00:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F150E10E211;
	Wed, 19 Nov 2025 00:24:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="gRDAZ4v7";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D272810E211
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 00:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3bUC+/4lCLosfxYLwIa7VCTQ+zRe9R20tkghQ7wsR5s=; b=gRDAZ4v7p1gyiXSrZfkRSjfObu
 pQTYIaNTgGdWpGeUy30y4O3CZWUzIvw1Pm1HU/FdcN11qkBsW+ml7PR2T+Vm7oFZvbbOUdpMFsM9A
 tQhIq9ZJp15Nv1raEPmg+JiC9UtQ5Obk3wrQMqMDKd56kzN8aftRhYJugpunRke58HFYGRgaf+gbq
 Mr3RE0Qkt8XhkZKd84ZRHH9dsSY1iNg4+nmaH0IZFc4EVc6jgxUb7kKxhkNRNyd4RWxOvh9upqL9w
 EqaMQDyF7sT+kJxa203bm7id2zUo2HeSIM6wQpz8OLjrHxyEgVyEKM29doe0rPrKBeeLy2ESSCWGh
 FpDwLiSQ==;
Received: from [104.193.135.201] (helo=debian.home.app)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vLVzZ-002MdZ-No; Wed, 19 Nov 2025 01:24:13 +0100
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Mario Limonciello <superm1@kernel.org>
Cc: Robert Beckett <bob.beckett@collabora.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v4 2/2] Revert "drm/amd: fix gfx hang on renoir in IGT reload
 test"
Date: Tue, 18 Nov 2025 17:22:38 -0700
Message-ID: <20251119002348.4118647-3-siqueira@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251119002348.4118647-1-siqueira@igalia.com>
References: <20251119002348.4118647-1-siqueira@igalia.com>
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

The original patch introduced additional latency during boot time
because it triggers a driver reload to avoid a CP hang when the driver
is reloaded multiple times. This has been addressed with a more generic
solution that triggers the GPU reset only during the unload phase,
avoiding extra latency during boot time. For this reason, this commit
reverts the original change.

This reverts commit 72a98763b473890e6605604bfcaf71fc212b4720.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 9785fada4fa7..42f5d9c0e3af 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -853,10 +853,6 @@ static bool soc15_need_reset_on_init(struct amdgpu_device *adev)
 {
 	u32 sol_reg;
 
-	/* CP hangs in IGT reloading test on RN, reset to WA */
-	if (adev->asic_type == CHIP_RENOIR)
-		return true;
-
 	if (amdgpu_gmc_need_reset_on_init(adev))
 		return true;
 	if (amdgpu_psp_tos_reload_needed(adev))
-- 
2.51.0

