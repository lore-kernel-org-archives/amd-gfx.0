Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99533C7115B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 09:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 023A210E348;
	Mon, 23 Jun 2025 09:52:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KaQPhLTe";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A2E310E346
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 09:52:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/geMka6CuX6iXZ5l8oI7cR9grvQCc7Shv7SX+qqgLJtHjaiSzzzdsYuPV8XjrbJbK3grMq9Yaw8r/AdQFwvapeMqMsTEv7Fm8FclOWrliejLeH3WwXWl6VAfqDC0fpBpCZw6xycM6aqTuUbLhOUNIpEbSSZvqUXvbXarsZg7qeGUyJ/MY3etwzBxoZC3Rc0I66clT43i94e9NTt/x8pZGpm92tpLsM1wv5i7o9hLNaOtoc4cjBOr3dQPke9ha3V/v7hdEmo1AFeZoevlK4Pf2XEeuORcJTbKEZHVJvc1HMBzTvpwSjFXAPvhJY8FPIevqzm7LoL6ZGyj7L9MOpSLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59S9ixdXW/Dxb5g5/9cbigoMY9nEbcoAwR/JYk/Z0zI=;
 b=AVr5zLmrQQO4eIL8IcKqONoJ9QTP2o5VoPPf7w+thRYxga8QCa7XbtVYVPmWSdLW1rm659huQ0hkFOqutbT1GAcuvmsVfa2xCymKCvinSdZwrE/EtC9AW15reDEcCLhwtMZgSyo35CJPHL2NlZFFlsadDQGcgnCrEEF+1wd78r41uy9O3VPJmSXMBrBFDn6B4K5/6E6hhK8boKpKyWvzmmB31LLm1EtW+8Cz5dg2bVncMSoX8lUZQFIWt4X0O0FQ/2uGqHIlmkSEJ8zdTdbBrBpKZFV2YxR7zVSMXT/85WC0PF1ZbUFd6lQbYmiRLPvIqJWyIp7fAg2QjCCK5k/tlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59S9ixdXW/Dxb5g5/9cbigoMY9nEbcoAwR/JYk/Z0zI=;
 b=KaQPhLTepxCOkRM7ss7Iz0cQ8GwYD1iC2y7G8sOLBQ0hm7EiiegpeyHM0FBVBzThp/jVtXlEuOwlTYhqtKHqGNSeao6CJULVh76Jcc/GtAvufW9V9qNVtCxfoOh+PsKEPjHVj+GOXcQDNMCEr+7e4Ysqw3pruuzQ8fAp97M1lcg=
Received: from DM6PR02CA0071.namprd02.prod.outlook.com (2603:10b6:5:177::48)
 by IA0PPF864563BFB.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Mon, 23 Jun
 2025 09:52:12 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:177:cafe::f7) by DM6PR02CA0071.outlook.office365.com
 (2603:10b6:5:177::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Mon,
 23 Jun 2025 09:52:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 09:52:12 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 04:52:10 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v3 05/11] drm/amdgpu: add userq object va track helpers
