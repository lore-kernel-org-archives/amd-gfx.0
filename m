Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B814C54E58
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 10:59:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C79710F2D3;
	Wed, 13 Mar 2024 10:59:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m5hDW4/a";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B57B10F3A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 10:59:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YewmvOs5I2FXk85k9D7vPRWX2/JEpAQ5WEaR2hZmbCwOjVoML7uRsRoKaZvgXoHEkkaCsGk/bYB//Yx4FYZD34OXe+vEBDepKxsIOvs5wUZMm6RAYbJH9zDKc3+0OPaa6jcAF3PfI5NSw/oxkU4wwPHkmeaR512Kt0UrMBcrX8+FjPzW+k+qFaur/rruzZP6BdvWMEKiB5TF0Copcov3NKHM6qiqaVWQKoctbY8ZULbeaI8a/ezs0wnxYsgCd5rXWA9M2R1X0MNf2/ZQtb3ShcgiXnDlzFmeyOWaO/7MWEbKAoX1P81I372PWTHGjN1uXZsRT9H03gu+iFXPZHkYAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vI2vldZpQj0XspA/ygtjv4IF+xGrisc8F2RVrBxbLyQ=;
 b=QTUsei3ahSXpYI/3J7KdqUrn9b6CgVmmdXKo+Zh1/8uBP0VGVyLDgwTJtK1LndRsWZPWdOGEE6GqMBV9AhFqsJH0fqq0MZC+nhnzV3bcUaTXpxD4MaRQ1XMZYqRw1k7Mk+w6uNbFDSuaqJ5ryEJ1CZfgXhP8F/EGzqkxjJ+1WQJkk78kIRkOHireu1TatAaxnjkKV2CYn8PGnOfLps8Lj0Ouycgkxt1yqgN5EEdnuSKKtk5ok0OfR8uBEADzQUJwuZObuo+ISI6IbwZd2DiY0XhI/cu8/yEzh7HvrHbBfnsx2xCb6kfSSwaQC5HaCtXo1qD2hot6wkmnZnj6UfgnVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vI2vldZpQj0XspA/ygtjv4IF+xGrisc8F2RVrBxbLyQ=;
 b=m5hDW4/abRr7wGSp/nUFXXDrORf8Rm6bjb+f2L8r7ciN6HYf06fkY/MN+P7NA4MWG3tOIEYPXn/eNowMbq6ttkAJ4H8LB9yVmbGCDESBKhqcSbWQjYD2qEsT1PEezWiHAIo88oa4v60CwHAEc97J/NYGsn96CtYGqSdWfg9AA3Y=
