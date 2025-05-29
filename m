Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91362C5B552
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FDBD10E772;
	Thu, 29 May 2025 20:08:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kzuvnyzi";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89AFE10E24D
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chAx14QS9njY3XiYrAkv3tGZdSKvnS1dLZauyFShk7gFgfVG+n1CoeQqeX07GWrSFK/1wWijyYPs4a3rxEpUvCXgpqKysSUr2SsHYSWREoeAmMcvUj37lSVqMSn6lYk2aTH0RiAzGrNs0+n2/nGR+RmUxpdMpmUqLHdeIkmX2C26xSsUF/HTEMWN8C5jwERludgWrMo684utnDsi3DFviSX0PzKTMojc+DHGMy6pzLWhgjuyxvleoD5HT10Unnwg/LLc8+Q0sjEvoQ/BBar2DBF55viS9SAA18WLWywWXbL0Dljx9zxFRr0WDgI0AR5cdGpbw2HlFqTotOo5/uruvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RLKAMTQR5prifZzq5jSJRBC7HxodAqu/Rcw3mtfN1k=;
 b=wExGMzmDp96pRWwm+AvajMN8AzSTBd0Yg8pKcJayYTkNj2mxZH2yVcNfkPl4X/vJkPIhdB2dRLKkO+ATqQ9k6qhsw2UxoXRuNVmy1H4kFJP1TCu/XWfwG7gLlQQSMUYt9FjtwbUyT+swItjg6/wGoyuIZ8SNUTwUSmwMAHZkfLgB1dFtIZb9q77NdaWpF+SsoBeZs6LQY3/IZwhOGJj0X+tEbnhzoNZZmfDi7SM6D/zEliogmRqcYoZSE1drlwtP3py60flQnaCLTrzTSHKPVd7slSj1h3auJ/uaiqxuwQhw2ltCLBUqThBmotGYl1tWmbYjgAdd0DkjC8EB54mz8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RLKAMTQR5prifZzq5jSJRBC7HxodAqu/Rcw3mtfN1k=;
 b=Kzuvnyzit6cfQfL2J3rvgo970buRNqKTA8HzNztuya07+j0da74eU04bokiB+h61hUDolo5QPCNFNk4/hBMJ0Gkvc1b3kSl9e+HI1dz2/0LoMnEhF8G83R8EvWngwqk+dKAmTrLLtzKqQoXwb6fll5ee8RPw2OB7L2GuSRoVGJA=
Received: from MW4PR03CA0049.namprd03.prod.outlook.com (2603:10b6:303:8e::24)
 by DS0PR12MB8528.namprd12.prod.outlook.com (2603:10b6:8:160::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 29 May
 2025 20:08:28 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:303:8e:cafe::2e) by MW4PR03CA0049.outlook.office365.com
 (2603:10b6:303:8e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 29 May 2025 20:08:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/28] drm/amdgpu/sdma5: re-emit unprocessed state on ring
 reset
