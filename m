Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D4CC77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB26310E819;
	Wed, 25 Jun 2025 21:07:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t8INLj3h";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B74210E800
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTQpSeoPnShT1EA1iX8tg3DfmDwdtuNLvA6HNy2wiHfUSUiBChzWnD0ovxn8krx1eYt+1FGJl5jLMeLdzlOaetL37mYvQsP8nftbHhN6wkoZ0mk923hgNd3DZ1f98alq5ujgJNSZQW9SYIQujn2MQfaOjQX+KN4FfdNqC/pkvScEQ8dOXfrnM9tt2XcewHa1BxkWdZDA25hLAnXKcv0KJSv4rXr+uUXffCmv2imr0CTGM7wmOqKBAxjrDzbL/adqBU947/h+wIH0Zk2MjF3wqM7qTS9sQ0Y/HNkN0RBZMVzl4M18gLa0UUMBcvy6DvE387FB2kgsnj9bTEf4iMc+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUpekgKR2Wrw2sGusV+YLat3RC6Hivt+NCzzSoJDx1o=;
 b=ob8GxZgXuIFH8s1N0CgKcOqJFfMqnfncr+4EnB1/MqQqoSmpMB+t7uS96bByORHXWrOYHwHC7PkxZg7henVxO+RUQfrp2L8JA9gaBT08jik5ieCMN+2WrMecTFX0TBMJvohI5+puZmPMP4m6OYBECofhhPAJSf8MrpUlDIiBa2/GrcFzbQRaLLUNOEypk4tJ2MvqGDR0bNaQuknpG+USxxD6e5Q1vP6+MSqCKav774DRKlZI0qCB4kyKKYccyLmpN9flbAPCq7ZnMfIk13n+cuudT5esmJRrcK7+nv9KBdmVE64JkpUWvwC09OJiykaaphSV0wFmISW2zkGhgFnzbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUpekgKR2Wrw2sGusV+YLat3RC6Hivt+NCzzSoJDx1o=;
 b=t8INLj3hoaZDMmab2ODHSfM3qsjHtiQlpEUMxvBEFbgEbombvXpRZMBzpVWtNMOUHMBS+Bhr0Py189tK/P30NaMwtdXjMdFpSUjGC3ZuNxE5yzHLKnkrleTN4WamwdMa/Kd093j9dQlUBBEB5u3ZshkII0q0po9vVB8osLp7Zfw=
Received: from SJ0P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::15)
 by SA5PPF7F0CA3746.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 25 Jun
 2025 21:07:06 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::65) by SJ0P220CA0007.outlook.office365.com
 (2603:10b6:a03:41b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.18 via Frontend Transport; Wed,
 25 Jun 2025 21:07:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:07:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:07:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 15/30] drm/amdgpu/jpeg2: re-emit unprocessed state on ring
 reset
