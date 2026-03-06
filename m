Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D45FCB619
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 15:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 689E710E194;
	Fri,  6 Mar 2026 15:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zm7x09qi";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD14210E194
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 15:36:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twNcbdTwhxx/pEZ9XdDZMhSqfGw66YWNBUhHlGgBRCXSxsR5pnocLGAoE1ytmPfx0l9rSp904uQoNy5twTFYcZ9bBvPBvdPJq1RSfIQafvMFqC2ok17YmGcvuUk8Y/P3IAXDbbtz6Sv3+n/8WbwodXVHwp2PlnNQCnxDU2yRGDEhttyJkKgg5ZgqX/SQQof3Qf0QRocAPNGYxBYsfIH+nXwDqMbSxnr68Zh7sAoQ5D9yiGpgas+cht4m048X88S8m7Db7E5EspmZCzEBbCkKE/YMx7QYK4kmJwYErUXVPXMKLA4fN6jphTKJO5zreCCgz5sn5rgE5i2GhF1NryMMCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYugiyHm5dNlI4yYIc7AiWokSEF024kmf+eQ6JR1PUw=;
 b=Acbo7eM52YOvDFxleulbSls4pBjEv+/k/8daRVYR22UuVN2FKiA3NQouLMbcP2IcPdbqB3o8lH2jWKOzvg1mbe7mfzvhEpN35y9Cvrw1OGIZBXYlSDPGAqP5ywLr0R/lNjAH8hLjSisIz0ROldLLKMfRUDiAaxQxCwQyjDmLLlt9RqTrQHDWWVb2nRtqtyYTzIYNxEQCNzddaxzGskOSa+1jD0Fsx01goDe/rf7wFGu1CcwKCuB/p9T2YHTpE3GU/L8g8fWK4csLY3sJLjhiWj/u1UQU4RoYJTc4Izm+FhzMDsYzMeezj9UPSQq9a/4L3q8k3akrXj5YI6OxiIsZkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYugiyHm5dNlI4yYIc7AiWokSEF024kmf+eQ6JR1PUw=;
 b=zm7x09qi6NN+1ciod8V7VK4m/E0KmIwtNaHOmfhVdfm6BaOwXV3zDjqOJn2Tm1KJ0PF3nAkp2rUNxoJc7T/HUwqdUKpxaLw6ms3kF0bUgB0bus1taY6uh4cC5kqow3dC7fsMy0UQxAmlW93fmgc+lSDR5RhrrJyNEbIaCFV0TGE=
