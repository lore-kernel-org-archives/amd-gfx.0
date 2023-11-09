Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A44C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 20:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AF7C10E916;
	Thu,  9 Nov 2023 20:51:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0733910E912
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 20:51:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQVNm2VakmBbumJGS7YoEeWvtUc7AbFKj9BoAS094V+Z/V2rq1q+wqx9udMn8qVQlwEyjfSj2OOEzWkAxSkV92y4C9823h1N9jkRKQoohk0KgUZtVEOJkEI250t5nrH3u3KbpfhLnuzScVN6Gt3Ie4YnIlIVARQY03vs/a19xaZRK1o4PlRqZUE+chNt8E8Jm3Nbeovgu2Xgy19XlkLILLxbJgiy9HHPVLveroHJeMI724sissOookuxXh2FSO3ZAlJ2wbiELbOtPRYYoeGAwajoOEpg6pBf94m5V25FbOgNEHhF7TOtBXTGFoh7jv6vTTHqhYJg+6Z6datjvLJTXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lok/TX7mgJNAI3KDVmHbTuXozSGbBDX3vo8f7hWJXYA=;
 b=XWauPliFUmXxdpPUuRJvatFD7vby70KTMKd9u9VWO6nqVnNc3S7D8zYabRRouCTmP8H11mKGBLZKXDFZQsSVz6mASJkVe1VT+wXI9yBFU4mNT4FHAX9SzG/5Gk1yqamGaXHLB1qXrwwRQlHRzV1yPo04Oi/C4/vGHH8pNUyiQz6drE66ioU//nXVtRyHTta5G6b3aejYtp3WY8ctwT2yOd8ICKS1mEvEO0tsUSIxp+ZA5vxnSrTYwZzgUZZWYtF2VqQN8m8KjXcl+OUkx03QKXEWXcI/EkCCKCGw+Z27753AubsKm+nKM4MDUqQt5+vTregYLm39vIqOX7Mhr2u0Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lok/TX7mgJNAI3KDVmHbTuXozSGbBDX3vo8f7hWJXYA=;
 b=FJ4EkkTLOjiTKiJLuc7U8RgD9BFCexVYXAfmg0Q8YXJnT/lzR4VUKBSQgB9AK8A8KKSk+wulOd1rl+zIQeFdFYkn5cHWMITGBbGXMW03P35F67GN/HlH+0DXdzWJgs7N1dtMkh5kxyDWV1ggis3XLqqlq6IZDTXfRPiLfiVIYf8=
