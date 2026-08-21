Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC100C5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:51:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83C0F10F3AC;
	Fri, 21 Aug 2026 19:51:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U5J4ZLjx";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011055.outbound.protection.outlook.com [52.101.62.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 058B910E34F
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:51:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6VIWmwoJqby0LuZNYmRkkOGIqk9sF3cpAhOFkPjSBuyYQWLW4V2ezEk+AKXgsIvI1RMtAE8bvaCfIAT0UPWQnuNCfaMdyLLEejqlbkBeACNYJPgAGREsLM3NZgKPnUqYFVMwpnqTz0C4BUuEfUZhCTUXyZ7Y2f8ACv+VP1IlSaf/WfaGWuPpTdX4EDZQwWTaWmbU0uZ0apd1iqFBoJHn7Si5o5DYLL+9I0YeQ8j7kqud+COjZZL15jOtzmrD8suHcgPSGbsG1M9WK1GO100eqFt314WaWXjzPvgjr22vPVExh1K7/OMoFIkzQa3zkeRkhhJHsDyG9gHeYUOqAPWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVOMPpzeGliggGI+D27nfgpR7N5/BjMMaj748qR721E=;
 b=GQX0R+13o3iCAniwogMF6hE9K2LBejzqeMOWC1yA4zzm4jaF0Y0//Z5a2U57UWGdtx1UvHsWCItw2y8C8YzA5aE7S2gpuQySAOKncibl6DoOjfCIc/dvWJ+Y8do+2r2yoCCvXBwxs5OTgtkRJZrcwidmC5dZ0pTIWeGdnIMP4L708gUL++a9+GtwKwlQczgddQ+z3fp1y+otcSACH874DwUzy86VaNl4Mr6pvvOEX74KgsnVXPrlOq7IkFo/WDcUwHNTLhzmDarQ9XfskGLrX4F+V5inpodn0CUXAMo59hH1yUkkqvYJ0uj3np0lklpvGOFaiRCnHqOQ4Zmtq8qDnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVOMPpzeGliggGI+D27nfgpR7N5/BjMMaj748qR721E=;
 b=U5J4ZLjxDg7UirnYVwxlUklyhj8W4gdBuf3IZdX6HWtK4WCHiLeXdrwajQLyh52WLx/FA3zn7LQ0JZBSL6MKY6HZ5wNENPQaWimRWcHPx5sI3GTxI1WxT1ycLPs13i8SHlM90L69GM3JnA7dcqfBsvJGtYcuNdeSBgMb8sxDSUo=
Received: from CH2PR12CA0021.namprd12.prod.outlook.com (2603:10b6:610:57::31)
 by PH8PR12MB7350.namprd12.prod.outlook.com (2603:10b6:510:216::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:36:15 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::7d) by CH2PR12CA0021.outlook.office365.com
 (2603:10b6:610:57::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:36:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:36:13 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:08 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:36:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 93/95] drm/amdgpu: create UALink NPA import BO directly in the
 NPA domain
Date: Fri, 21 Aug 2026 15:34:56 -0400
Message-ID: <20260821193458.808626-94-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|PH8PR12MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: 74ce281b-c36f-42a8-6dc7-08deffbb75e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: BhXYIU1g8rZA0aAdoJok91C4ph7EG9YnDHoAwr3wjo+BBqFarBVvT20epObDKSj7wyc0zixqTuMxei+Co+hzLBokq+UpdIAhIcjQdGivQOvP3+I8FC2mEVSkCxBXO3UDhuWf56TtWNr4MwA2L/nWkOFeptjArtMaRnmIvolJJxyn5Eu3f83FVQOIAMRM8bcCD0TpV55Hwc2xluNh602CTxYE+G1U1jeG9Vr0X4UwjNP9noJEAsbGIAGu45fCqoYDU3hnmUv+1Qwnh6knp/99SAWae9FWOYXa7duNgAaDrxqMPegplZg37DoyAR/dhFRtsoR/MrnlLEnDyfX6zfCQ7HL7VPlsWDwnMpAcwHJ0e1noHcv4n1A0O1VRhKV5nXoH7AC7FYCyhivnJntXYQpGKfG2Selr8BMOlk9PCw4SF2jvSeGliZeqsKHy9gI7xBnbRxi034DzMatuyC10nOkShPBEfHJ02heRjDp+k9VsRCAOo60kiCV/fEm/1BNKs9siAEMx3dqhv6YgGDx+zR8cSKe2s0dP7g+okK/RwX6q+23wc/56f5HsNciHzictAhq3DyOuBSQo+ELvVedjPJ2nziVWBKyLPH3ZldJ/fw2OCrLYL4Nzsg9zZjPsXYySzcB6VaBVA2YlrkAkVKlyTFwZpmQX1jKMRiwWuj19I3NO6+56Isn4srLk3BjBftQksoj/LOD8Hu/pyDnJta9dP8hG0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Qol1bk9POijzHKHYbYocZaxPOr8Vv0TvyWpysAurv3ukZRf7kon5jgjhagt86jKaH19NFxafhfE0xVJlbqQ0QrvSZkAZv0GtVS7323KUBkCXi/ZL+CBUjaaLmVY5Y4CvLPxVRqgAJF7PL3UUV8mua4b6TWYj5qbG8EqJzh9bIhClVyCcgv4hOdLdLmYgV4gMu0aXt73mqiwU01lFDUL+aVJecsBpBzTEjgVHinpOErc9fX0pYaLvny1OR4dCfpM+CLFNNWd61unZ/CfNAU8QdapQWYT528449ep7GZNez/NgaGr0j5nowM1P1T8y2els3hqB27um8Mh3iRqjgLiaHI2SgJW3KjzJba1ew10neMHN8Ls0EUIYVAycCj4yOt94c4SLfiM4Du2sev2cvWiupEMNIVQbgyhCF9uSE4Vef48qbQXq9AnXHXsZDsDqDadb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:36:13.4602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ce281b-c36f-42a8-6dc7-08deffbb75e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7350
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

