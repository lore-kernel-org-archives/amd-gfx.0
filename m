Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3995C54FB3
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39C7F10E252;
	Thu, 29 May 2025 20:08:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dfxkPs2T";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EB4810E75D
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhJv+b7RM+5EwisYe9H78QwWVyopJu77fBAmJbsJS75eBYV185DNJdOfxtjTmtrE6s7WUtwdlI9IIfUArkqa1NETSfxN2FRdFFPb16tg0lHDKfOdUp1pcpx5ZeEsfTEz69Nz4aDkjcB03fXRvp0d4g5kQTf3y9NSZovU88bQB5+XLZSBKhE8RLT23QMErhcXyMeQkJszfAeGI1cQMj/vNVm76cdkVveKYVoWUe4KV0kohowJqT43eikf1SSjMTFoUArEp9EexXvJJ2TmWlFkEglSQbIwVuZxJ0hH49H+bEMib03D5bKk4ImPs8wARZw4dZX3yM8JI8Gir/Kfe4m0wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGaH+O6mg2HZ9ro4cxp+kByD0QcRSzQiXkYr3cOLG+s=;
 b=QHaqzbQZ5fxQfnLZgTMEs6CL59c4//wijDTwGeDi/YFzkdsvkHIbx7Hf1vuLrBIKzF5YZw74JzglJfQq9LGyL6RGj1sTSUFJwGK+6uW4eebaAjf6PZo0chZ1FUGc6fetVDrk6ouFzAk0A/Lvi4QkomeA9dw7dga9zm8FItCyjOWpaG4AYgaz++fhAuvlRoqcGN4VIICXWtXS+3GWbUhqC7Dc/cdbX/dhsZkkIJP2sjJt1AaAUKH0rmscxrKsCOj6k9+E2GKAumpe4eUwDM7Z+zv7pacLsh5EwpOngQtkOzDdEJhdX2t1zaJ4+8cVgM24uKP1wWyOJ2oXOoGgTRe42w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGaH+O6mg2HZ9ro4cxp+kByD0QcRSzQiXkYr3cOLG+s=;
 b=dfxkPs2TMnYuVu5r1SmoYFSBIhQLkuC+Hu+oPIcI2TB52qCtvNXv+e2EbKSpLI1ZxQhnk2Y1aqfJgGq5Z0mDLOWKOHScIcgArtUXQGRaZ9Bz1l7lKuk7oEaEtmLj3SrEjVPGXodC6alFDsOmAa76gD9TiX2HAmBDGvVsrTF3fAU=
Received: from MW4P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::21)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 20:08:21 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:303:115:cafe::fa) by MW4P220CA0016.outlook.office365.com
 (2603:10b6:303:115::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 29 May 2025 20:08:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/28] drm/amdgpu/gfx9: drop reset_kgq
