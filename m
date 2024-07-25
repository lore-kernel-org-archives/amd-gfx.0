Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D42C3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B26A10E84A;
	Thu, 25 Jul 2024 15:01:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZNTsD8QU";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0F4410E867
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKGaObMFZTvWWZ0smwccd6yQfjIaPo5IZnEF9FrgoJMzozqVQzWMu18rAOUIsRwCHMdCzjzOeSQ/UEXRf2fvw+X8WHr813jGyNxjRY2TOcTzh4iVhoSLMsAZ0t5lqfhdhcfo8QmtWcAY+ubW12t1jkzEZLaNrybe5cu5W5zNAMe8ATnQkHQ5nmtiSE1ZuGhff7CiSCXLfI8NFEwK4bo1+H++yPAqME/MhfSqrlbq1t7LAVbMwhi7z8umvjx0L32qbM6JIvqUlSEJXkKEpCAHV/AVsZgoO3YVPxKC9RlN7TvpRzJLggrEGJPJlGMEh0D72Xa48XM87f3E4sA4Ls80Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMr+d3HQb/lTCXm+3sA/ixrCks579RossD19I/gZ8d0=;
 b=SSCVkT7C62qxq6+rSKNT1zoQg6a/2z7MqZPGotrRZrmrpp7ejrZEN98EtcHL2g/wQHUr9oBmJ6k/zzS4iAUoCndTwEz9v66A5jkOYeTjgm+XPflxN0g3KirMsuLSMebL6FliTTKXMCwX2lrVfLl1k/ayVJWkbQM6NQcU+AaxludLCorAmGl9LoNoK4rNUPSkZM2IWKKaTFltVVacyzuSPMLqMKP36S3Zu07pkUmJJS2SzpUisqrFxF9bHnQ9Un7VfoeUSbXodsQgaBVAZhdgbbMHUOzHfgVBJOIaHvLhywSlx1MqUtwd+NJrGtI+SC7SfLRiGEScbfRJ3PBfpKbkdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMr+d3HQb/lTCXm+3sA/ixrCks579RossD19I/gZ8d0=;
 b=ZNTsD8QUxUbreuIIgmR/+JhjKzQlr+b/iyD2JsQBUvvVXBxChHmvldZCv+cHGfA4nXX3vEmZB3Z2TPrV+lnpkAXErDNUYigYgHJ2+a6Wi0hIrsoo0v0KiNHrNKb+3Z3MP5gbh/1j3rlgWimJx/xAC7DJ6Pa7s/Ln1gesRbW8yl0=
Received: from PH7P220CA0113.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::31)
 by DS0PR12MB7534.namprd12.prod.outlook.com (2603:10b6:8:139::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 15:01:25 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::34) by PH7P220CA0113.outlook.office365.com
 (2603:10b6:510:32d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 24/53] drm/amdgpu/gfx9.4.3: remap queue after reset
 successfully
Date: Thu, 25 Jul 2024 11:00:26 -0400
Message-ID: <20240725150055.1991893-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|DS0PR12MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: be045417-4757-470e-a6ed-08dcacbaa766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6I+qdmKUfxkK6MBffwYRxs3aTavEgBri/ADIE6iuvfyw7zIDKcgURCo7lA/Y?=
 =?us-ascii?Q?o3jfW3No3aYP9caazd4vRVegL81/U2jSIkzNRUxx+6zyk+A2Lhy5VdY9fuBY?=
 =?us-ascii?Q?f51g8mgIC+L+XTbk54DJgIGmvJvQzwEzQZkCXt8yEnuT4qhv15bIeKKD6UjR?=
 =?us-ascii?Q?+vvR4i9owSdCoQ48RGQlEK2NeoD63nxHkxRX4K3sNKmQLTyoWJeSG8ub/dTq?=
 =?us-ascii?Q?tstQXQzIup5aHs/fPMCJJMFkVixGaN+naJIfkOUidM+9Ij6x+nLnY3PX5Jwm?=
 =?us-ascii?Q?BpO33URGxAdQZ8ZaeVz2oE/eWvwb9DpSWFjNS2IIgSxvFBuhjR9wrM19HGS7?=
 =?us-ascii?Q?wBjoqyBYtv5tBRzwMGa3FYEFe+DCFAsoWJnRKZlNItyFyKrJuQCNB60aM5+C?=
 =?us-ascii?Q?INIpOp/xVT3F5XeMHTDrWIJ9KHpK9+Q5vwe3FIoc/Q/Ki16JQvDQ/k5icV/l?=
 =?us-ascii?Q?yVtqrReL+SrB4+dV+Js5L1+Yz31Up98SDBF5gVnp/flDXx+TCOrwvGnrzNBd?=
 =?us-ascii?Q?NNuohwYaRNq6XCMG36usMj0Omo7m07NzFQjPlAkyqjZ03UR24BwNHmTEQq9T?=
 =?us-ascii?Q?MPiuW+QwvGcd8Ys8P7NJUgVGmS+BWBEQU0BS5/okWPsH3/zcS3D/Nl/vj0KS?=
 =?us-ascii?Q?+TyIl8k0IkHVmqPVlsbFqx0j6m7O/inrPn3JqtG0+LvzfbxMwsJ51yv1zvVg?=
 =?us-ascii?Q?Destry0MMAf+clbyPr2TtZm2uH6TFIhvWthX1gZtwwovQl5HbWUb+N/4D4Yh?=
 =?us-ascii?Q?p5pMZf2/Aa2mK1FoJxsMqNwysFpn73YabpJwa9PfTym1zpoFp4FcdPHeEh/u?=
 =?us-ascii?Q?8ETnovfyj28uoxw6xFaVAPapYNKlaMMNPZffk+xwCVOgiDa9AnFOch7cD22q?=
 =?us-ascii?Q?j7+BKnOLtIn88dwxDcAddrvW+IndPTWEz+pgQV0+QlR+j4bDkyRvdlBYgwUg?=
 =?us-ascii?Q?m6QzDXovd0jZxQeDe+T9Ul5HBiHZqrvgJ1PyE8bKsRuiCHv1Ik6umCIUFKzI?=
 =?us-ascii?Q?c3Iy2mIcUylh5LIwP259IxjQPITyOPgN4c77evM8dTaixcfSklwvSiCfUr31?=
 =?us-ascii?Q?DviHrN9KHkzHYIfN7756PZyOoI5HeE4cnWJ2zQMTLKZQZXhsuwh8sFAYTwYu?=
 =?us-ascii?Q?eUc/ogr8SejFPeK69DzVvoQeVS6jBMVZ8dk3GLQOEOvE8Dula2ln0s5GVCE9?=
 =?us-ascii?Q?JC+V1P/S+9ErNl3xo4XRPBjf/w+wvwpnUMOE9ckDIbQRU+UY7dUQoz9WBvVH?=
 =?us-ascii?Q?qV4i2i+emCMWHi6iDdbQmV2RopdmNCv6Wz1rONENFlZdF2GjdQuN+thFyy8S?=
 =?us-ascii?Q?4WefLdbDzy+5PpGdZJ+0N1pqUkRMiWOY1KJmEwIIXU6SDXNODeTzKVv15d2Z?=
 =?us-ascii?Q?nwpivSDDTld5UsBskeqdEudNpjCTBqNhIcB6JWYcmuh3JXKGewRvy7fr62tz?=
 =?us-ascii?Q?Adh9nqB99l/1C02VgKLkQGjlRttpnk85?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:25.0778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be045417-4757-470e-a6ed-08dcacbaa766
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7534
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Kiq command unmap_queues only does the dequeueing action.
We have to map the queue back with clean mqd.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 36 ++++++++++++++++++-------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 6cf90ebdbad1..394790d00385 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1917,7 +1917,7 @@ static int gfx_v9_4_3_xcc_kiq_init_queue(struct amdgpu_ring *ring, int xcc_id)
 	return 0;
 }
 
