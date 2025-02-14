Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCFCC021A4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 05:55:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78DC510E0A1;
	Fri, 14 Feb 2025 05:55:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4RYTrR/y";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D40A10E0A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 05:55:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oc7TLBmtZbTiP4KDdtdq92jwv3BhE8qNJyhMZtgkRviQAm6jzE1TIsHYZEvPrndiNsMWqU3dzaHtSARIPkoKFkcI1rQLK0jj/Eucpv/Q97rMUQwIEIJlw23R+cM2H3Omv78MNqvU9feULkKnuLAGGp5Bcciu/jTjDGxiZ6l8LyNtkWCZeDgPsxfbVxjAG+xUcgTtLMmaXcO+lZJPOYEmpksN+wFG3GimPgwT9UKH+mpHAp6I0ZhDoCC0Q8akIjXotG7lGQWZffklvl4Iht5gDh14ZVZo+1pbllGXgCcm9SajK23eeMbW3NIxmMT34+aDgYgYmJs9+UZiWQx8DxFvWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1USvHBvAucBb1vbU2JXRyab+xftIPvidDtEfRREfFSs=;
 b=PlqC7fxzOxpWLL94jtrjGROtPdBKowBIwfr99K7MWevEhKnCjv+hMoeCk1iT7D9aDBLiCoqNgr/2h/nGNdJOXGy9f13jBGL0i+gTOViFNYj4N3BDKtH3NAOD5apr+dSDpPC1vDozLv9aGzYhZufzkiuZ+Lyn0pOQADBEMG0MMI+P5XWcb/x0zoo5zonPIhBtl/vxSWWLcFDmN4VrZdPRcOj2WBhAmIOVwG8MNnUKDXdcsRAPWAuV3CnA9zdKvMjZUTIlUZR6W0ZWXh06e0AMVxF3jrF9k2HUAMslDUVEtoIFD2Ts4h8IHIGn0FB3VedG3uZLxuQ58supKuO/3DVteA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1USvHBvAucBb1vbU2JXRyab+xftIPvidDtEfRREfFSs=;
 b=4RYTrR/ywAeqfNCkT05/fAI3JecB9iyKREkiq1zOAdpKo9sT9vy3WIpBbGMWeIOnurGnM4IzLz8fsfx++DVdaezzGsAqEPPvKNZhAPG5/FdAyNhwMRVQMXauGtOjw9xrtt+zVyTi2NaDl3qF8SxLgV8phLDLI2pN5RN5UbfhRW4=
