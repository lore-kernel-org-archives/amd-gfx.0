Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC18CCD37A7
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 23:25:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62F2710E62B;
	Tue,  3 Sep 2024 23:25:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4Wj/gG5a";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74DCA10E629
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 23:25:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGjOejfrmY1dL1q0QAMV/4b/LoZ7OqdarUpUrMER7+ZBMn93y0PDj8++jaKP5Ynw8d8VyPqLskCDwG/xXELif2g9iaCQKMNziHGM9+R6W/sjcZjpvTMZ9T1pHEZEmzumAEEJlWFYEAu2WndJ84EqEFjswov2FWTlFlkDUfel/wxQx53IVgGdz8R6jMhwJJpWrue03x8eWei+Eg3QkyadLDJmQIpZXJHhJl+FSuLZtGee98Red0+mmNQSsq8cRbqnLHACgwk0/hzPfUnQTy0FWe+AmQIeOkPDxvCzCJmyyt9AtsyJwcLREYuBLx7Cf7vqXq6vr94pul4AYgDuARbyXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkbRoh4MuOkNE7cxm2A1P0+pz5Nr4zKC+cS9Id2M9zk=;
 b=SBomaZ7th9q4jho2oJaffakgHRArO+loRe2ZiTZqwE8hf6wERsUzBntMcr+X1QeEv4TiKzvABKYnY+sbUKdQT8Vmfw1lTF2kKzt6uv5Ilw+rKItQonViCI7kKVcJDBYE1Q6fuU14jfJEQG0d99DNudFo8f8n6ICZcOn9mEGMidOLCbVPSNFFxQK7t109ZKa1Q6NKBDwQah2uARx+ED3KesixXkVrk/XPoQ00DAKHyfxXJtNBYYyWc1EX6cCk/vN1yU2oJAZVNCtC1Jnlq+RTR6J6bV1KVKNfBpqMTlUu+UD69jDk3rH3UeLTGasIB9wSptuhr4jvmPHXOdlgLxDC7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkbRoh4MuOkNE7cxm2A1P0+pz5Nr4zKC+cS9Id2M9zk=;
 b=4Wj/gG5aZYWKScZP48DIK0T0cqDNKjmFPHVM+JCx2cXZq8uZEkHQgu4TaoUI54ZO6ANwui5+Sx/d7SnZGibQaBqH8JiP+q24iiwuVokvbrzg6qF3M0s6121YN8cMou5JF8YQ/vi9SWDTc81kVEHO7WuBvOoqHxPEQw1aSI6trJw=
