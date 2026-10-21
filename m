Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED68606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 00:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FLsSpA6L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E38410EC09;
	Wed, 21 Oct 2026 00:08:02 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77AC810EC09
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 00:07:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clgFcVQu1a45WJOkngdokiIW0+ZJCSj4gn6p5nvCOCMBWj5QnwOFETRQMWwSCVrvNZGkyHxga4BecoR2hiTJ8Guuo/ef69EazmAXdb9byMzeOHOhsE+ykrniP5BlcYN7IQMlmbHJvPuVXZVqR3hUYe0uYDJgkqBd8Ax1ds5GouhtSPawThs9aVVNJh5it1kuOW0I5stT87mHQ8Cw0A2/Y14a5icWG7E5qdBZjk5Guvil/NO0KdhaEbnYRgaYS+d1WgArhQ+FR9/Uzcw5NJOECKUYyTmquEtZL1nHs68+fXoqTlrhG4RaIKQokBNhVpwVQSiZHBsVQKB1Vfj/x9B6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J47xvttTIqqPbPyQ/RkMMuyfRfEfFHgwLWfVAppqSg8=;
 b=mdK10XSAzuhF2e5c2AmN94EAHwwtXendsWLvAYzuVO4sDMYktxR4TlpALZTgAnqnMbI0LAQEtaDVJge1a55VLcgxVQdyqd9YgwYj3PP+M21kM25606GzG4RcpyucZDxn1wVPhR1vUOFgIJ7Pb7UHnOnkxNcqxVAZso0GGUkv5jDrRBWYbmw4rJzS78eSn2CEBorfPeTh4E96Z1e6OwInRxqlZwg2WRwb6IlYBTlKSvw7wngdSUDgCm/So1AWhAhD518X8rY/vFQBfiYOumWQfppIqHnElc1yBLOyWrb/egx0SN5K1bxJpD1yR9Dohoh8SGzCalgzHasMaaJSPin4KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J47xvttTIqqPbPyQ/RkMMuyfRfEfFHgwLWfVAppqSg8=;
 b=FLsSpA6L9+PTZkji2Zgjx+slNnO6QX4jdsmuurp0RlJH5H97M5Qt6mnpMtydqtwi1IkClBa/Q9pKkWYsvACGLWFPJY48OfeEBX4MGseApJx1LpS26uMuOTZ3A/PIpLE/ulDPJeh2TTl1I1wFzAoZnLoSCmbTaoYcVGDylA9vc0k=
