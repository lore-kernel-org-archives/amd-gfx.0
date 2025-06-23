Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4D0C7EE2A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 131A610E41D;
	Mon, 23 Jun 2025 16:15:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sz7GqmjK";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EF6610E41F
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nxcj86/6AfMI4QhG+/cT8JAYverZySmO8bT2l3vmm8vNkZS+uSocQZHpTQj6myBVkYUoqdMulVOLSFAFzJ5kabzIv1DD5rCLrLBjjy9ivIbX1BChtIlGbM0pC6b9fieQ1K2phm1a8o/gzG4VVfPmegPJdOxnNwz7dr/ugZ/q4zbxiYyTU5qwTWfWi/WbeatsTrwnZlF+1vVuBEBPyStOie9J3eJiBGC+ji9PIRzT08iwnXJAIgBpoM6YhvaVfXKU6jamwg3uOy1C2CANtDUc6bWnWeXVZcAUFLFZUyNmibde8v+uwJMO3Hc1Fm2YCT7L6pnpCNZQoJR+WU7aWCYeKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlm61OClyPuAl9pD3Q6LkDUf23UrMRQ8TMt+PUVqBI0=;
 b=rtqnE3hhz6Eugn+WGthadH6LtoXBXqKM+X6IQR0LcOrQ+M5RlIi7NNYeSOjQ7djtgADBhfzOXOuEdE6fMY093zBopAoz6kNnlrQSfFM/m16w+TYFldNGwSeEcJvxJPqb6wSbab0tJ/VGLF45B2/AMFkh8p7Q4aD9fBSfKIyM82m41F4E6emB01F7sZJjul7ONIpPYL+nqeGKVfH9Xgu1XOrC5YMOp6q8yHizy0iNcWraUJIt2MweajkcpozW3iT09cqXaZlAsaA/BoiZw3SSM5efO4Rdv+TtaPZ0DYo5UWya5o1TTOBAPspXVBWGEo4/kKDzRcAH3mRnjVtVPr0WyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlm61OClyPuAl9pD3Q6LkDUf23UrMRQ8TMt+PUVqBI0=;
 b=Sz7GqmjKna6M0X1avP9yr5BBGfopx6O+KY7M+YXdbRNJjLoZ3j0Coil/pI7Tv+bkDScteYgI12ihU3KVePCmV0sPBsJuQO2jsL6n1jsvca5oZhD95hHo/QKb5KmApF2oHaDrQVterQUzsvWnWNsPYQBlvMRCZ588zVjpI3Y9qsk=
Received: from BN0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:408:e6::9)
 by CY3PR12MB9632.namprd12.prod.outlook.com (2603:10b6:930:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Mon, 23 Jun
 2025 16:15:12 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::e8) by BN0PR03CA0004.outlook.office365.com
 (2603:10b6:408:e6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.28 via Frontend Transport; Mon,
 23 Jun 2025 16:15:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:15:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:15:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 24/31] drm/amdgpu/vcn4: re-emit unprocessed state on ring reset
