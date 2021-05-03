Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FE5C43462
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 16:35:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 076ED61278
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 16:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076ED61278
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBB4A6E8D5;
	Mon,  3 May 2021 16:35:23 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B0006E8DA;
 Mon,  3 May 2021 16:35:22 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1AC060D07;
 Mon,  3 May 2021 16:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620059721;
 bh=l++XYtZtJ70mk4ZhI+OUoCT6J6N26BdalDtg7D1/Kkg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=X1FTRV8uyEJ2kD+cyWQAGLOQlAySUEqYWyw7fowL9MeTFx5feWZ9QQQz+r6gN9UhC
 dmPyvsfgbmA6R4jA7CzuRCNyS7Qo2x8t47z7Wz4nv2QmwiSq4s+1zLh6d6L/zNNzJo
 2O63GTRwQqnfnLoYxaiUC0bDG7+NuLQjSiSBtWEDzSemZTfq3Nf6fqjcI42cGre7h2
 wyyKiGki6yKUq64FQYjj6E6A8T4KEwMSEqW0AmkmbkIcwagodRySfSEln0HjNiZEBx
 wwDTLbc7dyJNyt/XVcQjN3j4nhWauw5BtQV8K6Mqr7USwIBYp1wX+hf5h60QQpIVdv
 +jwvdKCLn85dw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 005/134] drm/amd/display: changing sr exit latency
Date: Mon,  3 May 2021 12:33:04 -0400
Message-Id: <20210503163513.2851510-5-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503163513.2851510-1-sashal@kernel.org>
References: <20210503163513.2851510-1-sashal@kernel.org>
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
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, amd-gfx@lists.freedesktop.org,
 Daniel Wheeler <daniel.wheeler@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 Martin Leung <martin.leung@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <martin.leung@amd.com>

[ Upstream commit efe213e5a57e0cd92fa4f328dc1963d330549982 ]

[Why]
Hardware team remeasured, need to update timings
to increase latency slightly and avoid intermittent
underflows.

[How]
sr exit latency update.

Signed-off-by: Martin Leung <martin.leung@amd.com>
Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index fb7f1dea3c46..71e2d5e02571 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -181,7 +181,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_0_soc = {
 		},
 	.min_dcfclk = 500.0, /* TODO: set this to actual min DCFCLK */
 	.num_states = 1,
-	.sr_exit_time_us = 12,
+	.sr_exit_time_us = 15.5,
 	.sr_enter_plus_exit_time_us = 20,
 	.urgent_latency_us = 4.0,
 	.urgent_latency_pixel_data_only_us = 4.0,
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
