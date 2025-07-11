Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E990FC83F21
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62D8010EAE2;
	Fri, 11 Jul 2025 22:40:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LglNFXU2";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4642310EAE1
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPBMB4BHMpocfGv94LuepWFjSBEueeRaTVebRz/RghkJks+KH5KBtJrlLMeh0DkWuzl05QkWzYZlxL/yHovEcC1P/mAfX7X49alIiL68ogram6QpjW/QgWkHvlaFtpcSTL4U1OILxh+vpXaoJBv+wqyWMFB/za16oX7w1eB9+81uqC3dPmigOyclLvbj8dixgioi1Ama6DaxlVNLhNMBMQvp+hhsPVE/FT2fzJK23DInm7Egp/ojd3zyYRk57tSaJdBX1A0Fhl6rBUprFeu7Qcc66xuZes9YJTGLKVFhs86evQXzRE9GiYOxNg0mAeY2Mal+QkkX9FsImykZyJ2yyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rUBp9hc0Ge2TEAhS5M5LMRbFOOdoFsLFajCQcAjKLs=;
 b=k6SYgcEyX8jRt7feXkqXrFMT5OnXCapnY1I06n6UfaUVvK1c+Xgkq29N/UIz+KvUJ4r2KaW689uBUKL8nNdeaH1tWIQe/WhGWd8ojZLTgPGHgQWPNN7IVNjTk6IZCyOLh142h7C6UeKPQGTLK/BiPwT/DP2vrnF8aupB+0SNwp/UiEGBpLHgNHuvLTkOnXbFCSpm9yWEvnYV4joeKl3rSVfuezKJCvsAeRZECbOniZkE6eTPDF/SaFz9Ve+CTOze3CfalsbUy2h4g/3QUuMm0K3Sdehr6id/7CnLKZ+4Wxvl0eJ6Bg4lZJTlndLjtocYOOOi0hejs67E9D7Zz8d+dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rUBp9hc0Ge2TEAhS5M5LMRbFOOdoFsLFajCQcAjKLs=;
 b=LglNFXU2gm8XY2RzcleGgcY3RbeCwPY5gZw1tzCe+eJ0NOz2xCVQaVDXrSI/Fj/ddI2fEecbIpCSUbUFh/fjHyZ2CqyeNMJbqBDZxpX3XVwwDa8QKVsxfsOuYWhVdzdmsjZ505/EY5YKeya9Yy9lkyTqhKTKp8b+yhlja0ZCnrs=
Received: from BYAPR01CA0051.prod.exchangelabs.com (2603:10b6:a03:94::28) by
 BL4PR12MB9722.namprd12.prod.outlook.com (2603:10b6:208:4ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 11 Jul
 2025 22:40:46 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::46) by BYAPR01CA0051.outlook.office365.com
 (2603:10b6:a03:94::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 22:41:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/33] drm/amdgpu/gfx9.4.3: re-emit unprocessed state on kcq
 reset
