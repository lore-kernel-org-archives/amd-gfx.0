Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E99C2BB3F
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 19:44:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EDE710E1DB;
	Wed, 15 Nov 2023 19:44:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5015410E1D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 19:44:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWSY8SraIPU3rx+B5Twp3dz3/O3np9Rk2pnIJ/+SfmQJ7PLbnchA2oOfB9otWUHO/KPZ80oFDop+qvHqNVff+eipvvZN5Ua+BRd4ecoX0h6wBtdgtuPpxlU1oCBS3AMQOARgiOctc0T56sCu1QQ6frLLzlmqh0YOeh1VZVFoSLfMIPMK/0UREpxNOqRvv2WPOHY2nKXMhX1wmYdfN1BHk8ZpgTL46Kr/Uk7reSE1clOrHTucYLGtyCgw3yucim/TlneGrlgqgcuz8qC52eglRSpvT/3EY++Y2hVzWOF4S3CGe4Lf6QUmXXjdBv3XOxfSso8mmrSmRU/2a+TJ0Nx0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9CKqWq4L0eVtmOv1gXBIkNVkdDCBZPsF6go6M3iAlgQ=;
 b=O4tv9v91Hg56EQkkU0ymxemUsUESShtHVdwyctiHr4vr82c7qUaLcgONsGDNgzSB13a1xy2xDR85rCCIsmLUA0LkO3E8KTo2XGnLfQIJxrBdl0oBa9dJnNkasC1kpHZs3FTQECbhsyy6tEzdVnukPUSMBGNPJaPL1zxCguIzZbjkKrDJPXMKmvLkwDnIIpUJR3oY1585Vc9PdYOPsB40Iq6eKEfrhpiQX55DMEmZiQr6yz01A9crYdkm+U4ByEAUCHKr8l49GAZUDyTll/72pykXR/tvZQT4vp8Et+lHwNM4gML33G3Y7gcOFJrcN8PE3mveNwIjLQpkCsTbtHvedw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CKqWq4L0eVtmOv1gXBIkNVkdDCBZPsF6go6M3iAlgQ=;
 b=TjDeVQ+J24dV9Pd36DGmWAYvu9qoJnlXayH5pV2XPuOWSpRUBMFgevUozKEZQyV5ddbirL6vZwY/RZ5WldleiLVac4EDf+FxSE+HJ4jgfOr33BDQRoDvICUgDmZBTXmllL7tdeGzrTVO76+Ve/8Hm3sQKdIiv7QRPV03StycSUQ=
Received: from MN2PR14CA0026.namprd14.prod.outlook.com (2603:10b6:208:23e::31)
 by MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19; Wed, 15 Nov
 2023 19:44:14 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::bd) by MN2PR14CA0026.outlook.office365.com
 (2603:10b6:208:23e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.19 via Frontend Transport; Wed, 15 Nov 2023 19:44:14 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:12 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/35] drm/amd/display: Update DCN35 watermarks
