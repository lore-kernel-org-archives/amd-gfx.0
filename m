Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EB7C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E34110E2D3;
	Fri, 21 Feb 2025 15:39:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eu8wn546";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4318410E2D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:39:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDTYKFGyAIZHurZF/fzyYkwE4gl9558QLBnja/lw5m9HJqM6M5sXStIPbn2tfZlATu6t1iGEvDdCc+aMp7kodnjnzeBkqC3yAo4agAImaB81Oy/rkKcxNfJuLFhfuq4iBNQQRhOEqzHuTetCwWafmWIS5ZrGsBW+OTUsuu9kTMcxbzNBI/EW9apPfzKLSDTo5eUff/hhaY7bc5Bh3kKb0DBGbrNR9KNGx6uN5z+mypOw+XlW6hSQV3OLai5ZxzhrZR6OkQDrCXzP8dyjWlEgw5R6OccFs4LRSLlsO1BURDOM6q90vSSlSg5oZC1qGEqDb9JnG4cxnOGHcoYMK2yx/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Dy35xXxcGpxbp6uUxHg0yUsdo6F6Z1bDws4bU/YZ9s=;
 b=DdtddnU5Banz8tpzM/D1fci5z05OAh4PbKUqHG1rqPAoa7wfh6lMQpS9llgdK3OsBbH8Ju3L9ahHWoy6vLAvLCWOF/H1Rop5zwQ6KDqbhwSldyIVRY0XQUGBn8NqgtQXfmexS5uqan3KJnl9qDTD9lb+m0FBLCdpBMBCiljvP4GsqYRtuGOzE+t5BNGelN47C45zJXoPy/L/386hk1sSajWDRSurTJckj7EQm4/XNnAc5/riDL1MM1T8bvww2y6p1QNZHsJOsICnV8ODZ0o6uuSIIJPu/x6W/j5FJak1bBDL/z37RvvxMm28NXA4VwsreYbnuNXXQCLTXHEFI20j7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Dy35xXxcGpxbp6uUxHg0yUsdo6F6Z1bDws4bU/YZ9s=;
 b=eu8wn546YY3EvEdgxYPbTLhtjsHhMC80Jm6560FuEjiG+/A9/FlfITnHpWlrIB7raiGEUGVIb1sZVtehgy4fGXjLQzHjdsZuYLkWcpIiIT6PAR/Tp5TvmZOpbZPtIbBu5S+J79Yz1EWehYKyruu0QB0b3myTiad25ItRe1sekV4=
