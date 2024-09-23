Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1415CF9C71
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Sep 2024 17:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BF7A10E28A;
	Mon, 23 Sep 2024 17:41:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BSQ1QWQt";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D17C410E28A
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Sep 2024 17:41:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPKGM8uF9/KQrxFQ/5T27MeDTjg7U4w9ipyNPmgnHxUwUQVeS+itSfyqrvxv9UVKpN70HwC2w7JIMayLFzEgMiX0M75sOftlaVi7AzF6ZB8ctzLX32GBveyglMXoWHikMG+duguJ6uuwyygtRs0nJN+Sk1I60ifLWAnozCCa5fSdSRFPA2xs8FFiQqsmLrr4dohKlQMYik718/HkPZ3w2BZSsmX/72JnTHpf9jHTM1H3PY5p10P+T0+r7nMBmAvUAT321yz6i8iBIDsTBRHr2OFXlXGAqPW+aVKECQ5m4hUrRfCzPLfCb6wF63Rm+DE0rcZAcT+KCAxpL6lMQi7XfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCWtC8NeIJNcwstKVwgePW/pHzt3/SVlXPkDT7/lauM=;
 b=OYXTemPYZPhL50bEpric8eecNqvKaC3RYdDpQjabjwffElWJHne6PeKkxyJUDuq34ipVYpOm2mw15he95NMLyIXFoY16V3bc+qgxf6kUAoWUmhYFSbPxO5vtwFxsrxq1BIoJ7En/S7/Df+ocLm9WO/kjezRjJrrIry+8XhCHzgayj8Qfm625Hpaj3cVZvtRC9IzzSObglv6g+a28eR3DAthJQ03g+6h0SpoyMGBq+glynS0/3VgoZ3R6Xpzp7v6cy9SBDE7yesUi+HTJ5ulVxBInh7FO4PdTB52vqyVCt6swWBjhMCJCwiiwx/SN8eNLkEVNYZ/EAqQKqDLgujpUZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCWtC8NeIJNcwstKVwgePW/pHzt3/SVlXPkDT7/lauM=;
 b=BSQ1QWQt+1INB9wLgdNZvPrrR7ov5qA2H9rnX4tEjjwPliqjp/tlaZ4el7Qe4qTHbry9ZvJ5vcIS/hZt0923ukBzkxCNN/0lGzYJy5U7XZ1eWTaZHHVNwXlvl9gtXUfsjBbYKPwacXsSPl/SC//ZIoct+IzeG4Pe27RKmLHmLTQ=
Received: from SN6PR05CA0029.namprd05.prod.outlook.com (2603:10b6:805:de::42)
 by SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 17:40:59 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:805:de:cafe::84) by SN6PR05CA0029.outlook.office365.com
 (2603:10b6:805:de::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.14 via Frontend
 Transport; Mon, 23 Sep 2024 17:40:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Mon, 23 Sep 2024 17:40:59 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Sep
 2024 12:40:58 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harish.kasiviswanathan@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCHv3 1/2] drm/amdkfd: Update logic for CU occupancy calculations
