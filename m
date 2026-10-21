Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6218C606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 00:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iXTmp1Kf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 065F710EC33;
	Wed, 21 Oct 2026 00:08:04 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9EFB10EC33
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 00:07:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9HtbkUHlpqVFVAJ2EfVS/r83nEuISf2bll0uuYT0vIs3v1iutCPiGjxDMLjef1+cRAypL6oka10pVDKsyKdDkWZWY033FYarxJp7ESOaQKmvB1THZdMiA64MgJxxSl3pKopcXyWdP7yDtxWtU2+wAlFr2ZhbODzbSfn+hgh5OCUI232V6AOkMaclCRyXryLyKkxlH9EYOdC+d61JiuVlhHZpoOic6bhT3OBjTjA0u4lsez/JrHyfsAiciGJNxlhDut6O7Wbop1c7vtjrBKuz08LD0J+6FNARf2OuiPFvTx+m+tqOCBlOFMxsN7+hppO3tOk5KbCQNKiGgIUJhcl+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RH5GVeBCrnNU7fQk19mX053DQKpUcVsXT2ogADsvdQY=;
 b=LehnznkibPZgpqOUKeGZNgJpgZNlbzwQPIDO/pMpegaP+4HNMxBKonmiAaGERyZinNgxzSWgGeOI/HppZzmX+5qti/2cFcyAbsbeoxOCUYVXG/PgiS7Sog3vdpbXzJUYVkh6MbwE7El9ItCpC+hPtF2p1NG8xFhpm+i07JZdCyeWwKwYIb77R8k2PjAHezRFQIydxXGZ7prR+XYm5Jk2mdR83sydp5yB66KxdFBmUMzolQ4wxYOg9Ha5Y8kYKuXQwU7mZJGPUDCW66/XJYNQSZwlDxk4UCAA4nmUpi+rFHSk9tRF1//s/yhfBpgnFf940K9S+K+NkpqTBrrbLx/rpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RH5GVeBCrnNU7fQk19mX053DQKpUcVsXT2ogADsvdQY=;
 b=iXTmp1KfMRj46e1tBn5gqpPDYZxAa/wxdWd43EUpWK+eB6xgxeHQp4fvP7REDb2fIDMwDMBlBqd4UcP5F9iiErryq5/m/kbFLTqR9mbbZGBWiVapRZdyREVFGWxquuMoNpZO32yKha2iL8OsZoIJFVWXPsLqbznOJmY7rz3IK6o=
Received: from BN9P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::16)
 by DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Wed, 21 Oct
 2026 00:07:50 +0000
