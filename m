Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FA560A2613
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 19:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=S7CfWzm3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D03610FF94;
	Wed, 18 Nov 2026 19:07:54 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DBE110FF8F
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 19:07:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTtoWZhFEgPissWbQ5t1ul/FZqGtVmgGhLo+Y/l46RgD4gH940/vzn15FobUtCj2FvBCq7HrGMVcdxVB016KbXzf1LMKGdryoyzGhmwFxt9rZC27csDp8hsxqLaAiN29HXmFffWI8unplfAVRhuMKS+0gBvAFvDLX6fBJLBpvJNuk4aanDX/ItqagFNr8W4YfYuv9Dck7aLAXatja4UCNnZD39+uAo+399qf6zoldU/e7kdZ3jG922TjPrydx3Qkd31forhisdIZNhAMKbjmdaOzSp7tm/LJB5Ib4Ko5652YdicM7HWOsA1vuo7CMN4OgSueG9U2IQDUEp+rYqrG/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGtlmO/7llqtkxCUc8Ch7JzlMOm7E4VCUkCL4OoaMwE=;
 b=tIehmr/FX5lsNhRYUg2EKzu8BC72rKBBriwo/K98S5W/ABKF6FxO7dB8j6nv0C1YkdH3mvir0iwpZasq4xQ76hiB6WNdEDr+CIrVRPjSNr+ofcrTYdBbekoHulUXvxGIUsIW7SOMKAKXUkyx35ugRqCpICUeuMgl6ukZ+HjF9PlkmA6dYHrEeuzouHwjfmeAFt8gpdZe42vNn/x+v7tRPl7TPSV8SjelrGY5ABRXppRaP30/+zyE+0DYNpI1XhNjxHLvk0l1hYoAtRkRQG48nGgU0ZkLdI4gRHPgvzDg5nOTZg+7QUCfb9vLrtRlgoF9FeyuAcJNog67Htvwp+AKAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGtlmO/7llqtkxCUc8Ch7JzlMOm7E4VCUkCL4OoaMwE=;
 b=S7CfWzm3bv/4WuTaYBisPJwmUEYKgYDtEi7ryr52+7y/6Dut0g2TMJTh91CUSsrwmjTEk6e5FAuHzBAKG7adkkmJNzrvn3xzRlBiHE1cHv7sxcUc7RPXGY78RratoMiXrh5hTWGFyeZu2YwI1OglF6WGtgBNBQFwDX0pX6zgeiw=
