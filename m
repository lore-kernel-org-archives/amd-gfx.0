Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80884C4451C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2026 03:22:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2276010E3FD;
	Wed, 22 Jul 2026 03:22:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TCVln0+d";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0361C10E3F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2026 03:22:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBQAIeSlnWKRRwN7CTbE8gyJXgzvvtsBwCC837XtS+E0V5B23sLQw4Ear3SBOVHl6h/rTjOa2OA7KTfJ0vnC4KNGmITZzAh6M7BWA7OCg1PAiFxiVF+b1SiNiAt3Tfy5hI8soST/igDD9Gm801lX5PENDh7TcYDy04to8thzydBlKyq+cbId4pdEMK/8IOSYxsxI7nKQA29jNlK5T9PNFA/fE7NQQV4YUzeUctch/FbdZrrD14v3kPZP7b3Fhvjh8qWJybhiQqf3bB4S6jn9EZw7A6UY8EF+rAFDfLbTZrO1rg9ny40mtQhlvAjP7EzgSjHtRRlrJmTFmacXHZ4fNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8GNaR0ccCW9O54/O80AOKkISLaS8W3DJUTwxih6YBw=;
 b=p6Ky1KKNecUrykVC52dVV39SupRU73ET7mqyNCHEnzXy3Nwqh0uTQaEGkXIW9oRTl99lywj3Jcjcx8ImJMC7qjKDkPFmjfhUYIU89RvDwN3+k+EsDPygTQyI9qB8Vyti0Y6TfWThS2WI36IdaO07ceMeA2+sOTt8hd19Glvzkw/+sskhxqw3l/t/7d2pcaRx/rRu6e3S2ZTbMj5liHjCNUEF8wPkL1gsQ8ZKwOQHfmbpU7k0j/RZ54nMYouCRDQPk2JoiSxDBn+OaHp9GMX2B3+ciYF6of9zm+w+5A+mPWHiFwaPEK+Y+OUTbi/QfP6nCA5ZjMQupawc4AAgYLX3nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8GNaR0ccCW9O54/O80AOKkISLaS8W3DJUTwxih6YBw=;
 b=TCVln0+dSimCHORoHQ7dQewggGA5kwvDaLF0dNs/5Qsa8Dhm1nUhjaLPK80RJWqmj1zfJLlelFE5vTCIgsealhi0M5hElY7M5WWlDmRYq4XUW549zlHnq+bp51AHVM/U5+zL55EuJ2T4ZvhsDItaFAF/xWp7eqmgHWhmmj5F/e0=
