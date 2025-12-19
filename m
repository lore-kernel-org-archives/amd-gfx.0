Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C28E66884
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 18:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBFB210F066;
	Fri, 19 Dec 2025 18:22:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G2EMOkP5";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011000.outbound.protection.outlook.com [52.101.52.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DA8E10E3D5
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 18:22:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMK3LNDvnb9oGkRpkZJ8TCsvp4x1vGPSx74y4zFE7iJ267kMXFeYZyAMpEAQNv1AJXOrtBlFgeON2JPCfdwSbg9kGshMEAlJgg/+pY3kG0UXivLbCYdJ3nKy8QkrNqnJqWmUOAULGGOZFb4ByNCx7LVd+3WlE7Kn1HYAHozLJNnC0cTd7iyygnAumZf+13iKWspmKzXonaGj9RKf/95qzEJjEppPsVN9qAr+nWcjkLSYICDABRaUkVS3r9o2uKZwa7TSe9FA+VnZvNPh7fzxZcjRD+QNDafjX8oqpz5QA96Rvyv8Cx0oCyDdeeHdTszRCb9qbgIRTJZJW2mpKgDGig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AM35sGBzI9OEfmIS5+5b09TAAnfsQJOIKFQ5ZK28ZA=;
 b=PLSbMm8YcYFSc6Q6JykyuigfWFlViuf5BhmsVy5Kqf6VvVEJ3ns83QCrjwRSqipT1MLCpbjt2WyuG3RTOMetkBFRBKnGQkLWTZhv6OYZoCEu8plSg7+uGEMEUjUNZdZInwYT8L/DoPM5edjqvwLofKSUH350hmWTROLfS/wNyYy/K5MqQEiIFD/WOH+xz/wxfyshzr8pXwuElP4yTgu9gtpMUqBwJwm16Y7QSonk3hblL5sp4VewV2UW+FuxdbEN2y67rPbcPIRnBwquYCZKL6JWLYpHDKfjyDkxUWHRArGp7C1qiEOCeJ7/L1d7tdt4/nruYUg1bbx6KXNRPcT0iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AM35sGBzI9OEfmIS5+5b09TAAnfsQJOIKFQ5ZK28ZA=;
 b=G2EMOkP5xEPw3u076xH8BmyJsT7ymTkBeczoBh2Hm4v6GX+Ii0V/lS6h1ezik88PmVlFtaV46CUrQnt4svmmYVEP7RkeReGsoDW4T9bWSbq5feDnLXG4sw7WTBaNjbak9tKiH63wxiZKPV7xHI/rxebx7nuYK2x6BMgRuAX4vx0=
Received: from CY8PR19CA0036.namprd19.prod.outlook.com (2603:10b6:930:6::29)
 by LV8PR12MB9417.namprd12.prod.outlook.com (2603:10b6:408:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 18:22:30 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:6:cafe::d5) by CY8PR19CA0036.outlook.office365.com
 (2603:10b6:930:6::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.9 via Frontend Transport; Fri,
 19 Dec 2025 18:22:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Fri, 19 Dec 2025 18:22:29 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 19 Dec
 2025 12:22:13 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/5] drm/amdgpu/gfx9: rework pipeline sync packet sequence
