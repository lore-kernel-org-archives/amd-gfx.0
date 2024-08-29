Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4362BCA0EC6
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Aug 2024 22:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F31E410E79C;
	Thu, 29 Aug 2024 22:13:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hx+BnPVj";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AB0010E79C
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Aug 2024 22:13:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ep0gnjd++DghmELhI8u3qRv/61mG+Wa1Tu0ogvGh8UP0AX9dhTvpWCiMy7fzmKdOfOJ4ppnliZFUAzsWor2COHcmMg6qATrR8CEos9uuz8wkWWjA77CN9nXn2iCg/10qLPuJRazkdm3c1fiP1dkrWaxfBA3mDSRO4wnKa47Nag5zi4su0mQkltxXZCX9jgYeQNA3fdR9gxV60zRFPhrC/lV1F5OLZR0MXhSlBhWxGEYOlq+/l5lRkBhleaLMtMngQ8Bo5EFnCFFGeOzx0R7Kl0Q/PZossLQwJUoGwlBgy9TmMZDH04SIRQ7O0zD5Bqg3tKHGAQaMVQiAxEd7aw+l0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiQcIBX4/vypPhEpVgCuDhYqd2Gbg/typtfxRA7EebA=;
 b=hcU8xefi9W8nOc8hEWrRTkUn0Dl/TFrbg8FkMiD9cbk0FBlGAsiGj6rwsQKgzf8CqVb0gnvczy2p25Tr3ygdk2juLqcPle3Gj+N5YG53LbOpbl5/tCV9oLdENLYIOX3vR3YBEuqXAT2C7H4cXciX1m9e5lrYifyM0c4/VhHoSGmLgk27L6OMggmlD5cpahB4yCsmuAsJ4X4uBRum1gTD34iMcT3FQY4B/dThegO5SlIhUbZes8JXqe9mUxGuTIuw96PoXbomzSztLsbvNVtvGhouoIoSFF2ZKwj3QqEyqvgkL/KIpUSu/YUBOxdK1chyo8zf0h6Ouda/rAddvv62mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiQcIBX4/vypPhEpVgCuDhYqd2Gbg/typtfxRA7EebA=;
 b=hx+BnPVj2Q9dJWw/EI9+1ZA1e7UDzl9G1QhKz51Fi4Iv+poFtaRC0OjGI0ig9JO2GwwwPRlkCW/epfkWOl+RAsil3jXZHlvO0Y31ll3I4PBTTgUe3BHjDVI44FPDxe4e6Co0RAkhNff++DDob2rLfraIQY7i1NqJCY48Tw0Gsss=
