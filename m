Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177A6D2069E
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Oct 2024 06:03:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5159110E68A;
	Wed, 16 Oct 2024 06:03:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dgqFV9gN";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE6F10E68A
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Oct 2024 06:03:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDl4CT/dtxhFDAFlV4+Md1qzu1uNKP0rsgzM3mMXAxdrU4WuWzIUA0iTTKz23DuQ7bLnwm0hcwUibKQnhpyRBzp3X82GjzeGQI8tTOk5a2ohydlPFclhfmL6zWHKk4UtwmweRjdN11KP1Ddc1uDZ3OysE35jU0VA8NapXycWy2lcK3RB5yV/wFXN+xSeOD59uEJ0mK4pRmybd0n6HUMikUtrfgPHi5Hh9okrBbIffCoiza/xT/HeOtP0ItVgO4ig1S9FBfsdlJQbBbJNqY1nQLwH9SWFUJ3/XgrZxjt/htaIxSWWQTHNFQ56lb/GaRHFg2pEI+B+tMuUYItfjNGwUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZOxMsZpL6BpAtd2dtlrfiNEdNGbFd+EKvVyT9aJ/NM=;
 b=ZTpvHCqTmyEMm3V1WRlASY6qCZO+QWNjR9VHxCEM1+NhIqKRablY5iz4VKUug5TwFaSji37PzrYQkSpuyxl1redG9Yt7R5KFAEMx9kf7iN4wq2gLTTeSI6y7FSBG/eGbvao+nvePJeOtxsF2kcxDG8iW8OQMCPuL0a1FcitEW9wk+fZLcJRTxzv5LMHl8t+0jputlS6qllQ9usAjMqeBDv6XxlZuf2syprMAOEHqy9IV9IfcYf7h6OyB8P9mRprqqjAgnAk5je/twBqT/nf0WS0/XCezDxiSihmSru3LR6QFVAI9ILPCJlaItQ0hqEh8J8w96RYIwo8aEUR440HdQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZOxMsZpL6BpAtd2dtlrfiNEdNGbFd+EKvVyT9aJ/NM=;
 b=dgqFV9gN5aHNS3t0f8WilYJj/USmqSPBOJqHa5RE61beApZ7dD1GoRDg1LgCaNZyUL3K3ZUoc8Iqjlnjf34ma5VoskiHt3Zs3wK4UOKu9VhaJZ4FfW9CuvcFKOIuM2ZXTzGZrU2+hPkra8prQtfWfQ8bXNKdrAbty+f/BPIgNIY=
