Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8A3D7308A
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2026 02:57:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D81310E43C;
	Fri,  3 Apr 2026 02:57:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2XRaHLi8";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011006.outbound.protection.outlook.com [52.101.57.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 973FA10E43C
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2026 02:57:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMEq0yHLxamGqsQCpI6yy15R+9ytFXOtFk0NMFzAcl91VeD00LGBr1eQvSC6Xz+O5gikHi/gK/cGf4A0aYMFGU/MA1sDWEmVg7rAOA3ZU6qjE7K0L8wGiX3MWsHDuphSB3W8//JdxLQW4zJV3wvB30tVYJ3uJxitEvQu1hBKKnFQmYVPxf7twSVPO7WC00nqST5cEDz+pDe7+NfVLYegyhJXf8KMZmx5suERVZVP3iMISqhtdCOS0W8O6w3tk8EnQRAIUYlsvCWln7b4p/KIBWvTau8+JI7oO+HAypBVBzkrJ8LZflWYP+OmIN6O92g7VP5mjO39A1K0s9W091TGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJzNNBNf7CxGR90sQRLVuHaa+mZ4bn3mzVnHvPGo+N0=;
 b=wUVROlJSbpNwHnOaRhvzLHcRLqsDKqq8Hrt9IKOp0FoS2LSBdnPVdlAXI/C9a91+5BTSam2RdG+jC/uRrso7PY6yJ+q/sqjAbn9llD80CBce4OdZ3uCFdCA5SJiFGub6CMBbFZBkVM+spWly+7BoOFXK4z+KIsWKztcJWhm5neRUduwVfYuRUcf5LIyyejOCarMEpI6jZK0bIcR9AeNCXkd/3tXg/1M3pIfY49ReueXjtFFiGCvdYeLFiIsGyN0bCcFcq3fplUCgoI4h0si9X2PLIXf9Nw1aUHXl0UJyoPPmofWRLuEonllCdBe6873BTaH5+CIsCVAYOF/tn5h2tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJzNNBNf7CxGR90sQRLVuHaa+mZ4bn3mzVnHvPGo+N0=;
 b=2XRaHLi8V5FRuPvag3VnzDBvNd2gU2cEMINYow1RA059ArmNE0g5jkwQ6wPYJzSe23Y2YmXLepo4ilE2RUqPry9fJ+147gGHfqYdWiAPMD1eBslfrCQ/kruyVwtbhsb9HBputDuu42n2+bjw0LOpHNN4C6PgXRF+juJpSoQGMfk=
