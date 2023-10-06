Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF3EE92FF9
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 09:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 505B610E0A5;
	Fri,  6 Oct 2023 09:34:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE70E10E06B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 09:34:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrVmTEZXc87IgyfL5gGPB7b7UK1RkAh90OurAD+J6qYnsi4ChOuLwRa/vgVfLS+4XnwPA3ArAkYvqcdXxi/Bax7my9kchgrNRd1+enIjmphMP8npb1j0PajFlscyE09KwWsjBt69MMVxRBBuTZMkGDT2u0xhXeSRfTlkEIjeVrfs1qZZbtt7znR0auQMvhEk3jAHL6GZb8YRarhtrR++BZCd6oVeYOy6MLzCB3wuSzgQNpeI09J0g/+65UZh5WTDRi9AW1FnhjXhBb4jZ0i8rSMadj6I0m5BHCZWEPPUYFhkERXkkjYaavH5AnItHwvmUbzBgsFpBYI6P5ctzNa4pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylStLcg+Zo/pncqWJqCszkdteEsBUpFc9MNj65xNqa8=;
 b=EoNWoDVU2Bitw0zHHGiyQ1dJm4Hd6GkwK0FIvTv2eyJmJM/NflGodEnYMmK3Ru9wRuJf997uA2GFh+ueJISPvLigCEZewc1sh0xWAGY1/dc4GoYNnUCu//jYR7/q7gYjz+xgs2XorApwA8yAzinKl9ZKPQUdsqhJBzRJB52kFSxFE7g98ndNrTmUBst86ALa4T0LQnFHoYWfv6mFDVkFpNgv4+RnX9vWWG83TQw6qn9NlL8HSK5gT6hcjsqK7GFNxRx725W9JaHWUJnMPvZpQvw9qyP8fexooT0w9M9AwLDWN7QWeYxoAfXmceVTKzU0VEselQf+dv/abQiTUf5GOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylStLcg+Zo/pncqWJqCszkdteEsBUpFc9MNj65xNqa8=;
 b=laY4qHn+1rHhYMuHsaQI5JjnNihqVPudQVDSa0dY6iAzlIdVq5knnSDYtvRWKP89ntZVGdNX0sVAOHf+2fI7K+IelLEKD0I2m31maL9jSo/LStSEKUjuZWE2554mAVkSoUwnEcMbo4EN8uEpUWjw9VFBcKCn2rHM1Ln2hI8RJCc=
