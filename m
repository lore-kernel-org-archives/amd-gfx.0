Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75B5C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 09:48:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4634510FE40;
	Thu, 25 Apr 2024 09:48:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tjzy4iys";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9C1F10FE40
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 09:48:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmYIVMu6RvZishdVhpr2Ie/wKFMLfvSZnX0xltzNL5UGyajYlKXXD4TTZzLZhJGyXzrVnqezv/y/QlQrdGVY8zhw7riWUqI7qgyt9c6855IJGAfa9X0XmxiTODi+bbf9Zx6QO8lLImBYMmE78mbnEsLiDmO8Y74PEU76m951RNVe4W7UqWTIvuZxSQ/XKT9F86c1zjzda04TZq+LR27PXO5nkKwFq5neGUAkqZ2oM7i1icZUFTUHYqjUWi9v0ww/VktrRwyxHEv5FCrpQm0uk0b8scuDebUHd0Z3/fpOeCgEnkaZ04SI1PGWxQ8Rezdt1BgZBSELVLtA+UBG9Sm5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xcmGRu7h4Adx7Jg1u3t8aA0uWyUg8RJRa11wv59iUw=;
 b=JeKQ8acnDGTpLbRilXdzhhJ73qAB+Z+ZT9n5udXN0zSAT32xvX1yNotUcKG+6cGhlNfsEa8c29xsDh3jBOlIyml4lADWXjVSW0mEalsWKEFFQG54v/Plxo24XYEBhtxmBljL642TPTsOfJ6g/D97wQFuikKFylqOP+D/7OQ5Ld8NW336gF9nGuR3ojRZ2+lo4t4sydocFtMe6hBZVy4+erC+PqnFMXrm0zxKG9ERCcGpXttVeY7Jl+OvWjJWSUiV9xoEgLA06wisJLjPr8ROiQLWz9FhXds4RVJwnQpQbQvHDpGDbQ8rleLBi0jSAjP4q4bBlNKRyPQ7GyrUaGOHzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xcmGRu7h4Adx7Jg1u3t8aA0uWyUg8RJRa11wv59iUw=;
 b=tjzy4iysT9nVL6o2Xjq4MCgDhLdD+j4VLHUzKPJMGIQh2LiQoJOwrqWgQtuP+z4+bByG+erw5Hl3St4DXb1P0zpUXiEjLgQrxQkYYmpL+btBAck/UjJSqBV6RTHFmOJ4YJotGddSaEqdtuQ3topYsnROLK0x2a8s6yf/ajpoupY=
Received: from BN0PR02CA0029.namprd02.prod.outlook.com (2603:10b6:408:e4::34)
 by MW6PR12MB9017.namprd12.prod.outlook.com (2603:10b6:303:23b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 09:48:24 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::c8) by BN0PR02CA0029.outlook.office365.com
 (2603:10b6:408:e4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.26 via Frontend
 Transport; Thu, 25 Apr 2024 09:48:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 09:48:23 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 04:48:21 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>, <Christian.Koenig@amd.com>, <Likun.Gao@amd.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH 5/5] drm/amdgpu/gfx: enable mes to map legacy queue support
