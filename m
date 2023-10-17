Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 795E3CDB482
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 07:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02E0089048;
	Tue, 17 Oct 2023 07:22:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B95310E277
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 07:22:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/UERlpEoZiISYrxjj5va1j2bVmv5bCjUXwRmRcW7kUOgllpqkVlrhckcAXYv36rQfCONikSQNI2RIVA9HbUv429wP0F9khUG2uJklrCSmj6LwEzUZjD+lmmZzJ/Mrt8ssj3RB28AFe5eaTQSGXvdZm4Bh5wULoU1xYmQmqtwZjhtR+6PBZAFhpCoXnMPREf62aZnNWCn6y0WjmM0pvR1eDybmd1BbnpDIJIw2LO5nvjH+KdNBdlQ0ARQ7vuwk4Xm0eCywPp/xmN9Qoc9uAjTaE1/vLIMnm9sLF19X8Bt/NZkJnFPRVglXbLiyoEzgAAnaFymZLaxOoCARiYWii0rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eBjrPIo+JzmdPNOWN4hNPoXjzp+lYW6Q4g1gKKw5/s=;
 b=OTzhdJKATusu0SisWaEu4SLdMpZMsR0LQ4lM/9gG8ya0mNEkMD3zO2A5YUx9lLQp6GwUt5pW9GSNfsS5rt/QvlgJs/xEr5/wyuMe/vtjwNClny169FD8/15VYZzNH7MxMFlYjy6r4sA1ITvqnaxlJ9PEjWGQBvS+Jm582cfd9/ryDP1REhYC+o9Rmc/jtp9DnctGY+/jYjzQu+k9wdkJmQgms9qtNuUuLLtr1jGXhl+EQRt3hoIqCCzVVtjEHG1iev40U4wJRaPdXOlWFakL9/zdmm8jHTv+2ET2wIvpdBKjMm43ylRBYJA+ql6SGIz4rxzuA/UY2++UL/BUuVaoVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eBjrPIo+JzmdPNOWN4hNPoXjzp+lYW6Q4g1gKKw5/s=;
 b=C7J5CDnCkzfRo3Aa9LjOKgrAJj/ajma2qBxBD0aPNaJ8pfeMD665jF0OK7k9SHiG2Y8+zsHegIjTFXVrDSlLYtQUjl7n6+lzlIYbIezSAYyyHjbVAjCvhdgCUL7Tydh6UMZJqCfgoNMO94JAqBhS7v8aKQcjro3sUx2tRsmnJHY=
