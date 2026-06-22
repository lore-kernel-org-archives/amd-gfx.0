Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA50CDB466
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1DF310E586;
	Mon, 22 Jun 2026 08:46:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oYj2ImgM";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD3110E586
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:46:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLcQx1KzecYL7fBa31H5n+tpI50TUSB3Ko8lApoKeDqLEy/qo8n0oMxEyyGbNDFuE0rgwW8KWnd8bi2Jr4x3byCAoJOA8zfqgQUe8Xe4Vn1wemM40kUwOOryUABfrSpXZOaK/xPw49qD3YpQRGmuQs4Ejuq3jjMSmLeqzHKQC7CvF9ZQXhXmeEcnEV0NFOmVtxMhUZqASegt6NUMqc/ECPZh1neGIldM6V0jc0d/+CF1VerPzeN874EhT1zAXVgo5NXrB0hDEeVuNEqVv8V/+s/kjzz0ZOuhQ2k80DzErAZGsHJScourb+9Jy4X4a/oxqagvqOIuprY0eATGUwmH8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sm7jDeaQ2hh3hhYck+6ipLrH/VyL+r6zqT3HLDdc/dw=;
 b=IirH6WhZ4VJKHEL7/aGpIttfEcGWbVo+BnY8zksp6tVkJi8LmBrYOm0FHe/xs3GYbR99we0UikAmbF4+JRODEQ5FvAVf8t5cnShbuRHA/aQVSUAJQk5I2ylFQVBNINx1HoibyRdMn+wfNzCKz58AMQomB7nOrhzC6iGh5th71hGdIBVop1LXCMsJFdNVcbLy3MYVtuHQPvgA3wNtMvOjmUaRc+SKnhWXlJYDajoMSEYk5t3A7eOYyzbl05Cbg+EOOJt1ohuDw9Yjgd8ecR8bDHGzKrJ0w983uRNupnirwQfV4yCEQpFQEfBnuT28ZeKIm7Gz3tWrrUzVDT3QF0oOOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sm7jDeaQ2hh3hhYck+6ipLrH/VyL+r6zqT3HLDdc/dw=;
 b=oYj2ImgMh+D21jhCgMbo2VP0+KOWFw3sIgkJoAJgCu01AddjbaC30U7y6OC7HISw3T+fpz3LdZjaH4ZN+XAENPBMePoICbFnLOHH6Vb3wcFVIPrsUDgMHOBhMPBPOP+bo+m210raIor1Z4eZYAeO+UskbtDMLk+XUw9d1R526oQ=
Received: from DS1PR05CA0016.namprd05.prod.outlook.com (2603:10b6:8:23f::12)
 by SA5PPF50009C446.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 08:46:39 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:8:23f:cafe::29) by DS1PR05CA0016.outlook.office365.com
 (2603:10b6:8:23f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Mon,
 22 Jun 2026 08:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:46:38 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:46:36 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 45/48] drm/amdgpu: retire legacy get_retire_flip_bits
 interface for UMC
