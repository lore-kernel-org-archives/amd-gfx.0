Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59BCC02199
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 04:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D52910E420;
	Thu,  6 Feb 2025 04:23:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SMXT0wZK";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6611110E420
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 04:23:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsqnNbVibrRl8MxvInf4KYBvnEw5MskDq32VKX5MfJo0S06yRLKyUFgucBG/M/QwGNMbj6lwsmzLPe68+AWk1WXSHKZjcdBjWiylciLhbQCgmiAf/k+RQ40NNBaHPQ/SbXBzk/CZVTOXw0Vmz8PHG9b1RW0m+L1KxtAiYYiCMXP8u5UrEsWTVzskJUYoIwEEC5jWKGo5xK/UhWuNvW1Ag52gdWnINnVE7IQAz8aFe2YxB6PzrQSKDMb45nNKTdQLecGB2/s2KzBUsjzlJpD5nSVpxdbh+Ia8Asep0m9poponw/R5drWEn+T9+dtgXRWhiVCUWi3e/CkIAoeJEU9ipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KPADWyL1eByTnnl8MV8YqxUDScUBQRS+LuyCbIie8Q=;
 b=VLLM0ybIzNiW88YmWJAuFWtMmc9yqZdRl0a3tfIUHZTCEXlZjmGBXLKf0Wu/UQYviWDoH+7s/kroFvJ04ZMVsAkktJ3oTN2RwiSu7LCaNM0I8ztamOKWkiQDK+Sia1MiSWLEIOMkeMs1Z8Y7ODeX7nDUrs4YrxcxZNILvTEB5fsCVZ8V2vCXf4M6XcfFE/SYbx06Nbk2VlDvEaq5euRNE4e1cmIssPf1O/m1ZccDHCbQ0lp/lPFGUwiBgULE7/8PJJwcq2YEjpQxNQpZHaXVNPTKJqxoBhHLeSNQxYPM/VNAmGsJTvrVmRZl5H1SKf/gA5FwaiMf8i0uLAv2BOmq7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KPADWyL1eByTnnl8MV8YqxUDScUBQRS+LuyCbIie8Q=;
 b=SMXT0wZKQjlrq0AiLWXuM6NX1CLM3F3gbKJqTy35hDNjX0abCdOncwy6AQpOElfPGSvd91ztjcY1KfminuZypmG6yp/TEEUTwbyKx/x94Nv2sHfjDVdWAZHBOagAIOixRl0Q7aO0GYckPhqsPXMvKK3+5xOWIsbm2ytuhMQV18g=
