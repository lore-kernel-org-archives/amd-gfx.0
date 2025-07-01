Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1317C83038
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A78710E637;
	Tue,  1 Jul 2025 18:45:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dVtT22vo";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 491DD10E62F
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFdjmTDDqQh4IUBBC4gc3ap5UklXzPS+Uw9PUFTgLHtvqt6Bm1lM/FActEtSgwotLnMe39WnGvSTu0JbdpZ7InErKWL/gmP+MZOwA0w8UPvrGr4Qh9an22TqDQsG19j3AILXugsXQwRkSgtm3OJvyBHgA0ZVcn82/VAvsY+rF5z42P2Ty3Cd3eh6Ib9htaiUaSgSOBdNNg3+oQafiQRmygEHzAWPongML9/JvU7SVNEpDNWyWgX+4GJuRimAKzzNrazsA2NnXN0qLbvX0LHgNE70O5Rs0bsTEWHUR1osg5jMGZTksmfomKfJx/KnrkAMYX7W2bnUU2uqlVagAY1Eyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DE2uvAzxyueec+4syxqOa3TWhiaQrtaNGYpqHt7fu9Q=;
 b=n42EKysTQ5wnWMWupMdzP4BEPPcQaXupFNeDTlHh9c4QeR4XBHNr/RngE+cAwJ/mJuSXBO1sOSh0qiW2tzLf79GZ8Eg57c+PeIWVxuy2Nn7OUcbVDP2b/r6W6YYR1YERlYyFv5CCQrx2VUDCVU6IMxNxwcr42hx2yGNXOEBjMa5iLztqxNeKlP7tGDTw5RU2SlEhxMssxxJesCQn1olkxZ1DA4bYLBZiTjKLiyeQ5CBbpeL4CnJ6NCTMHyggmg+HCAEZwnUfdgw4jRZ6JpuQzZtJtvU2Ms4BzEQ35T1obRx00WSBMXAZZ/AhUHIzqMyrVApRuFSD3ItqAfO6gkGC3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DE2uvAzxyueec+4syxqOa3TWhiaQrtaNGYpqHt7fu9Q=;
 b=dVtT22voo/VcfDNgmXFObuEtSfnOu0VCyiO2eEIpTiHATuVAQbOMhysPI9TiX2YCn/jdnliTkpSou5OyRm2GgJjwMBA6uYHr6snDxBJi206IgM6pncHZzM9PfnqnMbskaym5K8uZBVTOcn4EiVh1cKmZT8KBSpLT2O6M6DXnwKI=
Received: from SJ0PR03CA0131.namprd03.prod.outlook.com (2603:10b6:a03:33c::16)
 by CY8PR12MB7681.namprd12.prod.outlook.com (2603:10b6:930:84::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Tue, 1 Jul
 2025 18:45:19 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::2b) by SJ0PR03CA0131.outlook.office365.com
 (2603:10b6:a03:33c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Tue,
 1 Jul 2025 18:45:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 23/28] drm/amdgpu/vcn4.0.5: re-emit unprocessed state on ring
 reset
