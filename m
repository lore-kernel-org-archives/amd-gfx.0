Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4F0C5B555
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80CC710EA06;
	Fri,  6 Jun 2025 06:44:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vcTkp+tn";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42B6010E9D8
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpGAOfWLAu1FGcKvFAhP1vdA2ngx1IwU82beShXhHwmFTyRDsViUVAx+gkQMII4BTKOoi5hm/2NmJsawvY4bBsl4B80dgxpi6Hc5XJbmSRVmfshJdc1mEAAx1dElLtffzGIMB/HUFJUwgMOVe/XNSeTULu8XSPtL0Wli4GMYVC6OfmkvsEeJW6epLplcugXos7U3RySIkyDLSzzgSp+I7SXy92BI7VSWe0F4viG11nMV1Vo+oHF/wcUwG729lJo9T9npQeLLSAPZnr3oW4Yzd7DB02gQeL20x0gZNl4JpVIXjYX6iVA0sBYRIbmKmI6ZUy0lvtbvjbAdb4ADn5lSYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ogronEiMX8L31nNEgWUquCP9BP6Baif7I/S6GPX+EM=;
 b=C1HG5tHE+DRUgha/SeG5z/+UBHZB0fq7P8aaPIIACdLlj01nmAOMMRf65RKD4aBvFrpBwIg+AymXZGiiOiOONj5vZQOPP2oPSyhfiF/1LPfZRHE8HZTcGREV4S4khWvkp8mrJFI5jBP/p3To73l8Si5+LGqsc/8EHTzd4/a+xe4PEM9uoA2NqVS9mcLIig8spA0hvZvZ2PpAU4rufQt2klcnr9a26ABhKNnp86u3gxxxoRJPZ7eln2rq3WXMftUQtwDO51bqQ1ox75JWIqoYud4lan70Du90uFJTO+rDuQ8tbAcs2DJIybu+TGxBTM9zBY3Eopo4Zo7UjIaXJVgbmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ogronEiMX8L31nNEgWUquCP9BP6Baif7I/S6GPX+EM=;
 b=vcTkp+tn/5mdVGXs4INsy/68QYVbYYdk+l8LQwzQakZHQ8LfXC43/aJQWkaAM3DDX2ZATfEgVq6ZPwj75qWsQj1KTqUKd1LAS5u3y/9YFqQZnVlNRsvIBnL76d2ZyBSMFLtKaK4mS3ZmKvvfDJ4yCepoVD/4AfcrEpRxwZtrDdY=
Received: from SJ0PR05CA0126.namprd05.prod.outlook.com (2603:10b6:a03:33d::11)
 by DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 06:44:27 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::20) by SJ0PR05CA0126.outlook.office365.com
 (2603:10b6:a03:33d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.10 via Frontend Transport; Fri,
 6 Jun 2025 06:44:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 27/29] drm/amdgpu/vcn4.0.3: re-emit unprocessed state on ring
 reset
