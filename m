Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0746C87FD3
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 12:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 546EC10E1D5;
	Fri,  8 Aug 2025 12:49:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n8UWGVJ0";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8B1210E1D5
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 12:49:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQcmFKBsyKPepNzMf9zUgqB04T0x2PJrugdIi05cLjc4GtvwqS1hPiMMZcSVIa+jd1AkKpSxPHmmj3YSqRrHdZJTBWSZpqdNy982zleBOPFN4YHokSSvadsO/5RwoCQejqvnOrYss4lwA0jVuq33nsrXeA99dKwQRiAngs6FI1uOhNmwSOsCeL0egVRn/kAxvzE4IX78TLjFbRxU4dFllKHxWYZ3by+YPlrcOFs+WITuXULwrp7skUMJbnsXT7NpHG3CKvweRWXLo4wIx9CgeBivu8qDH9E9cgf9wtYgLV7O9x9CQRQWYQOmiqXQg7+6Tjm/iynEZPxpvnLULxc9tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBd2eik0r2I4JXzppAhbtVgif7/ruVdbFaKFL7Gcz7E=;
 b=YUVASEUEJ9W0gCT0GGEfsUTmiUjLTgI52LCnCATHYvXN1oUCzzbv33AJOVxrfdjEZQzYXToP3FFoxrq0rx5pq26KwNcggoyEAZ7OX4LHo2CiV5PVRTv22JeQyd5+CpcWMdAakbvxgogjBeM3jq/+N923DbYkUA7ZKdWYOhGWg9O/v2QkaIcwos4ZARaK6OOBMtASJkNtsCKlWGNgQzVyGBZw9mOZZb7h42xlO/N5TB0+ZF8Lh+q1t3cwyn6HSAd+PmMg3Dup+z5Z7hb4KnU0V5yaFbCSoqUfd9j9H/vVkydNrM1MSZasB7aCoIbHC7AzhH/tTEZYIgmqAhL/TrEFfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBd2eik0r2I4JXzppAhbtVgif7/ruVdbFaKFL7Gcz7E=;
 b=n8UWGVJ0OAp+wXaLFL9/66ZXMWxVJgZZIVEYtuwAh2JFtX5nfhycouvVcgBhzclbLiAa0MWvYKE7Q1w3rwH2juc3+yHTmGLOBavT3gnjH3AnSXvH11rRbKku3d7dmtzyhVenX1SLCnaiS4/68EBvFbgAYLnAk6cWe/oJM21J3R4=
