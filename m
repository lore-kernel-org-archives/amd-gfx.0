Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F14CCD98E4
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1758E10E6CC;
	Mon, 15 Jun 2026 23:57:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zToX4a4V";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011010.outbound.protection.outlook.com [52.101.57.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00F0310E68E
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:56:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ar2QkjVuUwaFZZ2LHwyahd/2qljJbnoWdRV/IQpdWDXGESzxUQ6nA1Vn/d0Ij4xX46JTQ1r30e7NXd1H2vcJoS+HNEbAsaFu8CEr8aECz3VbbraA4PJVQBgE1Sq4zHPnDtTdY+VMEfaYsfUrE7YI8pgZhSJLHY1XJGWk36XKSf68OhSAAPsBNqpIUaUILWdsNa4ryA4sC80NP8GiRPUHeY2AfE+yfx0gK5QqWnRRfChdIwQNCBixQLgNS0cO+LWMageau7GDnKg2Z7FgDc5jq0A3BGN4kp5kQw+LQUVVsGDVTddCbrRBs101nZmnZSXL0ycB7taF0UwsyZ86Derjeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgfwW0594j9Rq/HXgTSLp3+FUHg+iLnKxtw7o4AVjzo=;
 b=YxJQuvMQe/WSBOAYxyGLrn9qUVjROiwpR665eED6bUNOGu/mkcqKFgNZI/zyXFEfYm0wIdB89xVssdVE+YYQ3hBnpvayV7MdCXiTkHnM9NY5FWLcACzM0jr8/z25g30bnYc2ZsvsktGOPiv20JGOB6ak95uMdMY8GyZRAuBax47SG+R1dzFj3BJRaxu+2PAbyAchoa//NWtCOa51xPcEhgqFDKSIqFtWgvZSqLm/rlTsgVJNu7Z/pef7ECPjuFB9QjeAhLPOAU0wBwZMae7M0R6gyA4VOiQ4jj8kstTYWEJuhA3WM6V1bwY13g5n0X2RHNSfUGTrgNK50tO2c1vX1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgfwW0594j9Rq/HXgTSLp3+FUHg+iLnKxtw7o4AVjzo=;
 b=zToX4a4VJJDEy45gJX8ubPPRK5HUwU/K/pl5Yrb7x34vX1uzYxvkrh8M3fGtwZli1wtrZFPA9Ucr2DW8ZqdGzWIe2zR/6QJH49mn6BnCJr3amVs/5/4+V+xNLBdG93/q4VJHlL3FpvVIUJ4KKxJIoiu9WdJqgVOBjzLb/rmyleg=
Received: from CY5PR22CA0060.namprd22.prod.outlook.com (2603:10b6:930:1d::23)
 by LV3PR12MB9165.namprd12.prod.outlook.com (2603:10b6:408:19f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:56:56 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:930:1d:cafe::a1) by CY5PR22CA0060.outlook.office365.com
 (2603:10b6:930:1d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 23:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:56:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:56:54 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:56:54 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:56:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/43] drm/amdgpu/gfx10: replace BUG_ON() with WARN_ON()
