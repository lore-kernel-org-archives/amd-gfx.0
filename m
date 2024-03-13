Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F0AC54E58
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 11:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9968610F3F7;
	Wed, 13 Mar 2024 11:00:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cHvWqpw/";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8C7E10F2D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 10:59:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSVH3Do/Cp+fV3bxRgNwcFzCz68dC5cGJX5GdhVGrl4iBfLO5loodQw2JTkgTODWIEcSeW1PVQM4YYdj6GJ34LqHrLStMTUuOCDLIQQ4JnHJldW95S8GHFqTQLoPoYGBneTIVmmLQFmMQgx31bmYFk2rooT5tBrhJ2ptDgUNFLAiLO3eLIocLH38CX9szw4RJ4Cp1tFICBqZK3s3+unGTi4b43wm0Lqn0Dpqg99Sx4SsTO1O22JM1ysP+dymp0EXo+8qJuRSyD6qDXKURtsHr05J7J4+xBi56h24jnja+EvN/xBVUAZOUFb3JQ3XEgJ9uGXxRKIzZlaQEdwvv43e1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mykDyuiPqDJd7ox1JHEqFWTnAaQZgn1/x9utpBlnY0M=;
 b=NU5eBDEOxoBWK79gt8XhMAlzJRBkmCV+fjTXtmKWtweyjK76TKSgsC08D5aZ5pUbbc9WktP9XukDQ2fKMpEOaT5Hxezeleco25qIqAB3A//1UctIUOmJPZ5E+5xX8IWbi7iWNqMrwEqM7upNC4YJ7NRy0sbnVPyh8EZ/tlLhFIV6oerlt4cVV3rs/BAgnObPZolxKeqlEgEwaMzV1dzaFwP2tGirm5j1fhuRpZlgdK2ofesjOdGLovoLD5QqxC2162K540P8UJE4gWMd2jiAMoTSP80DK4nJ+UP0w/+PVWbOYvO2ny3bp+gB7VZcosX8F+WVVmhcxxf8HZ1dSvuRcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mykDyuiPqDJd7ox1JHEqFWTnAaQZgn1/x9utpBlnY0M=;
 b=cHvWqpw/rqPHywLdLM/yWYq5dwNYpUCE/HH/7jwjRHd7ZqByaQcJC1Heh5kCQA/CfGYaAehCZvqKOUD9FbzKppAWZ4nR2UjHWmxCfVa9UbPI42OwBYMfzJmEYILkKtv6O/fBWaA4xrYYTqUae+zgJ61NdoUla6NFtruQ+oNBbRc=