Date: Thu, 29 May 2025 16:07:34 -0400
Message-ID: <20250529200758.6326-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
References: <20250529200758.6326-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c850904-8a4f-4902-5d6e-08dd9eec8fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1h5zMTS3bphgPuMqeY7sI5o18xjebyYaa2XVJLnZhoZHGYf7+lGN5vNoudWd?=
 =?us-ascii?Q?1//HwVCUT65kg84qdahbgn2SPsaSD4evmfsun/t76jPUHy5zA0UFhZ+smILA?=
 =?us-ascii?Q?LG6HWs1+floWHWfSIVpf54DY+qZQmlxTq2NWxOKqA/Cm9dy4Ti4E7l88UNVs?=
 =?us-ascii?Q?UiygoroMkbPQOUBIt+kXyHVplJEZYTQVxGa65oiHrddnGi4b9fBgiIRkW2Gc?=
 =?us-ascii?Q?Wtv4d/J48dT05Mh8s2B123vGSZpzFg5hABi635Wm4EUnw2a0qL9BYiYe6CtC?=
 =?us-ascii?Q?6zsVuT5WKRSwF687O6q/2jwxsv1CfiUwQv1pM5d+xSY/68i86j4HxhTiHSwB?=
 =?us-ascii?Q?Ag/hL5d37PopCqoXGKX9pTdPWASqQTKGeh7UheU/OECs4DT+yvXIWKAotOBl?=
 =?us-ascii?Q?EkS3Jdd/SQbImumvM1XzBEkpt5mUfYgKcV3+L2qtyaeIhPFCTlSFah7RieDU?=
 =?us-ascii?Q?rYh5p4vbfXROxQZFsL5vc0lMYDNno1uwIKMiMDcz2rYMvH2lLZzZ8vIhg7jA?=
 =?us-ascii?Q?Bo1hAzwI//+j6Qr1QYYFUjcxTPMgFvJcAsbkHXosVlQIrjYnQ8GaiU/OWmwg?=
 =?us-ascii?Q?HPR1xSuvtaZfQqRyZnURIOJfgDkLW5Yz+J61jshBXOUX5KWozwTNnDlUvu2r?=
 =?us-ascii?Q?q3N//9fwU1egL09FD438CFYvukaGA6u0KVq0tuGnXQ7QWo0m2CTgi77x775V?=
 =?us-ascii?Q?f0CB7rSz/YI/xJ6GNY0OuYZBeUD9dlZnBpuKWzA4N76CuMvaTaGdOub591Os?=
 =?us-ascii?Q?MUPKUx5Xg5KFKuZrw2AH1GdaLQWzON9sbD9vOIQar7gUOf5XoXoH4GEbAaZ1?=
 =?us-ascii?Q?/rMuHSCS6GbaiBJ3kzq+SBmlvYgl303aE0W36z2V1SZ8NZ69+jFjgR+ugJ3Q?=
 =?us-ascii?Q?N/+xYrDozQfb2N4jZ5qLfFoeQWsZVNYszSu3/HSNt6E7c46cIbOfDCO3okm8?=
 =?us-ascii?Q?f0xMhcxe9lPde9zM1lM7BztPnASlSw7Ewb2g2SCwcAmoK73PAoZ5aERZGAEe?=
 =?us-ascii?Q?QjOOVh75b3BuTdJ8vZ+29NfYFcslpWiIFuxK9wR4LvI7BuVDQfmi0C+GLk0E?=
 =?us-ascii?Q?5EuYCGRRM5t+J6X/6B5dMKB/d8szyFwip0GbTsyE90gJqB/kAOlfm/K06iOQ?=
 =?us-ascii?Q?XyVkXI51fSjJbqOhSilC+KOBNzM6Rvp4RwhpXuAm/4ruQxRd9OFJ6D8lfxpJ?=
 =?us-ascii?Q?CNHbPbaczs8CV42T0oIvgzmiGO+cywVAmvDh8wr1OzVr/AmrE6izJ/Eh+5fK?=
 =?us-ascii?Q?T0U+Wb5+cPmXun8EKMpnrlGMfhTSqwTN38m7b4+MEtxnQFOJLenbN0K849sg?=
 =?us-ascii?Q?BtPNEsxTYKoxxqA32KuOkuC31KPF3Qn73WWqMhRB+WKKOxwiwl1sSpm229xK?=
 =?us-ascii?Q?2ny0jlRazdSXL7qdunC9Y8H1XckDfFPiUoWU6f2JnTEUJC+/xk/LiVhP/tmm?=
 =?us-ascii?Q?irT5G1dbX6AAjuUmVpqrdCkJSDDHx24q8of0/gllnzaK0+3qmhPuvi/AkVIZ?=
 =?us-ascii?Q?AYY7C1p3fMq8jnj9LxRcUg+BceqpnkiJHwXB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:21.6295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c850904-8a4f-4902-5d6e-08dd9eec8fbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 46 ---------------------------
 1 file changed, 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d377a7c57d5e1..d50e125fd3e0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7152,51 +7152,6 @@ static void gfx_v9_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 	amdgpu_ring_insert_nop(ring, num_nop - 1);
 }
 
-static int gfx_v9_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
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
-	gfx_v9_0_ring_emit_wreg(kiq_ring,
-				 SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), tmp);
-	amdgpu_ring_commit(kiq_ring);
-
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
-	r = amdgpu_ring_test_ring(kiq_ring);
-	if (r)
-		return r;
-
-	if (amdgpu_ring_alloc(ring, 7 + 7 + 5))
-		return -ENOMEM;
-	gfx_v9_0_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
-				 ring->fence_drv.sync_seq, AMDGPU_FENCE_FLAG_EXEC);
-	gfx_v9_0_ring_emit_reg_wait(ring,
-				    SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0, 0xffff);
-	gfx_v9_0_ring_emit_wreg(ring,
-				SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0);
-
-	return amdgpu_ring_test_ring(ring);
-}
-
 static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 			      unsigned int vmid)
 {
@@ -7477,7 +7432,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v9_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
-	.reset = gfx_v9_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v9_0_ring_emit_cleaner_shader,
 	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
 	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,
-- 
2.49.0