Received: from PH7PR03CA0016.namprd03.prod.outlook.com (2603:10b6:510:339::13)
 by MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Fri, 3 Apr
 2026 02:57:24 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::49) by PH7PR03CA0016.outlook.office365.com
 (2603:10b6:510:339::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Fri,
 3 Apr 2026 02:57:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 3 Apr 2026 02:57:23 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 21:57:21 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: fix incorrect FeatureCtrlMask setting on smu
 v14.0.x
Date: Thu, 2 Apr 2026 22:57:10 -0400
Message-ID: <20260403025710.1891947-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: d247a607-1bb4-4b70-4774-08de912cbac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: yLfmkuH4OOgocXJp7XzDn7KPL/sxW3BszYjue8Or1+RcAA8mOkLtFHOZqDwp7K3AEzMYSaFIWqCoWUwo3fhA2MefKiZI+HnytvCrzTgA7L4UqADsUGu2xpx9gTjel6JWOqg2CC3k5YNwRIpLixGqiMHM8Hf5UAIq3Br590+37kjvTxNOVYeHLz8bgFEwyzbi9twVHqAkLDRJteoEGFcIHR+XtGSHeTm778gP1x/5kaKuvti6r2tkk1Z9g4oCtS3xNXluitdeVzlFVp7/aqVJsUAh1WxWVZuQaqq3JGfF3Q5bCBLuZeg/yrpGu7WFitq6C/SZRP0QN2wLVX8iViOTHk8qLbFB7uE41+PF7Am1gusjiQaO4vp8hiaQL8Wm1KGFVTbMgeumjuzaNRu7pEeucxfklQHMMtK1tCfPiFy2CZpUFGQ7y5crVNDSq7hcbyJu0FnTkTIPQ/MFLfaeV09QJI6Kc0FlcWnXR3GHmnE/wdXYJUnGyjZCZFk862owpvkLWVrb0UNyIckoGmOa+2lDJhkWCvxED3S8UIP+/6OTTbw6lQtR16o9S4o3+JmIo8RtgGL7ynMPMBzp/S6gPnvGZxt7g2n0FrlXBIX/A5+mk77OD5AW0LvTa4o96dn8q5ejPHY1JlyGLQzYyyEDx3yPor/FSM5vhlroG+tDYuk83CHI0+MmgSP97Xn+hM+BNbmCBQE4dAABfF26QCQpNYr6ptBRdbUEyx6HoaA4S9NIPVfTKfayWNAPraGsyTUgv96yz57uzMr8EAYyLYMHI82/aw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RGleoc0zhYSnikzj3GUHkRfFHnydRZ7hERMHuuqGn0JlrmqIej/k1mwlHCY4+GM+TzHQ3HEYzAv2xJB/slT7Rv90M77YhUgkssvBrQ0fehKuFXFfbflewSQggepx6r9iPviYFrY1uxcTsOnuA/ktLlygBkmeQMy+mqIrp89ZZedAD46cjMjVvpZqsGvDyxaQ13oCPIlQa1DDKt6TzDIWrQ6UDP/OrKziSWg8edrPpAWdGPUUtIltBD9LEfxI4OgGvEproTyq6jOnq9Zjmt1thCyHQ0SEK6skB81KFFUtlwLErX4IW9+G8jQMAAYRZS92lJYNfYiChOLd52m/TPAyK0sGGmyBIYVNyb9lHPsGjb2YPNunKNRfTT7HY3Iq3KPHggA1ez8xI+Wm7sgUQi6FrVQ4upya1TMsrDcWdNKK1UupLfhERwCfxjzLFhDS4QQo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 02:57:23.1065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d247a607-1bb4-4b70-4774-08de912cbac8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077
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

OverDriveTable.FanMinimumPwm and FeatureCtrlMask.PP_OD_FEATURE_FAN_LEGACY_BIT
have a hard dependency.
Invalid handling of this dependency leads to disabled thermal monitoring
and temperature boundary validation.

Fixes: 9710b84e2a6a ("drm/amd/pm: add overdrive support on smu v14.0.2/3")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 2be080b4cbc3..bc1bfb618aa0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2390,6 +2390,7 @@ static int smu_v14_0_2_od_restore_table_single(struct smu_context *smu, long inp
 		}
 		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		od_table->OverDriveTable.FeatureCtrlMask &= BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
 		break;
 	case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
 		od_table->OverDriveTable.FanZeroRpmEnable =
@@ -2418,7 +2419,8 @@ static int smu_v14_0_2_od_restore_table_single(struct smu_context *smu, long inp
 		od_table->OverDriveTable.FanMinimumPwm =
 					boot_overdrive_table->OverDriveTable.FanMinimumPwm;
 		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
+		od_table->OverDriveTable.FeatureCtrlMask &= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 	default:
 		dev_info(adev->dev, "Invalid table index: %ld\n", input);
@@ -2588,6 +2590,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FanLinearPwmPoints[input[0]] = input[2];
 		od_table->OverDriveTable.FanMode = FAN_MODE_MANUAL_LINEAR;
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		od_table->OverDriveTable.FeatureCtrlMask &= ~BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
 		break;
 
 	case PP_OD_EDIT_ACOUSTIC_LIMIT:
@@ -2657,7 +2660,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 		break;
 
 	case PP_OD_EDIT_FAN_MINIMUM_PWM:
-		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
+		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_LEGACY_BIT)) {
 			dev_warn(adev->dev, "Fan curve setting not supported!\n");
 			return -ENOTSUPP;
 		}
@@ -2675,7 +2678,8 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 
 		od_table->OverDriveTable.FanMinimumPwm = input[0];
 		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
+		od_table->OverDriveTable.FeatureCtrlMask &= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 
 	case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
-- 
2.47.3

