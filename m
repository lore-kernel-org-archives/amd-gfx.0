Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3A5C5DF81
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6717C10E87D;
	Mon, 24 Aug 2026 22:14:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nyuuv0vc";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DAED10E867
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fuye34u7lbiAQLomt8g3uqZeaileXv04xtdROy2kkKqJK0XTjJqTWo76WKx6Xc8n/6ywmiSL6ol1fd+Azxk/If79F+CTDNAyU0GyZSuLFndOT6k74dW3txKHxcmrb0BMLSqmpP5N8ta8xLIVV9Di70aTgkxeF8OX7CAG+JBpCNckBbJke1w3wvBvzbwK0t7A/KZEoPpCtLXf481TgaO0B6W7LQkI0JbVlpOyGv3uGyJh2PCoGAj1JBOIhRWeipWvxo6pS6ir85DkpEXP/ygMkOKFTOhsQ9Olk6FWWhw51WC9Izi+M4zXitI9FEkExpH4I537PP5Z6ENgamvLSRMLig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fnpxu8YlYqXIMrjAiHjzIf/LQi2c4E2ykIfhZjiFVZQ=;
 b=DtGdkqysvYxf3ERdA6V6eW/OKg7oOeb+a44Ek3OPGZTVzEKbQkOHvB7ThCsiz4Q7pAFThbbG/mwU/a6u3wpgDcaelHesVXbEC1h6Ip9J4kQ2bRsvdwl9+kWikCYmndyBKTNd9wI4tUpDqMUyC55oiIdk76Ohdw+GuRWzgUo07A4SQn/eZcMkZcXNtGmkccdN6wE2apxRqrE4tv/xfZBN4qaDW0lb/5IszSYoZh/cRNJtFEXylC1RiXP1nM6GUqmYLA9shnD1LSrV60Jq/sWuoi1JfWjdOPixXxkN08AGZTJhUamV1xkMrYkd/FmLtxpzUW65quqPyR5QhJpe/tZCDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fnpxu8YlYqXIMrjAiHjzIf/LQi2c4E2ykIfhZjiFVZQ=;
 b=Nyuuv0vcvRmY+qUtGN2NW5NfhTwQdDHAQiuqkg5XSKquS3D2igYySym12cHYZg/Bai1WNmq+bxDEkjJKz8DYhbzrYa1zSkjXZKP4sst8EARedE8781EMOrMBl5H/w89oqmDs4acI2n4eZ7HCgV3i7ExThp0ExCE3ux4f8W9lT5U=
Received: from DS7P220CA0041.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::27) by
 DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.12; Mon, 24 Aug 2026 22:14:31 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:8:223:cafe::9b) by DS7P220CA0041.outlook.office365.com
 (2603:10b6:8:223::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:31 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:21 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:20 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 30/30] drm/amdgpu/gmc: add helpers for various tlb inv
 functions
Date: Mon, 24 Aug 2026 18:13:52 -0400
Message-ID: <20260824221352.1793542-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|DM6PR12MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: 867f7889-bc0c-4496-cf84-08df022d1248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: S6D+fxYih57Y0ZinpSVmkUcIubcPtt0P2d5gJSkR6IcMpqyiLJ/EeKg3F4sEz22Ul0EVJ5qNX4F5BCi+oW2JsVyTzpvma7fqEQ+VeRcJZ1ptVnYLp5SoZJqjsbBv3FvZ/7Nn/4jjBo5zLrXXPmJrWZj6aEKWk5PqtxNWr3gJdfBQ5F1imW+GIc5VaJTifR65te7FPwvht9gAYzGsVa+ynlfA31txhFyunTf2x/crvp/qRAMt6B7RosNjadrl03f05En3YAOVJZV7vwRfqGL75wj9NbwMX4kQ4cYT4UlkCHK0WsbEtSvz7WKPgA37PVZv9jjImdBYY8dYg+UPPjT/PZ/QXBd5Vdzi4qy5OvM1xfTAy5qjWI+8nB6UdCQBIfoOnCza9jjtZ2HmrhjsshDFX8bvTn2Al6N36dbai9TP781U+fCZPRE/ovWChFyhD6aNWDjiMx3nxvq/HJHUFw5/j4rUEneNjAHvs/voC5gvyEcwKpjPv4rDI9HB+sZBLSqGW1A2j5apb5egZ1QpCLddxKXK9Cwc6Ho7K1EfE+25Gcn04JbkggnO9DpQ5R1+xCaw9eAQS0PUeW/0m69uDHG6IdSA/Za3w55KFxc4GW9nFHS+0tX8D1su+GigQ8QnGqdnyt7DnIiZTq4wh+4U6Q7ERED1TK8RpzVX1uDjQ6KFykkbIZKqgS55PVSh4Wm3+UHCiHFeTlJuw4FkL1SR7fjL7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bRZIQ504bzD95w5t2bhCmyU6bIj8E3C8SV4Nuhb5sDc/opFvLxd8ZnTBwfm+QxAEbeT5r8jkLExV4cry8NxdjR3BiY3Kz/GGMvDHmxk8EnYgvmTCgYTLb+6vVIScSkgcFTmCBlVDfgzxYMUc64CLp16jFlUfWQX+H7hAz7oY2AItXGmz8/t4radCYrMyOga57eTSQYnk3IKYvsk/VRe9IllqwfU+kbooWXsiacwcFqlGzSQvnxFhSbZtCQi3ZpIcU5MFWT4kcYF2CbbqtVwJT1LDmSpewEV06D+YzAMiutdhvHtAZxmJR/dXmFOUoilZlvXGDFJYy15ud9t/ViSDUDv+BfPvhj4eJFL4MhKCiOrM204+0jCTF+Zrdcaiih6DVa9zxxPXxCis8mO7a4cJg8gYUpoF/Lt6C9+zctMfRafznhlPICW/SN07CcOLryys
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:31.2832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 867f7889-bc0c-4496-cf84-08df022d1248
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316
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

gmc9-12 use the same logic for almost all of these, so move it to
helpers and remove the gmc specific functions.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 195 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |   7 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |   2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 199 +--------------------
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 204 +---------------------
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 219 +-----------------------
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c  | 195 +--------------------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  92 +---------
 8 files changed, 221 insertions(+), 892 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 2800eebe50649..185290a392bec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -951,6 +951,201 @@ static int amdgpu_gmc_flush_gpu_tlb_mes_helper(struct amdgpu_device *adev,
 	return 0;
 }
 
