Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48680C6FA86
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 17:02:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B40D510EB8D;
	Thu, 15 Sep 2022 17:02:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 041A610EB8C
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 17:02:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWlPU0ppYRA/rK+fV8XDd5WDo3wlmaWwd/OvOY0KO5LkJe8jIae4SFXzzGSTJsxNehh4YF+Vjl3aJUrCrQPYJOalo3i6pXKcx9A1Ny+1IbYlu+6nVP0Wki3ItpSO3gqplUHz6+IHbe32PH10M0aeAn7VSucGT8EPTYXATfryNJNyXjOgQS0i04qVeBEobvlC1Vl11zACgzI9ipLYJ/eSnxe8urawEERQWTV9IAeWCpJVxV6ddzksbz9/+TtKtJzcMB5M1mcNADdr1qhxlIa1YjrCZfPk01GD9xQQnNd4x2vy0Csf0FZR2iKv6n4yxt5CbxdOlZ/7uccWUfSNlV5BlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b51H4MZYd7+AqE1DO44DsXCTvQX62tGCiA8NiDw2JfI=;
 b=P9zkOjnKqpTtM8JGSydSxKqSb/fNGYCHe6whYtlKaomPN2wobYrgIOVxGV5q4W94KlDVEHIbYEc63DMDmxGqm91dwVlzK0/ZBofUwt1PBoxCdYRs7ZuEg8PKFZYVPSJrZX9cdCrsPAzI2C/IUIrYL1J9GcfSxYajYdYCObcUX+lMsoXA1vamqFMPJSnhGeL4kS+P/DnHIgNNjKoLzZs6kr9gWbtYaq/VkQkEoQMirM4B95S9TXOYayImyU9R+m4BKOdUunQr5S7RFxkC1RDSHbfrRJYPDpQxhU180YZmC5cuGS5H0WjMsOsgZjfGIXhUnXMUzcd2U16y9fsofW3mnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b51H4MZYd7+AqE1DO44DsXCTvQX62tGCiA8NiDw2JfI=;
 b=LOiX90lJ66e8G1EWm4LFCkGiIWVLpMQsoV+T+mQVUpHEZcLiMVn69kDkEnSxsmxjtxcQZaMjPJlm0BCeooT+6z//maQii8V1oJd+OVTrypxaNwx/QdLjrpJXB9GfGNKsVlDmhc/3mjpFzMVFq4A7c9SB68Vufnh0XwsFZJJoarE=
Received: from CY5PR15CA0165.namprd15.prod.outlook.com (2603:10b6:930:81::7)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Thu, 15 Sep
 2022 17:02:17 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:930:81:cafe::f4) by CY5PR15CA0165.outlook.office365.com
 (2603:10b6:930:81::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Thu, 15 Sep 2022 17:02:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Thu, 15 Sep 2022 17:02:16 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 15 Sep 2022 12:02:05 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 07/10] drm/amdgpu/gfx8: switch to amdgpu_gfx_rlc_init_microcode
Date: Fri, 16 Sep 2022 01:01:32 +0800
Message-ID: <20220915170135.23060-8-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220915170135.23060-1-Hawking.Zhang@amd.com>
References: <20220915170135.23060-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E8:EE_|BY5PR12MB4306:EE_
X-MS-Office365-Filtering-Correlation-Id: 232e9717-b498-460b-d3c0-08da973c0b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s4GQ889z4QfnxIDkzQi+fDv7TP6qVVNRFPKqqZ3hK1sMXoEwPAiNJ0E2Y4OzHTxcW6f6r+TWxToXuh5b+TOWRfOmIYhJ5VWDBU2ohHj+iGB1FoTjwLp8bb/BCosnBS+FCF/wRuVIVMbgeGV2gwUl5xWrWggwCHNL9ot2c/fbalTeXWSgSHRGo1yf3gpOGpC6qqVNtBHc6rb7+6DskaaKCSJN3t1IGuIM7ANHXii8UOl8WYF+WLmWn2Esz/6M5k1uVgW8gXB9l45DuBxEQEdgZlbu+SYUvUFKkBrEHg+2jkEsGvrGtv4zD8xmMYLCtr9IruNZ37A1NJQ5T+rgXNAXW8mk5NjogGzXvLHhbL0tUjHTGM7rdR3G4KEGskZmg6y7FeJ8A/8ZaQuaJ2cIKC2B7Ba5bq4s9hvrTrKJ6tUZPF6dFNuG85zRDTgaq73xcVmhaNyuvWLmVBZrH4Xir1rtFHTGZ8Ko/4Oq65djFkpxOMTudDSl16+/qQY3Vk89I09xy+pPhwgWQq1+Tb1pvZ1dd+h6rKXuFehZlbY06VJe4wrdSWkhXkVXJhVIKHEKA6fiFmC8W/KH5OJK1SY5Qeqjuc9h3pkfYTgadUiCDGvLcI9ghC+Q60GBy8Q0EkWxqc6rXMiGcQGpxoIovmycv0b0k7RcAV1305NumXHpd4XxtowiQNKpDwBSYe1F964B/BFJOIkvBnYZWLCO0GjeM+WjEUKGTvEJvN9q7yYxK2mjT8LnV/0KHbTuFeyfPsDg6k83cN0RzSzMweZop4AJBhxHBsBWsf+5fvZ1EfxTX0vBugjwTOo7bmfxFTdAWNHyU7FE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(7696005)(70206006)(4326008)(2616005)(83380400001)(6636002)(47076005)(81166007)(41300700001)(110136005)(40460700003)(1076003)(70586007)(478600001)(16526019)(6666004)(8676002)(316002)(356005)(26005)(86362001)(2906002)(36756003)(336012)(426003)(82740400003)(36860700001)(40480700001)(186003)(82310400005)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 17:02:16.5321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 232e9717-b498-460b-d3c0-08da973c0b2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

