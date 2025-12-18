Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7A5D711CD
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 22:42:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D364110EBDC;
	Thu, 18 Dec 2025 22:42:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gijwk0m3";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010068.outbound.protection.outlook.com
 [40.93.198.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F86010EBCC
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 22:42:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzuHZ1sQ7NdggwyyBCbIauzRa1w343IajiUT0TlVoRxFi/HeaROnhKzQSSUZimK8HkoCEs67vHKI6IwOWxOPLWXcldQZnXNtOoQdTXzxN5cayBNA+KiiHZ58u7/OfjoFBFfAUojpbY7VHtC1JuibG9JQ1CwYZSCyfIOaL2uMtEiyHf4azGFwMybSDm21F21v4qja7QO1muTuwhLNrrpVr9jQxmwVCxyWspP+M49JrKbnk2l1iNmtFfdfSIXTzuXRNLA1E2T8lNFqVNr/a0RG3K8xQKNgibiA93AzuexpFRPWe6yhLHy69RizDoCa6JUzCn/OEOVWKwi03oA/H7+OGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ml1qaRfNbrmZNqUcAaUIvzP94P3Vp21bBYptGZ3d9SM=;
 b=J5iNfjx+FtMSAuc30W4zAmUC4BZtMu+e9jWVMhKVddzAFY51hIM2Yb4R7mw/wax5yJJkTNSSwvVTOZ3LTF65tIXI+8aPOplLlwZpplizVr0cOT3VF7PrUMr36MLgZLxpaqZ34mxDGmkp9zq6Dd7NO8VcJerDhLSP1BFN5prbbWHSHwFeKHe/AciYmDY4dcSDLMjLngPTTiUUuc0zlXyK0Mse9Lp3/SI3zpGcbI2G1jSlaVMOuIVgFdUHs7C5Fm8PCJvmAlz8q9cBeCBblt86+4Lp3Tn+OgI2nGPF61E8yzRT2kbXadLGbPSNL5xEXDSG00ahk0RHaoKFh8rwD0axoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ml1qaRfNbrmZNqUcAaUIvzP94P3Vp21bBYptGZ3d9SM=;
 b=gijwk0m3WRg4fLyuB4Z5mhEIap3D7IKDrbxEuv66dnA0zuY1QEhsHb+U7h0edQTP/+HcRXlOvwHE27EZjWyp0gIF6F4m+AC39IXRrxan3AO1UtY3wMyLDZrYppsfTx3mwAnwd+BzX7boNP3v2XaxSvlg2jG+sZLo2RWlhkrjxtY=
Received: from MW4PR04CA0095.namprd04.prod.outlook.com (2603:10b6:303:83::10)
 by CY5PR12MB6430.namprd12.prod.outlook.com (2603:10b6:930:3a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 22:42:01 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::67) by MW4PR04CA0095.outlook.office365.com
 (2603:10b6:303:83::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Thu,
 18 Dec 2025 22:41:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Thu, 18 Dec 2025 22:42:00 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 16:41:55 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/7] drm/amdgpu/gfx9: rework pipeline sync packet sequence
Date: Thu, 18 Dec 2025 17:41:40 -0500
Message-ID: <20251218224141.5841-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218224141.5841-1-alexander.deucher@amd.com>
References: <20251218224141.5841-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|CY5PR12MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: 59d806c7-48f9-4f10-1da5-08de3e86a8b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qMfd3OPAxKxPDrtXpo3yOx4EqN+xhXPmI80Gw1cIbPu6Gbzo0sfqZL0r13dL?=
 =?us-ascii?Q?79Hbj4pGn+e3aZAGcmC63Mzv0adbpHXogUDUBiLIyU/lKubd6A7JgLO8JWBk?=
 =?us-ascii?Q?ZAmobr5bK4qMpdeB3mBZQrLm3N7RqzWboJk2ZJug3eyMpPnhzCdPMioCWC98?=
 =?us-ascii?Q?hk/1dizlohLmfdN/gLgyt2WSW3WfG0IYK6YbN4Tlt6fDk1pC9k0NRPm1AZzE?=
 =?us-ascii?Q?0dDMubKaJwweizuY09x9YOcKfXlgWP1afQk2Y2vTNiXfX+J2APjdTwYlDKK8?=
 =?us-ascii?Q?sqLsnmDcO2ENaAOkp7YiPHwCAcKjULgSRfnmlD4h85IRHO3YdqT9eUVUohKj?=
 =?us-ascii?Q?KpT30v6NoAL5XDywahCUY8Zn36/njCPVan3ojHIr88BeMER5lGBlPiWlSHNs?=
 =?us-ascii?Q?vI6CXIuytjsX7HJb/d9+tSf3Mp1AGbv5SgsHg3MSYk9WYfCQnN7VVI9mDSqj?=
 =?us-ascii?Q?2dy2BPcEsr1wpzp3qqTIhz4G7uV+Q3/QeC60p4MAel5f6M2+lnqrIM4c1D/Z?=
 =?us-ascii?Q?GCCiLXlc9P/x2oi5OlQha4e7ZecRcdLG4rr0bH/5EkUXp/v5CZz1lkKztpPT?=
 =?us-ascii?Q?Iuc7LsBV6dcJNJeafuafQCSA6ysjEl+plrqS6d4DDLL9ZT+n+971CNbeSQk1?=
 =?us-ascii?Q?4Qz2jBNFIbZG4vY4M+KjoLJTn3rXmzw5pi6v/fTJm8GcYHJEtd8e9H5wVlzV?=
 =?us-ascii?Q?WTST1mfRX9FDZgU4dYetNUTm1cJaKDTXkE6uG0peFsMXV0/tMRX+y0I2Dhg6?=
 =?us-ascii?Q?wAYFo7pSAI7ECCXAiBa1iusfDxDl4fLD7aUSbzwyMljdrE+lFePJdyhHG1wo?=
 =?us-ascii?Q?Ey0miXazPCQoylVAHxymERWdOIg5ncgj4W3nn8ziJMlgYiFtKD2zjr8ofY0R?=
 =?us-ascii?Q?yBracRI7M8ncb7OXrR2KtLSyeSAB043ZZf4W0fDScfirROjou2gf2Az5kZOo?=
 =?us-ascii?Q?FY0UtShXWuD43oA65e0X/IPlJRGon32rdkbv1V6BShnBz55Fdy+H8US5RwsP?=
 =?us-ascii?Q?FaHul94WBevy7MAd4MnrUp/Ux/rA3QDQscurj+Nqo9LSKQKUexc5935uSuxJ?=
 =?us-ascii?Q?YvEYbJa4p+3KWY4rte5a/6ECFeP9IlK0yQPXuaGEBfvzV3XBop6YHtM21pxm?=
 =?us-ascii?Q?kiCKoIvSEuDVN39XgUPzvisgsE/vHbWT4ZCNn0MqwHjIN8alvOyNxXG0c2DT?=
 =?us-ascii?Q?hFLn9rGDR25wT3FtEXLFyUZT/0UrMhjhyU7mCxHB+55vmukF2igj2kQJWsHH?=
 =?us-ascii?Q?SgSPGRuLJ3xT4T4MJuuhVKlJGbqejctqHP7+WBkmDiTp3W+RlmUm+IxSv7X7?=
 =?us-ascii?Q?FhVuRy9B6bT5ZyUycUUXH4ELbOccbaG4nvJn3FBkm4VyKNiAsroNUkIjRrlp?=
 =?us-ascii?Q?zF27HrMqxiEnmIXFpy2sGf7L7BThmeREmD6V1t54PConeBmnEO1yg09LNjVS?=
 =?us-ascii?Q?o11vpfXxN12h2kcVowQ70Gt0SiMoxSqGMPTGnkqFBNsQ2WOw0jUMdP0k76CV?=
 =?us-ascii?Q?2lslio8LrRNxeLTZgNqdrrcswCz225xuRg3lkDronzusrYGMHa6L2t1MbqlX?=
 =?us-ascii?Q?PnZtyQDTR8iXgwnHR38=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 22:42:00.9035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d806c7-48f9-4f10-1da5-08de3e86a8b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6430
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

Replace WAIT_REG_MEM with EVENT_WRITE flushes for all
shader types and PFP_SYNC_ME.  That should accomplish
the same thing and avoid having to wait on a fence
preventing any issues with pipeline syncs during
queue resets.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 32 ++++++++++++++++++---------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 7b012ca1153ea..d9dee3c11a05d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5572,15 +5572,26 @@ static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	amdgpu_ring_write(ring, 0);
 }
 
