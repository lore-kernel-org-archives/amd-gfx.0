Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F80CCF9EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 20:00:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CC2310E855;
	Wed, 25 Sep 2024 20:00:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TOmIWldb";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 107F810E855
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 20:00:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekxtIMnN4y8fQnBxfaR96KZ+TED8YXX2lLLHHQ5xLv278C8RJlv4HwRUivxdKmCwwa52UgMeiZau54A7TJUKJZRhVt6K2bN5xf0evhZUEAy4AEzUp0Gb+NImfCwknS+CJISH96Qz4knxdnIl2XfdRlIxvhjTDKzsvse8biaysBLM0HJL02wlBfU7hGF2JXV4rMyNIf40HfzChA+wE9lCAUACpLdYbGLNs8b3XsbFez3sOlZMhM4Hf/suIGIu3EwpfSRKDQ3WfivPjQi3OZAyPjs3Vc1+sdKElIraJUuf+5y/jmYgDPEtMbkqZkjsVj7e5H5fdZyExXqSWffgp5ljbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5F/Eh0WP5w1ICAM6Wi1iac+8nHCmpIr1sUOe2BWo7JI=;
 b=Diw2dPRkhtOaJIIcMyBokfeYkGxNNy+4j47xEqP0IORQRYgXlGcaMQtpCt/98SeuYDAmjnG3yJyjm4dIZWTwFG5jaOu6zVDg6CGUPwW7/KvI9cgJw8wS4Pk7fEHg1neo/1dFYVJ5hnsdpuw7Mh0z4tBD4OPUIaA03O3O+fSj0eS6NCHl+tdBgVr4AYW369WSaqNaQq+LDZ7wHkMU3v8JTQQ4JjShjkr6UV2X4XT1sxFeYCGBVBcSwk8SBP4QZCpWN4K+6YYVHHNCyZ88ASHGh/GRs96xDxB+r4K4zy8fODulkI93LkCOGOglUqiMnOIa52ctKx2UFOk1c8nUgfzREg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5F/Eh0WP5w1ICAM6Wi1iac+8nHCmpIr1sUOe2BWo7JI=;
 b=TOmIWldbwshJO6MapoTM0fSNjjgjas1ppxDpg9eqlazSuUHLAho3ijZN1Swtn3wMl6Gr1W1b4OTsZx+I42c3WO4EVkELn4MZ58Eu9qxiQ7GvPL9y8ZpAKGQTwnHDxcj2/YH8LhO5emaSntGK1moP2IWSkxtP8+QqZYjwjRj3k4o=
Received: from SJ0PR03CA0181.namprd03.prod.outlook.com (2603:10b6:a03:2ef::6)
 by PH7PR12MB6693.namprd12.prod.outlook.com (2603:10b6:510:1b0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Wed, 25 Sep
 2024 20:00:04 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::3c) by SJ0PR03CA0181.outlook.office365.com
 (2603:10b6:a03:2ef::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20 via Frontend
 Transport; Wed, 25 Sep 2024 20:00:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 20:00:03 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 15:00:01 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v2 02/08] drm/amdgpu: screen freeze and userq driver crash
