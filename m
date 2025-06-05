Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E58C5B555
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4A010E7B5;
	Thu,  5 Jun 2025 01:46:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MP8LnXE9";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B41C110E233
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6hJbQ0UfxO+blEIW/TQrqVlZmYcPEEjifcTjSSppQZDgaGoTAMrqOl/1O20B5r8kOzATs2oGAIXCSkJrvEQAPgdpgtBk9dkAr+uPhm5qslwAirAJrybg3fndp5OsHWNN9FTk4ySqBGfYyhlDcdRthNKsHrY2u6GX+YuR+VHnehbAad9kU4+7mgpAgCuZJfCxOgH3Tk0tlEESEjKfEqXOmIB0UNtj/et/Tkzk4Y3upRuP9TH9oro3bW8BYKnIq1LPNvlJnQ3Hd/C+aefvEl9bgDCi/nq8kOP80ogkpdlODm2wKOizdE5sUeEJFI11X4SofRMP1oDMs0r1kzdgl4oOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRvvk4eg1JqQ/hxHEg08NFm5v6TaboJLOgZe7TcmrLY=;
 b=wdLnB4241e8GHdzM2rxi5YiM7WcsRoVrpFaLM0b1a28ekk3AyeIfZXpF7fqWXTvAu1Jv5ljLclWj7QWJBXMbYalKzej9mGrTOTDGz74sCkGdrSfsUssVva0I9s3NIOmdFdXBDZNLdNbnAyJzMv9ovFCs/+OpCZ8p1EqRZ7JLmtaXcd2ZmYTe3KjxYVWVHPas/Ttrd4lP4yob01QPTpSzJ9hjf+QAfabrhb5k90YHwxyqw9LlwOUjuL2Gr557tIwjbSDkwqxBhMwjX8xCsSX/7IdI5e5hmf17CPvEfhG1mHilmYvxG40+st/JqBk+VAhIbQwlRyqRrdisMqFj9P3VGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRvvk4eg1JqQ/hxHEg08NFm5v6TaboJLOgZe7TcmrLY=;
 b=MP8LnXE9HfbTXAiXcWbHOzIu/Uh1yHuac+MA/I4kuR3Pun+DhS5d15Ew4IJ5wLAOr3LtNDwoSYO2gagSRj9DgH0xLQKr/0SGLusgfl49yR/sOkmYR4uvnnG7qx9xhk07tntxaubt05UJZAxn4tP84EmfyTb/katU2Ky+s8xdreI=
Received: from SJ0PR03CA0124.namprd03.prod.outlook.com (2603:10b6:a03:33c::9)
 by BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Thu, 5 Jun
 2025 01:46:20 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::33) by SJ0PR03CA0124.outlook.office365.com
 (2603:10b6:a03:33c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.32 via Frontend Transport; Thu,
 5 Jun 2025 01:46:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/31] drm/amdgpu/gfx7: drop reset_kgq
Date: Wed, 4 Jun 2025 21:45:32 -0400
Message-ID: <20250605014602.5915-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605014602.5915-1-alexander.deucher@amd.com>
References: <20250605014602.5915-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|BL1PR12MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: 60afde86-da46-4742-df0a-08dda3d2c4e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EzSr982NYYEincwHVU3MxBSutZEeEQHIRrVek6N1CkMX7tM06XWFJH/Z/FOS?=
 =?us-ascii?Q?HBMFrAokgB/89QTblCCFIzbQwlfH9tSbxYPkKU0tkNdhWD81BFyszhGNQjOE?=
 =?us-ascii?Q?LrDIFJCB43+W2Yp+oxHc8qIsti7IMmILCzOsrXd29qy79UIlISrQvEQ97Y3V?=
 =?us-ascii?Q?jyCIDv7L9O45DuGYcXZYeoVUaErdA1HjeIm/qUm3W6Uq/gOM7FGJhkFyNvZk?=
 =?us-ascii?Q?EhCVEsYMog8qauaXDSUoRovj1ldrE3Nio8W6hWNKHD74LckS6becQtpJS2EO?=
 =?us-ascii?Q?froe96gDFQwA13RTcIhy5IZmvESLKVMvTWLS+INi1f+0a9CoZ3vIuxBuBbbt?=
 =?us-ascii?Q?vIlhXGuBGo2hBy5dSEjSJ3FaKVeuulFAg4pwZ+1q+o1MdPFMb8lA/IbSD5CF?=
 =?us-ascii?Q?Io3Y0BMhRTMUKLoj2iaKO7e8Tqan3M3aVQRAEgAIYLVDRVny7pk4Qjf+6ci3?=
 =?us-ascii?Q?ZHKICOjevir1g0nfHU4jgkCpsDy/kz/vOExArJ02Ax3rJdu8sMA2dbvISvby?=
 =?us-ascii?Q?AN7EfelhJgJ8JT+0F8B4OwvEhKU2ecisHBzEFWwn9yXj8IjaBsp56cD/3DC0?=
 =?us-ascii?Q?NV4hVsaZaSOoFbQOrMMYnwjXwll8XhYc8KyuoPeqvQCyzx55iP7PueXxewb4?=
 =?us-ascii?Q?qaoMoNIxlYeaOqlV7Otshccd+OUoT9bfdFxLbGvHIcqU/UCDhGqHkp+6w9bM?=
 =?us-ascii?Q?10kjoFDyDNHBcKUUCv7QvRTbq7Jw2pBjgqeB8vD6vDld/CySC6LgBU5j12ir?=
 =?us-ascii?Q?dsUkPe7dBO6XWDqNcDCzZtjfwDw9TF7zN85Ehk0oHUmbu7rGw1sKQudL5eq4?=
 =?us-ascii?Q?GcvXelddVDh7UNDHvxeVgWrFSNKG7k+LxZ3IJwY74oKHNFg3EEm/900W7qcS?=
 =?us-ascii?Q?S4YqHxC/Iw8/MVN+Qih6XZpsVlxPV2z6N/gF1NXDKU/A6M1WGuNejPWKloP5?=
 =?us-ascii?Q?bPqAoyIhwI1gYgw0Iau9a/CE1aQQWO7z2qfwuM83wlL0JTXrhdHtvZrpQNu9?=
 =?us-ascii?Q?vvh4gXaO0eecinrXRKKBqXuVEQE97foN4WNsQNvqrbxmfmyG/beaRlL58Cbh?=
 =?us-ascii?Q?XbWI6+68sXg0zDI73oXJvAJy0vNyOeygHVXYp3kG001MwYqak9/jhmjuSI7R?=
 =?us-ascii?Q?no4TRok8ntgvUFAscThf1bFOCuXwR8C6yRZZ22r/cmEiRw74+LcLnnmIjq+z?=
 =?us-ascii?Q?Xk3PRGy4IP7VNaby5q5uhyYCo/dMLuVK9Z4gkZ5HKUkDkiEwEUtuQqVwPXye?=
 =?us-ascii?Q?VZ3+9xrbhmfn67cbEo6Lj53THR9bO1KtU4CXtk2adMD0hjHuVUKpNfdKHWX7?=
 =?us-ascii?Q?fwmEC2G1EM8tbbxRp1L072Xcv42SHEZ09Phb9Sznf12kXiybVfJ3nY3kfqSJ?=
 =?us-ascii?Q?P2NByb09QiR7MJpYdRaRoiYRjgqvUHC2e0CgYKBefIQzTiVUWGyvMM/wbhUX?=
 =?us-ascii?Q?t8m80M//sx3yxq6ElXWtK1nf2kXe4jYTp/BidpIXZBStTUvzmYWphKPAddlL?=
 =?us-ascii?Q?Cz205pA7s+woetsX7SysMu4z1TGD2qH1eUkn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:19.7599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60afde86-da46-4742-df0a-08dda3d2c4e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5732
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