-static void gfx_v9_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+static void gfx_v9_0_ring_emit_event_write(struct amdgpu_ring *ring,
+					   uint32_t event_type,
+					   uint32_t event_index)
 {
-	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
-	uint32_t seq = ring->fence_drv.sync_seq;
-	uint64_t addr = ring->fence_drv.gpu_addr;
+	amdgpu_ring_write(ring, PACKET3(PACKET3_EVENT_WRITE, 0));
+	amdgpu_ring_write(ring, EVENT_TYPE(event_type) |
+			  EVENT_INDEX(event_index));
+}
 
-	gfx_v9_0_wait_reg_mem(ring, usepfp, 1, 0,
-			      lower_32_bits(addr), upper_32_bits(addr),
-			      seq, 0xffffffff, 4);
+static void gfx_v9_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+{
+	if (ring->funcs->type == AMDGPU_RING_TYPE_GFX) {
+		gfx_v9_0_ring_emit_event_write(ring, VS_PARTIAL_FLUSH, 4);
+		gfx_v9_0_ring_emit_event_write(ring, PS_PARTIAL_FLUSH, 4);
+		gfx_v9_0_ring_emit_event_write(ring, CS_PARTIAL_FLUSH, 4);
+		amdgpu_ring_write(ring, PACKET3(PACKET3_PFP_SYNC_ME, 0));
+		amdgpu_ring_write(ring, 0x0);
+	} else {
+		gfx_v9_0_ring_emit_event_write(ring, CS_PARTIAL_FLUSH, 4);
+	}
 }
 
 static void gfx_v9_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
