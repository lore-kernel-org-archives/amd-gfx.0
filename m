Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7432FC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 12:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D45B910E077;
	Fri, 10 Nov 2023 12:52:47 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68F9810E077
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 12:52:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/iExlWHfjdaIsGyyBnhp+dDfCIHZfbm0KO0oi2QLp7NAZDCH5OiAgOnwXSiu7PiEgc8Yve4c35BLZuc/4U/eCrVCa80McHvuzmhAXWSA9l+w3KUvUqNsLct3Rn1Mli/FM9Hups4YMa1PE/PXfUJu6qM0fSSQ409WKe5uK0rQlc9Ju6QtvbnqUdypmEaKQFHyiiX9N4K4HgKLT6RmR5vpY5ocP4Ea/Q9gnNW2Hurah5+4rHbGxslaixxzX3MOhxE2vNg7Tf+MNoAp1wuSWQ2SpOnbbbBLynfbLp9enwa8A0MVVlAZJBl6qYagiVKoMFuPP6FFOe0xcouf9q09a81Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ik1xKtEg7y37kpZOxPc2AP0dn5ypEoeMiZwEgkq6u3E=;
 b=GPtiBcZIh8Dii9l1JZemvSUlGQayCkV/nO0o4bQXCam3ZdjnssB646aupYlCk25Xaxsxe7UsIH/MQ/nGBWAEgUrCRThf9237tOElUCvjlE8JOBgGHTDbwgsghNxahwBnnEG8qob3t0YyZZlpcjtDa57rQKgMKrnehn+cR5Q0m2M83FxIs8YXKQTc8FNlqLOK1TCsF0RvlBMbE0QRswse7G6VN01/05778poKc9xGdeeV8qXCn1lCYi8gMd4ipRdT5NgTxQns0Ze2lhAjO5v88YawqYPWKISh5HnS1GmCxNpqtmbrI+B2mz+dgiwhPDZxliyeXQ/ERRKcVhvx8q3LHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ik1xKtEg7y37kpZOxPc2AP0dn5ypEoeMiZwEgkq6u3E=;
 b=uHD6UdCKUAHkPoJmIdY8zz5V94aS6M2BAylvadyvZgyaz56nJoWGsv+ydK6AgdsT3v8ug8z0tgYjigCQFxuexbPtTN1rFTWvr/yuKjieHEflM8wJJH8IWtRp2wM3KNGaULd4OVL8WAWg80bj0wWU1N7f9WZ9HCc54W3Z4j7Mqek=
