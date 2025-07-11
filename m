Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C3FC83F26
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:41:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CA0B10EAFE;
	Fri, 11 Jul 2025 22:41:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CD1QXcRT";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F319310EAE5
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:41:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pX9/C7nLnBqzpCW3vWvgjbWkhR0gzc9s/M2DMSfz6WyFMEYK6//24LN7JjM7F0MfoZX55Lz2FV42HWSKWVFPJTrSb3HCa5//EoJhRSxtqGVFIU8B2xZqGiExHSHBgdPKLXWP4w8MjRsAjpquJZ7c4tCvz/A88d6NLqblJ31BJ4Ipp9toT1FxL1g8FtDkcEgiUDksZE5DStrxFdAFGAonV+BZQ9n3Byf0WI3pEZGkVfLfxImDY6wVRdDxIWZG7lpDyUDiyE2Cn+L4IibsP/H32s8Lug4pdQCea4Y2g7reqba+aPreWLgXvjOE4LkTPxVIOzgOftMELFUYoon1yxtjkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vl4NLpVrULbuvImY2DAz+B46ZRh7jISPBU8T8cVdAw=;
 b=oiPLrhu+aemh1FBnWagnyHrNG8bIeRcm8h/qCYoxoCrEQmngn0SMrn9JJ3CHlZy9MM+G8A70wN9Vcv7+7a8fXA7w4PHDoNM7Q7eC8P+2mf8Q4OeVNr218NDZQWkyfgFs7mFHAQbk2TBHn5dOSbicQCiRONAbwoFB2MiLHa3ArhwkDSze6vvdff2172wybiJPGeCMiy7WMeBjIgqPH+jaCqPFbJtHKLtmSieurgB/6CAp5ytd2tNGM67VIih+P1+XAVBysdNaHXrm0ZWlrfX6c4triOEt1yxocf/HlQbROW5hB/nl/h9NWxMKQUcVEnwh94gZ3wA8QRg0UsUDsnzv9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vl4NLpVrULbuvImY2DAz+B46ZRh7jISPBU8T8cVdAw=;
 b=CD1QXcRTrTSY+sV4IS4j8WnWTDevViIMtoHkJ+1XVaP93Oq1x149GDr8XnzDoRsy5Ta/V55HaVBotYpd4mJBZ2rYpWaHpcB5BCwxRVjrNFV/cBtFWRf7jD+/jzRmvbHJM3LdzPED4V2aHVhW/v1XjlH9eJPcjB9l/1Q2js2VMjE=
Received: from SJ0PR03CA0230.namprd03.prod.outlook.com (2603:10b6:a03:39f::25)
 by DS7PR12MB9549.namprd12.prod.outlook.com (2603:10b6:8:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 11 Jul
 2025 22:40:58 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::75) by SJ0PR03CA0230.outlook.office365.com
 (2603:10b6:a03:39f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 22:40:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 29/33] drm/amdgpu/vcn5: re-emit unprocessed state on ring reset
