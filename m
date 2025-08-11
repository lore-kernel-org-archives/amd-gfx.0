Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAF2C87FCF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 01:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2003B10E375;
	Mon, 11 Aug 2025 01:04:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bg2RShsO";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C851010E2C6
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 01:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2FISHAwpMeq05F4/C1na9M4RJgok05yXaRBD2TFLzrwWflaXTKJBwT3JUvtNrIuu64fbvRE4a7xkwQzHUDKhrwbaKS5RA5F5kUPrZqO3eX0PUF/YVrmKv7wPM/sUdtLqAoSIi9QahnXK9bnwO2rWk5eNyk66YKRGMPkqe9vKGTwIHedQcBwCpDqRNcZP5/W/Whd3lFTlS4g//6kQWz8WUorA4Imo943KXVulcOAQGTfQ6Sda3PIa+ghCJtH3USRHAUw/FVBVz3hKmc25Tzr2An/R+ayiJXCW6dIRl/Ll/MZcNtgsmZjs7+eoy90/ISEOaZVb+MivfmL76OY/UyvfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBd2eik0r2I4JXzppAhbtVgif7/ruVdbFaKFL7Gcz7E=;
 b=gHtEbcAwdMOVxPsND/uug8aqHlsdqST/iegB3cypybzJrzS3AYwRUbD4dLUDdsSGxcDwyg5zh+la1ykWktQKTbNIQLxhSP4q6+isM3JFbjrcD+/XVrGmiLAOe/AuV8lwgy12smoVtULmNzK8FePASCBiONwW+gSgW1+93rHaGxSpyP6BjBPwEH/UhbYORosiDftm0sQXRh8MiYfg7iG25sq5N2Z6/ig4+M22VffiGwbVSXw8FCt7YLmuqhcfIp9N6jqGsBAgZ9zsZJx1p8GPCbF1ajrhr4rSAbpbRWX10SdmuIX7LFwQjCE4S84rKfv+9fXtpHXT6UefQ6wD/a7czQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBd2eik0r2I4JXzppAhbtVgif7/ruVdbFaKFL7Gcz7E=;
 b=bg2RShsOK0E6XKOPAXmos//O4Q8+7MVyJLm3wBhHBTcazGO/YQiUCOG21lB6KPn19TSOoesnAgIQ0idiEE6dU5ffFDVqtZlZdIUJM0Dy83IG3Pp7kDwzAHh+oJFBnr1KHOGfSC7pEG/Ho73qMHpdE8bReic9xK9KxlK7WhDIz/k=
Received: from SN4PR0501CA0111.namprd05.prod.outlook.com
 (2603:10b6:803:42::28) by LV3PR12MB9402.namprd12.prod.outlook.com
 (2603:10b6:408:213::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 01:04:45 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:803:42:cafe::c4) by SN4PR0501CA0111.outlook.office365.com
 (2603:10b6:803:42::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.11 via Frontend Transport; Mon,
 11 Aug 2025 01:04:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 01:04:44 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 10 Aug
 2025 20:04:44 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Sun, 10 Aug 2025 20:04:42 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Ruili Ji <ruiliji2@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v2 1/2] drm/amd/pm: Add VCN reset support detection for SMU v13.0.6
