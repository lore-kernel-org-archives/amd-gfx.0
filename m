Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAC9C5B555
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ABD710E9C3;
	Thu,  5 Jun 2025 01:46:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t1gSQYPL";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50F7610E9C3
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ad5J0MTeYTtFIAf/Tq0adLb6Fh/rtj/PlfuB87UnJocAAQ6GuRgL7qpLc11QayTAtaRyRUYuTKlM1sSa01tRjQUmfeyqDCA63jLxn1jCBOKlcwaEVp/BlhZx2XSGpFCPi2EYwAXbU/xSPIG02nFPcILcw0iQ1Bses3fQXBEpKMY3eT8MGe52MviivyZAbFV9GPdD3qBQIcTyI+yoHYS038g92lM5P+cuFVckAZyDGAf5ogWy4T9xx3sZa+o6yaNS0ek6cRMVBgRmY2w+lncKdIrkjCt3KkMrHygcWQQjoCwZSx63uTVzjcTJ9l9C8rccSD8159G25uuB2e7GlinHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zw/d2l+6UtjlkbH2k5Amjpl8kzbdslZchR05V+m6WSw=;
 b=EGiVBjAS6x7ma0qbJsoUU9M8gbolTefqZENFS57jav0FU7D6br4n7dYbGV5jDlZWIFr3JOZfxXvn09LTF9HJkM3bE3mOjXlG099oabVTFUsUxvoVwXzxhaQYr8NUaH5wriRJJKb+6i/CUNMTsWwnTMs4IFrjOvITomp23zcp5z3B3gCTNNw84W6gAOh/Js1CBwKm5bC3b6KnxHHGDhv0+FlfeOlK8lIC7r7U662ptxYXYziVOv/12o5ZILM3OmIQM51RZOjXQY/zgMJDYLQEWxKm7HBDipiJjPPg5U1FlD5/pqd28I64pryBeVNNTP/561lWE3cjWecYO2k6Dzeg8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zw/d2l+6UtjlkbH2k5Amjpl8kzbdslZchR05V+m6WSw=;
 b=t1gSQYPLXM0/P9lZnThNF1oynTA47gfoHc3cb9kZYY3Fiy1fdwESgQoYW4kV8dDu8jvyL3KuHWAgRK8R7idxh2W4SXPjRRPjuem0B1xbeaW8d/i0NCG1pdShRiIu8QCbw+TZJOce+ih2c+mKCbwobn8Xf7kfKUcUBKGenMiJHfM=
Received: from SJ0PR03CA0139.namprd03.prod.outlook.com (2603:10b6:a03:33c::24)
 by DS5PPF5C0B6C3B6.namprd12.prod.outlook.com (2603:10b6:f:fc00::64e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Thu, 5 Jun
 2025 01:46:37 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::92) by SJ0PR03CA0139.outlook.office365.com
 (2603:10b6:a03:33c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Thu,
 5 Jun 2025 01:46:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 27/31] drm/amdgpu/jpeg5.0.1: re-emit unprocessed state on ring
 reset
