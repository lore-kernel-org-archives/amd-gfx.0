Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B93C83F03
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 221FB10E2D8;
	Tue,  1 Jul 2025 18:45:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nWUsYUGw";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87E9910E601
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6njZmrkZqJqXYQoPPs1YGcsXmZPhECO9F4cFn+i9ctqTYi+391aJBD1vTwCGqow6/iL3ZG2CkU6sg8VAcS7bAUsSC5VvJVkvxEd1RPmlFVSaHrb14hex4h1EZwn4BRL0mXjlDrNYM1RoE7/N9RuI1G+3xwWySBJGfV5vfsARedqCDS1V6Yz8LYDTSyaDFwU+aHExsagiuNvCEAAo/aM9SakYjEhRMGXM/jXICpllF4YKhvPzIkqgd3BWSGl/aoh+ugfmCWxR/uOGEQKNMB+4yrgbMsDQg8yufkydU6tmUcTp5PS6FA0my/vXeIALjbULHFSTyvRx71L19cOMjHJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUpekgKR2Wrw2sGusV+YLat3RC6Hivt+NCzzSoJDx1o=;
 b=yRv6OvDs1MkGeBoZwW3FnmdW0PEjAwzWEMHUsuaJ7cr1tSGF6l0dl/rG0MQ0HsS85IUMIAbuX+Ra/48i3ek7/fZah9ZXEnl4uGf8dFN8WF8n7VEfNY6wo1nR1kncKBT3K3t2jZQOPF2f2x6QebbCoyzP581dMUfi9b6Xh40QhxaG6LNrp4T8tHHQPZX5G8rRMPCdHy+LeJuLDenmpQq+yGaCHamLzskEROzW31lcA7D6rt1Ld7v4die/CKANNd1RrU/XKBdIqvvl8vB0QvcRG3CwFQedNKSZT97y84dnuYpaw/cgNJiaEZKYxvJugbtly+WI+u49ibUp1KZkDW6bXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUpekgKR2Wrw2sGusV+YLat3RC6Hivt+NCzzSoJDx1o=;
 b=nWUsYUGw5yfpeEAeaVRTZxZCYRaaUVB2z5A70a0u5LqK6aTV5sQyIiS2JmeofydGXTadpuDcO0ggPXNmiDjXAcQlW9/In9HnLeHWOSmEUzCz8TivX7V1thbfWe0Mlnp0ZoJz55P3qK3tMTsqFYgDdSKFDehGpwOb55ywAJO02Fc=
Received: from BN9PR03CA0607.namprd03.prod.outlook.com (2603:10b6:408:106::12)
 by CH0PR12MB8461.namprd12.prod.outlook.com (2603:10b6:610:183::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Tue, 1 Jul
 2025 18:45:13 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::8a) by BN9PR03CA0607.outlook.office365.com
 (2603:10b6:408:106::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.31 via Frontend Transport; Tue,
 1 Jul 2025 18:45:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 13/28] drm/amdgpu/jpeg2: re-emit unprocessed state on ring
 reset