Date: Mon, 11 Aug 2025 09:03:51 +0800
Message-ID: <20250811010437.1895121-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|LV3PR12MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: 93d1d075-ba27-4f30-7d5c-08ddd8730f70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4Lc59xJenH5bnAIp9LbRsYR8aJVr8WWEhLAzSH1Oyu3p7N+mEfyCaIZawLhj?=
 =?us-ascii?Q?tgoGqXizkSSVZEsRtUjD7vM1xl0uPHpRQX7XY0Kl5qm8R6Zrr5HGmb8BXKdF?=
 =?us-ascii?Q?ae/J+Wr5QqmoB7lEI5Sg7LaErrjZ72Rc9cikSHNb6Z6GT4IzvGX4lQNfApC8?=
 =?us-ascii?Q?2hVdw9sBw3qOwK+9yjQn1IHBopWfp8bRFUX+nXerPcE/GG3kmHtbe7VhB2JT?=
 =?us-ascii?Q?VNveW94KVqNrrXEePnEjfzy4QUETTBRk+cdCo0xVY6MecoKQeKnEtsMmsUsY?=
 =?us-ascii?Q?aX6O3lgpwQ1CDhGMGzBT0f4Ixa9xcY8tct0+Bh0zbS/qzKOSiMJLPlNuifyC?=
 =?us-ascii?Q?tihPAf/R7VknkaMBbEYbVSQCnMNuoh/uYUFE9MfFFxF0kiI+7HVWuvlfEjtk?=
 =?us-ascii?Q?gQGtfnbRctZl3U8Z3Brf8Fr1moC6hgFGpTIXd/SfT7Bs182z9w87x8b/NI9q?=
 =?us-ascii?Q?o6TfFkep/QwwVDzkkPZOOTdm0ApR7IIKl4zaEAZ9i8wZ9zH824TJEE96Uswi?=
 =?us-ascii?Q?/DthtBZgEryKyyZzIqhh5UUocFwjUgXVxG5xDr7n07HJrCssJsCqA61+xsg9?=
 =?us-ascii?Q?6MP/crfJ+yWyeu+09zPkbfj8NFeDnRTyjIz+SvfwSfUVG6No4Xh7ofUSrehC?=
 =?us-ascii?Q?2wHbwJLRnAIf9+ePcN0VgoPtt0Sp/5I4Xt5KKiDfG5vEHc6ukV0pbjg3+B8x?=
 =?us-ascii?Q?dajfQ2hK9ekgjLseJFthEAZRyx5VqaSGAveRN3ARK1P+7uuQqbUROi5iZ0P1?=
 =?us-ascii?Q?QTPZfewad3kypJ+bAMmsRCbk2sCZzCnwnaHRAoXLHyHB46LUzLBBHsQJ2VV3?=
 =?us-ascii?Q?B8hTKv5Kay2KU6dU2ENUVFtGFlDCez1ZuotgrOiwJqRCFYYJYpm2V2NagK/Y?=
 =?us-ascii?Q?0Wo00C9ofx/yJ1u5oOnxANjSAxlxTe7NQJOCaajxv45EgcEq0Az6/f2d2W3t?=
 =?us-ascii?Q?IdquAUjkCKh8qkyt01HBOHtZh83Ms7EhQ9Xqzx40x9r2PlSDy1x2LSHj3+T3?=
 =?us-ascii?Q?9xpf0FGcNFTTOT78uE+A+kQ7K1UmvNbfvHDl4ledh0/tYId94AfAkea0Jikn?=
 =?us-ascii?Q?7L5qNRrozzCZfbz9B+Xmm7Twptp9zMcJTxUZNInO3EQIdNQda+DeNpSS/Sp3?=
 =?us-ascii?Q?LUfnCIyoJlY5rdnlWM/RBWdWBYn8tAbYiFvIEBVMHgnudjzAZx6vUQ+Z6xuI?=
 =?us-ascii?Q?AS2+Yh9MBPLtHWKeQNsU7+o+6KJvhZWiOAoXkMH0EAAY3QemB3pB08FmkEkJ?=
 =?us-ascii?Q?TwMtFBiq7g3WmBs5ei/tR2kSVfGVaPXUKTTpgpJiV95LX1D4EBZDB5irskG9?=
 =?us-ascii?Q?RUT2rFJbWnAeisob40xcNUwnD0vQYJelS7AIN8c0jTDeGzb+ISvI2p+1fL95?=
 =?us-ascii?Q?QAmNjxK1PI0oMDBSvQBAVVb3y4PZ1ucoA7eF9mtdz1UO4bAGOHsmguxFqxfO?=
 =?us-ascii?Q?lq9k11uZ12gHPBCr2rnLnFWjjbVI15gqs5UbHdl3/WWqOuF+TyxrtbhTxW89?=
 =?us-ascii?Q?jbuuOwJ3eqSxUZQolxRVVtSD01E+gqq4kqZh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 01:04:44.7628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d1d075-ba27-4f30-7d5c-08ddd8730f70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9402
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