Received: from MN2PR14CA0021.namprd14.prod.outlook.com (2603:10b6:208:23e::26)
 by MW6PR12MB8998.namprd12.prod.outlook.com (2603:10b6:303:249::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Fri, 8 Aug
 2025 12:49:13 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::43) by MN2PR14CA0021.outlook.office365.com
 (2603:10b6:208:23e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.18 via Frontend Transport; Fri,
 8 Aug 2025 12:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 12:49:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 07:49:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 07:49:11 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 8 Aug 2025 07:49:10 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Leo.Liu@amd.com>, Ruili Ji <ruiliji2@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: Add VCN reset support detection for SMU
 v13.0.6
Date: Fri, 8 Aug 2025 20:48:35 +0800
Message-ID: <20250808124909.1813022-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|MW6PR12MB8998:EE_
X-MS-Office365-Filtering-Correlation-Id: fb3d6b97-f0b0-40ec-26f3-08ddd679f9a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fm4DASO2Y5bKW8M4mG+bu3fAObC/dl39gAreau8aB65pjGO7bE7GdGRWwsx8?=
 =?us-ascii?Q?kted/2uIlwVVU/BcIXSd9H4uIAPXVx1urFI35ITxEZtq9FSVes9ynj4WHEdP?=
 =?us-ascii?Q?sV4hjrMbao/j+JtWEYZ23xTB9XLWK4+oAmcOtnxzl8kpyUrJMPyjqaQ6tFca?=
 =?us-ascii?Q?s6sz8K/yEiIuwtN8Qnp9H8xpW1fbXYBgZMgDAO8gzTv8xYrfv+PUp0TcdHMk?=
 =?us-ascii?Q?j59FSCrKEkZPCqxODyhONXHqyuaaaIBAD2qHJWJjfe+eOX5oId+kdHmdfijL?=
 =?us-ascii?Q?DHc2kZGq3ZYpujDzUtTxRHXdQ1q/qNzkChH5H4BL+NzFB/LCPpe/ZRbsUPBr?=
 =?us-ascii?Q?LSdsNwyCv+lYamMDFk0XEYoNdk9v3DIrxr1A5k2VT/vAY0RVYydGUoK1qhTd?=
 =?us-ascii?Q?Rzu1fwIf1hNAGEIMK+Ig3+3E0LuV8/v/SsqMyKbfPcOPN/g2ZLRedn2H8OMw?=
 =?us-ascii?Q?bM7d3ZaKPtgQlBSuRHUhTR2LUAAzQidTTRG+h32m/U/NM+m3SgxGSNxmpPPs?=
 =?us-ascii?Q?AbPJiPl1/SrqRI2J1pTrDj4epo3veZ72xgnxfY3JY3mzHpUYxOBz0uCgAE/n?=
 =?us-ascii?Q?dtqCN3SlmIJjPOi8kj1zZ3fOQZwqUcsGANlAPxS4j0ifUtIlxu0VtfNM8hwD?=
 =?us-ascii?Q?7ZrM6BW1PIpweIIlYkRZYmdJLYWr6oC7K66jxobYbb8B491/MpBHCzBP3ZH6?=
 =?us-ascii?Q?uBJ3OGmcVlF/eaxBFp1Lm5Z5v90ZrSrcmgpcKb0aws25r9wHdQj7Np/1Vg1n?=
 =?us-ascii?Q?18sv60AaUyWFNB2wdsFp7pc0bmkPw50AGWhRYRg9uunGPU/vKkQavsjZ66LW?=
 =?us-ascii?Q?F+2frCbtm8Mfc0gzTdnMkLV66HvpPqkFv3ndZAjuWxwexcXG/rEY7mhAVDr7?=
 =?us-ascii?Q?HdvpDnGqgX65gmQ09e5WC5Ev1vfYSCsEPqhlae6KSfSXxx7IeDtT+pWcfWnn?=
 =?us-ascii?Q?xTclRhqmIKQUh9umFDNG2JUkzQE/XfNFiJ5MAC8GwHs63ewNlWKDpsLOnALP?=
 =?us-ascii?Q?RRwNSjmdiepDSrYhw5QAafeFlVyecHf9UlxK+ZNCj6h3Lb/1DTVnz6HtxRD/?=
 =?us-ascii?Q?y9OJarL2KMTLMDGMnYvvG4JXToAw1l7liJGwQLtEoJQw1Hvq0viTK1JGK96N?=
 =?us-ascii?Q?HYxcC4ylPqc8+L2mIdJ8wdPtFlsDsA0/ZabmFFpXtgLZKNVHu6YvMj5VByWe?=
 =?us-ascii?Q?UDXa7cIh8Wx6WNGe1XHlDNl7Xv5h2H3V1Zzf44kNn/p0jghk2yNcMRr01yia?=
 =?us-ascii?Q?B/fWeTj8hb7+nRhSSEPR1jhFL3JD5ch8Inn7rEzrkkr8QPM1wC8OcKNdLGK5?=
 =?us-ascii?Q?fRsYsWEF0YKo1nelWxuyPCbOXDrl//6MtDsT/sCUFLvLk07q1qdU0c+7gt8X?=
 =?us-ascii?Q?j1nEzbi9tpYV6c6DX6W7BscMvuMNqaTJB98hnzBjysuqwdefoRW6KdnJkCwq?=
 =?us-ascii?Q?nRdU5NhHBDIye+lyxQ5L5vd0R+zdzWadYx52TigCMyzY+dZYNYVGCtocYWGd?=
 =?us-ascii?Q?tA3xKLuT/i9Ib9sO2OqXE6XWatcx+NudAW/t?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 12:49:12.3176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3d6b97-f0b0-40ec-26f3-08ddd679f9a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8998
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

From: Ruili Ji <ruiliji2@amd.com>

This commit introduces support for detecting VCN reset capability through
the SMU interface. Key changes include:

1. Added amdgpu_dpm_reset_vcn_is_supported() interface to check VCN reset support
2. Implemented SMU backend functions for VCN reset capability detection
3. Added SMU_CAP(VCN_RESET) capability flag for SMU v13.0.6
4. Updated PPSMC message definitions to accommodate VCN reset functionality
5. Added version checks for VCN reset support (fw_ver >= 0x04557100)

The changes maintain backward compatibility while enabling proper detection
of VCN reset capabilities when supported by the firmware.

Signed-off-by: Ruili Ji <ruiliji2@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c            | 15 +++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h        |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 11 +++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h  |  5 +++++
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h   |  4 ++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 18 ++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h   |  1 +
 7 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 6e0d711820ea..518d07afc7df 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -820,6 +820,21 @@ int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask)
 	return ret;
 }
 
+bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_device *adev)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	bool ret;
+
+	if (!is_support_sw_smu(adev))
+		return false;
+
+	mutex_lock(&adev->pm.mutex);
+	ret = smu_reset_vcn_is_supported(smu);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
+}
+
 int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
 				  enum pp_clock_type type,
 				  uint32_t *min,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 09962db988d6..9748744133d9 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -615,6 +615,7 @@ ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev,
 int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask);
 bool amdgpu_dpm_reset_sdma_is_supported(struct amdgpu_device *adev);
 int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask);
+bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_device *adev);
 bool amdgpu_dpm_is_temp_metrics_supported(struct amdgpu_device *adev,
 					  enum smu_temp_metric_type type);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index dc48a1dd8be4..a03d37bd9e48 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -4106,6 +4106,17 @@ int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 	return ret;
 }
 
+bool smu_reset_vcn_is_supported(struct smu_context *smu)
+{
+	bool ret = false;
+
+	 dev_info(smu->adev->dev, "SMU driver smu %p\n", smu);
+	if (smu->ppt_funcs && smu->ppt_funcs->reset_vcn_is_supported)
+		ret = smu->ppt_funcs->reset_vcn_is_supported(smu);
+
+	return ret;
+}
+
 int smu_reset_vcn(struct smu_context *smu, uint32_t inst_mask)
 {
 	if (smu->ppt_funcs && smu->ppt_funcs->dpm_reset_vcn)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 611b381b9147..7990771151be 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1426,6 +1426,10 @@ struct pptable_funcs {
 	 * @reset_vcn: message SMU to soft reset vcn instance.
 	 */
 	int (*dpm_reset_vcn)(struct smu_context *smu, uint32_t inst_mask);
+	/**
+	 * @reset_vcn_is_supported: Check if support resets vcn.
+	 */
+	bool (*reset_vcn_is_supported)(struct smu_context *smu);
 
 	/**
 	 * @get_ecc_table:  message SMU to get ECC INFO table.
@@ -1702,6 +1706,7 @@ int smu_send_rma_reason(struct smu_context *smu);
 int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask);
 bool smu_reset_sdma_is_supported(struct smu_context *smu);
 int smu_reset_vcn(struct smu_context *smu, uint32_t inst_mask);
+bool smu_reset_vcn_is_supported(struct smu_context *smu);
 int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
 		      int level);
 ssize_t smu_get_pm_policy_info(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 41f268313613..63a088ef7169 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -94,9 +94,9 @@
 #define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
 #define PPSMC_MSG_SetThrottlingPolicy               0x44
 #define PPSMC_MSG_ResetSDMA                         0x4D
-#define PPSMC_MSG_ResetVCN                          0x4E
 #define PPSMC_MSG_GetStaticMetricsTable             0x59
-#define PPSMC_Message_Count                         0x5A
+#define PPSMC_MSG_ResetVCN                          0x5B
+#define PPSMC_Message_Count                         0x5C
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 90e66c8f2f82..c25dd7427f1d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -434,6 +434,9 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
 	    ((pgm == 0) && (fw_ver >= 0x00557900)) ||
 	    ((pgm == 4) && (fw_ver >= 0x4557000)))
 		smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
+
+	if ((pgm == 4) && (fw_ver >= 0x04557100))
+		smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
 }
 
 static void smu_v13_0_x_init_caps(struct smu_context *smu)
@@ -3171,6 +3174,20 @@ static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 	return ret;
 }
 
+static bool smu_v13_0_6_reset_vcn_is_supported(struct smu_context *smu)
+{
+	bool ret = true;
+
+	 dev_info(smu->adev->dev, "SMU driver smu_v13_0_6_reset_vcn_is_supported\n");
+	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(VCN_RESET))) {
+		dev_info(smu->adev->dev,
+			"VCN reset capability is not supported\n");
+		ret = false;
+	}
+
+	return ret;
+}
+
 static int smu_v13_0_6_reset_vcn(struct smu_context *smu, uint32_t inst_mask)
 {
 	int ret = 0;
@@ -3859,6 +3876,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.reset_sdma = smu_v13_0_6_reset_sdma,
 	.reset_sdma_is_supported = smu_v13_0_6_reset_sdma_is_supported,
 	.dpm_reset_vcn = smu_v13_0_6_reset_vcn,
+	.reset_vcn_is_supported = smu_v13_0_6_reset_vcn_is_supported,
 };
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index ece04ad724fb..7c98f77c429d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -64,6 +64,7 @@ enum smu_v13_0_6_caps {
 	SMU_CAP(RMA_MSG),
 	SMU_CAP(ACA_SYND),
 	SMU_CAP(SDMA_RESET),
+	SMU_CAP(VCN_RESET),
 	SMU_CAP(STATIC_METRICS),
 	SMU_CAP(HST_LIMIT_METRICS),
 	SMU_CAP(BOARD_VOLTAGE),
-- 
2.49.0

