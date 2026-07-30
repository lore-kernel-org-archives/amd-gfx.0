Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD83EC54FD2
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 02:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4568110E0DA;
	Thu, 30 Jul 2026 02:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tWuLnNWV";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011044.outbound.protection.outlook.com
 [40.93.194.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A83710E0DA
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 02:59:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvyQhdAKgvrUFWe1E7VGNESMt9yC4vM/4lIRtUl0d7vvbEXRJ2S0U/7L3hqdDXebtN3skUskyFMcQyPjgQXVxT0NfLC2bqvy/phCaKnr6tdcXoraoOFyEw2plRIlheNf/aZ8/88GMj4tX4xPM5ZXrsQDX5TvEaECRj17WOLuMZs2THlxbRfCJmTGS6F+XcXPajVNGHSwRBDVY0hn6u9MHEVfdCme3CeehI3eh0qpOgjJMWj0Rj6DsrPIyevzRhewz9i1lhE0EQn/bKHY7Sv4OKTOFtKikAVO/LfI6UVO5LXgqhmW5G5iahdynRicIjJ9VSlH9mr8qWTsfbqDKl5LZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APgbAjarJqlcRRsG8g9fzIhQbroLnh/9Xt3n4LCsGzg=;
 b=B+WxnIP2wpCmQAJ/eAHrJFUHjNKem/RT2msrchvoaXPGlTEl92V9kPB2CgMyt3tbmfTb/JpWO6fWr/7bkHO7qzjoRlQtGI9jGxiM1x6QCYQTugWjB+2MNRJOU8eE1RDnJGkvMATUuiBjwZuKAxMIFCzN01Jr5F9bpGBCyE4Wmcy94wmmQSVLJ2wUHEx0fMmteT3KUhCB184jrJIVlaCoyyqzgcGTiLIUgmIEDjZAxgVlcUVmDFMj+yKwM5tkbvodKd647rFiCqqQyRnQUkXYYRtGU8wyOfxlvR5/fwc807C6IRIAasKOlu0CQujnnqO9orf++pCuh9C4E7VZpCflDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APgbAjarJqlcRRsG8g9fzIhQbroLnh/9Xt3n4LCsGzg=;
 b=tWuLnNWVBnbg3F1oqHRd6O5Xzt7QPU8gfNfsBGX/gZg6thoasUmFo6DRCUClAhM2PkOTVC5FIZWkjoA5sjbYUT2gbYEXC7/IoJ6fcG2Q6lsAGLonpzfKw3kr7E4j/2lb9CqdCsmKHR6HZcE3HabJM+jMKjGOfxiw6spzELiDDIg=
Received: from CH2PR07CA0063.namprd07.prod.outlook.com (2603:10b6:610:5b::37)
 by CY8PR12MB7147.namprd12.prod.outlook.com (2603:10b6:930:5d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 02:59:15 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::42) by CH2PR07CA0063.outlook.office365.com
 (2603:10b6:610:5b::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Thu,
 30 Jul 2026 02:59:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 02:59:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 21:59:14 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 19:59:14 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 21:59:13 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Mario Sopena-Novales
 <Mario.Novales@amd.com>
Subject: [PATCH v3 3/4] drm/amdgpu/gfx12: recover gfx user queues on priv-fault
Date: Thu, 30 Jul 2026 10:58:28 +0800
Message-ID: <20260730025904.1993364-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260730025904.1993364-1-Jesse.Zhang@amd.com>
References: <20260730025904.1993364-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|CY8PR12MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: 6937312b-07c1-4fe8-0da9-08deede68a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: RyosBx7NGdEEc9TpoMLvJxSglf3YTzCZbTxJG/cOfifbwdSxgQAg4OG/JJ2KJ6g8DBAuXkakQVxp8/GaRkeG1EmEY5Q7Dtev2vSBTJWomQW7ZAWefwCGmVmDmE8gnyUqdBWl+r8VKB4u2M0WqsAhiYv6Gmbdi0zmkrRNBHE3x1yg3sQwiMPflpdCKX4ZBg1nngO6tx5WawMKQlE23mviIyiHjVa44dYRGDcZDOYwTMheu6XPQ6cCGyhihl60OYK73/72TB8zZk4IGo+a5T6JODwOgaJdPc/s/Q3IiF5yvMpjCUYLoFD5St/rxuhMTPUhFGj2NSYPt9K3/CcVgF77IeCzB4KXvshkXC7jO3CYt/cS4rmnGWbpg5wjtdov3y6WmuH0dRKgssaxXadplRFRpemk9TFa3Bo17EzrrOHXgXhRWilivdTGFDyzHxkj5jCUsZhhui/tLxLGReaoIzlr8sLpA8CEsgAnUE6icSaNjHlkFBpoOJxgkAd0hYquiSISFPkyaeGz+Hfh2K1J3AZCFNe0Ug5SSOfzubaip9bwTA3xxoSw70kj9vq4Awz5ahTQMZRQjx1QuAW2dEcTK1kqfq1GtMc9IV/lI0vQup0Q8l8/XTZ72ihN5RgTWoiaJSwJjTPj1WtVxaMopFBw6i73lkmqeRg2/WOO/3RCKBIrkkNih40BiCOpZJ+nBMr80S87xkXFnZ3O7kkHH9HEvk39kw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hOE3U/da2osN1QFxiKqsFbIsv7iNEkCfAGlVeHqAsD1hwZ2c3nd6bMCplcEco7rZ9XWq8FrtF3GQS6jK7l8TY8aIZ2njnI4H5fU2ODUmfksbsH/oXZ7H/OziG8tt9rdFknJX//MqTr5Oubeve/Wuk0yxYLx2qncD/L/Q/50EgUPoAx7OBtv11lDUBlOs8purF4wvwkdO1xlLbwNnH+22CXca1mtZlRbl6Sp48yLj4cz5A5aD0/IhJLNnYmvgHh5ScPcxIij0ORXAd9+2MAn9VbLaFlJ+qCHfyJGvn2u5H+BMSbn9UT1m7nS8mjcCIveTF0l9BO+5dP0c1iE7qmvxJn35YDOBmutyYrCYoVLTDz5y3GUMCOXGnZZnGcmkr34aR0E20WDYwfPl6vlvz7GdZJYeLa2Zwa/x/oRBnVDaOI+30ycPU/nYvcFkDqG+X9aw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 02:59:15.1993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6937312b-07c1-4fe8-0da9-08deede68a59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7147
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

Mirror the gfx11 priv-fault user-queue recovery for GFX12, reading the
doorbell back from the HQD via soc24_grbm_select.

v2:
 - gate on adev->gfx.disable_uq instead of !adev->enable_mes (Alex)
 - document why both the doorbell (compute) and HW-slot (gfx) reset
   paths are needed (Alex)

Suggested-by: Mario Sopena-Novales <Mario.Novales@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 64 +++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index b3887c5262a0..8fe991787974 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -286,6 +286,7 @@ static void gfx_v12_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
 					   bool all_hub, uint8_t dst_sel);
 static void gfx_v12_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v12_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
+static void gfx_v12_0_userq_priv_fault_work(struct work_struct *work);
 static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
 				      bool enable);
 
