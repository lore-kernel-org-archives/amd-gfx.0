Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C396C31D97
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jul 2024 17:31:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7125110E663;
	Tue,  2 Jul 2024 17:31:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VUDXve/l";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9242110E14E
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jul 2024 17:31:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnfFLjn6d2zIYFE0V0oIRV8Bv3RrO2x9IbmsZbcjSra9ODYEcxCeCTPXNH8l8wBqVcn9RIs2hHK1Uya/TLLkhQ0vKHXmUzDG/PkW06pRkdyGJJD2Vaf5gZfvc6Nj/znGUBduruzBNc1tA8sTxR7UNWhNVXad0H+LmEAGCkRBYatQ2qBpqJcoImYmPWIk3OUwv9valpRHrtQoddWb48S4XmeVXwg+1AhwppvDSZ84tDQEz4ZQrEu9i4YcSxsQ3fGjGrHXh+Isv5acoFtW63Odi5PzNasz3kiQMhruNKuXhfIwjZ0e9bUUr2wrG5YAWaC3WCHcKJ3EmV3M7vfFg4UBvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0y7E508lZSjSvX1Pwxu5o+16hwco82uNjI8ijN7tgas=;
 b=jXWpDbjSwZgFw1wfKKqzxgxzR/59bfv7a4ejw22VxLfH3QCHj1A2vCrnbSDCzTBJYA0j/ZYAEK4wbNxC5b4x4UpSnyMFdaoGboMwovdGDP5/I7czj0iwoCaVnqzhpmi2BS7muHHI2yp8V6l5YVsGQ8HY7CmGUvDr7TYthcsWVFa/tgAz9X9j21ZIM7eOsJ704Ztl6EfMOiIdAaGZuUTb8FGWcVdL7r8B+/PDh60gqcF68lrocNfWw3P5i8GvrDD7GrNNi3jAwqdywHXX+/0etbwjIqkp3yarHhgmPtQ93H9cQxwnhRfUFf0lWZRiHejMWAAFBKmF5km5JiD4LLjvkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0y7E508lZSjSvX1Pwxu5o+16hwco82uNjI8ijN7tgas=;
 b=VUDXve/lvWBzYI0/m3CKnhL1GXZDeEsfmpmrz4pu/wOVzpYfsCn6sQHyqXi2yy60jbqVjdcuIPOnktIYQpXyrPHUSnopOVt7C2oAMtoP2AATXqqjiFBokLm+OB20VrVb378KqnGfCYfqzmzJsLh3dLpglEM+ml41sm/0gsEv3ns=
