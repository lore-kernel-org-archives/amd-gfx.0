Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E21C83F1B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB6C810EAE7;
	Fri, 11 Jul 2025 22:40:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KHcY8xjq";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DA8910EADD
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:40:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FF+TWCrdTaQDfzWr2oBLsK7Ji6G44sbgED4dCiA7hzuMGRrOvYK4rQYOi1xR5hDvHl+ax/mTIFqCc+qakoON7yU+W0Dznfc9OsbkHQnKEJa9aHGUY4jLGYHizwOhSSg3Tn3SxhTelU/Vt/xjYMbis79yxzNAa6QCgNSAPf0tCdYTC+eKkPo6Bk4XbKnMI/MviuhkgTLt4HMsIgoJi7s0ew5IO5Vyjg/sHP+tlbpa/1J+JI142tpONkEWQblZqXsKpWEOw8RlkFGy/t/LRhs0HEYq5azNWhqZuEmN1GeNAH/KCHntU/eJg5GTdk0w3ftToKkLuCLrl3SV1XpUFxYUcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSA8WXXHQaJZVtoVVIG0otoNQ4MZvDiEPIax4I4cWuQ=;
 b=LaflQd8bfk+zs5eIKLe0K4XTJ8XOVt4Tgw8TF5cCqFUJeVAfVqXk0WhMi/iGnJrrQYO7gpUkT3cUYG00SSMR36vfBeTdu5M6bY1HRs2mXf27HcLaJVgFwxGZk+UkRu81zitBE/dTrvMdstYdugaIFfyiHb5hL6hkyqC8StFOQRKGq9F3LE8NSpDxCfJeMSuqQU33XB0M9AzsvSTLm7Wk8nEEnNRpTRd6RdhEgkyzfBmdOkNd8/U24T8qe6cN0Mz7/USquX/uGlFiGHdLMGoRZWgh9YNej08P1xrh0BFGMGWBcKxPYLFOQsQZZi6l8IofULtd++QdfqZzGOrtgifb0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSA8WXXHQaJZVtoVVIG0otoNQ4MZvDiEPIax4I4cWuQ=;
 b=KHcY8xjq+Ry06eM0rM9fyTfJfZjdiu8AG96IQbmkvIHVe4+QOJ89hFFUX8Me3sK6aa7sMJU4F1gS4ZDzHB5A7nrCh/nX1eqq05jFW20DKEMCtb+4ZPwUW5LaBCFkpamhH5SxOqiDuJydrwWoFrOKDKTFGX1CwoAQMNNA2Qf6MvY=
Received: from SJ0PR03CA0212.namprd03.prod.outlook.com (2603:10b6:a03:39f::7)
 by SA1PR12MB8143.namprd12.prod.outlook.com (2603:10b6:806:333::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 22:40:45 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::1) by SJ0PR03CA0212.outlook.office365.com
 (2603:10b6:a03:39f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.27 via Frontend Transport; Fri,
 11 Jul 2025 22:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 09/33] drm/amdgpu/gfx9: re-emit unprocessed state on kcq reset
