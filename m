Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D81CDB466
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:21:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB50510F1A3;
	Thu, 25 Jun 2026 08:21:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JZiyiYXX";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013009.outbound.protection.outlook.com
 [40.93.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC9D610F1A0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:21:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjoP7YiYkbgrEQjtGII+q9RKtmyTvanSTBzY6wB/0lSQ2tYxKAPRBHohiT2tjlPSe/tIMtRxfWmax/cXXJ4eA/HYeM8MqSjtH6I5U4pQevIxefK0U2+KMYxpVxI/hpWKp1ONx8bEWp0iik2yG0BlOxIEWbLwOxG5W9f82Cq2D2A7syJPdhtYYYewB+Ea/teJp2y1+DHIOYKx/DoZyWiypuGuTcX0NX0Fkjz+3q0uTM1dTRbxHAKDpBvYsI3dAG5d9kAvZbZeo1f48iSW6eSpk2rFEW6cCHxGmMBJzweAP8cM/pa7m5ySZbeIYH+wEcbPyBU9pJuCT2IEnUMwGeeWNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGGyN7zPQGpEAyqBUpPqeNT3gxnyrSqUOxQtBSvQn+g=;
 b=Za+Ehq2jThGZmigvvnR0ygNZFpbci0D+mPoujON/vUqGjVq/pfPT7WWDVr9Prpztvhgw/me0OXLIyXsmn0TXB1Iy01bvKuV3cCEZTGOoGE1xACoIPsc6BCZoGu6X223p4zduLcc9J4FZE9cQw2bmO0s67QM4JdyLc4WPjd5+ICvsXBVKaRLqZ9tdQEYXWutqeAgkSDO1XNf8m9KHTZQ6F/wpu3/DslTvu1RS8Y1+ekQKWu1oZ3JlaWrmA7TZ0Q9t9SIhIq/apg21P9MQ07p+9B/gG61nuyhuOoiLl7n1Js2woBFp8v4/yKYYj6+gSd0ckkKuAoZqOEvP77wCdZUOkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGGyN7zPQGpEAyqBUpPqeNT3gxnyrSqUOxQtBSvQn+g=;
 b=JZiyiYXXeV8xuehgCMUHmBTRLlco0JEO8Pl8Mq/6FYovg3Ypph46b1FrwLuSU1NXSNpkbRPo+AVXMXfRKSZ9G2USiPxeonLVgkjkMV6R4DtXrPOAKjoAnLNfWYPD9RRSxMwNVBudDDnMKZ0pjWL/QlJjZzGnjJbqDvudx6oo7wo=
Received: from CYXPR03CA0066.namprd03.prod.outlook.com (2603:10b6:930:d1::18)
 by PH7PR12MB6737.namprd12.prod.outlook.com (2603:10b6:510:1a8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 08:21:34 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::3b) by CYXPR03CA0066.outlook.office365.com
 (2603:10b6:930:d1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Thu,
 25 Jun 2026 08:21:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:21:34 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:21:31 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 41/44] drm/amdgpu: retire legacy mca umc status check
 interface
Date: Thu, 25 Jun 2026 16:19:34 +0800
Message-ID: <5c92f688f7d2144b955201f2162e30c7661205a0.1782373702.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
References: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|PH7PR12MB6737:EE_
X-MS-Office365-Filtering-Correlation-Id: bb6aa4fc-6ca8-4275-0540-08ded292c4c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 3w1v7f+JvLyjIsQnAY69dJwQrg2bbLRWvM1TDfWb5CwOWcr76TisypND4atZ9gyHDLALLEtTnqciTlOG+xGpywghrC0fdOl9s55gs8BmrK5ThqtSRNyUPH4KVYLUY+7E0tmcch5T/VrtS5LgsGNrHsngqR/gl4BhEJAXpjegbt7rDyjf44ISFYwzQp2GW8LGh1+hnDtxDpXlc2867yHfqR3VWlfddhomRCSVxG3qsm9E9I2lYEoC41FdWMZUM6xmkiLMgK5cU7wQ9PeaUebLYUxPsFyE/jw6o+P8ibA4+I1Ex5jM93dGEmzU7im3zkFFkwNWLEbbhyi/dOKRTtIzh2Rx0cQMqLw+6maT5Z/gC6QPFGeM87Tmk2z+Yt178Y84W+Qspn6ynOmsDsfyxZdtJaGuGojTwT/utziENDE1ud2xNNKZTuQ0UuVByoiPzhM25v88De258UhmAjiqXU0XPJaiTl4LuuuY+S1GoicjNrIR1ETOQ/ejpyQ2jll7GLEpzgjirPZZ8qRAuBnSo1zwY6hGKOeywA8DTzF2THIsF7Lxz/Wb5Bw9F0fsbjAUilzy+baLPcnDpVlb8ZMPrVHTmTCkSviC2Ke20UDZIIpDL7WUE5tatLAkBS4EhEBvb+ulG+0aRbppMqQypW/0rLCoPnk4PnUvG5Zfp1SlhfbyBAl+1mp1Y705EavFwy/gx/ylkv88Hw3dCEVizFkdfVK3ng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /LJexf/RutnF1YXPlI+2qYRyU07p++Oa4Li8yU5+O6ZtooY3VwHz0Jjcjd1a4wjTaJRJSb4cXgKmXFgm6/fRoSlaEsqTRelAIEkNhdPADl/VqsdC2LIKXBxFEsKPAATk0COYzUEF3NPzv8FHa8+UyzyOhSEZ17GeDdOkLA3ywZ2M8RmxQjcXMOdz30Sr6lHV25I3p6a35gPkATIKJJ0EPjr/+Y0ecpzDoU407MdjZn1nB2SJzB9Cem6css60ZiT3ElRpgGhuj7s3wy/1c9ZqZYDhwnrTaQ5zgv2DDTC7qyZKwq67noYFfi9tHUJyEpV6YV0hHbsDZIQAzpvtKYD7h6lHiHF5KA9JZ13V8L3DG8lavAdMx0+zR76qLCLPVPRKloSbMz4/07quu/xiyKdeupJngm52+73sg/meKYeHTq62Ksz/1UTp3usamp+99Un8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:21:34.0484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6aa4fc-6ca8-4275-0540-08ded292c4c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6737
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

