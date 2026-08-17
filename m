Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C23C5DF74
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 21:49:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD3C610E95F;
	Mon, 17 Aug 2026 21:49:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dDsgQOAN";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011043.outbound.protection.outlook.com
 [40.93.194.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C72810E95F
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 21:49:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+J+PKoaksvKR04lOmmaikScaTpgAzgHq+X9M7N82NRqPoC6QFVYYnYCnainE90ZeCKhG/tWAbfnt6vRvduq/5AjaSS8b0TME5D5/bjgqRdaRVj8KENLh9wm512GA7MzhL/emllI+9+NazXYAIZUGsfwZTtjxRZAtcWFGBXgKqT0QJfqnfHjzQHX2z4nwLKnblbbFM4SOXcu3J0RZt1lVVfdwcBsh1VimzGXRT4w1T1wj8OQqQRercw4gr1+HM0EgG2ykGNLYRRkOU/NObIn8ZEQS/AZTogsSd0apeQAZaKBV3SmaCF/bQAk3UusG76oPpRw6LAfA95KR4J63n3VXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMC8J8J57z2IELH8az2+VPsWsqvMVhWtdtnYCp6VJ08=;
 b=vk2sGcBiSTdrUPKPOMX/HMZ0KyokLum9fMh3iphqqouAOlQWdjEOj9R/e4OeV6BUNrXXhSFtICYMFKIN5Pe+HAVlOvwk/QMz54+rcQ8gXh3VA801MwZ1ae65T1Owz80ogIkcRtH/BQfIy7z38Xl6Xo4OdhRQc8qMz9LUFcgtTltilkVXCwwsAHFAqz1/Hlr9SBT4FECAzl38iMvykG+zU8TySTGhKe/wvXsVD0xPOlal2WH6mPW0WdX+vDLkU/HsPLTgDcLmYF1UgqXF6qzrVEV+2gUafmlE5oMukLHAfeTixxrXtdAwLvUVjgUeXolpT6lElhm9gp5cE3yn7Wxkqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMC8J8J57z2IELH8az2+VPsWsqvMVhWtdtnYCp6VJ08=;
 b=dDsgQOANaqAhiov8X+ZstYaFNEBctSpsF/6JagXmC7npoc6zc4o4s3x/77e4IXtp5NHv3zK050I+QX/wt2IQzU3f6rdADmRk+HgXQKdNJrUWjyh2NJh0uT5h+6CLPpTL03UfpPcNcHlnNoNxYHUouRT9iF6b7iVf9+0lTizGFGA=
Received: from BLAPR03CA0052.namprd03.prod.outlook.com (2603:10b6:208:32d::27)
 by SA1PR12MB8965.namprd12.prod.outlook.com (2603:10b6:806:38d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 21:49:27 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::59) by BLAPR03CA0052.outlook.office365.com
 (2603:10b6:208:32d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Mon,
 17 Aug 2026 21:49:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Mon, 17 Aug 2026 21:49:26 +0000
Received: from belanger-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 16:49:25 -0500
From: David Belanger <david.belanger@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Belanger <david.belanger@amd.com>
Subject: [PATCH] drm/kfd: Add CU occupancy support to GFX12.1
Date: Mon, 17 Aug 2026 17:49:07 -0400
Message-ID: <20260817214908.99287-1-david.belanger@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|SA1PR12MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: df043cd3-8d61-4942-118f-08defca96866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|6133799003|10067099003|11063799006|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: hB5bXOldt6NA3rF3y64fEgZXUG6DHfuBCQgYBxPol7RnOUQK1xVFO6K8sv4LJ8HYUicDuoA8d492Jz1moCVjQ+DU+quPnhW9/s5EoQaSIGvGMvYsh1XpYRHZgf+x50S2MWi7mJCrcZD0vmzYUIoZOs62eVWnsbqXQoQ9H+xy4urBXJG1980UsmYhPuZdqD3UWzhktlV8kq2vBR8z5wpvo8kkTod51/KRWp4NDv7NUDpAMKETjlwiwZH75NqWOI/hVDUg9ajBkllPLO2OA707htEwrAPAehK+PtlXnGk4nhzbflrD6X/B2Az9xtz8bYGdzZxvo2MMK4i184jGiDPMiw8nwuhy6d26kLXAxQpo/0m/zzlL8z+zqKeJwcTs3hCmKifzAkTNoxQ5p1DAlHlcBx+WP7VPx/01PX5e8nKHlhgUPA4uTBIeHz7GiCR/Mx+nJ8HgoUwLljq29iafybZNNnJ1gnM6scVdQnNXEB5+tEgkn2Rb24wQMZa07zRCSwucarxzg4X92LOqt0bD6aLjwYXHNHnW49Jtfm9LMhyBppP6uF49mhx/h/SxeGnsym67Xo91pXf6I9/Dc9URNlDdul+PAo0VxozAOMBHMFP/kbgTuZD+ug0Si3alhej+8ZXstBFgGQAKHBzNsPGsOs+Qi0q1dzafiWY0M3QOx0etFT9bQgYBiwzJ3osqkgljhlfP8Gf5o5KMtlCQu2Z+Ovh07w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GmnuL6pBuYpx43Se9ytKFDOzBteODfh17swq3U7xa5YEnCjXhAenII6WK0ze2oE3CBQ/jz/SNKLH1PoJJqLkJj3sTFfqwl6df2uPSYSloKlmF5t2aNJbTmo9rinWiL9t25F2IGSjKayZNhoxZCxb2zsMQ7pf+pTfa4FFjmsTQnzz/9SK1fm9odn260Obem+mC/OC6oUkiisfr2D8EtKe3cy4+hNKTAdYr1xDAJ8RgmFV93IzFl5jNAcXIApYOrHLf52XZvpzz12BeWpRIrMoY8v9SYZz+17KttsFb773OWbpp7YTT5n6nMS+z35NOKNhqFM3qNYkECIyY4vb6AUnHVHEcS2fCbY/H7wfEErEgtnhEPwwprMM1HfTyYB2Hx5Nrm4fy+jUCQb3N8u8RSlej3TJNY2VbyYx6cYC/WXrTbiJ7bfoe26OUhURZQaaH7Q5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 21:49:26.3933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df043cd3-8d61-4942-118f-08defca96866
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8965
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

Port changes from GFX9 to GFX12.1 mostly as-is.
Minor changes to register access code.

Assisted-by: Claude:Sonnet 4.6
Signed-off-by: David Belanger <david.belanger@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c  | 150 +++++++++++++++++-
 1 file changed, 149 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
index 38ca1aea33b2f..b9a4a365e58ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
@@ -371,6 +371,153 @@ static uint32_t kgd_gfx_v12_1_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
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
+	amdgpu_gfx_select_me_pipe_q(adev, 1, pipe_idx, queue_slot, 0, inst);
+	reg_val = RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
+				  regSPI_CSQ_WF_ACTIVE_COUNT_0) + queue_slot);
+	wave_cnt = reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
+	if (wave_cnt != 0) {
+		queue_cnt->wave_cnt += wave_cnt;
+		queue_cnt->doorbell_off =
+			(RREG32_SOC15(GC, GET_INST(GC, inst), regCP_HQD_PQ_DOORBELL_CONTROL) &
+			 CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) >>
+			 CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+	}
+}
+
+/**
+ * kgd_gfx_v12_1_get_cu_occupancy: Reads relevant registers associated with
+ * each shader engine and aggregates the number of waves that are in flight
+ * for the process whose pasid is provided as a parameter. The process could
+ * have ZERO or more queues running and submitting waves to compute units.
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
+static void kgd_gfx_v12_1_get_cu_occupancy(struct amdgpu_device *adev,
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
+	amdgpu_gfx_select_me_pipe_q(adev, 1, 0, 0, 0, inst);
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
+		queue_map = RREG32_SOC15(GC, GET_INST(GC, inst),
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
+	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, inst);
+	unlock_spi_csq_mutexes(adev);
+
+	/* Update the output parameters and return */
+	*max_waves_per_cu = adev->gfx.cu_info.simd_per_cu *
+				adev->gfx.cu_info.max_waves_per_simd;
+}
+
 const struct kfd2kgd_calls gfx_v12_1_kfd2kgd = {
 	.init_interrupts = init_interrupts_v12_1,
 	.hqd_dump = hqd_dump_v12_1,
@@ -384,5 +531,6 @@ const struct kfd2kgd_calls gfx_v12_1_kfd2kgd = {
 	.set_wave_launch_mode = kgd_gfx_v12_1_set_wave_launch_mode,
 	.set_address_watch = kgd_gfx_v12_1_set_address_watch,
 	.clear_address_watch = kgd_gfx_v12_1_clear_address_watch,
-	.hqd_sdma_get_doorbell = kgd_gfx_v12_1_hqd_sdma_get_doorbell
+	.hqd_sdma_get_doorbell = kgd_gfx_v12_1_hqd_sdma_get_doorbell,
+	.get_cu_occupancy = kgd_gfx_v12_1_get_cu_occupancy
 };
-- 
2.51.1

