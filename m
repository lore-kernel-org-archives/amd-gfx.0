Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF27C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 06:13:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4F3E10E6F0;
	Wed, 13 Dec 2023 06:13:52 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 149A410E6F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 06:13:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiQlEH5HqWE0FRheTv/RIQSegxD8dQXiwd8QOnzkj29Pc4K+YLoQWHn9F9X9MiYyg9ofhO7K83EbBPNISt46wzmv+p2+0CttWP0x5dEAzKxO61rMkr0mLKhivnlmz1/a6rcNEtVY9Xxowa7m7gNXc8MDzvAF/aho/kn4fgZtQIG8L2dvwXULvRyjbOL3jZhAIYjGIrR74jKanscCsK+Lnf1H5fjNC3vOM+iRCzYfxYFPmDAB0ezNuQHSBOS5daJ6tnbKi5A67E/3nQMQz0y6kKb27C7h4/gQOj/dn+AjlCFk3uxUpKOh5JXmQztYX1hWo1jdMsha9doLgdRet00Y9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoOKT2glFEIK0bWCx3ghUgxUJvUVjBWpaE/ddidDxPQ=;
 b=PKylGKPtcVQMcuWtGw3cGxDSNH1C8lnv0dWbnG+EUQUspzYIzUxPAJe/Vw2Ge9BEz8OPbproevJ30VZSeSf66x6Q0z6FYSgX6t8ZW7el24TDLEMoZEIsoilWgyIdG+zoP3Z5MvYvNAIBh72IFDjuQLLzeNPdn496M12elglWPmRhuUseOmEf7UgajUYdBQRfKVq0X/iaTaV+IIjdpuvkTz0MAR+CXtyIiEl5dD/KMksfyqzi1elQCTy2LcvlGVzaYf/nSc+a8xcjXNE6loz9HLerO1q3cifqeH5An8xosU8Rlz+oLVOsjShHVFvyycWZsj9rz0StbSceoTqqf8vwxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoOKT2glFEIK0bWCx3ghUgxUJvUVjBWpaE/ddidDxPQ=;
 b=G4YY7DtvkAEst6i/GYCNmPi3OK3iqF8tCpJjA+uEwI5mzFeOqmHmPwJfetv82V2RAtjtbAvABl3+5dBfNLMhnRmPWGTZ3Yk5PjJeed6jgbhBotL4yCtIK9BssaBWEl1QyeDV3GZ5Fw8DXp6vDFxzB03yBeRqiWn7mUfeyjViTaE=
Received: from CH0PR03CA0348.namprd03.prod.outlook.com (2603:10b6:610:11a::23)
 by BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 06:13:48 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:610:11a:cafe::14) by CH0PR03CA0348.outlook.office365.com
 (2603:10b6:610:11a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 06:13:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 06:13:47 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:13:45 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 12 Dec
 2023 22:13:45 -0800
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 00:13:40 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/25] drm/amd/display: get dprefclk ss info from integration
 info table
