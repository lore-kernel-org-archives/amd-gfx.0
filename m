Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16779F94CC1
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 21:51:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 974CA10EAA5;
	Wed, 22 Apr 2026 21:51:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wVb6FO06";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013015.outbound.protection.outlook.com
 [40.107.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7110210EAA5
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 21:51:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNNdNlQPWb/EQetIEJfTeafHeeBPrZH2+QflLiHsatyxVCsn4OZ4ixQXUP1Dp55L2GEZfKBKGMxq4naCttYfuACIzbmPrAJ5F6vfzUafPp27L/G9t+uJZq8kYWsWWmVrDwEn4dsHTKki9UP3ZHGgNsE40kAVepKiJXpWc9Qm6DqnHxqUOX9CwAAcVIWmiNFZX7WrMO94QSRSFCFB4I4iO48BSCpHLACiaSA/FouvD3VYctNwj/0rKJoUwPFsc4lwNzGLiirnJNcIrSeB/W35grWZdHPuBwknjv5lyZChV74tPNt8QuzrLbyqtgzrHIZ6E2oJmM2V8TISvgLpOrRjxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSuSQkWdIaTd4aUHdHG/dl8Q1fyNCWv5syIWt6hCaP0=;
 b=Ol8ZwdzlEd7J0QB3ObMKuFuiaeNw1wLI3qHZ1GrZJPjUQ+nUziU1UbCIbXur0JNTAWFmPN6wAt6JPrOZIhyZasICxWFa1jgYTnyRTJ5MTIwgr60sayHEJNq6Myp+k2zsf23pNqCLQdnWn91n4TkDqmD7l6alwI5taDDXALj/GrIPCIQf3iVVv0T8E/UjTiwKVzw+daZJfp8psa7GYXvyNn/Ds5h9+IDuvqLDU8WMaFDwLKPSMPQ4t/uj+kw2qHJk4F05+BxZ5+VuSfecbhVbo0UdBIb0fCSSnrJ5bHnXM/T0c9n3qu+7SLViPmz5tbpn6yW3yAv8GdzhczxT/2MN0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSuSQkWdIaTd4aUHdHG/dl8Q1fyNCWv5syIWt6hCaP0=;
 b=wVb6FO06qh8oM5tEt8Brtn2ZMCKW4nobsiA4zLAOWcD5VI4qf5Y9TVi0naODrUnh10zB0Ml4ME4m0LS/EGLXEw7WDNqAkfC5AoVU3IArKxaj4m8QyV5jxlbShMvzE9WQIC4SapeZZJkhecD8Wf077y/ZB26yJDjfKx4aTYTTjAo=
Received: from BN9PR03CA0225.namprd03.prod.outlook.com (2603:10b6:408:f8::20)
 by MN0PR12MB6001.namprd12.prod.outlook.com (2603:10b6:208:37d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 21:51:02 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:f8:cafe::c9) by BN9PR03CA0225.outlook.office365.com
 (2603:10b6:408:f8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 21:51:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 21:51:02 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 16:51:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 16:51:01 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Apr 2026 16:51:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: update cp cmd pkt for gfx v12_1
Date: Wed, 22 Apr 2026 17:50:33 -0400
Message-ID: <20260422215035.2242622-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|MN0PR12MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: cb710ad6-5389-4d7f-72d1-08dea0b93f41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: EMO9NY/0W6YAzzzVV2pUsbupYjEOF5aXGgvngee1cEg1dzBhkoGRwTT6h7TgqVvEMpBmGZhGOtRMdeKQ2UcFYWjYY71U0Xvc9OT3sZW6gKYuUjOP28pHykn9RjhK1tKgZ/C949dqIj47NSzDpVSvl3np739fR1/ujpoCy+Z+khPhylPczhTBDQ/W4J3/cYMp5k2oC5We85037kzCEEndoGpDV/SApt5WeACEXJ46kxrapa2khAEHK7GVTj8ounJSaMESsYGsAJOjkB6haswKF8ef6Y/8DcrEIrMHw/prCTOCTpG4YKneGF6IvUysuD4IZIYol5kOGFAW6lFVvRDAjPqkEezQ2xdf4IKJtYDzrFq+UKFedV4EGSC1hTqm7biO9Cmye8zBkedOCSyZCQ13k4v5A0YtapAFIi2k/W2pcjOeZQyK+X2bRSOWNf7dGp1y+SfeeQ/tyKtAM4uRob8TUsjBTjd4FWnrcuUhitAlHfEzCe3Xz8V4NVsGhWyuiojzrT3SW0dylAZPFydUiDCtfqSAtbLcBRxdHrZ8KUYyuguVxkdBRLqYN1kCcH35xTqVmTacfj2Q9YM6GHePLt9mXCRcrhmp0JwwM73KVUjGiDbs+GlbFVCv1/3U3bQNlpv5gPdsUd64xet3aWQU9qyTV+buE2qNyZ67eZ4wAiJgY0t0xTc1NHU0XhSIiJC28UgpvWJjbHGkhgUwUopz0A+YACZfMjkPr0A4UTD/R313puhY1qOhpDCpp5sylb4sgVOhBwf9MhWen5Ghqa5qXPpYFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rHNfj7bUJYIXo9iCOGqObJCYbn29Uhd17P4PsGdKt9K/If0NDKoy/+auSIYN1y1idusUJ1SMlK1ZPyjdYOoWkA9Km4h1wlYX3gNfk2tbU7uIMU/luUgYAwl90ThSMNS0asRcORXg8PrPtgiF7MOfdrH3ZY3cZ+YRrJB97d135y1kidN/mp9hg76FtQOZJNj9hdrpUdtw2i79C2IGnJreVVzT24arHiGJysjJvWvL531f5j6IZsDIJbsOwKsfQiuax3GW1pODg3E2wqi0VgwOHk7GJad4zqVZ2997Y9lybD47Er3OO5qO4/UYVLRyfWsWpNOneGy9TmcP3hpaWsA9CW3eR9FTyn6c2jCnJYx/2N2i9CSxKQN9a7rUp3NpxPg+njyiRo465/zaHeVOxHVE9w+i/rhD6P5wd113HLddOBmV1SLcATe0YgU5JvtI4x2M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 21:51:02.3438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb710ad6-5389-4d7f-72d1-08dea0b93f41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6001
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

Update CP command package for gfx v12.1.

v2: squash in update (Alex)

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     |  34 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h | 347 +++++++++++++++------
 2 files changed, 273 insertions(+), 108 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 948758b51b5cc..f4089ab108474 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -243,9 +243,9 @@ static void gfx_v12_1_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
 	amdgpu_ring_write(ring,
 			  /* memory (1) or register (0) */
-			  (WAIT_REG_MEM_MEM_SPACE(mem_space) |
-			   WAIT_REG_MEM_OPERATION(opt) | /* wait */
-			   WAIT_REG_MEM_FUNCTION(3)));  /* equal */
+			  (PACKET3_WAIT_REG_MEM__MEM_SPACE(mem_space) |
+			   PACKET3_WAIT_REG_MEM__OPERATION(opt) | /* wait */
+			   PACKET3_WAIT_REG_MEM__FUNCTION(3)));  /* equal */
 
 	if (mem_space)
 		BUG_ON(addr0 & 0x3); /* Dword align */
@@ -335,7 +335,7 @@ static int gfx_v12_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	}
 
 	ib.ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
