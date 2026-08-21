Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CDEC5DF89
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 14:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63E7C10E0A5;
	Fri, 21 Aug 2026 14:26:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="04LdTGpP";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F15410E0A5
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 14:26:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiP0FZpjQOE0FN2IJ/OPXZ6mVtTY/5q2g7iXwXCJXDqui+BGl+00xwvE9Ath5d1ZORkYPficrDksEtY9pflpDrxtHKvRssv9/+lnaSWmEe8/PbcGQR3ZWBvLg05an6o8hIJkYwbz7uLhJXlHTX0PfpIfREGAjW77ncyl31X9cO00HYUYhQxojSt7j/FMQjPm73TshG4KzM+qlgEfQ/QilxCCB62SU8snpGQ1DqXfV0JD429g+6BueqGqIV+Kl72+BZrd7T1lqD6Q3wA1D3zDVQ/Okw6CxGX4DNJrnvhC/dnvnfa/2O7IUz6TrjUVbP6v9bjmzudPXazkkUX00RORfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzR/pMnm5TsfNiWCvW0jTO2HPXN92BwMnLGk1nGct8E=;
 b=KjDpqY1esFW0tvqSAPJNzyYQ3N4u8mfVV0XGmHVe8/InDreWxl3t+J97SDjn/R5Fcv9HtJ2GpSACJ4FF85Xa9oTsGfwZF+OFzeUZ5sO6X3E2h+c1j355OCB9w1zNg3xKzZBIInbWDvgw1I4G/mYMj7CopDv6DkX/asKxtAkNOOZOVulsH9XoM/iJuQR6xeXHAK7zQ6QyNftAYU7briAXRCz3IuLzkHrU51MH139leW6Gaw8Tdm2wSriwfFFmSYkcv2i4qdrkz4PpgUJp6mNPdnrjrOK50X6DV7F04DnwTjQliu4o0yCJ5hWEatL1SZxr7x/EPS87N/zBhpXhZ/eoqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzR/pMnm5TsfNiWCvW0jTO2HPXN92BwMnLGk1nGct8E=;
 b=04LdTGpPOBl0113jAcBgVZAqjjwlI8RpgEbQc/MNAA+xm/d7sUk6ohyJerbWrwMT0S9tTZ0xOnI5AiD6aleK1fhMrxOnnsciuCnltyQh1+8K1cJzw6yaaPo2F04Xoybhhhl4EgJGz8dr0KonelJhsH1g+AqYyW7VkscJqMnh3yw=
