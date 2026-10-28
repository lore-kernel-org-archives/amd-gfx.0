Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6AC606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 08:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oQWEDVJM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66D5010FA81;
	Wed, 28 Oct 2026 08:58:10 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F10A10FA93
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 08:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtS62HoZSGUaGUJtsoECxA5saKmBDIHOYL0zljq0UBRxRebP5ixah9mppqEbqAV1C8T232CJOZcDq05P7lSUaezSXJXcLoLjXtnptamZbP9jtEMV+nPXpa4hVeilITkZSFTojGfK2FhHsGkHbOSkROobghSlP9ErEBckxfqlcGa+u0yoaF8rajX+Lfft0V9HnS2AKm2dBJ6uZi3fDBGgwIDBCehI5DeuovoPafQ0WCj4aQJexB655OTf4ekXd3xMLodbEJstAqifK8SRmFE9qzNnvvjPnzBBbYG3MkivJNqnni9eLnG148+LQbYg45Tr45aRcwQz5iaHec7qxk1UzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GxPJIBlXmJ/jH4KXnpZaXFVRTI3LpWgJk4jLCQGaAo=;
 b=THVevIrHuMvwBaXgzakv8rykicnS3EGGERLUb3K3nCZAtqnx6htF63JKtnm6qD+W0Q6dDabBudgEhJi+ikMStRauw8Fud1UuKXxyrnTMNAwdYaWeZJGBrCxGvMXRC3JzD3Oe40z79n2H1ak/Wt7jJfptlOF1H076afU8pfeCMwGexDctS8l9niMThyGuYdceS51qYR6zQaketdwk+L65MSPEiUDAKbztnpj2+Y9yBTFAwD+ElBQSOaZlpWZDKceNdi7LHQXfeCB6m6PRN+y0Gy6raw4Y4j/zh0RyHBvu1KZUMGZOB9NMklbue3hwUo/MOZ1uJcgglWKJa8XJo2HB7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GxPJIBlXmJ/jH4KXnpZaXFVRTI3LpWgJk4jLCQGaAo=;
 b=oQWEDVJMwWuAFJxg03zhF6YNU8vO0LCTMsfM4+rg2U8IwExK5uxOnK4lWSwu/zO2f1m6tNkVydZzDh+uuet8wnCtAigii6zfIecx5uFnd69BusVDzsS7wV07rps751DM8/f9fL1Rgbvi1zGEoNAumxji4cQynEJ8HLXJaMTXNBY=
Received: from MW4PR03CA0201.namprd03.prod.outlook.com (2603:10b6:303:b8::26)
 by SJ2PR12MB8717.namprd12.prod.outlook.com (2603:10b6:a03:53d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 08:57:58 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::3c) by MW4PR03CA0201.outlook.office365.com
 (2603:10b6:303:b8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Wed, 28
 Oct 2026 08:57:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 08:57:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 03:57:57 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 28 Oct 2026 03:57:54 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v3 08/15] drm/amdgpu/gfx12: read and restore the ring state of
 a gfx queue
