Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7989C606A31B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 03:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=z2kiUKrX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20A1A10F3C5;
	Thu,  5 Nov 2026 03:07:07 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010040.outbound.protection.outlook.com [52.101.61.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45ED310FD4B
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 03:07:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SirArv7uYRtQvBdQTv4gOLJ6gdSpcAUFsfYYbKMe38Qv5zEaVRdKdty7zyHbXt5Yie0BGrwVRC3YnKA419HxqVuDwKouELbV4ogGKQ5gbcKqoSSav1EAFpVj4W3JEUUx1y+J1jw5+fOANVC1VCuGpo81r3IFcwHiTTlviseTGcu9NIoGFEmQVAnUNB2ICmx7i+S0F6fQaJrPTzHtsIMWY+fJFAf6q5DV5a4mIFrCydHCd/naLw5lGEEp3R2m1x3whXgSzvXlZVoa0MNUs6y/+IsHxg+q9pfElsMkVPfUrCgThxiwafH88GLxTOozdPD7fctizHCVaVjBim3Gdgu6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoT31bjg1W3jT9RYKADrnqG7N9+TLAi0mjlDJUcGUSc=;
 b=mhps4s4YToqeYOgJjSE0uTxGU/+5aRuwLOz+hvWKKaa+IbDq6aWGB/VxonoQMBViuLq7xN+T4U52u+k0FXRB8V8ps9PW4JqbC4qyBtVQzYL9c4buMATkG2l9ux5gH8SMf+I64pk5ezHK3dfwqCOYfnru5TyLFb3tSbblUim8kTTpfud2XhcFfzKzIyvKhl1bSjEJdh2hBBrfypH5a9MYW0zjrIN0pLZqQUAcJJo7PlTPMXb09nh8R2Leyzv5adWG14W74+OIyp2rx1MSG/TcGb8VeNBNdj5DEXDRgEAG2YuxWnGwsDUtgN2NWdFcJkd6XAmJsA6bSR3DkPN5CsrCaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoT31bjg1W3jT9RYKADrnqG7N9+TLAi0mjlDJUcGUSc=;
 b=z2kiUKrXLbjd9BIr2JJa6b9T15fhDm1T34FoZ/Y9DVFe4Bhe5jt6MI9d4i+yDvq3cXPJRZH0nvZvr/cGDkGARxdpDdNhWVxCW0uWGftHWGJ+eYqH5cO0WhABa0aHqobK8ZMdMtPJ2XsPlvAIrnU26ZaO2a+SPWR+OOjfAuGinSA=
Received: from BN9PR03CA0243.namprd03.prod.outlook.com (2603:10b6:408:ff::8)
 by DS0PR12MB379256.namprd12.prod.outlook.com (2603:10b6:8:3df::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 03:06:26 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::86) by BN9PR03CA0243.outlook.office365.com
 (2603:10b6:408:ff::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Thu, 5
 Nov 2026 03:06:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 03:06:26 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 21:06:26 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 21:06:25 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 21:06:23 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v4 05/13] drm/amdgpu/gfx12: save and restore a gfx HQD
Date: Thu, 5 Nov 2026 11:05:47 +0800
Message-ID: <20261105030612.726542-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261105030612.726542-1-Jesse.Zhang@amd.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|DS0PR12MB379256:EE_
X-MS-Office365-Filtering-Correlation-Id: 37b028ca-f7c3-4aca-ad8d-08df3ae9c7b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|261026140227099003|261022105027099003|261026121527099003|261028144727099003|261021121427099003|261102123227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: a/B8Z2n+04Gn5S6Z+qkQd4BjkgaDx8mMW4NTkBsKPgDT1gllnVI6BQT0NKE87qEMrHlGi3VAc0tuqr8sr0cTWGje54PppanrmGhx+jeVeiOmMDWz3rjZHPBGeV+myT4fX5PXwCyjfL3oviPxlTzGRdzoJdE1b4+TcGDLCYdHAGQd+yNqy6jKRiK1L/R91jSVFM7rcONV7ptcrM+1D2J246Lvu5PKR+DbO3ccJEFsoZv4i0EDssItyGEoLN46VRzKQBp+x4Bn7Rx3MNOmplT92owiV8A3YX/EF8/RuBSzr7oHqXzsDqEUsm/VsImgHFjwEYmHw4Y5m2Z3X82UmrA0SFiFgC9L0/ws82TlX3nuokeuJ5sfmDed5s0YdVMHz3cE7Hg4PPiHcjyJXNXDaLym9CxElCGHP+oMsKPs+INoSBk6BtIafPcUbx2isYdeecA+x/P/sLeAd9eYMyZS3ZfG/1s05EUCBh+5VitPRItIePr8we16dWad21toj1HPsVa3F7APZNU+7TE9XxiI0jwfHJEv9OzJl7RGGIIvoh+owH6q9E38CaXQUk24i2k7f2Z9tGZBXBJKeltjwp2+O5mgFPD713jPqr5YtGBDzYTr/9KxHvbay5IzMQ1SmT8TtNfcVxB9hKk9RiDfTuPXWDXsLpDOCosmj8sFfQQCojmpMigVw0Ll3zJloytgunBGaaA4ZI1fjv8QlbXp6IDBEwvu2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261026140227099003)(261022105027099003)(261026121527099003)(261028144727099003)(261021121427099003)(261102123227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FZ0mil/an88NbXFEjOxS402Zkk8faiyUUktAbKoWZVRDqmSO2XfjTFxSj/v/D/8t8eBGW5IG9NsotODcr5hdRHhx7psOsyvSLkwulO1wS6kqPKZDn94K1rDw58UuHC6a7VBSXRU8TRKNQZuQ3u+UTHg+nk1Sa6VYUyAATFyVQB5BvoOQJ3HCS/ckb9I9oKWsmgvOBzfaDfJ3XAy58zzSdxAd4S7N98IPvwZXADCDJAOnvuQ1A1L3ZWipt3S8Bbx8ysmHW9FYndnvutWS858Wkj5TYneV8bnuL9JGCg5FKAdVK0QfMh+ZUXuW41jxm+5KYVwels6oxL5nkZJjR7kaS6eGKa32LfrlomD2nLXX2TpIH0SalkdDOouY5r2VzTMdQRn3JPGZrun16ofNHgDthd6lAhFhNcJByx5N5/JyBHqern3MiVgrGrSauC1NCFg1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 03:06:26.1980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b028ca-f7c3-4aca-ad8d-08df3ae9c7b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB379256
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

Implement the gfx callbacks to save and restore a gfx HQD for gfx12:
- save_hqd() saves the HQD offset, CSMD read pointer and write pointer
  of the gfx HQD of a doorbell, and whether the queue is the one
  connected to its pipe;
- restore_hqd() writes them into the MQD after a reset, for MES to map
  the queue again where it was. A queue switched out of the pipe resumes
  from the preemption status the PFP saved in its MQD, also in the
  middle of an IB. The queue the pipe was executing has its state in the
  PFP, which the reset cleared: it restarts after the work submitted so
  far instead, and that work is dropped.

v4: Rename to save_hqd()/restore_hqd() (Timur).

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 83 ++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index cb15dad0e57b..484e876fe235 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -274,6 +274,11 @@ static void gfx_v12_0_set_imu_funcs(struct amdgpu_device *adev);
 static int gfx_v12_0_get_cu_info(struct amdgpu_device *adev,
 				 struct amdgpu_cu_info *cu_info);
 static uint64_t gfx_v12_0_get_gpu_clock_counter(struct amdgpu_device *adev);
+static bool gfx_v12_0_save_hqd(struct amdgpu_device *adev, u32 doorbell_index,
+			       struct amdgpu_gfx_saved_hqd *hqd);
+static bool gfx_v12_0_restore_hqd(struct amdgpu_device *adev, void *m,
+				  u32 ring_size,
+				  const struct amdgpu_gfx_saved_hqd *hqd);
 static void gfx_v12_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
 				   u32 sh_num, u32 instance, int xcc_id);
 static u32 gfx_v12_0_get_wgp_active_bitmap_per_sh(struct amdgpu_device *adev);