-static int gfx_v9_4_3_xcc_kcq_init_queue(struct amdgpu_ring *ring, int xcc_id)
+static int gfx_v9_4_3_xcc_kcq_init_queue(struct amdgpu_ring *ring, int xcc_id, bool restore)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v9_mqd *mqd = ring->mqd_ptr;
@@ -1929,8 +1929,8 @@ static int gfx_v9_4_3_xcc_kcq_init_queue(struct amdgpu_ring *ring, int xcc_id)
 	 */
 	tmp_mqd = (struct v9_mqd *)adev->gfx.mec.mqd_backup[mqd_idx];
 
-	if (!tmp_mqd->cp_hqd_pq_control ||
-	    (!amdgpu_in_reset(adev) && !adev->in_suspend)) {
+	if (!restore && (!tmp_mqd->cp_hqd_pq_control ||
+	    (!amdgpu_in_reset(adev) && !adev->in_suspend))) {
 		memset((void *)mqd, 0, sizeof(struct v9_mqd_allocation));
 		((struct v9_mqd_allocation *)mqd)->dynamic_cu_mask = 0xFFFFFFFF;
 		((struct v9_mqd_allocation *)mqd)->dynamic_rb_mask = 0xFFFFFFFF;
@@ -2015,7 +2015,7 @@ static int gfx_v9_4_3_xcc_kcq_resume(struct amdgpu_device *adev, int xcc_id)
 			goto done;
 		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
 		if (!r) {
-			r = gfx_v9_4_3_xcc_kcq_init_queue(ring, xcc_id);
+			r = gfx_v9_4_3_xcc_kcq_init_queue(ring, xcc_id, false);
 			amdgpu_bo_kunmap(ring->mqd_obj);
 			ring->mqd_ptr = NULL;
 		}
@@ -3292,11 +3292,29 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	/* reset the ring */
-	ring->wptr = 0;
-	*ring->wptr_cpu_addr = 0;
-	amdgpu_ring_clear_ring(ring);
-
+	r = amdgpu_bo_reserve(ring->mqd_obj, false);
+	if (unlikely(r != 0)){
+		DRM_ERROR("fail to resv mqd_obj\n");
+		return r;
+	}
+	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
+	if (!r) {
+		r = gfx_v9_4_3_xcc_kcq_init_queue(ring, ring->xcc_id, true);
+		amdgpu_bo_kunmap(ring->mqd_obj);
+		ring->mqd_ptr = NULL;
+	}
+	amdgpu_bo_unreserve(ring->mqd_obj);
+	if (r){
+		DRM_ERROR("fail to unresv mqd_obj\n");
+		return r;
+	}
+	r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size);
+	kiq->pmf->kiq_map_queues(kiq_ring, ring);
+	r = amdgpu_ring_test_ring(kiq_ring);
+	if (r){
+		DRM_ERROR("fail to remap queue\n");
+		return r;
+	}
 	return amdgpu_ring_test_ring(ring);
 }
 
-- 
2.45.2

