Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925DAC5475B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Mar 2024 11:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F06310EC92;
	Fri,  1 Mar 2024 11:07:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dSq6aL8V";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91E5D10EC93
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Mar 2024 11:07:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KB6PujNNoK81NN10JirUhEI9+fqt2ch9jBph/BPf2CmkyfzRBKAIXrW5YuJ5/68Me0qqLtu5Bb16zjAkT3zUVlUIK44G+wFVMM6+uwdaO8oSjTDjLhIUcVgd6MQp+YFSrhEiaL9TNTfGMEHB+16tEDm2IT/cNtSvFA5sBFDVVtH9e1YXyd9jkE6ecbpK3fgtT0tNib8CweyGCNKU4Yyy9AEmHALXiYCjhSLue3FxSr+oGRrW6aNsXPVhGNehxhjzpKxVz7UuwJvwr6kf7RVk6esQXnTQJo8o5Dr9wKprlja2YeVqddAZjT8u34Vhbfv4UY/Qzr1vJeyftX6h5QL/hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dct8N3ZMm+iWWM4H03ipcEaZjbFNmqYYL7yyHsbc4YQ=;
 b=YWEnAX8voHKVWY/jLN2zwN0l74/FZY/bpk/lMX69hWne7YVyNd771tHktXJLvhsEfwkmpCyujFQ7p+UIIj5KtFGsUPo0DO/+RLjLlA0VgZdbQWF44fU2ojyFixBXXxKmojH2NR8gKlsPh2wnNWqC3vDWVa1VRL38XGCDp0/AcIlrbFhTPpOicJy2d8Ma0HBWkI2a5SW4SF57WZ60IatudhykIsVNpDEpE90iPMMJKYPTDlHccq5JYC197xxaBajlTPKmeLj2SACsgPwpvjCmQzsBjttALmeye34+y0d9pxf5q8x8wYbWSy8L/NnI8r8gapyp9OuSOlXQEwTbzPSfkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dct8N3ZMm+iWWM4H03ipcEaZjbFNmqYYL7yyHsbc4YQ=;
 b=dSq6aL8VTGZUAo2Aqo45QW8KqlxjEgq8e63imtAPIjxcPoMDYrl1MmKbXHTLMKngat4wZyDfBXMwy9sjTapVyIlEYd9IPVZ66VU7nHZrKIW9x3guv11n8bJu81c4qv/lK/Vs0ZmrJFRAJdjwWbCBoJBJq0hkrlL9FzJniV5l6c4=
Received: from BYAPR05CA0096.namprd05.prod.outlook.com (2603:10b6:a03:e0::37)
 by IA1PR12MB8468.namprd12.prod.outlook.com (2603:10b6:208:445::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Fri, 1 Mar
 2024 11:07:50 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::d) by BYAPR05CA0096.outlook.office365.com
 (2603:10b6:a03:e0::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.27 via Frontend
 Transport; Fri, 1 Mar 2024 11:07:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 1 Mar 2024 11:07:50 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 1 Mar
 2024 05:07:48 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <yangp@amd.com>, Shashank Sharma <shashank.sharma@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <Christian.Koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Subject: [PATCH v4 2/2] drm/amdgpu: sync page table freeing with tlb flush
Date: Fri, 1 Mar 2024 12:07:24 +0100
Message-ID: <20240301110724.947-2-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240301110724.947-1-shashank.sharma@amd.com>
References: <20240301110724.947-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|IA1PR12MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f4a81d-442b-456c-0b50-08dc39dfd581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XbXSov/e+9ay/BFLh5ludp1IFOpuEhEx9udSV0LFlz2k//J0KoiNkU4aAmPw+SQThVt1P3CcZH8sH/E9OVptjxKTiss3GjC5Snog0y03QjK6RSjQQJXYW5kjZSSm3aaRc7Wqi23d+iOhKwzQtSJ41sV4Fl5gQj4CMlMq4VG/SNhwuYl8GS8kUOvtF62686P947UAvI4fh237iia3/sxR+FUjeoOwld7AiIYn929iXMGdxeUx+B7Egj9+YRIFDz6M/ruF0OosaUC7E6O7kEdCojfV54Hrv7gQcvEuzhHMN/J7krB29FtwiNxhhoUmVHh3a35hyx8rK7iXNuXWTOwbZFaDRWksJcQEQoVCLcvkNufVji3JfMnrx+uY66xfm2PBIE+WEdaE8MnSPaNv99dDrEE1uZhXtLt4JXzxgrtEsTr+eE/b2G1TtHO2V7SocLAjoqIYvbwfxRzuTM7pa3fxhIfPy/87/GJM8JL7fjZE/dhyCG+JDf92PImFby3Zx3o+cb7C1kU9/u3V13ihMOsxAUtcgYLHucsvn9/7AO5JDBR6Gv7intUGDQA78XV+Gwq6UaY7CZ52/KoWYkgH3q3WXX/AvWcc3lCc7Ugt894Re36SsodDf4WRa4iVA8bVlMwguh8P+u/ubgYWOiXaxX0giyLBlUSZlL8jHG0J644M3fqALflBa8hM4Enw3WQwxGAYnQRAk9fHvgNLm3PZLnoJF7tWSxphuBhLlKM1fWVzG/pf+JCoMXek3/N6+hc86XZN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 11:07:50.0074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f4a81d-442b-456c-0b50-08dc39dfd581
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8468
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

The idea behind this patch is to delay the freeing of PT entry objects
until the TLB flush is done.

This patch:
- Adds a tlb_flush_waitlist which will keep the objects that need to be
  freed after tlb_flush
- Adds PT entries in this list in amdgpu_vm_pt_free_dfs, instead of freeing
  them immediately.
- Exports function amdgpu_vm_pt_free to be called dircetly.
- Adds a 'force' input bool to amdgpu_vm_pt_free_dfs to differentiate
  between immediate freeing of the BOs (like from
  amdgpu_vm_pt_free_root) vs delayed freeing.

V2: rebase
V4: (Christian)
    - add only locked PTEs entries in TLB flush waitlist.
    - do not create a separate function for list flush.
    - do not create a new lock for TLB flush.
    - there is no need to wait on tlb_flush_fence exclusively.

Cc: Christian König <Christian.Koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 21 ++++++++++++++-------
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 310aae6fb49b..94581a1fe34f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -990,11 +990,20 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	/* Prepare a TLB flush fence to be attached to PTs */
 	if (!unlocked && params.needs_flush && vm->is_compute_context) {
+		struct amdgpu_vm_bo_base *entry, *next;
+
 		amdgpu_vm_tlb_fence_create(adev, vm, fence);
 
 		/* Makes sure no PD/PT is freed before the flush */
 		dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
 				   DMA_RESV_USAGE_BOOKKEEP);
+
+		if (list_empty(&vm->tlb_flush_waitlist))
+			goto error_unlock;
+
+		/* Now actually free the waitlist */
+		list_for_each_entry_safe(entry, next, &vm->tlb_flush_waitlist, vm_status)
+			amdgpu_vm_pt_free(entry);
 	}
 
 error_unlock:
