Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6500ECDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:46:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E961D10E582;
	Mon, 22 Jun 2026 08:46:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rV3mvz80";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CD2610E582
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:46:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYg3OzIsrLygt801gux0vosr8sZ3s1rD6axP3LxzxjXWrWPc3pN3oZ+r/w7Q3WVQCYDdmt0c9djPAeilNmmeNkzXerJ9eMVA/SzLF2fwaR6B+ligJdO18zXBb3mCqYgwWUJmRQnq6VnygDqv2pSlobeoMoRHnDXI01iWLwDwkj+PSSe32ek1FU94hQO6nBn/S+mQcsR0l3RDlSIq2bC3AspWpEVh/y3T3NhWLyQ7vkySfHIh3SU47dUPGOpfmTyxixIzuIItMBtowkzvnWxjEiG5SG6LMZWRicrS4y3M13Y9z2DxoNKJvnSVTZaJPuUpXRHdCSsswI6/MuJwiaGXOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGGyN7zPQGpEAyqBUpPqeNT3gxnyrSqUOxQtBSvQn+g=;
 b=jcsjYik9bmD3mGHac1mK2uP3+ylGrJnSvQpcCpceJo1qsZ2RwMZjsZz/jhrVqNZpUn7YWt8dRWPd33PoY9h7JslRl4yaYrAO4zZCbdA/BN2cepmvXcGfnBNlVI9osQvufW9DLbXI+C786DWHSENOaQeNLA/0HpTARrtvt1Q9vLcelqJ98HfxId1OO9zag0sh/ioAzDQrwANTHhy4AXL5s+INuDYaykKXHdIuRwacpvpl1tcoDf9NETjiVub7nPleJsxEmlpjgxx19JezaDgwepNR9zzYw1AiKuaDu/nwGgsmWj/d0zCOt1fq23fbD2gi5TcxhboJbjHAVRc3IkCpBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGGyN7zPQGpEAyqBUpPqeNT3gxnyrSqUOxQtBSvQn+g=;
 b=rV3mvz80eUQtk2ejW/rZo+wK6CQIkrK+yHN2WKCaK/+jpSNwRmCrLT60m/tNSvLkaPp248HPgPPG/a8guHK1r/EcHorKx7jNL1f5bDE+YatwJjevTBfEZXwSmwqNJ18WCbzdticlcwOKhO81UJXrCEHdyohATJAmY81xNl8muU0=
Received: from DS7PR03CA0265.namprd03.prod.outlook.com (2603:10b6:5:3b3::30)
 by PH7PR12MB5927.namprd12.prod.outlook.com (2603:10b6:510:1da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 08:46:35 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::76) by DS7PR03CA0265.outlook.office365.com
 (2603:10b6:5:3b3::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 08:46:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:46:34 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:46:32 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 43/48] drm/amdgpu: retire legacy mca umc status check
 interface
