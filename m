Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BD0CCF2DA
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 08:34:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B7AF10E86E;
	Mon, 19 Oct 2026 08:34:20 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010034.outbound.protection.outlook.com [52.101.56.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEF7C10E871
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 08:34:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9rSq9yHmZX2zFeq/zbN8syc7+9/0TA5sMYarJsS+74X6OAneg6djTIV96g7ONFDyq7ktSu5o42dJN8B5goSiKsHMrK5muwbUM8F2koYLz6ssysgo8Y1rj3OfKu7q4IN8+/Vr3z/ssby3GoIc4+VurS7Iu+0m1v6JT0jhtrybWDpwlWXiZEwtiBGsc1E/ylqRgowsfRY3K9+QTyM7AIQvvAqEK7Tx8QbOVBm30tMD1AUuwmaRXuspKKGGtYzq+mz3TcqWtRJ9ZbHgCxeSLz7rfpsmKVLmbLJ244e8aiLaPcJpxRIvjhAMy5OiYzCh49ghoPk0PXgwuwkW+EfZ2OYLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WOdP0QpF2hKn79mzWMi28ZECA0t/xQEnQG4WbZrXrg=;
 b=nUzHGpRH6sMDXTUry5wQF2bRsSbrqlCAZvvXDf4zJjwIjlAtSM4lan0wifcgmtY885+9yqnq7dEEMbrb01ph7+wEW9tIigvrsgXYplbCMV8LjyJBG5cKprDc3KUSeYlKN7BMiB2lc6FYTfYeZrr0XsH6hNQT5MZrgS3LiIHDEb3DpNSDdWnLoc1Kv9JmTx+fOsj/oZEANrduqhmtsnmyWhiMLZmo8PJ0VVtrgSS7dnQh3PXwaaYWQv2ZAOyevwJgE6hQ1FYzsyE9RbjBR2c+A49o28GNeH+KGmWcXDTRHJZ4OwB8tUZOG2AdWO5bYKs3lw0G0tBy2H66yAKwSM9haw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WOdP0QpF2hKn79mzWMi28ZECA0t/xQEnQG4WbZrXrg=;
 b=qdmOA026O5OFY8C4LUHEfZYpZ6sCOK9hkEkGYX67ZL2pbCgpvtb0HNVGSJPSWlfHtt6MCIZVbdSiT4/OJjFaRft0ILKIeNqvxuGCnMSxAAykiSVNNflRBmUcEIRiM0+S0S6VkC8Ssyt/iBYZpl1N+TyYdKnWaXwZN85dyW53Hc0=
Received: from PH7PR10CA0009.namprd10.prod.outlook.com (2603:10b6:510:23d::29)
 by SA5PPF6CDAEAF48.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8cf) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 08:34:08 +0000
