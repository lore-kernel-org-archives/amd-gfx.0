Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44A7C3DA4A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 17:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7237010E529;
	Tue, 20 Aug 2024 17:16:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r3IOD++Z";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B760710E529
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 17:16:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYISqcH+EVIPaBVGk/odp1fDx0kQo50TXNx4oHS3xoP7gV7vchDSO6O7kWqb+1Zy+2VJ4d3Hv1chZCEHYiWygV7cmw/RgDAQE1fiEQXRtjJFSkQMQLC59qgjI4BVv/K/iXJROyPV/eYZa1ruR5+ae5jMbeKV8LOLJCXzbzGIl2StMSmJheCPDTp6ObaWryJE3KP6n4ydw5UlcdK3iWRa7r5WTTohQinV1ilYkC78f9+voEGQlC+V+HqNAWADpfyYdqAuigAkeoW9gNUNSwa6NxE6ZJSTmE9mS0k0CldjcHZ2hVbRF29ltiDM0wO6IW3+zFCLleVqnTlAVRMOJvLinw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cr86n0vRpLWjt3brh5yk5lJeA++thPP8awRrZlgK7OE=;
 b=O2i7gdyjoLeomLt//sDRvZdz8VW9XSTefTGM+gvD/CobGQwVv2BlEgl7G4lviZapvHl8EUbV7xJeBdkQz3ZCH5rKJhhdjaLcMmV9FCXEhNELXZN4NDolTaIK8KK//t9WL9L78Nid+6WeXlvA8x786jdLHjJaBvmyk3vgTtUzRK+PTZGk+EKEwAEhhnP8Ey1cmn12YFDYM4H9QHDinZOJt8FR81uPHD1Xh87YIvh8A/Yj4J25gLqzA/9HaedQwO/HmnKTGJDxTtrvXVAo7CexRvrV9rN7AxTbJp4pmZp53jsCInPplp7IkRQUOAGW+5GrFUbrd0+uNbUJE2LriGFxzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cr86n0vRpLWjt3brh5yk5lJeA++thPP8awRrZlgK7OE=;
 b=r3IOD++ZkoLNk/9f32C0UqYTP2nBpOut5dJYZSWseQp+1KeGsWyc76prkALzGn91UEvhQ2VcFFOW2KRzFa35A9gx84RmuzJqpcprR66kRTOrTg2Wo9RpxabBbPZvI5BCx9+vm9dKWpoKZF94JOaETRgDQCf/ifPKXY90m4gQHRI=