-	ib.ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
+	ib.ptr[1] = PACKET3_WRITE_DATA__DST_SEL(5) | PACKET3_WRITE_DATA__WR_CONFIRM(1);
 	ib.ptr[2] = lower_32_bits(gpu_addr);
 	ib.ptr[3] = upper_32_bits(gpu_addr);
 	ib.ptr[4] = 0xDEADBEEF;
@@ -3366,7 +3366,7 @@ static void gfx_v12_1_ring_emit_ib_compute(struct amdgpu_ring *ring,
 					   uint32_t flags)
 {
 	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
-	u32 control = INDIRECT_BUFFER_VALID | ib->length_dw | (vmid << 24);
+	u32 control = PACKET3_INDIRECT_BUFFER__VALID(1) | ib->length_dw | (vmid << 24);
 
 	/* Currently, there is a high possibility to get wave ID mismatch
 	 * between ME and GDS, leading to a hw deadlock, because ME generates
@@ -3402,15 +3402,15 @@ static void gfx_v12_1_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 
 	/* RELEASE_MEM - flush caches, send int */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE_MEM, 6));
-	amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM_GCR_SEQ(1) |
-				 PACKET3_RELEASE_MEM_GCR_GLV_WB |
-				 PACKET3_RELEASE_MEM_GCR_GL2_WB |
-				 PACKET3_RELEASE_MEM_GCR_GL2_SCOPE(2) |
-				 PACKET3_RELEASE_MEM_TEMPORAL(3) |
-				 PACKET3_RELEASE_MEM_EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
-				 PACKET3_RELEASE_MEM_EVENT_INDEX(5)));
-	amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM_DATA_SEL(write64bit ? 2 : 1) |
-				 PACKET3_RELEASE_MEM_INT_SEL(int_sel ? 2 : 0)));
+	amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM__GCR_SEQ(1) |
+				 PACKET3_RELEASE_MEM__GCR_GLV_WB |
+				 PACKET3_RELEASE_MEM__GCR_GL2_WB |
+				 PACKET3_RELEASE_MEM__GCR_GL2_SCOPE(2) |
+				 PACKET3_RELEASE_MEM__TEMPORAL(3) |
+				 PACKET3_RELEASE_MEM__EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
+				 PACKET3_RELEASE_MEM__EVENT_INDEX(5)));
+	amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM__DATA_SEL(write64bit ? 2 : 1) |
+				 PACKET3_RELEASE_MEM__INT_SEL(int_sel ? 2 : 0)));
 
 	/*
 	 * the address should be Qword aligned if 64bit write, Dword
@@ -3471,7 +3471,7 @@ static void gfx_v12_1_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
 
 	/* write fence seq to the "addr" */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
-	amdgpu_ring_write(ring, (WRITE_DATA_DST_SEL(5) | WR_CONFIRM));
+	amdgpu_ring_write(ring, (PACKET3_WRITE_DATA__DST_SEL(5) | PACKET3_WRITE_DATA__WR_CONFIRM(1)));
 	amdgpu_ring_write(ring, lower_32_bits(addr));
 	amdgpu_ring_write(ring, upper_32_bits(addr));
 	amdgpu_ring_write(ring, lower_32_bits(seq));
@@ -3479,7 +3479,7 @@ static void gfx_v12_1_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
 	if (flags & AMDGPU_FENCE_FLAG_INT) {
 		/* set register to trigger INT */
 		amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
-		amdgpu_ring_write(ring, (WRITE_DATA_DST_SEL(0) | WR_CONFIRM));
+		amdgpu_ring_write(ring, (PACKET3_WRITE_DATA__DST_SEL(0) | PACKET3_WRITE_DATA__WR_CONFIRM(1)));
 		amdgpu_ring_write(ring, SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regCPC_INT_STATUS));
 		amdgpu_ring_write(ring, 0);
 		amdgpu_ring_write(ring, 0x20000000); /* src_id is 178 */
@@ -3518,7 +3518,7 @@ static void gfx_v12_1_ring_emit_wreg(struct amdgpu_ring *ring,
 		cmd = (1 << 16); /* no inc addr */
 		break;
 	default:
-		cmd = WR_CONFIRM;
+		cmd = PACKET3_WRITE_DATA__WR_CONFIRM(1);
 		break;
 	}
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h
index df0ada0b56d1d..77b4f6ea532f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h
@@ -58,6 +58,29 @@
 #define	PACKET3_DISPATCH_DIRECT				0x15
 #define	PACKET3_DISPATCH_INDIRECT			0x16
 #define	PACKET3_ATOMIC_MEM				0x1E
