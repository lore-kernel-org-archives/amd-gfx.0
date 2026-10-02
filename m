Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576E6CA5FC4
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 08:32:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9A4110E85D;
	Fri,  2 Oct 2026 08:32:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.b="EU6hgenZ";
	dkim-atps=neutral
Received: from smtpout1.mo540.mail-out.ovh.net
 (smtpout1.mo540.mail-out.ovh.net [51.210.91.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 959DD10E6B4
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 08:32:53 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net [79.137.60.221])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4hx28z1WYYz427T;
 Fri,  2 Oct 2026 08:32:51 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net. [127.0.0.1])
 by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.deucher@amd.com>; Fri,  2 Oct 2026 08:32:51 +0000 (UTC)
Received: from mta11.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.37.58])
 by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hx28z018vz6MWL; Fri,  2 Oct 2026 08:32:51 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.8])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta11.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 9095B9A19B9;
 Fri,  2 Oct 2026 08:32:50 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S003f1ccdee4-1c52-4c4b-94f8-e846f8386462,
 DC8B761EC6BD655BE6CB70D306B6091D09A22BEC) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 88.133.252.134
From: Natalie Vock <nat@pixelcluster.dev>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Use real_vram_size in GDDR training BO placement
Date: Fri,  2 Oct 2026 10:32:33 +0200
Message-ID: <20261002083233.16768-1-nat@pixelcluster.dev>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 7796575381887214068
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTETXVrmTgs+kZUOAxyoqqysU2dDffFo8cZmt17C8/wHOwFdo/bwi5+rIpYfqAV7LeGR355IYsAMXCg0p0dyjMqdZrB9+iuHeW2e+cTiaPvFjQitUXWDAMygZKHPC/F6s1RCkBLCP1Sy+d4Lc44hsgikOxqanhnt9BEi3n4uGhTBSW8eVz1kC7Z3QBFFni/hpQv1k7T+L7giLOkSSf7Th4tPOC+SJsWCokJ0mtRbteuw646Ybugr9okpfgESRgdO+0Yu1Rpy0NpqUPddQn9e1tU56sneJe7jhr30zIzkXUucnSQNaQGiXYfSOrsI/uxypufQCcVE1z9YK+aq+XDhaLv0QVOlenys4y4LKOfbbY5xU4zgWoY/YOi02OFGWOEbkxq392Fy3UFgMaO9e9hTexIWNzVEqDD5Pdnven8EAwbmiSZ4BeEikne5aLjYW2DnqWBhyzoMEPTgWQJy96CLUAZZju+q1L1r+W3RrMUC3Yuet4liE5AIjEaOTxZOmAsUOYn1Gk0M0WF75MfSpiaeQR03iTD/NyawrbA/cUQLUO7TZkM+etho6RqeeUf0UW7kXXV470EDTHRm1hIgY29JY1Ws+8RB0LmVcyLmi7OpXV5kDMRYJWAN2OwJRy5u520EyJSsm7YyBmZMxKtW5f5OPM68BHnjmREZMKWI63E6c6EK8w
DKIM-Signature: a=rsa-sha256; bh=4zYenkOsxTWUtqfzMbVEtKhtYL/SOJdP0wRK2B5WBlI=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1790929971; v=1;
 b=EU6hgenZkn0YP01p/7BCC+jaSuBvwdbC6YuZV6WopCF9OScopGX3XUzMebWFAc3ZlVwCayc1
 rylptXhI4Yv2K1RJ2YdM/jDGNzgT5Qk9uU7aLkdnQsUJNDEXEjX7+FDhwjnqShA5x7M4IZh7/7e
 BGCWFYJ8v26BB0e1cUYH6BbtQhy9NharkUsbe4TT/O143/twPGqGBpvvCxbeqLECZ6rmiMctwKp
 EB1S4m+dMRztvZIPuH1sXCC+VW8MPlm2ScZqPphbXrFEMWaZCE9CjzqGrraVtJ/ADjJiAvQotlG
 nZ1npQ9ga8R+A+ceH5wATZbpCkVZosLR/EbV18tVZ4WNw==
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

Otherwise amdgpu.vramlimit breaks on GFX10.3 because the BO offset is
out of bounds.

Signed-off-by: Natalie Vock <nat@pixelcluster.dev>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 3d620ec2937f4..b77c94178296e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1798,7 +1798,7 @@ static void amdgpu_ttm_init_mem_train_resv_region(struct amdgpu_device *adev)
 		return;
 
 	reserve_size = adev->mman.resv_region[AMDGPU_RESV_FW].size;
-	offset = ALIGN((adev->gmc.mc_vram_size - reserve_size - SZ_1M), SZ_1M);
+	offset = ALIGN((adev->gmc.real_vram_size - reserve_size - SZ_1M), SZ_1M);
 	amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_MEM_TRAIN,
 				  offset,
 				  GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES,
-- 
2.55.0

