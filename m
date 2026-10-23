Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC98606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wfPDKWLz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E758A112C87;
	Fri, 23 Oct 2026 17:13:23 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D03E510E5FF
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 13:00:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q90JboqzE79YktYkZMo0GQXe1Bg+S/VSEX2xr3FbaotRKq+Ci2PktsPGdkmfTgXMxjNFu7orx4qKHWShzLetRuoxg/KRBRCesy7Iu5r2YPPekRSRzV5DH/M9P0GwyJvdpSuCc8vCVNfQ8Iu9aR/2B5dBm93OOfDE5KGWDLtHCRlGsZWcvk4APmO81M279V254EwhNUOr0/6pgWdaSWr47qUvkZIwK+R1v5hhNoequN2rM7W6NIFjDSjF07sd1dnXEP0s3FjaUcCJsBKFvDxq7VvqohxWuTlGzi3ZIplQXJdwHe0Z9zWj5KOm6G5uV1ookHsI3zZgCdFGT3ob0J23Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfW5Mf//WD8oBPsh2nO4GlNbdHhGNIo/aB75725Ooz4=;
 b=E/W2Jh3mHaJPoYqlKikZzFJpiQZFQ0pMfAEOrV9EUqztJrdnkzJP+7PDJwcfCDZLao2LM4AopV3mYNOJBkSEf0quvSwkLYhlAHnOs1JCyRNxnZtfsWWFhBw0nS20algNPF4ebwJwVa0q6v/0IlypoqLxGygsyG11o0/O/lxiCNs6P3iyexAoZyIyFSNEeSxaRBYxqZAHo/dETopR8LtZZ9QVuVk0LCQwueJuzN1k7rC5xYdNDagOkdOrQpKz4UzOLYenVq+9BxajHAJeY72PCx3AzAu4HD5SfMhWbuPGqU83fjKpiY/TdqdkCOoCACmFbLHw+eP7Td/zY13XzlUNYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfW5Mf//WD8oBPsh2nO4GlNbdHhGNIo/aB75725Ooz4=;
 b=wfPDKWLzHvyG3TJ1Mkgk8CaGn8aLblIBcF8HC71HCNgc97CGTYjD+Rt9kAPPwIS5m1ELdCQG3ta1hEmBpDBoR9T0ToBnGJLbkToN8WXYru59Tbf7IOOUGmwq5Coy6UQl2Jc3sI5K/VWmCnQi5Pis8vCBJJNG5ZSsPF4xlKqm/AQ=
Received: from DS7PR03CA0066.namprd03.prod.outlook.com (2603:10b6:5:3bb::11)
 by BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 13:00:07 +0000
