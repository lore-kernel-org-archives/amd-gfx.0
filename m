Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E96DC3600C
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Apr 2025 03:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A81E810E4CD;
	Tue,  1 Apr 2025 03:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3T0VgSac";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C691A10E4CD
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Apr 2025 03:05:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctvWcshCZFKhd0LkgEDAEO5LfmV20jh28nkZXr559BcEoA0XvHFOfgW9/B8A0sdQ2B2Dhmyqgj341DMujl35r6AVcZ/U8rAP5zlZNYdTk00mksyg7fTE9FGrdlCIHlwDuYKFHCx81GtfM0YFsEY7lQd3FGdWJSUBs5TdbuqmtUZR3PN8SPbmCUdzv7Ydd0Vp/wmBcMI9nJogUVCCl8cKngpnRhBfgJ3Hd23LRv+kKpKxPHJwYS+MRuvo8egltMktkH2B3j1P0DqJNvhvDqHlW8qkMr2RIe14HAFiP9Pc3gmtitMjAsdL/+IWZ33978jFYKTphlUhwX47wlJm1JgshQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAfnLn16oyWoySZYU0h2ZWwFZQN1tcVP8VzeW+iyVQY=;
 b=w99p40qX2lRL3zxGP9WCPpfjl7pCwWSRQQLVyr8mo2VvWSSvptPgY8asq9KzBWQihqKyLRKYyrqnvywDsoLzhPianNRALXpdYItRfnouM8YkSlWHTZOT/IBaLOzps1GCIrUkavpYlzrr9YuBuBjX5PARspP2dXtGtZKpp4yhTIrA4m6oafG6TeAwih7GGK+/iDPde97rDnW5LJTqITc5YFUHj7iUAdxYCqHM0KAovcefEmh3o9Y4DZDe7sHvZ56clfWy+OOTpYRxfoOUFgWsn9Dg8U+YtsFBLQFYnzKrF2T6m9rgNJ/9fda3/ds+AuY1RJfW0Hjf1PvTSC1m8J4nNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAfnLn16oyWoySZYU0h2ZWwFZQN1tcVP8VzeW+iyVQY=;
 b=3T0VgSacIPhgYXwDXu93W87938b2/q7GNNzk/+Pnu7fe/zY0PIhTVctiFI6HhV9Yz3sH6RSakXGHUkFRXK5hyno634kI7dxVrBQQRdv8xfdZ9FKOy0j7CybXXeHzPkSBXowKnNjyhjXP5/O+GbtOqW/MkWmde/guOO1l6+IlHE0=
