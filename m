Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7E7CC6B38
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 14:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F248511286B;
	Fri, 16 Oct 2026 14:28:45 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012032.outbound.protection.outlook.com [52.101.48.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5B7310E10B
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 14:28:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIbSrxphxoxDn4uvhGJNtHpoB30LpoH+qqgfNj0reXA9OBWbzSBnlj/f8bF+twWRnltQrdXCouYieUhEgR1NVKKbCv3MfmM5iH8Sc2pPABGeoNiaRjnq5ns97cCyzNROCNdajpJDFMfwfJqZlq9UPGADPlUK9Myslf8YG7WDRbwUjOQWMqaTD6J1wkMo37j9CKvNmkFTZ1BBSfPvMsJpsFFgwhh9he2jJTs48dCVmEXkecbLW1hsLoxwTz+9vqezIFTfXmaKJen2fxuPIi/bvUohqgCiktndhTM6gjM5XjyHbMhNp2FpO3jFCQuxE8wdySV6xueUWK0RykAPHMbkOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3WqzYMAxqMNzcWwbKha+uUzjKn2j/VTRi0iMFUWXIE=;
 b=Y+nGaTC93/pplk/HPKk5sraCOp0pRZNNLaOiqoaI2fY2FRSgPtSKC+aT8mei+G0ujyAnH66ZEkq/QXYT9rEfQYG4MtoaDOrfiwjM7PyUs5VXDsFBMWdypj4RgSITRjttW722LMSMkU6yVBdWjkN1Wq3JZogdzRvtkXkY5/I7bk+eqM2RM18boNacw5Q3r79FjRf3/PraKZFROhdHFH4lKUhI15nD1ec1/iCFfWYRAaDVP4ehfv7SlEpot7Rzj04XJ2ZBQksPZ7CZ2XBKDFh9xaVwNqisnXKBin083PaHfiOCtUHYiO4PFsyRJmYk7bqaPht+m/J4CVDpUXPvQbxnkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3WqzYMAxqMNzcWwbKha+uUzjKn2j/VTRi0iMFUWXIE=;
 b=L3PEn9RpL28WCYLjSlgahxTfQkDOddTqcIFYt+95Yb7zIgS5OJ3S/7N8HGOGGJ8pb2VfTsRlu0CRgVZsJ0HCNvP3NwI2dCpkC0Y6nQo7L4/5tjJ9Pawyod8+Y5XeSR9Erb4O6Cu5S/Ihr0uCHi3rg2xDAvSfwl52wzRdcEEcO0U=
Received: from BN0PR04CA0105.namprd04.prod.outlook.com (2603:10b6:408:ec::20)
 by SJ2PR12MB8062.namprd12.prod.outlook.com (2603:10b6:a03:4c8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Fri, 16 Oct
 2026 14:28:34 +0000
Received: from BN3PEPF00022BC3.namprd05.prod.outlook.com
 (2603:10b6:408:ec:cafe::a5) by BN0PR04CA0105.outlook.office365.com
 (2603:10b6:408:ec::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 14:28:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC3.mail.protection.outlook.com (10.167.248.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 14:28:31 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Fri, 16 Oct 2026 09:28:23 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <shaoyun.liu@amd.com>, Yongqiang Sun <Yongqiang.Sun@amd.com>, Shaoyun Liu
 <Shaoyun.Liu@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: wire mes_dbgext on mes12.1
Date: Fri, 16 Oct 2026 10:28:16 -0400
Message-ID: <20261016142816.361760-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC3:EE_|SJ2PR12MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be0e0a0-857e-4a6e-c4fa-08df2b91c0c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|56012099006|10067099003|3023799007|11063799006|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: rXgNave+LiZumlHDiUBDyAOAEEBmF29+h7bwlPTipNStY32lQU70i3Hb8B1UAmhhi9UJQXSp/zhlh+ZSaSUyBnzNJiVfiZbSQu3hGlJ7VFb9KJSLlTu3BgpO2TEfD+4+ys7iBHZ7NpAPkihoHsCHCsm3gBr4qzx/ujsk0bPBTy/eHPHAh2U/r6XpYTurmGzpqqpUNYW6NfxTkdo5zrZ6dokefykQC5Y7GYSXxBrhaQa0E2+TiozQO907M3YeDox6Ns/yw5kPJViOyKngeTri6pn2n/Fd+ARlWX72lbjjoUgStjDlejlL4IZ0N8xCnNISid0vmLEIOJhO/6j8QXWCe2l2cmgYpNy1nomocanPAaFG1LPQ7o/DgeW9mC+8WHGZY9Ht3sNz/BQKo+XslQMQUjEZ8NpEjAWCCdcjGizjiXCGXAyw/xvoWsfrfTXFmDZMcheZcYp/nLLZNt6C5nJcvc0kiS6lmW7XPMzaaWFgFIty9l1wSEJ2xxrGxnaW7TKnnDI9bXnkkxH+DMZP5W/Jd83yWDLjGDTNnwBHJhvy6Ac30Z7dKsC16JTwtCAzMxJkG1Ll2k3gxy5aUHOGNx7Ti8+/GLf5IJw209oj8ncDGmoaeJi6e71yJWdJG9DtXc39kWiW3Jn9krSe5PdGdhSSPCm/SMwD72w1R3GWIdbSjl4oR9DxD4Peg6sZPOS79R9VuNaTIptrEaJsMkyaAFM+Ug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(56012099006)(10067099003)(3023799007)(11063799006)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 86ulaQDNfIeveVsR37TwUAuVp+IL7UaLrCoBhxLTfLHBqVVkEBsCdE4hjuO7YIz6PKwi9+YKEz79RC8KROE8NEvOxiehrIlT5U93a1I3NKd6+p4+aBJBTlReciqS3TF63+lNC+N3PRsv3/+wjJyXxC1bna7YbfCaJeMHgfrLrZOiNpQWP6aUeJJBqnkoxxWdfbWg0qZFvStJe9+s+7Ai2MMwI7pEYYIkmDRJyAj6urHtUr2Ssgpae0zA3oGjvFxd+4euQOu7v0QB7huQ9XXZtObwlfDAV3hoLgve4NVasp0JD5DEM1xCQbofhetY0ZDR7Li2qsUIU+gCGAONcvl4+h8mc2SbLMXF/Cz4gQICCYbdLDEk5k7woJDKsNDLsahDZU4s5RGsAS6OqHcd9kBgNQFJcBPVCxcSpBAjMvZkWjeVjHEbh23j4ZEB6JNVjcn2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:28:31.4169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be0e0a0-857e-4a6e-c4fa-08df2b91c0c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8062
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

Add the per-IP hardware wiring that drives the mes_dbgext core on
mes12.1 (mes_v12_1 / gfx_v12_1): handle MES_MISC_OP_SETUP_MES_DBGEXT in
the misc-op path, unmask the MES host (TIME_STAMP) interrupt across both
me3 pipes via the XCC-aware GRBM select, select the zoned buffer format
in sw_init(), start/stop the feature from hw_init()/hw_fini(), and drain
the log from the me3 EOP interrupt handler while the feature is active.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
Reviewed-by: Shaoyun Liu <Shaoyun.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 19 +++++++
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 68 ++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 147bed75261c..52a8c5022da8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -3489,6 +3489,25 @@ static int gfx_v12_1_eop_irq(struct amdgpu_device *adev,
 
 	DRM_DEBUG("IH: CP EOP\n");
 
+	if (((entry->ring_id & 0x0c) >> 2) == 3) {
+		u32 type = amdgpu_mes_ih_int_type(doorbell_offset);
+
+		switch (type) {
+		case AMDGPU_MES_IH_INT_TYPE_DBGMSG:
+			/*
+			 * MES firmware debug-extension ("mes_dbgext") messages are
+			 * delivered as an EOP interrupt from the MES scheduler pipe
+			 * (me 3).  Type is in context dword bits 31:26 (MES_DBGMSG = 7).
+			 */
+			if (adev->mes.dbgext_active)
+				amdgpu_mes_dbgext_notify(adev, doorbell_offset);
+			break;
+		default:
+			break;
+		}
+		return 0;
+	}
+
 	if (adev->enable_mes && doorbell_offset) {
 		amdgpu_userq_process_fence_irq(adev, doorbell_offset);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index ef81c5a23b9d..c5fefba912a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -42,6 +42,7 @@ static int mes_v12_1_hw_fini(struct amdgpu_ip_block *ip_block);
 static int mes_v12_1_kiq_hw_init(struct amdgpu_device *adev, uint32_t xcc_id);
 static int mes_v12_1_kiq_hw_fini(struct amdgpu_device *adev, uint32_t xcc_id);
 static int mes_v12_1_setup_coop_mode(struct amdgpu_device *adev, int xcc_id);
+static int mes_v12_1_enable_dbgext_irq(struct amdgpu_mes *mes, bool enable);
 
 #define MES_EOP_SIZE   2048
 #define MES12_HUNG_DB_OFFSET_ARRAY_SIZE 8 /* [0:3] = db offset [4:7] hqd info */
@@ -631,6 +632,13 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 		misc_pkt.change_config.option.bits.limit_single_process =
 			input->change_config.option.limit_single_process;
 		break;
+	case MES_MISC_OP_SETUP_MES_DBGEXT:
+		misc_pkt.opcode = MESAPI_MISC__SETUP_MES_DBGEXT;
+		misc_pkt.dbgext_init_data.dbg_ext_mc_addr =
+				input->setup_mes_dbgext.log_buffer_mc_addr;
+		misc_pkt.dbgext_init_data.u64_all =
+				input->setup_mes_dbgext.log_options;
+		break;
 	default:
 		DRM_ERROR("unsupported misc op (%d) \n", input->op);
 		return -EINVAL;
@@ -954,6 +962,52 @@ static int mes_v12_1_inv_tlbs_pasid(struct amdgpu_mes *mes,
 
 }
 
+/*
+ * Enable/disable delivery of the MES firmware host interrupts at the CP.  The
+ * MES firmware debug-message ("mes_dbgext") interrupt is delivered to the IH
+ * as a CP EOP (src_id 181) on the MES scheduler pipe (me 3) and handled in
+ * gfx_v12_1_eop_irq(); it is gated by CPC_INT_CNTL in the me3/MES pipe context,
+ * selected via GRBM_GFX_CNTL.  Must run in process context (takes srbm_mutex).
+ *
+ * Although the firmware C code passes Rs64HostIntrGeneric1IntEnable, the RS64
+ * library routine that actually raises the interrupt (AsmRs64SetHostIntr)
+ * hardcodes the TIME_STAMP assertion bit (CP_INT_STAT_DEBUG bit 26).  So
+ * TIME_STAMP_INT_ENABLE - not GENERIC1_INT_ENABLE - is the CPC_INT_CNTL bit
+ * that lets the CP forward the assertion to the host IH.  CPC_INT_CNTL is
+ * per-(me,pipe); the enable must be set on both me3 pipes (0 and 1), matching
+ * the Windows/SR-IOV KMD path - setting it only on the scheduler pipe is not
+ * sufficient.  Armed on every XCC, since each runs its own MES and logs into
+ * its own per-XCC buffer region.
+ */
+static int mes_v12_1_enable_dbgext_irq(struct amdgpu_mes *mes, bool enable)
+{
+	struct amdgpu_device *adev = mes->adev;
+	int num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	u32 cp_int_cntl;
+	int pipe, xcc_id, inst;
+
+	mutex_lock(&adev->srbm_mutex);
+
+	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
+		inst = GET_INST(GC, xcc_id);
+
+		for (pipe = 0; pipe < 2; pipe++) {
+			soc_v1_0_grbm_select(adev, 3, pipe, 0, 0, inst);
+
+			cp_int_cntl = RREG32_SOC15(GC, inst, regCPC_INT_CNTL);
+			cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CPC_INT_CNTL,
+						    TIME_STAMP_INT_ENABLE, enable ? 1 : 0);
+			WREG32_SOC15(GC, inst, regCPC_INT_CNTL, cp_int_cntl);
+		}
+
+		soc_v1_0_grbm_select(adev, 0, 0, 0, 0, inst);
+	}
+
+	mutex_unlock(&adev->srbm_mutex);
+
+	return 0;
+}
+
 static const struct amdgpu_mes_funcs mes_v12_1_funcs = {
 	.add_hw_queue = mes_v12_1_add_hw_queue,
 	.remove_hw_queue = mes_v12_1_remove_hw_queue,
@@ -965,6 +1019,7 @@ static const struct amdgpu_mes_funcs mes_v12_1_funcs = {
 	.reset_hw_queue = mes_v12_1_reset_hw_queue,
 	.detect_and_reset_hung_queues = mes_v12_1_detect_and_reset_hung_queues,
 	.invalidate_tlbs_pasid = mes_v12_1_inv_tlbs_pasid,
+	.enable_dbgext_irq = mes_v12_1_enable_dbgext_irq,
 };
 
 static int mes_v12_1_allocate_ucode_buffer(struct amdgpu_device *adev,
@@ -1524,6 +1579,15 @@ static int mes_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->mes.kiq_hw_fini = &mes_v12_1_kiq_hw_fini;
 	adev->mes.enable_legacy_queue_map = true;
 
+	/*
+	 * Enable mes_dbgext by default on mes12.1: seed an 8 KB runtime
+	 * request so hw_init() -> amdgpu_mes_dbgext_start() brings the log up at
+	 * boot with no mes_dbgext_buffer_size module param needed.  The
+	 * collection mode still follows mes_dbgext_options (default bit0 = 1,
+	 * interrupt-driven).  Both module params continue to override this.
+	 */
+	adev->mes.dbgext_runtime_kb = 8;
+
 	adev->mes.event_log_size = AMDGPU_MAX_MES_PIPES *
 				   AMDGPU_MES_LOG_BUFFER_SIZE * num_xcc;
 
@@ -1818,11 +1882,15 @@ static int mes_v12_1_hw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
+	amdgpu_mes_dbgext_start(adev);
+
 	return 0;
 }
 
 static int mes_v12_1_hw_fini(struct amdgpu_ip_block *ip_block)
 {
+	amdgpu_mes_dbgext_stop(ip_block->adev);
+
 	return 0;
 }
 
-- 
2.43.0

