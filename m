Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D060C7115B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB80D10E421;
	Mon, 23 Jun 2025 16:15:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XHYHIRys";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED2AA10E416
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7jfpWEKF2a1hRecQd3Tm1CuluTULC4gAT0ayTYxF8W8vGFz+8BbToNyrt/8GO57R01vV9tWhd4+8DgbRHP2/RgHsJwDHjwSWvvfsRzpe5pI+7rlZpL1OcLzHdXrT1F/vVJa2qwpkZ34ZgSSyNldkzB4Irl8B56Ys9qQE/iF52kpEBBH1T52UxRXcTHxNfCHkryDPKAUGtaeWSLYzyaUi5hCVExlRCc9yQp4TUmInkdLlKr/MtiMs5m3Xximts5fZSLn3FYphSdao40pDV9QxMm6RNojmKIFB8FzfrH3ftLGELBIGcOLQJ00HgrWQOtE55ktYVJdlrLh7D/F5xXgUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhTW0Vdz8satq8xcKXYJ4HfSokk2w6HrwrTgm5o3Zug=;
 b=X8XyQitqAKXvZgqnVub3+azS1vMLwjFxYRkmn5Clhox/vne5v3OkWRKBOt23o2ISIlcwq0J+eWt7jc2hUkGjCeDBlN001SocXehOGJEcBSWHDuOqQ40r/cpZ38oeVw04FM9jT3X/LKzI1UwougoRe2fcE12niPaTuYULAzsAn2On7RltEeP3BJH/Ac5+lXs+r3tcyWl1CVQRWmczTra2O4OG1AulldPnW6xh0IR5mQEYB00utN9tIrJhjcZIbDVooNAo24ErxK6owuK46IsgRbZdWT5zYWYwmWzOl6IDsUY/QtndJ7rWy28U3ghq/dBdirp/FUR61Q8K/ZgybHqXXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhTW0Vdz8satq8xcKXYJ4HfSokk2w6HrwrTgm5o3Zug=;
 b=XHYHIRysey70bT1ioupkT+dqy0eXg+JTheMiK+WJBwmFcQeAkZ4Bbtu1+OKUkKDrwSqJDSYYKZDkahx0WvC1COArMBS4zbCjGYdVpFgdkWO+I5sCERBTkKyjn0Ix25qm5//DaDT2RtR1itqmx7w6ZJFGDJgfImBxqANFJJc5WeA=
Received: from BN9PR03CA0950.namprd03.prod.outlook.com (2603:10b6:408:108::25)
 by BL4PR12MB9723.namprd12.prod.outlook.com (2603:10b6:208:4ed::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 23 Jun
 2025 16:15:11 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::cc) by BN9PR03CA0950.outlook.office365.com
 (2603:10b6:408:108::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 23 Jun 2025 16:15:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:15:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:15:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 23/31] drm/amdgpu/jpeg5.0.1: re-emit unprocessed state on ring
 reset
