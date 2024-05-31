Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7147C27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 06:53:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C372112FDE;
	Fri, 31 May 2024 06:53:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nJRzkYXn";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FB18112ADC
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 06:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4tEYCJPWmE01ds9NW71Tz2CGCkA8xd2NfJgB+n4a8XofOLGaPn9Vyz+7CqxyJSdrNTzDdRT5gI+NlMESlgVlu+H7ywgjs5uCUFmEEZa4JU3m4B4imKSVeDOk4WvpXl48i8E/e+Qbhf1k6teTiUavW0OfGvyUI+YX+W28WgrRqMsgnjuX7Cdd2FC88J+Ip3ewhMITayIJk6NVS3ongJ3bl5uoqTue149UyGij4ZC6tpqOinXa+4XqHw0d9zoM93IsfWN8fqEWLEsuh+Z8LSwykCUytwuV0fjtQv8F/D7fZP7zPmT/PHwmJHm8lzBPJepZZFeLtdejJ2D/WL9jaNSbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hIMKC88K6FK4W/mOccG+6VITXsq4OLuPDh1ikvbEGM=;
 b=kRk78BYBdO50dcqg58Pv0AK9EO/MW4u8WzB+BG3bk/KhVQBKcgX6T6UUPftzNnUdULLnTk1jtz/m81kYrGg6wWZHxxzRPc45H399xFo7SeCKPA4ZmY8GCIPhRvHf+Tkv5l87MrIrI8JEOgVglVSxtBuh/mEPjbNjFbC/geaNNvMkZMXmH/AZ4kDMkn0WOkiW2yP4MgwwbkTPm8Ll6O5gYpoE0ZSxjOxGAJRIJRxJ22PrJmV/CtW88loXnTjv4C+XY8gCCPmixrYdyHV5JNLqQ0pzdCY7LIgH+63I/mthJAILbJj+DapcP7X0SmHrI2uAtth53Dj4yNar6kNAoXmJ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hIMKC88K6FK4W/mOccG+6VITXsq4OLuPDh1ikvbEGM=;
 b=nJRzkYXnS9drDCPwCH8LMY6N/Melmnzgqaz3Twa50JulPOfxrUZR4BbiojOqGRH8L57bnkqPIdJDIb1umSIeV2lyZy7X/J/jEGnilUza/6SlBgC+gtPe68rbhmqlIdyZI+jjvjUDcq7m5mF70G3SHt7aTs6tKZcY5x102mGusXM=
Received: from PH8PR05CA0014.namprd05.prod.outlook.com (2603:10b6:510:2cc::7)
 by DS0PR12MB7607.namprd12.prod.outlook.com (2603:10b6:8:13f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Fri, 31 May
 2024 06:53:23 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::4e) by PH8PR05CA0014.outlook.office365.com
 (2603:10b6:510:2cc::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Fri, 31 May 2024 06:53:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 06:53:22 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 01:53:20 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 14/18] drm/amdgpu: refine gfx8 firmware loading
Date: Fri, 31 May 2024 14:52:45 +0800
Message-ID: <20240531065249.1746350-14-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531065249.1746350-1-kevinyang.wang@amd.com>
References: <20240531065249.1746350-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|DS0PR12MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: 471ce594-e8f6-4dd7-6634-08dc813e5d12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eeucjxKnhs6sHC6A3FtUdzxX+SXKJ22ZyRbOv7AuaY9R4NgnHh4kbwat96I7?=
 =?us-ascii?Q?NUHOSEoShNUSlfAA97CThbIxxr4CyAOFLmDY0305XYQH6FGf+QP9rBmyBHRM?=
 =?us-ascii?Q?/RNt4m+M34WIHH0XCXPkqvgMBUGctVM9pR7x2mjhydcb9niGm/hK2qsJD/Gc?=
 =?us-ascii?Q?wpyzw2t3QpCJE7ESnntMFEQYBknEoBABX0ET+ZjNNhm+bq+23AsSi8KQYw71?=
 =?us-ascii?Q?SRxhfgpzqHobThC+cTyIXK4V3A8w3+td9W8KLStScbAklgkOoId9BWJFKxu0?=
 =?us-ascii?Q?F3ik1rz/2O9hCKnXEEeQeJYwiZ1eUEdrZCPSvOEeOy1E/XRhkCx+T//grOxf?=
 =?us-ascii?Q?xIcFgTE19i9FvxIUc4B0TUhUxYZOvxkGAgrlDqcGdRoBCmYOR/06gYELhP93?=
 =?us-ascii?Q?Oe8z5fsFNkWtjKUTPelY+TaDu1ZlMtE86ViUXPV/ZBZ8cfVdD5PWZD6jJj8M?=
 =?us-ascii?Q?kBkdDDr4Q4kD/w/GYjBPFNPVeaESFoc7hH/x7aEbLb5u1JND7eSUPID2msfF?=
 =?us-ascii?Q?uDwws/rlkItu91CpVV/Aaisxt58gU9dNHiMlUcJyUtB1vwpbsj1ofq4QlAHH?=
 =?us-ascii?Q?Wd9ydopZ7NugnqMbk1BMBtY5YtqKVbfUBqmP8nloA41Ukn75CtdjCztjnGn0?=
 =?us-ascii?Q?5Z15Zqvl7bvDN10ctJnEzG5PfZLL83nhzEWCwuS4twQfWxXuh2grPlnvCbX1?=
 =?us-ascii?Q?bbZH/qZ2mOSJyF3uulIEklJO+jyC2uuGWuni9nz4dx5z81mk98CILNPh44Gi?=
 =?us-ascii?Q?G9hLiJRustoq67J9xcmroAQKdE6/I4kvgwwPbRwnCLBdIjWATWiDBypWfVPT?=
 =?us-ascii?Q?g+mjO6mnhF0NvFoNTXoSwoP1MbJogTmj/lKSh6E86lkbQB4hi8A05GwbjZsn?=
 =?us-ascii?Q?PKZXCxvY2QvmzYHLWDoZSg28VC2VaZ2aErIIf3w9IbdMjaf1PbGZ+7enHySH?=
 =?us-ascii?Q?g7xYQW2MsYtq7Q5/kQcOfL5UwQZ/x9q8ptrAMUUKVs4DPR/pVCzTCYg3Rgb3?=
 =?us-ascii?Q?FG1JvnLk0FnDgeBtBrYLyvjpRhU9rIpwY+U6MRdELt/VyA6Rv/VwevFmP+dE?=
 =?us-ascii?Q?F0M9jrN6c4I3anhhE5I88/Mh3kyeDvz+RzJfW4Alozu0dIT7wE2P7juuobc2?=
 =?us-ascii?Q?KyMtMY3p9um0rj0EXIbeMBNpihRBtozUSPDyYbwvatlTLESRCjKZ3GF2/+CS?=
 =?us-ascii?Q?nfkwqi1nEYjZBDx3M7ayT2QqZRtmz2gNjISOEX9aQvuqvownPNJ6obQk4sqa?=
 =?us-ascii?Q?op/QnZv/dhvBbXNoiKBLtoXfYj4HuCyb0kcYbrE2YwpdK3PCEruB0zxJX5No?=
 =?us-ascii?Q?mq1AUUEDkZSD9dlH8OfcMtoLTL5lK0p1FOF3QivHs2oFAmpB5lLFKXHEsgWo?=
 =?us-ascii?Q?UVgQ3SCLVP8zncG0Wrl9+EyKVdhO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:53:22.8116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 471ce594-e8f6-4dd7-6634-08dc813e5d12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7607
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