+/**
+ * amdgpu_gmc_flush_gpu_tlb_pasid_helper - tlb flush via pasid
+ *
+ * @adev: amdgpu_device pointer
+ * @pasid: pasid to be flush
+ * @flush_type: the flush type
+ * @all_hub: flush all hubs
+ * @inst: is used to select which instance of KIQ to use for the invalidation
+ *
+ * A helper to flush the TLB for the requested pasid using other callbacks.
+ */
+void amdgpu_gmc_flush_gpu_tlb_pasid_helper(struct amdgpu_device *adev,
+					   uint16_t pasid, uint32_t flush_type,
+					   bool all_hub, uint32_t inst)
+{
+	uint16_t queried;
+	int vmid, i;
+
+	for (vmid = 1; vmid < 16; vmid++) {
+		bool valid;
+
+		valid = adev->gmc.gmc_funcs->get_vmid_pasid_mapping_info(adev, vmid, inst,
+									 &queried);
+		if (!valid || queried != pasid)
+			continue;
+
+		if (all_hub) {
+			for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
+				adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid, i,
+								   flush_type);
+		} else {
+			adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB(inst),
+							   flush_type);
+		}
+	}
+}
+
+/**
+ * amdgpu_gmc_flush_gpu_tlb_helper - gart tlb flush callback
+ *
+ * @adev: amdgpu_device pointer
+ * @vmid: vm instance to flush
+ * @vmhub: which hub to flush
+ * @flush_type: the flush type
+ *
+ * Flush the TLB for the requested page table.
+ */
+void amdgpu_gmc_flush_gpu_tlb_helper(struct amdgpu_device *adev, uint32_t vmid,
+				     uint32_t vmhub, uint32_t flush_type)
+{
+	bool use_semaphore = adev->gmc.gmc_funcs->use_invalidate_semaphore(adev, vmhub);
+	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
+	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
+	/* Use register 17 for GART */
+	const unsigned int eng = 17;
+	unsigned char hub_ip;
+	u32 sem, req, ack;
+	unsigned int i;
+	u32 tmp, inst;
+
+	if (AMDGPU_IS_GFXHUB(vmhub) && !adev->gfx.is_poweron)
+		return;
+
+	sem = hub->vm_inv_eng0_sem + hub->eng_distance * eng;
+	req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
+	ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
+
+
+	if (vmhub >= AMDGPU_MMHUB0(0))
+		inst = 0;
+	else
+		inst = vmhub;
+
+	/* flush hdp cache */
+	amdgpu_device_flush_hdp(adev, NULL);
+
+	/* This is necessary for SRIOV as well as for GFXOFF to function
+	 * properly under bare metal
+	 */
+	if ((adev->gfx.kiq[inst].ring.sched.ready ||
+	     adev->mes.ring[MES_PIPE_INST(inst, 0)].sched.ready) &&
+	    !adev->gmc.use_mmio_for_tlb_flush) {
+		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
+						 1 << vmid, inst);
+		return;
+	}
+
+	/* This path is needed before KIQ/MES/GFXOFF are set up */
+	hub_ip = AMDGPU_IS_GFXHUB(vmhub) ? GC_HWIP : MMHUB_HWIP;
+
+	/* disabllow gfxoff when we invalidate */
+	if (hub_ip == GC_HWIP)
+		amdgpu_gfx_off_ctrl(adev, false);
+
+	spin_lock(&adev->gmc.invalidate_lock);
+	/*
+	 * It may lose gpuvm invalidate acknowldege state across power-gating
+	 * off cycle, add semaphore acquire before invalidation and semaphore
+	 * release after invalidation to avoid entering power gated state
+	 * to WA the Issue
+	 */
+
+	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
+	if (use_semaphore) {
+		for (i = 0; i < adev->usec_timeout; i++) {
+			/* a read return value of 1 means semaphore acuqire */
+			tmp = RREG32_RLC_NO_KIQ(sem, hub_ip);
+			if (tmp & 0x1)
+				break;
+			udelay(1);
+		}
+
+		if (i >= adev->usec_timeout)
+			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
+	}
+
+	WREG32_RLC_NO_KIQ(req, inv_req, hub_ip);
+
+	/* Wait for ACK with a delay.*/
+	for (i = 0; i < adev->usec_timeout; i++) {
+		tmp = RREG32_RLC_NO_KIQ(ack, hub_ip);
+		tmp &= 1 << vmid;
+		if (tmp)
+			break;
+
+		udelay(1);
+	}
+
+	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
+	if (use_semaphore)
+		WREG32_RLC_NO_KIQ(sem, 0, hub_ip);
+
+	/* Issue additional private vm invalidation to MMHUB */
+	if ((vmhub != AMDGPU_GFXHUB(0)) &&
+	    (hub->vm_l2_bank_select_reserved_cid2) &&
+		!amdgpu_sriov_vf(adev)) {
+		inv_req = RREG32_NO_KIQ(hub->vm_l2_bank_select_reserved_cid2);
+		/* bit 25: RSERVED_CACHE_PRIVATE_INVALIDATION */
+		inv_req |= (1 << 25);
+		/* Issue private invalidation */
+		WREG32_NO_KIQ(hub->vm_l2_bank_select_reserved_cid2, inv_req);
+		/* Read back to ensure invalidation is done*/
+		RREG32_NO_KIQ(hub->vm_l2_bank_select_reserved_cid2);
+	}
+
+	spin_unlock(&adev->gmc.invalidate_lock);
+
+	if (hub_ip == GC_HWIP)
+		amdgpu_gfx_off_ctrl(adev, true);
+
+	if (i >= adev->usec_timeout)
+		dev_err(adev->dev, "Timeout waiting for VM flush ACK!\n");
+}
+
+uint64_t amdgpu_gmc_emit_flush_gpu_tlb_helper(struct amdgpu_ring *ring,
+					      unsigned vmid, uint64_t pd_addr)
+{
+	bool use_semaphore =
+		ring->adev->gmc.gmc_funcs->use_invalidate_semaphore(ring->adev,
+								    ring->vm_hub);
+	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
+	uint32_t req = hub->vmhub_funcs->get_invalidate_req(vmid, 0);
+	unsigned eng = ring->vm_inv_eng;
+
+	if (use_semaphore)
+		/* a read return value of 1 means semaphore acuqire */
+		amdgpu_ring_emit_reg_wait(ring,
+					  hub->vm_inv_eng0_sem +
+					  hub->eng_distance * eng, 0x1, 0x1);
+
+	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
+			      (hub->ctx_addr_distance * vmid),
+			      lower_32_bits(pd_addr));
+
+	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
+			      (hub->ctx_addr_distance * vmid),
+			      upper_32_bits(pd_addr));
+
+	amdgpu_ring_emit_reg_write_reg_wait(ring, hub->vm_inv_eng0_req +
+					    hub->eng_distance * eng,
+					    hub->vm_inv_eng0_ack +
+					    hub->eng_distance * eng,
+					    req, 1 << vmid);
+
+	if (use_semaphore)
+		/*
+		 * add semaphore release after invalidation,
+		 * write with 0 means semaphore release
+		 */
+		amdgpu_ring_emit_wreg(ring, hub->vm_inv_eng0_sem +
+				      hub->eng_distance * eng, 0);
+
+	return pd_addr;
+}
+
 int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 				   uint32_t flush_type, bool all_hub,
 				   uint32_t inst)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index f20f08630408e..22814dd451430 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -459,6 +459,13 @@ int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
 				  bool write_fault);
 int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
