Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9B5C27C5F
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jun 2024 08:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EAFB10E1C0;
	Fri,  7 Jun 2024 08:33:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s26jSWQo";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFBE210E1C0
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jun 2024 08:33:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSk66vCkvShAqdN01lJ78ZKtVGQTTNFtCP7+AvanMpwr4dE5dUjPHBFSE96NWXz7DWaf/hhZZLcqu1NrOAGyFZCDVJoALCmD334nUdX83GEKn53EOT1F3ua+qF/hRbaIwx7MpQjVPDiGGDorFtZJEzVr1XqSj//eqHiI4zo43djrUW/ej+PcHKKxe1Aw+r+qOGS5P2froYdTpEpC6VGJOdbyedABDJ2oey4qHoUIsRY4z0xC7j+ioyh5MAaqHUb1X7Gof//5CwipwRBI3Glu6OtO7P71Y22CP/55VPaEBpCMR3x5HeE7gT5oNTs9f7Jh3tiEm9stl8TQyvgjk4OQ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RK7h/fsLgbSj5THq6M/tHiN2BUysex2mdkS3HkBoVC8=;
 b=EomNAqXEZySDknIwJ8RBwsaGkKbsGFFzJSD3VjhOzKj4KHp/5Uzu/J/lVQvdQRPYIqCfaXvUuqMLGm5R4VhaHhcExGzGqMdInadRexVGg1gYPYyb32J4TQ8JgysEk+KR1zjJ2pKhFqc55tZrNZCwJ0LDBVBtv+HdMvmeu5cJAvUoA6DBu65y6Im6kK6fAw2MRqRgMo5p33OwNxLGBybOYqvyVHVURLPy5C9jI+Jq0oPAUbyWTFSroeZGAyYGGRAJOALsX8iA0zC6xKUP1yz6LtQlRCsN7+3Y0SDXtyHFCcJEYho4Wq1JqacL2REcIFj1jDqnVlUnRnsKQE23MwsJBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RK7h/fsLgbSj5THq6M/tHiN2BUysex2mdkS3HkBoVC8=;
 b=s26jSWQoQRwIaPZABihZNtcAlqFGUAAjQI8Gj1xMo+LGeUiunsDs16WPBWaZJlPWxCXTOtLsH25KpzvOWQU17ItTY8Z4/fM2t728+98gSvmmD9Yjzm/hKbv5ycJxLTonybVXY+acM7vjQK7u85gQ2lFLhO/KbRSBBjZ+BcVJS6M=
Received: from BN9PR03CA0500.namprd03.prod.outlook.com (2603:10b6:408:130::25)
 by SA3PR12MB9091.namprd12.prod.outlook.com (2603:10b6:806:395::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Fri, 7 Jun
 2024 08:33:42 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::3c) by BN9PR03CA0500.outlook.office365.com
 (2603:10b6:408:130::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Fri, 7 Jun 2024 08:33:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 08:33:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 7 Jun
 2024 03:33:41 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 7 Jun
 2024 03:33:41 -0500
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 7 Jun 2024 03:33:39 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Tim.Huang@amd.com>, <jesse.zhang@amd.com>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, Bob Zhou
 <bob.zhou@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix dereferencing null pointer warning in
 ring_test_ib()
Date: Fri, 7 Jun 2024 16:33:36 +0800
Message-ID: <20240607083336.65752-2-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607083336.65752-1-bob.zhou@amd.com>
References: <20240607083336.65752-1-bob.zhou@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|SA3PR12MB9091:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b37aa6d-5881-49cc-43b6-08dc86cc899c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WFhccEpICP/gKR6ygRSzI9PXkpkgb63pC7aCi5fmmo8SkgolUo2dpde5KiB7?=
 =?us-ascii?Q?Ghw5T1vpnESUC8elnxMrub1yHtsClvnDrLBWl0Dc9Q32d1qGbRlodpcOKDZB?=
 =?us-ascii?Q?qBsch/F5Yx+PEILFHK9/yMhpL4c87yvQVyIRXepl2gK620jqJuE9mrE7AcTU?=
 =?us-ascii?Q?nvg6Ptv6eZtu15iaKO5icjLTa+3Sivr5EZOFepJFVEXYeJat/OMuVb+/T6ym?=
 =?us-ascii?Q?3R+Jfi9KSYxLtokkCGN86KRNFRME1GsjbaE64/Q0WpyqqWf+CKcniZi6GwkC?=
 =?us-ascii?Q?AcbtwxyTJ+ZMmmReQVqGWNS4Lcy5LORaYlfCas/BYedCv0kWcKYP/zJOsRfo?=
 =?us-ascii?Q?3rwXqAU9kwCkwHwtM4eTHfHddBrubzWJbuRmXSHu276m025N3aBHZU7blk/R?=
 =?us-ascii?Q?RvemYwaKpbB8xz5DdvzpYHPJVas4V+yJaxzMhbP65yYElRd0jeE2uq1Bzq8C?=
 =?us-ascii?Q?IZMjHmmsfQoiwjGYr9zKgVuAD3fp4rt3dISXebVHg3NqkJeEUB2q9okKlyfU?=
 =?us-ascii?Q?WAf7Trh+L9b9gljQmQmoDDXOtXSKk94+/LkWXEQEXTlvEm1sL2o73cxbEjaB?=
 =?us-ascii?Q?4K0HJp8Sg6YMSV4hzu3A98Zdw+G/8FbSWX0Z4On7PpTQOHCs0uRJT6JJ16wP?=
 =?us-ascii?Q?R3CTkq6fb4+xHov0kN2256LuOAAR8WsrRdeV4A0VPrxgDT9pJCfOTTbMAUBa?=
 =?us-ascii?Q?HS8k5sThgzlSwlraNptX9H+6HjdkOsafnJJRpNfWID5JFHf75/iSOw0CXhCg?=
 =?us-ascii?Q?d1ck20ar6bEajUrUl3GaJvj0vr52QvjTepGPbUeQAvUp8PW83tuv0l9ij40a?=
 =?us-ascii?Q?4HL4e9Mr7cDvJSm0TWiLqmZbNLKP8XHuqBCtg7iTjJRn7f0yPJNPlU1icyBG?=
 =?us-ascii?Q?WD7kMipwCAxPGZO3v1R9kjKyEIlS3L78FihorVmwxw1RkxB8C3CU1+gS2j0O?=
 =?us-ascii?Q?hUGcjnt4kLGtJ12u+oR9REaNmieuxGMfaFJXbVJ1kmXlWpacFn2Dc82j/9pV?=
 =?us-ascii?Q?ix6QOlE8u74PejzzM7hb7+oPRhl7TzNbSp9eH2nh/ooq3N0b6Vja75giLZ8C?=
 =?us-ascii?Q?AEpEaEFPiqnmj4xwIvUVxbGWfXZhq3yrgzeyUO/BQmEd5itGbTDuIunk3S8A?=
 =?us-ascii?Q?Gm1ww2AXy89aEP8vRw0OI2vQWaju7Kgwlonaqa6i0MdEyC/iuWT9WxMGtK/F?=
 =?us-ascii?Q?b/35ROzZgyKo4T6Du3d0grdxbneMWCWwsxSYwJ7Pz0s9UxN9f4vVcu+0dG7n?=
 =?us-ascii?Q?7UMaaO+9MIElEXfyGa/mpaDcqvPnl/C2qw7e9Rrm2UAsiO1OscL0PgFbCfN2?=
 =?us-ascii?Q?3/LM96QU2o9B8sYFNR7dE89Rn81gAf6eAdskVdsmzQ1Qte3kkviWcHzBxzKA?=
 =?us-ascii?Q?QQn2DkQkFy+2Wvs9KtNyXvfwq6RCy9pPFvGIA2xH+8wxLuc1Ag=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 08:33:41.9156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b37aa6d-5881-49cc-43b6-08dc86cc899c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9091
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

To avoid null pointer dereference, Check return value and
conduct error handling.

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 4 ++++
 6 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 2a510351dfce..f131f96a734c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -547,6 +547,8 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, padding);
 		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, padding);
