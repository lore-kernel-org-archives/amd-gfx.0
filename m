Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F30C61CE8
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE31110E7C6;
	Thu,  5 Jun 2025 01:46:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rQ4yxaVK";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF5B110E7C6
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0u/Wg1SKqFjMRFBj8KdBtzosEddsyEIuI5at4oJSDlSV42Osbpe1nZ2VBSnv2pAZLSkiyQX93f3cyAGZ4DcRnodKM8TyiSAK1ec8OKeT/IYyAUOePBxDDkkflvewRoPNDILk0LJt3swINo6OEgWMYACK4sYZR4zPnBuwbIgQIn2AB0lW1UDdXOR1Y38XqydmMdHcmxo9GubcaeOlJoMVKQwdN1OWxVEdKoNZn4QTkyRlbg2B+eWhRwiKkJAQ8dJ28b8UEEB77ULY2RSGndrTat0i9unKrP8jNzQg2dqypWnMbivse408vBYKxpigyZKuxLW+fsdbD68rBUk7cmsEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6EEB1MtKOFZNktxIn5psSozCBcmOkybPxCmL8XAm0s=;
 b=SDWW+odBtbFEMeur1LUss2c0q6bL98igvgQhjnt1M1kn4XnbnVi4VvVM6eiDKM2Qu7x+zm41vwMjwqq5PxUqxCO8jzZkaCNzlj5Ow1PRK8NkKPXwICSQk0283GuSQwJx9WDBF12/gXrBymnefqi3O+Bq8yt99twd1MdyQLOwgzNWGhADMn6IjZYkPhSHTQbEoLe+JwntSLfdnez1bGHqEv9VYemC+k6k99BOIkamtooREFEuLAR7awwgEe9z1DKgz9BwUbepeUp+jGGZpNw1CkyGAPJ/h7QOTuj+6IpLlVZWxRRzpa2jz9hqLAil3cXVxy4jPDIPwOdUjk7Fpw98Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6EEB1MtKOFZNktxIn5psSozCBcmOkybPxCmL8XAm0s=;
 b=rQ4yxaVKfq2Rt8gmdz6G/7xXmUED1YVylz0G7E77QuyDndW2adb5/eA0bscdC5FjPYZA6lo876dLCE42pRM5R8uYcYJNZTOrtZpvO3fPuKZtXsl/o38WDrH5sWcj/Hyh/NpJZ+BnkbHf4EozKimItqtYdyZDPw9koAwZg5DbqkU=
Received: from SJ0PR03CA0150.namprd03.prod.outlook.com (2603:10b6:a03:33c::35)
 by DS0PR12MB7512.namprd12.prod.outlook.com (2603:10b6:8:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 01:46:21 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::c0) by SJ0PR03CA0150.outlook.office365.com
 (2603:10b6:a03:33c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Thu,
 5 Jun 2025 01:46:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/31] drm/amdgpu/gfx8: drop reset_kgq
