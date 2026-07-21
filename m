Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78C8C44529
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 09:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6912310E306;
	Tue, 21 Jul 2026 09:21:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JjmMq3sQ";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EC3810E306
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 09:21:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LK2ItESMcjLZ0aiTSnXBNuH61j1ENA4ywtMcJT76czJRHj6p5C2P3pCm7EmJdhIOrcJ8MNkTHNVdW0Vbnj0xi+f9YE5T4E84ERsbjgsXaFv/Q4MnEQRP8IMrDnpthGCTCZCwBG4uEXWM4WVQ7fwa0Wv3Z1CFagu0Hx2PvCylJnk1Du8gsLbfE13JR3ksKiCpJuJFWcVB6aD3oKjscxJICIJ/dz46zLCf+mwg29VDQlmxlEAn5Xti4uX5lTgYH2uB7Krwg97i4A4C4sk0W+4ZC7KryORLDSHfQ5Tu7qEgC/zoKVtJjXnz7uecEJgsxARj5liNsebv3MQiqGICcoxMrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1+bN4ylm/hgsNMC/lDnwIVfiqe6oRwJiid7kmNZPu0=;
 b=qsy6IWg40FKV0Agnxn0d2gcel/By7w3sbvQulloV1++YIATLeSPprUARE/KcP/5koo1qwz0ozgbZOWKYTV8jlkI0hm2jzwtzkw8YDusIpFKFo81cxv1QguOQTIJ6GBX8Du3j2G8Rt4AISEtKL1wW3VrQ5kfnvlw3UedDASfwM4FYtCxzdaAU+teIlU7tg8CxsB/y1bi4EI9XRvFxBcmNRfnpT0xvtFiqE0qcSqzHKqFBbWMp3GFE52hE3J4XjHueNfC0TBuVvOTvDMyZNgIvXYgrCwXQ1Y0y8Klj1rCIsolDGw4X95tqoF2Fg03CTIHy6QHrucy7RMQzWKMzVFXSFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1+bN4ylm/hgsNMC/lDnwIVfiqe6oRwJiid7kmNZPu0=;
 b=JjmMq3sQzhv+D/LBVkeJaE1lTiGUvOR61CQMyoEtdvn30imrmIEeb7Ux0tBA0VJD21mwq2k08UzVoN7ykozMKEoU6k7yXlK3Duf6X90Psp9XZbGIZE+LnDJTHD3OJ3vRq8Ap0XnB7ALkVmkDJLDZjBo2euduc01CPpcj//oDPII=
