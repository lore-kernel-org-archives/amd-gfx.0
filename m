Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25A1606A325
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 18:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NuJ9ulQt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7288410E122;
	Wed, 18 Nov 2026 18:52:51 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B21AA10E122
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 18:52:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3Z4+r9wMnidXQEgAsjQHvLzkmChUt+cdzxtt6X6yc9jpEE440NnC3LlgZGgPUHmJdq62h39C/2xJ7UGMx3gcZ09a9jpac4hqbvnhZgO6HWfF9Wb56BXjKK5btAx18YU15npSu/4nwyFcDZhiOu4kCJZJCV1TxHOg4QxZWdQYnGe6M6/xiWhil5V5rVhZNk2cgxgu+b683GHJZeuCagSxI1obMoLU7BIB2jWZ90ck/vp6KUg0QdG0nAdX0k4H9EkOUolDWYNyMkipsrQh8i9QbSjCj4lIRX+ACPP1bcuWGiXfAL1TC5PPxoDBvPCfLG17WclNrwLp8JwVlRJ/Q85Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGtlmO/7llqtkxCUc8Ch7JzlMOm7E4VCUkCL4OoaMwE=;
 b=mFZhPgGB4wlBuNWWaQMaKezkTDGGKHVvj0RN+CjFlBFxnMAWvcjKg0aC8GmfbYAn7LknLzWheHft4qb9Dihn0ZteL0GoaeLtmLKhR8v5muGubFGHO3HV7SBvaSQIqDjrWOXzYqgn4TKDbAAJeMhI8mE16SY9HitEQW6VYKKR4iYz3SaGDxoCc7rj8f9B1GEEcohxxtdzBkNDawojf8zVyZFJAMfE/xEh1pIfkYPPFVpGpCZeEXyo1vsiUNGCcYJ1aiVx39UC7ooUrmTpLedrN8mTt2uJ2sAPJsqIU7QdiVnwpYgzYLFb6H3Gzyd/1xN6VNsZyupt4IjF6aUGJd+Z/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGtlmO/7llqtkxCUc8Ch7JzlMOm7E4VCUkCL4OoaMwE=;
 b=NuJ9ulQtATXPNFcr7pUyNxDoDQqXR/CR45cuVzsTod+GZOJpEgsnIwnd/SiNQabDG5EOqPxEbG+DVe+ciz2WLlI2hd7diqzDKzctChpxxoS3vMFdP41esIt3Y9w6Y1yBAr3w/7YpeJBlU2jJxYdqQf5acqEDmK/mq3zMMxH4x7c=
Received: from CH0PR03CA0352.namprd03.prod.outlook.com (2603:10b6:610:11a::21)
 by SA3PR12MB8438.namprd12.prod.outlook.com (2603:10b6:806:2f6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 18:52:39 +0000
Received: from DS2PEPF00006E1F.namprd05.prod.outlook.com
 (2603:10b6:610:11a:cafe::90) by CH0PR03CA0352.outlook.office365.com
 (2603:10b6:610:11a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 18
 Nov 2026 18:52:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00006E1F.mail.protection.outlook.com (10.167.23.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 18:52:39 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 12:52:38 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 12:52:37 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Shahyan
 Soltani" <shahyan.soltani@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH 1/8] drm/amdgpu/vm: reserve more fences in amdgpu_vm_lock_pd
Date: Wed, 18 Nov 2026 13:52:18 -0500
Message-ID: <20261118185225.1857845-2-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118185225.1857845-1-benjamin.cheng@amd.com>
References: <20261118185225.1857845-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E1F:EE_|SA3PR12MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ded4372-7482-4d5f-6ac4-08df45a51e5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|261102123227099003|56012099006|11063799006|10067099003|261021123027099003|261021121427099003|261022075727099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: Cy7upFkRllOetfkRSFkqKcurVML47gCcFCp+ByRkHRcR6PhnlWox0vGpOD1NOVr6DPVrtLzwn8OhF5c/JNbDRNjtWO7D1RsIqkprrTbuZ1fatG+Axas26+ZUClCf1Q+Oo8eLSYJfkV7KHlKmuSU5V0pyTjCxK04B8zvvprmL/1zHZr1YT8Rq2oX9A07jI89kC6LpiMBZDUKmshq9SrPoltR+tkSYNhCw5lsFlNbXjk6ZVHWn3O+LEJS6THh5dIpw/r96uq2d/5oJk4vf6/DkpwL615Oz867MgEvwiz/J9SDkm7lEFz+xstxCR2NGQV9z13XC4qjdiVZT87fDzUPXrnqhiFAyVTL5PxAbhwqUEFrNGQ/nxh5siYpPPw6rYAkINsWyKCwIweUje9cEDEvo5XEiVkR+Np0VLXYQyvn0bJQJ+Y3ZAorRd8C0K2hVZWXLXxpNtnSkNP+5iPcGrcP9G81HKPK75ygQdeLwr8NLdLfj31OSRs7LykgYy1i8wztKUCLpDjWVD9b+JGdXzFzrC9UO1IZ/aZdMRdFOtPLC3kXBT2ZxhtQrQ3ZN2cceOBMSBUoEfMSwuMtVmBiMWYowNMCPoeJOr6BautnpucS/b6tEN8RR/Rgksj93jdSbgf8aKiL5OFYduILmcX6hkbm4rs2t2Mp69U4uJ4pVrkXRRppozpVvkgny4HwRIVhjxoHRoVdxQ6nRyju8b+x7sIz+SQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(261102123227099003)(56012099006)(11063799006)(10067099003)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UlKJnFItbFgwd2tEFwFcw8F6C/l4hGGKIYGxB+Lmy+pFLa04wkVydQ/v5xo5XHaRKopS5YQVq5dh3ReYqeTQ6DOArhkYb+pW3DjHr7MTpFeZxY41OD+9MLuFPhLUHrS9ouo9rIR87WkCGtD21rRgNssNFXg+elkTbCX3G/zxX3689dS1uVBuOusD39WaoklV9YByzkemU6c9nrFguiydZqKrKnA4wYP9Gu11YDW13TxHGKgrs7TUKcTx71CEWptDnN+PoXhU6rBKJDBYJI/n5qvvCxYNmVfwQIQvAZSxF85losGtWhA9SMt/k8xyGKcNqdEY57scVPD3Wu65PtWl8pi0XV0zMFBCaUaTMB103NtIGh3I0KUIPW6Ve8hm+FzR3GAQAOQ65HqAD5dabq1pZ1vKS+DluGzOvexy2Sj2IhtIOnPxQd108loIqz7Fyu7h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 18:52:39.0290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ded4372-7482-4d5f-6ac4-08df45a51e5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00006E1F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8438
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