Received: from BL0PR0102CA0037.prod.exchangelabs.com (2603:10b6:208:25::14) by
 CY5PR12MB6347.namprd12.prod.outlook.com (2603:10b6:930:20::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Tue, 1 Apr 2025 03:05:47 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::c) by BL0PR0102CA0037.outlook.office365.com
 (2603:10b6:208:25::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Tue,
 1 Apr 2025 03:05:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 1 Apr 2025 03:05:47 +0000
Received: from ruili-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 22:05:43 -0500
From: <ruili.ji@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Leo.Liu@amd.com>, <Sonny.Jiang@amd.com>,
 <Shimmer.Huang@amd.com>, <Jenny-Jing.Liu@amd.com>, Ruili Ji
 <ruiliji2@amd.com>
Subject: [PATCH 1/3] drm/amd/pm: implement dpm vcn reset function
Date: Mon, 31 Mar 2025 23:05:32 -0400
Message-ID: <20250401030534.3880347-1-ruili.ji@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|CY5PR12MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 107b1c9d-55af-445c-1bc5-08dd70ca19b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z8/l9/EODX2ndnYUGz8fWzY/Xy9j0qcgcvMWiR3fEPRg+AtKaNa0BAWr8O8w?=
 =?us-ascii?Q?elmO/J0i9SyCPUKfDFYRujB/a1vP1XfvOEMdQani3GIW/IK+TDSXrHpAIfkp?=
 =?us-ascii?Q?vwqtJAS1ltoPUCSdg+L4VpIvh4ugeg+dpNq5hXGzdSEBckXvdvqtjk3RTj9+?=
 =?us-ascii?Q?8/1nQz+Iy1H5LAd2BjZcwdsgrDMF3FNWHJviOv5cHpspjMEIq2d1hGr5AIfy?=
 =?us-ascii?Q?BF6GOuKwzMJUVbSKS3glNmlQzyNgj6EMwwtJGjIDRNYKEME8ZZqNz8egAkKu?=
 =?us-ascii?Q?miI/QzGkmtD1me1rEadPb/QQAv79t/u89djCDnRLqxGVgxiqru1Pe2FuzTrW?=
 =?us-ascii?Q?wWXx/j7hAn+cGROQR3XHbmRLrRp3k25b/drd2MutkDeGMnJKXCdAQ6QzklkA?=
 =?us-ascii?Q?l5rr50Sm0k6k0DYQk+a//yWn3Kt3yBMM3Vn3Ny0I1ixrfegYJEJC/3oFKfG1?=
 =?us-ascii?Q?z4mHBiqVnMqD7555Ga1peNlzTmML6+lZC+0qwW6d6gDPqq1EozEBefyrEtl5?=
 =?us-ascii?Q?wo+3OdsOU5yfYIKNunVL4Tk72bqCXESihAem5tMAxyeF5BcrY3t2a8u4bD5k?=
 =?us-ascii?Q?1dBPpdZcxOgzirYflkD6JT5PMvlcoAsPdV2ai4uVaOahSXcI9Vb01T5NxKB3?=
 =?us-ascii?Q?x3e9yw4T5l+7l3CznaROxqC/GpNxmW4FxEFnmqDb4RdDFFR7oEZ5IBbY+rBp?=
 =?us-ascii?Q?0i9eC6gS83KagqcJCi83Jj4Xf6sdyS9L7k5NwT66bsrgWYyk4gxpcshFf4Of?=
 =?us-ascii?Q?vglhgWsegyMZAH9aJgGJwhvhJf/O4VHM2/vFats76cG2dBkf6Ldiyxta9hu3?=
 =?us-ascii?Q?zlLdsjGPLQLzjKXUa83ufwu9SMMFmcJCMiW9ekv1P2b6OMrmhqRUgEgNZ97z?=
 =?us-ascii?Q?/4NJXlSVDnN6V62TLEJfYTOz/xkMdEhW9JqSTy1i+7Ev+baWbm6kf02FYhvu?=
 =?us-ascii?Q?3VUHqAgzsvVoQFN6cjB1PVtX1HOXxuNgTbyVARAow1p9tXIbXjAI+kHOb7ip?=
 =?us-ascii?Q?0lNkkuyBtFCdwNjpfOAhqvYmU4hzyyl/0gqFWJIxAggZgXgKJdaErLPKKQIb?=
 =?us-ascii?Q?HEsr6vGuRMRN0sKCIucMc556voiatHuE9ma5p4YStkWmvjaN4GmP2Dj8W2UI?=
 =?us-ascii?Q?7L3En0OZpwz+WGw4bUBxwYQeAnqQdElA1NUE7lUlN3wY/jUYlz9M4gXsVW1j?=
 =?us-ascii?Q?KT3iKd9ZKTN98uM5zthrltE4R/V8LmeKEggInSd9e9WiMTH27tmKG9Va9k8m?=
 =?us-ascii?Q?l/Vv29RNkp5sJNLwkJLfr75RyXSgsnTYZfi4JXeCG/cVs10CPj9iFwjHbiY8?=
 =?us-ascii?Q?druFZ/2iBal91CtIjnKPWcJiCPAwPKOtD39Gz/XhqKT/rG0CIqgKBng4pcma?=
 =?us-ascii?Q?VsXCTwqAQDsA+2+rSXGHMKszDKKw/XBnRFdQE08K7PHXV2cGCTa5884NWeB4?=
 =?us-ascii?Q?Yj93fQBpbvA/oAf9LajWrxlSapXcpFsqVGWw/7yA6om/gLe2Y/mIoxitdCfn?=
 =?us-ascii?Q?JR+XqnohXayVzKc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 03:05:47.2817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 107b1c9d-55af-445c-1bc5-08dd70ca19b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6347
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

Implement VCN engine reset by sending MSG_ResetVCN
on smu 13.0.6.

Reviewed-by:Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by:Leo Liu <leo.liu@amd.com>
Signed-off-by: Ruili Ji <ruiliji2@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c              | 15 +++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h          |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        |  8 ++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h    |  6 ++++++
 .../amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h |  3 ++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h     |  1 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 16 ++++++++++++++++
 7 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 81e9b443ca0a..2c14b4ee8b70 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -761,6 +761,21 @@ int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask)
 	return ret;
 }
 
