Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE6AECAAD8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 15:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E597810ED6F;
	Fri, 16 Sep 2022 15:05:37 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C4F410ED71
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 15:05:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcIpklMn05psnnFMFc172USib2CuDsAArHjw+EcTK2nvAuJDW+q18EjXPY32zVkNcqjfd+nO4ywe5SQMQ6tov+x5Yv9EuB5hFOqOLZLkwxqxDsZJMN2psgnaSoq5I+jkuNBeIpMHqSTRMxiuXnbUTDk2VhY2tfE7lMiH0qxkIsiSp6qGMLzi+btKw9+bn6sORC7U5YklDQgd9uMCPA3lhLf1T9YXZcDD2HsWR4zpVEQN33RWL17C/qwgqJF9nMfycxwljtY4JMbERrtF4tytaQI7iMajqCrAcEIY/cuSJMkHnAd3qgjziX3Rjx1BhaW3UXtn9REvkPg2wAaz5tB5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9jHKA/wPd9AB213vDvt3lJyJlPTKSrbOOQnzjbeOJ0=;
 b=ZBvecuVBPPmFYTIRnIj5tug1zSCG/VQwnZFGxxAwLUVujkLKNDx44j6NBLbZad/sAvwE8QWwZnFnn27ZkNZBGOkJWcWaGzMfUsdT1oJLJ0C5j/WmdAP7//dCehHogseKy67/SjXnZLRsDQCtlBAOpHMPikehuLawg2PSagQkFXJh8QRBhzfMYxSbL/YvmObU3CPRY95/ZvtOm7gX4FA0b6jmIslNHwrLobZuD9diGQsyPOMvw7pNzl+GXxUGmCBYupygZgPdOg42E2dgEdgErAKmPzdI9Y9ies+F8ca1x2bm9OZbzGgq65lSdADeBzkAq9oLanb4VrAdc8WWS0ZeZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9jHKA/wPd9AB213vDvt3lJyJlPTKSrbOOQnzjbeOJ0=;
 b=k8UMLiBfBaNXfTaLMqwm5rMG6vDRxpRwgn3EcpH109Fhl6bvfx/d4GHinVr9gP8q+tklBk4uNCZPrLsb+QUTw45vfcOK6eL3kOfy6rQcG6BEYUs+JZCTDqG9JFQpF8nQ/NjmKbDabcYDll8HI8dGwiuLugnpGjBkTtO0hQ5wgAQ=
Received: from BN9PR03CA0034.namprd03.prod.outlook.com (2603:10b6:408:fb::9)
 by DM4PR12MB5360.namprd12.prod.outlook.com (2603:10b6:5:39f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 15:05:23 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb::4) by BN9PR03CA0034.outlook.office365.com
 (2603:10b6:408:fb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16 via Frontend
 Transport; Fri, 16 Sep 2022 15:05:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Fri, 16 Sep 2022 15:05:23 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 16 Sep
 2022 10:05:22 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/7] drm/amdgpu: Rename vm invalidate lock to status_lock