Date: Wed, 4 Jun 2025 21:45:57 -0400
Message-ID: <20250605014602.5915-28-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|DS5PPF5C0B6C3B6:EE_
X-MS-Office365-Filtering-Correlation-Id: 13bd17b6-f29a-4bbe-357d-08dda3d2ced2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8v3UZEJtdHMm4nATsUSrGxlOaxsvSAXb+kspzHYm+lOsZugVlTLLoxKzbIVv?=
 =?us-ascii?Q?s+rbv4MCyrqIkvNDl64ZMFV832tcWhoVdYB/LFNFJ7L11/Tm7EnuZ/xCw3rl?=
 =?us-ascii?Q?5axtfGG+YVHEqv157Cq6FAx6F2YmSDNWS+YcDmjgfg2WNQPacEObXFLQRMbw?=
 =?us-ascii?Q?4J63ZZDcVKxyaF3x5xmASo65GyaVCjJTUgnGuZasqUL/sKFDrMYtqcgFBSNL?=
 =?us-ascii?Q?fRYlklBxTZKTsFo/UgDoxOJfINqndnqsX2hMNPx2QcomGLwZhu5yGLrL/VRG?=
 =?us-ascii?Q?if5m1FwMO96uYfPqKUmUTXlUDo3GxlD59mngmtmpR4ZJGdozyJl7aeI7Lyn+?=
 =?us-ascii?Q?bQdR9u7/kmpgmfV0J2+m7JBi2nF8Hv9s+FU1uUPKBO+C+hDOHcHEM8xp5Umi?=
 =?us-ascii?Q?limHraj29IqGh3SzsFC1ZN+y4AZHRFoGk0PuB//hshHNJwdizicRcqlz4Aaq?=
 =?us-ascii?Q?alUYnOL5txBOEcJLKWNq/X/Fx5EOu4dO2OzksC2Ts/yYrNBT8Qbjz4cMHtWB?=
 =?us-ascii?Q?WxPCbcf9znQakZocYrt6FxJgWsGheqweNNhCBp8cx50BB4OprBN89JV7BtMg?=
 =?us-ascii?Q?/l+fhgGQxL6hArw/rSxJYnqtyrrqfzSAfHaPqphSf7lCe5TMULBJjtinSLcD?=
 =?us-ascii?Q?JnTvG2BTul6LogZkdE5QNJ05jKdkitR69kNN5N4skQ2rCkT7ukK/Ifo6+hOf?=
 =?us-ascii?Q?SJZvhG+IoeimbZ0ZD+8PJk3Jq5eW6OLun1JAo1bHQJvlIfc1wqyjTR3TA4Rz?=
 =?us-ascii?Q?xvMWVS0qDp+rCjCQXoV/1vjg5SCBweWNYE37Knp6/XLA9QoRiSjfKOYii2PZ?=
 =?us-ascii?Q?gonNYlRMl5NUIz0w86luDpVeWjGV/CKpD0wLHVRrZHyiUsttwjqHMpsY+v5D?=
 =?us-ascii?Q?E6vczOMsWvlnsAXLJW6zG01+L6C+lQSa9NeVJbuP7rR5M+yDmqS5L+Rv11oI?=
 =?us-ascii?Q?jiuebIuZo89kdgDTaxvS+fioet4BeGh4Jc0J/jRxSe++bmFPneNueD3UVN6R?=
 =?us-ascii?Q?WI4y6UoeY6pM1mDgotODoXouzk3JRVc1I0l+nHprTGP4iG48Pf7c2vBHTdWq?=
 =?us-ascii?Q?+hwAmbC10iRZ3wcvsRT9sNrKELuPKkpWrFXQsdR0T2xMyoHHfgZ8ssgutTkZ?=
 =?us-ascii?Q?SeQHSIqP5U5h/IQuFsZQiHdFY5wQjP/PzT2q337doJd15pQonS3jFqeGAplO?=
 =?us-ascii?Q?N0alKPR6s/6FroEc4VAtntiCkms890qxmByySliGCZgHwXIxJ7R0UrPTelSP?=
 =?us-ascii?Q?Pmh+jIsV0UL0R9qmHXGQAYi+HQsVoScawWmFqRIvH49n51MsGNfgbqtsTuK6?=
 =?us-ascii?Q?UT4a/CxvrMSiqv9rKVmJdjcfiNakBCUwgFFHp5O9orBpLJzpIWMhJmZgm5X7?=
 =?us-ascii?Q?qj1m3cSuAb28Lk5TUpi4tgnVqQcm1zMgS1QanZFDG9hGtiH+JhDjigAC9g4P?=
 =?us-ascii?Q?ECRsJa664ifdrmK7uZwtdNw+ND8a/O/8zzsC7QW2OMeGL858XzDpPfyq61SQ?=
 =?us-ascii?Q?OKz01a+Wx+A1pWAm66d6JuRGEtXPR/3FZ98U?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:36.4088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bd17b6-f29a-4bbe-357d-08dda3d2ced2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5C0B6C3B6
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 858b930d1dd54..56112a319c375 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -841,8 +841,8 @@ static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 
 	jpeg_v5_0_1_core_stall_reset(ring);
 	jpeg_v5_0_1_init_jrbc(ring);
-	amdgpu_fence_driver_force_completion(ring);
-	return amdgpu_ring_test_helper(ring);
+
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
-- 
2.49.0