Date: Mon, 23 Sep 2024 13:40:45 -0400
Message-ID: <20240923174046.284250-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SN7PR12MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 330f9bdf-e88f-43df-c06a-08dcdbf6e312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uMydn/0byHn5a6iyhuC+cxG12+aTUxoIRxfL3IjgyPyKWHW4ue2Oi4KBCgU7?=
 =?us-ascii?Q?fm12FxYOB+Vw9hMBvhicMdbhjG8DrEZq0UGyiapwUjUvOO+VsFQ84y/A53E3?=
 =?us-ascii?Q?FP9jUd5GLw5BGJEbjYojrF6LwfJ9HAq/O5DklI17BY530BNoacM9TC6pq+XF?=
 =?us-ascii?Q?27f0h1v+sSaoQNtFb5vL7kOQt6wqkN4IPskMEfRIrmnERy4kujvcg+AOd9oZ?=
 =?us-ascii?Q?04PE77m0wS4XFWJsmowEQa00tN6je3MCPf5Iao5MZdCrO63HhC0Zwvv/vXTS?=
 =?us-ascii?Q?FOGaotO8uGbZTS+9MYHit2m9URnWfZGVUSlSWRk/m/aPA4u7Q784duwEQTv3?=
 =?us-ascii?Q?Q7zHGkulxOMGavHQDZ2Sn3MAMgAIYq0Fn0df9QZNHajVKpZbdzUNtZ0ENdSC?=
 =?us-ascii?Q?s5DIZ38vWMwDTrNddJxgNcVwDP4SmDUJBxcGjVGkNpWcmS1NUFZY7WPmSoVV?=
 =?us-ascii?Q?9cpqKvNkkdQjhzCKEvncrilNmtm7ohppHpSNweAjNAxG/7uejPNmNjmn7bQX?=
 =?us-ascii?Q?6ZB2G6S8Ok0FUOyrpU5/FFc2LGkPeE8/IDIwXZxYPxSC9vxaEaFgwWlp/K3z?=
 =?us-ascii?Q?XDczTWnMOfolV50KUbjSXSSuE9upCctSFrVNTTdLyX2boFPi3ONnM7aYIke1?=
 =?us-ascii?Q?HpA9Zv6kj6BQwCuzQnDbB7+nlZ77WIFEWioflxNCLqV/RCbRiDQWnhp1zd8a?=
 =?us-ascii?Q?fa4x4fKH6a0QNQmF2bnC7gk+dPfpDnS/rPflK1TvFPq6uFLsf45WHXqG36mW?=
 =?us-ascii?Q?xgcVgQ23zcircUdrO8UDqOGjBBHo5Bjmwi/bgXtzlur7SchnnmW7oAp0KWVD?=
 =?us-ascii?Q?hkyy5BG6TcrzDKHSZ/aNTTv1uKxqcgxdTc88yQPeAKLDtkFJpjXx3dZGblzO?=
 =?us-ascii?Q?CNhTlcz3vZEAzkOQ00voL2d6i27G9s14VJcZ+ncmqC84CGKF+5D4brOmmjV7?=
 =?us-ascii?Q?onk9ATNrQ5gwGIxI/rB/f69uCC8oW2gjZYOsuSL8l6ydiubzrFPXfiTbKqbO?=
 =?us-ascii?Q?umpyNNYSiqowGWAXmVzZoCzOXVPL5CUNkPMUrvGmOUUlLCI6FnR7nJMQtbua?=
 =?us-ascii?Q?X7NiVp6qbBOPUeCntIoz8fT6RjEmlC4ODCs6mJkx2CYMdNpRmrGAxOHfx78X?=
 =?us-ascii?Q?0pEeI2f4LF6x4tRqYcbDIR2smg7Q6JVx5P14KnAfgNGMFneUWbPIMirwSVBN?=
 =?us-ascii?Q?1GUtdeNjh3hSY2tgj9GifETWN4wvLdGcP2DM9WAd/9riGFYIgdJKEm8b1wu9?=
 =?us-ascii?Q?bZfW8IUV8HHz3hDKbxPgqjxyhWf1p2LMAZzn8z9zNUKwR6v16Eyv3FJ8evWh?=
 =?us-ascii?Q?P2yoSnDvUE/ABGCRWa0LRk7eN3+doI2du3iW9TdqZyoAb3bS/jGfA914hCcI?=
 =?us-ascii?Q?ECXlBJuRKqndPwmcnqVfuA+zEM+xXl2VqfgwLr/HY79ll7mbVElVQYsTnZbN?=
 =?us-ascii?Q?b1iN4X9eUVrKifJ94qaH7ktsiLKeKFGO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 17:40:59.7081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 330f9bdf-e88f-43df-c06a-08dcdbf6e312
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452
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

Currently, the code use the IH_VMID_X_LUT register to map
a queue's vmid to the corresponding PASID. This logic is racy
since the CP can update the VMID-PASID mapping anytime especially
when there are more processes than number of vmids. Update the logic
to calculate CU occupancy by matching doorbell offset of the queue
with valid wave counts against the process's queues,

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
v1-v2:
- Break into 2 patches, one for the generic change
  and the other for GFX v9.4.3.