Received: from CH2PR17CA0018.namprd17.prod.outlook.com (2603:10b6:610:53::28)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 03:21:59 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::31) by CH2PR17CA0018.outlook.office365.com
 (2603:10b6:610:53::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 03:21:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 03:21:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 22:21:58 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 20:21:57 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 21 Jul 2026 22:21:56 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Mario Sopena-Novales
 <Mario.Novales@amd.com>
Subject: [PATCH v2 3/4] drm/amdgpu/gfx12: recover gfx user queues on priv-fault
Date: Wed, 22 Jul 2026 11:21:15 +0800
Message-ID: <20260722032152.2904563-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260722032152.2904563-1-Jesse.Zhang@amd.com>
References: <20260722032152.2904563-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|MW3PR12MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f43190d-a13c-4ec5-a010-08dee7a063c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|56012099006|10067099003|11063799006|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: t0DsyNX2lzvggXQ9ld1uILq3JZx0LF/DICOOgNyr1qXO12fVquSSFDZux04cjE9cHAlzRGGw/aEZH5J2cpsCj//N5qg1ifYX0GGeI8UVQWAul+ttTFfrUzamq2S4QsVQWsKgwoGOv3SPi0jLzdcAnzw/XnpK3bMM4E5Tp/lSY4KxlVOrzKBCXhXv/QQYFP9QYMhVsHJRAZ/nmhyTIWJuGWs5Mk9c/OPFM82FAPt0dcQxdAkjZomRUxfQpNiASU5rgzkMJ8h0mlIEE9BUSGx2yx5Ba0nV7EC6j0LIhUWgCkSEUOs44Boih6W7H+3SM8Ig1IToHOHC3V8rwBypQjWaiQOP6sTQdgTTaBDGjGLhZsJJ4x7kPWs+46Qlxaon3JAkD+tlbnDeffGQsruF6ed2G/RbKsJt/CfPCupCrlBwKU7ooWH/MRTC6atk8Y5m+3Z9GQK64qUzvUlwM/Q7ZxhktFgAN+76cnk7l9RvfgFaJbMYAfl4m/LEYduYwDBJcJNYT7XdylfIHqC8/awry74cScBMxE1LDQV7NlcbbBYkcaUPWKco3oSKITUMozOZoWuryfHTlL9UjzmFnu6o3S54L/OTPqDVJE2Voo/1hqH4Arv7NrFJn30DQ9RpbAWGC8M7IUP5AjliJHkyz8Uu0U0EK6uQ45nYz2IxS4o2NY36DlSkpN8RjtbpTYuJjWJAz52ovWXPIInDWXMwwX0duQ5PBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(56012099006)(10067099003)(11063799006)(18002099003)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SKu97oWHcFmfmb2Rw86u01Pz+o+lMwBep1VwM3L7/ODujdFEHrunQgBEcj/XLmL7AqAnfNxPw1Ywi+Yo83zDBs8ecbigIyVXmU+4nIbHCdt9iaKnC4AQiGBucHCJUJzlWP2++oRLxDDkvFc2SN3ydzl+X035BR9g+5fR6JzPomQjAr4qd+pjr4ad9wbgsVjJ7nE0Z+/r5ylDpMc00i3x5nNGlBFzTdNCqVtxtPvqKNZ0R5TL7hEhcHzEpureMobEm2HXIfTXsMlOc9Ec8swUW2VFSeqenkqR+Q+v/hoBEo3icUzZ4szc6UVsSuykM5nm6LrFohX5Ob/LfAHfQD3iZCJtxmcGH6btnbJVZFIX5CMzVlwFDzll8uxetH83GZuQJ8ydsfG6V7RZDTwXQN5W5K1YDmJVeu84SC2mmIVUXGwvBHAhPQtezE5yhkxIv9t1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 03:21:58.7080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f43190d-a13c-4ec5-a010-08dee7a063c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364
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

Suggested-by: Mario Sopena-Novales <Mario.Novales@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 62 +++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index b3887c5262a0..7b8a841d23fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1400,6 +1400,8 @@ static void gfx_v12_0_alloc_ip_dump(struct amdgpu_device *adev)
 	}
 }
 
+static void gfx_v12_0_userq_priv_fault_work(struct work_struct *work);
+
 static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int i, j, k, r, ring_id = 0;
@@ -1608,6 +1610,8 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	mutex_init(&adev->gfx.mec.reset_mutex);
 
+	INIT_WORK(&adev->gfx.userq_priv_fault_work, gfx_v12_0_userq_priv_fault_work);
+
 	return 0;
 }
 
@@ -1645,6 +1649,8 @@ static int gfx_v12_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	int i;
 	struct amdgpu_device *adev = ip_block->adev;
 
+	cancel_work_sync(&adev->gfx.userq_priv_fault_work);
+
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
 	for (i = 0; i < adev->gfx.num_compute_rings; i++)
@@ -5038,24 +5044,56 @@ static int gfx_v12_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
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
@@ -5084,10 +5122,20 @@ static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
 		}
 	}
 
-	/* No KQ matched: HW slot is a MES-scheduled user queue. */
-	if (adev->enable_mes && doorbell_offset)
+	/* No KQ matched: the faulting slot belongs to a user queue. */
+	if (!adev->enable_mes)
+		return;
+
+	if (doorbell_offset) {
 		amdgpu_userq_process_reset_irq(adev, entry->pasid,
 					       doorbell_offset);
+	} else {
+		/* GFX IVs lack the doorbell; record the slot and let the
+		 * worker read it back from the HQD.
+		 */
+		set_bit(pipe_id | (queue_id << 2), &adev->gfx.userq_priv_fault_slots);
+		schedule_work(&adev->gfx.userq_priv_fault_work);
+	}
 }
 
 static int gfx_v12_0_priv_reg_irq(struct amdgpu_device *adev,
-- 
2.49.0

