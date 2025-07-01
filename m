Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834C7C83038
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18FEC10E61B;
	Tue,  1 Jul 2025 18:45:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YHQJ4F+w";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 993A110E601
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9VVcXBf4OrMmdMO6FhHadRsKdUHt4l2f7ObyeVEb/ryXUxhCqJH3T2XaK+AowsntOHHFV20+t4X2qkT3RQfyQLaRMHME+l3pVtu8xNKyX3j7YeE03iiKVqFKlyOch5Nzd8kaVC09WlyoyUKycIc9KTn9DDLAz+DaKmhE9RZIPIKHbelsD1kfo2SFZO3HRHWU6lhjahwH7AakjGMY1ZZWuUxv+I8JflKZpkMPgJKaVPICThTBVE8shR4odep8XRTYjUH5pEwwlam8Es2fmheWP00lVvbs1Q0wB52sBEfu6HJLKvwu20VCpCOJNU3DSTe3vO96S6xP73YIOROs++F8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86WAeOPk1JUb2RxrIr9thCiy8o6FauJ2/k1//iZPCz8=;
 b=AS0TRvPCORBiF0Q/pkyvToP7eADjPgj9XPHUppcKrncJnr7ng+4wDQWFFtIHP1yMiMYFJTRsfecgFNz+Ynbb9dY3YCEdeVzg7adDVux+AHHQWTHC4EE0wYQyoXjtjAQWdmJVAB+EsaOe9KBt4MIaEBe6cczWRfBit91Yl+RdcbjBRL6nkCORYMAlrDwiqoRyUP83KRnYflvMjd9+mm7z7Z8qPAvKQLzUZ+y34Zc1IrVfjHZWXVWpq1WftHc5Gm8qbqn9tx3lipf55WBjfkLajDtw/klzSK2WrpL/vWIiid5xY5JI8S9+aQ53Sb8a7SktcJh/m+IGyA6uvbHxy1u1dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86WAeOPk1JUb2RxrIr9thCiy8o6FauJ2/k1//iZPCz8=;
 b=YHQJ4F+wAl7+TRH5+3FkovqQGuQ4G5DUJcJDw1PvUBFHSnyOAzusu+jveIbluZ2FLM3kxUT1kO7V3HCjdRKBmIMcTggOpgnoRq9IuOLgWXc4uNqwFJ61Eo886/MV3Zgeo7l/qnLtpi9Cm6WiB3voExjpsDSeBCOPcsSAWv25h6o=
Received: from SJ0PR03CA0124.namprd03.prod.outlook.com (2603:10b6:a03:33c::9)
 by CH2PR12MB9494.namprd12.prod.outlook.com (2603:10b6:610:27f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Tue, 1 Jul
 2025 18:45:13 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::45) by SJ0PR03CA0124.outlook.office365.com
 (2603:10b6:a03:33c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Tue,
 1 Jul 2025 18:45:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/28] drm/amdgpu/sdma7: re-emit unprocessed state on ring
 reset