Date: Mon, 23 Jun 2025 17:51:48 +0800
Message-ID: <20250623095154.1150830-5-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623095154.1150830-1-Prike.Liang@amd.com>
References: <20250623095154.1150830-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|IA0PPF864563BFB:EE_
X-MS-Office365-Filtering-Correlation-Id: 41fa1f20-8d5f-4a2a-2031-08ddb23ba0a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PZWH8DL4/jhz2+g/j8ggS9pTBW5rkJkNPTwGp2ZtqbK4hZreA/TmDyf1OCzS?=
 =?us-ascii?Q?z9pz3lWfOjgUFUCR9YQU3wKfSckas/oxAGX7P57/o6sq+tGWqXWzb/U1n0It?=
 =?us-ascii?Q?o1BjBdtB248Pcxc5xv3jFYsWJIHwXCcO/tim5jrZsVCXAqW1tAfx9c+sBMkk?=
 =?us-ascii?Q?TUhdH88C3OZ4t4sQlRnuloZZZMtVA669ipImjDKOZYUChsxz+5lYHPU22nmx?=
 =?us-ascii?Q?+gsi2QudLn+CeNjASXpvKVeMkM63UBSO0axX5YA5kaqM0pSWRk5hNgazWdpX?=
 =?us-ascii?Q?HGJDlJgGqvU3kO2ueBMYW4PJWokrMWs4TE5pxBa8osqwU+Lq40yCO8fIABf9?=
 =?us-ascii?Q?zYnN2wRmkZptCau/QJaj0R6uweMFgs+HgCKeYH/s6G8dJsKg0xJGqKrW4mzP?=
 =?us-ascii?Q?dP5/r1k98IE0it5p7t4SupXJiU9HOcriRDMIgcDzQL6K9Ll5Hzj1YgAKKxXw?=
 =?us-ascii?Q?7ARpmKEYBKROkQMmuBy2V8HZmRN2kGlF8q9azQsRiQ7n0fWLcnkFC6yBRTPT?=
 =?us-ascii?Q?fdXXu/XNEaIAo7BOjSENjgv2faO51YfA7EVQlEdvf+zOyx9HyVof0TLg/mgN?=
 =?us-ascii?Q?pAs9CLUjj4kAbXVA5AnBs9aqjqGfjusEbUt+gFjxDXP4nBRD9F2H54+8Bqcw?=
 =?us-ascii?Q?sE20ggpceRRTc6p3cSV4Oe1bg+Qo2F+fPNqm8xrzmCMWezkuUJe6s++0FiEn?=
 =?us-ascii?Q?LzX65wNWqhh8yP8UY+EhwpPrDPGNQP7WNC1ZThUZvQ8Nw6HD9uR7D0periT+?=
 =?us-ascii?Q?lZ2z/gYLqoZgK44HclE3rZSvOfEdODcfmf1FKvhaCySCVbP6aoJh1HZ48o59?=
 =?us-ascii?Q?F66GRJtv+LvPlS72F04kOLKOI0U1lFbRBBEtCsdipNbpsOJBywdeStp+7vPN?=
 =?us-ascii?Q?TiUInaFZCeIuPxR2EvevrTq0GZPsgfOpsNr8BoizPC7bgN0J6hQ1kaxwtCq5?=
 =?us-ascii?Q?x8Pj0DW1cjHTUnBdiOAi3nm9RJH+edM4zxju3QMOvXzjoD0IkvSagOzfhZjO?=
 =?us-ascii?Q?E1mUoOBaM6ShRSruWsoj+ZtErOsnpJ2HNujgt8G2xQjz9SIG64XS7dGbCbFl?=
 =?us-ascii?Q?OFqTsJKgq3fvErLHZL3TyHvuofNT4wXZ+OGzkCXs7LhAsWKeHftVAVC1qLfN?=
 =?us-ascii?Q?6qT3gjfF01YbX9YefZoUSFbDpsW0rhcEfePQ2yB4D6wxzhRC6qa38ChlvG6v?=
 =?us-ascii?Q?46QCISNFTnaOrYdd0rn/WbSrxlqcgsNWOEqtbt+yks/r+cadQThK+uiCwCh6?=
 =?us-ascii?Q?jbwDgClVN90NocYePMyHN/BFqZi7TESNMtiDyzdCQdp8yjjpF1EeX0DGI4QC?=
 =?us-ascii?Q?HdPAH2aPBXwkt65enRTPNvAIO4oEuPSM/YVt26qnBCTL4aQuoh31Fs7OlPUD?=
 =?us-ascii?Q?RhLuTpWDNQ9Due43bruphCJboQaQUWJC5nrByCSF1oFzVMbbpDNMF251CA/l?=
 =?us-ascii?Q?Uu0SQarPm9nkx3Fc1+iqa/1S8e5qr/haDTCd2cb5G8D6WGJPpkBhR3XSnij+?=
 =?us-ascii?Q?lmCKPAFTiDabkmBx0dZT1XmlcMXGwr8ttiE5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 09:52:12.3943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41fa1f20-8d5f-4a2a-2031-08ddb23ba0a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF864563BFB
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

Add the userq object virtual address get(),mapped() and put()
helpers for tracking the userq obj va address usage.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 132 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  14 +++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |   4 +
 3 files changed, 149 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index a20f7ccbe98e..cbbd1860a69a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -76,6 +76,134 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
 	return -EINVAL;
 }
 
