Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1FCC3815B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 10:17:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E0E821744
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 10:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="z+EZc9Qc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0E821744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F6826E4F8;
	Mon, 20 Apr 2020 10:17:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA94E6E4F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 10:17:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtAsLkWSSLFuWin8PR2A8//SmVMq2hPWn6DrEZ01MsD5Ata7acH2luXCeDso93Q0isI36zMfm/Jk6tmOaXRbdmJGE3Les7HyjrzHIdBFg1tGHXHYX1ugxi8tOA80Wu4HJyhC/5qEPjfU7FK2BXbUm51YhMRbAscGnXQY0kJmhv6rrIvftSnLkLi5TCvlOhNy6hQKJQl45nZXrVjp+2wwHxjCJQenF825kJh1ywKxCUvz8AKVYVkzYnnOdJgMZjv1Vzb8yjrN877UclF7hq7dt9GX7K27zWfrKMpNUs5j5Tqbpcgx3bGsOrh1LTlzY+hby11V6yv6UcmsKNouBS7U3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caF7uFGYticy91jAA4RvGlUkgcOs9wwFbgxtItHEJ5A=;
 b=at4SnCagBnWo9YCYcTTFzXY5kCEH4jsLclrME3qphNSRlp9N+eZIap5glWKLZqqXVtplb0Ibu6pUOt8gHIhAGmgOCFDJHSieWOeKRC8T2CVJjkmKjFdMRFXG544rJhMlpu2LypYrACxtQQIPPwc/b3KVXHNcQxkduIVqVI8u7t2YMDyliCHUmDVJAeIP0247Y6yZc+wiTyIwW5tj5QY0ImoyYN1MQD3gEZ0OeWsrKclwzp0Hg3HMXWq4LBlyvH82I8TN645qmLgHy4YOzvLe913yZz/0ZU61oQetNyXimQNH5aPUiouzmaaRUsmQM6hhaoglDSTRdQNo8+7AHHfWxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caF7uFGYticy91jAA4RvGlUkgcOs9wwFbgxtItHEJ5A=;
 b=z+EZc9QcriZEHeDRHRYBgfO/PxKLC1T3Mu5OWSBqUal85mS5QqbL7eU8ODMW3fYG6mj2gzxNPqCck9jUJQbe/yPhFOTvHV+TzvXC6zbE3wP3k3jv99zicZD2/G8r46SA9mpYIEH4Ow6/nb8MADJRw2P9r5Pn0N5MLd3iBo6IRcE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3225.namprd12.prod.outlook.com (2603:10b6:5:188::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25; Mon, 20 Apr 2020 10:17:28 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 10:17:28 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 John Clements <john.clements@amd.com>, Guchun Chen <Guchun.Chen@amd.com>
Subject: [PATCH 5/8] drm/amdgpu: switch to helper function to init asd ucode
Date: Mon, 20 Apr 2020 18:16:41 +0800
Message-Id: <1587377804-3836-6-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587377804-3836-1-git-send-email-Hawking.Zhang@amd.com>
References: <1587377804-3836-1-git-send-email-Hawking.Zhang@amd.com>
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-All-Series.amd.com (180.167.199.189) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2937.6 via Frontend Transport; Mon, 20 Apr 2020 10:17:26 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f587fb2d-f041-43cb-af30-08d7e5140794
X-MS-TrafficTypeDiagnostic: DM6PR12MB3225:|DM6PR12MB3225:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB322575A57C34D8CFA98D47CAFCD40@DM6PR12MB3225.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:75;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(26005)(2616005)(16526019)(956004)(316002)(186003)(6486002)(6636002)(2906002)(86362001)(478600001)(6666004)(8676002)(36756003)(4326008)(5660300002)(66556008)(66946007)(66476007)(7696005)(52116002)(110136005)(81156014)(8936002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mS72DAJezKs1T3i/sRVXar6lbZ3zeZsAVM2U71AZVlOKkAdz8o2AOvaxVzV+eYgTYmNhexrCOOPzRu9th7iJGJuLe3VmYjSMZmZH1YtnnE4YzxAVIngyDkpzCJZHiaKiggFsyw6TTGehilMBCYhHQ5c3SU7JgjwDYkF7zSBNbUt2lTqPfdFIOd+DaO1iYTsGcNDoH7gdYyKf8ogL9QknWPQZdJUkX6kyaIKzK+cBmqpfQkW2nyDcZXrGcdz/YbHXYYCb/w/VRRh+QbhhQDlS2fzr6XIq0ie2lXyBDUepLC0DHePZ8m824mUcHCA5+mcUMV8CtgzdV5l9hySczKXNJ8h/ZYkmffP1TUVCPJhNUXF04ppFZFRjJu5c8KuHH+a66Ka5jw/dat+r65a14x+GWbYV+eSaiiiqvh63S2xLkJLnqkrwJCGv03RETmnrjYNu
X-MS-Exchange-AntiSpam-MessageData: n8ZMB+IqUT/ZDak9V8HxBHnEyqntoJBfs/NUCMMWoSgkQEgnP/iCShwbHkKNXtrWequau46GouPaqON6LT9T4RH9T2tHpyCUapTqIrATDFUpDozgZ60jR9Uv5fQCLLWFwgVJcshvRPwJpiXQpVKeRA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f587fb2d-f041-43cb-af30-08d7e5140794
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 10:17:28.7726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5wVAbbBquvVByDoFxTKkTobn3Viu1aPmj5Aw7sHhuOqMagzxBC66V02+B1OSedr7j2CFM6h/N5DZU2EN/86Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3225
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

call common helper function to initialize asd ucode

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c | 17 +----------------
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 20 ++------------------
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c | 27 +--------------------------
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c  | 16 +---------------
 4 files changed, 5 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
index 6e041b7..90727cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -50,7 +50,6 @@ static int psp_v10_0_init_microcode(struct psp_context *psp)
 	const char *chip_name;
 	char fw_name[30];
 	int err = 0;
-	const struct psp_firmware_header_v1_0 *hdr;
 	const struct ta_firmware_header_v1_0 *ta_hdr;
 	DRM_DEBUG("\n");
 
@@ -66,22 +65,10 @@ static int psp_v10_0_init_microcode(struct psp_context *psp)
 	default: BUG();
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_asd.bin", chip_name);
-	err = request_firmware(&adev->psp.asd_fw, fw_name, adev->dev);
+	err = psp_init_asd_microcode(psp, chip_name);
 	if (err)
 		goto out;
 
-	err = amdgpu_ucode_validate(adev->psp.asd_fw);
-	if (err)
-		goto out;
-
-	hdr = (const struct psp_firmware_header_v1_0 *)adev->psp.asd_fw->data;
-	adev->psp.asd_fw_version = le32_to_cpu(hdr->header.ucode_version);
-	adev->psp.asd_feature_version = le32_to_cpu(hdr->ucode_feature_version);
-	adev->psp.asd_ucode_size = le32_to_cpu(hdr->header.ucode_size_bytes);
-	adev->psp.asd_start_addr = (uint8_t *)hdr +
-				le32_to_cpu(hdr->header.ucode_array_offset_bytes);
-
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ta.bin", chip_name);
 	err = request_firmware(&adev->psp.ta_fw, fw_name, adev->dev);
 	if (err) {
@@ -126,8 +113,6 @@ static int psp_v10_0_init_microcode(struct psp_context *psp)
 		dev_err(adev->dev,
 			"psp v10.0: Failed to load firmware \"%s\"\n",
 			fw_name);
-		release_firmware(adev->psp.asd_fw);
-		adev->psp.asd_fw = NULL;
 	}
 
 	return err;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index f633577..6d50da0 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -78,7 +78,6 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 	const struct psp_firmware_header_v1_0 *sos_hdr;
 	const struct psp_firmware_header_v1_1 *sos_hdr_v1_1;
 	const struct psp_firmware_header_v1_2 *sos_hdr_v1_2;
-	const struct psp_firmware_header_v1_0 *asd_hdr;
 	const struct ta_firmware_header_v1_0 *ta_hdr;
 
 	DRM_DEBUG("\n");
@@ -148,21 +147,9 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 		goto out;
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_asd.bin", chip_name);
-	err = request_firmware(&adev->psp.asd_fw, fw_name, adev->dev);
+	err = psp_init_asd_microcode(psp, chip_name);
 	if (err)
-		goto out1;
-
-	err = amdgpu_ucode_validate(adev->psp.asd_fw);
-	if (err)
-		goto out1;
-
-	asd_hdr = (const struct psp_firmware_header_v1_0 *)adev->psp.asd_fw->data;
-	adev->psp.asd_fw_version = le32_to_cpu(asd_hdr->header.ucode_version);
-	adev->psp.asd_feature_version = le32_to_cpu(asd_hdr->ucode_feature_version);
-	adev->psp.asd_ucode_size = le32_to_cpu(asd_hdr->header.ucode_size_bytes);
-	adev->psp.asd_start_addr = (uint8_t *)asd_hdr +
-				le32_to_cpu(asd_hdr->header.ucode_array_offset_bytes);
+		goto out;
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
@@ -229,9 +216,6 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 out2:
 	release_firmware(adev->psp.ta_fw);
 	adev->psp.ta_fw = NULL;
-out1:
-	release_firmware(adev->psp.asd_fw);
-	adev->psp.asd_fw = NULL;
 out:
 	dev_err(adev->dev,
 		"psp v11.0: Failed to load firmware \"%s\"\n", fw_name);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
index 42c485b..6c9614f 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -45,11 +45,7 @@ static int psp_v12_0_init_microcode(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
 	const char *chip_name;
-	char fw_name[30];
 	int err = 0;
-	const struct psp_firmware_header_v1_0 *asd_hdr;
-
-	DRM_DEBUG("\n");
 
 	switch (adev->asic_type) {
 	case CHIP_RENOIR:
@@ -59,28 +55,7 @@ static int psp_v12_0_init_microcode(struct psp_context *psp)
 		BUG();
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_asd.bin", chip_name);
-	err = request_firmware(&adev->psp.asd_fw, fw_name, adev->dev);
-	if (err)
-		goto out1;
-
-	err = amdgpu_ucode_validate(adev->psp.asd_fw);
-	if (err)
-		goto out1;
-
-	asd_hdr = (const struct psp_firmware_header_v1_0 *)adev->psp.asd_fw->data;
-	adev->psp.asd_fw_version = le32_to_cpu(asd_hdr->header.ucode_version);
-	adev->psp.asd_feature_version = le32_to_cpu(asd_hdr->ucode_feature_version);
-	adev->psp.asd_ucode_size = le32_to_cpu(asd_hdr->header.ucode_size_bytes);
-	adev->psp.asd_start_addr = (uint8_t *)asd_hdr +
-				le32_to_cpu(asd_hdr->header.ucode_array_offset_bytes);
-
-	return 0;
-
-out1:
-	release_firmware(adev->psp.asd_fw);
-	adev->psp.asd_fw = NULL;
-
+	err = psp_init_asd_microcode(psp, chip_name);
 	return err;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
index 9ca37d0..14d17b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -95,22 +95,10 @@ static int psp_v3_1_init_microcode(struct psp_context *psp)
 	adev->psp.sos_start_addr = (uint8_t *)adev->psp.sys_start_addr +
 				le32_to_cpu(hdr->sos_offset_bytes);
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_asd.bin", chip_name);
-	err = request_firmware(&adev->psp.asd_fw, fw_name, adev->dev);
+	err = psp_init_asd_microcode(psp, chip_name);
 	if (err)
 		goto out;
 
-	err = amdgpu_ucode_validate(adev->psp.asd_fw);
-	if (err)
-		goto out;
-
-	hdr = (const struct psp_firmware_header_v1_0 *)adev->psp.asd_fw->data;
-	adev->psp.asd_fw_version = le32_to_cpu(hdr->header.ucode_version);
-	adev->psp.asd_feature_version = le32_to_cpu(hdr->ucode_feature_version);
-	adev->psp.asd_ucode_size = le32_to_cpu(hdr->header.ucode_size_bytes);
-	adev->psp.asd_start_addr = (uint8_t *)hdr +
-				le32_to_cpu(hdr->header.ucode_array_offset_bytes);
-
 	return 0;
 out:
 	if (err) {
@@ -119,8 +107,6 @@ static int psp_v3_1_init_microcode(struct psp_context *psp)
 			fw_name);
 		release_firmware(adev->psp.sos_fw);
 		adev->psp.sos_fw = NULL;
-		release_firmware(adev->psp.asd_fw);
-		adev->psp.asd_fw = NULL;
 	}
 
 	return err;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
