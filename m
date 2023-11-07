Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D8EC4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 19:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 243DC10E665;
	Tue,  7 Nov 2023 19:14:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24C9F10E665
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 19:14:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQ4nOfxXUdabYazQpeQewmACAMNfwfYkwBp/uTHpCyTMfF/LWab6cA/NCXSh7FrImVcV+2w+KYMphNC9GTQMbon0fxfkfgUd5l1srLDD5eipoUtwefKy9LT4RjJs7yldOfQobr7+7ymyBn22dv/3ps1RHkvTpyETF5qBSObCIBlhOZ+JwEO3p9yL1RAejJEuG8HZwiIe4ZTjPRLNd4RsSbp6626FG5zZvk65u488ReBpf+SPdumMRJGVMYumfbt9EiMxjCrAK56C9uhVlcwnUavvqGpkMlCa7ONWUKQLgaH4Iqxur3+4pyiX9xF1qq57SaOF/I7LljZZt7GR2AT1jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqZP9LYY9a8MkJdvMIAz5xS03vw5RiNxCzU7LUJpN/8=;
 b=mKg781YuK+RcWOxaR1DoWojkMpJJSiZVIUjORN1OiXVATdrxvec/EJS2HgYZHbr1SaFH6Je5yvYCUpvv42hFUwWTwhnSB0IePJqd3Ydlpm36FERH6SVCVcjI+T4oRFpGbChx/fgrIILP/eirIQf4pbhi4VUKE562l3LZR66S0LF+SWBHy/6Sth+MPvytRTkZ0N1XGsqGOMhImGDo/fl5ObrMKL4R64n1alyUGRKVe9gsSM87DvuBbffygfBGn8HcaOHdxNLQdI2O0cOdQS9Vf2llJHfoL86DfSlCT54Rqd4n3SCB3UQAFmrC9DZuBbSBF0WQF0fG0kPBDHQSK6DxVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqZP9LYY9a8MkJdvMIAz5xS03vw5RiNxCzU7LUJpN/8=;
 b=MA38MLOWwGIXp6Yi5pakt4xrjZUOPXxaWqF/SVG94fHPVZDyOlPnqCowiA6fpb7uK0NxiHjz5qvmoI4A+ItuTCAQmmn4j2Zl7WqS9AmlwGfe5Mec82Ir2ma7V3PkuBqdPfRnqDo7u5Y4gWfg2HFIbRZcTCRSyTZtUCXnGyPAaGs=
