Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CCBC54E4A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Mar 2024 09:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D90510F928;
	Fri,  8 Mar 2024 09:52:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="maw1bzwX";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7850910F928
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Mar 2024 09:52:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMQ7/ASE3V9omBthBJhoG0aGIi+NmisY2d0YA2E7ftJOTNbN0Gdl3GRpkLJwabtXcTRdpMK2n1IsH/LZ8SvCxqPKK9H2PmXy4Gz65ravgHsbdJJiw2Ak2tz4B2wLYRPxP72GlC2SXxyRI0Pc2kLxIVnkqxexurM5sjNmpa4pp5RvVjhYVFWo2YqGu7N8BzXAC3VORvyihV4jLKLlslGGmgMgo7KPHVx+Kc5k9UZsVNM84u0YM+kh67RIcf9WwuBvuDNYqF+61HuUVZKH4+Z6p7qqQadjAQ3H92fyAsCKH2loSOiwpFttY6yTua07jzZHWv305JnxmEQ5bQ56Q/Z9Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjsJ/gAwWlCWHBQwDoh8uuovHY5attNrDHNgjdmINJI=;
 b=nxCG0Wri1eRtfSHpDkdFLGrPbZu9WUQ/gexQhfSMV1W9DYiD3cz3MRbTVkFzQbqtL+XxIMSdydd+6xEi/PmIpPkaTgeVAJim/LZJ7XjbJDXOfCRp29at8dd8Ta3DfSX6xjghkRYpawvrcMRSFLVvyhWhggoSy5LUjyVN19JFIz6r9V7nJR80Onjgo3T8vy5ZFxlQjbTU8daG9Pz8vyjYLREQ0TAlcS+N2nW6GdLGkd6CKmMMCoQiMt9Ly/Nq9oL9dsHXA5FwUToBweYto8riX2lEJYcCDEA3zn5xnSqyXEee9uCelYMml2WVSJb5zMw6Du8dQZBaZd4z9h4te/KlKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjsJ/gAwWlCWHBQwDoh8uuovHY5attNrDHNgjdmINJI=;
 b=maw1bzwXj/VlkfXEigQV8CGAh0DPd2kL0vDelFfku80DDai0opJ86qg2tApi9lqOHQe2demDD4ytMIpHb5qozneOI0/FwRsce+QnHFBGBBAWh7TjH6ZAiEbARxCBkdd+EVu0iraDvp6J8fpxscfse6Oi8r5tVPHWR0QA/4VPXIU=