+#define 	PACKET3_ATOMIC_MEM__ATOMIC(x) ((((unsigned)(x)) & 0x7F) << 0)
+#define 	PACKET3_ATOMIC_MEM__COMMAND(x) ((((unsigned)(x)) & 0xF) << 8)
+#define 	PACKET3_ATOMIC_MEM__SCOPE(x) ((((unsigned)(x)) & 0x3) << 23)
+#define 	PACKET3_ATOMIC_MEM__TEMPORAL(x) ((((unsigned)(x)) & 0x3) << 25)
+#define 	PACKET3_ATOMIC_MEM__ADDR_LO(x) (((unsigned)(x)))
+#define 	PACKET3_ATOMIC_MEM__ADDR_HI(x) (((unsigned)(x)))
+#define 	PACKET3_ATOMIC_MEM__SRC_DATA_LO(x) (((unsigned)(x)))
+#define 	PACKET3_ATOMIC_MEM__SRC_DATA_HI(x) (((unsigned)(x)))
+#define 	PACKET3_ATOMIC_MEM__CMP_DATA_LO(x) (((unsigned)(x)))
+#define 	PACKET3_ATOMIC_MEM__CMP_DATA_HI(x) (((unsigned)(x)))
+#define 	PACKET3_ATOMIC_MEM__LOOP_INTERVAL(x) ((((unsigned)(x)) & 0x1FFF) << 0)
+#define 	PACKET3_ATOMIC_MEM__COMMAND__SINGLE_PASS_ATOMIC 0
+#define 	PACKET3_ATOMIC_MEM__COMMAND__LOOP_UNTIL_COMPARE_SATISFIED 1
+#define 	PACKET3_ATOMIC_MEM__COMMAND__WAIT_FOR_WRITE_CONFIRMATION 2
+#define 	PACKET3_ATOMIC_MEM__COMMAND__SEND_AND_CONTINUE 3
+#define 	PACKET3_ATOMIC_MEM__SCOPE__CU 0
+#define 	PACKET3_ATOMIC_MEM__SCOPE__SE 1
+#define 	PACKET3_ATOMIC_MEM__SCOPE__DEVICE 2
+#define 	PACKET3_ATOMIC_MEM__SCOPE__SYSTEM 3
+#define 	PACKET3_ATOMIC_MEM__TEMPORAL__RT 0
+#define 	PACKET3_ATOMIC_MEM__TEMPORAL__NT 1
+#define 	PACKET3_ATOMIC_MEM__TEMPORAL__FW 2
+#define 	PACKET3_ATOMIC_MEM__TEMPORAL__UC 3
 #define	PACKET3_OCCLUSION_QUERY				0x1F
 #define	PACKET3_SET_PREDICATION				0x20
 #define	PACKET3_REG_RMW					0x21
@@ -76,7 +99,11 @@
 #define	PACKET3_DRAW_INDEX_MULTI_AUTO			0x30
 #define	PACKET3_DRAW_INDEX_OFFSET_2			0x35
 #define	PACKET3_WRITE_DATA				0x37
-#define		WRITE_DATA_DST_SEL(x)                   (((x) & 0xf) << 8)
+#define 	PACKET3_WRITE_DATA__DST_SEL(x) ((((unsigned)(x)) & 0xF) << 8)
+#define 	PACKET3_WRITE_DATA__DST_SEL__MEM_MAPPED_REGISTER 0
+#define 	PACKET3_WRITE_DATA__DST_SEL__TC_L2 2
+#define 	PACKET3_WRITE_DATA__DST_SEL__MEMORY 5
+#define 	PACKET3_WRITE_DATA__DST_SEL__MEMORY_MAPPED_ADC_PERSISTENT_STATE 6
 		/* 0 - register
 		 * 1 - reserved
 		 * 2 - tc_l2
@@ -85,27 +112,52 @@
 		 * 5 - memory (same as tc_l2)
          * 6 - memory_mapped_adc_persistent_state
 		 */
-#define		WRITE_DATA_SCOPE(x)                     (((x) & 0x3) << 12)
-#define		WRITE_DATA_MODE(x)                      (((x) & 0x3) << 14)
+#define 	PACKET3_WRITE_DATA__SCOPE(x)   ((((unsigned)(x)) & 0x3) << 12)
+#define 	PACKET3_WRITE_DATA__SCOPE__CU 0
+#define 	PACKET3_WRITE_DATA__SCOPE__SE 1
+#define 	PACKET3_WRITE_DATA__SCOPE__DEVICE 2
+#define 	PACKET3_WRITE_DATA__SCOPE__SYSTEM 3
+#define 	PACKET3_WRITE_DATA__MODE(x)    ((((unsigned)(x)) & 0x3) << 14)
+#define 	PACKET3_WRITE_DATA__MODE__LOCAL_XCD 0
+#define 	PACKET3_WRITE_DATA__MODE__REMOTE_OR_LOCAL_AID 1
+#define 	PACKET3_WRITE_DATA__MODE__REMOTE_XCD 2
+#define 	PACKET3_WRITE_DATA__MODE__REMOTE_MID 3
         /* 0 - local xcd
          * 1 - remote/local aid
          * 2 - remote xcd
          * 3 - remote mid
          */
-#define		WRITE_DATA_ADDR_INCR                    (1 << 16)
-#define		WRITE_DATA_MID_DIE_ID(x)                (((x) & 0x3) << 18)
-#define		WR_CONFIRM                              (1 << 20)
-#define		WRITE_DATA_XCD_DIE_ID(x)                (((x) & 0xf) << 21)
-#define		WRITE_DATA_TEMPORAL(x)                  (((x) & 0x3) << 25)
-		/* 0 - rt
-		 * 1 - nt
-         * 2 - ht
-         * 3 - lu
-		 */
-#define		WRITE_DATA_COOP_DISABLE                 (1 << 27)
+#define 	PACKET3_WRITE_DATA__ADDR_INCR(x)  ((((unsigned)(x)) & 0x1) << 16)
+#define 	PACKET3_WRITE_DATA__ADDR_INCR__INCREMENT_ADDRESS 0
+#define 	PACKET3_WRITE_DATA__ADDR_INCR__DO_NOT_INCREMENT_ADDRESS 1
+#define 	PACKET3_WRITE_DATA__MID_DIE_ID(x)       ((((unsigned)(x)) & 0x3) << 18)
+#define 	PACKET3_WRITE_DATA__WR_CONFIRM(x) ((((unsigned)(x)) & 0x1) << 20)
+#define 	PACKET3_WRITE_DATA__WR_CONFIRM__DO_NOT_WAIT_FOR_WRITE_CONFIRMATION 0
+#define 	PACKET3_WRITE_DATA__WR_CONFIRM__WAIT_FOR_WRITE_CONFIRMATION 1
+#define 	PACKET3_WRITE_DATA__XCD_DIE_ID(x) ((((unsigned)(x)) & 0xF) << 21)
+#define 	PACKET3_WRITE_DATA__TEMPORAL(x) ((((unsigned)(x)) & 0x3) << 25)
+#define 	PACKET3_WRITE_DATA__TEMPORAL__RT 0
+#define 	PACKET3_WRITE_DATA__TEMPORAL__NT 1
+#define 	PACKET3_WRITE_DATA__TEMPORAL__HT 2
+#define 	PACKET3_WRITE_DATA__TEMPORAL__LU 3
+#define 	PACKET3_WRITE_DATA__COOP_DISABLE(x)  ((((unsigned)(x)) & 0x1) << 27)
+#define 	PACKET3_WRITE_DATA__COOP_DISABLE__MASTER_AND_SLAVE_COOP 0
+#define 	PACKET3_WRITE_DATA__COOP_DISABLE__MASTER_ONLY 1
+#define 	PACKET3_WRITE_DATA__DST_MMREG_ADDR_LO(x) ((unsigned)(x))
+#define 	PACKET3_WRITE_DATA__DST_MEM_ADDR_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
+#define 	PACKET3_WRITE_DATA__DST_MMREG_ADDR_HI(x) ((((unsigned)(x)) & 0x3FFF) << 0)
+#define 	PACKET3_WRITE_DATA__DST_MEM_ADDR_HI(x) ((unsigned)(x))
+#define 	PACKET3_WRITE_DATA__DATA(x) ((unsigned)(x))
 #define	PACKET3_DRAW_INDEX_INDIRECT_MULTI		0x38
 #define	PACKET3_WAIT_REG_MEM				0x3C
