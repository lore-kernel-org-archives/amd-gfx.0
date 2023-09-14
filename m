Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DB5EE0213
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D858110E4E4;
	Thu, 14 Sep 2023 02:02:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D548610E4E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:02:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfOfki+bIBkzdVYiegT2YDcGH5aB3r7H8yElJQ9rW6CMB9mk1oj/DY99zG3XkwuVLIYUFgtLBGbzzsXcW/DIss6d4euQUfmAq8pVClDPRBO+h1rSFmD/9ODTFEeHreZBfozpe4gUTe8ilBN/+YUm0Kp/ti9MEOLswD4++Wbcmbsr39eujt/kMsTyeKLDkyhbRAZo4fHO9MzqlGpQtHWgZx/u24DCGmZiOFj6C4bzHVytbDMjuTK/YdhX4GeYDkUuJ2hjlJ8iss5Ow+HMnht7SIhFGmQUxbVBhxDCVC6IVejmrNBAp1I2e36qS3CTeGsgoszdmbwbMndNenopNAIrOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdN+CeT8bIGiZtUflYq4cKAPZSzLi+fVrPZsdj+zyro=;
 b=Z2G38Wf4n6MqOBDDSGHLD1MlU6EY3Pc3Jsa2g6rOZFrLWxJiUr9fVAoDlBIVGN5IXdr38+A6V3DDMT5OYujM9jKh0RHMWZoOGDviCawvZg6zyKf+K0nVgEYqxiTt+KWcuPq5q61ssmSaOksQRGWbMmDaefzCVYYM17DNEoDSrIwQbqKBGI6X7ICBZ6P1cBMEuKGy/LfY2V2lmMRBEdHKzVNzMJXzKaOsoWCKf6OEJxFz8W1fw06A8SPku0CsDrqWFnf3JFUVMnV5atEq01c60hHjhAvfuXLRp8lXOB7lweqrpkqt5k9bu8XQtRHGphmZYy7ZXNJtWCoQtPY949c4MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdN+CeT8bIGiZtUflYq4cKAPZSzLi+fVrPZsdj+zyro=;
 b=qNiUcL7ncB7FoKRG54vYvmcw6XxSL/Jg7TxXL3dq4u0WtT1gUJVNAr/fmcpicRPgfUj8xnx3Ei5Arh7rCxdg+Haml762m6ZWIdIefb2HzDyT2VVHqfEsKa6GYJRTgkrmwN2iU3BnCYfrSG6y2S1CPD484DZGDw4EUAiHGecwYHY=
Received: from BY5PR17CA0018.namprd17.prod.outlook.com (2603:10b6:a03:1b8::31)
 by IA0PR12MB7506.namprd12.prod.outlook.com (2603:10b6:208:442::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 02:02:16 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::47) by BY5PR17CA0018.outlook.office365.com
 (2603:10b6:a03:1b8::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Thu, 14 Sep 2023 02:02:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 02:02:16 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:02:04 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/28] drm/amd/display: Use optc32 instead of optc30 in DC