Date: Mon, 15 Jun 2026 19:56:06 -0400
Message-ID: <20260615235645.737189-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|LV3PR12MB9165:EE_
X-MS-Office365-Filtering-Correlation-Id: bf210c80-081e-4340-99c6-08decb39c7d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vGXH5XKiqx92FxkFBk6+/eN2dPy5YFel13FXUTEm+VN8Gq005h/vOR3GNg3/eKxEvN5Rkff7oSo+bek9JFhcxRqeoR1m4J+KFc3GVIN30xOMugBfy3vheJDChZ9jy0eY62pBcrzZnXose9rVPwwbIxlsX+dD2RzB/k0RzX5OLZ3LETOJ+jIeuGsxarhg05qhA8VGYPO59Asq6p//9xCeLlGYSAMYORbQba26Srb06XW7pevOxsr3XCNuYVVr9fCA0Pg2VeYQ1kauiFAgKLLgMYrSrv8osk6mswBPcZz26j+Jf9K/ZqM9fj0LQS3vB00PdueEOEQlvgCgzSFBbgY+A2mLeWJQdEeKejOuhl8amyuWlBVD16NAwcOzQC0m7hnQEkXxbNXFr5rYCG5XwHDxyl1mUTucIuw9bDUfCFq6JlvLZJXiRF3GAcdEdD8aKqm+TwqfXuk5Fxt0STJaj0Z4MxB90XY+vbu3K7RXJ4G/9D8jbpuDoRlhckWe8rmt8VG0+rjCxBUVpTCgM9FNu/CibpLqoe3EGFkfgYXKdJ3qNJ+Y5V0HoDMWUycDR/+v4hTXYoKAeK54i6GpI3B1ZzEaEppM+agMz7XJ0pie2SLbpr9GTBidduhA988q1LcJ/vbGmnEQtP9HOn8PL6F9djhSDYHs8G03InticQjM0xQ4WEeYRPrUr2ym2RZy9EvZaIi6CM5BijiheIQCjTaBcI8RBtkTvQAIbWNU/7rUj9bTIDo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7c5swCsKPBMhLQlRGQJRpa350Jze1t0VAOzLJtWnfbJnF/va+4LRJA1Eaxr43Sj/+rV8aZgomN0LCV+GiqEaBOgUjixLLa/eGl8soEqaNu2TTYWr/a8/3QBmN16w75dXrEWSfS7y82lnuKQ4gYF+AHA/x1a449DvdJyYqeHo+MPsXkOF7b/ZySWi9CbK2vgP6IcGU7InP2aOG+d+exmGeWHftnijgM88xOtDqB/Wv5HEQ8AQCJYWlhJLrfPHD1zFYJi4EBoFaqA/f55CRDNIMaOVDt+Z1lYmy2LcMl/svwGQhnj1FHwG+Btxxu0DmKfEf35mWqmtNhV+sMpFce2noNUxZWgp61PZIaxH6pRffVaAPFBqPBlYZ1KaaVj0Jed4BsyJswlJYlXjeBHdt9Fn7AfXn99Z0Vxk4o0XkC+U/x+NoBlaNP8xjsWsDubcPpZi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:56:55.8765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf210c80-081e-4340-99c6-08decb39c7d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9165
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
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index e99d17cd43e57..544d6aafb11a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4022,7 +4022,7 @@ static void gfx_v10_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
 			   WAIT_REG_MEM_ENGINE(eng_sel)));
 
 	if (mem_space)
-		BUG_ON(addr0 & 0x3); /* Dword align */
+		WARN_ON(addr0 & 0x3); /* Dword align */
 	amdgpu_ring_write(ring, addr0);
 	amdgpu_ring_write(ring, addr1);
 	amdgpu_ring_write(ring, ref);
@@ -8661,7 +8661,7 @@ static void gfx_v10_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 	}
 
 	amdgpu_ring_write(ring, header);
-	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+	WARN_ON(ib->gpu_addr & 0x3); /* Dword align */
 	amdgpu_ring_write(ring,
 #ifdef __BIG_ENDIAN
 		(2 << 0) |
@@ -8696,7 +8696,7 @@ static void gfx_v10_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
 	}
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
-	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+	WARN_ON(ib->gpu_addr & 0x3); /* Dword align */
 	amdgpu_ring_write(ring,
 #ifdef __BIG_ENDIAN
 				(2 << 0) |
@@ -8729,9 +8729,9 @@ static void gfx_v10_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	 * aligned if only send 32bit data low (discard data high)
 	 */
 	if (write64bit)
-		BUG_ON(addr & 0x7);
+		WARN_ON(addr & 0x7);
 	else
-		BUG_ON(addr & 0x3);
+		WARN_ON(addr & 0x3);
 	amdgpu_ring_write(ring, lower_32_bits(addr));
 	amdgpu_ring_write(ring, upper_32_bits(addr));
 	amdgpu_ring_write(ring, lower_32_bits(seq));
@@ -8779,9 +8779,6 @@ static void gfx_v10_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	/* we only allocate 32bit for each seq wb address */
-	BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
-
 	/* write fence seq to the "addr" */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
 	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
-- 
2.54.0

