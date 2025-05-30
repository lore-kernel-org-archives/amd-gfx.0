Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B019C5B549
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 07:55:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB55110E7F1;
	Fri, 30 May 2025 07:55:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lB6VNY9P";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 272EB10E7C3
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 07:55:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRQVxpBWtVqWzmWiLT80MM8ngO80aZq+YMUj3V7ChZhBP+lRBcT3geZ8TxJ6PeQPDIJ65qm+nNm295qGsZERZnY1cqe/t18fLWhRDK6zpujJptNTy3Bq2OD738kbtNWcshLe/0PQhZ6iTKHAUq68OvqbLbhNd8qrLbB6zSCypQkivNMnrjofM9+DJFF3OqcssNnNgh16ShppRgyisfHC5VC0Jl2qm7GpZl41FWtqoKvIUx9li7DdrHIgkyKBcKAB64JpsUtddN3+ZIue5TnbBym1SDBznRW6PGvq+1pqN8xGL9WljLr5+aPK32L+IR1BejIlNVxQUD+4lC+sACWrPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sinz0FiFanr/uXNVtd/QXSQfdJsMXl7zBzsbvUwQ08w=;
 b=jkEALUfEbnj5OE0Ab6tk8Ij9lKboWz9iJLcjCRAJd34OT08VMC9BKg6ppkRSfqDZWaPwNlPGj6Iu5FuFcUaZwe+npzsIydesMv2AxmvkXjVr9l5IscWdYyeDuznh86OnXSBW0ATixghbjv+x1rd4SC5Uz+lRZWV3UD+4owZEU+oMTFs8c1dtLSOkMMGUN77vmNTat56PC/AI2USq9A4f4NKEl0E1V8ityd1j9Cw2S4kSfgRg4bEY6bGNUTfMIq4hOYudhmMJwFgX6RcemvSbaCsCbKgpmirISfmSqvSi05SGbgpzlTevMWOR9hjAdxpaTVSSHuSt5aMLkAj5M7BYeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sinz0FiFanr/uXNVtd/QXSQfdJsMXl7zBzsbvUwQ08w=;
 b=lB6VNY9P0+P/lusTlNeuI70f/v3xjaau45GBG6r2vmDlzQnrZ0alXsiJuq9RXrVYiPZ5jQeMCjR5qMpFLDsp/CO8s6k19iXkWhTVzZeQOlgAj21zFG2XuxjM0e4upss6pyVv/OUfmeUphm0a812LxK9+4OczPmo721kKynIvxJE=
Received: from BY3PR04CA0022.namprd04.prod.outlook.com (2603:10b6:a03:217::27)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Fri, 30 May
 2025 07:55:24 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::ae) by BY3PR04CA0022.outlook.office365.com
 (2603:10b6:a03:217::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Fri,
 30 May 2025 07:55:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 07:55:23 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 02:55:21 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 4/9] drm/amdgpu: validate userq buffer virtual address and size