Date: Tue, 1 Jul 2025 14:44:35 -0400
Message-ID: <20250701184451.11868-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701184451.11868-1-alexander.deucher@amd.com>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|CH2PR12MB9494:EE_
X-MS-Office365-Filtering-Correlation-Id: b8736319-a35a-4de3-5f94-08ddb8cf6a23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q0WjkXmxyUlxy4U5fbeempnY2G5YkaiY/7GMSW74Kq45HL58jUadP+UvcmEJ?=
 =?us-ascii?Q?zQku+s/XXOKrah/fQ6mSKs1r7w8UkOgEmzOCy/WA8GhKd+igJaFFVNh1utoh?=
 =?us-ascii?Q?ZNaduvCgACty8sbZxu4YN5ZBmW2RGzDp/nMr7VHQc5UGL7IbTrnSqOohtle/?=
 =?us-ascii?Q?ZqiYBKIqby7+rPV1/3aOIVwp37abhwdKfvR0VRh7wnwDqUqmRTDvdUgSVbhC?=
 =?us-ascii?Q?W65+Ci+QnWEEwdTuKw7kYtSMrbRt5a+Rqj4MTwoZyMisHeW3f4ltfkl20uEY?=
 =?us-ascii?Q?3bdUsfOopt58GxSXKsqMFhZ8v/NjpUXTmjHdf0bF9HddL006iflXNT66z1JA?=
 =?us-ascii?Q?/AeMF8lha3oNeFt6WfOusrHC1g9S+bm1hVIEWzpTlkDNgwuxFyElCmV0XgQT?=
 =?us-ascii?Q?V/CpI06A4+FTyoJFWs/1k0cjV/m9BdeGDU8RPkAyEDk/MVh8/vz3b5KP/fo2?=
 =?us-ascii?Q?HxSlB+P9pv/MIhZcLDdYxRK0U8wBdKStESsJb5kUxLbAzgQPQ/d2TfIG/8zs?=
 =?us-ascii?Q?rqNXQ0o4GI+R1w4lvaoJF9rafXdRguqj09vQn59LKYr3QZfKR1nlLLlPmj4g?=
 =?us-ascii?Q?1IfFE08ySRpcyOO6gfQAy/U/MF+Fbkcfv8lrxgQ0Nz8R2iLU8HI/PQQA2VMF?=
 =?us-ascii?Q?Tf57B//aeNvrWRV7iX5ND50jgT7rfX7bViGXvTMAsD4krm5PEffgYKK8TK5g?=
 =?us-ascii?Q?bJctk0jQ7ToytTH+zyXvwhrv7rg2HWgUm6tIpN8YzjhSzTIKtPET+7XU+jUA?=
 =?us-ascii?Q?4dLypMUNa0ytRh2skcDebtDK7ZskX7N843wTJprZF9hF1VbMx6hoTpe+86MY?=
 =?us-ascii?Q?iC1wupkzrRHzDT+1WkQZFM1DP9kew3+c88ar+Y+UJOKkbXE/NT1cfj/7j6pY?=
 =?us-ascii?Q?IKRqH1nEL7DvtwJ2yXaA2AiNo6T+F8/rSvrx3B6PonD+vgIkw8C0mWTh6MgD?=
 =?us-ascii?Q?hfaLyq/TsOivmdQxITPHnQQkh8g6LhOsv4dEqOzXQmogyJSsZKAOnvGIhlcd?=
 =?us-ascii?Q?8CemO/r98lOFmJIfsmQ3slzQNha7y8rdFr9bNA/bPsYfiAj/lEbqClwVlhXW?=
 =?us-ascii?Q?XbaYv6xV4F6oghjP61EgOm57T5Vimc2NjngVij5ZDquI1VReXQxHwRBRkwKJ?=
 =?us-ascii?Q?9G2cLldT58eZnS+iIRaukuLivYAI5fz39SlEEnSPRgSio/aZuKrBizNjLolj?=
 =?us-ascii?Q?iOskJQuiERo5vIcFPWlM27G2Jr0ccVGauLD9VY/EvZ9Rptu5Wwfdyw+MkAY0?=
 =?us-ascii?Q?upgKjPN3pYR6fky4WkZy9RwrWfFGHcalI0ipdqWEpMH4/GQ/oKREQaope4+0?=
 =?us-ascii?Q?JI4vG6qEizP7HssAqyJl6t0yj9a4xZnFvQXWlbpM4ycMuaqxhNXvr4JJ/21i?=
 =?us-ascii?Q?n6z0B8jab1HgJSVW+hSou73vVAorsDPozDbLouimw7cQOdjg4ufLc6r6NyM2?=
 =?us-ascii?Q?yw2i99OaLwD3bJKPRggoeJWbSWxHFNrO9nkB2Zw2N20yGBhjyENzgfe5xnLK?=
 =?us-ascii?Q?OrSkTW85SO9glxIq9PHoCzq2Su2EtnxNKeqV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:13.3581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8736319-a35a-4de3-5f94-08ddb8cf6a23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9494
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
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 99a080bad2a3d..64322a836ebbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -807,33 +807,27 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int i, r;
+	int r;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (ring == &adev->sdma.instance[i].ring)
-			break;
-	}
-
-	if (i == adev->sdma.num_instances) {
+	if (ring->me >= adev->sdma.num_instances) {
 		DRM_ERROR("sdma instance not found\n");
 		return -EINVAL;
 	}
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
 	if (r)
 		return r;
 
-	r = sdma_v7_0_gfx_resume_instance(adev, i, true);
+	r = sdma_v7_0_gfx_resume_instance(adev, ring->me, true);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 /**
-- 
2.50.0

