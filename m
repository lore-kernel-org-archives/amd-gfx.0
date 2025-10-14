Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA37CCD184
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 07:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D93D10E54B;
	Tue, 14 Oct 2025 07:07:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bQm6XC7y";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011034.outbound.protection.outlook.com [52.101.62.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BADE10E54B
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 07:07:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxGA/LDydYuaenXy0Pb4ABW4jeyixjSJE3ds40bAy/pvKBz/w/6I7wFuVKFEP4lyNMrEVT75Rymp10NIif39ZxCWBBdKN09ugeKlSYUncykUy4Yv/kp09gbm6+sjWTZKGfImCzpPVmS1nGjEQgpZqngCFOiAyu/Y2WYJFUr6qt7FyuehOouKKh1bBiko2YZ0vNtdOUduVxFx3xfUQkBy/iQ+s26FISnhvooNbKvasVfbZO/GvvXuvSEbiM2qin4iypUpNchpTxjwxrZr6Ic44e27n6iOgUA18wqauM0RW4+hC5A3HzlnabRzA6tBJQsoGWmi8KfAUa2kQWCUs1zfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GwYm5gjxfnGsIItJqd0vK8Eum6R5JHrvUuiR4L2isc=;
 b=DVsumBDUutLIm/yOrTBE9enp7t43Q/ZhViIMpNyeCzeVcCxCxz+b+oRat7EBXT68dZ/JbqUu7kXImhFX46j6gDe/G6ZV/eApJzD2AQeVV0rSpcgN4oNLPHEddJKb/tknFYznIRqEQEM6WnavnvHTnwI3rO0KYErF91JybRmTOcUK+8FKPwSWMrixkayS7qna2Hzr07zjvL/5iXosfNrtrDo3l6qcbCf1nTxXCHRx0GfkZg7KMpaqXJjXRuKzsbUl/sUE01UMn9SX4Fe/EocShEpZ0wsW91IjkMw4cmajg+tfz1JwQvIVnoMfUDIMYYtivcQ5Scu2HSIsKcTtFbfTuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GwYm5gjxfnGsIItJqd0vK8Eum6R5JHrvUuiR4L2isc=;
 b=bQm6XC7yeLhya954mADXEBkmd7Jd8IYVpQYKIRUV+6e0VhkwaqQ/UEZY2OcrLKZ/EH/srw9vJIb4KiMgXsZXFr+WyX/e79UNOlMUvCBKZgeJTHF61ohgCSCbAfvGnbssTRC9fokwDupHsz8HamaXC0CEQTSAdQy+zUER0sfUuC0=
Received: from BLAPR05CA0041.namprd05.prod.outlook.com (2603:10b6:208:335::24)
 by BN7PPFCE25C719B.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Tue, 14 Oct
 2025 07:07:34 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:335:cafe::47) by BLAPR05CA0041.outlook.office365.com
 (2603:10b6:208:335::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Tue,
 14 Oct 2025 07:07:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 07:07:34 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 00:07:31 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add ras module ip block to amdgpu discovery
Date: Tue, 14 Oct 2025 15:06:16 +0800
Message-ID: <20251014070617.698199-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|BN7PPFCE25C719B:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f3e409-c988-4888-313b-08de0af05983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8Wf4c9J5LfRkUJ/VzB4rkdNmixhdF5GBsgIe1iWnb07dC++SnFSSgpQD/jsR?=
 =?us-ascii?Q?NKlu6sOgJ95MtpHJjq7ck9fBtjCv2K4aObDg1j1Hs+N0nvSVP1P9nJj4WaCQ?=
 =?us-ascii?Q?3NQD8dgUIS3hS1iuWUVUmc0uKm3gX1SWKNqtJaUZQ+nO1glaCEBi6tSiW5Xp?=
 =?us-ascii?Q?DOvhD6ojmh+wLPAEoJZ2xI8r68ZexkMfNVAxCrlpIxXMrbfpXOq4ke8JyucB?=
 =?us-ascii?Q?LJns4YOPvF62YQlq1sieaOkQh098LJa7Ls9uXdfqqDi6q1QE/Cqu2zCa5BKt?=
 =?us-ascii?Q?HC+QxGDxYZ5WcWWcfvKRr8qbP9x9mkdUc0H1fAvs9F7DJ2+2B3+bbkAdAWov?=
 =?us-ascii?Q?lC6hAk9wer/wPH6zs//S8dP6hf11/GgN8nHJj1tsCGI7Ctl104W10YcxrJ1J?=
 =?us-ascii?Q?bRR5Xfot6palKjEBK0EnNW58P59oIsCiPTY/mg0DWsmuLdP1VoJ6j47qoJAl?=
 =?us-ascii?Q?uoh/mjw8pRYmnVaIjlMfeAGmtK9LuhIw0Yoelpxbr9QlTENk2N2l3MDwRG2W?=
 =?us-ascii?Q?NW9R063M6skTmyT7qcU6NuB9Y9QX9ibNWzTHFhavPi9YdLSpWAGZ6KwOJsJB?=
 =?us-ascii?Q?UfylI9Mkkj+M1n83uZSr9l1UCP6Jd06a3OW0+nG2QDg5HBz3kkNecmww1CVy?=
 =?us-ascii?Q?4v0KfPEOTipSrkS+CSypm91RrVqJ+iX0V12nM8GNK+JvZoPwIFZMk4BJRqdT?=
 =?us-ascii?Q?BwPegLP5PRAa6WjNOxPlTzpWtO4LSh0bsMdQ3uxAW45c0RSi6Vm6LLdkCrl4?=
 =?us-ascii?Q?vwwsYhUWwKq59e5HndgG5deNpHSDzfwBM7gb71PfXWRb+CCOirmSCaOSOlSr?=
 =?us-ascii?Q?54QmpUGRDHQe2yJNEkTfwItd4kf5x0793vHhfcyjB55hg8CwJqfFd1N7x49c?=
 =?us-ascii?Q?2fiauPBEtXPeLx8LWhMpaw7p7c7QB74zt9Qq1UkjJZYFGzo0r8KFwHtxJhcD?=
 =?us-ascii?Q?uEjj+ZnwdQytozREkeFcWovHneURDcY1KdZMdGUJO5gKdMAA7a6q9wlOpVsj?=
 =?us-ascii?Q?E2NfrRY34m34VhRHZxTlyTkHmJ3mt3GMZx+/ANhhzIVV/3q9Wsdc1DiXT9EY?=
 =?us-ascii?Q?TEs+xkTgLJdfFvKdcevHRMKztSNLr/dVx7AjnMZOKu2B/Xz3o6/9DHtBLbxC?=
 =?us-ascii?Q?QQmqX8QbmQk/vcy3TxFXS87H7OInmhK84YsjvMIuZZ029opSmtLxljkAaeb4?=
 =?us-ascii?Q?DysC7+kZSYqj0q7LWTrrr+4Nd8YjOQx0R6rW/hdda4q6RvhW7iyFvIE08iS1?=
 =?us-ascii?Q?fsEdxfCW1z4lv4DLVbmMm1yZLSnmgEGlLpHM35cN8EPx7A36js6b+OCtlxIv?=
 =?us-ascii?Q?uwYwxn58JnatJg4RvKbc6PYiz/7w4utV2AQUOCvYxnSphxgZnrdPdmuufrh+?=
 =?us-ascii?Q?DUEm1nBEdUWEYZ/GsHq+KLM0YVt28f3lIAfyWA7ahEB4+UEhmvp7lmMhbrQC?=
 =?us-ascii?Q?KczcA5P3hjw6bizcIoJ4aWAn5DPIVg73X9hQAkUWZ7tkUS+s95PAf4zqsv9q?=
 =?us-ascii?Q?KPqbS2HSgvaeQOky9BIS08fDx1uL6BFaeNIAe+jCX4tWqbb6PZvaJXoFh68q?=
 =?us-ascii?Q?TaIceeyyJJ+ulGrAB/E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 07:07:34.2942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f3e409-c988-4888-313b-08de0af05983
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFCE25C719B
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

Add ras module ip block to amdgpu discovery.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 20 +++++++++++++++++++
 drivers/gpu/drm/amd/include/amd_shared.h      |  1 +
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |  8 ++++++++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h  |  2 ++
 5 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d9bd1d71552e..04c1f004931b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -378,7 +378,7 @@ int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block);
 
 int amdgpu_ip_block_resume(struct amdgpu_ip_block *ip_block);
 
