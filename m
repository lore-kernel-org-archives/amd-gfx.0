Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF32E92FE4
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 05:22:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A53EF10E0A2;
	Fri,  6 Oct 2023 05:22:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A50FB10E0A2
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 05:22:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFq35HWCCLMYtTLpf2eru9CzdU6Nd9+mMWxY8zPWrqO1M5gz927fiquJdQEtsdmg5RoeO4Qhw26yn6HwjKf8uw6/0EY3afqOh8WjwF0Ctpli39gAMKzCzvzRH1E+gWa3pAVT7xPC6iKlLvmxu0PyFelBgO+6SSUtQHy2R3zwV4AmhoxdJWvdrwVyoyqElvy+6BvJ2pSa++3Z/sChFNkKSlHJhMr8AhIO/wxTB8F4S2UxxbwBnM1rWF3zyFeWYCVoxbmvkcnMjIwcm/gUMZq/3sw52WAe4dsRxsICauKsaOO4bRaU5GBbz1ZvxxgjxrzQTvfjyZDifCB3Dz5PC8pXJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNWkNOknIBkibUmUCrzNvSwwJZ3uEn3qEvAbn/YoOvk=;
 b=YZZAfHMigiSsi6n2SX1Bm7lfztCvlS4V/bohl41R2hm5b+3txFE9dJR/pV16BfnPN7W3QmwkITc+5dYcRK4tlRXC62InPBj5jqfyURWkZdpygJ9w2z9V2qCRuquiS1tMREW31zzMQU9Y8emaKoGU2seMczhPlPpNHSjIvfrsPiQ6u+sjzim+8nfqhfZLJOiJE6EDj5VP5X9f9Y7LOQeS9dnFIPKW2ckAbK5MOLymxKchuGhWwuDYXerA98kSKDOLqALjI5OIRclvfZzj/Ddt/I1Lg1FthG1R5lIz4/O6tyjr91fLP5sHip4Pe1K0EnctZgraNd09mTUokQpFmxexQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNWkNOknIBkibUmUCrzNvSwwJZ3uEn3qEvAbn/YoOvk=;
 b=LW3mlguYvFznT8Bi7bdE4iQfAI/xBsm4/L7+B2qF2wzP0gJ/lPP+K6jNhikXPoCeyMzmOiQd2iAxopzOZcbm8MxqHoK5SDRkZYDRiv5Nvxu5xbZlEdXiFwlih/GtYqscWSj3UYWZOAgBNsbMZguAsGlSR3ffiWqysx2PS+5i4is=
Received: from SN4PR0501CA0065.namprd05.prod.outlook.com
 (2603:10b6:803:41::42) by PH8PR12MB6913.namprd12.prod.outlook.com
 (2603:10b6:510:1ca::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Fri, 6 Oct
 2023 05:22:09 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:803:41:cafe::31) by SN4PR0501CA0065.outlook.office365.com
 (2603:10b6:803:41::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Fri, 6 Oct 2023 05:22:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 05:22:09 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 00:22:07 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/4] drm/amd/pm: Add support to fetch pm log sample
