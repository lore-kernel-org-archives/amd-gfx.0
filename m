Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DFF606A32A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bYDz4sVS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17FBE10F010;
	Thu, 19 Nov 2026 14:44:29 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF21D10E8A1
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 14:43:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CzrQZj8+DsRUr2U5FRin2q1vJF5b/Nyf9u883Qtalzjekr1PcK7rjISqIanf2kW4Vj72kXeipYtxeU3HoFrqpcD5w0pI1KXWAWeGxPyOB+kbJxpVrSCeqB3dJ/lGWHkz9B4m35tZHb/r5p9fFYxPxAicjyE2YY/oBcp+bRCzl97nrcRV8fSFJBKyStKUYGYUG+SOaUDOw8FxmJ8AQZwxvu4G1c3y2tGdwExDA2ejcpY6QtO7Ap1no2We3EeFH07fKZNJdEoTXNuluGppLRVqlUYEVtq0oj21vaGHC/18dUras2PeleQSk1pfEvASBbjJkdBFmiiWouWPc1u+gIdQ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WoiOwYZqjqNR4nouGyDMTy325n7gAfZwmFfynLnv/0=;
 b=GY490p3tNc2KuYk5xlhnQtpwawWvKq9+FfibQzVf2xHnMkB7zFX0qEkqE8G2otJ+ubBoeXHmXUZN1jzHFCA0xuSQCChn4gQFL+fx849ZRj3RS9sFIkwOSL3CmjNU2n+iWGfZFET+B2BA/spNxGEgl/WXp7HJs7PEiMdeU6yv13oLPdZ4o4N6k4ob3oE2jtCPIVmEYpof3rX3G+lIJpcbH0GN00tHw7VyZGVPivcWEAfZcR3m384xaxT5Bm5Of8uA6HMU7BQgX9kPhEajIMWhuK3gzQVDI8r/KDdtFqs+kCisUBHBLHr+VBUUNHiEJPAiK6hthfd7rLCCqF4kRqOygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WoiOwYZqjqNR4nouGyDMTy325n7gAfZwmFfynLnv/0=;
 b=bYDz4sVS2SVzbDIG/JJ50pTfc3NfYDPt6JbIyh55MtVR+oJKeDpM38HbYcwYkBjkXN9TYhM1CtOr3+DbwTZXaTM49pwcSvwxGEVUYdJmJoCBSmjqjtUzPTKvpqH5QDdTotwhHYEuzwEJvV/fK7VfHvfCTTXLqLb20auVIHRQ9DM=
Received: from CY5P221CA0131.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:1f::15)
 by LV5PR12MB9802.namprd12.prod.outlook.com (2603:10b6:408:2f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 14:43:19 +0000
Received: from PH3PEPF00059616.namprd05.prod.outlook.com
 (2603:10b6:930:1f:cafe::88) by CY5P221CA0131.outlook.office365.com
 (2603:10b6:930:1f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 14:43:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH3PEPF00059616.mail.protection.outlook.com (10.167.243.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 14:43:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 08:43:17 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 08:43:17 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, <superm1@kernel.org>
Subject: [PATCH] drm/amdgpu: add helper for determining removable devices
 (USB4, TB)
Date: Thu, 19 Nov 2026 09:43:09 -0500
Message-ID: <20261119144309.3013871-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059616:EE_|LV5PR12MB9802:EE_
X-MS-Office365-Filtering-Correlation-Id: e87e1152-5f05-428d-2c32-08df464b7361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|261026140227099003|56012099006|11063799006|10067099003|261009221227099003|261026121527099003|261022105027099003|261021121427099003|261009223027099003|261102123227099003|261021123027099003|261028144727099003|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info: 7QgR3KCvWoyfsfToyWYvRgPbRvIukUXqPD9Y3yK399J7gCHLMVp7hTGvAdzPjBkUQ+ZZKKn48AP/WMbZeIT0GRZzpjgeoyUEJy+By+XxDr1Nhm/+S4Lj+JnyV2hvMCS/3BI5w+tp9rS16iNbI59QEKXSmmaLobm15F1/ya30X2W5N4+USj26bcvNYZlUR3nQc7vTFViiOAVyIdQbqiIdhYaTlkwqhuotoDVf7LLyVhSk3AMpWs0OMzbK63OKqu2mBgWzYUnmnq2Aiw1xrN37GdPA7onv+elBoYmAn+abv5ASbBGGia4Xhtx8eNqyds3ktIIUUfEkpCD1v5oO8J3X94pUkwFUa9JcE1pKKxMiUau/OLcFWnIU6TjHC9R0AwiELOXSiySx/1UPXzO/zDdTeCGkBICYfxAhZN0K3+TggALYzHA90dT9GKUfjK08Stt+9ao3cPZEiTeq2SmzIvey7yRtgSQA6YUyBT5lbyXglWqrEOepYpjPScqPruixF5covPfSv5K8sxsA4tvgA8vyhZ8Oj5w4Refr40f6T7uPVkr8kOHbn3ojT0phzdrOXh4+9kPdCPuhLWuYEQirfP36GAkRGPwPVLu/6l82z7K56pnszlNU2zIi4oFL0abbDsKzAJ+5fLjFgs+FhTyiIfe0voEyPvp1qxxPtUgqrMHq6F4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(261026140227099003)(56012099006)(11063799006)(10067099003)(261009221227099003)(261026121527099003)(261022105027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261021123027099003)(261028144727099003)(13003099007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UkEZRL47FKc/BeLZoZva4u4NuVYRZuT9C+3PLBHByvmh8lXsMYBao0nEWFottOjvNoIzKDz7PaFOgmNCi3SU6ds2F+SwyCdP+7QcSdAKyXyf5z1ZwgSUYPeHSNxRk4aAjbo9O4bwOHtXOBbW2Fhrbq9ERnZEOS27LDGU76Oy3LS4dH7O8y5wX7hsTFAdjws/GdzxEz7xL/g0LX/E6YQxrn+t0RJ8PtW+JB5+i2bTf/2MIEPwsnTLIXIF94nRW1r/lbR0+v4lPhtjGiMO+hwNBlfZCjGPIVjMCfkzwR6OfvAHj5duGIEcWvWRqL62fpI5Goc5NIPnjqgjydIEsoaEiwSGJpXMfOTFJ7plrI/hpVzq8nbmXXUhedj/8yCJIohhS3OkU8lJrwhFw/NW64ZKa80w8nAodCeZ9NF1qFuDD/svmxvqImIjhLnVDDCaHgh1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 14:43:18.1435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e87e1152-5f05-428d-2c32-08df464b7361
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF00059616.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9802
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Apparently some Intel TB ports don't set dev_is_removable() on attached
devices and thus the current check fails.  Add a helper to check both
dev_is_removable() and TB attached.

Cc: superm1@kernel.org
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/6163
Fixes: d9b3a066dfcd ("drm/amd: Exclude dGPUs in eGPU enclosures from DPM quirks")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c     |  4 ++--
 4 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7e1b9a70fd150..5dfb57e7c0b32 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1053,6 +1053,8 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 
 int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context);
 
+bool amdgpu_device_is_removable(struct amdgpu_device *adev);
+
 int emu_soc_asic_init(struct amdgpu_device *adev);
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 6bbca70a4e2eb..4918e891f9781 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -369,7 +369,7 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)
 	bool found = false;
 
 	/* ATRM is for on-platform devices only */
-	if (dev_is_removable(&adev->pdev->dev))
+	if (amdgpu_device_is_removable(adev))
 		return false;
 
 	while ((pdev = pci_get_base_class(PCI_BASE_CLASS_DISPLAY, pdev))) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ea960085bfc8c..7179011d1b0a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -617,8 +617,7 @@ void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev)
 	int bamaco_support;
 
 	adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
-	if (pci_is_thunderbolt_attached(adev->pdev) ||
-	    dev_is_removable(&adev->pdev->dev)) {
+	if (amdgpu_device_is_removable(adev)) {
 		dev_info(adev->dev,
 			 "Runtime PM disabled for externally attached device\n");
 		return;
@@ -1286,6 +1285,16 @@ bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev)
 	return amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 0, 0);
 }
 
