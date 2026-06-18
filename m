Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E10CD98F8
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 04:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99C6310EBED;
	Thu, 18 Jun 2026 04:44:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kpk4lTZ/";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013022.outbound.protection.outlook.com
 [40.107.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5958110EBED
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 04:44:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDU7Cm9QCgvhReXbYqc0CYPkqlVWLQTfWdxytJcPjDw8wbcj7S6nlCcUXE1io3yh4FBau6tG2GHdvtEWtrTmdFcuGY6rijV89s2XXuQ9bzGue+eogzg62Bgj8dGoQ7t37cbR0PNPa8JBs5EiuXz939qZiXdQ4VyxwODdcryO17Bf/gE1QiAGttfzX3PkXrpDFs4MtSiuuHtETEP2KmAi84Vs/Vmrot3VAcYJ4iUkaDTauq/KxmGGdhZSlQAooVcHUsULEYiCAtxTlPrJw9NIKbDPStqV+Ypol/eFW90qEwAY89kz6WtmjfIkh9MrDJIhwApkXRl29kzeERHFV8f8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZg7AQm5K3Qc//4YzlLBOUnAX9ecTCFJRB1Pi0Q73Dg=;
 b=X6K2Bu1brabE75nUP/yFECMBO928AtW5YJ+7uEadiSEjmJS2j2Id2zz6X9otOu9M3v9r3IQYr/or3xOEWmMnB8+nzrSBwv6W8NkLnpO41khulK50qZ2nioeQqDDlYl2Yxv4rtKK/7VOtwNGEDvqp2cASrhhclx5xa6fhHCqY9kmSBDAIPsII+nwAO8iXe2G7cXC+zwRhliCUR1FmZshvHJX7lpBSihl9tj5uCtIpudSIX9fBlQ9HSqa8PGwSaQGGwSQNLw9WSIimTeFbMjSyPG6Z3256Ft67kyyc8ZaKjaLi4uwUBwmiIvQ9DmZEr45BVm5N9e/hCFimAwQv6pl8kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZg7AQm5K3Qc//4YzlLBOUnAX9ecTCFJRB1Pi0Q73Dg=;
 b=kpk4lTZ/4glBDVTBc1OBO3c/Hmdbl5pzO1cx89yc/Z86FTrjqvccBR7uJgSs7g6bUqo3sUP693tgjeW/KxWGVE8fnOZCkWajYB9GdDnu55Ot//2XOoUWSv3G4FA1/Xxu+5906zUbA3r9Gn2NN4TAZA1RJWA9DrAkKLVtfhYkjiA=
Received: from BN9PR03CA0976.namprd03.prod.outlook.com (2603:10b6:408:109::21)
 by MN0PR12MB5812.namprd12.prod.outlook.com (2603:10b6:208:378::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 04:44:18 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:109:cafe::aa) by BN9PR03CA0976.outlook.office365.com
 (2603:10b6:408:109::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Thu,
 18 Jun 2026 04:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 04:44:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 23:44:18 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 17 Jun 2026 23:44:06 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v3 1/5] drm/amdgpu/userq: add reset helper and identify guilty
 user queue
Date: Thu, 18 Jun 2026 12:43:36 +0800
Message-ID: <20260618044405.1724370-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|MN0PR12MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: f8228b59-ed80-4d91-29ee-08deccf44215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 4XHSOA2guMGK9WJDd/6dg2TO+IsfyDS6hjdbLQJlAxqL5Uds+oswDFpMbqOS5pPxHVX9pFKKiXZlRC1CgxhqFTK+4Y4brmynp5FDkTe5YhKRpZHdYnkC6bcemOzU3XVAGLp8OqRmTI19rpcz3elX2QpWhfWRkkgmHrkN1NuzZc2JvtSMtduri6wNi/2XYe46Mr7m4R4/R8OjkUu4M+0ClIkRT0rGuvtTPv1tlXLPvF3yL1JCkYipNnc2EY8t3sMyMANa1VQBXsc4h29tDtLhjqrtc2fUmDBRHWPeA4ZlcvZ5YUyWBhtF4E7PMJ+ByOOZQ8xTxunQkYablS1tZCBF49oUxFeBM/GwnuW5Kz2QWYW017fvQNZfjE6L0J0UWxGTimOPPs/GvpQvMfeW5hIeEkL2CHRR+6JCLKRBLJ4ASZmv/frgkHShYqeJUCoaLcxd9Lw4JoMNZgto9O6OYVs/Sq5fnTlvWp4DVcrg1XuhOVrw79lMydp6zKXkSBv7/zlPaEuUe7qtHnAuix32JolOrA+n0svsNIH7Vs8irBQyckMiYNPuFxLkRcdoit08pRv0wHGMlGDiWW2pts4woHpUF4wzavYJpyGuJOXcilNf9tfjgspsIh+O27+eJMxi/FZvqihxFw5WUTVgBYLvm1lBe/kT7tDKndn8tet9YzXjuBtZI1A1QBZC/p+BGJ46tahiNJWwD/lp0JAPQX1rgy1ZeGzoaQjXlCacOiMiuuVZdbc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rKT4O5w9GQvIyglMJHr53J6NO3EDyx+W2xIeP76/hsonTXxns2kste2kdZ4Du+LMQaLqBHHGTwO2PzjkD2ZcBGNNicclWw+0CWB+BhPebdUudbqdfxogVC61Vpr7ux3nWCESGptW9oDZDzMGp+DREc0VDOWTN042VqE/UMF+Ymn6VN4k+Fg+40gGX3viNnD6/bxNUUlV3oBijBI1n1qxKjRBvyQjBWUg487Y0RNX9hk1iBLDF02Ql7JacVvWn06U0pQyzMdJO3t6m5fJwFDzfvh+ES0TCB6CBukz2seaKkoDIqj05c4+T/wPJiYBfHZzDntpQdmU8DU5OUliOgo3oYaZWKCbWkBLStubh8ANab6CLzpCZxLtD4k9bD1DRQs9SQClgpXdTba88tR93jJuv18zUyxMMrXl+uVO6b9KhGAYwnDg/PUOPG1ks2ES/INQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 04:44:18.5531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8228b59-ed80-4d91-29ee-08deccf44215
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5812
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

If we get an interrupt for a bad user queue (bad opcode, etc.), add
a helper to handle the reset for user queues.

v2: squash in fixes
v3:
 - schedule the reset via amdgpu_userq_start_hang_detect_work() instead
   of open-coding mod_delayed_work()
 - drop the per-queue guilty flag; always reset the queue the hang
   detect work belongs to, matching the non-compute reset path

Co-developed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 22 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 11 +++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index d434dd77e421..032989249940 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -141,7 +141,8 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 		int r;
 
 		if (queue->queue_type == AMDGPU_HW_IP_COMPUTE)
-			r = amdgpu_gfx_reset_mes_compute(adev, NULL, NULL, NULL, NULL, NULL);
+			r = amdgpu_gfx_reset_mes_compute(adev, NULL, NULL,
+							 queue, NULL, NULL);
 		else
 			r = userq_funcs->reset(queue);
 		if (r)
@@ -671,6 +672,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 
 	queue->doorbell_index = index;
+	queue->doorbell_offset = (u32)args->in.doorbell_offset;
 	r = uq_funcs->mqd_create(queue, &args->in);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to create Queue\n");
@@ -1112,6 +1114,24 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
 	dma_fence_put(ev_fence);
 }
 
+void amdgpu_userq_process_reset_irq(struct amdgpu_device *adev,
+				    u32 pasid, u32 doorbell_offset)
+{
+	struct xarray *xa = &adev->userq_doorbell_xa;
+	struct amdgpu_usermode_queue *queue;
+	unsigned long flags, idx;
+
+	xa_lock_irqsave(xa, flags);
+	xa_for_each(xa, idx, queue) {
+		if (queue->vm && queue->vm->pasid == pasid &&
+		    queue->doorbell_offset == doorbell_offset) {
+			amdgpu_userq_start_hang_detect_work(queue);
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
index 7a5f8ed794b8..61e5f8a06eb2 100644
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
@@ -178,6 +179,16 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
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