Date: Mon, 22 Jun 2026 16:44:45 +0800
Message-ID: <79a1dc885ce5d678ca3ace2294d7102f2fe2757d.1782117608.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
References: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|PH7PR12MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 7012188d-a3c2-4a7f-5be8-08ded03ac3fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: oSJRQyRfIHYGJssA+DoAQAOsC0Pq1AOazgwAJeo/+ehwd09s1xSJYN4CCn6YjOHmDUbCP0moLaprPhjBgOKE4QdNbNjcckFQBOIBBac8BdpX4hxlKHuoaufZI/0lt/IxxyK+qrQcSuA88BilK/LZYDYVKbpxG2WgCcwELd3Fxp0d4fxLFdbi2CMZlkdd5on75C6+iZzOaC2j5FcaxqwoVHAJ7x6wUlSs9y4+VizY8XF2xV5SvkWggZFT0nZpX3TkI0Y4p7T61kTN4f2HNgPLqiLV+SYCwe+brNDUWE/2R1caUDJVqWOSMXZ+GLC4nvCI0rd47FO9iXE2DFFyJyOWqceKndPjchNntiNl3eSvghgPDLLMC+qgw+uqxXLwkJBcOYbx/gEExj2bdMI3QsWcdHuaUW3iIV5MYCFceb7C5k7tUB9wFwByv8mO3mTWkBYe2wNlLjnfL3u/GxUgcjj7mfw3yfoCnCUXPzLoSD1ci0qeo3PEnDmXLcRvIRjdS6dUTqMUZA8eikKy5P9nDeUVi0WzCXm6/JrnrqvLNwqTj7LTJU03+GQLHARHODYQDSLf1IleAz8Jgc/t35op9CC/vkfewSeGhe4ROPeBPSK7Ps9XSEWuOb2qP62DeMP3OYO2PQ+jSv2TAC69WpPva9rJiRAz/fY6pV+bl3ZJDAezLo73EiyZHRRhGFlJ6bCZ1bfPoPhEZo/HUIeIAnXCKJ25rw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vekrYQm+L1PErjSBoOcyfkQoYJcXHvWK66Kzvc6BhkqRf7uRmQLZGZW4oud8f6JfdzSIzG1MgpD7YEzkUrptr1iJbma/TI+N6Nq1hVVAjZcDWRHJ8Fo0Cqh6CikqtQ7a/HTGS5YOQ9hOHqiV1ABJ+5n9uDnGcitAC0r5HhsYGD7dqsaYtjBLxasgGSR87n+Ggwiu1ptusDKx8BJvTbDapKBgxNkoif9XPGBQOrf3QnpJFI5tei/T70uq418Soj+575E5ij4nGkWHg+76AMBVG41kDIrUPXkYVQlif0XgtuLB2PQpB1c8P109PmESTmWsaf7aqVRSUbZ2cjIWK0z08GMCUPEdwQcPkzkebRBkjjolU9nsg1FsW1H0iueUu9kR05CmKgZfkl/u7obpjiDsrD+kW34gLQYC9ANDu2yTF0JekxigA3JPOu6wdoUyiOjc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:46:34.6952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7012188d-a3c2-4a7f-5be8-08ded03ac3fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5927
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

Remove the legacy interface to check mca umc status

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  3 ---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 20 --------------------
 3 files changed, 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
index 6d12f8a516d5..8ad47c5ab022 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
@@ -26,7 +26,6 @@
 enum amdgpu_mca_error_type {
 	AMDGPU_MCA_ERROR_TYPE_UE = 0,
 	AMDGPU_MCA_ERROR_TYPE_CE,
-	AMDGPU_MCA_ERROR_TYPE_DE,
 };
 
 struct amdgpu_mca_ras_block {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index cf06d5f856f9..46c42997d314 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -21,7 +21,6 @@
 #ifndef __AMDGPU_UMC_H__
 #define __AMDGPU_UMC_H__
 #include "amdgpu_ras.h"
-#include "amdgpu_mca.h"
 /*
  * (addr / 256) * 4096, the higher 26 bits in ErrorAddr
  * is the index of 4KB block
@@ -101,8 +100,6 @@ struct amdgpu_umc_ras {
 				      void *ras_error_status);
 	void (*ecc_info_query_ras_error_address)(struct amdgpu_device *adev,
 					void *ras_error_status);
-	bool (*check_ecc_err_status)(struct amdgpu_device *adev,
-			enum amdgpu_mca_error_type type, void *ras_error_status);
 	void (*get_retire_flip_bits)(struct amdgpu_device *adev);
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 67bdf7303e6b..d62712324940 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -178,30 +178,10 @@ static void umc_v12_0_get_retire_flip_bits(struct amdgpu_device *adev)
 	adev->umc.retire_unit = 0x1 << flip_bits->bit_num;
 }
 
-static bool umc_v12_0_check_ecc_err_status(struct amdgpu_device *adev,
-			enum amdgpu_mca_error_type type, void *ras_error_status)
-{
-	uint64_t mc_umc_status = *(uint64_t *)ras_error_status;
-
-	switch (type) {
-	case AMDGPU_MCA_ERROR_TYPE_UE:
-		return umc_v12_0_is_uncorrectable_error(adev, mc_umc_status);
-	case AMDGPU_MCA_ERROR_TYPE_CE:
-		return umc_v12_0_is_correctable_error(adev, mc_umc_status);
-	case AMDGPU_MCA_ERROR_TYPE_DE:
-		return umc_v12_0_is_deferred_error(adev, mc_umc_status);
-	default:
-		return false;
-	}
-
-	return false;
-}
-
 struct amdgpu_umc_ras umc_v12_0_ras = {
 	.ras_block = {
 		.hw_ops = NULL,
 	},
-	.check_ecc_err_status = umc_v12_0_check_ecc_err_status,
 	.get_retire_flip_bits = umc_v12_0_get_retire_flip_bits,
 };
 
-- 
2.34.1

