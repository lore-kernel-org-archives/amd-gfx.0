Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F959C677C4
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1396D10E9AE;
	Thu,  5 Jun 2025 01:46:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ytVo/XN4";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E50A10E9A9
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P027tj364QNCFl6CetO9USiboQMZsfzgkgSlUNP2vd3maIlgwnEw2K9KpKCxSGZgYedlHaD2TfvfdTk1DLxSWpxabuchL+5O1hKhSqiKGC69u+Cyc3MqpVej57We5Xd3BhLlwi75gOdxm6iIBgqEukM7SQdc1QI4uY4+zOI7j2m+BPd4SnUNMo8ggE7+D/mLujsUG2Qc57n8u4hWfJrNp3szAEnMJs188gesAA8N3Y8GbxFt+IucglXkhn8sOVbfF2zHG2gyG3lPMNWAKs5OZrLkMI3wryerXOwcKBVx6FtrOnwnlqOmgI4ldh5Pp6+ODqHrCY6uKYLKLJwpZOa0pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cu6pPKctWR+q9OsfQZSRfEdXu4h5amtLDswIJhJXtpA=;
 b=nz+cG47z/rZFrT3lHzamKwRH8ct1wy1YJTOmBrQAVMGUD1vcByoTjsgu5XE6PZ3Hb1nHvUbArnWvI+V0PAL6PW1jPzmB/ymjvnJBevddIm3LXK1/eCYRiUpmysrWX8nPLGHwTPcnUyzdM4KjJmHGBUFzXpI94FheF+tOK5dvcmypZ1XZyj7gDUMNuCdE+kzHxQKV0o4ZbVSAztfaqI+fEW2Lt2S1QtM9Zw90jWvYSwOAAHp18iMc8bJHdaF7aNmfE1mC3GqdgsUCduagazCPGtDugCnZFxadfZ84j4qP2HS6npaw5/d567O0zjCAo1FMTSPY+XHk350W/N8czYXm1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cu6pPKctWR+q9OsfQZSRfEdXu4h5amtLDswIJhJXtpA=;
 b=ytVo/XN4V2LLJC/1d8cnfol2wUy984vYRUT1gidHsjpdlr6iQyVrB4ZkF9GCQu+u22jLoyXX7rqITYCtFQQLJktCHDUEF+MxgMZfQoXPemm3oBvegIOAzeHI6e6yXCM/gl7lQSK6GQvNGWLhhffEFf+i0m5Jw2V5rONYxqkuTlQ=
Received: from SJ0PR03CA0146.namprd03.prod.outlook.com (2603:10b6:a03:33c::31)
 by DS0PR12MB7536.namprd12.prod.outlook.com (2603:10b6:8:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.36; Thu, 5 Jun
 2025 01:46:30 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::54) by SJ0PR03CA0146.outlook.office365.com
 (2603:10b6:a03:33c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Thu,
 5 Jun 2025 01:46:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/31] drm/amdgpu/sdma4.4.2: re-emit unprocessed state on ring
 reset