Date: Wed, 15 Nov 2023 14:40:18 -0500
Message-ID: <20231115194332.39469-6-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115194332.39469-1-hamza.mahfooz@amd.com>
References: <20231115194332.39469-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|MN2PR12MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: c8318014-87ef-4e82-9424-08dbe6133f1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7O2hNS+yA12jgKPFICJqtVkzOKpemDAgU2Q8MYiSpERl9gclerYtJydoT+gxKF3lklKtzJVgWsIInFb2I1gIOe0gnA988gwPfwlgSYX3eFiIcT5fSS9DYCGsi0PFJ42zEf6Z2kFnNpq6cn7y+JW6HyaKoMl1p/JUid0VYlWZMHAIhP+xiQRL1llE+VAZ5FiIDJ721k5qJdhcMQVZZ0RdaGS3BfM96xly0L/UegdwEowT5HmHcYSaD1Z8qQVCi7qN2icgve83o08DFRD6ZQVFxOnFZDdDAv45T3LKHmkZShDckkXEjyOsCZqoEnTZRS8b/vfxJ9CYVmdOqZD3r1nMqxnCktb3KxXszOuBSGHhEmSfTSAit904Ji5mNoTLk9yKrp2trf/UZhaFrlCIP2y67wVPX8ng8wboreq6ggwXDO10aZnzXg2/v2U3cWkItxb/cpPQRLrgKYmDwrwlcUZArLLSBgz8QQhmosr3vICE1CmE8NnDj0uCql5VlNp4hYSccceFtk5sXHLxOMiUB28ncTPNy6KUYT71iOi3Y3Nm2nrOkg+Wr7ruE4ekHceIhzJo/cCwPnO0xr80jH7+e0XhU1jOCTw2BZgZG7ACKVATMFiDimASlyxX4dDNob/Cv0RWqRbLqRiHOloSe0x5KW/xZUY1Vzxn8aa6bJv+slDo5IfHxFYQKwD6Qi0ekYgoRKJQSucv+aYpmTm+QViFkFHrJ0IeXsXXVo+XJ+5GXRZkplKA9tn71FA4YkM2d5BBB43crJPMdHjQ1mBCsXGJyi+DDGUASCV1iGvLmX/3UNS5NM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(82740400003)(47076005)(81166007)(16526019)(41300700001)(15650500001)(8936002)(4326008)(8676002)(26005)(336012)(426003)(40480700001)(1076003)(83380400001)(356005)(36756003)(36860700001)(2616005)(40460700003)(86362001)(2906002)(478600001)(44832011)(316002)(6916009)(54906003)(70206006)(70586007)(5660300002)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:14.0414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8318014-87ef-4e82-9424-08dbe6133f1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159
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
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why & How]
Update to the new values per HW team request. Affects both stutter
and z8.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 32 +++++++++----------
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |  8 ++---
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 507a7cf56711..3469f692d6ea 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -443,32 +443,32 @@ static struct wm_table ddr5_wm_table = {
 			.wm_inst = WM_A,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 9,
-			.sr_enter_plus_exit_time_us = 11,
+			.sr_exit_time_us = 14.0,
+			.sr_enter_plus_exit_time_us = 16.0,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_B,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 9,
-			.sr_enter_plus_exit_time_us = 11,
+			.sr_exit_time_us = 14.0,
+			.sr_enter_plus_exit_time_us = 16.0,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_C,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 9,
-			.sr_enter_plus_exit_time_us = 11,
+			.sr_exit_time_us = 14.0,
+			.sr_enter_plus_exit_time_us = 16.0,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_D,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 9,
-			.sr_enter_plus_exit_time_us = 11,
+			.sr_exit_time_us = 14.0,
+			.sr_enter_plus_exit_time_us = 16.0,
 			.valid = true,
 		},
 	}
@@ -480,32 +480,32 @@ static struct wm_table lpddr5_wm_table = {
 			.wm_inst = WM_A,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 11.5,
-			.sr_enter_plus_exit_time_us = 14.5,
+			.sr_exit_time_us = 14.0,
+			.sr_enter_plus_exit_time_us = 16.0,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_B,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 11.5,
-			.sr_enter_plus_exit_time_us = 14.5,
+			.sr_exit_time_us = 14.0,
+			.sr_enter_plus_exit_time_us = 16.0,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_C,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 11.5,
-			.sr_enter_plus_exit_time_us = 14.5,
+			.sr_exit_time_us = 14.0,
+			.sr_enter_plus_exit_time_us = 16.0,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_D,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 11.5,
-			.sr_enter_plus_exit_time_us = 14.5,
+			.sr_exit_time_us = 14.0,
+			.sr_enter_plus_exit_time_us = 16.0,
 			.valid = true,
 		},
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index dee80429fc4c..30d78ad91b9c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -164,10 +164,10 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_5_soc = {
 		},
 	},
 	.num_states = 5,
-	.sr_exit_time_us = 9.0,
-	.sr_enter_plus_exit_time_us = 11.0,
-	.sr_exit_z8_time_us = 50.0, /*changed from 442.0*/
-	.sr_enter_plus_exit_z8_time_us = 50.0,/*changed from 560.0*/
+	.sr_exit_time_us = 14.0,
+	.sr_enter_plus_exit_time_us = 16.0,
+	.sr_exit_z8_time_us = 525.0,
+	.sr_enter_plus_exit_z8_time_us = 715.0,
 	.fclk_change_latency_us = 20.0,
 	.usr_retraining_latency_us = 2,
 	.writeback_latency_us = 12.0,
-- 
2.42.0

