Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8CAC5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4D0A10F32F;
	Fri, 21 Aug 2026 16:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="erZIGhyY";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010025.outbound.protection.outlook.com [52.101.85.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEE8C10F334
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:03:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyw0+0EBMeUAUhxk3Gu15vxhPLRiuyl6L91fqJLW1o/Ep2eTJreOAHBDR/+l9hMKjU3/Ifhi6vhpdy92acYRdqYXa6kGa/m4+HdwjkNXobIXJPFPv4NR4y9gSqDaG9MtfAhcoT/2BY93bUVQVAiLbPS9rwGgyI3pe1KMLEIgHbjOli71w0Yhu0xxN2ERSRn0UCk4/C2NG/5R1Q8AwdB1sLz098EJr4qwdXsCj8BRfcY6FWot1YeiCklK9CrEGphpIwzzGMa4L1+gZyehoj6kH9utMWs9qsZWUIz3F8YeyOy2Zk4P1kLL7+6t5LYmTKzp5xQYj9k+bJK6rs3EUrfp4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5QsdGq6e1K6NKhhzDTqgGkGJ3wqr536A4587BHnsrw=;
 b=b4c5bjTlKycj10mE8/m1TaD81KcVlNQB8ALZLpzlwY42IEyRkfARNGSF9iSL4vzH+BOtuLbaOY5VYXx3aPRh/6znzRXDwnZDhbTkCsFMJjknhAZphiYziJ53uRxMKy8lVDbHsi8GrRhnil7nskzoapCCj8q2sPnM9d1R2kzyajXyfaJlxBzuu5WZCmID1xo1y67wMgWf/q4iEI526NLLSldgVB0fGKiUaDGny434Pfy6k4zfXZF6QLLSgvcRUm6GTxOvSO1xzVdQXtpkCDp277KJB1Y+pLBU1UhI2WW79rMpKCG5P8qW15C+otdt39wXqKLuQZ8yRvPB0p+r2p5QjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5QsdGq6e1K6NKhhzDTqgGkGJ3wqr536A4587BHnsrw=;
 b=erZIGhyYgD+ybeJ8/gLaSQ7ABgRKu7Lo9110RgUVLE9V+e6F5X+oXaCq3ytqsepDYY0f1lyZU8v37403U4RQx4ZnHLUE/Dk5UdhiWmqCnGLrjkNo0IIQ9hoDz7PD9hu7BTSLeF3CRqz0e/bW+gFeUv00xqNfJx8f4H8/DSZAfJ0=
Received: from SJ2P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:5db::16)
 by SA1PR12MB6993.namprd12.prod.outlook.com (2603:10b6:806:24c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 21 Aug
 2026 16:03:19 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:5db:cafe::63) by SJ2P221CA0012.outlook.office365.com
 (2603:10b6:a03:5db::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:03:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:03:17 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:03:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Bokun Zhang <Bokun.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Add JPEG v5.0.2 SRIOV code path
Date: Fri, 21 Aug 2026 12:03:03 -0400
Message-ID: <20260821160303.751422-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160303.751422-1-alexander.deucher@amd.com>
References: <20260821160303.751422-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|SA1PR12MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: 9384e36e-be6a-4a8b-2602-08deff9db744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|22082099003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 9NMSGQz7v1Sw0GGt4OY8tNkYxlHI+41t5npgqYtyJB6F808zRZDNgI0nC0gBiW/u/TFRCFbVBZ6NMFUBlLOc6zktUfWoznkZZezZ1Eiwykp7Jgx03VAfiZEJFZMGiQTFfuOavLbnUJv6VdWYoFWK3t0kEds+q+5aAkgUR1EYApSUa4LLHeIzNoiETguS1C+Qz8dZeKojtE7QcbOiYU5PMVIVVZ/2XptPwDzAWE/rAAYcjTWtbnysyU+R3S6i912DmtwT8DG2PlgErPXJO0hM+jCNIZvnYX/Oiu3AAMhwWj7GWdx+73VbB2sdN4OXLU20ieNhYGagu4CwW+GuJLgec1qJEjB7zclgcfDFemgQsrycxm5wJBidU8IyZPdtST5kYXrX0cE7mk/F2wng6daGT44GZPsgigdhkDV9RO1YD0pIvfCRde0Q483wN8SmoL0/dy+cr4CM53SPvOrdqyf5X9PHNWou5jqoZZfrAOVHeI7S35cWmi92z0uFsNBz7cjsqPE9TkAQk1tLCxsEiUx/KmQrJdZcC0ub2ncgelKSeToWbuhoiF+hvAwbqK5LmcWM+2jnCzM2G5XO+JFxWc2typpoktOcGphTB/86o8utxJT1TlrhMkS5VDFem67lnHIA4FPjFpwzM7RH2S/qGNmkfELNgoYepELnC4xzE1/gfVeqRrDIPSKGFln5AJ7B2uG1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DexVzxA6J60tXFRCUCIRv7pKKujuel5R+eA/JB/HxjNyNiF5v/oS+UfWA354Uymmtsx5EmdvNSQzmvLQyrMYL+F1LbfORMEGf8fSaHk2X1aLa6Tb5VHk1VOH6/q/4OzAZeKxwLl6HvwB9KDGJuUMTkI6ureGubV6M9MFE9tfQCy6bkw4HyAtwu2zv8eEkssuzLfoSxV9s4TIlwgbGcYUa8XDKjOJGr/hxyXhpez3GCjA4e10T5nF0qr5nUC2HuBgRQe6rD3STQ9S1GZBA3mgkRpcLk6mF5rg5s4rYF1+RGsTETLbpLOQ6F5e/t20ZMSKthj0aimPwur8EbR0c7Y7BjUc4Y3/FbJCbWFmBm8aI/WrkvmRDTlMBC38AmZZJMgS1uU/j8dLphnrKBSVvq97xBmCnpMk44bqJnXqoFqyXxRbW1ZDi9uCvyjm12QHQ9R+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:03:18.1839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9384e36e-be6a-4a8b-2602-08deff9db744
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6993
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

From: Bokun Zhang <Bokun.Zhang@amd.com>

- Add JPEG v5.0.2 SRIOV code path
- Add JPEG MMSCH init table transfer
- Skip unsupported actions such as power gating
  and per queue reset for SRIOV VF.

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c | 156 ++++++++++++++++++++++-
 1 file changed, 152 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
index e79ffec251d75..dd0abce73687c 100644
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
2.55.0

