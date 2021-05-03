Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE262C43462
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 16:37:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AE7C61244
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 16:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE7C61244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBD5A6E94A;
	Mon,  3 May 2021 16:37:09 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1F4E6E949;
 Mon,  3 May 2021 16:37:08 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B11A6141D;
 Mon,  3 May 2021 16:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620059828;
 bh=1lF+p0wWKEydSjKxt8caoh1BWCJvhUgVNOheCC5uX6o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=X5Irqu/WxLrjPeB/bWLjd3XfGO5Ac4ksgbbtMtaaxfcWgBP6MLxrCA6nhupbwiv3B
 TQCoqs7KOdrmzWXn83RkArRh2kEm5pdyPQUpspe7pcZv0H24PupyRP/2VFoedZKjEX
 zIvzHdHAtrZ8mbWeAfDmhHxRCc7TBUH5ttzJZHArbZ7FzrfkJxEBVuRTsXO9HOY4Vk
 SF4E6IDw5E7FEIJk+pXsOhwJe8ue2AxCHkXsGAB5XutR4bpNLHLGnWuuXwRDaXP7vr
 Bd1KoElMIR8vgd4WckUFpvCL2W2A9E7qFW0/q4bCXm4vTKX1lKJnpTVbrTCKa31jyC
 yn6O6t8SDgQ3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.11 005/115] drm/amd/display: changing sr exit latency
Date: Mon,  3 May 2021 12:35:09 -0400
Message-Id: <20210503163700.2852194-5-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503163700.2852194-1-sashal@kernel.org>
References: <20210503163700.2852194-1-sashal@kernel.org>
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
index 7ec8936346b2..f90881f4458f 100644
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
