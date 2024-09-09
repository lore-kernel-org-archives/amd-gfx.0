Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBBEECE57B
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 09:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3980710E32F;
	Mon,  9 Sep 2024 09:40:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DcO1VtmB";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC09D10E32F
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 09:40:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiZ/Sn5W01AsJ2iLn4s/CtgsmUmhX6L5aP3vlCQwD4yXkW6NDiQ0B20o73xNt1LEkMilnL93x8BEP4MUBZ5p/9uTlIqqw1B8iVH9UWWEv58gDiO/FlxnLRiovFih/TKPbvKJNwve7zCJqyiMbtAf8jqcdkfAIVFCIx3ng8VIUMpkGvby9WUdQQPDkMh+n/XOpSFHf/dImhzbVqdVxPVC7V1IPUF9Fe4P3F4RiZ+qXX1xqYOlkHQjoDQw6b/h1ULsGOkMzWsnkvutIgQNK/rQ3h3F+eLMaHl7q8axV/wcZ8nqhCYCgsk1v58DbMiZ/Ckr0xSOABp7y/dopejBydBtrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ttlcd3I+VAOWwdB+W1TGWiQLfj8VpOI5/DUj5ofLMU=;
 b=l4YAMPmwbRgifqNsPB5EjRmIt6O/QayP8d5y+HD0Wgrzt/6zBe2PrCtkw4Ilr/0/8uCr2MTLSAe3Eu8UVO8ufENyAgDr75E48IMIKzn2rUmMGXV7fjWuWvSyMlgkVYFOt3cXSENO0fwmWURnUI2ipZQw1O1Qp3I/Zqm4mVcgDEXTMimNQPrYR5ssoVyl99mO/Z75v/sRvHIYEEVvCeijCZ4AT/JyCGY1of1hdiZipynTyghYJzKYJqclERT7Nh/42kUe8qD8BLnWBmEDyJBU3TtKEO3DbVamkFG9TMplGJXmgKqR3Qq/XUtre+7S2cFedS6PtO/93KZB2TC/OdJbxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ttlcd3I+VAOWwdB+W1TGWiQLfj8VpOI5/DUj5ofLMU=;
 b=DcO1VtmBNgaNaAW2gCrg2y0kthV7vwBhHDPNTx32wO8gQmhxy1gkgs2zJe0FdRr/iASZv8eRRb3bQjjXLPjy8rtRDta4R0i09G4AbyYIjvXRSKjVq49+hpy9k2nJ/HtpoQn5pK9C1KTC70dbBo63Y8DHMChhFVVFsnjiRdsCu8M=
