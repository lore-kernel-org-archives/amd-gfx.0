Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6E4C5516E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 20:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C3F010F079;
	Thu, 30 Jul 2026 20:27:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B2XIwWq+";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 713EB10F07A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 20:27:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfyujaO3YnbmFt+2lQWwK/UG4r+nnpzSpTdWl+oh/JEPUy11mzlJsVO00upb5DHGUU41bbS/oc97p7fqpiKfAmL+6tPHD+d4vpgIjXwyvgF+h4fGHsQpI00o36YhcRgNQ9xrZMVQ16o1CnVpXDifZOFRGhwjULhJdOBB/cOjjMB3JABQaleHRxn0YkmITOhvIm8EqSqmgfplkmqgGFSuzM5wN2AD+PcjkA6rtDozKMVUlyJGI4Ece9KM6pUvd1q47iEvTuQW/Df1dIgidQXlNDdWtrxMn1eGS2il95My5uvSM3tvuoy1c6/2IdMc0Cy5b/4n3oHpmrdQY1UsiucDUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KW7D2gDpXzEWhdGkkjVkpN6g689m/+puhO2r4LUhjgk=;
 b=C8ref7Ic0EtwpooYOqfelnwBtxJj5f4i4IXBbV8Am9z8GCSUtixKhVn9zwUDKhphXuZQ8CIWbN26lRaD0FAEKW31nSXpOcCZYBQRvWJMAq7fLL3cQWQ96beL3aEkWwKz2ndfNvstIyq0LBQTCYSsmLiA9AbVXI7sXo2v2qTTHsAg9MZqTMvOohwrqCBoAqso1XdeYnvycvgTJsMwkjHG71hR5SwuLch5aZpKkYiyXmrZ83DsVInWBKcIxRXl353hXcTr9v+APzxIPRZ0HkqBikZ33sJ5n7l1Q0zhd1Rxu76dp6gLhqP/oPp6vPDUlr64p30S/TNjtLrRwpxzLSrs8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KW7D2gDpXzEWhdGkkjVkpN6g689m/+puhO2r4LUhjgk=;
 b=B2XIwWq+EQhFJ1pkWsLtdLAWFApLcoeBPwRV1m2RFr2LlgczjNmmkDQFQ4DqgO6qp3PLR1Fw8tWC4o6pjIih3PG5Td9z7NSTdadK6eJgwX/uFo8FsEpdDAVHOyl/MJKkORkPzoo84lrgORAlbjRuJBf4m3f+L0Pz+WsYrsEdLFg=
