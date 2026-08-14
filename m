Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA14C5B572
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 115B210F706;
	Fri, 14 Aug 2026 21:03:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B1Gg4Uil";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013006.outbound.protection.outlook.com
 [40.93.196.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D5010F6F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYtJxeXHV5LTR3Pt8hRLxUYliVADmfw0HVjIqglixpxSg42y9a+QjNnssMAhfCvfRVC2TDJt6E9IAj54ejbryRmpMejAHjBdP5VGvAMT41Tcp8oK6zoNqr7V8vaA3REI3xp7RrRcfz8RtOZ4Cy3U9lschCJTQB2z3YpLdf9+kFIELCbQukXFyHOv8myT/Dyfxiwo1RVCwSDXH5RcvF43Ma+lBmJIBr5P9pKh8vtEMBjnl5kDNbGx4OA8cNzCFo+nwruYhO14jH0Hyy2JBmxkcvKeqFS4qtsMi8OJHMdXyuAxM7IongN8ZiM7VpJ49YiwfuLemnCcptkrf5jkTCY/AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUDcjAgsafsXbop6bHDn3J0g4PfZZ6YZukcUSw2c7+g=;
 b=rNcD1xh6rMn/uhet08+kJZJPrJaE9Tqtxm1qkchLxRZATuXho0oVqBw3Bw2pX2YF0CmW+EOPMPHtcFLpOScVZQ4QvKFnI3U7UpZd23VpNA172C0eJbKdn8RBs+jYox0xGJ23L4rjO0dpMfRe4q+8nF3uy1PBDAko9NqXOYefLPpM1Tx9XDqEsZ9dYZvYWW+twzvJMx0dkWJpJVpofrD6OlkdcFZSJlPQcunFmRKMO3lSmCWmCJ+ZXMQf0zdOttm9Y0TvTlDcrZADE0HI0YlJL/JlUmRuBrmyqsPwfPb+U4VRjDnT74Ts83u4bU0PH79UtXJEsbBquCKsNh5IWSdsZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUDcjAgsafsXbop6bHDn3J0g4PfZZ6YZukcUSw2c7+g=;
 b=B1Gg4UilfR6lT3T1LVN/r+ZSnOJO6zfk4lZqpr/JTEGThz9Bk14zogoxXi+kDTBCHb1gZCdonlWMXNegG82v5+wJyGQ8PEahPuF59c9rCSgkYtyxztew22gNcKFsfSIHPgx32zA+PXFPrej/eU/9yZtgWr3yd5A+E5O7UO22Tcs=
Received: from DS1PR07CA0021.namprd07.prod.outlook.com (2603:10b6:8:44d::8) by
 CY3PR12MB9605.namprd12.prod.outlook.com (2603:10b6:930:103::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.15; Fri, 14 Aug 2026 21:03:19 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:8:44d:cafe::14) by DS1PR07CA0021.outlook.office365.com
 (2603:10b6:8:44d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:19 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:15 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 029/109] drm/amdgpu: factor PSP v1.0 firmware bin descriptor
 parsing
Date: Fri, 14 Aug 2026 17:01:26 -0400
Message-ID: <20260814210246.3067612-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|CY3PR12MB9605:EE_
X-MS-Office365-Filtering-Correlation-Id: 5166967a-a8a4-4a0e-cc10-08defa4777f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|56012099006|10067099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: CaGMjtrnfBFUhsVajjsRjOL67bf5yjhL5wq30sJH74eb2ydHtQnhzH+o0hQigB5ZmOkaiByNRO2zz97SsAaZV1TXUc7nr6q189OA2VtyATEXWFxp7CFeU1HNeWiU9RCbMxYNO14MkZLa4twFeeMLDyGPbjDrckBPsGlejFuaOD6GazUJTnSSSdG8GvKmPHWGANKF+LUxFpTjsO2h/am1yxaXjupjtY5DqLQMuW0kHUNyRHiO/plFGtd2erUomK36U4+Xg5Nif6+9Zp3NM4KV+abyvLkJqQjnpmW14ObtKC4q+GjGQ/x0WyvdlvXtIb0gfXhRSJopnA8B3MR3SxZP+0BbirRRZFU7BItbVPSofRbg6DA0omVlWiuyZCLZhsLUrfKRIwfbyruIu0xVE+Qp0NQ1QojHXWyGu0ULK+MpnmgKcMhn2f6R//teyrpVSJRCH/WfLgP+zomsTVLFUHh23bLQG7xM/808ogNk8Mz/j37bM4gWtpyY3nXD6//myf96dKJmDKTuFW/ns/PgiwE8GjfCkA7zXP4IM+US5PiNDww7PTfFHCaUDHXS2hpZMgpILsYL9wYzQOujqZHs2gTj1H7ppEGGkNDPRJ9o1i44PH3VhoHmJWJWS7WopFeEmV/ioh/nt7ktM9tWjbmItG71taV49iSO1C4CujpnMwqW924yyC2yM288GAz1hVz1CJT3ykAtp/4R7MeZ7mjJicjJAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1GI1x25M+cYuihOiUAB6XCGOpa23YMqYqtCIZACE98K9YMtnCGTKTuppzZwmF/vqUPtVDCYYmyQ2pxk/QWoYO2U0S+ZkWzHcVpVMPmGtrzUsRYV9oG/OIGsdv9nbm85vTGkK/sFDiIzFm9fqX2IPKf0lbgQFaalllWCGEcgjuIsoZ/nQMPsf5C0zJhotguQ8IurLX73lJeicqfYpbujlXGfiHYfYVXFSZYVsom8SLjoGONF74yjwSBvFVz+4+NzWb9liTEsMECdzbEcmIaFw7/meoUHSVFiWB+Gqko949yWVZL9UpWJN0OI9m2ItFmkPNjVJE4I3z1LjGxhQ9udgNOvd/c5Zq7DlyDuTtPUrtcEIiEEHJJd3CXJQalVUmSfP1Cc5pYomDHdQDZYTCLtA5qCbFgFjeMuZXdVjSW2Ow8uhYwjruXvFbChE9zrxhymm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:19.4768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5166967a-a8a4-4a0e-cc10-08defa4777f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9605
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

From: Candice Li <candice.li@amd.com>

Add parse_psp_v1_bin_descriptor to populate struct psp_bin_desc
from psp_firmware_header_v1_0, shared by ASD, TOC and CAP
standalone firmware loads.

Use psp-> fields directly instead of adev->psp.

v2: code rebase
v3: Rename v1 header helper to parse_psp_v1_bin_descriptor,
    have it return an error code with explicit NULL checks.
    Rename sos v2 helper to parse_psp_v2_bin_descriptor for symmetry.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 93 ++++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  4 +-
 3 files changed, 55 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index ad58d422204e8..f2f179421c4da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -349,8 +349,8 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
 		fw_info->feature = adev->psp.toc.feature_version;
 		break;
 	case AMDGPU_INFO_FW_CAP:
-		fw_info->ver = adev->psp.cap_fw_version;
-		fw_info->feature = adev->psp.cap_feature_version;
+		fw_info->ver = adev->psp.cap.fw_version;
+		fw_info->feature = adev->psp.cap.feature_version;
 		break;
 	case AMDGPU_INFO_FW_MES_KIQ:
 		fw_info->ver = adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 04f6ebf31cca5..d7d6623b51da6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3960,58 +3960,72 @@ int psp_ring_cmd_submit(struct psp_context *psp,
 	return 0;
 }
 
+/**
+ * parse_psp_v1_bin_descriptor - Populate struct psp_bin_desc from a
+ * v1.0 PSP firmware header (standalone images such as ASD or TOC).
+ */
+static int parse_psp_v1_bin_descriptor(struct psp_bin_desc *desc,
+					const struct psp_firmware_header_v1_0 *hdr)
+{
+	if (!desc || !hdr)
+		return -EINVAL;
+
+	desc->fw_version = le32_to_cpu(hdr->header.ucode_version);
+	desc->feature_version = le32_to_cpu(hdr->sos.fw_version);
+	desc->size_bytes = le32_to_cpu(hdr->header.ucode_size_bytes);
+	desc->start_addr = (uint8_t *)hdr +
+			   le32_to_cpu(hdr->header.ucode_array_offset_bytes);
+
+	return 0;
+}
+
 int psp_init_asd_microcode(struct psp_context *psp, const char *chip_name)
 {
-	struct amdgpu_device *adev = psp->adev;
-	const struct psp_firmware_header_v1_0 *asd_hdr;
-	int err = 0;
+	int err;
 
-	err = amdgpu_ucode_request(adev, &adev->psp.asd_fw, AMDGPU_UCODE_REQUIRED,
+	err = amdgpu_ucode_request(psp->adev, &psp->asd_fw, AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_asd.bin", chip_name);
 	if (err)
 		goto out;
 
-	asd_hdr = (const struct psp_firmware_header_v1_0 *)adev->psp.asd_fw->data;
-	adev->psp.asd_context.bin_desc.fw_version = le32_to_cpu(asd_hdr->header.ucode_version);
-	adev->psp.asd_context.bin_desc.feature_version = le32_to_cpu(asd_hdr->sos.fw_version);
-	adev->psp.asd_context.bin_desc.size_bytes = le32_to_cpu(asd_hdr->header.ucode_size_bytes);
-	adev->psp.asd_context.bin_desc.start_addr = (uint8_t *)asd_hdr +
-				le32_to_cpu(asd_hdr->header.ucode_array_offset_bytes);
+	err = parse_psp_v1_bin_descriptor(&psp->asd_context.bin_desc,
+		    (const struct psp_firmware_header_v1_0 *)psp->asd_fw->data);
+	if (err)
+		goto out;
+
 	return 0;
 out:
-	amdgpu_ucode_release(&adev->psp.asd_fw);
+	amdgpu_ucode_release(&psp->asd_fw);
 	return err;
 }
 
 int psp_init_toc_microcode(struct psp_context *psp, const char *chip_name)
 {
-	struct amdgpu_device *adev = psp->adev;
-	const struct psp_firmware_header_v1_0 *toc_hdr;
-	int err = 0;
+	int err;
 
-	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(15, 0, 8) &&
-	    adev->rev_id == 0)
-		err = amdgpu_ucode_request(adev, &adev->psp.toc_fw, AMDGPU_UCODE_REQUIRED,
+	if (amdgpu_ip_version(psp->adev, MP0_HWIP, 0) == IP_VERSION(15, 0, 8) &&
+	    psp->adev->rev_id == 0 &&
+	    !amdgpu_emu_mode)
+		err = amdgpu_ucode_request(psp->adev, &psp->toc_fw, AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_toc_1.bin", chip_name);
 	else
-		err = amdgpu_ucode_request(adev, &adev->psp.toc_fw, AMDGPU_UCODE_REQUIRED,
+		err = amdgpu_ucode_request(psp->adev, &psp->toc_fw, AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_toc.bin", chip_name);
 	if (err)
 		goto out;
 
-	toc_hdr = (const struct psp_firmware_header_v1_0 *)adev->psp.toc_fw->data;
-	adev->psp.toc.fw_version = le32_to_cpu(toc_hdr->header.ucode_version);
-	adev->psp.toc.feature_version = le32_to_cpu(toc_hdr->sos.fw_version);
-	adev->psp.toc.size_bytes = le32_to_cpu(toc_hdr->header.ucode_size_bytes);
-	adev->psp.toc.start_addr = (uint8_t *)toc_hdr +
-				le32_to_cpu(toc_hdr->header.ucode_array_offset_bytes);
+	err = parse_psp_v1_bin_descriptor(&psp->toc,
+		    (const struct psp_firmware_header_v1_0 *)psp->toc_fw->data);
+	if (err)
+		goto out;
+
 	return 0;
 out:
-	amdgpu_ucode_release(&adev->psp.toc_fw);
+	amdgpu_ucode_release(&psp->toc_fw);
 	return err;
 }
 
-static int parse_sos_bin_descriptor(struct psp_context *psp,
+static int parse_psp_v2_bin_descriptor(struct psp_context *psp,
 				   const struct psp_fw_bin_desc *desc,
 				   const struct psp_firmware_header_v2_0 *sos_hdr)
 {
@@ -4241,7 +4255,7 @@ int psp_init_sos_microcode(struct psp_context *psp, const char *chip_name)
 		}
 
 		for (fw_index = start_index; fw_index < fw_bin_count; fw_index++) {
-			err = parse_sos_bin_descriptor(psp, fw_bin + fw_index,
+			err = parse_psp_v2_bin_descriptor(psp, fw_bin + fw_index,
 						       sos_hdr_v2_0);
 			if (err)
 				goto out;
@@ -4476,16 +4490,15 @@ int psp_init_ta_microcode(struct psp_context *psp, const char *chip_name)
 int psp_init_cap_microcode(struct psp_context *psp, const char *chip_name)
 {
 	struct amdgpu_device *adev = psp->adev;
-	const struct psp_firmware_header_v1_0 *cap_hdr_v1_0;
-	struct amdgpu_firmware_info *info = NULL;
-	int err = 0;
+	struct amdgpu_firmware_info *info;
+	int err;
 
 	if (!amdgpu_sriov_vf(adev)) {
 		dev_err(adev->dev, "cap microcode should only be loaded under SRIOV\n");
 		return -EINVAL;
 	}
 
-	err = amdgpu_ucode_request(adev, &adev->psp.cap_fw, AMDGPU_UCODE_OPTIONAL,
+	err = amdgpu_ucode_request(adev, &psp->cap_fw, AMDGPU_UCODE_OPTIONAL,
 				   "amdgpu/%s_cap.bin", chip_name);
 	if (err) {
 		if (err == -ENODEV) {
@@ -4497,21 +4510,19 @@ int psp_init_cap_microcode(struct psp_context *psp, const char *chip_name)
 		goto out;
 	}
 
+	err = parse_psp_v1_bin_descriptor(&psp->cap,
+		(const struct psp_firmware_header_v1_0 *)psp->cap_fw->data);
+	if (err)
+		goto out;
+
 	info = &adev->firmware.ucode[AMDGPU_UCODE_ID_CAP];
 	info->ucode_id = AMDGPU_UCODE_ID_CAP;
-	info->fw = adev->psp.cap_fw;
-	cap_hdr_v1_0 = (const struct psp_firmware_header_v1_0 *)
-		adev->psp.cap_fw->data;
-	adev->firmware.fw_size += ALIGN(
-			le32_to_cpu(cap_hdr_v1_0->header.ucode_size_bytes), PAGE_SIZE);
-	adev->psp.cap_fw_version = le32_to_cpu(cap_hdr_v1_0->header.ucode_version);
-	adev->psp.cap_feature_version = le32_to_cpu(cap_hdr_v1_0->sos.fw_version);
-	adev->psp.cap_ucode_size = le32_to_cpu(cap_hdr_v1_0->header.ucode_size_bytes);
-
+	info->fw = psp->cap_fw;
+	adev->firmware.fw_size += ALIGN(psp->cap.size_bytes, PAGE_SIZE);
 	return 0;
 
 out:
-	amdgpu_ucode_release(&adev->psp.cap_fw);
+	amdgpu_ucode_release(&psp->cap_fw);
 	return err;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index d80c85793e3b9..4047706c1ce22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -448,9 +448,7 @@ struct psp_context {
 	const struct firmware		*ta_fw;
 	uint32_t			ta_fw_version;
 
-	uint32_t			cap_fw_version;
-	uint32_t			cap_feature_version;
-	uint32_t			cap_ucode_size;
+	struct psp_bin_desc		cap;
 
 	struct ta_context		asd_context;
 	struct psp_xgmi_context		xgmi_context;
-- 
2.55.0

