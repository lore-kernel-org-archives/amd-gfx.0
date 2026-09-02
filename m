Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B935C624D3
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 15:07:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 882F910F260;
	Wed,  2 Sep 2026 15:07:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YTq2Zy6b";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B09110F260
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 15:07:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaXb7m07u38yM+UQrr7Fb2digZc7YvSVZsCW3JpitdgBOx21ENnMgMpNTHSYUZg9N70Ue5+QAmsRdYOUnOe8O8bPW5YV6zVVY/7WSQWEFSt1jlN2Ydet6mcD7+ygvfHln373S8fyTxjJSFFsZ5th7DRMIpvWyZZXJ6k/+jVkjZIrSa+II+u+T/b6pat0Qhe2AqpilN+hQnpjyLrfFTdl77Oqw2u8EjuhUygvI5ZL8eQRvlvXNQ9MmdBikxZm0ag3zyccRZe+GVewIhqqvXgcpVN0Y1QB0pgIfSeO1hJihPwEHl6la2Vo36/sF1Ktl2v17POXhEhFYqyY7Hf16xxAiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSJ6TVv9pOSBpAbratbs4qvQl1IoW//jhPFcgt1ewIQ=;
 b=bDdg3Nk9MfK8n2HzSh/x3k2WLKDctBmc5xym+PLzatydB176UkiQxO6yESHrAB1Zb51oo3F84t7zeEJZkgjyphsroS8/43gYh3ar9DENpfW3B7YGTW+bufOFof7Ae43Ok+/Zk8qJQevJ4zexr965/aRPIn33uXceGDj8ehVQhcZ1Ymy3nbUn9PmR6L2LSTNdgS0OQ5GdyzSfsBq2ke2wViI5hvg/q2ZXb9Jtrj59nZM+/1Y+OdIW3SCflT8y1V5veNXuB2QV4VNGwuSP6aTMNLFKj5sxkiCqUiPgYJjDvtW2u6y+bYbExBLlyDwbtHlivy/D+m8Ugu2rjkh3N/VFPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSJ6TVv9pOSBpAbratbs4qvQl1IoW//jhPFcgt1ewIQ=;
 b=YTq2Zy6b7CELRzEcbz8SOp840dFt2ASGm3XJJL8pkkgSyfNMqzitYe7yNjtQVX7YiCWNig99hlRjf0fRC4kwSJqktKHmMF6a5jO/tDatK3TTgiDPB7fYtJCJpAJyskY/gdAWrBvNAGqJJxsagkv07LpHhU9oMehLiwzDEvb+fIU=