Received: from SJ0PR13CA0195.namprd13.prod.outlook.com (2603:10b6:a03:2c3::20)
 by PH7PR12MB8054.namprd12.prod.outlook.com (2603:10b6:510:27f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 20:27:42 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::15) by SJ0PR13CA0195.outlook.office365.com
 (2603:10b6:a03:2c3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8 via Frontend Transport; Thu, 30
 Jul 2026 20:27:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 20:27:41 +0000
Received: from bokun-linux (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 15:27:41 -0500
From: Bokun Zhang <Bokun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Bokun Zhang <Bokun.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add JPEG v5.0.2 SRIOV code path
Date: Thu, 30 Jul 2026 20:27:31 +0000
Message-ID: <20260730202731.265870-1-Bokun.Zhang@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|PH7PR12MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab98aed-cc6e-4553-394f-08deee7901ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|56012099006|10067099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: zaK494ycObf1BoMne+VVAGg0Yy7UVuNhgkxrbal8jnFhlLNKVX1eDZLzrhxBPyZfC0XLW7l4uLPl3zG6/YbkrRWl/Ntdj072XdqO901ojo+XZebzZwseVlZEZ7t5lM2NPf/1G2wXI+Ax4QXejmFNZ7Rpp6/xCDYKori11sK/nNjJElicAJCikJ4Wvum4XQgREDkoE3qoYiCFgoz/VM0fs7UM3aT9LRvfQE76eLFR4rbTjU+QVxb6oJy1vKvpesJjLD+mXGzckJBsEDyX+exbme74Ahmd3xhhEdgQkHh/qPirsnYPvr1JJWXst0B73CCy4NNK9VrtqFonrzkebuvupX6xR2Apm12vXA6/v+BoQUtrJSVDjKlwGeuyBLOaSoNK2xx0pdOpO/F09vSYSPdcb3Bo88uEwhuZIxJSbB7BaRtho2N9QCdEMwLH8nBGjIC50EvYexghdMSw+zNRSqhoC6IBMzDi1lko6cOKLp5XYJggJtF8y7yedubndIwfI6c6pahSYsSAVAkGi5oouKp2buk9509xtoqSXDJ10+FBfGigi8eKHjHP4ty0lG6rqC4Yi+907yDhkvt/Qf3MjjMxEFol9vJIiOhu1p1Nuqe8lXZKgBIxU4kTSCc55NoYJXNT9DlZEUYvI8zy4upHR9xnisWtfSsqWFYYd4yxbjqhpCPwpjuhRD1l6sORn/3sXVL1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(56012099006)(10067099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 519fdAMs3HVAzv4j6Z3edQd1Vag6gYXSnJ1LAYVlDVcOvYGywNcR55uEmnFDdsJte6Hi0aqsUrAuhGRfmk9V1i0SiEQ7mvpZrURFTw5mCmjm9K4tCYX3hTEisggopp9TlZYi55Wpwzd7rIh+l/YKQf1OTPpIlT+MySCQ1jCAH3cIFbUVhLOy9+UVH2L7NW2kVAbLw8izN2w0JWH2emzwpqzZ/863k1zaPgkhq/FYDjOkAhpRCEEVedXMqw3NeAyhXcY0vV4B0PbFqArXiI/Z5iSLaO9l6dmaYmhr+6hE64EGHkw0Ww+zHKaQrRv04gOqW7y0CnrUeFdQ5tzJfPNn/rJI0LjU76cjOom/53f0oJcXQnC1bYcHn1S+6poWWrzaRmlPbL85Il4PaHVl2iTaKzu03mlH76NpxaARELoOIAe8mrgmMTcD3FOjnpPwvSvD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 20:27:41.8440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab98aed-cc6e-4553-394f-08deee7901ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8054
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

- Add JPEG v5.0.2 SRIOV code path
- Add JPEG MMSCH init table transfer
- Skip unsupported actions such as power gating
  and per queue reset for SRIOV VF.

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c | 156 ++++++++++++++++++++++-
 1 file changed, 152 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
index 1c7f13e1cd75..e9df11a5dd26 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
@@ -34,6 +34,7 @@
 #include "vcn/vcn_5_0_0_sh_mask.h"
 #include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
 
+static int jpeg_v5_0_2_start_sriov(struct amdgpu_device *adev);
 static void jpeg_v5_0_2_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v5_0_2_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v5_0_2_set_powergating_state(struct amdgpu_ip_block *ip_block,
@@ -164,9 +165,15 @@ static int jpeg_v5_0_2_sw_init(struct amdgpu_ip_block *ip_block)
 			ring = &adev->jpeg.inst[i].ring_dec[j];
 			ring->use_doorbell = true;
 			ring->vm_hub = AMDGPU_MMHUB0(adev->jpeg.inst[i].aid_id);
-			ring->doorbell_index =
-				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-				1 + j + 11 * jpeg_inst;
+			if (amdgpu_sriov_vf(adev)) {
+				ring->doorbell_index =
+					(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+					2 + j + 32 * jpeg_inst;
+			} else {
+				ring->doorbell_index =
+					(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+					1 + j + 11 * jpeg_inst;
+			}
 			sprintf(ring->name, "jpeg_dec_%d.%d", i, j);
 			r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
 					     AMDGPU_RING_PRIO_DEFAULT, NULL);
@@ -187,7 +194,8 @@ static int jpeg_v5_0_2_sw_init(struct amdgpu_ip_block *ip_block)
 
 	adev->jpeg.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
-	adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+	if (!amdgpu_sriov_vf(adev))
+		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
 
 	return r;
@@ -228,6 +236,23 @@ static int jpeg_v5_0_2_hw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_ring *ring;
 	int i, j, r, jpeg_inst, tmp;
 
+	if (amdgpu_sriov_vf(adev)) {
+		r = jpeg_v5_0_2_start_sriov(adev);
+		if (r)
+			return r;
+
+		for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+			for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+				ring = &adev->jpeg.inst[i].ring_dec[j];
+				ring->wptr = 0;
+				ring->wptr_old = 0;
+				jpeg_v5_0_2_dec_ring_set_wptr(ring);
+				ring->sched.ready = true;
+			}
+		}
+		return 0;
+	}
+
 	if (RREG32_SOC15(VCN, GET_INST(VCN, 0), regVCN_RRMT_CNTL) & 0x100)
 		adev->jpeg.caps |= AMDGPU_JPEG_CAPS(RRMT_ENABLED);
 
@@ -276,8 +301,10 @@ static int jpeg_v5_0_2_hw_fini(struct amdgpu_ip_block *ip_block)
 
 	cancel_delayed_work_sync(&adev->jpeg.idle_work);
 
+	if (!amdgpu_sriov_vf(adev)) {
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
 			ret = jpeg_v5_0_2_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+	}
 
 	return ret;
 }
@@ -407,6 +434,122 @@ static void jpeg_v5_0_2_init_jrbc(struct amdgpu_ring *ring)
 					 reg_offset);
 }
 
