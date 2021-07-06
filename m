Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7235EC11F6C
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 11:17:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38ED861C9B
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 11:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38ED861C9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DD6A6E223;
	Tue,  6 Jul 2021 11:17:28 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D30F6E217;
 Tue,  6 Jul 2021 11:17:27 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5324A61CC3;
 Tue,  6 Jul 2021 11:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625570247;
 bh=+gJwqH3qnoQPAxy9N5oXl0R72nGKihjj2Ere3lD/uGE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=c96PTx90zQu2iIZsfxotCuXhno1bl6k4tYzcCrxodzq+VhCAxWiXNvCOBesZehdtN
 1vMZEsYpLzgXey0r57aYd0pfwPqZ/wx0MB3xh3FeKoCSW4Q1kIGB9iHe9dMC6RbPdr
 QN5o6WJBWkMQwDIb9eSF4m9yzP/St+wC5F4+TrZjnY0tTv1JuwmAbv2ujQUYONY1Wt
 xv5+3N90q6qCpoABuPwLjT6FFFjqGxd4twgRbpHbhsJsJdU6iK5GIcFm6pChE7duWc
 m3XBmnu3HE71ytT8utvgQJBbG2pfuX9t4laFOAgUMxRdoq0lxTg7Mrku+Iq26dCXjy
 L/Xemd9T8g/zQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 146/189] Revert "drm/amdgpu/gfx9: fix the
 doorbell missing when in CGPG issue."
Date: Tue,  6 Jul 2021 07:13:26 -0400
Message-Id: <20210706111409.2058071-146-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706111409.2058071-1-sashal@kernel.org>
References: <20210706111409.2058071-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yifan Zhang <yifan1.zhang@amd.com>

[ Upstream commit 962f2f1ae273399e357a3192d5413ca57f9b4885 ]

This reverts commit 631003101c516ea29a74aee59666708857b9a805.

Reason for revert: side effect of enlarging CP_MEC_DOORBELL_RANGE may
cause some APUs fail to enter gfxoff in certain user cases.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index c09225d065c2..516467e962b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3673,12 +3673,8 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_ring *ring)
 	if (ring->use_doorbell) {
 		WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,
 					(adev->doorbell_index.kiq * 2) << 2);
-		/* If GC has entered CGPG, ringing doorbell > first page doesn't
-		 * wakeup GC. Enlarge CP_MEC_DOORBELL_RANGE_UPPER to workaround
-		 * this issue.
-		 */
 		WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
-					(adev->doorbell.size - 4));
+					(adev->doorbell_index.userqueue_end * 2) << 2);
 	}
 
 	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
