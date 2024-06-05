Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3154FC27C50
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 01:34:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6768D10E67A;
	Wed,  5 Jun 2024 01:34:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hbVa8I1P";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 794EA10E672
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 01:33:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyFf43KT5R3DNecHLBMVWrFYmDKf0sWRyy/40rhVMBvCEXX7lpm2I7IKIZkst9ECbxu7wHrT38bJWbhVwaicAMbzofb4cKQWtiLBqKXq+z9w4jPCr8Bj5BKPjHw4UuaqRz2mD5PpG407q96+2uory3LQGmVqK800fqZ1KogoUehqhU0PFUOwKIu05Q1iXVbsmVK92rNxgiOZZwYfIL96TIW+VSY4/K9M9IPmLlx1xKBfSuMgu1A7zruTDK5NZRclhhqgA7MHQChqKkOBLbiCAs/BaSdVH1N75Flij5XzvS5RSzaZ1USoF0Hl4JWZly1x9eY9nOVf/PC+RHycB09bug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2D4NB+qV9F9gvq0iifxSm4v9jYdHKVx3vPMZmbw7yhM=;
 b=irYNvpCzM20+i4Si5C3J+buARf/oQqKJ9c5tplOf+8r5mFbgufApKqGHEqvpfU/RqpFc0FVqgHjMzd1HM0QQ0RvOZHIsuHG/6aPrMTax/K/TA5i8Pi26H/5kKgAdAqlBO0bZtzFHZvnA9SvlhBCEQzYpEgtAsva6LUEj5BahtQbyA/ZkQSKViPC3CgLo2BjhqTr2RTe7Cb94PYOrc9TQnfgl9BeIYLV2KSsB6xLJ2dQYKMZvrL6AIY3TjQo+1AUutkd8vU1udwsWlJ2FM6BZ+WfKRLCjZ9IrYgQUXyFwrfYvOkQ1CEub3eZIo7cMPxWlwKOOW7wc+PBKoWWHk3mBcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2D4NB+qV9F9gvq0iifxSm4v9jYdHKVx3vPMZmbw7yhM=;
 b=hbVa8I1PZ0oZ4trJ9Ay8j6rmmnhzGi1jjoqaKyOGh6g8sDDiOeDfcKCga6UsLg09YKm28mVUbtPssasUlL+EJ3heBtZrFxM1PQsUnVIelux4vzZt7hd4VOHTFNrsdBOiPiUNS0gVQrs0kSMAITPgeZDljMH/eKjFb6Pbs99C76c=
Received: from BN0PR03CA0029.namprd03.prod.outlook.com (2603:10b6:408:e6::34)
 by MW4PR12MB5601.namprd12.prod.outlook.com (2603:10b6:303:168::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Wed, 5 Jun
 2024 01:33:53 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::ef) by BN0PR03CA0029.outlook.office365.com
 (2603:10b6:408:e6::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.29 via Frontend
 Transport; Wed, 5 Jun 2024 01:33:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 01:33:52 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 20:33:49 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH v4 6/9] drm/amdgpu: call flush_gpu_tlb directly in gfxhub
 enable