Date: Mon, 23 Jun 2025 12:14:30 -0400
Message-ID: <20250623161438.124020-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623161438.124020-1-alexander.deucher@amd.com>
References: <20250623161438.124020-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|CY3PR12MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: 8926c007-c00a-4403-30d1-08ddb2712184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PVgGnjRfdZ5paoPNKbQP21AaTPER0LftSQAnWARFg+pYn/5BCD10r5I3x+1R?=
 =?us-ascii?Q?idGiqxJYpETkNWbbBVnaMGpmdRwjsZziAdULgkDq/pv92VXPpz6PZQWYjkvN?=
 =?us-ascii?Q?7WaAtFXcoNb3t0fFT1H5jdgqNnG47q5ujgv15l/a6w6FkQGQSOC58/YSEWQx?=
 =?us-ascii?Q?yre9UX7Ry9P/JgMG6Xp1LKr+2miCpkpSvsU3kSdJPNGWS+Xyyfb+Qy5tfV2P?=
 =?us-ascii?Q?5BLYbPr2YI2puSZdVOUi8DJ5a20W1PL4ael+tqaYt4KvwX++2ebq0o5k8jOj?=
 =?us-ascii?Q?BKq27U0VgfWKCXNnqdH+qGa/BHJktppfLNm2QlLVYXwuoA0FZp2SZaN10hmU?=
 =?us-ascii?Q?+28wduAjZuq77TWtj2pfpEU+L51xLNXaG84/A+itV9cEBnzq9jPPCt6TQ4DI?=
 =?us-ascii?Q?y0wVuEMOtTgSCxE3Lb2ou6w6WzRf6AWY8LJHsdAJ5l+Vmpb1t4w/AuYHyTsO?=
 =?us-ascii?Q?///dcBHU+gD+IhVX5zezycWU5w89b1NfApSs+mOZt/teWBkH8CfK6YKxYpbu?=
 =?us-ascii?Q?JkBaNX6z/+rTA51WawRyxiQXguVNu4BAycHKzL4x1150kBOAsNzXZBuf7Wpk?=
 =?us-ascii?Q?p6G4ILPQtprzFM0TmqBlymx0N5iEV1Ra4J3k1m0UJ28o82IrhQFwREgBrkTk?=
 =?us-ascii?Q?Ew6N56zrWuQx0XYH8Dnz1/7u+IK9zgBJLZUjwRh2i00CNLo8cABWb2gtao4d?=
 =?us-ascii?Q?tyqIAHAozef8zLd/swVig5jQ2z16grro9vd9PL6f6Fu+N35RJ39B/lgJTSak?=
 =?us-ascii?Q?W/yhYu33dqrp0xFKJn7DNrYcIc2WI/FMRhX/xuib8QenjQrsnvYZRNje3+6x?=
 =?us-ascii?Q?w+WusmqbQsGaU8IgV2Fels73SsopHoLcnTT3Yvb8/QtpuOLFq9UtIhn7BM8P?=
 =?us-ascii?Q?+77gDwQyzocdtKt2kHYlgj2KHR8ncdhw1MNGNq0roSuuksx2heobWsd+aKpA?=
 =?us-ascii?Q?2/uF/V6Yi/L6lf2NbLfyTYDaEi3/m2jCTUSfDYumxoo0+RItzzzVjsQGvXpC?=
 =?us-ascii?Q?65T5pmQGiwYNC71hlzOiYBYOuLi8QENTvygiCewBb+tlO3Y8NiM69TO9pIDH?=
 =?us-ascii?Q?Z2qVGx3y38F66gL2Xtm+cEQCWUStmho9adrKEMl/f/G1ILchTkpCSbXFlILe?=
 =?us-ascii?Q?S7md7dhrjXvihgtcofPZB8iKhEnQvHJmIJjes/eJYtA/60SfAAHOhojyZIN+?=
 =?us-ascii?Q?g8VFLVAWFrjSJiSrcsAAhCIi47qaLCDIdbFPETDcvGeJ/PO/Q/brlWe+Oynj?=
 =?us-ascii?Q?1qtnpBGT5qTGNVMsE5P9ZEUFN3NzsUvxnRODB6PQX/8+a0xMlTgHdsHQtflm?=
 =?us-ascii?Q?J7bdDS+1qw586CvpVqvhl2VgZpwYN56UpeK7fB1+WX4viCd4P2Qxe2WLooO8?=
 =?us-ascii?Q?BDcBdLgCCiUPHDW0u4kyYv1XhMEytyIe1Gp/VHy0EqXux5cN3Yx4hSlQKW1x?=
 =?us-ascii?Q?p1UZr0Fk9pVXDHJIm8LLwcXZaLkVHhtBPniwMOM+BiO8Qr3bBcUwHqfPW9Jk?=
 =?us-ascii?Q?0zFomE6wnP2U7eWgjwM39kaaXHO11NQSG8VP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:15:11.9429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8926c007-c00a-4403-30d1-08ddb2712184
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9632
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

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index eec9133e1b2c4..9bf1a345ac2cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1973,21 +1973,14 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
-	int r;
 
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	vcn_v4_0_stop(vinst);
 	vcn_v4_0_start(vinst);
-
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
-- 
2.49.0

