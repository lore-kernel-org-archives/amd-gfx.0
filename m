Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23574C61CE5
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 04:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4997510E543;
	Wed, 28 May 2025 04:19:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LycSmpgo";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16EDC10E55D
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 04:19:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1xKubkuPROh5c3yJjiTWYNDT5v72M4CN4d+rXZW2mXBBP87MJy4cWcm37OByQmzTbX+GORmeiePd7JOvUFjl7j5nLD5wI/gIk1I7nS0aaHRGmJ96p99kvZYXJdewQSFPEZWbql9PWo8w1lHeNUEaVnH46ao7vkjAtII9qGQLhixUjfiWJ4EUPGMfPUN/8vtzmwuc89Ch68XdDun1Jg6YuYXq99UuZofU583U0zX0BiLbj7029atuu5U2aw4YikRjFHYwZT4iDE/NoK/5v6e2pXWkWqByX+hwM1RJupohOSxKLff/auKyzl7K2Jys7LnmvBnTheZl2vNO6fs0yi/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6EEB1MtKOFZNktxIn5psSozCBcmOkybPxCmL8XAm0s=;
 b=IF2WERyxh7o8X2A1rNWqppN1noxv3innAueKnwRtvmE0xQ4Rf7nmCtg7XBZwkVC8lmtm4z4UTRKtiIJQYOsvVxP8UzFbskUuoMmt+/Y5HNxyAaPucSPMcaEEIcpOoYXbzgVMzS6KCWvZ4IhAvgrFqeuMQt1XpxWKb7X7aAIBzHsiBDc3LLAZYmPu0l1CWGEcLuZ07hWxeMsuadjC61FTp/IYzwChBQyHK3P2mrkxEcg/LSlYx56axbKgCQYKc6d9poPQ6R6eYfMOzLzj2t8miK7Se5kwFZ/88gpjOFl+OsJsNOm8MbDNFPfBmb2/b378UNorm4iIZV13ooL+UzNnyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6EEB1MtKOFZNktxIn5psSozCBcmOkybPxCmL8XAm0s=;
 b=LycSmpgoweX9s2Q2h/IuTMgKAcL2X/lsoLQRNrKtlc4KvmqzrEWX3NDztqB9BVi0I4WjYQW0eAgK1F9dSIhy+Jc9gD4tkTQJGQXCwPbNC1mgA/nK1jdx7mHCeTup3wAydHEQzcYoF14mvMIADGIz/tdT3XMfqXHQrDt2CV0D0mA=
Received: from DS7PR05CA0037.namprd05.prod.outlook.com (2603:10b6:8:2f::24) by
 SN7PR12MB7417.namprd12.prod.outlook.com (2603:10b6:806:2a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 04:19:33 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::ee) by DS7PR05CA0037.outlook.office365.com
 (2603:10b6:8:2f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.15 via Frontend Transport; Wed,
 28 May 2025 04:19:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 04:19:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 23:19:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/19] drm/amdgpu/gfx8: drop reset_kgq
