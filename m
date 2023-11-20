Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E7CC2BB3F
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Nov 2023 18:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4822510E103;
	Mon, 20 Nov 2023 18:49:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8735F10E103
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Nov 2023 18:49:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fz7NpRX8wphjbsJrzwUnBdk2VC2CnURoubaGAYlEahcyIRr2MYO/8mRdh4+jp5pywo1YU+9sAyuuwRLuv7c+Qv7QlrOy5fWLydBZjAIJPEyvWqSgrFsypKYCqkbzg81is3co+T6lG4uEEoQ/Y1VXRliLGErKtNN7VWbxzSdXawkngKWatc5eVffWN0jK5jYT1ss1qnlg5CxdYrbtWxjQawEzFflpk0MdaAAUGSUiHS3xypzWO3gZ1MTZ9tsdckpDjSlRQ8EsWQGsh/074WnzjJhaHPCHCEACg2qJ1jU4oGqooXnwp/4ydaTRVjrMbNg9TLmxyxLcbLw7nXaU4AJPXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7PB7l3yEfKpEXJh7suJxlIJ+fPSDBeHui6TYAsgRjc=;
 b=SUqxv8QGHVumfonVZo9Ul723Ub4XVlTy3A2Ct18ioT2RedWkOJGgohU+1kwjeeFFqICGW1cG9Relc6hcuTOvAGb3XmBfr6U0abZaNkbTjjO7tSKfQvBJGgqawE9U36HpbvPlgD+6i9yA12ztgJSnzsBP8BB1JzMo4qrnOTDHfM/daTI9ewPSkiH9eNOovzEGG7bXXbLnVazXf/S3NIBtawKSZtgFkKd80HwgjERUgUSACXF1rht027tmZEG1oHO17vKAMnUEPU15TVSPYQ0FCPDpqnlnb5BfOiOw3Nstuacqbrrj8ntHhiqX76D2KLGrb3AVcvh7tGKqh9kJEWbMnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7PB7l3yEfKpEXJh7suJxlIJ+fPSDBeHui6TYAsgRjc=;
 b=BE5TX6S3/rYrU1wAByIbzYvJnkD7gJx72bDgoRHRY8g3JqOoXAMLiq9YFRPrX0KcOnfu6M4yReuwuxmsQvelD2Mup1yoKbn4rH8v0GQmFN6XAnmzviIWkT27Z5qeHzRtCvUSxQ6q27aqFyWhCnUvBf4i3tb9S12YLaEn6rJuCXI=
Received: from BLAPR05CA0017.namprd05.prod.outlook.com (2603:10b6:208:36e::29)
 by MN0PR12MB6004.namprd12.prod.outlook.com (2603:10b6:208:380::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 18:49:41 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:36e:cafe::e6) by BLAPR05CA0017.outlook.office365.com
 (2603:10b6:208:36e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16 via Frontend
 Transport; Mon, 20 Nov 2023 18:49:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 18:49:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 20 Nov
 2023 12:49:39 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix AGP addressing when GART is not at 0
Date: Mon, 20 Nov 2023 13:49:20 -0500
Message-ID: <20231120184920.24597-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|MN0PR12MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f59478-1859-4fd7-bc71-08dbe9f9743f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cd2d1TZuPqnBYQgUjdVt26d/x6HgWVN0xm4i7gJlFiqScp7yZdyB8QibvQC7yXLXADmyneIUpk/SbBEGg8CyW1LDpBTmRjkBdgWY3dEn6dmfHM9K8uiBPyb+cMssQumUKIL/i19IFG3cU2IRC47JtjbS70PIj2wqkV2HbGmIM5qiNBWUBFsiSXP42eDtd23A+Hupr3GYfdFpNVr3HJvSUdqKOJDAkP3z2A+9T20we35YJPRgRM3c9MSFb47NLVcHb4oXzHQoKyvWJonFCbZuP5a4zx7kVUoOm/9JBcafxMRpSFiqFr7yauRLYe8ASC613NB0AB4wHE+zAjGeAlgVy7pHcorf+X9Ifh2L/ioDFkAj4VPtOcliR5c4kSQ0iC/M5vEHm4VeAgaaIlAdzkBoUDcaODmOMtcS+dIMMT2wSXf4y++RF3il1xek6v7haFeGeRG3lM+TQwsXHnJ5gSeGlmhRN7lLEhqg9SfPE1cZ+okWkpiwxFKaf6S1AH/HLLsFufbq15ZnjxHAahGnj1z5RheNR9TQbptww/0AzDtEHO2GdwOjC9s77J2z2Heafz4oAk1xWUxW9QQ7kAW3Lm/yjIErJ/tAAMz/bJqT/X4FYLZ51WyYgrWtiHQX/pWkzknFiZScDsROuvQWTshlsXeA6APbK6HEhcu5kmlJe5+FSR7WHIrLijzXRJgga6znkkKFeRPb2RDylD/z0419bGzUvP+vYuRzG/U2MlxlfDD6HttvkL4gOWoiulzVfbu3y1weRWRxEg1dN1lK3D7liYDKpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(82310400011)(186009)(36840700001)(40470700004)(46966006)(356005)(81166007)(40460700003)(47076005)(1076003)(16526019)(26005)(2616005)(36756003)(336012)(426003)(82740400003)(2906002)(86362001)(54906003)(5660300002)(70586007)(70206006)(316002)(6916009)(8676002)(4326008)(8936002)(7696005)(6666004)(41300700001)(478600001)(83380400001)(40480700001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 18:49:40.9207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f59478-1859-4fd7-bc71-08dbe9f9743f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6004
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
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 mario.limonciello@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This worked by luck if the GART aperture ended up at 0.  When
we ended up moving GART on some chips, the GART aperture ended
up offsetting the the AGP address since the resource->start is
a GART offset, not an MC address.  Fix this by moving the AGP
address setup into amdgpu_bo_gpu_offset_no_check().

v2: check mem_type before checking agp
v3: check if the ttm bo has a ttm_tt allocated yet

Fixes: 67318cb84341 ("drm/amdgpu/gmc11: set gart placement GC11")
Reported-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reported-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: christian.koenig@amd.com
Cc: mario.limonciello@amd.com
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 +++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  4 +---
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 5f71414190e9..d2f273d77e59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -181,6 +181,9 @@ uint64_t amdgpu_gmc_agp_addr(struct ttm_buffer_object *bo)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
 
+	if (!bo->ttm)
+		return AMDGPU_BO_INVALID_OFFSET;
+
 	if (bo->ttm->num_pages != 1 || bo->ttm->caching == ttm_cached)
 		return AMDGPU_BO_INVALID_OFFSET;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index c938648de853..c24f7b2c04c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1538,10 +1538,14 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
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

