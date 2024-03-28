Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A56CD11DD
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:52:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C268B112547;
	Thu, 28 Mar 2024 19:52:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i9iv/1uc";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 580A111253F
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:52:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQWu1nUOWum7zooNm+NegkOUbiXp2x480rV4nqXKIoqAWqvP0pFHIQc/HeFjN4wowFb+3wXIMaobhJ0h9ui11ksvLoy6SCSW9rZSJ2eUdaxg+A13gGr0u7VO8aS7FSsg5jIEaerhdINih1g5cIJ58RO284Sc97+WPtlYPFTat3PQ+6rv983Tcn2G/R+f4J1C8AU9DHlQIFVJd2Q8IkJQdzGifzTteNO2CItVol+nvm2sSo4qx2RKrvgXEPr92Bf7g5SEylOSy/NIT0uwcIJV5LfDKMuOEFDQ2tDhXsd2IUExQq7ZPtU/4QxTm3bnUqy0hiAphDMEbjmpaadh7Z7BUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrRMzqj9dSwqonpdVMhiDDV5av4Bq30WYBbDBtluHn8=;
 b=oLr2YrJqwQEDGOocSt/NlS251xRi6hh+dKHjzJlzoIabsuSaUdtelbQxsUEaaGYPr6D2+5B5Ty6+2a0G23/p/0MtYSswGwMK+5l1JDvuY4kJsQhstu1iKwyhsAXHDARLb947YC/GZoYo9pcT7KykRbRtjxAOPewMvkW6ltqwpHrCsn9zqkGMuai5Y+vA7mok5nW6gk9HGKxPrnV25C0Z0yyGlOib0Hv6tWgCJcyMzpzLeEXovscS/dSO2sKVqDHBSnAVHShT856P3FheAXhY5lfdz+f/1ZP0e7FzHCjIOKHd/HTjI7MC8TRNe6Uz68yWZXaZdDet3IMu7S9qFwPhPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrRMzqj9dSwqonpdVMhiDDV5av4Bq30WYBbDBtluHn8=;
 b=i9iv/1uc+W8W2vyUvqTqUrHKRIZv+KFRb1FjZsFudMRY4ibltz9VM1vzph1giKtDTbNcgmSIKrxpmFAPUIKU4+qNDh9GxGZyVVxyFJ2HL3gsLF76p41sA3UJQNgKNsywNpCoVp86/3Z7Z0GMEjS6EwI5N869Jpc7v8Z505yDO+Y=