Received: from CH7PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:5:3bb:cafe::14) by DS7PR03CA0066.outlook.office365.com
 (2603:10b6:5:3bb::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 13:00:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH7PEPF00000017.mail.protection.outlook.com (10.167.244.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Fri, 23 Oct 2026 13:00:07 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 08:00:02 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <Kevin.Wang@amd.com>,
 <asad.kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Add board metrics capability mask
Date: Fri, 23 Oct 2026 20:59:49 +0800
Message-ID: <20261023125949.3230148-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF00000017:EE_|BL1PR12MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ecde39-9733-4a3e-3b8b-08df31059039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261021123027099003|261022105027099003|261021121427099003|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 9qJX90Ra8qR6U6860FLUQOpAYAquR22/DQnkXgrEt68Ug7q/sK9Tvkrro2ZxKA0Xnhkb8ww33YNHwHw8urtTaDwzArFX5fr38vLh+ThlJKY0VZRniC9RDB2+1OVKN6Gw2+nPV+OETchFDM0nr8Rht7dWthaRSWBUdL7QAG1eyI3KQ1e2TywMVfMqxe/2F9mFztfzlfj/xMQs6KmMzrvygVKU0RlhA/TQT+ZSkjG0pURUrpEF5HWZso4/wlQZ3/X3w02wWwJyFWljqZHgrFEdeF+sUrgBCApc4bdnXnrrQnQNMw0i22rECEMb420NUMtkjOCXR8vMCBkzs8F1UTwkzN7VaLjzTGFnfQvgC8Ik2PbrTVci60XmCGlFu/8cmokrTp+vGVJRj53foDjh1xEXFXJ+kD8QlZ+oGQRbbQ+HmJGVudaT44GKgtwL5EeefSDEHzjKCu22OwRnDBJKtl3opYoLflfNB9FnmnfgPfuD8F7giAv1IYICV2vzZq6WUTrnSU3s9w8g+QYti+BZ2OdvK1dYH+DKM+OnF4EYSwShVvVbCjEXPwZon3XC82sWvkR9Xc8eE1Zdd0uwd3qyH/RIOH7eIMdXVcws1puPEsBRW4EXXn726UgBY2X7JevBNK9KPGuS0Mv2heSjUM6k7QT6+hcOY8ZfBDk1zB4LQAxB4yfFlW9rTZUhIk3Hr9LH75Qm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261021123027099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tFFOB0K2WK0bApfkKnjnw7Ec4v0YyL3kJ51FkUZGFUtQ+DJyrovP2tjgczhcy7RNqX6W3sDQ+uJlJ2I5f04qUA+zwOjlpIeAL03gyTVB71HOMGzajnk+VpnkF1BTcE+J6VGeJbjAcUp5Ir/lPNU24vh1aQE9+MFU7s37lFtdHIocnM+s/hrvEZt2AhrJYFeYEsfxGip0reO5A52jFEfjkaT4najqRAAlBcxZ5jTehkMWvtVs2RlYhJ7N+tk6ZiLmE3jM5OBhzux2rb9V0WXWyYegmvKCWTmuSMZHVUalo473L6pfoBRaegX0TO551phCnjefk0Oz0Oov4iaC482MHM7clw+5up/eZg+Mp0kVnLSe7vEpZ38+9UAW4QSkxyQc1UjAQ1ShtsH9AW18ocH7tBgR6y8Z2CS1hl7JCK4DhJAiCBtDSUhwxeCeqsBNACqH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 13:00:07.3803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ecde39-9733-4a3e-3b8b-08df31059039
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874
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

Report temperature, baseboard power, and NPM as separate bits from
get_board_metrics_cap(). Create board/ when any bit is set, and create
each board file when its capability bit is set.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  11 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  28 ++---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 117 ++++++++----------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   5 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  34 +++--
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  15 ++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c |  35 +++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |   1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |   1 +
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  |  23 ++--
 10 files changed, 132 insertions(+), 138 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 45d68ffe6c59..755b29e5a73d 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -192,6 +192,13 @@ enum amdgpu_npm_cap_field {
 
 #define AMDGPU_NPM_FLAGS_DIR	BIT_ULL(63)
 
+enum amdgpu_board_metrics_cap {
+	AMDGPU_BOARD_METRICS_TEMP		= BIT(0),
+	AMDGPU_BOARD_METRICS_BASEBOARD_POWER	= BIT(1),
+	AMDGPU_BOARD_METRICS_NPM		= BIT(2),
+	AMDGPU_BOARD_METRICS_BASEBOARD_TEMP	= BIT(3),
+};
+
 enum amd_pp_task {
 	AMD_PP_TASK_DISPLAY_CONFIG_CHANGE,
 	AMD_PP_TASK_ENABLE_USER_STATE,
@@ -531,8 +538,8 @@ struct amd_pm_funcs {
 	int (*set_df_cstate)(void *handle, enum pp_df_cstate state);
 	int (*set_xgmi_pstate)(void *handle, uint32_t pstate);
 	ssize_t (*get_gpu_metrics)(void *handle, void **table);
-	ssize_t (*get_temp_metrics)(void *handle, enum smu_temp_metric_type type, void *table);
-	bool (*temp_metrics_is_supported)(void *handle, enum smu_temp_metric_type type);
+	ssize_t (*get_temp_metrics)(void *handle, enum amdgpu_board_metrics_cap type, void *table);
+	u32 (*get_board_metrics_cap)(void *handle);
 	u64 (*get_npm_cap)(void *handle);
 	int (*set_npm_limit)(void *handle, uint32_t limit);
 	ssize_t (*get_xcp_metrics)(void *handle, int xcp_id, void *table);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 75d8bb4868e8..04b7b2e1a406 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -2141,13 +2141,13 @@ int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
  * Return: Size of the metrics structure on success, or a negative error code on failure.
  */
 ssize_t amdgpu_dpm_get_temp_metrics(struct amdgpu_device *adev,
-				    enum smu_temp_metric_type type, void *table)
+				    enum amdgpu_board_metrics_cap type, void *table)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	u32 cap = amdgpu_dpm_get_board_metrics_cap(adev);
 	int ret;
 
-	if (!pp_funcs->get_temp_metrics ||
-	    !amdgpu_dpm_is_temp_metrics_supported(adev, type))
+	if (!pp_funcs->get_temp_metrics || !(cap & type))
 		return -EOPNOTSUPP;
 
 	mutex_lock(&adev->pm.mutex);
@@ -2158,32 +2158,28 @@ ssize_t amdgpu_dpm_get_temp_metrics(struct amdgpu_device *adev,
 }
 
 /**
- * amdgpu_dpm_is_temp_metrics_supported - Return if specific temperature metrics support
- * is available
+ * amdgpu_dpm_get_board_metrics_cap - Return board metrics capability bits
  * @adev: Pointer to the device.
- * @type: Identifier for the temperature type metrics to be fetched.
  *
- * This function returns metrics if specific temperature metrics type is supported or not.
+ * OR of AMDGPU_BOARD_METRICS_* values. Zero means board/ is not created.
  *
- * Return: True in case of metrics type supported else false.
+ * Return: Board metrics capability mask.
  */
-bool amdgpu_dpm_is_temp_metrics_supported(struct amdgpu_device *adev,
-					  enum smu_temp_metric_type type)
+u32 amdgpu_dpm_get_board_metrics_cap(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	bool support_temp_metrics = false;
+	u32 cap = 0;
 
-	if (!pp_funcs->temp_metrics_is_supported)
-		return support_temp_metrics;
+	if (!pp_funcs || !pp_funcs->get_board_metrics_cap)
+		return 0;
 
 	if (is_support_sw_smu(adev)) {
 		mutex_lock(&adev->pm.mutex);
-		support_temp_metrics =
-			pp_funcs->temp_metrics_is_supported(adev->powerplay.pp_handle, type);
+		cap = pp_funcs->get_board_metrics_cap(adev->powerplay.pp_handle);
 		mutex_unlock(&adev->pm.mutex);
 	}
 
-	return support_temp_metrics;
+	return cap;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d2babb99bda4..e8b028847375 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2152,7 +2152,7 @@ static ssize_t amdgpu_get_baseboard_temp_metrics(struct device *dev,
 	if (ret)
 		return ret;
 
-	size = amdgpu_dpm_get_temp_metrics(adev, SMU_TEMP_METRIC_BASEBOARD, NULL);
+	size = amdgpu_dpm_get_temp_metrics(adev, AMDGPU_BOARD_METRICS_BASEBOARD_TEMP, NULL);
 	if (size <= 0)
 		goto out;
 	if (size >= PAGE_SIZE) {
@@ -2160,7 +2160,7 @@ static ssize_t amdgpu_get_baseboard_temp_metrics(struct device *dev,
 		goto out;
 	}
 
-	amdgpu_dpm_get_temp_metrics(adev, SMU_TEMP_METRIC_BASEBOARD, buf);
+	amdgpu_dpm_get_temp_metrics(adev, AMDGPU_BOARD_METRICS_BASEBOARD_TEMP, buf);
 
 out:
 	amdgpu_pm_put_access(adev);
@@ -2190,7 +2190,7 @@ static ssize_t amdgpu_get_gpuboard_temp_metrics(struct device *dev,
 	if (ret)
 		return ret;
 
-	size = amdgpu_dpm_get_temp_metrics(adev, SMU_TEMP_METRIC_GPUBOARD, NULL);
+	size = amdgpu_dpm_get_temp_metrics(adev, AMDGPU_BOARD_METRICS_TEMP, NULL);
 	if (size <= 0)
 		goto out;
 	if (size >= PAGE_SIZE) {
@@ -2198,7 +2198,7 @@ static ssize_t amdgpu_get_gpuboard_temp_metrics(struct device *dev,
 		goto out;
 	}
 
-	amdgpu_dpm_get_temp_metrics(adev, SMU_TEMP_METRIC_GPUBOARD, buf);
+	amdgpu_dpm_get_temp_metrics(adev, AMDGPU_BOARD_METRICS_TEMP, buf);
 
 out:
 	amdgpu_pm_put_access(adev);
@@ -2405,40 +2405,11 @@ static DEVICE_ATTR(npm_status, 0444, amdgpu_show_npm_status, NULL);
 static DEVICE_ATTR(baseboard_power, 0444, amdgpu_show_baseboard_power, NULL);
 static DEVICE_ATTR(baseboard_power_limit, 0444, amdgpu_show_baseboard_power_limit, NULL);
 
-static struct attribute *board_attrs[] = {
-	&dev_attr_baseboard_temp.attr,
-	&dev_attr_gpuboard_temp.attr,
-	NULL
-};
-
 struct amdgpu_sysfs_kobj {
 	struct kobject kobj;
 	struct amdgpu_device *adev;
 };
 
-static umode_t amdgpu_board_attr_visible(struct kobject *kobj, struct attribute *attr, int n)
-{
-	struct amdgpu_sysfs_kobj *board = container_of(kobj, struct amdgpu_sysfs_kobj, kobj);
-	struct amdgpu_device *adev = board->adev;
-
-	if (attr == &dev_attr_baseboard_temp.attr) {
-		if (!amdgpu_dpm_is_temp_metrics_supported(adev, SMU_TEMP_METRIC_BASEBOARD))
-			return 0;
-	}
-
-	if (attr == &dev_attr_gpuboard_temp.attr) {
-		if (!amdgpu_dpm_is_temp_metrics_supported(adev, SMU_TEMP_METRIC_GPUBOARD))
-			return 0;
-	}
-
-	return attr->mode;
-}
-
-const struct attribute_group amdgpu_board_attr_group = {
-	.attrs = board_attrs,
-	.is_visible = amdgpu_board_attr_visible,
-};
-
 /* pm policy attributes */
 struct amdgpu_pm_policy_attr {
 	struct device_attribute dev_attr;
@@ -4805,18 +4776,12 @@ static struct kobject *amdgpu_board_kobj_create(struct amdgpu_device *adev)
 	board->adev = adev;
 	ret = kobject_init_and_add(&board->kobj, &amdgpu_sysfs_ktype,
 				   &adev->dev->kobj, "board");
-	if (ret)
-		goto err_put;
-
-	ret = sysfs_create_group(&board->kobj, &amdgpu_board_attr_group);
-	if (ret)
-		goto err_put;
+	if (ret) {
+		kobject_put(&board->kobj);
+		return ERR_PTR(ret);
+	}
 
 	return &board->kobj;
-
-err_put:
-	kobject_put(&board->kobj);
-	return ERR_PTR(ret);
 }
 
 static void amdgpu_pm_kobjs_fini(struct amdgpu_device *adev)
@@ -4900,11 +4865,50 @@ static void amdgpu_pm_npm_sysfs_init(struct amdgpu_device *adev)
 	}
 }
 
+static void amdgpu_pm_board_metrics_sysfs_init(struct amdgpu_device *adev)
+{
+	static const struct {
+		struct device_attribute *attr;
+		u32 cap;
+	} files[] = {
+		{ &dev_attr_gpuboard_temp, AMDGPU_BOARD_METRICS_TEMP },
+		{ &dev_attr_baseboard_temp, AMDGPU_BOARD_METRICS_BASEBOARD_TEMP },
+		{ &dev_attr_baseboard_power, AMDGPU_BOARD_METRICS_BASEBOARD_POWER },
+		{ &dev_attr_baseboard_power_limit, AMDGPU_BOARD_METRICS_BASEBOARD_POWER },
+	};
+	u32 board_cap;
+	struct kobject *board;
+	int i, ret;
+
+	board_cap = amdgpu_dpm_get_board_metrics_cap(adev);
+	if (!board_cap)
+		return;
+
+	board = amdgpu_board_kobj_create(adev);
+	if (IS_ERR(board)) {
+		dev_err(adev->dev, "failed to create board sysfs directory\n");
+		return;
+	}
+
+	adev->pm.board_kobj = board;
+
+	for (i = 0; i < ARRAY_SIZE(files); i++) {
+		if (!(board_cap & files[i].cap))
+			continue;
+
+		ret = sysfs_create_file(adev->pm.board_kobj, &files[i].attr->attr);
+		if (ret)
+			dev_err(adev->dev, "failed to create sysfs file %s\n",
+				files[i].attr->attr.name);
+	}
+
+	amdgpu_pm_npm_sysfs_init(adev);
+}
+
 int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 {
 	enum amdgpu_sriov_vf_mode mode;
 	uint32_t mask = 0;
-	uint32_t tmp;
 	int ret;
 
 	if (adev->pm.sysfs_initialized)
@@ -4966,30 +4970,7 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 			goto err_out1;
 	}
 
-	if (amdgpu_dpm_is_temp_metrics_supported(adev, SMU_TEMP_METRIC_GPUBOARD)) {
-		struct kobject *board = amdgpu_board_kobj_create(adev);
-
-		if (IS_ERR(board)) {
-			ret = PTR_ERR(board);
-			goto err_out1;
-		}
-		adev->pm.board_kobj = board;
-
-		amdgpu_pm_npm_sysfs_init(adev);
-		if (amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_UBB_POWER_LIMIT,
-						 (void *)&tmp) != -EOPNOTSUPP) {
-			ret = sysfs_create_file(adev->pm.board_kobj,
-						&dev_attr_baseboard_power_limit.attr);
-			if (ret)
-				dev_err(adev->dev, "failed to create sysfs file %s\n",
-					dev_attr_baseboard_power_limit.attr.name);
-			ret = sysfs_create_file(adev->pm.board_kobj,
-						&dev_attr_baseboard_power.attr);
-			if (ret)
-				dev_err(adev->dev, "failed to create sysfs file %s\n",
-					dev_attr_baseboard_power.attr.name);
-		}
-	}
+	amdgpu_pm_board_metrics_sysfs_init(adev);
 
 	adev->pm.sysfs_initialized = true;
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 550d11fd7ffb..a2a76d5e734e 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -530,7 +530,7 @@ ssize_t amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void *buf,
 ssize_t amdgpu_dpm_get_xcp_metrics(struct amdgpu_device *adev, int xcp_id,
 				   void *table);
 ssize_t amdgpu_dpm_get_temp_metrics(struct amdgpu_device *adev,
-				    enum smu_temp_metric_type type, void *table);
+				    enum amdgpu_board_metrics_cap type, void *table);
 
 /**
  * @get_pm_metrics: Get one snapshot of power management metrics from PMFW. The
@@ -619,8 +619,7 @@ int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask);
 bool amdgpu_dpm_reset_sdma_is_supported(struct amdgpu_device *adev);
 int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask);
 bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_device *adev);
-bool amdgpu_dpm_is_temp_metrics_supported(struct amdgpu_device *adev,
-					  enum smu_temp_metric_type type);
+u32 amdgpu_dpm_get_board_metrics_cap(struct amdgpu_device *adev);
 u64 amdgpu_dpm_get_npm_cap(struct amdgpu_device *adev);
 int amdgpu_dpm_set_npm_limit(struct amdgpu_device *adev, uint32_t limit);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index a901f8535598..4d99ea8aa76e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -4010,21 +4010,35 @@ int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
 	return ret;
 }
 
-static ssize_t smu_sys_get_temp_metrics(void *handle, enum smu_temp_metric_type type, void *table)
+static ssize_t smu_sys_get_temp_metrics(void *handle,
+					enum amdgpu_board_metrics_cap type,
+					void *table)
 {
 	struct smu_context *smu = handle;
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_driver_table *driver_tables = smu_table->driver_tables;
+	enum smu_temp_metric_type temp_type;
 	enum smu_driver_table_id table_id;
 	struct smu_driver_table *temp_table;
 
+	switch (type) {
+	case AMDGPU_BOARD_METRICS_TEMP:
+		temp_type = SMU_TEMP_METRIC_GPUBOARD;
+		break;
+	case AMDGPU_BOARD_METRICS_BASEBOARD_TEMP:
+		temp_type = SMU_TEMP_METRIC_BASEBOARD;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	if (!smu->smu_temp.temp_funcs || !smu->smu_temp.temp_funcs->get_temp_metrics)
 		return -EOPNOTSUPP;
 
-	table_id = smu_metrics_get_temp_table_id(type);
+	table_id = smu_metrics_get_temp_table_id(temp_type);
 
 	if (table_id == SMU_DRIVER_TABLE_COUNT)
 		return -EINVAL;
@@ -4040,21 +4054,17 @@ static ssize_t smu_sys_get_temp_metrics(void *handle, enum smu_temp_metric_type
 		return temp_table->cache.size;
 	}
 
-	return smu->smu_temp.temp_funcs->get_temp_metrics(smu, type, table);
+	return smu->smu_temp.temp_funcs->get_temp_metrics(smu, temp_type, table);
 }
 
-static bool smu_temp_metrics_is_supported(void *handle, enum smu_temp_metric_type type)
+static u32 smu_get_board_metrics_cap(void *handle)
 {
 	struct smu_context *smu = handle;
-	bool ret = false;
-
-	if (!smu->pm_enabled)
-		return false;
 
-	if (smu->smu_temp.temp_funcs && smu->smu_temp.temp_funcs->temp_metrics_is_supported)
-		ret = smu->smu_temp.temp_funcs->temp_metrics_is_supported(smu, type);
+	if (!smu->pm_enabled || !smu->ppt_funcs || !smu->ppt_funcs->get_board_metrics_cap)
+		return 0;
 
-	return ret;
+	return smu->ppt_funcs->get_board_metrics_cap(smu);
 }
 
 static u64 smu_get_npm_cap(void *handle)
@@ -4153,8 +4163,8 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.get_dpm_clock_table              = smu_get_dpm_clock_table,
 	.get_smu_prv_buf_details = smu_get_prv_buffer_details,
 	.get_xcp_metrics                  = smu_sys_get_xcp_metrics,
+	.get_board_metrics_cap        = smu_get_board_metrics_cap,
 	.get_temp_metrics             = smu_sys_get_temp_metrics,
-	.temp_metrics_is_supported      = smu_temp_metrics_is_supported,
 	.set_npm_limit                = smu_set_npm_limit,
 	.get_npm_cap                  = smu_get_npm_cap,
 };
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 9d47d2ab1b49..1899ab7a04f5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -828,14 +828,6 @@ struct smu_temp_funcs {
 	 */
 	ssize_t (*get_temp_metrics)(struct smu_context *smu,
 				    enum smu_temp_metric_type type, void *table);
-
-	/**
-	 * @temp_metrics_is_support: Get if specific temperature metrics is supported
-	 * @type Temperature metrics type(baseboard/gpuboard)
-	 * Return: true if supported else false
-	 */
-	bool (*temp_metrics_is_supported)(struct smu_context *smu, enum smu_temp_metric_type type);
-
 };
 
 /**
@@ -1621,6 +1613,13 @@ struct pptable_funcs {
 	 */
 	ssize_t (*get_xcp_metrics)(struct smu_context *smu, int xcp_id,
 				   void *table);
+	/**
+	 * @get_board_metrics_cap: Return board metrics capability bits.
+	 *
+	 * OR of AMDGPU_BOARD_METRICS_* values. Zero means board/ is not created.
+	 */
+	u32 (*get_board_metrics_cap)(struct smu_context *smu);
+
 	/**
 	 * @get_npm_cap: Return NPM sysfs capability bitmap.
 	 *
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 1691a0be4f7d..9d8470c6ac16 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -598,23 +598,27 @@ static enum amdgpu_system_temp smu_v13_0_12_get_system_sensor_type(SYSTEM_TEMP_e
 	}
 }
 
-static bool smu_v13_0_12_is_temp_metrics_supported(struct smu_context *smu,
-						   enum smu_temp_metric_type type)
+u32 smu_v13_0_12_get_board_metrics_cap(struct smu_context *smu)
 {
-	switch (type) {
-	case SMU_TEMP_METRIC_BASEBOARD:
-		if (smu->adev->gmc.xgmi.physical_node_id == 0 &&
-		    smu->adev->gmc.xgmi.num_physical_nodes > 1 &&
-		    smu_v13_0_6_cap_supported(smu, SMU_CAP(TEMP_METRICS)))
-			return true;
-		break;
-	case SMU_TEMP_METRIC_GPUBOARD:
-		return smu_v13_0_6_cap_supported(smu, SMU_CAP(TEMP_METRICS));
-	default:
-		break;
-	}
+	u32 cap = 0;
+	bool temp;
+
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) != IP_VERSION(13, 0, 12))
+		return 0;
 
-	return false;
+	temp = smu_v13_0_6_cap_supported(smu, SMU_CAP(TEMP_METRICS));
+	if (temp)
+		cap |= AMDGPU_BOARD_METRICS_TEMP;
+	if (temp &&
+	    smu->adev->gmc.xgmi.physical_node_id == 0 &&
+	    smu->adev->gmc.xgmi.num_physical_nodes > 1)
+		cap |= AMDGPU_BOARD_METRICS_BASEBOARD_TEMP;
+	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(SYSTEM_POWER_METRICS)))
+		cap |= AMDGPU_BOARD_METRICS_BASEBOARD_POWER;
+	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(NPM_METRICS)))
+		cap |= AMDGPU_BOARD_METRICS_NPM;
+
+	return cap;
 }
 
 int smu_v13_0_12_get_system_power(struct smu_context *smu,
@@ -1035,6 +1039,5 @@ void smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table,
 }
 
 const struct smu_temp_funcs smu_v13_0_12_temp_funcs = {
-	.temp_metrics_is_supported = smu_v13_0_12_is_temp_metrics_supported,
 	.get_temp_metrics = smu_v13_0_12_get_temp_metrics,
 };
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 95e288327e45..41885b972d14 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3314,6 +3314,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.get_pm_metrics = smu_v13_0_6_get_pm_metrics,
 	.get_xcp_metrics = smu_v13_0_6_get_xcp_metrics,
 	.get_npm_cap = smu_v13_0_12_get_npm_cap,
+	.get_board_metrics_cap = smu_v13_0_12_get_board_metrics_cap,
 	.get_thermal_temperature_range = smu_v13_0_6_get_thermal_temperature_range,
 	.mode1_reset_is_support = smu_v13_0_6_is_mode1_reset_supported,
 	.mode1_reset = smu_v13_0_6_mode1_reset,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 1b6926625cc3..a2632ffcc2ec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -112,6 +112,7 @@ int smu_v13_0_12_get_npm_data(struct smu_context *smu,
 			      enum amd_pp_sensors sensor,
 			      uint32_t *value);
 u64 smu_v13_0_12_get_npm_cap(struct smu_context *smu);
+u32 smu_v13_0_12_get_board_metrics_cap(struct smu_context *smu);
 int smu_v13_0_12_get_system_power(struct smu_context *smu,
 				  enum amd_pp_sensors sensor,
 				  uint32_t *value);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index ef6f0a0e3973..f427efa23c4c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -1584,19 +1584,16 @@ static int smu_v15_0_8_mode2_reset(struct smu_context *smu)
 	return ret;
 }
 
-static bool smu_v15_0_8_is_temp_metrics_supported(struct smu_context *smu,
-						  enum smu_temp_metric_type type)
+static u32 smu_v15_0_8_get_board_metrics_cap(struct smu_context *smu)
 {
-	switch (type) {
-	case SMU_TEMP_METRIC_BASEBOARD:
-		if (smu->adev->gmc.xgmi.physical_node_id == 0)
-			return true;
-		return false;
-	case SMU_TEMP_METRIC_GPUBOARD:
-		return true;
-	default:
-		return false;
-	}
+	u32 cap = AMDGPU_BOARD_METRICS_TEMP;
+
+	if (smu->adev->gmc.xgmi.physical_node_id == 0)
+		cap |= AMDGPU_BOARD_METRICS_BASEBOARD_TEMP;
+	if (smu_v15_0_8_cap_supported(smu, SMU_15_0_8_CAP_NPM))
+		cap |= AMDGPU_BOARD_METRICS_NPM;
+
+	return cap;
 }
 
 static void smu_v15_0_8_fill_baseboard_temp_metrics(
@@ -2523,6 +2520,7 @@ static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.get_gpu_metrics = smu_v15_0_8_get_gpu_metrics,
 	.get_unique_id = smu_v15_0_8_get_unique_id,
 	.get_ppt_limit = smu_v15_0_8_get_ppt_limit,
+	.get_board_metrics_cap = smu_v15_0_8_get_board_metrics_cap,
 	.set_ppt_limit = smu_v15_0_8_set_ppt_limit,
 	.get_npm_cap = smu_v15_0_8_get_npm_cap,
 	.set_npm_limit = smu_v15_0_8_set_npm_limit,
@@ -2555,7 +2553,6 @@ static void smu_v15_0_8_init_msg_ctl(struct smu_context *smu,
 }
 
 static const struct smu_temp_funcs smu_v15_0_8_temp_funcs = {
-	.temp_metrics_is_supported = smu_v15_0_8_is_temp_metrics_supported,
 	.get_temp_metrics = smu_v15_0_8_get_temp_metrics,
 };
 
-- 
2.46.0

