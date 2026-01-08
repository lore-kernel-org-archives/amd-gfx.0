Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69945D1D465
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E260510E77D;
	Thu,  8 Jan 2026 14:49:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5H2DCYWH";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35D2810E76B
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3Ja9MbVPMiU3YEkLsdxkCLZeC01Oea/KEFDLZ1iCYQjuj2dOj8/9DjBZsBUIVzfrKpJcywa7jQNvQatDkGXR7ygc8H68zQonAv2+tRlrrIXG6urGekBrDEH2vkeim/XA4F1PmwM0SBqOP4BusLLpZoQ2+XpW0jk72RMxsA35L456v5kNTIXFrdpkfnahZSuSXeIuJTbO3lSwmRHPRT5GFbosp/JvFqoZSf0zaAkKRmcZPA2gDKdiyRZD744BWtfzIdql+fTZfqM/AvASBekWc5cEAGnCaToDA1Cgatmncnhq2j/rA2THS1AaCoM2i5AvhryIF8sADdLwzBhe3Bz7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tcAahTDFRVaduK8wjmq9W0xJGdk3lY2kWJKtcDzOz8=;
 b=Yr0OrD5XZY5oO0v1EpdNK3wGKLOHDDDCc+AVtEGIbugSLARlFqkJdc2l6nnFhoheTkqCY1KGsgYU64TN6FsMdtsj+jMhEtiIjIetalKaSU5k6G2rXiG/iXdgR59peFBmfSHTFKpwiIgd1//AJKPgWy3rxHKp+Bsuij/ru3lHSB5verrPt315hbNv3EbScKP4gqYCd60L0/6K2sFuEsFEyRNY967QbYEzYKVY/7LJ8kI/g9h3LVe4gUuUcNUdOTM4sOyKvX7DQhO70XR3rt7Fzcu9IJfWSBSKg5fyO6QIfyLTBSlxqMWHS6awcawu1fgdYVudjm3ooIXJQEg9Am5Tyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tcAahTDFRVaduK8wjmq9W0xJGdk3lY2kWJKtcDzOz8=;
 b=5H2DCYWHxp99opIqFdgzM57aEEZ/H9l/x+RQsHPM4/dxi57yK02aT6v2zRsU7j97a6GamqtlAvDkT5s6a0Z8BLK6V82dqgmZvjoBMIlkcPkUIu5A+tIT839vbbX7/uuOJlrNuA1ppDHSU9r4ptTOIEH9DpHfzw4LzYDJXrpo8Bo=
Received: from SJ0PR03CA0337.namprd03.prod.outlook.com (2603:10b6:a03:39c::12)
 by PH8PR12MB7158.namprd12.prod.outlook.com (2603:10b6:510:22a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 14:49:10 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::ce) by SJ0PR03CA0337.outlook.office365.com
 (2603:10b6:a03:39c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Thu, 8
 Jan 2026 14:48:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 8 Jan
 2026 08:49:03 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Jan
 2026 08:49:03 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:49:03 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 30/42] drm/amdgpu: drop drm_sched_increase_karma()