Received: from DM6PR21CA0029.namprd21.prod.outlook.com (2603:10b6:5:174::39)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 19:52:12 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:5:174:cafe::3e) by DM6PR21CA0029.outlook.office365.com
 (2603:10b6:5:174::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.13 via Frontend
 Transport; Thu, 28 Mar 2024 19:52:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:52:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:52:10 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:52:10 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:52:10 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>
Subject: [PATCH 40/43] drm/amd/display: Add code comments clock and encode code
Date: Thu, 28 Mar 2024 15:50:44 -0400
Message-ID: <20240328195047.2843715-41-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|PH7PR12MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d76f1a-e182-4fe0-4a69-08dc4f608f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u9TLsQ95nlQuaFwlXI93Uc90o25oE3t04EIX6YMpnFLVDlou8omh7opL2FWz6dDiUfkr90AWk7zTqLKMDKIht2wt9kVElpO4RVVaW/boIVGMNb+MP08j47IdGFhw4jRuYp58LPdU+ilmuh/mbfHSB1pl6W6dpRoK3uk6ZPzK2DBb9N14OdXR7f/vwN5HounJvQQQ0o0SRVpUTZY98TJ4jbRL85Kl/AUV6HQEUD6dEZvEFSkOy4eDGLiPWe2vkAuhGrbWsXeIUq60eerQn45gOR7pp3oC+SH18/DMZrzL//G80vETC9CbWETUcVfxrolI+Yim2ZHndhs2OFBq7H+nI3yQNOgTb9PUUbcCJJPi1J+ops/7lDqeMRB9ZrFiFSC9sOps8/48B3qrCprKV2V5zcB2r+NFqaz/p9jVYysCTVaPk7vByQiqzJ2ICKQt2cB6ScjM5SBabeVYIsBn3ylsfCp86LEl5YFlWEzdTChIRKchgibXX/gVp6kBw2hDvLSAZgHJrkPgmGN/4omg3EaphimxLwiWy+o2843lcsNZhugLe/FlN1zWmaovCEYZAfC+rkdSrZE9tRBKHakTJdYT1Tl1OzDEGltpql/2cdQW/Ml5VUqLkiuhUvxkRRUGdrx+w4JzyujorfS7n1/hP3D9AUPn0Z3jUiwoNfYAht3YbdW71Dl2EI4TLYQO2S46p2f+7vGcse8n3rh4CFAfM2oFYEX4kl24pBVgzJWepw04CtMEEb+uCJ6xnHfZY3qlzUnM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:52:11.3239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d76f1a-e182-4fe0-4a69-08dc4f608f04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

This commit adds some comments to make easier to understand the clock
update for DCN 201, the encode function, and other minor comments.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c    | 11 +++++++++++
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.c |  2 +-
 .../display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c    |  4 ++++
 drivers/gpu/drm/amd/display/dc/resource/Makefile      |  6 ------
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
index 9c90090e7351..f77840dd051e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
@@ -100,7 +100,15 @@ static void dcn201_update_clocks(struct clk_mgr *clk_mgr_base,
 
 	if (clk_mgr_base->clks.dispclk_khz == 0 ||
 	    dc->debug.force_clock_mode & 0x1) {
+		/* this is from resume or boot up, if forced_clock cfg option
+		 * used, we bypass program dispclk and DPPCLK, but need set them
+		 * for S3.
+		 */
+
 		force_reset = true;
+		/* force_clock_mode 0x1:  force reset the clock even it is the
+		 * same clock as long as it is in Passive level.
+		 */
 
 		dcn2_read_clocks_from_hw_dentist(clk_mgr_base);
 	}
@@ -150,11 +158,14 @@ static void dcn201_update_clocks(struct clk_mgr *clk_mgr_base,
 
 	if (dc->config.forced_clocks == false || (force_reset && safe_to_lower)) {
 		if (dpp_clock_lowered) {
+			// if clock is being lowered, increase DTO before lowering refclk
 			dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
 			dcn20_update_clocks_update_dentist(clk_mgr, context);
 		} else {
+			// if clock is being raised, increase refclk before lowering DTO
 			if (update_dppclk || update_dispclk)
 				dcn20_update_clocks_update_dentist(clk_mgr, context);
+			// always update dtos unless clock is lowered and not safe to lower
 			dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.c
index 09ea65acb2c4..63798132ed95 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.c
@@ -103,5 +103,5 @@ void hubbub201_construct(struct dcn20_hubbub *hubbub,
 	hubbub->masks = hubbub_mask;
 
 	hubbub->debug_test_index_pstate = 0xB;
-	hubbub->detile_buf_size = 164 * 1024;
+	hubbub->detile_buf_size = 164 * 1024; /* 164KB for DCN2.0 */
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
index 45143459eedd..678db949cfe3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
@@ -474,6 +474,10 @@ static void dcn31_hpo_dp_stream_enc_update_dp_info_packets(
 				&info_frame->hdrsmd,
 				true);
 
+	/* packetIndex 4 is used for send immediate sdp message, and please
+	 * use other packetIndex (such as 5,6) for other info packet
+	 */
+
 	if (info_frame->adaptive_sync.valid)
 		enc->vpg->funcs->update_generic_info_packet(
 				enc->vpg,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/Makefile b/drivers/gpu/drm/amd/display/dc/resource/Makefile
index 184b1f23aa77..db9048974d74 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/resource/Makefile
@@ -102,10 +102,6 @@ AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCN21)
 
 ###############################################################################
 
-###############################################################################
-
-###############################################################################
-
 RESOURCE_DCN30 = dcn30_resource.o
 
 AMD_DAL_RESOURCE_DCN30 = $(addprefix $(AMDDALPATH)/dc/resource/dcn30/,$(RESOURCE_DCN30))
@@ -202,6 +198,4 @@ AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCN351)
 
 ###############################################################################
 
-###############################################################################
-
 endif
-- 
2.34.1

