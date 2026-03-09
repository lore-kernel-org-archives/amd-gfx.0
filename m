Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C89F417E0
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C79E010E508;
	Mon,  9 Mar 2026 14:26:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BasEPGjZ";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BC0410E4FA
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 14:26:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzgYCbevUzmYc5zCA1FsktHgc9XVwxxqhdnuTdHImb3PhblJoT3iwGXwHG7rc77OG/rCc/d/TeftnvPKImYZoRBs4nse1oXzY4Tw/HhmNkDuPWvoqxv6D50MXebFSahR0Q3R8L+S6RtsiP8ESvgPGsz6an7GRb3jZgscAqHZ5LvpBelE1egagsK/rQL1yIoagVv3aU8dzeef8SGOLJuEUYHLTHsL9pYEzSoMcPLqmET+2yMKrXV9pTIXOgZHyKns+yUKy7vkKXhxF6IwATjS+6roS5Vnk5bFEHcqVztD2Pz4Pre/zRbXC+ixCFsmmC9g7IJYzLKqPKy9zWqto7YpSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pMSEEFDiP9dX3oolCyNVDbpmebECrgRjC2rcbkqUsc=;
 b=jz5T13UK7Mvlxe28BnVYrFms8+wX22FYpLzmNwEQtKzgE3o9r2+z8YSmQKEEUY+ZyHAbI3Mh7X3HEjFLSdlfIIealt4f2bY2wTRrjEpx7ATWL6bkJZ5WhY5Y1IhKA9JMlFcWq/7U3MDTdoav0M32X3Xp/ZfO/YHAXxdGUGrmZX3XA1DCTZ7CUG6AIkTuu6zzgTH/tiGt/7YBR0+DiRfvTQ818Tkof4dTaaIkPEQCvSCoD5g9Gk7Svq4whi8/uLj2IQQdZNyO5jC50iWnAB8tXU2U6+K3cGn+rlCRxwwtdC1Zcdo32Lgjji7sqb9WmZrcU3Gvy3eIWIZiW153FFFaTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pMSEEFDiP9dX3oolCyNVDbpmebECrgRjC2rcbkqUsc=;
 b=BasEPGjZvYIw6ZzVJH66gRP4870nTvk4lTmf/0KhC57XoZWZazO2rVp00XSq12zq1supFC2Of5v3PF/S4E8oUx9bXx3KwzUvDgykIxCbFokARIJ7jWCtClCiSxHd2kktF+Uv/3Xzme8v2d4l/HLIp3KRuyPpDUkjsq3srQCZRnE=
