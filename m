Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461FEC6FA86
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 17:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93ED910EB8F;
	Thu, 15 Sep 2022 17:02:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23B1410EB8C
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 17:02:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpBSa0TwQ9HQQztXytUa8zyYBQEvJ5dta4aPJzCasLVMvXHwz3tTj4Lmc76K6VXEDXSuMSZUDWsYeRpue5pMhzsUJs+PLy9B6vBBSyWXTLde/GQ5V4JQYsz4rvA8Z9GYRq2Y5d5HUVi7hmvYAS/PITIBHEZOqSlWKWgLJAXypMKN7lclV4cRipjJHP71RyOtL7qJo00dr2jUZNcNFgBJPS/8+qgV0FRQPgMzdDA751HrPsTN7LFJNsmpm0hw1kXEGUEbDFou6B+u6A6UTMWW9thOj1xBJq8npiwzeakE4PZoDWJ42y6xMG9j9vTJCFz5eCDGRgoUFYgbKplzCHGfuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQCQ3xMHvk6QAyPq/ndfLP0nf2cb9SOHvTPYmhfw+og=;
 b=V9nUyMRzMC3IwcP/5BTBjTDlVxMQp7Clky8XWhNwTdQFeSrhBbbJ5uOr+SsK8S37Jp9gFxKvqGavdKqS0vuPJGA9GzLgAka/RpkMsxgHuGLVl8DcrTJpK43180dlkaoBzs7V1CACeimqziYBBW7qbR0RQ+sVwQ+g+GFYAZpV8Vlyy8u/2jLM0Ki+eMKYL9zqeiv83oaH8pv5Y1qCWr5zhmfUerEtpsfJD7cZ927vTkKQNdooXaeyohDDuGTqgFrLUKHnGivRfuPbU3RslJFZrzwO8hmKgTf3PXlpmu7snIyQeR9CY1dnWz/uz2kThho6ZYGip5YPeWlSn9ftcz+2DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQCQ3xMHvk6QAyPq/ndfLP0nf2cb9SOHvTPYmhfw+og=;
 b=r3YA2I0mLrHbQCU7E8lF6gd29+UvJkdOC/7q+lgWkd0pEEC4ubZVSf6Cp2eCwAuQdhJLnYLMLpJ9ZRT6GQH9qG/vtzHyhJxtKS6md9I81x8c5qXbjJ8s8BTeLjboa/mcyjWnLPNrMNEkKcY03N+SdCWtRzsXMy03FW63tVxowHs=
Received: from CY5PR15CA0167.namprd15.prod.outlook.com (2603:10b6:930:81::13)
 by CY5PR12MB6347.namprd12.prod.outlook.com (2603:10b6:930:20::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 17:02:19 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:930:81:cafe::a6) by CY5PR15CA0167.outlook.office365.com
 (2603:10b6:930:81::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Thu, 15 Sep 2022 17:02:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Thu, 15 Sep 2022 17:02:18 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 15 Sep 2022 12:02:10 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 09/10] drm/amdgpu/gfx10: switch to
 amdgpu_gfx_rlc_init_microcode
