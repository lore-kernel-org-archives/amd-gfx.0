Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFB3F417E5
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C73B10E50C;
	Mon,  9 Mar 2026 14:26:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="THHriIHw";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010071.outbound.protection.outlook.com [52.101.61.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B92C10E50C
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 14:26:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoUeemSDPxoQNFNhqUeNuavBni1F0tqKgyuvnPHHwlE9eohga1X5yCgBPm1efrOn+eWDV5NqqmKNm6V5SnniMN7BwyL/FayjzYxEmBfUh8PqyX/0RhFlBU4GZOUROZqwMGgZyR5f4oNHgDFqhTDq8bxUbPxGRv4ven8W+mtGJ+v76wk7rPIq+lVaBPBIL87OlC2kXemA5tZ4H0UTr4XriOWDje51/XQIg8dRDvG4+W8iSkOj/+/JT7M8kMcoLpQODJxdalBv5gRFfsGgbMRbUr8TW9FCxb51SeMbv3t7Uu4NU0XMqCxd6mGGisTQ2r8i1m0G04S3s1C52p/viqFrjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xw9aNfR8G5Zjoi7Z3VlBjXCdIagO+8NS3l+jVMUnnRA=;
 b=KfvhFHP0jFsEvNxBjyps7TxnUTJwHGOju9wtVjvjrlo/qUPat4fqTY+4lJakjxtTRSHkXae/x0geyIMQ8+WzKB/59VqfERGVhExbt/lRrKBjvkqOSuzTGSb1hn9Dt6d7LYQap1Z5PxV6xjhDhmDXj/d+LeVnraoaZUkrz/7o97m0Wd9UzUUqD61yEvmaiEFkwc/tN36ZCZwXGP7ANIjoBE1qsJVJVOBpGhJKC28dbnIIWy8IPqQ6jxTVh6LkEec7grxXb+ARADLdzbSIsnugz8+1z7sWOM/jQYJRGdFyFyDu2YXkNE+HZxXDB3S6tUmS3K7ggNNPgyEvQnjMUzsJ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xw9aNfR8G5Zjoi7Z3VlBjXCdIagO+8NS3l+jVMUnnRA=;
 b=THHriIHw4jk66q7LzFrM0sdTQNyWnPb1PYwzIfvgBI6H9AgRrSvpS6FG4CoQk1zxOmz4kGKRhyfN8XDOvRQ2STWa+/ONrPofs49Toj0KwJR626NHDTADMdYoVGY4hfdqNHJzqGjmFknRl5ScSsvHXIgzwOo1UY5G7q4WaXVClys=
Received: from SN1PR12CA0070.namprd12.prod.outlook.com (2603:10b6:802:20::41)
 by SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 14:26:42 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:802:20:cafe::ef) by SN1PR12CA0070.outlook.office365.com
 (2603:10b6:802:20::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 14:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:26:41 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 09:26:37 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Mar 2026 09:26:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: retire some unsupport cmd pkt bit for gfx v12_1
Date: Mon, 9 Mar 2026 10:26:19 -0400
Message-ID: <20260309142621.2843831-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309142621.2843831-1-alexander.deucher@amd.com>
References: <20260309142621.2843831-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|SJ1PR12MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: 017bd3ad-4dec-474d-27dc-08de7de7e219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: R0W1xoR0Bl1lAx4Gcl18/ZO/PP2yXqm++liRZWQxvYH7TqsL1JFmzoRdgieXh3MrkJjX0u7WE3yCol35vWC9P54RCycBtkpGbHldgM5c9AaxPITBIb4ZY6fW1J4XHQ31yMMHIUskf7VgYTKPJyRTsaSEFM763Oy3BRVmAz35etk6Ys84+KearB7oJiiK2zZOdi5/BUMxwTv6LUKNjEhqhuyPRNwzv/TX6QPlCQDroy8OA+wAzMWpTrCpDy4Wfnp58Dug/bQNR70puZK40gTWDgY8jGemUq0h15g+WePTOYKInAnW+67BR5qyDwSxhzu+xC9MWeW+UL7Gb6OPkkFYD/VY3AcDVQybZO7nGJlYJtkph9AFJAH/84WxAHlB7ZoPq9NnDjWIJGYU2t/E7sTA0B4lKivjkMbBM3iv7R52jqsRpVIKxR5Vf6DfmK2WX+NCZ5kC/8fXCYDHkZlGtEc2yaPM1kf2K4gEPLoQQhXdb32XHDJE5X6bXK1eKu0m+d96zEWtGl2hwh5bJnnPy8k9bGiQ8TgPMuOAU9SH7Y3HHsYuVX8t/aKNO/Sa395TZ+zBgliuQPQjSjqqW14uH30aSWComGOUeFJOehgnbntcWGq/NPzaQVsYSpmHqZ+hKXTdrnSRty82tAaGmTORyU7jKkMu5AU75bNS93sN7IKpIHo23fgYwUjCkm5vSNXDPtgeGTqpEvfPrQl4rQ2NklK9OCVE5No56TkfG1bGFmSyi6dv6E2bfKixQKIjczCyLvp61/ojPGqyturcOR3cj1004A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0Mo1Paj6RB4K3ZGRCFtMLANrqxWY5GRfIKymwQRqSKjlihkKkhfOA3eO/joM8GVhkLewTELq18TdUoCTeHbo3E2rTzuXN90Y7tIiZaaO5qbl/uoPi8F3v5P7HKGj1Q6lyNTLbU5bjnccZ9wbvUkkTZF7wiyrJxehJGVTph9XlG0s0yf4q8PkiviIYs4uIkDWcjUoEVPAf0Bymd76KSfxNBdTNXgRQkyBxkKHuPC6UwfI6jjlAV5TvaHcXr51R06oWMnTcq3DeIyB2A95qLgMZx+8b8ymWX5A2wsFo182xrVk9Fhqfjz/6IhZWzpS/ovLobLzyVMPXhWkmsQ9g6lL9ywktnJQDQmC0Y7Fr/EDEyE5LfQjMtAx1Gxdmi6DnGFpJa2VsevUyDa1y/Hk6u7H1FPjdAPugUjbRoWQ3ND3SI1buedaKynsYtVdS11xt09Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:26:41.6995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 017bd3ad-4dec-474d-27dc-08de7de7e219
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6121
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

From: Likun Gao <Likun.Gao@amd.com>

Retire some unsupport CP command bit set for gfx v12_1.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 6f2240f0ac524..1a7ccfed8f0ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -136,7 +136,6 @@ static void gfx_v12_1_kiq_map_queues(struct amdgpu_ring *kiq_ring,
 			  PACKET3_MAP_QUEUES_PIPE(ring->pipe) |
 			  PACKET3_MAP_QUEUES_ME((me)) |
 			  PACKET3_MAP_QUEUES_QUEUE_TYPE(0) | /*queue_type: normal compute queue */
-			  PACKET3_MAP_QUEUES_ALLOC_FORMAT(0) | /* alloc format: all_on_one_pipe */
 			  PACKET3_MAP_QUEUES_ENGINE_SEL(eng_sel) |
 			  PACKET3_MAP_QUEUES_NUM_QUEUES(1)); /* num_queues: must be 1 */
 	amdgpu_ring_write(kiq_ring, PACKET3_MAP_QUEUES_DOORBELL_OFFSET(ring->doorbell_index));
@@ -245,8 +244,7 @@ static void gfx_v12_1_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
 			  /* memory (1) or register (0) */
 			  (WAIT_REG_MEM_MEM_SPACE(mem_space) |
 			   WAIT_REG_MEM_OPERATION(opt) | /* wait */
-			   WAIT_REG_MEM_FUNCTION(3) |  /* equal */
-			   WAIT_REG_MEM_ENGINE(eng_sel)));
+			   WAIT_REG_MEM_FUNCTION(3)));  /* equal */
 
 	if (mem_space)
 		BUG_ON(addr0 & 0x3); /* Dword align */
