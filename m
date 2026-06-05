Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76665CD6E74
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 10:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 163BF11A70F;
	Fri,  5 Jun 2026 10:32:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WG7GnqKX";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010063.outbound.protection.outlook.com [52.101.56.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDCD311A70F
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 10:32:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsc/HByeAjj2lszwLYua61dL2o+9dngJ89wvOZ3DIPwzricZwNmwacNm1kF0wUQAwJpcanvzG95yzXHVii6e6qO08Ce9fVPsRw/KMxpI6CCoUY3yA8lJW/2/HvivXSN7WVbXe+r9AqLkcuo/S0ztokREx95IYkqFydMVe7GCXL4AT6oYv08he7Lu83HF/yI5c2DSLebSkOXSIONQO2iolQILCDPageC07mdGJrlDzOuQOSBeFzBVuchxBL1p5I6Ddwt8yEgCiK10nzVXAX6sFTfYjZowRaFtomIyJGOiYmp7ZuidZZx5gB0DA7j5x+8kGnFucjimYw70UorM2194CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCn8UUWblvdNMhIigu9D/E7j4RSbzOvoeB5fm+vQ1yg=;
 b=mZzgdcUZzj7ZY1n7CZdEOP7XC4vT4k1mkRMqIxQExt0br1uT3Z2jM2/DFRuctJ0TYRSvj2cggkfFd4nA35L+LOM2roW/C+IFg/VZHpsVrSjMd6nAWmA56Zd9f/wn77F2Rda88esjZT/CISFg3auegwlYJEE0cf+1z1yBxJpw0zgsZLuJX7HvmaFNiWcoi70JwcRI3Z1913T3yew4GfsZnS7RAV7ScNQfsF+krrd2BUFasJy3oa1OKztuoa0ah2WuDUizfnSMWCQ5JwuJsr8ZaE06d3EgcKtsjZqa6aa0IG56xE67uNC/Jd9y2B6WJReLQj5M5lonmXBEN8hHX65bOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCn8UUWblvdNMhIigu9D/E7j4RSbzOvoeB5fm+vQ1yg=;
 b=WG7GnqKXa0o7Bfao8Jkria6jbWbIqYXQOWIUHuNtifG+Bjjxc++/crW32O4oBeL2JPezkr7JSN+Q721E1IjPPBf5pgFnej3ZX/h4ySkwjoPETrgVZJLS/FPigGZ9Wn9KpG1S8353TlpL0K1rEkI6drTL6ngwg6maQ2mFZBuz9Fo=
Received: from DSSP220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:3d3::6) by
 MN0PR12MB5834.namprd12.prod.outlook.com (2603:10b6:208:379::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 10:32:12 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:8:3d3:cafe::5a) by DSSP220CA0003.outlook.office365.com
 (2603:10b6:8:3d3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 10:32:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 10:32:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 05:32:12 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 05:32:11 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 5 Jun 2026 05:32:05 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 4/6] drm/amdgpu/userq: identify guilty user queue from
 priv-fault IRQ