Received: from BYAPR11CA0095.namprd11.prod.outlook.com (2603:10b6:a03:f4::36)
 by DM4PR12MB7528.namprd12.prod.outlook.com (2603:10b6:8:110::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 22:13:45 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::66) by BYAPR11CA0095.outlook.office365.com
 (2603:10b6:a03:f4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27 via Frontend
 Transport; Thu, 29 Aug 2024 22:13:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 22:13:44 +0000
Received: from KfdLnx23.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 Aug
 2024 17:13:41 -0500
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Subject: [PATCH V3] drm/amdgpu: Surface svm_default_granularity,
 a RW module parameter
Date: Thu, 29 Aug 2024 17:13:34 -0500
Message-ID: <20240829221334.313701-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|DM4PR12MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: faf6be0a-d953-4648-d5be-08dcc877d8e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?54oJvwOKRsuw31kYv5iPpeOH+QcJGjDTyAH4pHaADVEgkhB1rFAM0KkWp0tH?=
 =?us-ascii?Q?MHjN8VKnxHwymjcKdwyCDswj0sI4yxBB1hZlOFXlWoTYXTMy4emaB7ra4MAt?=
 =?us-ascii?Q?x7NjfCPKcr5+ModfqYRKS7jqJtoq7nkccx9IvOBwv9BI/bBQ8CXYj68MWwb3?=
 =?us-ascii?Q?LdQtxcoqi3TCcdj7I7ysvgVY0ExJrRYSPXMmPV91P4tKqQDGZ0TW2uQ1k5Yz?=
 =?us-ascii?Q?VCwnISeEtfl9W5DqnXfcqBsQbrYbL5XJYtq+zSObBL+bqeqSGX6ykEJRHbpd?=
 =?us-ascii?Q?pBoP7GfRMZuAfZIkn1CKtD5W5Zkur9zCGlnPpC1MuNNz/mWEHB9gXqfyymJv?=
 =?us-ascii?Q?7rcdgOh8025jWVs/g5P0bqJRNFyP5SJIcdPASlozXr31bR0boq38rxTt+iNj?=
 =?us-ascii?Q?0FsmL1uF12gu5KH7LvG9fM66PYZaD+pBFxGkMPbulMvCjFyp4CXJqNgzBfE8?=
 =?us-ascii?Q?GHmv9nkK5nbF217GtSRmmvEPf74Eu9suhechl+v40eoYFfWdnjCKgxR5Nuew?=
 =?us-ascii?Q?upq3z9wiF5N1CMdPOK70DrQ8eELUG5s7+yltquR0vdbV03reCFEJ3oU+XNSH?=
 =?us-ascii?Q?jThpJ4GWz7T6muiE2cduxm23i6SOvU+bZTtgaZVYPctESN1J5rvFlyWa3iSe?=
 =?us-ascii?Q?bifZsvXk+gUbPXP7yuSc7bnXP59Zoi7bDDXGH5iHmN5acAVNm/rDTXuB8ZRh?=
 =?us-ascii?Q?ZprPpMsAmE5yZJmU7kbc9/mGeEN94nDXfPfTz1mfwNTaSEn2AJycZFJFpN27?=
 =?us-ascii?Q?ZhCojO6Fd9VFy7iBrJMZ+ahN5XydmjVIQQD9gKY2uw8P3i+qUWsZEDNYdmcq?=
 =?us-ascii?Q?PgCtAnarVJ164ZypOA0ObRrvJZzeIlM2FkFDEwZOlXldwhqiIPQI773mRJxC?=
 =?us-ascii?Q?4pSdv4bQF1UJvYEUTkVnoDWoNCkKtGKOioG2FTCTkGVcbX0e1HdKYkcBYvbI?=
 =?us-ascii?Q?HvqcrtSrBz5YwzdAwsDLkn6IHFo/RzPAUwde+CQnha1I//ECtqgyB0rGxwTm?=
 =?us-ascii?Q?NkkPRfah4u9ZzE5bgj1cXMvUSIdb5PKRgRTIu33oUQfnvvZuV7wFuje5HZ/R?=
 =?us-ascii?Q?xkjs2QcIg9Zuh11736/gOIMJeLOk4s2MJoLBMbddn94/afrT8DB235KlEkDP?=
 =?us-ascii?Q?l7rhtrfmeq9VAHFGh4VIUzIeQTGERDlTi8fF1WfKF5qtf5LLzKi8Gt+WoVRK?=
 =?us-ascii?Q?PuEI1k69Ek8bIdAF1iMAP32/OtMn2xuvmOyNa1BGuO16gsnModjYhyfKyJ1k?=
 =?us-ascii?Q?CrmdZSoZWtw3KxNuxBD215n040aBYouTp3K6mShkv9eOhmS25Uz0qjpVB5r8?=
 =?us-ascii?Q?KNQWagix6beJyswPKGb00I5KkRRF9OfoyyEYotU/7jvuhYtxhU2w6qzlMJk+?=
 =?us-ascii?Q?upMYTLPWsiZFAz5ZccqU6wSauRqVH4izYgCWPayWxPeQDjchC6ysBFbbST/K?=
 =?us-ascii?Q?n9/PjeTV1Iw2/+x7NtlOGOjia9tVUdrP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 22:13:44.3290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faf6be0a-d953-4648-d5be-08dcc877d8e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7528
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

Enables users to update SVM's default granularity, used in
buffer migration and handling of recoverable page faults.
Param value is set in terms of log(numPages(buffer)),
e.g. 9 for a 2 MIB buffer

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h   |  6 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 25 +++++++++++++++----------
 4 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e8c284aea1f2..8eb934af02f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -237,6 +237,7 @@ extern int sched_policy;
 extern bool debug_evictions;
 extern bool no_system_mem_limit;
 extern int halt_if_hws_hang;
+extern uint amdgpu_svm_default_granularity;
 #else
 static const int __maybe_unused sched_policy = KFD_SCHED_POLICY_HWS;
 static const bool __maybe_unused debug_evictions; /* = false */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b9529948f2b2..442039436cb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -169,6 +169,16 @@ uint amdgpu_sdma_phase_quantum = 32;
 char *amdgpu_disable_cu;
 char *amdgpu_virtual_display;
 bool enforce_isolation;
+
+/* Specifies the default granularity for SVM, used in buffer
+ * migration and restoration of backing memory when handling
+ * recoverable page faults.
+ *
+ * The value is given as log(numPages(buffer)); for a 2 MiB
+ * buffer it computes to be 9
+ */
+uint amdgpu_svm_default_granularity = 9;
+
 /*
  * OverDrive(bit 14) disabled by default
  * GFX DCS(bit 19) disabled by default
@@ -320,6 +330,13 @@ module_param_named(pcie_gen2, amdgpu_pcie_gen2, int, 0444);
 MODULE_PARM_DESC(msi, "MSI support (1 = enable, 0 = disable, -1 = auto)");
 module_param_named(msi, amdgpu_msi, int, 0444);
 
+/**
+ * DOC: svm_default_granularity (uint)
+ * Used in buffer migration and handling of recoverable page faults
+ */
+MODULE_PARM_DESC(svm_default_granularity, "SVM's default granularity in log(2^Pages), default 9 = 2^9 = 2 MiB");
+module_param_named(svm_default_granularity, amdgpu_svm_default_granularity, uint, 0644);
+
 /**
  * DOC: lockup_timeout (string)
  * Set GPU scheduler timeout value in ms.
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 9ae9abc6eb43..d6530febabad 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -868,6 +868,12 @@ struct svm_range_list {
 	struct task_struct		*faulting_task;
 	/* check point ts decides if page fault recovery need be dropped */
 	uint64_t			checkpoint_ts[MAX_GPU_INSTANCE];
+
+	/* Default granularity to use in buffer migration
+	 * and restoration of backing memory while handling
+	 * recoverable page faults
+	 */
+	uint8_t default_granularity;
 };
 
 /* Process data */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b44dec90969f..624bfe317c9c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -309,12 +309,13 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
 }
 
 static void
-svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,
-				 uint8_t *granularity, uint32_t *flags)
+svm_range_set_default_attributes(struct svm_range_list *svms,
+			int32_t *location, uint8_t *granularity,
+			int32_t *prefetch_loc, uint32_t *flags)
 {
 	*location = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
 	*prefetch_loc = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
-	*granularity = 9;
+	*granularity = svms->default_granularity;
 	*flags =
 		KFD_IOCTL_SVM_FLAG_HOST_ACCESS | KFD_IOCTL_SVM_FLAG_COHERENT;
 }
@@ -358,9 +359,8 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 		bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
 			    MAX_GPU_INSTANCE);
 
-	svm_range_set_default_attributes(&prange->preferred_loc,
-					 &prange->prefetch_loc,
-					 &prange->granularity, &prange->flags);
+	svm_range_set_default_attributes(svms, &prange->preferred_loc,
+		&prange->granularity, &prange->prefetch_loc, &prange->flags);
 
 	pr_debug("svms 0x%p [0x%llx 0x%llx]\n", svms, start, last);
 
@@ -2694,9 +2694,10 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
 	*is_heap_stack = vma_is_initial_heap(vma) || vma_is_initial_stack(vma);
 
 	start_limit = max(vma->vm_start >> PAGE_SHIFT,
-		      (unsigned long)ALIGN_DOWN(addr, 2UL << 8));
+		      (unsigned long)ALIGN_DOWN(addr, 1UL << p->svms.default_granularity));
 	end_limit = min(vma->vm_end >> PAGE_SHIFT,
-		    (unsigned long)ALIGN(addr + 1, 2UL << 8));
+		    (unsigned long)ALIGN(addr + 1, 1UL << p->svms.default_granularity));
+
 	/* First range that starts after the fault address */
 	node = interval_tree_iter_first(&p->svms.objects, addr + 1, ULONG_MAX);
 	if (node) {
@@ -3240,6 +3241,10 @@ int svm_range_list_init(struct kfd_process *p)
 		if (KFD_IS_SVM_API_SUPPORTED(p->pdds[i]->dev->adev))
 			bitmap_set(svms->bitmap_supported, i, 1);
 
+	/* Update default granularity to one bound by user/driver */
+	svms->default_granularity = min_t(u8, amdgpu_svm_default_granularity, 0x1B);
+	pr_debug("Default SVM Granularity to use: %d\n", svms->default_granularity);
+
 	return 0;
 }
 
@@ -3767,8 +3772,8 @@ svm_range_get_attr(struct kfd_process *p, struct mm_struct *mm,
 	node = interval_tree_iter_first(&svms->objects, start, last);
 	if (!node) {
 		pr_debug("range attrs not found return default values\n");
-		svm_range_set_default_attributes(&location, &prefetch_loc,
-						 &granularity, &flags_and);
+		svm_range_set_default_attributes(svms, &location,
+				&granularity, &prefetch_loc, &flags_and);
 		flags_or = flags_and;
 		if (p->xnack_enabled)
 			bitmap_copy(bitmap_access, svms->bitmap_supported,
-- 
2.34.1