Date: Thu, 8 Jan 2026 09:48:31 -0500
Message-ID: <20260108144843.493816-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|PH8PR12MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: 59adf6c6-ca6b-4295-4318-08de4ec51469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RUiAeDpQy8JWklxlCe1XGmKYbUnEvubpfK0mcFEDfCKC4IckiWLRYR5Dkofu?=
 =?us-ascii?Q?YIr/rXox0WY1p4xolMGwruI9P0xjm+S8z4nm6GnKoEzxmwpMMGVeaTdOtFoV?=
 =?us-ascii?Q?8tZbnQ+T6CrcCgd5QW5AHhlgNtlC065UiSg9kc134tYCWtP9l1cK2XELz4AR?=
 =?us-ascii?Q?LtPBfah7c1G3e26uWEVqIiy6/lQZL+TldGi5Alm1E4wOETgQ8TCJ4hF40Z4B?=
 =?us-ascii?Q?3oQ2MZA1lUzfTrwto3rHtWJen4Nx/qZkXQ5Ptjw/pG9EmuKbwDcnGuJw/1B3?=
 =?us-ascii?Q?uXkS+2dKJla+VkiVornZ5nMzt1asPLzBScNy65nbKyg5yG4xcZ8lAqd49VPB?=
 =?us-ascii?Q?QncrC8OFqrj2BTUpHxZMDWR1UTgpdC+o9T/Xb62SI8EjsXGOaSZxC02wi+yV?=
 =?us-ascii?Q?MrV+zlM4/GguB/AiTl/ABGXIvqCKheIbNao0jHu/9PrB9unDD4ZJom9aoQry?=
 =?us-ascii?Q?sExmvjpNTjhiYixd4SjmhfJHV88rg0dh0nxgzfztmVpZmkGxJRWAriev/zX3?=
 =?us-ascii?Q?acXddWncTsW+6RpJS4q2AOgpCFjHWwGtVOAUfc5AnrWHOmJDh0lPgptZ0SL3?=
 =?us-ascii?Q?o/u5oFDR3FTELe6zCMhzv+8kOxpmQj1UZ4BQRJ6lrYAc2xE2djWFEb+gqVkj?=
 =?us-ascii?Q?qK93h+fxDGIOovWplLfgta1bH0tMuK1vSuM1uzCBn9SjaaaKd9MjG0H0r3fE?=
 =?us-ascii?Q?VSXFDv7T/7WbzaM0bNHTt0wSb0B09OKdhbqRivKtXGIYAGXWYtNtwhE/8VNu?=
 =?us-ascii?Q?zs+/cRXe/RL5pCJiwfNRNPaQHJc9bgnLgVRg7JftXgnvJjxsmeR7khkWqh0k?=
 =?us-ascii?Q?6dMzmqWimtDJ807LhJMzGF26rGfsqswaG3qEyKTTjMTvldWVgj+JiSlslBfy?=
 =?us-ascii?Q?ZtQGnAQL3J5Bz8+JBPkGKiqcpCqjyB8fTPj/p7CT0LnPr/YHBsUo2cUL/koq?=
 =?us-ascii?Q?uwAkWBqMgWk+yIlJhRhbi2cnFV480zEfcR2/lzU7RKiXSOcW3O12o8Y0Z5dF?=
 =?us-ascii?Q?ipBAgYOwtS4EqDB1xVSbPqnJEBvvV3sZ8wlcn8zgm+anUk+mzk/GY5lGu7W/?=
 =?us-ascii?Q?8LZ7DHoxcKL3H/3y20iLDspnXwExlz0eh4ADncJD3KAfidxwtts2nzk4RiiO?=
 =?us-ascii?Q?U+nOjYVGRsDTPr5gyPBmBPaCE2g69l2VgnmkbWJkkry2YVO5iY9KamXd3O4P?=
 =?us-ascii?Q?+nFBedwv3jQSf7Sj/G+yVy/94qiDGc6EszPZ3B5R86giw9wuOAShF6IZdx5b?=
 =?us-ascii?Q?bFzWm4PMTcDv5QgNFZvJL2AYRHvVfnDvWkngR8znjXhQ8kH5XlJ24oyAhUF2?=
 =?us-ascii?Q?Sud/xVyqqBXgWaRzFq4qSy6bo4G3pHi6GBIBLcOj1KN3oIPRKCPKTdnOiDBF?=
 =?us-ascii?Q?ZQN9uNtYdW3dwAgGEEliDByCCFafIegMP4T9AsBGwDkiZfdFaP+OvGxz+crI?=
 =?us-ascii?Q?PyP+niEsKHWb/Dk+i72nBxRrWinIdclh0nKVRTMJ7PKRVyjTzgsNx0WYSq4M?=
 =?us-ascii?Q?jKUPoo2lozugQd/Ds361KsRdxRStnL2mFgM0APgO6HJormTOf/0frn9XC7+H?=
 =?us-ascii?Q?5Ft9AW+tI2XIC7g5JqM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:08.9800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59adf6c6-ca6b-4295-4318-08de4ec51469
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7158
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

It was leftover from when the driver supported drm sched
resubmit.  That was dropped long ago, so drop this as well.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 868ab5314c0d1..c9954dd8d83c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5808,9 +5808,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 
 	amdgpu_fence_driver_isr_toggle(adev, false);
 
-	if (job && job->vm)
-		drm_sched_increase_karma(&job->base);
-
 	r = amdgpu_reset_prepare_hwcontext(adev, reset_context);
 	/* If reset handler not implemented, continue; otherwise return */
 	if (r == -EOPNOTSUPP)
-- 
2.52.0

