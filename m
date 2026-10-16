Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9941DCC6B38
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 07:24:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3261E112626;
	Fri, 16 Oct 2026 07:24:06 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB9B4112626
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 07:23:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6Wf+JhUnjC1/BOvYDtQ3qpf8Ali4TVy8++IKgJLcu7aveD/wHwUbecLfbO260NAwXZzGuz7/KHEGOFG25BVJzRmWfEX1cRG/1ZdTLVpQC3aajoPMht9cqBG2M7xfDP6iuaPJTMMCqqzsU6jEfVOYa4sjGmqNno7MpraMVomdptWyyU/olUykPKezkZQUZz4YDUFphZc+C5vBqqCYLaDyd6ymaZtGG3+RDeXV/YIvmidovGLN2CWj7xv3ep38kAdctJi90wnwUrt4i4SMy5wHOaz49GhjbhiwGkRIlGB9ALwztV5YwVXP8VR4+fxqXAaZ2fbC9FXuUlFRYg85XGexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVJl3PYhdMMVWlS+UVOEPMChGZGTfwiTXA/SDMJGEHM=;
 b=AU46rntgvkw9RXwGVjnVQeThWwYQ6hQgrkBx8A9y6Er9tT3FeGULSHxrGtakrrW77xDL1lFpZMIVM24LhyYxoADfEnIZfsmjeIzTEz/PzlLRFUtMN026Aw3WwISVVqsn2Sif78+jdgsVDGE05cDWxKlrZytrPXIQFG7On1nAql8TiO8rQF8LH+gCHYDWr9G6UfJGr7rlzENUARUb2gs//AHm7awFXEtKN0patD0KN6YetcZ9t9bOpAmafmPFTEiq4Zpz1+hxhg5PSDc4cFtNUq3r2c/uSbfwoAaIE6p6b+hZPnJ6UD3R59G0pOrR+NpQxdxqoCSd5lK3EO4FPz6loQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVJl3PYhdMMVWlS+UVOEPMChGZGTfwiTXA/SDMJGEHM=;
 b=pMm7msbPY4hzMwrhjsH4zNhXbtKLIvv2nXf7n1uzGXxWZzBvJmZxUcWJzTku2/PXoqoVrMnvnXezfHQNXP/2FWWvI3ObUJ+yZMUddEv6sOKWbBSJggeQ1H6lHWfUV8JS+rJhiRsG8JtAgi1Iaez2Q5DNQyS9bpI/ytdSBKud5qw=