Date: Fri, 16 Sep 2022 01:01:34 +0800
Message-ID: <20220915170135.23060-10-Hawking.Zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E8:EE_|CY5PR12MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a99b87a-95f2-4bd3-87fa-08da973c0c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WwqzOMO3TNLa8PUy+SGAYifFwKLU9rBV1a8qOlfC9gyF17osGhHN1qXjBtLk3awDGQS68vwUg0GNJlN0kmIPZwUX98Yel78WdmgMSdu6U+kFg3SFLYALC+/sB+rCRL3/BCpGOtHFnaKW+Pq3U1Tv8ajFMD8NAi/p+yH+0e/4OefdXXVfD2JMM46+NgzrhlF43/ULE8GbFmfuI0elwEmb/RcaH4xxRbmpiooXpxmVLs4dsIe0l080d0bdwRlq6BEEKKMIPTwPty6JwPdVFuiANBAKdmGbD+flnR75DqThqE+c/b8+lXh9ekFPxw0Or1zHWoumVKjb12wv6BfSTB94kVjCaELXsldDuats9+6EuLembpfHBR5ISZEHuvyFb4JIXHznL9jCb+oKeu+bVtUiB4iS9j6BSPwO1ySHM+XRYqwIbvX3Eou6Bg7Iie0g0iPIkIkjqwfh7tXrS5RgvGhlqTnKh0qb5VfnqpDskEPM0viBw5GTM5UEjl0qFTOeej2EhauSM/iXRRRwaypgleyDUOH3fnprJPMq2vFuzwW0ESO1dzp5kjYwJACam5aoS2SBtvhvtI25Q4K9MLBUAC12q0wYFN8HSyAydNBFoeJ89Mifm9srbQ2+U9usHedABkPmV3UiW0shchUlaTQNnnpynBUOgZElce7Unq5C48ilfMUaiLma2pVfA7as5eP7BVXHWWCB536DmrjNYw+RYJKwpVy+wK2JtVDjjicCeSamd6GmaXSEpO8rnp6hiVe0NjYXg5+cFjqPrVaQsP0Y6hyiX2h+QIjBP+TPlXPWIYqYHxZe5ZymVXtXNGQgoWygcJ5j
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(47076005)(426003)(86362001)(41300700001)(82740400003)(16526019)(478600001)(81166007)(8936002)(110136005)(40460700003)(36860700001)(36756003)(26005)(2616005)(186003)(6666004)(6636002)(336012)(5660300002)(2906002)(7696005)(40480700001)(316002)(356005)(70586007)(8676002)(4326008)(1076003)(83380400001)(30864003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 17:02:18.8915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a99b87a-95f2-4bd3-87fa-08da973c0c86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6347
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
for gfx10

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 191 +------------------------
 1 file changed, 4 insertions(+), 187 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 26ec04fd313b..423b1b6d31b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3943,56 +3943,6 @@ static void gfx_v10_0_check_fw_write_wait(struct amdgpu_device *adev)
 		DRM_WARN_ONCE("CP firmware version too old, please update!");
 }
 
