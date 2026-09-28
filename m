Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41B4CA5FA2
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 16:44:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EEC910E2A8;
	Mon, 28 Sep 2026 16:44:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0gLhkzj/";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010056.outbound.protection.outlook.com [52.101.85.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F00AC10E2A8
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 16:44:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iv2HGd3uyPUUq8JL/A5Xyh8NcTt214FkSCsHk81ZhKe7+7CPZz3JvyKHeVqr22pdELvRi2KU5I/adV9WJLHgoAPbemRlL6/rGPircJaExkysJXMdovlEn4y8jVACf4no16W4/let4ReEk8P6I/kF+oKhCroJ8dsnt3vMFjgTF3RBHLD3motR2/h2FiYsfiMve7qlZrvr/TeN9+uVO6bnA6+wJYGrCePIFyr49tdLKbm+cMKRdq6t7fb1ZNzRqMxJywJp2bE2zEKC1P8ewRBqqMuyVRkB2KxgHPVRbYDYjVdqeEFnHvOyg3mqHJ7sJr9lRi517uiHHpnH/Kbh4lcXDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQnSbcayjxyq63W8MzUzpHnbk1VY2jdXn4O63fY6rCM=;
 b=clYff+TujXAKRXw0lMJnoDlBGWAU9z35mZGSNCzjpAqQdq9aN8r4ABE4u58xUNWOOTCy5BEMFkbFXM5NIe4yhr+u2u8hHJiUzEXbPeKGvrloH+uIvqF7uGNUsJYK37X7Hcpg617t/fRdWnPmiuBElqdLSxJMBmUQMxezypW6/N5UNsrNm0v7dThdILiwnm9NI+vK2gW6WQ80nY5h5fcOpSEM73VvsUV5vsgRp5No3V8dBe8Nl9JTrVxHsG7CfFF8r22nnpr0ztP3hixsRB2GYY8ogHN5jkLMleqAYTTPNfILCfY0Q3Tf2pINsOrp1TIdKp18uEd83Ub8dEh2qIhf6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQnSbcayjxyq63W8MzUzpHnbk1VY2jdXn4O63fY6rCM=;
 b=0gLhkzj/TZ/xmic0HD+1XpjwrZjAjZSq+GBp0IXO/vxj8Hs3FSfleOFtlvTN58OqC+bOVtYMAnMKOimjEEo87zYJ+tvRC4bKBxRWZmHklV6fOIEEJDzPM9YZ0x5ehItnPQ0QHW+SoZipsFfYTLtGE3lABNd12lbtiEtSWoVGsrE=
Received: from BN9PR03CA0776.namprd03.prod.outlook.com (2603:10b6:408:13a::31)
 by DS6PR12MB777192.namprd12.prod.outlook.com (2603:10b6:8:411::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 16:44:47 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::36) by BN9PR03CA0776.outlook.office365.com
 (2603:10b6:408:13a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 16:44:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 16:44:47 +0000
Received: from MKMZHLUO01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 11:44:46 -0500
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Philip.Yang@amd.com>,
 <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>, <Gavin.Wan@amd.com>,
 <Victor.Skvortsov@amd.com>, Zhigang Luo <Zhigang.Luo@amd.com>, Zhigang Luo
 <zhigang.luo@amd.com>, Fangsheng Huang <Fangsheng.Huang@amd.com>, YuBiao Wang
 <YuBiao.Wang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH 3/6] drm/amdgpu: fetch the A+A VF VBIOS from the SRAT HBM range