Date: Wed, 28 May 2025 00:19:00 -0400
Message-ID: <20250528041914.5844-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528041914.5844-1-alexander.deucher@amd.com>
References: <20250528041914.5844-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SN7PR12MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e055833-14b1-4267-b517-08dd9d9ed95d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AExeLZC5nc3rWwNlIgPniq3h/6D/FzOk+F7aOX4F1z0jYodrTG1DPkIp6iH1?=
 =?us-ascii?Q?MHSuGJ5epxIspoB6xGkWr0qgnWBLcMH2MFqHLpi+VBVjzZL703ESnPm8jjW1?=
 =?us-ascii?Q?dx0snmfYunxzRwDVAJwohzj62c5MNzw2KnUX32drm68ZwQ63bV2pF4EDpEEA?=
 =?us-ascii?Q?9xR4TXbHNHfOsMfmzKVsW2Ag/5z3lNKALHcjEiDcGM0vlnEMXQ8BKLcHmeOv?=
 =?us-ascii?Q?YBdLoNSSA/iHeBXx3TMTPgg5RYwfti6reLApvaOjqSkNrALWqg6rqlJ56DWW?=
 =?us-ascii?Q?z1a+Y99MqLhpSwW5jK8e49QdvqlgDU+9ETXE818B1R7b+rzVemmAzqgzycC8?=
 =?us-ascii?Q?Z3SjX7kGbDm1FV6cf8cgKDeQgcNcVcmPZFdhbR98L9iHQ3LabOSHpoaO6ULB?=
 =?us-ascii?Q?U2YK4c7+fft3NepHuMqQxWiJ5DXlNlxnAoKLoM6mKgLPRI+1yQJ6Aauw80xI?=
 =?us-ascii?Q?8P6FpJoozyHefJaytPy0+Sl89p9cH/9Bq/q+6CPyzVwPv1+5vnpdfYD1Zm2z?=
 =?us-ascii?Q?4QPaI9IbpFnRQNZTl8+5adyQ7S1Pcb4k0kpqu4ni7cguYSxWZ6zeOfFiGWfD?=
 =?us-ascii?Q?qBHB4Nq4FEXcuXOezlmTE2GJPdWMts7luL+emce95NaCbv9LNjtcysqytkw3?=
 =?us-ascii?Q?mVsdn0GbsLe6x/IrR5sn2AZfQGUJP8bzRhwUJwyJ9ZKMNmyr4hhjPv86772f?=
 =?us-ascii?Q?CY+5b29vFLH5L5Pu1lnuwRTpXuIAhLSkVJzGr9wG4wW17niCeY9stg3GIjAv?=
 =?us-ascii?Q?9LaUvZlTikYzwbD5QmntaSCn7jcSfvK+/Jomg1BR0/GqPG9agdXg5C8OgplM?=
 =?us-ascii?Q?aEgUy8yw9xDWA6xtKXpz5/LUDTNIpXkaXSRtTXLVEl904vhanqKaaaDVFBwJ?=
 =?us-ascii?Q?SyKDhpTOBmi/XMktajnheIagLzihKNkhT6WXoWF6rhgHB+oHdO0QznD3twwp?=
 =?us-ascii?Q?2F7RHKL7KYSJCtHg7dU+zNA3ak10USGu8S8ug/ZtEAAVAqYQCnbcPHlroy0I?=
 =?us-ascii?Q?P5W6Wtha8aHfNA6Z/sbAi0ez5EyCgFHEVpCvFGL4horpVjU34DmchibechWJ?=
 =?us-ascii?Q?ELb0LVKRMRnxlxE+1Fi2461njcP3OCLrYxR4xXJBueJD5QBdEdXPvqTwtN/n?=
 =?us-ascii?Q?Plesbs62sRq+irxZVgziwQk6Qlr0n0KOn23Evc95gqbe2tNObnEJrscEUGIu?=
 =?us-ascii?Q?WhiucJWD8hcNfS+gyg63fs7VpOMhMgdH8eGKJeQg0PdsMrBaaObLUT+1gkrK?=
 =?us-ascii?Q?oGIACIgakiVVWz3V9XAyN+1iaXYPGrRW0t5rAsSFEyczW1n2mjvgbTmJTGs3?=
 =?us-ascii?Q?+ftgfygr3jKU1NRKnJPLDsNSZe5pvzery6dZOpW4TZINgToYDmDHDD2Lq/Zo?=
 =?us-ascii?Q?ZTjxlrCdcM/wOY9kPkLVwA9I88DQpkWJ9z6RW1lqQaLntx3zSBE8L6WO67GW?=
 =?us-ascii?Q?ZaE5tSV42FWCxJGUBQuDZ0xkp2EPWBHAMHan5tCt5TH65u0gZv6ivbuMIoK5?=
 =?us-ascii?Q?OtTbfB/x7NVqP6ocqd9IXqIeVpPKEoLjPC0t?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 04:19:33.2856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e055833-14b1-4267-b517-08dd9d9ed95d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7417
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