Date: Wed, 13 Sep 2023 20:00:17 -0600
Message-ID: <20230914020021.2890026-25-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
References: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|IA0PR12MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cc788f5-9662-4247-bdce-08dbb4c69edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EyeWvsFI3qbDFmQb2tPa6MsmYTduSWG0Dx/0oVvmHsoIPtGqdw6RZbbGrtbvrCFEiMXGF8Q3IX23pXl8auAXpfk8XcGvDRecOnAD5MrgwcMo1AKhrOPznI+V86UP06CNdZ1YegddSIUq9fSasQ6O4MLqiS1OMwdAKQAtOkUjCdpaZndiWyTP5JKBCvOvJE18jZJGw1xrRAHYuS/4juKU4j9B/LDSyq5CougCYA0aqr6UM7o3S4PyYPm+YETuRsP6NnR3MizAJ0YPyREw3HTYtnGnXHEz8ZQZPrZ/ONMmmw8vsOF9n/y0LQsgSkMVN4rBBbgAWMfQR2WnnsYLxgP7h4ayQnvyu6crJfXRj5hFqVPrWwOvkIMXntt03amIb4VYZgDOryPiwIq477tqWX5Cgt7LwHud0WHrTj+nZV+6XGZQO0/WyQmCvGgL+9fdhMxLFqkBJ8oa4+DYkoc6gSd8Y4dyMUybBqsLiDRKKXnnfZPqXlLq7KwmLcvkKq/w1rqKKYSFIzOCbTgwU6vVI5kYzkyFGuJyntyqTeRKD/D3tjSBzZ3jAKnuQQj22mEM5FbnluaJeoXZU/IHQu3gVd0prkUPyLFO4QDwvg8bs5dHcDnX4cqoqVktbLAfBHpMh2IWxYlezlRUtAIiPbXqi7qSATSfl5vL1axgCP4iRvfv0gvBGhVVjszH1XktN306W58BWKC1n8QVu6I2QUpTM9OXseNHx80FCcfklmgq9pxCBHKJ5LdK/fIzcIiHPmPxgym64oDtVyc9acAnI2d1nD5YTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(1800799009)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(6666004)(70206006)(478600001)(426003)(2616005)(83380400001)(26005)(4326008)(336012)(1076003)(2906002)(6916009)(8936002)(16526019)(8676002)(54906003)(70586007)(316002)(5660300002)(36756003)(41300700001)(82740400003)(36860700001)(40460700003)(47076005)(40480700001)(86362001)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:02:16.4288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc788f5-9662-4247-bdce-08dbb4c69edd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7506
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
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Ovidiu Bunea <ovidiu.bunea@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

Change DC to use optc32, which uses REG_UPDATE instead of REG_SET.
REG_SET clears OTG_H_TIMING_DIV_MODE_MANUAL which must be set to 1 for
FRL DSC.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c | 2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index 5bf4d0aa6230..b97bdb868a0e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -207,7 +207,7 @@ void optc3_set_odm_bypass(struct timing_generator *optc,
 			);
 
 	h_div = optc1_is_two_pixels_per_containter(dc_crtc_timing);
-	REG_SET(OTG_H_TIMING_CNTL, 0,
+	REG_UPDATE(OTG_H_TIMING_CNTL,
 			OTG_H_TIMING_DIV_MODE, h_div);
 
 	REG_SET(OPTC_MEMORY_CONFIG, 0,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
index e7e25c58c692..a2c4db2cebdd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
@@ -201,7 +201,7 @@ static void optc32_disable_phantom_otg(struct timing_generator *optc)
 	REG_UPDATE(OTG_CONTROL, OTG_MASTER_EN, 0);
 }
 
-static void optc32_set_odm_bypass(struct timing_generator *optc,
+void optc32_set_odm_bypass(struct timing_generator *optc,
 		const struct dc_crtc_timing *dc_crtc_timing)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h
index 93cc7fc8472c..8ce3b178cab0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h
@@ -181,5 +181,7 @@
 void dcn32_timing_generator_init(struct optc *optc1);
 void optc32_set_h_timing_div_manual_mode(struct timing_generator *optc, bool manual_mode);
 void optc32_get_odm_combine_segments(struct timing_generator *tg, int *odm_combine_segments);
+void optc32_set_odm_bypass(struct timing_generator *optc,
+		const struct dc_crtc_timing *dc_crtc_timing);
 
 #endif /* __DC_OPTC_DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c
index 2bea1e475096..b0c068240a94 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c
@@ -249,7 +249,7 @@ static struct timing_generator_funcs dcn35_tg_funcs = {
 		.set_dsc_config = optc3_set_dsc_config,
 		.get_dsc_status = optc2_get_dsc_status,
 		.set_dwb_source = NULL,
-		.set_odm_bypass = optc3_set_odm_bypass,
+		.set_odm_bypass = optc32_set_odm_bypass,
 		.set_odm_combine = optc35_set_odm_combine,
 		.get_optc_source = optc2_get_optc_source,
 		.set_h_timing_div_manual_mode = optc32_set_h_timing_div_manual_mode,
-- 
2.40.1

