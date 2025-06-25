Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F3CC7EE39
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA38010E80C;
	Wed, 25 Jun 2025 21:07:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="slwkuVeB";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50AC910E23B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIuUrtXI2piH5ypESNyUT0ptL/E9BEfd6+tqAW7X36ZR2YO6uYbpz9RSxB5KJskXJuknZevof5AVDkiC2iy99n9c6bBc3xwNGWbQ1qzhFCP41OL57IH+D+C0IB/wZvbLg2PJuHY+Z24VncIkStNlJD4vZi6sfrcLVqL8OHN/siYvG851SsC0jZcsgojG8K4VCxfb/zMDFoLSV98CIdkUNni4YxuSb6QUQfoZl9oB3Tv5ijffTsrc0ZiSLPLRlxmev2mMrY/UHFlxaf+0BdKu75jhCHwbpVWxplDy032sQsioXSNFsIt/yL6V21P6Qq1X+Axzw0vMgw6RbxsTd4dNrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJcM+iffO4yA4CeFmAkL9avhgHeSixcg4vk3BdfcT8Y=;
 b=XGwFMqlgMLGbqx73Wyn9LVTBrusYW3oc+bTwXcbkjOqD0Vd822oWEQHjOUUp6bt9/resn+HeYQz1YDsd9viCYBP10w+q02EEFx5CUwX87EUgumu/NySVd18b6ccRZQyG2ND4N70esUBNFILZwuylLspBcWycJ1psFFTOEdM7wkopsFXXfTFPAg1SL8ZkwiLw+u0ulr47IGKaS0mqGKmWEAMD7P1trxmajPd2zmjiUpQgP4HcZ5vKbn0ME9OpsMOMh3/3BtvEQ1zVuUCsHUTe7DkOBnOvZldD46FwZbtN+oOUvFz1tFOH2vDhy99Vx5YWHUPdPqJyqimh14gz+CVCIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJcM+iffO4yA4CeFmAkL9avhgHeSixcg4vk3BdfcT8Y=;
 b=slwkuVeBp35vhNqWlrAIjBVyoxRgW0IvDBdc2p8SKfafvhDOCZb7dGthw3Es+jGDQfZz03OspNNIQpdL1XExe0NzimZcg9IhYDYwBPuwRDfHY3BYObQsZPC3ghcZbQCQ/AXwtL6FZnLFTWLkPtSQO755knJ/AfJpuJkbe7Ju6uM=
Received: from BYAPR01CA0024.prod.exchangelabs.com (2603:10b6:a02:80::37) by
 DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.17; Wed, 25 Jun 2025 21:07:09 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a02:80:cafe::e7) by BYAPR01CA0024.outlook.office365.com
 (2603:10b6:a02:80::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 21:07:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:07:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:07:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 16/30] drm/amdgpu/jpeg2.5: re-emit unprocessed state on ring
 reset