Received: from BL1PR13CA0241.namprd13.prod.outlook.com (2603:10b6:208:2ba::6)
 by PH0PR12MB7929.namprd12.prod.outlook.com (2603:10b6:510:284::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 12:52:42 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::29) by BL1PR13CA0241.outlook.office365.com
 (2603:10b6:208:2ba::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.10 via Frontend
 Transport; Fri, 10 Nov 2023 12:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Fri, 10 Nov 2023 12:52:41 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 10 Nov
 2023 06:52:40 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: exclude domain start when calucales offset for
 AGP aperture BOs
Date: Fri, 10 Nov 2023 20:52:25 +0800
Message-ID: <20231110125225.2512174-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|PH0PR12MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: fc29feb6-d533-44ec-8ec8-08dbe1ebed6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +HOZfeDMiYTSKX0W4cJf8FENvD/Pzek+BlfU7OY8/k4IUiTyWk7F/WBcnOg4FzO8Q4XRmxUdVJkEWhrVZBvT+WjdOsj6fUYSSFnQV7V1L1fFOFTsS5MLt0DwMbcsR1rFBfglju6mX6KQuVpmzLjJv3NUQf6tAt38+f67PqzFh4uS+WsrCfalcY7xEvwcPIihEwQq/Y1E/ZuJieVVGohoZXzvA/5a3qVgZnXQLsvvfWPPxpa+xlVNsRLMlXjGxwFddUaz7nkFE4w9CDX/iQDpqyCO64jVRnlfy95CawFYh0PGKhPMBpqPsOIrIjYbbyLhVdQhp/Ed5BBOYdLAof4vHwnIU7CssReciTxkXvZRyb5R2Oo+RtHDDJPL0+Ejml3/58A77WM6Yk3tzS3z0BwJoo57gxTtDbSWj0xe3vaD/wm+Ubr/Jw9Lfr9FUMRZjicc0as91qHqgjne52Puc9hooy4DQGni4rresz0LgljT2yxOrpwse/x6a8QUIXqMxtML5gveDsVQI01ipnBMTb1c8Y5RxDmRO+KkVGPYOtaBKS+Tg5UZ7Lz56ppzyH0DYA949x31dv1NGpu0c+sQGloa8r2L/tQLtu0sh3IqYx2nLh/OBhv18D//zzYGTSMX/Honoqx8Jap9l/dvNUcgpfXFwIXpwo0pYk98W7E4veSqrbl0AKED9WnVLEJ1gd8mHBEKu8lMBtq0stzV34MxG8nBUhNepgcdY+0xEDv3MgANCfL0iug4tsLbyaqzIbSOh7BgdOV1pFs7C91twWDonr7Jug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(186009)(82310400011)(451199024)(1800799009)(64100799003)(40470700004)(46966006)(36840700001)(7696005)(86362001)(8676002)(40480700001)(8936002)(4326008)(478600001)(6666004)(1076003)(5660300002)(36756003)(54906003)(6916009)(70206006)(70586007)(316002)(2616005)(336012)(2906002)(47076005)(16526019)(426003)(36860700001)(83380400001)(40460700003)(41300700001)(26005)(81166007)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 12:52:41.9467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc29feb6-d533-44ec-8ec8-08dbe1ebed6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7929
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Jesse.Zhang@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For BOs in AGP aperture, tbo.resource->start includes AGP aperture start.
Don't add it again in amdgpu_bo_gpu_offset. This issue was mitigated due to
GART aperture start was 0 until this patch ("a013c94d5aca drm/amdgpu/gmc11:
set gart placement GC11") changes GART start to a non-zero value.

Reported-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 ++++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 5f71414190e9..00e940eb69ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -169,6 +169,13 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
 	return 0;
 }
 
+bool bo_in_agp_aperture(struct amdgpu_bo *bo)
+{
+	struct ttm_buffer_object *tbo = &(bo->tbo);
+	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
+
+	return (tbo->resource->start << PAGE_SHIFT) > adev->gmc.agp_start;
+}
 /**
  * amdgpu_gmc_agp_addr - return the address in the AGP address space
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index e699d1ca8deb..448dc08e83de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -393,6 +393,7 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
 				uint64_t flags);
 uint64_t amdgpu_gmc_pd_addr(struct amdgpu_bo *bo);
 uint64_t amdgpu_gmc_agp_addr(struct ttm_buffer_object *bo);
+bool bo_in_agp_aperture(struct amdgpu_bo *bo);
 void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc);
 void amdgpu_gmc_vram_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
 			      u64 base);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index cef920a93924..91a011d63ab4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -39,6 +39,7 @@
 #include "amdgpu.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_amdkfd.h"
+#include "amdgpu_gmc.h"
 
 /**
  * DOC: amdgpu_object
@@ -1529,8 +1530,13 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	uint64_t offset;
 
-	offset = (bo->tbo.resource->start << PAGE_SHIFT) +
-		 amdgpu_ttm_domain_start(adev, bo->tbo.resource->mem_type);
+	/* tbo.resource->start includes agp_start for AGP BOs */
+	if (bo_in_agp_aperture(bo)) {
+		offset = (bo->tbo.resource->start << PAGE_SHIFT);
+	} else {
+		offset = (bo->tbo.resource->start << PAGE_SHIFT) +
+			 amdgpu_ttm_domain_start(adev, bo->tbo.resource->mem_type);
+	}
 
 	return amdgpu_gmc_sign_extend(offset);
 }
-- 
2.37.3