Date: Fri, 5 Jun 2026 18:30:50 +0800
Message-ID: <20260605103144.2537331-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260605103144.2537331-1-Jesse.Zhang@amd.com>
References: <20260605103144.2537331-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|MN0PR12MB5834:EE_
X-MS-Office365-Filtering-Correlation-Id: ba3d9caa-ec46-4397-e094-08dec2edb468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cAxJ4+WHjHjMya36fCYpIpIVTA0bpaa/bm6Q3Q3ZfGrKlVIveW6PmSiTX4xRRtsZSKyBd0IytOtAEYX560eP5jNZdcQfzQwfSRXZGwwm7Nop9mldqVHCWjQayCT+V4HNCc+ubnD/1ooNBr8u25t1Bk/pEQ0314xsV0o2Hwu0e8blTHG9JXwGY/1xSTL/2fP/IaQlZ9CIR06ATnKsia3kvZROeYdtT1uVzeHKfBnXCmQZAK9DfoXXOrO2/YhvW+mwQ9RLwK+kd8EsReeooLjDH3KiY60KgyTHPKFCWqMSXXxcONSThNkOr8glFSCc6cysXLfELY3ZmWuoCX188EIKNJhK18NRSExjHaGpduKJzJTTIWAA2dX1In6fyQRD2GRi4amWq2I1CBh+w5PxYH86NkOSMYhYia1Ba4riLiQfOrLvwV1ciOave2aTgFJzXqmoJ0qBAI5CBXMZqV3o8K7xEbHcG/jdoHrfktbHV/L3A8lqx5hVW3btEIP4dWp+b0ukjwqS9HlO3v8dzhS8u0tF4rrqQCEOUkmOco9EO5Pi2NebijShk05SJdN0IexR9Iok7ZN5hy+tXxlabHgYelNNGd7cmgYpbAR7UaFKj/VS/xCetGBx2SKUJ5PYy8dz4qBWZxlO3N6KGsD0tCJ+zjnDJ72Tb8NQ+1MtZ8/x0qB1v8ztADT54Vcs5xkqXACgStp+enqQD8Jbgk7nTIuJevIo/BtIb2Igew676NvZmLg2X24=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hEz7/mg6axhQOWIINrzs+N9cQD3nKOMnW0jmihUst3kmbIsEaavPZIsGFuSGHH0xGxYrcef/Op0e/Z7eM24YpzO6nLGqKuUBUbG5YIZkc9SbqpYFV6Qrt/NpPSPG3bQfN7kATaJdJCNX61g+iAwSnMgbFqWvwkJef07NGHIsssu3iSPrIZABW3NFSScQUsTo/amzxTzLTt6ZK3CbAK4WnPprJxDtxp6GQgi+0HlZpsnq2D6Lm//J8nZ9kr0ukOiSEiKkQ75ccAjfyTc+V+O3C9jUrDdtMiT0NKDyQ4R208aGUW2ffrppTtXaFw0K2FBcKXBlqWFjHEzersUyPYu1+nmypEsHdALDKE/5nBnE62W4+Y46Lr1nruYMPwKNL7ollILksvI3S0TqIKbvvemVu/zwF2Vy624TipW4iUgHHa6w6qnK6Q4LVqVws8ylrU/x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 10:32:12.2359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3d9caa-ec46-4397-e094-08dec2edb468
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5834
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

CP priv-fault IRQ carries the offending queue's per-process
doorbell_id in src_data[0][9:0] (same encoding KFD extracts via
KFD_CTXID0_DOORBELL_ID_MASK), with pasid in entry->pasid. The
existing lookup against BAR-absolute doorbell_index never matches
this payload, so the targeted-reset path is never taken.

Cache args->in.doorbell_offset on the queue and look it up by the
(vm->pasid, doorbell_offset) pair. Add a queue->guilty flag set by
the IRQ and consumed via xchg in hang_detect_work; on a hit, route
compute reset through amdgpu_gfx_reset_mes_compute(..., queue, ...)
and fire hang_detect immediately via mod_delayed_work(..., 0)
(queue_delayed_work() is a no-op when the work is already armed at
submit time).

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 37 ++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  5 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    | 10 ++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c    | 10 ++++--
 4 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 99c5adf3cb24..231ffb29fe5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -140,9 +140,14 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 						 AMDGPU_RESET_TYPE_PER_QUEUE)) {
 		int r;
 
-		if (queue->queue_type == AMDGPU_HW_IP_COMPUTE)
-			r = amdgpu_gfx_reset_mes_compute(adev, NULL, NULL, NULL, NULL, NULL);
-		else
+		if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
+			struct amdgpu_usermode_queue *guilty_uq;
+
+			/* IRQ-side WRITE_ONCE(guilty,true) hand-off via xchg */
+			guilty_uq = xchg(&queue->guilty, false) ? queue : NULL;
+			r = amdgpu_gfx_reset_mes_compute(adev, NULL, NULL,
+							 guilty_uq, NULL, NULL);
+		} else
 			r = userq_funcs->reset(queue);
 		if (r)
 			gpu_reset = true;
@@ -671,6 +676,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 
 	queue->doorbell_index = index;
+	queue->doorbell_offset = (u32)args->in.doorbell_offset;
 	r = uq_funcs->mqd_create(queue, &args->in);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to create Queue\n");
@@ -1111,16 +1117,31 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
 	dma_fence_put(ev_fence);
 }
 