+bool amdgpu_device_is_removable(struct amdgpu_device *adev)
+{
+	/* older TB systems don't set dev_is_removable so check both here */
+	if (dev_is_removable(adev->dev) ||
+	    pci_is_thunderbolt_attached(adev->pdev))
+		return true;
+
+	return false;
+}
+
 #if IS_ENABLED(CONFIG_X86)
 static const struct x86_cpu_id amdgpu_pcie_dynamic_switching_quirks[] = {
 	/*
@@ -1308,8 +1317,8 @@ static const struct x86_cpu_id amdgpu_pcie_dynamic_switching_quirks[] = {
 
 static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu_device *adev)
 {
-	/* eGPU change speeds based on USB4 fabric conditions */
-	if (dev_is_removable(adev->dev))
+	/* eGPU change speeds based on USB4/TB fabric conditions */
+	if (amdgpu_device_is_removable(adev))
 		return true;
 
 	/* Hosts have problems with dynamic speed switching */
@@ -2077,7 +2086,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	    (amdgpu_is_atpx_hybrid() ||
 	     amdgpu_has_atpx_dgpu_power_cntl()) &&
 	    ((adev->flags & AMD_IS_APU) == 0) &&
-	    !dev_is_removable(&adev->pdev->dev))
+	    !amdgpu_device_is_removable(adev))
 		adev->flags |= AMD_IS_PX;
 
 	if (!(adev->flags & AMD_IS_APU)) {
@@ -3820,9 +3829,8 @@ static void amdgpu_device_sys_interface_fini(struct amdgpu_device *adev)
 static bool
 amdgpu_device_should_register_switcheroo(struct amdgpu_device *adev, bool px)
 {
-	return !pci_is_thunderbolt_attached(adev->pdev) &&
-	       (px || (!dev_is_removable(&adev->pdev->dev) &&
-		       apple_gmux_detect(NULL, NULL)));
+	return !amdgpu_device_is_removable(adev) &&
+		(px || apple_gmux_detect(NULL, NULL));
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index 04041b398781b..3da92fb09495d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -357,7 +357,7 @@ static void nbio_v2_3_enable_aspm(struct amdgpu_device *adev,
 
 		data |= NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L0S_INACTIVITY__SHIFT;
 
-		if (dev_is_removable(&adev->pdev->dev))
+		if (amdgpu_device_is_removable(adev))
 			data |= NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT  << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
 		else
 			data |= NAVI10_PCIE__LC_L1_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
@@ -476,7 +476,7 @@ static void nbio_v2_3_program_aspm(struct amdgpu_device *adev)
 
 	def = data = RREG32_PCIE(smnPCIE_LC_CNTL);
 	data |= NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L0S_INACTIVITY__SHIFT;
-	if (dev_is_removable(&adev->pdev->dev))
+	if (amdgpu_device_is_removable(adev))
 		data |= NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT  << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
 	else
 		data |= NAVI10_PCIE__LC_L1_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
-- 
2.56.1