Received: from PH1PEPF00062F23.namprd02.prod.outlook.com
 (2603:10b6:510:23d:cafe::67) by PH7PR10CA0009.outlook.office365.com
 (2603:10b6:510:23d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Mon, 19
 Oct 2026 08:34:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH1PEPF00062F23.mail.protection.outlook.com (10.167.243.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 08:34:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 03:34:00 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 03:34:00 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 03:33:59 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 03/13] drm/amdgpu/gfx11: add a gfx engine reset
Date: Mon, 19 Oct 2026 16:33:03 +0800
Message-ID: <20261019083402.2033724-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261019083402.2033724-1-Jesse.Zhang@amd.com>
References: <20261019083402.2033724-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F23:EE_|SA5PPF6CDAEAF48:EE_
X-MS-Office365-Filtering-Correlation-Id: f9465379-04e2-4c49-f41c-08df2dbbbe63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|261009223027099003|10067099003|56012099006|3023799007|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: rI/9oBHxUs0hlN58SbbTzId9oZT/VFhmIgIvSLuEjuegqqgbo0OVx9FIToxvZkV5UPLyLVMNU8RVfBgi44u8FW13a9BXp5YYJWYjlrOBOJKOUaMZhZ1H39YeFWCPTR3xLm8CIg7LPFU390DNd73jh0UMOefv2XGiLPYXEqJuyc+TLVdRzNTmquMCSQD5YGFIMJJHWVEho8sp1iBR4k3f9L2gUQqPUpuWf/MMS6LRUUTes1MCyzgx8lGlmbPLzj4kdXcqgFenU4Wa0dRDFnlkm2tqCxr8t0hvWaCR4d9sMUu30dtIhVxHSbJHlBBDjyKhfiAEqzd91Y28kxvyn/HGSslXWrxkwQ6SZIrW11/D4mzu++NjMSt2BcLi0xK+KqMLYlgIfDqwypD/rvunOTHTyuaOhMBcomSEOfRuhgAA0jGUX+k3mSSW8JSBBp5r4i9eeUpUOcwSHl2vRnKgAV77EC7vGP0BUX8Jkoqa5dzhlTeom+PptNmnp8L0xy8jJehCZq9NbiFUnQLnylCJEm2RgLKrJm5SHce9sm0yTDZ2INT/KEeE60yOMyqDlBKWeT+JA7PgN95E0c16kuG/cPdFQWESsoyyPDtkuFJMtsZbuW+O5jELaAkAM6swbopP4QugqGuCLJ8Bj6aUqdohkflt/8CeUJUyCa6RhahswhLMIv7/quDgA3JX44BpCqtHbJLY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(261009223027099003)(10067099003)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MwJiQl3mi9Nsc2BBMk5p/k3SH6u5Q47+ZDuBYSaNAMxzRvNH88z1hDYTkyMPWdGjP1MkgvEJlNYEFyhB0+UKLi0E7K9rCT4rW+QFW2dj4CZwLlCoYF2+7hL2IF3YbmcxS1U7W6LnyFPEqQxF2zhc1cUO180hL9zxA9wnU3FaNKfEOjAc7ZuLsNmLzACJ2xEqLKZXYzNljogjTQZoct7CuEdQuQr3QG7yi4izs6woClUpZpi65xTQ/OFFkF7Myrcuox+uMUOkgMUdm0336ekUra+iadwN2/hBRINEJYfa0f8ShF1DpX/h0Nal7BijwigfMNCCHfTbkvKpl02FvfM6Rz9dIUi1x1VvpJswkV8d+8sXncN4x1sPfi25ckdOTF/sYVYPRBhqwnWQAA2G9uCBoUG3hQa9BEUhvmAnr3KMZBTlaI9OblgRRdu2hhT9bto2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 08:34:08.5125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9465379-04e2-4c49-f41c-08df2dbbbe63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH1PEPF00062F23.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF6CDAEAF48
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

Implement the reset_engine callback for the graphics engine of gfx11, as
for gfx12: a PM4 packet that runs past the end of its IB leaves the gfx
streaming engine stuck, and neither a queue nor a pipe reset recovers it.

- halt PFP/ME and wait for the memory requests of the CP DMA to complete;
- with CP_SOFT_RESET_CNTL.GFX_ONLY_SOFT_RESET and GFX_HQD_REG_RESET set,
  pulse GRBM_SOFT_RESET.SOFT_RESET_CPF/CPG, holding the MES lock, and
  wait for the memory requests again;
- clear CP_VMID_RESET;
- restart PFP/ME from the start of their RS64 firmware and restore
  CP_PFP_IB_CONTROL; if the CP doesn't go idle then, fail the reset so
  that a full reset follows;
- remap the kernel gfx queue through MES from its MQD backup and init the
  CP registers.

MES resets a gfx queue by writing CP_VMID_RESET, which the PFP handles.
When the PFP hung, eg. on a bad opcode, the request stays pending across
the CPF/CPG reset, and the restarted PFP then waits on it forever for
queues the reset already cleared. On Navi31, clearing it turned the
engine resets after a failed queue reset of a bad opcode from 0 of 25
into 25 of 25.

Unlike gfx_v11_0_cp_gfx_start(), don't write the clear state to the
kernel gfx ring: with enforced isolation, a ring write stops the user
queues, which the caller keeps from being mapped or unmapped meanwhile.
The queue reset doesn't write it either.

gfx11 has no helper to restart PFP/ME from their start addresses outside
of the firmware load: add one. A later patch enables the reset with
MES, async gfx rings and the RS64 firmware.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 202 +++++++++++++++++++++++++
 1 file changed, 202 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 315dfd806d56..61811db62faa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -363,6 +363,8 @@ static void gfx_v11_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
 static void gfx_v11_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work);
+static int gfx_v11_0_reset_engine(struct amdgpu_device *adev,
+				  enum amdgpu_gfx_engine engine);
 static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
 				      bool enable);
 
@@ -1150,6 +1152,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 	.get_gfx_shadow_info = &gfx_v11_0_get_gfx_shadow_info,
 	.get_hdp_flush_mask = &amdgpu_gfx_get_hdp_flush_mask,
 	.detect_hung_queue = &gfx_v11_0_detect_hung_queue,
+	.reset_engine = &gfx_v11_0_reset_engine,
 };
 
 static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
