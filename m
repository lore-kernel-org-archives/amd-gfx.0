Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865E2C7EE31
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 222FC10E961;
	Fri, 27 Jun 2025 03:41:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b7YK6gFi";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 528A210E93E
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebHxtmedZuxIw5vubZU1fbFrK/M11mEFZbXFzsRJ6dF1eNgARy9xXtdr7JsYzq2Bmqm5LKHEuK0dHkFqoAk3g7zThaw3dECbQ1h7U9FRAMN3izyOsc+CvjaElc4Fu23qRFY5P+JLTzI+UJ7uu9w885Prsk8LZlwMwwXRXUrw3D97NOwX8Q4CNMelmdLNCKdsO6vZheHTNEjLu/jDFKwFd3mtOtKKRpin27bbkCdK3pTgIW13rgEfk/O0iw9NCZ9CucYLThfobb7U9eJFuWuRmyjLZND7vo2weqdXePmBkLc5Wf0+Kv10W66h3owXPNqKMAkJ4HI3Ovt5B3Ncah8HPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJcM+iffO4yA4CeFmAkL9avhgHeSixcg4vk3BdfcT8Y=;
 b=RtpmwnnyvcsAQ0PbgXx2qjRctT+H0uRkTCiTEI8AYFri10z+pnlihgCyZsyNaF2VSJDKAlwtT4XqEEnCRbe9UjQDIb1pcskjHNQZnb5EvEpktwRj2IDLcYkQITZDnk1HkHYJm+LUq6H6hNcQsLEraEXDMM9bif0ENsl4tN2xym/PGz8tMzlifiK5F3Uh86vd85ci89BY6Y1vOjn685wOlmEGL0V7VJarpfbhSIRdrSF9WEG1lu+cylq3rt9Z0ERvVlg2L+CQc6lRpnWUGALL4AvEii4VlK5mPBpiic8Fg6i+yfToAdaspXrTNlVaw3TQsrPYmtVUDsNx7bxgkz+wAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJcM+iffO4yA4CeFmAkL9avhgHeSixcg4vk3BdfcT8Y=;
 b=b7YK6gFiJam0vIBZdoZ3f9ydlnsXtC9SGBHuFxqgJV0+Ze+ARZHGESGdwZq0r2yyiS+yfdaV4zNJ/1y+vCrOGw3kRYFwFl4c1kFDYrR5WI4vH5SlVz5BuRAoFwwXcG3ahh+8bIBv7Bl6VUoBoecKp8/vyZaarZk1IhaijACfFS0=
Received: from MN2PR08CA0001.namprd08.prod.outlook.com (2603:10b6:208:239::6)
 by SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 27 Jun
 2025 03:40:34 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::c5) by MN2PR08CA0001.outlook.office365.com
 (2603:10b6:208:239::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Fri,
 27 Jun 2025 03:40:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 19/33] drm/amdgpu/jpeg2.5: re-emit unprocessed state on ring
 reset
