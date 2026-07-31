Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7629CC55162
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 03:10:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3B7E10F12A;
	Fri, 31 Jul 2026 03:10:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="saD8UXIs";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010008.outbound.protection.outlook.com
 [40.93.198.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC53E10F12A
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 03:10:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhVJZi0GiTSqDfztrgGuyYyG7ThyX2fX0PvV5KgbuT3fYH+TsAYEjO7O4ke/Vs5cgF9WQYpEcgo0Zx/Vs023iy3+h2lF9y6GLPBFwzsofouFW2Ve+x/NUAQPLsqYSJiUjI9sAfZrG7o0HECuj/FdFOU3sT84UWFoyWyAxKsbTxC1w544JOsN878yyfAgooV7amjGFhvVqdMdFIsaiNCt6e1MEpQJaaq6X81n2llz0OhWij6M0kCbDPMs2CgP7RuF14OJDPDocJK1kzBqVJJBFLIXTXJUFVZp6M5GOadjtXuQCfWxpylnjpIe0Q81tS8SZos7KQG9gAZZIpdW8bHKIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2zP2lKZK+1sDX6xN/9XCEslfj+vgu4KcxJSOLX7KVo=;
 b=AZsRzfjurSOLEpiJof+tSpoIheBRrTkGdbBO5XNCkFRB/hAemEJ4AC3/IQlPbGGHm6ltVB8b7z60Wfl6SK/qv+V4TgAccuLk/Mh8oUTdeX4k+JtHjkZYe+2rRImGonnYR9IfH1ii8/ZcqpK4GYjt7Cjd56/mhOdzWBy2ODORT8opvQgvaIVmFvyhmVStvjea5sQTd9iaZRz1/bhhjWnhTulkHeQKyhQ5tiJsQTezlPdl878e376kvgRsAAYDg9ir0DWNsci/KnbOe3x2M1DQZ+aO8R/VW1QbYqAgqAcry9wpuDccgTDiOu0OA6W+TE8966/TNl0jL3ULmmUkP6FYQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2zP2lKZK+1sDX6xN/9XCEslfj+vgu4KcxJSOLX7KVo=;
 b=saD8UXIsbXBCpKUWnn1bpCYHeRblLG6T5U883HNCrInmdZt1xlWeZXTppvT2XkyI7nEVuqK3Wf6YdSgfVQk/fJwXRnQbsUDbu0gn7HHzwSDcGNfRVbQcE5a9u7r5JUhHasn9wT4+2aE9yrJxp8gvmuGZMBNmwgr1QWZ/RQoXH+U=
Received: from SJ0PR13CA0009.namprd13.prod.outlook.com (2603:10b6:a03:2c0::14)
 by LV3PR12MB9332.namprd12.prod.outlook.com (2603:10b6:408:20f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 03:10:39 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::af) by SJ0PR13CA0009.outlook.office365.com
 (2603:10b6:a03:2c0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.9 via Frontend Transport; Fri, 31
 Jul 2026 03:10:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 03:10:39 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 22:10:37 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 2/4] drm/amd/pm: account for OD percentage in effective PPT
 limits
Date: Fri, 31 Jul 2026 11:10:20 +0800
Message-ID: <bcb96d859a658124072dfdbfc00566ad821c527f.1785467079.git.kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785467079.git.kevinyang.wang@amd.com>
References: <cover.1785467079.git.kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|LV3PR12MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: be0c1d10-9025-4332-830b-08deeeb14cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qUptErBbauzh3TNyKQZKWnwuLQlFqckYBfcOPJCe0FXSrs9V8sF+RA5o9P9IfEmH0Y1jawW5JZPAMthYiUrl8TNMQJyGmTrPrqUQVGSC31C0CMqiiwdOTUIwhWoAxsYzKjXvLOHh5Fs7jlK9jZGuFpq3ZIMwpIocycWWJTDp2VZl8Qne46wq3vHXxTKOrnpS6YYj12OYmZdDXnZJvlgZDUI9r2jZxO2z+BOje0iWdTji9oEDK2Ik+v76TUqjIeGe9HBGpXkQO7oU6Qg2+y7MdvIlo6VV/fkyIdD3DHrFi/33WYc3C8BM8Tqh+5JFYGJ75BRXYnzv4L6NmZqByBEX/i4DFian64tyd28XmXm1UI/UCgREn2M47xPBuytddKBbEwL+vufNnfJLJq9q8TFzqWNkhE4k6XlGuOHbtkmizpnpsW/lBrKJ6yUqWhu/7PCeUhITzIm2N3EeVsfe455Bsbj4guyvCCgBDjmGGJu/7a8im6LLy4ip/hA+R1FT9M6R214rT1IVulVKIPBajRKsDsHvS00Hk/pfUPukcZR/HxXZuH1alx2P0KU/RDeVqfvvsWC/fXVH3+3YDCRBX0iISglTgSTJIKgJ+5pc5I+0l7T7TdCZjBAVL+WJqM+mlCvGlBQmEwpK18F0L3P1xdfJatsavnv6XZxM+huQQObWrSmjeGAL8t0Xbjl08TL8ip6ejmXytJBKi4HO7vVu5w5aew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: unkzj/jM1qbchVakbwkUe41GltJ6qESzS2JhjnEo1rcfSMv/pzZp7muKmQPfxYvKXgXizA9YukK24ZO8QFkCELo6248PNTypG0OuIZGHpTMwWkF1b0/lGx9VkkXVsXMBE/uwZZG7V6twCIZnqycWR4z+/xocctgtCklDBt/MiB4B/OEERHs8tDQ0zoRpybClYsJyf3wb44NLTtqKc3ruHs8c57ZbK+I8ATKPsMLTsXMraIW1BpqACNsi7Y/bWudRcf97Wpa1JVYdJNrt9UXWxUebd8d1gpRaCMhv3FTznqs1JqSGPcjl1IVLzXuQUJER0kUSspc3CikIOuNBbjLbxBksAdqK9wPV8UNi/5LW41kNZ5gbNXReakaLG9eIF9L+sM3yRMzWpDKQNZwjIa/M6TSqtsQid16C8AF3z50Us1CFqqfugJc6Veq2EV1xV+Xa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 03:10:39.5821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be0c1d10-9025-4332-830b-08deeeb14cbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9332
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

SMU 13.0.0, SMU 13.0.7, and SMU 14.0.2 represent limits above the
message limit as a base value plus an overdrive percentage. GetPptLimit
returns only the base, which causes two incorrect results:

- hwmon reports the message limit instead of the effective limit.
- Lowering the cap can leave the previous OD percentage active.

Export the active overdrive table from PMFW and combine its PPT
percentage with the message result. Use the exported percentage to clear
OD state before programming a limit within the message range.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 35 +++++++++++-------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 35 +++++++++++-------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 37 ++++++++++++-------
 3 files changed, 65 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 95257d5378b8..81b7c2de45ae 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2394,17 +2394,23 @@ static int smu_v13_0_0_get_ppt_limit(struct smu_context *smu,
 				     enum smu_ppt_limit_type limit_type,
 				     uint32_t *ppt_limit)
 {
-	PPTable_t *pptable = smu->smu_table.driver_pptable;
-	SkuTable_t *skutable = &pptable->SkuTable;
-	uint32_t pp_limit = smu->adev->pm.ac_power ?
-		skutable->SocketPowerLimitAc[PPT_THROTTLER_PPT0] :
-		skutable->SocketPowerLimitDc[PPT_THROTTLER_PPT0];
+	OverDriveTableExternal_t od_table;
+	int ret;
 
 	if (limit_type != SMU_PPT_LIMIT_PPT0)
 		return -EOPNOTSUPP;
 
-	if (smu_v13_0_get_ppt_limit(smu, limit_type, ppt_limit))
-		*ppt_limit = pp_limit;
+	ret = smu_v13_0_get_ppt_limit(smu, limit_type, ppt_limit);
+	if (ret)
+		return ret;
+
+	ret = smu_v13_0_0_get_overdrive_table(smu, &od_table);
+	if (ret)
+		return ret;
+
+	if (od_table.OverDriveTable.Ppt > 0)
+		*ppt_limit = *ppt_limit *
+			(100 + od_table.OverDriveTable.Ppt) / 100;
 
 	return 0;
 }
@@ -3045,22 +3051,23 @@ static int smu_v13_0_0_set_ppt_limit(struct smu_context *smu,
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	SkuTable_t *skutable = &pptable->SkuTable;
-	uint32_t msg_limit = skutable->MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
+	uint32_t msg_limit = skutable->MsgLimits.Power
+		[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
 	struct smu_table_context *table_context = &smu->smu_table;
 	OverDriveTableExternal_t *od_table =
 		(OverDriveTableExternal_t *)table_context->overdrive_table;
-	uint32_t current_limit;
+	OverDriveTableExternal_t current_od_table;
 	int ret = 0;
 
 	if (limit_type != SMU_PPT_LIMIT_PPT0)
 		return -EINVAL;
 
-	ret = smu_v13_0_0_get_ppt_limit(smu, limit_type, &current_limit);
-	if (ret)
-		return ret;
-
 	if (limit <= msg_limit) {
-		if (current_limit > msg_limit) {
+		ret = smu_v13_0_0_get_overdrive_table(smu, &current_od_table);
+		if (ret)
+			return ret;
+
+		if (current_od_table.OverDriveTable.Ppt) {
 			od_table->OverDriveTable.Ppt = 0;
 			od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_PPT_BIT;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 6e0a27eec610..b94ae43586df 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2376,17 +2376,23 @@ static int smu_v13_0_7_get_ppt_limit(struct smu_context *smu,
 				     enum smu_ppt_limit_type limit_type,
 				     uint32_t *ppt_limit)
 {
-	PPTable_t *pptable = smu->smu_table.driver_pptable;
-	SkuTable_t *skutable = &pptable->SkuTable;
-	uint32_t pp_limit = smu->adev->pm.ac_power ?
-		skutable->SocketPowerLimitAc[PPT_THROTTLER_PPT0] :
-		skutable->SocketPowerLimitDc[PPT_THROTTLER_PPT0];
+	OverDriveTableExternal_t od_table;
+	int ret;
 
 	if (limit_type != SMU_PPT_LIMIT_PPT0)
 		return -EOPNOTSUPP;
 
-	if (smu_v13_0_get_ppt_limit(smu, limit_type, ppt_limit))
-		*ppt_limit = pp_limit;
+	ret = smu_v13_0_get_ppt_limit(smu, limit_type, ppt_limit);
+	if (ret)
+		return ret;
+
+	ret = smu_v13_0_7_get_overdrive_table(smu, &od_table);
+	if (ret)
+		return ret;
+
+	if (od_table.OverDriveTable.Ppt > 0)
+		*ppt_limit = *ppt_limit *
+			(100 + od_table.OverDriveTable.Ppt) / 100;
 
 	return 0;
 }
@@ -2665,22 +2671,23 @@ static int smu_v13_0_7_set_ppt_limit(struct smu_context *smu,
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	SkuTable_t *skutable = &pptable->SkuTable;
-	uint32_t msg_limit = skutable->MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
+	uint32_t msg_limit = skutable->MsgLimits.Power
+		[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
 	struct smu_table_context *table_context = &smu->smu_table;
 	OverDriveTableExternal_t *od_table =
 		(OverDriveTableExternal_t *)table_context->overdrive_table;
-	uint32_t current_limit;
+	OverDriveTableExternal_t current_od_table;
 	int ret = 0;
 
 	if (limit_type != SMU_PPT_LIMIT_PPT0)
 		return -EINVAL;
 
-	ret = smu_v13_0_7_get_ppt_limit(smu, limit_type, &current_limit);
-	if (ret)
-		return ret;
-
 	if (limit <= msg_limit) {
-		if (current_limit > msg_limit) {
+		ret = smu_v13_0_7_get_overdrive_table(smu, &current_od_table);
+		if (ret)
+			return ret;
+
+		if (current_od_table.OverDriveTable.Ppt) {
 			od_table->OverDriveTable.Ppt = 0;
 			od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_PPT_BIT;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index f54780e9dba2..4d8faff364c3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -60,6 +60,8 @@ static void smu_v14_0_2_get_od_setting_limits(struct smu_context *smu,
 					      int od_feature_bit,
 					      int32_t *min, int32_t *max);
 static int smu_v14_0_2_init_ppt_limits(struct smu_context *smu);
+static int smu_v14_0_2_get_overdrive_table(struct smu_context *smu,
+					   OverDriveTableExternal_t *od_table);
 
 static const struct smu_feature_bits smu_v14_0_2_dpm_features = {
 	.bits = { SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
@@ -1615,17 +1617,23 @@ static int smu_v14_0_2_get_ppt_limit(struct smu_context *smu,
 				     enum smu_ppt_limit_type limit_type,
 				     uint32_t *ppt_limit)
 {
-	PPTable_t *pptable = smu->smu_table.driver_pptable;
-	CustomSkuTable_t *skutable = &pptable->CustomSkuTable;
-	uint32_t pp_limit = smu->adev->pm.ac_power ?
-		skutable->SocketPowerLimitAc[PPT_THROTTLER_PPT0] :
-		skutable->SocketPowerLimitDc[PPT_THROTTLER_PPT0];
+	OverDriveTableExternal_t od_table;
+	int ret;
 
 	if (limit_type != SMU_PPT_LIMIT_PPT0)
 		return -EOPNOTSUPP;
 
-	if (smu_v14_0_get_ppt_limit(smu, limit_type, ppt_limit))
-		*ppt_limit = pp_limit;
+	ret = smu_v14_0_get_ppt_limit(smu, limit_type, ppt_limit);
+	if (ret)
+		return ret;
+
+	ret = smu_v14_0_2_get_overdrive_table(smu, &od_table);
+	if (ret)
+		return ret;
+
+	if (od_table.OverDriveTable.Ppt > 0)
+		*ppt_limit = *ppt_limit *
+			(100 + od_table.OverDriveTable.Ppt) / 100;
 
 	return 0;
 }
@@ -2800,22 +2808,23 @@ static int smu_v14_0_2_set_ppt_limit(struct smu_context *smu,
 				     uint32_t limit)
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
-	uint32_t msg_limit = pptable->SkuTable.MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
+	uint32_t msg_limit = pptable->SkuTable.MsgLimits.Power
+		[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
 	struct smu_table_context *table_context = &smu->smu_table;
 	OverDriveTableExternal_t *od_table =
 		(OverDriveTableExternal_t *)table_context->overdrive_table;
-	uint32_t current_limit;
+	OverDriveTableExternal_t current_od_table;
 	int ret = 0;
 
 	if (limit_type != SMU_PPT_LIMIT_PPT0)
 		return -EINVAL;
 
-	ret = smu_v14_0_2_get_ppt_limit(smu, limit_type, &current_limit);
-	if (ret)
-		return ret;
-
 	if (limit <= msg_limit) {
-		if (current_limit > msg_limit) {
+		ret = smu_v14_0_2_get_overdrive_table(smu, &current_od_table);
+		if (ret)
+			return ret;
+
+		if (current_od_table.OverDriveTable.Ppt) {
 			od_table->OverDriveTable.Ppt = 0;
 			od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_PPT_BIT;
 
-- 
2.54.0