- Incorporate Harish's comments.
v2->v3:
- Update the comments sections for kgd_gfx_v9_get_cu_occupancy
  arguments.

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 102 ++++++++----------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |   5 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  20 ++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |   3 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  14 ++-
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  10 +-
 6 files changed, 89 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 1254a43ec96b..26b1f37c316e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -950,28 +950,30 @@ static void unlock_spi_csq_mutexes(struct amdgpu_device *adev)
  * @inst: xcc's instance number on a multi-XCC setup
  */
 static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
-		int *wave_cnt, int *vmid, uint32_t inst)
+		struct kfd_cu_occupancy *queue_cnt, uint32_t inst)
 {
 	int pipe_idx;
 	int queue_slot;
 	unsigned int reg_val;
-
+	unsigned int wave_cnt;
 	/*
 	 * Program GRBM with appropriate MEID, PIPEID, QUEUEID and VMID
 	 * parameters to read out waves in flight. Get VMID if there are
 	 * non-zero waves in flight.
 	 */
-	*vmid = 0xFF;
-	*wave_cnt = 0;
 	pipe_idx = queue_idx / adev->gfx.mec.num_queue_per_pipe;
 	queue_slot = queue_idx % adev->gfx.mec.num_queue_per_pipe;
 	soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0, inst);
-	reg_val = RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, inst, mmSPI_CSQ_WF_ACTIVE_COUNT_0) +
-			 queue_slot);
-	*wave_cnt = reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
-	if (*wave_cnt != 0)
-		*vmid = (RREG32_SOC15(GC, inst, mmCP_HQD_VMID) &
-			 CP_HQD_VMID__VMID_MASK) >> CP_HQD_VMID__VMID__SHIFT;
+	reg_val = RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, inst,
+				  mmSPI_CSQ_WF_ACTIVE_COUNT_0) + queue_slot);
+	wave_cnt = reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
+	if (wave_cnt != 0) {
+		queue_cnt->wave_cnt += wave_cnt;
+		queue_cnt->doorbell_off =
+			(RREG32_SOC15(GC, inst, mmCP_HQD_PQ_DOORBELL_CONTROL) &
+			 CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) >>
+			 CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+	}
 }
 
 /**
@@ -981,9 +983,8 @@ static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
  * or more queues running and submitting waves to compute units.
  *
  * @adev: Handle of device from which to get number of waves in flight
- * @pasid: Identifies the process for which this query call is invoked
- * @pasid_wave_cnt: Output parameter updated with number of waves in flight that
- *                  belong to process with given pasid
+ * @cu_occupancy: Array that gets filled with wave_cnt and doorbell offset
+ *		  for comparison later.
  * @max_waves_per_cu: Output parameter updated with maximum number of waves
  *                    possible per Compute Unit
  * @inst: xcc's instance number on a multi-XCC setup
@@ -1011,30 +1012,24 @@ static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
  *    number of waves that are in flight for the queue at specified index. The
  *    index ranges from 0 to 7.
  *
- *    If non-zero waves are in flight, read CP_HQD_VMID register to obtain VMID
- *    of the wave(s).
+ *    If non-zero waves are in flight, store the corresponding doorbell offset
+ *    of the queue, along with the wave count.
  *
- *    Determine if VMID from above step maps to pasid provided as parameter. If
- *    it matches agrregate the wave count. That the VMID will not match pasid is
- *    a normal condition i.e. a device is expected to support multiple queues
- *    from multiple proceses.
+ *    Determine if the queue belongs to the process by comparing the doorbell
+ *    offset against the process's queues. If it matches, aggregate the wave
+ *    count for the process.
  *
  *  Reading registers referenced above involves programming GRBM appropriately
  */