@@ -6916,6 +6919,205 @@ static void gfx_v11_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }
 
+/* Restart the PFP and ME pipes from the start of their RS64 firmware. */
+static void gfx_v11_0_restart_gfx_rs64(struct amdgpu_device *adev)
+{
+	const struct gfx_firmware_header_v2_0 *pfp_hdr, *me_hdr;
+	u32 pipe_id, tmp;
+
+	pfp_hdr = (const struct gfx_firmware_header_v2_0 *)adev->gfx.pfp_fw->data;
+	me_hdr = (const struct gfx_firmware_header_v2_0 *)adev->gfx.me_fw->data;
+
+	mutex_lock(&adev->srbm_mutex);
+	for (pipe_id = 0; pipe_id < adev->gfx.me.num_pipe_per_me; pipe_id++) {
+		soc21_grbm_select(adev, 0, pipe_id, 0, 0);
+		WREG32_SOC15(GC, 0, regCP_PFP_PRGRM_CNTR_START,
+			     (pfp_hdr->ucode_start_addr_hi << 30) |
+			     (pfp_hdr->ucode_start_addr_lo >> 2));
+		WREG32_SOC15(GC, 0, regCP_PFP_PRGRM_CNTR_START_HI,
+			     pfp_hdr->ucode_start_addr_hi >> 2);
+		WREG32_SOC15(GC, 0, regCP_ME_PRGRM_CNTR_START,
+			     (me_hdr->ucode_start_addr_hi << 30) |
+			     (me_hdr->ucode_start_addr_lo >> 2));
+		WREG32_SOC15(GC, 0, regCP_ME_PRGRM_CNTR_START_HI,
+			     me_hdr->ucode_start_addr_hi >> 2);
+
+		/* A pipe reset takes the start addresses. */
+		tmp = RREG32_SOC15(GC, 0, regCP_ME_CNTL);
+		if (pipe_id == 0) {
+			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_PIPE0_RESET, 1);
+			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_PIPE0_RESET, 1);
+		} else {
+			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_PIPE1_RESET, 1);
+			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_PIPE1_RESET, 1);
+		}
+		WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
+		if (pipe_id == 0) {
+			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_PIPE0_RESET, 0);
+			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_PIPE0_RESET, 0);
+		} else {
+			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_PIPE1_RESET, 0);
+			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_PIPE1_RESET, 0);
+		}
+		WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
+	}
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
+/* The CP DMA and the interfaces its memory requests go through */
+#define GFX11_CP_STAT_MEM_BUSY	(CP_STAT__DMA_BUSY_MASK | \
+				 CP_STAT__TCIU_BUSY_MASK | \
+				 CP_STAT__RCIU_BUSY_MASK | \
+				 CP_STAT__UTCL2IU_BUSY_MASK)
+
+/*
+ * Soft reset the gfx CP and restart PFP and ME. Returns -ETIMEDOUT if the CP
+ * is still busy once restarted.
+ */
+static int gfx_v11_0_soft_reset_gfx_cp(struct amdgpu_device *adev)
+{
+	u32 tmp, cntl, me_cntl, ib_control;
+	int i;
+
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+
+	/*
+	 * MES fetches its own queues through CPF: a MES command that is in
+	 * flight during the reset doesn't complete. Keep MES commands out
+	 * until the reset is released.
+	 */
+	amdgpu_mes_lock(&adev->mes);
+
+	me_cntl = RREG32_SOC15(GC, 0, regCP_ME_CNTL);
+	/* Cleared by the reset, but otherwise only set by the RLC on GFXOFF exit. */
+	ib_control = RREG32_SOC15(GC, 0, regCP_PFP_IB_CONTROL);
+
+	tmp = REG_SET_FIELD(me_cntl, CP_ME_CNTL, ME_HALT, 1);
+	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, 1);
+	WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
+	udelay(50);
+
+	/*
+	 * Let the memory requests of the CP DMA complete: when they are
+	 * still in flight during the reset, the ME stays busy after it. The
+	 * DMA of a hung stream may never complete, reset anyway then.
+	 */
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!(RREG32_SOC15(GC, 0, regCP_STAT) & GFX11_CP_STAT_MEM_BUSY))
+			break;
+		udelay(1);
+	}
+
+	/* Without GFX_ONLY_SOFT_RESET, a CPF reset would also hit compute and MES. */
+	cntl = RREG32_SOC15(GC, 0, regCP_SOFT_RESET_CNTL);
+	tmp = REG_SET_FIELD(cntl, CP_SOFT_RESET_CNTL, GFX_ONLY_SOFT_RESET, 1);
+	tmp = REG_SET_FIELD(tmp, CP_SOFT_RESET_CNTL, GFX_HQD_REG_RESET, 1);
+	WREG32_SOC15(GC, 0, regCP_SOFT_RESET_CNTL, tmp);
+
+	/* Both are needed: a CPF reset alone leaves the streaming engine stuck. */
+	tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
+	tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPF, 1);
+	tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPG, 1);
+	WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
+	udelay(50);
+	tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPF, 0);
+	tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPG, 0);
+	WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
+
+	WREG32_SOC15(GC, 0, regCP_SOFT_RESET_CNTL, cntl);
+
+	/*
+	 * Let the memory requests in flight drain before PFP/ME restart. Not
+	 * the whole CP: after a hang, the halted PFP stays busy until it is
+	 * restarted.
+	 */
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!(RREG32_SOC15(GC, 0, regCP_STAT) & GFX11_CP_STAT_MEM_BUSY))
+			break;
+		udelay(1);
+	}
+
+	/*
+	 * MES resets a gfx queue through CP_VMID_RESET, which the PFP handles.
+	 * A request the hung PFP never handled survives the reset, and the
+	 * restarted PFP then waits on it for queues the reset already cleared.
+	 */
+	WREG32_SOC15(GC, 0, regCP_VMID_RESET, 0);
+	amdgpu_mes_unlock(&adev->mes);
+
+	gfx_v11_0_restart_gfx_rs64(adev);
+	tmp = RREG32_SOC15(GC, 0, regCP_ME_CNTL);
+	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, CE_HALT,
+			    REG_GET_FIELD(me_cntl, CP_ME_CNTL, CE_HALT));
+	WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
+	WREG32_SOC15(GC, 0, regCP_PFP_IB_CONTROL, ib_control);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+
+	tmp = RREG32_SOC15(GC, 0, regCP_ME_CNTL);
+	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, ME_HALT, 0);
+	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, 0);
+	WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!RREG32_SOC15(GC, 0, regCP_STAT))
+			return 0;
+		udelay(1);
+	}
+	return -ETIMEDOUT;
+}
+
+/*
+ * Reset the graphics engine: the CP front-end (CPF/CPG), PFP/ME and the gfx
+ * HQDs. MEC, MES and the compute queues keep running.
+ *
+ * A malformed packet whose length runs past the end of an IB leaves the gfx
+ * streaming engine waiting for data that never arrives. Neither a queue nor
+ * a pipe reset can stop it, but a CPF/CPG soft reset limited to gfx can.
+ */
+static int gfx_v11_0_reset_engine(struct amdgpu_device *adev,
+				  enum amdgpu_gfx_engine engine)
+{
+	int i, r;
+
+	lockdep_assert_held(&adev->gfx.mec.reset_mutex);
+
+	if (engine != AMDGPU_GFX_ENGINE_GFX)
+		return -EOPNOTSUPP;
+
+	amdgpu_gfx_off_ctrl(adev, false);
+
+	/* Leave a CP that doesn't go idle to a full reset. */
+	r = gfx_v11_0_soft_reset_gfx_cp(adev);
+	if (r)
+		dev_err(adev->dev, "gfx CP still busy after reset, CP_STAT 0x%08x\n",
+			RREG32_SOC15(GC, 0, regCP_STAT));
+
+	/* MES still has the kernel gfx queue mapped on the cleared HQD. */
+	if (!r)
+		r = amdgpu_gfx_disable_kgq(adev, 0);
+	if (!r) {
+		for (i = 0; i < adev->gfx.num_gfx_rings; i++)
+			amdgpu_gfx_mqd_reset_restore(&adev->gfx.gfx_ring[i]);
+		r = amdgpu_gfx_enable_kgq(adev, 0);
+	}
+	/*
+	 * Only init the CP registers: gfx_v11_0_cp_gfx_start() also writes the
+	 * clear state to the kernel gfx ring, and a ring write with enforced
+	 * isolation stops the user queues, which the caller keeps from being
+	 * mapped or unmapped.
+	 */
+	if (!r) {
+		WREG32_SOC15(GC, 0, regCP_MAX_CONTEXT,
+			     adev->gfx.config.max_hw_contexts - 1);
+		WREG32_SOC15(GC, 0, regCP_DEVICE_ID, 1);
+	}
+
+	amdgpu_gfx_off_ctrl(adev, true);
+	return r;
+}
+
 static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 			       unsigned int vmid,
 			       struct amdgpu_fence *timedout_fence)
-- 
2.50.1

