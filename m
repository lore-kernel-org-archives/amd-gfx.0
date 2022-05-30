Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AFCC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 30 May 2022 13:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75C3610E854;
	Mon, 30 May 2022 13:25:28 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04C2010E854;
 Mon, 30 May 2022 13:25:27 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 633B760EC7;
 Mon, 30 May 2022 13:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F85DC3411F;
 Mon, 30 May 2022 13:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653917126;
 bh=cz7EaM8E2HHkUwPlijx0Xy7QFc9ala/dWiZQqSjozhk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bdJYcYTSL2P/vS/iMtfjFpBnsrAvCNxV6uo/v8S4vR+0XcvavRBvBaQGrRfb+pbmR
 z+Nh1Y/FxT200JiE/c30yQobrgGDZ8HZx5W9KxlQ8V72smrMqFXBxcX2bwJaaRxC54
 LnDy+Qk9uDsYzO9H5VEPLmn7qSyq504J7nRLV2YL8IoJhoD1ecqoqYKoAgom54vF7O
 qW3FdwdxPZgVihBNH8pEXH8MZn7lrv5AMCSppna99zJtLhjSEv3V4NlqZTc/i3uXEf
 3lDSnV704fRt8Oki4E16SGg0Q41cD/RR0SfqEN1GufIqmd2huiPtRj8E50PzcLUoym
 81k69WOFAeetQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.18 023/159] drm/amd/display: Disabling Z10 on DCN31
Date: Mon, 30 May 2022 09:22:08 -0400
Message-Id: <20220530132425.1929512-23-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220530132425.1929512-1-sashal@kernel.org>
References: <20220530132425.1929512-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, meenakshikumar.somasundaram@amd.com,
 Eric Yang <Eric.Yang2@amd.com>, sunpeng.li@amd.com, Xinhui.Pan@amd.com,
 Rodrigo.Siqueira@amd.com, amd-gfx@lists.freedesktop.org,
 nicholas.kazlauskas@amd.com, Saaem Rizvi <syerizvi@amd.com>, airlied@linux.ie,
 Jerry.Zuo@amd.com, michael.strauss@amd.com, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, Alex Deucher <alexander.deucher@amd.com>,
 harry.wentland@amd.com, christian.koenig@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Saaem Rizvi <syerizvi@amd.com>

[ Upstream commit 5d5af34072c8b11f60960c3bea57ff9de5877791 ]

[WHY]
Z10 is should not be enabled by default on DCN31.

[HOW]
Using DC debug flags to disable Z10 by default on DCN31.

Reviewed-by: Eric Yang <Eric.Yang2@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Saaem Rizvi <syerizvi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 63934ecf6be8..d71e625cc476 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1030,6 +1030,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 			.afmt = true,
 		}
 	},
+	.disable_z10 = true,
 	.optimize_edp_link_rate = true,
 	.enable_sw_cntl_psr = true,
 	.apply_vendor_specific_lttpr_wa = true,
-- 
2.35.1