-void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
-		int *pasid_wave_cnt, int *max_waves_per_cu, uint32_t inst)
+void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev,
+				 struct kfd_cu_occupancy *cu_occupancy,
+				 int *max_waves_per_cu, uint32_t inst)
 {
 	int qidx;
-	int vmid;
 	int se_idx;
-	int sh_idx;
 	int se_cnt;
-	int sh_cnt;
-	int wave_cnt;
 	int queue_map;
-	int pasid_tmp;
 	int max_queue_cnt;
-	int vmid_wave_cnt = 0;
 	DECLARE_BITMAP(cp_queue_bitmap, AMDGPU_MAX_QUEUES);
 
 	lock_spi_csq_mutexes(adev);
@@ -1048,42 +1043,30 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
 			  AMDGPU_MAX_QUEUES);
 	max_queue_cnt = adev->gfx.mec.num_pipe_per_mec *
 			adev->gfx.mec.num_queue_per_pipe;
-	sh_cnt = adev->gfx.config.max_sh_per_se;
 	se_cnt = adev->gfx.config.max_shader_engines;
 	for (se_idx = 0; se_idx < se_cnt; se_idx++) {
-		for (sh_idx = 0; sh_idx < sh_cnt; sh_idx++) {
+		amdgpu_gfx_select_se_sh(adev, se_idx, 0, 0xffffffff, inst);
+		queue_map = RREG32_SOC15(GC, inst, mmSPI_CSQ_WF_ACTIVE_STATUS);
+
+		/*
+		 * Assumption: queue map encodes following schema: four
+		 * pipes per each micro-engine, with each pipe mapping
+		 * eight queues. This schema is true for GFX9 devices
+		 * and must be verified for newer device families
+		 */
+		for (qidx = 0; qidx < max_queue_cnt; qidx++) {
+			/* Skip qeueus that are not associated with
+			 * compute functions
+			 */
+			if (!test_bit(qidx, cp_queue_bitmap))
+				continue;
 
-			amdgpu_gfx_select_se_sh(adev, se_idx, sh_idx, 0xffffffff, inst);
-			queue_map = RREG32_SOC15(GC, inst, mmSPI_CSQ_WF_ACTIVE_STATUS);
+			if (!(queue_map & (1 << qidx)))
+				continue;
 
-			/*
-			 * Assumption: queue map encodes following schema: four
-			 * pipes per each micro-engine, with each pipe mapping
-			 * eight queues. This schema is true for GFX9 devices
-			 * and must be verified for newer device families
-			 */
-			for (qidx = 0; qidx < max_queue_cnt; qidx++) {
-
-				/* Skip qeueus that are not associated with
-				 * compute functions
-				 */
-				if (!test_bit(qidx, cp_queue_bitmap))
-					continue;
-
-				if (!(queue_map & (1 << qidx)))
-					continue;
-
-				/* Get number of waves in flight and aggregate them */
-				get_wave_count(adev, qidx, &wave_cnt, &vmid,
-						inst);
-				if (wave_cnt != 0) {
-					pasid_tmp =
-					  RREG32(SOC15_REG_OFFSET(OSSSYS, inst,
-						 mmIH_VMID_0_LUT) + vmid);
-					if (pasid_tmp == pasid)
-						vmid_wave_cnt += wave_cnt;
-				}
-			}
+			/* Get number of waves in flight and aggregate them */
+			get_wave_count(adev, qidx, &cu_occupancy[qidx],
+					inst);
 		}
 	}
 
@@ -1092,7 +1075,6 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
 	unlock_spi_csq_mutexes(adev);
 
 	/* Update the output parameters and return */
-	*pasid_wave_cnt = vmid_wave_cnt;
 	*max_waves_per_cu = adev->gfx.cu_info.simd_per_cu *
 				adev->gfx.cu_info.max_waves_per_simd;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index 988c50ac3be0..b6a91a552aa4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -52,8 +52,9 @@ bool kgd_gfx_v9_get_atc_vmid_pasid_mapping_info(struct amdgpu_device *adev,
 					uint8_t vmid, uint16_t *p_pasid);
 void kgd_gfx_v9_set_vm_context_page_table_base(struct amdgpu_device *adev,
 			uint32_t vmid, uint64_t page_table_base);
-void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
-		int *pasid_wave_cnt, int *max_waves_per_cu, uint32_t inst);
+void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev,
+				 struct kfd_cu_occupancy *cu_occupancy,
+				 int *max_waves_per_cu, uint32_t inst);
 void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
 		uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr,
 		uint32_t inst);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 71b465f8d83e..29578550b478 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3540,6 +3540,26 @@ int debug_refresh_runlist(struct device_queue_manager *dqm)
 	return debug_map_and_unlock(dqm);
 }
 
