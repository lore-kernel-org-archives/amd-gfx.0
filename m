Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60784C5B555
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0C3A10E95F;
	Fri,  6 Jun 2025 06:44:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dDtn03d2";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36BB510E95F
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3G8vtuHC58Ud+SkPUqn416siQQaIYBaHicw2kSs4gzEu6RHwppXIMk8Xr6euFkZcuvGCzVF83ZNOz63gamyAtv4BAla5tshGp9CEL7cf/JR5HU/21bK6OJuDam7Guj8szT7ARS8W2B+ZWWdyI2u8l1HPnT7ORijGDyalfKjTE5hDhJ7rjMgUQhbLoATKLzgqdoV6fThgiqjAMBo/D/YQgGue68MLsWYTm+nRPDMA1o5CrKYK5CQwkbHKTaUcvuJZWojG7mBOdtStQb+axq1gSqXtHuH53+xG87f4P70ri1GRKt5Ofr2E9+5IXCwt4FYIaJ7/1NsfvXhQabmga1Oug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XcSlJiUnhmtAIZ7jBkWsnpvn9fAhKh9MVdIr3n5Fk4=;
 b=EZkVSOQxjfbA9Nc+FFMxvl/glle9TDxpVzjbKxxStDeZ23fc+V9Tcca/Zzfrpn+gnFI052+jewGfvVuTFWg3o4nLSSSz7XWnWdtoDek01OPAjn0fVx8NTl9fuFWG+2AkhT6/0ypaEjOYEzkDyOOTOenS3PfIRuc/9i2Ru938F/qqFbvoAl3ASC7U3f6ntMVPxGNqmtpgbeTB/MyfwtRcQaBfZ7ADxlKfAradOfj8d5D+y688+gz34MySsu4DlmG1M/Jny1D+cdyLsMxgBVK8rb2pjtcLbHOmL+j4sTCkOpnunYXIARXnLelbVbGLO8xdysk6noiToRy9A8DrSySi/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XcSlJiUnhmtAIZ7jBkWsnpvn9fAhKh9MVdIr3n5Fk4=;
 b=dDtn03d2MuEwrIJvOFgYHMrG+1FWLda4bYWGDz6VexbclVAZroBYWcoIFQSrWUmljGyAjGcVKvuSNcp9LXWiege9W4fzdtBba5CB3llfr97lq+9W2YM7NAaXFdTE/4cPYq+opI//teb88bTZbF2sGldwzU2NbCFeCe28HemsYh0=
Received: from SJ0PR05CA0145.namprd05.prod.outlook.com (2603:10b6:a03:33d::30)
 by PH7PR12MB9128.namprd12.prod.outlook.com (2603:10b6:510:2f7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Fri, 6 Jun
 2025 06:44:24 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::60) by SJ0PR05CA0145.outlook.office365.com
 (2603:10b6:a03:33d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.9 via Frontend Transport; Fri, 6
 Jun 2025 06:44:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 21/29] drm/amdgpu/jpeg4: re-emit unprocessed state on ring
 reset
