Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4573C6FA86
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 17:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BC7610EB91;
	Thu, 15 Sep 2022 17:02:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F261110EB8D
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 17:02:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YD4T9SJRbTI8whm7DtC2FpHRQEfljP7qFj1bGvFr8YjPDBeDDjNwHsJazExtQrURTJT07RVh7vX2QPbCpvHi7vnMYO83gY08IMc4fuQBkyv8htCh+i2Gfg2lay7iywAo/r8PPYbnexvHcPPgGub1ge2wbbHbw4DKoqxEnLrGj//BaueApuUK1MR6OAg3Y9gP0BuKbNuCyUDbvOvL65kJe1D/53f1+msipXVawEIKohdR85l8JCwMX/JuN+Qwi6f2alMobm10pWSfuK9yHHnDGwr90P96h3SNpmhn3RmEo0i/ReVDTZfKL33mLaUJFv+f7iiecH3friyl3QIDvtJgYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrk1X3PXQlg7PmXEYbhObSuBJifxDzdMdD9QplMooe4=;
 b=IiV63VUo5vB2oAdffclVZzUcsgpHCgQtI32zdYQzzhZWakfX5wl6L9pMcUREvohf29BSC0QJEUTYEZUNc2O3kxrA/l0jSyjUuP/dvGo21yTyo+EegTr67+10zCAIZTGpy/qFuoWQUeOioMQrguESXBz7z8sEEHOhs2k77jFKYBEPRUc4+vSIK5kD0Wzloi8k57VL/oHUkZ0U3Vv+aYrqVD3w12p0OFo4jqtBHB2ioGSu+s2qihaC2PVmeaQgC+xpkVSBznCLw1FlQpuzJOiHnVST0kHGJyJ+4eWGGiZk5N7z63zXTHcgjqtu3BYiWqb8+vP8m5rjIA9olHA4WoVCHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrk1X3PXQlg7PmXEYbhObSuBJifxDzdMdD9QplMooe4=;
 b=y5V33kEWcoFhwjpvzTgIA9SQZBTz45v95qmt+S5jtmfAoDmImsWTpgEWEqYEu1zslWxGgDBGq5UrIhniN2alYCT/sV9AzSKEPeUsKVYG658dwfkdYoi7aWIQ3/6VMvRruR3Dc8BbfPM63EbXuXy7ddWcOqieP6faxCHYyDMVBTQ=
Received: from CY5PR15CA0170.namprd15.prod.outlook.com (2603:10b6:930:81::9)
 by MW4PR12MB7215.namprd12.prod.outlook.com (2603:10b6:303:228::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 17:02:19 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:930:81:cafe::78) by CY5PR15CA0170.outlook.office365.com
 (2603:10b6:930:81::9) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.5612.12 via Frontend Transport; Thu, 15 Sep 2022 17:02:19 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 15 Sep 2022 12:02:13 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 10/10] drm/amdgpu/gfx11: switch to
 amdgpu_gfx_rlc_init_microcode
Date: Fri, 16 Sep 2022 01:01:35 +0800
Message-ID: <20220915170135.23060-11-Hawking.Zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E8:EE_|MW4PR12MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: bb3a5fed-bd32-4650-fa24-08da973c0cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ljEoJ/6MZ9pXEHLXSsuCeVToLiHuZ5MP5YpYGmwIagkNphEsBMYCsm6J4Eu1pb0bSCcW6Vm2sm+xpYpJ0WWeRLf0t8PZZJQoVIR1PCmzCefFkX4o9QNkvwtYQE4Inn6Ht8FQ4/bsywqDq2volT5ajmilJs+V48P8/PJr428cGOOeiPqLqKz9iFZYeD26ddcCQd/Ff5/95/4HQnfJ8nL5ggfHkSnNsJVENXyCB7Es7ZpujgaKqDLr8QQRZc/oOFRoEAjYuZh/+WnxcFbPyd92AbnVk7n1FbNCVq5R27UnOhWHd2ZYNiZ1vAj4N4yXqatbUX9sznJiWS0n53HM7Vj+gptqYbyoj5Dw1jMIkMVXd7HjijFOFvfadORdGXQev5ahol9Ffi+GgkNJ8WDVVng0zFZxw4aKovC7Zj6tUe5nobeD0rr755p0uqqlMybytmbBl59/oOlv2G1/HttxuhNeFoYLadyMtr0nr0Kd8MFGbQxjAZHdeeAONaglm9mMK/pPnhuw7CEk5Urk0LHcO6I1iAOBNaKUN6g0cnIc1/8+0ztOqPcMgpJiorIed8GC9rFIWkH9hk7a7gas6OTMbbh6xC3VTmKUHu1v4GZvU4/77pjYAe3nDAp2IJrbjKxRnLDtB3JoYYPhFL60OT5MSRgDcf/0X8ayF4P6/LshY8KaUwRJCAoU47yr1NsqPiAsFO/jeVRHJFIE3E5bp5gtrxjdm8RQVdwcxwjRmRFeJbKeo0cIiNSBsRvbYc+Son9N5kRyz6mDhVjtBY4sU0OQh7CnXtI8AlJd++WqekKOQR72OpldryTy0hHyC3L5jB499fl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(46966006)(40470700004)(36840700001)(426003)(186003)(8676002)(478600001)(5660300002)(1076003)(40480700001)(7696005)(82740400003)(82310400005)(70206006)(356005)(40460700003)(8936002)(336012)(36860700001)(16526019)(47076005)(81166007)(41300700001)(86362001)(316002)(70586007)(2906002)(2616005)(110136005)(4326008)(26005)(6666004)(83380400001)(36756003)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 17:02:19.4384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3a5fed-bd32-4650-fa24-08da973c0cd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7215
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
for gfx11

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 156 +------------------------
 1 file changed, 4 insertions(+), 152 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ce8c792cef1a..565d7492a43c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -438,54 +438,6 @@ static void gfx_v11_0_free_microcode(struct amdgpu_device *adev)
 	kfree(adev->gfx.rlc.register_list_format);
 }
 