Received: from DS1PR06CA0015.namprd06.prod.outlook.com (2603:10b6:8:23e::14)
 by SJ0PR12MB5634.namprd12.prod.outlook.com (2603:10b6:a03:429::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 09:21:43 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:8:23e:cafe::2) by DS1PR06CA0015.outlook.office365.com
 (2603:10b6:8:23e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 09:21:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Tue, 21 Jul 2026 09:21:43 +0000
Received: from canli-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 04:21:42 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: fix BO placement overflow with four domain bits
Date: Tue, 21 Jul 2026 17:21:24 +0800
Message-ID: <20260721092124.1967369-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|SJ0PR12MB5634:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b994c07-4bba-4b8a-ce69-08dee7097ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|56012099006|10067099003|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: tu1dDUohAB3Vis0PyCEeGyELk/dWwlhZBrBdVKR5K8yOOm1QcSJAyFLOzHocRu73m3pX+aL9yP5TE+uREFLIeUtPuum137Z+YZoICdeAn1RJg/OPPZOGm7yIS5Oo7KEFw79H9A1XNOAIqgAFY7v6/qPW9u1vS3gHcVUJ3XNPCNdf/NrdgQmbdoS3N8JVQ8xprK6Ss092zSJ/yuf25a7FTzUA/y698JJp7kRoTGQlK24apB0kIGu7ILic1iB2CtoBg7h72ZVz7aFntF6fO53dL1wo7Kmw+2FbZhoUNGfZtwpfwa6Ub8siGKf15iIr7dogXcqaiLsSE4+FVsgRdQ2bNKTSErMFxT9uZ5uw9S493m2IFeAs0PCMR4oPN29b0kd5KkKGme6xvxEhEQI5Xrr1TfKqvcrWLw8K6/jZ2doSjlomY3Co2J+pyroA1dkC34OCt9wFOCio0jroqDdj8qgx1jrEvNvo+OKJs1LLFM6YDZTEcoC1SA1UGlcyj6OTjSlsbHOzJrOlE9fwIcC2AivrnHAgozfojtm5ZKEddLCsMGFEVBW8IGy/teoNJcG0pzlvoVYOK/W14W5DVfgMaB2P8o1kodpG6CQb1WxBw1kOUG+9eplqdNh6czrzpjwyMMek93og5UeRM212V3N8ypF/I+umvbevihG9HvV83duT1IMdmJv7SYuDbflPZnn691nyCASzZa5f5BvXNrR0vS20Lw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QfoLTeCWIWIMSSRnJKhIpxtTW8mMcUux4YfHQsTjAqs9g4liy2HF62dJ+6xeTouuaybf0m+2zVrjJJW9KlnDcDoM6sPaSCK+VMUgmdNl2UDNGUVVKfHwuA6Hurmuy3rHTnUU5qPGCEFMcD3bu1xliDyTfkhfW65xmWKG+QM3n9nAL1pYNGlLjs4WRhZM+LwMwSjfZzH2d/Cd3vV3GF34jBz5e4l7NGQTBRhes7RWL4UC8mDVpav+3H0uuAqmFsnXE9lvkA0OdwCH2E/dFAumGw1uDeWOtvtbi3p62Mv4nRsX/Fl9/mPJ62bqtl/lusJDMTjr453OUC46YaiNg6Ylb7W8pXqGx+p4Wjh9Qs5jDiO6Eqv4p89W3dvgaqNLvNb3Y/q3CT0g6J0H7jlyXJSBfnKYvEV41lnELjJwVW8okgR4lbr9qxNwsF2ARhP+0YAs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 09:21:43.4024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b994c07-4bba-4b8a-ce69-08dee7097ad4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5634
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

AMDGPU_BO_MAX_PLACEMENTS was 3 but amdgpu_bo_placement_from_domain()
can emit up to four entries for CPU|GTT|VRAM|DOORBELL. Unprivileged
GEM_CREATE with domains=0x47 writes past placements[] and triggers
BUG_ON().

Increase the array to four and normalize mixed GDS/GWS/OA domain
masks to CPU-only placement on all rebuild paths.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h    |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 18 ++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 ++-
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 6a0699746fbcd6..bcf81aba942842 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -431,8 +431,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
 
 	/* create a gem object to contain this object in */
-	if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
-	    AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
+	if (args->in.domains & AMDGPU_GEM_DOMAIN_GDS_GWS_OA) {
 		if (flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID) {
 			/* if gds bo is created from user space, it must be
 			 * passed to bo list
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
index b558336bc4c6ca..321db2ca29f4a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
@@ -31,6 +31,8 @@
  */
 
 #define AMDGPU_GEM_DOMAIN_MAX		0x3
+#define AMDGPU_GEM_DOMAIN_GDS_GWS_OA \
+	(AMDGPU_GEM_DOMAIN_GDS | AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)
 #define gem_to_amdgpu_bo(gobj) container_of((gobj), struct amdgpu_bo, tbo.base)
 
 extern const struct drm_gem_object_funcs amdgpu_gem_object_funcs;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index d4a9d5e8fb429a..bb02858cbebf0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -99,6 +99,19 @@ bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo)
 	return false;
 }
 
+static u32 amdgpu_bo_filter_placement_domain(u32 domain)
+{
+	/*
+	 * GDS/GWS/OA are not normal fallback placement domains. When mixed
+	 * with CPU/GTT/VRAM/DOORBELL, fall back to CPU like amdgpu_bo_create().
+	 */
+	if ((domain & AMDGPU_GEM_DOMAIN_GDS_GWS_OA) &&
+	    (domain & ~AMDGPU_GEM_DOMAIN_GDS_GWS_OA))
+		return AMDGPU_GEM_DOMAIN_CPU;
+
+	return domain;
+}
+
 /**
  * amdgpu_bo_placement_from_domain - set buffer's placement
  * @abo: &amdgpu_bo buffer object whose placement is to be set
@@ -115,6 +128,8 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 	u64 flags = abo->flags;
 	u32 c = 0;
 
+	domain = amdgpu_bo_filter_placement_domain(domain);
+
 	if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
 		unsigned int visible_pfn = adev->gmc.visible_vram_size >> PAGE_SHIFT;
 		int8_t mem_id = KFD_XCP_MEM_ID(adev, abo->xcp_id);
@@ -690,8 +705,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 		bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
 
 	bo->tbo.bdev = &adev->mman.bdev;
-	if (bp->domain & (AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA |
-			  AMDGPU_GEM_DOMAIN_GDS))
+	if (bp->domain & AMDGPU_GEM_DOMAIN_GDS_GWS_OA)
 		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
 	else
 		amdgpu_bo_placement_from_domain(bo, bp->domain);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index ff11a09034997e..20f4d8c243afdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -37,7 +37,8 @@
 #endif
 
 #define AMDGPU_BO_INVALID_OFFSET	LONG_MAX
-#define AMDGPU_BO_MAX_PLACEMENTS	3
+/* Covers CPU | GTT | VRAM | DOORBELL placement candidates */
+#define AMDGPU_BO_MAX_PLACEMENTS	4
 
 /* BO flag to indicate a KFD userptr BO */
 #define AMDGPU_AMDKFD_CREATE_USERPTR_BO	(1ULL << 63)
-- 
2.25.1