Received: from CH0PR03CA0438.namprd03.prod.outlook.com (2603:10b6:610:10e::14)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 17:31:02 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::33) by CH0PR03CA0438.outlook.office365.com
 (2603:10b6:610:10e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Tue, 2 Jul 2024 17:31:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 17:31:02 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Jul
 2024 12:31:01 -0500
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Subject: [PATCH 1/2] drm/ttm: Allow direct reclaim to allocate local memory
Date: Tue, 2 Jul 2024 13:30:47 -0400
Message-ID: <20240702173048.2286044-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|MN2PR12MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: 7362b080-7d15-4b20-06fe-08dc9abcbede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y6ESMka1xAq4ERcsg64xdMpaOMcWgdpte11KCqil4oKTLYZltq1nY/mpzAK1?=
 =?us-ascii?Q?wIAAWD+TJBDAztS0pvvrjGGHZ8omTGvsvJETb7KDvdXwfibgMqy+YQZKZXkD?=
 =?us-ascii?Q?MtjZhnkC5FPHITDiesMHoLPEUK71yBDYj0SBR1GR5t4GQcJGQ6K4zaSzbF/6?=
 =?us-ascii?Q?5viare1DMWKVYeM3rlbR0e42FwAZQcTpsPzGTW/j7Dr1hx7ZtRqnHh8Vt8zN?=
 =?us-ascii?Q?p1X6fq9SNIkzEkGtmZNGB8qgmhaxTFuO89DKEPKGT7Fk/YdqUaPekz/mSJh2?=
 =?us-ascii?Q?6xrt3q9bo6ylohmgCem+nb+RQ2PMP9PkC8TIXsBooa5yXr50VC0K0ZdZqL+X?=
 =?us-ascii?Q?aRo/KYtkyDmpvAmdMiIDPKBo9HkLAbbVZnW3mmQQkqNVKPOZ/AmtahJuc2jX?=
 =?us-ascii?Q?sAk4Uxb1tI8tevZ1+4qIWxF8TOv6RbrsWvzqw7uzHEeDV09Ng8dEj7wFGO4K?=
 =?us-ascii?Q?KzLRb6cLHtFOFGg3GGkGvqmjMYmm67WG2w6zmjeRgieszjwhuULs8Ac6JmVy?=
 =?us-ascii?Q?6ti3e7vX89QBEDXbMPE1Svk5/X36GN2NHj2OEFw6fSCnG5aaMtcDl4iZ7MZ1?=
 =?us-ascii?Q?wsj4xulMGAXmF0u03vgM6YUxk6Tw7r+jDaqyldTGWKeujEHhm/81tkbXLEQn?=
 =?us-ascii?Q?qqfXNxnkA3vhSFuvfpdeVQdq9Upo39MYIUxICybn3zN8dqx+i797edz/apFL?=
 =?us-ascii?Q?IO9tCxnJWAkAhqa049WdLbUYdANN+6fK3Ux4oykMKuICSrDXJn3MqKNghEJ2?=
 =?us-ascii?Q?H/naoFycTh5kV659XY+POmUSVm+bT+6wM22g7yMuIao8ueOaBczuEDPjXhac?=
 =?us-ascii?Q?+557JnrGm8c3ssVj+TO6Qwj8ncvD79utB12uq0IYKySlExDeP9BIOscxvCyz?=
 =?us-ascii?Q?DsuAWKVFF2AVqpAOw9j3Ee6DdOEgwqxDy84qs80x0LiUdxoQBU+bqNmAhaJd?=
 =?us-ascii?Q?C6H1QDonl2OrRdGYDpzL0fVQurXoB3uEbdbSclXYOppBLfCk502DdhyAozGK?=
 =?us-ascii?Q?XlvIOvRosFwqanlkDqXKOPXp3jLK1OPakLjK8pBaU2l2tlt5iI/D72teRaTP?=
 =?us-ascii?Q?aJZDw8U1CUkqETx+KROpPwt6DYybvASE/UmXcqFioQlLyf5KLUK9QW8EqQdk?=
 =?us-ascii?Q?LilPgMouyE5vBU3mUZtWW/ndnUjGsRXKblQ1CuANZEO1tVsYZDZB6KmOWVpu?=
 =?us-ascii?Q?evJ4eXO7yOC1YcR6IbRGA4OR2i5E3TYvgGnPfAdvZQ821IUQAjw1+NUqnFJY?=
 =?us-ascii?Q?6Uuuahk5peSVOvf6sVN19ESLbNiD+ClM50q5ZKT9vgBfNijHBAOT6Zu+4Rhw?=
 =?us-ascii?Q?M6FqRCLeVGCAC5PqNpgHDDzhY47bKxMqloXAAdgbETMAuQaD1Aertlz3Bf2N?=
 =?us-ascii?Q?LiTTzDLPX5rO79vGu3xvzaAiECrLtHlUp0LpYK06IfUa3rkRQN7UTw+9Z25Z?=
 =?us-ascii?Q?L2YMNmxMIUYKx0Jx3B8GU9ACvuPyCe1P?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 17:31:02.5581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7362b080-7d15-4b20-06fe-08dc9abcbede
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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

Limiting the allocation of higher order pages to the closest NUMA node
and enabling direct memory reclaim provides not only failsafe against
situations when memory becomes too much fragmented and the allocator is
not able to satisfy the request from the local node but falls back to
remote pages (HUGEPAGE) but also offers performance improvement.
Accessing remote pages suffers due to bandwidth limitations and could be
avoided if memory becomes defragmented and in most cases without using
manual compation.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 6e1fd6985ffc..cc27d5c7afe8 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -91,7 +91,7 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
 	 */
 	if (order)
 		gfp_flags |= __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN |
-			__GFP_KSWAPD_RECLAIM;
+			__GFP_RECLAIM | __GFP_THISNODE;
 
 	if (!pool->use_dma_alloc) {
 		p = alloc_pages_node(pool->nid, gfp_flags, order);
-- 
2.34.1

