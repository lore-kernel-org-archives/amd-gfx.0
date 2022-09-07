Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07647C54EE9
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 18:12:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D54610E6B7;
	Wed,  7 Sep 2022 18:12:29 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74AB510E469
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 18:12:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjLN2Gj9UQk5UhHYKXK2WaRiy7PO7sQQWn+MvkXmMhC0FEMfssXKFtfrALfi+dYr9/cbn+oi6PaTu1/YDhtarz+mQihxgYV779WNuORJVuvuqtng76VGk/oXwx3bwzs0+gcLJHADnwafM7wI9FJVDur6fo6xynuyVi5zTWgWWedjv7mftd2dCm1wB06tDbMfTTLAGuLoP9nOMhm411LG1DUXB1WGIzQReBA4JFjtP+WQmqWCjOAhr+ap+tbqA/QtIu/CnGVZ5QP4UVpxln94lzGueoAXBT08kPHWyUgHz2fm3KbWjmWHcf0EM8NUpI3R1ji+jbvBQc3DI1UXCKzmHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlu0Sndcmm+QuQe/G4adNKxRfEp5ZJKppc7nLdSySPU=;
 b=jo7oKoz5FzgMEcModkmEDwaufcZjQDx8fE5RAH4D1nd9h1yldZzd55zPlbfi6CFVWpHDOxnVRrOvU+JKUagDFzfF3TGuDXiyjvlkG1xOv+IUX4j+9wii5z4BDVzMVkMswsk85VeaQHZpoCyfiF7ai2DR6OvcgVTEmpWf8f/O1O0+1RL8AlPdTHDG5U8VxiOwbSj1teEl2e9V5bB7u+UNeh9mieFI7Y19sSZTgdKO2EKVbDnmDRxaJuW5uMiJVdjC9WaXOq51fTNykIwEBIfqJW4G/j9tXPRNin6CcuniUhvCDRcFtJ8if1TN760Qa3yS3fD7dUTsK6v+xHBQijdpig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlu0Sndcmm+QuQe/G4adNKxRfEp5ZJKppc7nLdSySPU=;
 b=UFyiAd4Xhw5MRe4mFH9MT1JEJ6xf8HdMysiR9iwH/Zylya8J1JWkgxhavVqQrCUnGGaTp+pIETX9TMBa822dua/dU1D+u3teo5o1uTpc/BaW1kFjgZHUjFgakwIAe4MuR10ZKoeNR4uoCgBRPQyVfCwznTT/gWSjP0Czwxv7ILI=
Received: from DS7PR07CA0020.namprd07.prod.outlook.com (2603:10b6:5:3af::12)
 by DS0PR12MB7605.namprd12.prod.outlook.com (2603:10b6:8:13d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 7 Sep
 2022 18:12:21 +0000
Received: from DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::6d) by DS7PR07CA0020.outlook.office365.com
 (2603:10b6:5:3af::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 7 Sep 2022 18:12:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT105.mail.protection.outlook.com (10.13.173.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:12:21 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:12:19 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/21] drm/amd/display: Fix divide by zero in DML
Date: Wed, 7 Sep 2022 14:11:44 -0400
Message-ID: <20220907181200.54726-5-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907181200.54726-1-pavle.kotarac@amd.com>
References: <20220907181200.54726-1-pavle.kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT105:EE_|DS0PR12MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: df4c070d-40ba-43c4-a576-08da90fc8244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fVMJSmIbYIeLATegDa/QIUGUzkftGNd7AwOohzNzeToLsc/XZ7P8Hzr1UOcZ/efW/FVREbQsc3U6rBHrPnE3mamhZXxaUavzygBZaokomDSfLXejgfUpqhfc4coMsaltrDTwjJVQeru+8Rq6Wyf+4/WNsOIi8T6i+iEi8v98AA9KEknWPu8lqHL9kIIrhKp4QhTZz9rlxzpCvCvV78lWFNjZhvh7J+Xhs32rzdRw+M5wDXBAKvaQvMLBw/JvTX/wDTycioiPfSg/kzjL/TK0nh1fk772gpC1HW+ISijR3W4EPF8jkP0+VXJIJuh4ad9kIzoislhjrV6ViXK/CgOcyKCcJqgKdEVxNblhK9gp9Kg/jpYc4E4HsnWcPkM7+n88RRm1JYAplGy323MrJmGpcj1CHfCRpMassNEyzlQPwq9INQlonmJGYdtkoi8UyoNQ4WIgrTVrzzGClRtezJsp0qTuJibRPqJq5yq7w4p6fegmfy2DOQMsbt8+xBti++U5SVi40asR9apZdLXKaq66iK96mCb3x5Td08+Eq1q6/5TCVqK2Z9AkOHm0/m9iL+6VXVwGNwgQ/pE2VGKVbU632KPvvFiYksnNRBeBlWbiANfakMuGxLmdFLOGMd/aAxu0Mlq/+wTUOGNSbGkNcLEmfX0Uw+JphOzGFFwWLl+HU8hnfeINQDF4qO7cG15TFzCwUOEGoRjVo8pbWfCpmw5a1fOddwUBYYpuyHUa5eI43IXHOQtnzVRx+etzXPf+cnJzgGVLhqa6ktCt+zjBnTcIi/YDy+Lz7NMofttpLNXM84VcPeFAWQ2qZ85iSHE2r598
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(136003)(40470700004)(36840700001)(46966006)(82310400005)(86362001)(2616005)(26005)(356005)(81166007)(7696005)(478600001)(41300700001)(6666004)(40480700001)(40460700003)(82740400003)(83380400001)(186003)(426003)(1076003)(47076005)(336012)(16526019)(36860700001)(2906002)(8936002)(316002)(6916009)(54906003)(70206006)(4326008)(70586007)(36756003)(8676002)(44832011)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:12:21.7104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df4c070d-40ba-43c4-a576-08da90fc8244
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7605
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[why]
Incorrectly using MicroTileWidth instead of MacroTileWidth for
calculations.

[how]
Remove all unused references to MicroTile and change them to MacroTile.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 .../dc/dml/dcn32/display_mode_vba_32.c        | 24 +++++++++----------
 .../drm/amd/display/dc/dml/display_mode_vba.h | 10 ++++----
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index d8014bfbc3fe..cd6bf67035d4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -1806,10 +1806,10 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				&mode_lib->vba.Read256BlockHeightC[k],
 				&mode_lib->vba.Read256BlockWidthY[k],
 				&mode_lib->vba.Read256BlockWidthC[k],
-				&mode_lib->vba.MicroTileHeightY[k],
-				&mode_lib->vba.MicroTileHeightC[k],
-				&mode_lib->vba.MicroTileWidthY[k],
-				&mode_lib->vba.MicroTileWidthC[k]);
+				&mode_lib->vba.MacroTileHeightY[k],
+				&mode_lib->vba.MacroTileHeightC[k],
+				&mode_lib->vba.MacroTileWidthY[k],
+				&mode_lib->vba.MacroTileWidthC[k]);
 	}
 
 	/*Bandwidth Support Check*/