Date: Wed, 28 Oct 2026 16:56:39 +0800
Message-ID: <20261028085736.3808569-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|SJ2PR12MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: d212af76-55a6-4574-ce29-08df34d1901a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|18002099003|22082099003|6133799003|261026140227099003|56012099006|261021121427099003|261009223027099003|261022105027099003|10067099003|261026121527099003|11063799006;
X-Microsoft-Antispam-Message-Info: gUngGtiSkcBts/VxyjEDc1tOyclMXQVe91Fq0ZCXbsXL70bg3RV81o8nU9rxXn+uFg2KAQpe93SyhkLjHAZfaTUTxRQzWPKtZuOYmVyiab/7Nk6qc/88k6DBy0erjSjHKTi6tBPXr5VvyGevp3aCKlIEcVmMuS3PwweGB4EArbzexTRviDtCq7o4gHq884xKPSDpp3S/+eBhyQ1sQq1fZ9vLBz6dYSiFwGj+npgwoXApBiPHpf5sREGdxN0EXAdh3AUM+3Lc/k+FRRw/RtEMnX3GROKfARoEsoV6HSEbvptNGoxL/+cJvqSOcNjeqTlUOhQD9I36wFzAh1ewIpugW0v/2vF295BesT6v8JpJ2M+rIeInuSvZ2SprkXkeG5llkgfQS+GLcWliGbV+brMOoR3unDg0YefloCfhjp6+IZTuicENjhJj8D+JjGz8jo+dXEvos/qhqpY8rkSFdBiMBlW0e/oOAx4/0MXxtYjZF40UOOiOPpTUkR5we3skJAwt7QUfWPXDRCxZ0LyQz/7tlX0id+phFpDGoNyux/dYlP87YgmL+JwCjql0H/qyQfULt7wNf9iVESYhx81WwFZ1ezn0x5x9qRBEJrS82lki75Ek01VV+3q32+kcKqe2Hv1EobVz/HybyC4IophiEEkcnUUyyjKRteFjwqNML161aF8O6c21sR3u72DgTCa1ilpfARBslDzyoTKBClDPrz5qYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(261026140227099003)(56012099006)(261021121427099003)(261009223027099003)(261022105027099003)(10067099003)(261026121527099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uHmUnIaqGPYDVcRWIRShZGNgo+n3d0S4Y7+vSSnod0p53yVGpoOqhnjP8UfvKmfrcdNcX33/iAfR8HM5oJIRYLmITjtRzoz3+QdAoMl8dr9TFzxNXzW3+1CFSBUOt7RWDrYNWXJBh4mjjBWSc3M5wJsc0MeymMCcqXIB1HFz8AwRjy58c2ouVwX1TZ0P+NNFr5cPZ8xB1AAOs6WkZxH/zShV5V5t1NvG5N2W1ARGumhnKWgy8kIGMZxQ6u3A1OVIXVDpRhcsfWzKIWz/xSh1GPcEOhR3CDpt7xlVgDDSemX5r6N5vH5OEIsrd2L7Zsv6W/Jclp3AsTew0pjbAdjT/T4fduDBRzoRC7pjFKKFpmyxwODEMHsNxA5nNVj5NYbYNqcPOgopdeVvgRuTVWqBExiuJtV+KdR6rtq0Cbx9JmyVA/VaSYPUoUHWPQctoXxz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 08:57:57.9105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d212af76-55a6-4574-ce29-08df34d1901a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8717
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement the gfx callbacks to read and restore the ring state of a gfx
queue for gfx12:
- read_gfx_hqd_ptrs() reads the HQD offset, CSMD read pointer and write
  pointer of the gfx HQD of a doorbell, and whether the queue is the one
  connected to its pipe;
- restore_gfx_mqd_ring() puts them in the MQD after a reset, for MES to
  map the queue again where it was. A queue switched out of the pipe
  resumes from the preemption status the PFP saved in its MQD, also in
  the middle of an IB. The queue the pipe was executing has its state in
  the PFP, which the reset cleared: it restarts after the work submitted
  so far instead, and that work is dropped.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 85 ++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index defa5ca84fc2..708325e6bc7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -276,6 +276,12 @@ static int gfx_v12_0_get_cu_info(struct amdgpu_device *adev,
 static uint64_t gfx_v12_0_get_gpu_clock_counter(struct amdgpu_device *adev);
 static int gfx_v12_0_reset_engine(struct amdgpu_device *adev,
 				  enum amd_ip_engine engine);
+static bool gfx_v12_0_read_gfx_hqd_ptrs(struct amdgpu_device *adev,
+					u32 doorbell_index,
+					struct amdgpu_gfx_hqd_ptrs *ptrs);
+static bool gfx_v12_0_restore_gfx_mqd_ring(struct amdgpu_device *adev, void *m,
+					   u32 ring_size,
+					   struct amdgpu_gfx_hqd_ptrs *ptrs);
 static void gfx_v12_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
 				   u32 sh_num, u32 instance, int xcc_id);
 static u32 gfx_v12_0_get_wgp_active_bitmap_per_sh(struct amdgpu_device *adev);
@@ -967,6 +973,8 @@ static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
 	.get_gfx_shadow_info = &gfx_v12_0_get_gfx_shadow_info,
 	.get_hdp_flush_mask = &amdgpu_gfx_get_hdp_flush_mask,
 	.reset_engine = &gfx_v12_0_reset_engine,
+	.read_gfx_hqd_ptrs = &gfx_v12_0_read_gfx_hqd_ptrs,
+	.restore_gfx_mqd_ring = &gfx_v12_0_restore_gfx_mqd_ring,
 };
 
 static int gfx_v12_0_gpu_early_init(struct amdgpu_device *adev)
@@ -3978,6 +3986,83 @@ static int gfx_v12_0_reset_engine(struct amdgpu_device *adev,
 	return r;
 }
 
