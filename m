Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2FBC7115A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDF6610EA64;
	Fri, 13 Jun 2025 21:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="saT6S6DR";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD9EB10EA60
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cW3iqQO6+CygSTEJ1hQ1Ia/52Yu5Evd6LG0GOnhOZU1pgrXiQnKTT+jMHCI0grmFGlIOgYBQJxz1+46ZHP5StXPLd87QBXzGM4co/X99B1/2laKkcUoGzNtMusGdj5tHBl8LpllhCUqqdlKHK198Lvz0RLkl09sI2n01ZMrfr8kjDdS0S+k+S0o8mZ64vw30AuOsI3kwR+xoVi87PtVU51zvs61EF4MCYappxZIdBZClJygh9Db97eG9jhOqpVlaCPug5UUzf7Kn/TgV6A7WdReGQnRl7XA4fVJg1DSR8MIptE8sN+G1r19mEJ5CAnncPnoXd4JVmGzVmBWh/tz9LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2PfNn5Ig/GY7M7/zqOW8kiVKL2tEalunwik73n+Okk=;
 b=Cw+O19pnf1oqYC5JEa/ShonIBdqzQzvkwMgx1GxVDEHn4oP3E4p1akm+NAkTqopQOi5cwEPvZrTtZr1qw0T9fJIn6xkb446meTKV+vcFwk09G51StSCn0WQk/URxGpNTMeB6UsnkNT3YfJBYCe/wnKsdyvvwW3XUCufnqakqtpRxTlH+LOlwyh0f2FC50PFapv86xRVMjcuGkkZeizAxDm7+SP3UItlGqDJujt2k1Qy57xRfB8dXHNlehuwkR8CggJVUGkpwSDT2T1fzhkGA1zgZMb5ltCkqyH7nuThdlhXO06WuHqh0uoAcNJc5wZL8aBlFtYh8x9diiDggvJGiSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2PfNn5Ig/GY7M7/zqOW8kiVKL2tEalunwik73n+Okk=;
 b=saT6S6DR7MBlqHt2femYgT79pcx+EQ8nqlPeFd1KdQLhLtTZO+6zNoDELZyGv9pN128+9X/GH74J4ghyHBuZxIqoN5IxEOYoxDUYAvEteLTVNt/xuYrAqjsRrPEfokoo/J5qsRj4XAU/8rZOo9AYMd8irEId/9AF4RcSxcUMsgg=
Received: from CH5PR04CA0007.namprd04.prod.outlook.com (2603:10b6:610:1f4::7)
 by DS0PR12MB8416.namprd12.prod.outlook.com (2603:10b6:8:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.22; Fri, 13 Jun
 2025 21:48:11 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::13) by CH5PR04CA0007.outlook.office365.com
 (2603:10b6:610:1f4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 21:48:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/27] drm/amdgpu/gfx9.4.3: re-emit unprocessed state on kcq
 reset
