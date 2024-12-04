Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD63E7716F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 23:32:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82F4A10ED83;
	Wed,  4 Dec 2024 23:32:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UJYaZ6Ky";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDFA710ED83
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 23:32:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bEuyxiu9GUuxQjYb8p7oapLvoRBc0iKngkyyrtVNxvNHUxZ+LiOwLIg0RQZBW96ogD18QFDEwGkGxiozWtdlNCV5orJuF72kuFzmZs4rgFBmMHtCuVEkdo9E6aBHAoWr5T+maxjcUhcnfdttk5Qe7pBTVOp9x4sPwuAuqkxhTv1Ig14nYsoZfA5GmsnAQz6ilfqjT+aaeLb9OJS+1IWYMsReTFSrMyUBpekKnAMyDkDmrFnCn7cOjrpp1fr1qMcEP2tn0Jlh0Bv+rYjx9QrvyqY8bDEnJsDuixOGq0SARntp8Ur421aJ7SdlSiGFgOBWui5C0i+4o6Y3MFO88060HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaA83k4pia1qNEomNpN2Y2nw3xojogCSvtQcnlFPIvY=;
 b=JHFQaOF7KVARoka9rC/VKJt+eYBw9nAAc3mCu+P+hHXxYssIBAVd8L52Er4aa77H7otCePuIi3vI0SZq49ULWN5T3W/ks7oTWPUe4xBnFN5uQl3jkZH90KvO7l4uTbOlcxAU7wWQf5qIvPQKBqGsOslF+XAiaC0y7I9+fCwKactgRjqYV1Sp6THDUwYjMS1MoMechhLQYNeAKALtgIhjgQf+5+Yi1sXWmqGS1bK4IkvnKvye/x/gWxw/SwFBZZdjlvgGszVkcBK1wycihNvxsjOMLEFC973DB7EyyOW6aJoM5Sfm1VoWFn2Ugzo3EsD+WgFRJa9kXCSnN+R8vDxzeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaA83k4pia1qNEomNpN2Y2nw3xojogCSvtQcnlFPIvY=;
 b=UJYaZ6KyWSjyCiQeX6HOTN8+uPHWL75xkrxzYLCr1Kv+pYWIU3or5hZf907P0XThzt/Jmtzo09QPvtWGEHMrzxvGHS+wRvQJwfll3EBz18eGZS6TzPHbvU/zBBweyqzm2mhwnhvTtmsH2AVCnJ97XuTeBXXcj48q1xbGNIKez20=
