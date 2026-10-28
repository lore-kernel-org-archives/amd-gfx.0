Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D283606A33E
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dMVEkod4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B508010E6AC;
	Wed, 28 Oct 2026 17:04:59 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BCAF10E6AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 17:04:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QiClHUh2md/IN+o0OwmGen4LfOAKyr9FPV7CZNfePS79n3B+RVi9oZ+WJxjj+HERdNw01aPQjEr3Ltv6DMHd3eBeuWaTGBsr3UHyn4qxHlVcwEzMelAbj44WZpXYR+/J4+4hdYTznYVTX03ecTxN9A6+Ic2c6ydh+XPPsdwqZ8CBYZM5kcjtC8ZtIOGrI+NGDxTta1oMm1d0jNii8i5CZ4ks7VTTUJ8vq/4swstvrzrEzbdVHZh5rlDU0DCt/j+oK9JsBI5WJecEHG1KVDc3fuNYmOcosyYrWErYKOdkWuN0fYo/qsv58P4CFzqynvvxz7EMw0xEBdQJcGtICxbXFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1ENskJWvn87hSl+nEARRkBx/T4puzWbDo9sWckbUcg=;
 b=vPEadloQtFWZDNbL4ivnVhB2Y3bKGSTyeVwv8lK6y377EopeJ5+V+pVYNc1z8HAX6xBdLMAOMI9A49rF2/bReeObqftPD0Pxlhvpw82aIQrrA8C/h9JdCGCZGsVF97tl81yYcdrFB6kp4GGGiJHf/C6MxaXWz49yLCvzOO0O33aFHeb0KXNDVUlKTvjJzS1J1QbZYo05g6ATZvlh9CFBX3nTqLK0GryC+VqmJbPAjHobt7Q8EW+y6coomYn4JnrlAqwmh/gHnaViKnAbwM8Yb4ruIKSdcTeqNnb8Pmv6ol+ljO/BEyuWEx5yZoR1ttMbN78x4r3bVh1NQ29Txldh+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1ENskJWvn87hSl+nEARRkBx/T4puzWbDo9sWckbUcg=;
 b=dMVEkod4YhJBL1P72L00IAFeXmSPf79nS5kytfq5P4CeaGHyrbcwggUUhg0PIEVCM26CFCqoE8vmvF6Z+ezYJEH6L4R14+nSluy84EARBkjDbqB6/fbBygjjwWw9Xz3gulPOX+AXRF4+1XEqVMCeoVeTZX/ITGeZ3Vcrn23/IhM=
Received: from CY5PR15CA0036.namprd15.prod.outlook.com (2603:10b6:930:1b::21)
 by BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 17:04:46 +0000