Date: Tue, 4 Jun 2024 21:33:15 -0400
Message-ID: <20240605013318.11260-7-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605013318.11260-1-Yunxiang.Li@amd.com>
References: <20240605013318.11260-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|MW4PR12MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f55c2cc-51e7-4ad2-ef5d-08dc84ff8ed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RDf8vMh2f+U64+P8paeSb2BvwYo4UvTYIwMviPWDURxZAapKGUeiViN17JzY?=
 =?us-ascii?Q?YZWRe4WssMM6f1v3SYyrNNhbyCW8XxyP2I1lQsemZM5GWMMj4m2yS/95O8LV?=
 =?us-ascii?Q?VurcVHiSMPsCOp+xvXBQBL0SixrIirg0bFQC6KJquy1ETypidvWyK6knRrcG?=
 =?us-ascii?Q?jiMkJd1jFdpuACYcih8OJSySx3tXVhmqZK6cvIHcUoYljwQlYG63iAlo6Dr9?=
 =?us-ascii?Q?/N8P08+DksunMI54lme7AyRK6fG/43K7HIVZff05foFyMxjrUD0EFgWasGvb?=
 =?us-ascii?Q?s1L1WbLzVcR6yt9VdPSnli1PzES4oCCBzjugboYMsR/CyEvR5WbfYY832/5a?=
 =?us-ascii?Q?sg0GF8twKa075GdjffPD+eRGplMQTUZ2iD0EElZBaojDSGHEvYyXqNuJ4rY7?=
 =?us-ascii?Q?KpB0W7ux1GA+FFC71xdtySpr4U1niCyXHyShYAguQcl4vPWK1ppL2uJRu3sO?=
 =?us-ascii?Q?FHFXzCVwAYeAkBqFEpnhw58KU8Q3XpiULpSh7sEdWzzIWAWviFGMA3OIZeWW?=
 =?us-ascii?Q?u06Dz+28yc9iY2cD/3MdCZiGtXzNIMRvf9f1BybpoSp1ZXzpGC8OnzKNu1Go?=
 =?us-ascii?Q?oGY348Af0lvz0f3WeLIKoiQwSguN0uApoj5OxIZwIZ3KQ/da7iV1T202XEAP?=
 =?us-ascii?Q?KqiIFzr+W8jG+1mKK/o5uAQJVlUlleSUEZYXAmYqEZtwhKUFH/sNpq/VxCz7?=
 =?us-ascii?Q?cNfxkCZ/eYUW69jblYFQm+cl+pfdcaNOHc2rSvjpiV/2+hQg6ImX0MW49IOO?=
 =?us-ascii?Q?j5jf7+Im+Xd7CQwHvSbliAH9Lmmhe5TFdk6Pdn/E4ALlHLQYVaxanMAWAxD6?=
 =?us-ascii?Q?prmLfMJblIeS7E2wQ8YHW9q83ma96Bfj3zPpPg62RmVI185cMMlYtHoSY7tj?=
 =?us-ascii?Q?JvFosNphq2WMiY2MCvm9h+t44WBDBajVP/XPcebblRrfXpSCegpbP4zY0isB?=
 =?us-ascii?Q?ieIHa6VUOBOOKEetx+z0RwUfJ5vRdcvNYbVviceCRZsr/gRrlBl8wnCMjD5o?=
 =?us-ascii?Q?2BCIoOi3YPt3LSo6NDfoTwMdRYSRPicaHVpH3YNW3DZyq+rApCalCA7WlYEr?=
 =?us-ascii?Q?MQB8Vv4RJjZGOzLFwO1asZNGtZLSgXOff5q3ddPsNjLQ46crMBRjc6q9YpdD?=
 =?us-ascii?Q?6LNQFNAw6b66M0txaOy71aZiit62gV2hOx4DSD9rvZVRfDHO1fRYptAxTBfW?=
 =?us-ascii?Q?yb4Eo/Xt5F1IcjDhinJYC0rPQO9gF4zdb02pzegkg4bHIB6OVCK9y1z+fgSP?=
 =?us-ascii?Q?d1QXn+AjDhkA5UBjFdhW7st/OTlLwlEyithXoahJjEcDRUNjYILhl6pfGXvA?=
 =?us-ascii?Q?32dCdLZPzF3gh+bIUTsL79yg1VX7cf3LgLNStqrjwOmGkSpbIrEQugI35LRh?=
 =?us-ascii?Q?C+xGA0srnSkhApJnSLGn4WHCej6e?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 01:33:52.6767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f55c2cc-51e7-4ad2-ef5d-08dc84ff8ed3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601
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

Here since we are in reset and takes the reset_domain write side lock
already. We can't use the flush tlb helper which tries to take the read
side.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 4 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 603c0738fd03..660599823050 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -620,10 +620,8 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	int r;
 
 	if (!hub->sdma_invalidation_workaround || vmid ||
-	    !adev->mman.buffer_funcs_enabled ||
-	    !adev->ib_pool_ready || amdgpu_in_reset(adev) ||
+	    !adev->mman.buffer_funcs_enabled || !adev->ib_pool_ready ||
 	    !ring->sched.ready) {
-
 		/*
 		 * A GPU reset should flush all TLBs anyway, so no need to do
 		 * this while one is ongoing.
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index aba0a51be960..93b62107f7a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4401,7 +4401,7 @@ static int gfx_v11_0_gfxhub_enable(struct amdgpu_device *adev)
 		false : true;
 
 	adev->gfxhub.funcs->set_fault_enable_default(adev, value);
-	amdgpu_gmc_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
+	adev->gmc.gmc_funcs->flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 1ef9de41d193..b7ea46ed0c72 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3213,7 +3213,7 @@ static int gfx_v12_0_gfxhub_enable(struct amdgpu_device *adev)
 		false : true;
 
 	adev->gfxhub.funcs->set_fault_enable_default(adev, value);
-	amdgpu_gmc_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
+	adev->gmc.gmc_funcs->flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
 
 	return 0;
 }
-- 
2.34.1