Date: Fri, 11 Jul 2025 18:40:00 -0400
Message-ID: <20250711224024.410506-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711224024.410506-1-alexander.deucher@amd.com>
References: <20250711224024.410506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SA1PR12MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: feb0e52c-9041-4cbb-5f82-08ddc0cbf93f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xvp6oIHUVl8RXd7HINutRe8GSHaT2bJ7s6OqgeAbhyad6ZVB4WXsn4XQFt3f?=
 =?us-ascii?Q?PD278XaW0b5ITotta0JyrClIaJ6JE0YKStkDx8tXIxCpZ+2MxrQfMCA0lfZi?=
 =?us-ascii?Q?8PDodRGUoSmS7c3oc+XpLK+29L4YKnwOD4+c07yAhPKraIK8RckjtoespK3D?=
 =?us-ascii?Q?QbYkGf1MsTEZtgSlBb7olVCWE0Xc5CAlMPEBVY3y3oXRCzbWiW509xq+cU5j?=
 =?us-ascii?Q?QGw3uxwNXNoVivXL/YNXOjZxYttUzPGyWSatbV7dLVWPeG5KcFu2ys5tk2jO?=
 =?us-ascii?Q?jwe23O6WHPZAWVdVDp1lW15pJgAfm3oQVpkEdO1UelOIsqw+EHNAaGWaE28d?=
 =?us-ascii?Q?9uFNcnDQwgxLA+/+3h7L0twPUNMevMbeL6X8MxYo9x+P6Z/inuJgzMnVqEe8?=
 =?us-ascii?Q?Q2Kgs6HsnVIwQvDx1/D2TvukiivqkRoU4wpELuaWFGbzMvw0505z2S6KHbjT?=
 =?us-ascii?Q?UksUxwm2x4aOuiTadJfpWBNB6JVRoN7M9dpGYxScydFXDvDOOJ5blxOG5h0K?=
 =?us-ascii?Q?GkumMNTAgGdXH6MUQ7jRadXi5+DVyTdPY2oCASaqdGCoPF7dpYrxlRxeQqCw?=
 =?us-ascii?Q?ZjuoT4Ya/dh1uWoZWwKwtdiU4Dro2Zvs+UKo2RbmQI6LaoE1wxN5C6lHqvyx?=
 =?us-ascii?Q?2mqno4Fm+A/sxApNrBGpksyNKCxKa0RBULfyH+UZ5xFw5pj2fc18ngqHBOsw?=
 =?us-ascii?Q?BdzLZkS34avsOJ9X7TZHPeVbdD23wGcpNPYGfTNlI+vsSt7mKbZIVg0NHYbm?=
 =?us-ascii?Q?LPb4CwqsOIqcSvF5gdzLUm7kOWELJP2rUHA7wFdgB10aYo2RPwB6Hqoa9hHG?=
 =?us-ascii?Q?PjH1b+kjMQK77eAhvRYLU9cR6dXPwlPqV7mGWvi0YVoF7Xf8uVVTHy1Pgrr+?=
 =?us-ascii?Q?aTtVUIPEPzFKhIbsGXWbJyx32YxzTSKEJTKcdIs58ngQR3i8jZTW30UwfzKr?=
 =?us-ascii?Q?crluW7Zf6wt001Q4IYkEW+HESWjrxcAs+D+sHg39cbvz8oOkZBYOUPNIthY7?=
 =?us-ascii?Q?TZdLCj5vXJJ55VSI7f9iE3lbNz6cs9GDkjrx8qPzSYfwk610Is2A1ON0PwUe?=
 =?us-ascii?Q?1o1PQlN0/6Rd6jT+c2ugAy3YZJ1pD65ypczHuagKXaEwNtEpl3MSBGcVPP8a?=
 =?us-ascii?Q?hmmCXqgRQ0JoURYVhPfsg+5W9wmwHkdyoJZrHCGuFdGImpXIevzhv+PeMlAw?=
 =?us-ascii?Q?CwkYWvnv3IR4mIr1urtPNkyDPYMZR1eFm55IK10U9Elnoadi7XDjkccGkGxq?=
 =?us-ascii?Q?8vOiyr3Cj23wqiUfxZ5yyizGnzOZhzYJQRyGo8Z1RNxCkoTafiFmjPvbGZTi?=
 =?us-ascii?Q?u4iQlbvmJsZa0wAcQjph2/KqZYjNA0K8Ez2/YYKioXxbnMRZoS1k5kYrW7yG?=
 =?us-ascii?Q?EN2JxzlhbkEgbH1uaYw3cwqWyAoJXSKIzqj8NWrZ//9XAPXEE1TLL9uT1q8e?=
 =?us-ascii?Q?iWODDtsJDvyJWyGCxruAabCxWwo8xFIpeetZvxqOJs8nwXPUhbsbm1ex6Gah?=
 =?us-ascii?Q?lfMx81qWrGt5nsvu9RhCDdalZKbidMCLWUA5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:44.8161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: feb0e52c-9041-4cbb-5f82-08ddc0cbf93f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8143
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

Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index ac058697054f9..9c0cdf4dde714 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7189,7 +7189,7 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
@@ -7246,13 +7246,7 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 		DRM_ERROR("fail to remap queue\n");
 		return r;
 	}
-
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static void gfx_v9_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
-- 
2.50.0

