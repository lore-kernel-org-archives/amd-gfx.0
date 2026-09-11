Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8CAC88E5B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 17:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F37AB10F6B0;
	Fri, 11 Sep 2026 17:56:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ee3wIDlI";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C1C010F69F
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 17:56:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9OPojFf1A9JYAUDJP4a6E61Cyk20qXcQ+ZaFnWd5IgM5/nZsFss2zwFNUytkVM/cblu1Sc5oUwpfSIcA088nVmatA3/4cuX/0L7SgvRfoCZSPa651d03arayb3jidBXwFO/lOMWJNyi+aZs8T16X8tQyAo22m+et2ZMLDaUXVrRvwl13Eb149Z3CPSv6oSaZjqZo5pae5Evt1IjH/jLM2LEEaXy6qsdS6RpRxK1vZDgm2Fj8FAjD1Raxpx0j1Ti9tPhF14uMkUb/LSRiCVVlxwHKuTw5npxBRcoh7i4jl8O6t61KtJVH2mNKByhj/+bL9F5FsVfuW1zIVjwE9zJhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PGu2SzvjDXU2inAqkJEl8sEs+wnAQ36XKBQC8rD6NE=;
 b=ZGMuI2ZibQrQjMCYr35Jy7Fmmks781d6g5ivV2TpEz2Q7vOXAOyEi26B7qfmFO9FCSlpt3MIAkeyV2xwm71FI/+81KMnioj5pNXjM4TCougZxng1UcLMdPzZpw3br6GBw9iDRaYKwIqh+HQ4G0q27UobrnjNUfxVQbZ8g5x7GECx/M1EZCqY2TapVlPcKiDLCoyopFXW0DzyDTRNFtRgglDXx6eRgdEK+hNQsCMGiojW+mKLN3HTdp/4FPOO6xAzrs1PQaYJ6B8Hijea/C0nH0Pa9yjMmqVGF765NrkOp33/lXv7CBK69/wmyob/GC+PDRoFOFy63q2ptI0ZyXOxxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PGu2SzvjDXU2inAqkJEl8sEs+wnAQ36XKBQC8rD6NE=;
 b=ee3wIDlItw9ZLaWFg+PzEDxypHd6B48Xs5bldVZv8n4kphow26TGpkF7NMZTF7no5InVHNniU5tCMCpIHYSjhQLNwTrnTHsMtQPeArlIVyG3mO8lxQBXPR5eUAwtMlMLKCsTPeObsbfmH28E2gsVWADt5akrMwiiFmmoO5ldVa8=
Received: from BN9PR03CA0175.namprd03.prod.outlook.com (2603:10b6:408:f4::30)
 by DS5PPF2FA070BDF.namprd12.prod.outlook.com (2603:10b6:f:fc00::649)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 17:56:11 +0000
Received: from BN1PEPF00018071.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::a1) by BN9PR03CA0175.outlook.office365.com
 (2603:10b6:408:f4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 17:56:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018071.mail.protection.outlook.com (10.167.245.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 17:56:11 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:56:06 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 12:56:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 21/23] drm/amdgpu/gmc10: use SDMA for pasid TLB invalidation
Date: Fri, 11 Sep 2026 13:55:42 -0400
Message-ID: <20260911175544.1314467-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911175544.1314467-1-alexander.deucher@amd.com>
References: <20260911175544.1314467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018071:EE_|DS5PPF2FA070BDF:EE_
X-MS-Office365-Filtering-Correlation-Id: b7668b98-4c8b-427b-e542-08df102df73e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|18002099003|10067099003|11063799006|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: SJUsqopeXSkcpIYpI7mkZl2d0Q/CkkGIYo9mN5cuHfIu0FjiFry5ux6xI8KnnbiANb9VVZmaNCOp0B4dVaIEpgzZewkLpGYgv7jBFkYpwoY/oRBvs5OxiVaFz5Dgid3deENnEpZFE07nFmLYMlIPM+j+uYegdU0qV0NR4b/i1880OL4MEYJ+n3nEUuKud378LQHHZdZqVirq8pzw43oC6RZkd8mkm2KIuNkrXFjwZ0BmqlA13VAFfYuarlMy8dqXxRDZeSEkFrNXiIIpvs01eN+jdu2PqHgMdJOw3aWqEcoIwZb9LXjJPyO6uU/DNDNjrHbXReMmsCuSVWGNCCXvqagRfyN2nA6Xh+f2WW58MhvUJxkDvfn6MrZwve5bgvguyACk3W974Q6YG7qifZfG+7l/6BuUE//mc1AI7M5Svu9SkfFSHzTpy3eAlnxzLhxpi/sJ5IqhZMl22wV6H5zWwAGAL4gUIOPaU6xQKgt6RWJN3FDpJwpG/D1i9PKI0SLX+obSxQN/jDRT+uQRHMvVHZhYxKbxv96hpkYpuVK0fkEsIv3XJZ4VXvnPuN387pMKZ77R1EyvBB/dBLfUhBqLCSSqlEnqQbuLXCuHqAcci3Ey3DIGXcZGoZbdpVHYEH7J050X7p+7Rs2ekW8pSKjIoyPOGJCf9tr7JmYC+HxvfNXCFCrw6vPjzIvlKReKqWyqPrxyr+3dXaFBMBIDUbPUyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(18002099003)(10067099003)(11063799006)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YxudZoU5t070heuezWUfi6QRyVOYwNBDBreNbTaCYLISnCV9V+nAXRIuX1Y8R0mHrhiN0NsL4rDbI365BFoEBd/kBkD1gEYDfD/8RAt2WAZBXg3oGdZQ1NwlMrWo//HI4+GtolPT8qBRdyUAUozY9jPjs4oVY9RrbzP2PK9cZv1vVA9wm0/svunwBYSk2envHvgiTEmqQfcgsmgqZGgyw7BQvh4CZAF10v3ZT1mgIAezpUSVxLdnQy81FwWCJjXXvrMwihQjA0WwgDNmrc6KEMH2URNLlHrK9nIeaGQUITl1p7ncnka2HEZH4R3dpYOt+fdhmdqysqGQySSllWjt/OMkKdAp23fXnqMZhCYsLOFlm7BBongZzo6gtucC/0PsTQCFUQsmArV4NXSxWZ5CZhNFsHREfYVLX6roi3v1W3t9OJdkd8UgWiWuuGkbrJ0k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:56:11.7176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7668b98-4c8b-427b-e542-08df102df73e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF2FA070BDF
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

Use SDMA rather than KIQ/MMIO.  This is recommended by
the hubs team and aligns with what other OSes do.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index fa0fc4dc724c6..7899c92dfa122 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -786,8 +786,7 @@ static int gmc_v10_0_hw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 
 	adev->gmc.flush_pasid_uses_kiq = !amdgpu_emu_mode;
-	if (adev->gmc.flush_pasid_uses_kiq)
-		adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_KIQ;
+	adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
 	adev->gmc.gart_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
 
 	/* The sequence of these two function calls matters.*/
-- 
2.55.0