Date: Fri, 30 May 2025 15:55:00 +0800
Message-ID: <20250530075505.882004-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250530075505.882004-1-Prike.Liang@amd.com>
References: <20250530075505.882004-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: edbe7714-72f5-4e49-c8d0-08dd9f4f5511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WRvHOpcWckzy/4dZvGazDai6fH5GwAQ6QZbACf9LNjACDdEoHJbnDoCcmJea?=
 =?us-ascii?Q?rbqFHT6P4xrkixBA9q7/BaKefoPcjvGp6/o4re+JGox1xRv0khzg6maq/ug8?=
 =?us-ascii?Q?RvpyTlpVfGenUf2UO1wtakYhWiMNlH2qcI6/YcTXm88+3lHVeY2TPqp/Wg4L?=
 =?us-ascii?Q?F7Bm+FPItc6qk5G7jPNqZY5+9PD5lT7oNfO2KPg4cZJXq3wYEUitQ+BU/zIO?=
 =?us-ascii?Q?q/TTMQGKBJGoBCy1LqPh+xICx+OVH3qdXekRMdsDptbNW+vvBiTZtr7ghXuY?=
 =?us-ascii?Q?3ZWumfQI2IBiTEYUefjCQjGatkk6+gktRb4Z0RtP0OBTLvtlzWEH/w29/Mxz?=
 =?us-ascii?Q?RuahGMy9F3CSb08FUMcSG7B+Eq0Aj8w2iTgDTKIxPSrahUQnID/lzXeaMIdd?=
 =?us-ascii?Q?f3G+47m9zLHyEl/LYlxKW7mzGGQZs7LYIKBqgU01IUbCoRZg83Dl0J6SNVRe?=
 =?us-ascii?Q?m1obehhrQ29qHvIZhKtOB4ZwpszeRHGOzxuCfiX4HKxuViIlbA3aYFsDxapu?=
 =?us-ascii?Q?Uj3wPptG6HV06ev1cx68MJYvunA1kAR8lHPb8RbzG7ELqCTD400ivtcHb4H1?=
 =?us-ascii?Q?P7ARStpRONfmRV7mnNRt8oZ/JqSNIhru9PgZA1dEG5PX/79PGMA1XBzo73VR?=
 =?us-ascii?Q?WqQnFI9CTUHH4jQPkM73pCsg+0BxQwO8a5Tpc+aSOzyIBZmIlZbxYanbJcK2?=
 =?us-ascii?Q?iPTBrr0OOO4hunhLzQ7IZ/myfxVAFu6Ie04+Ynd+sbqRzX6c0LCT66T5pgVs?=
 =?us-ascii?Q?v62d1bZAmhyjK+C6qUyuqAd8eFqb4E+FI/5gPUnjr94RCzYNKuoMsVKjudSp?=
 =?us-ascii?Q?hk0nEh/SPDDOqMBgz2U84cvh9Era5QyVhtAt7M1SmVCSq07qenPLM5h1Y1pu?=
 =?us-ascii?Q?7HgM17xG9zmnsN6wjJFRrXrBk8MtVCzvBxCXnP1850ABOk/f/mRxI10YMKNR?=
 =?us-ascii?Q?TCwE4J2z+aZqWHAz61JaW4b6MG0TTbGX0xB8LpT24eLW9nx/4GK0zQbm9Q9J?=
 =?us-ascii?Q?3ybhDqVGIAxVYj0is8issk2WBUxGHMKhkpjJS4emNDGzFA9Gyeec+zti6EQy?=
 =?us-ascii?Q?ODQd7tEOO3wSmFLMfTXD6FjC/hjf6NA8MCcxTRsPirAN9gIAg/vRLm8eXbFQ?=
 =?us-ascii?Q?d4tQ9FALy8j5GQgMqSOgjHuDbVl4ypLHaoSu2qmKv7yZeyXBesymOnDAkWDN?=
 =?us-ascii?Q?+oAxuZ64fcEspNiN6xdsmXO3GLGODh5HD36Ia56AlUwMcdnzOhgGmZj+KUtJ?=
 =?us-ascii?Q?gq59YKmVQrs7GLWHuirriT0+e0NN3psVOV3cGK6ygm5M2kd8AqG9VzE1qLjn?=
 =?us-ascii?Q?Isf/+V8gp4NKSYs4y4P+aWXdnAsA9iR4bafj0SqybUnNYXHT21uLi6u+1j70?=
 =?us-ascii?Q?e6+ReUPNwcvcmOjtt/h7s1+ODPjYKmiA4HabJ3ZUMrWbL7wa+asXyGnmabHO?=
 =?us-ascii?Q?Xs72/s+SGzCLqTXolMrO+DqgYILyqRTRomvbNYJJ31E8X89AFrDIS7U0gnSL?=
 =?us-ascii?Q?D11vUjRj7t2uoX3fwvMv4jPjpj95ion1UIsc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 07:55:23.3433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edbe7714-72f5-4e49-c8d0-08dd9f4f5511
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420
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

It needs to validate the userq object virtual address whether
it is validated in vm mapping.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 56 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 25 +++++++++-
 3 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index f45585bd5872..32e88064bdea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -44,6 +44,41 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 	return userq_ip_mask;
 }
 
+int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
+			 u64 expected_size)
+{
+	struct amdgpu_bo_va_mapping *mapping;
+	u64 user_addr;
+	u64 size;
+	int r;
+
+	addr &= AMDGPU_GMC_HOLE_MASK;
+	user_addr = ALIGN_DOWN(addr >> AMDGPU_GPU_PAGE_SHIFT, 0x100);
+	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
+
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
+
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
+	if (!mapping)
+		goto out_err;
+
+	if (user_addr != mapping->start ||
+	    (size != 0 && user_addr + size - 1 != mapping->last)) {
+		pr_debug("expected size 0x%llx not equal to mapping addr 0x%llx size 0x%llx\n",
+			expected_size, mapping->start << AMDGPU_GPU_PAGE_SHIFT,
+			(mapping->last - mapping->start + 1) << AMDGPU_GPU_PAGE_SHIFT);
+		goto out_err;
+	}
+	amdgpu_bo_unreserve(vm->root.bo);
+	return 0;
+
+out_err:
+	amdgpu_bo_unreserve(vm->root.bo);
+	return -EINVAL;
+}
+
 static int
 amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