@@ -7404,7 +7415,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.set_wptr = gfx_v9_0_ring_set_wptr_gfx,
 	.emit_frame_size = /* totally 242 maximum if 16 IBs */
 		5 +  /* COND_EXEC */
-		7 +  /* PIPELINE_SYNC */
+		8 +  /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		2 + /* VM_FLUSH */
@@ -7460,7 +7471,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
 	.set_wptr = amdgpu_sw_ring_set_wptr_gfx,
 	.emit_frame_size = /* totally 242 maximum if 16 IBs */
 		5 +  /* COND_EXEC */
-		7 +  /* PIPELINE_SYNC */
+		8 +  /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		2 + /* VM_FLUSH */
@@ -7521,7 +7532,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 		20 + /* gfx_v9_0_ring_emit_gds_switch */
 		7 + /* gfx_v9_0_ring_emit_hdp_flush */
 		5 + /* hdp invalidate */
-		7 + /* gfx_v9_0_ring_emit_pipeline_sync */
+		2 + /* gfx_v9_0_ring_emit_pipeline_sync */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user fence, vm fence */
@@ -7564,7 +7575,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
 		20 + /* gfx_v9_0_ring_emit_gds_switch */
 		7 + /* gfx_v9_0_ring_emit_hdp_flush */
 		5 + /* hdp invalidate */
-		7 + /* gfx_v9_0_ring_emit_pipeline_sync */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		8 + 8 + 8, /* gfx_v9_0_ring_emit_fence_kiq x3 for user fence, vm fence */
-- 
2.52.0