+		if (cpu_ptr == NULL)
+			return -EINVAL;
 		*cpu_ptr = cpu_to_le32(0xCAFEDEAD);
 	} else {
 		r = amdgpu_device_wb_get(adev, &index);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 460bf33a22b1..b5719760abe2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -322,6 +322,8 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, padding);
 		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, padding);
+		if (cpu_ptr == NULL)
+			return -EINVAL;
 		*cpu_ptr = cpu_to_le32(0xCAFEDEAD);
 	} else {
 		r = amdgpu_device_wb_get(adev, &index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index b7d33d78bce0..56edac57d1e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -984,6 +984,8 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_ring *ring)
 					 AMDGPU_MES_CTX_PADDING_OFFS);
 		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
 		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		if (cpu_ptr == NULL)
+			return -EINVAL;
 		*cpu_ptr = tmp;
 	} else {
 		r = amdgpu_device_wb_get(adev, &index);
@@ -1067,6 +1069,8 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 					 AMDGPU_MES_CTX_PADDING_OFFS);
 		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
 		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		if (cpu_ptr == NULL)
+			return -EINVAL;
 		*cpu_ptr = tmp;
 	} else {
 		r = amdgpu_device_wb_get(adev, &index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index cc9e961f0078..3e5316a24c90 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -824,6 +824,8 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_ring *ring)
 					 AMDGPU_MES_CTX_PADDING_OFFS);
 		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
 		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		if (cpu_ptr == NULL)
+			return -EINVAL;
 		*cpu_ptr = tmp;
 	} else {
 		r = amdgpu_device_wb_get(adev, &index);
@@ -907,6 +909,8 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 					 AMDGPU_MES_CTX_PADDING_OFFS);
 		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
 		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		if (cpu_ptr == NULL)
+			return -EINVAL;
 		*cpu_ptr = tmp;
 	} else {
 		r = amdgpu_device_wb_get(adev, &index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index c833b6b8373b..c1d6ece57bd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -846,6 +846,8 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_ring *ring)
 					 AMDGPU_MES_CTX_PADDING_OFFS);
 		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
 		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		if (cpu_ptr == NULL)
+			return -EINVAL;
 		*cpu_ptr = tmp;
 	} else {
 		r = amdgpu_device_wb_get(adev, &index);
@@ -929,6 +931,8 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 					 AMDGPU_MES_CTX_PADDING_OFFS);
 		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
 		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		if (cpu_ptr == NULL)
+			return -EINVAL;
 		*cpu_ptr = tmp;
 	} else {
 		r = amdgpu_device_wb_get(adev, &index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 96514fd77e35..2ea988e7e242 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -859,6 +859,8 @@ static int sdma_v7_0_ring_test_ring(struct amdgpu_ring *ring)
 					 AMDGPU_MES_CTX_PADDING_OFFS);
 		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
 		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		if (cpu_ptr == NULL)
+			return -EINVAL;
 		*cpu_ptr = tmp;
 	} else {
 		r = amdgpu_device_wb_get(adev, &index);
@@ -942,6 +944,8 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 					 AMDGPU_MES_CTX_PADDING_OFFS);
 		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
 		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		if (cpu_ptr == NULL)
+			return -EINVAL;
 		*cpu_ptr = tmp;
 	} else {
 		r = amdgpu_device_wb_get(adev, &index);
-- 
2.34.1

