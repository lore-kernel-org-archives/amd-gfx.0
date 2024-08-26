Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F37C5321D
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Aug 2024 19:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93D7C10E223;
	Mon, 26 Aug 2024 19:34:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2tNyBxru";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C94F10E223
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Aug 2024 19:34:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHf4BAkZ+FpmpjLmkci/9T9dI6EATkjlOdq9sezPMr9+/t3XI7SP4nr0PWXWLpEPCNjdSOzrBc+QrkznRZk5QLPQRe+QN3aTe0pOkfvJmBta9safRvEWi88L8DZn5jlrOzkm75HNeAb4Afpl69ZXK+caSnujKOR2+WtTQcy0D3+s3giP6mL7PdTjLk1GqWRohKTAdqFq1EpANjFNug7wf3mezYUecmqGgeX6oCaCTvWI6zlcEbkc/b8MAObLC7FWbbTSCcB10pkEFw5KxcMjrS2rwUeKqUcLm5I2wkzdm+7vxhWP3NtiV7O3A8OMeJwM4rL67JlWRmW36g/ah8oAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSXHoMtF0H+AD2755VnPdz7fO2KuGu5Xqv3LU+7t35Y=;
 b=WW+aUt45voXsytgx/Z0yFBR1agON9a/4uudWs3Emas2ZpqZx2OKV8ycdyXXdXxShLvVzfeQ/9yTHHUnpe5KI0XkFWOmvxCyNOA9cdeXbpLnDhVWKRQ2+AWV8uHaLO0W+vvxN0VPDrluFHWk4mrppqcgd0T3AMV4ev7NLaTlKm2dA1tnNfX+zEKNldI3cLhr4PvT9Dix3CazTlvWK3iRYn9X/5K2HpCpYMDkexsdF30v6S2dBRER1+RCxColVG0JpyX3iv43U7DxyFaEajcmgyotSBzJ610j5g52mR1+Zh29NxgroDG/dXgN1DlsISuMwPq/pJDtzpWlPsYhqZ4664g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSXHoMtF0H+AD2755VnPdz7fO2KuGu5Xqv3LU+7t35Y=;
 b=2tNyBxruxJGpj9+wPsiWH30wLvS1Wllh++r5vwzf3qi2vYsaGzk6eLtyIDZvlfwIZjHT+BVQ3MuYSiCPC/y2uMFPwYngsP9sMvOs7XWAulQxF1S0FZo2M8VlwvHqAf8J5Jp3wx6/KSTN8U7/ObBHFAioO1+U309TNGF+MGhT+pM=
