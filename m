Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B638C7EE26
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B27BE10E427;
	Tue,  9 May 2023 22:17:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B544C10E426
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:17:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhwB00oe18uL7bm/1ji5mmOxe62BG6YqEyJjLmzJITVQZI5MlxS21D/IL2uiHO//GeOUvy+8yHqm1z3ijgpOmW6KKdgBfNZ/srQ79gHPJ2h7BTEvAUVwxM2f5+C28z/NME0E2mZk4Naw2BSq3yEXS5MC0p2ypqcYKih0O0xHH5etuVC7jaXdh8Q60gyYiaowj+3Rwj0m7hO2Kv/deE6Qw+jSS1HUx+WZtKjI5tB84BTrrr+c5MZ9gZc/HQpLJE+Zi/VNw8YQDDA0CGmJPYJTAGAdf5d8zhdDWsWT+zCaJ4WXBLCJtAlwlJ6p2Zf3R2ZNed9fhsfUAmFzP1ANOIEeJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWX/noajjdJ8sq4uRrxvhlsEWbib4UBg40D9f85KdBc=;
 b=W72l9BLQKpBwaAAx4/JBVzCaMJnL50+qB6SeCnsfkih0swx0BqAfcYIyibbGR1Zh80ae2GhBUlk+z1cBEDUv3GfInB+3Wbf1xIVEqJ1+/NekWSVRQ0Rnpnw5ECdF8CAfHVWl4sQc3wRcPxhocP8jdS20eNJf+tJeGsNZT2PzT4NTTtN5bjoHQfx/LE5EK8GMfk1HWh8gfeb3cb/BbJy2MO4jVaeHhvyXs+fJfSKnMmhj/q1pOmjmFIBcWxVzLaG+Lli/RQ0UtYpLYI/LajaFRPu0LkC0qLPYxim4ZUQBZy4UeownJtQE4n94AXQ/+8KHe+KaUZ0oqxkEcMm+t33OTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWX/noajjdJ8sq4uRrxvhlsEWbib4UBg40D9f85KdBc=;
 b=ZKgh2CdjV8up43DDCVuCpyrZqkGVjkyUKQB0CoBCWZ3J1uRbT1byzC1nZkj/duqDJbKgdjAZAxjGbelpe0Pqr2Zg1jwKmIv83C+HVRDovyzazHvinIaiWNF57Do01y7wsFGtDki+S56NiHbnCvkACPRVYk6kJiTkv8xXJBE8vsU=
Received: from MW4PR04CA0227.namprd04.prod.outlook.com (2603:10b6:303:87::22)
 by PH7PR12MB9255.namprd12.prod.outlook.com (2603:10b6:510:30c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Tue, 9 May
 2023 22:17:53 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::f1) by MW4PR04CA0227.outlook.office365.com
 (2603:10b6:303:87::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:17:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:17:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:17:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix unmapping of aperture
Date: Tue, 9 May 2023 18:17:38 -0400
Message-ID: <20230509221738.477282-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221738.477282-1-alexander.deucher@amd.com>
References: <20230509221738.477282-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT044:EE_|PH7PR12MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: 993341c2-060f-4e73-47ef-08db50db3c0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pKbDcBlmnTr53W/+QIE9MLfq29jlyQ3uCRjlk3P4zBYhSbByWAW1D+ffX9Erjfa7pGK4ITCnPKdONeRePApkynVBFgHbdYwAfsB2Vv73p3Cq163NbBA7WPkIWK1mzVZO9ORThADaKAVe7xs7eplzA5XrB/0/LGEeJ1vFlZcm25o1FL+r91vX9yu/Hk72JPtKm9hoyJcHGM3BfJicCEYeTwBSuvpfOE+SF0oJ3ICS6eUWasLpUckVm/xsLm94qrkn6qi+0w+d8jv3Qiytf//8hTHYShLTbsDiRbJIx8QLDjFTmRkV2D7zXqKT1VVDLDVprt4zUNblNpYxzXSYEZNPlydwDiX7RZrKlrWYsbyeZ+zgiW/dkkzMRzp1t61ZW6WmRr2tn1caLehYLKFegXXKd5tfIkP/SV+vZ3Ifn+OwYEPHQzJRAUbj4qpf/zRFkhBiPL/LQBcBzokO0wqBS52HSpINQ5q8KrNj2XKp1kyIjy1xBEBxCIqg4jrCdpteqRoh9ROJ4Nm4zvybX1M3QZwxJElaRaySu6z7hrh66ataJoxQdUTzrbz+2F0NhckfExLpkF8uaKudahBtc7Luz85Q++oKivGypL/MeSr+aPuY0m2PorztjU8PcfX5e/a8a+DylikOu+GFnLxtFwHJDBBBNM0YqeMBMuIxDH7vbm8upB4IprZPK5GxcyzJbI3qIWciagae9fAfdLzrCU4ZSGOuCbDp384lpFqSqAFSu2pHpBmzC9gQBPQ7WdZ+JdXFoerW6NoiPIkpqfgWTEeIFelUzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(2616005)(6666004)(2906002)(478600001)(186003)(40460700003)(16526019)(36756003)(7696005)(40480700001)(1076003)(41300700001)(26005)(82740400003)(356005)(316002)(83380400001)(81166007)(54906003)(47076005)(4326008)(6916009)(70206006)(70586007)(86362001)(82310400005)(8936002)(5660300002)(8676002)(336012)(426003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:17:53.6926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 993341c2-060f-4e73-47ef-08db50db3c0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9255
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

When aperture size is zero, there is no mapping done.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 7 ++++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d1dca02860b2..5d62e0d5cc11 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4120,7 +4120,7 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
 	adev->mman.aper_base_kaddr = NULL;
 
 	/* Memory manager related */
-	if (!adev->gmc.xgmi.connected_to_cpu) {
+	if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu) {
 		arch_phys_wc_del(adev->gmc.vram_mtrr);
 		arch_io_free_memtype_wc(adev->gmc.aper_base, adev->gmc.aper_size);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index a5c4f98f8cd1..c6214db42bda 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1080,8 +1080,7 @@ void amdgpu_bo_fini(struct amdgpu_device *adev)
 	amdgpu_ttm_fini(adev);
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-
-		if (!adev->gmc.xgmi.connected_to_cpu) {
+		if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu) {
 			arch_phys_wc_del(adev->gmc.vram_mtrr);
 			arch_io_free_memtype_wc(adev->gmc.aper_base, adev->gmc.aper_size);
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 7885162b7368..254927c596ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1848,12 +1848,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		adev->mman.aper_base_kaddr = ioremap_cache(adev->gmc.aper_base,
 				adev->gmc.visible_vram_size);
 
-	else if (!adev->gmc.is_app_apu)
+	else if (adev->gmc.is_app_apu)
+		DRM_DEBUG_DRIVER(
+			"No need to ioremap when real vram size is 0\n");
+	else
 #endif
 		adev->mman.aper_base_kaddr = ioremap_wc(adev->gmc.aper_base,
 				adev->gmc.visible_vram_size);
-	else
-		DRM_DEBUG_DRIVER("No need to ioremap when real vram size is 0\n");
 #endif
 
 	/*
-- 
2.40.1