Date: Thu, 25 Apr 2024 17:47:43 +0800
Message-ID: <20240425094743.134248-6-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240425094743.134248-1-Jack.Xiao@amd.com>
References: <20240425094743.134248-1-Jack.Xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|MW6PR12MB9017:EE_
X-MS-Office365-Filtering-Correlation-Id: 396c3b8e-63e6-447d-1d6b-08dc650cd923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dtA6087xfaxnP5rHX9fU0PZPNu013OlmK4IXMW35twN+kcMlauXMNNzUzB+8?=
 =?us-ascii?Q?59F40j+hV4bwKzlMx/EkEDrfW0XDPydt9ScKSkxA7lOgFwb2nqFMUOjUzraP?=
 =?us-ascii?Q?8dqlB0r5AsLTrT8JhYidF1njYWCJyVVJwHoBEj+WmNvptrQfbgY3D6YkAM3D?=
 =?us-ascii?Q?0o++1Cx/6x/qeTsrOmvFrhfwRClU+rFH3Lg2u5lgpTJLLFQIeKgwn+h06BVx?=
 =?us-ascii?Q?koiN4xv9Lh2Y6LkrX96vGDSY84G5gmlY3Qt1aBnXHcIRcLWbZNmNskOPq4BV?=
 =?us-ascii?Q?GIOjkHUkHJkXban5zUeNh6ZOPCZtFF0xx81qtNppEEXP01wZnUX7+9cuBOPR?=
 =?us-ascii?Q?TOv4ZT6101M71s08avC+S+P0JKLhY+Iu+n2i/q8c+d51BKzWsEeEdD8sjSAi?=
 =?us-ascii?Q?2QjwJowBqbJ4Fw0IYlBBbPI03HkRjHknJ9FN0S7XDtsyPwKSanvM92p/upLb?=
 =?us-ascii?Q?k7ADjB+7KvXo4uzhYmoqMym7M2eGynVm/TJAbHoojUF0/jYScjDcX+IytBYi?=
 =?us-ascii?Q?ZaVccIcsuJDaqPulpi2MYK+JdWxusweTg303/rYRwcaOCFWrgDLrz6JYr7vn?=
 =?us-ascii?Q?EJg4tp7LMohcEU7I6bujjREgAo9KgfIOgCtRlNCFBODfmoaKLG6y3lgfkC9I?=
 =?us-ascii?Q?sMEGtSnhirXPiWYCsZOHEqHiM71Q+9XkHsrU8znRiP84oPMsyB8xz6zK/1/L?=
 =?us-ascii?Q?zhab+EzYdg+VfV177MP6v2oBjlLF8IXQ1PLaRUWqQSuGiJB7Z7xs+J7d1w9L?=
 =?us-ascii?Q?I+BYcSxb1mm0/QsQfV73y38K1sIJFDcjr+8K7/UJDRMmAruLsyhIX0evGmRk?=
 =?us-ascii?Q?GVnbEdZ3A740HARiAe5Oz7aDfAr7aglJY57e1/1vvMuhbt88a9EfjnYFi+uO?=
 =?us-ascii?Q?p3uoMc0Ke3aZ9cLorfLTrCRPC5Kq9dsDPRCQMSAmLPxunEjsD2lD4DNYdpNw?=
 =?us-ascii?Q?KsSA4twm4EgrM2xyol7YTY4vCugu+YvlXm2kwbjOGmX/5SBwcB0G6vmj7x+J?=
 =?us-ascii?Q?6Bv1tKi6bmpk2KNXqI+ZRsxk9PKdKi5VQkZJ7EFTzWiyIOToeEe/KL4n8bha?=
 =?us-ascii?Q?SVVPuacKze8BT2T/vNLFylSI2MjkbO7DaSSi4QKZSu6eA3lJhhc4OZWd4Hd1?=
 =?us-ascii?Q?4lGjVHmf+yVb5mlkk5bqHOGwHWzDl2a5FcuepUXf4+qHX+D/pAQXY7YsJRDV?=
 =?us-ascii?Q?x/wqEJZ3zIn204dsoej/UVD9wScPlYncoHjUQ2gXGlQzdHXsvCyXyut8iTiJ?=
 =?us-ascii?Q?pmQSi7qSLVxR+0X90OAM6Hac9KT1YLBVNlbRd+aaVvsBYP3cBa1t/xVWRNDU?=
 =?us-ascii?Q?NDcJer0FZxsSeQ6scOjWDF++t4OkfXUelbimCPTjWjrk5UbE6f4MT//mIq7d?=
 =?us-ascii?Q?VEtGhlI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 09:48:23.6269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 396c3b8e-63e6-447d-1d6b-08dc650cd923
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9017
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

Enable mes to map legacy queue support.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 39 +++++++++++++++++++++----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index d95555dc5485..172b7ba5d0a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -622,10 +622,28 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 		queue_mask |= (1ull << amdgpu_queue_mask_bit_to_set_resource_bit(adev, i));
 	}
 
-	DRM_INFO("kiq ring mec %d pipe %d q %d\n", kiq_ring->me, kiq_ring->pipe,
-							kiq_ring->queue);
 	amdgpu_device_flush_hdp(adev, NULL);
 
+	if (adev->enable_mes)
+		queue_mask = ~0ULL;
+
+	if (adev->enable_mes) {
+		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+			j = i + xcc_id * adev->gfx.num_compute_rings;
+			r = amdgpu_mes_map_legacy_queue(adev,
+							&adev->gfx.compute_ring[j]);
+			if (r) {
+				DRM_ERROR("failed to map compute queue\n");
+				return r;
+			}
+		}
+
+		return 0;
+	}
+
+	DRM_INFO("kiq ring mec %d pipe %d q %d\n", kiq_ring->me, kiq_ring->pipe,
+		 kiq_ring->queue);
+
 	spin_lock(&kiq->ring_lock);
 	r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size *
 					adev->gfx.num_compute_rings +
@@ -636,9 +654,6 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 		return r;
 	}
 
-	if (adev->enable_mes)
-		queue_mask = ~0ULL;
-
 	kiq->pmf->kiq_set_resources(kiq_ring, queue_mask);
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		j = i + xcc_id * adev->gfx.num_compute_rings;
@@ -665,6 +680,20 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
 
 	amdgpu_device_flush_hdp(adev, NULL);
 
+	if (adev->enable_mes) {
+		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+			j = i + xcc_id * adev->gfx.num_gfx_rings;
+			r = amdgpu_mes_map_legacy_queue(adev,
+							&adev->gfx.gfx_ring[j]);
+			if (r) {
+				DRM_ERROR("failed to map gfx queue\n");
+				return r;
+			}
+		}
+
+		return 0;
+	}
+
 	spin_lock(&kiq->ring_lock);
 	/* No need to map kcq on the slave */
 	if (amdgpu_gfx_is_master_xcc(adev, xcc_id)) {
-- 
2.41.0