Received: from CO1PEPF00012E5F.namprd05.prod.outlook.com
 (2603:10b6:930:1b:cafe::af) by CY5PR15CA0036.outlook.office365.com
 (2603:10b6:930:1b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 28 Oct 2026 17:04:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E5F.mail.protection.outlook.com (10.167.249.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 17:04:45 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Wed, 28 Oct 2026 12:04:44 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Shaoyun.Liu@amd.com>, Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: wire mes_dbgext on mes12.1
Date: Wed, 28 Oct 2026 13:04:33 -0400
Message-ID: <20261028170433.462855-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E5F:EE_|BY5PR12MB4115:EE_
X-MS-Office365-Filtering-Correlation-Id: da9ca9b5-46e8-4635-354b-08df35159124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|260925022911599003|260925021311599003|260925021911599003|11063799006|56012099006|261009223027099003|261022075727099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003|10067099003|18002099003|3023799007|261028144727099003;
X-Microsoft-Antispam-Message-Info: tUUJ1Iru8Baq1dPZuQpqBREgl2MP8U2C21GNgvElxgcxPNhYg0DsRqmhT2gSYGT95M4IK7JXIUKhQQqhFeB9qAGw4okUm/8/n2RozRGjspbpHN4uHzRYetGT8KFmJlNDCyvuGuLTJVAs50VMsb3DQqXeOmTyCMYoPxVopLSzcciJbyT/WJ2/Dr0ytmpyItrn0L9SR1oo3wzk1VCW1ORuvokAgZhScd0s2DJzcMKT3yaBqO4l5zdw0II3bun/+EeFoP/wIpOYTFHeJmIiueyVlidTT/Nqf0XZ9hfKnotQNRGvUcj7/WAelCODQ9TcFa1qAlBYE3MiPKmxCmW0AzBGaErlEPPqRZ8bVk8cTPxWHCxjSVHrWy8dntVekRbLqKUNegcEL8uVXU+TQBWJVHsn1w6SnWTa+R1b0TN+OQumJ/aGyhk7Tmv38BLy7Bq5miEnRjfa+4s/G1oU0og/gv8WsCUsCPWcg0Q+A3xHaYtX89wldHwpve4/q47hxfGzup7nj7qOHnaBePXdYCkzXsbI+l+5xpdHdhMWGBnNoMadaO9wCIAQBcAYArp8BUOPGtykgu+HDsG0LAk2lsOLV6PguStke0bJB3MqRFWNz82CVSZHaPJGdeOMY0P8bbkQNKPzaSjPNxrHp/YRlIeFq76R11kFvDZRfQ7jF3A6p+9i2IvNjJNSU9u6bAR7JXlTAZ363ewFVwRabTOmpZAPRhabJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(260925022911599003)(260925021311599003)(260925021911599003)(11063799006)(56012099006)(261009223027099003)(261022075727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003)(10067099003)(18002099003)(3023799007)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BPDM80vPfWUcdOubfOL8MFZDiQdxRkzAsKr5NoWpr6aJPN+OrnLYLuU56eDakpLQy8CPkbF/0/iAakvIPWjEwAwiFqkFk5ZqMIi1jN+S0qy1Tl8u+OWj40i0ej5KK6nZ8UeZRJOvc1BkQdl3nPJCnkDg/Nd0yW6jOe8brlbrea7Ql4VVukC2sG64A0+7CcmzJM4PiEAtSg8Z16Q+3urK3Rjuv2AFGqU+UoOC+Qm0n0nulzzma/fbmWxlgWmUuAMcd/QQflt274llsvl4xe/mzD9Ek2ek5RItkxsh6zNuDiZUePgvWp0ipZ1qyb8Ww3vh+qDGvihkFoKtSebKTX5cohiAEqFBvQdNavugp1QflOBBzfQkHfyYAxy7r3SB/X2+A/pFIT9+INS1xjxPVHcPZB9wDcJEh1HPU+Vd/Zg7UwYvxTuUMuJzXDWn80D6I7Iw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 17:04:45.4207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da9ca9b5-46e8-4635-354b-08df35159124
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4115
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
index 1589fc6413af5..4449691744a96 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -3515,6 +3515,25 @@ static int gfx_v12_1_eop_irq(struct amdgpu_device *adev,
 
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
index 5573fe981a220..5e4f929ba6b5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -42,6 +42,7 @@ static int mes_v12_1_hw_fini(struct amdgpu_ip_block *ip_block);
 static int mes_v12_1_kiq_hw_init(struct amdgpu_device *adev, uint32_t xcc_id);
 static int mes_v12_1_kiq_hw_fini(struct amdgpu_device *adev, uint32_t xcc_id);
 static int mes_v12_1_setup_coop_mode(struct amdgpu_device *adev, int xcc_id);
+static int mes_v12_1_enable_dbgext_irq(struct amdgpu_mes *mes, bool enable);
 
 #define MES_EOP_SIZE   2048
 #define MES12_HUNG_DB_OFFSET_ARRAY_SIZE 8 /* [0:3] = db offset [4:7] hqd info */
@@ -639,6 +640,13 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
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
@@ -962,6 +970,52 @@ static int mes_v12_1_inv_tlbs_pasid(struct amdgpu_mes *mes,
 
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
@@ -973,6 +1027,7 @@ static const struct amdgpu_mes_funcs mes_v12_1_funcs = {
 	.reset_hw_queue = mes_v12_1_reset_hw_queue,
 	.detect_and_reset_hung_queues = mes_v12_1_detect_and_reset_hung_queues,
 	.invalidate_tlbs_pasid = mes_v12_1_inv_tlbs_pasid,
+	.enable_dbgext_irq = mes_v12_1_enable_dbgext_irq,
 };
 
 static int mes_v12_1_allocate_ucode_buffer(struct amdgpu_device *adev,
@@ -1532,6 +1587,15 @@ static int mes_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
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
 
@@ -1826,11 +1890,15 @@ static int mes_v12_1_hw_init(struct amdgpu_ip_block *ip_block)
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