Received: from SJ0P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::23)
 by SN7PR12MB6960.namprd12.prod.outlook.com (2603:10b6:806:260::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 15:07:08 +0000
Received: from SJ1PEPF000037BB.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::1c) by SJ0P220CA0016.outlook.office365.com
 (2603:10b6:a03:41b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 15:07:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037BB.mail.protection.outlook.com (10.167.244.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 15:07:08 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 10:07:07 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH 1/2] drm/amdgpu: Add kernel VMID trap handler
 infrastructure
Date: Wed, 2 Sep 2026 20:36:55 +0530
Message-ID: <20260902150656.183333-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902150656.183333-1-srinivasan.shanmugam@amd.com>
References: <20260902150656.183333-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037BB:EE_|SN7PR12MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef127a5-24c8-4ae6-2c85-08df0903dbdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: u8lGVfEGaqoGpVmuVaVyWZzwMCqvaSsltNsnB/5MJ5XmI77Df7M/tiuGZgf4gV9TBTW55yUYqmJ70Fq/hx2bddIbmBFyMSLzZ+lX6XIkp91EUywSndgQWJOvkps10vgGiAPhHCzqiaF2F26HVV+OKhYqirBSSdM4CT1BZk3/oGYbXjZd5LMqI/NnbmPeuC9t+sV0C8nJSXd6TL4fXm6SsuodMGnweIZSp7FxlK0LdZUTnUfmuEtqzf28aPeP/8/seh2UCdNnJYZmRI5BeIEBXfPgqHij0aFSMG8hYXwDXssl7gO9Jk8xkvy+pHxTN7kEtEKKx6H9RsfhH2kgzaz/wegOJcXnUy7ezKH+LwwyDVSFgTZkBigMm9qHCeq+9PxPE9HThixgJZwHrF/DfhNHcf6024b3eS5otub5QZ0CnxPr4X7+7Eqt6oJCEPpsCxMe+S/sn4dC5RYl414F3Z+RDbW5RfHkMMkd/XNX3RC3RZf6aZL+PESBOrZjDThRXzIzWMCL+TyUsvIDgnwRvjljMKkhAPZwBUshCSQXDfxv6XlnU4zuvQU0kYYkOKrFVdUwZVxZUX+1KmO8aRHm9L0CrU5uMsBNMG9mTkw/SmAwmx4gtmYE3DcNvW8hz8ccaoapQrlb30wl7PTH0HOeWO4HI43MBiwqVvkzIeKNd9hQTjhsFI4BCdYTsM59uKNZuHv29tig2jFyIlkBhE/51BUD7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IVG28G9TKTGKi+vD7kn+UhZaruhchhDGnNg9AmajLoofBeaWVhdCbJ5ytbIIvJnX4IacLOppHvxPdtyDW0PyCczNuq2ZaL6tvOKh81oIUZACoHNdGo+woNfWD/9b8+XnsOVrnk/Ny1PAP/ZfEDmkF2Pz0+TUtbhkwHCTn71Y/G0G1qU8Oa6tRJhNhN0X5OK0Yq/ehytG7lycnf8jCNb0ugzuKgQzxl2Pl6K8vXdinY97UAbMh/03cYFnv7Z4OnCAMpIERKSyXXuYEtJLsoAP6v6DTctsMFoI1DzJ7Ygf2qiuQmoXUjPXjPMCpertoaV/9Wfnj9PwY6tbtA4nqARJdEUTBKVnXB89LKy5LXkIg2woWyAQhT0D6Fl/fGtdqz1sR1w/bby95x03Wezg9wBakGGETuWyb54MqesaJoOYY4NHvoVN7gyYXsaU2So/PJIC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 15:07:08.7286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef127a5-24c8-4ae6-2c85-08df0903dbdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6960
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

MES owns kernel queue VMIDs (1..first_kfd_vmid-1) but does not program
SQ_SHADER_TBA/TMA registers for them. Add infrastructure to let the
driver program the first-level CWSR trap handler for these VMIDs directly
via SRBM select.

Add kq_tma_bo — a pinned GTT BO used as device-level TMA scratch for
kernel queue VMIDs. Unlike per-process TMA (created in amdgpu_trap_alloc),
this is device-level and lives for the lifetime of the device. It is
zero-initialized by the OS: the second-level handler address is 0 until
userspace calls SET_L2_TRAP.

Add amdgpu_trap_program_kernel_vmids() which dispatches to a per-HW
vmhub callback, and a new program_kernel_trap_vmids hook in
amdgpu_vmhub_funcs for per-GFX-generation register writes.

Required for:
  - RADV graphics debugging on Vega/Navi/Steam Deck (Valve request)
  - Consistent trap handler behavior when switching between kernel
    queues and user queues

Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Alexander Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: I0709e788835b69d3d492864de8d5c2d36d0f08c8
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 37 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h |  2 ++
 3 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 3ca187f5ade8..5624a5ab5c62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -115,6 +115,7 @@ struct amdgpu_vmhub_funcs {
 	void (*print_l2_protection_fault_status)(struct amdgpu_device *adev,
 						 uint32_t status);
 	uint32_t (*get_invalidate_req)(unsigned int vmid, uint32_t flush_type);
+	void (*program_kernel_trap_vmids)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_vmhub {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
index 31f653ec3fb1..0e0aeea0aa2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
@@ -256,8 +256,23 @@ int amdgpu_trap_init(struct amdgpu_device *adev)
 
 	memcpy(ptr, trap_info->isa_buf, trap_info->isa_sz);
 
+	/*
+	 * Device-level TMA for kernel queue VMIDs. Pinned GTT — not subject
+	 * to eviction. Zero-initialized by OS: second-level handler address
+	 * is 0 until userspace calls SET_L2_TRAP.
+	 */
+	r = amdgpu_bo_create_kernel(adev, AMDGPU_TRAP_TMA_MAX_SIZE, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_GTT,
+				    &trap_info->kq_tma_bo, NULL, NULL);
+	if (r) {
+		/* isa_bo freed explicitly; trap_info struct freed by __free */
+		amdgpu_bo_free_kernel(&trap_info->isa_bo, NULL, NULL);
+		return r;
+	}
+
 	amdgpu_trap_cwsr_init_save_area_info(adev, trap_info);
 	adev->trap_info = no_free_ptr(trap_info);
+	amdgpu_trap_program_kernel_vmids(adev);
 
 	return 0;
 }
@@ -267,11 +282,33 @@ void amdgpu_trap_fini(struct amdgpu_device *adev)
 	if (!amdgpu_trap_is_enabled(adev))
 		return;
 
+	amdgpu_bo_free_kernel(&adev->trap_info->kq_tma_bo, NULL, NULL);
 	amdgpu_bo_free_kernel(&adev->trap_info->isa_bo, NULL, NULL);
 	kfree(adev->trap_info);
 	adev->trap_info = NULL;
 }
 
+/**
+ * amdgpu_trap_program_kernel_vmids - program first-level trap handler for
+ *                                    kernel queue VMIDs
+ * @adev: amdgpu device pointer
+ *
+ * Programs SQ_SHADER_TBA/TMA for kernel queue VMIDs (1..first_kfd_vmid-1)
+ * via SRBM select. MES owns these VMIDs but does not program trap handler
+ * state. Called after trap init and on GPU resume via setup_vmid_config.
+ */
+void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
+
+	if (!amdgpu_trap_is_enabled(adev))
+		return;
+	if (!hub->vmhub_funcs || !hub->vmhub_funcs->program_kernel_trap_vmids)
+		return;
+
+	hub->vmhub_funcs->program_kernel_trap_vmids(adev);
+}
+
 /*
  * amdgpu_map_cwsr_trap_handler should be called during amdgpu_vm_init
  * it maps virtual address amdgpu_trap_tba_vaddr() to this VM, and each
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
index 6d4664469bad..326910f1d94d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
@@ -48,6 +48,7 @@ struct amdgpu_trap_obj {
 struct amdgpu_trap_info {
 	/* cwsr isa */
 	struct amdgpu_bo *isa_bo;
+	struct amdgpu_bo *kq_tma_bo;	/* pinned GTT, device-level TMA for kernel queue VMIDs */
 	const void *isa_buf;
 	uint32_t isa_sz;
 	/* cwsr size info per XCC*/
@@ -70,6 +71,7 @@ struct amdgpu_trap_usr_addr {
 };
 
 int amdgpu_trap_init(struct amdgpu_device *adev);
+void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev);
 void amdgpu_trap_fini(struct amdgpu_device *adev);
 
 int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-- 
2.34.1

