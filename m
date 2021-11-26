Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7F5C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 19:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8EDE6E977;
	Fri, 26 Nov 2021 19:49:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CA9B6E876
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 19:49:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NF251c9fxDEPwfF6800sQixO6YMiK1uFcUSboEsG8FOHfOHwjseruuYM2KmhaUmtz053J0lFiK7e6BdJutuD/JlZa+p0xule5O7CFFBPbj9qkVSThjVALPpaPJhl/j6GyV0xVWfNA7+6lv5P4+rymXOsAEpFF+6RhkoE72EXf1hfk+1hJh2osrmGd31timm4BOrmR7QWSjyDhH4u2jQx/sQlpa5lYI9/vzXDX3w9vSXj8PPTZrDmw9V9CUmmJ+BCGKMfgKNOrRFN8voTiwGBd9Ua7knVa53OkDQAslHr1FgJQ1GQ5MT1nEY0mV08+zpYQjQp1l+l2QJhSLJ+aL6LDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqsODGpjFbC0JEhBap9xW/3FTGdKzWFTsq6tKiLaSRg=;
 b=a+W+zZpy1VGytGUpTZ8SlXXEsCi90/ijq6dR7WtUkDA6WP1rUAoe5HYH/ccCnFP5KYSCduBA7Ajaz/AWEJs7EOzwe4UVc5UlM+vtEMTWXCJTU11lciSSM6knOM3lbTxcAS0CYKVpCS06mJZ0VOgFkIiUFLn5ke9hu4Ou41W4WtU2Tk/18wHp2tCAIAPC4kIKcNsGanI8IQP0zRzposVJUw3/gs7Y4jalpZLgP4a/J3DxbOrTSfwfXIPjJ6fRnqwVbe3I0XOVLBzGrro5o393RmTEojzTC6QRNDqrmzjaZLO+8QznNiOrq8LVOwR7qTyz/Kyz1xtYt5jk1pg1/2J59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqsODGpjFbC0JEhBap9xW/3FTGdKzWFTsq6tKiLaSRg=;
 b=gOxNx+dM/loAF/nhUkTkje7WZuUE47H3mYKfxrvXb68yMvvNav/eOdjL5aw60RcNGNRVboXsubk/yIM1/bvQdsy5FV5ZcR2ScJeG3bXyeKgOAn5sC1wNf0WtghvL4sTpHiZbNwCXY48h1/qt8KPRcYlmq1IBsbHlfCWm8sjLBpI=
Received: from MWHPR17CA0094.namprd17.prod.outlook.com (2603:10b6:300:c2::32)
 by MW2PR12MB2571.namprd12.prod.outlook.com (2603:10b6:907:10::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Fri, 26 Nov
 2021 19:49:36 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::d7) by MWHPR17CA0094.outlook.office365.com
 (2603:10b6:300:c2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Fri, 26 Nov 2021 19:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Fri, 26 Nov 2021 19:49:36 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 13:49:36 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 11:49:35 -0800
Received: from blakha.ht.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 26 Nov 2021 13:49:34 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/16] drm/amd/display: Fix dual eDP abnormal display issue
Date: Fri, 26 Nov 2021 14:49:15 -0500
Message-ID: <20211126194922.816835-10-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
References: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 607c7e68-d983-44d0-838b-08d9b115e05c
X-MS-TrafficTypeDiagnostic: MW2PR12MB2571:
X-Microsoft-Antispam-PRVS: <MW2PR12MB25719B4EB0246BAD1341331EF9639@MW2PR12MB2571.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WuNfMT9o/wgVMT0jVvixXwO/9+ZRjq7y70ZjtoZ/6ZTJmYl58bgY72CglsFPIWgFZU80kCjiyrPJZyCxSfIowvqEwDyrveCg4WOgDjHQJccMHndXl+B2yM0sx7DE20E6dtA1eDwo+ZwMMW2edhzM5dLyxlvukjnHeMFmodx6V7iP659J64OVgmRF5rJ8xI2p6Dhu5K62duhQ1SAnKuq32QDaz9qG+E3LFvs2y9hPKebMMnj6C6qs1clnQ6I7Tp5JMA2DxCqiWN8V8daglBJVdLxgEY37UZ2c6uT48M3fuO1IB2M5zE5K/KEjt97opN+fFbau+gt3G+0tiExrDw9QlHRv9bxyBEHFdxeazD6FJTLI/dLXLumR+ik76svSD248PszAY54kOqQVWdqvyAmb6RG/PTLldoMXNDRVtXl72px0K8BzcRUZfkwtIUNvSXlHicW1bkgP5KdRyF1F2QC5C/f2nIWa3mBh8Fq9Vafbx/357JcuDg/9d5n8UugfT9DU5cDE+qPLv4QTUoeioFNhTaqR3vuJabM2oJpW6unNqMTszw+RBfSz2ZpOVE2u8O9RQYrPo80wO2c1cqV63gyKfoRWS+iNHsoz9Z3POxLjxGJQVZtrgIrD9k/cFcqI9bc4U+jhv8Yg09V92z98NuxueMSEzE1lvfg3HfD96XoIc0OiERJcpozjDiYGdu1q89NU00jx1Z+DNXAYKPabmHGU1Am3hkZ1SC8JkLWnjXrePhI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(508600001)(356005)(316002)(26005)(70586007)(8676002)(6666004)(4326008)(36860700001)(83380400001)(54906003)(186003)(70206006)(82310400004)(336012)(426003)(1076003)(6916009)(2616005)(2906002)(47076005)(86362001)(8936002)(36756003)(81166007)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 19:49:36.4635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 607c7e68-d983-44d0-838b-08d9b115e05c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2571
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Brandon Syu <Brandon.Syu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas
 Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Brandon Syu <Brandon.Syu@amd.com>

[WHY]
Driver use primary eDP link stream as the condition
to enable fastboot or not.
In dual eDP case, set second screen only,
this would cause slave eDP timing to be used on primary one.

[HOW]
Add a check for unmatched eDP link stream.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Brandon Syu <Brandon.Syu@amd.com>
---
 .../gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c   | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 67298aa890c4..a6bc3c7673ba 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1817,15 +1817,17 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 	get_edp_streams(context, edp_streams, &edp_stream_num);
 
 	// Check fastboot support, disable on DCE8 because of blank screens
-	if (edp_num && dc->ctx->dce_version != DCE_VERSION_8_0 &&
+	if (edp_num && edp_stream_num && dc->ctx->dce_version != DCE_VERSION_8_0 &&
 		    dc->ctx->dce_version != DCE_VERSION_8_1 &&
 		    dc->ctx->dce_version != DCE_VERSION_8_3) {
 		for (i = 0; i < edp_num; i++) {
 			edp_link = edp_links[i];
+			if (edp_link != edp_streams[0]->link)
+				continue;
 			// enable fastboot if backend is enabled on eDP
 			if (edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc)) {
 				/* Set optimization flag on eDP stream*/
-				if (edp_stream_num && edp_link->link_status.link_active) {
+				if (edp_link->link_status.link_active) {
 					edp_stream = edp_streams[0];
 					can_apply_edp_fast_boot = !is_edp_ilr_optimization_required(edp_stream->link, &edp_stream->timing);
 					edp_stream->apply_edp_fast_boot_optimization = can_apply_edp_fast_boot;
@@ -1837,7 +1839,7 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 			}
 		}
 		// We are trying to enable eDP, don't power down VDD
-		if (edp_stream_num && can_apply_edp_fast_boot)
+		if (can_apply_edp_fast_boot)
 			keep_edp_vdd_on = true;
 	}
 
-- 
2.25.1

