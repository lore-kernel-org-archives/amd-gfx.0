Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074B3606A31E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lAfw9DtS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75363112212;
	Thu, 26 Nov 2026 09:34:52 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C1A91121E3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 09:34:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmGEnC700QdBr/7L0+F/Vej9QeiltGBco+NtKSiZ/8IRCtELsJbcWtqopxfEvSHogJAI+9Qq/s19n3SfNb8gQugLEE+CwzDgYylNE+6+5p+61BObCOkhA7wGrAJFAdhUgdOUdhkJSaI/G7qb3mk5vWPBR82chdDPP5PLocXI7OFf0hxvPOp6TkpWEvKSCF0QSVaegDo0TS9gRPqxesgYvjhK2H254cJhtVpIs0Y9Mh+tFNsjsZrOjWMraoVnPpwDfRfGsA0X+CoXpPbC85KosMDF8gUnNSyQQChH0UBb/0sxSYp2jwApSYHg3r1ZSbLgihtqJcoHCS7BqOf1yn+JEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5uudC1npo2qzSMKkuvkMxMN360cbRS5lVYJ9qcqOLs=;
 b=dC2Eo06N3KzkW6OSIk4/9MOoRo90pK8HIJsW88nOMNiiVMDBl9aF62X7JV4TgSFaBR0NL7N+k1oub7cqufK13EbUJ+hjuJYxRehVmNsPromYYNZZs18MpyjP/kh1yXqGKO4qr1dRu1v1clSyDPMGdEH0mof833sjJC9Bu1tj3pLOhOdilWEzQ9ftff0AD24z/x0sdl5iU0Q+c93UhtTRsgyfTBEnzJ5g+U8Ni5jhN3ztZLKXoKk1HhpnM2I4LvAxxQYvorEjBWM+kd8pi+u/pCI9IE6L4N+O1CZhYv/PNJDBGI7z3EGJybnxSl/o694ebmFb7qX+JJmXUjaBK4hetA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5uudC1npo2qzSMKkuvkMxMN360cbRS5lVYJ9qcqOLs=;
 b=lAfw9DtSL45CpDYFcOPHg0ckvUNFvflU8HX3CRirFFG4C+PpJWkbzZlt17zu1lJHVDp6+axnm62QvQdHWWAVM2f7kDcRP3DsCLlvd6VD1TV36FiJzqWqWUkM4n8RSTadeNgHB2Je+p3zAU8jYx/VdLOcARhunUrxLLgvEAo3izk=
Received: from BN0PR04CA0080.namprd04.prod.outlook.com (2603:10b6:408:ea::25)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 09:34:39 +0000
Received: from BN7PEPF000000A2.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::6) by BN0PR04CA0080.outlook.office365.com
 (2603:10b6:408:ea::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 09:34:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A2.mail.protection.outlook.com (10.167.248.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 09:34:39 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 03:34:38 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 26 Nov 2026 03:34:35 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v5 06/15] drm/amdgpu/gfx11: save and restore a gfx HQD
Date: Thu, 26 Nov 2026 17:33:42 +0800
Message-ID: <20261126093417.192538-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261126093417.192538-1-Jesse.Zhang@amd.com>
References: <20261126093417.192538-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A2:EE_|BY5PR12MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9ad269-c815-4d3c-49d7-08df4ba07e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|6133799003|22082099003|18002099003|3023799007|56012099006|11063799006|261028144727099003|261102123227099003|261026121527099003|261022105027099003|261021121427099003|261026140227099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: DM2SHLMmYEJv1QfHZplnDukdQ+G9S+0AOdsztLAZ1ocKbEo+cVOF4W1bY3XBMYZ2GYM4wiBbiBi4g7OkK+5aUxRjYjj2iGRkWIJY1tWm00D4A4tqi9BtZGXKlBMHTAparmhPEWw0+tkFApiRM9JFK4SS2DbBXwstrPDldrr4CDW9ZD0FPJkjkFt14ZeUhidVe2kcaxJIRMZ7EsKcHtkZfEeoLijHbcnNi/7wiZ9QahZdYv1dAmmMihpP74aeSjpTb2irb/vS0IulusrG8oJlvHkVU6v9wWBHyGphbnNOaQsePPKiZ7nSlnTH6jUdHCnDhoC0tEoEhAPQgJqOTiNS+fqVG5kLZvylAAr4c6D2Xvo8OKw9rnmjWz4tQ1/uHIei7ELrD7lCdoojKZbe3za8E1ibdmW/bAdKb0qVYwI9XnHqbIEP870GGmiJT6g+cS3AUDRxR2Ph75a4kBwXDEr6yaX6dqwUe5XEveHwC44x8HgBMNcTiEPAiy4B+4MyrSKVp31S4sK0Hce7wyEjMSPQj72+NYY6akSXVh5XfdbMbws9DMBDGH+afHkX5BZrmRiwpaAAJWMOTMZJM7kDAj6V8LRuYIAXz3DPRWLzJfT7F+RX/nuczTH1RvrFuqwx487roFvNRRckgJUGe9fwHDluUFACLQxK2N4kpmFPBkn3+Au3OTd+MLjHT34Guq4Lpbu6Z/8RzbaxqCptJZnZL9+HcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(261028144727099003)(261102123227099003)(261026121527099003)(261022105027099003)(261021121427099003)(261026140227099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fIWRWCOV1hIkjkIRNYfHtFdkFry3AqK96PVPi+gJgG8OUsTeUAjzpM8X6FBB8RXp0fSOsLwbiEcPgL98p4YG34sRnrc7z9ieRetXmt6+sBgtrOkh+FFRmWJ3l0eqLeZ2gB8HL6JhugYsJQQFgP1HVguwR3MatD9sPRNDGCYtr5X9Wm0DpNzTsz5C6edlyH/NhOaH677hr8/Y1QetSTLK3vo0nf3kFzM0GUOUjbDSogeeJzaYSoJ+RklhpPM1VL+0quqM+88/CQevm4A2sPnw+jKnM84Mkyte2Dn4qH/tpClaPiYl8GcujOunFDCoiTn+ohWrJEskNOHYGUTCxAZ5l/9LtYJCDfdo0CulB7s36XG2Yw2vbDLmzG+O0/3UhRzHfkEEOrkzftuj4dHtw1UOkBeJvKkd9D6UEEJDTM0HBWs0BwDRs6dJ3psKocuuHlEK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 09:34:39.1511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9ad269-c815-4d3c-49d7-08df4ba07e13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049
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

Implement the gfx callbacks to save and restore a gfx HQD for gfx11:
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

Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 83 ++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 570f0f3a2ea5..ecf8a156b7ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -382,6 +382,11 @@ static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
 				      struct amdgpu_ring *ring,
 				      unsigned int vmid);
 static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work);
