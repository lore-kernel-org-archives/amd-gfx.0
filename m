Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE8EC54FCD
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 02:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 455E610E0F1;
	Thu, 30 Jul 2026 02:59:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KaU3wjvA";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B312B10E0DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 02:59:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfzkNiI6Hbu7p2HmwjYycFD1X9XRfLf5dvcTSxTS6DdTVvtQuMJRm+mFTNuElqt0nAqkwmGN6d7v0SOIYUF1pCZh5f2sppHzIqkQii8JJPcuAuERG+IwjNzWs/Z9xq45oBAZPQOEG47+nUJq8+9DX5EcnIpEIxT126/YH7x1lsSz/S+SD4pVpayz9l1t6sxQqhQFKh+TSGiwrYaYiYumc2s+OF9wJ1D2kdPIJg6I0Sd+dGZy0CwGnlFxBQJoT3rbZbWr64okpX9Ugd4DPddjDaIJFLJrmIyE9NkD4ZNkwWeDVUqiMEPgj7CPIfAfAhYz6+ZzrXjnF04wfPRug8Fb2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHzHFaj2BVwEonC4HTCoAokslB7a+rjLo2SGGEwotkc=;
 b=FUnaARjFALBQ++6klKEMYsoQnv5Ldp+0MxpPpWT1h4n/UXqDwnHnSmd/KjenwE9FqQKrCB9EOwwp2FEg/NN/KL1aQNVObvyuLWanTW8YP6X6UXxBaNwoD+1f7i9LidAoxoG4W7lRusyJtuI9kxPZiksNe6VNCFY+Viio72VqiIECYtyuff2K2ESbAlxpvSYKX8B8aXu0Q58TZQld8Vq/XcIiEGX4pQX3Gnc3N5O99a+Q2dlTqhMaaHasw48ijuPoj54Rts4kvkzKYyLg0rFbwSBcd968v5Q7A36Bjkp5LT4XjraB6Z4H9x4l1VwNyXm0OHo99SZgwZ+TCi2cybiBAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHzHFaj2BVwEonC4HTCoAokslB7a+rjLo2SGGEwotkc=;
 b=KaU3wjvAQ+130f5gGyqTxb0sZFFOyj8ogs77E39OS8cJAAIASL5yUKFvGdYQpQF4QJOwZkdIaYe/eGTetIpJp/fVSVinWiEEguwtTWsBls/WC8VKXB6KYw8UCXDKVlFvRqxk8b7Bem3plnJvKrZZHyZM4D2vjU749FMx7edg5bw=
Received: from SJ0PR03CA0089.namprd03.prod.outlook.com (2603:10b6:a03:331::34)
 by MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 02:59:14 +0000
Received: from CO1PEPF00012E82.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::54) by SJ0PR03CA0089.outlook.office365.com
 (2603:10b6:a03:331::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Thu,
 30 Jul 2026 02:59:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E82.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 02:59:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 21:59:13 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 21:59:12 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 21:59:11 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Mario Sopena-Novales
 <Mario.Novales@amd.com>
Subject: [PATCH v3 2/4] drm/amdgpu/gfx11: recover gfx user queues on priv-fault
Date: Thu, 30 Jul 2026 10:58:27 +0800
Message-ID: <20260730025904.1993364-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260730025904.1993364-1-Jesse.Zhang@amd.com>
References: <20260730025904.1993364-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E82:EE_|MW4PR12MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: 5701f50a-66b7-42d9-9d4f-08deede68993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: fF633BX2chQwwUY0zursbUc7k2KBdQu43B1gFmxTtZqjhjO8UisKe8A2gqdrePkxic4Ojzm8llt4qeH4lNElGao8QX4DkwAm6BUyhJtwL7g6jdk2GCro/+GYFDfdmoG6Kx7PisHlx9t0VFSEYezpVdL4XCw5VEb9QcrpP/CZYNHWXoz+avXONFQMzroIUOYjQotPBPu1iTvnSIX/howxuNZKQXW3P7joT7+wDoYiawzV709bKBOjEUp9ZYUZ9E/aquo/MLXgFzGPHzCpZsNd9qBzHztaxXj6TlBKJi9dGly+g0WMs9UecogDgWG4/bHE0yy1yMOY+4N2OLfSGQRoeljDuyI6Z3937W1+af3X7IVHW3XElmRBsddml3dXGBOMUbHrTJGlD5TRYe/I3qFQUD+EkWCcg5b4L13Wldff5xwF0Orcp68CsCq2raUgXqy2+cdZ2cdgqYpFpnXhm4l6xp3LSmbwIfWucqFw8ZzXl0AE3mN2zDbJweJmwx8zrVKvceVNlcNxyCHwzbbrvdevKPx1l5YdGvpqzfG1oZPLumCAYoAiO9juiCA7ZP0Mnwh+u+5+9iWEUUdjP45lZtsre+/PrVLytEXHBP+Yxq5c8ibxWgMQPr+itQUH6EbH6aq8Qot6uw0R7JKRIkNQc4PdTBytLPGysRlqKx53V8yqBl94ehgeJizS5k1Iay/XEkBdCQgAOcpDkXUBYzJOupKh5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sETFNXl4+GIb+lHjUy0+TQXWc+W/2w0yeNU5FSNF0VxG68mXgLu/dbf7tcsq3n+qQgdoLqJldlU0pM+2v4s8lVc3xx2oOHhsmyq4x+SdMFkSbTYPlvuWWv+N4NTG5HRFu5KFttunO5oUv1yeD9UIzCyJIQJXnu95Y27ZPLqvhQDK4t5V+/LR6HFYjGflpBLEO2G/bWqUx0yt57eNHhljoO03qUVsUK0t8qOYryd5838j650VBg6fdTyU/Q8MD4BIuRLCnER5oeAL5OhMzpgT+61aZ8jCE2UTBQm8DHdB/JD8e/Aj63I9tzY+u8cq8PXEfccdNi8oEr4qUL9a6VrunzY3gAOgcD5Kk78eOnYsvJ9G446gpPtw7bfGF/DA+0pRRLVLjERO0DXRMBveNQXfPTj5EJ6HFrQ2jNMBlkoIAFXKxtZhb1raWKFRRUkGqoMS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 02:59:13.8512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5701f50a-66b7-42d9-9d4f-08deede68993
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E82.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6754
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

If a priv/bad-op fault does not match a kernel queue slot, it belongs to
a MES-scheduled user queue. Compute IVs carry the doorbell and use the
existing path; gfx IVs do not, so record the faulted slot and let a
worker read the doorbell back from the HQD (regCP_RB_DOORBELL_CONTROL),
look up the user queue and reset it.

v2:
 - gate on adev->gfx.disable_uq instead of !adev->enable_mes (Alex)
 - document why both the doorbell (compute) and HW-slot (gfx) reset
   paths are needed (Alex)

Suggested-by: Mario Sopena-Novales <Mario.Novales@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 62 +++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0cbbdc3694f4..4c1ba5a9c75d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -362,6 +362,7 @@ static void gfx_v11_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
 					   bool all_hub, uint8_t dst_sel);
 static void gfx_v11_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
