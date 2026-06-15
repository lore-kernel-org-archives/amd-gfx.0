Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5428FCD98E3
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEDA410E6DA;
	Mon, 15 Jun 2026 23:57:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oOeVQBLK";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012020.outbound.protection.outlook.com
 [40.107.200.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82E5810E6DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5och58Xw3j5nBw68vnaZDC1YdGi0m9JaO67UGga7O8wtlY27y+amiqkDLTWehflELpUit+F9+ScCvIJmkxb8vzH9uua5ZfWkVU2gHbr9sXeVK1wo03QOXVwVwqyq1nxdF7sEv95v+dPGl3H24DcUzioARtE4BPgppfzhNN1nuRfZcqZ8afEI+wyh6KLGT94TbxztvnlMwvzoDE3JSoo6HVGI5BN7LVR7Nx4kwPfmq2KZUJ4+vkBoAyNrQwS+P/m8Y8/XfZwVF//jCXwJN5lJmQBv8cuBx+663xDlz5VPd3QPNlhpSQpsxvt9brL9mY9e/12fdOnhpjQNXFxEW2A9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFlqWLxhiFw7TeeOdNn71Ve0buneEGILvx4ZIPOHSKA=;
 b=FBUJz/ySZzpBYtvlcfxtusktbjv9fcAHumuAOkkV+NwM/hlMoCJFViDkCBD/tRBsZ7c1K4DNlwAum50SmXMLaob5SFxaMuo8PqvyTCQE/lexqUEX1utyMVrr48Q4bT7I5aE3qUm7Qijez4tznMpnoCVvKRVDBr0M27BKoSpOusUIBkwHEfIivvUc9q79v3R7oyUQWmbViFcEpmTroCImbiqrlVS/FD3Gt3zYsRvh7O8DyJ0IKGCQNzK7LkWVRUOBbZLMvT5JtxL2G2j99VErGnX6dwjKMPE6C+sDRVr/Z2D0qGJZM5CS4+FWWb7cBx59atzXhxyvyhVgnZdPKAtDDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFlqWLxhiFw7TeeOdNn71Ve0buneEGILvx4ZIPOHSKA=;
 b=oOeVQBLKMsU2wKp5BC2KQsaLM9176e0p18mvOF5bDVVLL5soECQfIq+468ujSWztN7g9H5qP8C1THK0lZ/Q75Ewd6oIsUHNQdlIg0OCkF0T1zrubtjFYijgRxAAsKY9TDYIo/ccGwDuGYuOFNpeNJqrmbqa791BCx7IRKoiSDLI=
Received: from SN6PR2101CA0002.namprd21.prod.outlook.com
 (2603:10b6:805:106::12) by CYYPR12MB8701.namprd12.prod.outlook.com
 (2603:10b6:930:bf::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:56:59 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::68) by SN6PR2101CA0002.outlook.office365.com
 (2603:10b6:805:106::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.2 via Frontend Transport; Mon, 15
 Jun 2026 23:56:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:56:58 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:56:57 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:56:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/43] drm/amdgpu/sdma5.2: replace BUG_ON() with WARN_ON()
Date: Mon, 15 Jun 2026 19:56:12 -0400
Message-ID: <20260615235645.737189-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|CYYPR12MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d82312a-fe8a-47a9-06cc-08decb39c992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|56012099006|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: ZsNG42n0zkIswDH4jU1EKhSHdA+NxX1X/s947d8uWwD5Soi9eTl3LzDC/X46h3jNhD2WKSMHttWOQ4S67jlmiVX7tffMZ9L0jw/5+q1ocmKPHtEQP8Lz9CmymN+PSUf9b2rE4J5Oe01vsAikTna5k1rNDwccAjiX+qBmEfYH5Gdf8AP5xauVoO40UO0dnaPZKbNjcUU8kF47V6m7ErPBl+2myYGVK2cZGAIGSJYvVmXGCuHT17KiVfp1y3enrUE19encqErs4CpyrrGuAH7v/VysML5Uy4sCjvfnn+GV0/zbZ4fxjX/3bmQa60KtnV1+8N2CevfzFwwydN0Afal64saMPK4+QWN6LCL0gsXmOBLmp3QXqUm3BsKqZdBg0BuDnUjv6eDQhbXL26SvKtUngM9UO7npP8NQ5A1fGBBiwwvEz0dmHZTPMY9nvGlrFy8YYr4oDfIytQ9w5dlvr/N7H7YuruHuNZF29lCObBejWiSUhcIIF3Co4/UaSYk3lXrIPa+Dc6UqzDIXayK+Y7renUFXEGdlPCOXJroSZeA4s2cvBkOS0lZbmOikaF8n/vfBB73UCArahILRMzLmjwfPm/iEaoOeJX5kaHoTbaU9bdDPrZ/c5UbUkarIxh96VYyK1Y5QbWTGIbE5oiYRAjnXzDXGV3shS3AcYCTrbt81XQ1DhohBjZfli3I5yHXVcfW/ZMD6f9R6uFxi3AeoQ6I8a0yII3UcR1UKS4VDNCnWxb4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iPJJMLHBlXahXcAUfd3bGQM8kNknbne3tZ2S5C9U6JxCz114P232BRoYxOrfB1K9XyJxHmlM5c8mVLfd7JR8VVQjt/H6K3B6OZjRgR5ct0SYHAJkQyzDcioxN6ff+UE4RwOqr61p7KcLCtZFlHV8J+g3/nCv3sQSFjAjLOkbR6JFYY/UyPoJWbXU/1KUx+ThSFZusbRIABwQyrJIFRhPlgZm9e1WtEHAmMtUoH0Buw5fN4I2Z7xiq2Af1NBBVBE/JEhRjkfSQ+IeJjN1agy2WgNwSV9CrKBODP1qKM7EWEI3itaDdtW39Hzq8ev0cK0W0NqCCz15UaFqoMAipfvStwPFxn65EKcSL5jFWHxfgx/jh5jsZNbfULnzJx5dXCckBw4mEYY1ofn+xW0NW4TrTYeNECBlInRd5tN5hu7y4WKMuOV6N7zlzYxhIFUJIl6j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:56:58.7874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d82312a-fe8a-47a9-06cc-08decb39c992
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8701
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 520a7ac94dfd3..d379c58ac8227 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -377,7 +377,7 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_FENCE) |
 			  SDMA_PKT_FENCE_HEADER_MTYPE(0x3)); /* Ucached(UC) */
 	/* zero in first two bits */
-	BUG_ON(addr & 0x3);
+	WARN_ON(addr & 0x3);
 	amdgpu_ring_write(ring, lower_32_bits(addr));
 	amdgpu_ring_write(ring, upper_32_bits(addr));
 	amdgpu_ring_write(ring, lower_32_bits(seq));
@@ -388,7 +388,7 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 		amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_FENCE) |
 				  SDMA_PKT_FENCE_HEADER_MTYPE(0x3));
 		/* zero in first two bits */
-		BUG_ON(addr & 0x3);
+		WARN_ON(addr & 0x3);
 		amdgpu_ring_write(ring, lower_32_bits(addr));
 		amdgpu_ring_write(ring, upper_32_bits(addr));
 		amdgpu_ring_write(ring, upper_32_bits(seq));
-- 
2.54.0