refine gfx8 firmware loadin

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 69 +++++++++++++--------------
 1 file changed, 33 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 2f0e72caee1a..ed61aad2ca78 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -939,7 +939,6 @@ static void gfx_v8_0_free_microcode(struct amdgpu_device *adev)
 static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err;
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
@@ -982,15 +981,15 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 	}
 
 	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp_2.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+					   "amdgpu/%s_pfp_2.bin", chip_name);
 		if (err == -ENODEV) {
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
-			err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+						   "amdgpu/%s_pfp.bin", chip_name);
 		}
 	} else {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+					   "amdgpu/%s_pfp.bin", chip_name);
 	}
 	if (err)
 		goto out;
@@ -999,15 +998,15 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 	adev->gfx.pfp_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
 
 	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me_2.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+					   "amdgpu/%s_me_2.bin", chip_name);
 		if (err == -ENODEV) {
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
-			err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+						   "amdgpu/%s_me.bin", chip_name);
 		}
 	} else {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+					   "amdgpu/%s_me.bin", chip_name);
 	}
 	if (err)
 		goto out;
@@ -1017,15 +1016,15 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 	adev->gfx.me_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
 
 	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce_2.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
+					   "amdgpu/%s_ce_2.bin", chip_name);
 		if (err == -ENODEV) {
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
-			err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
+						   "amdgpu/%s_ce.bin", chip_name);
 		}
 	} else {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
+					   "amdgpu/%s_ce.bin", chip_name);
 	}
 	if (err)
 		goto out;
@@ -1044,8 +1043,8 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 	} else
 		adev->virt.chained_ib_support = false;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+				   "amdgpu/%s_rlc.bin", chip_name);
 	if (err)
 		goto out;
 	rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
@@ -1093,15 +1092,15 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 		adev->gfx.rlc.register_restore[i] = le32_to_cpu(tmp[i]);
 
 	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec_2.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+					   "amdgpu/%s_mec_2.bin", chip_name);
 		if (err == -ENODEV) {
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
-			err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+						   "amdgpu/%s_mec.bin", chip_name);
 		}
 	} else {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+					   "amdgpu/%s_mec.bin", chip_name);
 	}
 	if (err)
 		goto out;
@@ -1112,15 +1111,15 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 	if ((adev->asic_type != CHIP_STONEY) &&
 	    (adev->asic_type != CHIP_TOPAZ)) {
 		if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2_2.bin", chip_name);
-			err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
+						   "amdgpu/%s_mec2_2.bin", chip_name);
 			if (err == -ENODEV) {
-				snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
-				err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, fw_name);
+				err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
+							   "amdgpu/%s_mec2.bin", chip_name);
 			}
 		} else {
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
-			err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
+						   "amdgpu/%s_mec2.bin", chip_name);
 		}
 		if (!err) {
 			cp_hdr = (const struct gfx_firmware_header_v1_0 *)
@@ -1194,9 +1193,7 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 
 out:
 	if (err) {
-		dev_err(adev->dev,
-			"gfx8: Failed to load firmware \"%s\"\n",
-			fw_name);
+		pr_err("gfx8: Failed to load firmware %s gfx firmware\n", chip_name);
 		amdgpu_ucode_release(&adev->gfx.pfp_fw);
 		amdgpu_ucode_release(&adev->gfx.me_fw);
 		amdgpu_ucode_release(&adev->gfx.ce_fw);
-- 
2.34.1

