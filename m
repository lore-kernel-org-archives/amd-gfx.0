Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE77C433F5
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Oct 2022 23:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCF6310E557;
	Sun,  9 Oct 2022 23:51:32 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF36A10E557;
 Sun,  9 Oct 2022 23:51:27 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 88F07B80C74;
 Sun,  9 Oct 2022 23:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345B7C433C1;
 Sun,  9 Oct 2022 23:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1665359485;
 bh=mX24O1vGgImFyw9AlQ1u4BG7+ZHlcMrj6aWT8XAWarE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=L+Th4x7/eIGReD9DQ8j9epdjaqFOin6YTHYHX+P6n1865nf8iEw6pyLUDNSNuaTcJ
 5RG/SjQzYnTEfCcWyP5EosnujG2vxoEgnwJJW+Q7u8kaxMBfU4RLd2ttkyfL7HDjKM
 k6pPgPJTvt6dbcqskW5z/ZT0hpGiiuQgrTEHt9ivZzlTuqj0+RiUFwNfamIwomQhzi
 n+DExUzHfrpFIsFOfHW44V8bQZzQ7Tu4ezHAonFM1/Vfq5H9BUrrOtmwGJzTgDrkAq
 Na23BrO6/RRJ4PdbrsYYzAKGEeIDyrccbZpXjctBzs9YESDIruChlyFmtkOejhsWxN
 4o3cATatyogow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.0 31/44] drm/amd/display: correct hostvm flag
Date: Sun,  9 Oct 2022 19:49:19 -0400
Message-Id: <20221009234932.1230196-31-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221009234932.1230196-1-sashal@kernel.org>
References: <20221009234932.1230196-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Charlene Liu <Charlene.Liu@amd.com>,
 Eric.Yang2@amd.com, sunpeng.li@amd.com, airlied@gmail.com, Xinhui.Pan@amd.com,
 Rodrigo.Siqueira@amd.com, amd-gfx@lists.freedesktop.org,
 nicholas.kazlauskas@amd.com, mwen@igalia.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Sherry Wang <Yao.Wang1@amd.com>,
 michael.strauss@amd.com, dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
 Wayne Lin <wayne.lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 gabe.teeger@amd.com, harry.wentland@amd.com, christian.koenig@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sherry Wang <Yao.Wang1@amd.com>

[ Upstream commit 796d6a37ff5ffaf9f2dc0f3f4bf9f4a1034c00de ]

[Why]
Hostvm should be enabled/disabled accordding to
the status of riommu_active, but hostvm always
be disabled on DCN31 which causes underflow

[How]
Set correct hostvm flag on DCN31

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Sherry Wang <Yao.Wang1@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index aedff18aff56..2e5a21856eee 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -891,7 +891,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.optimize_edp_link_rate = true,
 	.enable_sw_cntl_psr = true,
 	.enable_z9_disable_interface = true, /* Allow support for the PMFW interface for disable Z9*/
-	.dml_hostvm_override = DML_HOSTVM_OVERRIDE_FALSE,
+	.dml_hostvm_override = DML_HOSTVM_NO_OVERRIDE,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
-- 
2.35.1

