Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BF5C44501
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 02:35:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECEC310E28A;
	Thu, 16 Jul 2026 02:35:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j9NNkhmO";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012041.outbound.protection.outlook.com [52.101.43.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5072910E28B
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 02:35:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSnn+E63+AofjkOs9gi4kGifwwUJYW43ssD+cJfXOIjjm7QSOvbh3d4MpMlxC63JYdiCOJq4F4cPXBL8el4GSv7IL6rS8oYX35NfYY2erxCE9wmr92epeuQPrnpMIAjeL5IAS0HkKSdbGib7HiiJUtGT8NZAx5O3pTAtb7yCbUWR0V+wd+CV5B0OJX23JgDdIc3pv9kXOzuWlbispxIqZLy9UOd+ZBYb0xlcb3e7PSSsb8Tbl4N+/hOpeip+OrDHGYDsmqb/fe9Fo0jKklFFRcpV9Ie5XDyHU+waMrUaXuIlOfjQZznW3ohG5iZZX86dNKwuOQzyfTf7q0Fv8nRv6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8GNaR0ccCW9O54/O80AOKkISLaS8W3DJUTwxih6YBw=;
 b=aumdNu90457W/T+Bh/XkHXRQonywX4fdlKrXnY6+jOb6sB/JRoja/gc6pyM+TqPd/VyaC18iR1ae3NvuzBte3d7oVT2FVkWLt/I+8Pc+8TFeBdoiIzVzihaUg3cl2gDVNJoM6ciTepkKPJ5md/O9AGzuFKRoiODQGObDtYz+4Rq0LvJQpiAkJpEgHlktlspAMLiKq+mH6sjH2VdHEPEve2a56dVmfgqg25OujjpvzWwEAlwNIYN88tyiYFDznbUBSvoTUNz63X7fuk3QSA1ZJQFzgzRNder0gPgxxkBDYh1up5RAFgs5bxH6QVHjIs2PTs/gcv5S4/bRpGslODbj8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8GNaR0ccCW9O54/O80AOKkISLaS8W3DJUTwxih6YBw=;
 b=j9NNkhmOcnhORXuRy5g7qd2/EZd/uURqJtskHS/Pg2ycISVzzrpyDyTCjE+9F2KnE1+vy/lHlxG01ZUjAxO7GTZ4n50n8lfMbC4lwkNPfgRGYmAKMwmSKl20YSAuJDdLEm3UZK/Hvq9KBCh7xEOvcU9EZzWisPGcwrkf9ymfQL8=
Received: from DS7PR06CA0006.namprd06.prod.outlook.com (2603:10b6:8:2a::7) by
 DS0PR12MB8072.namprd12.prod.outlook.com (2603:10b6:8:dd::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.10; Thu, 16 Jul 2026 02:35:33 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::37) by DS7PR06CA0006.outlook.office365.com
 (2603:10b6:8:2a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 02:35:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Thu, 16 Jul 2026 02:35:33 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 21:35:33 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 21:35:31 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Mario Sopena-Novales
 <Mario.Novales@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/gfx12: recover gfx user queues on priv-fault
Date: Thu, 16 Jul 2026 10:35:09 +0800
Message-ID: <20260716023527.2073603-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260716023527.2073603-1-Jesse.Zhang@amd.com>
References: <20260716023527.2073603-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|DS0PR12MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2cd99b-8cc1-4273-635a-08dee2e2e92f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|56012099006|11063799006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +/rjQXRd0JneOKNGKcilaLBzVC7MM681b/xE6RNwAfjy45Hqa6SwF/RZKSeGpJvsEeISdyV7gOceS/kbNbwGUrr1XCSwVbwpIsDYyHruRn7EO2m1Ipu9jnGU4udoYynJC4KNeIzZDPltak4mGwWv8kVmsvwORFXHAejboao3vyzI4c3Ep++vFyPYR08q9XjM5RxL2/5yKfL/mI5sYL16sTbq/lX6n/i5P3E8uL1TBiTFrrZZ27SP1MiyfvqTCgcnTI3vEGe9sD/OOeMntVYHQMZzZEt8cBmT8XK5XUVlb6M42Nf0GQop8X/22RYukZkMnsEel+mEveVsev7NC9vTqW133OIunrEf/55ZUz7+/TKRgY+tXgsn+ngjK6h0lwGxC+LLbvifB7SXhKsu2TCmpKhbyXES2cctXaOjVcMOwB1PUvrB9NFz1ioW7NRH93d84GqLXdDqO3UDRgXnk+U081ygHAhXDKZNsB8qtdmo1LW7TktcHF/+BZeEXA3aoxKEnT7UcXn0agtcogWVOgw99FOCayeC/hmaurvf3+tq2+ftTKEVe/IBv6ekK+5N7jQy8DFMmsDQjc/5dVe2jGgESObibaxbUgz6jaMT7l+d3TezVEB+g56MPOTQ4chJNUu1NL6C2kF4HIEHm7PAD6HKe4WctUH5DdHWVxV//I6B+ObO4PDbJ/GJM1FpKFJyvXAMOUs7aCW7INCv5CdjWOoyDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(56012099006)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9X00I73bJha9++2OiA4AVYwHXuMWYswn6kZDu8FRrtNRLIU2d4MQpVfDeck3dsn7BuZIx9YglikV8Nuc9pSHWxoT/GXjfO6jy1xXyGnPGevjRzOYetsb52HxNEAPPMj9OsbfYw7FtPtLyy3K3Qt4i+9d1LHSOnoDH/cnmvnPt2tuIwUzAuC0uTnEyHB2S1DbOxi3vVgzSqg/3gxI7d3sMbDCHBVz0QUjRDD8y3vfGpJux33gQDk3gwhzTdkjEHBvWEAFSXM00EFfAfTUmw07CuJlHUgycDtATrZWYkh+DsCVUr6EwNiQxVVFCjk35m/KmT4HLGqKaSnbHKp0EyfEgqCRk3Zeec0rli9G8Z0bn0t4xdqLcsJVcK6cqt/uBDusd6efph3UMp4qCmhj9gV9Psdd1WOhNzMU1kWpSK8tjWDMXivNy2dNaDzA265SFo/u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 02:35:33.4998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2cd99b-8cc1-4273-635a-08dee2e2e92f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8072
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

