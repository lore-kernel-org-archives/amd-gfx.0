Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26DEC25B74
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 01:42:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B63A10E1FC;
	Mon,  3 Jun 2024 01:42:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P1h3idYc";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A22410E1F7
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 01:42:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LG/AYz1XIDGLFGRU+BMAIlqy9ETu8yH+Hs62h8MlIx7YONoVEbTNEnMPg7Tk3fxE0aCTfnCWLyBAydjuqbIzQTyw+p6376CB2Pgyj3qJzdlMrp4gc3iixG4tXwEXLz1Xe4BZmNr7EJONEZFZa1QD4tPEEWoOTKjsNF95H5xl7i4jWHtcxHTrtAgufEvrKwUqVLS8nxJvXhGoSlGvg697frwoYGg5oywHlGGbhC1uTLAsQh/5IeB+vXdvQhVOKKRn1Alak+OAUGhCownqYNd0wTVKI247yC/zeRaOkcMuNUpWrJigDezN9sEBTAmZr2/HWhjDamMgRN9SCSRs/QP42w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgPaHU9GSzVObta4sip9ShtRgN87o8xu8KyNwRPTenk=;
 b=lVFW4iiP0Ni70FOljbuUo19iAYRi4GPXJtCRt/XcSp8x9HQG8JQb2ibz0YCKQTEdDXVo0FMyK3xcU8zqeMWORLJo10EvKB9UtkRg+IpSDh1MxgwtOTp6cKKSxAxbGF5u5dv3Ng/0XaHGZkWchVWqsWQxHRp6HmPeh6Um8V6RE7nNIDjMoBb+KyemsCVWvyIuBpK1GXytrmYeLd2za9ADRm8I5XGdDiCZ8Q0N3RSDbR1ZR8h1NXmtTVLgjcTAZP3r+lsYMKHrdXJLIPgmuCyhLNw0uAy/TrdFMTVOB2zE+GMHlMxMYY79aWa1i/mXv87yqjfp7e4ESPX1xGunEWJZog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgPaHU9GSzVObta4sip9ShtRgN87o8xu8KyNwRPTenk=;
 b=P1h3idYctnAMs1ECcWbghNZalwFWcs94ZGwA/1kFA8E93VMZ2cRQJaqvCLVLU2xOmXyS4PEGzpA30nWEvq8P9tLXXmGUoD+9x4my/j2UJFpYFT8UvR8o5lgrVavtH4JkdJz7O6wv55YUW/it/Qt/7Vqd5paHPyTO123xL69qzZo=
Received: from BYAPR02CA0056.namprd02.prod.outlook.com (2603:10b6:a03:54::33)
 by DM6PR12MB4122.namprd12.prod.outlook.com (2603:10b6:5:214::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 01:42:49 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::9) by BYAPR02CA0056.outlook.office365.com
 (2603:10b6:a03:54::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.29 via Frontend
 Transport; Mon, 3 Jun 2024 01:42:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 01:42:49 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 2 Jun
 2024 20:42:47 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 06/18] drm/amdgpu: refine sdma firmware loading
