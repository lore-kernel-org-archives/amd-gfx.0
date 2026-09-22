Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A612AC982FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 05:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E7F10EB61;
	Tue, 22 Sep 2026 05:20:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kbRQL3W5";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010067.outbound.protection.outlook.com
 [40.93.198.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF1CD10E73E
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 05:20:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bat5KM9jON1lQlkUd2pO4Ho/VNeB7fnm+KaVVOrG7GC3tNkMYNftTfeXstAWV2UcYE3Um7hh8c8qA6x9eG44l3CzAUcytGAm/U2fXabyDfKE20zTzBPdbZj1EeteQPzI7EpLZwXywgStENC4WOZgeK+3Uz+cdxvavHRfHxJJKkxaUCKtaDhtEFeYmsD/O/4CEjkafRwpr5AzT0PBbzdEwsGTugzb8XO0OlEYowJRUy0+WnzCT8nZdGQ7b9comKKI+fHJyed6cYM30j+QuCipZAk9PtjLUvINKJrkv0gjuKQWC0jqs2aG63Eh4YqBh9URY2L6/tWRYLEbVC8orYQJzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6x7vfNBQnJdMyExiE7JGf2MUhy3PFf98wogO+Uftgs=;
 b=lxH+jOLIVMfQfpGaR4xW8i1Nsj2CcnTvMSQhsKS0QO0xRyqxJSOf4yE5w77VmiQlAhzIIDXM7nAunuFLxkVvLUwgPfFDbGqchPVPtwkgbcZhytb8rHMiRL7Ob2ruFHYeca0+c69Tt5Tynx3WiNWrpa/033bKOYmQb660vBAz429+CWP78rOJjnv4vx25N84rniFKnxAJ7bHuz7lsNJ8goKNoDSsLaOW15P6jAA2jTzCdID7EiHDw7+tbI4MSgTzOK2XXMWaCvXxBFQ6pDZh3IMIcwQk5SxENRcvZ5S93q3Saek2wtDWnzAXz4OGC1MmVCd3mccKeM9MWlMw6WsOu5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6x7vfNBQnJdMyExiE7JGf2MUhy3PFf98wogO+Uftgs=;
 b=kbRQL3W5Qv272s2Q5PiZN9jueb3INOamtR6z5WyYcg2OGWmWqKCqiHzE8lKxjnjYoAsq8SgZli8F/avAyDLxByfqSZjdjDBOxN04KyIpJ78mzz+LzE/YX0zD3+crDjSF3N/0X2e56ninkgkq9xXdf2SQg1Je5tX70DuaVLmiOBU=
Received: from SA9P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::20)
 by PH0PR12MB7469.namprd12.prod.outlook.com (2603:10b6:510:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 05:20:03 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::22) by SA9P221CA0015.outlook.office365.com
 (2603:10b6:806:25::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.15 via Frontend Transport; Tue,
 22 Sep 2026 05:20:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 05:20:03 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 22 Sep 2026 00:19:59 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Jenny Liu <Jenny-Jing.Liu@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Samuel Pitoiset <hakzsam@gmail.com>, Natalie Vock
 <natalie.vock@gmx.de>, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Lancelot Six <lancelot.six@amd.com>, 
 James Zhu <james.zhu@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Pierre-Eric
 Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v2 2/4] drm/amdgpu: Make first-level trap state GPUVM-owned
