Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542ACCD98C6
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 03:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F31A10EC7C;
	Thu, 11 Jun 2026 03:58:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fNQ6Tw2w";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4095210EC7C
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 03:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3efBXV+4p/B4KO5yVHu91PQC0+EDuhzw2VZ//oqAHpOR+yE36EjGjLA6f+Evc8QFRBS/u3jXtpPFj1Ku7wJeHP52Wwd1cxf6Z5UBw8WCc3bIZLIsoJYTjNkKBynyzlcNVsplgDyN4QBxCvL9M+4SiIZ3ow6UbUc4h6g1YQKWtA8juiBj6DZnTOSK3dW21mj4QHIkycL0yIhkFquDhSpVmr3AVIjE+xXiC76aFpf9IcAf1La0lRfw5QsIEJuQew58ulaTzg2Wm+IX4ck4hadi05E0f7IqfZtqwyQwSISIsw08lG5Evs9TBP6Y6ZKy/TbBjLUH/NgmG3ngMgBCKZPvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fyl9TLiyaO6dG2YTMpRR5AS8tWMEznOddlLuDZwJFOc=;
 b=UNnakta6zkQdqHsRjiPWEr9PmVjrzL9Ot/2U+8Cc4AvHWypn7MR+/qHZE3+S+sYamrhB+8d//xHJARqL/3AjEqf3HHm00iuXBpf//80eQHy9NseRbQ8MGb4leBCfC3ZpTQlvVmab9EfRVX1YW/xHFxLzyTYxNZHf9VLqtpcHlPdJKBsDlfapRhQVMYGHDFdw8VzfeCGoGqh6Tbp8L2StmG6t3O2xdLUlpxpJmtSHnfETOhSfgPd23uwvk2SnPbYNtjQs6oWGHYt8BaKknOKSBGGYZSx2nPzSO1vTDpPXhQv8tQlQaJW0SDc6/fmfcWo5NpBroPeJRw50NBPlmFez2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fyl9TLiyaO6dG2YTMpRR5AS8tWMEznOddlLuDZwJFOc=;
 b=fNQ6Tw2wMxrn+Y2+atyYjn6dRZOLbyIUh0iF7z2cqxeRWRpe8gIBGcUw3ltJonwVVpPrdC/2kIO26hqQMrBwPUH7MIvuNJxG5EjEGyBMsGNB+owLzP7EzN7EL6SHOPyrHN8VvHwyof51wurh93KdvvWtm1Dn6wd0npO6ddOTqaY=
Received: from IA1P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::7)
 by IA0PR12MB8278.namprd12.prod.outlook.com (2603:10b6:208:3dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 03:57:56 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:461:cafe::90) by IA1P220CA0010.outlook.office365.com
 (2603:10b6:208:461::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Thu,
 11 Jun 2026 03:57:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 03:57:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 22:57:54 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 20:57:54 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 22:57:48 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 1/7] drm/amdgpu/userq: add reset helper and identify guilty
 user queue