Received: from PH8PR15CA0020.namprd15.prod.outlook.com (2603:10b6:510:2d2::20)
 by LV2PR12MB5870.namprd12.prod.outlook.com (2603:10b6:408:175::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 09:51:57 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::68) by PH8PR15CA0020.outlook.office365.com
 (2603:10b6:510:2d2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29 via Frontend
 Transport; Fri, 8 Mar 2024 09:51:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 09:51:56 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 8 Mar
 2024 03:51:54 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 "Yin Zhenguo" <zhenguo.yin@amd.com>
Subject: [PATCH v2] drm/amdgpu/pm: Fix NULL pointer dereference when get power
 limit
Date: Fri, 8 Mar 2024 17:51:40 +0800
Message-ID: <20240308095140.2221137-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|LV2PR12MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: 54cef2bf-fecc-4bf9-892f-08dc3f556447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ONAIKv9y5SnCeHBtW8XaEaAEcuJtTp3SCV2BfAhYZud0ow9QKvadnLOF65iccM9d+3JJ0p5PCzYxcUfxjLQne1zk4SmIZBknT036539Z4NuYqR4L9z0QX8jiTt+EhaBpdGGrrgBEzIZiYuWe0+SKvhelps11QDYRIrjpsMmpXCvGEDO4X2s4uVq4zj4P16rJc4aGMsw8JX2PoaldqChH8cQxsh/t/fjbSSgRmxy+bOs09uvhwURXZ6QYLCUjjbOdpwOzoJAAvFoUlo6ZZ+cHrkhP8MWidQME0ykScPmBnRFGIQJ6os+Rdl6fmp/ml/yo2Hgr9WRs/qSVeTy9MvPAUhp3I5Risc1PsRMEtIgFY0mvf0HDj3oZAhPaJNqTtZxkK2J1i1pJKFiNooWsijX2hW2N0pzVPc4QgsmyCQSy9FvtYiRZKq1AUzuMe14seLZTUIlb1X0fcU8dU+9YEOCt0u+lPkWDnhDDhdz5i7yzla6yHgLVLUBv9o0am78UX5aDyHdggFrLpih+fi64iIFUFyOQni53VaEqqRq6t43wkoqk0D7eDeUlKL3x9sjCUBeSomsT256afnanmyLzD3vlg0C6dYCo6NB8XudUU1GxMxj5HTNFc+JNOKgUegReV2zA2UdoGp1HS3sKuIL5SRScco6OqGfrIb1Fy8sC3dQSEHXEIvfKtwyM73oB+3/isGwLhsX6yUFdLRqSQ6QLXBwwszcRs7mKdzWFKLNMSXs2YX09mPEugAGp8EZHFFYGGRlt
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 09:51:56.6322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cef2bf-fecc-4bf9-892f-08dc3f556447
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5870
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
sriov case, We set default lower and upper OD value to
avoid NULL pointer issue.

Also, It's necessary to check od capability before
using the power limit value from powerplay_table.

Fixes: 7968e9748fbb ("drm/amdgpu/pm: Fix the power1_min_cap value")
Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reported-by: Yin Zhenguo <zhenguo.yin@amd.com>
---
v1->v2: Check the od capability (Alex, Lijo)
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 18 ++++++-----
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 18 ++++++-----
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 30 +++++++++++--------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 22 +++++++++-----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 22 +++++++++-----
 5 files changed, 68 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 1d96eb274d72..862d5d198f42 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1285,8 +1285,9 @@ static int arcturus_get_power_limit(struct smu_context *smu,
 {
 	struct smu_11_0_powerplay_table *powerplay_table =
 		(struct smu_11_0_powerplay_table *)smu->smu_table.power_play_table;
+	struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
-	uint32_t power_limit, od_percent_upper, od_percent_lower;
+	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 10;
 
 	if (smu_v11_0_get_current_power_limit(smu, &power_limit)) {
 		/* the last hope to figure out the ppt limit */
@@ -1303,12 +1304,15 @@ static int arcturus_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (smu->od_enabled)
-		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
-	else
-		od_percent_upper = 0;
-
-	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+	if (powerplay_table) {
+		if (smu->od_enabled) {
+			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+		} else if (od_settings->cap[SMU_11_0_ODCAP_POWER_LIMIT]) {
+			od_percent_upper = 0;
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+		}
+	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
 							od_percent_upper, od_percent_lower, power_limit);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index ed189a3878eb..fe8d24a7d319 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2339,7 +2339,7 @@ static int navi10_get_power_limit(struct smu_context *smu,
 		(struct smu_11_0_powerplay_table *)smu->smu_table.power_play_table;
 	struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
-	uint32_t power_limit, od_percent_upper, od_percent_lower;
+	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 10;
 
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
-
-	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+	if (powerplay_table) {
+		if (smu->od_enabled) {
+			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+		} else if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT)) {
+			od_percent_upper = 0;
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+		}
+	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
 					od_percent_upper, od_percent_lower, power_limit);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index a405424dd699..c86e13f6b6c5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -617,6 +617,12 @@ static uint32_t sienna_cichlid_get_throttler_status_locked(struct smu_context *s
 	return throttler_status;
 }
 
+static bool sienna_cichlid_is_od_feature_supported(struct smu_11_0_7_overdrive_table *od_table,
+						   enum SMU_11_0_7_ODFEATURE_CAP cap)
+{
+	return od_table->cap[cap];
+}
+
 static int sienna_cichlid_get_power_limit(struct smu_context *smu,
 					  uint32_t *current_power_limit,
 					  uint32_t *default_power_limit,
@@ -625,7 +631,8 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu,
 {
 	struct smu_11_0_7_powerplay_table *powerplay_table =
 		(struct smu_11_0_7_powerplay_table *)smu->smu_table.power_play_table;
-	uint32_t power_limit, od_percent_upper, od_percent_lower;
+	struct smu_11_0_7_overdrive_table *od_settings = smu->od_settings;
+	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 10;
 	uint16_t *table_member;
 
 	GET_PPTABLE_MEMBER(SocketPowerLimitAc, &table_member);
@@ -640,12 +647,15 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (smu->od_enabled)
-		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
-	else
-		od_percent_upper = 0;
-
-	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
+	if (powerplay_table) {
+		if (smu->od_enabled) {
+			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
+		} else if (sienna_cichlid_is_od_feature_supported(od_settings, SMU_11_0_7_ODCAP_POWER_LIMIT)) {
+			od_percent_upper = 0;
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
+		}
+	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
 					od_percent_upper, od_percent_lower, power_limit);
@@ -1250,12 +1260,6 @@ static bool sienna_cichlid_is_support_fine_grained_dpm(struct smu_context *smu,
 	return dpm_desc->SnapToDiscrete == 0;
 }
 
-static bool sienna_cichlid_is_od_feature_supported(struct smu_11_0_7_overdrive_table *od_table,
-						   enum SMU_11_0_7_ODFEATURE_CAP cap)
-{
-	return od_table->cap[cap];
-}
-
 static void sienna_cichlid_get_od_setting_range(struct smu_11_0_7_overdrive_table *od_table,
 						enum SMU_11_0_7_ODSETTING_ID setting,
 						uint32_t *min, uint32_t *max)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 6a501d2661f5..e17f93ba861e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2356,8 +2356,12 @@ static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
 		(struct smu_13_0_0_powerplay_table *)table_context->power_play_table;
 	PPTable_t *pptable = table_context->driver_pptable;
 	SkuTable_t *skutable = &pptable->SkuTable;
-	uint32_t power_limit, od_percent_upper, od_percent_lower;
 	uint32_t msg_limit = skutable->MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
+	const OverDriveLimits_t * const overdrive_upperlimits =
+						&pptable->SkuTable.OverDriveLimitsBasicMax;
+	const OverDriveLimits_t * const overdrive_lowerlimits =
+						&pptable->SkuTable.OverDriveLimitsMin;
+	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 10;
 
 	if (smu_v13_0_get_current_power_limit(smu, &power_limit))
 		power_limit = smu->adev->pm.ac_power ?
@@ -2369,12 +2373,16 @@ static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (smu->od_enabled)
-		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
-	else
-		od_percent_upper = 0;
-
-	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
+	if (powerplay_table) {
+		if (smu->od_enabled) {
+			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
+		} else if (overdrive_lowerlimits->FeatureCtrlMask &&
+					overdrive_upperlimits->FeatureCtrlMask) {
+			od_percent_upper = 0;
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
+		}
+	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
 					od_percent_upper, od_percent_lower, power_limit);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 3dc7b60cb075..684cb5a7ef6c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2320,8 +2320,12 @@ static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
 		(struct smu_13_0_7_powerplay_table *)table_context->power_play_table;
 	PPTable_t *pptable = table_context->driver_pptable;
 	SkuTable_t *skutable = &pptable->SkuTable;
-	uint32_t power_limit, od_percent_upper, od_percent_lower;
 	uint32_t msg_limit = skutable->MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
+	const OverDriveLimits_t * const overdrive_upperlimits =
+						&pptable->SkuTable.OverDriveLimitsBasicMax;
+	const OverDriveLimits_t * const overdrive_lowerlimits =
+						&pptable->SkuTable.OverDriveLimitsMin;
+	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 10;
 
 	if (smu_v13_0_get_current_power_limit(smu, &power_limit))
 		power_limit = smu->adev->pm.ac_power ?
@@ -2333,12 +2337,16 @@ static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (smu->od_enabled)
-		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
-	else
-		od_percent_upper = 0;
-
-	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
+	if (powerplay_table) {
+		if (smu->od_enabled) {
+			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
+		} else if (overdrive_lowerlimits->FeatureCtrlMask &&
+					overdrive_upperlimits->FeatureCtrlMask) {
+			od_percent_upper = 0;
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
+		}
+	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
 					od_percent_upper, od_percent_lower, power_limit);
-- 
2.34.1