Received: from BL0PR05CA0026.namprd05.prod.outlook.com (2603:10b6:208:91::36)
 by SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 10:59:57 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::fc) by BL0PR05CA0026.outlook.office365.com
 (2603:10b6:208:91::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19 via Frontend
 Transport; Wed, 13 Mar 2024 10:59:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 10:59:56 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Mar
 2024 05:59:54 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, Ma Jun <Jun.Ma2@amd.com>, Lazar Lijo
 <lijo.lazar@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/pm: Check the validity of overdiver power limit
Date: Wed, 13 Mar 2024 18:59:34 +0800
Message-ID: <20240313105934.2362429-2-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313105934.2362429-1-Jun.Ma2@amd.com>
References: <20240313105934.2362429-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|SN7PR12MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 28084eb0-ec65-4f6f-04e3-08dc434cb86a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RsGjxCFlx1o/ESUXVaVAZQ0xM2pr0AHgkvr9jMm8+CiUz1+MiFsEQojfwDgzO1idWaPy4vol1sjt7w8t1S+b1zriaC3v0hE81UUB0Amvy0t82VzBdEyU3WpWxWri2aThG17stdGezfTMyuRKSYe8Tnk0BL1SMG232jzkzKJPP49fzD35IfBr/ul9j/y3sQWlAlmEq/0NO3folk6s4x/krGf9SUkphx+PtNjL+ZaWA3pv+M/qRfFpGggsOdciUpS18AwmtC4dyjVnIaoXmscWx/qGN0aDmR6SgWDtkoZXXLH2C4WaAaN3+M0JCrG+3VZ1USZqhEFo3U9Bz85PbL8pfKN3yilX39LQkFSjXKfMdpKfKKz9b4XoNmgyjDxJM1wtb360bVraBBSnuhM5yf2Ps38eFpINXTFH+W+88GwyRdHAEgnf/QytBSuBYk+v6m+W2f5T3G7In7UOnezxL53a/UEK1r7hyj4Dki6W/23K5fthapyYeohUMN7QEGSqqM5GShxThvaCkOXj0dJV/6lo17YFTr7BRkZX4nVq+7MUIULOARRZXOAxum4E8rHQ+n7Z/2VmzWJbUEIpzbpchRBGBhFD6h45JNVGghrdpQc//XJvOYXpdgJITOLYiZdzo9C8f1N5bhUhFBDtkv2y+MfWpzKH6SZpSBXZXvEHWPdTJNh2E+V56IiuuRuwgp2zPMP5O3o4UCTXBc+C1uchwQbH6uij6I8LhcQvpCLSUHISvDtKWUxI1BnphBepalipIsH+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:59:56.9830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28084eb0-ec65-4f6f-04e3-08dc434cb86a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7324
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

Check the validity of overdriver power limit before using it.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Suggested-by: Lazar Lijo <lijo.lazar@amd.com>
Suggested-by: Alex Deucher <Alexander.Deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 11 +++++----
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  9 ++++----
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 23 +++++++++++--------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 10 ++++----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 10 ++++----
 5 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index a406372e79d8..40ba7227cca5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1285,6 +1285,7 @@ static int arcturus_get_power_limit(struct smu_context *smu,
 {
 	struct smu_11_0_powerplay_table *powerplay_table =
 		(struct smu_11_0_powerplay_table *)smu->smu_table.power_play_table;
+	struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 0;
 
@@ -1304,12 +1305,14 @@ static int arcturus_get_power_limit(struct smu_context *smu,
 		*default_power_limit = power_limit;
 
 	if (powerplay_table) {
-		if (smu->od_enabled)
+		if (smu->od_enabled &&
+				od_settings->cap[SMU_11_0_ODCAP_POWER_LIMIT]) {
 			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
-		else
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+		} else if (od_settings->cap[SMU_11_0_ODCAP_POWER_LIMIT]) {
 			od_percent_upper = 0;
-
-		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+		}
 	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 65bba5fc2335..836b1df79928 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2358,12 +2358,13 @@ static int navi10_get_power_limit(struct smu_context *smu,
 
 	if (powerplay_table) {
 		if (smu->od_enabled &&
-			    navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT))
+			    navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT)) {
 			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
-		else
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+		} else if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT)) {
 			od_percent_upper = 0;
-
-		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+		}
 	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 9371e6e79c56..86315e1cf81b 100644
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
@@ -625,6 +631,7 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu,
 {
 	struct smu_11_0_7_powerplay_table *powerplay_table =
 		(struct smu_11_0_7_powerplay_table *)smu->smu_table.power_play_table;
+	struct smu_11_0_7_overdrive_table *od_settings = smu->od_settings;
 	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 0;
 	uint16_t *table_member;
 
@@ -641,12 +648,14 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu,
 		*default_power_limit = power_limit;
 
 	if (powerplay_table) {
-		if (smu->od_enabled)
+		if (smu->od_enabled &&
+				sienna_cichlid_is_od_feature_supported(od_settings, SMU_11_0_7_ODCAP_POWER_LIMIT)) {
 			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
-		else
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
+		} else if ((sienna_cichlid_is_od_feature_supported(od_settings, SMU_11_0_7_ODCAP_POWER_LIMIT))) {
 			od_percent_upper = 0;
-
-		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
+		}
 	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
@@ -1252,12 +1261,6 @@ static bool sienna_cichlid_is_support_fine_grained_dpm(struct smu_context *smu,
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
index f1e388c2863a..b64057032548 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2370,12 +2370,14 @@ static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
 		*default_power_limit = power_limit;
 
 	if (powerplay_table) {
-		if (smu->od_enabled)
+		if (smu->od_enabled &&
+				smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_PPT_BIT)) {
 			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
-		else
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
+		} else if (smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_PPT_BIT)) {
 			od_percent_upper = 0;
-
-		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
+		}
 	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 8abf0a772e6b..7318964f1f14 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2334,12 +2334,14 @@ static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
 		*default_power_limit = power_limit;
 
 	if (powerplay_table) {
-		if (smu->od_enabled)
+		if (smu->od_enabled &&
+				(smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_PPT_BIT))) {
 			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
-		else
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
+		} else if (smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_PPT_BIT)) {
 			od_percent_upper = 0;
-
-		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
+			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
+		}
 	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
-- 
2.34.1

