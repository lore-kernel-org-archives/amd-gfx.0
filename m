Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F40C5B555
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F73110E986;
	Thu,  5 Jun 2025 01:46:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="exKqjhtW";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80E5C10E87D
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5Tc1UFzrhnsVFmkgYcv8gWRSccDZbH9m3r5JWVJNG9Q+4ajebVwCc+7dBveidAUSkqd1XbmOtWswBaZ6Yof/2H1LnNu3OgN1pB7qCkUQcKx+BxHnRisvaZY1jxxRO6CN+yrgJMvzOhsxv1ITxZlaghERGH7JcqGr6VpenatXCbn9Ed9U/WsMREIw2xxV/gkg9Fa0NlIdU2Do1KTfSr8U+EnYO/mCpnA1OkkxW9fyeFtwoQhR5LUeAfbEj//awFyLHId2WOXKjkSTYYjkaiy7TbeOqdcsInejI7VXezASGRWQ7Fj/PaRSIGJt2ogdb8igukobA54wrIvZ9R/Bqvx2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yqEWPVrJlbTMXo9Mm80nEi04kKH8zoIgnLbTHFuQf0=;
 b=qlJAhWkO2Dvm09XUrcMtQkdwoq+coiccRrZUNlS0hssPfDqZc9a+g7X0bgU9kEAPyKvvR81IXdUDMJKz1wMYKNWTKEwvyKudjBXHsy7XBjNpkjcWyVbFrlB1QRng8O2Ox2m3bIzz7JOAMfVBcBEeXQ2kJpSpvqYVLLAVS8LEO2FDIdxQxpAhL/Ex+Sc/dVBICvCieBLsG53mXwWF7wi9CE3P6HkYrEgNjhRYHTqnk0MLOtqmaVtaR6f/eNLU2SB+7kfQbAEqe9Tp2+USf5w8OZ2eru5jFKeCxLabRTjyLh3NvIzKHUzMrC6N6vqwoJEiclvzGgaxD7y8BVJEnYKl9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yqEWPVrJlbTMXo9Mm80nEi04kKH8zoIgnLbTHFuQf0=;
 b=exKqjhtWCLAKbvAwn6Z0QOGOC6KiJKnCjh7XqbgKb8rgETaSApfYC2b78KO2mP8+5qUJ2omhpcb5046k5/0P8xcK2xhKoYsD9LKKDc8UE4ulL6/4e6HWvkPyp+njV5+Hg2+QFRl/uonTamsQxdCLhCV+8xbKIZYXKLYR+iUeD8c=
Received: from SJ0PR03CA0137.namprd03.prod.outlook.com (2603:10b6:a03:33c::22)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Thu, 5 Jun
 2025 01:46:29 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::24) by SJ0PR03CA0137.outlook.office365.com
 (2603:10b6:a03:33c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Thu,
 5 Jun 2025 01:46:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/31] drm/amdgpu/gfx9.4.3: re-emit unprocessed state on kcq
 reset
