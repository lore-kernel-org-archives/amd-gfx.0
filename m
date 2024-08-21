Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F3FC52D7C
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 23:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A051B10E013;
	Wed, 21 Aug 2024 23:23:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R4imMa19";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 300BB10E013
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 23:23:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTUr7P8RbTctz6pFbm3uVa+TFGSfH3UgAVcydOIuREb8Sdc1bKFtUNVCb6HGpo6Og8p89xRyZB5AkZpmTDX0o7EuIKXTev7wBgmMJWYiz5nWUuU+xZHBBTHbgIy4BpT18tgI+nv2O4HIwF0mQKAuWRPInUP0BbhO9jOlz5fHt3kt53shNLL/MFQu69KOY6hK8eHOEkQgoQQ/uuGEiyRjVOVVWzjMK5V+zkqeFlpHl/KP5NJIQvfNT35oDXbpOfHhQVwvZEP8e4/PsFP/oF/wZR5kDj6FPVAJDeAmku7gyCfKu+z4Z3hYrtfwAobyLMjr2G+qzRRWs4BZo+Pz3qNeVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wq3PUYw6+qKMcMPCUzIm6ZHyXp9siQGPrsu2b8mG/Cw=;
 b=b/PLi0oxsaF8izBkAi37UhhxY1R/L0wz4OwH1eoCELtbFjg2hR+JVGxC8cOw8yX1m2QtmaEmFu3uiUktuddym8QtvxWxjW00zUJ7cXZWyuK4lh1H79hi8E2yr1iXqazV2y6tsq1QybnoDZmNNUmI4xW6TMyeZWkm3eR0RxXTZN/XlPwuPRAjOhHAR7qBc/HSLqzbj1mlByefsPNyxoLDBpMXUsWIKi9que4hPhaLopA9QBWJrWaUcLHHeLsbZRwlsdNvLzX1pGaPLAqKKOoRBnVAOBidMgGK5ea2umhYWGuw1vZwHAPtW9nvydXbxgI3IMpnmme9v91F+b76/VgGHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wq3PUYw6+qKMcMPCUzIm6ZHyXp9siQGPrsu2b8mG/Cw=;
 b=R4imMa1996TnmFjgV8zjPr8uPcxtGkXGSC4zHP/1UCGTORkCyUmajFfDuqB2ByAXm1Znzi/pZgu5uhfelTr1QcO0WaXkk9PCe7VZuCN+zGOm1T6TaDud9mpbzU/2MJkpYAacAD0Q2RDZmrUbzFdOsmBgo/3XV1rrIY7bi1I53zg=