@@ -394,6 +429,17 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		r = -EINVAL;
 		goto unlock;
 	}
+	/* Validate the userq virtual address.
+	 * TODO: Need to firgure out why the queue_size(args->in.queue_size)) doesn't match
+	 * with mesa request size. As a workaround there fix the queue_size to the 0x200000.
+	 */
+	if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue_va, 0x200000) ||
+			amdgpu_userq_input_va_validate(&fpriv->vm, args->in.rptr_va, PAGE_SIZE) ||
+			amdgpu_userq_input_va_validate(&fpriv->vm, args->in.wptr_va, PAGE_SIZE)) {
+		drm_file_err(uq_mgr->file, "Usermode queue input virt address is invalidated\n");
+		r = -EINVAL;
+		goto unlock;
+	}
 
 	queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
 	if (!queue) {
@@ -504,11 +550,17 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 		}
 
 		if (args->in.queue_va == AMDGPU_BO_INVALID_OFFSET ||
-				args->in.queue_size == 0) {
+				args->in.queue_size == 0 ||
+				!access_ok(u64_to_user_ptr(args->in.queue_va & AMDGPU_GMC_HOLE_MASK),
+					args->in.queue_size)) {
 			drm_file_err(filp, "invalidate userq queue va or size\n");
 			return -EINVAL;
 		}
-		if (!args->in.wptr_va || !args->in.rptr_va) {
+		if (!args->in.wptr_va || !args->in.rptr_va ||
+			!access_ok(u64_to_user_ptr(args->in.wptr_va & AMDGPU_GMC_HOLE_MASK),
+						sizeof(uint64_t)) ||
+			!access_ok(u64_to_user_ptr(args->in.rptr_va & AMDGPU_GMC_HOLE_MASK),
+						sizeof(uint64_t))) {
 			drm_file_err(filp, "invalidate userq queue rptr or wptr\n");
 			return -EINVAL;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index ec040c2fd6c9..375fba639c94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -132,4 +132,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
 
+int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
+					u64 expected_size);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index b46e67b179fc..4ba064e6dda0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -28,6 +28,7 @@
 
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
+#define MQD_SHADOW_BASE_SIZE      73728
 
 static int
 mes_userq_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
@@ -246,6 +247,19 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			r = -ENOMEM;
 			goto free_mqd;
 		}
+		/*
+		 * EOP VA size = MEC_HPD_SIZE * adev->gfx.num_compute_rings.
+		 * Since the userq support newer than gfx10, so the keep MEC_HPD_SIZE as 2048.
+		 * TODO: It requires figuring out why the EOP VA not match with MEC_HPD_SIZE *
+		 * adev->gfx.num_compute_rings.
+		 */
+		if (amdgpu_userq_input_va_validate(queue->vm, compute_mqd->eop_va,
+						/*ALIGN(2048 * adev->gfx.num_compute_rings, PAGE_SIZE)*/
+						0x200000)) {
+			drm_file_err(uq_mgr->file, "EOP VA is invalidated\n");
+			r = -EINVAL;
+			goto free_mqd;
+		}
 
 		userq_props->eop_gpu_addr = compute_mqd->eop_va;
 		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
@@ -274,6 +288,15 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		userq_props->csa_addr = mqd_gfx_v11->csa_va;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
+
+		/* TODO: Need to check the shadow WA size doesn't match with mesa request.*/
+		if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11->shadow_va,
+					0x200000)) {
+			drm_file_err(uq_mgr->file, "shadow VA is invalidated\n");
+			r = -EINVAL;
+			goto free_mqd;
+		}
+
 		kfree(mqd_gfx_v11);
 	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
 		struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
@@ -290,7 +313,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			r = -ENOMEM;
 			goto free_mqd;
 		}
-
+		/* TODO: validate the csa and check the va size as well.*/
 		userq_props->csa_addr = mqd_sdma_v11->csa_va;
 		kfree(mqd_sdma_v11);
 	}
-- 
2.34.1