Received: from SN1PR12CA0070.namprd12.prod.outlook.com (2603:10b6:802:20::41)
 by SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4d3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 14:26:36 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:802:20:cafe::55) by SN1PR12CA0070.outlook.office365.com
 (2603:10b6:802:20::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 14:26:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:26:34 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 09:26:34 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Mar 2026 09:26:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jack Xiao <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/mes_v12_1: add mes self test
Date: Mon, 9 Mar 2026 10:26:13 -0400
Message-ID: <20260309142621.2843831-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|SJ2PR12MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: 01bfb506-34c7-437a-dc5f-08de7de7ddd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: 4naV8Y0oj+FXBEX+nuQB6UYmt1n0/3KUCizfE2BuQLKq3J3MCElI3ob9kn6d326kXOtKVt5YvaJzE+fA0iBPoebCVBlTz2ib/lREcBEGmwND/AINZozGjTdQmDrvDn2V20PoBIUsq8DbrIrryJWD7y+VtUCZMKwWTkIG+PF+lEx1m3BZkRxUImHcDkTByvSxavgwkI5Mga8+afULVSGJXn1aNRvHTuMM+XSQF5Z13wwYTDxX5VGzGnuPbi6qxIktjerJ7B1XybH7u0JoGxFNs6DqB4GZGJXoXdLHbpR7AsHmGhQLmWgD31GbwXOvuht2AwCrDZjRJrcghuW536VgAZhZD95KmRfDrignSWivArZDnYEKdZMWMy9RqoAgr9kcHTbjJ6o87oIJg6vuSSbKWIauylcefn2Do0DWHxZUSopB8W0/gf6kIh8onnKIrQLuorFqOO2zDlhFxViCj894CpKsiTA0WV0Txdl9BqsI0eptsSRB0h2ziAllkjppfv4CDmejhk0iTvNMGyQKCe2IC6mtSiUNMj2NBImPD2JvCxaQOsFmbO+GC4XaveRNdsCwKTUsPYdgqyU+WC5oYfe6j1UZMmhGTlCa72a3ZATHDOn46s7UQZOCL+1/+kVfy4aDVLJLceanx9Il9nMDIwx5N4Iq6gY3HG0F80a1aE/RXuprUYGGnPyJX3HvmKSPcMhYn3dSrXqITIInwxiQUqlWNwXuzvXPT4wap5fbFSbsSwBo/8Th/+k5jkCWsTEXud9Y2eBu6UbCaxafV+hP6UXbXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ovrj2kxDZHndm0QCsgPox0L9gFSeC9AT1HxnRsRG/mFYCXan+TMLl/YbskWV/5HseAm5YN+nmxvk6nyjoqPbwOZ88T+CxYUaw3fkgz5aQ4JpBBVarAuuj34j+l6Wk2oKJ60JbxWHSHHibktOuNVmfIgv0RKoimZLNoXlcxsC+yXwcyKW006HSQo2dg5k4EbBp7NIM+gZLolPpo/HEKcF8qJY3+3p+CCK8hp3Mge2RAuNi1lkXvXMCxADj45dwl2aKQjfYSDWK3KnHh/zlMgzm2eMK77PJqAPHedFdIQcDPALtTPpfUmgk3clXMgUZ7lUSBWT2KriykREm58tiNvN9V/cUT3/kfMST4LC1zU0SPK6A2tg6SrKUTFvrgKHxvPqREbIj07nWuakcuHEGzoYwwtHBKpmexpn1J8QrLf22DYwuIyqd9np4bXvV8u3CoKJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:26:34.5486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01bfb506-34c7-437a-dc5f-08de7de7ddd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7799
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

From: Jack Xiao <Jack.Xiao@amd.com>

Add mes self test to ensure that mes user queue work.

V2: add pasid on amdgpu_vm_init.
V3: Squash in fix non-SPX modes (Mukul)

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 335 ++++++++++++++++++++++++-
 1 file changed, 334 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index d8e4b52bdfd50..2b3dbc3190ce6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -31,6 +31,8 @@
 #include "gc/gc_11_0_0_default.h"
 #include "v12_structs.h"
 #include "mes_v12_api_def.h"
+#include "gfx_v12_1_pkt.h"
+#include "sdma_v7_1_0_pkt_open.h"
 
 MODULE_FIRMWARE("amdgpu/gc_12_1_0_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_1_0_mes1.bin");
@@ -41,6 +43,7 @@ static int mes_v12_1_xcc_hw_init(struct amdgpu_ip_block *ip_block, int xcc_id);
 static int mes_v12_1_hw_fini(struct amdgpu_ip_block *ip_block);
 static int mes_v12_1_kiq_hw_init(struct amdgpu_device *adev, uint32_t xcc_id);
 static int mes_v12_1_kiq_hw_fini(struct amdgpu_device *adev, uint32_t xcc_id);
+static int mes_v12_1_self_test(struct amdgpu_device *adev, int xcc_id);
 
 #define MES_EOP_SIZE   2048
 
@@ -1949,10 +1952,31 @@ static int mes_v12_1_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static int mes_v12_1_late_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int xcc_id, num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+
+	/* TODO: remove it if issue fixed. */
+	if (adev->mes.enable_coop_mode)
+		return 0;
+
+	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
+		/* for COOP mode, only test master xcc. */
+		if (adev->mes.enable_coop_mode &&
+		    adev->mes.master_xcc_ids[xcc_id] != xcc_id)
+			continue;
+
+		mes_v12_1_self_test(adev, xcc_id);
+	}
+
+	return 0;
+}
+
 static const struct amd_ip_funcs mes_v12_1_ip_funcs = {
 	.name = "mes_v12_1",
 	.early_init = mes_v12_1_early_init,
-	.late_init = NULL,
+	.late_init = mes_v12_1_late_init,
 	.sw_init = mes_v12_1_sw_init,
 	.sw_fini = mes_v12_1_sw_fini,
 	.hw_init = mes_v12_1_hw_init,
@@ -1968,3 +1992,312 @@ const struct amdgpu_ip_block_version mes_v12_1_ip_block = {
 	.rev = 0,
 	.funcs = &mes_v12_1_ip_funcs,
 };
+
+static int mes_v12_1_alloc_test_buf(struct amdgpu_device *adev,
+				    struct amdgpu_bo **bo, uint64_t *addr,
+				    void **ptr, int size)
+{
+	amdgpu_bo_create_kernel(adev, size, PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
+				bo, addr, ptr);
+	if (!*bo) {
+		dev_err(adev->dev, "failed to allocate test buffer bo\n");
+		return -ENOMEM;
+	}
+	memset(*ptr, 0, size);
+	return 0;
+}
+
+static int mes_v12_1_map_test_bo(struct amdgpu_device *adev,
+				 struct amdgpu_bo *bo, struct amdgpu_vm *vm,
+				 struct amdgpu_bo_va **bo_va, u64 va, int size)
+{
+	struct amdgpu_sync sync;
+	int r;
+
+	r = amdgpu_map_static_csa(adev, vm, bo, bo_va, va, size);
+	if (r)
+		return r;
+
+	amdgpu_sync_create(&sync);
+
+	r = amdgpu_vm_bo_update(adev, *bo_va, false);
+	if (r) {
+		dev_err(adev->dev, "failed to do vm_bo_update on meta data\n");
+		goto error;
+	}
+	amdgpu_sync_fence(&sync, (*bo_va)->last_pt_update, GFP_KERNEL);
+
+	r = amdgpu_vm_update_pdes(adev, vm, false);
+	if (r) {
+		dev_err(adev->dev, "failed to update pdes on meta data\n");
+		goto error;
+	}
+	amdgpu_sync_fence(&sync, vm->last_update, GFP_KERNEL);
+	amdgpu_sync_wait(&sync, false);
+
+error:
+	amdgpu_sync_free(&sync);
+	return 0;
+}
+
+static int mes_v12_1_test_ring(struct amdgpu_device *adev, int xcc_id,
+			       u32 *queue_ptr, u64 fence_gpu_addr,
+			       void *fence_cpu_ptr, void *wptr_cpu_addr,
+			       u64 doorbell_idx, int queue_type)
+{
+	volatile uint32_t *cpu_ptr = fence_cpu_ptr;
+	int num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	int sdma_ring_align = 0x10, compute_ring_align = 0x100;
+	uint32_t tmp, xcc_offset;
+	int r = 0, i, wptr = 0;
+
+	if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
+		if (!adev->mes.enable_coop_mode) {
+			WREG32_SOC15(GC, GET_INST(GC, xcc_id),
+				     regSCRATCH_REG0, 0xCAFEDEAD);
+		} else {
+			for (i = 0; i < num_xcc; i++) {
+				if (adev->mes.master_xcc_ids[i] == xcc_id)
+					WREG32_SOC15(GC, GET_INST(GC, i),
+					       regSCRATCH_REG0, 0xCAFEDEAD);
+			}
+		}
+
+		xcc_offset = SOC15_REG_OFFSET(GC, 0, regSCRATCH_REG0);
+		queue_ptr[wptr++] = PACKET3(PACKET3_SET_UCONFIG_REG, 1);
+		queue_ptr[wptr++] = xcc_offset - PACKET3_SET_UCONFIG_REG_START;
+		queue_ptr[wptr++] = 0xDEADBEEF;
+
+		for (i = wptr; i < compute_ring_align; i++)
+			queue_ptr[wptr++] = PACKET3(PACKET3_NOP, 0x3FFF);
+
+	}  else if (queue_type == AMDGPU_RING_TYPE_SDMA) {
+		*cpu_ptr = 0xCAFEDEAD;
+
+		queue_ptr[wptr++] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
+			SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
+		queue_ptr[wptr++] = lower_32_bits(fence_gpu_addr);
+		queue_ptr[wptr++] = upper_32_bits(fence_gpu_addr);
+		queue_ptr[wptr++] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
+		queue_ptr[wptr++] = 0xDEADBEEF;
+
+		for (i = wptr; i < sdma_ring_align; i++)
+			queue_ptr[wptr++] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+
+		wptr <<= 2;
+	}
+
+	atomic64_set((atomic64_t *)wptr_cpu_addr, wptr);
+	WDOORBELL64(doorbell_idx, wptr);
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (queue_type == AMDGPU_RING_TYPE_SDMA) {
+			tmp = le32_to_cpu(*cpu_ptr);
+		} else {
+			if (!adev->mes.enable_coop_mode) {
+				tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id),
+						   regSCRATCH_REG0);
+			} else {
+				for (i = 0; i < num_xcc; i++) {
+					if (xcc_id != adev->mes.master_xcc_ids[i])
+						continue;
+
+					tmp = RREG32_SOC15(GC, GET_INST(GC, i),
+							   regSCRATCH_REG0);
+					if (tmp != 0xDEADBEEF)
+						break;
+				}
+			}
+		}
+
+		if (tmp == 0xDEADBEEF)
+			break;
+
+		if (amdgpu_emu_mode == 1)
+			msleep(1);
+		else
+			udelay(1);
+	}
+
+	if (i >= adev->usec_timeout) {
+		dev_err(adev->dev, "xcc%d: mes self test (%s) failed\n", xcc_id,
+		      queue_type == AMDGPU_RING_TYPE_SDMA ? "sdma" : "compute");
+
+		while (halt_if_hws_hang)
+			schedule();
+
+		r = -ETIMEDOUT;
+	} else {
+		dev_info(adev->dev, "xcc%d: mes self test (%s) pass\n", xcc_id,
+		      queue_type == AMDGPU_RING_TYPE_SDMA ? "sdma" : "compute");
+	}
+
+	return r;
+}
+
+#define USER_CTX_SIZE (PAGE_SIZE * 2)
+#define USER_CTX_VA AMDGPU_VA_RESERVED_BOTTOM
+#define RING_OFFSET(addr) ((addr))
+#define EOP_OFFSET(addr)  ((addr) + PAGE_SIZE)
+#define WPTR_OFFSET(addr) ((addr) + USER_CTX_SIZE - sizeof(u64))
+#define RPTR_OFFSET(addr) ((addr) + USER_CTX_SIZE - sizeof(u64) * 2)
+#define FENCE_OFFSET(addr) ((addr) + USER_CTX_SIZE - sizeof(u64) * 3)
+
+static int mes_v12_1_test_queue(struct amdgpu_device *adev, int xcc_id,
+		     int pasid, struct amdgpu_vm *vm, u64 meta_gpu_addr,
+		     u64 queue_gpu_addr, void *ctx_ptr, int queue_type)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
+	struct amdgpu_mqd *mqd_mgr = &adev->mqds[queue_type];
+	struct amdgpu_mqd_prop mqd_prop = {0};
+	struct mes_add_queue_input add_queue = {0};
+	struct mes_remove_queue_input remove_queue = {0};
+	struct amdgpu_bo *mqd_bo = NULL;
+	int num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	int i, r, off, mqd_size, mqd_count = 1;
+	void *mqd_ptr = NULL;
+	u64 mqd_gpu_addr, doorbell_idx;
+
+	/* extra one page size padding for mes fw */
+	mqd_size = mqd_mgr->mqd_size + PAGE_SIZE;
+
+	if (queue_type == AMDGPU_RING_TYPE_SDMA) {
+		doorbell_idx = adev->mes.db_start_dw_offset +	\
+			adev->doorbell_index.sdma_engine[0];
+	} else {
+		doorbell_idx = adev->mes.db_start_dw_offset + \
+			adev->doorbell_index.userqueue_start;
+	}
+
+	if (adev->mes.enable_coop_mode &&
+	    queue_type == AMDGPU_RING_TYPE_COMPUTE) {
+		for (i = 0, mqd_count = 0; i < num_xcc; i++) {
+			if (adev->mes.master_xcc_ids[i] == xcc_id)
+				mqd_count++;
+		}
+		mqd_size *= mqd_count;
+	}
+
+	r = mes_v12_1_alloc_test_buf(adev, &mqd_bo, &mqd_gpu_addr,
+				     &mqd_ptr, mqd_size * mqd_count);
+	if (r < 0)
+		return r;
+
+	mqd_prop.mqd_gpu_addr = mqd_gpu_addr;
+	mqd_prop.hqd_base_gpu_addr = RING_OFFSET(USER_CTX_VA);
+	mqd_prop.eop_gpu_addr = EOP_OFFSET(USER_CTX_VA);
+	mqd_prop.wptr_gpu_addr = WPTR_OFFSET(USER_CTX_VA);
+	mqd_prop.rptr_gpu_addr = RPTR_OFFSET(USER_CTX_VA);
+	mqd_prop.doorbell_index = doorbell_idx;
+	mqd_prop.queue_size = PAGE_SIZE;
+	mqd_prop.mqd_stride_size = mqd_size;
+	mqd_prop.use_doorbell = true;
+	mqd_prop.hqd_active = false;
+
+	mqd_mgr->init_mqd(adev, mqd_ptr, &mqd_prop);
+	if (mqd_count > 1) {
+		for (i = 1; i < mqd_count; i++) {
+			off = mqd_size * i;
+			mqd_prop.mqd_gpu_addr = mqd_gpu_addr + off;
+			mqd_mgr->init_mqd(adev, (char *)mqd_ptr + off,
+					  &mqd_prop);
+		}
+	}
+
+	add_queue.xcc_id = xcc_id;
+	add_queue.process_id = pasid;
+	add_queue.page_table_base_addr = adev->vm_manager.vram_base_offset +
+		amdgpu_bo_gpu_offset(vm->root.bo) - adev->gmc.vram_start;
+	add_queue.process_va_start = 0;
+	add_queue.process_va_end = adev->vm_manager.max_pfn - 1;
+	add_queue.process_context_addr = meta_gpu_addr;
+	add_queue.gang_context_addr = meta_gpu_addr + AMDGPU_MES_PROC_CTX_SIZE;
+	add_queue.doorbell_offset = doorbell_idx;
+	add_queue.mqd_addr = mqd_gpu_addr;
+	add_queue.wptr_addr = mqd_prop.wptr_gpu_addr;
+	add_queue.wptr_mc_addr = WPTR_OFFSET(queue_gpu_addr);
+	add_queue.queue_type = queue_type;
+	add_queue.vm_cntx_cntl = hub->vm_cntx_cntl;
+
+	r = mes_v12_1_add_hw_queue(&adev->mes, &add_queue);
+	if (r)
+		goto error;
+
+	mes_v12_1_test_ring(adev, xcc_id, (u32 *)RING_OFFSET((char *)ctx_ptr),
+			    FENCE_OFFSET(USER_CTX_VA),
+			    FENCE_OFFSET((char *)ctx_ptr),
+			    WPTR_OFFSET((char *)ctx_ptr),
+			    doorbell_idx, queue_type);
+
+	remove_queue.xcc_id = xcc_id;
+	remove_queue.doorbell_offset = doorbell_idx;
+	remove_queue.gang_context_addr = add_queue.gang_context_addr;
+	r = mes_v12_1_remove_hw_queue(&adev->mes, &remove_queue);
+
+error:
+	amdgpu_bo_free_kernel(&mqd_bo, &mqd_gpu_addr, &mqd_ptr);
+	return r;
+}
+
+static int mes_v12_1_self_test(struct amdgpu_device *adev, int xcc_id)
+{
+	int queue_types[] = { AMDGPU_RING_TYPE_COMPUTE,
+		              /* AMDGPU_RING_TYPE_SDMA */ };
+	struct amdgpu_bo_va *bo_va = NULL;
+	struct amdgpu_vm *vm = NULL;
+	struct amdgpu_bo *meta_bo = NULL, *ctx_bo = NULL;
+	void *meta_ptr = NULL, *ctx_ptr = NULL;
+	u64 meta_gpu_addr, ctx_gpu_addr;
+	int size, i, r, pasid;;
+
+	pasid = amdgpu_pasid_alloc(16);
+	if (pasid < 0)
+		pasid = 0;
+
+	size = AMDGPU_MES_PROC_CTX_SIZE + AMDGPU_MES_GANG_CTX_SIZE;
+	r = mes_v12_1_alloc_test_buf(adev, &meta_bo, &meta_gpu_addr,
+				     &meta_ptr, size);
+	if (r < 0)
+		goto err2;
+
+	r = mes_v12_1_alloc_test_buf(adev, &ctx_bo, &ctx_gpu_addr,
+				     &ctx_ptr, USER_CTX_SIZE);
+	if (r < 0)
+		goto err2;
+
+	vm = kzalloc(sizeof(*vm), GFP_KERNEL);
+	if (!vm) {
+		r = -ENOMEM;
+		goto err2;
+	}
+
+	r = amdgpu_vm_init(adev, vm, -1, pasid);
+	if (r)
+		goto err1;
+
+	r = mes_v12_1_map_test_bo(adev, ctx_bo, vm, &bo_va,
+				  USER_CTX_VA, USER_CTX_SIZE);
+	if (r)
+		goto err0;
+
+	for (i = 0; i < ARRAY_SIZE(queue_types); i++) {
+		memset(ctx_ptr, 0, USER_CTX_SIZE);
+
+		r = mes_v12_1_test_queue(adev, xcc_id, pasid, vm, meta_gpu_addr,
+					 ctx_gpu_addr, ctx_ptr, queue_types[i]);
+		if (r)
+			break;
+	}
+
+	amdgpu_unmap_static_csa(adev, vm, ctx_bo, bo_va, USER_CTX_VA);
+err0:
+	amdgpu_vm_fini(adev, vm);
+err1:
+	kfree(vm);
+err2:
+	amdgpu_bo_free_kernel(&meta_bo, &meta_gpu_addr, &meta_ptr);
+	amdgpu_bo_free_kernel(&ctx_bo, &ctx_gpu_addr, &ctx_ptr);
+	amdgpu_pasid_free(pasid);
+	return r;
+}
+
-- 
2.53.0