It doesn't work reliably and we have soft recover and
full adapter reset so drop this.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 71 ---------------------------
 1 file changed, 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index da0534ff1271a..2aa323dab34e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4884,76 +4884,6 @@ static void gfx_v7_0_emit_mem_sync_compute(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0x0000000A);	/* poll interval */
 }
 
-static void gfx_v7_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
-				  int mem_space, int opt, uint32_t addr0,
-				  uint32_t addr1, uint32_t ref, uint32_t mask,
-				  uint32_t inv)
-{
-	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
-	amdgpu_ring_write(ring,
-			  /* memory (1) or register (0) */
-			  (WAIT_REG_MEM_MEM_SPACE(mem_space) |
-			   WAIT_REG_MEM_OPERATION(opt) | /* wait */
-			   WAIT_REG_MEM_FUNCTION(3) |  /* equal */
-			   WAIT_REG_MEM_ENGINE(eng_sel)));
-
-	if (mem_space)
-		BUG_ON(addr0 & 0x3); /* Dword align */
-	amdgpu_ring_write(ring, addr0);
-	amdgpu_ring_write(ring, addr1);
-	amdgpu_ring_write(ring, ref);
-	amdgpu_ring_write(ring, mask);
-	amdgpu_ring_write(ring, inv); /* poll interval */
-}
-
-static void gfx_v7_0_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
-					uint32_t val, uint32_t mask)
-{
-	gfx_v7_0_wait_reg_mem(ring, 0, 0, 0, reg, 0, val, mask, 0x20);
-}
-
-static int gfx_v7_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
-	struct amdgpu_ring *kiq_ring = &kiq->ring;
-	unsigned long flags;
-	u32 tmp;
-	int r;
-
-	if (amdgpu_sriov_vf(adev))
-		return -EINVAL;
-
-	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
-		return -EINVAL;
-
-	spin_lock_irqsave(&kiq->ring_lock, flags);
-
-	if (amdgpu_ring_alloc(kiq_ring, 5)) {
-		spin_unlock_irqrestore(&kiq->ring_lock, flags);
-		return -ENOMEM;
-	}
-
-	tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
-	gfx_v7_0_ring_emit_wreg(kiq_ring, mmCP_VMID_RESET, tmp);
-	amdgpu_ring_commit(kiq_ring);
-
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
-	r = amdgpu_ring_test_ring(kiq_ring);
-	if (r)
-		return r;
-
-	if (amdgpu_ring_alloc(ring, 7 + 12 + 5))
-		return -ENOMEM;
-	gfx_v7_0_ring_emit_fence_gfx(ring, ring->fence_drv.gpu_addr,
-				     ring->fence_drv.sync_seq, AMDGPU_FENCE_FLAG_EXEC);
-	gfx_v7_0_ring_emit_reg_wait(ring, mmCP_VMID_RESET, 0, 0xffff);
-	gfx_v7_0_ring_emit_wreg(ring, mmCP_VMID_RESET, 0);
-
-	return amdgpu_ring_test_ring(ring);
-}
-
 static const struct amd_ip_funcs gfx_v7_0_ip_funcs = {
 	.name = "gfx_v7_0",
 	.early_init = gfx_v7_0_early_init,
@@ -5003,7 +4933,6 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v7_0_ring_emit_wreg,
 	.soft_recovery = gfx_v7_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v7_0_emit_mem_sync,
-	.reset = gfx_v7_0_reset_kgq,
 };
 
 static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_compute = {
-- 
2.49.0