Date: Fri, 19 Dec 2025 13:21:59 -0500
Message-ID: <20251219182201.5722-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219182201.5722-1-alexander.deucher@amd.com>
References: <20251219182201.5722-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|LV8PR12MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: a30d7ab0-e3ed-491e-7d05-08de3f2b91eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JauYMIP24zXqFbaycHJqHfTrlb01GqF9gEV3Obzcb9NqcHeHDEfNqQydYbqb?=
 =?us-ascii?Q?Gf3UD90FJeAP7SwfvQQhwzJ5xDA9I7+Y3/GBw49dB0iizcG5Fkp1kSTZDsup?=
 =?us-ascii?Q?g35NmZk5wyEJ2DevGfZNlNFGJLa7SIfeoDqX0MBRPKt1oSciPo7GR8F21lMT?=
 =?us-ascii?Q?1/aI6YvyYOQJjq3tl7ys643Gq/bbfV/eMhtaHplIleAtYY6bYYcSg8AoQqIm?=
 =?us-ascii?Q?NJDvmh33ZTZPDfaAr+xihtiu+zOOGbINCz3R5aCZ31gObFMEuWUK4rKOOqHx?=
 =?us-ascii?Q?W8sFyIWXYiwPWUORGJpySjF8q2zAEFJM6c60UJnA/StuFX5eM9exzwIzi6X6?=
 =?us-ascii?Q?CXYhOnIOmht+RKdMKlL6+3kpShkmfZWOaIRXfMmsjsqmLPBqTjz26VBZtSuI?=
 =?us-ascii?Q?ZrR1qbPidBPp0IRFGr3HXz1wgqXhRnhIW2zS/b+SHRGSLpDsJ90fpAwGeflk?=
 =?us-ascii?Q?wbAi5i6A2dlx0sZi6DkS7sluW/1C28ojGWugq3e14gYwkZUMazSvWE5n5QzO?=
 =?us-ascii?Q?Y4nqUs+PPc8vj+l7pHiQOWNQJIL6rYzPAqnytifcAmWBJro9LeMtcSqwiFNr?=
 =?us-ascii?Q?dhBX9r3qdOMPku0RiDcPU2KPc50kLdNURGXcpfvXo6xU4cwwM20Pt2bA+oxW?=
 =?us-ascii?Q?SAq+1mY16kSZsqPKVrwSAGrT2pDb8HwnZHQtqoYOA8o3dLDbKb4+2kumWIPf?=
 =?us-ascii?Q?XFmNxhCQOSiO6+btfvLPnX7mI2li8RMgP2K1PD5lY9U8uFm5gZt72aeldvZG?=
 =?us-ascii?Q?5e91SJbFNO19hFr4EGVq5C1jOWrCBeS9Hm0COX8mm/bLJH2KiGFkyet9AU9A?=
 =?us-ascii?Q?8kw8KeOODeaTO60XZAkzZ6KIOJICjacBbeb7rEl/bbfVB+FyvpNlBawGEV63?=
 =?us-ascii?Q?ztz+05KVsOrV2Ge7w0v3Ebv79YEO+l+gFhE1hVQ6F4Xm0DF3JWVtsXSQQL3q?=
 =?us-ascii?Q?FizKt0hvmNnRdVq8zas67bSe+1JKLCZp/eGKYs3NEA9Cvm3N+gevruZ8w008?=
 =?us-ascii?Q?jo94q5H0I8gL/dksaAnftW81gDGnSsgCEGhsyao2hek7vqicjS4ev0Hw1wVU?=
 =?us-ascii?Q?q7ZNMNu2A+wT1XvpcE/DPQfuAfp7NnQzR4cWagUAns4+sUcWk/hhsr3BEUzs?=
 =?us-ascii?Q?FFxv+ryFNJAsRpZOmQT4Vrth8YpviAF+H22AaTjqg1QQT7acG76wdDJ/Pcsm?=
 =?us-ascii?Q?yEdsGEsw6feIGttLY4822zx0h0aFTwJp+m6UkLBV5WsxQMEdVjPFEKLjn2RI?=
 =?us-ascii?Q?LdFLJsgtN/dOPSUZ56kt+9pSoyNHHWTWUENkgEO++Fd0R6tzeSKbBJFG+7sF?=
 =?us-ascii?Q?nYzWmdjDIYGAeuQ0040daxBZFWLU0U9wscUs1r5yVG9z8teA9pMBN9GSMoJe?=
 =?us-ascii?Q?9fQudiBoCB3rUelTxxjk+HJieH1HLu/Lvp5NftvXMFspFHhQO9DCFZoHrb1i?=
 =?us-ascii?Q?xQghdJ1KQ26hrj80KSslecgsIR7jxEeCGZyMBmr8K12i2nZGt6N+b2mm1Mtz?=
 =?us-ascii?Q?m9zHw6zVX6LLV+P/kUr/ARgUNaNPJisWzpcRo6hZkycgCqZmG8GNQga//Q91?=
 =?us-ascii?Q?v+iLJNieDzwhqrD+e/s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 18:22:29.6586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a30d7ab0-e3ed-491e-7d05-08de3f2b91eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9417
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
shader types and ACQUIRE_MEM.  That should accomplish
the same thing and avoid having to wait on a fence
preventing any issues with pipeline syncs during
queue resets.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 67 +++++++++++++++------------
 1 file changed, 37 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 7b012ca1153ea..0d8e797d59b8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5572,15 +5572,42 @@ static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
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
+
+static void gfx_v9_0_emit_mem_sync(struct amdgpu_ring *ring)
+{
+	const unsigned int cp_coher_cntl =
+			PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_ICACHE_ACTION_ENA(1) |
+			PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_KCACHE_ACTION_ENA(1) |
+			PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_ACTION_ENA(1) |
+			PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TCL1_ACTION_ENA(1) |
+			PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_WB_ACTION_ENA(1);
 
-	gfx_v9_0_wait_reg_mem(ring, usepfp, 1, 0,
-			      lower_32_bits(addr), upper_32_bits(addr),
-			      seq, 0xffffffff, 4);
+	/* ACQUIRE_MEM -make one or more surfaces valid for use by the subsequent operations */
+	amdgpu_ring_write(ring, PACKET3(PACKET3_ACQUIRE_MEM, 5));
+	amdgpu_ring_write(ring, cp_coher_cntl); /* CP_COHER_CNTL */
+	amdgpu_ring_write(ring, 0xffffffff);  /* CP_COHER_SIZE */
+	amdgpu_ring_write(ring, 0xffffff);  /* CP_COHER_SIZE_HI */
+	amdgpu_ring_write(ring, 0); /* CP_COHER_BASE */
+	amdgpu_ring_write(ring, 0);  /* CP_COHER_BASE_HI */
+	amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */
+}
+
+static void gfx_v9_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+{
+	if (ring->funcs->type == AMDGPU_RING_TYPE_GFX) {
+		gfx_v9_0_ring_emit_event_write(ring, VS_PARTIAL_FLUSH, 4);
+		gfx_v9_0_ring_emit_event_write(ring, PS_PARTIAL_FLUSH, 4);
+	}
+	gfx_v9_0_ring_emit_event_write(ring, CS_PARTIAL_FLUSH, 4);
+	gfx_v9_0_emit_mem_sync(ring);
 }
 
 static void gfx_v9_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