Received: from SJ0PR05CA0171.namprd05.prod.outlook.com (2603:10b6:a03:339::26)
 by BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 06:03:33 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::1d) by SJ0PR05CA0171.outlook.office365.com
 (2603:10b6:a03:339::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 06:03:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 06:03:32 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 01:03:30 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <lijo.lazar@amd.com>, Jiadong Zhu
 <Jiadong.Zhu@amd.com>
Subject: [PATCH v4 2/3] drm/amd/pm: implement dpm sdma reset function
Date: Wed, 16 Oct 2024 14:02:18 +0800
Message-ID: <20241016060219.1811607-2-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241016060219.1811607-1-jiadong.zhu@amd.com>
References: <20241016060219.1811607-1-jiadong.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|BL1PR12MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 597d456c-516a-4db8-cc27-08dceda843db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QFzQ8v/A0yukMDEt6SP2f+T3suzQZlZQm2zinSDjwZHPYxqcFN/6xnii9V2U?=
 =?us-ascii?Q?kz468FN1s6C9g3ZFTddKSQ0jfUWfhm+8x4PmXO8iTcud2G/fWNxgkPvjbg6I?=
 =?us-ascii?Q?UFE3bbOR9F7dFohxl4bl9uuskkTmliKvBeio4plnlqUZx4+k1G6elAI1W9FM?=
 =?us-ascii?Q?g791RjPAb2GUqR2xnquRUHxPpcqun0fr9SSojvlXWoj0VMR+n7/ZA7DfgUrO?=
 =?us-ascii?Q?X8mnUXzLbLTs5F9Z8K0aFqYb38uf4P4j+bt3oDipgCpLszhSEfnqssz24jRP?=
 =?us-ascii?Q?TP3cIbw+0hf5+OWWgVCqVyVEoqo1qdfZ6/EsLHegYwn0kK7uKlcwH1MEM538?=
 =?us-ascii?Q?OW7d9ORbNgG/flhCD030bhOvwtgz3gQ8jSBHHUqKFjrrSbevXGIuR3uVYG8t?=
 =?us-ascii?Q?OTf13ep8nSBhGeVZxcQnZX7JuTcFzdipfaChK9tHSEy2mzfeRBaIQC5NkqOt?=
 =?us-ascii?Q?YKEP6xN/ypCF2PPJTavDuJRuXC5dgKdFCTbJJz8aDpgWxnRcKQBNpzXkRcXz?=
 =?us-ascii?Q?Dzqch5XIfxwr1qW+eLADf4/4FfxN53CWYwcyvf9i4Syoqz5gkE15eton7Tzy?=
 =?us-ascii?Q?pFCDQhpJIMOad7HghUmVB0a5/F7KF5I+G7BcI9XKpPe+RDyn+IAdG/qamAnT?=
 =?us-ascii?Q?/HvtKWCA3FvFUAl7X6QYK1h8USElSuE5z8U5504tqiJjDzIRrzXv8RqAzYO2?=
 =?us-ascii?Q?YMYF1bsHvt7iE6QXhDIrptsI0BSds951FznGBmI24bBL+zp1KFIX+1b5EcI/?=
 =?us-ascii?Q?lyBQcj/sChKTT1gGy9dJAMLx+hyVDGChpf8LHshqwnhaMLeL/JhxO5lGwE6N?=
 =?us-ascii?Q?sz8dF/fL2iwveb86gzCokUapdz14OWAWvgs4m28RBe2R6IxLJT5eDKu2vv4T?=
 =?us-ascii?Q?J7rndmFqG+huEZ6aQv7AXhFhufwXvRuggi/BDJdYu0/lXn31spJO7VMKyg4k?=
 =?us-ascii?Q?KkE7FgIpP5JMeVt7l/qxH1k8Wvys1qSvg3ocKUxdVgN1tbi1W/y1EXm8lyLa?=
 =?us-ascii?Q?xWJ1QA82ja4HblNsgqSyVydP/vWQWSUngUpxQ+ktSHUj/3TPypuYDlQfEOUf?=
 =?us-ascii?Q?jTIsR+ux5vvKMTsDVA94fsU9WE7mejNAIIKxqqeQ29NfE8ozSfsQSMYFbJHo?=
 =?us-ascii?Q?UwhL+aVzEg7rKuGzdwJ+Mp4IKdBgTBMz078VcI/bKW/gtXblxIAHtjT4a7UX?=
 =?us-ascii?Q?otYIxE97+ynYlJ2W1vSytdYEsySslV855ocuJS1opXDqAcvofmOyWbnfbApN?=
 =?us-ascii?Q?GVOHU80ogFUZtXHQz7GpPVSos7ZL93iV+blVttpVuSUtrVa9LSUU+J6liJDX?=
 =?us-ascii?Q?xIkPRKE372eESB2hqnSm8OEg+JwwKhFb2+sn9938+5/hQJ/u7kUbKLhCQjFB?=
 =?us-ascii?Q?W7rxXaj9zbr3n8+NzxKAa2EoODM2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 06:03:32.6659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 597d456c-516a-4db8-cc27-08dceda843db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Implement sdma soft reset by sending MSG_ResetSDMA on smu 13.0.6.

v2: Add firmware version for the reset message.
v3: Add ip version check. Print inst_mask on failure.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 15 ++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 10 ++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  6 +++++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 ++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 23 +++++++++++++++++++
 6 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 9dc82f4d7c93..9e7a652d119b 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -700,6 +700,21 @@ int amdgpu_dpm_send_rma_reason(struct amdgpu_device *adev)
 	return ret;
 }
 