+int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask)
+{
+       struct smu_context *smu = adev->powerplay.pp_handle;
+       int ret;
+
+       if (!is_support_sw_smu(adev))
+               return -EOPNOTSUPP;
+
+       mutex_lock(&adev->pm.mutex);
+       ret = smu_reset_vcn(smu, inst_mask);
+       mutex_unlock(&adev->pm.mutex);
+
+       return ret;
+}
+
 int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
 				  enum pp_clock_type type,
 				  uint32_t *min,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index f93d287dbf13..a22a97ef6d8e 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -605,5 +605,6 @@ ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev,
 				      enum pp_pm_policy p_type, char *buf);
 int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask);
 bool amdgpu_dpm_reset_sdma_is_supported(struct amdgpu_device *adev);
+int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask);
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 033c3229b555..e2dd6709b26d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3941,3 +3941,11 @@ int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 
 	return ret;
 }
+
+int smu_reset_vcn(struct smu_context *smu, uint32_t inst_mask)
+{
+	if (smu->ppt_funcs && smu->ppt_funcs->dpm_reset_vcn)
+		smu->ppt_funcs->dpm_reset_vcn(smu, inst_mask);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 3ba169639f54..2f7baae7405d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1381,6 +1381,11 @@ struct pptable_funcs {
 	 */
 	bool (*reset_sdma_is_supported)(struct smu_context *smu);
 
+	/**
+	 * @reset_vcn: message SMU to soft reset vcn instance.
+	 */
+	int (*dpm_reset_vcn)(struct smu_context *smu, uint32_t inst_mask);
+
 	/**
 	 * @get_ecc_table:  message SMU to get ECC INFO table.
 	 */
@@ -1642,6 +1647,7 @@ int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size);
 int smu_send_rma_reason(struct smu_context *smu);
 int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask);
 bool smu_reset_sdma_is_supported(struct smu_context *smu);
+int smu_reset_vcn(struct smu_context *smu, uint32_t inst_mask);
 int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
 		      int level);
 ssize_t smu_get_pm_policy_info(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 288b2576432b..348d06a3200c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -94,7 +94,8 @@
 #define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
 #define PPSMC_MSG_SetThrottlingPolicy               0x44
 #define PPSMC_MSG_ResetSDMA                         0x4D
-#define PPSMC_Message_Count                         0x4E
+#define PPSMC_MSG_ResetVCN                          0x4E
+#define PPSMC_Message_Count                         0x4F
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index c9dee09395e3..eefdaa0b5df6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -277,6 +277,7 @@
 	__SMU_DUMMY_MAP(MALLPowerController), \
 	__SMU_DUMMY_MAP(MALLPowerState), \
 	__SMU_DUMMY_MAP(ResetSDMA), \
+	__SMU_DUMMY_MAP(ResetVCN), \
 	__SMU_DUMMY_MAP(GetStaticMetricsTable),
 
 #undef __SMU_DUMMY_MAP
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 682646068000..dcba2b351068 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -195,6 +195,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(RmaDueToBadPageThreshold,            PPSMC_MSG_RmaDueToBadPageThreshold,        0),
 	MSG_MAP(SetThrottlingPolicy,                 PPSMC_MSG_SetThrottlingPolicy,             0),
 	MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,                       0),
+	MSG_MAP(ResetVCN,                            PPSMC_MSG_ResetVCN,                       0),
 };
 
 // clang-format on
@@ -2939,6 +2940,20 @@ static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 	return ret;
 }
 
+static int smu_v13_0_6_reset_vcn(struct smu_context *smu, uint32_t inst_mask)
+{
+	int ret = 0;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ResetVCN,
+	                                              inst_mask, NULL);
+	if (ret)
+		dev_err(smu->adev->dev,
+			"failed to send ResetVCN event with mask 0x%x\n",
+			inst_mask);
+	return ret;
+}
+
+
 static int mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
@@ -3611,6 +3626,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.send_rma_reason = smu_v13_0_6_send_rma_reason,
 	.reset_sdma = smu_v13_0_6_reset_sdma,
 	.reset_sdma_is_supported = smu_v13_0_6_reset_sdma_is_supported,
+	.dpm_reset_vcn = smu_v13_0_6_reset_vcn,
 };
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
-- 
2.34.1