-void amdgpu_userq_process_reset_irq(struct amdgpu_device *adev, u32 doorbell)
+void amdgpu_userq_process_reset_irq(struct amdgpu_device *adev,
+				    u32 pasid, u32 doorbell_offset)
 {
 	struct xarray *xa = &adev->userq_doorbell_xa;
 	struct amdgpu_usermode_queue *queue;
-	unsigned long flags;
+	unsigned long flags, idx;
 
+	/*
+	 * CP priv-fault payload is (pasid, src_data[0] & 0x3ff) — the same
+	 * per-process doorbell encoding KFD extracts via
+	 * KFD_CTXID0_DOORBELL_ID_MASK. Find the offending queue by the
+	 * (vm->pasid, doorbell_offset) pair, mark it guilty and fire
+	 * hang_detect immediately (queue_delayed_work() would no-op if the
+	 * work is already armed at submit time).
+	 */
 	xa_lock_irqsave(xa, flags);
-	queue = xa_load(xa, doorbell);
-	if (queue)
-		amdgpu_userq_start_hang_detect_work(queue);
+	xa_for_each(xa, idx, queue) {
+		if (queue->vm && queue->vm->pasid == pasid &&
+		    queue->doorbell_offset == doorbell_offset) {
+			WRITE_ONCE(queue->guilty, true);
+			mod_delayed_work(adev->reset_domain->wq,
+					 &queue->hang_detect_work, 0);
+			break;
+		}
+	}
 	xa_unlock_irqrestore(xa, flags);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 5a2ae33135da..1e765cd765ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -53,6 +53,7 @@ struct amdgpu_usermode_queue {
 	enum amdgpu_userq_state state;
 	uint64_t		doorbell_handle;
 	uint64_t		doorbell_index;
+	u32			doorbell_offset;
 	uint64_t		flags;
 	struct amdgpu_mqd_prop	*userq_prop;
 	struct amdgpu_userq_mgr *userq_mgr;
@@ -86,6 +87,7 @@ struct amdgpu_usermode_queue {
 	 * Delayed work which runs when userq_fences time out.
 	 */
 	struct delayed_work	hang_detect_work;
+	bool			guilty;
 	struct kref		refcount;
 
 	union {
@@ -175,7 +177,8 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
 int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
 void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue);
 void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell);
-void amdgpu_userq_process_reset_irq(struct amdgpu_device *adev, u32 doorbell);
+void amdgpu_userq_process_reset_irq(struct amdgpu_device *adev,
+				    u32 pasid, u32 doorbell_offset);
 
 int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 				   struct amdgpu_usermode_queue *queue,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ea323d241324..27d0a3dbfce8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6681,10 +6681,16 @@ static int gfx_v11_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
 					struct amdgpu_iv_entry *entry)
 {
-	u32 doorbell_offset = entry->src_data[0];
+	/*
+	 * CP packs the per-process doorbell_id in src_data[0][9:0]; upper
+	 * bits hold other CTXID0 fields. Same mask KFD uses
+	 * (KFD_CTXID0_DOORBELL_ID_MASK).
+	 */
+	u32 doorbell_offset = entry->src_data[0] & 0x3ff;
 
 	if (adev->enable_mes && doorbell_offset) {
-		amdgpu_userq_process_reset_irq(adev, doorbell_offset);
+		amdgpu_userq_process_reset_irq(adev, entry->pasid,
+					       doorbell_offset);
 	} else if (!adev->gfx.disable_kq) {
 		u8 me_id = (entry->ring_id & 0x0c) >> 2;
 		u8 pipe_id = (entry->ring_id & 0x03) >> 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index b3f1bbf3fc13..7c269cb75e07 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5009,10 +5009,16 @@ static int gfx_v12_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
 					struct amdgpu_iv_entry *entry)
 {
-	u32 doorbell_offset = entry->src_data[0];
+	/*
+	 * CP packs the per-process doorbell_id in src_data[0][9:0]; upper
+	 * bits hold other CTXID0 fields. Same mask KFD uses
+	 * (KFD_CTXID0_DOORBELL_ID_MASK).
+	 */
+	u32 doorbell_offset = entry->src_data[0] & 0x3ff;
 
 	if (adev->enable_mes && doorbell_offset) {
-		amdgpu_userq_process_reset_irq(adev, doorbell_offset);
+		amdgpu_userq_process_reset_irq(adev, entry->pasid,
+					       doorbell_offset);
 	} else if (!adev->gfx.disable_kq) {
 		u8 me_id, pipe_id, queue_id;
 		struct amdgpu_ring *ring;
-- 
2.49.0