Received: from BLAPR03CA0025.namprd03.prod.outlook.com (2603:10b6:208:32b::30)
 by LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 14:25:53 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::8d) by BLAPR03CA0025.outlook.office365.com
 (2603:10b6:208:32b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.9 via Frontend Transport; Fri, 21
 Aug 2026 14:25:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 14:25:52 +0000
Received: from belanger-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 09:25:52 -0500
From: David Belanger <david.belanger@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Belanger <david.belanger@amd.com>
Subject: [PATCH 1/2] drm/kfd: Add CU occupancy support to GFX10 and GFX10.3
Date: Fri, 21 Aug 2026 10:25:25 -0400
Message-ID: <20260821142526.276153-1-david.belanger@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|LV8PR12MB9620:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e38bb86-4d78-407c-1608-08deff901b3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|56012099006|10067099003|3023799007|6133799003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: KsEpJqD9Y8rVbgmdgz1GH2EUqYNDpiD1Cly4R0Cmam59u1Ahdq4fysAPx+jifMOC+t49QPwqZ1Z4nlQN6hKJltjeZ/W/vsS/2p7+qiJLd1MQcYFaINMi3UdxesF78L1+BrOWRVNwxNnhdnPERD5bCxyZqUz5lk/25n3tg225GyL6Aph9xgWCPJL6WF4cs92gY3bB7aCtK3bs0OYQvKSrmBlmvDh+8+v2hgXCn+vSXDMmuB9SRyvkr/pAsgBE64D7noDUAuNDrHNjGuGpdw1HiWtXXPDwioY5TT2+/HGUSeDdNS9BbiI0gSjzWLUYThiwvM5B6mZ7B2xd/QJYgCWIj/t5rz280IvQQm6MMWd0jvupZAijTZDUyovF4Y9nUWN07YmYoGgLWS+rYLgM1rL1nZhduud9oF57S8GTQP8wRbzi35uplzT4Jp7XNejzdDEBu842yvv03PTdAbwEiA+uXrMbLDxe83A0JAkMS8zV0WhmJyQZ5fOUg4UQJx8wKFRRDteWy5aAAVN/2PFBRmGxT3PrrzcqV89J8T+a2PeEhVs7zD5dihwcLWbZ7A50xafE4SRWwR0U2JHtrA6xL2JwQSIQgFppQLvR0V5jWbAbUXvEN0OUmEhxqhJIm2ZxjDfPYVkYop23cf57IIjZYxLZ516UN/ImIqP4Jf19HwgXmXyHfVRla8Svq2fCR/DntKBC4RfmsBdy+AiXUJ4DQuYIwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(56012099006)(10067099003)(3023799007)(6133799003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VLQikyIsdKW7ISz64Zjyuph+uzsp9yjKGwBhGgmGq3UGaImM94njNhGen7CqIvwjOgZXV/FwvzRmVPvERI5gd51SozPN8a93bGWDXG6uPix+9GKcCr3Z8eWUP6FiA+S23tyYoEKWIYcl6Kqp1VcbPEJu8UjWFR8U5GxlFc1+91tURPNiyxoXA840cqFk6x40YS55v623+XyfsAJOqyyMlxaU3M8IHj/U9QTByEtfTOYJOsRPm7hDx2ANmbYMPRXL6jLkVQRuw3watZRdg/tWXiCgI28otkh5kvrxd7/cnCsmu8mPtC0nZfsVNBbpyiaRy4wimfDG5ZnT45DMhKzayiU4RHc9PhWMqDLTqKMqtyHqTHPrX8LnZ2Yw88mKnPvT8zS2Ymb3bJ9TZt6g2DENpBg/nrpfqrPQsODgURULEMMt+akMn/PvNqtbODRUYzAo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 14:25:52.9910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e38bb86-4d78-407c-1608-08deff901b3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9620
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

Port changes from GFX9 to GFX10/GFX10.3 mostly as-is.
Minor changes to register access code.

Assisted-by: Claude:sonnet-4-6
Signed-off-by: David Belanger <david.belanger@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 148 ++++++++++++++++++
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |   3 +
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |   1 +
 3 files changed, 152 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 88acf75f0edd6..4c48f6afb736b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -1090,6 +1090,153 @@ uint32_t kgd_gfx_v10_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
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
+	 * parameters to read out waves in flight. Get doorbell offset if there are
+	 * non-zero waves in flight.
+	 */
+	pipe_idx = queue_idx / adev->gfx.mec.num_queue_per_pipe;
+	queue_slot = queue_idx % adev->gfx.mec.num_queue_per_pipe;
+	nv_grbm_select(adev, 1, pipe_idx, queue_slot, 0);
+	reg_val = RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, 0,
+				  mmSPI_CSQ_WF_ACTIVE_COUNT_0) + queue_slot);
+	wave_cnt = reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
+	if (wave_cnt != 0) {
+		queue_cnt->wave_cnt += wave_cnt;
+		queue_cnt->doorbell_off =
+			(RREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL) &
+			 CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) >>
+			 CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+	}
+}
+
+/**
+ * kgd_gfx_v10_get_cu_occupancy: Reads relevant registers associated with each
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
+void kgd_gfx_v10_get_cu_occupancy(struct amdgpu_device *adev,
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
+	nv_grbm_select(adev, 1, 0, 0, 0);
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
+					 mmSPI_CSQ_WF_ACTIVE_STATUS);
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
+	nv_grbm_select(adev, 0, 0, 0, 0);
+	unlock_spi_csq_mutexes(adev);
+
+	/* Update the output parameters and return */
+	*max_waves_per_cu = adev->gfx.cu_info.simd_per_cu *
+				adev->gfx.cu_info.max_waves_per_simd;
+}
+
 const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
 	.program_sh_mem_settings = kgd_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_set_pasid_vmid_mapping,
@@ -1119,5 +1266,6 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
 	.program_trap_handler_settings = program_trap_handler_settings,
 	.hqd_get_pq_addr = kgd_gfx_v10_hqd_get_pq_addr,
 	.hqd_reset = kgd_gfx_v10_hqd_reset,
+	.get_cu_occupancy = kgd_gfx_v10_get_cu_occupancy,
 	.hqd_sdma_get_doorbell = kgd_gfx_v10_hqd_sdma_get_doorbell
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
index a4c607c881783..47ab25d611727 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
@@ -68,3 +68,6 @@ uint64_t kgd_gfx_v10_hqd_reset(struct amdgpu_device *adev,
 			      unsigned int utimeout);
 uint32_t kgd_gfx_v10_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
 					   int engine, int queue);
+void kgd_gfx_v10_get_cu_occupancy(struct amdgpu_device *adev,
+				struct kfd_cu_occupancy *cu_occupancy,
+				int *max_waves_per_cu, uint32_t inst);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index e31afee429793..50535563efa86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -683,5 +683,6 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd = {
 	.clear_address_watch = kgd_gfx_v10_clear_address_watch,
 	.hqd_get_pq_addr = kgd_gfx_v10_hqd_get_pq_addr,
 	.hqd_reset = kgd_gfx_v10_hqd_reset,
+	.get_cu_occupancy = kgd_gfx_v10_get_cu_occupancy,
 	.hqd_sdma_get_doorbell = kgd_gfx_v10_hqd_sdma_get_doorbell
 };
-- 
2.51.1

