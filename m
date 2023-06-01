Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8916EC7EE23
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 19:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2303010E5AA;
	Thu,  1 Jun 2023 19:32:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9255510E5AA
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 19:32:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBH52sH/us+UlUjl7+p1zFaRx9wmGVc/QTm1foKgD5a4GRo+dCQ4w+PopNfpk17l83GPuap7/aTl8+H37AfkZOZ8apyevbpbY6tmDtp+xFr0FOqX4Dj6AGBThXwe/YUNjPedqOnYkZ7pFpo0SfZkCoS1IwuLBvxGkVoJfwtolAXhDYhIUyIgcv2cP5ktTZJg5DM88WScRLxiRBrrrkIuyKLwzcNwxyF3qkYLOXTvJc7Cwesm3keGCUsEJuOYzc4CINJyV9OBS7D7OoOIPz9VE6aBzEW4FPC4ZKavoYfgF/UwuSLjp0p8VADyEa49ugJKXlXvaeMYrl09llq5gd5L4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+nAzmah5T1h2xYZbPbvgMUc4YTdaeOJ6zOd0I/WUo0=;
 b=M6fGSQtyAz6qqOcMvgSo+NDG+MDYLULbGzg1Lia6lVE1F63rjyejGSkKZsfOkOYtg8qVBdYm7sS3Q0FhoAw9XDvG/dlKLt6FQ3jhNqaTnuB5fZd4rTSTbSglm9AwWZ8nNxdicdohSBZKpTBkLmKYpCsLaIx5pXFDZjBh6J/jnZYg50tUnGl7KAZ6wQENJPVVR5IJAVyj6DXWaDTXQkUeHNLOBXK4nipCTRUQEeDmqwG2M5Vg+S8WnYAQvPKXn4wODIWa8rx8Y17sSw7DVbKISgs0I5wd5qLQ0Xtm653cUcnRQmRmDjL15TEK1ygVtnC14MUgYi+Vmb3nabRe1g10uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+nAzmah5T1h2xYZbPbvgMUc4YTdaeOJ6zOd0I/WUo0=;
 b=FXkbTNcKhxdJKZR0JdWZEwWAxYe/uQm19kfl+br5K8+XDtlxhB7ecpoNGb0uakDEFqnNHIJXkcsSQmqPg1nREm+chkESvSQy4F3gk0wFqBRlNfMGwclYE1qW67phBnI9DlKdzofpPeBiBJEdq63aPj2QRNHUUr56q7Ws4XivYrQ=
Received: from MW4P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::15)
 by PH8PR12MB7278.namprd12.prod.outlook.com (2603:10b6:510:222::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 19:32:07 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::98) by MW4P222CA0010.outlook.office365.com
 (2603:10b6:303:114::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 19:32:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.24 via Frontend Transport; Thu, 1 Jun 2023 19:32:06 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 14:32:06 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: Implement page table BO fence
Date: Thu, 1 Jun 2023 15:31:14 -0400
Message-ID: <20230601193117.13143-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230601193117.13143-1-Philip.Yang@amd.com>
References: <20230601193117.13143-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT023:EE_|PH8PR12MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: aeda7325-5467-43aa-c534-08db62d6e2d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gcvD4SYb6szjW/M+nQH+Hwrz2VvgV/0Yc/tE7M4WUcSd69JjQIVQE0uWQtoDhKgFlEEvGFnp7+7I+8w9MkkfFEKN2OdO7EXjP1+tGZqJaVJU1U2Ius6Gtct4cJYuI7gFKBWBrlJEgzULF511e3p1KJuq1ZsyybYRafIb2K1xm5hnQGrdzlakDHMOdnmGrnfTAo0hG4SCZPlwKsWSHUPujesmqBzXRw6Fpd6j2u0aUWjmCZnYnN+y5Mlypg9EnZFMBfq66ZCy+QKzWcvdNcIilJuvJ536egPgnrj4KtuBSDGWDv/IqfBL4aG+15FHYXcsI5Wlj0FJN1zidYGzP/pPyI79aX5ZKu2bJNhRsKcvJji0zupeKGVLdHrptKJK9vIrPiAwwehq95nT7tOHXorZIkD+2uOOXAVrmYtx5EALYVbQedkoPJQQrHk/Zkmug/AzTnbHBRVSAOcZt6JKG+E/gsWxfFOuLYVkD34LNxhvAeX5FAa1QwtsFAOx//2Uv9hohc8LItrlOV0GVChfVJ0Ttc271T6AsJrQzu3DZo8704yVvVRTJlMptn1VNfRvt+GBC5I/aLP72BZpX5b7CZzKVV54s5QJ8Fcb6jRPW7Bti3VMnpfj4OFmFXbmJrnqbS03Ga8ltz5YEn5VMKs98aEaG6Df2C1dMPwBL5b99eoxZobfFNGRNUd1M+Px+zvloKkT0D+mfhmf20TiT3RLo9mJmCtEvP4s79VUBuMrDZYWx3mshbvswZEInZ8QnAYdvqGaHNoFJdQ7U9eYH5tUGQdL7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(41300700001)(7696005)(5660300002)(186003)(16526019)(40460700003)(6666004)(82310400005)(8936002)(8676002)(36756003)(40480700001)(6916009)(1076003)(26005)(4326008)(70586007)(316002)(81166007)(2906002)(36860700001)(54906003)(70206006)(83380400001)(356005)(426003)(47076005)(336012)(478600001)(2616005)(82740400003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 19:32:06.9769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeda7325-5467-43aa-c534-08db62d6e2d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7278
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add pt_fence to amdgpu vm structure and implement helper functions. This
fence will be shared by all page table BOs of the same amdgpu vm.

Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 45 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  1 +
 4 files changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5af954abd5ba..09c116dfda31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1499,6 +1499,8 @@ int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
 int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
 			       enum amd_powergating_state state);
 