@@ -3412,11 +3410,10 @@ static void gfx_v12_1_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 
 static void gfx_v12_1_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 {
-	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
 	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
-	gfx_v12_1_wait_reg_mem(ring, usepfp, 1, 0, lower_32_bits(addr),
+	gfx_v12_1_wait_reg_mem(ring, 0, 1, 0, lower_32_bits(addr),
 			       upper_32_bits(addr), seq, 0xffffffff, 4);
 }
 
@@ -3455,8 +3452,7 @@ static void gfx_v12_1_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
 
 	/* write fence seq to the "addr" */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
-	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
-				 WRITE_DATA_DST_SEL(5) | WR_CONFIRM));
+	amdgpu_ring_write(ring, (WRITE_DATA_DST_SEL(5) | WR_CONFIRM));
 	amdgpu_ring_write(ring, lower_32_bits(addr));
 	amdgpu_ring_write(ring, upper_32_bits(addr));
 	amdgpu_ring_write(ring, lower_32_bits(seq));
@@ -3464,8 +3460,7 @@ static void gfx_v12_1_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
 	if (flags & AMDGPU_FENCE_FLAG_INT) {
 		/* set register to trigger INT */
 		amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
-		amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
-					 WRITE_DATA_DST_SEL(0) | WR_CONFIRM));
+		amdgpu_ring_write(ring, (WRITE_DATA_DST_SEL(0) | WR_CONFIRM));
 		amdgpu_ring_write(ring, SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regCPC_INT_STATUS));
 		amdgpu_ring_write(ring, 0);
 		amdgpu_ring_write(ring, 0x20000000); /* src_id is 178 */
@@ -3524,9 +3519,7 @@ static void gfx_v12_1_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 						   uint32_t reg0, uint32_t reg1,
 						   uint32_t ref, uint32_t mask)
 {
-	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
-
-	gfx_v12_1_wait_reg_mem(ring, usepfp, 0, 1, reg0, reg1,
+	gfx_v12_1_wait_reg_mem(ring, 0, 0, 1, reg0, reg1,
 			       ref, mask, 0x20);
 }
 
-- 
2.53.0