Date: Fri, 6 Oct 2023 10:51:47 +0530
Message-ID: <20231006052149.1566154-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231006052149.1566154-1-lijo.lazar@amd.com>
References: <20231006052149.1566154-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|PH8PR12MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: b899c10d-927b-430a-0915-08dbc62c3078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5gPRxKm/+ai0rW95+Kb5syTrkFyBe0mivW8xEEYfqXCIY2u0SGpQfMlEoOPj9fmyNW4ynPCTvngTncrmHQq/gSD7uEfAnC65kWAJCJ2hTfUuNz5dwqaAJmSmeI8acLpQBa0MbTYHiTWCW7jgbOY4fcefEbOPnckB83DEbPcTyhe+stcoxBUc9BGkxh5tLs/4KVAZqLsXoEAIKUSakTnlYIPGMxkxNe2gP1Ki4xKRy/mk8XkjPyogDbha6QY9/Z2JNhjCOBDxptguB2kk23tDINIADWU9h6YSWk8SzAqFWxJ56lV8gXlXQ6KuTUqhBPlwfTAh8o9NFNMuGDyXpBoYLXpIGvDjf9uUUI/68Qp3KoqEilOrspC4Mi1KPKKANCpXuYEAgP3NcKXIL6+bamhbT/ZBbhmEOLOXNFj6JmOru37XpwcUUUWREa+yqOEUT5kmFy/DB9Uy6F+RrB/YcqzeIYFyR689rKW89wrKyoYdJvMeeegU+f+Cyau0WeayZB8jSU4a+hkJ4ldM5WGRXTQRVvlfd8lCfgNqW7FuH3pZ0BQsLuwQQKJW7vXawGFFlyu5yUWuo3eQDwOeirilqMBCdt9Ji/HVUT1hynlNpzjY+SL4EIvUviexy0yFncNnCbISm96TQTuf3y49gE4UhABz01069JILqBXHl6ivjvro/qp3CzJhx7O8O+rG6tSr8JKhOkNE1w22/weXikaWY/8UiR3G7s3wLqUoAEBfZOsqLi/k/vJQoTGtJH/jFBPucYaXHfUaZDT8CiKiZwhHL41Tdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(186009)(451199024)(1800799009)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(426003)(2616005)(478600001)(7696005)(26005)(41300700001)(83380400001)(8676002)(6666004)(54906003)(8936002)(47076005)(6916009)(5660300002)(316002)(70206006)(44832011)(70586007)(4326008)(2906002)(36756003)(81166007)(40460700003)(16526019)(356005)(336012)(86362001)(1076003)(36860700001)(82740400003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 05:22:09.6309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b899c10d-927b-430a-0915-08dbc62c3078
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6913
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

Add API support to fetch a snapshot of power management log from PMFW.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---

v2: Add max size of input buffer to take care of overflows

 drivers/gpu/drm/amd/include/kgd_pp_interface.h |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c            | 16 ++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h        | 11 +++++++++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 14 ++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h  |  8 ++++++++
 5 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 9905228fd89c..01eaafafd3c3 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -426,6 +426,7 @@ struct amd_pm_funcs {
 	int (*set_df_cstate)(void *handle, enum pp_df_cstate state);
 	int (*set_xgmi_pstate)(void *handle, uint32_t pstate);
 	ssize_t (*get_gpu_metrics)(void *handle, void **table);
+	ssize_t (*get_pm_log)(void *handle, void *pmlog, size_t size);
 	int (*set_watermarks_for_clock_ranges)(void *handle,
 					       struct pp_smu_wm_range_sets *ranges);
 	int (*display_disable_memory_clock_switch)(void *handle,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 1b17a71ed45e..1db899485309 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1300,6 +1300,22 @@ int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void **table)
 	return ret;
 }
 
+ssize_t amdgpu_dpm_get_pm_log(struct amdgpu_device *adev, void *pm_log,
+			      size_t size)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
+
+	if (!pp_funcs->get_pm_log)
+		return 0;
+
+	mutex_lock(&adev->pm.mutex);
+	ret = pp_funcs->get_pm_log(adev->powerplay.pp_handle, pm_log, size);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
+}
+
 int amdgpu_dpm_get_fan_control_mode(struct amdgpu_device *adev,
 				    uint32_t *fan_mode)
 {
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index feccd2a7120d..ea2c1cc9c7b0 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -511,6 +511,17 @@ int amdgpu_dpm_get_power_profile_mode(struct amdgpu_device *adev,
 int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device *adev,
 				      long *input, uint32_t size);
 int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void **table);
+
+/**
+ * @get_pm_log: Get one snapshot of power management log from PMFW. The sample
+ * is copied to pmlog buffer. It's expected to be allocated by the caller. Max
+ * size expected for a log sample is 4096 bytes.
+ *
+ * Return: Actual size of the log
+ */
+ssize_t amdgpu_dpm_get_pm_log(struct amdgpu_device *adev, void *pmlog,
+			      size_t size);
+
 int amdgpu_dpm_get_fan_control_mode(struct amdgpu_device *adev,
 				    uint32_t *fan_mode);
 int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 99750c182279..73f3e7915d23 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3090,6 +3090,19 @@ static ssize_t smu_sys_get_gpu_metrics(void *handle, void **table)
 	return smu->ppt_funcs->get_gpu_metrics(smu, table);
 }
 
+static ssize_t smu_sys_get_pm_log(void *handle, void *pm_log, size_t size)
+{
+	struct smu_context *smu = handle;
+
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
+	if (!smu->ppt_funcs->get_pm_log)
+		return -EOPNOTSUPP;
+
+	return smu->ppt_funcs->get_pm_log(smu, pm_log, size);
+}
+
 static int smu_enable_mgpu_fan_boost(void *handle)
 {
 	struct smu_context *smu = handle;
@@ -3231,6 +3244,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.set_df_cstate                    = smu_set_df_cstate,
 	.set_xgmi_pstate                  = smu_set_xgmi_pstate,
 	.get_gpu_metrics                  = smu_sys_get_gpu_metrics,
+	.get_pm_log                       = smu_sys_get_pm_log,
 	.set_watermarks_for_clock_ranges     = smu_set_watermarks_for_clock_ranges,
 	.display_disable_memory_clock_switch = smu_display_disable_memory_clock_switch,
 	.get_max_sustainable_clocks_by_dc    = smu_get_max_sustainable_clocks_by_dc,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index f3cab5e633a7..0d84fb9640a6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1247,6 +1247,14 @@ struct pptable_funcs {
 	 */
 	ssize_t (*get_gpu_metrics)(struct smu_context *smu, void **table);
 
+	/**
+	 * @get_pm_log: Get one snapshot of power management log from PMFW.
+	 *
+	 * Return: Size of the log
+	 */
+	ssize_t (*get_pm_log)(struct smu_context *smu, void *pm_log,
+			      size_t size);
+
 	/**
 	 * @enable_mgpu_fan_boost: Enable multi-GPU fan boost.
 	 */
-- 
2.25.1