Received: from MW4PR03CA0174.namprd03.prod.outlook.com (2603:10b6:303:8d::29)
 by DM4PR12MB5916.namprd12.prod.outlook.com (2603:10b6:8:69::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 04:23:43 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::c7) by MW4PR03CA0174.outlook.office365.com
 (2603:10b6:303:8d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Thu,
 6 Feb 2025 04:23:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 04:23:42 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 22:23:32 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>
CC: <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2 3/4] drm/amdgpu: Add flag to make VBIOS read optional
Date: Thu, 6 Feb 2025 09:52:58 +0530
Message-ID: <20250206042259.1927200-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250206042259.1927200-1-lijo.lazar@amd.com>
References: <20250206042259.1927200-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|DM4PR12MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: dc73c1a2-cc18-471f-fb04-08dd46660a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t/ilNNFKi4VfqB+QJ1ou79JBlfPjQgsNGpv8q2OE5YbXblBJIWpIsIdS0g91?=
 =?us-ascii?Q?OyjR3M13kedT30W63YIyRjoOjr4Ta8/o/o7Q3xOK30YeTyuZj8v7N6qkqzna?=
 =?us-ascii?Q?rRpGC825jtY6dLaRApeo2+oKvDoWMezy0CM8fAkGFwpts/TRyr15KQbXcNEF?=
 =?us-ascii?Q?uXcGPkFzDhJhuXIlurCIJKFOr7wnjsG7q2R/EQHUhGvLHi7JdLRPxulW9Jhi?=
 =?us-ascii?Q?rCx1m27Zy/mayTofR45Y1MkXhU6UVNVh5xtd56GBAJ0Cm02UDla9uuYIxRGP?=
 =?us-ascii?Q?RrqsCRTQXaHDFluzFj7eEayxEFIgsZOcM7jeqk6PL/AzcokAPO7WrLNud6rt?=
 =?us-ascii?Q?rYiOY9DLmkQnAXiDqCPUQIncK0IW8MJKsJkuI5qekX9KcrCgv2X/1jbYUv90?=
 =?us-ascii?Q?f5JmbuCRZm18omCZqmPRtpApjt84R28I8NdFnMt6Qpa9MSSb2R4b97lJiK2w?=
 =?us-ascii?Q?wUC9j3jSUiOX15f2IxKH3dF0cZgF3XSaWdEUotJBViBtTZRhXkwbMDKkOSyZ?=
 =?us-ascii?Q?vjWAVcWbsZzu4W8a3zV0vLqg8XZrXUROKnEIet5sG/wwqsuw3ztyFD6zErlx?=
 =?us-ascii?Q?dqEgNwIxr/e4IrGPIXwy6OWo9VIxXau3d3IbBApAkZaNT/YcE/08Tcq3J/C8?=
 =?us-ascii?Q?9iuQ8zU0E/n9JcfL7Mawlgc4mUqV+ed+G386Onxy7s/ctTNAmEX8WqitKofv?=
 =?us-ascii?Q?ExgZKh5hptbBQBcVJ4QlW2BzEAtHrXOXe0U6hjBTuIuLUrLuLSSNMez++68A?=
 =?us-ascii?Q?yGsxiz9jjYqWfgGPblk42iSBsQa8KG0rLSwjeSrqoXyrHswgOnb0hN4qcISk?=
 =?us-ascii?Q?NuKznsmiBvgH66L2H1fCrjtkB5yaCwrJtz/DU5nFZ29Tnp5cItKv4flgn9MO?=
 =?us-ascii?Q?RMc52XEhh8tvJHR0rL+P70YQK1j1E8HP0UVXQ61JV0AqTLFfVcp1jYVAdQ+G?=
 =?us-ascii?Q?zGOc+F8KiQYrbByGfyxrkgfJ1tXo7N+BivH/B3IGsW1nRemYrffXLo7tA+LE?=
 =?us-ascii?Q?t7EaNCNoInI7yozBE9tyHBBQkRA8lqd2Z2/R7qnNWKA8fWEXHkf9xtNOmDj3?=
 =?us-ascii?Q?vfdeqdfp6y6x9DK7vVumLRzfUaS9RXfpoy8k0+oPdq9DHrBflesmJHnu4zUI?=
 =?us-ascii?Q?a6IhKAyNjf7UHhwH6AX5hRZ4JPgoRNW4gx8KiA1Ejco0FMX4biBxo6hhrpsY?=
 =?us-ascii?Q?w6cggZmcm7ankkRBenZ71j028UASTNLzzs9aba5miBujLEEghVCwKBgvN5+L?=
 =?us-ascii?Q?w5G8o/HhFdjB6yCWzpgFydvnSR7nYDrQ79TcvMYUZGBcegtcpsXZ7EotryV+?=
 =?us-ascii?Q?o+adz6OoKlxmfeLEvHqzsYuA7JE9JLhgQnEexmwNRrAX1ZUXb5UzGBb2Q70r?=
 =?us-ascii?Q?cbWPnGm2hI9qIgfaID+u60puh7A4CeroupDpvkH0u/RVrK8KoTp2MSvqPgjw?=
 =?us-ascii?Q?xo1qD0yYxTwp9Cdz1Em6NN9JRUxsQqJCMIhF2Z7MJ6PS96xjfiTEbBrcbfaw?=
 =?us-ascii?Q?t5Z++49Z8z4c58I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 04:23:42.6178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc73c1a2-cc18-471f-fb04-08dd46660a2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5916
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Certain SOCs may not need much data from VBIOS. Some data like VBIOS
version used will be missed but it doesn't affect functionality. Add a
flag to make VBIOS image optional.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 69 +++++++++++++------
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 16 ++---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  2 +-
 3 files changed, 58 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8549a9477dc9..16a61fa70afb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -103,6 +103,7 @@ MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
 #define AMDGPU_PCIE_DATA_FALLBACK (0x3C >> 2)
 
 #define AMDGPU_VBIOS_SKIP (1U << 0)