-static void gfx_v11_0_init_rlc_ext_microcode(struct amdgpu_device *adev)
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
-static void gfx_v11_0_init_rlc_iram_dram_microcode(struct amdgpu_device *adev)
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
-static void gfx_v11_0_init_rlcp_rlcv_microcode(struct amdgpu_device *adev)
-{
-	const struct rlc_firmware_header_v2_3 *rlc_hdr;
-
-	rlc_hdr = (const struct rlc_firmware_header_v2_3 *)adev->gfx.rlc_fw->data;
-	adev->gfx.rlcp_ucode_version = le32_to_cpu(rlc_hdr->rlcp_ucode_version);
-	adev->gfx.rlcp_ucode_feature_version = le32_to_cpu(rlc_hdr->rlcp_ucode_feature_version);
-	adev->gfx.rlc.rlcp_ucode_size_bytes = le32_to_cpu(rlc_hdr->rlcp_ucode_size_bytes);
-	adev->gfx.rlc.rlcp_ucode = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->rlcp_ucode_offset_bytes);
-
-	adev->gfx.rlcv_ucode_version = le32_to_cpu(rlc_hdr->rlcv_ucode_version);
-	adev->gfx.rlcv_ucode_feature_version = le32_to_cpu(rlc_hdr->rlcv_ucode_feature_version);
-	adev->gfx.rlc.rlcv_ucode_size_bytes = le32_to_cpu(rlc_hdr->rlcv_ucode_size_bytes);
-	adev->gfx.rlc.rlcv_ucode = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->rlcv_ucode_offset_bytes);
-}
-
 static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 {
 	char fw_name[40];
@@ -496,8 +448,6 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 	const struct gfx_firmware_header_v1_0 *cp_hdr;
 	const struct gfx_firmware_header_v2_0 *cp_hdr_v2_0;
 	const struct rlc_firmware_header_v2_0 *rlc_hdr;
-	unsigned int *tmp = NULL;
-	unsigned int i = 0;
 	uint16_t version_major;
 	uint16_t version_minor;
 
@@ -552,58 +502,14 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
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
-				gfx_v11_0_init_rlc_ext_microcode(adev);
-			if (version_minor >= 2)
-				gfx_v11_0_init_rlc_iram_dram_microcode(adev);
-			if (version_minor == 3)
-				gfx_v11_0_init_rlcp_rlcv_microcode(adev);
-		}
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", ucode_prefix);
@@ -738,60 +644,6 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 			adev->firmware.fw_size +=
 				ALIGN(le32_to_cpu(cp_hdr->jt_size) * 4, PAGE_SIZE);
 		}
-
-		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_G];
-		info->ucode_id = AMDGPU_UCODE_ID_RLC_G;
-		info->fw = adev->gfx.rlc_fw;
-		if (info->fw) {
-			header = (const struct common_firmware_header *)info->fw->data;
-			adev->firmware.fw_size +=
-				ALIGN(le32_to_cpu(header->ucode_size_bytes), PAGE_SIZE);
-		}
-		if (adev->gfx.rlc.save_restore_list_gpm_size_bytes &&
-		    adev->gfx.rlc.save_restore_list_srm_size_bytes) {
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
-		}
-
-		if (adev->gfx.rlc.rlc_iram_ucode_size_bytes &&
-		    adev->gfx.rlc.rlc_dram_ucode_size_bytes) {
-			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_IRAM];
-			info->ucode_id = AMDGPU_UCODE_ID_RLC_IRAM;
-			info->fw = adev->gfx.rlc_fw;
-			adev->firmware.fw_size +=
-				ALIGN(adev->gfx.rlc.rlc_iram_ucode_size_bytes, PAGE_SIZE);
-
-			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_DRAM];
-			info->ucode_id = AMDGPU_UCODE_ID_RLC_DRAM;
-			info->fw = adev->gfx.rlc_fw;
-			adev->firmware.fw_size +=
-				ALIGN(adev->gfx.rlc.rlc_dram_ucode_size_bytes, PAGE_SIZE);
-		}
-
-		if (adev->gfx.rlc.rlcp_ucode_size_bytes) {
-			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_P];
-			info->ucode_id = AMDGPU_UCODE_ID_RLC_P;
-			info->fw = adev->gfx.rlc_fw;
-			adev->firmware.fw_size +=
-				ALIGN(adev->gfx.rlc.rlcp_ucode_size_bytes, PAGE_SIZE);
-		}
-
-		if (adev->gfx.rlc.rlcv_ucode_size_bytes) {
-			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_V];
-			info->ucode_id = AMDGPU_UCODE_ID_RLC_V;
-			info->fw = adev->gfx.rlc_fw;
-			adev->firmware.fw_size +=
-				ALIGN(adev->gfx.rlc.rlcv_ucode_size_bytes, PAGE_SIZE);
-		}
 	}
 
 out:
-- 
2.17.1

