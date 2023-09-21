Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF42E7D0AB
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Sep 2023 21:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD3CC10E61C;
	Thu, 21 Sep 2023 21:40:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3A0710E61C
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Sep 2023 21:40:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5pIgDR/qKd4epl07up70q9rQKdr8XHqmXAK4Iv1rnME9xjGff7jwyVfMchPXGM+ahqkByV/3v5MNKGg42xIZTSsRpobEal5LDs8ESuPJ3Kwxr30+JiZUc57gaKW2Cy8JJC8Jkh8NoB67HgtkuVf9cZNjUlHa8Cb7E/EdyauqorX2pY/mt6FUSOyRdqzyrv4NaZV1a7+SbLwzUyasuryuoRZ87HlOrAxCpwB6Ub1nhE0orM91vH/mf4oDWjRPU47F6OWJSQ1Mo+cQrAfI7+sbkhPksBitrgNiwx51Fakmg3LVbm9lbO9L2cRJwTNSNZ5TGqsnFfyAPe4zDtJOLP/2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dwo9Qps1nYSZZmRF0s+1fDSYvWttO8z00jKYml5v+Aw=;
 b=Bc3N/lBOP9EuQ6z7nrTumY1tE29bfdNGiPaxKbsal40XXXb4fvbFX79KkZ3lQxBREhs7BtEglq5DKkM9nXAa7CX/oi684QbLvBQRTjsGDzPOLI1D7vpcCSC9Cdl2zY9h8jK0HJOL5I12Xuf32cIbpgBEImeHqo7FyPXs3aVc0K/nlwVmHovzhUz4Ol8xI/bBKxzyZ6Lao8+lCtCnVtZEdqLFJYWxCohm61dIpqGIBo41i+RJ5OyxT/NYE6i+ewBBhb1cWJjeecvn7+zcvLHeMjk/eROfp2C/soFdWhErQrOaCUmZL1ZkPL0aq6sw5/tb97B3F1g5zaQ5Nzyd6C5/nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwo9Qps1nYSZZmRF0s+1fDSYvWttO8z00jKYml5v+Aw=;
 b=Gp6PNq7CPohVSoXcHrZiaJKqekPtLBUoUiaZJA3rdUKLcYaI29bmEUM2LEchkh1Bg3paYlDKTkHKpOw520qysMtke8DbUeTweqXu2Z/3zzFH7BjZgRBLFR80QmyTSrBQxsZgXZmSaDivofRmOeWlXVUfbuqr++e91PU0QtDlAXM=
