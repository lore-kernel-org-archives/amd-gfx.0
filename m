Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756B3C624D0
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA09910EAAD;
	Mon, 31 Aug 2026 18:30:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GM7SGKiW";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDA6010EA66
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pu7xs3kqc0Ee7Vic91suaJjCZbcSPEHqF06b/Uzs5sRO16HKKHk5fH55qqCRQk++PH4Ftpe3LqiBwqf4bVUlOTijmlFz+rP/FTqJ2+L1qd19LHc3p1Ykcbs604n2erOBq+i/K0s52pOjAU1KrAZ+Ff9TXKNeJXPyExsmnQ7tNl2eCrOESnUJEELmpOVYXMe8IRspXvOOYYGtFokZgn48TK2w5mUxgdSHEjoWyhL/f/2XZvlalgH0lMkQZ5umc9j9Gtwx7FmprJesKaFVqy85vhNeJe4hDIc6LUGHW7P+3x6gkvau5fh9YXiHA8iJk844Ax3VYPzCbiMk6UYB6yON7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnVtSeEobWpCZvxKoPzZU3VyqTzGgBm4dAB6ZF/f5DY=;
 b=wOaPSXOHZrNtbRRJOWXZpWoc+0DKBSyRtXUY6Tvk2fRkl1KBh2CVc1pMx0Aby4y6cAdMrRerSkvnep/Ky3IPt/xB0zcUUjR80NRnAvVqLBGN38o3OxOYEvVq+gyDzr3csIVQJRQyRWbeJ0Hm/2NoLzpTMrIneHaiwVfNhDoyq3SW13GgdbtFc6tdoeu/4zYExdP9mNksEL/gVj/Qr/XQfBJ05XeKnxbvkL+73x3O9/d/hDmi1wuveNBTowAO43bbDFwboXlK4RgvteOHyS5TpWs7rMskmrKBZgxtF9mzH4F8v6jTmfcfUSO9g4o+qwVbF1Y6m075dQHRsdd26P8S9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnVtSeEobWpCZvxKoPzZU3VyqTzGgBm4dAB6ZF/f5DY=;
 b=GM7SGKiWwlnq3pTgHMfKVlyKmU+grj0tttWhm7iOW0lccR+KFUxIeHJAFNxt4p9c+7Hlxk4cABjvFRE5yaYmXaFT4D1tmVXR9FQpqEkkvglCt3rMt5eKRkXwpT1RRl4bNnEkQNZSbInUzGqUVrdvja/NCrNvNKmgQkuGAVOyB0Q=
Received: from CH5PR03CA0013.namprd03.prod.outlook.com (2603:10b6:610:1f1::11)
 by CH3PR12MB8459.namprd12.prod.outlook.com (2603:10b6:610:139::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:09 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::95) by CH5PR03CA0013.outlook.office365.com
 (2603:10b6:610:1f1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:51 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:51 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 70/95] drm/amdgpu: Use vm->last_update fence in UALink NPA
 unmap paths
Date: Mon, 31 Aug 2026 14:27:29 -0400
Message-ID: <20260831182754.1089811-71-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|CH3PR12MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: 22765c6d-a31c-4a7a-7db7-08df078dbf33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|10067099003|6133799003|3023799007|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /wd3SqlENIRxJcwDacrJZE7Y5tRc/HY75zY8qY8a/fIghlVXethzQUeyij9egXwVcKrtHOXRfpUgrQ3POdFto3eVxPet0sI/dMLvJcXHIikKKFZagHkkqrb5lQRwjQm1XAxzbFO2rJh34Y5wEhpYHGd60zGbQpDEVXwWJIC/Oy0IOlCLiFQVaTAR6Ec7xQahYehUCqt97Q9uMF/wgKZYVHbLt37PdGrRm60/sxUXHRwZnLiTuiuOuc9RZ1GzEStNH+f9z7oWpmGUnV1u9oAlkn65sYxfOVC27HlN22WQ14l/EWzD19lSMYxwuBMMJe51gBP8Fmh8SPf6xOrv7V4mnlqrFLA9oZAPYHwz2CXFe87DPMHGJ8Fn6rPXJwm/lX5O8C0kdP58ccoPeUSwmoHhhI9q0KI3MNjIjSs37Bg+COAz9r7h0WgW88CRCtKv0/B1tJv9iijg2Ps5XJodkO5adZgwUIyxwZ0iD5f3/7LyDx+/A0N7B1uAELxwC6t6e7utr3wgfpi+rXPxdd/ZmWP2SIFftgGHz9vev4rrDt5C8HtJncb88B1ThsqYznFadrlgrN1b8gXuwqXjY2Og0fz9HhQOJ05y2InCtY/phDUJsDXSW2/amKK0WWKtgOsns43ticTuw1IQld7/pB27yZgurTa1dJC/slopSI6R2fWYueZmFc5hJt61KNFw0A76J95xK8UoM9+3z4yzseTdzs5BMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(10067099003)(6133799003)(3023799007)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y6ZpYKG1dlaPavBUc+FaBIkc1QPPQMvBoUFdDLTXNPs6io6gbPTEsnS9QXKH023ylWq54PLW7Dz85Wl5VTr/06lICxzQN+AOvygylvl8fSzDV53GzJrjauIxBgeanSy5FQXSagIvFAuYa8DXO8bJyYQF1XcxxeiDCMq2pEzZ6Tt9QIhvUDXFCvl4L50le/oL5WWb6lC9Yr/QM0BaFlI32HJNkQGYdPo3SyA7H0i1APd4ppBK7ta0k7blKRVBKaD620Lx9twNPuwKT04rZcpxGxmgDf7c2v8O3Dwhtp0pYqKArmwCK/P4yz6n3fmkFwe4rrHal1DjpH+SBc/IjZFvc9UfThz2NerJaaeh8xHHOxjRgcUdAr4mblsUv2Rg9vaACPw6vy+1gyiUiTtM512IdtlU/KKslmWePMuprDEa+TxaAx7R4P/hnWvHw2U12H/H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:08.9036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22765c6d-a31c-4a7a-7db7-08df078dbf33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8459
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