From: Mukul Joshi <mukul.joshi@amd.com>

amdgpu_ualink_map_npa_to_dmabuf() created the NPA import BO in the
CPU/SYSTEM domain and then moved it to NPA. SYSTEM is use_tt=true, so TTM
attaches a host-page ttm_tt that the null move to NPA leaves behind. On
dma-buf export, ttm_bo_populate() then fills that ttm_tt with system
pages, spiking host RAM by the entire NPA window size.

Create the BO directly in the NPA domain (use_tt=false) so no ttm_tt is
ever attached, and relocate it to the exact remote window.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 29 ++++++++++++++--------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 444b0e29ee9f4..402d8941fb045 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -2987,10 +2987,10 @@ static void amdgpu_ualink_invalidate_import_mappings(struct amdgpu_bo *bo)
 static int amdgpu_ualink_map_npa_to_dmabuf(struct amdgpu_device *adev,
 				struct amdgpu_ualink_imp_xa_node *imp_xa_node)
 {
-	u64 alloc_flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS, npa_addr, size;
 	struct ttm_operation_ctx ctx = { false, false };
-	u32 initial_domain = AMDGPU_GEM_DOMAIN_CPU;
+	u32 initial_domain = AMDGPU_GEM_DOMAIN_NPA;
 	struct drm_gem_object *gobj = NULL;
+	u64 alloc_flags, npa_addr, size;
 	struct dma_buf *dmabuf;
 	struct amdgpu_bo *bo;
 	u32 handle;
@@ -3002,21 +3002,19 @@ static int amdgpu_ualink_map_npa_to_dmabuf(struct amdgpu_device *adev,
 	dev_dbg(adev->dev, "Create NPA BO addr 0x%llx size in pages 0x%llx\n",
 		npa_addr, size);
 
-	/* TODO: Check if this needs to be on a xcp_id basis */
+	/*
+	 * Create the BO directly in the NPA domain.
+	 */
+	alloc_flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
 	r = amdgpu_gem_object_create(adev, size * AMDGPU_GPU_PAGE_SIZE, 1,
 				     initial_domain, alloc_flags,
 				     ttm_bo_type_device, NULL, &gobj, 0);
 	if (r) {
-		dev_err(adev->dev,
-			"Failed to create NPA BO in CPU domain. ret %d\n", r);
+		dev_err(adev->dev, "Failed to create NPA BO. ret %d\n", r);
 		return r;
 	}
 
 	bo = gem_to_amdgpu_bo(gobj);
-	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_NPA);
-
-	bo->placements[0].fpfn = npa_addr;
-	bo->placements[0].lpfn = npa_addr + size;
 
 	r = amdgpu_bo_reserve(bo, false);
 	if (unlikely(r != 0)) {
@@ -3024,11 +3022,20 @@ static int amdgpu_ualink_map_npa_to_dmabuf(struct amdgpu_device *adev,
 		goto err_reserve_failed;
 	}
 
-	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+	/*
+	 * Drop the arbitrarily-placed NPA node and re-create it at the exact
+	 * remote window, mirroring amdgpu_bo_create_kernel_at().
+	 */
+	ttm_resource_free(&bo->tbo, &bo->tbo.resource);
+
+	bo->placements[0].fpfn = npa_addr;
+	bo->placements[0].lpfn = npa_addr + size;
+
+	r = ttm_bo_mem_space(&bo->tbo, &bo->placement, &bo->tbo.resource, &ctx);
 	amdgpu_bo_unreserve(bo);
 	if (r) {
 		dev_err(adev->dev,
-			"Failed to validate BO in NPA domain, r: %d\n", r);
+			"Failed to place NPA BO at 0x%llx, r: %d\n", npa_addr, r);
 		goto err_validate_failed;
 	}
 
-- 
2.55.0