Date: Mon, 3 Jun 2024 09:42:00 +0800
Message-ID: <20240603014212.1969546-7-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603014212.1969546-1-kevinyang.wang@amd.com>
References: <20240603014212.1969546-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|DM6PR12MB4122:EE_
X-MS-Office365-Filtering-Correlation-Id: 382f302d-41f8-4a2b-f1c1-08dc836e79f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ECWSPPkrJ1xfRSCWb+mc+KxHjqDGjA3an1IQwZE1GrEQfSZiIPMV4A96+G1j?=
 =?us-ascii?Q?niu5UpYMnakFvyV+QbC+Rsq7QXYvwn30z/o57Dw5sdLKB2nuI0FmjYYB1F1X?=
 =?us-ascii?Q?W9vbSCBF8DudO/WCo1HFFwn9fij4nsy4t9+aUp+0fgS4fXj58YZ4hRP8l7LS?=
 =?us-ascii?Q?lRJqu35ZEWaIbOjjs3Y/T9gM95vxTBfSEUVxQnzTCcfxHtSn3IV/lHuKS+Ly?=
 =?us-ascii?Q?xcWZ05gzkq9lnAlSPpwgtbRt8pXJ3h8pyh7DiJam1eXn5228CVGyiMoF6I6I?=
 =?us-ascii?Q?hHScmRoIsNsCH98KPVbInYAzM8NigVp69iTULEWX6MNpyrr/rakG6CXyJm+i?=
 =?us-ascii?Q?cBC97CdR7SlLdWV0XTzM5NkD45kQkWloNKZ1QIJTqMFqeQkL2lpezIokXCXy?=
 =?us-ascii?Q?vfp64WuSbNtN77Z9VBBzK33/6z+P+xzofZLQYJTzDOCDKLqkFMwkGbKBnNhj?=
 =?us-ascii?Q?ttN/QEMVIhBdBtueCbJpe0HOg8/Dv+iKNi6BV51N9nWLSTHnpy+rv00UDhOo?=
 =?us-ascii?Q?GMYIlkcpsMmk181f8pDvPk/xs6GYfFZ03idjyAbTRGGWkyGtmyGaqOQ7Wekn?=
 =?us-ascii?Q?aFyC7JSXkYDYJNQLyqOeH1h7v/thAVJ4gMzIzMX1YYXBT3ikRC7mC5h2HM3a?=
 =?us-ascii?Q?wZfYcN+MpvXshZ6OxOymk8DF/+PiK8Ek0MnTYG7GxY69lTOZhkN+hT3jJuwO?=
 =?us-ascii?Q?fzpiIBoymfH4sHb7ONRv7YEw0+6UouJYaHXVGFLR63qHtEnCSq36SQ1kCF12?=
 =?us-ascii?Q?o/Xxc1IcSNg1ZYOIWtQ/KHK5gMi/AqWeCUTqgb8cGn6c20xQkIi7B8t6D3ou?=
 =?us-ascii?Q?43LAY5XucHUvEuu7479KBmdrlJrN+Mh4I8Q1r/V/OcVic2xDJcoTRZQtOcq7?=
 =?us-ascii?Q?0tIEIHmLiiY1+B2OmOXx+cVBtrq5Ru64ykIs3Ha/JMDKNFiW4wdkU5bHTOzB?=
 =?us-ascii?Q?a5yIxq8tMK7GcDS2ZQY5Bljh1RWYvEvsHWMYSWJ9zAYQYtIHkPVHiCfWo1PN?=
 =?us-ascii?Q?zEbBuSd7n+QuJ9620YvGNbCnlAvEBZI198lool6QLR6fmwvBcfG4lXaAFcl2?=
 =?us-ascii?Q?UF1p9kMvVN83TQjCp5Epi3YoEYgC7OqiSaBcksfSPD+EG/g9+50TXBVZxG6W?=
 =?us-ascii?Q?V7we4kwT5gWcY5Ve/hBwRZwP4p0+w4E4pXebv5bYGrZF3em7l5B9co7kMrVN?=
 =?us-ascii?Q?XWUkHhfCXfOFqJdzlgXdOT4/J2eSY2KfeDd4IkVeXXe46FuiOYiNC37BdlUa?=
 =?us-ascii?Q?HJKSjIvzakVNg2RYFLGt++OnhFsDzZ50KeBAqCS+INS+hFDwiTi6+1qOTliR?=
 =?us-ascii?Q?Vijb1w7RKQcLzEvYny33nvK8tqGiiMJfy9G15wczPngHXlvMK6j2Kiqm1jgw?=
 =?us-ascii?Q?A5wincw0Y5Ge8CLyT7Zxndyoy7vI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 01:42:49.4189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 382f302d-41f8-4a2b-f1c1-08dc836e79f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4122
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

refine sdma firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    | 11 ++++++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 11 ++++++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 11 ++++++-----
 4 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 151f83ea803b..183a976ba29d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -215,14 +215,14 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
 	const struct sdma_firmware_header_v3_0 *sdma_hv3;
 	uint16_t version_major;
 	char ucode_prefix[30];
