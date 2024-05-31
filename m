Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC024C27C44
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 06:54:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B83810F0AC;
	Fri, 31 May 2024 06:54:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XBXT2zVe";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C17A1112CB4
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 06:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9aazZTiH5EzIfkfJtkN/TatkirnFT8QxBjJPscGnCeygasVddlsbUbwBq1ro7ubWfDiNoGQRBdzNsquWHFEiozIxISju5tQK055p7v7QF7Zjkmbm2004MwS+FVWvaT2u5+PbzZoTq8/Hcguvp+kepya8bhR/MARshT8VUh5SOImAepqjVtahBMAV/WburEc5d/GjnYnAGVnfQi7P/mNgWNO0C1mryGPut8b+4SA58xgOz7mbygh5Xi3yU+ewxZpBGjYCL3J51gwSNk9ZouriLH3whExT2lOu1tU1SARj+72F9G2ADdHmth3B6KmqJDVoH7gVhrCP+FO7shUg3GT/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfMBuxpHcCqoMDLM3L62EBcjIEX2fdA2PFwHspjqg1Q=;
 b=G9D+XjeHQ5Q4v6dIxLHnRwGNeXYg6+GuS3tIxxunzRuwHLPBhyMgiOT7KyMmCMZ9AjqayK07XbIs7j3Ej1R1K9MoAipifXHxLgt7WvxwCCRQMKbW9mB1QOeFJXnRmTloW7PfDGNvwe5REhIY59FA+3GoBrd4pVmrnWLGgnw76mPG53O028z32aXROMW38OoAVkf/AVebjlOQKTL9fVyDQgfIntuCHMnoFXgWWhgroRp5FsqROwyMyocCAUcr9DuE3hVJAbj0JhK/9Q1i3lQ6DpsmMrQ0ntdJMCoFzTUd4QDTtiWejD7jLo8k0wtbtF4xkzxpSK32XzE3zm1ByMOluQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfMBuxpHcCqoMDLM3L62EBcjIEX2fdA2PFwHspjqg1Q=;
 b=XBXT2zVeTP5ta6Gk36/NtH65k9Mwpc4tOWPJSpwEGiKC6afrxWEvuh6gcysW5WVyrwPht5tuJ/ObmNE0kNCHuzAJVer/GhFN/437jYcru7fpZg952EVzhn+BASw0d41oJAsE0dKW7okdKsXD8Evjs8EmDdNmgqbeBY4lNU9KcC8=
Received: from PH8PR05CA0018.namprd05.prod.outlook.com (2603:10b6:510:2cc::21)
 by PH8PR12MB7026.namprd12.prod.outlook.com (2603:10b6:510:1bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Fri, 31 May
 2024 06:53:24 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::f8) by PH8PR05CA0018.outlook.office365.com
 (2603:10b6:510:2cc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.14 via Frontend
 Transport; Fri, 31 May 2024 06:53:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 06:53:23 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 01:53:22 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 15/18] drm/amdgpu: refine gfx9 firmware loading