Date: Fri, 6 Jun 2025 02:43:46 -0400
Message-ID: <20250606064354.5858-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606064354.5858-1-alexander.deucher@amd.com>
References: <20250606064354.5858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|PH7PR12MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: cb2a0af8-1f0e-4d70-825e-08dda4c5935e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5EkCzE/OIryhzIEx4wt6PAJ4pbR0xcyK3jP0+p1fk6TZHdM0Wz2bWkRjKuzw?=
 =?us-ascii?Q?0sZtZBFPvRkNIsdQTnL5zdj1+3H2Jszdp9j0zhyWVLVDUjrROWJspCzsJTc+?=
 =?us-ascii?Q?23lvqvH8Ey8JMe7HHiiWXm1d+1lsWF0upCDGbgxeEKCNGT7i+R49mVINxdPt?=
 =?us-ascii?Q?zIJXh/F3B2GNVtyCHh90FtAlFg1t5ToCx9kCZOouKtBBaRt/r9eF34pZq3Jo?=
 =?us-ascii?Q?cEVXJVzf/TtKKRuAx4BvHuAzt2i9Rh1vlTVDwsCJiV7o1bzl/Y9krt1YGkSn?=
 =?us-ascii?Q?95skVU7/5NbbavUhwGHLTvTjW2cs8u38cAGiTQoOU0PcUeqX46kyewwRT06+?=
 =?us-ascii?Q?zigaztA2rzAmsHq4SYZJfliJxGXm4dhcn/K5AWCP1dftlYs5CVRG5NIIUfbs?=
 =?us-ascii?Q?dE0FbYgtmen+s3hFCp7dY2FWKr7B00lawiaudqMxisZiJ90fz9zP6ZWtXKNi?=
 =?us-ascii?Q?AYpsY9ChDsHDBdUQKG+CJaxrUiAo9UQjvVIKygdRmWywX/EgcfajDReOyxqn?=
 =?us-ascii?Q?EywpgikRBtFXEjzQqv4RVhB6sarg6tZC9dXNtt8cRejwv42s3aTk9TTIy6Oc?=
 =?us-ascii?Q?XiS3oSOgx6iL6nc9WeFkK+x8Qkb7Rs+AV0R9vLB19Tsr8VEWptBDByhsNf4Z?=
 =?us-ascii?Q?5wIL/D6ePH0lhplnGVEqlbBy7qAddrjUfQeQgd5sT2izQhUAjYbhDVZ/5DlY?=
 =?us-ascii?Q?xibG/qtyRlC6X+5p8tNjAW7N2LgoLioBthMKFpFy4A9esS3IwJQFwLm3Nog5?=
 =?us-ascii?Q?H9GslabE8aE1cNkSn7sK9jQsTAS9v1KCmtzbEVnlTam2sCp/ht4b4nL+MIjQ?=
 =?us-ascii?Q?N883wKxAKg5+cVb0BCu29Y9VJaKGiuIWjXWHcoHTcuVLrN1gaqes8a1D0Gv3?=
 =?us-ascii?Q?7ofi1Pd7qKh9Xer1p0hRnGUArYXp8Y6gKBoC6UJ3aZX0bG/iDVBQnH+pNtQx?=
 =?us-ascii?Q?Ge2Y3wI/F2pK4UQYJe6ga5ZZroGwEGbgczQxRjVPoza+Sr7KlQRd5Ngg/hS/?=
 =?us-ascii?Q?9RJHOkqS+JhMUi94bJb/QG+s8/9JmbXASpr3zFtCP8InNvt1XrR3+aoHv16c?=
 =?us-ascii?Q?EE8oDGcyfZuV7NaRiCUsV8cmeREftZOpaotylrwNAhteyBvV5IW9n8I1vcJX?=
 =?us-ascii?Q?c/dnjS0CrD/LtEK90LUZecIfjNNRV3RU8NTH+u91K+fgmi/6+0Inzjs2AII9?=
 =?us-ascii?Q?bHvtWvnWS1QIiMPduhl2MrnqYJ5Cp2/kUEmWBxLp1HBNlLQBGvFwho95XQOv?=
 =?us-ascii?Q?X2nirUi0Mo/Px0+fyBLRwLah4Jn28EnkVULPfNagPkMHzxL3yiChxdotgIrz?=
 =?us-ascii?Q?x0fqij3lS4Lg4GF7+PcGPAEtCdjGPzno4TSO0fMntOmBlK6+87OO1e0SPjup?=
 =?us-ascii?Q?AUOwgDIxQB9Hz0KTKgxW0GTeSaM1B3kTIwRL6oh5rhshrEuZTRztFfIZNWgz?=
 =?us-ascii?Q?XCEd64fXlpaI3wYj+3M9lVh31MirrPhiGfbgwmkc8RLaDL47ioomS64cNll0?=
 =?us-ascii?Q?evliADAaKyQ93b5hY4dIuvAxEAb0Bqzrkr+Q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:24.3174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2a0af8-1f0e-4d70-825e-08dda4c5935e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9128
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 179dd420edb15..8d7371121d28c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -728,14 +728,22 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EINVAL;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, &job->hw_fence.base, true);
 	jpeg_v4_0_stop(ring->adev);
 	jpeg_v4_0_start(ring->adev);
-	r = amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
+
 	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
-	amdgpu_fence_driver_force_completion(ring);
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(&job->hw_fence.base);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
-- 
2.49.0

