Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9D7C369AB
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Apr 2025 13:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5C9C10E20B;
	Fri, 18 Apr 2025 13:33:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oUGWCpeN";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D99D110EB9A
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Apr 2025 13:33:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsTOZQJgrt2efg9GJq8ihCWaRqCx/oB2sqIHUDPii8QbDnG5cu793swm6Q7sqQTDCIbywblo2R6LdeHIpxqFKsRZmdf+Koe46ysQZ0GLCQepwe0NC+LwaZ673+gSmt2AmKIoft7Nb9/e3H0Kq64yg+jnmlcoHKr0c5sRA5K09AKYO50kFJM0mJunDwvZpcFjgltflJ01wwdsa5LeSLdEfNEHkHa4khjqm5+zXBGWyHdKKSd/63UIX75voy2MCGid5FYceRoZI/fYDZOIgHbaqi0VTq07kbYQx/S+mc52i8Zx8jhYcEUhwZEGrrNwz6w82+a70pSABZf7f21N6fKkyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrtIwilBUrYh1q7qHd2E6MRP02bT3pMkWSNtoMjpdEM=;
 b=G2tK8M3HPVOuR2ZpvFRZeEx7JRQgXFmhLXiqsdOSmFwCOFfKy9zPksfDGMtELlCvrmLhzXq4O49VT8EVJyXkztjzhviimQVnyKj7KFQ+AT0iHwUUT7ZYzhSj469wbMApOFdOv/b2bfmMw9a8/dT7kL+t2vfFEsAcLXG5r31Z/2LcQ7QqoPE9tZ/sZ0ULWWN7rZ31RSCiIXZT50bnxyxo8YiQvjqVSs5t0JNzPWez4OowmFhI28cHIiukdzn/fRF/2zOFmHuXyy50hsK4VQ8k6ikVbzMX7MsuZuaqCWpNGY1wXuNsbKuIRpZ1u+qOGW5kvJp+rhWCOL0bE5qNMTBSUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrtIwilBUrYh1q7qHd2E6MRP02bT3pMkWSNtoMjpdEM=;
 b=oUGWCpeNQeE6/9A9uRMD7txJ/Bnw/AvStU1uaYRwML5heSMpKO1IldCmuKAhRZSZXiUrU/WG5/Nt9goggoJHQlvsOHW5S8RaImet6rAu0+ihZqIaWn1lojNOeGno4QjQJmiibLNb2TsqeBa8JT0dFnRdhdgfNDX14EFdYfhUigI=
