Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8D0C61DD3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FFBC10EF09;
	Tue,  1 Sep 2026 20:11:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="phOK2RML";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4455F10EEFB
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:11:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I262oYL78paaSoHMFuFtEkh0x9wup1xl65PHbEVe+AMlKRZ2ANN76TL8cx8wTn2Zsh+9PQ8dsAsce2ostibpvTrzVfc6REctlTC+Mz8XNczrip3zMklUSePbK6rUubYbTXDkObEI4qk5Wv0aQ2HY82hkhvILQBHsggBYyZZmZobDAisMoXmJJ1jjYLrhua3BzJqytFbNKYmEwBonAXNn4NCCFcjKaoOal9WIhGoKk4vEX+UIi1s3IhFpuUFVJbEvMkwsWsrEeVLKMI2b7YpOciRZqmuVXYOmhIUVt4pT3aSACew21AUGELS5gLE4ipCUx18uaQlM4HaEOKZ8jiNNtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gV0KLw0vfkpOEQL7WBme9t6DHPQRcQAYJ/200bop1WI=;
 b=BWJDyIMwMw9Gt43s/7BwoTxRPgOGSRcCzmg9l6X+0rrgy1kDomWp+/CQOBHLOfxKqmrTG7RSON+BCZPgYLSasdOEyNjRj+Mgx3cKQwUwyUARqweShyKCR3UnT/1wIf7Ory16TKoRo8EQA6sajJGtgg1PHRw/jRf2p23hf9tdO+cephdLveFXO73S6yw24gDh7dLAAHPWqeIwRbAjByHnq45mHUjPt2tzCWwlfErtfxqTl45GfuF31/udSc1sp2uCR1EwPRFLJoOt4X55gjIHNGH2VSnLYN1MZ9R3BhU0JiwEUj76ov9J5FLPNsU+PsC7m/ZkaZQr9+5qX58Tl2TjSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gV0KLw0vfkpOEQL7WBme9t6DHPQRcQAYJ/200bop1WI=;
 b=phOK2RML/V/wRwwYGJOPxRxC6P/U5kwQ1mF/fBtCFSaYjccBFqidZ5HJuTak/LwpZ3JaYVCWvApkADf4XM8G7e7ddp8cA9jHnW4zV+oJKqNa19ZSYGWOQhknl2KYael/UUrH8lzccjytaRQA/0BSirAyIU5sSPvEG1aamntdnxQ=
Received: from CH0PR03CA0092.namprd03.prod.outlook.com (2603:10b6:610:cd::7)
 by DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:11:03 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::36) by CH0PR03CA0092.outlook.office365.com
 (2603:10b6:610:cd::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:11:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:11:02 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:54 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:10:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/31] drm/amdgpu/sdma5.2: add tlb invalidation buffer func
 callback
Date: Tue, 1 Sep 2026 16:10:16 -0400
Message-ID: <20260901201034.2960437-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|DM6PR12MB4300:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d4ebd0-8927-4aae-c4f8-08df086525d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|6133799003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 19an+lJkmlY7EREmNgybJFNaRyO3y0ew7bG9f4JeI61pXwbYRn0gWgnjDfEX7NPb9CA7Y8pneb+ihnwnG/NQhv7NOqx7pderPsdxgruCJuiROc3x/bZ97wI3FaLyYuO750g9c/HF2dIWWw1ia0oJrPb1DNGn/8wM+lNRCvcHakyMfAE3Dv0NAvTdGDCuZKaG8IE3MZYbajdHjLZg7vUpvMdDMcglsyHMg4bex4Nz6Ump671zgCpyfHvRgwiOqQi1fx7ZXeLenCCnF7uuvpMCLAYfI+S5yq8Q1w46vgyegXVKMWo/6SzSa0eoa9MRiX472fofCLnQ2z15+vBb0+DlmTbpfEN3/mYe4vUOHhY3hY96yFqaI4tkp8wvwYVvNVQxFh6jRTblzx0te/t5b/PdaoLKyffNq+H2Ka/hZwMNbqRnXJzE/qx1WD0HIyyoCHTO0wC0Sn2e1Y1znjmhzpBibHzFsVssUA3sKS0TZKXIBfkfhrdYBAaRNpidTVxZqiZLMwStvJ7JO1t+QP8eoAGJj4G48b0ZGmX7tRK8QRqIogjaS3gtXCu8HIT4Tfre1ws9VXA7jpn3BTuRai0YPTR41zMwB24G9P9Q0o1fp0Pb0yyvEOXcYzAgQ6xSVY0R6bZxzepYgdH50F0AxsWqCNeT4VVOMy8PLptrIBNr027OFQOp7gLVr3zc2nBFbREB7ldG7TEtE7coorb1gnmRp4SGdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4CjPvku6TcmrJYmni+kQy1jZD4IS2A5FHdRrEtDH7/0OU+o+SLjtOYpj6GPay1OaGXyvgvzDI9e9uAo4FqAZcchNjNdnVDTJfXC9bF1CEuSo6HZkWyPRG2fccwBAZtVjYj4tePco13CZDlMmrU/3EYRkmbYuW3zZoQHKdf0w31G3aDVekWVKnNuzeyd9i5BhLfr9T3iKRIJKT0EiApwt045Irc5DSHDSowgujqNd/UJJb4X9Ju0UO3sxGqFBo3IhkyT6fSp74/+H/DOJHQANnIs22JPHPBZDGyh6RfjFYK3jfSYIwx1OWJgUIetetfjJpfGbMjCCSUfBX1L6fWFtZ/pGnkBhvQXwUqkxiF/WEsGXyKlBoTg3bNN0s7VthrTxkAW83AcrfwiDRueZA6XWvhYXuIelaHcTXrLgw4OqvibiwKKP64/P7/ozf2vzctSJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:11:02.9201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d4ebd0-8927-4aae-c4f8-08df086525d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4300
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