amdgpu_ualink_map_npa_addr() already uses vm->last_update as the fence
output for amdgpu_vm_update_range(), but the two unmap functions used a
local fence variable instead. This is incorrect because
amdgpu_vm_update_pdes() always commits into vm->last_update regardless
of the fence passed to update_range(). As a result the PDE update job
(submitted after the range update) would not wait before the TLB flush.

As a result, switch both amdgpu_ualink_unmap_npa_addr() and
amdgpu_ualink_unmap_all_npa_addr() to use vm->last_update fence.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 85276db902b15..5811218b35d33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1488,6 +1488,7 @@ static int amdgpu_ualink_unmap_npa_addr(struct amdgpu_device *adev,
 					struct amdgpu_bo *bo,
 					u64 npa_addr, u64 size)
 {
+	struct amdgpu_vm *vm = &adev->ualink.npa_vm;
 	uint64_t pte_value = adev->gmc.noretry_flags;
 	struct amdgpu_bo *bos[] = { bo };
 	struct dma_fence *fence = NULL;
@@ -1500,16 +1501,16 @@ static int amdgpu_ualink_unmap_npa_addr(struct amdgpu_device *adev,
 		return r;
 	}
 
-	r = amdgpu_vm_update_range(adev, &adev->ualink.npa_vm, false, false, true,
+	r = amdgpu_vm_update_range(adev, vm, false, false, true,
 				false, NULL, npa_addr, npa_addr + size - 1,
-				pte_value, 0, 0, NULL, NULL, &fence);
+				pte_value, 0, 0, NULL, NULL, &vm->last_update);
 	if (r) {
 		dev_err(adev->dev,
 			"Failed to unmap NPA addr (%llx) from NPA VM\n", npa_addr);
 		goto out;
 	}
 
-	r = amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm, false);
+	r = amdgpu_vm_update_pdes(adev, vm, false);
 	if (r) {
 		dev_err(adev->dev,
 			"Failed %d to update page directories during unmapping NPA: 0x%llx\n",
@@ -1517,12 +1518,16 @@ static int amdgpu_ualink_unmap_npa_addr(struct amdgpu_device *adev,
 		goto out;
 	}
 
+	fence = dma_fence_get(vm->last_update);
 	if (fence) {
 		r = dma_fence_wait(fence, false);
 		dma_fence_put(fence);
 		fence = NULL;
-		if (r)
+		if (r) {
+			dev_dbg(adev->dev,
+				"UNMAP-NPA: dma fence wait failed, error: %d\n", r);
 			goto out;
+		}
 	}
 
 	amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
@@ -2129,6 +2134,7 @@ static void amdgpu_ualink_send_tlb_shootdown(struct amdgpu_device *adev,
 static void amdgpu_ualink_unmap_all_npa_addr(struct amdgpu_device *adev,
 				struct amdgpu_ualink_exp_xa_node *exp_xa_node)
 {
+	struct amdgpu_vm *vm = &adev->ualink.npa_vm;
 	u32 addr_mode = adev->ualink.info->vpod.addr_mode;
 	struct amdgpu_ualink_importer_entry *imp_entry;
 	u64 pte_value = adev->gmc.noretry_flags;
@@ -2167,10 +2173,10 @@ static void amdgpu_ualink_unmap_all_npa_addr(struct amdgpu_device *adev,
 			npa_addr, exp_xa_node->handle.handle_hi, exp_xa_node->handle.handle_lo,
 			remote_acc_id, pte_value);
 
-		r = amdgpu_vm_update_range(adev, &adev->ualink.npa_vm, false,
+		r = amdgpu_vm_update_range(adev, vm, false,
 					   false, true, false, NULL, npa_addr,
 					   npa_addr + size - 1, pte_value, 0,
-					   0, NULL, NULL, &fence);
+					   0, NULL, NULL, &vm->last_update);
 
 		if (r)
 			dev_err(adev->dev,
@@ -2182,7 +2188,7 @@ static void amdgpu_ualink_unmap_all_npa_addr(struct amdgpu_device *adev,
 			break;
 	}
 
-	r = amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm, false);
+	r = amdgpu_vm_update_pdes(adev, vm, false);
 	if (r) {
 		dev_err(adev->dev,
 			"Failed %d to update page directories during all NPA addresses unmapping\n",
@@ -2191,6 +2197,7 @@ static void amdgpu_ualink_unmap_all_npa_addr(struct amdgpu_device *adev,
 		return;
 	}
 
+	fence = dma_fence_get(vm->last_update);
 	if (fence) {
 		r = dma_fence_wait(fence, false);
 		dma_fence_put(fence);
-- 
2.55.0

