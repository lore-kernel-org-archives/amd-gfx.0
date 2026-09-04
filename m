Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D031DC624D3
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2026 19:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CC6010FB01;
	Fri,  4 Sep 2026 19:54:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cUpRq9bh";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013021.outbound.protection.outlook.com
 [40.93.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E051210FB01
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2026 19:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCosvNMOGTJ/OgV4rxs+o964+zwPty0dElhcWIUtAtiwfbrnrTxHVSH7T5EAZuo24fXltCxo/WHSifyH6lro+sEnzdNzTgI+A/AxCXmcDG/qr0+33hdFX3Ru6V+VCEx64g6PxNT8aS0U52GFQhSUiV959x4vs0VlvIICx5CkPNqdrCeBLSChrgIWRo9typJ5kcPSZvGH0k3TKC3qsdD5plYkJT4bAouqRuLeiiOgnHT1M45NhxMKy5PSeQTKbjEWBCOi8c7tpdIdVsN27/ZHmzvBobwLW0/bcpYVZydvqZ76zaDgUPNwTAfjzwvdCquZhzfTGAYwLHW6hNWveBzFpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MZ0me+cSregzWmAR7Nd/Gwe8N+tbhjFa7D1XgMwxio=;
 b=wy3kcUmvyCBC8pAXCXKMewz6f36nuM0cuPEWzW8aJ27Eg2OvdzpJB0zhxbiNqsTi8G85TVRn3DBTXdEtarBOjV0AocM0cjFTFj2dMYN1jT+Xmz88gffEsHzdUNz4Qu/b90hXnpuCAm9dAEI5O6eTs/0AsQQTH2PbHkg0o/qJfFFDxZR3JW3bH3WS/VPDKs9miw5OEO/BpgaDWCEMTXps0Xc13zQ7BuCGSOxuH0kFFQzQQ2BapXiKTMYKqZFnW0rJBPUuxGjSPj6HGMAMLhuc9h1rS6ijYRdZ+po5vUL+A9HhoOc9cdT4L2IRkqTTb8fOFsYwSETrkfHVn4a1/BkV3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MZ0me+cSregzWmAR7Nd/Gwe8N+tbhjFa7D1XgMwxio=;
 b=cUpRq9bhqrviBkQKYKVGCJY952i9yefvDiKHH7AC4QOAAGsnvfEhMQAfwh6R15gYyRnq/wutjjNrpRcxufrKRtSkqxpMlmbipfI3FSjRM8cOG1v+c+Sp5pCzru3E2Z2yk6JYG2ULZgoea62YMjy/RN2OjsqyEmmgDBfMzGAhudw=
Received: from BN0PR04CA0006.namprd04.prod.outlook.com (2603:10b6:408:ee::11)
 by SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Fri, 4 Sep
 2026 19:54:29 +0000
Received: from LV8PEPF00000066.namprd03.prod.outlook.com
 (2603:10b6:408:ee:cafe::91) by BN0PR04CA0006.outlook.office365.com
 (2603:10b6:408:ee::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 19:54:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF00000066.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 19:54:28 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 14:54:25 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Fri, 4 Sep 2026 14:54:25 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH v2 2/4] drm/amdkfd: Change migration size in CPU/GPU page
 fault handler to THP size
Date: Fri, 4 Sep 2026 14:54:19 -0500
Message-ID: <20260904195421.42919-3-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260904195421.42919-1-xiaogang.chen@amd.com>
References: <20260904195421.42919-1-xiaogang.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000066:EE_|SJ0PR12MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: c695d40a-48aa-4014-5d3b-08df0abe545c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|11063799006|56012099006|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /nYpobJQAaRHR2sOmWp4j9pRYLTLE3pJx9Zr6+jf1nEjx06FML84EsebqU4jWh/lbOycYU/OkkPTkLcWMQ+TseeSc1bEDot5WsZfnJsDLyTO/7LgJgWIBlNKT764hFG4uIQJ6UZ2k7o5jeZKe1+oyaffZuHOi7Y7zPI4z4G3L9GMNum2Q9WvyXDGNwVGi9+d1xkkgVedF24TGkG00EPn929N9r8CNIXQKcoKo6aY4vUJCBbChbFHFwpDeX3X9HdNvd/SwRZruo+5gdFt5eRNG0ompIuIxKnosvBkBaBd28tUA0+KPsCfCkjheuVZWt1+pvWYk1TVY7j1GpZZvqZG5g15oigGxCpYUKtsU8czrZsLXpUAEHDl7lv8fB9Cl4pPXHAlVWnRqaxf4IkHSBxmBdX/E4CJ8OMY1o2pD2wLn9qX1vlXLzAZ41OARCKBmoaXPIC/sQHjASvch7IKMTsL1sk8v5/M0g2jxhB7Db+pA54347HN1gzQCWYG7yYRMeI6Wzxr/JA70LXPTCMwb/3REct4vwfmgMzJlrJ4UZk+Fzr/0EtkhNwT/yAB6QoO9iUc4xQ3cjR5EXLHdMy5ZZ9HmmA2cm77lqv2ZnZo+xy038DpddSlPDCexGUbMdLVn83pbssFQFdSO1KgASYyTtWje+GDTgEmGA7HAkwLHwSSB6+aHGYnwNJJuwhvZj+37wrxHJ05Emjy9yg6xOKnjm6/Og==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(11063799006)(56012099006)(6133799003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TYBdn1NjsVHREVz6Wl3nBE18h6x88T0HtqpuXjWEPjMXFP6QLJ0yucgHCUWULMfrCkve1vzCW5l2+W5zVcRn5M5qpngLkzIuGzNuuI7IQjGZmgrWItQsz1+9bIdDAJnDlyAF1vH5yFbRX1oabx3iw58znR5Vn2mHtWpJYJCVxuMymYAf+gkAqh0E/5V/6gHjeIGTZi5yPGLRBk7v6+I4FEgjki5XrZqMT6ibti28+8AhD0haIrdREKz3QuSIYSotOnsmBW/hkKI3Xb37OVmvTUkLNkCReiwkCoPT4s1xRP5UBAmkVbhPgHkGwpMF3AZ8VewB8FWX/e9ad4gwbFuVi56PBRIyqQSDo0EXLTVTyRDOZ6LCYLb4g6cSlwPLDE5VZreeDNx5V2rtEMBuASEfx5K6ZknlIe2dXowKsW9ZcFMjl8aaQ7HbG6269FX4IJ7R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 19:54:28.4884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c695d40a-48aa-4014-5d3b-08df0abe545c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000066.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167
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
index 813f3c1d29dc..bbf0fefd5722 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -1026,8 +1026,10 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
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
index 6b783d12bce4..482cd4e7eee5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3071,6 +3071,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	struct kfd_node *node;
 	int32_t best_loc;
 	int32_t gpuid, gpuidx = MAX_GPU_INSTANCE;
+	bool is_private_device = false;
 	bool write_locked = false;
 	struct vm_area_struct *vma;
 	bool migration = false;
@@ -3087,6 +3088,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		return 0;
 	}
 	svms = &p->svms;
+	is_private_device = svm_is_private_zone(adev);
 
 	pr_debug("restoring svms 0x%p fault address 0x%llx\n", svms, addr);
 
@@ -3224,8 +3226,15 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
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
index f2b3a05cd8cf..e78ee94ba33c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -215,6 +215,13 @@ void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
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
@@ -277,6 +284,11 @@ static inline void svm_range_set_max_pages(struct amdgpu_device *adev)
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