Received: from LV8PEPF00000067.namprd03.prod.outlook.com
 (2603:10b6:408:10a:cafe::85) by BN9P221CA0001.outlook.office365.com
 (2603:10b6:408:10a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 00:07:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF00000067.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 00:07:50 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 19:07:48 -0500
From: Kevin Wang <kevin.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: preserve committed OD features for SMU 14.0.2
Date: Wed, 21 Oct 2026 08:07:35 +0800
Message-ID: <20261021000735.3766283-2-kevin.wang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021000735.3766283-1-kevin.wang@amd.com>
References: <20261021000735.3766283-1-kevin.wang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000067:EE_|DS7PR12MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: 6576fbea-6f0e-4f56-03f9-08df2f075847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|56012099006|5023799004|11063799006|261009223027099003|10067099003|22082099003|6133799003|3023799007|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info: h+1S0/ClofBcJqqvJrVxVCrNsAWHlAP+F8uzer3OQk0lo+b6IHsZkMtkQ1dfSXg9FWDd6xtNypSAxsXj1vgENTbtnShkuDH92DZG2RRHzY195suaMRLjK2RVc6/ityZzLXtYOUeao0JhIZP5Cp8zl/WqK/8jaElPnRP7BeDoaX3n+rBA4OuhDqMtwqcpLQdiaEj5/JHk+/vUSuGsWz9lqAM5HdFXwLlR5CbXRObd+4YHa2sclo1kq6z/82j4vnItAHLXuchfFo/5Zj8Qh2KEUL4qtmER1deAmOnLKn5iJPsdX8JZi78zm+37VsZBO32fh8euWlclBX5ihtKftFgz8n+ov46aTwcsLBIYxvb2nwhuOdAimWUHzqhcMYQsFInchhTwGmwe24He1LCDquKzHMnjTMiDM+0oo3i0amIaMcpYCLgehgutXqCZAxjgiJst9/+WipgVLGuxQIiH6Nzk3If9B3ekhv+VpUUSDxX1JNp3UNNvwCuyPeBovENJjfIVp3N7xhJrF4XeUNB0OTkr9EYHH52wtaKxwUzKFKOvH7Fa9PPxw0OPStWH5hTGoU9vzAn+wOrFNOqObC3DnTyxSx/aJkR+o+QGyOLnN5L1KGW1UaIrvteUGKVff6pEvXOgKpXIsbg1898j+iwulqBAQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(56012099006)(5023799004)(11063799006)(261009223027099003)(10067099003)(22082099003)(6133799003)(3023799007)(13003099007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LKkASMElexdHejFxs7vkHS37GuLoakmKrFI1SNddTiNwL9aDzcp38u0JA6q6ZDLRR+EGws5x+P/m2n/GLsFA1PtouSIGUTCagmtfZRZfhwuvSF5cSHoq22cDctNNfe8g3viIRhJX/hxYikyrZY57NJPomakasPwwzu80dWegugddjwNvwNFnemEr7STEgr5mfjh8AxH7fX/IzipGUSOq36ln6B4NjaUZvqWZHqvv90M0pZq2Syc4ajxcVe65lNtsYpYu0C1ustrupVnkOZIgrNrPu71WsXAMvUjHda/51KJN9pvS8X/deV71uMw87R9VLfg09rde+e5dQNxY+EtHRZEsGzqWQ/viFYn2+AQV0dRduOH0VMhUJ/6exf5ivXffFuhxlmjQkZQ+efE7XfkJjUB6B9R6Vdl7oQmnnygymnZITR44C9LfilFGSHjpbTn2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 00:07:50.1799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6576fbea-6f0e-4f56-03f9-08df2f075847
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000067.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5765
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
- keep fan-curve and legacy-fan bits mutually exclusive
- keep staged OD settings out of power-cap writes
- update cached state only after successful uploads
- clear restored features only after they return to defaults
- restore PPT for the current AC/DC source after resume

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/3625
Signed-off-by: Kevin Wang <kevin.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 242 +++++++++++++-----
 1 file changed, 183 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index f0f86ae722a8..11fc1ad2e275 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -91,6 +91,10 @@ static const struct smu_feature_bits smu_v14_0_2_dpm_features = {
 #define PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE		11
 #define PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP		12
 
+#define SMU_14_0_2_OD_FAN_FEATURE_MASK \
+	(BIT(PP_OD_FEATURE_FAN_CURVE_BIT) | \
+	 BIT(PP_OD_FEATURE_FAN_LEGACY_BIT))
+
 static struct cmn2asic_msg_mapping smu_v14_0_2_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
 	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,               1),
@@ -963,6 +967,85 @@ static bool smu_v14_0_2_is_od_feature_supported(struct smu_context *smu,
 	return feature_enabled;
 }
 
+static u32
+smu_v14_0_2_filter_od_feature_mask(struct smu_context *smu, u32 feature_mask)
+{
+	PPTable_t *pptable = smu->smu_table.driver_pptable;
+	u32 supported_mask =
+		pptable->SkuTable.OverDriveLimitsBasicMax.FeatureCtrlMask;
+
+	return feature_mask & supported_mask;
+}
+
+static u32
+smu_v14_0_2_get_od_feature_mask(struct smu_context *smu, u32 pending_mask)
+{
+	u32 supported_mask = smu_v14_0_2_filter_od_feature_mask(smu, ~0U);
+	u32 fan_mask = supported_mask & SMU_14_0_2_OD_FAN_FEATURE_MASK;
+	u32 mask = smu->smu_table.user_od_feature_mask;
+
+	if (pending_mask & fan_mask)
+		mask &= ~fan_mask;
+	mask |= pending_mask;
+
+	return smu_v14_0_2_filter_od_feature_mask(smu, mask);
+}
+
+static bool smu_v14_0_2_fan_is_default(const OverDriveTable_t *od,
+				       const OverDriveTable_t *boot)
+{
+	return !memcmp(od->FanLinearPwmPoints, boot->FanLinearPwmPoints,
+			sizeof(od->FanLinearPwmPoints)) &&
+		!memcmp(od->FanLinearTempPoints, boot->FanLinearTempPoints,
+			sizeof(od->FanLinearTempPoints)) &&
+		od->AcousticTargetRpmThreshold == boot->AcousticTargetRpmThreshold &&
+		od->AcousticLimitRpmThreshold == boot->AcousticLimitRpmThreshold &&
+		od->FanTargetTemperature == boot->FanTargetTemperature &&
+		od->FanMode == boot->FanMode;
+}
+
+static bool smu_v14_0_2_legacy_fan_is_default(const OverDriveTable_t *od,
+					      const OverDriveTable_t *boot)
+{
+	return od->FanMinimumPwm == boot->FanMinimumPwm &&
+		od->FanMode == boot->FanMode;
+}
+
+static bool smu_v14_0_2_zero_fan_is_default(const OverDriveTable_t *od,
+					    const OverDriveTable_t *boot)
+{
+	return od->FanZeroRpmEnable == boot->FanZeroRpmEnable &&
+		od->FanZeroRpmStopTemp == boot->FanZeroRpmStopTemp;
+}
+
+static u32 smu_v14_0_2_restore_feature_mask(const OverDriveTable_t *od,
+					    const OverDriveTable_t *boot,
+					    long input, u32 feature_mask)
+{
+	switch (input) {
+	case PP_OD_EDIT_FAN_CURVE:
+	case PP_OD_EDIT_ACOUSTIC_LIMIT:
+	case PP_OD_EDIT_ACOUSTIC_TARGET:
+	case PP_OD_EDIT_FAN_TARGET_TEMPERATURE:
+		if (smu_v14_0_2_fan_is_default(od, boot))
+			feature_mask &= ~BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		break;
+	case PP_OD_EDIT_FAN_MINIMUM_PWM:
+		if (smu_v14_0_2_legacy_fan_is_default(od, boot))
+			feature_mask &= ~BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
+		break;
+	case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
+	case PP_OD_EDIT_FAN_ZERO_RPM_STOP_TEMP:
+		if (smu_v14_0_2_zero_fan_is_default(od, boot))
+			feature_mask &= ~BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
+		break;
+	default:
+		break;
+	}
+
+	return feature_mask;
+}
+
 static void smu_v14_0_2_get_od_setting_limits(struct smu_context *smu,
 					      int od_feature_bit,
 					      int32_t *min,
@@ -2320,6 +2403,38 @@ static int smu_v14_0_2_upload_overdrive_table(struct smu_context *smu,
 	return ret;
 }
 
+static int
+smu_v14_0_2_upload_ppt_overdrive_table(struct smu_context *smu, s16 ppt)
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
+		smu_v14_0_2_filter_od_feature_mask(smu, next_mask);
+
+	ret = smu_v14_0_2_upload_overdrive_table(smu, &upload_table);
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
 static void smu_v14_0_2_set_supported_od_feature_mask(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -2378,6 +2493,7 @@ static int smu_v14_0_2_set_default_od_settings(struct smu_context *smu)
 	memcpy(od_table,
 	       boot_od_table,
 	       sizeof(OverDriveTableExternal_t));
+	od_table->OverDriveTable.FeatureCtrlMask = 0;
 
 	/*
 	 * For S3/S4/Runpm resume, we need to setup those overdrive tables again,
@@ -2387,6 +2503,7 @@ static int smu_v14_0_2_set_default_od_settings(struct smu_context *smu)
 		memcpy(user_od_table,
 		       boot_od_table,
 		       sizeof(OverDriveTableExternal_t));
+		user_od_table->OverDriveTable.FeatureCtrlMask = 0;
 		smu->user_dpm_profile.user_od = false;
 		smu->smu_table.user_od_feature_mask = 0;
 	} else if (smu->user_dpm_profile.user_od) {
@@ -2423,6 +2540,14 @@ static int smu_v14_0_2_set_default_od_settings(struct smu_context *smu)
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
 
 	smu_v14_0_2_set_supported_od_feature_mask(smu);
@@ -2435,14 +2560,22 @@ static int smu_v14_0_2_restore_user_od_settings(struct smu_context *smu)
 	struct smu_table_context *table_context = &smu->smu_table;
 	OverDriveTableExternal_t *od_table = table_context->overdrive_table;
 	OverDriveTableExternal_t *user_od_table = table_context->user_overdrive_table;
+	OverDriveTableExternal_t upload_table;
+	u32 next_mask;
 	int res;
 
-	user_od_table->OverDriveTable.FeatureCtrlMask =
-		table_context->user_od_feature_mask;
-	res = smu_v14_0_2_upload_overdrive_table(smu, user_od_table);
-	user_od_table->OverDriveTable.FeatureCtrlMask = 0;
-	if (res == 0)
+	next_mask = smu_v14_0_2_filter_od_feature_mask(smu,
+						       table_context->user_od_feature_mask);
+	memcpy(&upload_table, user_od_table, sizeof(upload_table));
+	upload_table.OverDriveTable.FeatureCtrlMask = next_mask;
+	res = smu_v14_0_2_upload_overdrive_table(smu, &upload_table);
+	if (res == 0) {
+		table_context->user_od_feature_mask = next_mask;
+		smu->user_dpm_profile.user_od =
+			!!(next_mask & ~BIT(PP_OD_FEATURE_PPT_BIT));
 		memcpy(od_table, user_od_table, sizeof(OverDriveTableExternal_t));
+		od_table->OverDriveTable.FeatureCtrlMask = 0;
+	}
 
 	return res;
 }
@@ -2466,43 +2599,30 @@ static int smu_v14_0_2_od_restore_table_single(struct smu_context *smu, long inp
 					boot_overdrive_table->OverDriveTable.FanLinearPwmPoints[i];
 		}
 		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
-		od_table->OverDriveTable.FeatureCtrlMask &= ~BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
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
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
-		od_table->OverDriveTable.FeatureCtrlMask &= ~BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 	default:
 		dev_info(adev->dev, "Invalid table index: %ld\n", input);
@@ -2520,9 +2640,19 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
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
@@ -2694,6 +2824,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.AcousticLimitRpmThreshold = input[0];
 		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		od_table->OverDriveTable.FeatureCtrlMask &= ~BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
 		break;
 
 	case PP_OD_EDIT_ACOUSTIC_TARGET:
@@ -2716,6 +2847,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.AcousticTargetRpmThreshold = input[0];
 		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		od_table->OverDriveTable.FeatureCtrlMask &= ~BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
 		break;
 
 	case PP_OD_EDIT_FAN_TARGET_TEMPERATURE:
@@ -2738,6 +2870,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FanTargetTemperature = input[0];
 		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		od_table->OverDriveTable.FeatureCtrlMask &= ~BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
 		break;
 
 	case PP_OD_EDIT_FAN_MINIMUM_PWM:
@@ -2810,49 +2943,52 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 			ret = smu_v14_0_2_od_restore_table_single(smu, input[0]);
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
-		/*
-		 * PMFW interprets FeatureCtrlMask as the complete set of OD
-		 * features that are currently overridden, not as a delta
-		 * describing this single operation. Any feature whose bit is
-		 * clear gets reset to its default on import. od_table's mask
-		 * has accumulated every feature the user touched since the
-		 * last full restore, so record it and keep restating it on
-		 * subsequent uploads.
-		 */
-		table_context->user_od_feature_mask =
-			od_table->OverDriveTable.FeatureCtrlMask;
-
 		offset_of_voltageoffset = offsetof(OverDriveTable_t, VoltageOffsetPerZoneBoundary);
-		if (memcmp((u8 *)od_table + offset_of_voltageoffset,
-			   table_context->user_overdrive_table + offset_of_voltageoffset,
-			   sizeof(OverDriveTableExternal_t) - offset_of_voltageoffset)) {
-			smu_v14_0_2_dump_od_table(smu, od_table);
+		next_mask = restore_default ? 0 :
+			smu_v14_0_2_get_od_feature_mask(smu, od->FeatureCtrlMask);
+		if (restored_setting >= 0)
+			next_mask = smu_v14_0_2_restore_feature_mask(od, boot,
+								     restored_setting,
+								     next_mask);
 
-			ret = smu_v14_0_2_upload_overdrive_table(smu, od_table);
+		if (memcmp((u8 *)od_table + offset_of_voltageoffset,
+			   (u8 *)user_od_table + offset_of_voltageoffset,
+			   sizeof(OverDriveTableExternal_t) - offset_of_voltageoffset) ||
+		    next_mask != table_context->user_od_feature_mask) {
+			memcpy(&upload_table, od_table, sizeof(upload_table));
+			upload_table.OverDriveTable.FeatureCtrlMask = next_mask;
+			smu_v14_0_2_dump_od_table(smu, &upload_table);
+
+			ret = smu_v14_0_2_upload_overdrive_table(smu, &upload_table);
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
 
@@ -2870,10 +3006,8 @@ static int smu_v14_0_2_set_ppt_limit(struct smu_context *smu,
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	uint32_t msg_limit = pptable->SkuTable.MsgLimits.Power
 		[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
-	struct smu_table_context *table_context = &smu->smu_table;
-	OverDriveTableExternal_t *od_table =
-		(OverDriveTableExternal_t *)table_context->overdrive_table;
 	OverDriveTableExternal_t current_od_table;
+	s16 ppt;
 	int ret = 0;
 
 	if (limit_type != SMU_PPT_LIMIT_PPT0)
@@ -2885,13 +3019,7 @@ static int smu_v14_0_2_set_ppt_limit(struct smu_context *smu,
 			return ret;
 
 		if (current_od_table.OverDriveTable.Ppt) {
-			od_table->OverDriveTable.Ppt = 0;
-			table_context->user_od_feature_mask &=
-				~(1U << PP_OD_FEATURE_PPT_BIT);
-			od_table->OverDriveTable.FeatureCtrlMask =
-				table_context->user_od_feature_mask;
-
-			ret = smu_v14_0_2_upload_overdrive_table(smu, od_table);
+			ret = smu_v14_0_2_upload_ppt_overdrive_table(smu, 0);
 			if (ret) {
 				dev_err(smu->adev->dev, "Failed to upload overdrive table!\n");
 				return ret;
@@ -2903,12 +3031,8 @@ static int smu_v14_0_2_set_ppt_limit(struct smu_context *smu,
 		if (ret)
 			return ret;
 
-		od_table->OverDriveTable.Ppt = (limit * 100) / msg_limit - 100;
-		table_context->user_od_feature_mask |= 1U << PP_OD_FEATURE_PPT_BIT;
-		od_table->OverDriveTable.FeatureCtrlMask =
-			table_context->user_od_feature_mask;
-
-		ret = smu_v14_0_2_upload_overdrive_table(smu, od_table);
+		ppt = (limit * 100) / msg_limit - 100;
+		ret = smu_v14_0_2_upload_ppt_overdrive_table(smu, ppt);
 		if (ret) {
 		  dev_err(smu->adev->dev, "Failed to upload overdrive table!\n");
 		  return ret;
-- 
2.55.0

