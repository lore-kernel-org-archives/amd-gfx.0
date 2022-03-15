Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94507C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 14:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 264F310E50A;
	Tue, 15 Mar 2022 14:11:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE73A10E4C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 14:11:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDczS/1D0249crO0wCoiFOJ+yF6JI60c901N392YNya5AxpjP5L/prvUxoBEzdyllzXIJBVe2DCckh967gwCOppw2PnNc+60QO0u5HAD8IxkWEI+UTmYiMwIuWOowIrMvot/I78oHuHWTV7LWReiG2ypDRAXDGG6EPT4n+hE7UyLa0PuFTV/SXOVHubUfOQ2KLYLP8XQeJWKk6lkwN2mRkXVaPCn7K/syJQLnL3wnCh+Xc9eMwUMd6DXNMjTVmy1XIQC+B8UDmJ4EgM46qbKEVKehWcZBl59ZW4/qVsMYIurhwBFBgQ+qfbMrLBa+Kss8W2f1I5XMRYGrtlH/t5jHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FxoREZQTZtD1ahYkbOiJsIS7ucw+ZiUwsbHbIVAZGA=;
 b=dqA5yPm9eRaCkYfE4gvKzySwWEeX9nfTeAKFBM+bPBn1vXnbOIf/BMGnFutfEvC3OFHYdIteWgmjmU9W6HfKExLIxQr2qkZGrRSqiLZ4ozN4eO0wSh+ijKZ3VU8Hb5m+1jimvKn6V//9i74TLadnWm4L3dbEWyhq1S+Wbex0unlZV7vuaQTfuf7J7+QM9ohUaPerKI4Gc8RSS5gNWUYkHs2AeWNDLmocedf8qFio29cWOXl/df6hUYcpbe4b1m+J03LebWBd5Z1CQm0KI+9ox4cYpfLjbN1nlmm7gfMlgz0Q5/8EzWlFHHip+Nt7aNgOux2y98v1xeiCqSW8UR0C/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FxoREZQTZtD1ahYkbOiJsIS7ucw+ZiUwsbHbIVAZGA=;
 b=TqFUW3kP1KGCYROkFf0yg0/OQ4Iu+DkUrjLCO7qD7c1gkj+U3cy1dfdYv2PvsSzPpa69k//4lymvImTv8qf2jRCNzgbeVgxo7z3IdNxzVM0tMRXwwqDCsbOuaFbs06lcSNtSbzCk/1BzvF/IjmAFcwHxQ3k0+wHuw3gZ1HC5WcA=