Date: Thu, 11 Jun 2026 11:57:28 +0800
Message-ID: <20260611035747.548780-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|IA0PR12MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: e708716b-1ffe-4087-010c-08dec76d9e34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 7oN+deILYWqXLMAzm+DQMlga+x1BG81sJ7fLrlUhBc/IKcIUBkl40V4CTfTSXvQfk0hxoH/qdv6tLqsQNLzfWM/3H7VGEhs50v8sbrpkdVvNm3UCSIClGhatEfQku4vDespEUGl8ChEF5NtNL6BVmH8JhauQTN6D9sBJ5E/E6m13b7BqKL6sm87vxkmsIbIauVg/tM5DvbpW8ZETaZm+84f4LJQyxfxhhyw+3vCP/x7oJf4yjftz+b2b8pJ6qkWgJ+CJ5Fpv1bexb9V0iaSq272D5Im1Kw5PSoGwXv02IJGAhglfCb8qjMORdUsQiPMUoBYVBsjHg+ym3pYsEF9yrciuxlEs3h3ttm+WHhX06wsdrkdgOHqdloZZamFI9aFpqiYZ8BTwQ/tXRB3Fa9EIjJ7ZBidPuSFwJdESdkvVI1j/4RpV4X39lWo1YqYh7UrbfPbScUMJrKBrrXx47jDWz7VzECKy01trcz8YtP0Lk8/n3ljCE/rtheVruSLtdhPB+yYzDAwLxQ3S8pPSSQzL+bdJzcHijcc+jmfGEhp7pSVbLi3XVGt1+utvfz21Igu+U8U5sgbKkaZkfLmoW8o3SJ2YIvvGSBnqLLhQg/q60VfNQf/DZ92FvcjJ4DrczLn0zK4RRQubE+XvoTb1msbwk0ix7khLnNwRSBAIQnB/LshTTXMqirls049j3dj998BHTORwjmXAQiQxGAc2Yi3d5FZOeZKJpc4vL6DUEVzVXL8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G/J9WwljIReOYZaI7UlZ6zqdIiK6affmSxnvyCzLx6Z1umiwvgKy4qMFZlckfD6echFgJR4zD952LHHHWK7XOYhdxqctacFSSc69T6Gpbgro6XCMFewvU3J5pie8aGxeaki38eNCz+RxdRISkW9OMdHT6yfYgY4t65CVyUy592y+E3L/0QbMWayWdV09MUN894aEn3UPwwR3dSuS+PJr7+8uMgBIN9w9saEP5uE0BOIGV2r9hMgXPzqj7/hplf+BEao0yCHrX7HaN92YqOXoM+dTsOmAKeCnuXRK6a13w5nl69rBGv0yZtFE4rXslPvpM3bGtq0GuNDTNQDI5Qvxz3B9nbExoIiZhnU22rTwY0MEfArG5OPkwZ9Wx4qXisO4yPAZzfrfs7yALWV/zWc1ppzISSLYW1uDrKmhEr+/naRULWGp8No1VrCmc/iaaTHc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 03:57:55.2328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e708716b-1ffe-4087-010c-08dec76d9e34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8278
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

From: Alex Deucher <alexander.deucher@amd.com>

If we get an interrupt for a bad user queue (bad opcode, etc.), add
a helper to handle the reset for user queues.

v2: squash in fixes

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Co-developed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 40 +++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 12 +++++++
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index de6848b4fd67..231ffb29fe5e 100644
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
@@ -1111,6 +1117,34 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
 	dma_fence_put(ev_fence);
 }
 
+void amdgpu_userq_process_reset_irq(struct amdgpu_device *adev,
+				    u32 pasid, u32 doorbell_offset)
+{
+	struct xarray *xa = &adev->userq_doorbell_xa;
+	struct amdgpu_usermode_queue *queue;
+	unsigned long flags, idx;
+
+	/*
+	 * CP priv-fault payload is (pasid, src_data[0] & 0x3ff) — the same
+	 * per-process doorbell encoding KFD extracts via
+	 * KFD_CTXID0_DOORBELL_ID_MASK. Find the offending queue by the
+	 * (vm->pasid, doorbell_offset) pair, mark it guilty and fire
+	 * hang_detect immediately (queue_delayed_work() would no-op if the
+	 * work is already armed at submit time).
+	 */
+	xa_lock_irqsave(xa, flags);
+	xa_for_each(xa, idx, queue) {
+		if (queue->vm && queue->vm->pasid == pasid &&
+		    queue->doorbell_offset == doorbell_offset) {
+			WRITE_ONCE(queue->guilty, true);
+			mod_delayed_work(adev->reset_domain->wq,
+					 &queue->hang_detect_work, 0);
+			break;
+		}
+	}
+	xa_unlock_irqrestore(xa, flags);
+}
+
 static int
 amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 9df1b78407f5..a55d57e2c169 100644
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
@@ -176,6 +178,16 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
 void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue);
 void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell);
 
+/*
+ * CP packs the per-process doorbell_id of the queue in
+ * CTXID0[9:0] on priv-fault (same encoding KFD uses via
+ * KFD_CTXID0_DOORBELL_ID_MASK)
+ */
+#define AMDGPU_CTXID0_DOORBELL_ID_MASK	0x3ff
+
+void amdgpu_userq_process_reset_irq(struct amdgpu_device *adev,
+				    u32 pasid, u32 doorbell_offset);
+
 int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 				   struct amdgpu_usermode_queue *queue,
 				   u64 addr, u64 expected_size, u64 *va_out);
-- 
2.49.0

