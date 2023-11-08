Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F68C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 04:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9B7710E385;
	Wed,  8 Nov 2023 04:22:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9EA210E37F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 04:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+O6w5QL64iTV2RnHonCff6ochppL52HatFLVO+gZis1UJrf24PcikSw2s4YPTMTMZSNzvBO81UjJHnd6kmorneWj3iw5MdDs2SOpMs9S/QpMn9QisyRfQJ9NKQhk2+ryLbNe8NVp5nXSoVdcXfN5lM/LmLIcRjG8LJH4jo8Dbry3DlduYrsTrRJrJUmaRvthnaFY/9zUVSnCAVPk+gWXy32cwyj2/SK03kmCFpqedFeADSk7fU50tNGnBNckrtMqpIarOzAoZnmxJOa3utQD7nmotUXbyGG7FsbPqndSBRwGG2CnfjI3CAz2jraO+MbHz3yBuelvlPTvjsTTFgJnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uW4MlUf8PVgZ4gSRrI3YEJ6VYNlGiD+KzYUACdHnlU=;
 b=F8fqMueY/hW2JVecpQntWY2I5+XIALIqzFle8GRgJCpVgHzDJHnwrXnPOWT9GqQbFhaIS6ERIM9BqOr1SB0WknWaFBECl5rLnhcGDx1R0wT2NqK2/tIDtMzDDhfpuOxfyHVELAkKytMyetBd787CL8xiw/TSUiiKu6axVm0SZbISgmGXU6YtXQdz0iTXDej9ECLX45vLAv+xYWsXtnRE4m74ExX7iyHOArICOUmOrj5bz7Tat3uXUDGWGNCs69hKl8+vArEI/VjxzpbjlgqFArO613iripRb2N2dK/IsjgTUcE90o0n6f9xQ+P9TGmM87d+YIs2NzyF4PDiPE1D7dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uW4MlUf8PVgZ4gSRrI3YEJ6VYNlGiD+KzYUACdHnlU=;
 b=ZiNSz+rmrsZvX4UPn2qgG/D80gpH0gyWnH0eGqiGWvtcJNFTTeaiPFwgxKETqFyZJjE6bVkVKNw+UrJ5l81FYR0Saf7aplDazWrg9kGHEfWp/q9t4JdN/VrlVirfpJN5y/XBQJPeO4HrI7nHwA/x1j84s76cjbP2CxgGu02zVcM=
Received: from CH5P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::10)
 by SN7PR12MB8436.namprd12.prod.outlook.com (2603:10b6:806:2e3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 04:22:28 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::5d) by CH5P223CA0002.outlook.office365.com
 (2603:10b6:610:1f3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29 via Frontend
 Transport; Wed, 8 Nov 2023 04:22:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 04:22:27 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 22:22:25 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/4] drm/amd/pm: Add support to fetch pm metrics sample
Date: Wed, 8 Nov 2023 09:52:05 +0530
Message-ID: <20231108042207.528357-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231108042207.528357-1-lijo.lazar@amd.com>
References: <20231108042207.528357-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|SN7PR12MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: b5933e22-73f4-4455-8214-08dbe012511b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tasGPxgC/rynN/wdDM4R4zoTzeX3Wu3fH/49lVE71nlRqtTvDQbeRleOD6e+aMB6xv5aawndZ/AsUYkxzQ3urmm0E7C+rwxaNiylmIhg15feuRixL6u56HcyQ0khvyOQJ4T6rqCdLNV2HrHvSYkm/Mx47KTtj7U1x5EbIYoD7yNiWdB7gUdnCvTLbLT7goBG5Amnr+5S9GZ86xy7StEIek/Udtu/iB+I64ADGWOlvV4VRyHrucNv4bN+EL201z4EKWpawhO01ruklF5sVT2o8iT5/LiEdH4hPqH9rHStXk8TvLj3upOtPQ64sS/LTf8YVpXxqNQaZHdDCA9Gqi4du4uS3hlIzdscuopdkwHh0+wH0KwRJzkBxlsEhH0UWj0SCUcdghfSGPl9IreX0HXZvjSCrAjJcWLDb686+mdX8vmXgM0gI/vxHH6n1WtXDvevgwHC/2UywMO3lG2CFUx03SJ6IyIUXk6KZFDsRLGKCtBEeuSOFkBeDxyWSNI8Jr+zhhbELNSIYkJQPg9TjXrbA5RPk6ecWM6fjC8yscmfcA9reFRwQ8pps1Rxm4pbRvgivik133RbSgq2EoXy4no+XPZ0z1sKJRW8uMhEiVZbuPwYrkHGlgTEHjendrtgOngUxSx8il4mPaDKrp4+n7SbXg3ey/8sx6G9QB6JE7xm6kopPyQBFb5g8GY0+pqSXem9YGVxkD87OVxOXIDOExPUjedb/tpDQiqJnk0sqqgbRmsjzptxgcjhR9z4vFsTWYa9CfRKJJEWraVEHUpE/JsIYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(82310400011)(186009)(46966006)(36840700001)(40470700004)(2906002)(40480700001)(5660300002)(4326008)(8936002)(8676002)(81166007)(356005)(86362001)(41300700001)(47076005)(83380400001)(36860700001)(82740400003)(336012)(426003)(2616005)(70206006)(70586007)(44832011)(1076003)(316002)(40460700003)(54906003)(6916009)(7696005)(6666004)(16526019)(26005)(36756003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 04:22:27.7066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5933e22-73f4-4455-8214-08dbe012511b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8436
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
Cc: Alexander.Deucher@amd.com, kevinyang.wang@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add API support to fetch a snapshot of power management metrics from PMFW.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
v2:
	Return EOPNOTSUPP if callback not implemented (KevinYang)

 drivers/gpu/drm/amd/include/kgd_pp_interface.h |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c            | 17 +++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h        | 12 ++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 15 +++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h  | 10 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h   |  3 ++-
 6 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index f9c438d16c56..6a1d31e8fdd1 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -431,6 +431,7 @@ struct amd_pm_funcs {
 	int (*set_df_cstate)(void *handle, enum pp_df_cstate state);
 	int (*set_xgmi_pstate)(void *handle, uint32_t pstate);
 	ssize_t (*get_gpu_metrics)(void *handle, void **table);
+	ssize_t (*get_pm_metrics)(void *handle, void *pmmetrics, size_t size);
 	int (*set_watermarks_for_clock_ranges)(void *handle,
 					       struct pp_smu_wm_range_sets *ranges);
 	int (*display_disable_memory_clock_switch)(void *handle,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 1ae3b81548fa..4717884a2bc4 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1299,6 +1299,23 @@ int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void **table)
 	return ret;
 }
 
+ssize_t amdgpu_dpm_get_pm_metrics(struct amdgpu_device *adev, void *pm_metrics,
+				  size_t size)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
+
+	if (!pp_funcs->get_pm_metrics)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->get_pm_metrics(adev->powerplay.pp_handle, pm_metrics,
+				       size);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
+}
+
 int amdgpu_dpm_get_fan_control_mode(struct amdgpu_device *adev,
 				    uint32_t *fan_mode)
 {
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index feccd2a7120d..9b3fef5474b1 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -511,6 +511,18 @@ int amdgpu_dpm_get_power_profile_mode(struct amdgpu_device *adev,
 int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device *adev,
 				      long *input, uint32_t size);
 int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void **table);