+void amdgpu_gmc_flush_gpu_tlb_pasid_helper(struct amdgpu_device *adev,
+					   uint16_t pasid, uint32_t flush_type,
+					   bool all_hub, uint32_t inst);
+void amdgpu_gmc_flush_gpu_tlb_helper(struct amdgpu_device *adev, uint32_t vmid,
+				     uint32_t vmhub, uint32_t flush_type);
+uint64_t amdgpu_gmc_emit_flush_gpu_tlb_helper(struct amdgpu_ring *ring,
+					      unsigned vmid, uint64_t pd_addr);
 void amdgpu_gmc_flush_gpu_tlb_gart(struct amdgpu_device *adev,
 				   uint32_t vmhub);
 int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 5033f85d31022..654bf7f780d59 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7497,6 +7497,8 @@ static int gfx_v10_0_hw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 	struct amdgpu_device *adev = ip_block->adev;
 
+	adev->gfx.is_poweron = true;
+
 	if (!amdgpu_emu_mode)
 		gfx_v10_0_init_golden_registers(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index e716a86ba2913..35397b44c9dfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -223,195 +223,6 @@ static bool gmc_v10_0_get_atc_vmid_pasid_mapping_info(
  * by the amdgpu vm/hsa code.
  */
 
-/**
- * gmc_v10_0_flush_gpu_tlb - gart tlb flush callback
- *
- * @adev: amdgpu_device pointer
- * @vmid: vm instance to flush
- * @vmhub: vmhub type
- * @flush_type: the flush type
- *
- * Flush the TLB for the requested page table.
- */
-static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
-					uint32_t vmhub, uint32_t flush_type)
-{
-	bool use_semaphore = gmc_v10_0_use_invalidate_semaphore(adev, vmhub);
-	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
-	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
-	/* Use register 17 for GART */
-	const unsigned int eng = 17;
-	unsigned char hub_ip = 0;
-	u32 sem, req, ack;
-	unsigned int i;
-	u32 tmp;
-
-	sem = hub->vm_inv_eng0_sem + hub->eng_distance * eng;
-	req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
-	ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
-
-	/* flush hdp cache */
-	amdgpu_device_flush_hdp(adev, NULL);
-
-	/* This is necessary for SRIOV as well as for GFXOFF to function
-	 * properly under bare metal
-	 */
-	if (adev->gfx.kiq[0].ring.sched.ready && !adev->enable_mes &&
-	    !adev->gmc.use_mmio_for_tlb_flush) {
-		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
-						 1 << vmid, GET_INST(GC, 0));
-		return;
-	}
-
-	/* This path is needed before KIQ/MES/GFXOFF are set up */
-	hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ? GC_HWIP : MMHUB_HWIP;
-
-	/* disabllow gfxoff when we invalidate */
-	if (hub_ip == GC_HWIP)
-		amdgpu_gfx_off_ctrl(adev, false);
-
-	spin_lock(&adev->gmc.invalidate_lock);
-	/*
-	 * It may lose gpuvm invalidate acknowldege state across power-gating
-	 * off cycle, add semaphore acquire before invalidation and semaphore
-	 * release after invalidation to avoid entering power gated state
-	 * to WA the Issue
-	 */
-
-	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (use_semaphore) {
-		for (i = 0; i < adev->usec_timeout; i++) {
-			/* a read return value of 1 means semaphore acuqire */
-			tmp = RREG32_RLC_NO_KIQ(sem, hub_ip);
-			if (tmp & 0x1)
-				break;
-			udelay(1);
-		}
-
-		if (i >= adev->usec_timeout)
-			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
-	}
-
-	WREG32_RLC_NO_KIQ(req, inv_req, hub_ip);
-
-	/*
-	 * Issue a dummy read to wait for the ACK register to be cleared
-	 * to avoid a false ACK due to the new fast GRBM interface.
-	 */
-	if ((vmhub == AMDGPU_GFXHUB(0)) &&
-	    (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(10, 3, 0)))
-		RREG32_RLC_NO_KIQ(req, hub_ip);
-
-	/* Wait for ACK with a delay.*/
-	for (i = 0; i < adev->usec_timeout; i++) {
-		tmp = RREG32_RLC_NO_KIQ(ack, hub_ip);
-		tmp &= 1 << vmid;
-		if (tmp)
-			break;
-
-		udelay(1);
-	}
-
-	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (use_semaphore)
-		WREG32_RLC_NO_KIQ(sem, 0, hub_ip);
-
-	spin_unlock(&adev->gmc.invalidate_lock);
-
-	if (hub_ip == GC_HWIP)
-		amdgpu_gfx_off_ctrl(adev, true);
-
-	if (i >= adev->usec_timeout)
-		dev_err(adev->dev, "Timeout waiting for VM flush hub: %d!\n",
-			vmhub);
-}
-
-/**
- * gmc_v10_0_flush_gpu_tlb_pasid - tlb flush via pasid
- *
- * @adev: amdgpu_device pointer
- * @pasid: pasid to be flush
- * @flush_type: the flush type
- * @all_hub: Used with PACKET3_INVALIDATE_TLBS_ALL_HUB()
- * @inst: is used to select which instance of KIQ to use for the invalidation
- *
- * Flush the TLB for the requested pasid.
- */
-static void gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
-					  uint16_t pasid, uint32_t flush_type,
-					  bool all_hub, uint32_t inst)
-{
-	uint16_t queried;
-	int vmid, i;
-
-	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
-		bool valid;
-
-		valid = gmc_v10_0_get_atc_vmid_pasid_mapping_info(adev, vmid, 0,
-								  &queried);
-		if (!valid || queried != pasid)
-			continue;
-
-		if (all_hub) {
-			for_each_set_bit(i, adev->vmhubs_mask,
-					 AMDGPU_MAX_VMHUBS)
-				gmc_v10_0_flush_gpu_tlb(adev, vmid, i,
-							flush_type);
-		} else {
-			gmc_v10_0_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB(0),
-						flush_type);
-		}
-	}
-}
-
-static uint64_t gmc_v10_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
-					     unsigned int vmid, uint64_t pd_addr)
-{
-	bool use_semaphore = gmc_v10_0_use_invalidate_semaphore(ring->adev, ring->vm_hub);
-	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
-	uint32_t req = hub->vmhub_funcs->get_invalidate_req(vmid, 0);
-	unsigned int eng = ring->vm_inv_eng;
-
-	/*
-	 * It may lose gpuvm invalidate acknowldege state across power-gating
-	 * off cycle, add semaphore acquire before invalidation and semaphore
-	 * release after invalidation to avoid entering power gated state
-	 * to WA the Issue
-	 */
-
-	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (use_semaphore)
-		/* a read return value of 1 means semaphore acuqire */
-		amdgpu_ring_emit_reg_wait(ring,
-					  hub->vm_inv_eng0_sem +
-					  hub->eng_distance * eng, 0x1, 0x1);
-
-	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
-			      (hub->ctx_addr_distance * vmid),
-			      lower_32_bits(pd_addr));
-
-	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
-			      (hub->ctx_addr_distance * vmid),
-			      upper_32_bits(pd_addr));
-
-	amdgpu_ring_emit_reg_write_reg_wait(ring, hub->vm_inv_eng0_req +
-					    hub->eng_distance * eng,
-					    hub->vm_inv_eng0_ack +
-					    hub->eng_distance * eng,
-					    req, 1 << vmid);
-
-	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (use_semaphore)
-		/*
-		 * add semaphore release after invalidation,
-		 * write with 0 means semaphore release
-		 */
-		amdgpu_ring_emit_wreg(ring, hub->vm_inv_eng0_sem +
-				      hub->eng_distance * eng, 0);
-
-	return pd_addr;
-}
-
 static void gmc_v10_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int vmid,
 					 unsigned int pasid)
 {
@@ -552,9 +363,9 @@ static unsigned int gmc_v10_0_get_vbios_fb_size(struct amdgpu_device *adev)
 }
 
 static const struct amdgpu_gmc_funcs gmc_v10_0_gmc_funcs = {
-	.flush_gpu_tlb = gmc_v10_0_flush_gpu_tlb,
-	.flush_gpu_tlb_pasid = gmc_v10_0_flush_gpu_tlb_pasid,
-	.emit_flush_gpu_tlb = gmc_v10_0_emit_flush_gpu_tlb,
+	.flush_gpu_tlb = amdgpu_gmc_flush_gpu_tlb_helper,
+	.flush_gpu_tlb_pasid = amdgpu_gmc_flush_gpu_tlb_pasid_helper,
+	.emit_flush_gpu_tlb = amdgpu_gmc_emit_flush_gpu_tlb_helper,
 	.emit_pasid_mapping = gmc_v10_0_emit_pasid_mapping,
 	.get_vmid_pasid_mapping_info = gmc_v10_0_get_atc_vmid_pasid_mapping_info,
 	.use_invalidate_semaphore = gmc_v10_0_use_invalidate_semaphore,
@@ -957,9 +768,9 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 	if (!adev->in_s0ix)
 		adev->gfxhub.funcs->set_fault_enable_default(adev, value);
 	adev->mmhub.funcs->set_fault_enable_default(adev, value);
-	gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
+	adev->gmc.gmc_funcs->flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
 	if (!adev->in_s0ix)
-		gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
+		adev->gmc.gmc_funcs->flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
 
 	drm_info(adev_to_drm(adev), "PCIE GART of %uM enabled (table at 0x%016llX).\n",
 		 (unsigned int)(adev->gmc.gart_size >> 20),
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 8b95a1281886b..b05dda4b0b690 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -208,202 +208,6 @@ static bool gmc_v11_0_get_vmid_pasid_mapping_info(
 	return !!(*p_pasid);
 }
 
-/**
- * gmc_v11_0_flush_gpu_tlb - gart tlb flush callback
- *
- * @adev: amdgpu_device pointer
- * @vmid: vm instance to flush
- * @vmhub: which hub to flush
- * @flush_type: the flush type
- *
- * Flush the TLB for the requested page table.
- */
-static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
-					uint32_t vmhub, uint32_t flush_type)
-{
-	bool use_semaphore = gmc_v11_0_use_invalidate_semaphore(adev, vmhub);
-	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
-	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
-	/* Use register 17 for GART */
-	const unsigned int eng = 17;
-	unsigned char hub_ip;
-	u32 sem, req, ack;
-	unsigned int i;
-	u32 tmp;
-
-	if ((vmhub == AMDGPU_GFXHUB(0)) && !adev->gfx.is_poweron)
-		return;
-
-	sem = hub->vm_inv_eng0_sem + hub->eng_distance * eng;
-	req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
-	ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
-
-	/* flush hdp cache */
-	amdgpu_device_flush_hdp(adev, NULL);
-
-	/* This is necessary for SRIOV as well as for GFXOFF to function
-	 * properly under bare metal
-	 */
-	if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring[0].sched.ready) &&
-	    !adev->gmc.use_mmio_for_tlb_flush) {
-		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
-						 1 << vmid, GET_INST(GC, 0));
-		return;
-	}
-
-	/* This path is needed before KIQ/MES/GFXOFF are set up */
-	hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ? GC_HWIP : MMHUB_HWIP;
-
-	/* disabllow gfxoff when we invalidate */
-	if (hub_ip == GC_HWIP)
-		amdgpu_gfx_off_ctrl(adev, false);
-
-	spin_lock(&adev->gmc.invalidate_lock);
-	/*
-	 * It may lose gpuvm invalidate acknowldege state across power-gating
-	 * off cycle, add semaphore acquire before invalidation and semaphore
-	 * release after invalidation to avoid entering power gated state
-	 * to WA the Issue
-	 */
-
-	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (use_semaphore) {
-		for (i = 0; i < adev->usec_timeout; i++) {
-			/* a read return value of 1 means semaphore acuqire */
-			tmp = RREG32_RLC_NO_KIQ(sem, hub_ip);
-			if (tmp & 0x1)
-				break;
-			udelay(1);
-		}
-
-		if (i >= adev->usec_timeout)
-			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
-	}
-
-	WREG32_RLC_NO_KIQ(req, inv_req, hub_ip);
-
-	/* Wait for ACK with a delay.*/
-	for (i = 0; i < adev->usec_timeout; i++) {
-		tmp = RREG32_RLC_NO_KIQ(ack, hub_ip);
-		tmp &= 1 << vmid;
-		if (tmp)
-			break;
-
-		udelay(1);
-	}
-
-	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (use_semaphore)
-		WREG32_RLC_NO_KIQ(sem, 0, hub_ip);
-
-	/* Issue additional private vm invalidation to MMHUB */
-	if ((vmhub != AMDGPU_GFXHUB(0)) &&
-	    (hub->vm_l2_bank_select_reserved_cid2) &&
-		!amdgpu_sriov_vf(adev)) {
-		inv_req = RREG32_NO_KIQ(hub->vm_l2_bank_select_reserved_cid2);
-		/* bit 25: RSERVED_CACHE_PRIVATE_INVALIDATION */
-		inv_req |= (1 << 25);
-		/* Issue private invalidation */
-		WREG32_NO_KIQ(hub->vm_l2_bank_select_reserved_cid2, inv_req);
-		/* Read back to ensure invalidation is done*/
-		RREG32_NO_KIQ(hub->vm_l2_bank_select_reserved_cid2);
-	}
-
-	spin_unlock(&adev->gmc.invalidate_lock);
-
-	if (hub_ip == GC_HWIP)
-		amdgpu_gfx_off_ctrl(adev, true);
-
-	if (i >= adev->usec_timeout)
-		dev_err(adev->dev, "Timeout waiting for VM flush ACK!\n");
-}
-
-/**
- * gmc_v11_0_flush_gpu_tlb_pasid - tlb flush via pasid
- *
- * @adev: amdgpu_device pointer
- * @pasid: pasid to be flush
- * @flush_type: the flush type
- * @all_hub: flush all hubs
- * @inst: is used to select which instance of KIQ to use for the invalidation
- *
- * Flush the TLB for the requested pasid.
- */
-static void gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
-					  uint16_t pasid, uint32_t flush_type,
-					  bool all_hub, uint32_t inst)
-{
-	uint16_t queried;
-	int vmid, i;
-
-	for (vmid = 1; vmid < 16; vmid++) {
-		bool valid;
-
-		valid = gmc_v11_0_get_vmid_pasid_mapping_info(adev, vmid, 0,
-							      &queried);
-		if (!valid || queried != pasid)
-			continue;
-
-		if (all_hub) {
-			for_each_set_bit(i, adev->vmhubs_mask,
-					 AMDGPU_MAX_VMHUBS)
-				gmc_v11_0_flush_gpu_tlb(adev, vmid, i,
-							flush_type);
-		} else {
-			gmc_v11_0_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB(0),
-						flush_type);
-		}
-	}
-}
-
-static uint64_t gmc_v11_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
-					     unsigned int vmid, uint64_t pd_addr)
-{
-	bool use_semaphore = gmc_v11_0_use_invalidate_semaphore(ring->adev, ring->vm_hub);
-	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
-	uint32_t req = hub->vmhub_funcs->get_invalidate_req(vmid, 0);
-	unsigned int eng = ring->vm_inv_eng;
-
-	/*
-	 * It may lose gpuvm invalidate acknowldege state across power-gating
-	 * off cycle, add semaphore acquire before invalidation and semaphore
-	 * release after invalidation to avoid entering power gated state
-	 * to WA the Issue
-	 */
-
-	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (use_semaphore)
-		/* a read return value of 1 means semaphore acuqire */
-		amdgpu_ring_emit_reg_wait(ring,
-					  hub->vm_inv_eng0_sem +
-					  hub->eng_distance * eng, 0x1, 0x1);
-
-	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
-			      (hub->ctx_addr_distance * vmid),
-			      lower_32_bits(pd_addr));
-
-	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
-			      (hub->ctx_addr_distance * vmid),
-			      upper_32_bits(pd_addr));
-
-	amdgpu_ring_emit_reg_write_reg_wait(ring, hub->vm_inv_eng0_req +
-					    hub->eng_distance * eng,
-					    hub->vm_inv_eng0_ack +
-					    hub->eng_distance * eng,
-					    req, 1 << vmid);
-
-	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (use_semaphore)
-		/*
-		 * add semaphore release after invalidation,
-		 * write with 0 means semaphore release
-		 */
-		amdgpu_ring_emit_wreg(ring, hub->vm_inv_eng0_sem +
-				      hub->eng_distance * eng, 0);
-
-	return pd_addr;
-}
-
 static void gmc_v11_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int vmid,
 					 unsigned int pasid)
 {
@@ -543,9 +347,9 @@ static unsigned int gmc_v11_0_get_vbios_fb_size(struct amdgpu_device *adev)
 }
 
 static const struct amdgpu_gmc_funcs gmc_v11_0_gmc_funcs = {
-	.flush_gpu_tlb = gmc_v11_0_flush_gpu_tlb,
-	.flush_gpu_tlb_pasid = gmc_v11_0_flush_gpu_tlb_pasid,
-	.emit_flush_gpu_tlb = gmc_v11_0_emit_flush_gpu_tlb,
+	.flush_gpu_tlb = amdgpu_gmc_flush_gpu_tlb_helper,
+	.flush_gpu_tlb_pasid = amdgpu_gmc_flush_gpu_tlb_pasid_helper,
+	.emit_flush_gpu_tlb = amdgpu_gmc_emit_flush_gpu_tlb_helper,
 	.emit_pasid_mapping = gmc_v11_0_emit_pasid_mapping,
 	.get_vmid_pasid_mapping_info = gmc_v11_0_get_vmid_pasid_mapping_info,
 	.use_invalidate_semaphore = gmc_v11_0_use_invalidate_semaphore,
@@ -935,7 +739,7 @@ static int gmc_v11_0_gart_enable(struct amdgpu_device *adev)
 	value = amdgpu_vm_fault_stop != AMDGPU_VM_FAULT_STOP_ALWAYS;
 
 	adev->mmhub.funcs->set_fault_enable_default(adev, value);
-	gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
+	adev->gmc.gmc_funcs->flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
 
 	drm_info(adev_to_drm(adev), "PCIE GART of %uM enabled (table at 0x%016llX).\n",
 		 (unsigned int)(adev->gmc.gart_size >> 20),
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 4bb8c1e4f335b..842ea38347367 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -211,219 +211,6 @@ static bool gmc_v12_0_get_vmid_pasid_mapping_info(
  * by the amdgpu vm/hsa code.
  */
 
-static void gmc_v12_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
-				   unsigned int vmhub, uint32_t flush_type)
-{
-	bool use_semaphore = gmc_v12_0_use_invalidate_semaphore(adev, vmhub);
-	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
-	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
-	u32 tmp;
-	/* Use register 17 for GART */
-	const unsigned eng = 17;
-	unsigned int i;
-	unsigned char hub_ip = 0;
-
-	hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ?
-		   GC_HWIP : MMHUB_HWIP;
-
-	spin_lock(&adev->gmc.invalidate_lock);
-	/*
-	 * It may lose gpuvm invalidate acknowldege state across power-gating
-	 * off cycle, add semaphore acquire before invalidation and semaphore
-	 * release after invalidation to avoid entering power gated state
-	 * to WA the Issue
-	 */
-
-	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (use_semaphore) {
-		for (i = 0; i < adev->usec_timeout; i++) {
-			/* a read return value of 1 means semaphore acuqire */
-			tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem +
-					    hub->eng_distance * eng, hub_ip);
-			if (tmp & 0x1)
-				break;
-			udelay(1);
-		}
-
-		if (i >= adev->usec_timeout)
-			dev_err(adev->dev,
-				"Timeout waiting for sem acquire in VM flush!\n");
-	}
-
-	WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req, hub_ip);
-
-	/* Wait for ACK with a delay.*/
-	for (i = 0; i < adev->usec_timeout; i++) {
-		tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_ack +
-				    hub->eng_distance * eng, hub_ip);
-		tmp &= 1 << vmid;
-		if (tmp)
-			break;
-
-		udelay(1);
-	}
-
-	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (use_semaphore)
-		/*
-		 * add semaphore release after invalidation,
-		 * write with 0 means semaphore release
-		 */
-		WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem +
-			      hub->eng_distance * eng, 0, hub_ip);
-
-	/* Issue additional private vm invalidation to MMHUB */
-	if ((vmhub != AMDGPU_GFXHUB(0)) &&
-	    (hub->vm_l2_bank_select_reserved_cid2) &&
-		!amdgpu_sriov_vf(adev)) {
-		inv_req = RREG32_NO_KIQ(hub->vm_l2_bank_select_reserved_cid2);
-		/* bit 25: RSERVED_CACHE_PRIVATE_INVALIDATION */
-		inv_req |= (1 << 25);
-		/* Issue private invalidation */
-		WREG32_NO_KIQ(hub->vm_l2_bank_select_reserved_cid2, inv_req);
-		/* Read back to ensure invalidation is done*/
-		RREG32_NO_KIQ(hub->vm_l2_bank_select_reserved_cid2);
-	}
-
-	spin_unlock(&adev->gmc.invalidate_lock);
-
-	if (i < adev->usec_timeout)
-		return;
-
-	dev_err(adev->dev, "Timeout waiting for VM flush ACK!\n");
-}
-
-/**
- * gmc_v12_0_flush_gpu_tlb - gart tlb flush callback
- *
- * @adev: amdgpu_device pointer
- * @vmid: vm instance to flush
- * @vmhub: which hub to flush
- * @flush_type: the flush type
- *
- * Flush the TLB for the requested page table.
- */
-static void gmc_v12_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
-					uint32_t vmhub, uint32_t flush_type)
-{
-	if ((vmhub == AMDGPU_GFXHUB(0)) && !adev->gfx.is_poweron)
-		return;
-
-	/* flush hdp cache */
-	amdgpu_device_flush_hdp(adev, NULL);
-
-	/* This is necessary for SRIOV as well as for GFXOFF to function
-	 * properly under bare metal
-	 */
-	if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring[0].sched.ready) &&
-	    !adev->gmc.use_mmio_for_tlb_flush) {
-		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
-		const unsigned eng = 17;
-		u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
-		u32 req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
-		u32 ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
-
-		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
-				1 << vmid, GET_INST(GC, 0));
-		return;
-	}
-
-	/* disabllow gfxoff when we invalidate */
-	if (vmhub == AMDGPU_GFXHUB(0))
-		amdgpu_gfx_off_ctrl(adev, false);
-
-	gmc_v12_0_flush_vm_hub(adev, vmid, vmhub, 0);
-
-	if (vmhub == AMDGPU_GFXHUB(0))
-		amdgpu_gfx_off_ctrl(adev, true);
-}
-
-/**
- * gmc_v12_0_flush_gpu_tlb_pasid - tlb flush via pasid
- *
- * @adev: amdgpu_device pointer
- * @pasid: pasid to be flush
- * @flush_type: the flush type
- * @all_hub: flush all hubs
- * @inst: is used to select which instance of KIQ to use for the invalidation
- *
- * Flush the TLB for the requested pasid.
- */
-static void gmc_v12_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
-					  uint16_t pasid, uint32_t flush_type,
-					  bool all_hub, uint32_t inst)
-{
-	uint16_t queried;
-	int vmid, i;
-
-	for (vmid = 1; vmid < 16; vmid++) {
-		bool valid;
-
-		valid = gmc_v12_0_get_vmid_pasid_mapping_info(adev, vmid, 0,
-							      &queried);
-		if (!valid || queried != pasid)
-			continue;
-
-		if (all_hub) {
-			for_each_set_bit(i, adev->vmhubs_mask,
-					 AMDGPU_MAX_VMHUBS)
-				gmc_v12_0_flush_gpu_tlb(adev, vmid, i,
-							flush_type);
-		} else {
-			gmc_v12_0_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB(0),
-						flush_type);
-		}
-	}
-}
-
-static uint64_t gmc_v12_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
-					     unsigned vmid, uint64_t pd_addr)
-{
-	bool use_semaphore = gmc_v12_0_use_invalidate_semaphore(ring->adev, ring->vm_hub);
-	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
-	uint32_t req = hub->vmhub_funcs->get_invalidate_req(vmid, 0);
-	unsigned eng = ring->vm_inv_eng;
-
-	/*
-	 * It may lose gpuvm invalidate acknowldege state across power-gating
-	 * off cycle, add semaphore acquire before invalidation and semaphore
-	 * release after invalidation to avoid entering power gated state
-	 * to WA the Issue
-	 */
-
-	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (use_semaphore)
-		/* a read return value of 1 means semaphore acuqire */
-		amdgpu_ring_emit_reg_wait(ring,
-					  hub->vm_inv_eng0_sem +
-					  hub->eng_distance * eng, 0x1, 0x1);
-
-	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
-			      (hub->ctx_addr_distance * vmid),
-			      lower_32_bits(pd_addr));
-
-	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
-			      (hub->ctx_addr_distance * vmid),
-			      upper_32_bits(pd_addr));
-
-	amdgpu_ring_emit_reg_write_reg_wait(ring, hub->vm_inv_eng0_req +
-					    hub->eng_distance * eng,
-					    hub->vm_inv_eng0_ack +
-					    hub->eng_distance * eng,
-					    req, 1 << vmid);
-
-	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (use_semaphore)
-		/*
-		 * add semaphore release after invalidation,
-		 * write with 0 means semaphore release
-		 */
-		amdgpu_ring_emit_wreg(ring, hub->vm_inv_eng0_sem +
-				      hub->eng_distance * eng, 0);
-
-	return pd_addr;
-}
-
 static void gmc_v12_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned vmid,
 					 unsigned pasid)
 {
@@ -562,9 +349,9 @@ static unsigned int gmc_v12_0_get_dcc_alignment(struct amdgpu_device *adev)
 }
 
 static const struct amdgpu_gmc_funcs gmc_v12_0_gmc_funcs = {
-	.flush_gpu_tlb = gmc_v12_0_flush_gpu_tlb,
-	.flush_gpu_tlb_pasid = gmc_v12_0_flush_gpu_tlb_pasid,
-	.emit_flush_gpu_tlb = gmc_v12_0_emit_flush_gpu_tlb,
+	.flush_gpu_tlb = amdgpu_gmc_flush_gpu_tlb_helper,
+	.flush_gpu_tlb_pasid = amdgpu_gmc_flush_gpu_tlb_pasid_helper,
+	.emit_flush_gpu_tlb = amdgpu_gmc_emit_flush_gpu_tlb_helper,
 	.emit_pasid_mapping = gmc_v12_0_emit_pasid_mapping,
 	.get_vmid_pasid_mapping_info = gmc_v12_0_get_vmid_pasid_mapping_info,
 	.use_invalidate_semaphore = gmc_v12_0_use_invalidate_semaphore,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 2c980dc02c262..b20088e841349 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -281,195 +281,6 @@ static bool gmc_v12_1_use_invalidate_semaphore(struct amdgpu_device *adev,
 		(!amdgpu_sriov_vf(adev)));
 }
 