Date: Fri, 6 Jun 2025 02:43:52 -0400
Message-ID: <20250606064354.5858-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606064354.5858-1-alexander.deucher@amd.com>
References: <20250606064354.5858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|DM4PR12MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b4cb55-8d5b-4cb1-3566-08dda4c594ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uteWklm2Um7BJsrXWvSNDDcOqoLL1Wy8Qd6wOCL/HB/iBq8rGMYavYevNk4F?=
 =?us-ascii?Q?NttLyEfCdYqpn9IwRkXDQ4CyVSO9pcij7MvHuGgmNO6Z4I5ooXlTsyFgX6BR?=
 =?us-ascii?Q?RkeRQeksr13fcybEnObsZL/gwZhLBRXpYrwV2H+pBd0u02SHEBiTgswXWRGZ?=
 =?us-ascii?Q?yGEHF17Lzg27lR+LoqvVPN6J0ar0/98WQl+UD6wAxgretprwfXsoa1idmMb9?=
 =?us-ascii?Q?GkqTZdfmz+N1LvHa1r6laRATqnQfsNvGtrvMfjhLodDfJSS6IW2gYF5xNsR/?=
 =?us-ascii?Q?VYQe7tUZ+zL+2NsUCd4sKK55AgJy4+yNJRh6/KzwTjoG34z4zUacTjQ1OY5p?=
 =?us-ascii?Q?VL+qGofFwAesauSYZ2KYoDH1UY4IxWV4cCfHm5sj4JZaQ0LA/ZY727s92ATz?=
 =?us-ascii?Q?M1TZuY4/oa++ovxOwhNnfoiEYUHD1/d1iFTaqTksaGkzSoD/FvUbu+QBbgOb?=
 =?us-ascii?Q?cKWr00I1OONG2PyQMZMqEDJ5E+idixsuptXA8CF9O1trswXvrMSvugnBgZsG?=
 =?us-ascii?Q?Hz+NGyxzPQGI/VcmLYnKwaS5KdaknMWW2FQTA1wTKtJHKkFPmAWUgCV4yUuE?=
 =?us-ascii?Q?r2PBwjamhuB3hN/leEaoopkCURDCVQvqdiZy8MkXQCf6SQVW6BL0UxEuirtC?=
 =?us-ascii?Q?Fkr3cTgY95ICN2TsuT41p7E95c8tWESNNGpycuniqurYYvKOQUkljzpJpM7I?=
 =?us-ascii?Q?N0CR89T3qKdRURBti41DCgygaledM8dxTYFixXhUPtOhN86H2iUjWRhbI/CS?=
 =?us-ascii?Q?4YCwcRGyPNlxRN7dIyBrufMto8T201yrjoKRNoQIU3eTGJ9/JwmkdqpqvYkv?=
 =?us-ascii?Q?OGbqqoxMZPHIqxJfZfFPAbPxzD4GWzfpPyHw8Wb2UBR2PQ6mN2ex291e31Lp?=
 =?us-ascii?Q?ZMuziukgoATHxuiPvQwf6EBIcpUellITRr8WPqbQgmuO3/xjWX29F4iI20+z?=
 =?us-ascii?Q?pktQ60Kj+mSRGI2G6AXm6O6yrZjI95USfVfPP5kXrk9Z2q6ayLJuu4Ec8q/x?=
 =?us-ascii?Q?MkhuPgkqhP03jm6gIjE34moFU7tkPxD1UiYLXuWCSwne1bhuyLIllJBFoonv?=
 =?us-ascii?Q?gWrXe9nZoFKy3bspy+WPL9fatlfjg7FFVFduU6qS7mZVcDIEImgQqbXYbgSm?=
 =?us-ascii?Q?1woYIzFGg4KWX2i1ZDx2TWO/kxE4IaaEK3z3jlmbEDUyi1hF+eYJqtWIcv39?=
 =?us-ascii?Q?R4WJXojAB0RzvCFa8BjPGZ7KFeyAaoYAU34I8vTV5C213lMMLXCDbgPp/5fy?=
 =?us-ascii?Q?IQuQ7FSMBS7Uacou8qIQh6GzbwyaqlHnDTD3kxB7mjkds4VhwRaQi5RQ6TbS?=
 =?us-ascii?Q?sNtIxIOFEcrArgJNaTGlYNGiuUEOoEHbvKRpNI2+LQ5B2SsDyuwW0wBY5QZ5?=
 =?us-ascii?Q?sDe1eK/J1j6rUuG2bsH3rVfysjsJj1jsAnoSnTrM0bEih+epIVq2ZKcbA20b?=
 =?us-ascii?Q?8PNdUV2j1uOPrdFJ1wJ9A1cbJJ0W/kB45KzOcsuJ/n/DNRpok3U/exvXFz+p?=
 =?us-ascii?Q?KddXPqKtMv21JXgjHq01DYPNPOED4YcojDIm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:26.9441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b4cb55-8d5b-4cb1-3566-08dda4c594ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6254
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
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index a9d8ae4ab109a..e3fd5291b5195 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1608,6 +1608,8 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, &job->hw_fence.base, true);
+
 	vcn_inst = GET_INST(VCN, ring->me);
 	r = amdgpu_dpm_reset_vcn(adev, 1 << vcn_inst);
 
@@ -1621,12 +1623,19 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 		adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
 	vcn_v4_0_3_hw_init_inst(vinst);
 	vcn_v4_0_3_start_dpg_mode(vinst, adev->vcn.inst[ring->me].indirect_sram);
-	r = amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
+
 	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
-	amdgpu_fence_driver_force_completion(ring);
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(&job->hw_fence.base);
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