+int amdgpu_userq_buffer_va_get(struct amdgpu_vm *vm, u64 addr)
+{
+	struct amdgpu_bo_va_mapping *mapping;
+	u64 user_addr;
+	int r;
+
+	user_addr = amdgpu_userq_va_align(addr);
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
+
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
+	if (!mapping)
+		goto out_err;
+
+	/*
+	 * Need to unify the following userq va reference.
+	 *  mqd  bo
+	 *  rptr bo
+	 *  wptr bo
+	 *  eop  bo
+	 *  doorbell bo
+	 */
+	/*amdgpu_bo_ref(mapping->bo_va->base.bo);*/
+	mapping->bo_va->queue_refcount++;
+
+	amdgpu_bo_unreserve(vm->root.bo);
+	return 0;
+
+out_err:
+	amdgpu_bo_unreserve(vm->root.bo);
+	return -EINVAL;
+}
+
+bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
+{
+	struct amdgpu_bo_va_mapping *mapping;
+	u64 user_addr;
+	bool r;
+
+	user_addr = amdgpu_userq_va_align(addr);
+
+	if (amdgpu_bo_reserve(vm->root.bo, false))
+		return false;
+
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
+	if (!IS_ERR_OR_NULL(mapping) && mapping->bo_va->queue_refcount > 0)
+		r = true;
+	else
+		r = false;
+	amdgpu_bo_unreserve(vm->root.bo);
+
+	return r;
+}
+
+bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
+			struct amdgpu_usermode_queue *queue)
+{
+
+	if (amdgpu_userq_buffer_va_mapped(vm, queue->queue_va) ||
+	    amdgpu_userq_buffer_va_mapped(vm, queue->rptr_va) ||
+	    amdgpu_userq_buffer_va_mapped(vm, queue->wptr_va) ||
+	    amdgpu_userq_buffer_va_mapped(vm, queue->eop_va) ||
+	    amdgpu_userq_buffer_va_mapped(vm, queue->shadow_va) ||
+	    amdgpu_userq_buffer_va_mapped(vm, queue->csa_va))
+		return true;
+	else
+		return false;
+}
+
+int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr)
+{
+	struct amdgpu_bo_va_mapping *mapping;
+	u64 user_addr;
+	int r;
+
+	user_addr = amdgpu_userq_va_align(addr);
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
+
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
+	if (!mapping)
+		goto out_err;
+	/*
+	 * If here refer to the userq VM BOs and keep the usage count by
+	 * amdgpu_bo_ref(mapping->bo_va->base.bo) at creating the userq IOCTL,
+	 * this reference and usage counter will be kept until amdgpu_userq_destroy(),
+	 * while the userq VA is unmapped at amdgpu_vm_bo_unmap(), which is ahead of
+	 * amdgpu_userq_destroy(). So, when amdgpu_vm_bo_unmap() tries to unmap the
+	 * userq VA mapping, it will result in an unmap error caused by the BO's reference.
+	 */
+	/*amdgpu_bo_unref(&mapping->bo_va->base.bo);*/
+
+	mapping->bo_va->queue_refcount--;
+
+	amdgpu_bo_unreserve(vm->root.bo);
+	return 0;
+
+out_err:
+	amdgpu_bo_unreserve(vm->root.bo);
+	return -EINVAL;
+}
+
+static void amdgpu_userq_buffer_vas_get(struct amdgpu_vm *vm,
+			struct amdgpu_usermode_queue *queue)
+{
+	amdgpu_userq_buffer_va_get(vm, queue->queue_va);
+	amdgpu_userq_buffer_va_get(vm, queue->rptr_va);
+	amdgpu_userq_buffer_va_get(vm, queue->wptr_va);
+	amdgpu_userq_buffer_va_get(vm, queue->eop_va);
+	amdgpu_userq_buffer_va_get(vm, queue->shadow_va);
+	amdgpu_userq_buffer_va_get(vm, queue->csa_va);
+}
+
+int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
+			struct amdgpu_usermode_queue *queue)
+{
+	amdgpu_userq_buffer_va_put(vm, queue->queue_va);
+	amdgpu_userq_buffer_va_put(vm, queue->rptr_va);
+	amdgpu_userq_buffer_va_put(vm, queue->wptr_va);
+	amdgpu_userq_buffer_va_put(vm, queue->eop_va);
+	amdgpu_userq_buffer_va_put(vm, queue->shadow_va);
+	amdgpu_userq_buffer_va_put(vm, queue->csa_va);
+
+	return 0;
+}
+
 static int
 amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
@@ -442,6 +570,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->queue_va = args->in.queue_va;
+	queue->rptr_va = args->in.rptr_va;
+	queue->wptr_va = args->in.wptr_va;
 
 	db_info.queue_type = queue->queue_type;
 	db_info.doorbell_handle = queue->doorbell_handle;
@@ -472,7 +603,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
-
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 704935ca0c36..194ec7a6b3b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -52,6 +52,13 @@ struct amdgpu_usermode_queue {
 	enum amdgpu_userq_state state;
 	uint64_t		doorbell_handle;
 	uint64_t		doorbell_index;
+	uint64_t		queue_va;
+	uint64_t		rptr_va;
+	uint64_t		wptr_va;
+	uint64_t		eop_va;
+	uint64_t		shadow_va;
+	uint64_t		csa_va;
+
 	uint64_t		flags;
 	struct amdgpu_mqd_prop	*userq_prop;
 	struct amdgpu_userq_mgr *userq_mgr;
@@ -134,4 +141,11 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 
 int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
 			u64 expected_size);
+int amdgpu_userq_buffer_va_get(struct amdgpu_vm *vm, u64 addr);
+bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr);
+bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
+			struct amdgpu_usermode_queue *queue);
+int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr);
+int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
+			struct amdgpu_usermode_queue *queue);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 32bb9c2689cb..77ce971576af 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -264,6 +264,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		userq_props->hqd_active = false;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
+		queue->eop_va = compute_mqd->eop_va;
 		kfree(compute_mqd);
 	} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
 		struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
@@ -285,6 +286,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		userq_props->csa_addr = mqd_gfx_v11->csa_va;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
+		queue->shadow_va = mqd_gfx_v11->shadow_va;
+		queue->csa_va = mqd_gfx_v11->csa_va;
 
 		if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11->shadow_va,
 					shadow_info->shadow_size)) {
@@ -318,6 +321,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		}
 
 		userq_props->csa_addr = mqd_sdma_v11->csa_va;
+		queue->csa_va = mqd_sdma_v11->csa_va;
 		kfree(mqd_sdma_v11);
 	}
 
-- 
2.34.1