Date: Tue, 22 Sep 2026 10:49:31 +0530
Message-ID: <20260922051933.772319-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922051933.772319-1-srinivasan.shanmugam@amd.com>
References: <20260922051933.772319-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|PH0PR12MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: b47046b5-3c54-44fa-950e-08df1869284f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: NBR5+g8aVNWoKS7udJknFuPNy2sDD2mLpNVsCcE9j9gyQRyrx0oIQvnCI938qJtdTOYaqn1VPsy4WBsV1fM5tWU55PYHHdtu42DCwdOe87khLaCaEpzmncFTV9eECgkJTnbrTnFRbmOiwenZWQj2u/WcpJvQT7avMAreU5YOk4oYm9JjGSI/b0GlHkmkYAfeZOHfYaSEEBCmPZ1kTiJz9IYrIpKm0cs+KybvOX+Ym60hKJIjbmWa3+T3X5e15FompZN4LKfEjndcx9A6DcVkTgz4LLFjAxzo6jgnNzIf2riHz8xkqx7Hlotfs0n59Pt0KZwGPv8A+mcbbRCY12VB7kZq4RY1OXuT3EH9KsExoFNv7gDockfgqNBbu+kFl7vTGHYxpfaNvOtz8alKXjcoGTAkEgCVJJDmQW0T1QM0b4kXVGnqUmgkRav48ecDiF8BzrHmfBihHbI8dmsBfdCDncKjGVHiQ8xkKjPsaWMLR7/bZRHsBVWNzdCFe1S/cirIEsVwjvS7ca5yU/LCIjIbyJptjUWYjAFOMffjFVsQaiGojmcUKJKxAw5Fn3C0+FVYAK8leLsFuesR+H4rrwO9bqcp2OlAyFULa2fhaIITGdRODgFReDHtLQBo3Hl1MvRLZbMPeVY0ohKkzpdfEWJmPmJdTboRKmdXQ5MuakZ+BI9dhdcHGaiOysO7ZHs2oQ7x/eO9DrVN0atYlI2Iv07DXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: t+yl3ptJmmpoUTm4q3XgC/FyGzDrYRqmLNtO8M5ogW/047pctPG/wrU/rO0inH20JeGUn0l4Sh4eQVtCxx8r0XefSFA4Vqg4mI6WerGqJnUgqWrz6lI7ozO4/Edw2Eypd52dh/igoO+U2dAQmXqPjhYL9UL83hCyuERB5PtKYIt25AsdVSDZU/d7UL0cD9i8bXlJd5LQNEc+uWUZvR0JlP4+EDmNpbz+C43UzoBBgV+OxTGf5640JhK65XtTA1W8xMKImLEj2gtbo4fHLlGm8sorEQAZKSodvi6bDN6Ew4TST/cjPoLZpf+3APlLzAio+2sRhye137Gyie3M/iKEBi+wDD/vM4cOjZZDwZdH4u20K/5xbDK8XaKzd/BOTuv2BiwnwSxjWkPEL6qW8xkBo4YmFvkcDcE+NXvkBJn0MiIzFoRXJIKXy5GMnrMMUKXe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 05:20:03.6471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b47046b5-3c54-44fa-950e-08df1869284f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7469
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

The first-level trap mapping is a property of a GPU virtual address
space, not of a queue type. User queues and kernel queues executing in
the same GPUVM read the same TMA, so both paths must not carry separate
trap allocations.

Move ownership of the trap object to struct amdgpu_vm and create it
during VM initialization. Access the trap object directly through the
GPUVM instead of keeping a duplicate fpriv alias. This also establishes
the trap mapping before a GPUVM can be used by any queue type, which
allows the gfxhub setup code in the following patch to enable TRAP_EN
without a deferred allocation.

