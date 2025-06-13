Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FBFC7115B
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C86D10EA6C;
	Fri, 13 Jun 2025 21:48:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1UkIZwjc";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 362E710EA60
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ombyum1hCgSOhX9u/DRHslDLPxpGH3n+HTIbscWakdBb2CnUXiA7GrCqXvbvdvJTKnT2bjFOT+sCRq+kI0P5VqL9XdDGAlHdiRR7So9yp0c7O83TDtsh2lfNU66qBCOkvwp6TgCsqGiFkhkV8P9sobS6958alYEwQZ0hXc+ZBgA5r2j+ix46t0AAuKL2DzQoUcglTTFwUt9BGV1xrj00jlCjK7Sf6oIzbK22Z+tujhMzS4c4UtAZq7uW6WUgVMhqz4tamWUW9ziERNZmYKv9XHz+sdYkkXEz+RMfzNxOd3LurWPui58JnIZanl/9ClEPHng17wbHhMp2+YyMtkBClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bn4QF3gnhsFKtldjiIX348ZgLNX6ISw/w0PwZcL2KUg=;
 b=s6BMqbRNvsK1r3SJM0HEY1756FmnZz/SqVnrDWX5BGmCp4vc9MLIvFMb1a5BSwhztxWdyy0bLsx0EKoaaL0Y6nI/2rqrJaBIEiu7iXyjy+A933uNWY5l6ZwYfSCior970QfWxcbPQ7JkJ2/WvjwEfUHt3ABTJSzH2TVG9utb8eKT//hiA7bqKign355CLbJNwxc/YfzN6ppQ0adtrdQpgDt61YZRvgbSmda2pQRWpA8MT4f39wfqXxtcQ99lFZ4Y9n5vHs2Jd10s9GfHt5fBdRxv78IxGLv25DWefcjVRj9zWY6hYQ/xqnNXGkT9+gRulonXZJlVhVIbn8JlLUTV/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bn4QF3gnhsFKtldjiIX348ZgLNX6ISw/w0PwZcL2KUg=;
 b=1UkIZwjcgkq1Kgp9lHfHYiXxfrX2uDvei7vMMtuD9I0E14XpCIs7blWfpSBut1jHQmc1PL8NRAU3YOcSUVE14LD7fGTKkY9NTrCaNdpf7/Z7B4CxHmVMEpgmbxyaIIrZaOUbFpHPkOLhAe4d7MUvATDQD/iI1n10t7lJ2pFSVc8=
Received: from CH3P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::27)
 by CH2PR12MB4104.namprd12.prod.outlook.com (2603:10b6:610:a4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.24; Fri, 13 Jun
 2025 21:48:14 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::c3) by CH3P221CA0026.outlook.office365.com
 (2603:10b6:610:1e7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.17 via Frontend Transport; Fri,
 13 Jun 2025 21:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 17/27] drm/amdgpu/jpeg2.5: re-emit unprocessed state on ring
 reset
