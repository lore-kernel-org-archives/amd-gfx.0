Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D74BC5B572
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 19:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEF2710E45C;
	Mon, 17 Aug 2026 19:50:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x6M+TB6L";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013046.outbound.protection.outlook.com
 [40.93.196.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E2C210E45C
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 19:50:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHST4shd2Vx8+OuSUE8qSeoMxESKGvEyTM+PacLM3rRTvhu5Wx61kBgC7Hq2E/CyqynBS7ntG8Iewwbbaz9jGa7G9dK5RkICP/7qTLcFGnO0eTaJwzfYjYchOWAX2SEV+aoOJgNUQ+enrHzjz6l05eQGjeBpE0S5pzkUYS76AdZCkrbsQxHCURwbps7hY5Knbn8mAZr9DqyoGcLXoCrWbyjVwohOhtZyEj6dSzcAS+H/nWBRvL0IN3Rq9CxCcgzv3mflA7hV5LbbEwzQtMsmPCiA3yznEUg+1gjXrqwBgwvHvir2kkjvxRW1HbwkVI12Dh0vlx8dvdz7e7mXn75jpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmMvtLUrWt13cjcnenpz0JH+ymC7uhOxJ2nnfEEPQFM=;
 b=GryPgWpUtKz8xNpsSP/gjg+akgboEI6jA0zxcL0s6zYbRb446LkxRY62/kiD+lRK/N/3AjA5ui1uv5neX6ESkNgB3QktVSoM33g7YtndS//VAHMRDMXUPeGqwdDT/X4JMqhGqAomG38acM3ov/xAIqZMToNLADSMUoq6pE60x2ctCFj1LSAzch48XPLPkK8yH0guRb1pJhMu3kbwBODdCS9rMZDGMQT+1pUpS+D+MDxy2DCo2tVsdCSYBmrk09A7cB0jllr2V4urGe6CUqR0Ow52EmhQVXaM7E0H9NFUov8KJJJ09m3XZthu/ta3Ye+dH5PAOjvTbmkDIl/9DMPxjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmMvtLUrWt13cjcnenpz0JH+ymC7uhOxJ2nnfEEPQFM=;
 b=x6M+TB6LriL5v0gsvloYepjzj6LTTTO8HJvE6dOs3p3k7oYOaviFzizxX+spvZLnlYNBy1Bj/EXin03WPmCHezvcCYUxaG29CJJFjGT9b61P9Bs99G1Qoo0ojZ5N9EkXloWEYzy1ML6xwalY6lNWPUs06SUUUVnSGsAygJw0sEI=
Received: from SJ0PR05CA0038.namprd05.prod.outlook.com (2603:10b6:a03:33f::13)
 by DS7PR12MB9528.namprd12.prod.outlook.com (2603:10b6:8:252::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 19:50:28 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::a1) by SJ0PR05CA0038.outlook.office365.com
 (2603:10b6:a03:33f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Mon, 17
 Aug 2026 19:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Mon, 17 Aug 2026 19:50:27 +0000
Received: from belanger-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 14:50:27 -0500
From: David Belanger <david.belanger@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Belanger <david.belanger@amd.com>
Subject: [PATCH 2/2] drm/kfd: Add CU occupancy support to GFX12
Date: Mon, 17 Aug 2026 15:49:53 -0400
Message-ID: <20260817194953.97887-2-david.belanger@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260817194953.97887-1-david.belanger@amd.com>
References: <20260817194953.97887-1-david.belanger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|DS7PR12MB9528:EE_
X-MS-Office365-Filtering-Correlation-Id: f2dac2a1-4d6e-41f9-f41e-08defc98c97d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|3023799007|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: edfwbb1Oheb6e7iSKf7vxDN5+QUcT39ERZ+EMIXf8pi5kog7Fle6OiaJ6qKu421D+PwIXWnrPBAHvxf83BsN1JKJeW5hi19NRlI/QxgTUrsBiDHskiEiS+ysApdIWjRwOYOt97v8cIQjl7Oz/CfCEN//vkpgox4o3fWSpMSHf3rJRNq9dRxXCLqt3OsRjZbGkUhs1LX43SVv1fcFbas9x0DpZaPsc9zA7tYobzqBiLOdJIXEPTJ6+ZLKGxLLrcRKBJpg8btJJE9N8vSSJPfBUZC+C9Mlzbj9+OYtaeC1uu9vfxR70Owk/ZPzJwD8FzL2KikvGZvabE3mAQs4atrTie7C3q19FVAdn+WVWohWiL5i42LNZK5oMiDOABT6f50xJFvwiFFVJYD+AZSUWQfqIq03Je33j/txx5pJQJA5VJJts77ndyN2WR3K7omZMLT51OLFEJ6Ta2QXoIFYQ5hlec9epsa75Zkxf3iNx+nbQpKdzowj8Jr5ltURfnldc6VD+MnW3iN9b8K9+24hB2uDvLbaJm+7I6XqJtu1P40h5gQIZ6OByQekNFqrAWAQpe3/zN66/l9Fsxqj5HNR7lzxYItVymK2Jcr6g0Eb68LeIeIXDRKgMS9BPI3qKw/QQ5065FSCv1obl65QPDzdxKNoJvwwQLNjsp2ypECKnR8tk0xJBOQtMgb6aAqOzgCvyfAfHpqjE6GPQwRHlWqs6xnSoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(3023799007)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iTonZq9kePV17aQeh5jOC3poS5leOwWMdED7lpTJyaXNL5+CyDuSclM4N9TeCfzdz5GorVI7MxSsTnMujY+ORbCrs5s5O060i2j8AAmQt0DQvucuwM+uTqLoStvMowaaBnek4HPcq9sfi/MIKbo8FlOintTj8y2dAZ4WJND2qWJlXhxtEsX3f6eYiydL37L5AZjpswS7w3hZT7SV2CkQ1BGTqc8/McitORYjEIjdJd31M164j+7rNayIf0wRWQwdo8ZjU/lOpD+6b/C+ygPMArDYVB+FgP/tAFAy3X9QaRsdKYqAtPOP3pdMsGvqCBCix94TWbqyhMa8mRVorNOSwJ5S4WKnlgxUNNdpb14m/p3pYCSxUeyFFi5rOQlNroxz3veFjaUMfj3CcrynL7px+aoB/St+v/wDbtuQWcI/5vu3hiIzJGS35aGMKTi9c3nQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 19:50:27.8227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2dac2a1-4d6e-41f9-f41e-08defc98c97d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9528
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

Port changes from GFX9 to GFX12 mostly as-is.
Minor changes to register access code.

Assisted-by: Claude:Sonnet 4.6
Signed-off-by: David Belanger <david.belanger@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c    | 150 +++++++++++++++++-
 1 file changed, 149 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
index e11ba3e918411..c7717cf0e148f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
@@ -368,6 +368,153 @@ static uint32_t kgd_gfx_v12_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void lock_spi_csq_mutexes(struct amdgpu_device *adev)
+{
+	mutex_lock(&adev->srbm_mutex);
+	mutex_lock(&adev->grbm_idx_mutex);
+
+}
+
+static void unlock_spi_csq_mutexes(struct amdgpu_device *adev)
+{
+	mutex_unlock(&adev->grbm_idx_mutex);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
+/**
+ * get_wave_count: Read device registers to get number of waves in flight for
+ * a particular queue. The method also returns the doorbell offset associated
+ * with the queue.
+ *
+ * @adev: Handle of device whose registers are to be read
+ * @queue_idx: Index of queue in the queue-map bit-field
+ * @queue_cnt: Stores the wave count and doorbell offset for an active queue
+ * @inst: xcc's instance number on a multi-XCC setup
+ */
+static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
+		struct kfd_cu_occupancy *queue_cnt, uint32_t inst)
+{
+	int pipe_idx;
+	int queue_slot;
+	unsigned int reg_val;
+	unsigned int wave_cnt;
+	/*
+	 * Program GRBM with appropriate MEID, PIPEID, QUEUEID and VMID
+	 * parameters to read out waves in flight. Get VMID if there are
+	 * non-zero waves in flight.
+	 */
+	pipe_idx = queue_idx / adev->gfx.mec.num_queue_per_pipe;
+	queue_slot = queue_idx % adev->gfx.mec.num_queue_per_pipe;
+	soc24_grbm_select(adev, 1, pipe_idx, queue_slot, 0);
+	reg_val = RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, 0,
+				  regSPI_CSQ_WF_ACTIVE_COUNT_0) + queue_slot);
+	wave_cnt = reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
+	if (wave_cnt != 0) {
+		queue_cnt->wave_cnt += wave_cnt;
+		queue_cnt->doorbell_off =
+			(RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL) &
+			 CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) >>
+			 CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+	}
+}
+
+/**
+ * kgd_gfx_v12_get_cu_occupancy: Reads relevant registers associated with each
+ * shader engine and aggregates the number of waves that are in flight for the
+ * process whose pasid is provided as a parameter. The process could have ZERO
+ * or more queues running and submitting waves to compute units.
+ *
+ * @adev: Handle of device from which to get number of waves in flight
+ * @cu_occupancy: Array that gets filled with wave_cnt and doorbell offset
+ *		  for comparison later.
+ * @max_waves_per_cu: Output parameter updated with maximum number of waves
+ *                    possible per Compute Unit
+ * @inst: xcc's instance number on a multi-XCC setup
+ *
+ * Note: It's possible that the device has too many queues (oversubscription)
+ * in which case a VMID could be remapped to a different PASID. This could lead
+ * to an inaccurate wave count. Following is a high-level sequence:
+ *    Time T1: vmid = getVmid(); vmid is associated with Pasid P1
+ *    Time T2: passId = getPasId(vmid); vmid is associated with Pasid P2
+ * In the sequence above wave count obtained from time T1 will be incorrectly
+ * lost or added to total wave count.
+ *
+ * The registers that provide the waves in flight are:
+ *
+ *  SPI_CSQ_WF_ACTIVE_STATUS - bit-map of queues per pipe. The bit is ON if a
+ *  queue is slotted, OFF if there is no queue. A process could have ZERO or
+ *  more queues slotted and submitting waves to be run on compute units. Even
+ *  when there is a queue it is possible there could be zero wave fronts, this
+ *  can happen when queue is waiting on top-of-pipe events - e.g. waitRegMem
+ *  command
+ *
+ *  For each bit that is ON from above:
+ *
+ *    Read (SPI_CSQ_WF_ACTIVE_COUNT_0 + queue_idx) register. It provides the
+ *    number of waves that are in flight for the queue at specified index. The
+ *    index ranges from 0 to 7.
+ *
+ *    If non-zero waves are in flight, store the corresponding doorbell offset
+ *    of the queue, along with the wave count.
+ *
+ *    Determine if the queue belongs to the process by comparing the doorbell
+ *    offset against the process's queues. If it matches, aggregate the wave
+ *    count for the process.
+ *
+ *  Reading registers referenced above involves programming GRBM appropriately
+ */
+static void kgd_gfx_v12_get_cu_occupancy(struct amdgpu_device *adev,
+				struct kfd_cu_occupancy *cu_occupancy,
+				int *max_waves_per_cu, uint32_t inst)
+{
+	int qidx;
+	int se_idx;
+	int se_cnt;
+	int queue_map;
+	int max_queue_cnt;
+	DECLARE_BITMAP(cp_queue_bitmap, AMDGPU_MAX_QUEUES);
+
+	lock_spi_csq_mutexes(adev);
+	soc24_grbm_select(adev, 1, 0, 0, 0);
+
+	/*
+	 * Iterate through the shader engines and arrays of the device
+	 * to get number of waves in flight
+	 */
+	bitmap_complement(cp_queue_bitmap, adev->gfx.mec_bitmap[0].queue_bitmap,
+			  AMDGPU_MAX_QUEUES);
+	max_queue_cnt = adev->gfx.mec.num_pipe_per_mec *
+			adev->gfx.mec.num_queue_per_pipe;
+	se_cnt = adev->gfx.config.max_shader_engines;
+	for (se_idx = 0; se_idx < se_cnt; se_idx++) {
+		amdgpu_gfx_select_se_sh(adev, se_idx, 0, 0xffffffff, inst);
+		queue_map = RREG32_SOC15(GC, 0,
+					 regSPI_CSQ_WF_ACTIVE_STATUS);
+
+		for (qidx = 0; qidx < max_queue_cnt; qidx++) {
+			/* Skip queues that are not associated with
+			 * compute functions
+			 */
+			if (!test_bit(qidx, cp_queue_bitmap))
+				continue;
+
+			if (!(queue_map & (1 << qidx)))
+				continue;
+
+			/* Get number of waves in flight and aggregate them */
+			get_wave_count(adev, qidx, &cu_occupancy[qidx], inst);
+		}
+	}
+
+	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, inst);
+	soc24_grbm_select(adev, 0, 0, 0, 0);
+	unlock_spi_csq_mutexes(adev);
+
+	/* Update the output parameters and return */
+	*max_waves_per_cu = adev->gfx.cu_info.simd_per_cu *
+				adev->gfx.cu_info.max_waves_per_simd;
+}
+
 const struct kfd2kgd_calls gfx_v12_kfd2kgd = {
 	.init_interrupts = init_interrupts_v12,
 	.hqd_dump = hqd_dump_v12,
@@ -381,5 +528,6 @@ const struct kfd2kgd_calls gfx_v12_kfd2kgd = {
 	.set_wave_launch_mode = kgd_gfx_v12_set_wave_launch_mode,
 	.set_address_watch = kgd_gfx_v12_set_address_watch,
 	.clear_address_watch = kgd_gfx_v12_clear_address_watch,
-	.hqd_sdma_get_doorbell = kgd_gfx_v12_hqd_sdma_get_doorbell
+	.hqd_sdma_get_doorbell = kgd_gfx_v12_hqd_sdma_get_doorbell,
+	.get_cu_occupancy = kgd_gfx_v12_get_cu_occupancy,
 };
-- 
2.51.1