Date: Wed, 4 Jun 2025 21:45:44 -0400
Message-ID: <20250605014602.5915-15-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a57338d-f74b-41d1-f4c6-08dda3d2ca6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z5IDcswoUxdmMNWsFn/sINxC6Dg4+m6A3cEih9WbNPSqlzRQkjHcNWl30Vxu?=
 =?us-ascii?Q?3xr1Hu1QJ851G83gpIa05kGkDinhZcpKpC7hDolXo/P0+onsttmPtGu80P1I?=
 =?us-ascii?Q?rTTmpgq0SDjlYiGRtqhs3nc4rq5myW85yFs5uCXhdeA8ABELxFI2+mWOjCC5?=
 =?us-ascii?Q?8xBBIZKNZYADY9Y/cZADE3vEVqokGyz6KAsybwYojxUqUAmlb5KEiTdw/X8m?=
 =?us-ascii?Q?FSrmWRU3e4TzhWiAaCF1cgyH3RCse+fnuDxNP/sq8g9I62jaDgY7gFCv7Tlh?=
 =?us-ascii?Q?IURF7yoztHxuoMiXC1XyEyvjCxcJKnj6ZJY0K2D7dlOnzi4N2FYkE+iJQBeG?=
 =?us-ascii?Q?XTmGgcuX/5YypsYow0zyN7vJUXVIZNEde3xtCEt6USWE4eMUfIFKko/2/W2z?=
 =?us-ascii?Q?TzZtz7gWKMjdl4WDwUZRzVOnBH1Rx056r5Q67q1mk4+uuITQ5XEWkoAtjAgh?=
 =?us-ascii?Q?vJtEiPe/zAxqDutLLL/UkfLsg8DSCoIYHjC/Z5E26V/sSb3vUrc4pe79sbAT?=
 =?us-ascii?Q?lVNcVhotZWGLJ4w2Fi6wScOlRl2jlFfeWFRQSNtotLzUaSGLuot4HLu0i6fM?=
 =?us-ascii?Q?cLZ5D+MW6knjX+AGFvUtlX33nD5P82u17H0ugcYu6ZlmVmBnP8EjkY+POSuU?=
 =?us-ascii?Q?7IgXT70edFK6FPTsc/9V1odvOpg3N166N1jpN32E/rtVkSeRXrmTQhlmml82?=
 =?us-ascii?Q?SW7O94GKa0sm+Pyak+V87Gryd++4D+bREMNT6U9w5m4jEEqbNRh+F4fZP+i6?=
 =?us-ascii?Q?ZtFpC6ROmR1mus5ekfm64Hc7ZywlXafEtHzo/a5OJtP33XZmD+MGxEtPpn5K?=
 =?us-ascii?Q?QXisDW7Xadg0ndg9/2afLFQXKXmbDXIeD/B7LBi+dFdpMaOM/sqq1Ic+m2Er?=
 =?us-ascii?Q?C2oxL9fmiGBLD3ytuVM0/MI1kmq/mM1+RdbRyYJW7jmnieUMyIgq3HMhvqmx?=
 =?us-ascii?Q?qW8AMd0JjWd7i4JkoQSLh7Hmeab2EryAgNmwZGm1PvBAgiwahfU6ewg3gGsS?=
 =?us-ascii?Q?TYh/mscDywLGWL67EPs45fgNDZ6wnYaOqxZc3OrZRHmR61AXHLXsQbag4pwi?=
 =?us-ascii?Q?DrdTcnDtgh7eS/hftzJPfAqEAt7cfdBzVdixrBS1RkMUpoennNCJH0783X9F?=
 =?us-ascii?Q?BQn5sLJDB7/ZOLnPYWNhPUGKe7gOyre1N/i2ugwfk8z7dgHuohTdbxPtcHAW?=
 =?us-ascii?Q?sPGi5j+oreNZAw65vLuzRCbYlAO6uRNFmkSYbLuQKzdcJvUVHBTPNuxz88z3?=
 =?us-ascii?Q?pi+VpwKqs3mFGTcWbNwp4DV7936wHm0jQpSnXGE1NSQiMl9XnO1f2Spz2CSH?=
 =?us-ascii?Q?wWGl1vDlMoSKajH29L7Lz/tp+rZ0aWYX9QX2xk9OG47jR3eTiaaYQBIPnT/6?=
 =?us-ascii?Q?AS5c9VUh8GfqfWMJK4p8RtgN2DOHICA5734NxSqiiq7cOZ3JWWUj4Gb5XM9M?=
 =?us-ascii?Q?dLN20ii9q2DVIbSas/8N9fb6BAg7lnnTQr0jBv8Fy4QnKbAMbTIjzyIADPze?=
 =?us-ascii?Q?EMDA+GOP6RQfOvdWSk61TX3uNML4yoXVs4B7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:29.0270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a57338d-f74b-41d1-f4c6-08dda3d2ca6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index c233edf605694..409cfdfe54ac3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3612,14 +3612,14 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
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
 	}
-	return amdgpu_ring_test_ring(ring);
+
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 enum amdgpu_gfx_cp_ras_mem_id {
-- 
2.49.0

