Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D3AC77B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 11:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EC6F10E3FC;
	Wed, 17 May 2023 11:39:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C97FB10E3FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 11:39:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yt7m1419Znmqal2S3n133dm2CDv/mwAdA24VhQJMcyb9Cfnd8WYN1tAEphr7T94xYZpMyR/LKbepDiSM6dbHsuYwzT5UAXUMRpIV5yr+TR4NK+5OjRbS/iClbgUfMIfdIsq2z3jXshW6NUx7Yh6nuz2G/fJHFU0XTnnd4lr4GPdg6dsgggpfJwQTHXAO9TmdqaAoDCZqvIgNqGGYR/q5Ojk30f5xsM+YvB6erNUWK6n2j+ai1plPrIVtxd35ZSYZzE0He3FXRWKF7uG8NafzBWDx0ykOg0OAct9yhWq0Nzi+tABNWIEyGEFnT7uHGgmhX9QkYQ427dPm7xt/T0qvLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfmKu45dGxWtAM3Cx+eY8fWNSZH+jchY7pqSlEd8RWA=;
 b=FFbnSdVhTQhk8HRS6oNL59PPem0r6w+3Bm5Uogx7a21z35L+IpVj/9zcljMKzLQfCuRxaMEiO2DW0ocXlEywChW6YEWelknU/EMnDfTdtYQSNkCehPYQJXkDz1qhL/RF4q3D8ZMuEsJUdJBnwUws2KpUQOQDUhAXj403o8lbzCkpqq48xj7O5+BOImU9is2yon8LTSQn1PHFJSdWNKfw9g+TJK0MFRHE750ZSwZEgfjn+4ogTz6jx5vr9G2gV3Go2h34etvofot3q/spLG2ZrnCIDG9qbbxLuxEPgOrjU83Q2C0SMwvyMyBaCnKIG1Idguxgqxa0HFYQ0Gwl1VQipA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfmKu45dGxWtAM3Cx+eY8fWNSZH+jchY7pqSlEd8RWA=;
 b=PozuqwOMVnruhOGzsm1qGiH4UtqextxqdqW9PzNFyTaEO2vvvtpNZSRHaTdEWBFCKUVTO+ViqkduO4ZWgorCyBKgOHuJfrBHUWjWQlm3NOKzQO40dCCS4OcWG44efbtvcD+ZWzVGt90UeWfKsMKN6Ify3R6m1w+QVcJ4Y6NM5+w=