Will be used for TLB invalidation.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 49 ++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 35cdf6c149f86..a10086de35957 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -2038,6 +2038,52 @@ static void sdma_v5_2_emit_fill_buffer(struct amdgpu_ib *ib,
 	ib->ptr[ib->length_dw++] = byte_count - 1;
 }
 
+/**
+ * sdma_v5_2_emit_tlb_inv - Invalidate TLB using the sDMA engine
+ *
+ * @adev: amdgpu device structure
+ * @ib: indirect buffer to fill
+ * @vmid: vmid to target
+ * @vmhub: vmhub to target
+ * @eng: invalidation engine to use
+ * @flush_type: type of flush (lightweight, heavyweight)
+ * @xcc_inst: XCC to target
+ *
+ * Invalidate TLB using the DMA engine.
+ */
+static void sdma_v5_2_emit_tlb_inv(struct amdgpu_device *adev,
+				   struct amdgpu_ib *ib,
+				   unsigned int vmid,
+				   u32 vmhub,
+				   u32 eng,
+				   u32 flush_type,
+				   u32 xcc_inst)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
+	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
+	u32 mmhub_eng, gfxhub_eng;
+
+	if (AMDGPU_IS_GFXHUB(vmhub)) {
+		mmhub_eng = 0x1f;
+		gfxhub_eng = eng;
+	} else {
+		mmhub_eng = eng;
+		gfxhub_eng = 0x1f;
+	}
+
+	/* Trigger invalidation. */
+	ib->ptr[ib->length_dw++] =
+		(SDMA_PKT_VM_INVALIDATION_HEADER_OP(SDMA_OP_POLL_REGMEM) |
+		 SDMA_PKT_VM_INVALIDATION_HEADER_SUB_OP(SDMA_SUBOP_VM_INVALIDATION) |
+		 SDMA_PKT_VM_INVALIDATION_HEADER_GFX_ENG_ID(gfxhub_eng) |
+		 SDMA_PKT_VM_INVALIDATION_HEADER_MM_ENG_ID(mmhub_eng));
+	ib->ptr[ib->length_dw++] = inv_req;
+	ib->ptr[ib->length_dw++] = 0xFFFFFFFF;
+	ib->ptr[ib->length_dw++] =
+		(SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_INVALIDATEACK(1 << vmid) |
+		 SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_ADDRESSRANGEHI(0x1F));
+}
+
 static const struct amdgpu_buffer_funcs sdma_v5_2_buffer_funcs = {
 	.copy_max_bytes = 1 << 30,
 	.copy_num_dw = 7,
@@ -2046,6 +2092,9 @@ static const struct amdgpu_buffer_funcs sdma_v5_2_buffer_funcs = {
 	.fill_max_bytes = 1 << 30, /* HW supports 1 << 30, but PAL uses 1 << 22 */
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v5_2_emit_fill_buffer,
+
+	.tlb_inv_num_dw = 4,
+	.emit_tlb_inv = sdma_v5_2_emit_tlb_inv,
 };
 
 static void sdma_v5_2_set_buffer_funcs(struct amdgpu_device *adev)
-- 
2.55.0

