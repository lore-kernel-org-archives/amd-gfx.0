Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC12AC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 00:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF3DD615A2
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 00:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BF3DD615A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C02B89D61;
	Tue, 24 Aug 2021 00:54:51 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10E9A89D57;
 Tue, 24 Aug 2021 00:54:48 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC8D861411;
 Tue, 24 Aug 2021 00:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629766488;
 bh=hGpB3OYXSQsJAMtupy5tEoYQ9i3zYDhIn0ciJMdKmAw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qtpyr7KDiPj7zsKSkQJ9cayLd/buIICqpLopW4/zwgsZnTEYJGfafLhbVlEeHCWPP
 Lxic/GSoy/Y7r5XPmAVpBu0WVFksjDSWX44a4E1VY0xJNlSt7oytwn3dzWJC1M6xfA
 2CqDTSOWrmOtCuzD5rcdFBcsu9qqGmuxba0kFOellmSFi8L3HXlWwqAMDR/jrTyqyN
 rB/U978Kwc6xlh8jzcMUFLI6KeLXLjTnRCbi7jn0H52BmgTso8NdXKhs3Y3RC+i6RL
 2pwssWKGUKEhRlp/u+VqadL7CXLYgvMxHf3H5qUe/QdtSD8uDSuuSsApNtvWXZhcER
 FPcKJLJHsbPfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kenneth Feng <kenneth.feng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 12/18] drm/amd/pm: change the workload type for
 some cards
Date: Mon, 23 Aug 2021 20:54:26 -0400
Message-Id: <20210824005432.631154-12-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210824005432.631154-1-sashal@kernel.org>
References: <20210824005432.631154-1-sashal@kernel.org>
MIME-Version: 1.0
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kenneth Feng <kenneth.feng@amd.com>

[ Upstream commit 93c5701b00d50d192ce2247cb10d6c0b3fe25cd8 ]

change the workload type for some cards as it is needed.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index ed4eafc744d3..4dc27ec4d012 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -5122,6 +5122,13 @@ static int vega10_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
 	return size;
 }
 
+static bool vega10_get_power_profile_mode_quirks(struct pp_hwmgr *hwmgr)
+{
+	struct amdgpu_device *adev = hwmgr->adev;
+
+	return (adev->pdev->device == 0x6860);
+}
+
 static int vega10_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, uint32_t size)
 {
 	struct vega10_hwmgr *data = hwmgr->backend;
@@ -5158,9 +5165,15 @@ static int vega10_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, ui
 	}
 
 out:
-	smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_SetWorkloadMask,
+	if (vega10_get_power_profile_mode_quirks(hwmgr))
+		smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_SetWorkloadMask,
 						1 << power_profile_mode,
 						NULL);
+	else
+		smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_SetWorkloadMask,
+						(!power_profile_mode) ? 0 : 1 << (power_profile_mode - 1),
+						NULL);
+
 	hwmgr->power_profile_mode = power_profile_mode;
 
 	return 0;
-- 
2.30.2