Date: Tue, 1 Jul 2025 14:44:36 -0400
Message-ID: <20250701184451.11868-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701184451.11868-1-alexander.deucher@amd.com>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|CH0PR12MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: 9718ca35-4001-446b-d8de-08ddb8cf6a40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UgSKmcidNBYouAudQB6EfYvH3m7gj89zhZcS2wRIsXAk/g8QOoDwfYe59eFq?=
 =?us-ascii?Q?k1T6UIo3PnDcaM2YOXeIjZ89UOv9UkWjKdVd7ryzaVhC452tGRt3tl/zygJi?=
 =?us-ascii?Q?w1wJUaNPcIp6mCGtfPudk8/cqNFbDdGG8JlL+Gm1TTWzD7q4fcPq2xFwO0Vc?=
 =?us-ascii?Q?YTpMaBAX4SkYzTCJfp7NKpbKJZo15YTuVENRXD14bqVOWlcFreC3PXgIBege?=
 =?us-ascii?Q?mbwLDqnSLRop4wFwlu2BNAgt+PHxpUty2l7jLcDuiBWYPH03viYUP5HZzmvB?=
 =?us-ascii?Q?WmEJqcIkuOdlOi7OlqCgDnBAe1R6j2i4YaTGODE5HnFLs0an6Cgb9/5rIwjb?=
 =?us-ascii?Q?rz+cltPwgGUw/DnAF5JYrMU6KQJHaDFN6v4v73+qY1xFidXh/6GZ91iwZVU0?=
 =?us-ascii?Q?KL5AwOoBiho/R/9dXn6xtNJ9gZVhZTSNiyhgwrL2Nrc4el0UYRWwxbOEBves?=
 =?us-ascii?Q?W64PG2qvRw/SIhdmFKFcHRWOZVEY/vnvPzNeWV3gjG2WbickhAehbs+X4vnX?=
 =?us-ascii?Q?rp5ZD66v+j4R9O3U31H6bVOV89flxje/jNZX/G5iBp1Lu1xGoctnsuxhH/Td?=
 =?us-ascii?Q?80eP+CbNw9rlxMwSkmGJu2EAXP83ygX1VOy5mub7KNtUaiW5oDO22zyiKccp?=
 =?us-ascii?Q?98xgdxqXHzXVlulvbjpVuKidj8YjzBWpOfKqeFokzanwsiFDKubMu9gkVLOw?=
 =?us-ascii?Q?PzJACAiviTS2Vziuy92zET6ole7hMafR55wv270JrZ+5kipVc9AUPjdDw1kt?=
 =?us-ascii?Q?22vzFR91cX4wlCwgwmzqTIq5sBzD6KzuFX6ZrZdDunqMYz2YmdM3pSyf5e5t?=
 =?us-ascii?Q?nKIx92ecFYEarankK7tdpn/OishleBCEu52v7Yt7XlNk+iTZx47bu/J96j/T?=
 =?us-ascii?Q?0o6FX0XtD0VkwF+USlaO9mWD2MPeqjrFv8uNkmtBDdjAwilQ2ifUDdQomgf3?=
 =?us-ascii?Q?7y5pvWVer1BaZzfbystk4lUotYEXLbaMsqX0gXXNcp3z0a0Dd53VPUu3z5MX?=
 =?us-ascii?Q?qlNIP5plOswUeLTC1Y30kAOxeYShBCwtX8vwQOieRcwxeXqYm0aMpH3JRIwg?=
 =?us-ascii?Q?kiD7QICPzyMH+YS6NsiM/+eozRw6LkF3GzCeRZBfp8KFZ8MBMhKSkaZGEen/?=
 =?us-ascii?Q?QBPMOc6t689OCgzYZMXmZrP6dHdsoEZmVERcmfu61I1fZpdwo8TJBl5lQCRU?=
 =?us-ascii?Q?NY5fHh9L9iiYxYFN9E5kQohJ+/ysgfItbgyYSKy7p7GWllw+uzNK9HP0XHiT?=
 =?us-ascii?Q?mpY5QHDfSiCP+B9a2PWjsqn6i/7m5c/nAk8JqbDbN+T5rPZBNxftX4PkAS3V?=
 =?us-ascii?Q?EXhDaOZInk4FwxdwiJtEO5bQmelAfoXhfHUHGb7TMVl10lH8Hh4742dGQ+GL?=
 =?us-ascii?Q?Q145dWhphWBDQVbmFQwxlxrKkZgelVTdPXtuM7wUKc86YpqGQfou/DQunOaU?=
 =?us-ascii?Q?uOSOqoQPO7jgTZDaKMkrgUnyjdKrxopLbQ4LwRONwb87TCcmK9szJt5qrb1w?=
 =?us-ascii?Q?NxXKNyHiJAbD9+ZPhoMtXs6lL0HXEu6v9/21?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:13.6411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9718ca35-4001-446b-d8de-08ddb8cf6a40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8461
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 781a5a8a83614..cb66eff499662 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -768,17 +768,10 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *timedout_fence)
 {
-	int r;
-
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v2_0_stop(ring->adev);
 	jpeg_v2_0_start(ring->adev);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
-- 
2.50.0