Date: Fri, 13 Jun 2025 17:47:38 -0400
Message-ID: <20250613214748.5889-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613214748.5889-1-alexander.deucher@amd.com>
References: <20250613214748.5889-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|CH2PR12MB4104:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cc18704-d6d1-4e07-b9bf-08ddaac3ff22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WpdOxLaklu7I85WAKRVb6xpDdZGDiDVQMcK128toXk7+NlqBxaj3/zf3dyYy?=
 =?us-ascii?Q?kJgDe/yQKggSv1WfXF/5RxLcPLIXZfCXTyAbE6AFFzpBl751pdo335Ydt2mx?=
 =?us-ascii?Q?o9CU1hKO74BQS+lWmmEyeag7wmfy3yXHhYG5PJkbSA3r5Uem/ENIUgh9TRiJ?=
 =?us-ascii?Q?16zTePEWDMiK2UQMX/UeJm5lPiWtCB4Aq2SkisnDawUY3U2LoAU+MdO8E6Zr?=
 =?us-ascii?Q?VMmqPQdHMXVMQqwAnIoiaR9EPZJqFwtI6m/6P9QS/lqQFjfw7YZy95Eq6biY?=
 =?us-ascii?Q?NoayojWB25Dx1dgCxlw+8Uvan2UYz/buKWFHnClzEliqeKQluo24OlJfsD7k?=
 =?us-ascii?Q?qVAroq3ymZ2WN9/fZEBj+PAho5ftE2bvVL3pk63sxABCyeFO18LxUX75sZtO?=
 =?us-ascii?Q?WXl0DJ2cjg7/+OLTTlZ3aUYuK9RdFr5UcysIQtSHnubu+BGZR0VyjkYSwQkO?=
 =?us-ascii?Q?B57qOeP3dz3FLBuCQi3vkRhFiOmS6vovrhc7AiLPAiGeT1MpdHXzpBEK/7Og?=
 =?us-ascii?Q?9uxmYAuZa76wdcqJLTLVn8JG/1lzi29VAg59JgX/t/RhhR0SFFfVs1P589mx?=
 =?us-ascii?Q?VabO7IzKfmAcGrWepXq92nsTytR6xBsB0H7AvP7LBgNwzs2AGfl/lpu1RVxL?=
 =?us-ascii?Q?YhhhvIbSXuhCIKKgIUJLNCvArmZtJzvtOtJavxpVaK4GO5YH8ResGaDWO7tz?=
 =?us-ascii?Q?HhjvL1RXICokpUUfMdC+qnwhjPtvwnrcT+nnSaUPzVQcX+9ygBpPQWGkdfe6?=
 =?us-ascii?Q?xbxT0DJWaIal4RSKSPpiCzSx/bXxBa5dJ7k8e8QbVUqVLgNpyElUKT9vsWu5?=
 =?us-ascii?Q?+BWmbtfqaXuKR6ew87TRgm/xFPrVk3UWD0wGC+WOaS/QB17/TSatiw2NVP+b?=
 =?us-ascii?Q?6YEb5es8371h6MarLVPOE/lgKnb8pgEFa3hEEy/9UnvoO/TNKcUndzbpi/lj?=
 =?us-ascii?Q?qiHZxsOfilH1l353hCjTq/HxIAjPWAvC9/HBCb+0ctLtquPGQalpy9d801Qs?=
 =?us-ascii?Q?IAUK6UgWJNrzPO9fqR5AZBahqZZY76Tq6tsjFEwtyL9zibyexsrQXQicfgJL?=
 =?us-ascii?Q?OrJ0EkNHlvX1HfzHIv2k7ZfQFKJULjJdcbQV0Gk7E7ha8mqQMhjwRQeJbHKN?=
 =?us-ascii?Q?a1aR6N8AGdkqxg0/GCJBtPoISL/kUSudygmnUAfLqlm3W96Mz6ZaEk3pBvpc?=
 =?us-ascii?Q?EK8maJ7tVZu6Qxy4FVRq0Leb39N8h6GSCbCVrGDeeY7TQ3n6taTQkVB0vO7E?=
 =?us-ascii?Q?gpnirA1FTAfFH7RRacfiqGclp6HER3MXtPFYflvh64XOIWrRlc/uo85Xdh8R?=
 =?us-ascii?Q?dMseRP385ESociOYg8CLBf+oR0Sz0Nq1snAN8pU5/U0CwTsEnkfdlsBOk9cq?=
 =?us-ascii?Q?5Lch5uyn9fBbTC4JQNzIenKCqEwTqvAT3bG4B3x+I5Ti8ZI0vUyvjmWXypov?=
 =?us-ascii?Q?Q5tLypfrpNzFOXsNsY0H/0QZYdCymTrELiNLWtBv4c05QE/LMPNoTmmPC8lQ?=
 =?us-ascii?Q?0uRY47gZ3mmcE1CZl+0fH7jRuaqMwxSinmB/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:13.1738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc18704-d6d1-4e07-b9bf-08ddaac3ff22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4104
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index f8af473e2a7a4..4d566cc1c90bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -649,13 +649,21 @@ static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
 {
 	int r;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
 	jpeg_v2_5_stop_inst(ring->adev, ring->me);
 	jpeg_v2_5_start_inst(ring->adev, ring->me);
-	r = amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
+
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(guilty_fence);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
-- 
2.49.0