Date: Wed, 4 Jun 2025 21:45:33 -0400
Message-ID: <20250605014602.5915-4-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|DS0PR12MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: 832fe6d4-6e48-4f5f-ce48-08dda3d2c5be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IJ05KcnQhyvi9Mwipn/VKprst8wE1VC1676FBbC2r2LFS82l3b4x/DtArs9R?=
 =?us-ascii?Q?sHD2qVMNlH8vk0JQ5Hg6wkX2e1unRInxThb/PXn7XL/BxCIbi4LCdEPhSWY7?=
 =?us-ascii?Q?aU9YrDoCyU9WcOreRk7U8GJc3RDvNM1cVIiz/29BHB3q5hbqvHOZV2Ziv6F1?=
 =?us-ascii?Q?kdxFt9WKmSguZgHgY8teYqZ4yzcCr3Op2NXI+jWAlTXQ7fbolgxSihIPkuFL?=
 =?us-ascii?Q?ar9gXaJ/hj2aGoyyQ7fZ+56qMOoNkalMjHzW2pt8jNJgYHQvNEgejbJWgyeY?=
 =?us-ascii?Q?FlAowrZERuWH/2rU4xxGMGPpn27HJbY8n4zKgB18XyyjSI8ScSuo7ngaaIuR?=
 =?us-ascii?Q?L7bjv2/wvwsBfcxWo1JGpb/n4i32xFy9thjAO3eoj7i920DmsDQCKMpBO4L/?=
 =?us-ascii?Q?r3L4nxr0bpVvM1tT2yY6H4cIS1udw9biscFwZ9jjdd0mvRpOONMQHdv6S5Vv?=
 =?us-ascii?Q?xWkJlVLTAMu/eEZOtXpgKFxdOcZURzJFdt9YaYVs4z15hjzstdrwFV/QNlF/?=
 =?us-ascii?Q?2C+ZQ2eUpsldfgMC8qcwboRWvAs4fLla9Tt7gLb3ZF11m3DMDHaNNNGYPVqa?=
 =?us-ascii?Q?UdUJ26NebqAVBvHXfXKjVX5TGlZofISe/qHRMxHDynR6nNkAXVOJ1+L5PKPR?=
 =?us-ascii?Q?GPUjnIBuaZiicDnpOO5d9FrJO6rU2HPR3HH0eZ5dbkMwOILPGpfpHO5g+8ZX?=
 =?us-ascii?Q?DtKnMx6+QJAdtQeVfKyrOEIurHITcxZoLVZBZO+T6OFpCz+cYzYMsarN6ND/?=
 =?us-ascii?Q?ZhRT+anmpvRqQDCa4un1Uobg53rq4gxrGy5S/pPZG0BqODIo1VbZHyFJTIVJ?=
 =?us-ascii?Q?1T0KQMwiDC0XWTK/wCdpNfm0fJov6v8Kr/DPniICVCKPlrb1ZQVjA7orYzS/?=
 =?us-ascii?Q?WJG3RA165JToS2VIQZYaeOBw2nFa0KQ0nE92BhseQx5DWiioJXETVzPNTxG/?=
 =?us-ascii?Q?aa4F7C20AuNQJvFyNZxyt5/Ay8ILP48odMFrkBHAYxKA+f7e2Lu5OJlntzij?=
 =?us-ascii?Q?UTHrZ5Zq4b7e5D1Cr+aKdyumd/j2cEZPEwtXuWrG9B8KmAlDLEgfqW80+Zug?=
 =?us-ascii?Q?iNsBEVxni5vzcg9L8iMfg0v/MKOf016x0Exh08njeMv4yQ/B5pKKJZMTjArL?=
 =?us-ascii?Q?1l6sm/7jmrR2JyFQaHEKC2ugv+y/Ld2prpSb98gCFhgu7pHEoS1fgQBy0Dei?=
 =?us-ascii?Q?W21j365Y41mCl+62DKf5rf5288TXhWZdMVZyw3uU/s+0jF/b+LiqipjqclHf?=
 =?us-ascii?Q?OxrkDGlVE/gejXMYaThj9WKbo0X4kd1iKCB0zVzTtMvHJGL70VsOJiizATWA?=
 =?us-ascii?Q?SqLVcRqW7nSScXXBTxtaa6qR/Lf5Xg9eHeeVNbQUoO38WMpSy3/8KHJJ837J?=
 =?us-ascii?Q?kdL1Czwz6+DPOOP4KqLlox31WYmShwJ8MsIvShGt7vJaTqL87dd4VKRiUuHm?=
 =?us-ascii?Q?+u7df6klJV0RSbShNvbToZJqQdwrzL113GJAeHQjor6fd8mo8FKlo52rZlss?=
 =?us-ascii?Q?v58rHyVaCllgVUXh47XPlFjYoD+EQLLwGJDA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:21.1816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 832fe6d4-6e48-4f5f-ce48-08dda3d2c5be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7512
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
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 71 ---------------------------
 1 file changed, 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 5ee2237d8ee8f..68c401ecb3eca 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6339,34 +6339,6 @@ static void gfx_v8_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
 	amdgpu_ring_write(ring, val);
 }
 
-static void gfx_v8_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
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
-static void gfx_v8_0_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
-					uint32_t val, uint32_t mask)
-{
-	gfx_v8_0_wait_reg_mem(ring, 0, 0, 0, reg, 0, val, mask, 0x20);
-}
-
 static void gfx_v8_0_ring_soft_recovery(struct amdgpu_ring *ring, unsigned vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -6843,48 +6815,6 @@ static void gfx_v8_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
 
 }
 
-static int gfx_v8_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
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
-	gfx_v8_0_ring_emit_wreg(kiq_ring, mmCP_VMID_RESET, tmp);
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
-	gfx_v8_0_ring_emit_fence_gfx(ring, ring->fence_drv.gpu_addr,
-				     ring->fence_drv.sync_seq, AMDGPU_FENCE_FLAG_EXEC);
-	gfx_v8_0_ring_emit_reg_wait(ring, mmCP_VMID_RESET, 0, 0xffff);
-	gfx_v8_0_ring_emit_wreg(ring, mmCP_VMID_RESET, 0);
-
-	return amdgpu_ring_test_ring(ring);
-}
-
 static const struct amd_ip_funcs gfx_v8_0_ip_funcs = {
 	.name = "gfx_v8_0",
 	.early_init = gfx_v8_0_early_init,
@@ -6950,7 +6880,6 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v8_0_ring_emit_wreg,
 	.soft_recovery = gfx_v8_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v8_0_emit_mem_sync,
-	.reset = gfx_v8_0_reset_kgq,
 };
 
 static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
-- 
2.49.0

