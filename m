Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0687AC4725D
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jan 2024 08:20:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F70710E95B;
	Fri, 19 Jan 2024 08:20:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB0A410E95B
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jan 2024 08:20:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OE48riYHnb0fwcLcNOp1MfLu7VGKJpr99U8XQTFxly+5GgOXTcmeZuF8/RZTwQHSSodSutdZy25E++3BFiEOCcHhyD912ji4E+s3p715x2ytcdDqPj/8AYjG9H80JHleUf4Qu8EJdUv/8nTWZ1Mq+dUBoBegGfGHBXG77JJpd8I6zGAp1PB0dzVE+9ZC4NIJZ9qRERlxx6uGC1xE3l9va/wEruPY9gwUTMAWG3n5T77nszK7QTT591cSyZm898K9YN72PpfMW/J8HOmByvzQjpRaFkmez+YyN1Y2CBXGFrBKisbZuNvjS4RusJQJ9kF2fVru/FOI/x7BRv+pbyQImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVk/Zi1MCdwCTHacF87VV6AGtX9hXFOJ6hFITnm3m9Y=;
 b=JNr7PHhnuwZ7yws+IGDC5voQG6+WIQAD1SUpEuBuof2AzXz/AptQxlL/rcl++eAgkvdz6KHjR+svYmc26/gVVnnV6vLR7twxVzoCcd7E4zGxDbPuTuZRr1uMwtU+W0r+DQeHu0j5pPiezOpduRxH+W0URn3Y9iSxnf9Nvdl0MilAE5DS9Nggwo7tUMGYR2Sl4EG0EMgJ1WFMQ/X/eAkNRX1TvRh9qxxOvD+MZNyC3boPrej5RkS7ydwL+RQQyruwY8bYjOYHdBipUupZPjncyp0NGdkB9RFyvhWz/DuxhOhRgmeFlaFq5MTCKOsAjYzh4zFWW8kyE2Vm3a2zEXdibA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVk/Zi1MCdwCTHacF87VV6AGtX9hXFOJ6hFITnm3m9Y=;
 b=kcGQQA3pW6IUPJ0V7tovpinaA1n2SKFYjWCZSfrvmMKqqWBQoX0dP+vxyoO8cusIhSzi2+CH62e96bokvsfusJXqS4dd0RqZUD750SZvxqVJ0GNm+El6NOfYubGN5Kyh+M9rrA4uutfO7vayt6uR4aioKIgKVhDnY7ZkN2VcQTY=
