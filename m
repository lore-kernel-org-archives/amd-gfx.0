Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B978E7B5E0
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 09:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D09A810E34F;
	Wed,  4 Oct 2023 09:24:09 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 500A310E352
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 09:24:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgcKrgRvNbzXErz75T75qVMUXXGguCDLZqpn9f2sQyEUcK687iJMSj0R2ngjxTN/VGgSohbbX7RfiL0yU0oVvm9l4tOTbTE2xrIiqwhooZ/OhmuU83c40jTzndTpaEnT1wC/50ScwUyImu6TRSMBQRIdSLPbgHSL5PP7DmDrWkRgr4zQgGUHVqDF/HHh5Ak6LteS+fE81ityUQzo4Z6MvdNqyEPJZ1wYtM6Np6yXb65vGpUnbfZFLBP190zIaYabmR+qb4wamswmf+mSHjJN/ByDaMSIeBDwS3BJLuZs5gRd/ERWrsYqtVqY/ZMXWGuu58niIv0gH9Ahr1f5SuaGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kw6lc7GAAdW8xP3df8zXtWjp+WZ9sMxZ6J5GbXN+pqg=;
 b=mAX4jMgScIYJyVSu3gNunp3C1YFw+hpyNyYDY9t9429EFa0fsoy6l5cIOx0s3Q99FBjyQA/QrNFhyZf6xYrUBd+6eI5B8aqZN/Yn28MzWB8SJ+numeDuNdvvJnM5H5124z35hq2Akt+X21w1bBCpIBNcDANNR+nKPevIQlALqArQgGn2022wZXNDU3be3NHfrDan44mTcLhU+vpqMYKPOckNSTWHrDF5BZmtaA/2qrPhfgxOhJ320MQ/KGVKy3Oii8ehXVht54P5bJ0raNMOvIkwpF0YBshYJS4WoOK/cdAAtAdzEzOkeIkv5PyLacnwhYb/8z+Vml6Z4PY0LxjskA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kw6lc7GAAdW8xP3df8zXtWjp+WZ9sMxZ6J5GbXN+pqg=;
 b=M76Q5zj/py+EJlyGyz8pp1pZRU63OQSg7g4AFLpXXBPXtRT+TpxLRDanIvE6uCd8lr/Tuv3Bgu5bAtRHKcWH2DA85yO2m6aHJm/1v9QvoFZKxUpwuoS5WiUnmQRFLMOTaNt4G94mG4LTbr0/ctGbbhu51Djd+K1IX5dQDpDBzCM=
Received: from BLAP220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::11)
 by DM4PR12MB5166.namprd12.prod.outlook.com (2603:10b6:5:395::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 09:24:04 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::ff) by BLAP220CA0006.outlook.office365.com
 (2603:10b6:208:32c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.36 via Frontend
 Transport; Wed, 4 Oct 2023 09:24:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 09:24:04 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:24:04 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 02:24:03 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 04:23:58 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/16] drm/amd/display: Update dml ssb from pmfw clock table