@@ -962,6 +967,8 @@ static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
 	.update_perfmon_mgcg = &gfx_v12_0_update_perf_clk,
 	.get_gfx_shadow_info = &gfx_v12_0_get_gfx_shadow_info,
 	.get_hdp_flush_mask = &amdgpu_gfx_get_hdp_flush_mask,
+	.save_hqd = &gfx_v12_0_save_hqd,
+	.restore_hqd = &gfx_v12_0_restore_hqd,
 };
 
 static int gfx_v12_0_gpu_early_init(struct amdgpu_device *adev)
@@ -3853,6 +3860,82 @@ static int gfx_v12_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
+#define GFX12_HPD_QUEUE_STATE_CONNECTED_MIN	3
+#define GFX12_HPD_QUEUE_STATE_CONNECTED_MAX	15
+
+static bool gfx_v12_0_save_hqd(struct amdgpu_device *adev, u32 doorbell_index,
+			       struct amdgpu_gfx_saved_hqd *hqd)
+{
+	u32 me, pipe, queue, status, state;
+
+	memset(hqd, 0, sizeof(*hqd));
+	hqd->doorbell_index = doorbell_index;
+	if (!gfx_v12_0_detect_hung_queue(adev, doorbell_index, &me, &pipe, &queue))
+		return true;
+
+	amdgpu_gfx_off_ctrl(adev, false);
+	mutex_lock(&adev->srbm_mutex);
+	soc24_grbm_select(adev, me, pipe, queue, 0);
+	hqd->on_hqd = RREG32_SOC15(GC, 0, regCP_GFX_HQD_ACTIVE) &
+		      CP_GFX_HQD_ACTIVE__ACTIVE_MASK;
+	if (!hqd->on_hqd)
+		goto out;
+	hqd->mqd_addr = RREG32_SOC15(GC, 0, regCP_GFX_MQD_BASE_ADDR) |
+			(u64)RREG32_SOC15(GC, 0, regCP_GFX_MQD_BASE_ADDR_HI) << 32;
+	hqd->offset = RREG32_SOC15(GC, 0, regCP_GFX_HQD_OFFSET);
+	hqd->csmd_rptr = RREG32_SOC15(GC, 0, regCP_GFX_HQD_CSMD_RPTR);
+	hqd->wptr = RREG32_SOC15(GC, 0, regCP_GFX_HQD_WPTR) |
+		    (u64)RREG32_SOC15(GC, 0, regCP_GFX_HQD_WPTR_HI) << 32;
+	status = RREG32_SOC15(GC, 0, regCP_GFX_HPD_STATUS0);
+	state = REG_GET_FIELD(status, CP_GFX_HPD_STATUS0, QUEUE_STATE);
+	hqd->connected =
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
+static bool gfx_v12_0_restore_hqd(struct amdgpu_device *adev, void *m,
+				  u32 ring_size,
+				  const struct amdgpu_gfx_saved_hqd *hqd)
+{
+	struct v12_gfx_mqd *mqd = m;
+	u32 wptr = lower_32_bits(hqd->wptr) & ((ring_size >> 2) - 1);
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
+	if (hqd->connected) {
+		mqd->cp_gfx_hqd_offset = wptr;
+		mqd->cp_gfx_hqd_csmd_rptr = wptr;
+		for (status = &mqd->reserved_32; status <= &mqd->reserved_41; status++)
+			*status = 0;
+	} else {
+		mqd->cp_gfx_hqd_offset = hqd->offset;
+		mqd->cp_gfx_hqd_csmd_rptr = hqd->csmd_rptr;
+	}
+	mqd->cp_gfx_hqd_wptr = lower_32_bits(hqd->wptr);
+	mqd->cp_gfx_hqd_wptr_hi = upper_32_bits(hqd->wptr);
+	mqd->cp_gfx_hqd_active = 0;
+
+	return hqd->connected;
+}
+
 static uint64_t gfx_v12_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
 	uint64_t clock = 0;
-- 
2.50.1

