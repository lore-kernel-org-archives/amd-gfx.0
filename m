Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D59CA0ED1
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 01:04:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6B7E10E062;
	Tue, 12 Aug 2025 01:04:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vxDEmsoQ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4840E10E062
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 01:04:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lcquusfl2i+6DL6v2ntOmbpOJ2FpurPEbXyJSLhSSE/AS380c3eRuEadG2+fyNvNImyK8Z05iSIzoePthdQnBsj6PDfqVbPU/0faGnVxRpLiGjhv2Q2ufhltJHWHAFkmcl9MLZjXYTG8LYra5/WIzm1pW054L2J7SzNEgj/34hV9NX2yythCEGAl49bPeHbJa31QMH5vRfbew5AS6snTmLjOx+jRc+j+AfVBY/zAksmw+/uWfEojqD5S7/uyYMaPCbz7/mUc6plDhS8m1DNLXQMuagD9ke9pic2t5idpF67DtxOOUtDIsAaI9cLS1aVHHbbRYli16eSrwq7pt52f/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LiPs2N+eXSe3mQrK82F+a5fJHFFkt9SamTWY6AYl6Q=;
 b=vbt+6HgpjFN2u4+9SOnjn+rLqGEdpseBI4Z9P1kojCoug+ZMrM6hmPjvW9jIsIjA11daqzttrn53BerG6/06vV/pCDHZAQsob4qqCe/7iYmBZpaUEwEgMqHy0E5AyLmv+JdbBeauvdqDULzLoAkQVKhkqAYowgwBdnIYKbagmrqRqjg/7htEeoe0psP7VvHMsXzxoSI5HViJGx2isxJ33pzBzsE7O1t7fC+SCwC7XlyvIRxR2ERcMgJFg65Bwps+6so+AzrEy1fryYeW1ODG8YGwtgJm+MPUh1bpJGynxSpVKUSpG9mUoRQK4MyOaKUJ1zGo8n0lsbylmdmAaqwIXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LiPs2N+eXSe3mQrK82F+a5fJHFFkt9SamTWY6AYl6Q=;
 b=vxDEmsoQLC6s76+ka/T5UABbeM7X0aAmbuPyeoF7ep9vtw5stgqmEjf0mpnqDPZGs5u8qHY/Libg1rY8edt2kKHoZE5v6WZoxntS8/alngGq6ZiWNYll1UrHNn/0GVwtB2VvXuePEAAPgtQE8eGdGWxt3cvMRT+E0AeAKKvO4Gc=