Date: Mon, 23 Jun 2025 12:14:29 -0400
Message-ID: <20250623161438.124020-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623161438.124020-1-alexander.deucher@amd.com>
References: <20250623161438.124020-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|BL4PR12MB9723:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c9216e-002a-4ec3-42d6-08ddb2712120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8o/Tk514Bx3Fph5F/ZSOUuZ34BWiE3tTZpFaDd6LELf0vVrnCOeoDGrAbMdE?=
 =?us-ascii?Q?IjajDK+3q1LeD+ayxhEcqJPs+QeEA+1ZZBLxR43mFJ3YGkOwrWoxokDD+mJb?=
 =?us-ascii?Q?YPR/N01zpW9J1I+Zc+ulR7yp2KsW+5DpqKj4qO+Ie6bEZ9pANhvVGcm2JPJS?=
 =?us-ascii?Q?pvlL+kgbm02pvMg9BSFQXVqkzKerqK3zSvq5wyLQ+gE9Vlo5YZZQIh3Rq3AK?=
 =?us-ascii?Q?dYWY2uTRV8Dr3o8sFOXZKS0EwFx8HkH0P650+VmF2o8p/v90QwYeUlPeEg6t?=
 =?us-ascii?Q?uROKvX96ABiwPl8Zoeqm+y3lnUpUfKxglDb4pJQ2siXDzC+qc5CvCupP7mcK?=
 =?us-ascii?Q?3X5A3+3ljFrqMM4htVrmWtqrNLQHCdpmywtVne17u0GboCEYU15grsUz7wSS?=
 =?us-ascii?Q?EHw5Y1YwOaX+i6D0nDSO19Hiq+dEildAT7gWtcRN3/aLB95MARMwm1A1VvFc?=
 =?us-ascii?Q?yrIqhoVw7LwqIIa5V7I2DA71e4Rk8FFmQ1FXifd6xQk6wRxThBa/gLuKM7vy?=
 =?us-ascii?Q?pu6sEzTW5N19CcJVIB88zVMpshZAWdEGzy0LU+bcL5W2Edc+cQap4UZEuUlY?=
 =?us-ascii?Q?tAq58VgFQRbtZFKh3itONfQEkuQPshQwHL6Vt1zG9TgV68u26a+y+xzFPR98?=
 =?us-ascii?Q?fn7j9EE3XPpyOocgsIWzm9sgNnRZlBnkzdhn75AAByfT3Xa3DCDsv67mHEaG?=
 =?us-ascii?Q?m3uPb4uMPgCd472w52I+uO2fUhG/NnYsjCFTyJmQdWxDzgHz9ogiIj4HOcLc?=
 =?us-ascii?Q?qgxyQwCLldJmIgDpEpY8/gNg71vzc8/6iSM5QG0kkI5XBVV1iyy9HSfo2EkF?=
 =?us-ascii?Q?5EZdkrmVhBSDkmBIalV1DecS1o5+gBEaPuU4siFG4vq8V0nb8FBbCyCfipVV?=
 =?us-ascii?Q?yMW732chfUN4KK2paMIHzt+PB6oxNyYjNWaEP9ikpXc0WOkedeuo2IQv39zO?=
 =?us-ascii?Q?X1phoq6WkSoDWWO2kUSWTTqZHl9kgQsdNYPW5VjoR/rYn3sCpRnsaUoeOpOC?=
 =?us-ascii?Q?FTbnBcXkgcVMxaay06o0U7D6hMkC5uyh1axPWROrgtyP6+DSJEbuJdZIi6Xe?=
 =?us-ascii?Q?K815nEjVHXv/U6+isfX8QL1mgSUcRfOksSz7pmJEOvFG6jotxNzBJUJeUYdq?=
 =?us-ascii?Q?yE/QKqNdYmTm4Yq/80vneGFb4Aiziwg5tuNTix91oBCHHVaXHzpopuZHBkeA?=
 =?us-ascii?Q?UXtgPqIDFWQaCAh0Zo903AGqGtTaX3bRedthNXMGQ5jWnRp9IBF0g4Zny+/W?=
 =?us-ascii?Q?v5F0nmHTJqFGs1zesRn2XHr+Pd0N00GKOxwDoCXExX1Qvjx+lm8+8/+1fU4j?=
 =?us-ascii?Q?F013ZgQv+0qDrdJkUjN9EI0EsMND1SafyIohvofPkGf5I+OroGECx/BaVha+?=
 =?us-ascii?Q?5zox1d/ZRyEkKI9qRQiwL8/tu03VWY1ll5X2MhquP9XBhokcNU+A67hUotPr?=
 =?us-ascii?Q?+jemWAczgI8rKhNiUt5KRlRiA9uZBwlhXcQav2K7DBiicZJmgRi7Bg1mbTub?=
 =?us-ascii?Q?zln8Dh61CMU8telKZmEguvgcTRfYVXyXfWhA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:15:11.2861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c9216e-002a-4ec3-42d6-08ddb2712120
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9723
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
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 6f8a16da9d608..5473cbaa5c0e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -838,20 +838,13 @@ static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *timedout_fence)
 {
-	int r;
-
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v5_0_1_core_stall_reset(ring);
 	jpeg_v5_0_1_init_jrbc(ring);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
-- 
2.49.0