Received: from MW4PR04CA0264.namprd04.prod.outlook.com (2603:10b6:303:88::29)
 by BN6PR12MB1539.namprd12.prod.outlook.com (2603:10b6:405:6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 14:11:50 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::2) by MW4PR04CA0264.outlook.office365.com
 (2603:10b6:303:88::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26 via Frontend
 Transport; Tue, 15 Mar 2022 14:11:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Tue, 15 Mar 2022 14:11:49 +0000
Received: from yonsun-linux-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 15 Mar
 2022 09:11:48 -0500
From: Yongqiang Sun <yongqiang.sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Merge get_reserved_allocation to
 get_vbios_allocations.
Date: Tue, 15 Mar 2022 10:11:29 -0400
Message-ID: <20220315141130.150367-1-yongqiang.sun@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f6b1935-02c9-4584-f5e8-08da068dbf38
X-MS-TrafficTypeDiagnostic: BN6PR12MB1539:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB153992DB0A021988A025E252F4109@BN6PR12MB1539.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XSgSpZTBpYUPPAR+JjYUXIJRZr15F38u1JP6Fik5AbWEuNMsJuo+MB9FyTLrigV7QsZNvttNGGcv5HbILYhw6ah1s5kXOzyOS1cUy1xs1OtlP8KgP3Y+fJT49eNEFH4IkAQ1RCmVyKG0++UQZUGnbYw6Mlg/rQpi9MWjMMRc+KylGzzv8K6YT6hYrslIn573qyYNbizavORE+5TFLLQRmfBb60wFXu6bapooydx3EisdIovKYcshlT3ZpwctmKLzEGF8tdQ667ks8CrbT+SCtVi764cnvPl60zBbSc1Ww6rFcXGRm4XV/HfBCZOChjGYQAJ6pZ0jhX+4L/yrjRxX+4pnlusbO1chJht+2Da74Wp2QwFhO5GV4t41vumP0TatiztJ+R03aAE5qocMvLvn3JObbZpW+N1VysxvMHOvIIZxzHzIh7UMjq4sILZQoF6fp6ZA/7OZm3Ou+XxvshoczOsFh4RR/2gBcIHe5+9diIDGJZQvP/lyhsSGQ3CxybeYkA50BmYsAU+bFHgbgwwxI7PhyKSelXStFsd1pWRfjlEo3KlILsODMMOS3PxxKtbqMouzGt/Z+DX/mBlgsRLh07Qrd9mxLA8uoEigAqiQeHE8PX/GcP5wQhBbeObgyGwcqET/XPnfSOZbZifmZgUZdKlcWsOMaEdyKp5W5+bnVtlOsbNPmbk65O+s792D6OolsM2DWsPE9kifuXzJoaDbWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(336012)(36756003)(426003)(54906003)(6916009)(316002)(26005)(186003)(2906002)(40460700003)(8676002)(44832011)(47076005)(7696005)(86362001)(4326008)(83380400001)(82310400004)(70206006)(70586007)(16526019)(5660300002)(36860700001)(508600001)(356005)(6666004)(1076003)(81166007)(2616005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 14:11:49.2808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6b1935-02c9-4584-f5e8-08da068dbf38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1539
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
Cc: alexander.deucher@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some ASICs need reserved memory for firmware or other components,
which is not allowed to be used by driver.
amdgpu_gmc_get_reserved_allocation is to handle additional areas.
To avoid any missing calling,
merged amdgpu_gmc_get_reserved_allocation to
amdgpu_gmc_get_vbios_allocations.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Change-Id: I142127513047a3e81573eb983c510d763b548a24
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 32 ++++++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  1 -
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 7c2a9555b7cc..f18d050a14cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -626,6 +626,13 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 {
 	unsigned size;
 
+	/*
+	 * Some ASICs need to reserve a region of video memory to avoid access
+	 * from driver
+	 */
+	adev->mman.stolen_reserved_offset = 0;
+	adev->mman.stolen_reserved_size = 0;
+
 	/*
 	 * TODO:
 	 * Currently there is a bug where some memory client outside
@@ -640,6 +647,12 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 	case CHIP_RENOIR:
 		adev->mman.keep_stolen_vga_memory = true;
 		break;
+	case CHIP_YELLOW_CARP:
+		if (amdgpu_discovery == 0) {
+			adev->mman.stolen_reserved_offset = 0x1ffb0000;
+			adev->mman.stolen_reserved_size = 64 * PAGE_SIZE;
+		}
+		break;
 	default:
 		adev->mman.keep_stolen_vga_memory = false;
 		break;
@@ -760,25 +773,6 @@ uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo
 	return amdgpu_bo_gpu_offset(bo) - adev->gmc.vram_start + adev->gmc.aper_base;
 }
 
-void amdgpu_gmc_get_reserved_allocation(struct amdgpu_device *adev)
-{
-	/* Some ASICs need to reserve a region of video memory to avoid access
-	 * from driver */
-	adev->mman.stolen_reserved_offset = 0;
-	adev->mman.stolen_reserved_size = 0;
-
-	switch (adev->asic_type) {
-	case CHIP_YELLOW_CARP:
-		if (amdgpu_discovery == 0) {
-			adev->mman.stolen_reserved_offset = 0x1ffb0000;
-			adev->mman.stolen_reserved_size = 64 * PAGE_SIZE;
-		}
-		break;
-	default:
-		break;
-	}
-}
-
 int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
 {
 	struct amdgpu_bo *vram_bo = NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 93505bb0a36c..032b0313f277 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -331,7 +331,6 @@ amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
 			      bool enable);
 
 void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev);
-void amdgpu_gmc_get_reserved_allocation(struct amdgpu_device *adev);
 
 void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev);
 uint64_t amdgpu_gmc_vram_mc2pa(struct amdgpu_device *adev, uint64_t mc_addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index f60b7bd4dbf5..3c1d440824a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -948,7 +948,6 @@ static int gmc_v10_0_sw_init(void *handle)
 		return r;
 
 	amdgpu_gmc_get_vbios_allocations(adev);
-	amdgpu_gmc_get_reserved_allocation(adev);
 
 	/* Memory manager */
 	r = amdgpu_bo_init(adev);
-- 
2.25.1

