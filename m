Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2C7C3ABC9
	for <amd-gfx@archiver.kernel.org>; Sat, 10 May 2025 19:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAFCB10E051;
	Sat, 10 May 2025 19:02:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hY/LgUA1";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1AF210E0C5
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 May 2025 19:02:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 9D01EA4726F;
 Sat, 10 May 2025 19:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66553C4CEE2;
 Sat, 10 May 2025 19:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746903742;
 bh=G45MZhKOVyBEzGgepP3wRSkj4iFRcUI/9Fv0xQct6gc=;
 h=From:To:Cc:Subject:Date:From;
 b=hY/LgUA1hCYNydAanU9mgF+9tAofnqWY1Bzt5DI6tGRGKMtQbzsbHxKscF1/XlI9z
 3TcxUSzVM4DII1AVpad8oSV/uEUEtc+OQF19BTZftmdevvWiFsQaIufC56+5lY8sNK
 dyWwdpvCdqZUKn+JiJZ07fh4BFqSPsKdcXSYBGSPkh6CfngoZpXYxLi7f1y83oa+Gs
 YbzQRoYSVFS+2tTbXc4TiF96Q8utzJ7v6u94xmpG2onaB8KO8d6LGzYFL3D8zXxhYD
 klKqaSERyUHwlOLdOSf71SPfVKP+Z6rQICvdBAEdByiNwuvhDCrNbLPGF5+5ZC71AO
 5G28ZBhElqAOw==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>, stable@vger.kernel.org,
 David.Wu3@amd.com
Subject: [PATCH] drm/amd: Turn off doorbell for vcn 4.0.5
Date: Sat, 10 May 2025 14:02:16 -0500
Message-ID: <20250510190216.3461208-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
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

From: Mario Limonciello <mario.limonciello@amd.com>

On VCN 4.0.5 using a doorbell to notify VCN hardware for WPTR changes
while dynamic power gating is enabled introduces a timing dependency
that can sometimes cause WPTR to not be properly updated. This manifests
as a job timeout which will trigger a VCN reset and cause the application
that submitted the job to crash.

Writing directly to the WPTR register instead of using the doorbell changes
the timing enough that the issue doesn't happen. Turn off doorbell use for
now while the issue continues to be debugged.

Cc: stable@vger.kernel.org
Cc: David.Wu3@amd.com
Closes: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12528
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3909
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index ba603b2246e2e..ea9513f65d7e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -181,7 +181,7 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 
 		ring = &adev->vcn.inst[i].ring_enc[0];
-		ring->use_doorbell = true;
+		ring->use_doorbell = false;
 		if (amdgpu_sriov_vf(adev))
 			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
 						i * (adev->vcn.inst[i].num_enc_rings + 1) + 1;
-- 
2.43.0

