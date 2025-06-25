Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D656EC83010
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 957D410E80D;
	Wed, 25 Jun 2025 21:07:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DpYe+K5T";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6237010E806
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yv2HC/jKPWFyAoFHF/qUF6EMQKVsiLVzXWpFEwIiT2cFQDqW485mct7c7V9suC04JaeiM+HH86lG2FklNvqcMkoKnm+4TBWw4s8FjHTtzD9GMbY0mYMoDAD+scCS8ttfu+sZ5GAHZFTFM5ugIvmuzif0sMpF9rFs5T6qZaCPlxbJP38sVJ9a3DGt9IOpI8u92/+S4EF81wQ9XKoX9QoyPuwD0AjD059jaPgYLMB9F183H+Oy+T+uwGmBb9uHcY9373Tl+vEpCc/qfCpbpKU2ZhLJ7k2bOkbgqzcZ57O7KhGpQ1APTO+3Q4SIpDKXodkul2ICYp+b9atXpDTwRZT49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXVpr+TQTOc/CNdusWJlMee9AgPICcF+8373axFJcM4=;
 b=tc4Y23smquP6Vc8BLvadGxKnhI2BFDcp7df4B3iZXahl8iy8fGUN4U1yZ4v7SBYYAErfTysOfICw1bR8u6DHQwoCf3tiTMVTQZrt/LZqSJEZf2+rerE3BoH0Qx48Q6plb3PDH4filB9BtZsgTK6OAcp2AfXQ9q0dCa4yU2AvLekOOsF+G5Fi4vCQ0A4G+tpTc3fvxHVrMgnOAGvchs3kS5G+OTiv6Vy848zdGj6zJz35t1XPC1tsocClI4eW3UjIftFOG2F/hHsOeTZ7L/gdI/K6Fm/tcfz7yfNlD30Yd5t9pO5ycwQkKX5aSu7AjCRUiJSBODj15REKYJ8LE6A47g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXVpr+TQTOc/CNdusWJlMee9AgPICcF+8373axFJcM4=;
 b=DpYe+K5TEksOT2ZGiBhF9zX8N/kbNksbSq1tCH/nCq3sWum37etRVWMyg0rOqHv9kXhG5GBZ35JM0a489v23ChDA5nkIINtk3l+Fa0jnL9RBcN7OACIzJ5YLgMvD4cJL+MMCY6f0zVj4sW/3sHgvaqXd1OCm2o70YOzDeaX1/VE=
Received: from BYAPR02CA0041.namprd02.prod.outlook.com (2603:10b6:a03:54::18)
 by IA1PR12MB6385.namprd12.prod.outlook.com (2603:10b6:208:38b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.35; Wed, 25 Jun
 2025 21:07:11 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:54:cafe::fc) by BYAPR02CA0041.outlook.office365.com
 (2603:10b6:a03:54::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 21:07:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:07:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:07:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 23/30] drm/amdgpu/vcn4: re-emit unprocessed state on ring reset