Date: Fri, 16 Sep 2022 11:05:04 -0400
Message-ID: <20220916150510.31321-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220916150510.31321-1-Philip.Yang@amd.com>
References: <20220916150510.31321-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|DM4PR12MB5360:EE_
X-MS-Office365-Filtering-Correlation-Id: 3016ae43-1e63-49e1-039c-08da97f4e15e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ieeXaV+vqjsR4RIXwpTuvcAADZIqz4BBSk6pzoB/cCELJgEdQvDYfKWONR1U0jPUQgXQOhwwLSpU5Jz8iHKVIstU0CnJVZFDp00xYMd2RGy3PnDfwSmxnSvaCS6Ow4xNRZRmEJqek/0XWMhu1yrehLFopjvtoIBN5epAVsyj5nH4G/ar8Ez5lyxhyWDB2hqRgfNClyAabeRvFmDX5bQSlgjQsoJ7Bd8CphhI6PV4+Wr8H7G8jz+EHYH/uuhG1tVyBzV3DRpWIX6LLHYFhHt/ne5IeMRZFnhJEJLSLYWx/mlJU0NwE3xCzqSVT2OzjkrI3VsMvtFXu/N+bzkdjtcWZN4HBmcy9N+LuSOiY/ORdXvwv5uVn9UpUyOgo/ru45u3IiJqc+mamiuZL0Dq6xHXZdmPsIOUMA41S1cmpD/jmOYotGj3oR8epBQAU4nJwD5vxwbAHuUj5Pn/zSCqKSRErMmr4OB8B9+jiHln6vSC2s/XRXCyBjLB/BQ1aLu0dubdW9olYiF3WSgbDAnvOL+cU3FuWgzWtHTqe9ZFXqXeURw6X1N4x57sYemxkywMlMCA7/O28IEr1UMkKBg3QwSRHD2tZvxDqJqCVCEeWbeFvsIH/38xmhxBQ4hzV7NSr0xlJPtS7GVwJNgh+VvNam52GBgfeqfaNGRkk/lmpDRUrSucEgop2k2yvAVh1fVI3EDQEn4nGjA5d8BOBbquPPHibXUwWfYGmFahQBOUJgBLIhqQiq9jLlviydMPGN0H4hm3fp6FK6wL/UuqB21gtXpYPzKGD7ahwRXm94DUP2zvmiPX66RN9fuL2Sh2TyiNvuWM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199015)(40470700004)(36840700001)(46966006)(47076005)(36756003)(86362001)(40460700003)(5660300002)(4326008)(8936002)(2906002)(70586007)(70206006)(8676002)(54906003)(316002)(6916009)(81166007)(356005)(7696005)(36860700001)(478600001)(82310400005)(6666004)(82740400003)(26005)(40480700001)(41300700001)(16526019)(426003)(186003)(336012)(1076003)(83380400001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 15:05:23.4570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3016ae43-1e63-49e1-039c-08da97f4e15e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5360
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The vm status_lock will be used to protect all vm status lists.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 30 +++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  4 +++-
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 690fd4f639f1..596f1ea8babc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -225,9 +225,9 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
 {
-	spin_lock(&vm_bo->vm->invalidated_lock);
+	spin_lock(&vm_bo->vm->status_lock);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->invalidated);
-	spin_unlock(&vm_bo->vm->invalidated_lock);
+	spin_unlock(&vm_bo->vm->status_lock);
 }
 
 /**
@@ -256,9 +256,9 @@ static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
 {
-	spin_lock(&vm_bo->vm->invalidated_lock);
+	spin_lock(&vm_bo->vm->status_lock);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->done);
-	spin_unlock(&vm_bo->vm->invalidated_lock);
+	spin_unlock(&vm_bo->vm->status_lock);
 }
 
 /**
@@ -936,7 +936,7 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
 		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
 				gtt_mem, cpu_mem);
 	}
-	spin_lock(&vm->invalidated_lock);
+	spin_lock(&vm->status_lock);
 	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
@@ -949,7 +949,7 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
 		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
 				gtt_mem, cpu_mem);
 	}
-	spin_unlock(&vm->invalidated_lock);
+	spin_unlock(&vm->status_lock);
 }
 /**
  * amdgpu_vm_bo_update - update all BO mappings in the vm page table
@@ -1290,12 +1290,12 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 			return r;
 	}
 
-	spin_lock(&vm->invalidated_lock);
+	spin_lock(&vm->status_lock);
 	while (!list_empty(&vm->invalidated)) {
 		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
 					 base.vm_status);
 		resv = bo_va->base.bo->tbo.base.resv;
-		spin_unlock(&vm->invalidated_lock);
+		spin_unlock(&vm->status_lock);
 
 		/* Try to reserve the BO to avoid clearing its ptes */
 		if (!amdgpu_vm_debug && dma_resv_trylock(resv))
@@ -1310,9 +1310,9 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 
 		if (!clear)
 			dma_resv_unlock(resv);
-		spin_lock(&vm->invalidated_lock);
+		spin_lock(&vm->status_lock);
 	}
-	spin_unlock(&vm->invalidated_lock);
+	spin_unlock(&vm->status_lock);
 
 	return 0;
 }
@@ -1763,9 +1763,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 		}
 	}
 
-	spin_lock(&vm->invalidated_lock);
+	spin_lock(&vm->status_lock);
 	list_del(&bo_va->base.vm_status);
-	spin_unlock(&vm->invalidated_lock);
+	spin_unlock(&vm->status_lock);
 
 	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
 		list_del(&mapping->list);
@@ -2019,7 +2019,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	INIT_LIST_HEAD(&vm->moved);
 	INIT_LIST_HEAD(&vm->idle);
 	INIT_LIST_HEAD(&vm->invalidated);
-	spin_lock_init(&vm->invalidated_lock);
+	spin_lock_init(&vm->status_lock);
 	INIT_LIST_HEAD(&vm->freed);
 	INIT_LIST_HEAD(&vm->done);
 
@@ -2584,7 +2584,7 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 	id = 0;
 
 	seq_puts(m, "\tInvalidated BOs:\n");
-	spin_lock(&vm->invalidated_lock);
+	spin_lock(&vm->status_lock);
 	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
@@ -2599,7 +2599,7 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 			continue;
 		total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
 	}
-	spin_unlock(&vm->invalidated_lock);
+	spin_unlock(&vm->status_lock);
 	total_done_objs = id;
 
 	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 9ecb7f663e19..98895c8fef6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -268,7 +268,9 @@ struct amdgpu_vm {
 
 	/* regular invalidated BOs, but not yet updated in the PT */
 	struct list_head	invalidated;
-	spinlock_t		invalidated_lock;
+
+	/* Lock to protect vm_bo add/del/move on all lists of vm */
+	spinlock_t		status_lock;
 
 	/* BO mappings freed, but not yet updated in the PT */
 	struct list_head	freed;
-- 
2.35.1

