Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0C1CA5FC1
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 08:32:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99DA210F226;
	Wed, 30 Sep 2026 08:32:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KkkyFQK2";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E53D10E44C
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 08:32:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVZD5Yfek08QcC/YYbAdT0fOLoT9RgRuA3Hd5yDj/AYUcOQaT9rz9az5IPO0AdU6qzpmNDRcdYkRQGUa8p3bTBge3cuT0POi9ZnIzKRnOYEYStyZrnUeeS9AkkH4qs5ruwe2oFOypuBwhZKb+xNLNCjWcuSJtqrtVg1sJEFhxQ2r8hRazRrTU6Cpjbhu8HHUvKktRypVjMRXfyIxXeXhnnZABVDjTjvmz3XWNRO6kZHVNA1Ptg4zkoo1JpQCx/AXErseIUgKZDQa+2urkZADGeZkKNJpAi30MbLDCWx9k2+NBeG3n2sJV2tkSaJ9OrIq9rdkLcTbnsW8n0gUoRBEjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVUL5j3jPMZOI8jiz8jEJhw4q54kCcb4O2NhPyiVO/k=;
 b=bWPRPkxeLAa3bKnJSFGQXQ8v6x9XFP2Xi5EWxgQpsgD/tYGjf31mIuy9EJz6U+sIBbOvJtEArW8sH/on7cip9gFEmWnmwkCby7RL808asxkdCOqPprCmFi7lEI6+bylbks5/LGfy9GQZqxETLE92S4DzSP6fbZaqTC4j5huvN9ZCKsqbGTSFUk8AsOJBR4BGUhGCZtPJn5BcaAcMxvonnpf9NMZiBrlQG6mmxuPv6If042WleRSSjkfozeCsV8X3/j4rNj316a1X3sMZlOVkGtxSX3RSaO3qz63575Rzvj4K6mDkHCh5TJ/Dm7t9cAsTCjYBb4g3D7V3QbJlPABMmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVUL5j3jPMZOI8jiz8jEJhw4q54kCcb4O2NhPyiVO/k=;
 b=KkkyFQK2m1JOYmD1qAAn9tUrlNRkaYvSFqsid3usEmzBqapcm101IvhB1z+P5DimIcyJfs4kzgZECD/1arlcysigVvBk88J5dNQfsciBfVRP8clbpYH4Kr1tmbm3oYzV/wd1EtkwiZLQjz8nxZoR4Pk1YoHeeiAoYThywjmQvjE=
Received: from BN9PR03CA0511.namprd03.prod.outlook.com (2603:10b6:408:131::6)
 by DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 08:31:59 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:131:cafe::1b) by BN9PR03CA0511.outlook.office365.com
 (2603:10b6:408:131::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Wed,
 30 Sep 2026 08:31:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Wed, 30 Sep 2026 08:31:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:31:57 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:31:56 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 03:31:55 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <prike.liang@amd.com>, <sukhatri@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/userq: return the memdup_user() error for the
 user MQD
Date: Wed, 30 Sep 2026 16:30:45 +0800
Message-ID: <20260930083148.151311-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260930083148.151311-1-Jesse.Zhang@amd.com>
References: <20260930083148.151311-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|DS0PR12MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: faa84fe1-91bc-4a7f-cb58-08df1ecd4a8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: lEOFXA7Zn/G9QXA0yf/0BG2kxeRZ9wzQLJ+tRZO7NRWuO2VjF8lMdtmB2Kf+NaOdZ9cWgaRDV9KdwXHsmhkyKcS+EUfHen62AmAL4bFNzUGMnDbVgpjqLXAY/5n0dqN4qQNb3cA3OSK821Z3vFszd3wEIfKOQexHMVOB9O+a3YROF4fcXgyWj+sDpm0XIMsrwZaQb3r4d/FeADYiA4k0CVkUz8MfFpIuGAA5LD8zvfzqC9rYQbwnT2CtAj8lUVU52hAazLT09X7aTv/tN6sO3Ivb2ZJimcQjmgGqvvAmzousdnQmVip9pCON88pvcQ90UUO5ppuw+rkmigDo43A8SpO8qBjSmcAdHwYe7Hr3WReElD6msljuIAM9m8yWOR5qFjj1P3GJtZ8tx1QHDrSeflqeYYqm63D+9U+gxm8Wu3hFAQgnNTs6lIrkKtZvIM56jXAauY13BYQ8bezbYnOYkWZCdznMGb+GwdjEqqsNGDOG0V1/8xzDePUAog49w5d8j7F8ysstaLpyZhczG0n7iEaHKmPzcntoSsKSy0T1KVUYS8zrW5/hPAs/76xKPc9f2nImF8aqac97va4lrRsNKK5zP5RbLh3xCaxqKrE85TENc3lIWOF7wavrSHM3znPQcFeroFUFZuvsUcUoD+XsPQ5K7BUutxFWSnQncZ4mYlZMU9VWY6JaMzAGm1hO0e8/x+TjsxkgN7NmRLS7X7lp7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c4amqTWYE9/Wl88bWtWt3/Jv4tv/HQyPZQCHd5FNFrqRdZCAtsWtXxefUyK5kd1TofY4HbmTgxm6CIhsNE8tjxLzQpw5izX71INRYKyNBArlSxDIkbfrrZED6rlV2nCwNMm3FXH/oS2fdMpAXnE+0PdC3XT5aMOOKxGmJkcoiNVlqFspggJy4Au/DAYxxwfYxt38Bu5Z12ZqtI3koAjpLwW2aWK1IjkY/1Eg82vliGvar40Bf/4lQFWP348MoTT5BEr6BDktIWAED8Sj0BxLx6HDh+YnCv/a4fTJUh+FQn7KtlszuZhab/cM9kwXcb2vwq8S6t/+h0HYdRtsplarNglBcALcjAU/QmZyF4rO+3PHTbxdI3az0NeHeX8Iif9IaglMTf/5axNJUxlQ5/Ur27g2+V+zZBNfe3xZc1DDz4IJsJRIr1BX4lxxoi0SRmpK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 08:31:57.7303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faa84fe1-91bc-4a7f-cb58-08df1ecd4a8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780
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

mes_userq_mqd_create() returns -ENOMEM when copying the user MQD fails,
even though memdup_user() returns -EFAULT for a bad pointer. Return
PTR_ERR() instead.

Fixes: 2c695d7c0720 ("drm/amdgpu: enable compute/gfx usermode queue")
Fixes: 543b61453774 ("drm/amdgpu: enable SDMA usermode queues")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index e6c167a39d44..fee00a8c08e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -408,7 +408,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 		compute_mqd = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
 		if (IS_ERR(compute_mqd)) {
 			DRM_ERROR("Failed to read user MQD\n");
-			r = -ENOMEM;
+			r = PTR_ERR(compute_mqd);
 			goto free_mqd;
 		}
 
@@ -453,7 +453,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 		mqd_gfx_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
 		if (IS_ERR(mqd_gfx_v11)) {
 			DRM_ERROR("Failed to read user MQD\n");
-			r = -ENOMEM;
+			r = PTR_ERR(mqd_gfx_v11);
 			goto free_mqd;
 		}
 
@@ -498,7 +498,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 		mqd_sdma_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
 		if (IS_ERR(mqd_sdma_v11)) {
 			DRM_ERROR("Failed to read sdma user MQD\n");
-			r = -ENOMEM;
+			r = PTR_ERR(mqd_sdma_v11);
 			goto free_mqd;
 		}
 
-- 
2.50.1