Received: from BN9PR03CA0258.namprd03.prod.outlook.com (2603:10b6:408:ff::23)
 by MW4PR12MB7336.namprd12.prod.outlook.com (2603:10b6:303:21a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 17:16:48 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::76) by BN9PR03CA0258.outlook.office365.com
 (2603:10b6:408:ff::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.22 via Frontend
 Transport; Tue, 20 Aug 2024 17:16:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Tue, 20 Aug 2024 17:16:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 20 Aug
 2024 12:16:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gfx12: set UNORD_DISPATCH in compute MQDs
Date: Tue, 20 Aug 2024 13:16:34 -0400
Message-ID: <20240820171634.2015412-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|MW4PR12MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: c77ccab9-a216-4703-d8c4-08dcc13bdfbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K5uPPzmokFw1FVIvBTMO3va8domE9i5ECUrKmCi6jqkdOnvH7gUUEnHabZ1G?=
 =?us-ascii?Q?bxrb+L1NVzJ+r5h12kdqV2NdhDS0SenNaf7qp+tZzTmQRwl2FzhXm6FBTb2N?=
 =?us-ascii?Q?hVB3FmpxYCv8AW/sGHaHokbF/XUeKi+2Ayf/aQX93ALSll5VNAwlVRspDDYy?=
 =?us-ascii?Q?IWBdp2q9xHdX45fgctfH7+YWsM4PIfVEsOU7elfN+TuQ/wXVOlkiOed9f2vD?=
 =?us-ascii?Q?sqjoS0zBk++8p81Xn5YaWGRGw/heE6xunIcM/q2YcAk4eNb870eYwDzIkhTo?=
 =?us-ascii?Q?VH7e5lfGMWqij2/etGSPYlAhS5rdft/zEZD77ZC6E93jr7bKLHx8qSBFcmnM?=
 =?us-ascii?Q?Vj/EO4Rhxs9xfI5RAbZ7/gxunqoT4+0le8Xhm0QFHUWwLOuz7DJ8ye8OKatB?=
 =?us-ascii?Q?nuO142cH3/7341J5WGn8gGcAxcx8pRQ3B5VNrGIGuuHsQ2KgE2daLoyjVPo6?=
 =?us-ascii?Q?3o/TOprkKVZ8Y/Q3y7A4O4WD1bpYRxt74/rwpu4+r45gm21IEAFWByHLaAek?=
 =?us-ascii?Q?vLES7p3KeCXeZvDg2QhHDbJvJJinG2rK0L+X2zZ2b20Y8xVAyDEeSeHhKoTn?=
 =?us-ascii?Q?pzMp/CE/o0r3ugle2ciUJx9VJCmF2uLo0VbwdcI0/3qnFTqJnoL+fwbmILex?=
 =?us-ascii?Q?Z28s2TWbm3KHKhE9orhLq6pvHZKGufxeS75fER2yKJRgAp0EReytBIE1bEwX?=
 =?us-ascii?Q?MZagbtUBxykvMwABrML2XLRmJTtONNh165noxVxj5BrZLutPiC1v2fu3kE/f?=
 =?us-ascii?Q?QDpAM9Dxb0774lqM+zOIOR37KVUWs8PsODjwNaeFNMcMZIMl2+1n9QVT+Is7?=
 =?us-ascii?Q?yie4hiOnLMXy42WWyqGKLAWvJl7lINqsppziTCEDhC3jG5qFTgIOHA3sn4l3?=
 =?us-ascii?Q?kbmZmdit8etd91Ub9t8f3+O3e3YbJMboms2jR04MnnRBVxfDTsZmiwEngRmj?=
 =?us-ascii?Q?NQcuoE85JsDZIJXJWdL8Yo4KdPENlK36GcWZWYQarPu9YrSNwumu/0R1WI0y?=
 =?us-ascii?Q?9bc7CVa27q+77Xo3y6yx1jFHl9dgwicodo/U3vaf5JDMx5ea78mZEtjpo35K?=
 =?us-ascii?Q?55zErjJgfIy6tms/XoFTh0ra/swg9sjRjvuBys9U5pgDt9ii7AzYfqPHU4yL?=
 =?us-ascii?Q?8STPeoXY2aiDFR8FKLH0aD7ssJZsVLOA2ouokSWG71Oweb6BTrcq4n2h8vHk?=
 =?us-ascii?Q?5AOhnJMGtDfOD+gQDKXJzCSRY3Wh7XGEI8BxF9M65Sv63y9mqmwia8CossK1?=
 =?us-ascii?Q?AX3VWuT3/PhaAvKec/DPZH4Ob2LO+EBfrHlgQcL8A2apt4WifAnVIELzEOpM?=
 =?us-ascii?Q?MROrkiP8k23yCkGGDLJxccarI9dX5Ff11iDxmyuHDKvH1mPjeLZ0KlZ8K568?=
 =?us-ascii?Q?0cnbJAuIGPybRME7Yx6cSURYctF/3L27Scy/EnnMyuFQb8QARQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 17:16:47.9847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c77ccab9-a216-4703-d8c4-08dcc13bdfbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7336
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

This needs to be set to 1 to avoid a potential deadlock in
the GC 10.x and newer.  On GC 9.x and older, this needs
to be set to 0. This can lead to hangs in some mixed
graphics and compute workloads.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3575
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c           | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 070546c8dd59e..6f700800f346b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3054,7 +3054,7 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 			    (order_base_2(prop->queue_size / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
 			    (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index b7a08e7a44234..d163d92a692f6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -187,6 +187,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
 	m->cp_hqd_pq_control |=
 			ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1;
+	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
 	pr_debug("cp_hqd_pq_control 0x%x\n", m->cp_hqd_pq_control);
 
 	m->cp_hqd_pq_base_lo = lower_32_bits((uint64_t)q->queue_address >> 8);
-- 
2.46.0