@@ -2214,6 +2223,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	INIT_LIST_HEAD(&vm->pt_freed);
 	INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
 	INIT_KFIFO(vm->faults);
+	INIT_LIST_HEAD(&vm->tlb_flush_waitlist);
 
 	r = amdgpu_seq64_alloc(adev, &vm->tlb_seq_va, &vm->tlb_seq_cpu_addr);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 298f604b8e5f..ba374c2c61bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -343,6 +343,9 @@ struct amdgpu_vm {
 	uint64_t		*tlb_seq_cpu_addr;
 	uint64_t		tlb_fence_context;
 
+	/* temporary storage of PT BOs until the TLB flush */
+	struct list_head	tlb_flush_waitlist;
+
 	atomic64_t		kfd_last_flushed_seq;
 
 	/* How many times we had to re-generate the page tables */
@@ -545,6 +548,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			  uint64_t start, uint64_t end,
 			  uint64_t dst, uint64_t flags);
 void amdgpu_vm_pt_free_work(struct work_struct *work);
+void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry);
 
 #if defined(CONFIG_DEBUG_FS)
 void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 95dc0afdaffb..cb14e5686c0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -636,7 +636,7 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
  *
  * @entry: PDE to free
  */
-static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
+void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 {
 	struct amdgpu_bo *shadow;
 
@@ -685,13 +685,15 @@ void amdgpu_vm_pt_free_work(struct work_struct *work)
  * @vm: amdgpu vm structure
  * @start: optional cursor where to start freeing PDs/PTs
  * @unlocked: vm resv unlock status
+ * @force: force free all PDs/PTs without waiting for TLB flush
  *
  * Free the page directory or page table level and all sub levels.
  */
 static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
 				  struct amdgpu_vm *vm,
 				  struct amdgpu_vm_pt_cursor *start,
-				  bool unlocked)
+				  bool unlocked,
+				  bool force)
 {
 	struct amdgpu_vm_pt_cursor cursor;
 	struct amdgpu_vm_bo_base *entry;
@@ -708,11 +710,15 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
 		return;
 	}
 
-	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
-		amdgpu_vm_pt_free(entry);
+	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry) {
+		if (!force)
+			list_move(&entry->vm_status, &vm->tlb_flush_waitlist);
+		else
+			amdgpu_vm_pt_free(entry);
+	}
 
 	if (start)
-		amdgpu_vm_pt_free(start->entry);
+		list_move(&start->entry->vm_status, &vm->tlb_flush_waitlist);
 }
 
 /**
@@ -724,7 +730,7 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
  */
 void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
-	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
+	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false, true);
 }
 
 /**
@@ -1059,7 +1065,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 					params->needs_flush = true;
 					amdgpu_vm_pt_free_dfs(adev, params->vm,
 							      &cursor,
-							      params->unlocked);
+							      params->unlocked,
+							      false);
 				}
 				amdgpu_vm_pt_next(adev, &cursor);
 			}
-- 
2.43.2