-#define		WAIT_REG_MEM_FUNCTION(x)                (((x) & 0x7) << 0)
+#define		PACKET3_WAIT_REG_MEM__FUNCTION(x) ((((unsigned)(x)) & 0x7) << 0)
+#define		PACKET3_WAIT_REG_MEM__FUNCTION__ALWAYS_PASS 0
+#define		PACKET3_WAIT_REG_MEM__FUNCTION__LESS_THAN_REF_VALUE 1
+#define		PACKET3_WAIT_REG_MEM__FUNCTION__LESS_THAN_EQUAL_TO_THE_REF_VALUE 2
+#define		PACKET3_WAIT_REG_MEM__FUNCTION__EQUAL_TO_THE_REFERENCE_VALUE 3
+#define		PACKET3_WAIT_REG_MEM__FUNCTION__NOT_EQUAL_REFERENCE_VALUE 4
+#define		PACKET3_WAIT_REG_MEM__FUNCTION__GREATER_THAN_OR_EQUAL_REFERENCE_VALUE 5
+#define		PACKET3_WAIT_REG_MEM__FUNCTION__GREATER_THAN_REFERENCE_VALUE 6
 		/* 0 - always
 		 * 1 - <
 		 * 2 - <=
@@ -114,117 +166,222 @@
 		 * 5 - >=
 		 * 6 - >
 		 */
-#define		WAIT_REG_MEM_MEM_SPACE(x)               (((x) & 0x3) << 4)
+#define 	PACKET3_WAIT_REG_MEM__MEM_SPACE(x) ((((unsigned)(x)) & 0x3) << 4)
+#define 	PACKET3_WAIT_REG_MEM__MEM_SPACE__REGISTER_SPACE 0
+#define 	PACKET3_WAIT_REG_MEM__MEM_SPACE__MEMORY_SPACE 1
 		/* 0 - reg
 		 * 1 - mem
 		 */
-#define		WAIT_REG_MEM_OPERATION(x)               (((x) & 0x3) << 6)
+#define		PACKET3_WAIT_REG_MEM__OPERATION(x) ((((unsigned)(x)) & 0x3) << 6)
+#define 	PACKET3_WAIT_REG_MEM__OPERATION__WAIT_REG_MEM 0
+#define 	PACKET3_WAIT_REG_MEM__OPERATION__WR_WAIT_WR_REG 1
+#define 	PACKET3_WAIT_REG_MEM__OPERATION__WAIT_MEM_PREEMPTABLE 3
 		/* 0 - wait_reg_mem
 		 * 1 - wr_wait_wr_reg
+		 * 2 - reserved
+		 * 3 - wait_mem_preemptable
 		 */
-#define		WAIT_REG_MEM_MODE(x)                    (((x) & 0x3) << 10)
+#define		PACKET3_WAIT_REG_MEM__MODE(x)   ((((unsigned)(x)) & 0x3) << 10)
+#define		PACKET3_WAIT_REG_MEM__MODE__LOCAL_XCD   0
+#define		PACKET3_WAIT_REG_MEM__MODE__REMOTE_OR_LOCAL_AID   1
+#define		PACKET3_WAIT_REG_MEM__MODE__REMOTE_XCD   2
+#define		PACKET3_WAIT_REG_MEM__MODE__REMOTE_MID   3
         /* 0 - local xcd
          * 1 - remote/local aid
          * 2 - remote xcd
          * 3 - remote mid
          */
-#define		WAIT_REG_MEM_MID_DIE_ID(x)              (((x) & 0x3) << 12)
-#define		WAIT_REG_MEM_XCD_DIE_ID(x)              (((x) & 0xf) << 14)
-#define		WAIT_REG_MEM_MES_INTR_PIPE(x)           (((x) & 0x3) << 22)
-#define		WAIT_REG_MEM_MES_ACTION(x)              (((x) & 0x1) << 24)
-#define		WAIT_REG_MEM_TEMPORAL(x)                (((x) & 0x3) << 25)
+#define		PACKET3_WAIT_REG_MEM__MID_DIE_ID(x) ((((unsigned)(x)) & 0x3) << 12)
+#define		PACKET3_WAIT_REG_MEM__XCD_DIE_ID(x) ((((unsigned)(x)) & 0xf) << 14)
+#define		PACKET3_WAIT_REG_MEM__MES_INTR_PIPE(x) ((((unsigned)(x)) & 0x3) << 22)
+#define		PACKET3_WAIT_REG_MEM__MES_ACTION(x) ((((unsigned)(x)) & 0x1) << 24)
+#define		PACKET3_WAIT_REG_MEM__TEMPORAL(x)       ((((unsigned)(x)) & 0x3) << 25)
+#define 	PACKET3_WAIT_REG_MEM__TEMPORAL__RT 0
+#define 	PACKET3_WAIT_REG_MEM__TEMPORAL__NT 1
+#define 	PACKET3_WAIT_REG_MEM__TEMPORAL__HT 2
+#define 	PACKET3_WAIT_REG_MEM__TEMPORAL__LU 3
 		/* 0 - rt
 		 * 1 - nt
          * 2 - ht
          * 3 - lu
 		 */