Date: Tue, 1 Jul 2025 14:44:46 -0400
Message-ID: <20250701184451.11868-24-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|CY8PR12MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 31990f99-f8a0-41e5-4edc-08ddb8cf6dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J6i5WqFXrHHyL65zKw8zGuX1x4tdJ5CxDB+BreYg+VSYYdwQEHmyUR8OJauj?=
 =?us-ascii?Q?rG6F8fqbklSC6heb6T1p6f4bvb5CT0bexaV68I1Vd4dIrX1sfjRWrVxCWetN?=
 =?us-ascii?Q?IYjWWZg3MAR3pX4FFf7p2a/JoO4so+G+kDw6Q6fQzydCdv9U++KRqF4PQqAV?=
 =?us-ascii?Q?a1fqyRWGLE7d1XM9e3uwzoR7w+21YAm4EjerKiSV7dfv5PIgZrloQMMQuIgM?=
 =?us-ascii?Q?1NmO/nytLfBRn9L4cmMDg7UpSV7AvZGybMecl/5SI8y/Mw7Haa5ufbCjbNwF?=
 =?us-ascii?Q?g8LSucAAw4m5hU2HCZt+CXhcvxv8liKvqbIa+c7UIEPEIDNyB7YIvYuSN8+l?=
 =?us-ascii?Q?zCD5AP8YndDzatYwXTSYScXzb2iAC4unryQezgMmJVxX6QzaGGQMo54LEHjW?=
 =?us-ascii?Q?1pUx8QwPMAxUjyPqj0X5AQeNPBcMFxsmxyPq5g5vKEo27SV2IsDPIj9C7TVC?=
 =?us-ascii?Q?GNlmWIScx1b4KwvT+Gf1rqm39vUisiFvBmG/iiv1/1l32cB7YJ+5MRp8ba3+?=
 =?us-ascii?Q?6Bu0DFbZfYO8yEmcz7YSI4+TQv0hB/vZ3KrYqFiJ/5NDZ4Inpyd+7NNtr0JQ?=
 =?us-ascii?Q?VhF+SvQVh4saAL3JrTfU/nAfIs98Damr2sKr2EdrPzpKeNmP5lnC1GOdkYXl?=
 =?us-ascii?Q?TVMQCQFsMfFXIaYPmZ585foTlbChegMZcnRMbmC7CrxRr7hLGtkybAf2sy5y?=
 =?us-ascii?Q?jH5iio7bEuD+o/u9ku9Pq388FpmML/b8sWEVFRrqKKk/kr5J8xLLS9ZZUUik?=
 =?us-ascii?Q?FS6Cio66i2QF3ZLHBUOKssgPxW9325iRNGmbolMAvtNlct04RwDENMrLV6YC?=
 =?us-ascii?Q?Pdj/ycvOOtsDJdpYmt1HhvRx8hF2qMhLiGA5oF1aX/mhrz2RLx13Iu/e9HzT?=
 =?us-ascii?Q?ljvcGJwS2Q3c6AFiDMCmqo1k70zadOifyEYwoLJGM26+y8Wk4kAeytDAqvY+?=
 =?us-ascii?Q?jQkLWDCnXmFjP3YHojjqU+A8OcnqT8uOPMQtuvwH4LLmftcoXcF7w0Xctzvp?=
 =?us-ascii?Q?T44qPMu5X6ngT2KODRhD7+7lzAjBIfyfrzk8nGkAAf78qZyJKG6qTBZ78heT?=
 =?us-ascii?Q?Sd8gH465BPGiiF6YnLGncn0aabPu8vJ8TItNmImNpomEHJ1QY21rVcs2LAFX?=
 =?us-ascii?Q?YIDkMX/sGklxlW5kgiziwNj2Q6Anl1AqLznPoTzDvke6vubHsRH5f5X3DhGm?=
 =?us-ascii?Q?5xR/FooFE898gVp2mdD1e8xPlcNfO8yCGO5MV67zLO5WmKG1s+HGFuAsK69R?=
 =?us-ascii?Q?PKIGFWu/k8z0vBfy/Fr3+7xDu7oEq2f69VnqR5Hzdz0XPfECS18Er5NE1KNF?=
 =?us-ascii?Q?qNvKxgO77z8LmdbiQuUCCKajKBvuhi4yjUUtWVDnkcxv02d2/cMF8Tt+hT+Y?=
 =?us-ascii?Q?vsLvQqoz+m16TDkW3QyZjKrHTVJJPf9SpHF+g7/cLN0WsHJCBHTBX0tRbNYO?=
 =?us-ascii?Q?cA54VhL89BTcZspBWHYOuzx7RDidvUbLxisCvuMorSKR51MOyPhlhrPI0503?=
 =?us-ascii?Q?m3JfaVbtdkv3tkRcDngx7RvuYwbHZnfv9M64?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:19.6939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31990f99-f8a0-41e5-4edc-08ddb8cf6dea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7681
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
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 7e37ddea63550..faf2df7ed3fd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1471,21 +1471,14 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
-	int r;
 
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	vcn_v4_0_5_stop(vinst);
 	vcn_v4_0_5_start(vinst);
-
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
-- 
2.50.0