Date: Fri, 31 May 2024 14:52:46 +0800
Message-ID: <20240531065249.1746350-15-kevinyang.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|PH8PR12MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ece6529-826f-49ad-c135-08dc813e5daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zBUhGfusVR1A9m6rgC3htuEOf7DJLgIqiCkWE0KYQxC4NqNBtnOZCo2BMwwn?=
 =?us-ascii?Q?nWd7rIva09bnobB3GV8hpWJWfyqJOCLdL2JL2p/2tDFRrUDr/o1ubeYVbXVp?=
 =?us-ascii?Q?IvEHR16Cn5ZoJJNbPfFxzn5Hi7n8dqeYlGxJcSHKHZ2i2kt1tGoIaBn8Mi2w?=
 =?us-ascii?Q?tbjm3IFOSvRDKaYE361cG8AX6CBD4Hkjw3D16+6Rknxnlwe90mcCpPJf60yQ?=
 =?us-ascii?Q?FVWLDZPPV3TV1MdFbaXtAuO0Yu9MM4f9zqweLKvxyXCFXsaCKtTkXj7AadLE?=
 =?us-ascii?Q?SZ0xCF9hcUVt4+71GHzi3GmWSHJ2iNQz/yc7D2S2xtbrq4bwapIcv8p+9xWs?=
 =?us-ascii?Q?vsu1/v5mcVkn+M/mWxbj4c8tZjXrWQKiyRlPYwdOhlru/SomQHaHObyczaOx?=
 =?us-ascii?Q?LgiGxnqRUnVO9vfYvKvjUFaWm7PoFIg0QPX3gb1kHva1LcVVaN+ABYdyGZ+D?=
 =?us-ascii?Q?mUPx+FhCZxVPvhxCU0toJWRx9WIv7uVR4JQ7yBoIGzfSHXa6y39ARXjHfxZf?=
 =?us-ascii?Q?mfMzezgizmgQWgnxh/vnZXYKXiCg6ssYGFRchMUCl1VQwFiAxbbo8dCf98C5?=
 =?us-ascii?Q?HOAvHBGxJ58FMbTmqQa/PIwL6sHkFB5FEn5bHtmIkc5hf+C3QVaznfHdnOwd?=
 =?us-ascii?Q?cDBXNrVS3ExVZfBXCer5T2N9vcAb43EZpU9SwTqG4ktcevDij4FcNz0s5MHv?=
 =?us-ascii?Q?cogmfhuJdfsgt3YxIVS8DXIrFzHInYEfqlMci/nU3cnwOpu6QBzmBDnt8uVB?=
 =?us-ascii?Q?4XuVnWz7avsTwDJo6UDAXlfGdemMopeyhf6OBqZPlulB5XQYR9UBVD9yOKHY?=
 =?us-ascii?Q?Gmhyvobp40hJB8DDhi28EEizJvH9oUG9EHH57Zd5Z2ezCGChENt+EV57GJtc?=
 =?us-ascii?Q?uVcohwE3jsWQzKyef/MUF694Tj7FVOMosJl5kQp5kgMh5abTdK3DL8EjPdsC?=
 =?us-ascii?Q?wZpOnD/1fsaoSUqLPCb+fOWxTZh2NwojrtQ2BFAUYGjxe7CorNyp+qJnDzRn?=
 =?us-ascii?Q?i3oWOLSuHy6svnAqbZ3f+MDV3vy2tsf60TNWBWdm++gmhEEXGvdoFOO3ypKQ?=
 =?us-ascii?Q?N5CfRJyuXMWUKN/Lz5LPRYGcEWhf3gJoNnjGFYJVYCrFtEYy6+XiYhBbgYYU?=
 =?us-ascii?Q?sknLLg2784LY/Yaz2G/2wgy+AhCOX2aW1RHjaVDtdN79QuEDrLhahDAG14Aa?=
 =?us-ascii?Q?17RYsi0gYdLTqVZd02KyxGBI3h/jhjl05EJvIJHHT/z+z5LVIOXKIXRTlwBu?=
 =?us-ascii?Q?PjiFLbf8VXTqspaFzH0xR+W2wXREHaNnM98hg5BvZFnKb3+pE8fwxrslPQBm?=
 =?us-ascii?Q?oiz1XFmZUGzRMuV+OMwrnHaisSGajbl3OFW8sqhH74j1/omZdVSe+HjMiNTz?=
 =?us-ascii?Q?WNVRVWRiYfo5R0c2gYJ4enOYiPos?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:53:23.8428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ece6529-826f-49ad-c135-08dc813e5daf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7026
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