+#define		PACKET3_WAIT_REG_MEM__MEM_POLL_ADDR_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
+#define		PACKET3_WAIT_REG_MEM__REG_POLL_ADDR(x) ((unsigned)(x))
+#define		PACKET3_WAIT_REG_MEM__REG_WRITE_ADDR1(x) ((((unsigned)(x)) & 0x3FFFF) << 0)
+#define		PACKET3_WAIT_REG_MEM__MEM_POLL_ADDR_HI(x) ((unsigned)(x))
+#define		PACKET3_WAIT_REG_MEM__REG_POLL_ADDR_HI(x) ((((unsigned)(x)) & 0x3FFF) << 0)
+#define		PACKET3_WAIT_REG_MEM__REG_WRITE_ADDR2(x) ((((unsigned)(x)) & 0x3FFFF) << 0)
+#define		PACKET3_WAIT_REG_MEM__REFERENCE(x) ((unsigned)(x))
+#define		PACKET3_WAIT_REG_MEM__MASK(x) ((unsigned)(x))
+#define		PACKET3_WAIT_REG_MEM__POLL_INTERVAL(x) ((((unsigned)(x)) & 0xFFFF) << 0)
+#define		PACKET3_WAIT_REG_MEM__OPTIMIZE_ACE_OFFLOAD_MODE(x) ((((unsigned)(x)) & 0x1) << 31)
 #define	PACKET3_INDIRECT_BUFFER				0x3F
-#define		INDIRECT_BUFFER_VALID                   (1 << 23)
-#define		INDIRECT_BUFFER_TEMPORAL(x)             (x) << 28)
-		/* 0 - rt
-		 * 1 - nt
-		 * 2 - ht
-         * 3 - lu
-		 */
+#define 	PACKET3_INDIRECT_BUFFER__IB_BASE_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
+#define 	PACKET3_INDIRECT_BUFFER__IB_BASE_HI(x) ((unsigned)(x))
+#define 	PACKET3_INDIRECT_BUFFER__IB_SIZE(x) ((((unsigned)(x)) & 0xFFFFF) << 0)
+#define 	PACKET3_INDIRECT_BUFFER__CHAIN(x) ((((unsigned)(x)) & 0x1) << 20)
+#define 	PACKET3_INDIRECT_BUFFER__OFFLOAD_POLLING(x) ((((unsigned)(x)) & 0x1) << 21)
+#define 	PACKET3_INDIRECT_BUFFER__VALID(x) ((((unsigned)(x)) & 0x1) << 23)
+#define 	PACKET3_INDIRECT_BUFFER__VMID(x) ((((unsigned)(x)) & 0xF) << 24)
+#define 	PACKET3_INDIRECT_BUFFER__TEMPORAL(x) ((((unsigned)(x)) & 0x3) << 28)
+#define 	PACKET3_INDIRECT_BUFFER__INHERIT_VMID(x) ((((unsigned)(x)) & 0x1) << 30)
+#define 	PACKET3_INDIRECT_BUFFER__PRIV(x) ((((unsigned)(x)) & 0x1) << 31)
+#define 	PACKET3_INDIRECT_BUFFER__TEMPORAL__RT 0
+#define 	PACKET3_INDIRECT_BUFFER__TEMPORAL__NT 1
+#define 	PACKET3_INDIRECT_BUFFER__TEMPORAL__HT 2
+#define 	PACKET3_INDIRECT_BUFFER__TEMPORAL__LU 3
 #define	PACKET3_COND_INDIRECT_BUFFER			0x3F
 #define	PACKET3_COPY_DATA				0x40