Received: from SJ0P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::26)
 by LV3PR12MB9259.namprd12.prod.outlook.com (2603:10b6:408:1b0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:07:42 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::63) by SJ0P220CA0020.outlook.office365.com
 (2603:10b6:a03:41b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Wed,
 18 Nov 2026 19:07:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 19:07:40 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 13:07:40 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 13:07:39 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Shahyan
 Soltani" <shahyan.soltani@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v2 03/10] drm/amdgpu/vm: reserve more fences in
 amdgpu_vm_lock_pd
Date: Wed, 18 Nov 2026 14:07:28 -0500
Message-ID: <20261118190735.1863676-4-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118190735.1863676-1-benjamin.cheng@amd.com>
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|LV3PR12MB9259:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa346fd-493e-49c8-dc70-08df45a737c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|22082099003|18002099003|3023799007|56012099006|11063799006|261022075727099003|261009223027099003|10067099003|261102123227099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: xqYUOujWVNgTxjfkv+cg3cQUDgm4OOkEbdQBVWg6A7TUcfZ5ffbelRMnrM33+f7uZYHeAkFs9A6i4XWLXkJJrXMhF111OquYfE/NhQ0fXW5y9kiygBNkpxJx+QOCO0P6Az6pcRsMmLMvxcA7IW/0Aj4TWt0IBDssPakmedlaJJmKEHUib+DthSHzoGDOOeI7YqQxAVFcaUr5SIkIp95vBYZrhX6Ip6hABLolcEZnEQwKXGKiD1RIDfHAjaclgqJF73kddP3W/70ExfSiiZInr7A7+56LmezWQ7xFY5d2aIfstET5Na3NV/R4otUDpJ0hrFnFEjYRqbUWLq+e2mIkMx2wnIl3vmeQ+1fp+7GuMDK+tviLUUNW1vSZq4M7nyx2ZEcn6Mdu7RbRn1odvfGFNYwsQ61Z8MAmrgSITaJiT6A9m94SlVmcib7InXT/a6+acgFDCYhSEeCWpjoI9+PMwvfiMUl/wTjNu3fzt3TWpYcbJO1mek0qu6F43KkEf/K/aQPY+0nVayKS8I27gXkEqyZeg/7JgRCfNJvAnVSfl0NzTiMZRrwWaYGQIpSLl1+IXJ927eJvKyi/baJsg3GgTB+EvCbQv5wPN6RYeWHc9sDKZrkzjp6YFwpLRxVzfTq1xUzRTrdiPyGzOo/K39unyoooujrivOvUB9/q5bhN96vbIZ5Gr8NCPHFKI0yRVIwuDj1NGWFQh8B+IpL6yy7VRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(261022075727099003)(261009223027099003)(10067099003)(261102123227099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SCi9b/6lp1WKT9lRAZiXBfSw2LkUXhtUIIlmcSoBPWlHMlCZy53qvyEPe7uhB3lWtyLWgQTg68ucskZazMUrZWqROMMQPftJwlYczyUq03lVL/EnOEAYZhpwFYLRm8PO3pAOWoa3YFeAeMkQ+BkNl3vSLFCMWpKLHRzdgCe7rfCq+yDE+mLpiMyYpjJMBUz1gOvZRzaVJjBmuWG0DG2iwLfZxtLfH5fc80pmbr8QqCBVSC5TaDwhZfMBNGeyzB3woLScyFgPtOKihO4f6XSOjLDtnh3sq5E6eQvgH/6iZrOBeDtd3cRXg3TRr9ON9f3aFUNZUZQvgjzEGNZPS3U1Ea07Pr1dtwzvEtRntUQK9fHTzll5071+I1FXOK69qdCBmzWUJMt2Ort8NoZsBpwA0Ra0qdu2y46ON7+640Hj/948vbf+1dzd8vMN7dJ32u8m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 19:07:40.5912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa346fd-493e-49c8-dc70-08df45a737c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9259
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Any page table update may currently add up to three fences to the root
PD's resv (last_unlocked, SDMA commit, and TLB flush). In addition if
any PD/PT BOs need to be allocated, it can add up to TTM_NUM_MOVE_FENCES
on top.

Introduce AMDGPU_VM_UPDATE_FENCES for this count and reserve it in
amdgpu_vm_lock_pd().

Fixes: d8a3f0a0348d ("drm/amdgpu: implement TLB flush fence")
Fixes: 897ee11ec020 ("drm/amdgpu: create multiple clear/move ttm entities")
Fixes: ddc3c87584e2 ("drm/amdgpu: clear vm pts upon a vm->generation mismatch")
Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     | 8 ++++++++
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 2d4a17e11a1f..2403cd911058 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -3073,9 +3073,9 @@ static void amdgpu_ualink_invalidate_import_mappings(struct amdgpu_bo *bo)
 		struct amdgpu_vm *vm = bo_base->vm;
 
 		/*
-		 * Fences for the two SDMA page table updates were already
-		 * reserved by amdgpu_vm_lock_pd() above (it reserves 2 +
-		 * num_fences on the same VM root PD dma_resv).
+		 * Fences for the two page table updates were already
+		 * reserved by amdgpu_vm_lock_pd() above on the same VM
+		 * root PD dma_resv.
 		 */
 		r = amdgpu_vm_clear_freed(adev, vm, NULL);
 		if (!r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 8cc5964f29c0..6d8d639e5986 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -462,9 +462,8 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
 		      unsigned int num_fences)
 {
-	/* We need at least two fences for the VM PD/PT updates */
 	return drm_exec_prepare_obj(exec, &vm->root.bo->tbo.base,
-				    2 + num_fences);
+				    AMDGPU_VM_UPDATE_FENCES + num_fences);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index f6285a9d9e98..8117bec01e4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -187,6 +187,14 @@ struct amdgpu_bo_vm;
 #define AMDGPU_VM_USE_CPU_FOR_GFX (1 << 0)
 #define AMDGPU_VM_USE_CPU_FOR_COMPUTE (1 << 1)
 
+/*
+ * The number of fence slots needed on the root PD resv for a page table
+ * update: last_unlocked, the SDMA commit fence, the TLB flush fence, plus
+ * the TTM eviction/move fences of any PD/PT BO that is validated or allocated.
+ * This needs to be bumped whenever a new fence is added.
+ */
+#define AMDGPU_VM_UPDATE_FENCES (3 + TTM_NUM_MOVE_FENCES)
+
 /* VMPT level enumerate, and the hiberachy is:
  * PDB3->PDB2->PDB1->PDB0->PTB
  */
-- 
2.56.1