@@ -2661,10 +2661,10 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			mode_lib->vba.Read256BlockWidthC,
 			mode_lib->vba.Read256BlockHeightY,
 			mode_lib->vba.Read256BlockHeightC,
-			mode_lib->vba.MicroTileWidthY,
-			mode_lib->vba.MicroTileWidthC,
-			mode_lib->vba.MicroTileHeightY,
-			mode_lib->vba.MicroTileHeightC,
+			mode_lib->vba.MacroTileWidthY,
+			mode_lib->vba.MacroTileWidthC,
+			mode_lib->vba.MacroTileHeightY,
+			mode_lib->vba.MacroTileHeightC,
 
 			/* Output */
 			mode_lib->vba.SurfaceSizeInMALL,
@@ -2711,10 +2711,10 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BlockHeight256BytesY = mode_lib->vba.Read256BlockHeightY[k];
 				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BlockWidth256BytesC = mode_lib->vba.Read256BlockWidthC[k];
 				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BlockHeight256BytesC = mode_lib->vba.Read256BlockHeightC[k];
-				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BlockWidthY = mode_lib->vba.MicroTileWidthY[k];
-				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BlockHeightY = mode_lib->vba.MicroTileHeightY[k];
-				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BlockWidthC = mode_lib->vba.MicroTileWidthC[k];
-				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BlockHeightC = mode_lib->vba.MicroTileHeightC[k];
+				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BlockWidthY = mode_lib->vba.MacroTileWidthY[k];
+				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BlockHeightY = mode_lib->vba.MacroTileHeightY[k];
+				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BlockWidthC = mode_lib->vba.MacroTileWidthC[k];
+				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].BlockHeightC = mode_lib->vba.MacroTileHeightC[k];
 				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].InterlaceEnable = mode_lib->vba.Interlace[k];
 				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].HTotal = mode_lib->vba.HTotal[k];
 				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters[k].DCCEnable = mode_lib->vba.DCCEnable[k];
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index da8acf59ccac..630f3395e90a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -652,10 +652,10 @@ struct vba_vars_st {
 
 	unsigned int OutputTypeAndRatePerState[DC__VOLTAGE_STATES][DC__NUM_DPP__MAX];
 	double RequiredDISPCLKPerSurface[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
-	unsigned int MicroTileHeightY[DC__NUM_DPP__MAX];
-	unsigned int MicroTileHeightC[DC__NUM_DPP__MAX];
-	unsigned int MicroTileWidthY[DC__NUM_DPP__MAX];
-	unsigned int MicroTileWidthC[DC__NUM_DPP__MAX];
+	unsigned int MacroTileHeightY[DC__NUM_DPP__MAX];
+	unsigned int MacroTileHeightC[DC__NUM_DPP__MAX];
+	unsigned int MacroTileWidthY[DC__NUM_DPP__MAX];
+	unsigned int MacroTileWidthC[DC__NUM_DPP__MAX];
 	bool ImmediateFlipRequiredFinal;
 	bool DCCProgrammingAssumesScanDirectionUnknownFinal;
 	bool EnoughWritebackUnits;
@@ -801,8 +801,6 @@ struct vba_vars_st {
 	double PSCL_FACTOR[DC__NUM_DPP__MAX];
 	double PSCL_FACTOR_CHROMA[DC__NUM_DPP__MAX];
 	double MaximumVStartup[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
-	unsigned int MacroTileWidthY[DC__NUM_DPP__MAX];
-	unsigned int MacroTileWidthC[DC__NUM_DPP__MAX];
 	double AlignedDCCMetaPitch[DC__NUM_DPP__MAX];
 	double AlignedYPitch[DC__NUM_DPP__MAX];
 	double AlignedCPitch[DC__NUM_DPP__MAX];
-- 
2.34.1