-#define		COPY_DATA_SRC_SEL(x)                    (((x) & 0xf) << 0)
-#define		COPY_DATA_DST_SEL(x)                    (((x) & 0xf) << 8)
-#define		COPY_DATA_SRC_SCOPE(x)                  (((x) & 0x3) << 4)
-#define		COPY_DATA_DST_SCOPE(x)                  (((x) & 0x3) << 27)
-#define		COPY_DATA_MODE(x)                       (((x) & 0x3) << 6)
-        /* 0 - local xcd
-         * 1 - remote/local aid
-         * 2 - remote xcd
-         * 3 - remote mid
-         */
-#define		COPY_DATA_SRC_TEMPORAL(x)               (((x) & 0x3) << 13)
-#define		COPY_DATA_DST_TEMPORAL(x)               (((x) & 0x3) << 25)
-		/* 0 - rt
-		 * 1 - nt
-         * 2 - ht
-         * 3 - lu
-		 */
-#define		COPY_DATA_COUNT_SEL                     (1 << 16)
-#define		COPY_DATA_SRC_DST_REMOTE_MODE(x)        (((x)) & 0x1 << 16)
-        /* 0 - src remote
-         * 1 - dst remote
-         */
-#define		COPY_DATA_MID_DIE_ID(x)                 (((x) & 0x3) << 18)
-#define		COPY_DATA_XCD_DIE_ID(x)                 (((x) & 0xf) << 21)
-#define		COPY_DATA_PQ_EXE_STATUS                 (1 << 27)
+#define 	PACKET3_COPY_DATA__SRC_SEL(x) ((((unsigned)(x)) & 0xF) << 0)
+#define		PACKET3_COPY_DATA__SRC_SCOPE(x) ((((unsigned)(x)) & 0x3) << 4)
+#define 	PACKET3_COPY_DATA__MODE(x) ((((unsigned)(x)) & 0x3) << 6)
+#define 	PACKET3_COPY_DATA__DST_SEL(x) ((((unsigned)(x)) & 0xF) << 8)
+#define 	PACKET3_COPY_DATA__SRC_TEMPORAL(x) ((((unsigned)(x)) & 0x3) << 13)
+#define 	PACKET3_COPY_DATA__COUNT_SEL(x) ((((unsigned)(x)) & 0x1) << 16)
+#define 	PACKET3_COPY_DATA__SRC_DST_REMOTE_MODE(x) ((((unsigned)(x)) & 0x1) << 17)
+#define 	PACKET3_COPY_DATA__MID_DIE_ID(x) ((((unsigned)(x)) & 0x3) << 18)
+#define 	PACKET3_COPY_DATA__WR_CONFIRM(x) ((((unsigned)(x)) & 0x1) << 20)
+#define 	PACKET3_COPY_DATA__XCD_DIE_ID(x) ((((unsigned)(x)) & 0xF) << 21)
+#define 	PACKET3_COPY_DATA__DST_TEMPORAL(x) ((((unsigned)(x)) & 0x3) << 25)
+#define		PACKET3_COPY_DATA__DST_SCOPE(x) ((((unsigned)(x)) & 0x3) << 27)
+#define 	PACKET3_COPY_DATA__PQ_EXE_STATUS(x) ((((unsigned)(x)) & 0x1) << 29)
+#define 	PACKET3_COPY_DATA__SRC_REG_OFFSET_LO(x) ((unsigned)(x))
+#define 	PACKET3_COPY_DATA__SRC_32B_ADDR_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
+#define 	PACKET3_COPY_DATA__SRC_64B_ADDR_LO(x) ((((unsigned)(x)) & 0x1FFFFFFF) << 3)
+#define 	PACKET3_COPY_DATA__IMM_DATA(x) ((unsigned)(x))
+#define 	PACKET3_COPY_DATA__SRC_REG_OFFSET_HI(x) ((((unsigned)(x)) & 0x3FFF) << 0)
+#define 	PACKET3_COPY_DATA__SRC_MEMTC_ADDR_HI(x) ((unsigned)(x))
+#define 	PACKET3_COPY_DATA__SRC_IMM_DATA(x) ((unsigned)(x))
+#define 	PACKET3_COPY_DATA__DST_REG_OFFSET_LO(x) ((unsigned)(x))
+#define 	PACKET3_COPY_DATA__DST_32B_ADDR_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
+#define 	PACKET3_COPY_DATA__DST_64B_ADDR_LO(x) ((((unsigned)(x)) & 0x1FFFFFFF) << 3)
+#define 	PACKET3_COPY_DATA__DST_REG_OFFSET_HI(x) ((((unsigned)(x)) & 0x3FFF) << 0)
+#define 	PACKET3_COPY_DATA__DST_ADDR_HI(x) ((unsigned)(x))
+#define 	PACKET3_COPY_DATA__SRC_SEL__MEM_MAPPED_REGISTER 0
+#define 	PACKET3_COPY_DATA__SRC_SEL__TC_L2_OBSOLETE 1
+#define 	PACKET3_COPY_DATA__SRC_SEL__TC_L2 2
+#define 	PACKET3_COPY_DATA__SRC_SEL__PERFCOUNTERS 4
+#define 	PACKET3_COPY_DATA__SRC_SEL__IMMEDIATE_DATA 5
+#define 	PACKET3_COPY_DATA__SRC_SEL__ATOMIC_RETURN_DATA 6
+#define 	PACKET3_COPY_DATA__SRC_SEL__GPU_CLOCK_COUNT 9
+#define 	PACKET3_COPY_DATA__SRC_SEL__SYSTEM_CLOCK_COUNT 10
+#define 	PACKET3_COPY_DATA__SRC_SCOPE__CU 0
+#define 	PACKET3_COPY_DATA__SRC_SCOPE__SE 1
+#define 	PACKET3_COPY_DATA__SRC_SCOPE__DEVICE 2
+#define 	PACKET3_COPY_DATA__SRC_SCOPE__SYSTEM 3
+#define 	PACKET3_COPY_DATA__MODE__LOCAL_XCD 0
+#define 	PACKET3_COPY_DATA__MODE__REMOTE_OR_LOCAL_AID 1
+#define 	PACKET3_COPY_DATA__MODE__REMOTE_XCD 2
+#define 	PACKET3_COPY_DATA__MODE__REMOTE_MID 3
+#define 	PACKET3_COPY_DATA__DST_SEL__MEM_MAPPED_REGISTER 0
+#define 	PACKET3_COPY_DATA__DST_SEL__TC_L2 2
+#define 	PACKET3_COPY_DATA__DST_SEL__PERFCOUNTERS 4
+#define 	PACKET3_COPY_DATA__DST_SEL__TC_L2_OBSOLETE 5
+#define 	PACKET3_COPY_DATA__DST_SEL__MEM_MAPPED_REG_DC 6
+#define 	PACKET3_COPY_DATA__SRC_TEMPORAL__RT 0
+#define 	PACKET3_COPY_DATA__SRC_TEMPORAL__NT 1
+#define 	PACKET3_COPY_DATA__SRC_TEMPORAL__HT 2
+#define 	PACKET3_COPY_DATA__SRC_TEMPORAL__LU 3
+#define 	PACKET3_COPY_DATA__COUNT_SEL__32_BITS_OF_DATA 0
+#define 	PACKET3_COPY_DATA__COUNT_SEL__64_BITS_OF_DATA 1
+#define 	PACKET3_COPY_DATA__SRC_DST_REMOTE_MODE__SRC_IS_REMOTE 0
+#define 	PACKET3_COPY_DATA__SRC_DST_REMOTE_MODE__DST_IS_REMOTE 1
+#define 	PACKET3_COPY_DATA__WR_CONFIRM__DO_NOT_WAIT_FOR_CONFIRMATION 0
+#define 	PACKET3_COPY_DATA__WR_CONFIRM__WAIT_FOR_CONFIRMATION 1
+#define 	PACKET3_COPY_DATA__DST_TEMPORAL__RT 0
+#define 	PACKET3_COPY_DATA__DST_TEMPORAL__NT 1
+#define 	PACKET3_COPY_DATA__DST_TEMPORAL__HT 2
+#define 	PACKET3_COPY_DATA__DST_TEMPORAL__LU 3
+#define 	PACKET3_COPY_DATA__DST_SCOPE__CU 0
+#define 	PACKET3_COPY_DATA__DST_SCOPE__SE 1
+#define 	PACKET3_COPY_DATA__DST_SCOPE__DEVICE 2
+#define 	PACKET3_COPY_DATA__DST_SCOPE__SYSTEM 3
+#define 	PACKET3_COPY_DATA__PQ_EXE_STATUS__DEFAULT 0
+#define 	PACKET3_COPY_DATA__PQ_EXE_STATUS__PHASE_UPDATE 1
 #define	PACKET3_PFP_SYNC_ME				0x42
 #define	PACKET3_COND_WRITE				0x45
 #define	PACKET3_EVENT_WRITE				0x46