Date: Thu, 26 Jun 2025 23:39:48 -0400
Message-ID: <20250627034002.5590-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627034002.5590-1-alexander.deucher@amd.com>
References: <20250627034002.5590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: 04622fb9-8fb3-4444-5723-08ddb52c5f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B5exIeRqx/abtAZAYFCO3kwtWz0KWjW+1rDcsoBrgKSvU0eYmryMO7IpyTPd?=
 =?us-ascii?Q?3vYSayikYhKd0Mfec/505a48V2mIKyfno7W3EGNXdpTuaEMz6PFMjvu2f08r?=
 =?us-ascii?Q?CeMaB3Y+B0cwbgNY0m5o9cobtoxM22SF2xRrp9eD+rmLMh22+I7Vzisz43g6?=
 =?us-ascii?Q?hqSXL+QBoLDaLGaRwHOYnBItmQxNRWvLkUI5g8nXX01vE2CXH5KS28lBIAKq?=
 =?us-ascii?Q?xi3MRaulUU/Rtjd5JklxmjHis7L6FKmMy5IMtxB+jxXaMGm4uf8fKEsAIHIm?=
 =?us-ascii?Q?gT32TIo4LFHyzpxbdPhK2gMbPVPPUxyaYP5Gcdo7pVvu9rk2uORMestZ3b/G?=
 =?us-ascii?Q?dMqt16hKAlHWC6fiNNVB2muxke2IE7J9oYtJFXMjaZVgz5SkX3ocwYKH7wW+?=
 =?us-ascii?Q?P6ODdqLFbaVX8FF4WXl6V5j0yqKWgDUSBAa70LH6a+GgGUH8+xzTyjnmUdrp?=
 =?us-ascii?Q?lA05Lr8xGOYEPk7r777zAFg6e64p/ASe6zTi/xlqrcNNQF2WyEIkE36EX4PR?=
 =?us-ascii?Q?BM8OrrE266/9R6SL1cFuSyWj8F8hkscS4dmKtcdLQ78em183PTxQqw+G3CmE?=
 =?us-ascii?Q?MaovxNTzawLIVZpq/Rq0dWAbG2xpTOCQv5mAVx7J0EPxNvmcZYkqPc83WmjT?=
 =?us-ascii?Q?bNpCPATopIIDxJcFsMkWU5TNJY0k7widS8b6trX1cTaPmsCjKmiQI+jx2Uqv?=
 =?us-ascii?Q?m0YzJ7QBlJYlX5HvVeLB+4mq6C+8P6SKJuqGP9NegULc6VcJPTi58M5qNKCt?=
 =?us-ascii?Q?jU+3Rmy9gaEz0JFPeOe+Mtjmwu7li5GXJwRnk1X/zhiuLRr9N+4yMFhAQOqM?=
 =?us-ascii?Q?s6gtL+tZxgBrCS7VOIKugwgsTG5HaRmM4UfYzL7rAkGFlXUCJV7ZW9GOlkLh?=
 =?us-ascii?Q?DlIOM0DUoijZfeFn+OUqpqzMDJIhIA+efCS93ptkjmBv0jwwGJPOOccX1bjp?=
 =?us-ascii?Q?CNkKPvdL6B4w/ym8JjAqfjaXnZjvSncyAAu18wMAYXEzUewH6/PQu1w5CRn1?=
 =?us-ascii?Q?owgPSjuF0ApoafXXF9FIgaVh8M53yHK3xna7Ov4jXxGyz7WKXEQe1c2GvknD?=
 =?us-ascii?Q?o7kDd0N5FvbCoHtEFYx+FcAkWKEixpUZ5id6rozek+m5WF2hNUxTi1Uuw4Ym?=
 =?us-ascii?Q?lPp/1i0wmr5JKL5U9UrrQis7C3lbMKup8YVlOJ1k3Tk2cUOBph8TEiOpcsuw?=
 =?us-ascii?Q?oQgwYHpDZxGDQj6TECvmQzWNmh+8zzk2z9xbWcp6yQecIEXMFT/6eFoDUjPD?=
 =?us-ascii?Q?gjG2SiwzT7154BBM1iIXtM8X/u/Ot/vDzToCT8nbQkDLzAnd0i2KfGyHDMp5?=
 =?us-ascii?Q?SDq9rL4DenSN49ViQsMTjW4rY0RJjh/EvmgyZ6aTUuiHgD+XfGq8LYXQIMcb?=
 =?us-ascii?Q?E817tEcG3BU5qAozVdhuC/rtFdwCH3w4ti4mbEfyyewQm7RqJokUJZMMPnwN?=
 =?us-ascii?Q?/pKNqY9LVNyBpz6wzByElGWvEqqPdE8b1LgHG8o0rNcCEpNdLzsVRFKSdHSi?=
 =?us-ascii?Q?Yjq6v1rf/sG2X610aTk2pwcpWreNk0mKAg2Y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:33.4118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04622fb9-8fb3-4444-5723-08ddb52c5f10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941
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
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 5be9cdcae32c1..7432990f77507 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -647,17 +647,10 @@ static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *timedout_fence)
 {
-	int r;
-
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v2_5_stop_inst(ring->adev, ring->me);
 	jpeg_v2_5_start_inst(ring->adev, ring->me);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v2_5_ip_funcs = {
-- 
2.50.0