+int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	int ret;
+
+	if (!is_support_sw_smu(adev))
+		return -EOPNOTSUPP;
+
+	mutex_lock(&adev->pm.mutex);
+	ret = smu_reset_sdma(smu, inst_mask);
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
+}
+
 int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
 				  enum pp_clock_type type,
 				  uint32_t *min,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index f5bf41f21c41..41fb6ef984bf 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -597,5 +597,6 @@ int amdgpu_dpm_set_pm_policy(struct amdgpu_device *adev, int policy_type,
 			     int policy_level);
 ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev,
 				      enum pp_pm_policy p_type, char *buf);
+int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask);
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 4a6b4ad97f06..590d004046ef 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3820,3 +3820,13 @@ int smu_send_rma_reason(struct smu_context *smu)
 
 	return ret;
 }
+
+int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
+{
+	int ret = 0;
+
+	if (smu->ppt_funcs && smu->ppt_funcs->reset_sdma)
+		ret = smu->ppt_funcs->reset_sdma(smu, inst_mask);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index b44a185d07e8..5487d9d84a4d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1371,6 +1371,11 @@ struct pptable_funcs {
 	 */
 	int (*send_rma_reason)(struct smu_context *smu);
 
+	/**
+	 * @reset_sdma: message SMU to soft reset sdma instance.
+	 */
+	int (*reset_sdma)(struct smu_context *smu, uint32_t inst_mask);
+
 	/**
 	 * @get_ecc_table:  message SMU to get ECC INFO table.
 	 */
@@ -1630,6 +1635,7 @@ void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev);
 int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t size);
 int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size);
 int smu_send_rma_reason(struct smu_context *smu);
+int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask);
 int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
 		      int level);
 ssize_t smu_get_pm_policy_info(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index e71a721c12b9..855eb57c734d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -275,7 +275,8 @@
 	__SMU_DUMMY_MAP(RmaDueToBadPageThreshold), \
 	__SMU_DUMMY_MAP(SelectPstatePolicy), \
 	__SMU_DUMMY_MAP(MALLPowerController), \
-	__SMU_DUMMY_MAP(MALLPowerState),
+	__SMU_DUMMY_MAP(MALLPowerState), \
+	__SMU_DUMMY_MAP(ResetSDMA),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 52f3c537bb3f..5bede26aaaa0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -182,6 +182,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(SelectPLPDMode,                      PPSMC_MSG_SelectPLPDMode,                  0),
 	MSG_MAP(RmaDueToBadPageThreshold,            PPSMC_MSG_RmaDueToBadPageThreshold,        0),
 	MSG_MAP(SelectPstatePolicy,                  PPSMC_MSG_SelectPstatePolicy,              0),
+	MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,                       0),
 };
 
 // clang-format on
@@ -2697,6 +2698,27 @@ static int smu_v13_0_6_send_rma_reason(struct smu_context *smu)
 	return ret;
 }
 
+static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+
+	/* the message is only valid on SMU 13.0.6 with pmfw 85.128.00 and above */
+	if ((adev->flags & AMD_IS_APU) ||
+	    amdgpu_ip_version(adev, MP1_HWIP, 0) != IP_VERSION(13, 0, 6) ||
+	    smu->smc_fw_version < 0x00558000)
+		return 0;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+					      SMU_MSG_ResetSDMA, inst_mask, NULL);
+	if (ret)
+		dev_err(smu->adev->dev,
+			"failed to send ResetSDMA event with mask 0x%x\n",
+			inst_mask);
+
+	return ret;
+}
+
 static int mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
@@ -3342,6 +3364,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.i2c_fini = smu_v13_0_6_i2c_control_fini,
 	.send_hbm_bad_pages_num = smu_v13_0_6_smu_send_hbm_bad_page_num,
 	.send_rma_reason = smu_v13_0_6_send_rma_reason,
+	.reset_sdma = smu_v13_0_6_reset_sdma,
 };
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.1