Received: from SA1PR03CA0021.namprd03.prod.outlook.com (2603:10b6:806:2d3::24)
 by DS0PR12MB9058.namprd12.prod.outlook.com (2603:10b6:8:c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 23:25:06 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:2d3:cafe::6f) by SA1PR03CA0021.outlook.office365.com
 (2603:10b6:806:2d3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Tue, 3 Sep 2024 23:25:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 3 Sep 2024 23:25:05 +0000
Received: from KfdLnx23.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Sep
 2024 18:24:55 -0500
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Subject: [PATCH V5] drm/amdgpu: Surface svm_default_granularity,
 a RW module parameter
Date: Tue, 3 Sep 2024 18:24:47 -0500
Message-ID: <20240903232447.389164-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|DS0PR12MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: e4aa150b-dd65-45be-baa6-08dccc6fa4cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tkdGO9DbMETrZ/p14VjrSwbKX/ue7qLbG+Ip4pvNpYL8BSbkNVzXlqsnXQX0?=
 =?us-ascii?Q?GtdF+99+M9uxemZDlWivhLbzHMk5nePB0rfEcrZWZ6sWekSteY9Hv+dUE6zw?=
 =?us-ascii?Q?nc1iMp2BWU2E8D8vw5QH/N4+jj0I2A9Gs2DuGH1O83a9SvJ6xWvw3eYgnF/h?=
 =?us-ascii?Q?e4tlr/VqNziDf8LqhsCI1+b2VcjCRvbGmNA4AHAijuRvjEaudYJ8qBazLKs5?=
 =?us-ascii?Q?3TEd8L43oIdj+Rkhu29NV9QxArLIeGhKLfBBAJBoofJx71HlXJHPOYcuw+Vg?=
 =?us-ascii?Q?xuMODO9axuCY+Slqka+KUP12KhhU3St4ECdPrcHA9U+BmP6x4AgAndGfNl4d?=
 =?us-ascii?Q?SAq/xvn0cc0gcWoSkYctIvqZdSxN2HAGYPHcJvOBE3xKAFAI0kMwsnTHy7rG?=
 =?us-ascii?Q?uH8H0jbhATqQ5LXiz/SmPN2Y9rwoc8UfyKQa0DxDLEyfqC+X38ehFxOGCZfR?=
 =?us-ascii?Q?WEh5i6RDCwhG+GqaZo1VOiW7pz2p6eitsGnNmMG7iscPgwq3+5N4kaTPe0mS?=
 =?us-ascii?Q?VqU4sVoDxF1HkrtnFssssdjQE6mqB9HiWCpfDHYyZNvNFNwfYTTqfGELUwUR?=
 =?us-ascii?Q?ygtLWKImARelgNE4FSjmDTzW5NpnplYhF55tJhP+Ya6CZNb5VG6YZsuDd1eC?=
 =?us-ascii?Q?0koairI9TUKC9Ca7aCFI3VfsQx85j840oosuJX1otgc1sO9NDM/3E0EuXIFt?=
 =?us-ascii?Q?35OBcntSyxYI4dZ0zCX+PFAO7f2QY0P9aKpIlOYwbpvzH2Cn0aXwhcnQ7aSo?=
 =?us-ascii?Q?CAnwEfKpaMfJ/jeXyuSSgeHyu5MRMsTSWYrSEudA130Xxj8rTpWkTz4xqzkj?=
 =?us-ascii?Q?hDbCDBuaEmsUqdYetCEjHoUy/uMwhAOiaE5Ipc22YJcJNlABqIRlj9Vz5nWR?=
 =?us-ascii?Q?VQeh6LdHhodFf0jadhQBmHYjWFVp4fMXUhwATlqA+zVnE9q3L/Gh301pv3bO?=
 =?us-ascii?Q?I9x2pWKTzpNuZQ+SVtdBiQCdxExvYX2G0hJy6o7tx50cnyZPkp9MYPujLrD2?=
 =?us-ascii?Q?Rpr7UxpBtj728NyVCddB74CN6hHgpQ+KtG2HH5BHKWPUaThdq6aRDEBR/c4G?=
 =?us-ascii?Q?NRgUixtv5vYN4AslWCnI9+h4+YktNfx7+dQO6WAwLKsC+wbX2gKBAta3U1pe?=
 =?us-ascii?Q?ggum9UsGQxlAqORtJzAo4YAg6cpGTBr5STVAOrFsVo0npxaTMB/IskoyuZ8z?=
 =?us-ascii?Q?DyMfq0vrO914suws+A+M2ZkJ4OawGwNjh39yT0LhwjBBowb1i+u4qshoNFIj?=
 =?us-ascii?Q?0eCQe/+5YusiwtP7f9fWof8nSAK1IjF1t+ZJcIC33Mzszzq6uKx4DwHCoupn?=
 =?us-ascii?Q?INT648zNDmZhVIwjqq9VMGQyiWtCRQ95wtcr3tEhupracm0tV4mPtV6uN4e8?=
 =?us-ascii?Q?CJ95MDJgpqYzJDncbju5c94KJjB+mRz//aJdUrhP5AEuiKVHWc4xOruxmJ5h?=
 =?us-ascii?Q?bF22rQIc830q3hYQgNCPYmaLos+Z7V2R?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 23:25:05.7081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4aa150b-dd65-45be-baa6-08dccc6fa4cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9058
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
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 23 +++++++++++++++--------
 4 files changed, 39 insertions(+), 8 deletions(-)

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
index b44dec90969f..2bc2389cc7f0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -309,12 +309,13 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
 }
 
 static void
-svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,
-				 uint8_t *granularity, uint32_t *flags)
+svm_range_set_default_attributes(struct svm_range_list *svms, int32_t *location,
+				 int32_t *prefetch_loc, uint8_t *granularity,
+				 uint32_t *flags)
 {
 	*location = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
 	*prefetch_loc = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
-	*granularity = 9;
+	*granularity = svms->default_granularity;
 	*flags =
 		KFD_IOCTL_SVM_FLAG_HOST_ACCESS | KFD_IOCTL_SVM_FLAG_COHERENT;
 }
@@ -358,9 +359,10 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 		bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
 			    MAX_GPU_INSTANCE);
 
-	svm_range_set_default_attributes(&prange->preferred_loc,
+	svm_range_set_default_attributes(svms, &prange->preferred_loc,
 					 &prange->prefetch_loc,
-					 &prange->granularity, &prange->flags);
+					 &prange->granularity,
+					 &prange->flags);
 
 	pr_debug("svms 0x%p [0x%llx 0x%llx]\n", svms, start, last);
 
@@ -2694,9 +2696,10 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
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
@@ -3240,6 +3243,10 @@ int svm_range_list_init(struct kfd_process *p)
 		if (KFD_IS_SVM_API_SUPPORTED(p->pdds[i]->dev->adev))
 			bitmap_set(svms->bitmap_supported, i, 1);
 
+	/* Update default granularity to one bound by user/driver */
+	svms->default_granularity = min_t(u8, amdgpu_svm_default_granularity, 0x1B);
+	pr_debug("Default SVM Granularity to use: %d\n", svms->default_granularity);
+
 	return 0;
 }
 
@@ -3767,7 +3774,7 @@ svm_range_get_attr(struct kfd_process *p, struct mm_struct *mm,
 	node = interval_tree_iter_first(&svms->objects, start, last);
 	if (!node) {
 		pr_debug("range attrs not found return default values\n");
-		svm_range_set_default_attributes(&location, &prefetch_loc,
+		svm_range_set_default_attributes(svms, &location, &prefetch_loc,
 						 &granularity, &flags_and);
 		flags_or = flags_and;
 		if (p->xnack_enabled)
-- 
2.34.1

