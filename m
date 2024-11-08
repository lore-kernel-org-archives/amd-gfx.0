Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C11DD5E15E
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 11:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E96610E21C;
	Fri,  8 Nov 2024 11:14:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AFSXMyxj";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49E3610E21C
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 11:14:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMbvTX6gHPiamS3fjqgCXRcVFHwC/DjZi8dXqFVZGhNDN0Z06XQgi/45ZOJdaWuNOd+gelsA+yz74ehOCNhbJyQMF9jozyghaeo3QHFl7rgbM71B69OnMNkReYqmxPnxM3zzmxKgvM+K0i8T9efwUqOwjO4/A5OfHMTBzPm/EjquyFernMEE+Z6ObYypmHnCRHroKV3F0B0VsoGjdGI82pa1pQbvZaWdQnE+gJOGq0Kc26yQP7gg8WSzEfyG4SP0J4/80oLwsUX/xAxFP6aF+7gBpRWT0Pln2lAxWC+cew7mBq17d1lpWLMERLh0APt1prlDGBgWAKs/KScJVVDeqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYcbjaanTtQsdRIYLu6wJSd9Fe8bkEVS8c08IRIvOmY=;
 b=LYucerJJFpJsQ5IctbO5H9IMtQQHYFgXai+SXjpuqRfUSx4y494F1khreZANxG9vzwyUoppYGw/3TKMNfTZaMqhGd5X4i5FrqRPkESO4dIUBa5kLCivRE5iRVhS+PS9SRD5HqCPPHEDFnFkgP6llR2ytehHB893F5k0kaUurUp4do12h4i6cnqJ1jjA8JFbwKeXRBB14SaYJ0pNTlr7wgwsx+HipIPDWneW5klYIR8Q309rIvqZnAWYYUTi+n/IQTmNn15++ILW4rWG0ThmMVyypv5JEi2yC5ieRXIrzeDHE2qu8mYt9A4Hw6xNGA+3M545lQmxksJfkTcfLIeXjAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYcbjaanTtQsdRIYLu6wJSd9Fe8bkEVS8c08IRIvOmY=;
 b=AFSXMyxj8I3E/wGE8A4bHip5zUnspkDWhqNKD/SgCjxbPNjZXG23EfzHdY8UOFYuw+0ZPT4HzmRXj8AMoZxvVdAnfxj0z1tsUG3cN/R3dOMedPM2ZMwgBSskBAyJvIkT6j/JW5JU4uaMktX9kMg8uS9zPmoYwEok5sIDEbJFQJg=
Received: from BL1PR13CA0208.namprd13.prod.outlook.com (2603:10b6:208:2be::33)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 11:14:38 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:2be:cafe::1c) by BL1PR13CA0208.outlook.office365.com
 (2603:10b6:208:2be::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.11 via Frontend
 Transport; Fri, 8 Nov 2024 11:14:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 11:14:37 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 05:14:36 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 05/23] drm/amdgpu: store PA with column bits cleared for RAS
 bad page