Received: from BL1PR13CA0314.namprd13.prod.outlook.com (2603:10b6:208:2c1::19)
 by PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Thu, 21 Sep
 2023 21:40:34 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::df) by BL1PR13CA0314.outlook.office365.com
 (2603:10b6:208:2c1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20 via Frontend
 Transport; Thu, 21 Sep 2023 21:40:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Thu, 21 Sep 2023 21:40:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 16:40:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/gmc: add a way to force a particular placement
 for GART
Date: Thu, 21 Sep 2023 17:40:18 -0400
Message-ID: <20230921214019.926691-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|PH7PR12MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: ed88e43e-e2cc-4da9-12ea-08dbbaeb62bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J6zIdm5zxTaAeT0/GihpisFcuy0tpBPWUe5FmCX/vp4yXqQFFHXtWSMSo7XntK91L5fZeZZ2Cs+2CrK/X52yvMejuXQm8V4fBN9X/E7NLRgAatqTOZqYYAz1ctY051jbX1QSYLW+mdYQ/dQ2PQZ1cgfyIXdEmjLPtesUhGADk0j92Jt5OTIqua5xYF7FxX3hKQEq0nA7fBIRoM7NxkcrwVsA4YVN1S5xlmjC0bd47eYek84V2HSjQVn7XQDjze9MvRLEL0JJJlf/IJNREXQ+mu/sObwx9l2zt8gL0Y4YYC4irNIWNlviO33fxSLdiqPLHP8A59uiuBhDHcDgfH0lhyzN+tcwUZGV8kE572spfP7IDvyD+kW9FkN/qkt6FlMFEf8hVRD1A+HMFmrmfkD8CwS65X/qzCvSkg3KnvK6U24o8z94yfZrNDX/HZVZJp6tiGbf7gaob1o3DHmCcQA2/oAMwCf4tl/s0rlP2+Nz0Q1PBN0jRU1sBfQ4Bwa6DcEC8ZDTAkuUmd4ELQcCWIkvIFDajhMZevylMTPK+Bz59QptK3SaO6byPTYWg3FQ+9KMyeiqbtJ8up5Yc26jhHaiR9NxhiSYfCqdvs2HwAcoSWoU1BsEUvqx5XRpuVN0kEPa9yyY2x7ZrAtLaj7z/G0qTjwfl8JtJKS1+X4y5NPSD+0yPmbKtD9CwsCd9YP/rgogUg591RIdRs/BspCSCiBjwWprDYN5Qh7LCOQdbJKBBQgqdgiap00kW1ajjHZOZkxcIE9cQTosJ0ztbO9oBsLTcSm60AlFPWQkLWcxHQsuIuxVchN4UJK0RPEC8Xj9rG9iYRi+8pQPhFqg1tNyP6FHAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(1800799009)(230921699003)(82310400011)(186009)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(6666004)(7696005)(478600001)(8676002)(8936002)(83380400001)(70586007)(70206006)(6916009)(316002)(5660300002)(40460700003)(16526019)(2616005)(36860700001)(36756003)(82740400003)(4326008)(86362001)(336012)(47076005)(2906002)(41300700001)(1076003)(426003)(26005)(356005)(81166007)(43043002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 21:40:33.9383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed88e43e-e2cc-4da9-12ea-08dbbaeb62bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6393
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We normally place GART based on the location of VRAM and the
available address space around that, but provide an option
to force a particular location for hardware that needs it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 19 +++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  8 ++++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index f74a51a93ebb..d1d98488373b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -287,11 +287,22 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
 		mc->gart_size = max(size_bf, size_af);
 	}
 
-	if ((size_bf >= mc->gart_size && size_bf < size_af) ||
-	    (size_af < mc->gart_size))
-		mc->gart_start = 0;
-	else
+	switch (mc->gart_placement) {
+	case AMDGPU_GART_PLACEMENT_HIGH:
 		mc->gart_start = max_mc_address - mc->gart_size + 1;
+		break;
+	case AMDGPU_GART_PLACEMENT_LOW:
+		mc->gart_start = 0;
+		break;
+	case AMDGPU_GART_PLACEMENT_BEST_FIT:
+	default:
+		if ((size_bf >= mc->gart_size && size_bf < size_af) ||
+		    (size_af < mc->gart_size))
+			mc->gart_start = 0;
+		else
+			mc->gart_start = max_mc_address - mc->gart_size + 1;
+		break;
+	}
 
 	mc->gart_start &= ~(four_gb - 1);
 	mc->gart_end = mc->gart_start + mc->gart_size - 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index dd0ede75e5d7..fcef057b9213 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -199,6 +199,12 @@ struct amdgpu_mem_partition_info {
 
 #define INVALID_PFN    -1
 
+enum amdgpu_gart_placement {
+	AMDGPU_GART_PLACEMENT_BEST_FIT = 0,
+	AMDGPU_GART_PLACEMENT_HIGH,
+	AMDGPU_GART_PLACEMENT_LOW,
+};
+
 struct amdgpu_gmc {
 	/* FB's physical address in MMIO space (for CPU to
 	 * map FB). This is different compared to the agp/
@@ -339,6 +345,8 @@ struct amdgpu_gmc {
 	bool flush_tlb_needs_extra_type_0;
 	bool flush_tlb_needs_extra_type_2;
 	bool flush_pasid_uses_kiq;
+
+	enum amdgpu_gart_placement gart_placement;
 };
 
 #define amdgpu_gmc_emit_flush_gpu_tlb(r, vmid, addr) (r)->adev->gmc.gmc_funcs->emit_flush_gpu_tlb((r), (vmid), (addr))
-- 
2.41.0