Received: from BN9PR03CA0444.namprd03.prod.outlook.com (2603:10b6:408:113::29)
 by CY8PR12MB7338.namprd12.prod.outlook.com (2603:10b6:930:52::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 00:07:49 +0000
Received: from LV8PEPF0000006A.namprd03.prod.outlook.com
 (2603:10b6:408:113:cafe::31) by BN9PR03CA0444.outlook.office365.com
 (2603:10b6:408:113::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 00:07:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000006A.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 00:07:48 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 19:07:46 -0500
From: Kevin Wang <kevin.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>, =?UTF-8?q?Jos=C3=A9=20Miguel=20Sarasola?=
 <alosarjos@gmail.com>
Subject: [PATCH 1/2] drm/amd/pm: preserve committed OD features for SMU
 13.0.0/13.0.7
Date: Wed, 21 Oct 2026 08:07:34 +0800
Message-ID: <20261021000735.3766283-1-kevin.wang@amd.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000006A:EE_|CY8PR12MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: ad5102b2-3234-45be-916e-08df2f075755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|56012099006|11063799006|5023799004|261009223027099003|10067099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: 3tRmw/QAz5ld0FTmFm+OFQhiRihiaut5wOXBrygDBHC7D/ZbEE7AUC/SzYI7PqT1D/7MJyrK2sVOZf0D85Ct5yzkKts+SwaYlHd/eP4+m/wZN71VxEy8tZT6nl0FRNbLaXr1rCYkLRO7jO5Zx4xqefcRsR0EqD+8poGvhyjm3lx3Ne3Gbp9hozZqctdcDe3pAuWIzORcl6C6ZFMUBsBNWorVa9msRuL+YjW+hOE4298aLDc75fPS+kNyuRodd14QvthtsG6Y/UAoDYXoe04XD61MEmcpRNRSNtJuMfjo1GVVHEOuTRjCKTcfgczRU9iDfWK1UM3j+z2QX7lHKEWOvduGmMDLHZiVi2TBYRTNeEWDKnNgYXnSX9FZFGRTZXQO39CCJ8nEEIZeTkPjfU8pAabxy9NRL2zDwThurMKCkLp0OyETADW6ddybqeMoWp8MubQCFpwhgTWtTW95UsK3pmsQ2SlGhttBs1STr/lbe7Xy9OAviA/++Tep0MO9WgUuzP+fkvtXwKVjyEBCZFZZRDKhRq3nz/Wvnfog/0BoSkj2dhH0/GRPOAgwKLRJjSsv6vnM8x36JnpBSkxmdv0tLRJafeR4LTyHgoCzqMiEw9qNxXmihtgnpnyNud4l9xxgjXxxwmfnbW24iePJdtATIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(56012099006)(11063799006)(5023799004)(261009223027099003)(10067099003)(18002099003)(6133799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n6Ygvn+S1KDTaQ54epS9KSBQqffjEEwKcv6+a3tiQ9l29ne0+j2pPbzAl5fTf7K/lVlJ554wTe5OTtFjffC3b19qdTlqSwrnrHTJ7A34Ybrmavph0jE6nmpbrnI/UNyONdYWFwDUJmQkMHGMi8tF9+Q+I6McQNiiv1ygnXjN+Qx/c81eDTHFUjrJKplnd1Do/NdHQxduqN8hKahtJvDVB+BILvxps4YCLFSFmfy7sRzMXJELDokLiACJLxp+gDK2qbmxTqG3WVFsgFcYbZRLF99yPCVHdvR1jym5L1gAPUoVdT3JQdlWj+Hsc4cANRDKgQtZi0c6NaxOt9uOu6s68QHfrASozmmk3OslnssoDk0R8QSrM+tK+3JL0/qmuHTjZcv3QCxG6vUhG3fkOnwzsiek0I8KzxvPKn3cKytuPJXzIlLDUOzWHPfuVXqenDfd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 00:07:48.5958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5102b2-3234-45be-916e-08df2f075755
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000006A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7338
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PMFW treats FeatureCtrlMask as the complete set of active OD features.
Uploads containing only newly edited bits can drop earlier settings.

Fix the OD state handling to:

- preserve committed features across later commits
- keep staged OD settings out of power-cap writes
- update cached state only after successful uploads
- clear restored features only after they return to defaults
- restore PPT for the current AC/DC source after resume

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/3625
Tested-by: José Miguel Sarasola <alosarjos@gmail.com>
Signed-off-by: Kevin Wang <kevin.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 204 +++++++++++++----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 206 ++++++++++++++----
 2 files changed, 318 insertions(+), 92 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index a9bf686783e9..46edef326660 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -63,6 +63,9 @@ static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
 					      int od_feature_bit,
 					      int32_t *min, int32_t *max);
 static int smu_v13_0_0_init_ppt_limits(struct smu_context *smu);
+static int
+smu_v13_0_0_upload_overdrive_table(struct smu_context *smu,
+				   OverDriveTableExternal_t *od_table);
 
 static const struct smu_feature_bits smu_v13_0_0_dpm_features = {
 	.bits = {
@@ -1079,6 +1082,94 @@ static bool smu_v13_0_0_is_od_feature_supported(struct smu_context *smu,
 	return feature_enabled;
 }
 
+static u32
+smu_v13_0_0_filter_od_feature_mask(struct smu_context *smu, u32 feature_mask)
+{
+	PPTable_t *pptable = smu->smu_table.driver_pptable;
+	u32 supported_mask =
+		pptable->SkuTable.OverDriveLimitsBasicMax.FeatureCtrlMask;
+
+	return feature_mask & supported_mask;
+}
+
+static bool smu_v13_0_0_fan_is_default(const OverDriveTable_t *od,
+				       const OverDriveTable_t *boot)
+{
+	return !memcmp(od->FanLinearPwmPoints, boot->FanLinearPwmPoints,
+			sizeof(od->FanLinearPwmPoints)) &&
+		!memcmp(od->FanLinearTempPoints, boot->FanLinearTempPoints,
+			sizeof(od->FanLinearTempPoints)) &&
+		od->FanMinimumPwm == boot->FanMinimumPwm &&
+		od->AcousticTargetRpmThreshold == boot->AcousticTargetRpmThreshold &&
+		od->AcousticLimitRpmThreshold == boot->AcousticLimitRpmThreshold &&
+		od->FanTargetTemperature == boot->FanTargetTemperature &&
+		od->FanMode == boot->FanMode;
+}
+
+static bool smu_v13_0_0_zero_fan_is_default(const OverDriveTable_t *od,
+					    const OverDriveTable_t *boot)
+{
+	return od->FanZeroRpmEnable == boot->FanZeroRpmEnable &&
+		od->FanZeroRpmStopTemp == boot->FanZeroRpmStopTemp;
+}
+
+static u32 smu_v13_0_0_restore_feature_mask(const OverDriveTable_t *od,
+					    const OverDriveTable_t *boot,
+					    long input, u32 feature_mask)
+{
+	switch (input) {
+	case PP_OD_EDIT_FAN_CURVE:
+	case PP_OD_EDIT_ACOUSTIC_LIMIT:
+	case PP_OD_EDIT_ACOUSTIC_TARGET:
+	case PP_OD_EDIT_FAN_TARGET_TEMPERATURE:
+	case PP_OD_EDIT_FAN_MINIMUM_PWM:
+		if (smu_v13_0_0_fan_is_default(od, boot))
+			feature_mask &= ~BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		break;
+	case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
+	case PP_OD_EDIT_FAN_ZERO_RPM_STOP_TEMP:
+		if (smu_v13_0_0_zero_fan_is_default(od, boot))
+			feature_mask &= ~BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
+		break;
+	default:
+		break;
+	}
+
+	return feature_mask;
+}
+
+static int
+smu_v13_0_0_upload_ppt_overdrive_table(struct smu_context *smu, s16 ppt)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	OverDriveTableExternal_t *od_table = table_context->overdrive_table;
+	OverDriveTableExternal_t *user_od_table = table_context->user_overdrive_table;
+	OverDriveTableExternal_t upload_table;
+	u32 next_mask = table_context->user_od_feature_mask;
+	int ret;
+
+	/* Do not commit OD settings staged after the last c operation. */
+	memcpy(&upload_table, user_od_table, sizeof(upload_table));
+	upload_table.OverDriveTable.Ppt = ppt;
+	if (ppt)
+		next_mask |= BIT(PP_OD_FEATURE_PPT_BIT);
+	else
+		next_mask &= ~BIT(PP_OD_FEATURE_PPT_BIT);
+	upload_table.OverDriveTable.FeatureCtrlMask =
+		smu_v13_0_0_filter_od_feature_mask(smu, next_mask);
+
+	ret = smu_v13_0_0_upload_overdrive_table(smu, &upload_table);
+	if (ret)
+		return ret;
+
+	table_context->user_od_feature_mask =
+		upload_table.OverDriveTable.FeatureCtrlMask;
+	od_table->OverDriveTable.Ppt = ppt;
+	user_od_table->OverDriveTable.Ppt = ppt;
+
+	return 0;
+}
+
 static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
 					      int od_feature_bit,
 					      int32_t *min,
@@ -1514,41 +1605,30 @@ static int smu_v13_0_0_od_restore_table_single(struct smu_context *smu, long inp
 					boot_overdrive_table->OverDriveTable.FanLinearPwmPoints[i];
 		}
 		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 	case PP_OD_EDIT_ACOUSTIC_LIMIT:
 		od_table->OverDriveTable.AcousticLimitRpmThreshold =
 					boot_overdrive_table->OverDriveTable.AcousticLimitRpmThreshold;
-		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 	case PP_OD_EDIT_ACOUSTIC_TARGET:
 		od_table->OverDriveTable.AcousticTargetRpmThreshold =
 					boot_overdrive_table->OverDriveTable.AcousticTargetRpmThreshold;
-		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 	case PP_OD_EDIT_FAN_TARGET_TEMPERATURE:
 		od_table->OverDriveTable.FanTargetTemperature =
 					boot_overdrive_table->OverDriveTable.FanTargetTemperature;
-		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 	case PP_OD_EDIT_FAN_MINIMUM_PWM:
 		od_table->OverDriveTable.FanMinimumPwm =
 					boot_overdrive_table->OverDriveTable.FanMinimumPwm;
-		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 	case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
 		od_table->OverDriveTable.FanZeroRpmEnable =
 					boot_overdrive_table->OverDriveTable.FanZeroRpmEnable;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
 		break;
 	case PP_OD_EDIT_FAN_ZERO_RPM_STOP_TEMP:
 		od_table->OverDriveTable.FanZeroRpmStopTemp =
 					boot_overdrive_table->OverDriveTable.FanZeroRpmStopTemp;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
 		break;
 	default:
 		dev_info(adev->dev, "Invalid table index: %ld\n", input);
@@ -1566,9 +1646,19 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 	struct smu_table_context *table_context = &smu->smu_table;
 	OverDriveTableExternal_t *od_table =
 		(OverDriveTableExternal_t *)table_context->overdrive_table;
+	OverDriveTableExternal_t *user_od_table =
+		(OverDriveTableExternal_t *)table_context->user_overdrive_table;
+	OverDriveTableExternal_t *boot_od_table =
+		(OverDriveTableExternal_t *)table_context->boot_overdrive_table;
+	OverDriveTableExternal_t upload_table;
+	OverDriveTable_t *od = &od_table->OverDriveTable;
+	OverDriveTable_t *boot = &boot_od_table->OverDriveTable;
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t offset_of_voltageoffset;
 	int32_t minimum, maximum;
+	long restored_setting = -1;
+	u32 next_mask;
+	bool restore_default = false;
 	int i, ret = 0;
 
 	switch (type) {
@@ -1889,39 +1979,54 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 			ret = smu_v13_0_0_od_restore_table_single(smu, input[0]);
 			if (ret)
 				return ret;
+			restored_setting = input[0];
 		} else {
 			memcpy(od_table,
 		       table_context->boot_overdrive_table,
 		       sizeof(OverDriveTableExternal_t));
 			od_table->OverDriveTable.FeatureCtrlMask = 0;
-			table_context->user_od_feature_mask = 0;
+			restore_default = true;
 		}
 		fallthrough;
 	case PP_OD_COMMIT_DPM_TABLE:
-		table_context->user_od_feature_mask =
-			od_table->OverDriveTable.FeatureCtrlMask;
 		offset_of_voltageoffset = offsetof(OverDriveTable_t, VoltageOffsetPerZoneBoundary);
-		if (memcmp((u8 *)od_table + offset_of_voltageoffset,
-			   table_context->user_overdrive_table + offset_of_voltageoffset,
-			   sizeof(OverDriveTableExternal_t) - offset_of_voltageoffset)) {
-			smu_v13_0_0_dump_od_table(smu, od_table);
+		next_mask = restore_default ? 0 :
+			smu_v13_0_0_filter_od_feature_mask(smu,
+							   table_context->user_od_feature_mask |
+							   od->FeatureCtrlMask);
+		if (restored_setting >= 0)
+			next_mask = smu_v13_0_0_restore_feature_mask(od, boot,
+								     restored_setting,
+								     next_mask);
 
-			ret = smu_v13_0_0_upload_overdrive_table(smu, od_table);
+		if (memcmp((u8 *)od_table + offset_of_voltageoffset,
+			   (u8 *)user_od_table + offset_of_voltageoffset,
+			   sizeof(OverDriveTableExternal_t) - offset_of_voltageoffset) ||
+		    next_mask != table_context->user_od_feature_mask) {
+			memcpy(&upload_table, od_table, sizeof(upload_table));
+			upload_table.OverDriveTable.FeatureCtrlMask = next_mask;
+			smu_v13_0_0_dump_od_table(smu, &upload_table);
+
+			ret = smu_v13_0_0_upload_overdrive_table(smu, &upload_table);
 			if (ret) {
+				if (restore_default || restored_setting >= 0) {
+					memcpy(od_table, user_od_table,
+					       sizeof(OverDriveTableExternal_t));
+					od->FeatureCtrlMask = 0;
+				}
 				dev_err(adev->dev, "Failed to upload overdrive table!\n");
 				return ret;
 			}
 
-			memcpy(table_context->user_overdrive_table + offset_of_voltageoffset,
+			table_context->user_od_feature_mask = next_mask;
+			od_table->OverDriveTable.FeatureCtrlMask = 0;
+			memcpy((u8 *)user_od_table + offset_of_voltageoffset,
 			       (u8 *)od_table + offset_of_voltageoffset,
 			       sizeof(OverDriveTableExternal_t) - offset_of_voltageoffset);
+			user_od_table->OverDriveTable.FeatureCtrlMask = 0;
 
-			if (!memcmp(table_context->user_overdrive_table,
-				    table_context->boot_overdrive_table,
-				    sizeof(OverDriveTableExternal_t)))
-				smu->user_dpm_profile.user_od = false;
-			else
-				smu->user_dpm_profile.user_od = true;
+			smu->user_dpm_profile.user_od =
+				!!(next_mask & ~BIT(PP_OD_FEATURE_PPT_BIT));
 		}
 		break;
 
@@ -2186,6 +2291,7 @@ static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
 	memcpy(od_table,
 	       boot_od_table,
 	       sizeof(OverDriveTableExternal_t));
+	od_table->OverDriveTable.FeatureCtrlMask = 0;
 
 	/*
 	 * For S3/S4/Runpm resume, we need to setup those overdrive tables again,
@@ -2195,6 +2301,7 @@ static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
 		memcpy(user_od_table,
 		       boot_od_table,
 		       sizeof(OverDriveTableExternal_t));
+		user_od_table->OverDriveTable.FeatureCtrlMask = 0;
 		smu->user_dpm_profile.user_od = false;
 		smu->smu_table.user_od_feature_mask = 0;
 	} else if (smu->user_dpm_profile.user_od) {
@@ -2233,6 +2340,14 @@ static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
 			user_od_table_bak.OverDriveTable.FanZeroRpmEnable;
 		user_od_table->OverDriveTable.FanZeroRpmStopTemp =
 			user_od_table_bak.OverDriveTable.FanZeroRpmStopTemp;
+		user_od_table->OverDriveTable.FanMode =
+			user_od_table_bak.OverDriveTable.FanMode;
+		user_od_table->OverDriveTable.FeatureCtrlMask = 0;
+	}
+	if (smu->adev->in_suspend) {
+		user_od_table->OverDriveTable.Ppt = 0;
+		smu->smu_table.user_od_feature_mask &=
+			~BIT(PP_OD_FEATURE_PPT_BIT);
 	}
 
 	smu_v13_0_0_set_supported_od_feature_mask(smu);
@@ -2245,13 +2360,22 @@ static int smu_v13_0_0_restore_user_od_settings(struct smu_context *smu)
 	struct smu_table_context *table_context = &smu->smu_table;
 	OverDriveTableExternal_t *od_table = table_context->overdrive_table;
 	OverDriveTableExternal_t *user_od_table = table_context->user_overdrive_table;
+	OverDriveTableExternal_t upload_table;
+	u32 next_mask;
 	int res;
-	user_od_table->OverDriveTable.FeatureCtrlMask =
-		table_context->user_od_feature_mask;
-	res = smu_v13_0_0_upload_overdrive_table(smu, user_od_table);
-	user_od_table->OverDriveTable.FeatureCtrlMask = 0;
-	if (res == 0)
+
+	next_mask = smu_v13_0_0_filter_od_feature_mask(smu,
+						       table_context->user_od_feature_mask);
+	memcpy(&upload_table, user_od_table, sizeof(upload_table));
+	upload_table.OverDriveTable.FeatureCtrlMask = next_mask;
+	res = smu_v13_0_0_upload_overdrive_table(smu, &upload_table);
+	if (res == 0) {
+		table_context->user_od_feature_mask = next_mask;
+		smu->user_dpm_profile.user_od =
+			!!(next_mask & ~BIT(PP_OD_FEATURE_PPT_BIT));
 		memcpy(od_table, user_od_table, sizeof(OverDriveTableExternal_t));
+		od_table->OverDriveTable.FeatureCtrlMask = 0;
+	}
 
 	return res;
 }
@@ -3045,10 +3169,8 @@ static int smu_v13_0_0_set_ppt_limit(struct smu_context *smu,
 	SkuTable_t *skutable = &pptable->SkuTable;
 	uint32_t msg_limit = skutable->MsgLimits.Power
 		[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
-	struct smu_table_context *table_context = &smu->smu_table;
-	OverDriveTableExternal_t *od_table =
-		(OverDriveTableExternal_t *)table_context->overdrive_table;
 	OverDriveTableExternal_t current_od_table;
+	s16 ppt;
 	int ret = 0;
 
 	if (limit_type != SMU_PPT_LIMIT_PPT0)
@@ -3060,12 +3182,7 @@ static int smu_v13_0_0_set_ppt_limit(struct smu_context *smu,
 			return ret;
 
 		if (current_od_table.OverDriveTable.Ppt) {
-			od_table->OverDriveTable.Ppt = 0;
-			table_context->user_od_feature_mask &=
-				~(1U << PP_OD_FEATURE_PPT_BIT);
-			od_table->OverDriveTable.FeatureCtrlMask =
-				table_context->user_od_feature_mask;
-			ret = smu_v13_0_0_upload_overdrive_table(smu, od_table);
+			ret = smu_v13_0_0_upload_ppt_overdrive_table(smu, 0);
 			if (ret) {
 				dev_err(smu->adev->dev, "Failed to upload overdrive table!\n");
 				return ret;
@@ -3077,11 +3194,8 @@ static int smu_v13_0_0_set_ppt_limit(struct smu_context *smu,
 		if (ret)
 			return ret;
 
-		od_table->OverDriveTable.Ppt = (limit * 100) / msg_limit - 100;
-		table_context->user_od_feature_mask |= 1U << PP_OD_FEATURE_PPT_BIT;
-		od_table->OverDriveTable.FeatureCtrlMask =
-			table_context->user_od_feature_mask;
-		ret = smu_v13_0_0_upload_overdrive_table(smu, od_table);
+		ppt = (limit * 100) / msg_limit - 100;
+		ret = smu_v13_0_0_upload_ppt_overdrive_table(smu, ppt);
 		if (ret) {
 		  dev_err(smu->adev->dev, "Failed to upload overdrive table!\n");
 		  return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index d8715a94ec6a..668aea17288e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -63,6 +63,9 @@ static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
 					      int od_feature_bit,
 					      int32_t *min, int32_t *max);
 static int smu_v13_0_7_init_ppt_limits(struct smu_context *smu);
+static int
+smu_v13_0_7_upload_overdrive_table(struct smu_context *smu,
+				   OverDriveTableExternal_t *od_table);
 
 static const struct smu_feature_bits smu_v13_0_7_dpm_features = {
 	.bits = {
@@ -94,6 +97,7 @@ static const struct smu_feature_bits smu_v13_0_7_dpm_features = {
 #define PP_OD_FEATURE_GFXCLK_FMAX			1
 #define PP_OD_FEATURE_UCLK_FMIN				2
 #define PP_OD_FEATURE_UCLK_FMAX				3
+
 #define PP_OD_FEATURE_GFX_VF_CURVE			4
 #define PP_OD_FEATURE_FAN_CURVE_TEMP			5
 #define PP_OD_FEATURE_FAN_CURVE_PWM			6
@@ -1089,6 +1093,94 @@ static bool smu_v13_0_7_is_od_feature_supported(struct smu_context *smu,
 	return feature_enabled;
 }
 
+static u32
+smu_v13_0_7_filter_od_feature_mask(struct smu_context *smu, u32 feature_mask)
+{
+	PPTable_t *pptable = smu->smu_table.driver_pptable;
+	u32 supported_mask =
+		pptable->SkuTable.OverDriveLimitsBasicMax.FeatureCtrlMask;
+
+	return feature_mask & supported_mask;
+}
+
+static bool smu_v13_0_7_fan_is_default(const OverDriveTable_t *od,
+				       const OverDriveTable_t *boot)
+{
+	return !memcmp(od->FanLinearPwmPoints, boot->FanLinearPwmPoints,
+			sizeof(od->FanLinearPwmPoints)) &&
+		!memcmp(od->FanLinearTempPoints, boot->FanLinearTempPoints,
+			sizeof(od->FanLinearTempPoints)) &&
+		od->FanMinimumPwm == boot->FanMinimumPwm &&
+		od->AcousticTargetRpmThreshold == boot->AcousticTargetRpmThreshold &&
+		od->AcousticLimitRpmThreshold == boot->AcousticLimitRpmThreshold &&
+		od->FanTargetTemperature == boot->FanTargetTemperature &&
+		od->FanMode == boot->FanMode;
+}
+
+static bool smu_v13_0_7_zero_fan_is_default(const OverDriveTable_t *od,
+					    const OverDriveTable_t *boot)
+{
+	return od->FanZeroRpmEnable == boot->FanZeroRpmEnable &&
+		od->FanZeroRpmStopTemp == boot->FanZeroRpmStopTemp;
+}
+
+static u32 smu_v13_0_7_restore_feature_mask(const OverDriveTable_t *od,
+					    const OverDriveTable_t *boot,
+					    long input, u32 feature_mask)
+{
+	switch (input) {
+	case PP_OD_EDIT_FAN_CURVE:
+	case PP_OD_EDIT_ACOUSTIC_LIMIT:
+	case PP_OD_EDIT_ACOUSTIC_TARGET:
+	case PP_OD_EDIT_FAN_TARGET_TEMPERATURE:
+	case PP_OD_EDIT_FAN_MINIMUM_PWM:
+		if (smu_v13_0_7_fan_is_default(od, boot))
+			feature_mask &= ~BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		break;
+	case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
+	case PP_OD_EDIT_FAN_ZERO_RPM_STOP_TEMP:
+		if (smu_v13_0_7_zero_fan_is_default(od, boot))
+			feature_mask &= ~BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
+		break;
+	default:
+		break;
+	}
+
+	return feature_mask;
+}
+
+static int
+smu_v13_0_7_upload_ppt_overdrive_table(struct smu_context *smu, s16 ppt)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	OverDriveTableExternal_t *od_table = table_context->overdrive_table;
+	OverDriveTableExternal_t *user_od_table = table_context->user_overdrive_table;
+	OverDriveTableExternal_t upload_table;
+	u32 next_mask = table_context->user_od_feature_mask;
+	int ret;
+
+	/* Do not commit OD settings staged after the last c operation. */
+	memcpy(&upload_table, user_od_table, sizeof(upload_table));
+	upload_table.OverDriveTable.Ppt = ppt;
+	if (ppt)
+		next_mask |= BIT(PP_OD_FEATURE_PPT_BIT);
+	else
+		next_mask &= ~BIT(PP_OD_FEATURE_PPT_BIT);
+	upload_table.OverDriveTable.FeatureCtrlMask =
+		smu_v13_0_7_filter_od_feature_mask(smu, next_mask);
+
+	ret = smu_v13_0_7_upload_overdrive_table(smu, &upload_table);
+	if (ret)
+		return ret;
+
+	table_context->user_od_feature_mask =
+		upload_table.OverDriveTable.FeatureCtrlMask;
+	od_table->OverDriveTable.Ppt = ppt;
+	user_od_table->OverDriveTable.Ppt = ppt;
+
+	return 0;
+}
+
 static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
 					      int od_feature_bit,
 					      int32_t *min,
@@ -1523,41 +1615,30 @@ static int smu_v13_0_7_od_restore_table_single(struct smu_context *smu, long inp
 					boot_overdrive_table->OverDriveTable.FanLinearPwmPoints[i];
 		}
 		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 	case PP_OD_EDIT_ACOUSTIC_LIMIT:
 		od_table->OverDriveTable.AcousticLimitRpmThreshold =
 					boot_overdrive_table->OverDriveTable.AcousticLimitRpmThreshold;
-		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 	case PP_OD_EDIT_ACOUSTIC_TARGET:
 		od_table->OverDriveTable.AcousticTargetRpmThreshold =
 					boot_overdrive_table->OverDriveTable.AcousticTargetRpmThreshold;
-		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 	case PP_OD_EDIT_FAN_TARGET_TEMPERATURE:
 		od_table->OverDriveTable.FanTargetTemperature =
 					boot_overdrive_table->OverDriveTable.FanTargetTemperature;
-		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 	case PP_OD_EDIT_FAN_MINIMUM_PWM:
 		od_table->OverDriveTable.FanMinimumPwm =
 					boot_overdrive_table->OverDriveTable.FanMinimumPwm;
-		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 	case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
 		od_table->OverDriveTable.FanZeroRpmEnable =
 					boot_overdrive_table->OverDriveTable.FanZeroRpmEnable;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
 		break;
 	case PP_OD_EDIT_FAN_ZERO_RPM_STOP_TEMP:
 		od_table->OverDriveTable.FanZeroRpmStopTemp =
 					boot_overdrive_table->OverDriveTable.FanZeroRpmStopTemp;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
 		break;
 	default:
 		dev_info(adev->dev, "Invalid table index: %ld\n", input);
@@ -1575,9 +1656,19 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 	struct smu_table_context *table_context = &smu->smu_table;
 	OverDriveTableExternal_t *od_table =
 		(OverDriveTableExternal_t *)table_context->overdrive_table;
+	OverDriveTableExternal_t *user_od_table =
+		(OverDriveTableExternal_t *)table_context->user_overdrive_table;
+	OverDriveTableExternal_t *boot_od_table =
+		(OverDriveTableExternal_t *)table_context->boot_overdrive_table;
+	OverDriveTableExternal_t upload_table;
+	OverDriveTable_t *od = &od_table->OverDriveTable;
+	OverDriveTable_t *boot = &boot_od_table->OverDriveTable;
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t offset_of_voltageoffset;
 	int32_t minimum, maximum;
+	long restored_setting = -1;
+	u32 next_mask;
+	bool restore_default = false;
 	int i, ret = 0;
 
 	switch (type) {
@@ -1898,40 +1989,55 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 			ret = smu_v13_0_7_od_restore_table_single(smu, input[0]);
 			if (ret)
 				return ret;
+			restored_setting = input[0];
 		} else {
 			memcpy(od_table,
 					table_context->boot_overdrive_table,
 					sizeof(OverDriveTableExternal_t));
 			od_table->OverDriveTable.FeatureCtrlMask = 0;
-			table_context->user_od_feature_mask = 0;
+			restore_default = true;
 		}
 		fallthrough;
 
 	case PP_OD_COMMIT_DPM_TABLE:
-		table_context->user_od_feature_mask =
-			od_table->OverDriveTable.FeatureCtrlMask;
 		offset_of_voltageoffset = offsetof(OverDriveTable_t, VoltageOffsetPerZoneBoundary);
-		if (memcmp((u8 *)od_table + offset_of_voltageoffset,
-			   table_context->user_overdrive_table + offset_of_voltageoffset,
-			   sizeof(OverDriveTableExternal_t) - offset_of_voltageoffset)) {
-			smu_v13_0_7_dump_od_table(smu, od_table);
+		next_mask = restore_default ? 0 :
+			smu_v13_0_7_filter_od_feature_mask(smu,
+							   table_context->user_od_feature_mask |
+							   od->FeatureCtrlMask);
+		if (restored_setting >= 0)
+			next_mask = smu_v13_0_7_restore_feature_mask(od, boot,
+								     restored_setting,
+								     next_mask);
 
-			ret = smu_v13_0_7_upload_overdrive_table(smu, od_table);
+		if (memcmp((u8 *)od_table + offset_of_voltageoffset,
+			   (u8 *)user_od_table + offset_of_voltageoffset,
+			   sizeof(OverDriveTableExternal_t) - offset_of_voltageoffset) ||
+		    next_mask != table_context->user_od_feature_mask) {
+			memcpy(&upload_table, od_table, sizeof(upload_table));
+			upload_table.OverDriveTable.FeatureCtrlMask = next_mask;
+			smu_v13_0_7_dump_od_table(smu, &upload_table);
+
+			ret = smu_v13_0_7_upload_overdrive_table(smu, &upload_table);
 			if (ret) {
+				if (restore_default || restored_setting >= 0) {
+					memcpy(od_table, user_od_table,
+					       sizeof(OverDriveTableExternal_t));
+					od->FeatureCtrlMask = 0;
+				}
 				dev_err(adev->dev, "Failed to upload overdrive table!\n");
 				return ret;
 			}
 
-			memcpy(table_context->user_overdrive_table + offset_of_voltageoffset,
+			table_context->user_od_feature_mask = next_mask;
+			od_table->OverDriveTable.FeatureCtrlMask = 0;
+			memcpy((u8 *)user_od_table + offset_of_voltageoffset,
 			       (u8 *)od_table + offset_of_voltageoffset,
 			       sizeof(OverDriveTableExternal_t) - offset_of_voltageoffset);
+			user_od_table->OverDriveTable.FeatureCtrlMask = 0;
 
-			if (!memcmp(table_context->user_overdrive_table,
-				    table_context->boot_overdrive_table,
-				    sizeof(OverDriveTableExternal_t)))
-				smu->user_dpm_profile.user_od = false;
-			else
-				smu->user_dpm_profile.user_od = true;
+			smu->user_dpm_profile.user_od =
+				!!(next_mask & ~BIT(PP_OD_FEATURE_PPT_BIT));
 		}
 		break;
 
@@ -2187,6 +2293,7 @@ static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
 	memcpy(od_table,
 	       boot_od_table,
 	       sizeof(OverDriveTableExternal_t));
+	od_table->OverDriveTable.FeatureCtrlMask = 0;
 
 	/*
 	 * For S3/S4/Runpm resume, we need to setup those overdrive tables again,
@@ -2196,6 +2303,7 @@ static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
 		memcpy(user_od_table,
 		       boot_od_table,
 		       sizeof(OverDriveTableExternal_t));
+		user_od_table->OverDriveTable.FeatureCtrlMask = 0;
 		smu->user_dpm_profile.user_od = false;
 		smu->smu_table.user_od_feature_mask = 0;
 	} else if (smu->user_dpm_profile.user_od) {
@@ -2234,6 +2342,14 @@ static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
 			user_od_table_bak.OverDriveTable.FanZeroRpmEnable;
 		user_od_table->OverDriveTable.FanZeroRpmStopTemp =
 			user_od_table_bak.OverDriveTable.FanZeroRpmStopTemp;
+		user_od_table->OverDriveTable.FanMode =
+			user_od_table_bak.OverDriveTable.FanMode;
+		user_od_table->OverDriveTable.FeatureCtrlMask = 0;
+	}
+	if (smu->adev->in_suspend) {
+		user_od_table->OverDriveTable.Ppt = 0;
+		smu->smu_table.user_od_feature_mask &=
+			~BIT(PP_OD_FEATURE_PPT_BIT);
 	}
 
 	smu_v13_0_7_set_supported_od_feature_mask(smu);
@@ -2246,14 +2362,22 @@ static int smu_v13_0_7_restore_user_od_settings(struct smu_context *smu)
 	struct smu_table_context *table_context = &smu->smu_table;
 	OverDriveTableExternal_t *od_table = table_context->overdrive_table;
 	OverDriveTableExternal_t *user_od_table = table_context->user_overdrive_table;
+	OverDriveTableExternal_t upload_table;
+	u32 next_mask;
 	int res;
 
-	user_od_table->OverDriveTable.FeatureCtrlMask =
-		table_context->user_od_feature_mask;
-	res = smu_v13_0_7_upload_overdrive_table(smu, user_od_table);
-	user_od_table->OverDriveTable.FeatureCtrlMask = 0;
-	if (res == 0)
+	next_mask = smu_v13_0_7_filter_od_feature_mask(smu,
+						       table_context->user_od_feature_mask);
+	memcpy(&upload_table, user_od_table, sizeof(upload_table));
+	upload_table.OverDriveTable.FeatureCtrlMask = next_mask;
+	res = smu_v13_0_7_upload_overdrive_table(smu, &upload_table);
+	if (res == 0) {
+		table_context->user_od_feature_mask = next_mask;
+		smu->user_dpm_profile.user_od =
+			!!(next_mask & ~BIT(PP_OD_FEATURE_PPT_BIT));
 		memcpy(od_table, user_od_table, sizeof(OverDriveTableExternal_t));
+		od_table->OverDriveTable.FeatureCtrlMask = 0;
+	}
 
 	return res;
 }
@@ -2695,10 +2819,8 @@ static int smu_v13_0_7_set_ppt_limit(struct smu_context *smu,
 	SkuTable_t *skutable = &pptable->SkuTable;
 	uint32_t msg_limit = skutable->MsgLimits.Power
 		[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
-	struct smu_table_context *table_context = &smu->smu_table;
-	OverDriveTableExternal_t *od_table =
-		(OverDriveTableExternal_t *)table_context->overdrive_table;
 	OverDriveTableExternal_t current_od_table;
+	s16 ppt;
 	int ret = 0;
 
 	if (limit_type != SMU_PPT_LIMIT_PPT0)
@@ -2710,13 +2832,7 @@ static int smu_v13_0_7_set_ppt_limit(struct smu_context *smu,
 			return ret;
 
 		if (current_od_table.OverDriveTable.Ppt) {
-			od_table->OverDriveTable.Ppt = 0;
-			table_context->user_od_feature_mask &=
-				~(1U << PP_OD_FEATURE_PPT_BIT);
-			od_table->OverDriveTable.FeatureCtrlMask =
-				table_context->user_od_feature_mask;
-
-			ret = smu_v13_0_7_upload_overdrive_table(smu, od_table);
+			ret = smu_v13_0_7_upload_ppt_overdrive_table(smu, 0);
 			if (ret) {
 				dev_err(smu->adev->dev, "Failed to upload overdrive table!\n");
 				return ret;
@@ -2728,12 +2844,8 @@ static int smu_v13_0_7_set_ppt_limit(struct smu_context *smu,
 		if (ret)
 			return ret;
 
-		od_table->OverDriveTable.Ppt = (limit * 100) / msg_limit - 100;
-		table_context->user_od_feature_mask |= 1U << PP_OD_FEATURE_PPT_BIT;
-		od_table->OverDriveTable.FeatureCtrlMask =
-			table_context->user_od_feature_mask;
-
-		ret = smu_v13_0_7_upload_overdrive_table(smu, od_table);
+		ppt = (limit * 100) / msg_limit - 100;
+		ret = smu_v13_0_7_upload_ppt_overdrive_table(smu, ppt);
 		if (ret) {
 		  dev_err(smu->adev->dev, "Failed to upload overdrive table!\n");
 		  return ret;
-- 
2.55.0