Date: Fri, 8 Nov 2024 19:14:05 +0800
Message-ID: <20241108111423.60169-5-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108111423.60169-1-tao.zhou1@amd.com>
References: <20241108111423.60169-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a2eed4-19c0-4d2f-c6fe-08dcffe688a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5P4DIlSM2MRvTgmemhGGUXxMucsBcBlZn/GEAXRz7/63KCye5bidJ/BXz/id?=
 =?us-ascii?Q?hNiIUiEh+cN53adb7Nsfmk9VbV56TjRUUkqaqOtPb4s0sA0f/+uh++oHIOvu?=
 =?us-ascii?Q?vPCIW1IMl7fBUZwBFzU0wgH/Q4byxc9a61wg+a7MfhVxBLV9L2JFEqi2Ha/d?=
 =?us-ascii?Q?lD7QLO6mmLHpOl3gy0wYtLJQQ9MtG3yrMhWQZ8xAWz6lvg6hMhrs5pok+Jb/?=
 =?us-ascii?Q?5RYReCkSWHW/7JC03LVMNHojTgsRc8YVhH+EsNqiOoocZiY4v80fXLyC2mLC?=
 =?us-ascii?Q?/VWHyuDe0dOmHWLfqXkhTcmOZYkOPBOb3+Ukrg1P+9p+K44BDwadEsU/bYxl?=
 =?us-ascii?Q?G5E2+W3DE8mgZJVfkrtiCWLa0bgQbOO6UX18DQnB7Z9kOXG9k/ANuE4fsnLa?=
 =?us-ascii?Q?+XwZI0qDo8c430zjLzbe4vXjW/auJUr9r2HpBQ5wI8meFHJSIzKIwHFT+DPP?=
 =?us-ascii?Q?ZC20HJa/42Cm+fXPEEQ7x4HEcpgLH4TFRxoSEoFPV5+W7yBKUGPUb2dw9AyC?=
 =?us-ascii?Q?TOGy0enUbuK5F4bdKYe1X4cuN+zNMCFNyfU/VuTVFZ5aIGRzMnXtRSlceJ6Z?=
 =?us-ascii?Q?r2EuHHHDBtvW1YbIo9FJTLi2r+uQTxeCrdZUNHjN6IA9UNFtO/p22qGH1utj?=
 =?us-ascii?Q?oRfymgyllDlpgnUjit/lIPAGH60hOsZf8enNs7zbldc6bRISNT7YdEYTBbHs?=
 =?us-ascii?Q?T7sM1YVsSkXZM4LEz7ElK35zx0cY1xQkbht/zabElZP3lDPAvNJ7QxYUpL+J?=
 =?us-ascii?Q?+4z7DMMd88sHhd5/CyC62xIgtyEO9MfPNVE8mzmJyXDRZzI6orBh9q9JvrON?=
 =?us-ascii?Q?+w9t1P2XhN28dD72RaaBUTFMfMfSgNsfA0WUI6lh/hzOn3Wo4IU0xD7GeJMG?=
 =?us-ascii?Q?5haIUCzPoRjSfRkQiiREzrnCUsyWwxnnp51ijXBhHuqoWS/uEDarBeBuD9Em?=
 =?us-ascii?Q?9aqST9Nvh8zlZlZQt6Ml8/xxEa3HRUwpQHfiMniZUaWZ7GGYjGJsC0eDu+Zb?=
 =?us-ascii?Q?U+S/pFmGwGCTsTBNkeE6jUlkBQjM/6udmpkWzPWVClhlbj925MugT/AAII1b?=
 =?us-ascii?Q?H3gOURJAb8JDW5ZHa4mhqqqypaAZBctrZ4fvMnta51dofY6Mwm7NSIrPmHX3?=
 =?us-ascii?Q?XwfMRy/ZOEKeNNSrxrp2JtH2thdmC9PW00VCtl6vGY8n5Ox+yos1g8s1UoYQ?=
 =?us-ascii?Q?TC2eGjGtdCf948hy+fjKev2dxP8ZJmffC2DgWebCAJ37KuICxZpIuRz1M4Bq?=
 =?us-ascii?Q?/LhEih1ULw2YeqrUKBcg62fQpc3dS5iAAI8fUr4IPPuXsTBmh6GMnpswGiur?=
 =?us-ascii?Q?Zo/7phVwWBJTwWPYgn23jmP6FW+gR3BGqPohLk4e+FVt5mhTAalirCilpsYS?=
 =?us-ascii?Q?HJxajN3QouJxX3Qqe760ZkWvEEYei+8YPTYm0TQ5EWO63NZSuw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:14:37.9072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a2eed4-19c0-4d2f-c6fe-08dcffe688a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689
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

So the code can be simplified, and no need to expose the detail of PA
format outside address conversion.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h | 5 -----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index a030fed16c5a..65336ae12585 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -219,6 +219,8 @@ static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 	/* clear [R13] in soc physical address */
 	soc_pa &= ~(0x1ULL << UMC_V12_0_PA_R13_BIT);
 
+	paddr_out->pa.pa = soc_pa;
+
 	/* loop for all possibilities of [R13 C4 C3 C2] */
 	for (column = 0; column < UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL; column++) {
 		retired_page = soc_pa | ((column & 0x3) << UMC_V12_0_PA_C2_BIT);
@@ -537,7 +539,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	ecc_err->status = status;
 	ecc_err->ipid = ipid;
 	ecc_err->addr = addr;
-	ecc_err->pa_pfn = UMC_V12_ADDR_MASK_BAD_COLS(pa_addr) >> AMDGPU_GPU_PAGE_SHIFT;
+	ecc_err->pa_pfn = pa_addr >> AMDGPU_GPU_PAGE_SHIFT;
 
 	/* If converted pa_pfn is 0, use pa C4 pfn. */
 	if (!ecc_err->pa_pfn)
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
index dea42810fc53..f0074abb5381 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -82,11 +82,6 @@
 	(((REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo) & 0x1) << 2) | \
 	 (REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi) & 0x03))
 
-#define UMC_V12_ADDR_MASK_BAD_COLS(addr) \
-	((addr) & ~((0x3ULL << UMC_V12_0_PA_C2_BIT) | \
-			(0x1ULL << UMC_V12_0_PA_C4_BIT) | \
-			(0x1ULL << UMC_V12_0_PA_R13_BIT)))
-
 bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t mc_umc_status);
 bool umc_v12_0_is_uncorrectable_error(struct amdgpu_device *adev, uint64_t mc_umc_status);
 bool umc_v12_0_is_correctable_error(struct amdgpu_device *adev, uint64_t mc_umc_status);
-- 
2.34.1