@@ -7071,25 +7098,6 @@ static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 	gfx_v9_0_query_utc_edc_status(adev, err_data);
 }
 
-static void gfx_v9_0_emit_mem_sync(struct amdgpu_ring *ring)
-{
-	const unsigned int cp_coher_cntl =
-			PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_ICACHE_ACTION_ENA(1) |
-			PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_KCACHE_ACTION_ENA(1) |
-			PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_ACTION_ENA(1) |
-			PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TCL1_ACTION_ENA(1) |
-			PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_WB_ACTION_ENA(1);
-
-	/* ACQUIRE_MEM -make one or more surfaces valid for use by the subsequent operations */
-	amdgpu_ring_write(ring, PACKET3(PACKET3_ACQUIRE_MEM, 5));
-	amdgpu_ring_write(ring, cp_coher_cntl); /* CP_COHER_CNTL */
-	amdgpu_ring_write(ring, 0xffffffff);  /* CP_COHER_SIZE */
-	amdgpu_ring_write(ring, 0xffffff);  /* CP_COHER_SIZE_HI */
-	amdgpu_ring_write(ring, 0); /* CP_COHER_BASE */
-	amdgpu_ring_write(ring, 0);  /* CP_COHER_BASE_HI */
-	amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */
-}
-
 static void gfx_v9_0_emit_wave_limit_cs(struct amdgpu_ring *ring,
 					uint32_t pipe, bool enable)
 {
@@ -7404,7 +7412,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.set_wptr = gfx_v9_0_ring_set_wptr_gfx,
 	.emit_frame_size = /* totally 242 maximum if 16 IBs */
 		5 +  /* COND_EXEC */
-		7 +  /* PIPELINE_SYNC */
+		13 +  /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		2 + /* VM_FLUSH */
@@ -7460,7 +7468,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
 	.set_wptr = amdgpu_sw_ring_set_wptr_gfx,
 	.emit_frame_size = /* totally 242 maximum if 16 IBs */
 		5 +  /* COND_EXEC */
-		7 +  /* PIPELINE_SYNC */
+		13 +  /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		2 + /* VM_FLUSH */
@@ -7521,7 +7529,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 		20 + /* gfx_v9_0_ring_emit_gds_switch */
 		7 + /* gfx_v9_0_ring_emit_hdp_flush */
 		5 + /* hdp invalidate */
-		7 + /* gfx_v9_0_ring_emit_pipeline_sync */
+		9 + /* gfx_v9_0_ring_emit_pipeline_sync */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user fence, vm fence */
@@ -7564,7 +7572,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
 		20 + /* gfx_v9_0_ring_emit_gds_switch */
 		7 + /* gfx_v9_0_ring_emit_hdp_flush */
 		5 + /* hdp invalidate */
-		7 + /* gfx_v9_0_ring_emit_pipeline_sync */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		8 + 8 + 8, /* gfx_v9_0_ring_emit_fence_kiq x3 for user fence, vm fence */
-- 
2.52.0