switch to common helper to initialize rlc firmware
for gfx8

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 60 +++++----------------------
 1 file changed, 11 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 606d0c873d71..09c63e2d4637 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -951,7 +951,7 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 	const struct common_firmware_header *header = NULL;
 	const struct gfx_firmware_header_v1_0 *cp_hdr;
 	const struct rlc_firmware_header_v2_0 *rlc_hdr;
-	unsigned int *tmp = NULL, i;
+	uint16_t version_major, version_minor;
 
 	DRM_DEBUG("\n");
 
@@ -1064,49 +1064,18 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 	if (err)
 		goto out;
 	err = amdgpu_ucode_validate(adev->gfx.rlc_fw);
-	rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
-	adev->gfx.rlc_fw_version = le32_to_cpu(rlc_hdr->header.ucode_version);
-	adev->gfx.rlc_feature_version = le32_to_cpu(rlc_hdr->ucode_feature_version);
-
-	adev->gfx.rlc.save_and_restore_offset =
-			le32_to_cpu(rlc_hdr->save_and_restore_offset);
-	adev->gfx.rlc.clear_state_descriptor_offset =
-			le32_to_cpu(rlc_hdr->clear_state_descriptor_offset);
-	adev->gfx.rlc.avail_scratch_ram_locations =
-			le32_to_cpu(rlc_hdr->avail_scratch_ram_locations);
-	adev->gfx.rlc.reg_restore_list_size =
-			le32_to_cpu(rlc_hdr->reg_restore_list_size);
-	adev->gfx.rlc.reg_list_format_start =
-			le32_to_cpu(rlc_hdr->reg_list_format_start);
-	adev->gfx.rlc.reg_list_format_separate_start =
-			le32_to_cpu(rlc_hdr->reg_list_format_separate_start);
-	adev->gfx.rlc.starting_offsets_start =
-			le32_to_cpu(rlc_hdr->starting_offsets_start);
-	adev->gfx.rlc.reg_list_format_size_bytes =
-			le32_to_cpu(rlc_hdr->reg_list_format_size_bytes);
-	adev->gfx.rlc.reg_list_size_bytes =
-			le32_to_cpu(rlc_hdr->reg_list_size_bytes);
-
-	adev->gfx.rlc.register_list_format =
-			kmalloc(adev->gfx.rlc.reg_list_format_size_bytes +
-					adev->gfx.rlc.reg_list_size_bytes, GFP_KERNEL);
-
-	if (!adev->gfx.rlc.register_list_format) {
-		err = -ENOMEM;
+	if (err)
 		goto out;
+	rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
+	if (!rlc_hdr) {
+		dev_err(adev->dev, "invalid rlc fw data\n");
+		return -EINVAL;
 	}
-
-	tmp = (unsigned int *)((uintptr_t)rlc_hdr +
-			le32_to_cpu(rlc_hdr->reg_list_format_array_offset_bytes));
-	for (i = 0 ; i < (adev->gfx.rlc.reg_list_format_size_bytes >> 2); i++)
-		adev->gfx.rlc.register_list_format[i] =	le32_to_cpu(tmp[i]);
-
-	adev->gfx.rlc.register_restore = adev->gfx.rlc.register_list_format + i;
-
-	tmp = (unsigned int *)((uintptr_t)rlc_hdr +
-			le32_to_cpu(rlc_hdr->reg_list_array_offset_bytes));
-	for (i = 0 ; i < (adev->gfx.rlc.reg_list_size_bytes >> 2); i++)
-		adev->gfx.rlc.register_restore[i] = le32_to_cpu(tmp[i]);
+	version_major = le16_to_cpu(rlc_hdr->header.header_version_major);
+	version_minor = le16_to_cpu(rlc_hdr->header.header_version_minor);
+	err = amdgpu_gfx_rlc_init_microcode(adev, version_major, version_minor);
+	if (err)
+		goto out;
 
 	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
 		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec_2.bin", chip_name);
@@ -1178,13 +1147,6 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 	adev->firmware.fw_size +=
 		ALIGN(le32_to_cpu(header->ucode_size_bytes), PAGE_SIZE);
 
-	info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_G];
-	info->ucode_id = AMDGPU_UCODE_ID_RLC_G;
-	info->fw = adev->gfx.rlc_fw;
-	header = (const struct common_firmware_header *)info->fw->data;
-	adev->firmware.fw_size +=
-		ALIGN(le32_to_cpu(header->ucode_size_bytes), PAGE_SIZE);
-
 	info = &adev->firmware.ucode[AMDGPU_UCODE_ID_CP_MEC1];
 	info->ucode_id = AMDGPU_UCODE_ID_CP_MEC1;
 	info->fw = adev->gfx.mec_fw;
-- 
2.17.1