Date: Wed, 25 Jun 2025 17:06:31 -0400
Message-ID: <20250625210638.422479-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625210638.422479-1-alexander.deucher@amd.com>
References: <20250625210638.422479-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|IA1PR12MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e3ffc2b-d801-4b45-87ff-08ddb42c4082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JKX9/jYbabOEMM2b6k6FWOml+vFPgbjkaawWsli9tV38K65ZIxv8AXvgIzJC?=
 =?us-ascii?Q?P8MBWW0Uh9zMdy4i0BISP6Ux56E1gcjA2O95r2cnMlu8b1RlEm1AXkOewHSu?=
 =?us-ascii?Q?qNDadrr395R2pmCTk7kzwYUfPpohcCB2hbP8J0kwr9e85W6uxRKi5yKPnc4Z?=
 =?us-ascii?Q?UOB2iJeRIIuENPPbcyGI04UClbLdbrj7BYSfkAJLRxk+1gR2T30XcedtS+ZC?=
 =?us-ascii?Q?8SP3U+Zhmp/2PhG5u/8UhfeFD8pn/v3jWkNA/C6poQOhOTwldt1UOcnoJmDq?=
 =?us-ascii?Q?3zyJbu0pVRVgarK8A+a1iDTn1qVp2Nf2LjMe8w6LDHACMmOrcdC5zU6VX55Z?=
 =?us-ascii?Q?QaMdA0Z7RTGe5q69yZDbpibfDrZgLnfecQSUSkQvOkT0n8Wy5gE8Po3MjnYG?=
 =?us-ascii?Q?SX47hyGRoNLsDHD/1hoEuuZKRXcfuLt7R/7bWlw0rUYgK/WSfAUmqEd+ODeb?=
 =?us-ascii?Q?Ps5XMg23dVaTDo5H5Ojw0Qvmjy32LgkS7avpDH6WDt1l4GM6JGx5xASUdywe?=
 =?us-ascii?Q?FPWfOGkVGVO1MK3zCNoeSUoa60i8ytVJBSbIPfZudhGLUve7zqXRQ2CGgliN?=
 =?us-ascii?Q?u5FVtx/kOruX5iX0bbRn2sCN67c+hTnv1ku6qq4btdPeK84PJa97D4Yr4JCU?=
 =?us-ascii?Q?7e1Mf9em15y5oJ6lpwMClLsAvcpfWAnt72h+wY7R1w3+f12rUc9t9raDVvxF?=
 =?us-ascii?Q?3F+5e1+jdVsFXJvtzDMveLFOu5lrna43GXrwNVaYWFdhaWiiwhNyM3CD8vDW?=
 =?us-ascii?Q?QMn1LIfdOOzmSVmX34Wvp2fYRVQOL2CCQRVRWXTiJuIWi5hRxXmvLDl6Xsxm?=
 =?us-ascii?Q?V1YEV/tVlyyfxDaqAoNn19oNe9nEyhuC/Wz1+PIpsCeZHI6+xk5ToNoQoE25?=
 =?us-ascii?Q?W3tg7IYtblx3qpG0aZi4rQBmMdnhM6x4V3BFy1B0IFBwfdlQfvV/kDAPK4o2?=
 =?us-ascii?Q?8HQWRqbOa/T0tl61pi5nBXWjhJ7lOkKH9MJqwhZR3/SXY61d3OLF4iSwuq5L?=
 =?us-ascii?Q?ZhH0espM7NVxWl9G15EBhUh0MS6+xXjZbYb1jO2SIJNsLRP4nn+1tr/w85hu?=
 =?us-ascii?Q?3Wf5IxLeaAPE5GEEtHYjjpfuKQjF11T7bhBji0Hl9JkkY5kPXmOZUVOqnRMp?=
 =?us-ascii?Q?TNlRA4TcSPJVZeC9e3JWmBlL+2ORYaiX2SrYofwPTGErU57SZGjMjis5Vbkf?=
 =?us-ascii?Q?m+E3Dfee/ROo/NuyCE0MLd285ueBB+0XfF8j6S8fd28Ba1i6yBUuCmHa6EXQ?=
 =?us-ascii?Q?8nFCH1PvMMagMUVFzRIPnGQgpKkmFlFTcT0fV/Kyt3El4I7YA9VAMEyPCpm1?=
 =?us-ascii?Q?49vpomzEWfrp+NI+gKR+6OcY3jiQCPP2aeVGBk8iyPsU6wBNyzwlST/3vTAO?=
 =?us-ascii?Q?sn5YhljkLI/u9Pk/8dvz0LSD9TQ2scShLOjiiAUNnvsYaGeSkm5PuaLwU1dY?=
 =?us-ascii?Q?1nSX27B2ZU6xnqKAjHv70yzA4AsKEjbls6Py4t5IJ4N8DeQ/Ce+22BWTUAbU?=
 =?us-ascii?Q?Sfzt5jmeaGf7Oqtt4wQ8/d7cdcYMsYhIbR8D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:07:10.8980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3ffc2b-d801-4b45-87ff-08ddb42c4082
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6385
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
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index eec9133e1b2c4..9bf1a345ac2cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1973,21 +1973,14 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
-	int r;
 
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	vcn_v4_0_stop(vinst);
 	vcn_v4_0_start(vinst);
-
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
-- 
2.50.0

