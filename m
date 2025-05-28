Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82FAC5B54E
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 04:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F10C10E573;
	Wed, 28 May 2025 04:19:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v4Bop0K3";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FCD410E54B
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 04:19:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFAGXK+fpkCnyfr4T9Jq80e6T+5CEh8LzQm8fLDfKt3Y+DDj2cOcT17ug6VuG3dY8DzgGO2IbrNT9IOnyvFE+L73ynZ0gpw0fUVQK6UP8S222MjOhn7MXFbYZRFz3dYoiaKBHUQ6IwjaAyTW6cj2od3Gh8zzsyG3c+caIyaA4NL9T0A0uzeCrAbwN1nT1cpNWFCMsPTMCoHu8B8CmDY8DEcVaMsLfhJJUfli00aszffxSnlQ4DN9qxNcn0wacQBYXeft/lNdDsVfYYL+B7MUp4Wj/b47kRjR/CvZyE0zeFE9Wi9uVmh79x70tqMvzDN8LsXPQRrN/amykPlW0mSndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRvvk4eg1JqQ/hxHEg08NFm5v6TaboJLOgZe7TcmrLY=;
 b=EOi1lR1TRirui/W0zZnAOsyioEhThPCN9ptsVBd3NaUZ6jOsekLPVoCuNgpfMU29zbltLwd8cArrTcm4PDc9Z374IkwiJO9M00SNG1eKX1sTI45AsK6+x90rI0OHRnliArDuyu3c2QEWJ9UO7DFYVnE56tVYdwcg097Si/tU6MQlvurS0pZaykfn6DjjPSPaxT0DMK8Ib1IFkD107jAJEjh+x5uB5783mt0Lc0q++YyeuEW75mJe9PXNQ/xBnKV1tQf0i0pL90zI1SvSPcFk+Jwih/VTqCPHd2trlPpP3oawYjIgv3VX0x6ySEpJqQTNJPWu3SWy4Wkcixnfys9Hyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRvvk4eg1JqQ/hxHEg08NFm5v6TaboJLOgZe7TcmrLY=;
 b=v4Bop0K3wmB2SInGLPLYT4OwCZWjAEalujOATB+QvgzSLmF53FSHv5QY/Xkg1L9MHraQyCI2w7SBJrZ1PMNpbkRhD03IN0Jazc0HOXJLXbjzj4Kg3u8P6mpk5lQjYTqI5tDlrW7knqNHMjxrcwh4f70RIycdUVJzbAIjQV6LR7c=
Received: from DS7PR05CA0057.namprd05.prod.outlook.com (2603:10b6:8:2f::21) by
 SJ5PPF0529573EF.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::987)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Wed, 28 May
 2025 04:19:32 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::2e) by DS7PR05CA0057.outlook.office365.com
 (2603:10b6:8:2f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.15 via Frontend Transport; Wed,
 28 May 2025 04:19:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 04:19:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 23:19:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/19] drm/amdgpu/gfx7: drop reset_kgq