refine gfx9 firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 45 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 11 +++---
 2 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 3c8c5abf35ab..2a593fbc3c56 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1249,23 +1249,22 @@ static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
 static int gfx_v9_0_init_cp_gfx_microcode(struct amdgpu_device *adev,
 					  char *chip_name)
 {
-	char fw_name[50];
 	int err;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+				   "amdgpu/%s_pfp.bin", chip_name);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_PFP);
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+				   "amdgpu/%s_me.bin", chip_name);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_ME);
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
+				   "amdgpu/%s_ce.bin", chip_name);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_CE);
@@ -1282,7 +1281,6 @@ static int gfx_v9_0_init_cp_gfx_microcode(struct amdgpu_device *adev,
 static int gfx_v9_0_init_rlc_microcode(struct amdgpu_device *adev,
 				       char *chip_name)
 {
-	char fw_name[53];
 	int err;
 	const struct rlc_firmware_header_v2_0 *rlc_hdr;
 	uint16_t version_major;
@@ -1300,20 +1298,22 @@ static int gfx_v9_0_init_rlc_microcode(struct amdgpu_device *adev,
 	if (!strcmp(chip_name, "picasso") &&
 		(((adev->pdev->revision >= 0xC8) && (adev->pdev->revision <= 0xCF)) ||
 		((adev->pdev->revision >= 0xD8) && (adev->pdev->revision <= 0xDF))))
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc_am4.bin", chip_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+					   "amdgpu/%s_rlc_am4.bin", chip_name);
 	else if (!strcmp(chip_name, "raven") && (amdgpu_pm_load_smu_firmware(adev, &smu_version) == 0) &&
 		(smu_version >= 0x41e2b))
 		/**
 		*SMC is loaded by SBIOS on APU and it's able to get the SMU version directly.
 		*/
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_kicker_rlc.bin", chip_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+					   "amdgpu/%s_kicker_rlc.bin", chip_name);
 	else
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+					   "amdgpu/%s_rlc.bin", chip_name);
 	if (err)
 		goto out;
-	rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
 
+	rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
 	version_major = le16_to_cpu(rlc_hdr->header.header_version_major);
 	version_minor = le16_to_cpu(rlc_hdr->header.header_version_minor);
 	err = amdgpu_gfx_rlc_init_microcode(adev, version_major, version_minor);
@@ -1337,28 +1337,27 @@ static bool gfx_v9_0_load_mec2_fw_bin_support(struct amdgpu_device *adev)
 static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
 					      char *chip_name)
 {
-	char fw_name[50];
 	int err;
 
 	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_ALDEBARAN))
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sjt_mec.bin", chip_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+					   "amdgpu/%s_sjt_mec.bin", chip_name);
 	else
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
-
-	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+					   "amdgpu/%s_mec.bin", chip_name);
 	if (err)
 		goto out;
+
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1);
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1_JT);
 
 	if (gfx_v9_0_load_mec2_fw_bin_support(adev)) {
 		if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_ALDEBARAN))
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sjt_mec2.bin", chip_name);
+			err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
+						   "amdgpu/%s_sjt_mec2.bin", chip_name);
 		else
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
-
-		/* ignore failures to load */
-		err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
+						   "amdgpu/%s_mec2.bin", chip_name);
 		if (!err) {
 			amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2);
 			amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2_JT);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index aecc2bcea145..6e1598128209 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -372,15 +372,14 @@ static void gfx_v9_4_3_free_microcode(struct amdgpu_device *adev)
 static int gfx_v9_4_3_init_rlc_microcode(struct amdgpu_device *adev,
 					  const char *chip_name)
 {
-	char fw_name[30];
 	int err;
 	const struct rlc_firmware_header_v2_0 *rlc_hdr;
 	uint16_t version_major;
 	uint16_t version_minor;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
 
-	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+				   "amdgpu/%s_rlc.bin", chip_name);
 	if (err)
 		goto out;
 	rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
@@ -409,12 +408,10 @@ static void gfx_v9_4_3_check_if_need_gfxoff(struct amdgpu_device *adev)
 static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev,
 					  const char *chip_name)
 {
-	char fw_name[30];
 	int err;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
-
-	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+				   "amdgpu/%s_mec.bin", chip_name);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1);
-- 
2.34.1