Received: from DS7PR03CA0323.namprd03.prod.outlook.com (2603:10b6:8:2b::12) by
 CYYPR12MB8889.namprd12.prod.outlook.com (2603:10b6:930:cb::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Thu, 9 Nov 2023 20:51:39 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:8:2b:cafe::b) by DS7PR03CA0323.outlook.office365.com
 (2603:10b6:8:2b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 20:51:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 20:51:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 14:51:38 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amdgpu: add a module parameter to control the AGP
 aperture
Date: Thu, 9 Nov 2023 15:51:22 -0500
Message-ID: <20231109205125.513643-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109205125.513643-1-alexander.deucher@amd.com>
References: <20231109205125.513643-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|CYYPR12MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f4eb43-7de6-4a81-10c9-08dbe165abf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y+NrnKCqk7Wks4cfx90wZjYuwghyee8fsshTyhynutbbOAQZtgTnEVVt5Dbb4j+hBT3XE7jD+qRmZqPfSqIl+MwTz/TELfeS6F61lak0pjJNjGEsn7/rUmf8ZmpbRCNo7iFoMcDxIohoSk97qy6yCSwVAmuYbjbiaXAtbOXlSQoKFjuUFAmQiY0TySd7zzfh6rK5BEoM5soIu3D8piuJDXmu7mjpCgg4O03Ar2EriSaaVWUNQZJvRsJEnWYyWd8mVWuxecfexdSemvvBvlKd0urLbVN810K/jtlLCvpU5YZbDLlIvHcYJadiFp9VyW47PTiwa2DFbO1QEJEMghz+HtR7FokfMsOlXrabzu6QW8IV8EEgdE/Ro+mkjxSuHbh/eLkUsvDO6OLRVhE7JEyfB4Cj3ppWce/nnR9yPNmqpykIsvLEcSJ38nLmIbkK3dFJKzwre/OT5qUI7Qm2lnWero1glgK/dVEFDBfFfaG6+3WkoX1sXMV5/IwYqebQnBT4BwEFxx4RlUtC3m7MAL6+2BCfg3R3/hVkJ7EMEeqbHv+UKRnFYEMNiYmgomVms+eUUYGOtXTWZ0lkjEACJL0UsNhL5wsioVYd56leBmVnpinxJDykVZIxTfNELlB6xuPOqQDmwB0TOH0NDl7mqk9TLgbaQtjg1NaNFgZXYTcqv97qAuhFkw2b3n0PXA0ZfXDnTbge/YNl3JNI+5dFXXmmTBSdiR/jXnKSyE6IjFw1Sal0oCqIPJHhMDGtAslpzqgwuFilM5HmUyRofal1hh77Nw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(82310400011)(1800799009)(186009)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(83380400001)(26005)(2616005)(70586007)(70206006)(1076003)(336012)(478600001)(426003)(47076005)(40480700001)(8936002)(6666004)(4326008)(8676002)(316002)(6916009)(7696005)(16526019)(40460700003)(41300700001)(5660300002)(82740400003)(36860700001)(81166007)(356005)(86362001)(36756003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:51:39.4924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f4eb43-7de6-4a81-10c9-08dbe165abf1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8889
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

Add a module parameter to control the AGP aperture.  The AGP
aperture is an aperture in the GPU's internal address space
which provides direct non-paged access to the platform address
space.  This access is non-snooped so only uncached memory
can be accessed.

Add a knob so that we can toggle this for debugging.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  2 +-
 5 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 969d8ba8b8dc..8c1f88b4a58c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -250,6 +250,7 @@ extern int amdgpu_umsch_mm;
 extern int amdgpu_seamless;
 
 extern int amdgpu_user_partt_mode;
+extern int amdgpu_agp;
 
 #define AMDGPU_VM_MAX_NUM_CTX			4096
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0c0497d3a003..e8c42ff5d464 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -207,6 +207,7 @@ int amdgpu_user_partt_mode = AMDGPU_AUTO_COMPUTE_PARTITION_MODE;
 int amdgpu_umsch_mm;
 int amdgpu_seamless = -1; /* auto */
 uint amdgpu_debug_mask;
+int amdgpu_agp = -1; /* auto */
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
@@ -961,6 +962,15 @@ module_param_named(seamless, amdgpu_seamless, int, 0444);
 MODULE_PARM_DESC(debug_mask, "debug options for amdgpu, disabled by default");
 module_param_named(debug_mask, amdgpu_debug_mask, uint, 0444);
 
+/**
+ * DOC: agp (int)
+ * Enable the AGP aperture.  This provides an aperture in the GPU's internal
+ * address space for direct access to system memory.  Note that these accesses
+ * are non-snooped, so they are only used for access to uncached memory.
+ */
+MODULE_PARM_DESC(agp, "AGP (-1 = auto (default), 0 = disable, 1 = enable)");
+module_param_named(agp, amdgpu_agp, int, 0444);
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 0ec7b061d7c2..23483bffa1c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -675,7 +675,7 @@ static void gmc_v10_0_vram_gtt_location(struct amdgpu_device *adev,
 	amdgpu_gmc_set_agp_default(adev, mc);
 	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
 	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
-	if (!amdgpu_sriov_vf(adev))
+	if (!amdgpu_sriov_vf(adev) && (amdgpu_agp != 0))
 		amdgpu_gmc_agp_location(adev, mc);
 
 	/* base offset of vram pages */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index ba4c82f5e617..e1078b53e942 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -641,7 +641,8 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_device *adev,
 	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
 	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_HIGH);
 	if (!amdgpu_sriov_vf(adev) &&
-	    (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(11, 5, 0)))
+	    (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(11, 5, 0)) &&
+	    (amdgpu_agp != 0))
 		amdgpu_gmc_agp_location(adev, mc);
 
 	/* base offset of vram pages */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index bde25eb4ed8e..22375fc23412 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1630,7 +1630,7 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
 	} else {
 		amdgpu_gmc_vram_location(adev, mc, base);
 		amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
-		if (!amdgpu_sriov_vf(adev))
+		if (!amdgpu_sriov_vf(adev) && (amdgpu_agp != 0))
 			amdgpu_gmc_agp_location(adev, mc);
 	}
 	/* base offset of vram pages */
-- 
2.41.0