Date: Wed, 25 Jun 2025 17:06:23 -0400
Message-ID: <20250625210638.422479-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625210638.422479-1-alexander.deucher@amd.com>
References: <20250625210638.422479-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|SA5PPF7F0CA3746:EE_
X-MS-Office365-Filtering-Correlation-Id: c43d3c05-0f51-43d6-85ac-08ddb42c3d5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V2m3+LmiLZoX/LeOzEPA3haZyNnlVixgsuYC0df7RpgA1DVKX3CQ8RWfKNpR?=
 =?us-ascii?Q?Ep9mnOO/hPiFLDWlSvOclUo+mx+gTwKgx0hUIl+pe9W65jUqDJVT/hSpvQ7i?=
 =?us-ascii?Q?0KXoK1O23gpanNZzWsk41SDrt3NqTHgUjgfso/DuR7I21jjCLU/D3Ya5lGzo?=
 =?us-ascii?Q?oiLZ1pgH2Lj/wZy8YqRRwgDJs9tp3Y/vLWNMykjmrNNvoqCJ1Tvm4GKfdKlI?=
 =?us-ascii?Q?DBllzolqEIO9Y3aqLIFYZxciGT0txKqaiQ2VCudZgRG31FvtgTLf42uUDFZF?=
 =?us-ascii?Q?QY08AfhQRKzy+wEqy8rOQsa06Yyot1g/0zpe4aGlxRlFBuDjyZEwab5yL1SU?=
 =?us-ascii?Q?XVBnbAFcWPN3JVlNoT92jKCrHmw51oGr+yI8uO190yBKb5sdbfaKwptYWEyd?=
 =?us-ascii?Q?Dv0b1wzE3L1Zuv5syFxMXvW0QQ2ajnMm1wL5m/f4DXH9CBB39OjFonxfIpcA?=
 =?us-ascii?Q?mwg4OlqV5k0Ll6HAroFbhqEg5F7IiD+wNyNFlr+TZUvHiGm76BVizfU6J16T?=
 =?us-ascii?Q?VSLkxCoUcOLkk26pnfEtzzDYSrR1917xtBuS0/k97k3K5iIMC6QQ8wIqN/Aw?=
 =?us-ascii?Q?afxtlTXu6g9ECjfxejhCLrGW4tjoWHmQd+8TEyV0L7BtkOnZWlS//5Oua61S?=
 =?us-ascii?Q?AKT40D8Xj+wjv66zN/9x4RsxxOeC8KnE43fKX3CZ2uFS4s9rgZYp8aO6zCVf?=
 =?us-ascii?Q?Ap1OGAj4Z5/q93vXgfrubzm0QdYDufdODi51eseIAfZI0UdbtrLX3wioXFwT?=
 =?us-ascii?Q?q59cZhuQd3dLQpk6PRRV6QCsvRCMCvLV+cot6NVwv/f7EXigeG2IRVEqS4eC?=
 =?us-ascii?Q?Qyq3KOX7RI0vawnL5+OKOrReoPLJYdSL+AWq1nIBtRMUkwjsSmXT5sqdQfls?=
 =?us-ascii?Q?CCrD5pjJFVvhTiuwUrHd1U7aw/5ptSEOKbahxpqxOyAlwGFDzSVn1O1AzIrW?=
 =?us-ascii?Q?MFrOsp3ToN9aBvaQgo9NU0DZ7SC3XoJqZDYcIYKKEBOMkvuashUoONt4FkhD?=
 =?us-ascii?Q?w0HQWFtNSP6FlKxJKJCN8a2uVOVwf2IWQs8FTouotWaHWawKgHopZAhOzudN?=
 =?us-ascii?Q?W+asgkFoT8iZ8w0RtMGpq/gRYglCgxb9tdUdUkpxkMJe7bMHRk3M8SYApnhM?=
 =?us-ascii?Q?5/kXlHyoc7nBhhrcdQH2n/2CO5cUb5u0nYk3V1AzSuP3bUraCYtEXxOucW3h?=
 =?us-ascii?Q?97z0qi46n97JoxhDYKMJxdBemfBtaFdd270zND1zijKuVL86vMzR4/BkDfTE?=
 =?us-ascii?Q?ERcgnHbCYfSOhkmCjD1XtQ+EEoUVXwqp900bJIQbeP6PsXa0BP3CGRLSBKiH?=
 =?us-ascii?Q?Dtn5JzmcLlbA1kwHhJe2MIXXx2U7YRyLsy4jT5v4ZWug0FRCC5jKQw+1QyzD?=
 =?us-ascii?Q?0NgvekyjQ/Z+WtHmkxsuGJh4wE2ytzR9csOSJmU51ah/8yE3AGxAtHlBgMun?=
 =?us-ascii?Q?777aS/jGzwaqRmxC30jGaQtrrV6g8MttcTaLXfyktNb2Dn++ikqHz9rrb0yU?=
 =?us-ascii?Q?wJld3nA7MW3vEff80FCQi78MvqvVid3/UhtB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:07:05.6243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c43d3c05-0f51-43d6-85ac-08ddb42c3d5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7F0CA3746
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 781a5a8a83614..cb66eff499662 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -768,17 +768,10 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *timedout_fence)
 {
-	int r;
-
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v2_0_stop(ring->adev);
 	jpeg_v2_0_start(ring->adev);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
-- 
2.50.0

