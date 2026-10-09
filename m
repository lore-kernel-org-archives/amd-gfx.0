Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492D6CA6012
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 08:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4E7710FF77;
	Fri,  9 Oct 2026 08:19:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TmRH3VhV";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012042.outbound.protection.outlook.com [52.101.53.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0897D10FF77
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 08:19:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIUgi+dFgBXS/CQs4wNY34bBOJaDXDTbDlSSJ+krci4ZA2LYirYhYsF+GVbAI0VWD/EU/h2b2YMdK+7jJqsqfqN+yxbYsaIP76/qC5Do4nIFaJUlvXQfNrjUc+tzCsbK2jc0O6gy6R0l4TrenqkkSx0m0+XRH2MTssGnnbZ+MgiUqYqMSnPgBe73LzcydXuo6Ji9DQNe4UkFwwQQ4zAp9RtzwW0SNiAqKnpKTmydn/zyl2gZjvKBMulHUgL0lA38ZKYFFYH0Tseg3pKFRHg4G5cVq0b55tMdAOdVVJyufsQ8jYoINEoGYCw4iwGiDW39EJruTSbOH3hS9TQIUPdH4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqPrKAUriT+fpJl3n0vNrfaLKtA06VxlIE3NfkMiv28=;
 b=yGAiu/Xupz7f78QrcgD+dNDHvuPBz1HSmPRzhPztq5lWhoFRYJ5MrJPlBRu0iFfaRMwzNofohGyih5ZQkaHUtaHrswVl/FoUtNz96Qtt3XebKDxexeYN3uqJeKuFi9RP7mJ9z1J0zL6Cj1rtuqLq+PDYweppqNPe5g5vkxda76gxIF8lwrIpMBdaSTOLWXRbRz3Fym8nWNNe2LVI5xALmBbhr4R7pNernxQqCN1NtBUWh1j/EHPvrNE/1081S3OxV+RGwGrhqBFhtsY51M88BIaZS9tSwIWZHSYDWPOWs4OEya10o+NvoPwg/KVdYcY0f+4X1/OBGVPwdTRxd8H22Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqPrKAUriT+fpJl3n0vNrfaLKtA06VxlIE3NfkMiv28=;
 b=TmRH3VhVXOG/a1F+n+gE1b6k1EAKS0ovHq9reP9EsARzeWFESo6i2/0ZEB0t1TdVY4eWYQknQcieJPe0s9399Wn4vDwCio8jO/6oTuWGUAZoj53LDvynow8YAPmMWYDfmgZtrXqOmdjCGJYatdSzU+oWUhA86fKIYgGQ6hJWU+4=
