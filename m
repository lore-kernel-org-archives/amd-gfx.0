Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D4DC624A4
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 14:26:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1A2010E909;
	Mon, 31 Aug 2026 14:26:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PdO3Z22E";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013001.outbound.protection.outlook.com
 [40.93.196.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 580F710E90B
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 14:26:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aH6QX13sYfsoVKVHStMUflR5YtQDuVQWmH98QXP7L7R21j67beTNBtnH3+Y5xtlZ7LdKfrCbge2o3Tp4ydYCFLwyuLN4aBxGdPTUFHlr4D3dQCbn3bJQ8gotYY9JkuoDoEnWvA33ID1hLu4wGS9ezO9pgMy3ivZqTXTfBi37V+strr05FZ3QjT6Y+AwvEvSz50TRUE9Y/dsm3rCT4VrlOrpTR3RM/+3cd85wW3TwWFvyugx9wNb5MwXBMqFcW+Hc3Cmh+MBUjoViSPzxXEBBVB+v+mAkZILW/rSenr9YOZfO5GJo1+XdK7WPIFFz5fizrReMYflZMnCmyCinv6buQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spKZ9KUJN7sJKKKoH4XvCNREnhidYCEWmr3sAA5vnXA=;
 b=ozFTx+MigDDBMTT+NKsT0MHqHWPJQ3ukfO/Gs6rUcuOSZ+wlsdxmjr9CrjvrS8zL3mdKsLEqkTfBg07IcJCeMhwGS4bUIUxYc9vlR5p/p1i/Ulu6KlYbQjaBvW8eQFHD6EQpM7HHiBzf5QuY+Otj+Up9zAJ2EJ0wHQW4vQaqd+PXB90uY7QIrBIW4ZstW1DRHolbKBqzFMEKSnSLwoQobVC/DnexGJNvTfF3yOKCBD0pDgRxhY58Dp2sUTWs/8lZqA9EzonPHBMcc7NkAKQP7cN8GD9EQyj/l2exO4NR39u9bQ0mXbkZDGfB+rw+yOuDLEpQw3J3oDAPJ/R/WXTEpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spKZ9KUJN7sJKKKoH4XvCNREnhidYCEWmr3sAA5vnXA=;
 b=PdO3Z22EoWtKOaOI0+oWSvbqjrqetFXwXiIDg1hXwRJ6Ux7JS29N4/h7M9OssDfdPisLkEDUshgB/orfwPRlee960ukKUbzWi5IANKFXMdgam7woTcgVQVMWQIw6cEWs9Yh3FUW60kw5PWHO5HJpd0ANz0v1UU/DM6Weit4xMcg=
Received: from BY5PR03CA0008.namprd03.prod.outlook.com (2603:10b6:a03:1e0::18)
 by DS0PR12MB7827.namprd12.prod.outlook.com (2603:10b6:8:146::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 14:26:35 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::13) by BY5PR03CA0008.outlook.office365.com
 (2603:10b6:a03:1e0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 14:26:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 14:26:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 09:26:30 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 09:26:31 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Mon, 31 Aug 2026 09:26:30 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH 2/4] drm/amdkfd: Change migration size in CPU/GPU page fault
 handler to THP size
Date: Mon, 31 Aug 2026 09:24:16 -0500
Message-ID: <20260831142418.56423-3-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831142418.56423-1-xiaogang.chen@amd.com>
References: <20260831142418.56423-1-xiaogang.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|DS0PR12MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d6edf0-bf0a-4000-096e-08df076bda60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|6133799003|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 4jNRRRZHSaEAcWvawc7Sa+F6Y3MaIfoW2CCq77yp7KTiZm78eJyXnyd9/N0cuww+bCfvi9KJhLSdMU2E/IFhsZOCzYfVbb8eCKk8dJySkob9ySojkyuhY/1E9cLvGbhA78UsPDs5NANMrEF+3+wUnKIj6vmnDDjYbiX4M9BrzCZQ0hVBJm5gKR5dS23EJlp/ZauNuQXHCI4KEhix259Dxijm8PDBLOALLsq1qsbEcCSJ28t7GWBvQ7Nxl2bIpuhIVOQe11eC5gBv0xdkXNh8Z8JDyMdBdD3yaFHPXK2kPggMI9Oh3i0I2sfNVOkALl9a6Kbqq+FYFtDavEjSWS+BvwzsBerBI/3qyBV9rY1UaZG+FOurwu5KvkwYINmP4JDnLsZTofe+L6Vmj0wV+oxCOXTaavjwfCcYNKl+0wizjai9auezK03hRIgjJDmjXxplVo8C+FVoDLOngIhVJQexJEE9rsalF8+9VoPLS6cvhebRvN0Und88tDGuhHDw7U3Rc3CcfHoC2adkVkyvupaINZZpHE5qzHkJkzDAaOt2qQXWKZrMu3Ni3xq666NiJjn42wi+gUuTonT/OyWJF94DrDjxB77rNGSB/mz8ikukljT58cqr6Lo8KU2YM5OOYoRzx2ty9ZStYLWUE9Y69CxOZnT3XvHWwjRt8BQxujwxJeoYDAS8QlhGrnKiON6aEAXv3TrtsX6xg1Y8mLgrIG7utw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X26EUVXHtYOCKpjJU0J14EI7qZHYuRq5nQFepA4ZM1nlB2wk2jwz2/Lb3j0qRB5a4S/N+g56lq43x1+hDPeHvKMW+2Ql/Uo5itrJGEq2Hl8GlLhoeoXTFq/e/+Yq5cJI9XcYxvFuPWcq1s0u5WLez1EbkKIYYbe9/iR5MIVqlXDUXW6IdGWnCnu/75LLDFsIiHyp+YvZU6kQq4GKHvZupCcZKCYoCJ9TSYSnF3p/e6XXIRaik7wNAtIjLPX9QV1m0R17BVWTZnf/S/vIRJBdJ9D/zpU6vT2iNgrZqKpmVe6EGhPAl77/vrgDqD/V+2cZE8EG72GB6km1Lnc963gyC50pAjW1bnHf8MYbLs44Kyy2AN2ps35Tnwc/1Di9t1lQrtTyB8LLcFHH22hsa6rCu3XTVFis3c9pwyPk74RVPIbNv2UUo/Kd6IejWz70T17d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 14:26:31.5242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d6edf0-bf0a-4000-096e-08df076bda60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7827
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

When use HPAGE_PMD_SIZE based device private pages during migration core HMM
treats device private memory in HPAGE_PMD_SIZE compound folio if possible.
Current kfd driver uses prange->granularity that can be changed by user. Need
have migration size in CPU and GPU page fault handler in HPAGE_PMD_SIZE based.

For AMD GPU that exposes private device memory choose HPAGE_PMD_SIZE as
minimums migration size in CPU and GPU page fault handler. For x86 it is
same as default prange->granularity.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  6 ++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 13 +++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     | 12 ++++++++++++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 49a231e60dfa..f1399dd90d2f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -1020,8 +1020,10 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 	if (!prange->actual_loc)
 		goto out_unlock_prange;
 
-	/* Align migration range start and size to granularity size */
-	size = 1UL << prange->granularity;
+	/* Align migration range start and size to max of
+	 * THP with HPAGE_PMD_ORDER and granularity size
+	 */
+	size = 1UL << max(prange->granularity, HPAGE_PMD_ORDER);
 	start = max(ALIGN_DOWN(addr, size), prange->start);
 	last = min(ALIGN(addr + 1, size) - 1, prange->last);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 280c38932217..c66f83abedd0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3062,6 +3062,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	struct kfd_node *node;
 	int32_t best_loc;
 	int32_t gpuid, gpuidx = MAX_GPU_INSTANCE;
+	bool is_private_device = false;
 	bool write_locked = false;
 	struct vm_area_struct *vma;
 	bool migration = false;
@@ -3078,6 +3079,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		return 0;
 	}
 	svms = &p->svms;
