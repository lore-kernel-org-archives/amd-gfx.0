Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45470EEAA75
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 20:23:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8321C10E1D4;
	Thu, 14 Sep 2023 20:23:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F69010E1BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 20:23:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nigU3+Vt2mqfVVLZCqJ7O/2Y0y/w1HkmHtwdmvZbjTSQoG3JhU8StGDR6ut7i0+zp3QnIDulfQ78nPuhtMIAj+gfxv0d8jDhMI3E/Vrn21ZKFkhISbMMqsL14U3AasAMAMQp5Ei5+Z1Krf1KS57zNmquEZ0x0RC42mhrvknHQgl9n+tJCmLX1ZjFebuOHAnUGiPSvMI+Q4/vtkuWr3UHdgeax57YzIWGhhvWyIRxBIDSWccSyV3FllpsjerF9lOs4Cx3L/3cJbbjC1m7R7qjVlqOsLCwXMMHDwIE0Ic77Ij6AURTwKfUx22O8mq0zO93HInZ/8fBliU5sLkYXzjNEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAsZ/B8lTrWnlRB03y3BHCOo5Nx/4OpyfjfoGQ5rzaY=;
 b=fTtfEHCoTme/G2H1Etj608HcZxYkjV6Sf8RLk4dFW/NtCNtxt/u2VevLxbq91bztW+NQ7riwd4ZKxTED/TOBVe4yMPEHSGcqpZyAyOn8KZPyMxKWMPXrTZSiV1/UlQD816OjVu8e+pIIRMICbpnzRrqA3FqQCiC3hzZbYrnIPfYryit3vzKwENs7FDCGnvouSJ7VpRP0+POB0zrxfy92LZ7Utxzts4cq8QxF01erYxfMdo5UM7mKNglWbc74CKjea2TByt3B9aXffFYVnXiPduVRWWKlXgykfgz2KG7oD2qS8vAAq+2kGfnjrb9WQ3ZifRwl00lVA0B59zh+Ea1S8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAsZ/B8lTrWnlRB03y3BHCOo5Nx/4OpyfjfoGQ5rzaY=;
 b=IvuZ2Hb78s9ptYNggcbbfkQs6ZmBoTrUzot08Mm5v5D7PqELACVZ1KJvkOn8TgfKPYF0Jc2Nq+j26uOajKF22U7VTpirJ2s9Sn+xUv6ZuUijI6dCkI1ZM7GA0443S4RfCgc3yaOqmLrCi0puIKuXVlUgPIIKKTTGdlyC+piIcjI=
Received: from PH7PR17CA0015.namprd17.prod.outlook.com (2603:10b6:510:324::26)
 by DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Thu, 14 Sep
 2023 20:23:18 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::8) by PH7PR17CA0015.outlook.office365.com
 (2603:10b6:510:324::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 20:23:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 20:23:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 15:23:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu/gmc: add a way to force a particular placement
 for GART
Date: Thu, 14 Sep 2023 16:23:01 -0400
Message-ID: <20230914202304.695340-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|DM4PR12MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: c3302454-4ae3-49bd-251d-08dbb5606e72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ExhYDMVZaBZqv0jRIAsI+buhR6HoMjdCsQJSy/7lcVg+kCMRDZcRs4kk1mhkK/OIt8ec/osqSXifQQ+IKRETaACEXK+yrKqpaayjuSenmMLgSCTx4noIytKCuX0gjUNjGzyMPafKcrxH868Z1ZZb4/JcXYLsWU5L+QgbxfUxd/xAxaak618TNYFH9O6S7gBRHZUOdUBLZNxroeAHOBN6Gi52Y0050hBjZRzbMKu+nHGrAkhndOpNLH6OiX/5o2MTRBOgO2NNFx1LcGv9VVVGPiWM4rfV9hOq/ywPmnmRfYZ9zCkAGz6+OZN8tCg+btzR4keYkEvyfgQma3BnfMzONMr/l9fGL3oLxZ6L154YnW43Bo//BYcBnJY0phnmm8jYPg81TltuCMMTHEafy5A++1A5Wg6odP3Ds9/NY3SEwVj6Hn95XYiTjrJBAwxBGzESJbP8Ez5unp1lyWAJQDzWQxv8sdk/kXWY+XvSJeb9WGE/VP56lLNVynJpjohgAKB3SUbMQ+5MWpoOAhTE7f++kL+SxrhglyqDrAgXwR2GwRyJq8dOvWCfA/2bbbVkvrnwWLlnkbZddfbQuj6AkIWH5/6D1xWng0/i416zRSdsUHSZCgKzu3SvA9AyA5Kj09gecm89mJ8bZGAqZaWT8ixMV1nmQIta5IjpwX+9kbO8iZuqHnRKoieAvy6+8g7KXp9syYrWDeFTu1YDLD0ASfOUGvRKHl6BYpQDDhwBlUnTfDgCVI7AmVm0ErW4nQW7THUjVJQ7hN0xQeETQ87R9hszQuua1af/pb6s2kuPzm+YuPY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(82310400011)(451199024)(186009)(1800799009)(46966006)(40470700004)(36840700001)(40460700003)(5660300002)(36860700001)(82740400003)(356005)(81166007)(2906002)(478600001)(47076005)(426003)(7696005)(83380400001)(6666004)(2616005)(336012)(26005)(6916009)(70206006)(70586007)(16526019)(316002)(1076003)(86362001)(40480700001)(36756003)(41300700001)(8936002)(8676002)(4326008)(43043002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 20:23:17.6894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3302454-4ae3-49bd-251d-08dbb5606e72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  7 +++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c7793db6d098..c41321c456fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -286,11 +286,22 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
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
index fdc25cd559b6..caa15639d3d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -197,6 +197,12 @@ struct amdgpu_mem_partition_info {
 
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
@@ -333,6 +339,7 @@ struct amdgpu_gmc {
 	u64 MC_VM_MX_L1_TLB_CNTL;
 
 	u64 noretry_flags;
+	enum amdgpu_gart_placement gart_placement;
 };
 
 #define amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, type) ((adev)->gmc.gmc_funcs->flush_gpu_tlb((adev), (vmid), (vmhub), (type)))
-- 
2.41.0

