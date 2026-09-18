Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32980C88E75
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 03:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0E7710E080;
	Fri, 18 Sep 2026 03:58:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZJ0FHAz0";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010026.outbound.protection.outlook.com
 [40.93.198.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63D8810E080
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 03:58:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjarWVSHaP/mL0dfN57chq9v4lX4igK5dKul9/5YtKoKQ1k+JixYCK8amXjWoNDvDwQKBvW2hKD6lYEye934IHZr4c4i6r7PPeql88RgkhMa7gv/WqeDpb3twSUBsLSUg7Nzr/YoBMXQYgJRMAaqlwFR/ZzTrUuv61dEAVEzICO1Tcw/MpIVO2cnTMjskO09D5HWHgT7xUsJlrehCVjlOmx2S+gx99g9Qd8DDnh6RhhmfbynLHBHDeinjBMMd2jbw/+x9Dt9UHglMeNevjDR2c+p1DtA6JZs9xKvkBnjExXIQxrHIK06+Fra705AflmOb/NDMrZa60F/kl13MR30NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jx5k94EJOjgswDtRhbynXK/eyEdeoXyNdNZdlLVGuFI=;
 b=RloxQ6RXXIJat14afVgycuEd9LNfntA/fssWrbJihclyV0FcEVLPKV53m+U1KE4TSSrmGyXdBKMuF/w4NG11DiLT+FjZn3SNZiRxXEIvP3cnWNlQT0L9bM0kfhnQuqFdWLIQT9Slwm1lJabRiu325dKCDAEFSISRDTneJ8vCWpwelBUE5/GkUcufdr/lRlBF+nYt1axtfTW8vHZ0L6i54kMvHaaABq2eI1IdAUs/eyz2OwnMAd3eLh4ZKqrSh8AZFZ25RwYPbeHlyqQ1pkx7E4ht6/OJ723wdVEyU93Kq8wcre7W2MKm6gdZUnjiK579IXSGjLtmFdXV2mR874nXPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jx5k94EJOjgswDtRhbynXK/eyEdeoXyNdNZdlLVGuFI=;
 b=ZJ0FHAz0hfzYadKxPJbiGjAQqRPhr1Rs5JRdEZr8Dikro/yLEB3QApLzHuyS+ne04Z5zlAbnmUEI4hn0pMvKkv43TOf3DynpUe6DWHEm+O6K6d/vA5WAVcuToTNAVzKAFdmvu1QUhC33NlFLe45UM5cyO4r6NPCa4RowzxfautQ=
Received: from LV3P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::27)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Fri, 18 Sep
 2026 03:58:46 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:234:cafe::4a) by LV3P220CA0026.outlook.office365.com
 (2603:10b6:408:234::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Fri,
 18 Sep 2026 03:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 03:58:45 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 22:58:27 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Create NPM sysfs files from capability
Date: Fri, 18 Sep 2026 09:28:05 +0530
Message-ID: <20260918035805.1786646-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|BY5PR12MB4082:EE_
X-MS-Office365-Filtering-Correlation-Id: 6959494a-7e0a-475f-6794-08df15392346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 81zOeYx4J9p+SfiitfoZmcUIufCXKjXwDpz/uEBlrzWNwrMDbFpZ8mX8oRlKA5oKlBF3fF8+nn/jyiTLIFJCipCMA27bSmiqHtiefBrGt+ysuvfk39wGRP7MfLnXiwBNjMQ/DGuGb4cWVwxiqLEevAABhv0SgXIdxtnfuMeovznbb5fIgPcgi67+MNDaWmSHouhT0D2X6GxrjnER76o6J0TCSihulkqXyhiJ32mpaFiG0EGKtf+RsM+uRQ7M63fH1/EDPIzfo56K16AoQ8TKYWlaz3HSDnZkFi6t3kDuRtPo50POi9YrYxgnw+U1iqSLHqtWzfoFopFo1xN4yWUXwzpnDu7KCCt1597nyOWa02ifrrMRz79AfhD0TrihVBXFOPPGDlBMY73xRP9uT8J+5D/bbsQ6wwFnAFoO5cpneIfxTkQhfRcIijXT+Bh2vE7Kf4X3OjiSyanSf7cIjTfMCVXbzRTKoij6M8i5vpsR12l+l4sL4SLf0xgEhbe4t8pi9PV6Mjjo8f2EZAIuxzCdezd/hG8CVddXlrDyp7Mv19t2EGvpRts2ELF2BEdH8JSzy10i7u38ynk9zjxhacbmgwgd0b6zxoFs4WMLKSr2qCxIp+6EfQ57EPPbO4UkooJGgLckzzkr89ceeaRfbvH4KtRLspc7M13vsDp5Nx+m0jxf2xyolgGzmsV+nygXtau2M8cItTNYruPuMEbsj3VlyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lE8iO3Dbd9SOlsbvMj1/iOoqh8LJPW0MRqtAyUpi1+DRYaT/rNC5nt6C6iA4ycpS+hnkwXFC5NLWs0sLWfP/S8PADAJoZ3Jm+tHCK4Ma6UbaAJWWM5VlKPJMfCn+PZl/iMCCsIHEwE2Yv7g2AKVLXweV1T5iXmqQ4ulgL4w1IGAdGhHV6S0yXWJP7A1Kq+owWYvfLO9bahmx6jT99e9n0dzJjoqIN9tY95ecDcLU+IdLcE2IS90UKIjkGrVyY7R5KvyLd7KAdHrLmbMDJACb1+iqoTu40dF3a/D6ujLgxmchvseROgQviJtHr+V/ajl0e0sxj1v9AC/+dtmlTQARBrxYlzHQK04kG3EpO68yjxjR9zgwkq+n8+9DHX2uiTBN/znx9rfPlKYemOGc+GXdfp6TV3rIvwZD1Nzr86EnHVDQxmJqZWZvfQ2mYoQ9RK5/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 03:58:45.8597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6959494a-7e0a-475f-6794-08df15392346
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
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

Advertise each NPM board attribute from a per-field R/W bitmap instead of
probing a single sensor. SMU 13.0.6/13.0.12 reports the cap only when NPM
metrics and MaxNodePowerLimit are present.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Assisted-by: Cursor Grok 4.6
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 16 +++++++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 23 +++++++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 47 +++++++++++++------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 11 +++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  7 +++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 19 ++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |  1 +
 9 files changed, 111 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 606d48115301..5e8476c4b808 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -174,6 +174,21 @@ enum amd_pp_sensors {
 	AMDGPU_PP_SENSOR_UBB_POWER_LIMIT,
 };
 
+/*
+ * NPM sysfs capability bitmap: two bits per field, R then W.
+ * 00 = unsupported, 01 = read-only, 1x = writable (or RW).
+ */
+enum amdgpu_npm_cap_field {
+	AMDGPU_NPM_CAP_CUR_NODE_POWER_LIMIT,
+	AMDGPU_NPM_CAP_NODE_POWER,
+	AMDGPU_NPM_CAP_GLOBAL_PPT_RESID,
+	AMDGPU_NPM_CAP_MAX_NODE_POWER_LIMIT,
+	AMDGPU_NPM_CAP_NPM_STATUS,
+};
+
+#define AMDGPU_NPM_CAP_R(field)	BIT_ULL((field) * 2)
+#define AMDGPU_NPM_CAP_W(field)	BIT_ULL((field) * 2 + 1)
+
 enum amd_pp_task {
 	AMD_PP_TASK_DISPLAY_CONFIG_CHANGE,
 	AMD_PP_TASK_ENABLE_USER_STATE,
@@ -513,6 +528,7 @@ struct amd_pm_funcs {
 	ssize_t (*get_gpu_metrics)(void *handle, void **table);
 	ssize_t (*get_temp_metrics)(void *handle, enum smu_temp_metric_type type, void *table);
 	bool (*temp_metrics_is_supported)(void *handle, enum smu_temp_metric_type type);
+	u64 (*get_npm_cap)(void *handle);
 	ssize_t (*get_xcp_metrics)(void *handle, int xcp_id, void *table);
 	ssize_t (*get_pm_metrics)(void *handle, void *pmmetrics, size_t size);
 	int (*set_watermarks_for_clock_ranges)(void *handle,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index c70fd6691461..df5bbdab1ea3 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -2101,6 +2101,29 @@ bool amdgpu_dpm_is_temp_metrics_supported(struct amdgpu_device *adev,
 	return support_temp_metrics;
 }
 
+/**
+ * amdgpu_dpm_get_npm_cap - Return NPM sysfs capability bitmap
+ * @adev: Pointer to the device.
+ *
+ * Two bits per field (R then W). Both 0 means the field is unsupported.
+ *
+ * Return: Capability bitmap, or 0 if NPM is not supported.
+ */
+u64 amdgpu_dpm_get_npm_cap(struct amdgpu_device *adev)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	u64 cap = 0;
+
+	if (!pp_funcs || !pp_funcs->get_npm_cap)
+		return 0;
+
+	mutex_lock(&adev->pm.mutex);
+	cap = pp_funcs->get_npm_cap(adev->powerplay.pp_handle);
+	mutex_unlock(&adev->pm.mutex);
+
+	return cap;
+}
+
 /**
  * amdgpu_dpm_get_xcp_metrics - Retrieve metrics for a specific compute
  * partition
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index c0e677328af5..6f8252376127 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -4726,6 +4726,37 @@ static int amdgpu_od_set_init(struct amdgpu_device *adev)
 	return ret;
 }
 
+static void amdgpu_pm_npm_sysfs_init(struct amdgpu_device *adev)
+{
+	static const struct {
+		struct device_attribute *attr;
+		unsigned int field;
+	} files[] = {
+		{ &dev_attr_cur_node_power_limit, AMDGPU_NPM_CAP_CUR_NODE_POWER_LIMIT },
+		{ &dev_attr_node_power, AMDGPU_NPM_CAP_NODE_POWER },
+		{ &dev_attr_global_ppt_resid, AMDGPU_NPM_CAP_GLOBAL_PPT_RESID },
+		{ &dev_attr_max_node_power_limit, AMDGPU_NPM_CAP_MAX_NODE_POWER_LIMIT },
+		{ &dev_attr_npm_status, AMDGPU_NPM_CAP_NPM_STATUS },
+	};
+	u64 cap = amdgpu_dpm_get_npm_cap(adev);
+	int i;
+
+	if (!cap)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(files); i++) {
+		unsigned int bits = (cap >> (files[i].field * 2)) & 0x3;
+		struct device_attribute *attr = files[i].attr;
+
+		if (!bits)
+			continue;
+
+		attr->attr.mode = ((bits & BIT(1)) && attr->store) ? 0644 : 0444;
+		sysfs_add_file_to_group(&adev->dev->kobj, &attr->attr,
+					amdgpu_board_attr_group.name);
+	}
+}
+
 int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 {
 	enum amdgpu_sriov_vf_mode mode;
@@ -4797,21 +4828,7 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 					    &amdgpu_board_attr_group);
 		if (ret)
 			goto err_out1;
-		if (amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_MAXNODEPOWERLIMIT,
-						 (void *)&tmp) != -EOPNOTSUPP) {
-			sysfs_add_file_to_group(&adev->dev->kobj,
-						&dev_attr_cur_node_power_limit.attr,
-						amdgpu_board_attr_group.name);
-			sysfs_add_file_to_group(&adev->dev->kobj, &dev_attr_node_power.attr,
-						amdgpu_board_attr_group.name);
-			sysfs_add_file_to_group(&adev->dev->kobj, &dev_attr_global_ppt_resid.attr,
-						amdgpu_board_attr_group.name);
-			sysfs_add_file_to_group(&adev->dev->kobj,
-						&dev_attr_max_node_power_limit.attr,
-						amdgpu_board_attr_group.name);
-			sysfs_add_file_to_group(&adev->dev->kobj, &dev_attr_npm_status.attr,
-						amdgpu_board_attr_group.name);
-		}
+		amdgpu_pm_npm_sysfs_init(adev);
 		if (amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_UBB_POWER_LIMIT,
 						 (void *)&tmp) != -EOPNOTSUPP) {
 			sysfs_add_file_to_group(&adev->dev->kobj,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 8e8a052e1d53..ed1e7385243d 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -614,5 +614,6 @@ int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask);
 bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_device *adev);
 bool amdgpu_dpm_is_temp_metrics_supported(struct amdgpu_device *adev,
 					  enum smu_temp_metric_type type);
+u64 amdgpu_dpm_get_npm_cap(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 4290a4872f3b..0a6daff8766f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -4002,6 +4002,16 @@ static bool smu_temp_metrics_is_supported(void *handle, enum smu_temp_metric_typ
 	return ret;
 }
 
+static u64 smu_get_npm_cap(void *handle)
+{
+	struct smu_context *smu = handle;
+
+	if (!smu->pm_enabled || !smu->ppt_funcs || !smu->ppt_funcs->get_npm_cap)
+		return 0;
+
+	return smu->ppt_funcs->get_npm_cap(smu);
+}
+
 static ssize_t smu_sys_get_xcp_metrics(void *handle, int xcp_id, void *table)
 {
 	struct smu_context *smu = handle;
@@ -4076,6 +4086,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.get_xcp_metrics                  = smu_sys_get_xcp_metrics,
 	.get_temp_metrics             = smu_sys_get_temp_metrics,
 	.temp_metrics_is_supported      = smu_temp_metrics_is_supported,
+	.get_npm_cap                  = smu_get_npm_cap,
 };
 
 int smu_wait_for_event(struct smu_context *smu, enum smu_event_type event,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index ab43a5cd0dcd..76625cac74cb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1620,6 +1620,13 @@ struct pptable_funcs {
 	 */
 	ssize_t (*get_xcp_metrics)(struct smu_context *smu, int xcp_id,
 				   void *table);
+	/**
+	 * @get_npm_cap: Return NPM sysfs capability bitmap.
+	 *
+	 * Two bits per field (R then W). Both 0 means the field is
+	 * unsupported.
+	 */
+	u64 (*get_npm_cap)(struct smu_context *smu);
 	/**
 	 * @ras_send_msg: Send a message with a parameter from Ras
 	 * &msg: Type of message.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index d8ddad531d26..0ca5973391e8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -695,6 +695,25 @@ int smu_v13_0_12_get_npm_data(struct smu_context *smu,
 	return ret;
 }
 
+u64 smu_v13_0_12_get_npm_cap(struct smu_context *smu)
+{
+	struct PPTable_t *pptable =
+		(struct PPTable_t *)smu->smu_table.driver_pptable;
+	u64 cap = 0;
+
+	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(NPM_METRICS)) ||
+	    !pptable->MaxNodePowerLimit)
+		return 0;
+
+	cap |= AMDGPU_NPM_CAP_R(AMDGPU_NPM_CAP_CUR_NODE_POWER_LIMIT);
+	cap |= AMDGPU_NPM_CAP_R(AMDGPU_NPM_CAP_NODE_POWER);
+	cap |= AMDGPU_NPM_CAP_R(AMDGPU_NPM_CAP_GLOBAL_PPT_RESID);
+	cap |= AMDGPU_NPM_CAP_R(AMDGPU_NPM_CAP_MAX_NODE_POWER_LIMIT);
+	cap |= AMDGPU_NPM_CAP_R(AMDGPU_NPM_CAP_NPM_STATUS);
+
+	return cap;
+}
+
 static ssize_t smu_v13_0_12_get_temp_metrics(struct smu_context *smu,
 					     enum smu_temp_metric_type type, void *table)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ee380488d212..83a5a4614a4b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3312,6 +3312,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.get_gpu_metrics = smu_v13_0_6_get_gpu_metrics,
 	.get_pm_metrics = smu_v13_0_6_get_pm_metrics,
 	.get_xcp_metrics = smu_v13_0_6_get_xcp_metrics,
+	.get_npm_cap = smu_v13_0_12_get_npm_cap,
 	.get_thermal_temperature_range = smu_v13_0_6_get_thermal_temperature_range,
 	.mode1_reset_is_support = smu_v13_0_6_is_mode1_reset_supported,
 	.mode1_reset = smu_v13_0_6_mode1_reset,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 6554780afff7..1b6926625cc3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -111,6 +111,7 @@ void smu_v13_0_12_tables_fini(struct smu_context *smu);
 int smu_v13_0_12_get_npm_data(struct smu_context *smu,
 			      enum amd_pp_sensors sensor,
 			      uint32_t *value);
+u64 smu_v13_0_12_get_npm_cap(struct smu_context *smu);
 int smu_v13_0_12_get_system_power(struct smu_context *smu,
 				  enum amd_pp_sensors sensor,
 				  uint32_t *value);
-- 
2.49.0

