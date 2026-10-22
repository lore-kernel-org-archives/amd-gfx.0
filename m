Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83035606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 08:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zcIjNsFg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F19B51123B3;
	Thu, 22 Oct 2026 08:20:35 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D59E1123B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:20:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j9Kjz8r3KAHuX6i2/nZQ7SQ0IWlF7O9p5Ac6ax60KUXNazrJeIRqAcii6zk0JJqJle8WlxZMMdL0A9w+xC7VkSoyDrcmGDVz0/5fZAkrg5L5POI261HuhteWGo37ttuaf3/sXLPoTF0ik6UsdZfId9wbnMydlpbEXXfJxJ2uOa3JIqtqoc0wSC5QFwK7ZFsCfQIPJEN7YbwZ0oAmaqBM2XyvSID0jPMXREvf8bGJQssWqSX9J55bjMKwJMG8t6c9kEf0rqxfHCX8W/qrgujCn8l6cgD5HP6u9+7l/1M1xbtbAO7Rp97PHyoLb/tj0Sy4kyNdG/6MtHtaVJWMfkMclA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTETYbcjXVcSh4cTQii5yH7c3Q1zXy3jN0ppJxdC/K0=;
 b=iN54nTUrXo3cHBUjubmO8CV+DZAv7aRF5xSrEbiDvQjzvDhSa8T8KXsBG4zJGr/jOwtSBVHz/llg0caHmoWXUEPlk558ob0zY9FLsTraESVD9VAERvtVMblOSWiLiBS5nW4x7RXuL5uO6hCQ/0GEzGn7K2nJwXV5jqA7pDqRhOlGwCPTBfx/ZOIdNSMRrPoLjbXZ4q+QTGN3waihfjI9EtSSzDaMTbdexvTNdqrVDGdNYgtj8N06JTq9ttukxtPuLHRkpI1KuP/TRngNggya/JlbMwnhBx1CcaGulcjJwXv3g2AnbuojIyLRU+aIXnoucPEeG4b3l4ZuOFxLLVZ90Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTETYbcjXVcSh4cTQii5yH7c3Q1zXy3jN0ppJxdC/K0=;
 b=zcIjNsFgEnYulH2qr/+WLSbp+Ho/eBESAmqH0wBctTOwtSARX/sfpQ8yFbXLmJZuNRQTem2I51SvbxJQEvrknrTS+SRQW2HP5z6FshRmrNaOQtkfqonX35NWyRpA8xRCUHkE4cT40OX+JxPEM9zS1kq4BhAbAwzT8hm5J3lBRBo=
Received: from CH2PR08CA0015.namprd08.prod.outlook.com (2603:10b6:610:5a::25)
 by CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 08:20:24 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::17) by CH2PR08CA0015.outlook.office365.com
 (2603:10b6:610:5a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 08:20:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:20:24 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:20:23 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 22 Oct 2026 03:20:21 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <Mario.Novales@amd.com>, <Manu.Rastogi@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 03/15] drm/amdgpu/gfx11: add a gfx engine reset