Received: from DS7PR03CA0035.namprd03.prod.outlook.com (2603:10b6:5:3b5::10)
 by DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 15:39:15 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::f) by DS7PR03CA0035.outlook.office365.com
 (2603:10b6:5:3b5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 15:39:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:39:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:39:13 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdgpu/job: fix is_guilty logic change (v2)
Date: Fri, 21 Feb 2025 10:39:01 -0500
Message-ID: <20250221153901.3508931-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|DS0PR12MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c132f01-a570-47b6-5950-08dd528de571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yOLAEuB9+WO8xuvZPwLXhJNWAhhzoZBQC5HOzojeIH8pmVR+uMUYQEoOGVBQ?=
 =?us-ascii?Q?muC58ShohDSAUohhChXltVh741MzIf7ieK7+tKEBaMtLBkMqKyDkasEPLhrL?=
 =?us-ascii?Q?xuYDO+sjEE3bu65VjDP+3GOX26iMt+Omkt98pvMhGzWJSv/hP8FIWnPWuIqQ?=
 =?us-ascii?Q?/8w8R4Q65vrVQZ3zRmeOa8lc1gn0iy8Qtf7qf9XNq4jUVNTUzNyRbsEJjBCR?=
 =?us-ascii?Q?azCyvtQIKJz4FiXX6vHBwooX6OIhp4uuw+KJFb2KoVc4rMnskGSqerBvEqlc?=
 =?us-ascii?Q?cBRcWCeyfGI/rra3rHqb15Bw5fnYH2JvuwoPQwm9MSZRi40+9ccAcszS7hYv?=
 =?us-ascii?Q?z1P0Ry2AXWc3LwzOHjHFCEOSvmMlp57ekr7EfCDs7J7YvX7ylATTZPWBJGRL?=
 =?us-ascii?Q?TYm9u9F4tRrNa1TrYMFfDEwMrBg+NcYMeTMqRrkYxdnDDMQKcQTywn7XPvVc?=
 =?us-ascii?Q?5cFnjIuG0i73NY3PUkQZq/f098c0S8Oyf3IMCNbYAzPNL0qpMtaoaUfTN9/Y?=
 =?us-ascii?Q?I5/gMWWsJheUB1X+hNuPOnKePhII9qVz1UBDdLjA1bw85BxbBo6WTNqo0lLZ?=
 =?us-ascii?Q?Nen6M0G8eBP0/UOIs26SiNbZNIKHrEEefIgLF2XgHFq294HBiqo9chpmir4h?=
 =?us-ascii?Q?yfif/Oj2GY10BPsZjtA5lGrSJuGGHUZ6RuSuT7vdRYVxEnyhg5txBaw6d3oD?=
 =?us-ascii?Q?8i1zinpFE8Vak1vBXsGpH8nT2bBmeh14twM2N9GB0lCetYiAKtIqx5lU2LPQ?=
 =?us-ascii?Q?/eF9uzlYM4IUrxvg4bD1ytFh1K5cxmS7ZCV9hQ5evCAF/eJWhlx5MAk9VqGn?=
 =?us-ascii?Q?MrvCxJrc/vj3xSXyLLjmXCj1CYgU062UK40de8T1CrYKcdQvY1ZSkwdXbd/Y?=
 =?us-ascii?Q?x1NxZTHZbkC1D5dFiUaIMoccr7V9r26qsbb2OqQ3oAL7uDMdA3RqOX3Dcve2?=
 =?us-ascii?Q?+sILwzACEXN/HTNAHr2BuZC2jidPb3XQP1erlPj6QXzQFFwqNJNuK1IFnfwD?=
 =?us-ascii?Q?XE/h3e4TnHFl+0R/sYEjcEXfjoH9jmCP0HmpcCyDFaiYxCPN4zkV08JTfu8W?=
 =?us-ascii?Q?Q+bg+jhK3g2ftUgVvyvk0G1+HOVVUDDeSj0WaaIW4DerXOnO17AyN0ie8Zek?=
 =?us-ascii?Q?KXfDJUafx5fgLjIwM74Xmq+tVshY4Oy8oWo7IuEdCe3535t3p3XrxTipKyD2?=
 =?us-ascii?Q?ja22Pq9P+lEfJUMkkg1bpVrytZ/oHX9ypLLmJnqFAexuXRKx3eVl05PEvAJg?=
 =?us-ascii?Q?SEb3otFVgAbXsNPwO268A7E1bOO/FjIOXBSOFLk3FuSPp1bDHMf9+pu4GCe0?=
 =?us-ascii?Q?0jXracj4rmSrEvpCLbShZTyf3ZJ7ZlYyBovosuck+1HPV2kDrOmtp91+3l6S?=
 =?us-ascii?Q?A48O/WK3jAti9lqH1K1T1p+i4P4j4/q8cuxmkiQ/+ufEKMaynD3GcTCKz39b?=
 =?us-ascii?Q?64R8UjihpvceNLcjyHfNc29OKRueWOUkvg2UNT0l8oSs6sxEqvbbhCNLSxA+?=
 =?us-ascii?Q?y5c9/arAok4EmPo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:39:14.8818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c132f01-a570-47b6-5950-08dd528de571
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748
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

Incrementing the gpu_reset counter needs to be
in the is_guilty block.  Alos move the fence
error before the reset to keep the original ordering.

Fixes: f447ba2bbd48 ("drm/amdgpu: Update amdgpu_job_timedout to check if the ring is guilty")
Cc: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index efba509e2b5d1..c37bc683253a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -151,14 +151,16 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		else
 			is_guilty = true;
 
+		if (is_guilty)
+			dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
+
 		r = amdgpu_ring_reset(ring, job->vmid);
 		if (!r) {
 			if (amdgpu_ring_sched_ready(ring))
 				drm_sched_stop(&ring->sched, s_job);
-			atomic_inc(&ring->adev->gpu_reset_counter);
 			if (is_guilty) {
+				atomic_inc(&ring->adev->gpu_reset_counter);
 				amdgpu_fence_driver_force_completion(ring);
-				dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 			}
 			if (amdgpu_ring_sched_ready(ring))
 				drm_sched_start(&ring->sched, 0);
-- 
2.48.1