+	is_private_device = svm_is_private_zone(adev);
 
 	pr_debug("restoring svms 0x%p fault address 0x%llx\n", svms, addr);
 
@@ -3215,8 +3217,15 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	kfd_smi_event_page_fault_start(node, p->lead_thread, addr,
 				       write_fault, timestamp);
 
-	/* Align migration range start and size to granularity size */
-	size = 1UL << prange->granularity;
+	if (is_private_device)
+		/* Align migration range start and size to max of
+		 * THP and granularity size
+		 */
+		size = 1UL << max(prange->granularity, HPAGE_PMD_ORDER);
+	else
+		/* Align migration range start and size to granularity size */
+		size = 1UL << prange->granularity;
+
 	start = max_t(unsigned long, ALIGN_DOWN(addr, size), prange->start);
 	last = min_t(unsigned long, ALIGN(addr + 1, size) - 1, prange->last);
 	if (prange->actual_loc != 0 || best_loc != 0) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index c7d7adae4476..0c9bb9cfd0b5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -214,6 +214,13 @@ void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
 void svm_range_set_max_pages(struct amdgpu_device *adev);
 int svm_range_switch_xnack_reserve_mem(struct kfd_process *p, bool xnack_enabled);
 
+/* check adev has device private zone memory */
+static inline bool svm_is_private_zone(struct amdgpu_device *adev)
+{
+	struct amdgpu_kfd_dev *kfddev = &adev->kfd;
+	return (kfddev->pgmap.type == MEMORY_DEVICE_PRIVATE);
+}
+
 #else
 
 struct kfd_process;
@@ -276,6 +283,11 @@ static inline void svm_range_set_max_pages(struct amdgpu_device *adev)
 {
 }
 
+static inline bool svm_is_private_zone(struct amdgpu_device *adev)
+{
+	return false;
+}
+
 #define KFD_IS_SVM_API_SUPPORTED(dev) false
 
 #endif /* IS_ENABLED(CONFIG_HSA_AMD_SVM) */
-- 
2.34.1