+#define AMDGPU_VBIOS_OPTIONAL (1U << 1)
 
 static const struct drm_driver amdgpu_kms_driver;
 
@@ -1391,6 +1392,14 @@ static void amdgpu_block_invalid_wreg(struct amdgpu_device *adev,
 	BUG();
 }
 
+static uint32_t amdgpu_device_get_vbios_flags(struct amdgpu_device *adev)
+{
+	if (hweight32(adev->aid_mask) && (adev->flags & AMD_IS_APU))
+		return AMDGPU_VBIOS_SKIP;
+
+	return 0;
+}
+
 /**
  * amdgpu_device_asic_init - Wrapper for atom asic_init
  *
@@ -1400,18 +1409,28 @@ static void amdgpu_block_invalid_wreg(struct amdgpu_device *adev,
  */
 static int amdgpu_device_asic_init(struct amdgpu_device *adev)
 {
+	uint32_t flags;
+	bool optional;
 	int ret;
 
 	amdgpu_asic_pre_asic_init(adev);
+	flags = amdgpu_device_get_vbios_flags(adev);
+	optional = !!(flags & (AMDGPU_VBIOS_OPTIONAL | AMDGPU_VBIOS_SKIP));
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0)) {
 		amdgpu_psp_wait_for_bootloader(adev);
+		if (optional && !adev->bios)
+			return 0;
+
 		ret = amdgpu_atomfirmware_asic_init(adev, true);
 		return ret;
 	} else {
+		if (optional && !adev->bios)
+			return 0;
+
 		return amdgpu_atom_asic_init(adev->mode_info.atom_context);
 	}
 
@@ -1700,14 +1719,6 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	return 0;
 }
 
-static uint32_t amdgpu_device_get_vbios_flags(struct amdgpu_device *adev)
-{
-	if (hweight32(adev->aid_mask) && (adev->flags & AMD_IS_APU))
-		return AMDGPU_VBIOS_SKIP;
-
-	return 0;
-}
-
 /*
  * GPU helpers function.
  */
@@ -1730,6 +1741,8 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 	flags = amdgpu_device_get_vbios_flags(adev);
 	if (flags & AMDGPU_VBIOS_SKIP)
 		return false;