+#define GFX12_HPD_QUEUE_STATE_CONNECTED_MIN	3
+#define GFX12_HPD_QUEUE_STATE_CONNECTED_MAX	15
+
+static bool gfx_v12_0_read_gfx_hqd_ptrs(struct amdgpu_device *adev,
+					u32 doorbell_index,
+					struct amdgpu_gfx_hqd_ptrs *ptrs)
+{
+	u32 me, pipe, queue, status, state;
+
+	memset(ptrs, 0, sizeof(*ptrs));
+	ptrs->doorbell_index = doorbell_index;
+	if (!gfx_v12_0_detect_hung_queue(adev, doorbell_index, &me, &pipe, &queue))
+		return true;
+
+	amdgpu_gfx_off_ctrl(adev, false);
+	mutex_lock(&adev->srbm_mutex);
+	soc24_grbm_select(adev, me, pipe, queue, 0);
+	ptrs->on_hqd = RREG32_SOC15(GC, 0, regCP_GFX_HQD_ACTIVE) &
+		       CP_GFX_HQD_ACTIVE__ACTIVE_MASK;
+	if (!ptrs->on_hqd)
+		goto out;
+	ptrs->mqd_addr = RREG32_SOC15(GC, 0, regCP_GFX_MQD_BASE_ADDR) |
+			 (u64)RREG32_SOC15(GC, 0, regCP_GFX_MQD_BASE_ADDR_HI) << 32;
+	ptrs->offset = RREG32_SOC15(GC, 0, regCP_GFX_HQD_OFFSET);
+	ptrs->csmd_rptr = RREG32_SOC15(GC, 0, regCP_GFX_HQD_CSMD_RPTR);
+	ptrs->wptr = RREG32_SOC15(GC, 0, regCP_GFX_HQD_WPTR) |
+		     (u64)RREG32_SOC15(GC, 0, regCP_GFX_HQD_WPTR_HI) << 32;
+	status = RREG32_SOC15(GC, 0, regCP_GFX_HPD_STATUS0);
+	state = REG_GET_FIELD(status, CP_GFX_HPD_STATUS0, QUEUE_STATE);
+	ptrs->connected =
+		state >= GFX12_HPD_QUEUE_STATE_CONNECTED_MIN &&
+		state <= GFX12_HPD_QUEUE_STATE_CONNECTED_MAX &&
+		REG_GET_FIELD(status, CP_GFX_HPD_STATUS0, MAPPED_QUEUE) == queue;
+out:
+	soc24_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	amdgpu_gfx_off_ctrl(adev, true);
+
+	return true;
+}
+
+static bool gfx_v12_0_restore_gfx_mqd_ring(struct amdgpu_device *adev, void *m,
+					   u32 ring_size,
+					   struct amdgpu_gfx_hqd_ptrs *ptrs)
+{
+	struct v12_gfx_mqd *mqd = m;
+	u32 wptr = lower_32_bits(ptrs->wptr) & ((ring_size >> 2) - 1);
+	u32 *status;
+
+	/*
+	 * MQD dwords 32-41 (reserved_32..41) are the PFP preemption status,
+	 * mcbp_status_pfp: the offset and chained IB size and address of IB1
+	 * (32-35) and IB2 (36-39), rb_preempt (40: preempted in the ring) and
+	 * completion_status (41: 0 IB not started, 1 preempted inside an IB,
+	 * 2 IB completed, 3 IB resumed). The PFP saves it when the queue is
+	 * switched out of the pipe and resumes from it when the queue runs
+	 * again, at the HQD offset. That survives the reset for a queue that
+	 * was switched out. The queue the pipe executed has its state in the
+	 * PFP, which the reset cleared: restart it at the write pointer with
+	 * no IB to resume, and drop its work in flight.
+	 */
+	if (ptrs->connected) {
+		mqd->cp_gfx_hqd_offset = wptr;
+		mqd->cp_gfx_hqd_csmd_rptr = wptr;
+		for (status = &mqd->reserved_32; status <= &mqd->reserved_41; status++)
+			*status = 0;
+	} else {
+		mqd->cp_gfx_hqd_offset = ptrs->offset;
+		mqd->cp_gfx_hqd_csmd_rptr = ptrs->csmd_rptr;
+	}
+	mqd->cp_gfx_hqd_wptr = lower_32_bits(ptrs->wptr);
+	mqd->cp_gfx_hqd_wptr_hi = upper_32_bits(ptrs->wptr);
+	mqd->cp_gfx_hqd_active = 0;
+
+	return ptrs->connected;
+}
+
 static uint64_t gfx_v12_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
 	uint64_t clock = 0;
-- 
2.50.1