Received: from SJ0PR05CA0072.namprd05.prod.outlook.com (2603:10b6:a03:332::17)
 by SN7PR12MB6765.namprd12.prod.outlook.com (2603:10b6:806:26b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 23:32:14 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::ef) by SJ0PR05CA0072.outlook.office365.com
 (2603:10b6:a03:332::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Wed, 4
 Dec 2024 23:32:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 23:32:14 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Dec 2024 17:32:13 -0600
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Christian.Koenig@amd.com>, <leo.liu@amd.com>
Subject: [PATCH] amdgpu/uvd: get ring reference from rq scheduler
Date: Wed, 4 Dec 2024 18:31:38 -0500
Message-ID: <20241204233138.796163-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|SN7PR12MB6765:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c04e40c-0991-4edd-cf75-08dd14bbe22d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IdFB4Dz38DNgbcCCUmE9m2NeboRDe7SDa5TfSTW1p1hRzJgFcZoxFG4CPxZY?=
 =?us-ascii?Q?g4JwsgzI4kUa2KXOMDr95W9d7/fpYHOBqpQzso/o1Ag9wcfC1ofswGjL1w6G?=
 =?us-ascii?Q?Ompu0DHy/LeNA/2SIr6eyzHMZox/bQAwxxsiff9gwf9Cb+V9WfjnxwVIWE6Q?=
 =?us-ascii?Q?OOPn3damUPV9LPOUI/ASTF2gIuzNGHQMb5qsfmb1gZSS9X5sOLidWGaZzjkk?=
 =?us-ascii?Q?2OV0aauSvkjnEFY4D0Ig31WYnpxKUrBpiJ0Hs1Aevz7IGPtV06jy+DWgitmA?=
 =?us-ascii?Q?2F3m7bUx+pK8ekOyXU+mk3rUh9L1M3Jabt3BX2aZJqST/oC+IjGN8gZroYhc?=
 =?us-ascii?Q?MIWL8h+SCsnfwbYUljFEESvo6ikLkof9eE6th/u/RdAavVZkQDl8fF1STupU?=
 =?us-ascii?Q?a52yW0yDrqbHyClHDTWDg0yn+BKgxIroyrFvYA/GW8OLcLJcJth3do1d0v1j?=
 =?us-ascii?Q?ofpJf37Abd8gx6TXxsMbIdeNDUD9eFpx6EssSXyZ/FHakiggePtDGc8B0ifZ?=
 =?us-ascii?Q?3HPbFYDi45OWrl752zPP9m/ZId1nY+mbbRQqWr0Do+tXnb7U6anIxdAwF0pv?=
 =?us-ascii?Q?l+hypUlwiWp+87Ba395JOn1HRwuBgB1jntRyule/mtfO7z8BlxSHiqNgtaog?=
 =?us-ascii?Q?o8WRK7Mexk59KjJ9psW9NKTkjmy6pnse+JdY4I+ajdREdCnElnTwaMbmT35N?=
 =?us-ascii?Q?51s1YuxMYCaZ446jnpZv8j604pBcHkZcHtJjniFnt2matmu5WmBnGZVV359E?=
 =?us-ascii?Q?NRa771gDSeMtVkWJvy6XpbSXwXA6jc+7+6pbzWGf66UH9w5zYipi8ucQ+tdU?=
 =?us-ascii?Q?GFHFDiK8xjsqv0WcjGPNuA0gcmdCeOxDyMSj/ZX1qlBfUMozRUGJ8gmxfFTo?=
 =?us-ascii?Q?jCQq0IrEdQkucQwMSFqPnG4kxEzbudU18waPSnS/mAV1aJTlLHYqyWvO2oo/?=
 =?us-ascii?Q?3iy3tit+ywLfLOwSe7OgnSE3l5Ij8mmmJKvAuhS6XMcunxiBOEI04jdcKsNS?=
 =?us-ascii?Q?LfSzLn01qgWrgu7Gi1Q/vyDrpk6XQ8bSk1iCjkgMjaaqMv1BCbSZ5bUnrAa2?=
 =?us-ascii?Q?O3mQf+wIITWpPjfixFVp8+4GZXIJZ4pPPUntK+a+ah9wAL5p//XssJKBeqpT?=
 =?us-ascii?Q?rwIlFS0rdN2JrRahHutR1kAnuau+3J7NuLmbJBMUva+lGFo7Y96NbtxxBnRP?=
 =?us-ascii?Q?pLNieY3f6LJ5msvUwojBI6lhhj8MJ+fyFFKBipUouiGwVk6v8Yfej8/xa9Jo?=
 =?us-ascii?Q?b4/+BvGc11L4dHtKiyVxAzZvg3XvWUBzs0X6LuZFRzq8JlGcYZDb18Eff+fw?=
 =?us-ascii?Q?il7bUI6PKKIAFuJHtl8isU5EyiPb19dfeo7DfApsq2gXZZyOnJxz/enEJ3ov?=
 =?us-ascii?Q?yoY/2YzD0EiSDaW4u5bxqzlxNPwmDC4PfR0dgAmAinv86a0ImFcuzR0vw7g5?=
 =?us-ascii?Q?oqXAP9xF4MW+VIkoG5L1O/0fTEiim1LV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 23:32:14.1165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c04e40c-0991-4edd-cf75-08dd14bbe22d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6765
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

base.sched may not be set for each instance and should not
be used for cases such as non-IB tests.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 53249d4ff8ec..9d237b5937fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -1288,7 +1288,7 @@ static int uvd_v7_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 					   struct amdgpu_job *job,
 					   struct amdgpu_ib *ib)
 {
-	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
+	struct amdgpu_ring *ring = amdgpu_job_ring(job);
 	unsigned i;
 
 	/* No patching necessary for the first instance */
-- 
2.34.1