Date: Wed, 4 Jun 2025 21:45:45 -0400
Message-ID: <20250605014602.5915-16-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|DS0PR12MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e37f0a0-ebbd-4118-b101-08dda3d2caff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qf1fvdjYs1Y2P7RncjJp6zNXaSMoGg3F4/QbU/iP1nPXgQwKFLtMiiO5gtOT?=
 =?us-ascii?Q?TMe0hN2qL8uEYdg3tU1/5s8eTK3eFOjAbs5+yFx4eUn2v1XY3RwSQlhbvp9S?=
 =?us-ascii?Q?3ze+FDGKkqDs0V9qzKQmWucVniltEGEU8R0PdNyHLrZzEJ/fFTyfzX6slAl/?=
 =?us-ascii?Q?j51yvQ9sP2f9v2l7sm3JOuMMnp8nu/j3GIEu9ohyFsSYPX8aNCK7/NZe6toj?=
 =?us-ascii?Q?EaOZZS01nKHrjJWDHjqzxEaWcYu7joor38h1PsHuvg84kwiDn0G5zDVJTJaj?=
 =?us-ascii?Q?7CCkQYsLayt8i2wZmXg/kXds+TVwOuFqM8Xu8kfbVRN6GMV/QNNosDZwVD+R?=
 =?us-ascii?Q?zPO+vyqMorIcXxZiaRtRD2lyi24dEe5QE3iBJGyc+Xk6h1aPDgOCtpDgR7e+?=
 =?us-ascii?Q?Zac02iNjI6TsQdUAHIfDzeltLvWJIukd9Eo1E+1WncSmxaDDUbM1lkNos+MA?=
 =?us-ascii?Q?gKTT+VlzamS/eorW4F16ixLeQsMQrcaXq1K7q+G1VZqYpzFqHqkB3Qhw7X40?=
 =?us-ascii?Q?Nn6sQzdn/PuV2CEyom91m7rJdzejXDKFWzVGKvxjG3k3ru9fletKUF8tutFD?=
 =?us-ascii?Q?7BSM775PaoCIvKKoIOZ8Qn+NtER3DCGDmz/qfAFrNGAhla9HUFqQAVBQqDc7?=
 =?us-ascii?Q?yFOohZVsmSBQd3l0K21J3Ig+2WyI2H2TNXmfcUL1ZR9QRFzu0tXDr0P5GdD/?=
 =?us-ascii?Q?PZUsCt8uMehJMrjH321cqNof+sv3+ztKHVo9VHcyoaiZ27XL0lwhVwpOyRt0?=
 =?us-ascii?Q?mpfwwvzIYKOhpBFPp/yBEMostqH9LUjoGyLl+gPJ0xjGsT2ZaTMoQqTIfkiO?=
 =?us-ascii?Q?YuQluCj1MotxQ+1UNIzAV0SSA8CUXjIe5A9E1P3TZpb1yhh82YxF/6IHAXSa?=
 =?us-ascii?Q?onX9B/9oJfawJatu3xZ3KiO8mjQ48J2Ft8H+i1MwNmtE236sxXhkr8XXo66d?=
 =?us-ascii?Q?khpzInRvAD/YQZiWXEgxK9c5bZDvT5q9S0uBh3nOp1xa+pFrDZ7riA0Pu3cW?=
 =?us-ascii?Q?2IpHpLtdb+u0RMWxjw0cvBL2tljEOSKdQoiRkzPBe80T/NSaIw7Y/KiVIoo2?=
 =?us-ascii?Q?0ilS1kACujonVpHGRHuyspLz3BdFh48wOiU0vtr9gXrj2Q6i5WhJPmN2jRag?=
 =?us-ascii?Q?Envh2nyoNr0SolHUdeIxw0yy89zcE9suXHb5INd+isqryRyYecBKb+xAtp4V?=
 =?us-ascii?Q?sbIodSbSmHrfRCYBVgVvv3EocN5Onl5iYbQzgKaf4/dT82Et3p33UyobPc1V?=
 =?us-ascii?Q?2PbkMhQi5S5RNs11NaX6RjHn2rvCp2kZw763gqeOslU90UYTeJEAkzRimCBB?=
 =?us-ascii?Q?BqKEiLDZWYkBfqY/dkoku2KHfZoJ4EORvKEYwvTcOB8L2sJoOODyIuTczlau?=
 =?us-ascii?Q?jzTapMJFoWsmv6BYJBfIcm7pZcQ9nk53jKeMNyU5PcBhzh1881KQ6HZfKEUb?=
 =?us-ascii?Q?9Qp2mNCoSP9A86Gi/guxgzfl5vx8UMO54VFy8NMtPyxro5vhNqsmVawmvutW?=
 =?us-ascii?Q?CPhc8Xvq0bHYu4EvUGymP0bsp3HXxANArMyM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:29.9957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e37f0a0-ebbd-4118-b101-08dda3d2caff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7536
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 32 ++++++++++++++++++------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index eb78bf04a490b..a744efd5c0354 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1670,7 +1670,6 @@ static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
 static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
-	bool is_guilty = ring->funcs->is_guilty(ring);
 	u32 id = GET_INST(SDMA0, ring->me);
 	int r;
 
@@ -1681,9 +1680,6 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	r = amdgpu_sdma_reset_engine(adev, id);
 	amdgpu_amdkfd_resume(adev, false);
 
-	if (is_guilty)
-		amdgpu_fence_driver_force_completion(ring);
-
 	return r;
 }
 
@@ -1728,8 +1724,8 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
 static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 inst_mask;
-	int i;
+	u32 inst_mask, tmp_mask;
+	int i, r;
 
 	inst_mask = 1 << ring->me;
 	udelay(50);
@@ -1746,7 +1742,29 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
 		return -ETIMEDOUT;
 	}
 
-	return sdma_v4_4_2_inst_start(adev, inst_mask, true);
+	r = sdma_v4_4_2_inst_start(adev, inst_mask, true);
+	if (r) {
+		return r;
+	}
+
+	tmp_mask = inst_mask;
+	for_each_inst(i, tmp_mask) {
+		ring = &adev->sdma.instance[i].ring;
+
+		r = amdgpu_ring_reemit_unprocessed_jobs(ring);
+		if (r)
+			return r;
+
+		if (adev->sdma.has_page_queue) {
+			struct amdgpu_ring *page = &adev->sdma.instance[i].page;
+
+			r = amdgpu_ring_reemit_unprocessed_jobs(page);
+			if (r)
+				return r;
+		}
+	}
+
+	return r;
 }
 
 static int sdma_v4_4_2_set_trap_irq_state(struct amdgpu_device *adev,
-- 
2.49.0

