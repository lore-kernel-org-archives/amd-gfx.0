Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F36ECAAA1
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 17:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92BA010E02C;
	Mon, 19 Sep 2022 17:16:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D60010E02C
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 17:16:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMRg3Z+wXysBeTXJ5WZyqUQdkvbCr9kXto4kqqSI+o2nIIRdohuJqRgqyg6/y3v4KRkg0Swztn4JTvKrTrB9uMoIibNYPEwg5EA+3E8IA955mYFJVYfPrXkZiHCl/wJRnWWFAWiuXNs2GUCLkMkAEyfRJcHHSfqs+gI40PpIKtUtdeH7b6Ht1SukyhZtAKlcgh4SOe9FT9PrBvZINenfw4D0VP2YLdtJe9Q5foBHSh5AO+0zfsCxlfdGzv9wJNceYEEeiNNo3BeqLWmS0WlEvZ3And50OPwk54gr9oR4gvR4Cb4sjkPINxAPpqE4gtFRGT282pdzI5OrfpndiwYGXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzb7wfnE05gRBuiunar4vk/aZkWM4BzAnOsScqqZuFs=;
 b=gdJ9521cI75Tlc1gc64FRRTsvTZ3J9bcc8yQidL7jGuk4zDzmEz1+OaZ9nlgI0QMtz4WxZIwWZHBgWclczWXDWtu6A/VglWvsqaFqhs+pL1t3j2IJCgoTuVfihDkwISzzd/I3MVGBFqe3YA8inkPgid9DmPJ4gsVUlCVRfEoTGG1Uiju0HXsXzzXF29D/RfElVjwqs7wG2AkEtcXfFWmVvUjF8VsF+6iQyOegHLl+8lOambaYfqHOIMtqFdfxfL7B/AlgacBA4YmfduDRPF28Hvh2D0jBTZxyXhpsDABKf3Bz+ANcfYXj4dnetCxKtkziZH4M2+iqJ4+m2WAowC2cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzb7wfnE05gRBuiunar4vk/aZkWM4BzAnOsScqqZuFs=;
 b=00dKCK6d3iIyOr8P4ChV/oI6AlwZ2/uQ7iaPT5B5KAJAXhNevgyR9xMttMbGvhJVY0bqcI6lKRQA1AHcxP0QptvfvBuK0JbpzCUqt+WUnDJt9WeeHCiEMNpz7J3i1Fztvwkk8MumN3WUMnoJPO2C/W4ViNe3hgRXGSqJQMnUpto=
Received: from DM6PR03CA0035.namprd03.prod.outlook.com (2603:10b6:5:40::48) by
 MN0PR12MB6366.namprd12.prod.outlook.com (2603:10b6:208:3c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Mon, 19 Sep
 2022 17:16:23 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::d) by DM6PR03CA0035.outlook.office365.com
 (2603:10b6:5:40::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 17:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 17:16:23 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 19 Sep
 2022 12:16:22 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/7] drm/amdgpu: Rename vm invalidate lock to status_lock
Date: Mon, 19 Sep 2022 13:15:47 -0400
Message-ID: <20220919171553.11286-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220919171553.11286-1-Philip.Yang@amd.com>
References: <20220919171553.11286-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT052:EE_|MN0PR12MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: 02f873ce-7fb4-44b0-b162-08da9a62ad9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z5B7b39gKUqFNvIIdRAbfNhGw30BzBlmmCS60MfTrbrU0h/VJlbjRCFZ4SgbqziEcJFmCte8ol0ME21RbRDf0LTJmtMcA2+NFmCZT+GFQhkQasSnf7z2fUiBWfxUFCLf2kn1wEK1yUWo/xYJDW7tjmtmnBycV43Zt313XHlj4e8JrGhdljEkym51yQ+1TFdgDCV73rHZma7dKzRqM/9Iv2dlXgJj5cP85urwl2aDYSJOJejG3w4rWlTPRV4K0JYDzhgzsfYscyu9cLIajDeYQ63OrnhlGXXS0tws1V/fDhE15hQje07iHGzGxJBFhwcvua7YcuAQUl3DZ1L12XVte7dzaEbEO4ws3+JNekU6RavNChpM3gjXGrGNyUxLLGsSZeSf9pouOhXBSetGtaU54G2j/FxjYt1fcWXukOsnT4b2owWYhkz65IijkLBIXqwSTILb0xhN5bm69CxP810NorRvDdm2GSuU5+ocLW5bGGt1Dnk45hACYFxQ5pULzA092cBHJijhR4hrpAT8HrwfkyG7Y9UFBdChH/kJSTHXWepamoFV4ShEzoXWOFoscSZwnhLELehM55t6Hxp6ceLP8dnjSYp+lEnyGlGdD+ebqEtpWYvtPI11pl6FdUsk9GVmbD49DHO+V4cApaayCoIiANtnlDp/5ntlbcQuLeAw6dQo2Aq5HkVseQzoXK6/aTvTavd9cvfhox0va+UlC1xhGeHOoIbdm0sFrIs9mgN52d5jAT1aBHiC7p1NJ0gDtdOE53tPiA3mfNgAV/om0TlchzjKXKaoV1XwdNhSECUG5AgYYMqqUYcL3XLnVByZN+ky
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199015)(40470700004)(46966006)(36840700001)(478600001)(26005)(2906002)(41300700001)(2616005)(6666004)(7696005)(36756003)(82740400003)(82310400005)(86362001)(336012)(426003)(40460700003)(356005)(81166007)(66574015)(16526019)(47076005)(40480700001)(186003)(1076003)(83380400001)(36860700001)(70206006)(70586007)(6916009)(54906003)(316002)(8676002)(4326008)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 17:16:23.5805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f873ce-7fb4-44b0-b162-08da9a62ad9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6366
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
Christian König <christian.koenig@amd.com>
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
index 9ecb7f663e19..e6dd112d865c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -254,6 +254,9 @@ struct amdgpu_vm {
 	bool			evicting;
 	unsigned int		saved_flags;
 
+	/* Lock to protect vm_bo add/del/move on all lists of vm */
+	spinlock_t		status_lock;
+
 	/* BOs who needs a validation */
 	struct list_head	evicted;
 
@@ -268,7 +271,6 @@ struct amdgpu_vm {
 
 	/* regular invalidated BOs, but not yet updated in the PT */
 	struct list_head	invalidated;
-	spinlock_t		invalidated_lock;
 
 	/* BO mappings freed, but not yet updated in the PT */
 	struct list_head	freed;
-- 
2.35.1