-#define		EVENT_TYPE(x)                           ((x) << 0)
-#define		EVENT_INDEX(x)                          ((x) << 8)
-		/* 0 - any non-TS event
-		 * 1 - ZPASS_DONE, PIXEL_PIPE_STAT_*
-		 * 2 - SAMPLE_PIPELINESTAT
-		 * 3 - SAMPLE_STREAMOUTSTAT*
-		 * 4 - *S_PARTIAL_FLUSH
-		 */
+#define		PACKET3_EVENT_WRITE__EVENT_TYPE(x) ((((unsigned)(x)) & 0x3F) << 0)
+#define		PACKET3_EVENT_WRITE__EVENT_INDEX(x) ((((unsigned)(x)) & 0xF) << 8)
+#define		PACKET3_EVENT_WRITE__OFFLOAD_ENABLE(x) ((((unsigned)(x)) & 0x1) << 31)
+#define 	PACKET3_EVENT_WRITE__ADDRESS_LO(x) ((((unsigned)(x)) & 0x1FFFFFFF) << 3)
+#define 	PACKET3_EVENT_WRITE__ADDRESS_HI(x) ((unsigned)(x))
+#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__OTHER 0
+#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_PIPELINESTAT 2
+#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__CS_PARTIAL_FLUSH 4
+#define	PACKET3_EVENT_WRITE_EOP				0x47
+#define	PACKET3_EVENT_WRITE_EOS				0x48
 #define	PACKET3_RELEASE_MEM				0x49
-#define		PACKET3_RELEASE_MEM_EVENT_TYPE(x)	    ((x) << 0)
-#define		PACKET3_RELEASE_MEM_EVENT_INDEX(x)	    ((x) << 8)
-#define		PACKET3_RELEASE_MEM_GCR_GL2_SCOPE(x)	((x) << 12)
-#define		PACKET3_RELEASE_MEM_GCR_GLV_INV		    (1 << 14)
-#define		PACKET3_RELEASE_MEM_GCR_GL2_US		    (1 << 16)
-#define		PACKET3_RELEASE_MEM_GCR_GL2_RANGE(x)	((x) << 17)
-#define		PACKET3_RELEASE_MEM_GCR_GL2_DISCARD	    (1 << 19)
-#define		PACKET3_RELEASE_MEM_GCR_GL2_INV		    (1 << 20)
-#define		PACKET3_RELEASE_MEM_GCR_GL2_WB		    (1 << 21)
-#define		PACKET3_RELEASE_MEM_GCR_SEQ(x)		    ((x) << 22)
-#define		PACKET3_RELEASE_MEM_GCR_GLV_WB		    (1 << 24)
-#define		PACKET3_RELEASE_MEM_TEMPORAL(x)	        ((x) << 25)
+#define		PACKET3_RELEASE_MEM__EVENT_TYPE(x)  ((((unsigned)(x)) & 0x3F) << 0)
+#define		PACKET3_RELEASE_MEM__WAIT_SYNC(x)  ((((unsigned)(x)) & 0x1) << 7)
+#define		PACKET3_RELEASE_MEM__EVENT_INDEX(x)  ((((unsigned)(x)) & 0xF) << 8)
+#define		PACKET3_RELEASE_MEM__EVENT_INDEX__END_OF_PIPE   5
+#define		PACKET3_RELEASE_MEM__EVENT_INDEX__SHADER_DONE   6
+#define		PACKET3_RELEASE_MEM__GCR_CNTL(x)  ((((unsigned)(x)) & 0x1FFF) << 12)
+#define		PACKET3_RELEASE_MEM__GCR_GL2_SCOPE(x)	((x) << 12)
+#define		PACKET3_RELEASE_MEM__GCR_GLV_INV		    (1 << 14)
+#define		PACKET3_RELEASE_MEM__GCR_GL2_US		    (1 << 16)
+#define		PACKET3_RELEASE_MEM__GCR_GL2_RANGE(x)	((x) << 17)
+#define		PACKET3_RELEASE_MEM__GCR_GL2_DISCARD	    (1 << 19)
+#define		PACKET3_RELEASE_MEM__GCR_GL2_INV		    (1 << 20)
+#define		PACKET3_RELEASE_MEM__GCR_GL2_WB		    (1 << 21)
+#define		PACKET3_RELEASE_MEM__GCR_SEQ(x)		    ((x) << 22)
+#define		PACKET3_RELEASE_MEM__GCR_GLV_WB		    (1 << 24)
+#define		PACKET3_RELEASE_MEM__TEMPORAL(x)    ((((unsigned)(x)) & 0x3) << 25)
+#define		PACKET3_RELEASE_MEM__TEMPORAL__RT   0
+#define		PACKET3_RELEASE_MEM__TEMPORAL__NT   1
+#define		PACKET3_RELEASE_MEM__TEMPORAL__HT   2
+#define		PACKET3_RELEASE_MEM__TEMPORAL__LU   3
 		/* 0 - temporal__release_mem__rt
 		 * 1 - temporal__release_mem__nt
 		 * 2 - temporal__release_mem__ht
 		 * 3 - temporal__release_mem__lu
 		 */
-#define		PACKET3_RELEASE_MEM_PQ_EXE_STATUS		(1 << 28)
-#define		PACKET3_RELEASE_MEM_GCR_GLK_INV		    (1 << 30)
+#define		PACKET3_RELEASE_MEM__PQ_EXE_STATUS(x)    ((((unsigned)(x)) & 0x1) << 28)
+#define		PACKET3_RELEASE_MEM__PQ_EXE_STATUS__DEFAULT 0
+#define		PACKET3_RELEASE_MEM__PQ_EXE_STATUS__PHASE_UPDATE 1
+#define		PACKET3_RELEASE_MEM__GCR_GLK_INV		    (1 << 30)
 
