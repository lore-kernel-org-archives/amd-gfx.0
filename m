Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C98C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 08:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6586810EB35;
	Fri, 11 Apr 2025 08:42:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5AdF5S8a";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 129E110EB35
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 08:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yk5pI5wJ895q4wxHQDncQp/4tFAJKWz8EkFek/qY9VxP21ZAwZ5CXIasx8xAmUJBtFVq7yW5GdYgdT6y9dpjEte15uhBFEvWUGZLRoHP1Ecfrq7mY1B6OPsDwjSDXKupVKBMy3UZOpfA5qS2csBtZGNzRLL78I+TZlyYGbTOTivklzqwJLxKAlcaKo2U/FAZjoQuIjCcVG8vXsad4wRT+Tu+93QZEWht/mcOTgiuJ+DjNAmhnVOrCVuR6ojOJzkg4pgNqa7Vgv4lTlR/l5vRISUpDEzTm1QkjVPEhcZKZjLij/UZPUbTtqaa+NhNnq74T/ayP/BndCVUhFYt5ApWHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05Q/5MBo2eDNhTHP6IaAcdg9v6qFpCP6EOX8NtDpbbo=;
 b=o4F+riaFn9qJOTPmS9uxBV60i6/+YoDe950eI+0iigBXen9GynNks6x8MbqBO5KeNGBKEPxGc5MyIyvOQA0h2xJ4Mp7z3mW3DYXIzYeicTjFt5/NhjLuflTco0Z6oNVR+5h/dwXcBP72O2lZwTRr17/s79wZGVPqldNX/rHG527tqs7oNvcmb4yS80/V2Bcp0sfK8z1LvC8G5q76FreXSrLHNp/0cANQkA9uYyT02o4LRfKWrxEFjJmc2bxVzSQVem6CPzGOIPcTu87dHqmy+PhqDibm/vw7J5GsCS0lqeHc6VzGQRuVaBQI1XU20/jA2E/wScUcQBn9+aT8IOnB6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05Q/5MBo2eDNhTHP6IaAcdg9v6qFpCP6EOX8NtDpbbo=;
 b=5AdF5S8asB3trjGkOqfdQTH2pSm5BsVoy3T22YTWud7nBpxbXZEDsKwhgZ22hfGFiE5utxq6+2sOsbZpVGGxWY9Yy5P5PgxOH+Z4MV9N0mKfmOsD57DdDabROTD4uyzDIV8hI8zZOxe5jWeOWILDCdHTObqaAKgOoUChOT7intY=