Received: from SJ0PR13CA0215.namprd13.prod.outlook.com (2603:10b6:a03:2c1::10)
 by CH3PR12MB7715.namprd12.prod.outlook.com (2603:10b6:610:151::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Tue, 12 Aug
 2025 01:03:56 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::72) by SJ0PR13CA0215.outlook.office365.com
 (2603:10b6:a03:2c1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Tue,
 12 Aug 2025 01:03:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 01:03:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 20:03:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 20:03:52 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 11 Aug 2025 20:03:46 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Ruili Ji <ruiliji2@amd.com>
Subject: [v3 1/2] drm/amd/pm: Add VCN reset support detection for SMU v13.0.6
Date: Tue, 12 Aug 2025 09:03:13 +0800
Message-ID: <20250812010345.2261810-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|CH3PR12MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: c02ad8eb-d6c4-4669-3553-08ddd93c1c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?whI3IT7Py34bC4mlwCqi6pDcMpVerHFIfWLa8ymqXrY1vOkO2w0B53PTaX9r?=
 =?us-ascii?Q?bKk8RI53EGqs7mkQsylAwaBgjAapgQK56r78NI06Y3sgAL5OJLnpA3p7RPso?=
 =?us-ascii?Q?lm/90AsEuC0thdX4MiPGUsR3XDOLIJG1aU3Y7AmE1zYkb93dssMsM554CmY/?=
 =?us-ascii?Q?vspM9Rk6u6ub5MzqmzXzV79c8W6kkfukFedQtgNPY7vPX+MWVUYTOTFuUkOg?=
 =?us-ascii?Q?KnTD9c+5DdMSY4OS2JJ4aEutVQI3Kf59qa5LsNEbakly/Xrf/XfWSeWvdReu?=
 =?us-ascii?Q?wBPDwgiFZNbmKDyppMgR5IvoBS5a6yuCpIL+N2yquR60qZkvvu+0Vrh9sAm5?=
 =?us-ascii?Q?D8e9ACXUFwdW2AxMH7GM3pws5FHWOCWcXpDsNSwNHmy8b674DBntJQlnAlmV?=
 =?us-ascii?Q?FrRgFcIZegokciZbbVu9Z1c/YwyQpN2NNL5eAltEVh6DyzFSz225aajXWfYt?=
 =?us-ascii?Q?73DO1pU/Hcj+kSV34z50wMSJLbeBG5v5rA98Kbm51jwlFNB4c7+IClMb42hw?=
 =?us-ascii?Q?ew8L1e/FNmUlvgceF58RwjjQSgIyz8FJ+4ZJlbK/KLx0OOlql38q1x0cFbtK?=
 =?us-ascii?Q?XGgLFgOlBf//sJcyfJExPLR3iOgztYMA3msDN7pZmBievBc2mDvJJe5auIQc?=
 =?us-ascii?Q?cHx1j3z94Dm3RhtZNKmAd2Gi83q7rXn4orTZdR012gJEfOKkVfnV/28Uul14?=
 =?us-ascii?Q?ecGsIIiepYNLgLImXrvYiSFcVAW3m/Ggq5N+QDkw8Qye4T03gzffEGNXJRy1?=
 =?us-ascii?Q?rRIasP6AkbDwq9NOE8lJR6/2Ks9YlYLT8g9fl3o9kRO4Y+fiYK3nLIdD9swy?=
 =?us-ascii?Q?oPTau9GC3dmjqHaFDrEJLjSIjFcczv4KOCyQT7vCTpyHY58Mz2m1GpoT38q4?=
 =?us-ascii?Q?Dku/LY+7tMYME+NE22WtXyQmkOzbFmL0w3T/jbMvHyS/se4u+f8U4xUIMA5D?=
 =?us-ascii?Q?ciFRNbuGWGNaO7f3tko3w+ZAhi/XVsatfmjhwC0Vtdv+22e4t57jYw8srBM0?=
 =?us-ascii?Q?ffmjRlCicYy0/a821umNZcLZqXeCdb7hkRQhwxBLAHoTsSEp9Kqj61EjbXMN?=
 =?us-ascii?Q?S3304mF6ay+A964V2l6yeT7oT+LY/TUHwCKX0OxIdwDCeZ5lNiQgAVfK2kh9?=
 =?us-ascii?Q?gvwucKvkg4BbCZ4Ph146eoCrXzlTDvq98y+L2VuSNJHQ895cQqQBXwCDyXav?=
 =?us-ascii?Q?my08ejfiqrYTnOFdwzEUl1yq2r5ibBZFS89N4033AAwVQKHydiFdpMiw+6/R?=
 =?us-ascii?Q?lQa3T0ZY5t4j4NumVgNr749uW0OujG/FS/IuEQXeLVQZihPJDEA8lmnY5yDM?=
 =?us-ascii?Q?kA8IitHwk9+GL/pT7ppctEcuNSdpTfEk5/xzO92l6kpdXXO6g5DBGVsU0PEX?=
 =?us-ascii?Q?S5ya6vMvxkAHGr0QoStJuIwWYPK1UWjMD5xCG8apKVRB5V9B4TcNuulTyG6V?=
 =?us-ascii?Q?JNeA7CxvkCet7xk76UbjWsyiiDjdNRGYH0vp118QCS6vQ6cNr9cLtdtIAIBl?=
 =?us-ascii?Q?FvaJw0Em26tLhBKIgXveqw3Z2z3cCJNI3I3t?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 01:03:55.6199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c02ad8eb-d6c4-4669-3553-08ddd93c1c99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7715
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

This commit introduces support for detecting VCN reset capability through
the SMU interface. Key changes include:

1. Added amdgpu_dpm_reset_vcn_is_supported() interface to check VCN reset support
2. Implemented SMU backend functions for VCN reset capability detection
3. Added SMU_CAP(VCN_RESET) capability flag for SMU v13.0.6
4. Updated PPSMC message definitions to accommodate VCN reset functionality
5. Added version checks for VCN reset support (fw_ver >= 0x04557100)

The changes maintain backward compatibility while enabling proper detection
of VCN reset capabilities when supported by the firmware.

v2: clean up debug info and adjust this message to be more meaningful (Alex)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Ruili Ji <ruiliji2@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c             | 15 +++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h         |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c       | 10 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h   |  5 +++++
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h    |  4 ++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    | 17 +++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h    |  1 +
 7 files changed, 51 insertions(+), 2 deletions(-)

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
index dc48a1dd8be4..f9a350a82764 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -4106,6 +4106,16 @@ int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 	return ret;
 }
 
+bool smu_reset_vcn_is_supported(struct smu_context *smu)
+{
+	bool ret = false;
+
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
index 90e66c8f2f82..60aaf0e2ce8f 100644
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
@@ -3171,6 +3174,19 @@ static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 	return ret;
 }
 
+static bool smu_v13_0_6_reset_vcn_is_supported(struct smu_context *smu)
+{
+	bool ret = true;
+
+	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(VCN_RESET))) {
+		dev_info(smu->adev->dev,
+			"SMU VCN reset not supported.  Please update SMU firmware.\n");
+		ret = false;
+	}
+
+	return ret;
+}
+
 static int smu_v13_0_6_reset_vcn(struct smu_context *smu, uint32_t inst_mask)
 {
 	int ret = 0;
@@ -3859,6 +3875,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
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