-static void gmc_v12_1_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
-				   unsigned int vmhub, uint32_t flush_type)
-{
-	bool use_semaphore = gmc_v12_1_use_invalidate_semaphore(adev, vmhub);
-	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
-	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
-	u32 tmp;
-	/* Use register 17 for GART */
-	const unsigned eng = 17;
-	unsigned int i;
-	unsigned char hub_ip = 0;
-
-	hub_ip = (AMDGPU_IS_GFXHUB(vmhub)) ?
-		   GC_HWIP : MMHUB_HWIP;
-
-	spin_lock(&adev->gmc.invalidate_lock);
-
-	if (use_semaphore) {
-		for (i = 0; i < adev->usec_timeout; i++) {
-			/* a read return value of 1 means semaphore acuqire */
-			tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem + hub->eng_distance * eng, hub_ip);
-			if (tmp & 0x1)
-				break;
-			udelay(1);
-		}
-
-		if (i >= adev->usec_timeout)
-			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
-	}
-
-	WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req, hub_ip);
-
-	/* Wait for ACK with a delay.*/
-	for (i = 0; i < adev->usec_timeout; i++) {
-		tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_ack +
-				    hub->eng_distance * eng, hub_ip);
-		tmp &= 1 << vmid;
-		if (tmp)
-			break;
-
-		udelay(1);
-	}
-
-	if (use_semaphore)
-		WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem + hub->eng_distance * eng, 0, hub_ip);
-
-	/* Issue additional private vm invalidation to MMHUB */
-	if (!AMDGPU_IS_GFXHUB(vmhub) &&
-	    (hub->vm_l2_bank_select_reserved_cid2) &&
-		!amdgpu_sriov_vf(adev)) {
-		inv_req = RREG32_NO_KIQ(hub->vm_l2_bank_select_reserved_cid2);
-		/* bit 25: RSERVED_CACHE_PRIVATE_INVALIDATION */
-		inv_req |= (1 << 25);
-		/* Issue private invalidation */
-		WREG32_NO_KIQ(hub->vm_l2_bank_select_reserved_cid2, inv_req);
-		/* Read back to ensure invalidation is done*/
-		RREG32_NO_KIQ(hub->vm_l2_bank_select_reserved_cid2);
-	}
-
-	spin_unlock(&adev->gmc.invalidate_lock);
-
-	if (i < adev->usec_timeout)
-		return;
-
-	dev_err(adev->dev, "Timeout waiting for VM flush ACK!\n");
-}
-
-/**
- * gmc_v12_1_flush_gpu_tlb - gart tlb flush callback
- *
- * @adev: amdgpu_device pointer
- * @vmid: vm instance to flush
- * @vmhub: which hub to flush
- * @flush_type: the flush type
- *
- * Flush the TLB for the requested page table.
- */
-static void gmc_v12_1_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
-				    uint32_t vmhub, uint32_t flush_type)
-{
-	u32 inst;
-
-	if (AMDGPU_IS_GFXHUB(vmhub) &&
-	    !adev->gfx.is_poweron)
-		return;
-
-	if (vmhub >= AMDGPU_MMHUB0(0))
-		inst = 0;
-	else
-		inst = vmhub;
-
-	/* This is necessary for SRIOV as well as for GFXOFF to function
-	 * properly under bare metal
-	 */
-	if ((adev->gfx.kiq[inst].ring.sched.ready ||
-	     adev->mes.ring[MES_PIPE_INST(inst, 0)].sched.ready) &&
-	    !adev->gmc.use_mmio_for_tlb_flush) {
-		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
-		const unsigned eng = 17;
-		u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
-		u32 req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
-		u32 ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
-
-		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
-				1 << vmid, inst);
-		return;
-	}
-
-	gmc_v12_1_flush_vm_hub(adev, vmid, vmhub, 0);
-	return;
-}
-
-/**
- * gmc_v12_1_flush_gpu_tlb_pasid - tlb flush via pasid
- *
- * @adev: amdgpu_device pointer
- * @pasid: pasid to be flush
- * @flush_type: the flush type
- * @all_hub: flush all hubs
- * @inst: is used to select which instance of KIQ to use for the invalidation
- *
- * Flush the TLB for the requested pasid.
- */
-static void gmc_v12_1_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
-					  uint16_t pasid, uint32_t flush_type,
-					  bool all_hub, uint32_t inst)
-{
-	uint16_t queried;
-	int vmid, i;
-
-	for (vmid = 1; vmid < 16; vmid++) {
-		bool valid;
-
-		valid = gmc_v12_1_get_vmid_pasid_mapping_info(adev, vmid, inst,
-							      &queried);
-		if (!valid || queried != pasid)
-			continue;
-
-		if (all_hub) {
-			for_each_set_bit(i, adev->vmhubs_mask,
-					 AMDGPU_MAX_VMHUBS)
-				gmc_v12_1_flush_gpu_tlb(adev, vmid, i,
-							flush_type);
-		} else {
-			gmc_v12_1_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB(inst),
-						flush_type);
-		}
-	}
-}
-
-static uint64_t gmc_v12_1_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
-					     unsigned vmid, uint64_t pd_addr)
-{
-	bool use_semaphore = gmc_v12_1_use_invalidate_semaphore(ring->adev, ring->vm_hub);
-	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
-	uint32_t req = hub->vmhub_funcs->get_invalidate_req(vmid, 0);
-	unsigned eng = ring->vm_inv_eng;
-
-	if (use_semaphore)
-		/* a read return value of 1 means semaphore acuqire */
-		amdgpu_ring_emit_reg_wait(ring,
-					  hub->vm_inv_eng0_sem +
-					  hub->eng_distance * eng, 0x1, 0x1);
-
-	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
-			      (hub->ctx_addr_distance * vmid),
-			      lower_32_bits(pd_addr));
-
-	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
-			      (hub->ctx_addr_distance * vmid),
-			      upper_32_bits(pd_addr));
-
-	amdgpu_ring_emit_reg_write_reg_wait(ring, hub->vm_inv_eng0_req +
-					    hub->eng_distance * eng,
-					    hub->vm_inv_eng0_ack +
-					    hub->eng_distance * eng,
-					    req, 1 << vmid);
-
-	if (use_semaphore)
-		/*
-		 * add semaphore release after invalidation,
-		 * write with 0 means semaphore release
-		 */
-		amdgpu_ring_emit_wreg(ring, hub->vm_inv_eng0_sem +
-				      hub->eng_distance * eng, 0);
-
-	return pd_addr;
-}
-
 static void gmc_v12_1_emit_pasid_mapping(struct amdgpu_ring *ring,
 					 unsigned vmid, unsigned pasid)
 {
@@ -636,9 +447,9 @@ static void gmc_v12_1_get_vm_pte(struct amdgpu_device *adev,
 }
 
 static const struct amdgpu_gmc_funcs gmc_v12_1_gmc_funcs = {
-	.flush_gpu_tlb = gmc_v12_1_flush_gpu_tlb,
-	.flush_gpu_tlb_pasid = gmc_v12_1_flush_gpu_tlb_pasid,
-	.emit_flush_gpu_tlb = gmc_v12_1_emit_flush_gpu_tlb,
+	.flush_gpu_tlb = amdgpu_gmc_flush_gpu_tlb_helper,
+	.flush_gpu_tlb_pasid = amdgpu_gmc_flush_gpu_tlb_pasid_helper,
+	.emit_flush_gpu_tlb = amdgpu_gmc_emit_flush_gpu_tlb_helper,
 	.emit_pasid_mapping = gmc_v12_1_emit_pasid_mapping,
 	.get_vmid_pasid_mapping_info = gmc_v12_1_get_vmid_pasid_mapping_info,
 	.use_invalidate_semaphore = gmc_v12_1_use_invalidate_semaphore,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 2b359c56f8d44..97a0d5b1a974c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -887,94 +887,6 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	DRM_ERROR("Timeout waiting for VM flush ACK!\n");
 }
 
-/**
- * gmc_v9_0_flush_gpu_tlb_pasid - tlb flush via pasid
- *
- * @adev: amdgpu_device pointer
- * @pasid: pasid to be flush
- * @flush_type: the flush type
- * @all_hub: flush all hubs
- * @inst: is used to select which instance of KIQ to use for the invalidation
- *
- * Flush the TLB for the requested pasid.
- */
-static void gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
-					 uint16_t pasid, uint32_t flush_type,
-					 bool all_hub, uint32_t inst)
-{
-	uint16_t queried;
-	int i, vmid;
-
-	for (vmid = 1; vmid < 16; vmid++) {
-		bool valid;
-
-		valid = gmc_v9_0_get_atc_vmid_pasid_mapping_info(adev, vmid,
-								 inst, &queried);
-		if (!valid || queried != pasid)
-			continue;
-
-		if (all_hub) {
-			for_each_set_bit(i, adev->vmhubs_mask,
-					 AMDGPU_MAX_VMHUBS)
-				gmc_v9_0_flush_gpu_tlb(adev, vmid, i,
-						       flush_type);
-		} else {
-			gmc_v9_0_flush_gpu_tlb(adev, vmid,
-					       AMDGPU_GFXHUB(0),
-					       flush_type);
-		}
-	}
-}
-
-static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
-					    unsigned int vmid, uint64_t pd_addr)
-{
-	bool use_semaphore = gmc_v9_0_use_invalidate_semaphore(ring->adev, ring->vm_hub);
-	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_vmhub *hub = &adev->vmhub[ring->vm_hub];
-	uint32_t req = gmc_v9_0_get_invalidate_req(vmid, 0);
-	unsigned int eng = ring->vm_inv_eng;
-
-	/*
-	 * It may lose gpuvm invalidate acknowldege state across power-gating
-	 * off cycle, add semaphore acquire before invalidation and semaphore
-	 * release after invalidation to avoid entering power gated state
-	 * to WA the Issue
-	 */
-
-	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (use_semaphore)
-		/* a read return value of 1 means semaphore acuqire */
-		amdgpu_ring_emit_reg_wait(ring,
-					  hub->vm_inv_eng0_sem +
-					  hub->eng_distance * eng, 0x1, 0x1);
-
-	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
-			      (hub->ctx_addr_distance * vmid),
-			      lower_32_bits(pd_addr));
-
-	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
-			      (hub->ctx_addr_distance * vmid),
-			      upper_32_bits(pd_addr));
-
-	amdgpu_ring_emit_reg_write_reg_wait(ring, hub->vm_inv_eng0_req +
-					    hub->eng_distance * eng,
-					    hub->vm_inv_eng0_ack +
-					    hub->eng_distance * eng,
-					    req, 1 << vmid);
-
-	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (use_semaphore)
-		/*
-		 * add semaphore release after invalidation,
-		 * write with 0 means semaphore release
-		 */
-		amdgpu_ring_emit_wreg(ring, hub->vm_inv_eng0_sem +
-				      hub->eng_distance * eng, 0);
-
-	return pd_addr;
-}
-
 static void gmc_v9_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int vmid,
 					unsigned int pasid)
 {
@@ -1319,8 +1231,8 @@ static bool gmc_v9_0_need_reset_on_init(struct amdgpu_device *adev)
 
 static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 	.flush_gpu_tlb = gmc_v9_0_flush_gpu_tlb,
-	.flush_gpu_tlb_pasid = gmc_v9_0_flush_gpu_tlb_pasid,
-	.emit_flush_gpu_tlb = gmc_v9_0_emit_flush_gpu_tlb,
+	.flush_gpu_tlb_pasid = amdgpu_gmc_flush_gpu_tlb_pasid_helper,
+	.emit_flush_gpu_tlb = amdgpu_gmc_emit_flush_gpu_tlb_helper,
 	.emit_pasid_mapping = gmc_v9_0_emit_pasid_mapping,
 	.get_vmid_pasid_mapping_info = gmc_v9_0_get_atc_vmid_pasid_mapping_info,
 	.use_invalidate_semaphore = gmc_v9_0_use_invalidate_semaphore,
-- 
2.55.0

