Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B315FCE8D6B
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Nov 2025 06:38:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D25510E192;
	Mon, 17 Nov 2025 06:38:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ag9bWqxY";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013029.outbound.protection.outlook.com
 [40.107.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C113310E192
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Nov 2025 06:38:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHJnrXhp+S0fg8UTV5v6G7Hnyy7Q1kric1lE4HirHRc3+Ad6qnyR3dwty0WHEfU+PfXHabE8paiM2EFPyIFkUw19OJX7t4YwTScB/cdqw698FP/HjdeC28oMkQxfF8/pBaE2uMqhfZHepIn+oyjw6/L1UeMQ19HhXRm67HAuPyxiIbEtcBKBFbpx2DId/Dpsx8kQ8aBtKWSFGtgtKWU9SH3tD/RUp/UQY18p0aapIMLqz0wgSpDTPDo/2nKO8gZO2KSmbWFvs7EQOHhFrbDzgT9jYkjGlNUdo+tGB4DVUaw1+1KT/KKWaw/4EZ1sM5Oxp6143pdk635WxTQwkoRG3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uf2emAwj/D1Iz0Vh5/8MjcaNMbu+d9/OOcFI6iwVMDQ=;
 b=yO7M9/XvRNTglRZlClh3eVGR7gerxwkNEi5VbU3HyVqHcV0XMUdBPvWwKgKdCO9mP+HHyS7qQI8q/ErjAFbfv1sRpQGsviYMoC6oYh6AnU6OyhfxDuNVGjenDSYKHVjLN98QISh6Bl8VsVc5Q6jEO5iw+83SRyjxFalVkUTxKCqXePZcAzwkp1UFxri1NFbZUXy+SqOLEW7P1XpQUNxePvlaFDW+leDO/QHdOCnfbPTaA0XgKz7oSnjwXBo4Ws9c/iFK9xhKq1e/+aP6DrlNMFX42H51GMS+EkCVMXBy7Ztfqvqj2CjDnraI7W+C2cr4rToYbr2fGwEAbYVWJpQRcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uf2emAwj/D1Iz0Vh5/8MjcaNMbu+d9/OOcFI6iwVMDQ=;
 b=Ag9bWqxYnfxFWkQqAelvfhjqPlfIxaVcFEXb0uW09tuUOh6xRgldHReECshGc6/cKp6jHZO2sfRkUNYwLWoIZVWYery1EE+IzfSUQ/BD2c5k/I4jjaoNDhm/U3i30rN5QxCMS5Had2jUFbHFjV4btlSpGTDIRHOL6eGBBCQLw2M=
Received: from BL1P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::10)
 by SA3PR12MB9225.namprd12.prod.outlook.com (2603:10b6:806:39e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 06:38:48 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::63) by BL1P222CA0005.outlook.office365.com
 (2603:10b6:208:2c7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.20 via Frontend Transport; Mon,
 17 Nov 2025 06:38:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 06:38:47 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 16 Nov
 2025 22:38:45 -0800
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <emily.deng@amd.com>, <victor.zhao@amd.com>, <philip.yang@amd.com>,
 <felix.kuehling@amd.com>, chong li <chongli2@amd.com>
Subject: [PATCH] drm/amdgpu: reduce the full gpu access time in
 amdgpu_device_init.
Date: Mon, 17 Nov 2025 14:38:21 +0800
Message-ID: <20251117063821.3434458-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|SA3PR12MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: 817d5b11-bc7e-4729-d820-08de25a3f670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8z7abWbaFO3hoEsNnYrjocCpRMCemmPvx++7BU8rJw0rfgCtTzEnHfvpYO7c?=
 =?us-ascii?Q?akrlAdKcNBALb1l5EAugJurqUT8ld5FoMg8eljlMuMvZtpNvgMMD/lXx2kZT?=
 =?us-ascii?Q?eVwwOYAxH4ha4K1qT4jGn+8uNk9MfO/yp09V/Snlqobg6jWekf3kcKrdOTUW?=
 =?us-ascii?Q?QeU75fBsTu0SeKEGAYXDhgiUWvNfUrFeln+TT8wjrSNSoBrFfTV3aJKfS5i3?=
 =?us-ascii?Q?U535ASxPkMOM5E8aCn8sX9ZmuTGkKqSVwgDBN117mDA2wKLBTs8vFLuYWJvt?=
 =?us-ascii?Q?9fs3DBfNIoUWr2esQ3WGKDQNmtWznrZbgsRxz9rEAMNgllnJvqfXnMOZNMA3?=
 =?us-ascii?Q?rwwQXclsMqgutJmA1uX1X5SB2MaSoDuq6DawM/R1FakgdcSjMydAhEzmDDsW?=
 =?us-ascii?Q?kByeU8bVBA8xvcrSReNEDC2+XYhmCpuUMreM4FO9rpIkzoWCl8kNRsRbOTqA?=
 =?us-ascii?Q?pbXANYNm0ef94IS6GLdnQ34ULPhHYC8Btd12cxfu62Y34i+DZei7DJ3xfZAu?=
 =?us-ascii?Q?FmLjc5M8TrMnazkoGMdV+hGKm7h/N9XTvW/0USE7BAv3vr7Cq20wIfyWnqZH?=
 =?us-ascii?Q?C5qy1qo/cf3D90132NbJjA9UMkPLX60se5mMWniy95ia5Pg9x1pRuCafGRce?=
 =?us-ascii?Q?X0HoAW40LB51gbC8Qmc40Kn+iSc+uBsKxJ0qfpF+LJlXEn9Xku1AEPXrmBJF?=
 =?us-ascii?Q?og54RRsjx7oZ2WCulMT8nYsy/CBXI4vP2XFHN/whcLnvhXFk2RqSbhD4RmBV?=
 =?us-ascii?Q?qxqlHX5dE8qzw35DxVQjlOr8BslT9lOonyZuqFlhtyAQhl5G8jG8ellkDOTO?=
 =?us-ascii?Q?c1uNHgPoe7pVs6HwX9MdxBpTOuembNA/LR1qvlwDdKByEwjrwPkQh1xVhypE?=
 =?us-ascii?Q?s1w9QPRnXPbOnC/3w4Bx0HAVJ98y3rrdu4LfCwbEsrwHBoW9vSw17xLsO2qe?=
 =?us-ascii?Q?2h2zLkk9NCQ6V770Zr1a6R2+22xfpEoCIfiV85A91194Spl6mLbcBVqmkpK1?=
 =?us-ascii?Q?o0Dzd6tDkjatdgyFiF/8L0CQvS8um1u+o60ayrXpOUKxyjkMpVTUC5er+GKD?=
 =?us-ascii?Q?3Tc6yW9spwr2mci3LhO8DFUv+OyrKs7SVQ6vM+hA9Tde2+mn2qya7QbY0BRb?=
 =?us-ascii?Q?CiiVcN+MbpAih2c0oZL6XuHlYVup5cYpy1cq8V/GxeTXTb5GpENrN0HSI1Zd?=
 =?us-ascii?Q?jDWIROruJkUkoHv6mDQ+7a3F4Pr16aeykGv2EileBQXVfN41CvmQ1Rpayp51?=
 =?us-ascii?Q?Flo9ds9C/8jxCb2MXKbO+m0ADhA5eDVw0PEHnNhkRENMMY9S3n8wiyhdiZl+?=
 =?us-ascii?Q?r3R9WI5IshrsjEprOyiBBUT0fQMriiXQ9Po5H8R58b+lJFnXmDRsLcrIYkB3?=
 =?us-ascii?Q?ZwkT8+bkMt+AWSW1xFe62+F+OPB7q69j+XUIZFqWwwMLF+XGr2VSAccS+SDY?=
 =?us-ascii?Q?Yh2SO5WC8W6NbElggUogqU04iU3LIsJbydD8nRF5YB9MYdAi2MZ/t+emsaKd?=
 =?us-ascii?Q?GrNt/+U7xNFl9leSdIF7li5DAOu1EimmFJSL3BQLWGwi9B5GT7nKw/nGzdLt?=
 =?us-ascii?Q?x8LNSHomsnCsg60NsVw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 06:38:47.7217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 817d5b11-bc7e-4729-d820-08de25a3f670
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9225
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

[Why]
function "devm_memremap_pages" in function "kgd2kfd_init_zone_device",
sometimes cost too much time.

[How]
move the function "kgd2kfd_init_zone_device"
after release full gpu access(amdgpu_virt_release_full_gpu).

v2:
improve the coding style.

Signed-off-by: chong li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  8 +++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 23 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h  |  6 ++++++
 4 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 40c46e6c8898..6d204ba2c267 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -37,7 +37,7 @@
 #include "amdgpu_sync.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_xcp.h"
-
+#include "kfd_topology.h"
 extern uint64_t amdgpu_amdkfd_total_mem_size;
 
 enum TLB_FLUSH_TYPE {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0b40ddcb8ba1..b4e1f258119c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3333,7 +3333,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 
 	/* Don't init kfd if whole hive need to be reset during init */
 	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
-		kgd2kfd_init_zone_device(adev);
 		amdgpu_amdkfd_device_init(adev);
 	}
 
@@ -4931,6 +4930,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	if (adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL_XGMI)
 		amdgpu_xgmi_reset_on_init(adev);
+
+	/* Don't init kfd if whole hive need to be reset during init */
+	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
+		kgd2kfd_init_zone_device(adev);
+		kfd_update_svm_support_properties(adev);
+	}
+
 	/*
 	 * Place those sysfs registering after `late_init`. As some of those
 	 * operations performed in `late_init` might affect the sysfs
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 8644039777b8..8511b00a7463 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2475,3 +2475,26 @@ int kfd_debugfs_rls_by_device(struct seq_file *m, void *data)
 }
 
 #endif
+
+void kfd_update_svm_support_properties(struct amdgpu_device *adev)
+{
+	struct kfd_topology_device *dev;
+	int ret;
+
+	down_write(&topology_lock);
+	list_for_each_entry(dev, &topology_device_list, list) {
+		if (!dev->gpu || dev->gpu->adev != adev)
+			continue;
+
+		if (KFD_IS_SVM_API_SUPPORTED(adev)) {
+			dev->node_props.capability |= HSA_CAP_SVMAPI_SUPPORTED;
+			ret = kfd_topology_update_sysfs();
+			if (!ret)
+				sys_props.generation_count++;
+			else
+				dev_err(adev->dev, "Failed to update SVM support properties. ret=%d\n", ret);
+		} else
+			dev->node_props.capability &= ~HSA_CAP_SVMAPI_SUPPORTED;
+	}
+	up_write(&topology_lock);
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index ab7a3bf1bdef..129b447fcf84 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -202,4 +202,10 @@ struct kfd_topology_device *kfd_create_topology_device(
 		struct list_head *device_list);
 void kfd_release_topology_device_list(struct list_head *device_list);
 
+#if IS_ENABLED(CONFIG_HSA_AMD)
+void kfd_update_svm_support_properties(struct amdgpu_device *adev);
+#else
+static inline void kfd_update_svm_support_properties(struct amdgpu_device *adev) {}
+#endif
+
 #endif /* __KFD_TOPOLOGY_H__ */
-- 
2.48.1