Received: from CH0PR03CA0396.namprd03.prod.outlook.com (2603:10b6:610:11b::16)
 by SN7PR12MB6910.namprd12.prod.outlook.com (2603:10b6:806:262::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 19:14:18 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::9b) by CH0PR03CA0396.outlook.office365.com
 (2603:10b6:610:11b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28 via Frontend
 Transport; Tue, 7 Nov 2023 19:14:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 19:14:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 13:14:16 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix AGP init order
Date: Tue, 7 Nov 2023 14:14:03 -0500
Message-ID: <20231107191403.2676735-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|SN7PR12MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: 61533feb-2bd4-473e-fb48-08dbdfc5bd0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ad/gYAQO30EhBxW5IRQg2A+hutYyzJbjSa0eGV51QarRe5t0Vc28RdjNdvcYTvZI6EYWCTlXJbLpiH0CP4PBo2HHcFnouFvcouWu22cIpsVErgkWEb4cfYdFivRlIvDCo4IpFe3j2c7Ls/o882xjGRhSUgcTsWjq5UH6PWpkyBPfbBTFdQeoTR8ac9itwbi0nKiOYFuysTe0Q+onK/mBqZraV674Rp3SinbzmRVICJsiCBpZvLIzDT30z4h7MahxROYICBenDUXaAAQI7z0fEK/2ecy7NnGYAz2FUWG7Vq6vFotaW9ECat6fmmF4LhVmJYVL1pGQOFyI+onWp5sBeahlvWFHNTxknHQqRkUI/Ae1ScoldzwuPJ8jp1g8T7Qbgn9lsnwu1+/3k2/goRtiCi+Vh9oaU4c+d3xJVHd7LboWCH+quebpnSbcmsoO7sqOOx2S7LQAr9JwtdJ+hnaCWDsB1elrhTRwD29g3tx55bBafKrpwcmFsftHVYNctSsfgaq6WfhcSMSqgSbHHk67ra7Lv3Yfdv2qPVOrFAbu7F69CKagGphnZDrpD++eMZ+NN/lXVFV7WHlSYYXg+Z0I2N83Lby+n9krCUOqFdjPptXODzMGlOEWli/bZDQyFJnNCUCsPdi4yanZou6gngs5+bPabEeg8VB5gkk/JcEyjNW7jCPgk/DytrYjPB8x6D52zYyQItknHhqfrx4fsnuoDRZa5engFwD7zs54mzrkPPuvbaclgwQ9I0AQkdeiOlF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(1800799009)(186009)(451199024)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(47076005)(478600001)(41300700001)(7696005)(2616005)(966005)(6666004)(336012)(8676002)(316002)(4326008)(8936002)(16526019)(5660300002)(83380400001)(70586007)(36860700001)(1076003)(70206006)(26005)(54906003)(6916009)(356005)(2906002)(81166007)(426003)(86362001)(82740400003)(40480700001)(36756003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 19:14:17.5440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61533feb-2bd4-473e-fb48-08dbdfc5bd0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6910
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
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The default AGP settings were overwriting the IP selected
ones since the default was getting set after the IP ones
were selected.

Fixes: de59b69932e6 ("drm/amdgpu/gmc: set a default disable value for AGP")
Link: https://lists.freedesktop.org/archives/amd-gfx/2023-November/100966.html
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 2 ++
 7 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 0dcb6c36b02c..cef920a93924 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1062,9 +1062,6 @@ static const char * const amdgpu_vram_names[] = {
  */
 int amdgpu_bo_init(struct amdgpu_device *adev)
 {
-	/* set the default AGP aperture state */
-	amdgpu_gmc_set_agp_default(adev, &adev->gmc);
-
 	/* On A+A platform, VRAM can be mapped as WB */
 	if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu) {
 		/* reserve PAT memory space to WC for VRAM */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index d8a4fddab9c1..ef80ea0929fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -672,6 +672,7 @@ static void gmc_v10_0_vram_gtt_location(struct amdgpu_device *adev,
 	/* add the xgmi offset of the physical node */
 	base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
 
+	amdgpu_gmc_set_agp_default(adev, mc);
 	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
 	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
 	if (!amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 4713a62ad586..5f794a907945 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -637,6 +637,7 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	base = adev->mmhub.funcs->get_fb_location(adev);
 
+	amdgpu_gmc_set_agp_default(adev, mc);
 	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
 	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_HIGH);
 	if (!amdgpu_sriov_vf(adev) ||
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 7f66954fd302..42e103d7077d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -211,6 +211,7 @@ static void gmc_v6_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	base <<= 24;
 
+	amdgpu_gmc_set_agp_default(adev, mc);
 	amdgpu_gmc_vram_location(adev, mc, base);
 	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 61ca1a82b651..efc16e580f1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -239,6 +239,7 @@ static void gmc_v7_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	base <<= 24;
 
+	amdgpu_gmc_set_agp_default(adev, mc);
 	amdgpu_gmc_vram_location(adev, mc, base);
 	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index fa59749c2aef..ff4ae73d27ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -413,6 +413,7 @@ static void gmc_v8_0_vram_gtt_location(struct amdgpu_device *adev,
 		base = RREG32(mmMC_VM_FB_LOCATION) & 0xFFFF;
 	base <<= 24;
 
+	amdgpu_gmc_set_agp_default(adev, mc);
 	amdgpu_gmc_vram_location(adev, mc, base);
 	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index b66c5f7e1c56..fe52d132b629 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1614,6 +1614,8 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
 {
 	u64 base = adev->mmhub.funcs->get_fb_location(adev);
 
+	amdgpu_gmc_set_agp_default(adev, mc);
+
 	/* add the xgmi offset of the physical node */
 	base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
 	if (adev->gmc.xgmi.connected_to_cpu) {
-- 
2.41.0