Date: Wed, 13 Dec 2023 14:12:11 +0800
Message-ID: <20231213061227.1750663-10-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231213061227.1750663-1-Wayne.Lin@amd.com>
References: <20231213061227.1750663-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e7df19-b691-4740-e15e-08dbfba2ab47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pTJYBfhP27akjZ56RbQ8+gO9vgOkNiYSLTopzLoZQrz7v2+eXpCHTuhPxbgiTx46NQon5R/pPxfGH3CjqglAdkoLX90B+7fRHXH6sfxWgPdceYG7NDCOeS4Gns6qXY7DOiVTOCKMbId+0WE1ozHyWOBXPfcMibJ/xxt3YE7hoQ3L6sC9GKR2PggbEq6q2lNlEIm2y3th1QbclHsJEnqEzks/09I9KZ0LglU1U/N5KFAZnN+4ThkecVZnSDcu87lwuum8MHZkASq8HFlu1zqrdLcDYOT7quXX1SJlmEu0i2bYyrdbENlKlFClEblZgnaHx5toyzibXeyEjGVvWZCg60SfLOBX97eyl4oz9kag7Rl5hktgpqgpScE1iSkHJ/U57ZvIHIUn6r/CqiuleGkTKEUj2mWTJd8hblMEE9pq29CDpz6wuyIFIoaM6eym9++sdWaoolFOlsBwyqQntRnK3IS/nYlCiFq0nYO0UL5viMALCV6MzOn6EeEzi6Qhms+FOBMwihEbnLGnatZ2V6r2oESPTiZqTb7X4FcKhuivwDDywcKWEgo9nifXjPKUut1YrYUUR6zWxXQlUZAFOPd11JgXQs1pvAcBBJrUrm1BTU5qmJwsXVBiJXtNLHlmF5AG5E4NRvBZD1IgXQv3JJoDGgrjBwoNUe+sYVqDYDV0zDorEfXqX4HeAdIsrXWTE1uhaGMO7ZskLFu6i/2k22OrD3bKzISi0SVAhDZmXMOWaaksA71HDBTOut+7Yh0EEl5sv+KGkP/nSDGN1cAMqTgF6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(451199024)(82310400011)(186009)(1800799012)(64100799003)(46966006)(40470700004)(36840700001)(40460700003)(81166007)(5660300002)(2906002)(41300700001)(86362001)(82740400003)(356005)(2616005)(1076003)(478600001)(336012)(426003)(316002)(6916009)(54906003)(70586007)(70206006)(26005)(6666004)(7696005)(36756003)(4326008)(8936002)(8676002)(47076005)(83380400001)(40480700001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 06:13:47.5883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e7df19-b691-4740-e15e-08dbfba2ab47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131
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
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <charlene.liu@amd.com>

[why & how]
we have two SSC_En:
we get ssc_info from dce_info for MPLL_SSC_EN.
we used to call VBIOS cmdtbl's smu_info's SS persentage for DPRECLK SS info,
is used for DP AUDIO and VBIOS' smu_info table was from systemIntegrationInfoTable.

since dcn35 VBIOS removed smu_info, driver need to use integrationInfotable directly.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    | 19 ++++++++++++++-----
 .../display/include/grph_object_ctrl_defs.h   |  2 ++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index fcd65a2057ad..960c4b4f6ddf 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1014,13 +1014,20 @@ static enum bp_result get_ss_info_v4_5(
 		DC_LOG_BIOS("AS_SIGNAL_TYPE_HDMI ss_percentage: %d\n", ss_info->spread_spectrum_percentage);
 		break;
 	case AS_SIGNAL_TYPE_DISPLAY_PORT:
-		ss_info->spread_spectrum_percentage =
+		if (bp->base.integrated_info) {
+			DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", bp->base.integrated_info->gpuclk_ss_percentage);
+			ss_info->spread_spectrum_percentage =
+					bp->base.integrated_info->gpuclk_ss_percentage;
+			ss_info->type.CENTER_MODE =
+					bp->base.integrated_info->gpuclk_ss_type;
+		} else {
+			ss_info->spread_spectrum_percentage =
 				disp_cntl_tbl->dp_ss_percentage;
-		ss_info->spread_spectrum_range =
+			ss_info->spread_spectrum_range =
 				disp_cntl_tbl->dp_ss_rate_10hz * 10;
-		if (disp_cntl_tbl->dp_ss_mode & ATOM_SS_CENTRE_SPREAD_MODE)
-			ss_info->type.CENTER_MODE = true;
-
+			if (disp_cntl_tbl->dp_ss_mode & ATOM_SS_CENTRE_SPREAD_MODE)
+				ss_info->type.CENTER_MODE = true;
+		}
 		DC_LOG_BIOS("AS_SIGNAL_TYPE_DISPLAY_PORT ss_percentage: %d\n", ss_info->spread_spectrum_percentage);
 		break;
 	case AS_SIGNAL_TYPE_GPU_PLL:
@@ -2813,6 +2820,8 @@ static enum bp_result get_integrated_info_v2_2(
 	info->ma_channel_number = info_v2_2->umachannelnumber;
 	info->dp_ss_control =
 		le16_to_cpu(info_v2_2->reserved1);
+	info->gpuclk_ss_percentage = info_v2_2->gpuclk_ss_percentage;
+	info->gpuclk_ss_type = info_v2_2->gpuclk_ss_type;
 
 	for (i = 0; i < NUMBER_OF_UCHAR_FOR_GUID; ++i) {
 		info->ext_disp_conn_info.gu_id[i] =
diff --git a/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h b/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
index bc96d0211360..813463ffe15c 100644
--- a/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
+++ b/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
@@ -417,6 +417,8 @@ struct integrated_info {
 	/* V2.1 */
 	struct edp_info edp1_info;
 	struct edp_info edp2_info;
+	uint32_t gpuclk_ss_percentage;
+	uint32_t gpuclk_ss_type;
 };
 
 /*
-- 
2.37.3