Date: Wed, 25 Jun 2025 17:06:24 -0400
Message-ID: <20250625210638.422479-17-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|DS0PR12MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3f6768-735d-4352-310f-08ddb42c3f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JNbJBr9xJ+iKrJGtT9fH1zcyCieBVTWf/QsOnz3xtR/9CAxph8m5xcXYmVzB?=
 =?us-ascii?Q?yG9f7RBonPzYDQ/H8vtN5j/MZaiSobi3Nnd0tldqMo4y5nCpc4ic+/n28zuv?=
 =?us-ascii?Q?VEJys3IQ+5GYuB8qPz89y8xhK3r3XHF6doXIofAP8CThFcSLDjC9Je9vWhbK?=
 =?us-ascii?Q?u8M9UecHgH5KO1wAJeAFNIiVUeqHumsAby05qX/q6B1pTMwPzU3prYbtUO1V?=
 =?us-ascii?Q?mrLPvcvHhQMg6ut5TVCaTk9+sHop5i+mGUOBFRgIINpcYbx5d8YWuTrIPrPG?=
 =?us-ascii?Q?KmqAAJvjULhX95DkEqIhtX/F9oXEs4cbLUU016hFpfFxdmsVXkuMYFYSjZvk?=
 =?us-ascii?Q?rKZFMUMmwuNdkhFY4lkhisWoDZztJ4l1sqtau9lJj8r1Ekjkk0FQPW4iG/Pl?=
 =?us-ascii?Q?frwZliGaFuXxfiBo/ALLcgCe2Xsa8nBUz4D13iSfH5Q00oS/rIQfk4Gs8buc?=
 =?us-ascii?Q?hMmCEJGpwXou2So81U+pIvUQpAzExV8qEHNw8Tx7EaJRcfYcp/IFtMGNUoUP?=
 =?us-ascii?Q?ATOm3B2n6NWbh3nuolotGWxWu2yVUl9nOzgcf+Ja7fe1pMt/ij3qUuysC3Fm?=
 =?us-ascii?Q?Vu3xFqP4EzS2fmXq2KTSiijIx8MGD93m6TWNAIHpjJRqvMZ9MvHy3vCMn9ny?=
 =?us-ascii?Q?mzV0P0/14MAAkK4cRDnhwSDnLSuTGKXmurXpFjw6TIW3O3HiPmc8LyUlGQc6?=
 =?us-ascii?Q?uy8bxm9+KrkVwVVUpLrCE1n8i7I63HzVJnC2OorBKjcvmpf5XwfjeTdOi7Fc?=
 =?us-ascii?Q?1O396XeIcSc9nDSklyt9cAkckoHm4vgfIrlpGoYQZ1aNaIRAc4eNJOIfmb24?=
 =?us-ascii?Q?/sH8LH3AnXrgfHfrwt/rEOkJ6a+H30Dz5hEUm/dIR3wCHqfln5KkIFnR+ZqG?=
 =?us-ascii?Q?W0VR1rakR3mwZt0KKqDhN8jw/TK9FA22i1767IHqcOqizNWT8mAEGbZ2olk7?=
 =?us-ascii?Q?HTz7ZpL7u+ROWClz+6g4E5x+RXHtbtX0SiTa3FWMZjMOwQ/L4h+PvjoewmeJ?=
 =?us-ascii?Q?5EjNZPdc5IW46EHhSLcP0lJjVQfTXUuJ6Z95R2v1Mah3W23UgEeXhGwrDYlL?=
 =?us-ascii?Q?xKExk/E5PibQJ3kl3SHmq8m8CTHt/cvwPqEmm9BKDcbrb1QZv9A3OuHl0j6w?=
 =?us-ascii?Q?KmOOHnkMUkviTDuCtXPU10djGFoPpTiSdJfQnkDSKGv+TN2BiO9DVmQGdkEZ?=
 =?us-ascii?Q?ir5cMc5vyXYjXC1HVSk1Kd0K67eANOuKHsz1YsChuY0EWjMnkowVuJ7SWZ+3?=
 =?us-ascii?Q?f3PHB98e5F9ZOf86Oh1zv9uMQhZ0yd2QBHTrGEW4WbQyvY7dHUKSyVJ25dyW?=
 =?us-ascii?Q?BQc0UxkHBn7hk1m9PMeV+QlxaateMyh+QdjfyUSNnWMaf/haHP4Q5hryALEo?=
 =?us-ascii?Q?dgDDXmsMTyaM3Xl0ePF9r5PB2hi5si3d4/22/Yi745NNQ3xgjePtMoOYKT0M?=
 =?us-ascii?Q?5/5BiIQLQbxwa1iL1PqLJtkSliKl1DHEMwo5Ub+i+Wx/9Jc/n5wxtF2kcvG1?=
 =?us-ascii?Q?Di0nQgcEXMOG/09grOsumW9oyt8LSsokZ7r7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:07:08.5772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3f6768-735d-4352-310f-08ddb42c3f20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655
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

