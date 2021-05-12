Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1E9C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 18:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F986144A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 18:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F986144A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC98F6E0E1;
	Wed, 12 May 2021 18:03:50 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 368946E0E1;
 Wed, 12 May 2021 18:03:49 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C81D96143A;
 Wed, 12 May 2021 18:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620842628;
 bh=xo2BE0jRTsQlvSw0irHZvlNT7/Jy4g468u2AeXVwLzY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=riXLWLVmZtvXCPWhhmnCVWYBAHyQU6F6qn+yWwYZJnIcSYqJHrFK95Kbx1G9FuvcR
 9/xq76MwMREF40REbPtdF4j/yxZqJhld51cNcO8iQ4rRhVGFLOl0y7qTBVpDmJ2/E1
 PyDf5sXfAVRVRsmrXpGxqLovD5yiVe5menYkbQvIlr4NH3uktorHnI709ShrH2mQf2
 GkwdG4/MBgVz0dDLjjeX3U7ue46yT1i/deUshs8h5O2GaXE8maRWAPwql9L3K7Njpj
 bTQ5KQYjWuj23wMeGmjhQ2VkTlc8IaXel/9gc9MazCP7qDZw1M2dKJUZJGAwVw2Bdd
 cT9W+FacEQhEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 24/34] amdgpu/pm: Prevent force of DCEFCLK on
 NAVI10 and SIENNA_CICHLID
Date: Wed, 12 May 2021 14:02:55 -0400
Message-Id: <20210512180306.664925-24-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210512180306.664925-1-sashal@kernel.org>
References: <20210512180306.664925-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Darren Powell <darren.powell@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Darren Powell <darren.powell@amd.com>

[ Upstream commit b117b3964f38a988cb79825950dbd607c02237f3 ]

Writing to dcefclk causes the gpu to become unresponsive, and requires a reboot.
Patch ignores a .force_clk_levels(SMU_DCEFCLK) call and issues an
info message.

Signed-off-by: Darren Powell <darren.powell@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 5 ++++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index f2c8719b8395..52df6202a954 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1110,7 +1110,6 @@ static int navi10_force_clk_levels(struct smu_context *smu,
 	case SMU_SOCCLK:
 	case SMU_MCLK:
 	case SMU_UCLK:
-	case SMU_DCEFCLK:
 	case SMU_FCLK:
 		/* There is only 2 levels for fine grained DPM */
 		if (navi10_is_support_fine_grained_dpm(smu, clk_type)) {
@@ -1130,6 +1129,10 @@ static int navi10_force_clk_levels(struct smu_context *smu,
 		if (ret)
 			return size;
 		break;
+	case SMU_DCEFCLK:
+		dev_info(smu->adev->dev,"Setting DCEFCLK min/max dpm level is not supported!\n");
+		break;
+
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 31da8fae6fa9..471bbb78884b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1018,7 +1018,6 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 	case SMU_SOCCLK:
 	case SMU_MCLK:
 	case SMU_UCLK:
-	case SMU_DCEFCLK:
 	case SMU_FCLK:
 		/* There is only 2 levels for fine grained DPM */
 		if (sienna_cichlid_is_support_fine_grained_dpm(smu, clk_type)) {
@@ -1038,6 +1037,9 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 		if (ret)
 			goto forec_level_out;
 		break;
+	case SMU_DCEFCLK:
+		dev_info(smu->adev->dev,"Setting DCEFCLK min/max dpm level is not supported!\n");
+		break;
 	default:
 		break;
 	}
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