+static bool gfx_v11_0_save_hqd(struct amdgpu_device *adev, u32 doorbell_index,
+			       struct amdgpu_gfx_saved_hqd *hqd);
+static bool gfx_v11_0_restore_hqd(struct amdgpu_device *adev, void *m,
+				  u32 ring_size,
+				  const struct amdgpu_gfx_saved_hqd *hqd);
 static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
 				      bool enable);
 static bool gfx_v11_0_set_perfmon_clk_override(struct amdgpu_device *adev,
@@ -1171,6 +1176,8 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 	.get_gfx_shadow_info = &gfx_v11_0_get_gfx_shadow_info,
 	.get_hdp_flush_mask = &amdgpu_gfx_get_hdp_flush_mask,
 	.detect_hung_queue = &gfx_v11_0_detect_hung_queue,
+	.save_hqd = &gfx_v11_0_save_hqd,
+	.restore_hqd = &gfx_v11_0_restore_hqd,
 };
 
 static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
@@ -6813,6 +6820,82 @@ static void gfx_v11_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }
 
+#define GFX11_HPD_QUEUE_STATE_CONNECTED_MIN	3
+#define GFX11_HPD_QUEUE_STATE_CONNECTED_MAX	15
+
+static bool gfx_v11_0_save_hqd(struct amdgpu_device *adev, u32 doorbell_index,
+			       struct amdgpu_gfx_saved_hqd *hqd)
+{
+	u32 me, pipe, queue, status, state;
+
+	memset(hqd, 0, sizeof(*hqd));
+	hqd->doorbell_index = doorbell_index;
+	if (!gfx_v11_0_detect_hung_queue(adev, doorbell_index, &me, &pipe, &queue))
+		return true;
+
+	amdgpu_gfx_off_ctrl(adev, false);
+	mutex_lock(&adev->srbm_mutex);
+	soc21_grbm_select(adev, me, pipe, queue, 0);
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
+		state >= GFX11_HPD_QUEUE_STATE_CONNECTED_MIN &&
+		state <= GFX11_HPD_QUEUE_STATE_CONNECTED_MAX &&
+		REG_GET_FIELD(status, CP_GFX_HPD_STATUS0, MAPPED_QUEUE) == queue;
+out:
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	amdgpu_gfx_off_ctrl(adev, true);
+
+	return true;
+}
+
+static bool gfx_v11_0_restore_hqd(struct amdgpu_device *adev, void *m,
+				  u32 ring_size,
+				  const struct amdgpu_gfx_saved_hqd *hqd)
+{
+	struct v11_gfx_mqd *mqd = m;
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
 static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 			       unsigned int vmid,
 			       struct amdgpu_fence *timedout_fence)
-- 
2.50.1

