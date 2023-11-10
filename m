Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55A0C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 15:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AE8210E0E1;
	Fri, 10 Nov 2023 15:02:33 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E19A210E0E1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 15:02:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cB/rFUWSMGJyIq6Q7mIevD5VBTxqnBNCS4WDLeiF68aa2+/CrBs622Y2P2JcgPhXKuyiBFPIauOKEd5owWfeiuUOi5PbIW974XqFtd7+rHvBu0M/gBEaMhOydMsQG+zisEF+pLxo20PdkiSI25BhZxcZVarYuNjTKwyS5w/0B5UeF8IxW5xzUu8KyWztiKlVnB9C4+565HrRVRdIrbqKdvGAHUBfpkgH1emuLtzhfmeDzaSi6G+e/zF0ysm5jsNVu6RVPec7vYxRh5tCCpzeUYBd0rwQcjBWX7GBdGGOEJDGPhy08nRby9NkHY8ou4HtOpkrvwqmkBYO0BlrsKzYxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8o9aQOg/19QbfG8SXcsRuIBi1bM/I3QApH3ei5mUbQ=;
 b=KeUWXbvc3ZpIqOWO0ofM02x8OiCxKLKQqLayEO0IyCo0W1WRVb07FAjrHueV7FRYIkO6BxsY7S+D0+Wpo5Jvud6UGEI+Oj7/T7D6lHNzI8Hkz307dL8mEOvAfNiVY+PZJMunmcm2z04NqRdLHZvpznMyCGuS1ul8ijuvd2pUeUCd+Wakrl2m398ICwW/6nsO1tcJVCWBkTC5ur1UyZ+g2N6xCqL6z92uAurJiYf6qcTt2I24GFn+hDd9hLLMhaxolgpFzwKplGXqYEryAabX8Mj1PQDIVs5ML0y8cp/4M7ERnhjSuXXAcpbeDeWHF2DbHwAnyKyqOJR6zgzJMq/w9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8o9aQOg/19QbfG8SXcsRuIBi1bM/I3QApH3ei5mUbQ=;
 b=LTQs9y4DRTd8ZawxhymUGAF9mkcnskT4bw3NSLmW7pW+SpKHSotBJNOraRMPq3JBf1vJHqSuxhrAwFun4bCS12MJCEqsHvflPCYG59R/ISKyWWwln1bfzy79J82ujr7/tAjwPpPS9smWMS7euAB/i/NP2k+bReLFZPoXz/8ysKI=
Received: from MN2PR11CA0019.namprd11.prod.outlook.com (2603:10b6:208:23b::24)
 by PH7PR12MB5654.namprd12.prod.outlook.com (2603:10b6:510:137::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 15:02:29 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::d3) by MN2PR11CA0019.outlook.office365.com
 (2603:10b6:208:23b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.21 via Frontend
 Transport; Fri, 10 Nov 2023 15:02:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Fri, 10 Nov 2023 15:02:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 10 Nov
 2023 09:02:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix AGP addressing when GART is not at 0
Date: Fri, 10 Nov 2023 10:02:06 -0500
Message-ID: <20231110150206.1900871-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|PH7PR12MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: d693a486-0a33-416c-54b5-08dbe1fe0eb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7AHLM9PLDQOv4puTbcGGzTBg/DG01e2NIt3qJyPAtdmqNgBgpuAqj66Ji77cdUo83iBvgHoMDSarVggkIHy0krn850eu1LCXqvKfaeHzmpbTSHZK8synFGZsnV3+JJEdGRWMWO4PbhW+hrOS7VX83CUPMK7leiAs3dmSVDB5XaA9v0cMoR3ogcT0STV/txZ7zwqbAGtIFYP/gYWQRF132HWl2xYkKnBKR8TAJR9FNZrwJmNv+6I/IRBVUfl4ExjOwM2XbcLPgM8svfcBljyzVaauP2mO/fmCtMye3ZIioyJK4B+4yQr6ZkJc75VOdYTZBpR+9Yujyvp2x8tQVtR+98tLXooNcgYzDaa5LJVXsi50j9HMBIw/Ns9h2yougj/k/VBahLGwF+pCfP6dal2QlwKr9ZD8H38WV9smn3XIdu6yMBzLVRgeDTsJm0k/6o/YcMbPk81Q6S+wodhwOXjxm5YaNMU1yNKXK6PEyC+ST8ZzlhgmoYRFvqpMzPrbw5vI96Fa//bI4LGyI9qZYqb/bNp+2+dSPteuWwBlM3zM4tKoOxkFR9R/FGhLZIpn7tDfGg3e+XZo92reXW63Z6dyAl7/lmM+zTCtMJ8p3pbFQtjCdmEjRIhsrtmkvEh0Jpid6z6paJ3b8yVvYnm7a4SSP/JZFfN+VqDogVC01Gfes87QPKRTYP5gsvf9+EFrH3JHaNKhC7LdQ15Awx+eztRZiGTl59NfH0Nm87hdWmykV5ODwmROhXZYFsaU+ypQjcjPnTdUrf3v/H9xP2h1he+0EQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(82310400011)(36840700001)(46966006)(40470700004)(336012)(26005)(16526019)(83380400001)(47076005)(36860700001)(40460700003)(426003)(81166007)(356005)(82740400003)(41300700001)(2906002)(8936002)(8676002)(478600001)(6666004)(4326008)(86362001)(7696005)(70206006)(316002)(70586007)(54906003)(6916009)(40480700001)(2616005)(1076003)(5660300002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 15:02:28.5642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d693a486-0a33-416c-54b5-08dbe1fe0eb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5654
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This worked by luck if the GART aperture ended up at 0.  When
we ended up moving GART on some chips, the GART aperture ended
up offsetting the the AGP address since the resource->start is
a GART offset, not an MC address.  Fix this by moving the AGP
address setup into amdgpu_bo_gpu_offset_no_check().

v2: check mem_type before checking agp

Fixes: 67318cb84341 ("drm/amdgpu/gmc11: set gart placement GC11")
Reported-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reported-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: christian.koenig@amd.com
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 +++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  4 +---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index cef920a93924..d79b4ca1ecfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1527,10 +1527,14 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
 u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
-	uint64_t offset;
+	uint64_t offset = AMDGPU_BO_INVALID_OFFSET;
 
-	offset = (bo->tbo.resource->start << PAGE_SHIFT) +
-		 amdgpu_ttm_domain_start(adev, bo->tbo.resource->mem_type);
+	if (bo->tbo.resource->mem_type == TTM_PL_TT)
+		offset = amdgpu_gmc_agp_addr(&bo->tbo);
+
+	if (offset == AMDGPU_BO_INVALID_OFFSET)
+		offset = (bo->tbo.resource->start << PAGE_SHIFT) +
+			amdgpu_ttm_domain_start(adev, bo->tbo.resource->mem_type);
 
 	return amdgpu_gmc_sign_extend(offset);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 05991c5c8ddb..ab4a762aed5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -959,10 +959,8 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
 		return 0;
 
 	addr = amdgpu_gmc_agp_addr(bo);
-	if (addr != AMDGPU_BO_INVALID_OFFSET) {
-		bo->resource->start = addr >> PAGE_SHIFT;
+	if (addr != AMDGPU_BO_INVALID_OFFSET)
 		return 0;
-	}
 
 	/* allocate GART space */
 	placement.num_placement = 1;
-- 
2.41.0

