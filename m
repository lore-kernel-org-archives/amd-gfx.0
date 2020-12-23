Return-Path: <SRS0=7Usp=F3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D8EC433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Dec 2020 02:20:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA1BB22D57
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Dec 2020 02:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1BB22D57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 600B36E8B8;
	Wed, 23 Dec 2020 02:20:19 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 974286E8B8;
 Wed, 23 Dec 2020 02:20:18 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6241422AAF;
 Wed, 23 Dec 2020 02:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1608690018;
 bh=1Ak0DNfpo2bDXa6xfS4gXunyiBMMc+ttsGorulc+4hM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=s3Xjnx+gbnFrk1XHGyi3ANCh9plPZZdDIpyoctZDePaF5liDCNY2U90I7XJTzISZu
 P+I8NRUVCzI30qLx8Tbov1tEVpSUwNBlAmx4MuJC/ishTXGvPfBHSy+oztwDTGoL9O
 e//2B4vYd0bKh4A+1Aq+ZIfYJ9KSddBfuN8m/ukyZ3EX5bF5hFA/jEwd/To5gxA17d
 nGLYr8DD8p5HUz6dUtQfyers+y/P6FlEYVpmORgccCSLafCo4nB73eTXW2FPpq0m+1
 m+kRcTXHllbTc/ccYM6uTHKyVGxIDlCuRD2ezS3AHuEQwI8JNNQIYP/LHeA2GGWVoL
 TYmeawN2LMsDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 096/130] drm/amd/display: Revert DCN2.1
 dram_clock_change_latency update
Date: Tue, 22 Dec 2020 21:17:39 -0500
Message-Id: <20201223021813.2791612-96-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201223021813.2791612-1-sashal@kernel.org>
References: <20201223021813.2791612-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Sung Lee <sung.lee@amd.com>,
 Eryk Brol <eryk.brol@amd.com>, amd-gfx@lists.freedesktop.org,
 Yongqiang Sun <yongqiang.sun@amd.com>,
 Michael Strauss <michael.strauss@amd.com>, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[ Upstream commit 3abad347c432b9f5904cfad40f417d5cff90300c ]

[Why]
New value breaks VSR on high refresh panels, reverting until a fix is developed

Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index a6d5beada6634..bb7add5ea2273 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -257,7 +257,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn2_1_soc = {
 	.num_banks = 8,
 	.num_chans = 4,
 	.vmm_page_size_bytes = 4096,
-	.dram_clock_change_latency_us = 11.72,
+	.dram_clock_change_latency_us = 23.84,
 	.return_bus_width_bytes = 64,
 	.dispclk_dppclk_vco_speed_mhz = 3600,
 	.xfc_bus_transport_time_us = 4,
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