Received: from MW4PR02CA0022.namprd02.prod.outlook.com (2603:10b6:303:16d::15)
 by DM6PR12MB5023.namprd12.prod.outlook.com (2603:10b6:5:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 11:39:53 +0000
Received: from CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::13) by MW4PR02CA0022.outlook.office365.com
 (2603:10b6:303:16d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18 via Frontend
 Transport; Wed, 17 May 2023 11:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT110.mail.protection.outlook.com (10.13.175.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.17 via Frontend Transport; Wed, 17 May 2023 11:39:53 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 06:39:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 04:39:52 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 17 May 2023 06:39:47 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/18] drm/amd/display: Fix possible underflow for displays
 with large vblank
Date: Wed, 17 May 2023 19:37:16 +0800
Message-ID: <20230517113723.1757259-12-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
References: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT110:EE_|DM6PR12MB5023:EE_
X-MS-Office365-Filtering-Correlation-Id: dedd0669-e91f-4af7-d159-08db56cb6e68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R2XkXbyLSDDSv6j464yB/UQbxkTJnajXYSKtIGz3WjaRs3MtjsMRh3y6xzVSaZwHCkE89nqJR9SgGocZrfpBuGdOGzyzmrRBMkAeFyqOwTueLZEvE2ttbal/+BuM5oEH4oQ4MdwlFsQfDxFaL2paVCWr5XUF5xXCgcBOP/EGgrJlBpYTRYQAvFpafNRyNGy3jcvbr+ooej0s/Fe+KIywtcJ9nF3yvVyGpJVzcqW5OfCWfa5voIw4OflBZY0CLgLomOqvVODvHtGg+wveUyY/uMVb4Mk7D9tDHVFqlsKbe9e4JJf1fUh5BFOp1FNUGdEXCTZNbkC7Dhe0tI47Ep0T6bnE0vhMMfMuX7uquvYSI0knwkVrm75cLrqtAWHZ/nJ6JHpEXemqJbhGUbe6aQEov1/yVifOArgYiDlrsqiVOKwxdZo2vHw65khyQxQPtLSEQ/6b925IxMCwI9hIa6277m6JrkOlDeXyYU7iWtBr1pgfZSubjnCcAmXdQxdjVn/+enO5ay+TBXUYckz4Kzg6cRCe06LTvhyx4aLziXhoTpzBtJBl4/+zXQi+tWerS1Df8vMCDio4g9g6Sh81EkM6pdwTLzQp1EbbC/iwT3WnWjratiO4MRFlJAkp/Sam+h1TGR0vMCfu6MMrY3MC6a+LrIps/5XHiHY4cK/gut4SW678akXBkIcR29Fh9i06ej3fyUcWxQAZ5ZSU3HNNWuU8ZHzlvaFWIprU+VLqF85sxX+QMe94MbH4fRUAyuHfjt/hnJXtJgHAwxjuaZSvHMs+Ww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199021)(36840700001)(46966006)(40470700004)(36756003)(86362001)(19627235002)(54906003)(70586007)(70206006)(4326008)(316002)(6916009)(478600001)(6666004)(40480700001)(82310400005)(8936002)(8676002)(41300700001)(5660300002)(2906002)(81166007)(82740400003)(356005)(2616005)(336012)(426003)(26005)(186003)(36860700001)(1076003)(83380400001)(47076005)(7696005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 11:39:53.2363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dedd0669-e91f-4af7-d159-08db56cb6e68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5023
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
Cc: stylon.wang@amd.com, Daniel Miess <daniel.miess@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <daniel.miess@amd.com>

[Why]
Underflow observed when using a display with a large vblank region
and low refresh rate

[How]
Simplify calculation of vblank_nom

Increase value for VBlankNomDefaultUS to 800us

Fixed a null pointer from previous commit of this change

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
---
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 1d00eb9e73c6..554152371eb5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -33,7 +33,7 @@
 #include "dml/display_mode_vba.h"
 
 struct _vcs_dpi_ip_params_st dcn3_14_ip = {
-	.VBlankNomDefaultUS = 668,
+	.VBlankNomDefaultUS = 800,
 	.gpuvm_enable = 1,
 	.gpuvm_max_page_table_levels = 1,
 	.hostvm_enable = 1,
@@ -286,7 +286,7 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe;
 	bool upscaled = false;
-	bool isFreesyncVideo = false;
+	const unsigned int max_allowed_vblank_nom = 1023;
 
 	dc_assert_fp_enabled();
 
@@ -300,16 +300,11 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 		pipe = &res_ctx->pipe_ctx[i];
 		timing = &pipe->stream->timing;
 
-		isFreesyncVideo = pipe->stream->adjust.v_total_max == pipe->stream->adjust.v_total_min;
-		isFreesyncVideo = isFreesyncVideo && pipe->stream->adjust.v_total_min > timing->v_total;
-
-		if (!isFreesyncVideo) {
-			pipes[pipe_cnt].pipe.dest.vblank_nom =
-				dcn3_14_ip.VBlankNomDefaultUS / (timing->h_total / (timing->pix_clk_100hz / 10000.0));
-		} else {
-			pipes[pipe_cnt].pipe.dest.vtotal = pipe->stream->adjust.v_total_min;
-			pipes[pipe_cnt].pipe.dest.vblank_nom = timing->v_total - pipes[pipe_cnt].pipe.dest.vactive;
-		}
+		pipes[pipe_cnt].pipe.dest.vtotal = pipe->stream->adjust.v_total_min;
+		pipes[pipe_cnt].pipe.dest.vblank_nom = timing->v_total - pipes[pipe_cnt].pipe.dest.vactive;
+		pipes[pipe_cnt].pipe.dest.vblank_nom = min(pipes[pipe_cnt].pipe.dest.vblank_nom, dcn3_14_ip.VBlankNomDefaultUS);
+		pipes[pipe_cnt].pipe.dest.vblank_nom = max(pipes[pipe_cnt].pipe.dest.vblank_nom, timing->v_sync_width);
+		pipes[pipe_cnt].pipe.dest.vblank_nom = min(pipes[pipe_cnt].pipe.dest.vblank_nom, max_allowed_vblank_nom);
 
 		if (pipe->plane_state &&
 				(pipe->plane_state->src_rect.height < pipe->plane_state->dst_rect.height ||
-- 
2.25.1