Received: from CH0PR03CA0397.namprd03.prod.outlook.com (2603:10b6:610:11b::30)
 by PH0PR12MB8173.namprd12.prod.outlook.com (2603:10b6:510:296::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Tue, 17 Oct
 2023 07:22:12 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:610:11b:cafe::31) by CH0PR03CA0397.outlook.office365.com
 (2603:10b6:610:11b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 07:22:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 07:22:11 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 02:22:08 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Kenneth.Feng@amd.com>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amd/pm: Support for getting power1_cap_min value
Date: Tue, 17 Oct 2023 15:21:39 +0800
Message-ID: <20231017072139.40963-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|PH0PR12MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: f5d7405d-0563-42f1-343a-08dbcee1c7ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uXZ3dzkWFuWYkrKPY52nxIK19j6AFWZWl++SpcR8kCGxp5qsCMID5zzcGxN5eAmwFcrni3/xxFtF83+pVzeqUqrvTjGCoAzJ200lAfDfphTFVDi17edQPTj5LXMzI+F4Z0vMqnnJ1iXEj+tntWzC71Q5bIw0C/dTQ7T3o6X3W5Z1UjOZggd3wf9MIZDmqxmxo6UIkAhyX5pPtAZ/hM7VxPn9I7TU96mwISgyYEqVqV0duPx86XCwiXg5Q7XYqxp0j4l6wWKhwk9QHmqrDdloKFKW5Y71cMZ5k0newvO+hsijkMgZQeciGwM5WQMJsOtu22+O0DUUxD/0CA9pESzOFneoTKg7inKneKKwfgnPlOg+cwJ1nXz9mnCMeRtL8IAg08+xZM0JYitrdaaYQhA7VDF8drS12lSfDvwBG6GOoXmy5WjW3orNwYM/rLgH72pUSCw90eaGQo0FzJlOfaUa+hel3oSHrzw/G4lv3OORpUL2Tfn0Uk8ujYA/trZ0qv2vWbnxV34wMy6smknwYilQBLjrbnZoZDuUjueWWc7Br7ZqHtRfVD/9wQDHJ0kr9TdTwgFTl6st25RjXkyUpjR5H9Ip7KtlM5gPEXdKTNXoNWnT+gI1BmDJ72hdNX9PZSyaMosMDyBdrjM7iuS/+AIHdFyVCH98+gYDqPBZM20YR4EDnGYc3IXs/nHOXrK6ALC3yGjbgqYpd3gv1sKeAIBfZY1HUkm1E5aZgCMQ5vnnQFpF1ZXULzLrveC0syva7dPDPjKiTI5m1SiZh/94r6tuPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(36860700001)(478600001)(26005)(2616005)(1076003)(7696005)(16526019)(6666004)(83380400001)(4326008)(8676002)(54906003)(47076005)(41300700001)(8936002)(30864003)(5660300002)(70206006)(70586007)(2906002)(316002)(6636002)(356005)(110136005)(336012)(81166007)(82740400003)(426003)(36756003)(86362001)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:22:11.4853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d7405d-0563-42f1-343a-08dbcee1c7ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8173
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
Cc: Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Support for getting power1_cap_min value on smu13 and smu11.
For other Asics, we still use 0 as the default value.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 14 ++++----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 16 +++++----
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  8 +++--
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 33 +++++++++++-------
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 33 +++++++++++-------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 34 +++++++++++--------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  5 ++-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 13 ++++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 34 ++++++++++++-------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  9 +++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 34 ++++++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  2 +-
 12 files changed, 147 insertions(+), 88 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index c7c29aa24c36..d76c3abf406f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2921,14 +2921,6 @@ static ssize_t amdgpu_hwmon_show_power_input(struct device *dev,
 	return sysfs_emit(buf, "%zd\n", val);
 }
 
-static ssize_t amdgpu_hwmon_show_power_cap_min(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
-{
-	return sysfs_emit(buf, "%i\n", 0);
-}
-
-
 static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
 					struct device_attribute *attr,
 					char *buf,
@@ -2965,6 +2957,12 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
 	return size;
 }
 
+static ssize_t amdgpu_hwmon_show_power_cap_min(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	return amdgpu_hwmon_show_power_cap_generic(dev, attr, buf, PP_PWR_LIMIT_MIN);
+}
 
 static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 					 struct device_attribute *attr,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 7c3356d6da5e..f4a68d107184 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -849,7 +849,8 @@ static int smu_late_init(void *handle)
 	ret = smu_get_asic_power_limits(smu,
 					&smu->current_power_limit,
 					&smu->default_power_limit,
-					&smu->max_power_limit);
+					&smu->max_power_limit,
+					&smu->min_power_limit);
 	if (ret) {
 		dev_err(adev->dev, "Failed to get asic power limits!\n");
 		return ret;
@@ -2447,6 +2448,8 @@ int smu_get_power_limit(void *handle,
 		limit_level = SMU_PPT_LIMIT_MAX;
 		break;
 	case PP_PWR_LIMIT_MIN:
+		limit_level = SMU_PPT_LIMIT_MIN;
+		break;
 	default:
 		return -EOPNOTSUPP;
 		break;
@@ -2466,8 +2469,7 @@ int smu_get_power_limit(void *handle,
 			case IP_VERSION(11, 0, 13):
 				ret = smu_get_asic_power_limits(smu,
 								&smu->current_power_limit,
-								NULL,
-								NULL);
+								NULL, NULL, NULL);
 				break;
 			default:
 				break;
@@ -2480,6 +2482,8 @@ int smu_get_power_limit(void *handle,
 		case SMU_PPT_LIMIT_MAX:
 			*limit = smu->max_power_limit;
 			break;
+		case SMU_PPT_LIMIT_MIN:
+			*limit = smu->min_power_limit;
 		default:
 			break;
 		}
@@ -2502,10 +2506,10 @@ static int smu_set_power_limit(void *handle, uint32_t limit)
 		if (smu->ppt_funcs->set_power_limit)
 			return smu->ppt_funcs->set_power_limit(smu, limit_type, limit);
 
-	if (limit > smu->max_power_limit) {
+	if ((limit > smu->max_power_limit) || (limit < smu->min_power_limit)) {
 		dev_err(smu->adev->dev,
-			"New power limit (%d) is over the max allowed %d\n",
-			limit, smu->max_power_limit);
+			"New power limit (%d) is out of range [%d,%d]\n",
+			limit, smu->min_power_limit, smu->max_power_limit);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 1454eed76604..839553a86aa2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -500,6 +500,7 @@ struct smu_context {
 	uint32_t current_power_limit;
 	uint32_t default_power_limit;
 	uint32_t max_power_limit;
+	uint32_t min_power_limit;
 
 	/* soft pptable */
 	uint32_t ppt_offset_bytes;
@@ -821,9 +822,10 @@ struct pptable_funcs {
 	 * @get_power_limit: Get the device's power limits.
 	 */
 	int (*get_power_limit)(struct smu_context *smu,
-			       uint32_t *current_power_limit,
-			       uint32_t *default_power_limit,
-			       uint32_t *max_power_limit);
+					uint32_t *current_power_limit,
+					uint32_t *default_power_limit,
+					uint32_t *max_power_limit,
+					uint32_t *min_power_limit);
 
 	/**
 	 * @get_ppt_limit: Get the device's ppt limits.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 44e4289b95cd..77c01bfb96fe 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1285,14 +1285,15 @@ static int arcturus_get_fan_parameters(struct smu_context *smu)
 }
 
 static int arcturus_get_power_limit(struct smu_context *smu,
-				    uint32_t *current_power_limit,
-				    uint32_t *default_power_limit,
-				    uint32_t *max_power_limit)
+					uint32_t *current_power_limit,
+					uint32_t *default_power_limit,
+					uint32_t *max_power_limit,
+					uint32_t *min_power_limit)
 {
 	struct smu_11_0_powerplay_table *powerplay_table =
 		(struct smu_11_0_powerplay_table *)smu->smu_table.power_play_table;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
-	uint32_t power_limit, od_percent;
+	uint32_t power_limit, od_percent_upper, od_percent_lower;
 
 	if (smu_v11_0_get_current_power_limit(smu, &power_limit)) {
 		/* the last hope to figure out the ppt limit */
@@ -1309,17 +1310,25 @@ static int arcturus_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (max_power_limit) {
-		if (smu->od_enabled) {
-			od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+	if (smu->od_enabled) {
+		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+	} else {
+		od_percent_upper = 0;
+		od_percent_lower = 100;
+	}
 
-			dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_percent, power_limit);
+	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
+							od_percent_upper, od_percent_lower, power_limit);
 
-			power_limit *= (100 + od_percent);
-			power_limit /= 100;
-		}
+	if (max_power_limit) {
+		*max_power_limit = power_limit * (100 + od_percent_upper);
+		*max_power_limit /= 100;
+	}
 
-		*max_power_limit = power_limit;
+	if (min_power_limit) {
+		*min_power_limit = power_limit * (100 - od_percent_lower);
+		*min_power_limit /= 100;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 5f3cbfff156a..a83bd3f347a9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2337,15 +2337,16 @@ static int navi10_display_disable_memory_clock_switch(struct smu_context *smu,
 }
 
 static int navi10_get_power_limit(struct smu_context *smu,
-				  uint32_t *current_power_limit,
-				  uint32_t *default_power_limit,
-				  uint32_t *max_power_limit)
+					uint32_t *current_power_limit,
+					uint32_t *default_power_limit,
+					uint32_t *max_power_limit,
+					uint32_t *min_power_limit)
 {
 	struct smu_11_0_powerplay_table *powerplay_table =
 		(struct smu_11_0_powerplay_table *)smu->smu_table.power_play_table;
 	struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
-	uint32_t power_limit, od_percent;
+	uint32_t power_limit, od_percent_upper, od_percent_lower;
 
 	if (smu_v11_0_get_current_power_limit(smu, &power_limit)) {
 		/* the last hope to figure out the ppt limit */
@@ -2362,18 +2363,26 @@ static int navi10_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (max_power_limit) {
-		if (smu->od_enabled &&
+	if (smu->od_enabled &&
 		    navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT)) {
-			od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+	} else {
+		od_percent_upper = 0;
+		od_percent_lower = 100;
+	}
 
-			dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_percent, power_limit);
+	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
+					od_percent_upper, od_percent_lower, power_limit);
 
-			power_limit *= (100 + od_percent);
-			power_limit /= 100;
-		}
+	if (max_power_limit) {
+		*max_power_limit = power_limit * (100 + od_percent_upper);
+		*max_power_limit /= 100;
+	}
 
-		*max_power_limit = power_limit;
+	if (min_power_limit) {
+		*min_power_limit = power_limit * (100 - od_percent_lower);
+		*min_power_limit /= 100;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 28868f64d134..8206a2744272 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -620,11 +620,12 @@ static uint32_t sienna_cichlid_get_throttler_status_locked(struct smu_context *s
 static int sienna_cichlid_get_power_limit(struct smu_context *smu,
 					  uint32_t *current_power_limit,
 					  uint32_t *default_power_limit,
-					  uint32_t *max_power_limit)
+					  uint32_t *max_power_limit,
+					  uint32_t *min_power_limit)
 {
 	struct smu_11_0_7_powerplay_table *powerplay_table =
 		(struct smu_11_0_7_powerplay_table *)smu->smu_table.power_play_table;
-	uint32_t power_limit, od_percent;
+	uint32_t power_limit, od_percent_upper, od_percent_lower;
 	uint16_t *table_member;
 
 	GET_PPTABLE_MEMBER(SocketPowerLimitAc, &table_member);
@@ -639,21 +640,26 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (max_power_limit) {
-		if (smu->od_enabled) {
-			od_percent =
-				le32_to_cpu(powerplay_table->overdrive_table.max[
-							SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
+	if (smu->od_enabled) {
+		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
+		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
+	} else {
+		od_percent_upper = 0;
+		od_percent_lower = 100;
+	}
 
-			dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n",
-					od_percent, power_limit);
+	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
+					od_percent_upper, od_percent_lower, power_limit);
 
-			power_limit *= (100 + od_percent);
-			power_limit /= 100;
-		}
-		*max_power_limit = power_limit;
+	if (max_power_limit) {
+		*max_power_limit = power_limit * (100 + od_percent_upper);
+		*max_power_limit /= 100;
 	}
 
+	if (min_power_limit) {
+		*min_power_limit = power_limit * (100 - od_percent_lower);
+		*min_power_limit /= 100;
+	}
 	return 0;
 }
 
@@ -672,7 +678,7 @@ static void sienna_cichlid_get_smartshift_power_percentage(struct smu_context *s
 	uint32_t cur_power_limit;
 
 	if (metrics_v4->ApuSTAPMSmartShiftLimit != 0) {
-		sienna_cichlid_get_power_limit(smu, &cur_power_limit, NULL, NULL);
+		sienna_cichlid_get_power_limit(smu, &cur_power_limit, NULL, NULL, NULL);
 		apu_power_limit = metrics_v4->ApuSTAPMLimit;
 		dgpu_power_limit = cur_power_limit;
 		powerRatio = (((apu_power_limit +
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index a5481274052e..d006ebe94aed 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2344,7 +2344,8 @@ static u32 vangogh_get_gfxoff_status(struct smu_context *smu)
 static int vangogh_get_power_limit(struct smu_context *smu,
 				   uint32_t *current_power_limit,
 				   uint32_t *default_power_limit,
-				   uint32_t *max_power_limit)
+				   uint32_t *max_power_limit,
+				   uint32_t *min_power_limit)
 {
 	struct smu_11_5_power_context *power_context =
 								smu->smu_power.power_context;
@@ -2366,6 +2367,8 @@ static int vangogh_get_power_limit(struct smu_context *smu,
 		*default_power_limit = ppt_limit / 1000;
 	if (max_power_limit)
 		*max_power_limit = 29;
+	if (min_power_limit)
+		*min_power_limit = 0;
 
 	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetFastPPTLimit, &ppt_limit);
 	if (ret) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 2373a66c7efd..84df7df78032 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1145,9 +1145,10 @@ static int aldebaran_read_sensor(struct smu_context *smu,
 }
 
 static int aldebaran_get_power_limit(struct smu_context *smu,
-				     uint32_t *current_power_limit,
-				     uint32_t *default_power_limit,
-				     uint32_t *max_power_limit)
+						uint32_t *current_power_limit,
+						uint32_t *default_power_limit,
+						uint32_t *max_power_limit,
+						uint32_t *min_power_limit)
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	uint32_t power_limit = 0;
@@ -1160,7 +1161,8 @@ static int aldebaran_get_power_limit(struct smu_context *smu,
 			*default_power_limit = 0;
 		if (max_power_limit)
 			*max_power_limit = 0;
-
+		if (min_power_limit)
+			*min_power_limit = 0;
 		dev_warn(smu->adev->dev,
 			"PPT feature is not enabled, power values can't be fetched.");
 
@@ -1195,6 +1197,9 @@ static int aldebaran_get_power_limit(struct smu_context *smu,
 			*max_power_limit = pptable->PptLimit;
 	}
 
+	if (min_power_limit)
+		*min_power_limit = 0;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 4ddaa372604a..851d7f1c6f19 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2343,16 +2343,17 @@ static int smu_v13_0_0_enable_mgpu_fan_boost(struct smu_context *smu)
 }
 
 static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
-				       uint32_t *current_power_limit,
-				       uint32_t *default_power_limit,
-				       uint32_t *max_power_limit)
+						uint32_t *current_power_limit,
+						uint32_t *default_power_limit,
+						uint32_t *max_power_limit,
+						uint32_t *min_power_limit)
 {
 	struct smu_table_context *table_context = &smu->smu_table;
 	struct smu_13_0_0_powerplay_table *powerplay_table =
 		(struct smu_13_0_0_powerplay_table *)table_context->power_play_table;
 	PPTable_t *pptable = table_context->driver_pptable;
 	SkuTable_t *skutable = &pptable->SkuTable;
-	uint32_t power_limit, od_percent;
+	uint32_t power_limit, od_percent_upper, od_percent_lower;
 
 	if (smu_v13_0_get_current_power_limit(smu, &power_limit))
 		power_limit = smu->adev->pm.ac_power ?
@@ -2364,16 +2365,25 @@ static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (max_power_limit) {
-		if (smu->od_enabled) {
-			od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
+	if (smu->od_enabled) {
+		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
+		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
+	} else {
+		od_percent_upper = 0;
+		od_percent_lower = 100;
+	}
 
-			dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_percent, power_limit);
+	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
+					od_percent_upper, od_percent_lower, power_limit);
 
-			power_limit *= (100 + od_percent);
-			power_limit /= 100;
-		}
-		*max_power_limit = power_limit;
+	if (max_power_limit) {
+		*max_power_limit = power_limit * (100 + od_percent_upper);
+		*max_power_limit /= 100;
+	}
+
+	if (min_power_limit) {
+		*min_power_limit = power_limit * (100 - od_percent_lower);
+		*min_power_limit /= 100;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 8220bdcbd927..3ea2031c7f7e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1242,9 +1242,10 @@ static int smu_v13_0_6_read_sensor(struct smu_context *smu,
 }
 
 static int smu_v13_0_6_get_power_limit(struct smu_context *smu,
-				       uint32_t *current_power_limit,
-				       uint32_t *default_power_limit,
-				       uint32_t *max_power_limit)
+						uint32_t *current_power_limit,
+						uint32_t *default_power_limit,
+						uint32_t *max_power_limit,
+						uint32_t *min_power_limit)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct PPTable_t *pptable =
@@ -1268,6 +1269,8 @@ static int smu_v13_0_6_get_power_limit(struct smu_context *smu,
 		*max_power_limit = pptable->MaxSocketPowerLimit;
 	}
 
+	if (min_power_limit)
+		*min_power_limit = 0;
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 3c5526babb14..ac0e1cc812bd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2304,16 +2304,17 @@ static int smu_v13_0_7_enable_mgpu_fan_boost(struct smu_context *smu)
 }
 
 static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
-				       uint32_t *current_power_limit,
-				       uint32_t *default_power_limit,
-				       uint32_t *max_power_limit)
+						uint32_t *current_power_limit,
+						uint32_t *default_power_limit,
+						uint32_t *max_power_limit,
+						uint32_t *min_power_limit)
 {
 	struct smu_table_context *table_context = &smu->smu_table;
 	struct smu_13_0_7_powerplay_table *powerplay_table =
 		(struct smu_13_0_7_powerplay_table *)table_context->power_play_table;
 	PPTable_t *pptable = table_context->driver_pptable;
 	SkuTable_t *skutable = &pptable->SkuTable;
-	uint32_t power_limit, od_percent;
+	uint32_t power_limit, od_percent_upper, od_percent_lower;
 
 	if (smu_v13_0_get_current_power_limit(smu, &power_limit))
 		power_limit = smu->adev->pm.ac_power ?
@@ -2325,16 +2326,25 @@ static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (max_power_limit) {
-		if (smu->od_enabled) {
-			od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
+	if (smu->od_enabled) {
+		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
+		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
+	} else {
+		od_percent_upper = 0;
+		od_percent_lower = 100;
+	}
 
-			dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_percent, power_limit);
+	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
+					od_percent_upper, od_percent_lower, power_limit);
 
-			power_limit *= (100 + od_percent);
-			power_limit /= 100;
-		}
-		*max_power_limit = power_limit;
+	if (max_power_limit) {
+		*max_power_limit = power_limit * (100 + od_percent_upper);
+		*max_power_limit /= 100;
+	}
+
+	if (min_power_limit) {
+		*min_power_limit = power_limit * (100 - od_percent_lower);
+		*min_power_limit /= 100;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index bcc42abfc768..80b3c3efc006 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -85,7 +85,7 @@
 #define smu_i2c_fini(smu)                                               smu_ppt_funcs(i2c_fini, 0, smu)
 #define smu_get_unique_id(smu)						smu_ppt_funcs(get_unique_id, 0, smu)
 #define smu_log_thermal_throttling(smu)					smu_ppt_funcs(log_thermal_throttling_event, 0, smu)
-#define smu_get_asic_power_limits(smu, current, default, max)		smu_ppt_funcs(get_power_limit, 0, smu, current, default, max)
+#define smu_get_asic_power_limits(smu, current, default, max, min)		smu_ppt_funcs(get_power_limit, 0, smu, current, default, max, min)
 #define smu_get_pp_feature_mask(smu, buf)				smu_ppt_funcs(get_pp_feature_mask, 0, smu, buf)
 #define smu_set_pp_feature_mask(smu, new_mask)				smu_ppt_funcs(set_pp_feature_mask, 0, smu, new_mask)
 #define smu_gfx_ulv_control(smu, enablement)				smu_ppt_funcs(gfx_ulv_control, 0, smu, enablement)
-- 
2.34.1