Received: from DM6PR07CA0071.namprd07.prod.outlook.com (2603:10b6:5:74::48) by
 MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 23:23:02 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:74:cafe::e4) by DM6PR07CA0071.outlook.office365.com
 (2603:10b6:5:74::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 23:23:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 23:23:01 +0000
Received: from KfdLnx23.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 18:23:00 -0500
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Subject: [PATCH] drm/amdgpu: Surface svm_attr_gobm, a RW module parameter
Date: Wed, 21 Aug 2024 18:22:52 -0500
Message-ID: <20240821232252.230791-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|MN2PR12MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f4e2b2a-9659-43ea-4679-08dcc2383392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yLtOUlW0U7Cx90Q+BoZW3SEs/TgbPgFNDICjHz5F8wQLr1ZSzRWKfPnthmgD?=
 =?us-ascii?Q?Q2TccLnkpH8js8Iht0ROtt7YcZRwc8hFo0nvjrJGJpmJtJx+PLGIsd5wWOZG?=
 =?us-ascii?Q?QAO0JQU3a9rPk+ejI33cw31qcbvxXp9La11OzgW3gdVo+8JMLtzVdcj50LWN?=
 =?us-ascii?Q?BQfMzomEKDlxNegcXlC6dR+b1+z284FuT32Qwiy19SJqFXPuoomm4CDT/fRk?=
 =?us-ascii?Q?9gULcJ/ZcNIk78nmrfc01c8T68AsNSrH+fQKkGPA8sW6cm8W/xx8RNmqy+mW?=
 =?us-ascii?Q?38MxF3HyTzshaVI2CBI5CG59MNDgRyEVpvNYPwdSECiPO22rDrEOVAcC+V3E?=
 =?us-ascii?Q?9A9XfoT/UgdfrByvs5w6OghMPU0hc58iT5yrSdZ+xb2KlM0POP2X9nwaE7Ly?=
 =?us-ascii?Q?jwfo0+2lv9cQOb5rW9ZEcI7N1SIW416HRJk/ul/fgl+FOaW4RZVTBxQOU6nT?=
 =?us-ascii?Q?ItSW2N7dJcPOaALTGpTt2BrBn3Itt5MttAMU4JCLcodOIxfWVdSfcpw8u7jB?=
 =?us-ascii?Q?46ogkJrHTzqrFf5LqR/WaPbwspBQcFxw9R0KnW5RPAQhPodBz91f72mz4vmZ?=
 =?us-ascii?Q?8eIrzNI9gtT/kS6xG7Riv7ZMdtRbldmLzjX2MTbDtumql46wtCie+g911sAX?=
 =?us-ascii?Q?DAiJW/rzq2CCTDziZ9oSyCSg4CNr+yQtRLJQuSJFqJAmtlKzPKgTXnLBSWBT?=
 =?us-ascii?Q?P7UHYIIaNIPvsXvGsyuE/IT9PioKUAaI/QXMnkRM/y9OkpU2Wvevd5cZngU4?=
 =?us-ascii?Q?GZpCs6KbmquRu4wBWSprmeT4PCPFExvvpf5qtU3pviNOjqRbY21CQJB8fbm4?=
 =?us-ascii?Q?OlR3fFebtrvFYgnAB8qaf12tv8+3fnanutmuAVncFX5P0Clzyt2TI51s0oiR?=
 =?us-ascii?Q?Lf5LB7EogEWWyFBtdUHdXs/Mnm7YJ/uV11sAoEsZr5BgrauzHJ9600BHdGuA?=
 =?us-ascii?Q?7rijxu09G3EVoC0R1gGZmdXlQykLV0wxf4pvSBaoPRF9QkA+0JeGvMDHEqbr?=
 =?us-ascii?Q?xA9cUQlIT84rBD1AN+uQpNENugT0mG5SKEak5Rw6Dd0skM8islkpGuzfyPtA?=
 =?us-ascii?Q?1k85CnbBsGLgc3hikFVenXej8dQwLd80eRwaPjTIa8GdtjgNjLblXughcMwA?=
 =?us-ascii?Q?VTe6jO0N820FfjkOws69Sozu9Ixz/vArlymC2+ZuqBtwjnuEYMTUt5fsW9bO?=
 =?us-ascii?Q?FJ8AhL1C3wZ0V0Fd9BoWjIyQ+SFl8pXzNudoSEKYOk/6lT+IwXHiNrQYTrWs?=
 =?us-ascii?Q?IpwT9eWB960af+yoGi47ESIJS2WxD61B3WgfH1uwAmprxYTFDpPEHkCadYW6?=
 =?us-ascii?Q?TiHXhw7oeIuxcjRsHBVzZT6PyhofTBeZYsLE/Sc19Ha3l3ojXg/pAdss5Tgd?=
 =?us-ascii?Q?arJHU6hd9BppDXpCrDn6rw/8TUdM/bN6yA10PqQs4ajHbi2/ZB1qIKKqltDc?=
 =?us-ascii?Q?rRr1D20nDztZy7QZOGWHSkWDmVYZcVvz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 23:23:01.7699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4e2b2a-9659-43ea-4679-08dcc2383392
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239
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

KFD's design of unified memory (UM) does not allow users to
configure the size of buffer used in migrating buffer either
from Sysmem to VRAM or vice versa. This patch remedies this
gap, albeit at a coarse level, for workloads that deal with
unregistered memory

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 16 ++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h   | 12 ++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 29 +++++++++++++++++--------
 4 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e8c284aea1f2..73dd816b01f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -237,6 +237,7 @@ extern int sched_policy;
 extern bool debug_evictions;
 extern bool no_system_mem_limit;
 extern int halt_if_hws_hang;
+extern uint amdgpu_svm_attr_gobm;
 #else
 static const int __maybe_unused sched_policy = KFD_SCHED_POLICY_HWS;
 static const bool __maybe_unused debug_evictions; /* = false */
@@ -313,6 +314,9 @@ extern int amdgpu_wbrf;
 /* Extra time delay(in ms) to eliminate the influence of temperature momentary fluctuation */
 #define AMDGPU_SWCTF_EXTRA_DELAY		50
 
+/* Default size of buffer to use in migrating buffer */
+#define AMDGPU_SVM_ATTR_GOBM	    9
+
 struct amdgpu_xcp_mgr;
 struct amdgpu_device;
 struct amdgpu_irq_src;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b9529948f2b2..e195e1cf0f28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -169,6 +169,15 @@ uint amdgpu_sdma_phase_quantum = 32;
 char *amdgpu_disable_cu;
 char *amdgpu_virtual_display;
 bool enforce_isolation;
+
+/* Specifies the default size of buffer to use in
+ * migrating buffer from Sysmem to VRAM and vice
+ * versa
+ *
+ * Defined as log2(sizeof(buffer)/PAGE_SIZE)
+ */
+uint amdgpu_svm_attr_gobm = AMDGPU_SVM_ATTR_GOBM;
+
 /*
  * OverDrive(bit 14) disabled by default
  * GFX DCS(bit 19) disabled by default
@@ -320,6 +329,13 @@ module_param_named(pcie_gen2, amdgpu_pcie_gen2, int, 0444);
 MODULE_PARM_DESC(msi, "MSI support (1 = enable, 0 = disable, -1 = auto)");
 module_param_named(msi, amdgpu_msi, int, 0444);
 
+/**
+ * DOC: svm_attr_gobm (uint)
+ * Size of buffer to use in migrating buffer from Sysmem to VRAM and vice versa
+ */
+MODULE_PARM_DESC(svm_attr_gobm, "Defined as log2(sizeof(buffer)/PAGE_SIZE), e.g. 9 for 2 MiB");
+module_param_named(svm_attr_gobm, amdgpu_svm_attr_gobm, uint, 0644);
+
 /**
  * DOC: lockup_timeout (string)
  * Set GPU scheduler timeout value in ms.
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 7bba6bed2f48..07b202ab008a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -866,6 +866,18 @@ struct svm_range_list {
 	struct delayed_work		restore_work;
 	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
 	struct task_struct		*faulting_task;
+
+	/* Indicates the default size to use in migrating
+	 * buffers of a process from Sysmem to VRAM and vice
+	 * versa. The max legal value cannot be greater than
+	 * 0x3F
+	 *
+	 * @note: A side effect of this symbol being part of
+	 * struct svm_range_list is that it forces all buffers
+	 * of the process of unregistered kind to use the same
+	 * size in buffer migration
+	 */
+	uint8_t attr_gobm;
 };
 
 /* Process data */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 10b1a1f64198..fcfe5543a3c0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -309,12 +309,11 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
 }
 
 static void
-svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,
-				 uint8_t *granularity, uint32_t *flags)
+svm_range_set_default_attributes(int32_t *location,
+			int32_t *prefetch_loc, uint32_t *flags)
 {
 	*location = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
 	*prefetch_loc = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
-	*granularity = 9;
 	*flags =
 		KFD_IOCTL_SVM_FLAG_HOST_ACCESS | KFD_IOCTL_SVM_FLAG_COHERENT;
 }
@@ -358,9 +357,9 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 		bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
 			    MAX_GPU_INSTANCE);
 
+	prange->granularity = svms->attr_gobm;
 	svm_range_set_default_attributes(&prange->preferred_loc,
-					 &prange->prefetch_loc,
-					 &prange->granularity, &prange->flags);
+				&prange->prefetch_loc, &prange->flags);
 
 	pr_debug("svms 0x%p [0x%llx 0x%llx]\n", svms, start, last);
 
@@ -2685,10 +2684,12 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
 
 	*is_heap_stack = vma_is_initial_heap(vma) || vma_is_initial_stack(vma);
 
+	/* Determine the starting and ending page of prange */
 	start_limit = max(vma->vm_start >> PAGE_SHIFT,
-		      (unsigned long)ALIGN_DOWN(addr, 2UL << 8));
+		      (unsigned long)ALIGN_DOWN(addr, (1 << p->svms.attr_gobm)));
 	end_limit = min(vma->vm_end >> PAGE_SHIFT,
-		    (unsigned long)ALIGN(addr + 1, 2UL << 8));
+		    (unsigned long)ALIGN(addr + 1, (1 << p->svms.attr_gobm)));
+
 	/* First range that starts after the fault address */
 	node = interval_tree_iter_first(&p->svms.objects, addr + 1, ULONG_MAX);
 	if (node) {
@@ -3211,6 +3212,15 @@ int svm_range_list_init(struct kfd_process *p)
 		if (KFD_IS_SVM_API_SUPPORTED(p->pdds[i]->dev->adev))
 			bitmap_set(svms->bitmap_supported, i, 1);
 
+	/* Bind granularity of buffer migration, either
+	 * the default size or one specified by the user
+	 */
+	svms->attr_gobm = amdgpu_svm_attr_gobm;
+	if (unlikely(amdgpu_svm_attr_gobm != AMDGPU_SVM_ATTR_GOBM))
+		svms->attr_gobm = min_t(uint32_t, amdgpu_svm_attr_gobm, 0x3F);
+	pr_debug("%s() Granularity Of Buffer Migration: %d\n",
+			__func__, svms->attr_gobm);
+
 	return 0;
 }
 
@@ -3738,8 +3748,9 @@ svm_range_get_attr(struct kfd_process *p, struct mm_struct *mm,
 	node = interval_tree_iter_first(&svms->objects, start, last);
 	if (!node) {
 		pr_debug("range attrs not found return default values\n");
-		svm_range_set_default_attributes(&location, &prefetch_loc,
-						 &granularity, &flags_and);
+		granularity = svms->attr_gobm;
+		svm_range_set_default_attributes(&location,
+					&prefetch_loc, &flags_and);
 		flags_or = flags_and;
 		if (p->xnack_enabled)
 			bitmap_copy(bitmap_access, svms->bitmap_supported,
-- 
2.34.1