Date: Thu, 22 Oct 2026 16:19:43 +0800
Message-ID: <20261022082011.331462-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261022082011.331462-1-Jesse.Zhang@amd.com>
References: <20261022082011.331462-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|CH2PR12MB4071:EE_
X-MS-Office365-Filtering-Correlation-Id: ed5f4dfa-6821-40f0-ecc5-08df3015522a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|6133799003|10067099003|18002099003|22082099003|261021121427099003|261021123027099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: ST4H9e+72s9noAATBKXwoFCkf/e0/toRdhfK6uYvSdGIWqfK6j/nXVGSJJoGn1kH+q74UvRWQddkEojWbhnhgm1HqZbng/JNAP4CZK67ZuX4zi4PvUGieLcZG2TsNuBQleNyv4Dk8r48VBVCzOZScIV22r9AfrzYedt2nXdzxsn6SApjKC79TMQJnWyQ5fRq19H9kelJ5ekZUV7wwxguiJC7034XqvjkZPNquULyL3XH3R/4rvO3mIuQ9sQzVXec8eP3U41TJxUfy5V/cAXTedangWCco3M5AqzOenZqFgDaDOO0OxO56MZo/AviAVdKgpUB0LVp5FeidwgcuHVjoLEupGc4JfnQ0UuIODpiJHZ9QSWrsWeHGILev+nzJXm/PQXOYQEsGAFUU+s3d4vyWwlxLvmM3jNSdjA3CQCwfgMl/c9VayeL658PTfIRAlb9srU6C6IgL0cesnOB+rgdTzn0YJS5Y8NJsiDV0Qepf+sR90KFJUZ6qLoxnQtRusLisv4rp8bduIjf9MmaFuyYq2lJWLZepBumb45VfbFVEZM2iDGC6mojiqoVMn67kaHyjLVxeAyFwhPIVeX5YmC5NQQnSzk7tfwfGbRMaT2q/eITYfaF1bbGhrSa1iUY66U4ApWXE5jTE1TRzRTUrWCKOrWwcBQx0nBV4RFgT5OEiULrfbbkBZC2qnmVIIUXZ2lU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(261021121427099003)(261021123027099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tJevh/0zgbRgiuNR8ganp30StR1Wo25gppnxc6K+qPr9c003VaFfkp2SW3t2sGwTOF4R17nhwIL7nNESnhOFOfvKLs5CQWxs0LcxYm65LkCb/0np7tvt4KC5z5euvcixBU4bZ2JH2BXZDm4jIHXM5+FQim/0lKx/FhydlgV7FQSK4Fvuas3Rex48ra3n3PMGd1LH7Ky3sCNK7ow+gcTqdYAKFaWN7jhRGjDW+kCMB7aqAUkb3fgK69GNUgbqjqj7aR/w/hiMcU0vYfoWQgzdZTXdvrtCIBhaMqwuUA0Oto/DdaRDwbaYZE6GaaB7HEvfKH9n32suD7+q1f218aCI9Q0C56kwnAGBFTbQsfI6AyRwOiteZWFeZud/E/5/MnRDHE+skQ9ZCtlcm701gsdMcmNv+LnGm5kK8pYW+K+XXtxVwUy0loYpNxrBxSzLqCJo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:20:24.0460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5f4dfa-6821-40f0-ecc5-08df3015522a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071
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

Implement the reset_engine callback for the graphics engine of gfx11, as
for gfx12:
- halt PFP/ME and wait for the memory requests of the CP DMA to complete;
- with CP_SOFT_RESET_CNTL.GFX_ONLY_SOFT_RESET and GFX_HQD_REG_RESET set,
  pulse GRBM_SOFT_RESET.SOFT_RESET_CPF/CPG, holding the MES lock, and
  wait for the memory requests again;
- clear CP_VMID_RESET;
- restart PFP/ME from the start of their RS64 firmware and restore
  CP_PFP_IB_CONTROL; if the CP doesn't go idle then, fail the reset so
  that a full reset follows;
- remap the kernel gfx queue through MES from its MQD backup and restart
  it with gfx_v11_0_cp_gfx_start().

MES resets a gfx queue by writing CP_VMID_RESET, which the PFP handles.
When the PFP hung, eg. on a bad opcode, the request stays pending across
the CPF/CPG reset, and the restarted PFP then waits on it forever for
queues the reset already cleared.

gfx11 has no helper to restart PFP/ME from their start addresses outside
of the firmware load: add one. A later patch enables the reset with
MES, async gfx rings and the RS64 firmware.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 176 +++++++++++++++++++++++++
 1 file changed, 176 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 315dfd806d56..12b307e4106b 100644
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
@@ -6916,6 +6919,179 @@ static void gfx_v11_0_emit_mem_sync(struct amdgpu_ring *ring)
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
+ * Soft reset the gfx CP and restart PFP and ME. Returns 0, or -ETIMEDOUT if the
+ * CP doesn't go idle after PFP and ME are restarted.
+ */
+static int gfx_v11_0_soft_reset_gfx_cp(struct amdgpu_device *adev)
+{
+	u32 tmp, cntl, me_cntl, ib_control;
+	int i;
+
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+
+	/* MES fetches its queues through CPF: keep it out of the reset. */
+	amdgpu_mes_lock(&adev->mes);
+
+	me_cntl = RREG32_SOC15(GC, 0, regCP_ME_CNTL);
+	/* Cleared by the reset. */
+	ib_control = RREG32_SOC15(GC, 0, regCP_PFP_IB_CONTROL);
+
+	tmp = REG_SET_FIELD(me_cntl, CP_ME_CNTL, ME_HALT, 1);
+	tmp = REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, 1);
+	WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
+	udelay(50);
+
+	/* A CP DMA in flight during the reset leaves the ME busy after it. */
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
+	/* A CPF reset alone leaves the streaming engine stuck. */
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
+	/* Not the whole CP: the halted PFP stays busy until restarted. */
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!(RREG32_SOC15(GC, 0, regCP_STAT) & GFX11_CP_STAT_MEM_BUSY))
+			break;
+		udelay(1);
+	}
+
+	/* A CP_VMID_RESET the hung PFP never handled survives the reset. */
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
+	r = gfx_v11_0_soft_reset_gfx_cp(adev);
+	if (r) {
+		dev_err(adev->dev, "gfx CP still busy after reset, CP_STAT 0x%08x\n",
+			RREG32_SOC15(GC, 0, regCP_STAT));
+		goto exit;
+	}
+
+	/* Map the kernel gfx queue again: the reset cleared its HQD. */
+	r = amdgpu_gfx_disable_kgq(adev, 0);
+	if (r)
+		goto exit;
+
+	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
+		amdgpu_gfx_mqd_reset_restore(&adev->gfx.gfx_ring[i]);
+	r = amdgpu_gfx_enable_kgq(adev, 0);
+	if (r)
+		goto exit;
+
+	r = gfx_v11_0_cp_gfx_start(adev);
+
+exit:
+	amdgpu_gfx_off_ctrl(adev, true);
+	return r;
+}
+
 static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 			       unsigned int vmid,
 			       struct amdgpu_fence *timedout_fence)
-- 
2.50.1