Received: from MW4PR04CA0075.namprd04.prod.outlook.com (2603:10b6:303:6b::20)
 by SJ0PR12MB8089.namprd12.prod.outlook.com (2603:10b6:a03:4eb::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Fri, 6 Oct
 2023 09:34:22 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::62) by MW4PR04CA0075.outlook.office365.com
 (2603:10b6:303:6b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34 via Frontend
 Transport; Fri, 6 Oct 2023 09:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 09:34:22 +0000
Received: from amd-mlse-mangesh.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 04:34:18 -0500
From: Mangesh Gadre <Mangesh.Gadre@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>, <Le.Ma@amd.com>, 
 <shiwu.zhang@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu:common ta binary handling
Date: Fri, 6 Oct 2023 17:33:42 +0800
Message-ID: <20231006093342.3902490-1-Mangesh.Gadre@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|SJ0PR12MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: cd43dd6d-a4d1-4728-90dc-08dbc64f6c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zrhplaekvrU6nmMu5p2lQi8U1hxrR4uF6G/GTCslLc3y+Knv94KXEWm3DaMpIKbNeCxiObfCYH/zHh5diFnEuf/nhisc4Q1mfFX/tDZLhSfWB4tndc4xQ5E4jCBexNTtkWfzopoNye6CrKGmRdvbIjJa5sCt9poyuwMaleTajybD0t+o10N95vO5wn3zVKa63OPRaDFZ5Dbq+Q3lM/ryDDL6ZSs01Qhn7iDlfETmEnTNYxoxauwDAqFHKXUd5mXm3CvFSxAegD+4bOZVF5M1Dw4Bmc/c3CBk5PiXwxc/dGxd2qY3nZNUOU1Q7ZmquB9I4HBhRtNeFW4OscIlmGsGOcvp6/xLqHrlJva8iGAOfghd4+wLhrg0L/tmzO4g/Pxju5Zk4WjTBBAX5KkRvquRQCY4kT/4f0udjMK6d7mgURiIJlczqwLTW3FPWE9LAiUMNPuXDFm9UpH/Kux6hoFGdZi3AXodGfWbtx41fE8o/wOyYU4JXIfkahoSEjwYT4bL6uw/Bo4i2NnDFgUxo0fPjs0Ng7EosURuzdCC9Ks9ONFtloRJJ7AtSBVcdkF6ZJez4QkPcTscVv+q8BsT4/a6j0ETbgLZwG9ESyF03hETb/4evjj5HGM+gnARDYCEfzf4HwF8WHgs2RRE4DVkau+5c0lazKm4ej8hGp9LFld78XcG+RjxVKibqm7A92dgg4sXitGuzjcyODZVY1lZIBPeqI8BeaMnvZJyFnVDriUt3B3gPOgOVKrsroir/60Z6oUERibBH9pv5PpaiHJJKV+luw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(81166007)(82740400003)(356005)(40480700001)(36756003)(336012)(16526019)(41300700001)(70586007)(26005)(2616005)(426003)(70206006)(1076003)(316002)(110136005)(40460700003)(6636002)(6666004)(478600001)(7696005)(54906003)(5660300002)(36860700001)(47076005)(2906002)(86362001)(8936002)(8676002)(4326008)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 09:34:22.1201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd43dd6d-a4d1-4728-90dc-08dbc64f6c2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8089
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
Cc: Mangesh Gadre <Mangesh.Gadre@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Support handling common TA binary for dGPUs and APUs

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 85 ++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 16 +++++
 2 files changed, 90 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 72ee66db182c..72796671dd2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3279,17 +3279,12 @@ int psp_init_sos_microcode(struct psp_context *psp, const char *chip_name)
 
 static int parse_ta_bin_descriptor(struct psp_context *psp,
 				   const struct psp_fw_bin_desc *desc,
-				   const struct ta_firmware_header_v2_0 *ta_hdr)
+				   uint8_t *ucode_start_addr)
 {
-	uint8_t *ucode_start_addr  = NULL;
 
-	if (!psp || !desc || !ta_hdr)
+	if (!psp || !desc || !ucode_start_addr)
 		return -EINVAL;
 
-	ucode_start_addr  = (uint8_t *)ta_hdr +
-			    le32_to_cpu(desc->offset_bytes) +
-			    le32_to_cpu(ta_hdr->header.ucode_array_offset_bytes);
-
 	switch (desc->fw_type) {
 	case TA_FW_TYPE_PSP_ASD:
 		psp->asd_context.bin_desc.fw_version        = le32_to_cpu(desc->fw_version);
@@ -3397,11 +3392,17 @@ static int parse_ta_v2_microcode(struct psp_context *psp)
 {
 	const struct ta_firmware_header_v2_0 *ta_hdr;
 	struct amdgpu_device *adev = psp->adev;
+	struct psp_fw_bin_desc *desc = NULL;
 	int err = 0;
 	int ta_index = 0;
+	uint8_t *ucode_array_start = NULL;
+	uint8_t *ucode_start_addr = NULL;
 
 	ta_hdr = (const struct ta_firmware_header_v2_0 *)adev->psp.ta_fw->data;
 
+	ucode_array_start = (uint8_t *)ta_hdr +
+			   le32_to_cpu(ta_hdr->header.ucode_array_offset_bytes);
+
 	if (le16_to_cpu(ta_hdr->header.header_version_major) != 2)
 		return -EINVAL;
 
@@ -3411,9 +3412,13 @@ static int parse_ta_v2_microcode(struct psp_context *psp)
 	}
 
 	for (ta_index = 0; ta_index < le32_to_cpu(ta_hdr->ta_fw_bin_count); ta_index++) {
-		err = parse_ta_bin_descriptor(psp,
-					      &ta_hdr->ta_fw_bin[ta_index],
-					      ta_hdr);
+
+		desc = (struct psp_fw_bin_desc *)&ta_hdr->ta_fw_bin[ta_index];
+
+		ucode_start_addr  = ucode_array_start +
+					le32_to_cpu(desc->offset_bytes);
+
+		err = parse_ta_bin_descriptor(psp, desc, ucode_start_addr);
 		if (err)
 			return err;
 	}
@@ -3421,6 +3426,61 @@ static int parse_ta_v2_microcode(struct psp_context *psp)
 	return 0;
 }
 
+#define FW_VALID_DGPU	0x00000002
+#define FW_VALID_APU	0x00000001
+
+static int parse_ta_v2_1_microcode(struct psp_context *psp)
+{
+	const struct ta_firmware_header_v2_1 *ta_hdr;
+	struct amdgpu_device *adev = psp->adev;
+	struct ta_fw_bin_desc_v1_1 *desc = NULL;
+	struct psp_fw_bin_desc psp_fw_bin_descriptor;
+	int err = 0;
+	int ta_index = 0;
+	uint8_t *ucode_array_start = NULL;
+	uint8_t *ucode_start_addr = NULL;
+
+	ta_hdr = (const struct ta_firmware_header_v2_1 *)adev->psp.ta_fw->data;
+
+	ucode_array_start = (uint8_t *)ta_hdr +
+			le32_to_cpu(ta_hdr->header.ucode_array_offset_bytes);
+
+	if ((le16_to_cpu(ta_hdr->header.header_version_major) != 2) &&
+		(le16_to_cpu(ta_hdr->header.header_version_minor) != 1))
+		return -EINVAL;
+
+	if (le32_to_cpu(ta_hdr->ta_fw_bin_count) >= UCODE_MAX_PSP_PACKAGING) {
+		dev_err(adev->dev, "packed TA count exceeds maximum limit\n");
+		return -EINVAL;
+	}
+
+	for (ta_index = 0; ta_index < le32_to_cpu(ta_hdr->ta_fw_bin_count); ta_index++) {
+
+		desc = (struct ta_fw_bin_desc_v1_1 *)&ta_hdr->ta_fw_bin[ta_index];
+
+		if (((adev->flags & AMD_IS_APU) &&
+		     (le32_to_cpu((desc->fw_valid_flags)) & FW_VALID_APU)) ||
+		     (!(adev->flags & AMD_IS_APU) &&
+		     (le32_to_cpu((desc->fw_valid_flags)) & FW_VALID_DGPU))) {
+
+			ucode_start_addr = ucode_array_start +
+					le32_to_cpu(desc->offset_bytes);
+
+			psp_fw_bin_descriptor.fw_type = desc->fw_type;
+			psp_fw_bin_descriptor.fw_version = desc->fw_version;
+			psp_fw_bin_descriptor.offset_bytes = desc->offset_bytes;
+			psp_fw_bin_descriptor.size_bytes = desc->size_bytes;
+
+			err = parse_ta_bin_descriptor(psp,
+							&psp_fw_bin_descriptor,
+							ucode_start_addr);
+			if (err)
+				return err;
+			}
+	}
+	return 0;
+}
+
 int psp_init_ta_microcode(struct psp_context *psp, const char *chip_name)
 {
 	const struct common_firmware_header *hdr;
@@ -3439,7 +3499,10 @@ int psp_init_ta_microcode(struct psp_context *psp, const char *chip_name)
 		err = parse_ta_v1_microcode(psp);
 		break;
 	case 2:
-		err = parse_ta_v2_microcode(psp);
+		if (le16_to_cpu(hdr->header_version_minor) == 1)
+			err = parse_ta_v2_1_microcode(psp);
+		else
+			err = parse_ta_v2_microcode(psp);
 		break;
 	default:
 		dev_err(adev->dev, "unsupported TA header version\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index ae5fa61d2890..8c6094ee60c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -157,6 +157,14 @@ enum ta_fw_type {
 	TA_FW_TYPE_MAX_INDEX,
 };
 
+struct ta_fw_bin_desc_v1_1 {
+	uint32_t fw_type;
+	uint32_t fw_valid_flags;
+	uint32_t fw_version;
+	uint32_t offset_bytes;
+	uint32_t size_bytes;
+};
+
 /* version_major=2, version_minor=0 */
 struct ta_firmware_header_v2_0 {
 	struct common_firmware_header header;
@@ -164,6 +172,13 @@ struct ta_firmware_header_v2_0 {
 	struct psp_fw_bin_desc ta_fw_bin[];
 };
 
+/* version_major=2, version_minor=1 */
+struct ta_firmware_header_v2_1 {
+	struct common_firmware_header header;
+	uint32_t ta_fw_bin_count;
+	struct ta_fw_bin_desc_v1_1 ta_fw_bin[];
+};
+
 /* version_major=1, version_minor=0 */
 struct gfx_firmware_header_v1_0 {
 	struct common_firmware_header header;
@@ -419,6 +434,7 @@ union amdgpu_firmware_header {
 	struct psp_firmware_header_v2_0 psp_v2_0;
 	struct ta_firmware_header_v1_0 ta;
 	struct ta_firmware_header_v2_0 ta_v2_0;
+	struct ta_firmware_header_v2_1 ta_v2_1;
 	struct gfx_firmware_header_v1_0 gfx;
 	struct gfx_firmware_header_v2_0 gfx_v2_0;
 	struct rlc_firmware_header_v1_0 rlc;
-- 
2.34.1