Received: from CH0PR03CA0088.namprd03.prod.outlook.com (2603:10b6:610:cc::33)
 by MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.25; Fri, 18 Apr
 2025 13:33:08 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::25) by CH0PR03CA0088.outlook.office365.com
 (2603:10b6:610:cc::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.18 via Frontend Transport; Fri,
 18 Apr 2025 13:33:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 18 Apr 2025 13:33:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Apr
 2025 08:33:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: don't remap HDP registers if page size is > 4K
Date: Fri, 18 Apr 2025 09:32:53 -0400
Message-ID: <20250418133253.2453955-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|MN2PR12MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: a8247b99-5ff2-49d4-1992-08dd7e7d8de3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wDKfC6hOFyiwEPihsAFThkxv/CULYztGZAnlmqTWnKQOisyXVa0qz4k7QN43?=
 =?us-ascii?Q?GH5FUh81DSKUz4rl5HYrBsGvidXLLkOUcGZCWFBFPTm8PYyao2C48m8IC3GZ?=
 =?us-ascii?Q?GQZRaUNbaI+PoIa4OG2WUlu9UqAn4XRLnjNbjMQi37xcNa/pktoHIAcerhuA?=
 =?us-ascii?Q?wN1DdM2gUNW4VzJ65taSaRmVbk/INDvToJ7KGZOg8/ulM66k2GaeWaOWniSE?=
 =?us-ascii?Q?znb2+Csqizpb6Y3O1/iPrgmwOKEnXR7Aejya+24PzkjaRkLCR+tTWvqyH87V?=
 =?us-ascii?Q?SdUSXaT8u1ZLyqBYLDIeTAmvqLqUGfl63ihaESG8OmrmyemQdLP5JSeAefyK?=
 =?us-ascii?Q?IS+dFfOH0N2Z6yPuH5L5PCVwKA8ERZNWlLw4j2ad8mgxllG6nhZxN0DSDVYP?=
 =?us-ascii?Q?uHx66aSZsmWGDnyi/hDO6ew4EtiLrColQv5C54BtUjy5eI8GKF4lXUMZ84JZ?=
 =?us-ascii?Q?LwoWmi5zu/gMQO63y2wKsAtmtgSdhJDhnY4H6MjM2qJJDFxXOPe/fZgJ1iGY?=
 =?us-ascii?Q?m8IRCTCReI5F90wOd00HxRWnCzWH3iUWOCD6cqpiX1DGMHrih1RfMpGdHtiQ?=
 =?us-ascii?Q?NUYSXRFTqsDsi5SQQmowKXBd/qdMtg3tPNAi7JbIBtR8s+N3cRSkBV95hMdf?=
 =?us-ascii?Q?KogBZeRNhAQIv91Yz3JrJvfC/gqj96l7ftuqD2P1rymLNtU9rVwcRT+fdPd/?=
 =?us-ascii?Q?TBdIzKWSa29tk8IgUDj0q+LOWZX6WWkq92lWrqCzkIN7dcvOkcFfcINd8N5Z?=
 =?us-ascii?Q?tuTaUsGRBrLCQWtLwCEHlxRw/6RVni1Tb1sV2AA2l1330ICMsFuAuidDjle1?=
 =?us-ascii?Q?cA0OD+zxEPU4apYgE6sVMKu6jcs1FsLtAbVfdkE3AyCgUw4euWifR1h92PS/?=
 =?us-ascii?Q?hrSNj+n/zbCOy46NJSwe28WqoCV6u4aAYia2rWZsm5o+vU8dQEQpSIYQhPqg?=
 =?us-ascii?Q?umbWBLouXLUD4lclcJKbPFGTG10xiwEyE83LXKnHlZvUXXSNgaLtqC1L1IOb?=
 =?us-ascii?Q?caRX2+0W4Ci/OpReju8qVIeRqc9g82+ToIFdD3EA/luXbWctlJ+pKZ+YqkHq?=
 =?us-ascii?Q?OQcKYCwcQRV77TzrJf4P3vguFTToQFAI54tICgPBZ7WS3o2042p1e45MwnJt?=
 =?us-ascii?Q?gCBmAXyxpEy561j9zCzHS0i2znl43OBvIrE/KjMpcYBCA4K8fR4x8Eh849wW?=
 =?us-ascii?Q?lqtgtZhW0HgxacwzSkyDWagSqQiRIIfzcAk06/uwAhO0MT0du9u2p3HQG9Wq?=
 =?us-ascii?Q?5AiTWHfW+fgunwtyTWmvcPAEwsqXZDBDt0E7ZhEMtGucN4vqTAtR8j+tSDTM?=
 =?us-ascii?Q?dvUorB925T2BVz+dIwLDi6J14HZ5Ha7njoL8p+NaGt9y0P6nOsnp9yH6gtYV?=
 =?us-ascii?Q?xWyoRpYW0mAM4TIpf2GJpbO64e6rK2PMHparCdU1iuTrEjWtV2tk7xANWro+?=
 =?us-ascii?Q?ecTTkpqAZoC3b1yo7KtLmIG4F/+HiYLLJ3IURZNpOtX03Vbt2Afv1KNH0niZ?=
 =?us-ascii?Q?WC6dmIujXmBvYOHUGe6B7syoEBS1HshISqI4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 13:33:07.2335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8247b99-5ff2-49d4-1992-08dd7e7d8de3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304
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

We remap the HDP registers to an open part of the MMIO
aperture if page size is <= 4K, but if it's > 4k, we remap
the HDP registers back to themselves.  Rather than doing
that, just skip the remap.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c    | 3 ++-
 drivers/gpu/drm/amd/amdgpu/soc15.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/soc21.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/soc24.c | 2 +-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 50e77d9b30afa..890f846b80607 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1002,7 +1002,8 @@ static int nv_common_hw_init(struct amdgpu_ip_block *ip_block)
 	 * for the purpose of expose those registers
 	 * to process space
 	 */
-	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
+	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev) &&
+	    (PAGE_SIZE <= 4096))
 		adev->nbio.funcs->remap_hdp_registers(adev);
 	/* enable the doorbell aperture */
 	adev->nbio.funcs->enable_doorbell_aperture(adev, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index c457be3a3c56f..ef24201ffad52 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1297,7 +1297,8 @@ static int soc15_common_hw_init(struct amdgpu_ip_block *ip_block)
 	 * for the purpose of expose those registers
 	 * to process space
 	 */
-	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
+	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev) &&
+	    (PAGE_SIZE <= 4096))
 		adev->nbio.funcs->remap_hdp_registers(adev);
 
 	/* enable the doorbell aperture */
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index ad36c96478a82..23d4117287702 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -877,7 +877,8 @@ static int soc21_common_hw_init(struct amdgpu_ip_block *ip_block)
 	 * for the purpose of expose those registers
 	 * to process space
 	 */
-	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
+	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev) &&
+	    (PAGE_SIZE <= 4096))
 		adev->nbio.funcs->remap_hdp_registers(adev);
 	/* enable the doorbell aperture */
 	adev->nbio.funcs->enable_doorbell_aperture(adev, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 972b449ab89fa..71ba1fa8a8899 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -486,7 +486,7 @@ static int soc24_common_hw_init(struct amdgpu_ip_block *ip_block)
 	 * for the purpose of expose those registers
 	 * to process space
 	 */
-	if (adev->nbio.funcs->remap_hdp_registers)
+	if (adev->nbio.funcs->remap_hdp_registers && (PAGE_SIZE <= 4096))
 		adev->nbio.funcs->remap_hdp_registers(adev);
 
 	if (adev->df.funcs->hw_init)
-- 
2.49.0