Received: from BY5PR13CA0028.namprd13.prod.outlook.com (2603:10b6:a03:180::41)
 by MW4PR12MB7440.namprd12.prod.outlook.com (2603:10b6:303:223::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 19:34:30 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::8b) by BY5PR13CA0028.outlook.office365.com
 (2603:10b6:a03:180::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Mon, 26 Aug 2024 19:34:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 19:34:29 +0000
Received: from KfdLnx23.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 26 Aug
 2024 14:34:28 -0500
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Subject: [PATCH v2] drm/amdgpu: Surface svm_attr_gobm, a RW module parameter
Date: Mon, 26 Aug 2024 14:34:20 -0500
Message-ID: <20240826193420.126272-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|MW4PR12MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: e6118ced-f8a9-4a11-5f96-08dcc6061ac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DU4u0cewLivI4kLqHmw2meNdCJhwyDRNbHmDlQ1EEobGQV9BVWI8P5PxC88q?=
 =?us-ascii?Q?i/X5AmbGxxSW/YrwkluUwEGoazqifB5InLMhkBZbpKi9Frmp8ygWlYSCQUN0?=
 =?us-ascii?Q?nRseaP5UcCuN86u3LlsNDbepICfpMJmYhLxZWdT9mGcIXgEy/z0BdXvx1BXg?=
 =?us-ascii?Q?RLXLyXxyRAwgvRgRXfRVCDyTidRjeI7rqVeo+SHUJHp/7tqhngK+RI6KrxqN?=
 =?us-ascii?Q?l0f21nKZhwTjUnhNB2JVzmLi/Kc0zWcGcnRTIs314w8BopSLZMQoabDkQ1KM?=
 =?us-ascii?Q?lSLLmwCu/3gfHZeDG0Fg30ozadijKDaI5dV0mOTJ31czqJdg0JzmyzVXqrMw?=
 =?us-ascii?Q?oYoWDPgndQaF/+mJUFML2yW51LDIo8rLZN8J+MKZUR3dI6LMfDsDD1ePdzaw?=
 =?us-ascii?Q?9CIEf/HEnJcHu5Wce8lDXQxK87N8wbLmn17307VKRFQr24Jv1Vg9naQArvDj?=
 =?us-ascii?Q?B6VXjfpr5YK5EfMgtAOrb72W809jd4b7id0Hly85k60ElP1gyMkJ/PQPFa08?=
 =?us-ascii?Q?lBpTWgBRPwZ177GaTnI5pB5U4e/akC/ef4ZVLFhoHwNofAPWFib1Uu3aoIAG?=
 =?us-ascii?Q?P+AJSJd3lRcXGftDVUW1/rLxjbMr2Xt8+o4N00h+B/sEg5xbb6UKotp/1Ghv?=
 =?us-ascii?Q?haxlmwRqZxwT26Idz38JPRAXcScU8e9/l/wnQB4Dr+gH2HBJXHXJg/GzdtNg?=
 =?us-ascii?Q?fVWB1OdtEryRT4tM0cba5l02w41dU/CSzsWwypV6gNiGopIdnHFOujAzSic9?=
 =?us-ascii?Q?csDE2gxlW9AZgb8mnxd+ja2o4jD7Sqlqe8Uy6Zz5fEq4UukwaTl408XzMLuQ?=
 =?us-ascii?Q?Oi/UL1dBBTGqtFqPTtNkq/QXneUkT1Vx/fyCRvedYkJLslZ9QmNveMxVMQNU?=
 =?us-ascii?Q?l56ufa2Y9BAC76yGj9c+eKdxnn8Gupty+SwM68OChjkYCAAY+ja947h4MMag?=
 =?us-ascii?Q?SsnQU+9nLUiFFUZFgKCZk2G94yTJftuPUrCLzRS6CPSnC2Tq6tEcaPw4H448?=
 =?us-ascii?Q?ckDxLG+jpJzUVkpTPzDkApxAl8uji5cYae6AsY8M97v5qdWrbaKy7EGjmAXl?=
 =?us-ascii?Q?zZDOfpyvmTb9Rhb5nGzF7EbcPhuf0OsR9uyoCqSqO89VR8gdz2/cj9I0n8TO?=
 =?us-ascii?Q?CSWzl2lfkwFlmu5JY1HH2Ai9B8UY7w7WCa0ozL+ACpWD77A4SBpEKG8L5pVY?=
 =?us-ascii?Q?ix5qsAos864aTcXgpdXCHtJEeSoJSQR9lC8h0xuFgB7QD50CyEKQNgtmemix?=
 =?us-ascii?Q?2/YdL8KeAs/a4U4Hb3Cnx9BjItXuiTKAC7ga7kR+Djg+FI1Cyb/jsvSKz1iT?=
 =?us-ascii?Q?KuC0lR7OKUQ8VsFtQpnk+3SgTK6wkWma2zN9A8D+1s8IpsayuGA4NW8AgBWz?=
 =?us-ascii?Q?cQbhjCRq7evPlwvlgB+O7N+xDYDFnpZSuUPmpp8StJCt/VVJehNLzKVGRNjq?=
 =?us-ascii?Q?T+pdccdNksn8IIqOM+QluHQZt4XqGdz1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 19:34:29.9869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6118ced-f8a9-4a11-5f96-08dcc6061ac9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7440
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

Enables users to update the default size of buffer used
in migration either from Sysmem to VRAM or vice versa.
The param GOBM refers to granularity of buffer migration,
and is specified in terms of log(numPages(buffer)). It
facilitates users of unregistered memory to control GOBM,
albeit at a coarse level

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 18 +++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h   | 12 ++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 26 ++++++++++++++++---------
 4 files changed, 51 insertions(+), 9 deletions(-)

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
index b9529948f2b2..09c501753a3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -169,6 +169,17 @@ uint amdgpu_sdma_phase_quantum = 32;
 char *amdgpu_disable_cu;
 char *amdgpu_virtual_display;
 bool enforce_isolation;
+
+/* Specifies the default size of buffer to use in
+ * migrating buffer from Sysmem to VRAM and vice
+ * versa
+ *
+ * GOBM - Granularity of Buffer Migration
+ *
+ * Defined as log2(sizeof(buffer)/PAGE_SIZE)
+ */
+uint amdgpu_svm_attr_gobm = AMDGPU_SVM_ATTR_GOBM;
+
 /*
  * OverDrive(bit 14) disabled by default
  * GFX DCS(bit 19) disabled by default
@@ -320,6 +331,13 @@ module_param_named(pcie_gen2, amdgpu_pcie_gen2, int, 0444);
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
index 9ae9abc6eb43..c2e54b18c167 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -868,6 +868,18 @@ struct svm_range_list {
 	struct task_struct		*faulting_task;
 	/* check point ts decides if page fault recovery need be dropped */
 	uint64_t			checkpoint_ts[MAX_GPU_INSTANCE];
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
index b44dec90969f..78c78baddb1f 100644
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
 
@@ -2693,10 +2692,12 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
 
 	*is_heap_stack = vma_is_initial_heap(vma) || vma_is_initial_stack(vma);
 
+	/* Determine the starting and ending page of prange */
 	start_limit = max(vma->vm_start >> PAGE_SHIFT,
-		      (unsigned long)ALIGN_DOWN(addr, 2UL << 8));
+		      (unsigned long)ALIGN_DOWN(addr, 1 << p->svms.attr_gobm));
 	end_limit = min(vma->vm_end >> PAGE_SHIFT,
-		    (unsigned long)ALIGN(addr + 1, 2UL << 8));
+		    (unsigned long)ALIGN(addr + 1, 1 << p->svms.attr_gobm));
+
 	/* First range that starts after the fault address */
 	node = interval_tree_iter_first(&p->svms.objects, addr + 1, ULONG_MAX);
 	if (node) {
@@ -3240,6 +3241,12 @@ int svm_range_list_init(struct kfd_process *p)
 		if (KFD_IS_SVM_API_SUPPORTED(p->pdds[i]->dev->adev))
 			bitmap_set(svms->bitmap_supported, i, 1);
 
+	/* Bind granularity of buffer migration, either
+	 * the default size or one specified by the user
+	 */
+	svms->attr_gobm = min_t(u8, amdgpu_svm_attr_gobm, 0x3F);
+	pr_debug("Granularity Of Buffer Migration: %d\n", svms->attr_gobm);
+
 	return 0;
 }
 
@@ -3767,8 +3774,9 @@ svm_range_get_attr(struct kfd_process *p, struct mm_struct *mm,
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