The first-level ISA binary is identical across VMs for the same hardware
generation. It is copied once into adev->trap_info->isa_bo at device
init and mapped into each GPUVM at vm_init rather than duplicated
per-VM.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
Cc: James Zhu <james.zhu@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Samuel Pitoiset <hakzsam@gmail.com>
Cc: Natalie Vock <natalie.vock@gmx.de>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  9 +--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 20 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  4 ++++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  7 +++----
 5 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e3763c197138..c228f3c7ac4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -417,7 +417,6 @@ struct amdgpu_fpriv {
 	struct xarray		bo_list_handles;
 	struct amdgpu_ctx_mgr	ctx_mgr;
 	struct amdgpu_userq_mgr	userq_mgr;
-	struct amdgpu_trap_obj *trap_obj;
 
 	/* Eviction fence infra */
 	struct amdgpu_eviction_fence_mgr evf_mgr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 559c9222fc48..1e23a68b5c5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1499,7 +1499,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		int num_xcc, r;
 
 		fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
-		if (!amdgpu_trap_is_enabled(adev) || !fpriv->trap_obj)
+		if (!amdgpu_trap_is_enabled(adev) || !fpriv->vm.trap_obj)
 			return -EOPNOTSUPP;
 		num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
 		cwsr_info.ctl_stack_size =
@@ -1641,12 +1641,6 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	amdgpu_evf_mgr_init(&fpriv->evf_mgr);
 
-	if (amdgpu_trap_is_enabled(adev)) {
-		r = amdgpu_trap_alloc(adev, &fpriv->vm, &fpriv->trap_obj);
-		if (r)
-			dev_dbg(adev->dev, "trap handler not enabled");
-	}
-
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
 	file_priv->driver_priv = fpriv;
@@ -1716,7 +1710,6 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	}
 
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
-	amdgpu_trap_free(adev, &fpriv->vm, &fpriv->userq_mgr, &fpriv->trap_obj);
 
 	if (pasid)
 		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 930b744c5f5f..99a9605f8e15 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -44,6 +44,7 @@
 #include "amdgpu_dma_buf.h"
 #include "amdgpu_res_cursor.h"
 #include "kfd_svm.h"
+#include "amdgpu_trap.h"
 
 /**
  * DOC: GPUVM
@@ -2646,8 +2647,18 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	amdgpu_bo_unreserve(vm->root.bo);
 	amdgpu_bo_unref(&root_bo);
 
+	if (amdgpu_trap_is_enabled(adev)) {
+		r = amdgpu_trap_alloc(adev, vm, &vm->trap_obj);
+		if (r)
+			goto error_fini_vm;
+	}
+
 	return 0;
 
+error_fini_vm:
+	amdgpu_vm_fini(adev, vm);
+	return r;
+
 error_free_root:
 	amdgpu_vm_pt_free_root(adev, vm);
 	amdgpu_bo_unreserve(vm->root.bo);
@@ -2753,6 +2764,15 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
+	/*
+	 * Free trap state before reserving root. amdgpu_trap_free()
+	 * uses drm_exec to lock the page directory internally; calling
+	 * it after amdgpu_bo_reserve(root) would deadlock on the same
+	 * ww_mutex.
+	 */
+	if (vm->trap_obj)
+		amdgpu_trap_free(adev, vm, NULL, &vm->trap_obj);
+
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
 	dma_fence_wait(vm->last_unlocked, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index dd825e179979..bbf4aa96e15a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -43,6 +43,7 @@ struct amdgpu_bo_va;
 struct amdgpu_job;
 struct amdgpu_bo_list_entry;
 struct amdgpu_bo_vm;
+struct amdgpu_trap_obj;
 
 /*
  * GPUVM handling
@@ -488,6 +489,9 @@ struct amdgpu_vm {
 
 	/* cached fault info */
 	struct amdgpu_vm_fault_info fault_info;
+
+	/* First-level trap state shared by all queue paths using this GPUVM. */
+	struct amdgpu_trap_obj *trap_obj;
 };
 
 struct amdgpu_vm_manager {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 2150973b947d..1cce81914be9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -138,7 +138,6 @@ static int convert_to_mes_priority(int priority)
 static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
-	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
 	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
@@ -172,9 +171,9 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 		queue_input.is_kfd_process = 1;
 		queue_input.is_aql_queue = 1;
 	}
-	if (fpriv->trap_obj) {
-		queue_input.tba_addr = fpriv->trap_obj->tba_gpu_va_addr;
-		queue_input.tma_addr = fpriv->trap_obj->tma_gpu_va_addr;
+	if (queue->vm->trap_obj) {
+		queue_input.tba_addr = queue->vm->trap_obj->tba_gpu_va_addr;
+		queue_input.tma_addr = queue->vm->trap_obj->tma_gpu_va_addr;
 		queue_input.trap_en = !amdgpu_trap_has_dbg_wa(adev);
 	}
 
-- 
2.34.1

