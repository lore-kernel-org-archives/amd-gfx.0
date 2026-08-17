Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70677C5DF66
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 19:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA06710E44C;
	Mon, 17 Aug 2026 19:50:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DxB6ZCsj";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013070.outbound.protection.outlook.com
 [40.107.201.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B96FC10E44C
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 19:50:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QF59X3wNS/aiSRC0rEAzioEtrSNjv3gGAG/Q0cclx6TeQZGgsh0ZM06UC55ErlnGX/cl1mUkZJ5P15Mlu/Jp6LOnLofmG8k5sgbAqozuJXdwVRjrqv7oZExYQBhXGjtYKaKQMn9U1108nFK0gqPx1RnA4mmEwwkKBGYGLjIjjjTyiB3S4lyaJ/tAkU/jbsfEGi0i0V9nDv3ID9d7essEM/Tq2lF+9T7rKoK6Y19tMR4G+rC99qCwvq058d/kU9XRksuOCVc6TNwQ9mbbwmpbPkEKiT17Yf0c2OtfA3gyT8iCSTveyy40BhtTNo97/tuUikdf9KggYIQyE6jj294S2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2t1LpcknMEjPJn+W2caHr4/vc7j6KwLAfXEEJ5Il7k=;
 b=YYv4MxLQqHn+lgdB2CBLEfoknDoUIx6qvZVbxdzz6mLNZt7yAbR8vyU6UHbcAuPgM7PuLoIEsEbKMl3c635fLulYe7T9sEEp3BW6UklTCsSh+yYTV0dcKJQ1qba7dMTOe3hJDrGsEnMTFzDDh7jB/wLwBM9d2hjfXEy/gILn+d25zSIiR5o46AhLleP9oRqIxbxOd+H127Kz/M4SoG2WTZog+H3prwMtUhE18rizHh5gtQD33Iso3c4wXo27OE37oKOcfGRN+5B6w28FPFKhTTdaMx4LJ3yHvM7nI4Igl/0X59NocVqR9fCYEsCXbuU2/wkf1LcfuqIR0Nc3YzMCQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2t1LpcknMEjPJn+W2caHr4/vc7j6KwLAfXEEJ5Il7k=;
 b=DxB6ZCsjvtXLR3n/WTgCGBb+LIEDWVWyic2QLypioTltF+JUiyLFVYxHnH4xK8xrX4ArmjHl0WIIM6Z53x05MCuvbRX2dyhzpMFAnHyl/DEgJyCcIt6EIwly4M53BPirZ8ywJZQumm8//qzcd5sonlIvWSp64N+uYhqeBInMdpM=
Received: from SJ0PR05CA0046.namprd05.prod.outlook.com (2603:10b6:a03:33f::21)
 by SA1PR12MB6894.namprd12.prod.outlook.com (2603:10b6:806:24d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Mon, 17 Aug
 2026 19:50:24 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::16) by SJ0PR05CA0046.outlook.office365.com
 (2603:10b6:a03:33f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Mon, 17
 Aug 2026 19:50:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Mon, 17 Aug 2026 19:50:21 +0000
Received: from belanger-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 14:50:20 -0500
From: David Belanger <david.belanger@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Belanger <david.belanger@amd.com>
Subject: [PATCH 1/2] drm/kfd: Add CU occupancy support to GFX11
Date: Mon, 17 Aug 2026 15:49:52 -0400
Message-ID: <20260817194953.97887-1-david.belanger@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|SA1PR12MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: f1aaf87f-c85f-46a8-1583-08defc98c5b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|11063799006|3023799007|56012099006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: Hrsfqm56GwQzs8uKSppt/lnzoXC8ZgpbF3DEgR9i6YcS2vBWbv5czVXFz5aUDbC4IC6kBa5gyV2HR3/1cy5fdVxlUMvhNY7aQ9UfOWOGZozH3/kMomFR1YDyBaqY1yw+U8zdF8Zx06Pa9jKTAePqH+aovO9tP25Cs/57sBwQsyCge5+BebERIOI+lCz/1rK34DTHw4+CdYnmujT+t0cwnKKkrd95g/89tuiNepCzz1B6APYwdZDmRUyDouNblQBFo+xPvFoP24VLZJ+ocq0gs153cpObt4W/d0fWRrpqtiw6bGkp+MI0lvJvW6ueopK/zvJ1j87yav0SVgPS92i/+R2IvStFxilJtpeJqVTXgZ40aE3Cs2+iX1JjR50LGaWwwRkMlvYvJD6DU8a93jQaMQUwyCzWxDTk9GZhO7GBr62mPiv25ufJ5liPv+iQBX3W7Lcmwqp2x5vmiBejLHXwaMxCNRzl6mZLF6AOq47btD41BuwH6/Z9ImhjpHGWY3NcWPnqG3IliT0c3RQWe6dAIWT5KXIKIZK8Jn5tzJT61Ov93Aa3SgKP/kbr587orxkVBb1so1zGoWG3D1xpl23GPCH7p8K50wJtbVE2XIp6Dh0XZMSGqFGktOP5Lw/cMYvmRsSob+5GxJxv3+VETIkprKcN3oWgu4E9KpEzdiycFTSEPtTfGDNB3W5QKUdUcJxtyFO4rTw7TGsxPH0Sd+0cIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(11063799006)(3023799007)(56012099006)(10067099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VAzNDCL3oOefbgaqDSxP4aYN8x9AR/BSyWE+6JQHDjWWH9W5XoriTMp89//D+su/du0jZS0LIYXMEFhPlgbE6OeHGDazKa/BRlvdt688KXatIhIBS9h/dS3h41CD8xRpnhE8LU08sHds/KyNjQ4+jE/Pywewk7UXIc9NOAMrSu1flaEHrym6O9rE27UI7NRSE8ipJqIDNwYbov3Ka4FDVTuZ9u+1Otal2RvhyV7WQbqElPgbHb3Q9XU6CtCEAZw+josT2ZdVfYKcTnpQADyjMtveKbcek1j6+e34YughAzlCcW7TJj4cSI+l131nCnZLaa9UsQV07xysIulKUK4jl4gnpND1OIlG4rY+DMzIOF08sox+k8v57z80Osw2hYWvE0dTC2NZfqlG6imbBq2Ul1Me6ARyhx+tUleG4N4+4dpsFKXv7MH6URPrHFYpqaqX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 19:50:21.4272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1aaf87f-c85f-46a8-1583-08defc98c5b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6894
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

Port changes from GFX9 to GFX11 mostly as-is.
Minor changes to register access code.

Assisted-by: Claude:Sonnet 4.6
Signed-off-by: David Belanger <david.belanger@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    | 148 ++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
index 724beb96ed1aa..46042f72741b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
@@ -807,6 +807,153 @@ static uint32_t kgd_gfx_v11_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
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
+	soc21_grbm_select(adev, 1, pipe_idx, queue_slot, 0);
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
+ * kgd_gfx_v11_get_cu_occupancy: Reads relevant registers associated with each
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
+static void kgd_gfx_v11_get_cu_occupancy(struct amdgpu_device *adev,
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
+	soc21_grbm_select(adev, 1, 0, 0, 0);
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
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	unlock_spi_csq_mutexes(adev);
+
+	/* Update the output parameters and return */
+	*max_waves_per_cu = adev->gfx.cu_info.simd_per_cu *
+				adev->gfx.cu_info.max_waves_per_simd;
+}
+
 const struct kfd2kgd_calls gfx_v11_kfd2kgd = {
 	.program_sh_mem_settings = program_sh_mem_settings_v11,
 	.set_pasid_vmid_mapping = set_pasid_vmid_mapping_v11,
@@ -832,5 +979,6 @@ const struct kfd2kgd_calls gfx_v11_kfd2kgd = {
 	.clear_address_watch = kgd_gfx_v11_clear_address_watch,
 	.hqd_get_pq_addr = kgd_gfx_v11_hqd_get_pq_addr,
 	.hqd_reset = kgd_gfx_v11_hqd_reset,
+	.get_cu_occupancy = kgd_gfx_v11_get_cu_occupancy,
 	.hqd_sdma_get_doorbell = kgd_gfx_v11_hqd_sdma_get_doorbell
 };
-- 
2.51.1

