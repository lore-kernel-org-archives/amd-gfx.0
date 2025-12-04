Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18515D1F9CB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Dec 2025 12:10:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B107510E92E;
	Thu,  4 Dec 2025 12:10:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vChCRhWR";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010059.outbound.protection.outlook.com
 [40.93.198.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0A8110E92E
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Dec 2025 12:10:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZzbakw4FNPuLhCGa+UlF+Qs1gcH16UjZUCrRzSugaNrh532JStF0gFfo0SjUqOhQa0de5l528IepvMnAGn/jwU1BEQC0TAhge4iMF3AuT5RGKZAdULq1We5mTCPnb9DMKQwk7ZZ0e4HwHmfdVjf1d5DW+qgHmSfQWaXdzllBpgngcVPOPn/53HklacQ9VC+/Acs4PB5cZHxKL5AaUMQCeNKcDofDymMVnACkTw0JKS1cXR/KMMUYV5c72Qr/2lH4RUwD2wpiNJnXpNokvYABsrw4x0qnyAwX0urwsijmkcRm1TMwbzAk/rb40HU/32f6Jz8WXf9P0IR8/YF5L2pcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teAJkzYI2ATOP5YEtAomdd3+r7fgXIC9/cZ32J7rwK4=;
 b=AkSzBPv+WDZhj2BqwwT3WSijbIJTZgiaBzxisyfCeyi4j6G5y7LjajE4rTWKvlJbDWEVPg0UCkkarC1uCuh0/iz+SSvaBCwtmOjHxGTy6JXbDSNCdaGGNnL6USE1i9dJTbTcW3/7j7esUr96Jj/oYuOpGEGTUReVeC1tX7gK12zcOWS+JsBph84P25VmIdWZzv+8ct6D13SlgZhQOC6wAUHJ4ArXOMfIDgdAT6pp0wCKrf7yp+QFp4g1fKTDMuRjelixdfxY0JFUJRnvoYnbumJZbCN0fABXYVenhsdjH7svkhyTPSQ+Rgb/HxtGAR/uqWLrZvx7Qm9aFBvGT9Mp5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teAJkzYI2ATOP5YEtAomdd3+r7fgXIC9/cZ32J7rwK4=;
 b=vChCRhWR4Na/gLzMDKB0BtDjfaLtZ9jQvlCOIM5F5xbLBzTt93mg7Ki5KylfUlFIdV1TEBmBb7lLbvAAMr7Jg3Vql5D0MjQrHfpcLCQ+VEpIcunZFJKjPWAkB00snJgns+85+0aW4NdGb6K8aoZqZtnkrbjFAr/BFInOkVgdnGY=
Received: from CH0PR03CA0048.namprd03.prod.outlook.com (2603:10b6:610:b3::23)
 by CH8PR12MB9789.namprd12.prod.outlook.com (2603:10b6:610:260::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 12:10:43 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::60) by CH0PR03CA0048.outlook.office365.com
 (2603:10b6:610:b3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Thu,
 4 Dec 2025 12:10:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 12:10:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 4 Dec
 2025 06:10:42 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 4 Dec
 2025 06:10:41 -0600
Received: from drvdevbldsrv2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 4 Dec 2025 04:10:40 -0800
From: mythilam <mythilam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: mythilam <mythilam@amd.com>
Subject: [PATCH v1] drm/amd/pm: restore SCLK settings after S0ix resume
Date: Thu, 4 Dec 2025 17:40:35 +0530
Message-ID: <20251204121035.504066-1-mythilam@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|CH8PR12MB9789:EE_
X-MS-Office365-Filtering-Correlation-Id: 53ea1942-6f4d-40f5-eb40-08de332e25e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vrOt4/HqAqv2U5tZHnYx1tPvWR3KzY7NKAtSAsdgV9oVPuHASFQH12AOBMEO?=
 =?us-ascii?Q?4QW4iPTpTzOl3/azVTqkIEHh/jngrmCMpikxk4nifmezUsjUh6o/GdGElwbQ?=
 =?us-ascii?Q?b3SxKm/SVftMx8cxslfZFuL2UW4YiA4yKRRchB2eElkdDWFD+k3wayGwDp4p?=
 =?us-ascii?Q?BD0cRNo51zSwAeZTL+cWQdxRCyx+2G8YA9ihj4SMr/+nsefDAiK7V3glTvhg?=
 =?us-ascii?Q?+jU/l4Nz/mCgrVhi/mf93AVmh/GCDNjx6MGxZ7UKVCMPXDZLtjUneMWVXLtM?=
 =?us-ascii?Q?CK6Pvolp/VHRrWalDOo+tI9b9QT6CL06K6B2Q2sG2v63ECiwFMLfsNoK1kdJ?=
 =?us-ascii?Q?D3d4RxEMXILoWqTxSGB37kcVCNIUadtqFBs6T7BuwbTw9OkuzcqIiWwyXuOs?=
 =?us-ascii?Q?RWCYwGj6Lk2bm3OqiWKuGDlG1vhttgmYBRBc7JD7KoCWp+nBkK30fQbuPDS8?=
 =?us-ascii?Q?aebWJQCJDfnQvq4aQmIjgmBIPbMonWR83oQuPY8OOUat9G1A2aPBl9M94yYd?=
 =?us-ascii?Q?ba8vhGe1CsILuN8EXwG0pNnuQpju8hNUhcrnnD3LGBRXAeKrmLrJmse6DGNM?=
 =?us-ascii?Q?IPfWYrUVmUN3MTT0lVhpgeo1D+l1myAALJIoj/j3UXV+Tz3mruRPCY3X+sBa?=
 =?us-ascii?Q?mOLye1s43uyottuGWgw4PVcOWaJCLktxBufRUKqrt6X34uEQyCxRhr7IZMZq?=
 =?us-ascii?Q?Yd0J0GW3Yzurca3qFFpa9eiqIJnSIAQX2FIfCDJXRU+IFkc9xQ3x0pElOve0?=
 =?us-ascii?Q?IxSUNS/aKPJjTXgfwaGJ9c9Cfwvq+5MdTdg2B4BbmJa8aQFs+Hc3P3ANcfUt?=
 =?us-ascii?Q?ojGe7FWqM/WbuUc2+heQRrK4TDDcX4KvdhD2IcXFSDEEKdslVu+Cr9cr5CoG?=
 =?us-ascii?Q?3Jgdehg6xuQL2eS5YJuufGGPW+j0DFAQgFdkz0k9xjFz62f1fQWTdgWKTxO+?=
 =?us-ascii?Q?W70PZG/nQ4B9BWl7o6hISJzQMqJ4Gkr7zKDheMiFdM83K84y9e8k0CcypDFe?=
 =?us-ascii?Q?y6/XHA1Tn4WmO7jYSuYFBXvtyxJAEXNLgE682Cax8+1SUlNvd2R+Tq3XpZ/6?=
 =?us-ascii?Q?h1L1d3HqZUa+Zvkc1ru9YVAgetg9QbdTpebNQOSNtFjurzqJUA3Ua2hLzm8l?=
 =?us-ascii?Q?jUQqQYza+3XMvu3C1Hlgh/sYqX3T0Dy+iCVHrpNlv2sw2ivYZJNQy3LNN6An?=
 =?us-ascii?Q?d1a7L5FCzneb9LMfNI21BLE8EQZEj3SURtYi4XZPwbFeIEkyxFCQmTm61p5i?=
 =?us-ascii?Q?NiHtX1c/tM5CBOc7KQsgrsp5Xfl8CmxCdwqpHD8icXETXFTkZ7EnEJoEpRXF?=
 =?us-ascii?Q?ARQo/awL8gJKuvfPC2LgDNdPGooMMxlVLBOiHzOu//oTaVvO2ftagcNuh6+B?=
 =?us-ascii?Q?SLIn/lSjEmgDVpKazUe1GmNw73biCCPIJYvA5RNGul8bdpk0md8zozJTW+qF?=
 =?us-ascii?Q?mgJ1Jg8gSQ4nX14MqDAqwLQLBvcktZQ8hg57q2i8c4yszVYDtUnzE4myV0Dy?=
 =?us-ascii?Q?rnNOofhCP/48WSrKDD+YsblJDmHi5dr9FA7cmEMEZyetJLbvG6zE409HzAHo?=
 =?us-ascii?Q?/b0rJHRgZ4tY4U8Lwi4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 12:10:43.0257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ea1942-6f4d-40f5-eb40-08de332e25e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9789
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

User-configured SCLK(GPU core clock) frequency are not persisting
across S0ix suspend/resume cycles on smu v14 hardware. The issue
is because of the code updating the clock frequency during resume.

This patch resolves the issue by:
- Preserving user-configured values in driver and sets the clock
  frequency during resume
- Preserved settings are sent to the smu hardware

Signed-off-by: mythilam <mythilam@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  5 +++
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 37 ++++++++++++++++---
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index f9b0938c57ea..f2a16dfee599 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1939,6 +1939,11 @@ int smu_v14_0_od_edit_dpm_table(struct smu_context *smu,
 			dev_err(smu->adev->dev, "Set soft max sclk failed!");
 			return ret;
 		}
+		if (smu->gfx_actual_hard_min_freq != smu->gfx_default_hard_min_freq ||
+		    smu->gfx_actual_soft_max_freq != smu->gfx_default_soft_max_freq)
+			smu->user_dpm_profile.user_od = true;
+		else
+			smu->user_dpm_profile.user_od = false;
 		break;
 	default:
 		return -ENOSYS;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index fe00c84b1cc6..8d72a962aef7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1513,9 +1513,10 @@ static int smu_v14_0_1_set_fine_grain_gfx_freq_parameters(struct smu_context *sm
 
 	smu->gfx_default_hard_min_freq = clk_table->MinGfxClk;
 	smu->gfx_default_soft_max_freq = clk_table->MaxGfxClk;
-	smu->gfx_actual_hard_min_freq = 0;
-	smu->gfx_actual_soft_max_freq = 0;
-
+	if (smu->gfx_actual_hard_min_freq == 0)
+		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
+	if (smu->gfx_actual_soft_max_freq == 0)
+		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
 	return 0;
 }
 
@@ -1525,8 +1526,10 @@ static int smu_v14_0_0_set_fine_grain_gfx_freq_parameters(struct smu_context *sm
 
 	smu->gfx_default_hard_min_freq = clk_table->MinGfxClk;
 	smu->gfx_default_soft_max_freq = clk_table->MaxGfxClk;
-	smu->gfx_actual_hard_min_freq = 0;
-	smu->gfx_actual_soft_max_freq = 0;
+	if (smu->gfx_actual_hard_min_freq == 0)
+		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
+	if (smu->gfx_actual_soft_max_freq == 0)
+		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
 
 	return 0;
 }
@@ -1664,6 +1667,29 @@ static int smu_v14_0_common_set_mall_enable(struct smu_context *smu)
 	return ret;
 }
 
+static int smu_v14_0_0_restore_user_od_settings(struct smu_context *smu)
+{
+	int ret;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
+					      smu->gfx_actual_hard_min_freq,
+					      NULL);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to restore hard min sclk on resume!\n");
+		return ret;
+	}
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
+					      smu->gfx_actual_soft_max_freq,
+					      NULL);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to restore soft max sclk on resume!\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.check_fw_status = smu_v14_0_check_fw_status,
 	.check_fw_version = smu_v14_0_check_fw_version,
@@ -1687,6 +1713,7 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.mode2_reset = smu_v14_0_0_mode2_reset,
 	.get_dpm_ultimate_freq = smu_v14_0_common_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = smu_v14_0_0_set_soft_freq_limited_range,
+	.restore_user_od_settings = smu_v14_0_0_restore_user_od_settings,
 	.od_edit_dpm_table = smu_v14_0_od_edit_dpm_table,
 	.print_clk_levels = smu_v14_0_0_print_clk_levels,
 	.force_clk_levels = smu_v14_0_0_force_clk_levels,
-- 
2.17.1