+	if ((flags & AMDGPU_VBIOS_OPTIONAL) && !adev->bios)
+		return false;
 
 	if (amdgpu_passthrough(adev)) {
 		/* for FIJI: In whole GPU pass-through virtualization case, after VM reboot
@@ -2700,14 +2713,27 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 			skip_bios = !!(bios_flags & AMDGPU_VBIOS_SKIP);
 			/* Read BIOS */
 			if (!skip_bios) {
-				if (!amdgpu_get_bios(adev))
+				bool optional =
+					!!(bios_flags & AMDGPU_VBIOS_OPTIONAL);
+				if (!amdgpu_get_bios(adev) && !optional)
 					return -EINVAL;
 
-				r = amdgpu_atombios_init(adev);
-				if (r) {
-					dev_err(adev->dev, "amdgpu_atombios_init failed\n");
-					amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL, 0, 0);
-					return r;
+				if (optional && !adev->bios)
+					dev_info(
+						adev->dev,
+						"VBIOS image optional, proceeding without VBIOS image");
+
+				if (adev->bios) {
+					r = amdgpu_atombios_init(adev);
+					if (r) {
+						dev_err(adev->dev,
+							"amdgpu_atombios_init failed\n");
+						amdgpu_vf_error_put(
+							adev,
+							AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL,
+							0, 0);
+						return r;
+					}
 				}
 			}
 
@@ -4744,10 +4770,11 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	/* free i2c buses */
 	amdgpu_i2c_fini(adev);
 
-	if (amdgpu_emu_mode != 1)
-		amdgpu_atombios_fini(adev);
-
-	amdgpu_bios_release(adev);
+	if (adev->bios) {
+		if (amdgpu_emu_mode != 1)
+			amdgpu_atombios_fini(adev);
+		amdgpu_bios_release(adev);
+	}
 
 	kfree(adev->fru_info);
 	adev->fru_info = NULL;
@@ -5370,7 +5397,8 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
 	u32 i;
 	int ret = 0;
 
-	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
+	if (adev->bios)
+		amdgpu_atombios_scratch_regs_engine_hung(adev, true);
 
 	dev_info(adev->dev, "GPU mode1 reset\n");
 
@@ -5412,7 +5440,8 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
 		goto mode1_reset_failed;
 	}
 
-	amdgpu_atombios_scratch_regs_engine_hung(adev, false);
+	if (adev->bios)
+		amdgpu_atombios_scratch_regs_engine_hung(adev, false);
 
 	return 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 09c9194d5bd5..89109eb2ce16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -63,10 +63,10 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev, u32 *fru_addr)
 		switch (adev->asic_type) {
 		case CHIP_VEGA20:
 			/* D161 and D163 are the VG20 server SKUs */
-			if (strnstr(atom_ctx->vbios_pn, "D161",
-				    sizeof(atom_ctx->vbios_pn)) ||
-			    strnstr(atom_ctx->vbios_pn, "D163",
-				    sizeof(atom_ctx->vbios_pn))) {
+			if (atom_ctx && (strnstr(atom_ctx->vbios_pn, "D161",
+						 sizeof(atom_ctx->vbios_pn)) ||
+					 strnstr(atom_ctx->vbios_pn, "D163",
+						 sizeof(atom_ctx->vbios_pn)))) {
 				if (fru_addr)
 					*fru_addr = FRU_EEPROM_MADDR_6;
 				return true;
@@ -78,8 +78,8 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev, u32 *fru_addr)
 			return false;
 		}
 	case IP_VERSION(11, 0, 7):
-		if (strnstr(atom_ctx->vbios_pn, "D603",
-			    sizeof(atom_ctx->vbios_pn))) {
+		if (atom_ctx && strnstr(atom_ctx->vbios_pn, "D603",
+					sizeof(atom_ctx->vbios_pn))) {
 			if (strnstr(atom_ctx->vbios_pn, "D603GLXE",
 				    sizeof(atom_ctx->vbios_pn))) {
 				return false;
@@ -94,8 +94,8 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev, u32 *fru_addr)
 		}
 	case IP_VERSION(13, 0, 2):
 		/* All Aldebaran SKUs have an FRU */
-		if (!strnstr(atom_ctx->vbios_pn, "D673",
-			     sizeof(atom_ctx->vbios_pn)))
+		if (atom_ctx && !strnstr(atom_ctx->vbios_pn, "D673",
+					 sizeof(atom_ctx->vbios_pn)))
 			if (fru_addr)
 				*fru_addr = FRU_EEPROM_MADDR_6;
 		return true;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 723c655bb4d5..83b54efcaa87 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -177,7 +177,7 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 	if (!control)
 		return false;
 
-	if (amdgpu_atomfirmware_ras_rom_addr(adev, &i2c_addr)) {
+	if (adev->bios && amdgpu_atomfirmware_ras_rom_addr(adev, &i2c_addr)) {
 		/* The address given by VBIOS is an 8-bit, wire-format
 		 * address, i.e. the most significant byte.
 		 *
-- 
2.25.1

