Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4E9C04E84
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 17:59:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C03E10E498;
	Wed, 20 Sep 2023 17:59:02 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03F4D10E534
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 17:58:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMu6q/DtNtKbS4SwhTIi7xqH8Wiv2/GN+vdFtZe0yzRZHMdQNKO+fQ6PghiWeJJYWWFWtjmVqdU5FlAsYjB/ygAqVWoIWwnVjb0+QJkmYvp3L5Lfx0L/DHauK6/yp1JSOtrAMvIFiuapW8yO8vZSUPSWb9TVcKASPgfeaNGcrw4/ezADAvWfccO710TSSTe8ei7G6/agfix6RcBwh1HZBFITsC9is5QWUUUjelan/w+qLOjDqIAmc2fs0j1qR4rJkK4OHprbay292sHH0vPahB6SdDfMGn6SjKtByhwi08/F53d2lrhBbtrpFAx+LbA1BUubGg7mnzWDqGmwYcSimw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rO14oE7FhEb+TN5YtRZLRw2Xg3r3TfRPaiAhxAypjiM=;
 b=TPoMQaFX+5MGAs2SldGqPKrL1zByap+bpr42FlNpcexWUOxptX0hFkKCoeFahMyo09EfNe1inJ304iWS7oBc3vgfHl0c1EsnJfWm5NZl3obQvreVwJq6wIl9rEGlEBx9fcS2JUagHBbDjiCGJtzuzeA9Wk4wvejQkTtR95W6dbLg6c4U/WUhGgxqTsW+4ji+BnKgslyUzKdK8C+zwclbvfXuoPUmr0wVE2WljgP/GC2hk7COkQtjnPLxm5gAxmz4QZ6UJph4DOcgGOiN9PrMh6Q8F1R37nb9mTaJz/WQdvIO952O8m1ZrcwnmI6wyfk0+WgD6Py5kDKbcOZZ7h3J2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rO14oE7FhEb+TN5YtRZLRw2Xg3r3TfRPaiAhxAypjiM=;
 b=blQcJAMCOeH+5JKPa2m0ml13GLxozFHnxtpbgkHlaDV2IKAc30vQewWKkV5b9i93dRtWFlBUQxrHPf8fa/QPVBxD3CSkB/h+yDWJfcQyZvVlJaCyubsYXm95ZyTo7OMFSW2+7fzigoJnBKpc38fg8ckasZROCQmvWbtUaaiLy94=
Received: from DM6PR21CA0030.namprd21.prod.outlook.com (2603:10b6:5:174::40)
 by DM8PR12MB5461.namprd12.prod.outlook.com (2603:10b6:8:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 17:58:55 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::eb) by DM6PR21CA0030.outlook.office365.com
 (2603:10b6:5:174::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.8 via Frontend
 Transport; Wed, 20 Sep 2023 17:58:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 17:58:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 12:58:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu/gmc: add a flag to disable AGP
Date: Wed, 20 Sep 2023 13:58:22 -0400
Message-ID: <20230920175823.3099627-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920175823.3099627-1-alexander.deucher@amd.com>
References: <20230920175823.3099627-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DM8PR12MB5461:EE_
X-MS-Office365-Filtering-Correlation-Id: 795b5b55-a6b3-41ac-9e40-08dbba0341d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fEB6NByI8xdISpZvxBjd/Dgy1a+GDIrD9k7NN/hovjcYtp4rgegpeixyOpM8lDjil29uAxYqswgN/Kdi8SGM+wnE9ZX6zwrffSDOmSdk/PRl/qtDxPGXetaYEbMfFD2LSj0AeCurPJVpm7tL4VoVJU+qf0grl+r7JKF8MIaqXCoqp7cWX3fYvenmanDQkvC1Fy6p/ku/Fw/usgiBuC2aB3TLh2Xy1/YRdpwnW4qrVg5tJteJT6p1xThYZNgOaXdxD2CtxGQ+zyDLTuuBMw/Ep3DU6tosQQUzP0aQB+kHeAvHkUAYFJS6NyocSch24T43/TOY/HKxG8HqXY/Ryl297F04Jzmpso1fkPNSTC2vQ2+jzeHvq4ROK8JNgUQ8vw88DWyCKbELsvw5MPAhr4ZOeI5zA3dd0BKjwyQX7xN+WiDS+wxCFJM8WmTxsc/n7kxnzC2SZgzfzke0DOtlrDrOx/Av/QwmI754ivdyR57bpaQXCnM7nuHaCrhKHmxXc4IiHbUmMORTN/O1iZh1wgq5AHimCRusMZS23eiJBmi5G1Z873+/lDP4GJ8MOItbptBTyyZTtKsfOkeKJHwRsn/FBliE7/dP02fvSy+UJMsdUfTf73Yhw5bk6rZN25BlHKU7h6tmm0hFw6cQvOXD+1tHzyHyYexJ3bf5oIEl//AL2NrB8JA1lLcICxiPZIOxJi2X9L5NVuTOEz4FMMkvbYU9pjbo2gHQxXOY2izt/QZvWKKXGT6UTzpLlsHGBDvIa3StcGluxoOyWh2l4I2a8RIPCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(1800799009)(186009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(70206006)(6916009)(316002)(336012)(426003)(26005)(16526019)(70586007)(82740400003)(1076003)(83380400001)(36756003)(2616005)(7696005)(6666004)(47076005)(81166007)(40480700001)(356005)(86362001)(36860700001)(40460700003)(478600001)(2906002)(5660300002)(8676002)(4326008)(8936002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 17:58:55.3953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 795b5b55-a6b3-41ac-9e40-08dbba0341d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5461
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

Allows the driver to disable the AGP aperture when
it's not needed.  Program AGP explictly for all asics,
but set the flag to align with previous behavior.  No
functional change.

v2: rework patch
v3: fix broken rebase

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c           | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h           | 2 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c            | 2 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c            | 2 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c             | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c             | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c             | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c             | 3 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 9 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c7793db6d098..fc1a585d05bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -315,7 +315,7 @@ void amdgpu_gmc_agp_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
 	const uint64_t sixteen_gb_mask = ~(sixteen_gb - 1);
 	u64 size_af, size_bf;
 
-	if (amdgpu_sriov_vf(adev)) {
+	if (mc->disable_agp) {
 		mc->agp_start = 0xffffffffffff;
 		mc->agp_end = 0x0;
 		mc->agp_size = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index fdc25cd559b6..d3b014b84fa9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -333,6 +333,8 @@ struct amdgpu_gmc {
 	u64 MC_VM_MX_L1_TLB_CNTL;
 
 	u64 noretry_flags;
+
+	bool disable_agp;
 };
 
 #define amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, type) ((adev)->gmc.gmc_funcs->flush_gpu_tlb((adev), (vmid), (vmhub), (type)))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index e582073b57c8..2923007847bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -842,6 +842,8 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
 		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
 	}
 
+	if (amdgpu_sriov_vf(adev))
+		adev->gmc.disable_agp = true;
 	gmc_v10_0_vram_gtt_location(adev, &adev->gmc);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 69f65e9c4f93..28dc08fe542b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -741,6 +741,8 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
 	else
 		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
 
+	if (amdgpu_sriov_vf(adev))
+		adev->gmc.disable_agp = true;
 	gmc_v11_0_vram_gtt_location(adev, &adev->gmc);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 07579fa26fa3..a65118926ed7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -213,6 +213,7 @@ static void gmc_v6_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	amdgpu_gmc_vram_location(adev, mc, base);
 	amdgpu_gmc_gart_location(adev, mc);
+	amdgpu_gmc_agp_location(adev, mc);
 }
 
 static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
@@ -253,8 +254,8 @@ static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
 	WREG32(mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR,
 	       adev->mem_scratch.gpu_addr >> 12);
 	WREG32(mmMC_VM_AGP_BASE, 0);
-	WREG32(mmMC_VM_AGP_TOP, 0);
-	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
+	WREG32(mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 22);
+	WREG32(mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 22);
 
 	if (gmc_v6_0_wait_for_idle((void *)adev))
 		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
@@ -339,6 +340,7 @@ static int gmc_v6_0_mc_init(struct amdgpu_device *adev)
 	}
 
 	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