Date: Wed, 28 May 2025 00:18:59 -0400
Message-ID: <20250528041914.5844-5-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SJ5PPF0529573EF:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e545e22-5612-4356-9ace-08dd9d9ed8d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?09XLqFiThEvCtyE2mYdi861ucWGCqtyT3oE1cWX0FtBHbbmc8DenmdjODVoo?=
 =?us-ascii?Q?2o20HFPq/3iXVEaj2Pm5lsusLdWuffDm/RPHCCpu5MNAeTcrzmRdbRQ0Pi2S?=
 =?us-ascii?Q?of+AM3i4vbi/P8c3CctKIIHblHdi0kYhs4pchdGECxfsFzUxQ9JR57ijLsda?=
 =?us-ascii?Q?+fFVjev9U39S76v51X8kgPTDQ3eVtvuzQ4iVo+pXhvCtMsXFHrHnt80ehtTi?=
 =?us-ascii?Q?tq8Px7TFZK8vKdu/m3wpY8fDM6MTsfraHP3SMXwdBX8k8vDzHDpPguLwnJhW?=
 =?us-ascii?Q?2856N5zJUzaO9Ej9R7Da6aEnGo22alxgTro4NGR1sVe8S2CsxwSzElBBD+rb?=
 =?us-ascii?Q?6yxM9ejTYS+e6BtJdLuyBnTMy1wE/o7me2sMegrgO81ZJFaG8hBJ4iP3tbMD?=
 =?us-ascii?Q?+eGnY/NQfQXha0ywkrZet/MrWO6ZWYkAQ13EvoUPGmlJoWLUyX1SCkiJBdh6?=
 =?us-ascii?Q?9iWJCEmmGVJe2mrak4uw1xiH69eulmxPZxgM7JUwm3bShherCNo1AkUU5Axv?=
 =?us-ascii?Q?CtZf21cdVdkhQmR8c3moImv1pGFdWk8vzsqUnRCeW/A81X1ebsUUgVM4UroQ?=
 =?us-ascii?Q?wChG6aMLcZlIk36MH+D4TyoM1O+2QV7zzLXbi2hl6oaRFyvFVkobgoBP27DC?=
 =?us-ascii?Q?sgYJiTE5deY4Xw5GroIzoiuUbuIiOW9HgivI6yc+qYyOxt4ajap9XnfAQ2Tg?=
 =?us-ascii?Q?m6V+IF/JlFwKpRSGhhHqAVgQ8bCtgAmQouyC2nYVyc+EyqiIVIi5NNd4BHbr?=
 =?us-ascii?Q?jOoXGRzR5aSGWJwOAJUWuK1mFf5R4K6CBVBdPk32fmj1J6BllXKVz+/aH9+y?=
 =?us-ascii?Q?k4SahjfkXa4VEEN+NNPKku5VBw6oGtZb2ojjykEAv8TyaOas30lVPfGU6UOe?=
 =?us-ascii?Q?RCc+54ZxNiTP1uUG0/B/KZFR83ob9DgG+kg7BTCUUw6dxapF3/PRlp9gnpzV?=
 =?us-ascii?Q?dOgUZLoy6pSK9SPRtwWzTUqR23q6/O+kCIbQy9/LcR/bzgANLFX3rKXTGMEi?=
 =?us-ascii?Q?oVO6qqXBa7cMTwDmaWS+L36Apzj960XypLkT7auyzKhcKPLJkc8S+7BMnK5g?=
 =?us-ascii?Q?uY/w9Mcur2rgwTiVC+VF+W47JQhbzCAaTLTl4Nt6ucPFSsskX00fMbipTREC?=
 =?us-ascii?Q?gaV7IVNP63wLldNXC8RDuZ+2Ih6ire3XpIbfpF8uABigWdXn0C0JRrbcOAvL?=
 =?us-ascii?Q?YYBmig6p+gIvS6iI9hlKGiSEJG2rZGrgkrJP+nGcMf3AUv8oA/YNdqmGQ4J6?=
 =?us-ascii?Q?eY1eJfDMtbcdg6eZyLKwaNlzHiIuXVk4GaSRhWIqGh+4IFFXKAJBRmYGOAPG?=
 =?us-ascii?Q?DZkcPTBObpxk97X29CZx9+Qu/QejZeVjhp0EtAtuSErrPQx+Kd2tO67FpiDF?=
 =?us-ascii?Q?u3Km+Mzb81heV1txgdhi5aVth9LsK+IRt0C0R2x++f/QsrgOMq6HRuguMl89?=
 =?us-ascii?Q?WNgdxpJkOYQAVWuURFLwJm7V0nJj+YWS/WaEmZFPbEPpesNDI9YvQboyKzH+?=
 =?us-ascii?Q?tJhgaeLiVdf0ff4GhFnpQHmvW6aQqJnrbrjb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 04:19:32.3619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e545e22-5612-4356-9ace-08dd9d9ed8d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0529573EF
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

