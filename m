Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE0AC5AD49
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F7C110E931;
	Fri,  6 Jun 2025 06:44:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XvAIfHgK";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAC1710E931
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYKH4yBdUXqX1rfOgPFnc3iVVGei5EnAZVrati9Dso0hU3nI7fXYygfqgaZEfkU9BeDYQZesCQFtwpswzNF4Eg66if+/MqpsjASWRWfaVQvgVCoJVTkKAXYA9XErARw3zIQpgYwA1bDVm+VfxX9uiXOUtZehboVYgIp2uCqtwc1vjG+zr/wv3XtkDE9UQ4TPwpPCXCx9f6218sU9VbC4XVSdqKYj2dfjtUk0ZAeFDobzT4yMLtt/paH9t/qLvzDtpAX46zAluG1oW7QmNZ3XFkX1X0zPgi33lLeAVmzRZdI/ZLU4vwRZIXI5ujT5kMZ9pkdWWW6ysm5Shg6D5bvnmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzh/insd4valOF3CBzo2xSKDcK0leY4ZE4M7sHlBz9E=;
 b=wzb2CcETn1t1YXlWvCxFSowqsNKlpOA+3clcGh1QwrusKdTxinpby7mYo7/s+5qTVAcpjrEY2TThR5tEkh8KD0PzDYL+pffiK/56spm8VviyU7SJnDaI2HXdDQQ4gZ0ik2JTTR1RRHysSYFknFupFcuivOhz0yyfYVMhMiJnH2bfo5aotfn1BkKyIqFoKHRgRGwTZMNLfGqODFIF/gHE6nti0O0KIdBG9WHcCLkNSTu+EY5NXyWt5qffV1rJwBRw3jcALjjqi1H+s0SLHxFgQHJpnwBnSgkCCNEBKV7sVWkqtqOeUnAoD1m2ABpIYdKTTEkiC3tXTartnTp8WLxysg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzh/insd4valOF3CBzo2xSKDcK0leY4ZE4M7sHlBz9E=;
 b=XvAIfHgKhRP1bYmbJWr3y8YxbLJYwo7Eaxuqgux6h4gKDwIbdhsRHXKUNeWk/nDyWuOxnlGy/tMEF5rQAYaX7oZPmdQmpZSZOqRvBJ20WG05s40b6wzVa7POlyAzrtIimOGpgN7LMytce1bj2dFiueCQ2mzNTKzXNI5knxNzaKo=
Received: from SJ0PR05CA0149.namprd05.prod.outlook.com (2603:10b6:a03:33d::34)
 by IA1PR12MB9061.namprd12.prod.outlook.com (2603:10b6:208:3ab::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 06:44:21 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::29) by SJ0PR05CA0149.outlook.office365.com
 (2603:10b6:a03:33d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.12 via Frontend Transport; Fri,
 6 Jun 2025 06:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 16/29] drm/amdgpu/sdma6: re-emit unprocessed state on ring
 reset