Date: Wed, 4 Oct 2023 17:22:52 +0800
Message-ID: <20231004092301.2371458-8-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
References: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|DM4PR12MB5166:EE_
X-MS-Office365-Filtering-Correlation-Id: bfe9f6d3-ea5a-436f-1363-08dbc4bba724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hzxeEowIbqjxXvlYeFOsCNmwiuiWYqGjmyl8AISzU4JVrENM8ABhYwpcnew4ncomfX8fJuUOgUdF72QRp/p9WyzuqpnKAil84tHptaepLNd45k5u02+KRfzTr1Da4iZ+hfemap9FscIHysdHp6sbJMGwQ4uHYGfzWPzR+J0zmWp81jCcZVGNGJ5afr89SReRmOJWQVrt3A8bPK6suG/i1lTvChfRot0tHNJ4H4YUsXg/sqHup5qJ6QD3o6RK4STxbzHjsw3Lm0PH0UDz42o0cpETS9QDEBQ6CFui/Ue7NEIUOw16aZiAzpvfw5Ngx7JlHgeRiWjFLpmyXAilcKOzUdTZAMyybYSxNIUSUdmn0OIXHMQpruQn20za8gbhWrEgTRGlc4dOrpqG4JxQRUD6Fg7qiAo4IDbP6HJ2Ut/LI5hRFWC/p4ClZTn/Wez75qryFv0eM+wyRsgd1JEKDcc+baZmp2bwCRHa9izNqEOaM4Jyf5fyWZL3miSJDteakux/gnm5Fc3x6gUVFrxH2ijIdJbyxcfOvErjUu+V0Pmvxdr38Ue7UKyNXcnpCvllZhSOYiwL4gVqFz8ocIGrCZCpXNpxd8Qix6q8yd4cF1dgnImt7kpjYzUnxGyK62yWvcd8c6QrxW1v0MYPflv6fl0rjTJr/R0ntYaQpMVfLk3OfFeIrMKwZeKXFEakefCilYFpkDFis363TjtIUy20WhC+SqwTrT8ZPHEjDUILvVH5STXUCyVxzpvT8a4+gkTC7F7TP4U9kxq9eS2bCXu3+JhZBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(2906002)(15650500001)(40480700001)(54906003)(70206006)(70586007)(316002)(6916009)(5660300002)(41300700001)(8676002)(8936002)(4326008)(40460700003)(36756003)(86362001)(47076005)(356005)(83380400001)(81166007)(6666004)(7696005)(2616005)(26005)(1076003)(336012)(426003)(478600001)(36860700001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:24:04.4676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe9f6d3-ea5a-436f-1363-08dbc4bba724
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5166
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Muhammad Ahmed <ahmed.ahmed@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Muhammad Ahmed <ahmed.ahmed@amd.com>

[why]
Need to use real clock table

[How]
Update the clock table

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
---
 .../drm/amd/display/dc/dcn35/dcn35_resource.c |  3 ++-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  | 24 +------------------
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.h  |  2 --
 3 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index 24b455f3ac3c..d3cc8f4a82d1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -698,7 +698,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.underflow_assert_delay_us = 0xFFFFFFFF,
 	.dwb_fi_phase = -1, // -1 = disable,
 	.dmub_command_table = true,
-	.pstate_enabled = false,
+	.pstate_enabled = true,
 	.use_max_lb = true,
 	.enable_mem_low_power = {
 		.bits = {
@@ -1841,6 +1841,7 @@ static bool dcn35_resource_construct(
 
 	/* Use pipe context based otg sync logic */
 	dc->config.use_pipe_ctx_sync_logic = true;
+	dc->config.use_default_clock_table = false;
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index 4d5ee2aad9e4..be345f470b25 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -205,29 +205,7 @@ void dcn35_build_wm_range_table_fpu(struct clk_mgr *clk_mgr)
 	//TODO
 }
 
-void dcn35_patch_dpm_table(struct clk_bw_params *bw_params)
-{
-	int i;
-	unsigned int max_dcfclk_mhz = 0, max_dispclk_mhz = 0, max_dppclk_mhz = 0,
-			max_phyclk_mhz = 0, max_dtbclk_mhz = 0, max_fclk_mhz = 0, max_uclk_mhz = 0;
-
-	for (i = 0; i < MAX_NUM_DPM_LVL; i++) {
-		if (bw_params->clk_table.entries[i].dcfclk_mhz > max_dcfclk_mhz)
-			max_dcfclk_mhz = bw_params->clk_table.entries[i].dcfclk_mhz;
-		if (bw_params->clk_table.entries[i].fclk_mhz > max_fclk_mhz)
-			max_fclk_mhz = bw_params->clk_table.entries[i].fclk_mhz;
-		if (bw_params->clk_table.entries[i].memclk_mhz > max_uclk_mhz)
-			max_uclk_mhz = bw_params->clk_table.entries[i].memclk_mhz;
-		if (bw_params->clk_table.entries[i].dispclk_mhz > max_dispclk_mhz)
-			max_dispclk_mhz = bw_params->clk_table.entries[i].dispclk_mhz;
-		if (bw_params->clk_table.entries[i].dppclk_mhz > max_dppclk_mhz)
-			max_dppclk_mhz = bw_params->clk_table.entries[i].dppclk_mhz;
-		if (bw_params->clk_table.entries[i].phyclk_mhz > max_phyclk_mhz)
-			max_phyclk_mhz = bw_params->clk_table.entries[i].phyclk_mhz;
-		if (bw_params->clk_table.entries[i].dtbclk_mhz > max_dtbclk_mhz)
-			max_dtbclk_mhz = bw_params->clk_table.entries[i].dtbclk_mhz;
-	}
-}
+
 /*
  * dcn35_update_bw_bounding_box
  *
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.h
index b122ffdcc30a..e8d5a170893e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.h
@@ -34,8 +34,6 @@ void dcn35_build_wm_range_table_fpu(struct clk_mgr *clk_mgr);
 void dcn35_update_bw_bounding_box_fpu(struct dc *dc,
 				      struct clk_bw_params *bw_params);
 
-void dcn35_patch_dpm_table(struct clk_bw_params *bw_params);
-
 int dcn35_populate_dml_pipes_from_context_fpu(struct dc *dc,
 					      struct dc_state *context,
 					      display_e2e_pipe_params_st *pipes,
-- 
2.25.1