Received: from MN2PR22CA0030.namprd22.prod.outlook.com (2603:10b6:208:238::35)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 10:59:55 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::dd) by MN2PR22CA0030.outlook.office365.com
 (2603:10b6:208:238::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19 via Frontend
 Transport; Wed, 13 Mar 2024 10:59:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 10:59:54 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Mar
 2024 05:59:52 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, Ma Jun <Jun.Ma2@amd.com>, Yin Zhenguo
 <zhenguo.yin@amd.com>, Lazar Lijo <lijo.lazar@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/pm: Fix NULL pointer dereference when get
 power limit
Date: Wed, 13 Mar 2024 18:59:33 +0800
Message-ID: <20240313105934.2362429-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|MN2PR12MB4376:EE_
X-MS-Office365-Filtering-Correlation-Id: 0513baf0-91dd-4d21-e586-08dc434cb72f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2wTZMWwD8685KxMM8y6wntRLq+uYuMs+GVHlAZNcwUpPAzHnjwULx3PRG3lPvNm7Z9hv/T791faozndS9iOtnLWxv//Wy2qtrmAcPpRqs9WRp0ZG/D6HGlHpJvn9UZQL5ciTew3L9HH/x43F73lLzu5Q1GpCMg6e8/ynYptDQxbT8AlFW/Pd9QTcY4466SSFLcMbrSgBezv2VIs6zjCNwl0KCV6+OJOC9bvtLzgR3ZNFzm3AK9Mqfu1rNJUJ1LTYt2yEhlhfl2GwVkIr4nWINHdpgWjoPSyauc2pOmPn63MD3A7gnbMQxKJWVPYMXmqeHs8j5t0h0ZxEhLz4JRxkpfYhrIO+f6iafKc9XHMgyiynt8xxDc8sTFr0m/j6EQaOLGRl3IeguCkEdZjTutbNq/IQ0tuFJszJewWIpDrlE7RHne/9Tke0V99BBxX2bR3C8Z7pFXOqMp7WOozL8t2OkWMqT7PJNnZbQ9FwNf8Xz+XcwNzrlahHwHJhcQQ5FgekexxSN5hyGoLEHEhcohk524ZQBp1nAQ3Z9JHQWIvWyRskglM9Q8BoyOW5iOerEH/uWIZf1wdisENTCM3RNlqKXCwGlzd0FdwpiU/HmlQ9zGwYfAfnWaaWAjVL6Ak5jVHXWGOP9lu9h2OfsrNCOtZhxyEFiEl6hLDObAt5GDPnz9pRHIbGSiRJ3N3y5uQNSFnDQJLf+9diPf2Wjyc5EQO6F1ViKuzv3AT44qCttSXaZeHDVEASzqnMmMEaTit2W6f
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:59:54.9400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0513baf0-91dd-4d21-e586-08dc434cb72f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
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

Because powerplay_table initialization is skipped under
sriov case, We check and set default lower and upper OD
value if powerplay_table is NULL.

Fixes: 7968e9748fbb ("drm/amdgpu/pm: Fix the power1_min_cap value")
Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reported-by: Yin Zhenguo <zhenguo.yin@amd.com>
Suggested-by: Lazar Lijo <lijo.lazar@amd.com>
Suggested-by: Alex Deucher <Alexander.Deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c    | 14 ++++++++------
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c  | 16 +++++++++-------
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 14 ++++++++------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 14 ++++++++------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 14 ++++++++------
 5 files changed, 41 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 1d96eb274d72..a406372e79d8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1286,7 +1286,7 @@ static int arcturus_get_power_limit(struct smu_context *smu,
 	struct smu_11_0_powerplay_table *powerplay_table =
 		(struct smu_11_0_powerplay_table *)smu->smu_table.power_play_table;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
-	uint32_t power_limit, od_percent_upper, od_percent_lower;
+	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 0;
 
 	if (smu_v11_0_get_current_power_limit(smu, &power_limit)) {
 		/* the last hope to figure out the ppt limit */
@@ -1303,12 +1303,14 @@ static int arcturus_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (smu->od_enabled)
-		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
-	else
-		od_percent_upper = 0;
+	if (powerplay_table) {
+		if (smu->od_enabled)
+			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+		else
+			od_percent_upper = 0;
 
-	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
 							od_percent_upper, od_percent_lower, power_limit);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index ed189a3878eb..65bba5fc2335 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2339,7 +2339,7 @@ static int navi10_get_power_limit(struct smu_context *smu,
 		(struct smu_11_0_powerplay_table *)smu->smu_table.power_play_table;
 	struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
-	uint32_t power_limit, od_percent_upper, od_percent_lower;
+	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 0;
 
 	if (smu_v11_0_get_current_power_limit(smu, &power_limit)) {
 		/* the last hope to figure out the ppt limit */
@@ -2356,13 +2356,15 @@ static int navi10_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (smu->od_enabled &&
-		    navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT))
-		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
-	else
-		od_percent_upper = 0;
+	if (powerplay_table) {
+		if (smu->od_enabled &&
+			    navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT))
+			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+		else
+			od_percent_upper = 0;
 
-	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
 					od_percent_upper, od_percent_lower, power_limit);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index a405424dd699..9371e6e79c56 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -625,7 +625,7 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu,
 {
 	struct smu_11_0_7_powerplay_table *powerplay_table =
 		(struct smu_11_0_7_powerplay_table *)smu->smu_table.power_play_table;
-	uint32_t power_limit, od_percent_upper, od_percent_lower;
+	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 0;
 	uint16_t *table_member;
 
 	GET_PPTABLE_MEMBER(SocketPowerLimitAc, &table_member);
@@ -640,12 +640,14 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (smu->od_enabled)
-		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
-	else
-		od_percent_upper = 0;
+	if (powerplay_table) {
+		if (smu->od_enabled)
+			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
+		else
+			od_percent_upper = 0;
 
-	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
+		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
+	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
 					od_percent_upper, od_percent_lower, power_limit);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 6a501d2661f5..f1e388c2863a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2356,7 +2356,7 @@ static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
 		(struct smu_13_0_0_powerplay_table *)table_context->power_play_table;
 	PPTable_t *pptable = table_context->driver_pptable;
 	SkuTable_t *skutable = &pptable->SkuTable;
-	uint32_t power_limit, od_percent_upper, od_percent_lower;
+	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 0;
 	uint32_t msg_limit = skutable->MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
 
 	if (smu_v13_0_get_current_power_limit(smu, &power_limit))
@@ -2369,12 +2369,14 @@ static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (smu->od_enabled)
-		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
-	else
-		od_percent_upper = 0;
+	if (powerplay_table) {
+		if (smu->od_enabled)
+			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
+		else
+			od_percent_upper = 0;
 
-	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
+		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
+	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
 					od_percent_upper, od_percent_lower, power_limit);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 3dc7b60cb075..8abf0a772e6b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2320,7 +2320,7 @@ static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
 		(struct smu_13_0_7_powerplay_table *)table_context->power_play_table;
 	PPTable_t *pptable = table_context->driver_pptable;
 	SkuTable_t *skutable = &pptable->SkuTable;
-	uint32_t power_limit, od_percent_upper, od_percent_lower;
+	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 0;
 	uint32_t msg_limit = skutable->MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
 
 	if (smu_v13_0_get_current_power_limit(smu, &power_limit))
@@ -2333,12 +2333,14 @@ static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (smu->od_enabled)
-		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
-	else
-		od_percent_upper = 0;
+	if (powerplay_table) {
+		if (smu->od_enabled)
+			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
+		else
+			od_percent_upper = 0;
 
-	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
+		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
+	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
 					od_percent_upper, od_percent_lower, power_limit);
-- 
2.34.1