Date: Fri, 6 Jun 2025 02:43:41 -0400
Message-ID: <20250606064354.5858-17-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|IA1PR12MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: e53865ad-9d79-425e-349b-08dda4c5915e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZBa3DI6t1WpWyc+81f8z+EDRTE8y6gxki+/Wo63ic4qZFcdv1cRxTm3P/yYL?=
 =?us-ascii?Q?NRMLFVGbO/gamjve7ZbdAWC7pvDN087NFvqo6fD4nW/DXqDL0/3lnGLYGgSA?=
 =?us-ascii?Q?MOAhwgrLwDEdX1+UV1mVVR2T5rVUGNMs2BWUPHMdSyoZgXXHK5eGMCY28c0B?=
 =?us-ascii?Q?TzWq01qyQU3dcNshOTsum346M/KCsshmDt0UZ6/WzPv9mWJWdK2m3FEqOoGX?=
 =?us-ascii?Q?cdFRWOXDXBVtkhgKH/X1tjxv+SWR0NyI7iBv30RCmypn5pu1Y5+lcI5mXgXm?=
 =?us-ascii?Q?fhCpx2kqsu0VqAeLrq6cAszY9PqpTQkcQBFl+TNUM+jsKZFZbtDH4oB9zt0I?=
 =?us-ascii?Q?nxKcYhaB68tGSoDObSF2WArOM+e9HOOm9D7JhwOcXY1LQJ7ToCCmWmenXQIK?=
 =?us-ascii?Q?9QmvWIpD/NOT0RMXbkCWXlxAH54BFwbw4F/fuqXgPp9I3KDB2t70BGKGdgEq?=
 =?us-ascii?Q?nRASNE+6AHe1NcFZJ4hLG2kejam8gOWjAhnJyG6M/tNEYH6di5r9G1IjfQiE?=
 =?us-ascii?Q?/7VHwFFboV7lNwyCz4Y9cp/AyVVXbqg+qsJDM0ANInvhmpPjki6ocnGjUbab?=
 =?us-ascii?Q?VI4OJKsgED3sz1vuw0jy3OdKMpHoBYMzIMsYuYFfx5rXPMCzhidA95uc01aJ?=
 =?us-ascii?Q?Dc5RqDN/py64Y8PocsVcgmR5JEBrhWzPeRDOA+rnWrj4lTbApanE1iUc4ivZ?=
 =?us-ascii?Q?EkpuBg/u47RHXU1rdz29WddK20GRclMrwMQkgf1J+896J0Cy+N719P1lfffh?=
 =?us-ascii?Q?sykrLfgEVxThxfqzefBstlKwRYCuzqusnqX3Ia2x5j5AOsUYWX/T+OAIxG51?=
 =?us-ascii?Q?ogBWRmfhgzoaSfMXvmA3e87BkN7aiC8kfwSgUlzFIfR1kLcgSAQYDvTP055f?=
 =?us-ascii?Q?zB95gVFk/s+M/c5y9zrt0f1omFONlMXMz80n5CaqPpjivseMJhdd0mUB2hJA?=
 =?us-ascii?Q?6FvJzCcrit+hQ8WmcsOeK4zpF5fgMq4JpRd7vf7ZHZMdZgsi9soCm8GD4+bp?=
 =?us-ascii?Q?Nr3Q/MiZFYsJ0XA7bYGbvxZQTh4Fxmn9UmA//4WXuS015fwjfpTcVGohBhD4?=
 =?us-ascii?Q?ZcNFzF++03hcX2XgUvtOhacY54e8WJIhYtrSBP0s9tdZSk2Mwl2YZlO0yb5h?=
 =?us-ascii?Q?tgFk8WliZKj8XJDIABo/mPAZwAQFBDPh6O3BtgowYgbJWT9vdDh0YYsNalwY?=
 =?us-ascii?Q?NXuUtZwIGHofzTmDO+OSuVrC6tMMLG0mqIXs/8PGZOL7jFEGrCr1Bp1SReJv?=
 =?us-ascii?Q?1b+GpEAOzkFVFikX1dY+I3Qo1nbq2BVsVX1aqlkAh0DfB2pWyJMh6a53YRcz?=
 =?us-ascii?Q?CSHYQrHxBtm/ZSPdtoFXww4fK6hULGS4DWf65u1A1oa80pTQ3ciQJCeszojO?=
 =?us-ascii?Q?Yc6n3EU8ITxki4aPyBK3C8DaCGqI8JK7E+qnhX06MbTQNo3a+CLDK54DXVqN?=
 =?us-ascii?Q?b/yD4hnpTRWIm9nCmUXqcMjljNREZLSFg1nSku2KkkjXITXR9b8kMfXyVKe3?=
 =?us-ascii?Q?crS8+N4UrB9FP1AQGWTxL4IOetGoa1fiymOU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:20.9598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e53865ad-9d79-425e-349b-08dda4c5915e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9061
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
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index abb5ad697fbb2..f3a49d6a2ae0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1556,6 +1556,8 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 		return -EINVAL;
 	}
 
+	amdgpu_ring_backup_unprocessed_commands(ring, &job->hw_fence.base, true);
+
 	r = amdgpu_mes_reset_legacy_queue(adev, ring, job->vmid, true);
 	if (r)
 		return r;
@@ -1563,9 +1565,16 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 	r = sdma_v6_0_gfx_resume_instance(adev, i, true);
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

