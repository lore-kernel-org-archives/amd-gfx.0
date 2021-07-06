Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B91EC07E9C
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 11:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CD4761C3F
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 11:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD4761C3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFB9489FF9;
	Tue,  6 Jul 2021 11:14:37 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0FC689FD9;
 Tue,  6 Jul 2021 11:14:35 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9609B61C22;
 Tue,  6 Jul 2021 11:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625570075;
 bh=0TEEtHfReXo4F18sk6Sba1Yo0FUOojEbgub7tLSmUa8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iCpXyx7L0jR7bktVkMadi60TFGGuMg4Gmjjl33732LHbvxAYyHF0nfm0runM/6WCs
 lrCnl3opPB39nnVosNK0DdJwDvJt/ELuoURTG7XNVRu4FBF4kNWn4S+Hq9d/3Pf1ml
 FDhc9d80pmWwELvBtwqEK2Y+DYrZ5MnRWB+KqGazVEUtcAeEJbA1nwy+WNLxnTCnv/
 G4URyARd8KX/5eXa6LYiNcvk3yur4XxKTP5hH+vEU9QUSgrnrmz9Dyp5BdVr0aGbOt
 4bqLqAbxwH6Mko6fiM4AF4899XcMqtk7bL5H9386AIhZogUDKAYOJq1QsW8VR+gr01
 0xeP2z+3oJoQw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 017/189] drm/amd/display: fix use_max_lb flag for
 420 pixel formats
Date: Tue,  6 Jul 2021 07:11:17 -0400
Message-Id: <20210706111409.2058071-17-sashal@kernel.org>
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
Cc: Stylon Wang <stylon.wang@amd.com>, Sasha Levin <sashal@kernel.org>,
 Aric Cyr <Aric.Cyr@amd.com>, amd-gfx@lists.freedesktop.org,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

[ Upstream commit 8809a7a4afe90ad9ffb42f72154d27e7c47551ae ]

Right now the flag simply selects memory config 0 when flag is true
however 420 modes benefit more from memory config 3.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
index efa86d5c6847..98ab4b776924 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
@@ -496,10 +496,13 @@ static enum lb_memory_config dpp1_dscl_find_lb_memory_config(struct dcn10_dpp *d
 	int vtaps_c = scl_data->taps.v_taps_c;
 	int ceil_vratio = dc_fixpt_ceil(scl_data->ratios.vert);
 	int ceil_vratio_c = dc_fixpt_ceil(scl_data->ratios.vert_c);
-	enum lb_memory_config mem_cfg = LB_MEMORY_CONFIG_0;
 
-	if (dpp->base.ctx->dc->debug.use_max_lb)
-		return mem_cfg;
+	if (dpp->base.ctx->dc->debug.use_max_lb) {
+		if (scl_data->format == PIXEL_FORMAT_420BPP8
+				|| scl_data->format == PIXEL_FORMAT_420BPP10)
+			return LB_MEMORY_CONFIG_3;
+		return LB_MEMORY_CONFIG_0;
+	}
 
 	dpp->base.caps->dscl_calc_lb_num_partitions(
 			scl_data, LB_MEMORY_CONFIG_1, &num_part_y, &num_part_c);
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