Date: Fri, 13 Jun 2025 17:47:31 -0400
Message-ID: <20250613214748.5889-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613214748.5889-1-alexander.deucher@amd.com>
References: <20250613214748.5889-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|DS0PR12MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: 452012d3-571f-4ac5-f194-08ddaac3fde0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lkS0+OokGijar/eZuf4DIsnyNmuwAvLrB1GRhHjykC52/mm2GieO0MXNzb9V?=
 =?us-ascii?Q?Iv4+pvzOJrDhC5u/vfUVECgfZLy2I/d3C0McaSfSh5mjgyCP2dO6Sq2Zdf+r?=
 =?us-ascii?Q?c20Txy+fxuaPrgOL5X7sL7trvs249yDxTadHDlBrMnAxyjTfolq6msQy4t08?=
 =?us-ascii?Q?3nLft0erVtZwTXR9MOaNG4Z++U9Llun0vCQuwoqIXbFi02s9ymdwMUk09mSW?=
 =?us-ascii?Q?jCnu5Hb+Kenths3BltjRDF7OJXEfj4FRovesM2vKzGpZ9pCmRtMfOCvQEclB?=
 =?us-ascii?Q?wz+7twFw3OVO2QaHW78ErOWGRsKEYwcrHQL9kaUjpXLQ3iCvUb6nZgESaiKa?=
 =?us-ascii?Q?HW4wCr8cDWYG50+r/Ejdp0wxoQ3jcesgo3/fJyKcfayweS/jMIM+ZIOF3kFE?=
 =?us-ascii?Q?eIadvlpP1Hx+IplopC1gSy84hblNWU4MvI0SjhVM+zyNvI/lqoCJ2vFL1OHF?=
 =?us-ascii?Q?QEmdAASoGxgHUSXdFp0wOKC6HjNb2I8t7XRBP63K9WKGiLjxoPpeRfxRfrKW?=
 =?us-ascii?Q?w/1lAEEXqq7ys+sff8UWZWEdWJTnwMqaFO/Gy4QBiGnENt3rEQXr9NOw8ws1?=
 =?us-ascii?Q?/D+2Z2J7WE8/sXrGTCDOu735vmj6soQKCEB+CSDQ8CA1b6t3kRi2eWJBmPNZ?=
 =?us-ascii?Q?xutifgNECRxaJjLRAYFft1fRsYkttycpH8N8qvQRf/B1pwpvcOCvr3XQplJ5?=
 =?us-ascii?Q?R8Ct2/lDLDeX46euiVVU3zE1gW41C4i8kyy1k1MrPzt8g6SSE6GwmdA6spbf?=
 =?us-ascii?Q?4d1Cx7kV4gv3hNhvOVuZSy+CBJvPONwzrKH3DPhSXby0jO84XXSxOE+1O00a?=
 =?us-ascii?Q?7Sl0LejKNSSTJJrYA0k1ynD2MVC4yXcuaKile3Ku84Nm4C8wsnhTvEVfwbhU?=
 =?us-ascii?Q?tr+/J3no3uXl4RBljy4/Vst0f1R9bPcx0UWCBsHNk21dXnj9JiXyYgrTCOhZ?=
 =?us-ascii?Q?xP5qSamPa0Mi5BalBA048uaF/b/tp18KJiGgl1i/9PRNgCbm0Zgs7N01sVG9?=
 =?us-ascii?Q?B0gsx9PCiV1fBrBBLN9+phvaPYl7cTF/OSHx/Y6xPrqL1eruWajeQMc51yld?=
 =?us-ascii?Q?+K+SDRKBCtTMQ0fs1lalIe8Qj4rYwoNFm2jERLo1gXXRtoOTj5lCC/LUjjuK?=
 =?us-ascii?Q?WFEW/HzE1R5ySCNWhKkFJxOBHgKT8QYYFxcltgTIrPF8sWTqGLfA9fMKDhZ3?=
 =?us-ascii?Q?n4BMawTyyWhNg3wvkatUNCDcasd4OGgMsjwHHAaaOY7F5btiMgiR0OqufqO0?=
 =?us-ascii?Q?7EW2VXZR9WhSQYX4MkoX2EudQRGqwWU7aS0nvk+FmNz2F55Q3UPefv+d9P7H?=
 =?us-ascii?Q?7vx++LrNraA/WCOEpAAg0Th8uasuJAGxoS15pQR8aSKByX5IOQ8qz0Vj9gN7?=
 =?us-ascii?Q?JYTdZ0KGIZIn5vlKy6ivUbXpbUc4KvNsbTgGDbMvt+BfOL3XGbwylbYCCPlg?=
 =?us-ascii?Q?G+axfBpnFWAaBFFixvnvK+4l1eNzLnDnmxJqlRTouXHULviljkahNs6gnvco?=
 =?us-ascii?Q?1xMuVtaNf8M64Kva5cdyB6njY8w+l+lV9AqP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:11.0642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 452012d3-571f-4ac5-f194-08ddaac3fde0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8416
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 05abe86ecd9ac..5323830691937 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3567,6 +3567,8 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
+
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
@@ -3613,9 +3615,8 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r) {
 		dev_err(adev->dev, "fail to remap queue\n");
 		return r;
@@ -3624,8 +3625,15 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
+
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(guilty_fence);
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