Received: from CH2PR15CA0030.namprd15.prod.outlook.com (2603:10b6:610:51::40)
 by DS7PR12MB8417.namprd12.prod.outlook.com (2603:10b6:8:eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 08:20:22 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::9f) by CH2PR15CA0030.outlook.office365.com
 (2603:10b6:610:51::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Fri, 19 Jan 2024 08:20:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 08:20:22 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 02:20:21 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 19 Jan
 2024 00:20:21 -0800
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via
 Frontend Transport; Fri, 19 Jan 2024 02:20:20 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: update the power cap setting
Date: Fri, 19 Jan 2024 16:20:13 +0800
Message-ID: <20240119082013.2953172-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|DS7PR12MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de3f46b-9136-4fde-c669-08dc18c77b32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: clsnp46eZw0s7Rane6oFRB3Mh8/6TV7sYRI3dvU6cp3fbhsICUYUh42+aOVQcMPNToa1KmuX048qksX9jMefQOubZlZL4AC8SdZaUnwwVhyRjhPfU9YNvIP7v4E2r8wn4PoJNqoiwdoBU1hnLoebQJF8vdDfQmZO1t7YeEpWke1ZNIRKjYvgW5K6bUIdfHeyT/1b2XkjaiBnQKSRGe3jk64s8AML94kxRoIUmPK5LNVNXgzELbAauUDhB2UAoB4+/sCL6BLcdf93kcCSC1RzX+uEf/2Kp2+JDFqLDVBgWQbzWPXCjCBWdu+iPjFPCihKj68eJ5Cc2BgG/1ztUPrLxI0/ODp+u2HJPs3cptFVRnVw3Ngn8bwAvLsMYAQI8EAKtc4PATeS4EaI4oh6r9wrgK+xee6B5VqmVD5k69mrjO409I815CMxWVBEorwRwK+ZZ9G93YhP7XFFTx8g4E4GDw/OeC0BqcRqsgTZBeRlpENL20wyXHEcc4S+DC0w2lJCQT6pqxgkd6jiK7UUwABFmY0034qmZJYgGe4eZJKUAewF/N+JdOpLuQm8H4hCTmZg0h0RXj3EPMVyUatdb5QlRpFk1NfRiHdYsC9ZTpVx+h5FdR/yS9kl5TbPM5UK0FJfAtVOabgtHz9llVXsN+UQ3goycdbDD7vEnoE21GWZ7jBRAWQTwH1emXXrHqWTF5Arah3geDPC3v0GrhroN2G7nGdo4fV5vVy33X3++5YfaNayhtYyFHw1w5zROoAe3Zc+DJzXCIBNqSK0iAB1Wrd8NFiLfZqrb5XZndsYnsbcjaFjdr8acuS6iNivQLRf3Cs1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(230273577357003)(230173577357003)(82310400011)(186009)(451199024)(1800799012)(64100799003)(36840700001)(46966006)(40470700004)(356005)(70586007)(81166007)(70206006)(8936002)(478600001)(44832011)(36860700001)(4326008)(82740400003)(2616005)(8676002)(83380400001)(26005)(1076003)(86362001)(316002)(6916009)(7696005)(426003)(336012)(6666004)(2906002)(5660300002)(40460700003)(40480700001)(36756003)(15650500001)(47076005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 08:20:22.3470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de3f46b-9136-4fde-c669-08dc18c77b32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8417
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

update the power cap setting for smu_v13.0.0/smu_v13.0.7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 54 ++++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 54 ++++++++++++++++++-
 2 files changed, 104 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 231122622a9c..e769adb8da2c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2357,6 +2357,7 @@ static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
 	PPTable_t *pptable = table_context->driver_pptable;
 	SkuTable_t *skutable = &pptable->SkuTable;
 	uint32_t power_limit, od_percent_upper, od_percent_lower;
+	uint32_t msg_limit = skutable->MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
 
 	if (smu_v13_0_get_current_power_limit(smu, &power_limit))
 		power_limit = smu->adev->pm.ac_power ?
@@ -2380,7 +2381,7 @@ static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
 					od_percent_upper, od_percent_lower, power_limit);
 
 	if (max_power_limit) {
-		*max_power_limit = power_limit * (100 + od_percent_upper);
+		*max_power_limit = msg_limit * (100 + od_percent_upper);
 		*max_power_limit /= 100;
 	}
 
@@ -2960,6 +2961,55 @@ static bool smu_v13_0_0_wbrf_support_check(struct smu_context *smu)
 	}
 }
 