Received: from CH0PR04CA0035.namprd04.prod.outlook.com (2603:10b6:610:77::10)
 by DS6PR12MB095541.namprd12.prod.outlook.com (2603:10b6:8:498::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 07:23:56 +0000
Received: from CH01EPF000BE943.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::60) by CH0PR04CA0035.outlook.office365.com
 (2603:10b6:610:77::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Fri,
 16 Oct 2026 07:23:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE943.mail.protection.outlook.com (10.167.244.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 07:23:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 02:23:48 -0500
Received: from LNXAMD-Kenneth.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 16 Oct 2026 02:23:47 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kevin.Wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm:restate all customized OD features on every table
 upload for smu 13.0.0/smu 14.0.2
Date: Fri, 16 Oct 2026 15:23:51 +0800
Message-ID: <20261016072351.2479189-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE943:EE_|DS6PR12MB095541:EE_
X-MS-Office365-Filtering-Correlation-Id: dc8aae0a-5227-456e-4622-08df2b567036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|56012099006|11063799006|5023799004|261009223027099003|10067099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: MbLR8SBC8kEZxKS7AHzijQ6XFe9AXvjN1oRtEbhEnSqLcOGYsr0S+AN37V1ygEubmYMhEarx1L26ihjHx7sprN6ATKz3vO/WzJG5isf4hDE+wgpUyTPYEE6udc2E9aGSWtTqmxpgWcrOjQtwa+yIzv8dDbQ5TA0p9KAi2diePZRyF723Wmv8+5aN0DROSjjk4UoqOqyaXEz4J2BdDHmpcSLVtOSCyVgflEAhdNHGHiZPDgf33rdAfPypGGdQ1clyiDyoRDE4uf3KzhUxtnZupAj7flsFQUbF1xpHfXiITUrv2dJ1q+DO+sTzfRVzxXFERyZFI0LJe/vCC0Qkhgv4STb68qzX+GbSwgk8IlXhnLMw8k3UOMeqRHGmJz8PCeyVdiwNDMgLZuc/nw9AaS88q/b589aD3gTvdvoLaFfygUYxcClEn4b3ztJwXa1Z0GPNAemTYb0hdpu2CwXELci1oH/V5nP/Sv6DNxr7jSjfSKwT3UqLGyV4j9hZZpjQuZI/qbxjXG3A/C0zd6ilPftdkYQE60dtKFa14bL9BwuWNuaAyihCYQHqFrlhRmroM5/BF4dkbjiNVdEbeGTG2imNv1aZcgobcrohL8nYlaB5pj4XK8FQIwP1ovcztmV5y4RfgOD3AboGZdKpfPSZjnGQOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(5023799004)(261009223027099003)(10067099003)(18002099003)(6133799003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OPGR/tZ/HMyOLL/b18PbTU5RKsdmlKZFomZiNRjPT2PzLPvFnQuZUj6+ytEIRotHXf31SmoWjycVna6jVcaYRN5FM0VLuoii8AJ+dqvT2Um0cbTWAKKoZytik/dMSA1sLy0xwX6QaFjOad6vXZxgINStguiJ1iwfJvRtwaRKMImGTkhp25Njy5bUvE1Yzawqu7zSQU3zBFDvB4jTJheqbLiBI5gutG3D+XjsxQtFxFuU1LOrad55XUxOypN/OXLpR9kYWgFeT7ifpEarfMjFCLDVYf63Ubke7MRIwZRuiGPm1B7zu2p4J6u1nBwuzzviMuJwWQ+G/dbB9wmq9HC9VoOJoIaeWUF6ZuS3uUt0pweHyMelj4IPgYoQxkvwm57DbSfYfzTrm6ZdEKzjp7P9m/NVmL6LS9Ru18+qCu44Yz2OKGY6gbNnPhdRKXWQ+Ztv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:23:55.9129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8aae0a-5227-456e-4622-08df2b567036
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE943.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB095541
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

PMFW interprets OverDriveTable.FeatureCtrlMask as the complete set of
overdrive features that are currently overridden, not as a delta
describing the operation at hand. On import it resets every feature
whose bit is clear back to its default value - for the VF curve that
means zeroing VoltageOffsetPerZoneBoundary[] outright.

The driver assumed the opposite. smu_v14_0_2_od_edit_dpm_table() clears
the mask after a successful commit, so a subsequent above-default
power1_cap write goes through smu_v14_0_2_set_ppt_limit() and uploads a
table carrying only PP_OD_FEATURE_PPT_BIT. PMFW then drops the user's
voltage offset and reverts to the stock V/F curve, while the driver's
cached user table still reports the offset through pp_od_clk_voltage.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5935
Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 35 +++++++----------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 32 +++++++---------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 38 +++++++++++--------
 4 files changed, 52 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index f516d0d3bb92..9d47d2ab1b49 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -433,6 +433,8 @@ struct smu_table_context {
 	void                            *boot_overdrive_table;
 	void				*user_overdrive_table;
 
+	uint32_t			user_od_feature_mask;
+
 	struct smu_driver_table driver_tables[SMU_DRIVER_TABLE_COUNT];
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 6beafabf1306..468aaeb79ffb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1569,7 +1569,6 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t offset_of_voltageoffset;
 	int32_t minimum, maximum;
-	uint32_t feature_ctrlmask;
 	int i, ret = 0;
 
 	switch (type) {
@@ -1891,21 +1890,16 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 			if (ret)
 				return ret;
 		} else {
-			feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
 			memcpy(od_table,
 		       table_context->boot_overdrive_table,
 		       sizeof(OverDriveTableExternal_t));
-			od_table->OverDriveTable.FeatureCtrlMask = feature_ctrlmask;
+			od_table->OverDriveTable.FeatureCtrlMask = 0;
+			table_context->user_od_feature_mask = 0;
 		}
 		fallthrough;
 	case PP_OD_COMMIT_DPM_TABLE:
-		/*
-		 * The member below instructs PMFW the settings focused in
-		 * this single operation.
-		 * `uint32_t FeatureCtrlMask;`
-		 * It does not contain actual informations about user's custom
-		 * settings. Thus we do not cache it.
-		 */
+		table_context->user_od_feature_mask =
+			od_table->OverDriveTable.FeatureCtrlMask;
 		offset_of_voltageoffset = offsetof(OverDriveTable_t, VoltageOffsetPerZoneBoundary);
 		if (memcmp((u8 *)od_table + offset_of_voltageoffset,
 			   table_context->user_overdrive_table + offset_of_voltageoffset,
@@ -1918,7 +1912,6 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 				return ret;
 			}
 
-			od_table->OverDriveTable.FeatureCtrlMask = 0;
 			memcpy(table_context->user_overdrive_table + offset_of_voltageoffset,
 			       (u8 *)od_table + offset_of_voltageoffset,
 			       sizeof(OverDriveTableExternal_t) - offset_of_voltageoffset);
@@ -2201,6 +2194,7 @@ static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
 		       boot_od_table,
 		       sizeof(OverDriveTableExternal_t));
 		smu->user_dpm_profile.user_od = false;
+		smu->smu_table.user_od_feature_mask = 0;
 	} else if (smu->user_dpm_profile.user_od) {
 		memcpy(&user_od_table_bak,
 		       user_od_table,
@@ -2250,12 +2244,8 @@ static int smu_v13_0_0_restore_user_od_settings(struct smu_context *smu)
 	OverDriveTableExternal_t *od_table = table_context->overdrive_table;
 	OverDriveTableExternal_t *user_od_table = table_context->user_overdrive_table;
 	int res;
-
-	user_od_table->OverDriveTable.FeatureCtrlMask = BIT(PP_OD_FEATURE_GFXCLK_BIT) |
-							BIT(PP_OD_FEATURE_UCLK_BIT) |
-							BIT(PP_OD_FEATURE_GFX_VF_CURVE_BIT) |
-							BIT(PP_OD_FEATURE_FAN_CURVE_BIT) |
-							BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
+	user_od_table->OverDriveTable.FeatureCtrlMask =
+		table_context->user_od_feature_mask;
 	res = smu_v13_0_0_upload_overdrive_table(smu, user_od_table);
 	user_od_table->OverDriveTable.FeatureCtrlMask = 0;
 	if (res == 0)
@@ -3069,8 +3059,10 @@ static int smu_v13_0_0_set_ppt_limit(struct smu_context *smu,
 
 		if (current_od_table.OverDriveTable.Ppt) {
 			od_table->OverDriveTable.Ppt = 0;
-			od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_PPT_BIT;
-
+			table_context->user_od_feature_mask &=
+				~(1U << PP_OD_FEATURE_PPT_BIT);
+			od_table->OverDriveTable.FeatureCtrlMask =
+				table_context->user_od_feature_mask;
 			ret = smu_v13_0_0_upload_overdrive_table(smu, od_table);
 			if (ret) {
 				dev_err(smu->adev->dev, "Failed to upload overdrive table!\n");
@@ -3084,8 +3076,9 @@ static int smu_v13_0_0_set_ppt_limit(struct smu_context *smu,
 			return ret;
 
 		od_table->OverDriveTable.Ppt = (limit * 100) / msg_limit - 100;
-		od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_PPT_BIT;
-
+		table_context->user_od_feature_mask |= 1U << PP_OD_FEATURE_PPT_BIT;
+		od_table->OverDriveTable.FeatureCtrlMask =
+			table_context->user_od_feature_mask;
 		ret = smu_v13_0_0_upload_overdrive_table(smu, od_table);
 		if (ret) {
 		  dev_err(smu->adev->dev, "Failed to upload overdrive table!\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 414fb436d88f..b96152d3920f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1578,7 +1578,6 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t offset_of_voltageoffset;
 	int32_t minimum, maximum;
-	uint32_t feature_ctrlmask;
 	int i, ret = 0;
 
 	switch (type) {
@@ -1900,22 +1899,17 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 			if (ret)
 				return ret;
 		} else {
-			feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
 			memcpy(od_table,
 					table_context->boot_overdrive_table,
 					sizeof(OverDriveTableExternal_t));
-			od_table->OverDriveTable.FeatureCtrlMask = feature_ctrlmask;
+			od_table->OverDriveTable.FeatureCtrlMask = 0;
+			table_context->user_od_feature_mask = 0;
 		}
 		fallthrough;
 
 	case PP_OD_COMMIT_DPM_TABLE:
-		/*
-		 * The member below instructs PMFW the settings focused in
-		 * this single operation.
-		 * `uint32_t FeatureCtrlMask;`
-		 * It does not contain actual informations about user's custom
-		 * settings. Thus we do not cache it.
-		 */
+		table_context->user_od_feature_mask =
+			od_table->OverDriveTable.FeatureCtrlMask;
 		offset_of_voltageoffset = offsetof(OverDriveTable_t, VoltageOffsetPerZoneBoundary);
 		if (memcmp((u8 *)od_table + offset_of_voltageoffset,
 			   table_context->user_overdrive_table + offset_of_voltageoffset,
@@ -1928,7 +1922,6 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 				return ret;
 			}
 
-			od_table->OverDriveTable.FeatureCtrlMask = 0;
 			memcpy(table_context->user_overdrive_table + offset_of_voltageoffset,
 			       (u8 *)od_table + offset_of_voltageoffset,
 			       sizeof(OverDriveTableExternal_t) - offset_of_voltageoffset);
@@ -2203,6 +2196,7 @@ static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
 		       boot_od_table,
 		       sizeof(OverDriveTableExternal_t));
 		smu->user_dpm_profile.user_od = false;
+		smu->smu_table.user_od_feature_mask = 0;
 	} else if (smu->user_dpm_profile.user_od) {
 		memcpy(&user_od_table_bak,
 		       user_od_table,
@@ -2253,11 +2247,8 @@ static int smu_v13_0_7_restore_user_od_settings(struct smu_context *smu)
 	OverDriveTableExternal_t *user_od_table = table_context->user_overdrive_table;
 	int res;
 
-	user_od_table->OverDriveTable.FeatureCtrlMask = BIT(PP_OD_FEATURE_GFXCLK_BIT) |
-							BIT(PP_OD_FEATURE_UCLK_BIT) |
-							BIT(PP_OD_FEATURE_GFX_VF_CURVE_BIT) |
-							BIT(PP_OD_FEATURE_FAN_CURVE_BIT) |
-							BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
+	user_od_table->OverDriveTable.FeatureCtrlMask =
+		table_context->user_od_feature_mask;
 	res = smu_v13_0_7_upload_overdrive_table(smu, user_od_table);
 	user_od_table->OverDriveTable.FeatureCtrlMask = 0;
 	if (res == 0)
@@ -2719,7 +2710,10 @@ static int smu_v13_0_7_set_ppt_limit(struct smu_context *smu,
 
 		if (current_od_table.OverDriveTable.Ppt) {
 			od_table->OverDriveTable.Ppt = 0;
-			od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_PPT_BIT;
+			table_context->user_od_feature_mask &=
+				~(1U << PP_OD_FEATURE_PPT_BIT);
+			od_table->OverDriveTable.FeatureCtrlMask =
+				table_context->user_od_feature_mask;
 
 			ret = smu_v13_0_7_upload_overdrive_table(smu, od_table);
 			if (ret) {
@@ -2734,7 +2728,9 @@ static int smu_v13_0_7_set_ppt_limit(struct smu_context *smu,
 			return ret;
 
 		od_table->OverDriveTable.Ppt = (limit * 100) / msg_limit - 100;
-		od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_PPT_BIT;
+		table_context->user_od_feature_mask |= 1U << PP_OD_FEATURE_PPT_BIT;
+		od_table->OverDriveTable.FeatureCtrlMask =
+			table_context->user_od_feature_mask;
 
 		ret = smu_v13_0_7_upload_overdrive_table(smu, od_table);
 		if (ret) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 33f93f6d90af..c4dfa66c723b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2385,6 +2385,7 @@ static int smu_v14_0_2_set_default_od_settings(struct smu_context *smu)
 		       boot_od_table,
 		       sizeof(OverDriveTableExternal_t));
 		smu->user_dpm_profile.user_od = false;
+		smu->smu_table.user_od_feature_mask = 0;
 	} else if (smu->user_dpm_profile.user_od) {
 		memcpy(&user_od_table_bak,
 		       user_od_table,
@@ -2433,11 +2434,8 @@ static int smu_v14_0_2_restore_user_od_settings(struct smu_context *smu)
 	OverDriveTableExternal_t *user_od_table = table_context->user_overdrive_table;
 	int res;
 
-	user_od_table->OverDriveTable.FeatureCtrlMask = BIT(PP_OD_FEATURE_GFXCLK_BIT) |
-							BIT(PP_OD_FEATURE_UCLK_BIT) |
-							BIT(PP_OD_FEATURE_GFX_VF_CURVE_BIT) |
-							BIT(PP_OD_FEATURE_FAN_CURVE_BIT) |
-							BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
+	user_od_table->OverDriveTable.FeatureCtrlMask =
+		table_context->user_od_feature_mask;
 	res = smu_v14_0_2_upload_overdrive_table(smu, user_od_table);
 	user_od_table->OverDriveTable.FeatureCtrlMask = 0;
 	if (res == 0)
@@ -2522,7 +2520,6 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t offset_of_voltageoffset;
 	int32_t minimum, maximum;
-	uint32_t feature_ctrlmask;
 	int i, ret = 0;
 
 	switch (type) {
@@ -2811,21 +2808,26 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 			if (ret)
 				return ret;
 		} else {
-			feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
 			memcpy(od_table,
 		       table_context->boot_overdrive_table,
 		       sizeof(OverDriveTableExternal_t));
-			od_table->OverDriveTable.FeatureCtrlMask = feature_ctrlmask;
+			od_table->OverDriveTable.FeatureCtrlMask = 0;
+			table_context->user_od_feature_mask = 0;
 		}
 		fallthrough;
 	case PP_OD_COMMIT_DPM_TABLE:
 		/*
-		 * The member below instructs PMFW the settings focused in
-		 * this single operation.
-		 * `uint32_t FeatureCtrlMask;`
-		 * It does not contain actual informations about user's custom
-		 * settings. Thus we do not cache it.
+		 * PMFW interprets FeatureCtrlMask as the complete set of OD
+		 * features that are currently overridden, not as a delta
+		 * describing this single operation. Any feature whose bit is
+		 * clear gets reset to its default on import. od_table's mask
+		 * has accumulated every feature the user touched since the
+		 * last full restore, so record it and keep restating it on
+		 * subsequent uploads.
 		 */
+		table_context->user_od_feature_mask =
+			od_table->OverDriveTable.FeatureCtrlMask;
+
 		offset_of_voltageoffset = offsetof(OverDriveTable_t, VoltageOffsetPerZoneBoundary);
 		if (memcmp((u8 *)od_table + offset_of_voltageoffset,
 			   table_context->user_overdrive_table + offset_of_voltageoffset,
@@ -2838,7 +2840,6 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 				return ret;
 			}
 
-			od_table->OverDriveTable.FeatureCtrlMask = 0;
 			memcpy(table_context->user_overdrive_table + offset_of_voltageoffset,
 			       (u8 *)od_table + offset_of_voltageoffset,
 			       sizeof(OverDriveTableExternal_t) - offset_of_voltageoffset);
@@ -2882,7 +2883,10 @@ static int smu_v14_0_2_set_ppt_limit(struct smu_context *smu,
 
 		if (current_od_table.OverDriveTable.Ppt) {
 			od_table->OverDriveTable.Ppt = 0;
-			od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_PPT_BIT;
+			table_context->user_od_feature_mask &=
+				~(1U << PP_OD_FEATURE_PPT_BIT);
+			od_table->OverDriveTable.FeatureCtrlMask =
+				table_context->user_od_feature_mask;
 
 			ret = smu_v14_0_2_upload_overdrive_table(smu, od_table);
 			if (ret) {
@@ -2897,7 +2901,9 @@ static int smu_v14_0_2_set_ppt_limit(struct smu_context *smu,
 			return ret;
 
 		od_table->OverDriveTable.Ppt = (limit * 100) / msg_limit - 100;
-		od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_PPT_BIT;
+		table_context->user_od_feature_mask |= 1U << PP_OD_FEATURE_PPT_BIT;
+		od_table->OverDriveTable.FeatureCtrlMask =
+			table_context->user_od_feature_mask;
 
 		ret = smu_v14_0_2_upload_overdrive_table(smu, od_table);
 		if (ret) {
-- 
2.43.0