Received: from BN0PR02CA0059.namprd02.prod.outlook.com (2603:10b6:408:e5::34)
 by SJ0PR12MB6829.namprd12.prod.outlook.com (2603:10b6:a03:47b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 08:42:33 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::2c) by BN0PR02CA0059.outlook.office365.com
 (2603:10b6:408:e5::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.27 via Frontend Transport; Fri,
 11 Apr 2025 08:42:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 08:42:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 03:42:32 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 11 Apr 2025 03:42:25 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [v2] drm/amd/amdgpu: Fix array bounds check in amdgpu_hw_ip_info
Date: Fri, 11 Apr 2025 16:42:25 +0800
Message-ID: <20250411084225.3229214-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|SJ0PR12MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: b60a1310-8ea4-466c-2d60-08dd78d4cd26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e21n0U1pnbQ20nUwZlmx+yctCsY/MnRe5pI6luasxxBWyzADCt+7srmY5+MC?=
 =?us-ascii?Q?7zM55dBuHUcc9en+Tg8JPSuTR0YBtq7pFuzuSVy1wYy2L0W0MWW0mt/73i7z?=
 =?us-ascii?Q?0huRCyEO8Jgo8JWlV1tHc8+YIJWHGNUwRHmdmDiu2+p2TcsEier81JP4QXYY?=
 =?us-ascii?Q?bpiJGPYcX8uYmfs59RdaPQatdG1AfoWrrQGRHcAfc7GftApo3/GaQY3iQVWA?=
 =?us-ascii?Q?dEMMY5RYw/IfBPUAKzMY+fy0iTBiCPG1uUmIVUl30BwlFj16oLoFFrCKW6/5?=
 =?us-ascii?Q?+jbzxZO4bnu1nrFNMqJgDU9nN+9EB5IMyom6Ow1twbYk34DZuT0bH9iYssFK?=
 =?us-ascii?Q?FFdYKv3Oik8P+v5CJDhskxz4wvZaAPynOteUScyx2uXtphaRe/UtzcV+c+yH?=
 =?us-ascii?Q?azk1CD3+duWySA50wXgYvKPtHe7TOrB6/geG9OJNsrv41farEyaHMtwlHq/d?=
 =?us-ascii?Q?VFvtR3ZCSzY61gl7rv+9XoE4tgZ4TxaTqsa3l1pq1UBBDCe4qsLHdsKERBbB?=
 =?us-ascii?Q?suPupiW7IUV9IP4lzMUYbEj716t7akuFlvrvUStj2uRmRPrNWB2LdxD6GVQF?=
 =?us-ascii?Q?r8qMvAHLG9nOM/Dh4omI0run75U7yfi7oVfwDDvRAnR5CAD7X5xRuHRUYj9A?=
 =?us-ascii?Q?BK2dBScWyn/kCoqGbpC/3SqTiA+5gSsNnByZfKnHxCC74ZRITCPno1w41WXp?=
 =?us-ascii?Q?LmLS1/95HuzLWLiWbw6IQVdLQ+Do5USUQ5DuHl7YJVOfQ+VS6OhMNoE0niwS?=
 =?us-ascii?Q?ZJ2tGLTzOTgz6mLWxQv79ujlCBPddGZKRwW1CqXTfXFI4909/vMYMj78KUyq?=
 =?us-ascii?Q?GL9rTBV7s6r2e9/9mx3ZStR89lTSyRZEs7UxdpE1kKxLe3L8AVxME+QE1Fcs?=
 =?us-ascii?Q?lr9NhVF28rYW8Vl4Hi7V8MYnWooWWSCdvyUXrNjo9dSXnBYiUluh5k6tIPB+?=
 =?us-ascii?Q?r2XZMfYcaenTs+DVwVLemaVV9Hh0A7zTyi4ITJlOFBYYk5mJvW6UYjF/1Bk1?=
 =?us-ascii?Q?R7z8zr4EsyMbO+eB02Axx0UXz6hUZkfcrif9rrv220K1DBOJ+c1IyWufllQ8?=
 =?us-ascii?Q?JwGH93tmtsZ8jPB5+MGta3I39VMEKGSDNmCJduDnVeimSeOkbIqJXSLydYJd?=
 =?us-ascii?Q?8jCsWto7vVQr9GnhmV0oUbi5TmnWhK7iVpdtSO8ZcUeUB4W49jGkoESXnZJK?=
 =?us-ascii?Q?u5q6Gnj6bwM6gY+97W9OUjVkac6Q+RBpUuNu7JFQ56rKG20uqUqtE9XR3OYH?=
 =?us-ascii?Q?eXRvz3YtUdJvDsdrneWHbDmE+bIh3x2vqCMRUaKHp96ZyD1d9vOSph022GKS?=
 =?us-ascii?Q?shbVp7xLKmEsMljiz1uQ3Ei1u4CmfvMWY0VxhrHcSVfQ0Mgzax0qOB5eY0YI?=
 =?us-ascii?Q?fIL/kNiNpKFh3zUA+pHkoWq2SOMif7NR4owfmpZzLsDaFnZu2PHtDxYliQlS?=
 =?us-ascii?Q?9LItzvM6IoYexTxdeE46iBHVMUL2xldMT0y6yFOjODWUSixl51sbpILM/qmW?=
 =?us-ascii?Q?PpbwLjIkbg95UdV2UYXOTE+3Cpp35ohRBQpo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:42:32.6240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b60a1310-8ea4-466c-2d60-08dd78d4cd26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6829
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

Fix an array index out of bounds warning in the DMA IP case of
amdgpu_hw_ip_info() where it was incorrectly checking
adev->gfx.gfx_ring[i].no_user_submission instead of
adev->sdma.instance[i].ring.no_user_submission.

The mismatch caused UBSAN to report an array bounds violation since
it was accessing the GFX ring array with SDMA instance indices.

Fix the commit: de412e03405f6a50(drm/amdgpu: add ring flag for no user submissions).

v2: update the commit message.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 0ba3ef1e4a06..6a42dea775b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -427,7 +427,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 		type = AMD_IP_BLOCK_TYPE_SDMA;
 		for (i = 0; i < adev->sdma.num_instances; i++)
 			if (adev->sdma.instance[i].ring.sched.ready &&
-			    !adev->gfx.gfx_ring[i].no_user_submission)
+			    !adev->sdma.instance[i].ring.no_user_submission)
 				++num_rings;
 		ib_start_alignment = 256;
 		ib_size_alignment = 4;
-- 
2.25.1