+/**
+ * jpeg_v5_0_2_start_sriov - start JPEG block under SRIOV env
+ */
+static int jpeg_v5_0_2_start_sriov(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *ring;
+	uint64_t ctx_addr;
+	uint32_t param, resp, expected;
+	uint32_t tmp, timeout;
+
+	struct amdgpu_mm_table *table = &adev->virt.mm_table;
+	uint32_t *table_loc;
+	uint32_t table_size;
+	uint32_t size, size_dw, item_offset;
+	uint32_t init_status;
+	int i, j, jpeg_inst;
+
+	struct mmsch_v5_0_cmd_direct_write
+		direct_wt = { {0} };
+	struct mmsch_v5_0_cmd_end end = { {0} };
+	struct mmsch_v5_0_init_header header;
+
+	direct_wt.cmd_header.command_type =
+		MMSCH_COMMAND__DIRECT_REG_WRITE;
+	end.cmd_header.command_type =
+		MMSCH_COMMAND__END;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
+		jpeg_inst = GET_INST(JPEG, i);
+
+		memset(&header, 0, sizeof(struct mmsch_v5_0_init_header));
+		header.version = MMSCH_VERSION;
+		header.total_size = sizeof(struct mmsch_v5_0_init_header) >> 2;
+
+		table_loc = (uint32_t *)table->cpu_addr;
+		table_loc += header.total_size;
+
+		item_offset = header.total_size;
+
+		for (j = 0; j < adev->jpeg.num_jpeg_rings; j++) {
+			ring = &adev->jpeg.inst[i].ring_dec[j];
+			table_size = 0;
+
+			tmp = SOC15_REG_OFFSET(JPEG, 0, regUVD_LMI_JRBC_RB_64BIT_BAR_LOW);
+			MMSCH_V5_0_INSERT_DIRECT_WT(tmp, lower_32_bits(ring->gpu_addr));
+			tmp = SOC15_REG_OFFSET(JPEG, 0, regUVD_LMI_JRBC_RB_64BIT_BAR_HIGH);
+			MMSCH_V5_0_INSERT_DIRECT_WT(tmp, upper_32_bits(ring->gpu_addr));
+			tmp = SOC15_REG_OFFSET(JPEG, 0, regUVD_JRBC_RB_SIZE);
+			MMSCH_V5_0_INSERT_DIRECT_WT(tmp, ring->ring_size / 4);
+
+			if (j < 5) {
+				header.mjpegdec0[j].table_offset = item_offset;
+				header.mjpegdec0[j].init_status = 0;
+				header.mjpegdec0[j].table_size = table_size;
+			} else {
+				header.mjpegdec1[j - 5].table_offset = item_offset;
+				header.mjpegdec1[j - 5].init_status = 0;
+				header.mjpegdec1[j - 5].table_size = table_size;
+			}
+			header.total_size += table_size;
+			item_offset += table_size;
+		}
+
+		MMSCH_V5_0_INSERT_END();
+
+		/* send init table to MMSCH */
+		size = sizeof(struct mmsch_v5_0_init_header);
+		table_loc = (uint32_t *)table->cpu_addr;
+		memcpy((void *)table_loc, &header, size);
+
+		ctx_addr = table->gpu_addr;
+		WREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_CTX_ADDR_LO, lower_32_bits(ctx_addr));
+		WREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_CTX_ADDR_HI, upper_32_bits(ctx_addr));
+
+		tmp = RREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_VMID);
+		tmp &= ~MMSCH_VF_VMID__VF_CTX_VMID_MASK;
+		tmp |= (0 << MMSCH_VF_VMID__VF_CTX_VMID__SHIFT);
+		WREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_VMID, tmp);
+
+		size = header.total_size;
+		WREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_CTX_SIZE, size);
+
+		WREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_MAILBOX_RESP, 0);
+
+		param = 0x00000001;
+		WREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_MAILBOX_HOST, param);
+		tmp = 0;
+		timeout = amdgpu_emu_mode ? 1000000 : 1000;
+		resp = 0;
+		expected = MMSCH_VF_MAILBOX_RESP__OK;
+		init_status =
+			((struct mmsch_v5_0_init_header *)(table_loc))->mjpegdec0[i].init_status;
+		while (resp != expected) {
+			resp = RREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_MAILBOX_RESP);
+
+			if (resp != 0)
+				break;
+			udelay(10);
+			tmp = tmp + 10;
+			if (tmp >= timeout) {
+				DRM_ERROR("failed to init MMSCH. TIME-OUT after %d usec"\
+					" waiting for regMMSCH_VF_MAILBOX_RESP "\
+					"(expected=0x%08x, readback=0x%08x)\n",
+					tmp, expected, resp);
+				return -EBUSY;
+			}
+		}
+		if (resp != expected && resp != MMSCH_VF_MAILBOX_RESP__INCOMPLETE &&
+				init_status != MMSCH_VF_ENGINE_STATUS__PASS)
+			DRM_ERROR("MMSCH init status is incorrect! readback=0x%08x, header init status for jpeg: %x\n",
+					resp, init_status);
+
+	}
+	return 0;
+}
+
 /**
  * jpeg_v5_0_2_start - start JPEG block
  *
@@ -566,6 +709,11 @@ static int jpeg_v5_0_2_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret;
 
+	if (amdgpu_sriov_vf(adev)) {
+		adev->jpeg.cur_state = AMD_PG_STATE_UNGATE;
+		return 0;
+	}
+
 	if (state == adev->jpeg.cur_state)
 		return 0;
 
-- 
2.51.0

