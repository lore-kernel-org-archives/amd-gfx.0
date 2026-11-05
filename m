Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF55606A326
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 03:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2ShdRbDG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 493EE10E91F;
	Thu,  5 Nov 2026 03:06:43 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A3B910E91F
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 03:06:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epWgqaEt+Aoi47L8tozbPT/Drqr3Yn0AJDwtpYUHxqJFa/qdrhRpLAztZJKcDNs5iacPkT1mzV3xD4xQgpmvbqUZUzAg+w8KH50nAmHRkQzU3zdfrxEyAl+B6MJjpEluUdVf9YwZfcJMgPoMWsMgIRUr61qSSWjC/Km4Za/384Tfl+ZQmMEDd7xH0DsmmF1G+bBdb8sHFxgtZ8FLy3TNcEKXwzoO+nFmx891nFfKRl3v9wCq4c6tu8LGsAApDitLNKvx3j1MyDLlA+vLhrTLfeEFd12fB3ztb26JzBVWPEKWWvyC/QecT+G5nMQiA83bX1DjfpDBZYgjAAL6rq/Cvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTOC7F65fDmqazGOxblWTg4vKyhjRemHJMRZtZAzXVM=;
 b=SlaJMy6/luaEUx4+6w40nRUjT2JfBKORvTEReAhLSBGOY5Ky+yR6hX3/4TOZqP9RKZ7nlsATnXGJS8z20wiCB/MHkeCELGtqY3TB3kh/AhVNl8bCyNLVP7MuUq26CQjxzIRDkq5tHOE9312LnnCBzuc5z2mdypuuXV9zoo9MTAUXwtoZgrC2GgXTk1fFA3dg5tyX96h7V3wTJ4Tyd4q1rdsDfAihFCFG46BI7kcjytQcnMSfS1ene4KT2OjCJpfHT4LEH+xIrQxFCcOJNtzO8WhhXBlSq7VaZM/h2+viotgnQvGL4wTMgxfx5jhrUS5X8Bme9Y8m9mGZVRzUk76SRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTOC7F65fDmqazGOxblWTg4vKyhjRemHJMRZtZAzXVM=;
 b=2ShdRbDG7ORedaQop5IYV765y362RNrlFoHl+r/6woZ4ysp/SyOZymR7DAqu24zkkeDzWi31EWrw/utrNkxP6mUzhzWG+gKLpqhKrlnFo1LDWxMn11O2zmU0JX9DpuQfaBCXSOMF6uix/kwafilrfhxRGSFSZcKv1c60aCF3pgY=
Received: from BN9PR03CA0312.namprd03.prod.outlook.com (2603:10b6:408:112::17)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 03:06:30 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::36) by BN9PR03CA0312.outlook.office365.com
 (2603:10b6:408:112::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 03:06:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 03:06:29 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 21:06:28 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 21:06:28 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 21:06:26 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v4 06/13] drm/amdgpu/gfx11: save and restore a gfx HQD
Date: Thu, 5 Nov 2026 11:05:48 +0800
Message-ID: <20261105030612.726542-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261105030612.726542-1-Jesse.Zhang@amd.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|MN2PR12MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: f7208aa8-c501-4b79-120b-08df3ae9c9cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|6133799003|22082099003|18002099003|10067099003|11063799006|261021121427099003|261028144727099003|261026121527099003|261102123227099003|261026140227099003|261009223027099003|56012099006|261022105027099003;
X-Microsoft-Antispam-Message-Info: vwCUf2Sb2b4Ega2aFOcmuUIfCkefgUXe5ckzTFazvNdaceS11ql7ahXHh4NFoeMe1zQ7Wvyk0Ir3fkL+HKRh0MtzZA6HbfP1CACTpfuvnxIhMkVxDCB/GFdjE38pULZKNQThekqfTZoS1p7HP16YAkYhTXissayFvVke+3Vgaf3wES0hXxFFOMhOuGDhVMB/9B8rhMdKfhLtCM3eCH6tT7dJsZlOpUNbuoXeg4TKXl/mgTEhV/VDjWBzfHM8OLGdSMp/D0Dv2TbC8i8FcZvXDHnDzw8runwvaDcHjFg1ZL1+Y/ohe4Eo7Asnb51U7h5w+YJcnwkLR1dnkKWoBoU+R4+4VmE/b2k5bFr+i2gBM0g1AKc5vc5TUR0/VGjtCRhCQOWSar9O38aONkPwAvZNvgbBflk1PTqTCVhoaq0oeefeuAcXDy5jW/4UskrqgVztaxnUZPZ39yNLOhfw9fedngj35UpoaVKL4K50grjlT5MRi7ZAWh6Ggse0mKGvOW/v9Lr4fB4xEixKe7P4nq5QNS62u2r6mMrkN9aCtFA3rEUMrU9KGGpTsnNjcMf16znRBOxl6gJiJ6OlJe046tR/SglQZCsJC7ZxBMAiXUOepUTbpbWbLbzmRF7UWMhOdiwvzu+XcHSxlzdrDZ3fo63ZC/D0i2mJ/U799OChYH6s2uxQntdAlmUGko6HBx1JVSdp9elxJMaMgzy058r1WJEQ7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(261021121427099003)(261028144727099003)(261026121527099003)(261102123227099003)(261026140227099003)(261009223027099003)(56012099006)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SoSXxFGJJB/cOfpWEqLXA4Rh7hDqwQf//NkpNuZfafEAxNoFdjU0EEPXSOAsB6FczMIrWIDFKKwerTtE41mY+ivpV0p2IRgfN7fFnNvXljK/y4AbaqJT4T0saMagefIKPWY4lcdjvqqmBysDJS1umgN+qHIJfSD2zoVxZtuz+BFuyy7RUZx/bMOpeCaJVLYR4vbyzG4kilzJH01xjZDKnzj66aAbM6fyP7oK7PtSz6y8YHYIEvStw169TzQRI1CJHQRvCemEI0E4qBJqUU+SppUYZpHwqQpIFa4YYr3l5s8I50T9T5LW1JFpJGkoin6FnUbzT+fCMgXO7lWJ/hKz/j+Ps4WdH7n3Q+n3okwNEt6m2HO1thj7pIKQXsDfJqWR3L3Q0UhlCdzdzV5fwfFru9FDF/Nqx0ZjXGG4k/siywMcImz/nGZ3MM2Q6f+F/OyC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 03:06:29.7046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7208aa8-c501-4b79-120b-08df3ae9c9cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 83 ++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 430b8f3743b2..798015689f0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -365,6 +365,11 @@ static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
 				      unsigned int vmid);
 static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work);
+static bool gfx_v11_0_save_hqd(struct amdgpu_device *adev, u32 doorbell_index,
+			       struct amdgpu_gfx_saved_hqd *hqd);
+static bool gfx_v11_0_restore_hqd(struct amdgpu_device *adev, void *m,
+				  u32 ring_size,
+				  const struct amdgpu_gfx_saved_hqd *hqd);
 static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
 				      bool enable);
 
@@ -1150,6 +1155,8 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 	.get_gfx_shadow_info = &gfx_v11_0_get_gfx_shadow_info,
 	.get_hdp_flush_mask = &amdgpu_gfx_get_hdp_flush_mask,
 	.detect_hung_queue = &gfx_v11_0_detect_hung_queue,
+	.save_hqd = &gfx_v11_0_save_hqd,
+	.restore_hqd = &gfx_v11_0_restore_hqd,
 };
 
 static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
@@ -6770,6 +6777,82 @@ static void gfx_v11_0_emit_mem_sync(struct amdgpu_ring *ring)
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