-#define AMDGPU_MAX_IP_NUM 16
+#define AMDGPU_MAX_IP_NUM AMD_IP_BLOCK_TYPE_NUM
 
 struct amdgpu_ip_block_status {
 	bool valid;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 4e75334f3b3a..b4d52da687a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -112,6 +112,7 @@
 #if defined(CONFIG_DRM_AMD_ISP)
 #include "amdgpu_isp.h"
 #endif
+#include "amdgpu_ras_mgr.h"
 
 MODULE_FIRMWARE("amdgpu/ip_discovery.bin");
 MODULE_FIRMWARE("amdgpu/vega10_ip_discovery.bin");
@@ -2393,6 +2394,21 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_ip_version(adev, SDMA0_HWIP, 0));
 		return -EINVAL;
 	}
+
+	return 0;
+}
+
+static int amdgpu_discovery_set_ras_ip_blocks(struct amdgpu_device *adev)
+{
+	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
+	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 12):
+	case IP_VERSION(13, 0, 14):
+		amdgpu_device_ip_block_add(adev, &ras_v1_0_ip_block);
+		break;
+	default:
+		break;
+	}
 	return 0;
 }
 
@@ -3173,6 +3189,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	r = amdgpu_discovery_set_ras_ip_blocks(adev);
+	if (r)
+		return r;
+
 	if ((adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
 	     !amdgpu_sriov_vf(adev)) ||
 	    (adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO && amdgpu_dpm == 1)) {
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 75efda2969cf..17945094a138 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -109,6 +109,7 @@ enum amd_ip_block_type {
 	AMD_IP_BLOCK_TYPE_VPE,
 	AMD_IP_BLOCK_TYPE_UMSCH_MM,
 	AMD_IP_BLOCK_TYPE_ISP,
+	AMD_IP_BLOCK_TYPE_RAS,
 	AMD_IP_BLOCK_TYPE_NUM,
 };
 
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index a8d02bd42f90..3ae843d078d8 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -381,6 +381,14 @@ static const struct amd_ip_funcs __maybe_unused ras_v1_0_ip_funcs = {
 	.hw_fini = amdgpu_ras_mgr_hw_fini,
 };
 
+const struct amdgpu_ip_block_version ras_v1_0_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_RAS,
+	.major = 1,
+	.minor = 0,
+	.rev = 0,
+	.funcs = &ras_v1_0_ip_funcs,
+};
+
 int amdgpu_enable_uniras(struct amdgpu_device *adev, bool enable)
 {
 	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
index 8d6a1873b666..814b65ef1c62 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
@@ -54,6 +54,8 @@ struct amdgpu_ras_mgr {
 	bool ras_is_ready;
 };
 
+extern const struct amdgpu_ip_block_version ras_v1_0_ip_block;
+
 struct amdgpu_ras_mgr *amdgpu_ras_mgr_get_context(
 			struct amdgpu_device *adev);
 int amdgpu_enable_uniras(struct amdgpu_device *adev, bool enable);
-- 
2.34.1