Date: Mon, 28 Sep 2026 12:44:17 -0400
Message-ID: <20260928164421.10144-3-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928164421.10144-1-Zhigang.Luo@amd.com>
References: <20260928164421.10144-1-Zhigang.Luo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|DS6PR12MB777192:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c8cde0-33df-4483-6c61-08df1d7fced2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|10067099003|11063799006|6133799003|22082099003|10063799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: FAqCo3yaj1PlsNUcB2gd3+Xx9vDLQRDsDNJRXjd0NvJ1YJ3BRpSALLZ+6lKWawoTJY+lJatZ+bf1D006JThh/lWwoG0wQwdrloyk8jguOY3VnvZhjBaVnw135qEe9i13wbs1MOX2NWfe2BfqlKoJqkvIO3jlofblcG9IdFXyy0PdIJkCgauk3XYp/GzpPW7P37xXfROPnV2odaICMP8NDaj76X3LMNGd7VAyYML81/p1ist5Dn/ym1wub8wfVOC+TMDW766wi2SG8sKjn9LmdFMqUixB9wxGqzZE3mcQckDTvUQHMGRIKQfVqaOfwu9Mnlm3kGpHAmvWKr7CD1aL9ZoUQf6c2p7PUVaTnjecMHe/ICIDnOegzJVHUEPL67+jI1l1UGtZ8uoflwB1f2tbOEQteR7QxIzXPMoxym1q2xZ1Da59+BkPvimJIgkN+8tah/HwXQf1TIYD1LWbrVXxX3kqWKQzQYU0APSFjYGPbrFGTGPGOf8Rbuw6lsi9g3xCiJJbVUlfZHOgTmaDQQRrqF3loWsk3NOf+Iv9wfg9OgtrfP52deKTYwoVpW/AuzHymedWWzAQpyQiSyVRQ1NQiJFSGSmdMmvKgwQ3C1ksCtPEkPRcv25P87nqOeES10nDPqwVdrQH8IRpnd4WAatAyF9hUI0Egm/hNnJD/Xv8rKc4TOXM93JI7EF6XitoDZ8eEOZIcEc63WHllSL09IQaKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(10067099003)(11063799006)(6133799003)(22082099003)(10063799003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SmajGe0Dird82ZSPb+0QR05njEsEBG2NtKtSi1asYR6r7NRe2S1xcXeC5kLuTzFpyPU5ejj7pSexgufKxD1nIPVzeq4Ua6dZE9Xx1uS6tP7etd1wss/xEm0nffGyK+dByjHQH2xKJrgYaaUhMsMk2ctoTy5Si+uJXEH8Oe7G8QvBIdrqA9E8xX9iLA252EiqsyWxZbQhYAwrs8JyU+SE/GUtbjP9y6ZgPx0Tw4YvY6r0JCXWTi0kKllQEAEwKKZj+i3xvL5ycz6TIBGGsGy/SnxvrjoFE+lDlRwiltgtV8U6nsbcJhM8yf9vahspv6gsradcwMz8oHWCg0buXKc0fBieri3RXUj2bZJ1sPmV2+/uTVNxKgyjujTKvB0fO3pJoJarja35aY356mVr8dMKIZvsgQARg+Rn3Nsz/IOzv+4+baRGIj1eV7t0uBey+bXp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:44:47.7312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c8cde0-33df-4483-6c61-08df1d7fced2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB777192
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

On A+A the VF has no usable FB BAR, so the VBIOS copy cannot be read
through BAR 0. It lives in HBM, which the SRAT describes as
specific-purpose memory reachable at a system physical address.

Add a dedicated amdgpu_read_bios_from_spm() path that resolves the HBM
range from SRAT and maps it as write-back system memory. Keep the
existing SR-IOV dynamic critical region path when it is enabled,
matching the VRAM reader.

v2:
- Use a separate amdgpu_read_bios_from_spm() helper and leave
  amdgpu_read_bios_from_vram() unchanged.
- Keep the SR-IOV dynamic critical region path for SPM-backed VBIOS.
- Fetch VBIOS after the COMMON block and make it optional for
  SPM-backed SR-IOV VF and passthrough configurations.

v3:
- Keep the SRAT range local to the VBIOS path; GMC owns aper_base and
  aper_size.
- Map SPM with memremap(), memcpy(), and memunmap().
- Rely on amdgpu_virt_vram_is_spm() without redundant VF/passthrough
  checks.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
Signed-off-by: Fangsheng Huang <Fangsheng.Huang@amd.com>
Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c   | 55 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 ++
 2 files changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 08ed1eb69558..f9315e0472fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -152,6 +152,56 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
 	return true;
 }
 
+static bool amdgpu_read_bios_from_spm(struct amdgpu_device *adev)
+{
+	u64 spm_base, spm_size;
+	void *bios = NULL;
+	u32 size = 256U * 1024U; /* ??? */
+	int r;
+
+	if (!amdgpu_virt_vram_is_spm(adev))
+		return false;
+
+	r = amdgpu_acpi_find_gpu_memory_in_srat(adev, &spm_base, &spm_size);
+	if (r)
+		return false;
+
+	adev->bios = kmalloc(size, GFP_KERNEL);
+	if (!adev->bios)
+		return false;
+
+	/* For SRIOV with dynamic critical region is enabled,
+	 * the vbios image is put at a dynamic offset of VRAM in the VF.
+	 * If dynamic critical region is disabled, read it from SPM.
+	 */
+	if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled) {
+		if (amdgpu_virt_get_dynamic_data_info(adev,
+						      AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID,
+						      adev->bios, &size)) {
+			amdgpu_bios_release(adev);
+			return false;
+		}
+	} else {
+		bios = memremap(spm_base, size, MEMREMAP_WB);
+		if (!bios) {
+			amdgpu_bios_release(adev);
+			return false;
+		}
+
+		memcpy(adev->bios, bios, size);
+		memunmap(bios);
+	}
+
+	adev->bios_size = size;
+
+	if (!check_atom_bios(adev, size)) {
+		amdgpu_bios_release(adev);
+		return false;
+	}
+
+	return true;
+}
+
 bool amdgpu_read_bios(struct amdgpu_device *adev)
 {
 	uint8_t __iomem *bios;
@@ -530,6 +580,11 @@ static bool amdgpu_get_bios_dgpu(struct amdgpu_device *adev)
 		goto success;
 	}
 
+	if (amdgpu_read_bios_from_spm(adev)) {
+		dev_info(adev->dev, "Fetched VBIOS from SPM\n");
+		goto success;
+	}
+
 	/* this is required for SR-IOV */
 	if (amdgpu_read_bios_from_vram(adev)) {
 		dev_info(adev->dev, "Fetched VBIOS from VRAM BAR\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 96165b1b3e6d..4b43c80a30af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -944,6 +944,9 @@ u32 amdgpu_device_get_rev_id(struct amdgpu_device *adev)
 
 static uint32_t amdgpu_device_get_vbios_flags(struct amdgpu_device *adev)
 {
+	if (amdgpu_virt_vram_is_spm(adev))
+		return AMDGPU_VBIOS_OPTIONAL;
+
 	if (hweight32(adev->aid_mask) && (adev->flags & AMD_IS_APU))
 		return AMDGPU_VBIOS_SKIP;
 
-- 
2.43.0