+static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work);
 static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
 				      bool enable);
 
@@ -1931,6 +1932,8 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	mutex_init(&adev->gfx.mec.reset_mutex);
 
+	INIT_WORK(&adev->gfx.userq_priv_fault_work, gfx_v11_0_userq_priv_fault_work);
+
 	return 0;
 }
 
@@ -1968,6 +1971,8 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	int i;
 	struct amdgpu_device *adev = ip_block->adev;
 
+	cancel_work_sync(&adev->gfx.userq_priv_fault_work);
+
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
 	for (i = 0; i < adev->gfx.num_compute_rings; i++)
@@ -6707,10 +6712,47 @@ static int gfx_v11_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+/*
+ * A gfx exception IV carries no doorbell. For each faulted slot, read the
+ * doorbell back from the HQD (left in place by the fatal fault), look up the
+ * user queue and kick its per-queue reset.
+ */
+static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work)
+{
+	struct amdgpu_device *adev =
+		container_of(work, struct amdgpu_device, gfx.userq_priv_fault_work);
+	unsigned long slots = xchg(&adev->gfx.userq_priv_fault_slots, 0);
+	unsigned int id;
+
+	for_each_set_bit(id, &slots, BITS_PER_LONG) {
+		u8 pipe = id & 0x3;
+		u8 queue = (id >> 2) & 0x7;
+		struct amdgpu_usermode_queue *q;
+		u32 db_ctrl, doorbell;
+
+		amdgpu_gfx_off_ctrl(adev, false);
+		mutex_lock(&adev->srbm_mutex);
+		soc21_grbm_select(adev, 0, pipe, queue, 0);
+		db_ctrl = RREG32_SOC15(GC, 0, regCP_RB_DOORBELL_CONTROL);
+		soc21_grbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+		amdgpu_gfx_off_ctrl(adev, true);
+
+		doorbell = (db_ctrl & CP_RB_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) >>
+			   CP_RB_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+		q = xa_load(&adev->userq_doorbell_xa, doorbell);
+		if (q)
+			amdgpu_userq_start_hang_detect_work(q);
+	}
+}
+
 static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
 					struct amdgpu_iv_entry *entry)
 {
 	u32 doorbell_offset = entry->src_data[0] & AMDGPU_CTXID0_DOORBELL_ID_MASK;
+	u8 me_id = (entry->ring_id & 0x0c) >> 2;
+	u8 pipe_id = (entry->ring_id & 0x03) >> 0;
+	u8 queue_id = (entry->ring_id & 0x70) >> 4;
 
 	/*
 	 * Try KQ first by ring_id (HW slot is authoritative). The
@@ -6718,9 +6760,6 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
 	 * never share a HW slot.
 	 */
 	if (!adev->gfx.disable_kq) {
-		u8 me_id = (entry->ring_id & 0x0c) >> 2;
-		u8 pipe_id = (entry->ring_id & 0x03) >> 0;
-		u8 queue_id = (entry->ring_id & 0x70) >> 4;
 		struct amdgpu_ring *ring;
 		int i;
 
@@ -6752,10 +6791,23 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
 		}
 	}
 
-	/* No KQ matched: HW slot is a MES-scheduled user queue. */
-	if (adev->enable_mes && doorbell_offset)
+	/* No KQ matched: the faulting slot belongs to a user queue. */
+	if (adev->gfx.disable_uq)
+		return;
+
+	/*
+	 * A compute user-queue fault IV carries the doorbell offset, so reset the
+	 * queue directly from it. A gfx user-queue fault is raised by the ME and
+	 * carries only the HW slot (no doorbell); record the slot and let the
+	 * worker read the doorbell back from the HQD.
+	 */
+	if (doorbell_offset) {
 		amdgpu_userq_process_reset_irq(adev, entry->pasid,
 					       doorbell_offset);
+	} else {
+		set_bit(pipe_id | (queue_id << 2), &adev->gfx.userq_priv_fault_slots);
+		schedule_work(&adev->gfx.userq_priv_fault_work);
+	}
 }
 
 static int gfx_v11_0_priv_reg_irq(struct amdgpu_device *adev,
-- 
2.49.0