+
+/**
+ * @get_pm_metrics: Get one snapshot of power management metrics from PMFW. The
+ * sample is copied to pm_metrics buffer. It's expected to be allocated by the
+ * caller and size of the allocated buffer is passed. Max size expected for a
+ * metrics sample is 4096 bytes.
+ *
+ * Return: Actual size of the metrics sample
+ */
+ssize_t amdgpu_dpm_get_pm_metrics(struct amdgpu_device *adev, void *pm_metrics,
+				  size_t size);
+
 int amdgpu_dpm_get_fan_control_mode(struct amdgpu_device *adev,
 				    uint32_t *fan_mode);
 int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 37c2605f9b35..930e7e3532ad 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3189,6 +3189,20 @@ static ssize_t smu_sys_get_gpu_metrics(void *handle, void **table)
 	return smu->ppt_funcs->get_gpu_metrics(smu, table);
 }
 
+static ssize_t smu_sys_get_pm_metrics(void *handle, void *pm_metrics,
+				      size_t size)
+{
+	struct smu_context *smu = handle;
+
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
+	if (!smu->ppt_funcs->get_pm_metrics)
+		return -EOPNOTSUPP;
+
+	return smu->ppt_funcs->get_pm_metrics(smu, pm_metrics, size);
+}
+
 static int smu_enable_mgpu_fan_boost(void *handle)
 {
 	struct smu_context *smu = handle;
@@ -3330,6 +3344,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.set_df_cstate                    = smu_set_df_cstate,
 	.set_xgmi_pstate                  = smu_set_xgmi_pstate,
 	.get_gpu_metrics                  = smu_sys_get_gpu_metrics,
+	.get_pm_metrics                   = smu_sys_get_pm_metrics,
 	.set_watermarks_for_clock_ranges     = smu_set_watermarks_for_clock_ranges,
 	.display_disable_memory_clock_switch = smu_display_disable_memory_clock_switch,
 	.get_max_sustainable_clocks_by_dc    = smu_get_max_sustainable_clocks_by_dc,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 8def291b18bc..32600ba74bf1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -253,6 +253,7 @@ struct smu_table {
 	uint64_t mc_address;
 	void *cpu_addr;
 	struct amdgpu_bo *bo;
+	uint32_t version;
 };
 
 enum smu_perf_level_designation {
@@ -1252,6 +1253,15 @@ struct pptable_funcs {
 	 */
 	ssize_t (*get_gpu_metrics)(struct smu_context *smu, void **table);
 
+	/**
+	 * @get_pm_metrics: Get one snapshot of power management metrics from
+	 * PMFW.
+	 *
+	 * Return: Size of the metrics sample
+	 */
+	ssize_t (*get_pm_metrics)(struct smu_context *smu, void *pm_metrics,
+				  size_t size);
+
 	/**
 	 * @enable_mgpu_fan_boost: Enable multi-GPU fan boost.
 	 */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 9dd47d91093e..ea8ea99b7436 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -259,7 +259,8 @@
 	__SMU_DUMMY_MAP(PowerUpUmsch),	\
 	__SMU_DUMMY_MAP(PowerDownUmsch),	\
 	__SMU_DUMMY_MAP(SetSoftMaxVpe),	\
-	__SMU_DUMMY_MAP(SetSoftMinVpe),
+	__SMU_DUMMY_MAP(SetSoftMinVpe), \
+	__SMU_DUMMY_MAP(GetMetricsVersion),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
-- 
2.25.1