Date: Thu, 26 Sep 2024 01:29:22 +0530
Message-ID: <20240925195928.142001-2-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240925195928.142001-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240925195928.142001-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|PH7PR12MB6693:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b2fc424-2e2e-453f-b09e-08dcdd9ca57d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6BxeL6mVVkQLeMtwkhguEX+ayKUB6FIvaL1pOx5/P7BSDswg4xx7FqBoUG+N?=
 =?us-ascii?Q?jUx3/GxkWaumEiEoRiV4R+TRcbwIHfhf2q5KjIx0e8NU5CxPTdoFIe8fkoBo?=
 =?us-ascii?Q?o64zwXLxmUqA/qx5JfmBQqcQKvJtkwYA7Kfz3HfLGZxNUAktpfIgnjI8LmXj?=
 =?us-ascii?Q?AnrafRJq84ZaUidBGDf0N49IV8MuIwNDZAGz8w1lSf3AYqXQ8lebGBYuIhWz?=
 =?us-ascii?Q?DPXLSzSx2keVAV1fiOP4JIZiovTACQZMckpmCAoAb+hASziPMgFWnve1jCaa?=
 =?us-ascii?Q?/3WnSXq5AAgEqWaIex2tFy3hTcwcu17V0D8aJp16dTKj9YwlVpBQGaiDq0tu?=
 =?us-ascii?Q?9wZIgW549awOnvyZllwTBWv6QOKKuVpuFX4INPC1Cj27RBORxHxeBNVdFGF6?=
 =?us-ascii?Q?Iuab7PrD7g6HEaMYT6SarPatc5bclm0isvlsNyijgSW+aayKJU8Oy+k25AZg?=
 =?us-ascii?Q?QPms4v9YhBlMPnnNSsnf/0/0X0eocP8czkbUGS0HJYJissDfm9qavzB2EC/2?=
 =?us-ascii?Q?lOmlbF9u7Xr8B4nS/MKCApQWBRITgCHCNZLu7YwGeB32NLXs54vaPt553Njq?=
 =?us-ascii?Q?8V8lqw88zaV9JSVJ5uMDpQxbtnCuYlaPB0ci70c6EV8/WZXf2T5fKBhJE/pr?=
 =?us-ascii?Q?Sh0/t8Bmk0WHn/5+hmjdpjDOOEWYsKZk8S/aG1FhIEgmiv3FhbLJCaQhrO6Q?=
 =?us-ascii?Q?fHdhm1UuBsXd1CnwFWxeAA9TyDjIjC8PyPIrRWUcZpwEpF8Ms09P93v9D7de?=
 =?us-ascii?Q?SMPsvPJr9mU8lJrzhlKsomU2Ojr3idhC4fa71MN7ttAFhDpIJJko9221k7lh?=
 =?us-ascii?Q?6epc7HPuN6hfDrBEEpk8/XHY2AjyAkPeh7+LLibP/fsoL6GlljRl/yA12m2V?=
 =?us-ascii?Q?orotALPZlnWP5tHq+Wb/qDycnzjBp4iuyfjv6N6Lr+OsFhbJOr0DGSB3Sy0F?=
 =?us-ascii?Q?MAXHYuHkzmzWXstD8uTOedqHosGu+BU9jQOw+NMePRMsNMOcL4v/l+DODIgT?=
 =?us-ascii?Q?PR3yvLJAZk4DI5c5X15F5Iy8t252qJD8//Hy8f6gtoBd1NEBKkmeFOMzKW6F?=
 =?us-ascii?Q?2o7Z92G2U1j1h8i7Bj5mSCbQG+Nsxob3gTouA8OWexPjpeQ6r1S2BCIgXi+c?=
 =?us-ascii?Q?PqvnUlxRLWqWU2/vPDBfRbyZcSZZmvY6CGnd854+n0OO15lpDKFurwncRlbA?=
 =?us-ascii?Q?n6ZWmh0dRYgZJROqJlr+wR6KihrOv7QCedR60go0C0g++r7AwUlRVU+tdFdD?=
 =?us-ascii?Q?p9+Wdj+GiA7U5/3xtPpo6ZTqTTbsjuMrV2h9d2pPEvZBYeEpLtlBQjabYGch?=
 =?us-ascii?Q?KuwnB2FdkgpZwKiEDtfV/MdbXyjv2kfu2w3oeG2l7ESJ9zdGUui2aAF1/tW/?=
 =?us-ascii?Q?Db7Ngzg9QVcU3DJNOGkWpG5zBze1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 20:00:03.9476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2fc424-2e2e-453f-b09e-08dcdd9ca57d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6693
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

Screen freeze and userq fence driver crash while playing Xonotic

v2: (Christian)
    - There is change that fence might signal in between testing
      and grabbing the lock. Hence we can move the lock above the
      if..else check and use the dma_fence_is_signaled_locked().

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 96d1caf4c815..97b1af574407 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -185,6 +185,7 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 	struct amdgpu_userq_fence_driver *fence_drv;
 	struct amdgpu_userq_fence *userq_fence;
 	struct dma_fence *fence;
+	unsigned long flags;
 
 	fence_drv = userq->fence_drv;
 	if (!fence_drv)
@@ -232,14 +233,14 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 		userq_fence->fence_drv_array_count = 0;
 	}
 
-	spin_lock(&fence_drv->fence_list_lock);
 	/* Check if hardware has already processed the job */
-	if (!dma_fence_is_signaled(fence))
+	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
+	if (!dma_fence_is_signaled_locked(fence))
 		list_add_tail(&userq_fence->link, &fence_drv->fences);
 	else
 		dma_fence_put(fence);
 
-	spin_unlock(&fence_drv->fence_list_lock);
+	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
 
 	*f = fence;
 
-- 
2.34.1

