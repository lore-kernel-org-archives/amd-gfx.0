Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC27ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E13110E3B2;
	Wed, 14 Sep 2022 05:11:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB2AD10E3B2
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:11:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ja1eAIIS5zq59+kgrlvTmnOaI0Mbeo1cg4pCKrpkQrUbt2CxS6cAFbZWFuAcCJlsJaLB9oFM+Wqs/U3EIdQi95tcaGPV/pZutv95cxhFEJmIMJ/Z1nwfKzvK9cHqXg0+CaHUwzKOXIdYVLDaIDB849zfJMoQqkn3Ko2KLn2fnUHhhDICSN2r+Qax6bu1llXqyGmMh5SRckvfpQE84bGiHwgmKgL9DAa11+Kcl0B0s0qEehZeTZToUsiVR5vw9BuF4mdDM2c6MqdXbS33HxZLbCNZ40i63OuhUEguFxh4O8YiWTBf3ZQ6PKeKVddKWhpf+/bQjHWqR8j8I0vrr2fpMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zryLE1PFDOYJ3wm2AFfCLPdKdKB8dZZA8/YsXQpytKU=;
 b=NyMkzFGXnN6mlGh6/Vea3Iw6X6N4EFiLuIiXCjMs60GbDVWNzC+AmItaG1z/Efs1wLGrhN9L4Ztt28B5r1dDQt3oIaBdRy5IEu4Uid+/r9S270TTZfazEG9eWemgppEUujuE8xKq3GLyrTuG8jd6vNMTlYECVzWkPZxK51c88JwC3rYde1+fyDjSQY3GLaAePwzm9EiBGrUOTsF38tLD4MyzyzltCsmYygdQX2cV7Mr2sAFzUTcYo8fM8eSvJBQySstAa1zaiuOEFILITzi3TSHCryYBAwnu6FA7aAP8CaxvK5Trxw9piCMamtIq+QsUEzweSbUyKEXNwJ4vpBiGxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zryLE1PFDOYJ3wm2AFfCLPdKdKB8dZZA8/YsXQpytKU=;
 b=eiOSniVQrrCAshVSFH4414SbVuR18kQQIzn9jtRaScFwjVr7ix459+rmDI8tY6kUl5SOJ1ksbDVfOffyCpWpmox0eNzuJrAPdv9MQI77gLRsWWnEQ+uHbcE60Im+0yUcTpF0tpxfBbiyaKxRZaSBq1QzkS17EZTVH5ddbbksaCo=