Received: from IA1P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::7)
 by IA1PR12MB6212.namprd12.prod.outlook.com (2603:10b6:208:3e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Mon, 9 Sep
 2024 09:40:05 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:461:cafe::1b) by IA1P220CA0010.outlook.office365.com
 (2603:10b6:208:461::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 9 Sep 2024 09:40:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 09:40:05 +0000
Received: from mao-Super-Server.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 04:40:03 -0500
From: YuanShang <YuanShang.Mao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yuansmao@amd.com>, YuanShang <YuanShang.Mao@amd.com>
Subject: [PATCH v2] drm/amdgpu: Flush tlb by VM_INVALIDATION packet in
 sdma_v5_2
Date: Mon, 9 Sep 2024 17:39:55 +0800
Message-ID: <20240909093955.16747-1-YuanShang.Mao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|IA1PR12MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: 18511817-23f5-43e6-e3a6-08dcd0b362ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NCwQUfW8nnhQAqEKjNI7otrQ3w42RLhgLut2pGBgGr5QVRt1zYzPFhWXD7p3?=
 =?us-ascii?Q?Zd+dLA3n9CVmoZRYgRnvO+tkd+Qbccog8gmZ7dHcB2GrNHrPjjaMQO2uQH9k?=
 =?us-ascii?Q?xJ+0AWmC1XxaN1oVyzZuOm/A09a5LHziI8AxUXyGHQgHHReAvpuGIN2ps3bB?=
 =?us-ascii?Q?hvRgHvlqdbakXbgerN3UF5D+uENdT5g7skkYW3f/ZZcXHFYRsjNUyigULJpw?=
 =?us-ascii?Q?p3fm336jxAWBwakiuFsbe1UFhtPUR6H/5D1aC60dRT0pgT+3Ryk0rOdyEbjI?=
 =?us-ascii?Q?53OPJLbKkYryJ/xkeEdk164g4cuJYrSbr1BfD+C1GkefAPMWeA+vxaKUC4WN?=
 =?us-ascii?Q?gRNOsuEYV09Ysx26GG8UJau4DiCkzbs1aBe23KD0c+3Ufs2hK4miF2icHLE/?=
 =?us-ascii?Q?LyHQiVbMPGF+HiLpA34I4BBc+peGtbCmFCitIY09d2E9RWQmTcwa4y9SdT+r?=
 =?us-ascii?Q?kfu4v2MVgo4ZxNNqG/Kq8zUn7f3k7VFWzB+enYV0e6qp1xa7WBPfdnoxzEyS?=
 =?us-ascii?Q?VK2i6YpJ0fXtjjGSeB5RgiwXCisEJvYQ9Uu0hUvOJmGFPQPUphvKKsplBuRY?=
 =?us-ascii?Q?Dbi3Yhp1yiLag2MYzx9tEiKnc7GAx1+sI56mv1XldLmJxOn+unZtPvWMGT4f?=
 =?us-ascii?Q?Tzzu/vEd/10G1dd+5kLPhxiJV74IrAuGFv5kphP5NSyJwkFtGQgyoixFgUx9?=
 =?us-ascii?Q?dfG3aDDSuQ1ilS4YRkm3MPbHu42PtXRPku6O/FEyjT6c/01dLFgl0sHI2jtJ?=
 =?us-ascii?Q?NTJm9gvAFYtZ8ECPLDwIUAcMdjUz8VIQ9MZpUp2yS/Xk+qtD7d5wLS005r+R?=
 =?us-ascii?Q?bmRxYtwvTGX1a/9FiXWScnSKMVbRvuuh0u/iFhYJwrXmXdmgji2AmFMEgUhh?=
 =?us-ascii?Q?UY7j7ESfEubzTPsPhv8VO9kipTEyXBriPlbvcPlvBnDZfGbZN+d9TOS5SZ+R?=
 =?us-ascii?Q?Zb/VlYJW8/r0+isOQJlYKpCkyq14aPB6FAHfbslwt7LEGjUfpCNEVoBOtMpH?=
 =?us-ascii?Q?9uc3Xe3bq4bgfY8LmAMDAir77uYsUZ0g92YQUzRfZtpsYmdtCGgiEWlXA/Jf?=
 =?us-ascii?Q?Ko6vRLxDxMXlfXFrVkh2AeW/6QYUU3DCBCO7w5ge2SUZoMA9DnTrTs4tp1qc?=
 =?us-ascii?Q?sOKiMHttnhIz3qWhoPVaOUSKGMOK9HAZXw7uhBwc9z302Ctn3J5a+Jeotuf0?=
 =?us-ascii?Q?Bj9mwysOAsYLxEdPu8jjOj9PPiVDnAaGTJfNpR8ZccyS5oDtyWlsYB3/h/ks?=
 =?us-ascii?Q?+UCzc0o0wtZYQxREokH/RI/wwBfGxckebcjbIzXJVD4+NqVvoD1wYK6lkwX1?=
 =?us-ascii?Q?Dcdn/RGJdLZeJ4FMNzoVDMTcV+X5VxbrMSKfUrDslB41r0hOic2moamKjoqk?=
 =?us-ascii?Q?9/IBtOGm3U4n8x353xwczYxErJTuA/yICzybeMxLSZpPadWK6ha+qh1WM7IV?=
 =?us-ascii?Q?5Jj7F3q4aR26NJ/gQ18L484Nx+AHaPUw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 09:40:05.4329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18511817-23f5-43e6-e3a6-08dcd0b362ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6212
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

In order for SDMA not to be switched between VM_INVALIDATION
request and ack, use an single VM_INVALIDATION packet in function
sdma_v5_2_ring_emit_vm_flush.

Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
---
 .../gpu/drm/amd/amdgpu/navi10_sdma_pkt_open.h | 64 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        | 23 ++++++-
 2 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_sdma_pkt_open.h b/drivers/gpu/drm/amd/amdgpu/navi10_sdma_pkt_open.h
index a5b60c9a2418..c88284ff92d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_sdma_pkt_open.h
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_sdma_pkt_open.h
@@ -68,6 +68,7 @@
 #define SDMA_SUBOP_POLL_REG_WRITE_MEM  1
 #define SDMA_SUBOP_POLL_DBIT_WRITE_MEM  2
 #define SDMA_SUBOP_POLL_MEM_VERIFY  3
+#define SDMA_SUBOP_VM_INVALIDATION  4
 #define HEADER_AGENT_DISPATCH  4
 #define HEADER_BARRIER  5
 #define SDMA_OP_AQL_COPY  0
@@ -4040,6 +4041,69 @@
 #define SDMA_PKT_POLL_MEM_VERIFY_RESERVED_RESERVED(x) (((x) & SDMA_PKT_POLL_MEM_VERIFY_RESERVED_reserved_mask) << SDMA_PKT_POLL_MEM_VERIFY_RESERVED_reserved_shift)
 
 
+/*
+** Definitions for SDMA_PKT_VM_INVALIDATION packet
+*/
+
+/*define for HEADER word*/
+/*define for op field*/
+#define SDMA_PKT_VM_INVALIDATION_HEADER_op_offset 0
+#define SDMA_PKT_VM_INVALIDATION_HEADER_op_mask   0x000000FF
+#define SDMA_PKT_VM_INVALIDATION_HEADER_op_shift  0
+#define SDMA_PKT_VM_INVALIDATION_HEADER_OP(x) (((x) & SDMA_PKT_VM_INVALIDATION_HEADER_op_mask) << SDMA_PKT_VM_INVALIDATION_HEADER_op_shift)
+
+/*define for sub_op field*/
+#define SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_offset 0
+#define SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_mask   0x000000FF
+#define SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_shift  8
+#define SDMA_PKT_VM_INVALIDATION_HEADER_SUB_OP(x) (((x) & SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_mask) << SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_shift)
+
+/*define for gfx_eng_id field*/
+#define SDMA_PKT_VM_INVALIDATION_HEADER_gfx_eng_id_offset 0
+#define SDMA_PKT_VM_INVALIDATION_HEADER_gfx_eng_id_mask   0x0000001F
+#define SDMA_PKT_VM_INVALIDATION_HEADER_gfx_eng_id_shift  16
+#define SDMA_PKT_VM_INVALIDATION_HEADER_GFX_ENG_ID(x) (((x) & SDMA_PKT_VM_INVALIDATION_HEADER_gfx_eng_id_mask) << SDMA_PKT_VM_INVALIDATION_HEADER_gfx_eng_id_shift)
+
+/*define for mm_eng_id field*/
+#define SDMA_PKT_VM_INVALIDATION_HEADER_mm_eng_id_offset 0
+#define SDMA_PKT_VM_INVALIDATION_HEADER_mm_eng_id_mask   0x0000001F
+#define SDMA_PKT_VM_INVALIDATION_HEADER_mm_eng_id_shift  24
+#define SDMA_PKT_VM_INVALIDATION_HEADER_MM_ENG_ID(x) (((x) & SDMA_PKT_VM_INVALIDATION_HEADER_mm_eng_id_mask) << SDMA_PKT_VM_INVALIDATION_HEADER_mm_eng_id_shift)
+
+/*define for INVALIDATEREQ word*/
+/*define for invalidatereq field*/
+#define SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_offset 1
+#define SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_mask   0xFFFFFFFF
+#define SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_shift  0
+#define SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_INVALIDATEREQ(x) (((x) & SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_mask) << SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_shift)
+
+/*define for ADDRESSRANGELO word*/
+/*define for addressrangelo field*/
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_offset 2
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_mask   0xFFFFFFFF
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_shift  0
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_ADDRESSRANGELO(x) (((x) & SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_mask) << SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_shift)
+
+/*define for ADDRESSRANGEHI word*/
+/*define for invalidateack field*/
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_offset 3
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_mask   0x0000FFFF
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_shift  0
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_INVALIDATEACK(x) (((x) & SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_mask) << SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_shift)
+
+/*define for addressrangehi field*/
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_offset 3
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_mask   0x0000001F
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_shift  16
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_ADDRESSRANGEHI(x) (((x) & SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_mask) << SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_shift)
+
+/*define for reserved field*/
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_offset 3
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_mask   0x000001FF
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_shift  23
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_RESERVED(x) (((x) & SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_mask) << SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_shift)
+
+
 /*
 ** Definitions for SDMA_PKT_ATOMIC packet
 */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index bc9b240a3488..46b86bb5cd2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1180,7 +1180,28 @@ static void sdma_v5_2_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 static void sdma_v5_2_ring_emit_vm_flush(struct amdgpu_ring *ring,
 					 unsigned vmid, uint64_t pd_addr)
 {
-	amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
+	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
+	uint32_t req = hub->vmhub_funcs->get_invalidate_req(vmid, 0);
+
+	/* Update the PD address for this VMID. */
+	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
+			      (hub->ctx_addr_distance * vmid),
+			      lower_32_bits(pd_addr));
+	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
+			      (hub->ctx_addr_distance * vmid),
+			      upper_32_bits(pd_addr));
+
+	/* Trigger invalidation. */
+	amdgpu_ring_write(ring,
+			  SDMA_PKT_VM_INVALIDATION_HEADER_OP(SDMA_OP_POLL_REGMEM) |
+			  SDMA_PKT_VM_INVALIDATION_HEADER_SUB_OP(SDMA_SUBOP_VM_INVALIDATION) |
+			  SDMA_PKT_VM_INVALIDATION_HEADER_GFX_ENG_ID(ring->vm_inv_eng) |
+			  SDMA_PKT_VM_INVALIDATION_HEADER_MM_ENG_ID(0x1f));
+	amdgpu_ring_write(ring, req);
+	amdgpu_ring_write(ring, 0xFFFFFFFF);
+	amdgpu_ring_write(ring,
+			  SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_INVALIDATEACK(1 << vmid) |
+			  SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_ADDRESSRANGEHI(0x1F));
 }
 
 static void sdma_v5_2_ring_emit_wreg(struct amdgpu_ring *ring,
-- 
2.25.1