+struct dma_fence *amdgpu_pt_fence_create(void);
+
 static inline bool amdgpu_device_has_timeouts_enabled(struct amdgpu_device *adev)
 {
 	return amdgpu_gpu_recovery != 0 &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index c694b41f6461..d9bfb0af3a09 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -57,6 +57,16 @@ struct amdgpu_fence {
 	ktime_t				start_timestamp;
 };
 
+/*
+ * Page table BO fence
+ * Fence used to ensure page table BOs are freed after TLB is flushed, to avoid
+ * H/W access corrupted data if the freed BO page is reused.
+ */
+struct amdgpu_pt_fence {
+	struct dma_fence base;
+	spinlock_t lock;
+};
+
 static struct kmem_cache *amdgpu_fence_slab;
 
 int amdgpu_fence_slab_init(void)
@@ -79,6 +89,7 @@ void amdgpu_fence_slab_fini(void)
  */
 static const struct dma_fence_ops amdgpu_fence_ops;
 static const struct dma_fence_ops amdgpu_job_fence_ops;
+static const struct dma_fence_ops amdgpu_pt_fence_ops;
 static inline struct amdgpu_fence *to_amdgpu_fence(struct dma_fence *f)
 {
 	struct amdgpu_fence *__f = container_of(f, struct amdgpu_fence, base);
@@ -852,6 +863,40 @@ static const struct dma_fence_ops amdgpu_job_fence_ops = {
 	.release = amdgpu_job_fence_release,
 };
 
+static atomic_t pt_fence_seq = ATOMIC_INIT(0);
+
+struct dma_fence *amdgpu_pt_fence_create(void)
+{
+	struct amdgpu_pt_fence *fence;
+
+	fence = kzalloc(sizeof(*fence), GFP_KERNEL);
+	if (!fence)
+		return NULL;
+
+	spin_lock_init(&fence->lock);
+	dma_fence_init(&fence->base, &amdgpu_pt_fence_ops, &fence->lock,
+		       dma_fence_context_alloc(1), atomic_inc_return(&pt_fence_seq));
+
+	dma_fence_get(&fence->base);
+	return &fence->base;
+}
+
+static const char *amdgpu_pt_fence_get_timeline_name(struct dma_fence *f)
+{
+	return "pt_fence_timeline";
+}
+
+static void amdgpu_pt_fence_release(struct dma_fence *f)
+{
+	kfree_rcu(f, rcu);
+}
+
+static const struct dma_fence_ops amdgpu_pt_fence_ops = {
+	.get_driver_name = amdgpu_fence_get_driver_name,
+	.get_timeline_name = amdgpu_pt_fence_get_timeline_name,
+	.release = amdgpu_pt_fence_release,
+};
+
 /*
  * Fence debugfs
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 37b9d8a8dbec..0219398e625c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2147,6 +2147,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		vm->update_funcs = &amdgpu_vm_sdma_funcs;
 
 	vm->last_update = dma_fence_get_stub();
+	vm->pt_fence = amdgpu_pt_fence_create();
 	vm->last_unlocked = dma_fence_get_stub();
 	vm->last_tlb_flush = dma_fence_get_stub();
 	vm->generation = 0;
@@ -2270,6 +2271,8 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	dma_fence_put(vm->last_update);
 	vm->last_update = dma_fence_get_stub();
+	dma_fence_put(vm->pt_fence);
+	vm->pt_fence = amdgpu_pt_fence_create();
 	vm->is_compute_context = true;
 
 	/* Free the shadow bo for compute VM */
@@ -2358,6 +2361,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	}
 
 	dma_fence_put(vm->last_update);
+	dma_fence_put(vm->pt_fence);
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
 		amdgpu_vmid_free_reserved(adev, vm, i);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index d551fca1780e..9cc729358612 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -286,6 +286,7 @@ struct amdgpu_vm {
 	/* contains the page directory */
 	struct amdgpu_vm_bo_base     root;
 	struct dma_fence	*last_update;
+	struct dma_fence	*pt_fence;
 
 	/* Scheduler entities for page table updates */
 	struct drm_sched_entity	immediate;
-- 
2.35.1