Date: Thu, 29 May 2025 16:07:43 -0400
Message-ID: <20250529200758.6326-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
References: <20250529200758.6326-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|DS0PR12MB8528:EE_
X-MS-Office365-Filtering-Correlation-Id: a64581fc-3a47-455b-2198-08dd9eec934f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZAdEB2fUSetZ3Nho416J6oziu6AEfyb3TrUG/OFwo2D38llwYTwJTY6+Jkdm?=
 =?us-ascii?Q?JXF2pd7mkhLA/8F7FJsberVMGKSf40HLh/SPLKEOBcONesMfAJgfXpEh1zPr?=
 =?us-ascii?Q?NaOnyOsTVmI+Jpstesja9O6fsxdzl0jGk4omxUx4CQSOJceFUWFRr8zTarw+?=
 =?us-ascii?Q?Jq3oG2fZCOdWQ3UD/9lIM7PW2uRFYOql6NK6FynFKRm0knIzdBQ0DDPl066T?=
 =?us-ascii?Q?YKwVzP5cvHoOKK6hGMWtl7cNojAR3XwbIHY4iJAKjuZJus9YMlEru12LxePI?=
 =?us-ascii?Q?bMJlAUS+dtcWw61gQRCBeNhPnaga/0V8Vy6alq4DX3RW5QT4tXBrZZis58p+?=
 =?us-ascii?Q?PYc6+e0GTlBy0Lcl6a7zSUHMcND6LXiQYhLxDG6KYDPopww7C4ipOgNrnaSh?=
 =?us-ascii?Q?i61DTI3ZJ2f5xppeIjhXVU0gkQVYptLR7bMmI37dp40jcJbw0IHyETlEHaix?=
 =?us-ascii?Q?YLkv8pdw7A63WpuOgQmQyEhj6eNWj8QD+c1YtFX1vg/6ECuWI/R2Y0DKJ2m/?=
 =?us-ascii?Q?ms9FW/lV0MCiKpcBGih230H1cd/8O7px4Nood+0iMQ3dLzixlemBqPg/cAMs?=
 =?us-ascii?Q?jerThxE8l3Dh8AJocInPYTE0EyXPHje5vr76HmLEv2uPRek6K+WzouUElmZY?=
 =?us-ascii?Q?/m22m0yFhgiGwdJhc/ngQ9gc8nz0wvfVAzYdENvNNxpfiawFEE0Af+ybg8sw?=
 =?us-ascii?Q?fSMOp54xao8VYPP/xwZaGAC1ZHcVIfAtkiZHNuaBjEsgrhbEMqn7T5VMut1C?=
 =?us-ascii?Q?HqlUuP806QVrsD6X6DJyZamxt7qD2EOO/PZS2YIsiTHn8cB7dr8U/b5jLY09?=
 =?us-ascii?Q?sLahUIRaFS4/vzvrK21QQTr8glfqUVGg4UcCVmAOWzYMqGXU3Yh9IY/r8HWE?=
 =?us-ascii?Q?pl05NC9hnVqC++YHzc/ZOHiY6cuGnDZcrHUsxKD0qy05PrtWJNGGS583/TwO?=
 =?us-ascii?Q?NHbFwWzCumyopHn8IZe6AxAGgyq0HIqgzRq73aH16U4495AXTX71kp+S0JG2?=
 =?us-ascii?Q?X7RuH0DQHF/7eEJ3jXJ4K8Acb9B8Ci/HqvRryGVyQ/jCfVRiXHR5W7BqPIbk?=
 =?us-ascii?Q?UamxOg6SukZKyF0Rqb/sjU6/XW43gym1hYQ90BAJzsK9DVQEZ5z5VLE+6Tx7?=
 =?us-ascii?Q?yYy/PB7Hf32601IGALJ1arjP1MA9bHit9RK6MZoAfUKXl2rtbEpdF0hrLIqw?=
 =?us-ascii?Q?EBopYYFa0i5Vh9GY6inJXB+a6V1F3bKP7b1YV3OGS/DFLOw8YMrBwbZ2Saru?=
 =?us-ascii?Q?5Ap2uas41/OrYp+ysp58bSDqt0yZa8pYQctXyRo8tHfW/H4fcRniQSPuJ0rE?=
 =?us-ascii?Q?sW+32zSb6gthKe91a/tdVmYMz+z7tSlLopNVOhNVgt7TLjCeKu9Y6+hjsU0n?=
 =?us-ascii?Q?Z6wCV+CD4bwUSOOL90dW6Ld2jecD/Sw14yRz9ZI16OoXNPFFB+ASFPGD9zl8?=
 =?us-ascii?Q?QOqUZ3JMiec6w9JdZu+OgcGSBuPXyGf2GoMb11giHoJbKCcoblRCUZu06PlS?=
 =?us-ascii?Q?q150+OspkOitKMtXBQDJCyiCQRk/7V9Ntx2x?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:27.6132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a64581fc-3a47-455b-2198-08dd9eec934f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8528
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
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 43885dc04b632..44c0eb8536d7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1545,8 +1545,10 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	int r;
 
 	r = amdgpu_sdma_reset_engine(adev, inst_id);
-	amdgpu_fence_driver_force_completion(ring);
-	return r;
+	if (r)
+		return r;
+
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring)
-- 
2.49.0