Received: from SJ0PR03CA0227.namprd03.prod.outlook.com (2603:10b6:a03:39f::22)
 by SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 05:55:42 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:39f:cafe::e8) by SJ0PR03CA0227.outlook.office365.com
 (2603:10b6:a03:39f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Fri,
 14 Feb 2025 05:55:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 05:55:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 23:55:41 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 13 Feb 2025 23:55:39 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Jonathan Kim <Jonathan.Kim@amd.com>, "Jiadong
 Zhu" <Jiadong.Zhu@amd.com>, "Jesse.zhang@amd.com" <jesse.zhang@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: add support for checking SDMA reset capability
Date: Fri, 14 Feb 2025 13:55:33 +0800
Message-ID: <20250214055534.3249909-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|SN7PR12MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: c250be9c-c802-4cb0-0987-08dd4cbc3745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QYtjKrNIGD0Nk381zReEqlzVT2fbOzoDpH2a5nEbtCNIzqJENtkcs7KKx7mH?=
 =?us-ascii?Q?qXnUwrDS23cUa8oce3XXFUQe7iIaQNsgBBeWST89DNM9ZaA9DWejAwmoS97r?=
 =?us-ascii?Q?gMPoDY/Wh5u3a96P2fy8Z01KspD8rat75sjvpPUI0+9t9cZlKlUfyiYtJZPz?=
 =?us-ascii?Q?b9LwPPKsrayPXhBNNDhCqLApc8VZ/hU/j6e4FDJi2uhPgarL2sJmqkOCvCSj?=
 =?us-ascii?Q?loJfh7OtyQI4Ad3r/R02OS46gTDjbfCXV6qVydKwSljMbDODOob5IvweVFiN?=
 =?us-ascii?Q?5Y4oFC83DYK+7S1R9tKBHDmwd5fBJ2+4p+QiNegNJmeIhXAmzzMedQ7V8Gdz?=
 =?us-ascii?Q?toTOMLqd+K9UyDv/boEs3X+4sYE8sp60tW54WQLAX2t6m7lNDFSOEviyC+NA?=
 =?us-ascii?Q?680dDOBwoclTa1pv/UksoACJhZRB9eqSaEh+8KqcVrgc8fkdf81tT86DAyrZ?=
 =?us-ascii?Q?s5gPWOOP4bj9fMowIkf0uETXPR2RnzB7U8a8kESVUH6l+Q/EEU9EhBnjGEz5?=
 =?us-ascii?Q?AJSxS89EU8+eMJEo1yKZcxIO8xTt1iTXsH7qBkIXX1WvaB9XERSwKFCI6CNJ?=
 =?us-ascii?Q?ceIK8bIXV6EI0T+xBzwFqoREMXLN+04F8HGkJ02NJXieOLBlYwT1/yoS0s4g?=
 =?us-ascii?Q?+O2MypdwHm8gF3biGMiovAMwVf/0OkIkJoVZsgd4M7OH3K5Hd/cIMIep3rB8?=
 =?us-ascii?Q?rqZwlZ2EiXDHuMAL+BhyhkLYjrFuR4RV+VJWnk1k5JNnfjf/oVjPIeOIcll2?=
 =?us-ascii?Q?0SR9bZF0Vkuns2IE35gyQeJrJQqk6yaZdz1t6g+7y+uIHGYZdT8cploAK+/5?=
 =?us-ascii?Q?hUZwTAFDbmTBUeDRf5tFLkVhSzrlSy4CccflRTZ8C7glFtBtCq4n6AnIxqV+?=
 =?us-ascii?Q?DIiP+ydzs6wcKbxoBKb0orcGQokKmwvF0sjqDIFFgtH3exu2+IPrVxFdtf7J?=
 =?us-ascii?Q?eMsjHJyzpHkJPxyYxeh37tvN9O4l0BRaRNdLur5pDj2xqC6OAGQbseD1Mj/u?=
 =?us-ascii?Q?bSw3yqa6GJk7Hx801coiVGvTtSqXi8qvnH24xcsKjvJbrAacNulVMxG7wFio?=
 =?us-ascii?Q?GbNhOaffwUq4ykwGANIY15GBre2I9+uVFFMfeROCCTURRQT47AhIfUji7bF3?=
 =?us-ascii?Q?fml2aciHVrQGljda0Zb6ASLVw+E3vJTb2t+K1S8/hr1PtS147xrPLqDed4jX?=
 =?us-ascii?Q?QH/XTP2SArUDrAgrVCnFv3XsI2ISW5+W8wQeikjaBdjF5PNfXlRq63SkIMeK?=
 =?us-ascii?Q?C/U4dE8irafqmJprvtDI+I5RYbMsOSQuGK9o9PitdGioiA9g5acsQ98i6pwh?=
 =?us-ascii?Q?v2bQq15qtRoSLaGYJwY8DifWAXfGBiuajvpgHE21GjaLIKPpFcAoHVzgomgT?=
 =?us-ascii?Q?hx6inJjwjDUpXga9/kCmz6ziks1jaS74Rl+dhBProRVoPfcGjcO2CxY1Wyvp?=
 =?us-ascii?Q?Z93nvnFd5WQKYheaTS4e6j+1OvyV+eGhbqb4IFTwrv9aNSjxwO9VPZP6uOl/?=
 =?us-ascii?Q?X22Jj29nbNqXjyQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 05:55:42.0218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c250be9c-c802-4cb0-0987-08dd4cbc3745
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6839
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

From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>

This patch introduces a new function to check if the SMU supports resetting the SDMA engine.
This capability check ensures that the driver does not attempt to reset the SDMA engine
on hardware that does not support it.

The following changes are included:
- New function `amdgpu_dpm_reset_sdma_is_supported` to check SDMA reset
  support at the AMDGPU driver level.
- New function `smu_reset_sdma_is_supported` to check SDMA reset support
  at the SMU level.
- Implementation of `smu_v13_0_6_reset_sdma_is_supported` for the specific
  SMU version v13.0.6.
- Updated `smu_v13_0_6_reset_sdma` to use the new capability check before
  attempting to reset the SDMA engine.

Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 23 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 17 ++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 ++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 23 ++++++++++++++++++-
 5 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 6a9e26905edf..010f05a44287 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -719,6 +719,29 @@ int amdgpu_dpm_send_rma_reason(struct amdgpu_device *adev)
 	return ret;
 }
 