Date: Fri, 11 Jul 2025 18:40:20 -0400
Message-ID: <20250711224024.410506-30-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|DS7PR12MB9549:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d5b609a-2a3d-4bba-c297-08ddc0cc0139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LEdr/W8lGrMN+i6X0tM+oHnyU0rVwgMhZCBsZN7SvxWoGKXDVVRX0kGHOYvn?=
 =?us-ascii?Q?1piGrXiP7qkzeU/LjoTjrUJpZ11NdSTnuDiRxVpySvY5y3QfzQ5AQ0xrY7F3?=
 =?us-ascii?Q?VMidSkgDgucap+9MY6H831MlZnRWauUEut/RwKAC4LRQbu4e2GqpktffEK1c?=
 =?us-ascii?Q?t8q3RZn9Ag+pZaFOgV63NOmq3DaFgGY6995iVU1/FC2z3Su5v/Anp/zQzhDD?=
 =?us-ascii?Q?ltQdu9ButgzioBwxoaiWInBFAczPP8GQ82hJ7dj1YTgKCn31xoDtnt1UcsWq?=
 =?us-ascii?Q?BZ+Rsix+FtVBi7CODhSwIef2E6hDov4jyW9L06IuF784C13wDTc/Ie4gHAXX?=
 =?us-ascii?Q?UaCUIljeaSIG5cysdpu+cbtGijEtayq8NGwNP632ChP6/5w1zboc74HqFj/3?=
 =?us-ascii?Q?9RZSKdxcBnAe56Hog1nQ6M6iAiXTmRjAkP9RXM4Kp2IPVuQs0hwPPIKyKTG3?=
 =?us-ascii?Q?486ajWrADLqV4NhN5NrwJFdeZnBJpzAboM6dbXDdRW4fXtnfv32RFLtSmGyH?=
 =?us-ascii?Q?40NxENJVjXaEaVITerOXE0X5V0+rtKtUmUpmXdkWpFGxdAE+vnHFHUtiNWin?=
 =?us-ascii?Q?4p3W5t0mgqKrcVHUA0roJuJTgVay0z9WksY8rZw5Oc+W5TSQjIFMVbtHO7mV?=
 =?us-ascii?Q?MI0LFkKFIdvruqzD1DV97ukcfS9uSeZd0uHmJQCWaNse2fLR6nGiYzI9xO3M?=
 =?us-ascii?Q?o6G5NlPeKzjkUj2jZo3/cO/9CdE3GgsRNnSwPUB+gOs/dQN4TbyMzUrWj/AJ?=
 =?us-ascii?Q?5DeZWjTDSinnu5qwUhDdwRKEWFE6wIIPVnN+g3wUC8tF8XRwZYfQgDrcLk6H?=
 =?us-ascii?Q?n5nSkH60EQHBG23XLt3XCQ/7F9yufWizs7T+Nkk6OYyHGLtuIA5eGJxa9SwM?=
 =?us-ascii?Q?K4nyNgXJF8ldHedzRxJKo6Qm6Hq3YDj4axsRKu2SfcK1kvpI/FBtVI87+iF/?=
 =?us-ascii?Q?szZu1G9Ye8F0N+uriBTuj+p5a0ebplnTQtVAC718LKcnJj+ZWg6f5XbODheu?=
 =?us-ascii?Q?3te7U9k/OVy+hpoiaTvRLy9DGqg+ikop5GLPijjvYWzTLeZehOmOgdT0OQCe?=
 =?us-ascii?Q?B4+PScaCp/4ySLt5WA9uNaEQZDMCLoz4UBu0lKrVSc/240WS0l94hovhSh6P?=
 =?us-ascii?Q?lYpGVt28Dysc3XbRWws4y8cOZTiK+0DJfnCIbthYlviJ5AI5GpQXQ6IDkQ2z?=
 =?us-ascii?Q?+uBvLg/8Un6uC1LHq+2Sbu5Cgp8/8hknu6G6RliwSE0i5f32BL+X8xXOUbcr?=
 =?us-ascii?Q?2y0FYwTagc42z8CTuF+9eegtD0PlzR6rfITYaXA3Ef9bW3Q756HjxfkwpsQA?=
 =?us-ascii?Q?2/kTsuerg0azUx5u+vyHmmZMG2TiehvS8pGQ6aXNq0dgQXVLrJ+SbhzoELHd?=
 =?us-ascii?Q?YiN3b0wqwSOa1Nq8SG1pTPPjSMXPV/MBLilIAk3HXnPRceUMjifViDucQEJK?=
 =?us-ascii?Q?0/p2XFPoL/JArukfIWlsdxEHWDTEuu8FT37CSYBgPZ0si1F1mxt9hWr1SRVv?=
 =?us-ascii?Q?hRx4032bfPdFHM27B+1v87gIyEmzXlpYC8KZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:58.2017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5b609a-2a3d-4bba-c297-08ddc0cc0139
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9549
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
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index a137bef918ed5..ec0268b5666cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1204,20 +1204,14 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = vcn_v5_0_0_stop(vinst);
 	if (r)
 		return r;
 	r = vcn_v5_0_0_start(vinst);
 	if (r)
 		return r;
-
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
-- 
2.50.0