-
-static void gfx_v10_0_init_rlc_ext_microcode(struct amdgpu_device *adev)
-{
-	const struct rlc_firmware_header_v2_1 *rlc_hdr;
-
-	rlc_hdr = (const struct rlc_firmware_header_v2_1 *)adev->gfx.rlc_fw->data;
-	adev->gfx.rlc_srlc_fw_version = le32_to_cpu(rlc_hdr->save_restore_list_cntl_ucode_ver);
-	adev->gfx.rlc_srlc_feature_version = le32_to_cpu(rlc_hdr->save_restore_list_cntl_feature_ver);
-	adev->gfx.rlc.save_restore_list_cntl_size_bytes = le32_to_cpu(rlc_hdr->save_restore_list_cntl_size_bytes);
-	adev->gfx.rlc.save_restore_list_cntl = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->save_restore_list_cntl_offset_bytes);
-	adev->gfx.rlc_srlg_fw_version = le32_to_cpu(rlc_hdr->save_restore_list_gpm_ucode_ver);
-	adev->gfx.rlc_srlg_feature_version = le32_to_cpu(rlc_hdr->save_restore_list_gpm_feature_ver);
-	adev->gfx.rlc.save_restore_list_gpm_size_bytes = le32_to_cpu(rlc_hdr->save_restore_list_gpm_size_bytes);
-	adev->gfx.rlc.save_restore_list_gpm = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->save_restore_list_gpm_offset_bytes);
-	adev->gfx.rlc_srls_fw_version = le32_to_cpu(rlc_hdr->save_restore_list_srm_ucode_ver);
-	adev->gfx.rlc_srls_feature_version = le32_to_cpu(rlc_hdr->save_restore_list_srm_feature_ver);
-	adev->gfx.rlc.save_restore_list_srm_size_bytes = le32_to_cpu(rlc_hdr->save_restore_list_srm_size_bytes);
-	adev->gfx.rlc.save_restore_list_srm = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->save_restore_list_srm_offset_bytes);
-	adev->gfx.rlc.reg_list_format_direct_reg_list_length =
-			le32_to_cpu(rlc_hdr->reg_list_format_direct_reg_list_length);
-}
-
-static void gfx_v10_0_init_rlc_iram_dram_microcode(struct amdgpu_device *adev)
-{
-	const struct rlc_firmware_header_v2_2 *rlc_hdr;
-
-	rlc_hdr = (const struct rlc_firmware_header_v2_2 *)adev->gfx.rlc_fw->data;
-	adev->gfx.rlc.rlc_iram_ucode_size_bytes = le32_to_cpu(rlc_hdr->rlc_iram_ucode_size_bytes);
-	adev->gfx.rlc.rlc_iram_ucode = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->rlc_iram_ucode_offset_bytes);
-	adev->gfx.rlc.rlc_dram_ucode_size_bytes = le32_to_cpu(rlc_hdr->rlc_dram_ucode_size_bytes);
-	adev->gfx.rlc.rlc_dram_ucode = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->rlc_dram_ucode_offset_bytes);
-}
-
-static void gfx_v10_0_init_tap_delays_microcode(struct amdgpu_device *adev)
-{
-	const struct rlc_firmware_header_v2_4 *rlc_hdr;
-
-	rlc_hdr = (const struct rlc_firmware_header_v2_4 *)adev->gfx.rlc_fw->data;
-	adev->gfx.rlc.global_tap_delays_ucode_size_bytes = le32_to_cpu(rlc_hdr->global_tap_delays_ucode_size_bytes);
-	adev->gfx.rlc.global_tap_delays_ucode = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->global_tap_delays_ucode_offset_bytes);
-	adev->gfx.rlc.se0_tap_delays_ucode_size_bytes = le32_to_cpu(rlc_hdr->se0_tap_delays_ucode_size_bytes);
-	adev->gfx.rlc.se0_tap_delays_ucode = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->se0_tap_delays_ucode_offset_bytes);
-	adev->gfx.rlc.se1_tap_delays_ucode_size_bytes = le32_to_cpu(rlc_hdr->se1_tap_delays_ucode_size_bytes);
-	adev->gfx.rlc.se1_tap_delays_ucode = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->se1_tap_delays_ucode_offset_bytes);
-	adev->gfx.rlc.se2_tap_delays_ucode_size_bytes = le32_to_cpu(rlc_hdr->se2_tap_delays_ucode_size_bytes);
-	adev->gfx.rlc.se2_tap_delays_ucode = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->se2_tap_delays_ucode_offset_bytes);
-	adev->gfx.rlc.se3_tap_delays_ucode_size_bytes = le32_to_cpu(rlc_hdr->se3_tap_delays_ucode_size_bytes);
-	adev->gfx.rlc.se3_tap_delays_ucode = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->se3_tap_delays_ucode_offset_bytes);
-}
-
 static bool gfx_v10_0_navi10_gfxoff_should_enable(struct amdgpu_device *adev)
 {
 	bool ret = false;
@@ -4032,8 +3982,6 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 	const struct common_firmware_header *header = NULL;
 	const struct gfx_firmware_header_v1_0 *cp_hdr;
 	const struct rlc_firmware_header_v2_0 *rlc_hdr;
-	unsigned int *tmp = NULL;
-	unsigned int i = 0;
 	uint16_t version_major;
 	uint16_t version_minor;
 
@@ -4123,59 +4071,14 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 		if (err)
 			goto out;
 		err = amdgpu_ucode_validate(adev->gfx.rlc_fw);
+		if (err)
+			goto out;
 		rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
 		version_major = le16_to_cpu(rlc_hdr->header.header_version_major);
 		version_minor = le16_to_cpu(rlc_hdr->header.header_version_minor);
-
-		adev->gfx.rlc_fw_version = le32_to_cpu(rlc_hdr->header.ucode_version);
-		adev->gfx.rlc_feature_version = le32_to_cpu(rlc_hdr->ucode_feature_version);
-		adev->gfx.rlc.save_and_restore_offset =
-			le32_to_cpu(rlc_hdr->save_and_restore_offset);
-		adev->gfx.rlc.clear_state_descriptor_offset =
-			le32_to_cpu(rlc_hdr->clear_state_descriptor_offset);
-		adev->gfx.rlc.avail_scratch_ram_locations =
-			le32_to_cpu(rlc_hdr->avail_scratch_ram_locations);
-		adev->gfx.rlc.reg_restore_list_size =
-			le32_to_cpu(rlc_hdr->reg_restore_list_size);
-		adev->gfx.rlc.reg_list_format_start =
-			le32_to_cpu(rlc_hdr->reg_list_format_start);
-		adev->gfx.rlc.reg_list_format_separate_start =
-			le32_to_cpu(rlc_hdr->reg_list_format_separate_start);
-		adev->gfx.rlc.starting_offsets_start =
-			le32_to_cpu(rlc_hdr->starting_offsets_start);
-		adev->gfx.rlc.reg_list_format_size_bytes =
-			le32_to_cpu(rlc_hdr->reg_list_format_size_bytes);
-		adev->gfx.rlc.reg_list_size_bytes =
-			le32_to_cpu(rlc_hdr->reg_list_size_bytes);
-		adev->gfx.rlc.register_list_format =
-			kmalloc(adev->gfx.rlc.reg_list_format_size_bytes +
-					adev->gfx.rlc.reg_list_size_bytes, GFP_KERNEL);
-		if (!adev->gfx.rlc.register_list_format) {
-			err = -ENOMEM;
+		err = amdgpu_gfx_rlc_init_microcode(adev, version_major, version_minor);
+		if (err)
 			goto out;
-		}
-
-		tmp = (unsigned int *)((uintptr_t)rlc_hdr +
-							   le32_to_cpu(rlc_hdr->reg_list_format_array_offset_bytes));
-		for (i = 0 ; i < (rlc_hdr->reg_list_format_size_bytes >> 2); i++)
-			adev->gfx.rlc.register_list_format[i] =	le32_to_cpu(tmp[i]);
-
-		adev->gfx.rlc.register_restore = adev->gfx.rlc.register_list_format + i;
-
-		tmp = (unsigned int *)((uintptr_t)rlc_hdr +
-							   le32_to_cpu(rlc_hdr->reg_list_array_offset_bytes));
-		for (i = 0 ; i < (rlc_hdr->reg_list_size_bytes >> 2); i++)
-			adev->gfx.rlc.register_restore[i] = le32_to_cpu(tmp[i]);
-
-		if (version_major == 2) {
-			if (version_minor >= 1)
-				gfx_v10_0_init_rlc_ext_microcode(adev);
-			if (version_minor >= 2)
-				gfx_v10_0_init_rlc_iram_dram_microcode(adev);
-			if (version_minor == 4) {
-				gfx_v10_0_init_tap_delays_microcode(adev);
-			}
-		}
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec%s.bin", chip_name, wks);
@@ -4228,92 +4131,6 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 		adev->firmware.fw_size +=
 			ALIGN(le32_to_cpu(header->ucode_size_bytes), PAGE_SIZE);
 
-		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_G];
-		info->ucode_id = AMDGPU_UCODE_ID_RLC_G;
-		info->fw = adev->gfx.rlc_fw;
-		if (info->fw) {
-			header = (const struct common_firmware_header *)info->fw->data;
-			adev->firmware.fw_size +=
-				ALIGN(le32_to_cpu(header->ucode_size_bytes), PAGE_SIZE);
-		}
-		if (adev->gfx.rlc.save_restore_list_cntl_size_bytes &&
-		    adev->gfx.rlc.save_restore_list_gpm_size_bytes &&
-		    adev->gfx.rlc.save_restore_list_srm_size_bytes) {
-			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL];
-			info->ucode_id = AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL;
-			info->fw = adev->gfx.rlc_fw;
-			adev->firmware.fw_size +=
-				ALIGN(adev->gfx.rlc.save_restore_list_cntl_size_bytes, PAGE_SIZE);
-
-			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM];
-			info->ucode_id = AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM;
-			info->fw = adev->gfx.rlc_fw;
-			adev->firmware.fw_size +=
-				ALIGN(adev->gfx.rlc.save_restore_list_gpm_size_bytes, PAGE_SIZE);
-
-			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM];
-			info->ucode_id = AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM;
-			info->fw = adev->gfx.rlc_fw;
-			adev->firmware.fw_size +=
-				ALIGN(adev->gfx.rlc.save_restore_list_srm_size_bytes, PAGE_SIZE);
-
-			if (adev->gfx.rlc.rlc_iram_ucode_size_bytes &&
-			    adev->gfx.rlc.rlc_dram_ucode_size_bytes) {
-				info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_IRAM];
-				info->ucode_id = AMDGPU_UCODE_ID_RLC_IRAM;
-				info->fw = adev->gfx.rlc_fw;
-				adev->firmware.fw_size +=
-					ALIGN(adev->gfx.rlc.rlc_iram_ucode_size_bytes, PAGE_SIZE);
-
-				info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_DRAM];
-				info->ucode_id = AMDGPU_UCODE_ID_RLC_DRAM;
-				info->fw = adev->gfx.rlc_fw;
-				adev->firmware.fw_size +=
-					ALIGN(adev->gfx.rlc.rlc_dram_ucode_size_bytes, PAGE_SIZE);
-			}
-
-		}
-
-		if (adev->gfx.rlc.global_tap_delays_ucode_size_bytes) {
-			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_GLOBAL_TAP_DELAYS];
-			info->ucode_id = AMDGPU_UCODE_ID_GLOBAL_TAP_DELAYS;
-			info->fw = adev->gfx.rlc_fw;
-			adev->firmware.fw_size +=
-				ALIGN(adev->gfx.rlc.global_tap_delays_ucode_size_bytes, PAGE_SIZE);
-		}
-
-		if (adev->gfx.rlc.se0_tap_delays_ucode_size_bytes) {
-			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_SE0_TAP_DELAYS];
-			info->ucode_id = AMDGPU_UCODE_ID_SE0_TAP_DELAYS;
-			info->fw = adev->gfx.rlc_fw;
-			adev->firmware.fw_size +=
-				ALIGN(adev->gfx.rlc.se0_tap_delays_ucode_size_bytes, PAGE_SIZE);
-		}
-
-		if (adev->gfx.rlc.se1_tap_delays_ucode_size_bytes) {
-			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_SE1_TAP_DELAYS];
-			info->ucode_id = AMDGPU_UCODE_ID_SE1_TAP_DELAYS;
-			info->fw = adev->gfx.rlc_fw;
-			adev->firmware.fw_size +=
-				ALIGN(adev->gfx.rlc.se1_tap_delays_ucode_size_bytes, PAGE_SIZE);
-		}
-
-		if (adev->gfx.rlc.se2_tap_delays_ucode_size_bytes) {
-			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_SE2_TAP_DELAYS];
-			info->ucode_id = AMDGPU_UCODE_ID_SE2_TAP_DELAYS;
-			info->fw = adev->gfx.rlc_fw;
-			adev->firmware.fw_size +=
-				ALIGN(adev->gfx.rlc.se2_tap_delays_ucode_size_bytes, PAGE_SIZE);
-		}
-
-		if (adev->gfx.rlc.se3_tap_delays_ucode_size_bytes) {
-			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_SE3_TAP_DELAYS];
-			info->ucode_id = AMDGPU_UCODE_ID_SE3_TAP_DELAYS;
-			info->fw = adev->gfx.rlc_fw;
-			adev->firmware.fw_size +=
-				ALIGN(adev->gfx.rlc.se3_tap_delays_ucode_size_bytes, PAGE_SIZE);
-		}
-
 		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_CP_MEC1];
 		info->ucode_id = AMDGPU_UCODE_ID_CP_MEC1;
 		info->fw = adev->gfx.mec_fw;
-- 
2.17.1