+/**
+ * amdgpu_dpm_reset_sdma_is_supported - Check if SDMA reset is supported
+ * @adev: amdgpu_device pointer
+ *
+ * This function checks if the SMU supports resetting the SDMA engine.
+ * It returns -EOPNOTSUPP if the hardware does not support software SMU or
+ * if the feature is not supported.
+ */
+int amdgpu_dpm_reset_sdma_is_supported(struct amdgpu_device *adev)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret;
+
+	if (!is_support_sw_smu(adev))
+		return -EOPNOTSUPP;
+
+	mutex_lock(&adev->pm.mutex);
+	ret = smu_reset_sdma_is_supported(smu);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
+}
+
 int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 1f5ac7e0230d..353a10119dc5 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -603,5 +603,6 @@ int amdgpu_dpm_set_pm_policy(struct amdgpu_device *adev, int policy_type,
 ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev,
 				      enum pp_pm_policy p_type, char *buf);
 int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask);
+int amdgpu_dpm_reset_sdma_is_supported(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 488360d2aaae..a61c80aed24c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3903,6 +3903,23 @@ int smu_send_rma_reason(struct smu_context *smu)
 	return ret;
 }
 
+/**
+ * smu_reset_sdma_is_supported - Check if SDMA reset is supported by SMU
+ * @smu: smu_context pointer
+ *
+ * This function checks if the SMU supports resetting the SDMA engine.
+ * It returns 0 if supported, -EOPNOTSUPP otherwise.
+ */
+int smu_reset_sdma_is_supported(struct smu_context *smu)
+{
+	int ret = 0;
+
+	if (smu->ppt_funcs && smu->ppt_funcs->reset_sdma_is_supported)
+		ret = smu->ppt_funcs->reset_sdma_is_supported(smu);
+
+	return ret;
+}
+
 int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 {
 	int ret = 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 3630593bce61..090a2b3b81a0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1376,6 +1376,10 @@ struct pptable_funcs {
 	 * @reset_sdma: message SMU to soft reset sdma instance.
 	 */
 	int (*reset_sdma)(struct smu_context *smu, uint32_t inst_mask);
+	/**
+	 * @reset_sdma_is_supported: Check if support resets the SDMA engine.
+	 */
+	int (*reset_sdma_is_supported)(struct smu_context *smu);
 
 	/**
 	 * @get_ecc_table:  message SMU to get ECC INFO table.
@@ -1637,6 +1641,7 @@ int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t size);
 int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size);
 int smu_send_rma_reason(struct smu_context *smu);
 int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask);
+int smu_reset_sdma_is_supported(struct smu_context *smu);
 int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
 		      int level);
 ssize_t smu_get_pm_policy_info(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index d645387beaa4..b69d8c26ca8b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2902,11 +2902,31 @@ static int smu_v13_0_6_send_rma_reason(struct smu_context *smu)
 	return ret;
 }
 
+/**
+ * smu_v13_0_6_reset_sdma_is_supported - Check if SDMA reset is supported
+ * @smu: smu_context pointer
+ *
+ * This function checks if the SMU supports resetting the SDMA engine.
+ * It returns -EOPNOTSUPP if the capability is not supported.
+ */
+static int smu_v13_0_6_reset_sdma_is_supported(struct smu_context *smu)
+{
+	int ret = 0;
+
+	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(SDMA_RESET))) {
+		dev_info(smu->adev->dev,
+			"SDMA reset capability is not supported\n");
+		ret = EOPNOTSUPP;
+	}
+
+	return ret;
+}
+
 static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 {
 	int ret = 0;
 
-	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(SDMA_RESET)))
+	if (smu_v13_0_6_reset_sdma_is_supported(smu))
 		return -EOPNOTSUPP;
 
 	ret = smu_cmn_send_smc_msg_with_param(smu,
@@ -3590,6 +3610,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.send_hbm_bad_pages_num = smu_v13_0_6_smu_send_hbm_bad_page_num,
 	.send_rma_reason = smu_v13_0_6_send_rma_reason,
 	.reset_sdma = smu_v13_0_6_reset_sdma,
+	.reset_sdma_is_supported = smu_v13_0_6_reset_sdma_is_supported,
 };
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.1