Received: from CH0PR04CA0082.namprd04.prod.outlook.com (2603:10b6:610:74::27)
 by CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 08:19:35 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::50) by CH0PR04CA0082.outlook.office365.com
 (2603:10b6:610:74::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 08:19:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 08:19:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 03:19:29 -0500
Received: from LNXAMD-Kenneth.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 9 Oct 2026 03:19:28 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kevin.Wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: add zero fan stop temperature support on smu
 14.0.2
Date: Fri, 9 Oct 2026 16:19:30 +0800
Message-ID: <20261009081930.2028915-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|CH3PR12MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b1ebbe6-c4af-4b7f-0e1a-08df25de0d7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|56012099006|6133799003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: ZhLO9gCtBTB/OsO5nKOIM4GWznFJj81cOH7i84XI21Ywqi6CtgrlzNzsgAMoC3KQ36PAzGrqtNHRwZj5Wfw8hYD7XcMHngFln5mOkljvI9REyCKtI9Yf/TzY6vlU87WWei3Mr69Ctx3Ssn8rFCj1lnCT+ptQXr4S/ipYfl2dPQGN250VxUC8Xb87b2RSUIRcAz0U9kY/eLYZEnihTuCkqHf9+zKA2D0FrfxmrKM7SGmMjgAn9pmdRxHEBKYhNVJZzjkSskoZU70E86UhUEdOMSGvxaOkLRWVwfRJAILrQgxNudET5fkLGzOq1q7lL/37NAaJwJve62vc0NHOeqXBpGQX8sRxWx7TmMUQi9qAHdyoAC+lDaM4QTPt1RQLVWgTPGjGm0QZ1R31871fcGMVEHmfvnicS27QcKFljkwwlP/LGkimBkbI3mW1gZjkelLhWwoGN4YxA4iyEk2WljxcjlRe9NOrpr+lYdDE5pQd6v0QsZkrrG7VRbtpGZKMx4pcAO6PqqLVVBveGJsQkt60j2ypJwyyGIdiFVUEe/RX2os4c5XSgJxHI7O/IlBmewUepdebU1HTN7BB9qvPDW8N2S6LjjIQnviyjJAlu5sKkgvIVJ1DgDw7lQkuHVhY5nbpDsw8G21wHiQU4BY5Ue41HgpwkZ0hGWV4m9BcMrlx5oGNBS0rh0cV2DNpCSKz6rjIJqvp7IXHyvmVywE5ttahxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(56012099006)(6133799003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VxXDa+cJN/1bapDiqDjDI0UJqdSvtDHzXqUPWXGABLZ+eOnTD7HgonWSqI/IFQ7SP1uYFAJsRiD4VMmvGlS7q0MRoCZ9f2nIE6dlEWb27ADS34jZOgM2Wcm7fNKD6vfHd39i1rjEuu2/IMMQq9E6Y11Fi8GBj3MNN4rjHrBd8FuE1cUw6kjH6kLvX1gEKPLzdJVkgBHhzYEsVneFMEhW7Op3BH1JYQ+X/BLnvFeNEE4i8xFDU4e9XHCQzbfAdjdgvgr2p6ZQr5M1mMJ+tyhzfgPZuBcEsN80RbYjIe3F/g9vU4aWvOweygTBIMUwklFyH0YSabJrH3r2WBskOoQu0CRzYpjd5jltnttPqb/5qrac0kVspBTU6wiXqirhExatOe/HjgrFef+5DEKBonR1J23EgD/LzHAmj7RVSE0HyoTjKJl83kiwmrnWuCqnf2mJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 08:19:34.8433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1ebbe6-c4af-4b7f-0e1a-08df25de0d7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8658
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

add zero fan stop temperature support on smu 14.0.2

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 55 ++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 1054c4b4b03e..e095bebecfbd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -89,6 +89,7 @@ static const struct smu_feature_bits smu_v14_0_2_dpm_features = {
 #define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE		9
 #define PP_OD_FEATURE_FAN_MINIMUM_PWM			10
 #define PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE		11
+#define PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP		12
 
 static struct cmn2asic_msg_mapping smu_v14_0_2_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
@@ -1020,6 +1021,10 @@ static void smu_v14_0_2_get_od_setting_limits(struct smu_context *smu,
 		od_min_setting = overdrive_lowerlimits->FanZeroRpmEnable;
 		od_max_setting = overdrive_upperlimits->FanZeroRpmEnable;
 		break;
+	case PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP:
+		od_min_setting = pptable->SkuTable.MsgLimits.FanStopTempMin;
+		od_max_setting = pptable->SkuTable.MsgLimits.FanStopTempMax;
+		break;
 	default:
 		od_min_setting = od_max_setting = INT_MAX;
 		break;
@@ -1244,6 +1249,24 @@ static int smu_v14_0_2_emit_clk_levels(struct smu_context *smu,
 				      min_value, max_value);
 		break;
 
+	case SMU_OD_FAN_ZERO_RPM_STOP_TEMP:
+		if (!smu_v14_0_2_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_ZERO_FAN_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "FAN_ZERO_RPM_STOP_TEMPERATURE:\n");
+		size += sysfs_emit_at(buf, size, "%d\n",
+					(int)od_table->OverDriveTable.FanZeroRpmStopTemp);
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		smu_v14_0_2_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "ZERO_RPM_STOP_TEMPERATURE: %u %u\n",
+				      min_value, max_value);
+		break;
+
 	case SMU_OD_RANGE:
 		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT) &&
 		    !smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT) &&
@@ -2308,7 +2331,9 @@ static void smu_v14_0_2_set_supported_od_feature_mask(struct smu_context *smu)
 					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE |
 					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET |
 					    OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_RETRIEVE |
-					    OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_SET;
+					    OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_SET |
+					    OD_OPS_SUPPORT_FAN_ZERO_RPM_STOP_TEMP_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_ZERO_RPM_STOP_TEMP_SET;
 }
 
 static int smu_v14_0_2_get_overdrive_table(struct smu_context *smu,
@@ -2389,6 +2414,8 @@ static int smu_v14_0_2_set_default_od_settings(struct smu_context *smu)
 			user_od_table_bak.OverDriveTable.FanMinimumPwm;
 		user_od_table->OverDriveTable.FanZeroRpmEnable =
 			user_od_table_bak.OverDriveTable.FanZeroRpmEnable;
+		user_od_table->OverDriveTable.FanZeroRpmStopTemp =
+			user_od_table_bak.OverDriveTable.FanZeroRpmStopTemp;
 	}
 
 	smu_v14_0_2_set_supported_od_feature_mask(smu);
@@ -2443,6 +2470,11 @@ static int smu_v14_0_2_od_restore_table_single(struct smu_context *smu, long inp
 					boot_overdrive_table->OverDriveTable.FanZeroRpmEnable;
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
 		break;
+	case PP_OD_EDIT_FAN_ZERO_RPM_STOP_TEMP:
+		od_table->OverDriveTable.FanZeroRpmStopTemp =
+					boot_overdrive_table->OverDriveTable.FanZeroRpmStopTemp;
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
+		break;
 	case PP_OD_EDIT_ACOUSTIC_LIMIT:
 		od_table->OverDriveTable.AcousticLimitRpmThreshold =
 					boot_overdrive_table->OverDriveTable.AcousticLimitRpmThreshold;
@@ -2749,6 +2781,27 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
 		break;
 
+	case PP_OD_EDIT_FAN_ZERO_RPM_STOP_TEMP:
+		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_ZERO_FAN_BIT)) {
+			dev_warn(adev->dev, "Zero RPM setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		smu_v14_0_2_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP,
+						  &minimum,
+						  &maximum);
+		if (input[0] < minimum ||
+		    input[0] > maximum) {
+			dev_info(adev->dev, "zero RPM stop temperature setting(%ld) must be within [%d, %d]!\n",
+				 input[0], minimum, maximum);
+			return -EINVAL;
+		}
+
+		od_table->OverDriveTable.FanZeroRpmStopTemp = input[0];
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
+		break;
+
 	case PP_OD_RESTORE_DEFAULT_TABLE:
 		if (size == 1) {
 			ret = smu_v14_0_2_od_restore_table_single(smu, input[0]);
-- 
2.43.0

