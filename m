Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829BEC38145
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 14:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8434E10E6A9;
	Thu,  8 Sep 2022 14:39:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C58FB10EB31
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 14:39:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcfSpeIEsHSs3lzsba7IN6Dbq2eVsa+ZE6TsQ3ssXwJ7W+S1lmOMTpWdibM3ptWDBAjZKXicFhLnZxlYxQF6Cc/Vt/3NLQ+1g609qFDGkD/xQ/MGOM4UxMbGNjO0c0RrYUGJD2RX+E86QFfP6BR7q+Pck4aT63Sv5akSfEVQzew1dUzIVUzei1xFlIYcu8B5UizRu3GIkCMqb3XjQ4E54Kmg43zVI67ksnjitdqQlJGA46nUt/wTatK3kVjeOzWwbPcKO+EuJMky9tfUziu/C+N9fJWI3NoR0pxkwv/GhtF5QFgNR20cccGpxiojZJu6wAocRtCf4cobtkiwmCjPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idhN8taZHTTgkm+vH94bGHc6PSaE+eRvo9kCzzp2y20=;
 b=mzhbZ+ko/d3Pt15gXfiO2+6VHOKthqQVSKTDOhD34TDYOvfWspHIzNAqkLlT277LpifLCUyzO6qqK85EZde3ILy26IoYkdeyBu9Gq51STbcLnVmFFtIEgYsSDCmpwWFPvjwgOvlzSEPIphUEohlOxWA17fq1rzU7aw5igfamZpN0JxrrHKGXF77TIjQ5rAqKuh0dyqO4Po1M+uO7xdKeQqW0Ta0oSLbqlmrIxdfbsv1JcgTSduFlglZBECUnclUNBJ6bqzbIko9leMnbMYdLOMPSTYfUj9hPbI8RwYW6aZAqDCQ1j0cEzdQFNUnYuJmYkrHqDTIu8rPaUlFbkuUlFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idhN8taZHTTgkm+vH94bGHc6PSaE+eRvo9kCzzp2y20=;
 b=vu6U6Pxe6xEU/jPPnqwhG91ADoIpghRXXdyX8jZn8bowYcEhJbHdc6SolW89XElpBc4ssNAZs3Kcwgs3P3DXrCkkK+xVXZzgsOtnBnI6CbngnibcMf60Suy8FuwM2bSzrtL37IfYUGyu666wjCq69YHeMYXDS5E+mee9ulXD8QY=
Received: from BN0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:408:e6::6)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Thu, 8 Sep
 2022 14:39:17 +0000
Received: from BL02EPF0000C402.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::57) by BN0PR03CA0001.outlook.office365.com
 (2603:10b6:408:e6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Thu, 8 Sep 2022 14:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C402.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.10 via Frontend Transport; Thu, 8 Sep 2022 14:39:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 8 Sep
 2022 09:38:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: rework SR-IOV virtual display handling
Date: Thu, 8 Sep 2022 10:38:06 -0400
Message-ID: <20220908143808.53981-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220908143808.53981-1-alexander.deucher@amd.com>
References: <20220908143808.53981-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C402:EE_|MN2PR12MB4047:EE_
X-MS-Office365-Filtering-Correlation-Id: a89decbe-6486-4829-89de-08da91a7e86c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u1+eIzltrTs6Xl7jjWjBGKWhQ7bmqHyLIIe/PlNSs89qpmiQ3QitvIwc9MVTfvSEjjP21raSoxelr6CfN1CByFN+7jFuhECfLVLNXY6U760dXsm8cKJxztko8skwvfkXwC+9v4fL4E+MLjUKv2PJJVQDDcrDi7rJNrrn7S21CkgKfkEBNkA7XKeJ5u4dOpG3Qb/C/+SrfOmMZjfYPcaqZ0P8w4QDBdqMDBT2VNgXXX3TCcguBwx7Prl1SD2RMlwkhxIBLomVshGVIjQJYzhVkre+pV23T2qwWoBdni+loYK1l3op0J6efl7DO6oeBpbDtPwzYs/fou2mW3d8n56NeLRiKTYaeLI3EggHTOVA6oWdi1sHARclslrm5DtuQ6LCKZdjqIHVGnluv08UbWZCMLiqiWYBi0vyaGnkDGAzoIxn/AV8oeGIztPQ9kG361AXzYnxAoZnbIwCXsddoGTLOxbYV9g//KtSeCMr7vfCxFeReCNC2nSAMZHJrCPWABRvA+FwTA2U2l/ABeNFNVkaCMGnJviANrwU5pvd6ITtPAzec92M6Q3J0kWIxSuSkzdi65iL+rwca6fAALuCAgHaNjVGBkb7eBh+l/zFGSZ71iOwia1kiANsjGSzEO9C/PBzsQQfvRFRuviK1ma0kPAFwKRrKafa0tYGAGYLKQeCuEVsPl4f+NWApCyx7xbaEQfZ7O5fPJaj0lrAG7SYzBSegEjyGznUNLgqCW9t/75xQO10l1XbHChN1X6cGPEkYaRzhuaCsWXJjPfFpsiNrJPOQuCu++Q37wRJ5EHwBC6OTYDJW8wjoY8+6YzHA4sBgS8R
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(376002)(46966006)(36840700001)(40470700004)(36756003)(26005)(6666004)(7696005)(41300700001)(83380400001)(478600001)(426003)(47076005)(186003)(336012)(16526019)(1076003)(316002)(82310400005)(2616005)(2906002)(40480700001)(5660300002)(8936002)(40460700003)(6916009)(70586007)(8676002)(70206006)(4326008)(82740400003)(86362001)(36860700001)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 14:39:17.0245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a89decbe-6486-4829-89de-08da91a7e86c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C402.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
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

virtual display is enabled unconditionally in SR-IOV, but
without specifying the virtual_display module, the number
of crtcs defaults to 0.  Set a single display by default
for SR-IOV if the virtual_display parameter is not set.
Only enable virtual display by default on SR-IOV on asics
which actually have display hardware.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 13 +++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 18 +++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/vi.c               |  6 ++++--
 4 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 97d095a86410..2e44c9bf336a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1123,6 +1123,8 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
 bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
 bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
 
+void amdgpu_device_set_sriov_virtual_display(struct amdgpu_device *adev);
+
 int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 				 struct amdgpu_reset_context *reset_context);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 62b26f0e37b0..8a233ef87a7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1915,6 +1915,16 @@ static void amdgpu_device_enable_virtual_display(struct amdgpu_device *adev)
 	}
 }
 