@@ -1608,6 +1609,8 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	mutex_init(&adev->gfx.mec.reset_mutex);
 
+	INIT_WORK(&adev->gfx.userq_priv_fault_work, gfx_v12_0_userq_priv_fault_work);
+
 	return 0;
 }
 
@@ -1645,6 +1648,8 @@ static int gfx_v12_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	int i;
 	struct amdgpu_device *adev = ip_block->adev;
 
+	cancel_work_sync(&adev->gfx.userq_priv_fault_work);
+
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
 	for (i = 0; i < adev->gfx.num_compute_rings; i++)
@@ -5038,24 +5043,56 @@ static int gfx_v12_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+/*
+ * A gfx exception IV carries no doorbell. For each faulted slot, read the
+ * doorbell back from the HQD (left in place by the fatal fault), look up the
+ * user queue and kick its per-queue reset.
+ */
+static void gfx_v12_0_userq_priv_fault_work(struct work_struct *work)
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
+		soc24_grbm_select(adev, 0, pipe, queue, 0);
+		db_ctrl = RREG32_SOC15(GC, 0, regCP_RB_DOORBELL_CONTROL);
+		soc24_grbm_select(adev, 0, 0, 0, 0);
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
 static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
 					struct amdgpu_iv_entry *entry)
 {
 	u32 doorbell_offset = entry->src_data[0] & AMDGPU_CTXID0_DOORBELL_ID_MASK;
+	u8 me_id = (entry->ring_id & 0x0c) >> 2;
+	u8 pipe_id = (entry->ring_id & 0x03) >> 0;
+	u8 queue_id = (entry->ring_id & 0x70) >> 4;
 
 	/*
 	 * Try KQ first by ring_id; UQ as fallback. KCQ and UQ never share
 	 * a HW slot (compute_hqd_mask contract).
 	 */
 	if (!adev->gfx.disable_kq) {
-		u8 me_id, pipe_id, queue_id;
 		struct amdgpu_ring *ring;
 		int i;
 
-		me_id = (entry->ring_id & 0x0c) >> 2;
-		pipe_id = (entry->ring_id & 0x03) >> 0;
-		queue_id = (entry->ring_id & 0x70) >> 4;
-
 		switch (me_id) {
 		case 0:
 			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
@@ -5084,10 +5121,23 @@ static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
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
 
 static int gfx_v12_0_priv_reg_irq(struct amdgpu_device *adev,
-- 
2.49.0