+bool kfd_dqm_is_queue_in_process(struct device_queue_manager *dqm,
+				 struct qcm_process_device *qpd,
+				 int doorbell_off)
+{
+	struct queue *q;
+	bool r = false;
+
+	dqm_lock(dqm);
+
+	list_for_each_entry(q, &qpd->queues_list, list) {
+		if (q->properties.doorbell_off == doorbell_off) {
+			r = true;
+			goto out;
+		}
+	}
+
+out:
+	dqm_unlock(dqm);
+	return r;
+}
 #if defined(CONFIG_DEBUG_FS)
 
 static void seq_reg_dump(struct seq_file *m,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 08b40826ad1e..80be2036abea 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -324,6 +324,9 @@ void set_queue_snapshot_entry(struct queue *q,
 int debug_lock_and_unmap(struct device_queue_manager *dqm);
 int debug_map_and_unlock(struct device_queue_manager *dqm);
 int debug_refresh_runlist(struct device_queue_manager *dqm);
+bool kfd_dqm_is_queue_in_process(struct device_queue_manager *dqm,
+				 struct qcm_process_device *qpd,
+				 int doorbell_off);
 
 static inline unsigned int get_sh_mem_bases_32(struct kfd_process_device *pdd)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index a902950cc060..d73841268c9b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -270,6 +270,10 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 	struct kfd_node *dev = NULL;
 	struct kfd_process *proc = NULL;
 	struct kfd_process_device *pdd = NULL;
+	int i;
+	struct kfd_cu_occupancy cu_occupancy[AMDGPU_MAX_QUEUES];
+
+	memset(cu_occupancy, 0x0, sizeof(cu_occupancy));
 
 	pdd = container_of(attr, struct kfd_process_device, attr_cu_occupancy);
 	dev = pdd->dev;
@@ -287,9 +291,17 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 	/* Collect wave count from device if it supports */
 	wave_cnt = 0;
 	max_waves_per_cu = 0;
-	dev->kfd2kgd->get_cu_occupancy(dev->adev, proc->pasid, &wave_cnt,
+
+	dev->kfd2kgd->get_cu_occupancy(dev->adev, cu_occupancy,
 			&max_waves_per_cu, 0);
 
+	for (i = 0; i < AMDGPU_MAX_QUEUES; i++) {
+		if (cu_occupancy[i].wave_cnt != 0 &&
+		    kfd_dqm_is_queue_in_process(dev->dqm, &pdd->qpd,
+						cu_occupancy[i].doorbell_off))
+			wave_cnt += cu_occupancy[i].wave_cnt;
+	}
+
 	/* Translate wave count to number of compute units */
 	cu_cnt = (wave_cnt + (max_waves_per_cu - 1)) / max_waves_per_cu;
 	return snprintf(buffer, PAGE_SIZE, "%d\n", cu_cnt);
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 7744ca3ef4b1..e3e635a31b8a 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -71,6 +71,11 @@ enum kgd_memory_pool {
 	KGD_POOL_FRAMEBUFFER = 3,
 };
 
+struct kfd_cu_occupancy {
+	u32 wave_cnt;
+	u32 doorbell_off;
+};
+
 /**
  * enum kfd_sched_policy
  *
@@ -313,8 +318,9 @@ struct kfd2kgd_calls {
 			uint32_t grace_period,
 			uint32_t *reg_offset,
 			uint32_t *reg_data);
-	void (*get_cu_occupancy)(struct amdgpu_device *adev, int pasid,
-			int *wave_cnt, int *max_waves_per_cu, uint32_t inst);
+	void (*get_cu_occupancy)(struct amdgpu_device *adev,
+				 struct kfd_cu_occupancy *cu_occupancy,
+				 int *max_waves_per_cu, uint32_t inst);
 	void (*program_trap_handler_settings)(struct amdgpu_device *adev,
 			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr,
 			uint32_t inst);
-- 
2.35.1