-	char fw_name[52];
 
 	amdgpu_ucode_ip_version_decode(adev, SDMA0_HWIP, ucode_prefix, sizeof(ucode_prefix));
 	if (instance == 0)
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
+		err = amdgpu_ucode_request(adev, &adev->sdma.instance[instance].fw,
+					   "amdgpu/%s.bin", ucode_prefix);
 	else
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s%d.bin", ucode_prefix, instance);
-	err = amdgpu_ucode_request(adev, &adev->sdma.instance[instance].fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->sdma.instance[instance].fw,
+					   "amdgpu/%s%d.bin", ucode_prefix, instance);
 	if (err)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 6948ebda0fa2..952737de9411 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -107,7 +107,6 @@ static void cik_sdma_free_microcode(struct amdgpu_device *adev)
 static int cik_sdma_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err = 0, i;
 
 	DRM_DEBUG("\n");
@@ -133,16 +132,18 @@ static int cik_sdma_init_microcode(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		if (i == 0)
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma.bin", chip_name);
+			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
+						   "amdgpu/%s_sdma.bin", chip_name);
 		else
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma1.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
+						   "amdgpu/%s_sdma1.bin", chip_name);
 		if (err)
 			goto out;
 	}
 out:
 	if (err) {
-		pr_err("cik_sdma: Failed to load firmware \"%s\"\n", fw_name);
+		pr_err("cik_sdma: Failed to load firmware \"%s_sdma%s.bin\"\n",
+		       chip_name, i == 0 ? "" : "1");
 		for (i = 0; i < adev->sdma.num_instances; i++)
 			amdgpu_ucode_release(&adev->sdma.instance[i].fw);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index ac8a9b9b3e52..725392522267 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -127,7 +127,6 @@ static void sdma_v2_4_free_microcode(struct amdgpu_device *adev)
 static int sdma_v2_4_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err = 0, i;
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
@@ -145,10 +144,11 @@ static int sdma_v2_4_init_microcode(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		if (i == 0)
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma.bin", chip_name);
+			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
+						   "amdgpu/%s_sdma.bin", chip_name);
 		else
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma1.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
+						   "amdgpu/%s_sdma1.bin", chip_name);
 		if (err)
 			goto out;
 		hdr = (const struct sdma_firmware_header_v1_0 *)adev->sdma.instance[i].fw->data;
@@ -169,7 +169,8 @@ static int sdma_v2_4_init_microcode(struct amdgpu_device *adev)
 
 out:
 	if (err) {
-		pr_err("sdma_v2_4: Failed to load firmware \"%s\"\n", fw_name);
+		pr_err("sdma_v2_4: Failed to load firmware \"%s_sdma%s.bin\"\n",
+		       chip_name, i == 0 ? "" : "1");
 		for (i = 0; i < adev->sdma.num_instances; i++)
 			amdgpu_ucode_release(&adev->sdma.instance[i].fw);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index b8ebdc4ae6f6..aa637541da58 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -267,7 +267,6 @@ static void sdma_v3_0_free_microcode(struct amdgpu_device *adev)
 static int sdma_v3_0_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err = 0, i;
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
@@ -305,10 +304,11 @@ static int sdma_v3_0_init_microcode(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		if (i == 0)
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma.bin", chip_name);
+			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
+						   "amdgpu/%s_sdma.bin", chip_name);
 		else
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma1.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
+						   "amdgpu/%s_sdma1.bin", chip_name);
 		if (err)
 			goto out;
 		hdr = (const struct sdma_firmware_header_v1_0 *)adev->sdma.instance[i].fw->data;
@@ -327,7 +327,8 @@ static int sdma_v3_0_init_microcode(struct amdgpu_device *adev)
 	}
 out:
 	if (err) {
-		pr_err("sdma_v3_0: Failed to load firmware \"%s\"\n", fw_name);
+		pr_err("sdma_v3_0: Failed to load firmware \"%s_sdma%s.bin\"\n",
+		       chip_name, i == 0 ? "" : "1");
 		for (i = 0; i < adev->sdma.num_instances; i++)
 			amdgpu_ucode_release(&adev->sdma.instance[i].fw);
 	}
-- 
2.34.1