Date: Fri, 11 Jul 2025 18:40:01 -0400
Message-ID: <20250711224024.410506-11-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|BL4PR12MB9722:EE_
X-MS-Office365-Filtering-Correlation-Id: 935fc492-c02f-4a9e-a9ab-08ddc0cbf98a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bvdt66t1edAijHhRFGMv3m56Wside0KF6vpvq0VI5N4H0YO+PCLh+yFwwEgW?=
 =?us-ascii?Q?jnWlnir3IaVls3y0Me1QDKzBfoH4rR9zO0gxOtHnLkZu+cZXNW5PcAunIedT?=
 =?us-ascii?Q?bE4JUGCC2e+04IWWZs7MoJnUagTtDyH0S/V++MMIkq83yl2PCMQwTCay+2sn?=
 =?us-ascii?Q?JLwHzeoiDUXaTTlFBBHP5kH+7r2Wv+8uL++arCAI+LzOvesLErPOAft4tt9J?=
 =?us-ascii?Q?le2NM1k+bMSwKeNmzaK4LUioIlC/udskb8eyZ0B17VBaZHx5eGqhHwr2shYs?=
 =?us-ascii?Q?Fe7mEyqWvmN9KWG/vDBnHU9cNyD7VSgUhTIsbxs+X6l1xV/hMvAAyeCkMZjw?=
 =?us-ascii?Q?KIsnPjXroH0v2DDKM+NwcHUGDtUynjOmL3aTgoY3sOW2n+1QqW8BW2YYCj1B?=
 =?us-ascii?Q?GRrpwRaNu2pc8syWtHGt1VnLs1E0qVFLH9pDl2Es8rf7QzIWBjmcwIXs/nMO?=
 =?us-ascii?Q?5hFCoZBI2SdJvy2+nU6sYKwS4SdjjMetqlezhYkXtDayj68H4FPB7LCJXICL?=
 =?us-ascii?Q?erdEpX4ZHhyQFx4gSbi9sxpclFW3hQ3mzOtIHq7p1JDAn3F7+Scs9pmTQdTX?=
 =?us-ascii?Q?wBmCqq1ABrmsze589o/ZHzwvqP5jy18aOJwshc3vS2ahc093R7ZrXYotioup?=
 =?us-ascii?Q?J4zcN8I/KYsxpJbJbbCZAZOewJZWjm3CGA9JRIEVL6yT79sZxBLiN8esGZuk?=
 =?us-ascii?Q?4z7uvIkyg5sRQwXhEL8DD/OI7Sz12wwD8BExLbCUw7uhynJqd4AyftlA9lNA?=
 =?us-ascii?Q?Ti2az4BEhd3NIx2ByUF31YQbSllHDmKeEzuCfAf02RKgR4tfFXXHRsTQ16Gw?=
 =?us-ascii?Q?b2rdI44w5UH6Ia2MtQxdDEoEpWnfgR3/VeGDOZJwVwlNQHETbzJlRPP/FiMh?=
 =?us-ascii?Q?D8H3RvSKZHf+3cwR5UpNbqF3rzClXfGK0Cgw9lbVEdx7buQNC1hzAQGCrTAM?=
 =?us-ascii?Q?TRpEmFS6DvDk2NXmnvU/nw5NK3g6l+oJpMzqFk4sL7YazLcXEUm11rJ6aTsD?=
 =?us-ascii?Q?+9iTXqZDJ5qKDK0W7pKfRpEE7j4sC/cg5AJbXzCs6/jwkX5DvhcTutv1tpls?=
 =?us-ascii?Q?WJQfizo8GK2JBbNgBz8d5H+8m999CIp9kF+j5B7Aw9brTejsKWokzfTon44k?=
 =?us-ascii?Q?O58wCd3r3HfvNuhkBnJD/Erm1z3+cGY0gguSEPrDt1B6ebCktzZq06dIVeVi?=
 =?us-ascii?Q?UsLchoxauKuy2lR2KAU46AGAQvpbzeD1ajW6PvQe9rPIfergmAmwkZFE6Zcz?=
 =?us-ascii?Q?o5jRimngeUNzZ/TzJVSwyeDl2MGFWoPsX7tXE7c3RtrX8xooI6o74e4InTZY?=
 =?us-ascii?Q?Uyyq4Q6DpgodWj4+PZ93wJYYbxi3rM8ysOtDCQy3e7T3S++DBzdzGmv+75ye?=
 =?us-ascii?Q?Y0SEDjCuvSvF5rD9K6GIhkEuT/52/sK4mMKuWcZx2Q1AKdBvZf92dPC3uePv?=
 =?us-ascii?Q?QQQM7aHJNpQp107dJ9JRDoBDPQElNyKv6N4m8zVEhOZABZXrblAKPtnflGCj?=
 =?us-ascii?Q?fbCirOKpVaAXuOOoJ1fjpOjmOZK/CyVc8bvb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:45.3102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 935fc492-c02f-4a9e-a9ab-08ddc0cbf98a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9722
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index e2ff4b373a319..d80f1fb261d1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3569,7 +3569,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
@@ -3626,12 +3626,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 enum amdgpu_gfx_cp_ras_mem_id {
-- 
2.50.0