Date: Mon, 22 Jun 2026 16:44:47 +0800
Message-ID: <4ac315a6c2b9ce1baabd6f37d7b1e3dcff0e6235.1782117608.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|SA5PPF50009C446:EE_
X-MS-Office365-Filtering-Correlation-Id: d150f2ca-ff66-43d7-b3c6-08ded03ac652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yEvzTmvWgPrXW/+teNLodM9lmCDsq7VvLlW1hpNFqbdxH4BXsO2OMWO2KeFbkhrAFOSS/d75OC2V+UtIDWAmDplYC8xvAC6+JO7urr582B5Kl4djx65HmCDSbt5VGke5PECgPJ6Tt2rT0XPyYSdCxcLZaVjnAl628cn7TN6AvR//PGtS3Lx20BS8Soeu0tmCQcBF38XiO/qJ+2u5utlaoxnb33gNLMAOJ/pixq+AOgg83yTNOh06Z9IFMC+vWUe8gPydrqWVv0Q+LHi23JZWPmjjOEMnCqmUS/nARpycDM0+aWKeeePomfFVWS8chScpJ/V93DWB4LEf4EjtzqctOdR+zyxtL33iy2fmMyKBT3AETtlkrqX0DIKv5/iBgJpUE1cjKaKkSZfQ42Vs8478h9Ygb+Td985uZHrAJtA5O7ds76cSPCnIW841NJTs9wOaz32S/08EJyjItBM+V5XiFj3U+STYHeHI5wXsg7jOG2LdGqaRkrado33HCAO5XErLXkgLP/uPC/CyIIG4dY+UHeBZMSeNbPYPQNoBc8FusV51KmX8R6zWVVmZ2NvzcTPk3FTXXd9ru/qBaK7LlHV3+udZ2MTTgDEdubfp5SY3iFTT1zZVDzAxFaaEJYpAKXEw2sKWnDSP4XGxTpc80Gz9f1VePgtrlzIpFeTn3NWOwJMfoLb45BE7iQedyqtwDY4DBe2mtVnIGziyXoypdVaZhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Cs06xUxYvhStCB+zByv4HWw3YPJjexTVaDFin1etpqJveC8LRFW8GgBXzNuuxuSjGUygUKaCoNTWlgqVc5gYhQ03KFzvNivQ9IIWVUGzaVnczJdMcy5jcr0/yGdiAC3+PWIYlraP16V9AMt5UNDE0XgeKjPlWICl+9RWYwIRRZGwYKPqnCRYNmRXrbcbPfmyLesZyicnAyOsGOFNCrLCOpkED+wRd1UeYyI01nqKNu91LzM6/e9uMb4cX1KvnuCi7GBRwATIVPx+00lBciw/1f7zzD3E9XXt+R6xRZabM2Pij/Nt0/xtjy7uwDnsARlXKN7x9TRa4Es4I6iccl7ECGkwqlRal1fD0IoX7aNaFKTQfNqVrm/0UW3TLjmhC9HzoBiy4d5meTW89h9zRhV+Kay8zDe0V9G5cn4N/4IYlFCz78+4itNJ+garRvnubkZT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:46:38.6515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d150f2ca-ff66-43d7-b3c6-08ded03ac652
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF50009C446
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

Remove the legacy general get_retire_flip_bits interface for UMC

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  4 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h | 15 ---------------
 2 files changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e9583e8f0863..90f746ee90f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3202,10 +3202,6 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 	ret = amdgpu_ras_eeprom_init(control);
 	control->is_eeprom_valid = !ret;
 
-	if (adev->umc.ras &&
-	    adev->umc.ras->get_retire_flip_bits)
-		adev->umc.ras->get_retire_flip_bits(adev);
-
 	if (control->ras_num_recs && control->is_eeprom_valid) {
 		ret = amdgpu_ras_load_bad_pages(adev);
 		if (ret) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 46c42997d314..b2a3db60d231 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -77,18 +77,6 @@
 #define UMC_NPS_SHIFT 40
 #define UMC_NPS_MASK 0xffULL
 
-/* three column bits and one row bit in MCA address flip
- * in bad page retirement
- */
-#define RETIRE_FLIP_BITS_NUM 4
-
-struct amdgpu_umc_flip_bits {
-	uint32_t flip_bits_in_pa[RETIRE_FLIP_BITS_NUM];
-	uint32_t flip_row_bit;
-	uint32_t r13_in_pa;
-	uint32_t bit_num;
-};
-
 typedef int (*umc_func)(struct amdgpu_device *adev, uint32_t node_inst,
 			uint32_t umc_inst, uint32_t ch_inst, void *data);
 
@@ -100,7 +88,6 @@ struct amdgpu_umc_ras {
 				      void *ras_error_status);
 	void (*ecc_info_query_ras_error_address)(struct amdgpu_device *adev,
 					void *ras_error_status);
-	void (*get_retire_flip_bits)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_umc_funcs {
@@ -132,8 +119,6 @@ struct amdgpu_umc {
 	/* active mask for umc node instance */
 	unsigned long active_mask;
 
-	struct amdgpu_umc_flip_bits flip_bits;
-
 	unsigned long err_addr_cnt;
 };
 
-- 
2.34.1