-#define		PACKET3_RELEASE_MEM_DST_SEL(x)		((x) << 16)
-		/* 0 - memory controller
-		 * 1 - TC/L2
-         * 2 - register
-		 */
-#define		PACKET3_RELEASE_MEM_MES_INTR_PIPE(x)    ((x) << 20)
-#define		PACKET3_RELEASE_MEM_MES_ACTION_ID(x)    ((x) << 22)
-#define		PACKET3_RELEASE_MEM_INT_SEL(x)		((x) << 24)
-		/* 0 - none
-		 * 1 - interrupt only (DATA_SEL = 0)
-		 * 2 - interrupt when data write is confirmed
-		 */
-#define		PACKET3_RELEASE_MEM_ADD_DOOREBLL_OFFSET(x)		(1 << 28)
-#define		PACKET3_RELEASE_MEM_DATA_SEL(x)		((x) << 29)
+#define		PACKET3_RELEASE_MEM__DST_SEL(x) ((((unsigned)(x)) & 0x3) << 16)
+#define		PACKET3_RELEASE_MEM__DST_SEL__MEMORY_CONTROLLER 0
+#define		PACKET3_RELEASE_MEM__DST_SEL__TC_L2 1
+#define		PACKET3_RELEASE_MEM__DST_SEL__QUQUE_WRITE_POINTER_REGISTER 2
+#define		PACKET3_RELEASE_MEM__DST_SEL__QUQUE_WRITE_POINTER_POLL_MASK_BIT 3
+#define		PACKET3_RELEASE_MEM__MES_INTR_PIPE(x)    ((((unsigned)(x)) & 0x3) << 20)
+#define		PACKET3_RELEASE_MEM__MES_ACTION_ID(x)    ((((unsigned)(x)) & 0x3) << 22)
+#define		PACKET3_RELEASE_MEM__MES_ACTION_ID__NO_MES_NOTIFICATION  0
+#define		PACKET3_RELEASE_MEM__MES_ACTION_ID__INTERRUPT_AND_FENCE  1
+#define		PACKET3_RELEASE_MEM__MES_ACTION_ID__INTERRUPT_NO_FENCE_THEN_ADDRESS_PAYLOAD  2
+#define		PACKET3_RELEASE_MEM__MES_ACTION_ID__INTERRUPT_AND_ADDRESS_PAYLOAD  3
+#define		PACKET3_RELEASE_MEM__INT_SEL(x)  ((((unsigned)(x)) & 0x7) << 24)
+#define		PACKET3_RELEASE_MEM__INT_SEL__NONE   0
+#define		PACKET3_RELEASE_MEM__INT_SEL__SEND_INTERRUPT_ONLY   1
+#define		PACKET3_RELEASE_MEM__INT_SEL__SEND_INTERRUPT_AFTER_WRITE_CONFIRM   2
+#define		PACKET3_RELEASE_MEM__INT_SEL__SEND_DATA_AND_WRITE_CONFIRM   3
+#define		PACKET3_RELEASE_MEM__INT_SEL__UNCONDITIONALLY_SEND_INT_CTXID   4
+#define		PACKET3_RELEASE_MEM__INT_SEL__UNCONDITIONALLY_SEND_INT_CTXID_BASED_ON_32_BIT_COMPARE   5
+#define		PACKET3_RELEASE_MEM__INT_SEL__UNCONDITIONALLY_SEND_INT_CTXID_BASED_ON_64_BIT_COMPARE   6
+#define		PACKET3_RELEASE_MEM__ADD_DOOREBLL_OFFSET(x)  ((((unsigned)(x)) & 0x1) << 28)
+#define		PACKET3_RELEASE_MEM__DATA_SEL(x)     ((((unsigned)(x)) & 0x7) << 29)
+#define		PACKET3_RELEASE_MEM__DATA_SEL__NONE 0
+#define		PACKET3_RELEASE_MEM__DATA_SEL__SEND_32_BIT_LOW 1
+#define		PACKET3_RELEASE_MEM__DATA_SEL__SEND_64_BIT_DATA 2
+#define		PACKET3_RELEASE_MEM__DATA_SEL__SEND_GPU_CLOCK_COUNTER 3
+#define		PACKET3_RELEASE_MEM__DATA_SEL__SEND_SYSTEM_CLOCK_COUNTER 4
 		/* 0 - discard
 		 * 1 - send low 32bit data
 		 * 2 - send 64bit data
 		 * 3 - send 64bit GPU counter value
 		 * 4 - send 64bit sys counter value
 		 */
+#define		PACKET3_RELEASE_MEM__ADDRESS_LO_32B(x)     ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
+#define		PACKET3_RELEASE_MEM__ADDRESS_LO_64B(x)     ((((unsigned)(x)) & 0x1FFFFFFF) << 3)
+#define		PACKET3_RELEASE_MEM__ADDRESS_HI(x)     ((unsigned)(x))
+#define		PACKET3_RELEASE_MEM__DATA_LO(x)     ((unsigned)(x))
+#define		PACKET3_RELEASE_MEM__CMP_DATA_LO(x)     ((unsigned)(x))
+#define		PACKET3_RELEASE_MEM__DATA_HI(x)     ((unsigned)(x))
+#define		PACKET3_RELEASE_MEM__CMP_DATA_HI(x)     ((unsigned)(x))
+#define		PACKET3_RELEASE_MEM__INT_CTXID(x)     ((unsigned)(x))
 
 #define	PACKET3_PREAMBLE_CNTL				0x4A
 #              define PACKET3_PREAMBLE_BEGIN_CLEAR_STATE     (2 << 28)
@@ -370,11 +527,19 @@
 #define	PACKET3_SET_SH_REG				0x76
 #define		PACKET3_SET_SH_REG_START			0x00002c00
 #define		PACKET3_SET_SH_REG_END				0x00003000
+#define 	PACKET3_SET_SH_REG__REG_OFFSET(x) ((((unsigned)(x)) & 0xFFFF) << 0)
+#define 	PACKET3_SET_SH_REG__VMID_SHIFT(x) ((((unsigned)(x)) & 0x1F) << 23)
+#define 	PACKET3_SET_SH_REG__INDEX(x) ((((unsigned)(x)) & 0xF) << 28)
+#define 	PACKET3_SET_SH_REG__REG_DATA(x) (((unsigned)(x)))
+#define 	PACKET3_SET_SH_REG__INDEX__DEFAULT 0
+#define 	PACKET3_SET_SH_REG__INDEX__INSERT_VMID 1
 #define	PACKET3_SET_SH_REG_OFFSET			0x77
 #define	PACKET3_SET_QUEUE_REG				0x78
 #define	PACKET3_SET_UCONFIG_REG				0x79
 #define		PACKET3_SET_UCONFIG_REG_START			0x0000c000
 #define		PACKET3_SET_UCONFIG_REG_END			0x0000c400
+#define 	PACKET3_SET_UCONFIG_REG__REG_OFFSET(x) ((((unsigned)(x)) & 0xFFFF) << 0)
+#define 	PACKET3_SET_UCONFIG_REG__REG_DATA(x) (((unsigned)(x)))
 #define	PACKET3_SET_UCONFIG_REG_INDEX			0x7A
 #define	PACKET3_DISPATCH_DRAW_PREAMBLE			0x8C
 #define	PACKET3_DISPATCH_DRAW				0x8D
-- 
2.53.0