Received: from MW4PR03CA0307.namprd03.prod.outlook.com (2603:10b6:303:dd::12)
 by CH0PR12MB5057.namprd12.prod.outlook.com (2603:10b6:610:e0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 05:11:50 +0000
Received: from CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::b5) by MW4PR03CA0307.outlook.office365.com
 (2603:10b6:303:dd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19 via Frontend
 Transport; Wed, 14 Sep 2022 05:11:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT108.mail.protection.outlook.com (10.13.175.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:11:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:11:33 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:11:29 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 01/47] drm/amd/display: Port DCN30 420 logic to DCN32
Date: Wed, 14 Sep 2022 13:10:00 +0800
Message-ID: <20220914051046.1131186-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT108:EE_|CH0PR12MB5057:EE_
X-MS-Office365-Filtering-Correlation-Id: d707bc61-5e7d-4079-5051-08da960fa10c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cX9B84TC7RrFNdiOKDFx3h4WnX8KcdHWQA4HR+FITR1zIQD/HK1muu+3Xs5jLeLuzr5/GbbZz0ts94X2Zg86E+pn67oiGYl5UuzUZuSrp0d4AQM3VFUO8sDhe8uzYEExU3IvENeXKxs1+KdK7ks7BFml8QT2PXgDz+QFzsozXp8c9xQ0BO7+fl2yAF9r5FMQf2E01Qn6xZfPn378XoGyXJiJPNjF+napyR7bkjKexQAlA2vOUCvaJ4IFqBkXRSSD0VXSBGphUQT9pd/JR7bBSMnZy57XXxMrfhGeFz1aFun+0fH+Am8VkAlqcCGTMu+PjGiWl54+DIAQc7f8d/ZL8wmgEzA671ccwgQa816nLTqdghQJ1Gl1oUPaCiXCGDk5r+QQCea8rSKJrcVFGbezDhUTrDC9OZO3bGeUQuOK/c6KMUCoQKEkONCcr/KQ2RsWRovc8yiV3RqRGsP2d/s+wUSIwdoyoEhzienKYkMu08pca1G0BwF+hADZ9vct9WR5RKoTO/j/2GnN3sUixNeEv47qnFi5poHUlL/+G9g49lYyyJFrEt2N8JXfI3gwtaZ/sM5i78t7K/ibQWlqpkJazsNxMrAZPXeogyuq/2o80EeApBJJXofyqFz7H13Dhrt+tB0ge0H4eFvNofHQoLpFpyxFfPQHflfXXf/wsuuVwGOpScm8HPz/9TNxolBqPYsnMgn/2HGXc3uDaPzvCwqY4+PD4kJW17ZCXxBOh2lPkvrgdUWX91urZ2HWLI0cfwpKeLTCf/SGssINndbdqI2KILrAkdetvJwrWIpQ6pQwjYVXeETEyzVghlpndlDcLBFY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(8676002)(2906002)(356005)(82310400005)(40480700001)(81166007)(86362001)(41300700001)(316002)(1076003)(186003)(47076005)(8936002)(2616005)(70586007)(26005)(336012)(426003)(5660300002)(82740400003)(54906003)(83380400001)(478600001)(36860700001)(36756003)(7696005)(4326008)(40460700003)(70206006)(6666004)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:11:49.5086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d707bc61-5e7d-4079-5051-08da960fa10c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5057
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
Cc: stylon.wang@amd.com, Chris Park <chris.park@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <chris.park@amd.com>

[Why]
420 modes are limited by FMT buffer width of 4096
which requires multi-pipe support in form of ODM
combine.  If 420 modes have greater HActive than
4096, the DML logic should accomodate whether
it should be rejected, or ODM combine 2:1 or 4:1
is triggered accordingly.

[How]
FMT Buffer limit of 4096 in DCN32. Force ODM
combine depending on HActive and FMT Buffer limit.
Reject modes if TMDS 420 and above 4096.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
---
 .../dc/dml/dcn32/display_mode_vba_32.c        |  2 ++
 .../dc/dml/dcn32/display_mode_vba_util_32.c   | 26 +++++++++++++++++++
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |  1 +
 3 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index ad100658132f..75be1e1ce543 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -1992,6 +1992,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				dml32_CalculateODMMode(
 						mode_lib->vba.MaximumPixelsPerLinePerDSCUnit,
 						mode_lib->vba.HActive[k],
+						mode_lib->vba.OutputFormat[k],
 						mode_lib->vba.Output[k],
 						mode_lib->vba.ODMUse[k],
 						mode_lib->vba.MaxDispclk[i],
@@ -2014,6 +2015,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				dml32_CalculateODMMode(
 						mode_lib->vba.MaximumPixelsPerLinePerDSCUnit,
 						mode_lib->vba.HActive[k],
+						mode_lib->vba.OutputFormat[k],
 						mode_lib->vba.Output[k],
 						mode_lib->vba.ODMUse[k],
 						mode_lib->vba.MaxDispclk[i],
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 5b5b94f1024d..ad66e241f9ae 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -27,6 +27,8 @@
 #include "display_mode_vba_32.h"
 #include "../display_mode_lib.h"
 
+#define DCN32_MAX_FMT_420_BUFFER_WIDTH 4096
+
 unsigned int dml32_dscceComputeDelay(
 		unsigned int bpc,
 		double BPP,
@@ -1179,6 +1181,7 @@ void dml32_CalculateDETBufferSize(
 void dml32_CalculateODMMode(
 		unsigned int MaximumPixelsPerLinePerDSCUnit,
 		unsigned int HActive,
+		enum output_format_class OutFormat,
 		enum output_encoder_class Output,
 		enum odm_combine_policy ODMUse,
 		double StateDispclk,
@@ -1253,6 +1256,29 @@ void dml32_CalculateODMMode(
 		else
 			*TotalAvailablePipesSupport = false;
 	}
+	if (OutFormat == dm_420 && HActive > DCN32_MAX_FMT_420_BUFFER_WIDTH &&
+			ODMUse != dm_odm_combine_policy_4to1) {
+		if (HActive > DCN32_MAX_FMT_420_BUFFER_WIDTH * 4) {
+			*ODMMode = dm_odm_combine_mode_disabled;
+			*NumberOfDPP = 0;
+			*TotalAvailablePipesSupport = false;
+		} else if (HActive > DCN32_MAX_FMT_420_BUFFER_WIDTH * 2 ||
+				*ODMMode == dm_odm_combine_mode_4to1) {
+			*ODMMode = dm_odm_combine_mode_4to1;
+			*RequiredDISPCLKPerSurface = SurfaceRequiredDISPCLKWithODMCombineFourToOne;
+			*NumberOfDPP = 4;
+		} else {
+			*ODMMode = dm_odm_combine_mode_2to1;
+			*RequiredDISPCLKPerSurface = SurfaceRequiredDISPCLKWithODMCombineTwoToOne;
+			*NumberOfDPP = 2;
+		}
+	}
+	if (Output == dm_hdmi && OutFormat == dm_420 &&
+			HActive > DCN32_MAX_FMT_420_BUFFER_WIDTH) {
+		*ODMMode = dm_odm_combine_mode_disabled;
+		*NumberOfDPP = 0;
+		*TotalAvailablePipesSupport = false;
+	}
 }
 
 double dml32_CalculateRequiredDispclk(
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
index 3dbc9cf46aad..55cead0d4237 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
@@ -216,6 +216,7 @@ void dml32_CalculateDETBufferSize(
 void dml32_CalculateODMMode(
 		unsigned int MaximumPixelsPerLinePerDSCUnit,
 		unsigned int HActive,
+		enum output_format_class OutFormat,
 		enum output_encoder_class Output,
 		enum odm_combine_policy ODMUse,
 		double StateDispclk,
-- 
2.37.3