+	adev->gmc.disable_agp = true;
 	gmc_v6_0_vram_gtt_location(adev, &adev->gmc);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index e77e5593e1ab..680c7bc58c85 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -241,6 +241,7 @@ static void gmc_v7_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	amdgpu_gmc_vram_location(adev, mc, base);
 	amdgpu_gmc_gart_location(adev, mc);
+	amdgpu_gmc_agp_location(adev, mc);
 }
 
 /**
@@ -288,8 +289,8 @@ static void gmc_v7_0_mc_program(struct amdgpu_device *adev)
 	WREG32(mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR,
 	       adev->mem_scratch.gpu_addr >> 12);
 	WREG32(mmMC_VM_AGP_BASE, 0);
-	WREG32(mmMC_VM_AGP_TOP, 0);
-	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
+	WREG32(mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 22);
+	WREG32(mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 22);
 	if (gmc_v7_0_wait_for_idle((void *)adev))
 		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
 
@@ -406,6 +407,7 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
 	}
 
 	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
+	adev->gmc.disable_agp = true;
 	gmc_v7_0_vram_gtt_location(adev, &adev->gmc);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 6acf649469dd..1576d22c8197 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -415,6 +415,7 @@ static void gmc_v8_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	amdgpu_gmc_vram_location(adev, mc, base);
 	amdgpu_gmc_gart_location(adev, mc);
+	amdgpu_gmc_agp_location(adev, mc);
 }
 
 /**
@@ -473,8 +474,8 @@ static void gmc_v8_0_mc_program(struct amdgpu_device *adev)
 	}
 
 	WREG32(mmMC_VM_AGP_BASE, 0);
-	WREG32(mmMC_VM_AGP_TOP, 0);
-	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
+	WREG32(mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 22);
+	WREG32(mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 22);
 	if (gmc_v8_0_wait_for_idle((void *)adev))
 		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
 
@@ -596,6 +597,7 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
 	}
 
 	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
+	adev->gmc.disable_agp = true;
 	gmc_v8_0_vram_gtt_location(adev, &adev->gmc);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 2936a0fb7527..83a4e293ec4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1788,7 +1788,8 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
 	}
 
 	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
-
+	if (amdgpu_sriov_vf(adev))
+		adev->gmc.disable_agp = true;
 	gmc_v9_0_vram_gtt_location(adev, &adev->gmc);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2e4a8bdbf50e..c2cb4b4cd2d7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1255,7 +1255,7 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 	agp_top = adev->gmc.agp_end >> 24;
 
 	/* AGP aperture is disabled */
-	if (agp_bot == agp_top) {
+	if (agp_bot > agp_top) {
 		logical_addr_low = adev->gmc.fb_start >> 18;
 		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
 			/*
-- 
2.41.0