+void amdgpu_device_set_sriov_virtual_display(struct amdgpu_device *adev)
+{
+	if (amdgpu_sriov_vf(adev) && !adev->enable_virtual_display) {
+		adev->mode_info.num_crtc = 1;
+		adev->enable_virtual_display = true;
+		DRM_INFO("virtual_display:%d, num_crtc:%d\n",
+			 adev->enable_virtual_display, adev->mode_info.num_crtc);
+	}
+}
+
 /**
  * amdgpu_device_parse_gpu_info_fw - parse gpu info firmware
  *
@@ -3319,8 +3329,7 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
  */
 bool amdgpu_device_has_dc_support(struct amdgpu_device *adev)
 {
-	if (amdgpu_sriov_vf(adev) ||
-	    adev->enable_virtual_display ||
+	if (adev->enable_virtual_display ||
 	    (adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK))
 		return false;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 248c6708613c..fa7131605965 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1704,9 +1704,15 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 	return 0;
 }
 
+static void amdgpu_discovery_set_sriov_display(struct amdgpu_device *adev)
+{
+	amdgpu_device_set_sriov_virtual_display(adev);
+	amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
+}
+
 static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 {
-	if (adev->enable_virtual_display || amdgpu_sriov_vf(adev)) {
+	if (adev->enable_virtual_display) {
 		amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
 		return 0;
 	}
@@ -1734,7 +1740,10 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(3, 1, 6):
 		case IP_VERSION(3, 2, 0):
 		case IP_VERSION(3, 2, 1):
-			amdgpu_device_ip_block_add(adev, &dm_ip_block);
+			if (amdgpu_sriov_vf(adev))
+				amdgpu_discovery_set_sriov_display(adev);
+			else
+				amdgpu_device_ip_block_add(adev, &dm_ip_block);
 			break;
 		default:
 			dev_err(adev->dev,
@@ -1747,7 +1756,10 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(12, 0, 0):
 		case IP_VERSION(12, 0, 1):
 		case IP_VERSION(12, 1, 0):
-			amdgpu_device_ip_block_add(adev, &dm_ip_block);
+			if (amdgpu_sriov_vf(adev))
+				amdgpu_discovery_set_sriov_display(adev);
+			else
+				amdgpu_device_ip_block_add(adev, &dm_ip_block);
 			break;
 		default:
 			dev_err(adev->dev,
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index f6ffd7c96ff9..12ef782eb478 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -2111,6 +2111,8 @@ void vi_set_virt_ops(struct amdgpu_device *adev)
 
 int vi_set_ip_blocks(struct amdgpu_device *adev)
 {
+	amdgpu_device_set_sriov_virtual_display(adev);
+
 	switch (adev->asic_type) {
 	case CHIP_TOPAZ:
 		/* topaz has no DCE, UVD, VCE */
@@ -2130,7 +2132,7 @@ int vi_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gfx_v8_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v3_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &pp_smu_ip_block);
-		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
+		if (adev->enable_virtual_display)
 			amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
 #if defined(CONFIG_DRM_AMD_DC)
 		else if (amdgpu_device_has_dc_support(adev))
@@ -2150,7 +2152,7 @@ int vi_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gfx_v8_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v3_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &pp_smu_ip_block);
-		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
+		if (adev->enable_virtual_display)
 			amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
 #if defined(CONFIG_DRM_AMD_DC)
 		else if (amdgpu_device_has_dc_support(adev))
-- 
2.37.2