Received: from SA9PR13CA0017.namprd13.prod.outlook.com (2603:10b6:806:21::22)
 by DS0PR12MB8561.namprd12.prod.outlook.com (2603:10b6:8:166::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 15:36:28 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:21:cafe::f0) by SA9PR13CA0017.outlook.office365.com
 (2603:10b6:806:21::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 15:36:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 15:36:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 09:36:27 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 09:36:26 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 09:36:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: New interface to get IP discovery binary v3
Date: Fri, 6 Mar 2026 10:36:14 -0500
Message-ID: <20260306153615.21854-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306153615.21854-1-alexander.deucher@amd.com>
References: <20260306153615.21854-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|DS0PR12MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: 673bd7b1-0d00-44de-f393-08de7b96224c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016; 
X-Microsoft-Antispam-Message-Info: fukqeJEQhScunT44fS4xXO06VHRwXMjMwLp3huefW8ghZ8tfq94wcNG18zDVWZMJbSNgloc8aOCgiAX3bOB2lFTAZV3hvKfVno3ubrX2fiOZttqathNB9BzWJ1biF/PigewuSMyYNH6nF7LZ8K7aVUOrdYY00F+OE0X35vAQ2qIql5G+OjAsw1cBsTB95lKkCHCElLIfZPBJnFPNAFwPWQs1+zmhUfjjJEccdhp4NP0adnoFGChQPd1vfn4OoZAD+MnRwJ54JT0M+pMj1rQyC3WMDLmn7abBPFyBLocNNQ8nIOmxeDzxLYdy6V0c6Zucc+7G8XautfORXocySHZpqDISv7GTDaeL1IqiUNcJjOfGSPWInmRRvwmZUhi2WK7N8A3cutZUVCg2K2py1lodxnXggpNfreDn+ZCImmAMOeyvolexVM5JMf5MXINr00iJhlKaIQWDIUfKKqzuyJF8m2ao8qdvVS5Dr25px+B1H1eNqkBUzM+XlYqknn/rbR3i5FQ+vNI8ldV5+RU/9AO6+Vyvn37JBszD+Txl+uFDG9sMG/pjYI9GazCKAhtpi5nJgXOS21VJT9wt4IB9LYZgPYnkOpVG7LjXYMj1lzc+UlvE3h5ThNZ9/UO+xKlGK+0eWn+Pfu+bzeKRmnbEGYUjXCXGcf5hV2bZ/o0N73EhVWPFv6i6dFrt+8ZACL+tvk+ZM9i/CAID2FmT3Jc8ukhG9hk3x2bmzD62PNw+Gwgxq28kjIkHY2SUb//z2Olg8NCtegk+APu7ahzgwwSbZITJMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5nHTJGRXo2iLSmhG7vHdmax6Oq3+1e4Y+J0iGGQuAZ+3gRAr0XOF3kGIF8mRSUWFqdZmsv8RqlUlvkHIYN/F4ttpIrbON++1pdwS4zC/XhdeXAyF2pEPd+MSgD8Q7d/Pf/87gYtrdLGGaJWWtefaULUXaXAuk7x2JT4X+N2m151rGFzMso/eVVqjWPixeg/J/QrcUaYoxD8wpRuMDt9aU7tbt4GId4Dpd+9ED8FR2xGhYRMPKLMlZ99stOigQzuAnyStxrEWPneHk6ITAs6T6cwMhKDpXpaY7pgTJAuk7meGcMnoPO2ri3eKWAwmzPJY4vNj1dqGBsYeUHA6bemHZkJZ3fzjzpv7er1UgDOtdz44iLFmkbv+Tj/SdSH4pMDg+/yCIkJ64xSb228lXXHlLqTsFA+tUB5CiXEl/fE6FMGoUhwR7T4rU9Yt8VgnpV3T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:36:28.3339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 673bd7b1-0d00-44de-f393-08de7b96224c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8561
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Implement a driver path to read the IP discovery
binary offset and size from DRIVER_SCRATCH registers
BIOS signals usage by setting a feature flag that
instructs the driver to use this method. Otherwise,
fallback to legacy approach.

v2: Simplify discovery offset/size retrieval in
get_tmr_info

v3: Update get_tmr_info to cover discovery offset
and size retrieval for both bare-metal and sriov

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 165 ++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |   1 +
 2 files changed, 93 insertions(+), 73 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 415849bf568b7..36dc0add26f32 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -132,6 +132,7 @@ MODULE_FIRMWARE("amdgpu/picasso_ip_discovery.bin");
 MODULE_FIRMWARE("amdgpu/arcturus_ip_discovery.bin");
 MODULE_FIRMWARE("amdgpu/aldebaran_ip_discovery.bin");
 
+/* Note: These registers are consistent across all the SOCs */
 #define mmIP_DISCOVERY_VERSION  0x16A00
 #define mmRCC_CONFIG_MEMSIZE	0xde3
 #define mmMP0_SMN_C2PMSG_33	0x16061
@@ -139,6 +140,10 @@ MODULE_FIRMWARE("amdgpu/aldebaran_ip_discovery.bin");
 #define mmMM_INDEX_HI		0x6
 #define mmMM_DATA		0x1
 
+#define mmDRIVER_SCRATCH_0	0x94
+#define mmDRIVER_SCRATCH_1	0x95
+#define mmDRIVER_SCRATCH_2	0x96
+
 static const char *hw_id_names[HW_ID_MAX] = {
 	[MP1_HWID]		= "MP1",
 	[MP2_HWID]		= "MP2",
@@ -253,39 +258,12 @@ static int hw_id_map[MAX_HWIP] = {
 	[ATU_HWIP]	= ATU_HWID,
 };
 
-static int amdgpu_discovery_read_binary_from_sysmem(struct amdgpu_device *adev, uint8_t *binary)
+static int amdgpu_discovery_get_tmr_info(struct amdgpu_device *adev,
+					 bool *is_tmr_in_sysmem)
 {
-	u64 tmr_offset, tmr_size, pos;
-	void *discv_regn;
-	int ret;
-
-	ret = amdgpu_acpi_get_tmr_info(adev, &tmr_offset, &tmr_size);
-	if (ret)
-		return ret;
-
-	pos = tmr_offset + tmr_size - DISCOVERY_TMR_OFFSET;
-
-	/* This region is read-only and reserved from system use */
-	discv_regn = memremap(pos, adev->discovery.size, MEMREMAP_WC);
-	if (discv_regn) {
-		memcpy(binary, discv_regn, adev->discovery.size);
-		memunmap(discv_regn);
-		return 0;
-	}
-
-	return -ENOENT;
-}
-
-#define IP_DISCOVERY_V2		2
-#define IP_DISCOVERY_V4		4
-
-static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
-						 uint8_t *binary)
-{
-	bool sz_valid = true;
-	uint64_t vram_size;
-	int i, ret = 0;
-	u32 msg;
+	u64 vram_size, tmr_offset, tmr_size;
+	u32 msg, tmr_offset_lo, tmr_offset_hi;
+	int i, ret;
 
 	if (!amdgpu_sriov_vf(adev)) {
 		/* It can take up to two second for IFWI init to complete on some dGPUs,
@@ -305,51 +283,93 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 	}
 
 	vram_size = RREG32(mmRCC_CONFIG_MEMSIZE);
-	if (!vram_size || vram_size == U32_MAX)
-		sz_valid = false;
+	if (vram_size == U32_MAX)
+		return -ENXIO;
+	else if (!vram_size)
+		*is_tmr_in_sysmem = true;
 	else
-		vram_size <<= 20;
-
-	/*
-	 * If in VRAM, discovery TMR is marked for reservation. If it is in system mem,
-	 * then it is not required to be reserved.
-	 */
-	if (sz_valid) {
-		if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled) {
-			/* For SRIOV VFs with dynamic critical region enabled,
-			 * we will get the IPD binary via below call.
-			 * If dynamic critical is disabled, fall through to normal seq.
-			 */
-			if (amdgpu_virt_get_dynamic_data_info(adev,
-						AMD_SRIOV_MSG_IPD_TABLE_ID, binary,
-						&adev->discovery.size)) {
-				dev_err(adev->dev,
-						"failed to read discovery info from dynamic critical region.");
-				ret = -EINVAL;
-				goto exit;
-			}
-		} else {
-			uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
+		*is_tmr_in_sysmem = false;
 
-			amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
-					adev->discovery.size, false);
-			adev->discovery.reserve_tmr = true;
+	/* init the default tmr size and offset */
+	adev->discovery.size = DISCOVERY_TMR_SIZE;
+	if (vram_size)
+		adev->discovery.offset = (vram_size << 20) - DISCOVERY_TMR_OFFSET;
+
+	if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled) {
+		adev->discovery.offset =
+			adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].offset;
+		adev->discovery.size =
+			adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb << 10;
+		if (!adev->discovery.offset || !adev->discovery.size)
+			return -EINVAL;
+	} else {
+		tmr_size = RREG32(mmDRIVER_SCRATCH_2);
+		if (tmr_size) {
+			/* It's preferred to transition to PSP mailbox reg interface
+			 * for both bare-metal and passthrough if available */
+			adev->discovery.size = (u32)tmr_size;
+			tmr_offset_lo = RREG32(mmDRIVER_SCRATCH_0);
+			tmr_offset_hi = RREG32(mmDRIVER_SCRATCH_1);
+			adev->discovery.offset = ((u64)le32_to_cpu(tmr_offset_hi) << 32 |
+						  le32_to_cpu(tmr_offset_lo));
+		} else if (!vram_size) {
+			/* fall back to apci approach to query tmr offset if vram_size is 0 */
+			ret = amdgpu_acpi_get_tmr_info(adev, &tmr_offset, &tmr_size);
+			if (ret)
+				return ret;
+			adev->discovery.size = (u32)tmr_size;
+			adev->discovery.offset = tmr_offset + tmr_size - DISCOVERY_TMR_OFFSET;
 		}
+	}
+
+	adev->discovery.bin = kzalloc(adev->discovery.size, GFP_KERNEL);
+	if (!adev->discovery.bin)
+		return -ENOMEM;
+	adev->discovery.debugfs_blob.data = adev->discovery.bin;
+	adev->discovery.debugfs_blob.size = adev->discovery.size;
+
+	return 0;
+}
+
+static int amdgpu_discovery_read_binary_from_sysmem(struct amdgpu_device *adev, uint8_t *binary)
+{
+	void *discv_regn;
+
+	/* This region is read-only and reserved from system use */
+	discv_regn = memremap(adev->discovery.offset, adev->discovery.size, MEMREMAP_WC);
+	if (discv_regn) {
+		memcpy(binary, discv_regn, adev->discovery.size);
+		memunmap(discv_regn);
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+#define IP_DISCOVERY_V2		2
+#define IP_DISCOVERY_V4		4
+
+static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
+						 uint8_t *binary,
+						 bool is_tmr_in_sysmem)
+{
+	int ret = 0;
+
+	if (!is_tmr_in_sysmem) {
+		amdgpu_device_vram_access(adev, adev->discovery.offset,
+					  (uint32_t *)binary,
+					  adev->discovery.size, false);
+		adev->discovery.reserve_tmr = true;
 	} else {
 		ret = amdgpu_discovery_read_binary_from_sysmem(adev, binary);
 	}
 
-	if (ret)
-		dev_err(adev->dev,
-			"failed to read discovery info from memory, vram size read: %llx",
-			vram_size);
-exit:
 	return ret;
 }
 
 static int amdgpu_discovery_read_binary_from_file(struct amdgpu_device *adev,
-							uint8_t *binary,
-							const char *fw_name)
+						  uint8_t *binary,
+						  const char *fw_name)
 {
 	const struct firmware *fw;
 	int r;
@@ -602,14 +622,12 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	uint16_t size;
 	uint16_t checksum;
 	uint16_t table_id;
+	bool is_tmr_in_sysmem;
 	int r;
 
-	adev->discovery.bin = kzalloc(DISCOVERY_TMR_SIZE, GFP_KERNEL);
-	if (!adev->discovery.bin)
-		return -ENOMEM;
-	adev->discovery.size = DISCOVERY_TMR_SIZE;
-	adev->discovery.debugfs_blob.data = adev->discovery.bin;
-	adev->discovery.debugfs_blob.size = adev->discovery.size;
+	r = amdgpu_discovery_get_tmr_info(adev, &is_tmr_in_sysmem);
+	if (r)
+		return r;
 
 	discovery_bin = adev->discovery.bin;
 	/* Read from file if it is the preferred option */
@@ -622,7 +640,8 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 			goto out;
 	} else {
 		drm_dbg(&adev->ddev, "use ip discovery information from memory");
-		r = amdgpu_discovery_read_binary_from_mem(adev, discovery_bin);
+		r = amdgpu_discovery_read_binary_from_mem(adev, discovery_bin,
+							  is_tmr_in_sysmem);
 		if (r)
 			goto out;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index 4ce04486cc319..0f8736b49f217 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -34,6 +34,7 @@ struct ip_discovery_top;
 struct amdgpu_discovery_info {
 	struct debugfs_blob_wrapper debugfs_blob;
 	struct ip_discovery_top *ip_top;
+	uint64_t offset;
 	uint32_t size;
 	uint8_t *bin;
 	bool reserve_tmr;
-- 
2.53.0

