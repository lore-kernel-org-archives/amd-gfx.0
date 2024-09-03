Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691BDCD343F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 21:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F38AB10E319;
	Tue,  3 Sep 2024 21:46:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BLwFBwsV";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D39310E319
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 21:46:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbXiKRdrY1PDuhhObuqDGLyKyK5OVIjKcJcseI0spJOYFwrB3nzWADqKf1L9hozEieTyM86x9NbvVm1ZlXdIKWaXWvTsx/LL4TKuxzfMHeV9nT4uwCZPUZkS3mw1Ve+G0hPZGX1oib3K89mUJwKfPGZ/hmmQXzquEFjyxjm5jTgoSPslY+KpTNQk+Xds9oZPoDm9imcGOU3DMTt1+ars+NYHP880r6yGk1QG5PfGC42Jt7xx1EYvoo81pqf4vYxZIkgh1UYrUdcp+Pc4oyK5qD6u44TXfjcM0St9ue1GcZW1ZUevksfplGrN24bu8NTGzDXdvC4m1rVOuP+2OY6vZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ol4Pt8MMrweq05loAdbFyp/A/U+sTyQMRqlWAiCO2w=;
 b=xyGLbcghrMWB49gnGezYuxojbhGzQwZYGiXAMTwImdak5HzAdF0SFl6H2SEKacDmJ+LhJ0e9oQdSWTA7zLOHqWVEIAoLbBVsJUKAanbPLowUkx+MGPlo4zjGvE0YZ8UFbJRQ0uvwVdJZ7N62bCXxZZ27Bvpo6ItgiXTU2RWG94P2NwnMbhqqnwRMWkvbeCbB+hFLvv5Z/jodofnJj11n5y8yoetKxCPyXVxWFOrw7kMRCXkZZA9PqaV8DMHCsJ5ooWzwgQCPb8LxX+Ebwvp8CJ3n1b6TQgiW+2vSQOtH7OANhFUU4jAObf26Z9oP78HAoOeZ97RNg4A/8qgeLd3w5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ol4Pt8MMrweq05loAdbFyp/A/U+sTyQMRqlWAiCO2w=;
 b=BLwFBwsVbhpAnR+1VoMr0vcHd7ki6sbyqTguhlebnoh/tGHlgeg6E//DXrJMKmIhAsh1+DKKAQp2V0LzoFtutLSE/JL0q3pGUgevx/8A2QdVlKv1611vffTA0VqW5ICasFgK7lao001qHXYjrrogltaFcA4ANCp7qQHhb6NbUDg=
