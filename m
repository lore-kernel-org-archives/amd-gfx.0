Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA461C624C6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ABB710EAAC;
	Mon, 31 Aug 2026 18:30:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eGFInc5h";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013012.outbound.protection.outlook.com
 [40.93.196.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07C4D10EA67
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4STkrfJJIYT9O6m/3fLq/pPXeIppTLGX/VHAAjETH6+qFv+highyQ2CRXpI0Knz2FjpXdnsgVbB/K1CzVDxbyPjH3sVvMQVtFlsTWN4eckgjB8o34whfw3LPU5NkvqcaVoIr289xWiU2zzRknVk3VQkmoPiWIjhi4qmZUiGZFmc/qOTNC+jns9uhfL520voTDz+BPRvnHLBATiSO+lsiJRA7Us4aB95wBCjUG1/PIslisObHSkXmWTSHD8UZqlXmu+uSPAacrzBo6zg5A2tok25K1+wVYfRHAcpjF6dztgm3bLjFsCsrpGemRKL2twv5XMFOTjIp00l8qbUWd0BjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iwb9kjEQ0Zx2mM4Pf3bUGsyNtt5tVMZn2NKob1FMUo=;
 b=et6/KVYl92kJY7psRcGzdumZ8Ym5cgJkfAfgewauihcPm9vwfMYeqPCsDg4tNejG/Dg5Oud5DJdK8QmzugR/DUPfh0w8JkvnC020Je54QRIntMkO5xoUloFAvfc9ov8zCCYQ4SmDYHu0yHYfqDONhAHLgawwG+Qp6uLRSznCjjbbmpeor8cKS7s2iQeo300fzttKvtyOJfOB+nqKboL001n64Y0Fs3jnqceLtKuou35GqSnvQTnhkJcSrRxwr6DGExUOsBvmgBaz0wAnZWNGxUOWzLyNluXQItgQM/hm9uX29R1vD6StDimrxCZiRMEyI+5g7L8DfDB9Jju0dSzXKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iwb9kjEQ0Zx2mM4Pf3bUGsyNtt5tVMZn2NKob1FMUo=;
 b=eGFInc5hL32nhGJL513Oxjjp6jAt2JJmBHQW1Yemrq/FHaSWs/m6sju7NqrJXfQ3NUDPazztuKq0wi3v/Hfr+rPZHZAXA/OLVeeGkO11sInIAqCZmJUwkD6MoZE9/vpXoXHHKHJXSqXtAXvB0YOCGJh8Pnarm67AevxoG0ZymMk=
Received: from CH0PR04CA0115.namprd04.prod.outlook.com (2603:10b6:610:75::30)
 by PH0PR12MB7080.namprd12.prod.outlook.com (2603:10b6:510:21d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:56 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::72) by CH0PR04CA0115.outlook.office365.com
 (2603:10b6:610:75::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:56 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:41 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:42 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 55/95] drm/amdgpu: Setup PTE mappings for NPA addresses
Date: Mon, 31 Aug 2026 14:27:14 -0400
Message-ID: <20260831182754.1089811-56-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|PH0PR12MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f5fd85-89c4-40eb-1ff1-08df078db7b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zGLFAtb7UY9K1tiAQtu7Srll1Ad3Uua+ZMYXwrt5pX72c6w9XHeFmwWTyVH6SWW8s8QcQ7ibP3RBk7HFjs+1dWstoWuvPCpAURQjPJe1w7ao0aOhmBS9dJh9OpUOtDL0vz6p8tVRSzI69+ky3mcGA9HxLOMk/PwR5rYRhF4VVIaUt/o2WUF9r9V2EGNLjKHIkiISzvt+keDT0b7NEmWsK1d8j5da6u+SigUIV/owjCT+zi1HgN8c7UXc+otu7BW6J2N3n/WK9eFA5ffKuCG2UXGB4VVi7WESrtqVgfJpjjQ86lyqH1ZsFisyphu5k8MEQgJvuiqBeTe2UaGNeLsCnV3OaNyD++oZxZctJTyNRNXGQ9ZY1VEBVA0k+TBpdgj8KaDGpZgteLkwOdukytqaHnIffmNguxxeXUeoS4/iWvYrbvtzbRHQ/7cph4rj++WkeEXjKbjMVGgweG6gE69NqoPUCNbQ0r8/oxzFXqds9+OB2yxGtLTfIRYV6wm/we+4yOdhAW/Y9H6uQofM5YbkPOgtInpOSFP7uKG+L72jEgQLYROKqk3rrG1pmc6HuJxF8LjVax2uPnEWS5dXJeDOJJTsNM1R6pPNQyd8PEmQ4jPoRLLlOJ8H+G9X3QR86Ay4sbeYMxgMmTTxI51rjAzNlZO4g8NElPRmYE2zKvq3rZT6H8gvkapYCnLqSQ9THQwOnRMbRq12Bt4FTsKZ3owbHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +vf8w/JdcT7UVKUQsNqW711o7OuEmC5fXuA6+QtSzosfVI6KKaudvXp+ZWU+jP6EjxKbk51KLKBJAtpuPb7s55VeQuCDD54d+vEMPsNhoYHoPOefXEip84n0ePhz9Qwq6aGLIbm3nP8CO5+xxKTOROq8Lufoq3BdvTzT6KbmpXt7aAcr15XmYFUTESfLifEQGEXrpkLOSJt8kAMhG9sJL4y967kmSa62Ucw51CNMmdLLIQWxZTnQHZ7uLink2tdbppn5mQnAk2SUPSuqxNqrhG/zrc93mkCt67hSOu0AmtkARF3TZaaUoij6ACRlS4BLu43adw3bYuowZEB8TS9qtLI6GeF/Kn6FdN4daXkeJOQhOY/iKD6QEebfvYbn4uXQPE49KZqlBlH3jhjrfTei8bKjpCBUTtydUhqJ+/rehTo7gqbq3tSVtQ2jBNCj4OWt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:56.3083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f5fd85-89c4-40eb-1ff1-08df078db7b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7080
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

From: Mukul Joshi <mukul.joshi@amd.com>

Map NPA addresses into importer's application page tables
using a unique pairing of PTE fields.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_res_cursor.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  4 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c        | 30 +++++++++++++++++--
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
index 8908d9e08a304..6650b1194c0f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
@@ -92,6 +92,7 @@ static inline void amdgpu_res_first(struct ttm_resource *res,
 	case TTM_PL_TT:
 	case AMDGPU_PL_DOORBELL:
 	case AMDGPU_PL_MMIO_REMAP:
+	case AMDGPU_PL_NPA:
 		node = to_ttm_range_mgr_node(res)->mm_nodes;
 		while (start >= node->size << PAGE_SHIFT)
 			start -= node++->size << PAGE_SHIFT;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 4c8341b4fe1bc..fc928c2d8b21e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1196,7 +1196,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		uint64_t tmp, num_entries, addr;
 
 		num_entries = cursor.size >> AMDGPU_GPU_PAGE_SHIFT;
-		if (pages_addr) {
+		if (res && res->mem_type == AMDGPU_PL_NPA) {
+			addr = cursor.start;
+		} else if (pages_addr) {
 			bool contiguous = true;
 
 			if (num_entries > AMDGPU_GPU_PAGES_IN_CPU_PAGE) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index a8e32ee93735d..1468047687652 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -600,6 +600,21 @@ static void gmc_v12_1_get_vm_pde(struct amdgpu_device *adev, int level,
 	}
 }
 
+static void gmc_v12_1_get_npa_flags(struct amdgpu_device *adev,
+				    uint64_t *flags)
+{
+	bool is_aid_a1 = (adev->rev_id & 0x10);
+	unsigned int mtype_remote;
+
+	mtype_remote = is_aid_a1 ? MTYPE_NC : MTYPE_UC;
+
+	*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, mtype_remote);
+	/* VSCT = 0011 to identify NPA. Additionally PTE.B = 1 */
+	*flags |= AMDGPU_PTE_SNOOPED | AMDGPU_PTE_PRT_GFX12 |
+		   AMDGPU_PTE_BUS_ATOMICS;
+	*flags &= ~AMDGPU_PTE_VALID;
+}
+
 static void gmc_v12_1_get_coherence_flags(struct amdgpu_device *adev,
 					  struct amdgpu_bo *bo,
 					  uint64_t *flags)
@@ -668,6 +683,8 @@ static void gmc_v12_1_get_vm_pte(struct amdgpu_device *adev,
 				 uint32_t vm_flags,
 				 uint64_t *flags)
 {
+	struct ttm_resource *mem;
+
 	if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
 		*flags |= AMDGPU_PTE_EXECUTABLE;
 	else
@@ -689,8 +706,17 @@ static void gmc_v12_1_get_vm_pte(struct amdgpu_device *adev,
 		break;
 	}
 
-	if ((*flags & AMDGPU_PTE_VALID) && bo)
-		gmc_v12_1_get_coherence_flags(adev, bo, flags);
+	if (bo) {
+		mem = bo->tbo.resource;
+		if (mem && mem->mem_type == AMDGPU_PL_NPA) {
+			dev_dbg(adev->dev,
+				"Setting PTE for NPA BO, mem->type: %d, mem->start: %lx, mem->size: %u, cur_flags: %llx\n",
+				mem->mem_type, mem->start, (u32)mem->size, *flags);
+			gmc_v12_1_get_npa_flags(adev, flags);
+		} else if (*flags & AMDGPU_PTE_VALID) {
+			gmc_v12_1_get_coherence_flags(adev, bo, flags);
+		}
+	}
 }
 
 static const struct amdgpu_gmc_funcs gmc_v12_1_gmc_funcs = {
-- 
2.55.0