+static int smu_v13_0_0_set_power_limit(struct smu_context *smu,
+				       enum smu_ppt_limit_type limit_type,
+				       uint32_t limit)
+{
+	PPTable_t *pptable = smu->smu_table.driver_pptable;
+	SkuTable_t *skutable = &pptable->SkuTable;
+	uint32_t msg_limit = skutable->MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
+	struct smu_table_context *table_context = &smu->smu_table;
+	OverDriveTableExternal_t *od_table =
+		(OverDriveTableExternal_t *)table_context->overdrive_table;
+	int ret = 0;
+
+	if (limit_type != SMU_DEFAULT_PPT_LIMIT)
+		return -EINVAL;
+
+	if (limit <= msg_limit) {
+		if (smu->current_power_limit > msg_limit) {
+			od_table->OverDriveTable.Ppt = 0;
+			od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_PPT_BIT;
+
+			ret = smu_v13_0_0_upload_overdrive_table(smu, od_table);
+			if (ret) {
+				dev_err(smu->adev->dev, "Failed to upload overdrive table!\n");
+				return ret;
+			}
+		}
+		return smu_v13_0_set_power_limit(smu, limit_type, limit);
+	} else if (smu->od_enabled) {
+		ret = smu_v13_0_set_power_limit(smu, limit_type, msg_limit);
+		if (ret)
+			return ret;
+
+		od_table->OverDriveTable.Ppt = (limit * 100) / msg_limit - 100;
+		od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_PPT_BIT;
+
+		ret = smu_v13_0_0_upload_overdrive_table(smu, od_table);
+		if (ret) {
+		  dev_err(smu->adev->dev, "Failed to upload overdrive table!\n");
+		  return ret;
+		}
+
+		smu->current_power_limit = limit;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_0_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_0_set_default_dpm_table,
@@ -3014,7 +3064,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.set_fan_control_mode = smu_v13_0_set_fan_control_mode,
 	.enable_mgpu_fan_boost = smu_v13_0_0_enable_mgpu_fan_boost,
 	.get_power_limit = smu_v13_0_0_get_power_limit,
-	.set_power_limit = smu_v13_0_set_power_limit,
+	.set_power_limit = smu_v13_0_0_set_power_limit,
 	.set_power_source = smu_v13_0_set_power_source,
 	.get_power_profile_mode = smu_v13_0_0_get_power_profile_mode,
 	.set_power_profile_mode = smu_v13_0_0_set_power_profile_mode,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 59606a19e3d2..7c3e162e2d81 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2321,6 +2321,7 @@ static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
 	PPTable_t *pptable = table_context->driver_pptable;
 	SkuTable_t *skutable = &pptable->SkuTable;
 	uint32_t power_limit, od_percent_upper, od_percent_lower;
+	uint32_t msg_limit = skutable->MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
 
 	if (smu_v13_0_get_current_power_limit(smu, &power_limit))
 		power_limit = smu->adev->pm.ac_power ?
@@ -2344,7 +2345,7 @@ static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
 					od_percent_upper, od_percent_lower, power_limit);
 
 	if (max_power_limit) {
-		*max_power_limit = power_limit * (100 + od_percent_upper);
+		*max_power_limit = msg_limit * (100 + od_percent_upper);
 		*max_power_limit /= 100;
 	}
 
@@ -2545,6 +2546,55 @@ static bool smu_v13_0_7_wbrf_support_check(struct smu_context *smu)
 	return smu->smc_fw_version > 0x00524600;
 }
 
+static int smu_v13_0_7_set_power_limit(struct smu_context *smu,
+				       enum smu_ppt_limit_type limit_type,
+				       uint32_t limit)
+{
+	PPTable_t *pptable = smu->smu_table.driver_pptable;
+	SkuTable_t *skutable = &pptable->SkuTable;
+	uint32_t msg_limit = skutable->MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
+	struct smu_table_context *table_context = &smu->smu_table;
+	OverDriveTableExternal_t *od_table =
+		(OverDriveTableExternal_t *)table_context->overdrive_table;
+	int ret = 0;
+
+	if (limit_type != SMU_DEFAULT_PPT_LIMIT)
+		return -EINVAL;
+
+	if (limit <= msg_limit) {
+		if (smu->current_power_limit > msg_limit) {
+			od_table->OverDriveTable.Ppt = 0;
+			od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_PPT_BIT;
+
+			ret = smu_v13_0_7_upload_overdrive_table(smu, od_table);
+			if (ret) {
+				dev_err(smu->adev->dev, "Failed to upload overdrive table!\n");
+				return ret;
+			}
+		}
+		return smu_v13_0_set_power_limit(smu, limit_type, limit);
+	} else if (smu->od_enabled) {
+		ret = smu_v13_0_set_power_limit(smu, limit_type, msg_limit);
+		if (ret)
+			return ret;
+
+		od_table->OverDriveTable.Ppt = (limit * 100) / msg_limit - 100;
+		od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_PPT_BIT;
+
+		ret = smu_v13_0_7_upload_overdrive_table(smu, od_table);
+		if (ret) {
+		  dev_err(smu->adev->dev, "Failed to upload overdrive table!\n");
+		  return ret;
+		}
+
+		smu->current_power_limit = limit;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_7_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_7_set_default_dpm_table,
@@ -2596,7 +2646,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.set_fan_control_mode = smu_v13_0_set_fan_control_mode,
 	.enable_mgpu_fan_boost = smu_v13_0_7_enable_mgpu_fan_boost,
 	.get_power_limit = smu_v13_0_7_get_power_limit,
-	.set_power_limit = smu_v13_0_set_power_limit,
+	.set_power_limit = smu_v13_0_7_set_power_limit,
 	.set_power_source = smu_v13_0_set_power_source,
 	.get_power_profile_mode = smu_v13_0_7_get_power_profile_mode,
 	.set_power_profile_mode = smu_v13_0_7_set_power_profile_mode,
-- 
2.34.1