Received: from BN9PR03CA0885.namprd03.prod.outlook.com (2603:10b6:408:13c::20)
 by CYYPR12MB8853.namprd12.prod.outlook.com (2603:10b6:930:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 21:45:56 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:408:13c:cafe::c4) by BN9PR03CA0885.outlook.office365.com
 (2603:10b6:408:13c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Tue, 3 Sep 2024 21:45:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 3 Sep 2024 21:45:55 +0000
Received: from KfdLnx23.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Sep
 2024 16:45:54 -0500
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Subject: [PATCH V4] drm/amdgpu: Surface svm_default_granularity,
 a RW module parameter
Date: Tue, 3 Sep 2024 16:45:47 -0500
Message-ID: <20240903214547.327112-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|CYYPR12MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: c52cbc2e-5c76-4303-4ef3-08dccc61ca3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K88evif6nPCsTo2VwOJOdUId4Hs/pbU4X/J2qw+qFOL5R3NhkXD5PSe9qGUm?=
 =?us-ascii?Q?gFFhl/V3zQTcNf0mgm4FcO7MthxuUWEmi/+YaySKsl/RvnVLMMA4T702k3r/?=
 =?us-ascii?Q?pMzW4sGuXOHbiRzMHonpXHhzHhI2xgGh1I0VZDltLWltG5M2L6LrmfGUZWzj?=
 =?us-ascii?Q?+igUZdN74SFMrhTO4QykYO9SlWKMWJeW8T3/G4LqcatAMuT6SKv9RsJ/WFzI?=
 =?us-ascii?Q?dxbLV+D6C+Yyx3Aq7TFCze7EBinDO1l6WVR9t7hHB8rSTDuxrRPYz5xM9z5V?=
 =?us-ascii?Q?sOYo7kA4dLYqlw/ShoGcdaTM0YuSHTkVmF8yLrqzEGkpymQKVafrMWehB1NF?=
 =?us-ascii?Q?50OQNMqkXd8Qd45qXq/usVwdlfqomV/c7i4d0FPe+6w6sK/SzZotV14HZlY3?=
 =?us-ascii?Q?Qgifl+ZhFUCGVefky2fAXUhYXd1W4CVSaNgJ0g9ejooCwgAlaRrkQ2T+Kxex?=
 =?us-ascii?Q?E24yxhFyWAnmtTxhXRKcTiPbjgbZl5iBIerCCSO8KVx3ubuLbyFuHVsAXYv2?=
 =?us-ascii?Q?UN+YNypzJRbQSTb/6swtuh9+79dybiJcybKBFBxyxtWHeMNecrGSgn7paDK7?=
 =?us-ascii?Q?yx0+1efSymwBLcx7huqUC1F4/7Efhub3+vSeGe0Z74yJ2Yjp3bBVEfgQ5ye8?=
 =?us-ascii?Q?puRLA4F6lXeGpyxKrMooWkDLO9u50uf6ZcgCveRExtXNXsNodrJo/ZB0gZwm?=
 =?us-ascii?Q?9kwX2ux6sZSGw4I4CRf7+8FiVwEXbth0x3RY5yBFviB3Nc5z4Q8r+Y+/0IUz?=
 =?us-ascii?Q?w/+ZzR21NCJxnlsUWsx5TGF7Y81up0btpVKwqhniMYxFzEMrwWiOP8m0Qwgo?=
 =?us-ascii?Q?igfert/8yUC7edEOJLCQknux/UIyxPxx9HENfamaAs43h78nFEDwBQukaWXA?=
 =?us-ascii?Q?FsUBdO1d6uAf1mSw4MYJOzfBp0FSse95gGCfW6gCY9nw0l3tAjim1ijLyr6A?=
 =?us-ascii?Q?sgHH4+wJjtAO1zvf9fwauOLYnrc+p5CF6zLUZQainbLF56lGiqOJRX0uR2t7?=
 =?us-ascii?Q?qRLHyJAQP2RYPHWLRHLsqR7Y9mis+5WsKNqV1p2UWaofu6lHlvreN18i1Ucd?=
 =?us-ascii?Q?oPxqiPvKoCFng/Vq2Ek3S+1VsQ2DHZMlbp9+AZ3HnGyHHO5jkidPYowVIIUh?=
 =?us-ascii?Q?nkhUirjY6RyhQ4AL8CQfS0WMlVeBH8ugYD09rk4a1OwpEBKdwikJUyHWiYlt?=
 =?us-ascii?Q?uYYYrO4vilQCb6q38VMmsglNaGRJ6LwgJqEq7nWO/D0EXM5K7mGxAdSCzXN1?=
 =?us-ascii?Q?rFHtoYHwHz5pNrqA1+5wunCAhkdDBgg2PjOMX/f8Rr77HHp5NlfGcKbr78Nl?=
 =?us-ascii?Q?CXu6zz45h8SMMjX/pav312S7PFbdRLMETuMGDi2e/SWy410TKU4EzjluUV/h?=
 =?us-ascii?Q?GAAhwIMxFXb07DC6ma0Z8O+sdcHOjXT7uficpUWbPf90s8V8irYdYDee7VR8?=
 =?us-ascii?Q?en2x+EiHHJu8fwY1xEHFMzsrYkoX0jzO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 21:45:55.5870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c52cbc2e-5c76-4303-4ef3-08dccc61ca3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8853
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
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 25 ++++++++++++++++---------
 4 files changed, 40 insertions(+), 9 deletions(-)

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
index b44dec90969f..092cbb124319 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -309,12 +309,13 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
 }
 
 static void
-svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,
-				 uint8_t *granularity, uint32_t *flags)
+svm_range_set_default_attributes(struct svm_range_list *svms, int32_t *location,
+				 uint8_t *granularity, int32_t *prefetch_loc,
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
+					 &prange->granularity,
 					 &prange->prefetch_loc,
-					 &prange->granularity, &prange->flags);
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
 
@@ -3767,8 +3774,8 @@ svm_range_get_attr(struct kfd_process *p, struct mm_struct *mm,
 	node = interval_tree_iter_first(&svms->objects, start, last);
 	if (!node) {
 		pr_debug("range attrs not found return default values\n");
-		svm_range_set_default_attributes(&location, &prefetch_loc,
-						 &granularity, &flags_and);
+		svm_range_set_default_attributes(svms, &location, &granularity,
+						 &prefetch_loc, &flags_and);
 		flags_or = flags_and;
 		if (p->xnack_enabled)
 			bitmap_copy(bitmap_access, svms->bitmap_supported,
-- 
2.34.1

