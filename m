Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB861CD5BD1
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 06:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72D9610ECAC;
	Thu, 28 May 2026 06:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E4gcIRdA";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8BA510ECAC
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 06:42:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBoKtMW3HT3h+azlidnB5k4srPOx0/p/1xSNe5YHkpi8bGn1gaemMsnxW3Ux0qIpWuPd6fYmdPeL97NvUKbBrMvfY7q8XedjW2fCY+VR3syXOuRF1B2ZrQKvBusnDseoJlmV2kWY7wDUt0nG8BMH3NfbR7aasaImzq/Ijxdt/RYEp6Cq+MMfyuA3C+ZwRqyN2PdNGVB3bC7/KZLba5Z15vC48nNFQY1RTMleAJCTVk9Iuw/KHKxqRMKon6ImMTbsq7MzxTeXsLe39LRac6sgq+k7nMloVh3Mf5vSpOjkLtfki9ZsDC3NunFTy07ljwMwpJy0jwIF2GcKPhLXeCtWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7wSb68TRCcVEe/dl6oVouvi6EGqF8vMl9sVJF2WstQ=;
 b=koDyQV0OO7tGiCv9SRRyR+nu+oPJuB+2aSg2fOxCMIY8XEnmPOeYM6Yh4+OIUKalTvh6uLC7/zSlb01gaXc6ppY53wfm5hWI2O3nJ/l0St3N5lCqu+DnfM8TLwLG/SnrjEj275jmZxhy7rKIEitW5JNaAFFkUZ27u1NjOaHBkkhHYvsjhkoE+JDkS2SRgHgQwcTAVMUWPv9iVKgIfumP2La5FJnxKDXTxrXZFJcFldtFLUJn+Y3845o7mlw/bKqIJ/MGz7hvU+hRFlSsrIrOw1qeYYTBtcZ3aej5VNO6UHwPyHG7rC2S/jRXM9dKP9y+cvI6HgmbpQMkOY7FK1YCUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7wSb68TRCcVEe/dl6oVouvi6EGqF8vMl9sVJF2WstQ=;
 b=E4gcIRdAUuzWGX/ZyN/4shx0RKH/ux1SUE3ps1Ws8Gs74FBrtwwrqPOb94ipW/1oEcx33Z3I/7yS8zU3/zuPHM7hbGOIVEYATxd16/MM5SKktOSfYHbgM878EtcrLJ+4b0izNjBQSqRyw3DbNBT90516YlxcAJu8jmVMBkaYo5Q=
Received: from BL1PR13CA0095.namprd13.prod.outlook.com (2603:10b6:208:2b9::10)
 by CH3PR12MB8584.namprd12.prod.outlook.com (2603:10b6:610:164::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 06:42:29 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::2b) by BL1PR13CA0095.outlook.office365.com
 (2603:10b6:208:2b9::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Thu, 28
 May 2026 06:42:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 06:42:29 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 01:42:27 -0500
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH 2/8] drm/amdgpu: add support for SDMA IP version 6.4.0
Date: Thu, 28 May 2026 06:42:00 +0000
Message-ID: <20260528064206.12358-2-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528064206.12358-1-Pratik.Vishwakarma@amd.com>
References: <20260528064206.12358-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|CH3PR12MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a0d8fc7-a191-4f2b-2a64-08debc8449db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 1p2vObaLYylmoWR371xcag0bsTKTAwZ/qaVsRAPccoUAnQJY3TSZiGdVr06PLBa2wRU/VtCvrhnQLSO4HsAuKuwCY2p+8JuvMnpqlb4hWbDtNusdPrEQov+x4wDFDq56AKrVfHBIFtABsiRUhSyX4v5nDnZCgNOzPgIWMPzT/A8mZvohsyvbFJpQPono7zAa8eMlYKX93dT4HGXT+ejfrGVCl17g/4LiwNXtSnR4D2HF3s+vyeSogpKWCHmAS8Kp3iCe7OHdPEE/gASRCRzYYjkuBzr/14oOholtzmj1sxLaf8EtO6OS3okAbWVSpyvW/MZNoWBMphgRKNlZKugPV66L0LbMI6UUCojt7669JH7l2GN3nFahYHgGX2OIYUsJgy4m3lG4GTH5J+VkIrZ8k8KFx2eZjrqIYMp2oAceKtn8opf7PRbze1yo5+xtoyyl4CPfKZQEB2erbwT6rx5K+XD03l0/YbXLkKOQySLoePiUNxGQ+jEzXB02tliKH8JxT+f1CFyRSc7TkO9SK/Cmo+kZVifeVsNaCrYiKR5AjYflPS2Mh4sPLVdedko6ttYQ7qkDZiznp07oUnf5lQ2X/0gNkBhIxRV0QRRs/99YeK1sQpLFShQTe0N2+T/MpyU2roXS5rD5eA7mAB6V9YGA5VHNl5HcmFRDZgoRKfVyMZrUMD/UieVta1DNQAu3ZZGhmFd9fD7ZMgvPjj79NTMNRBIlE1bPEg80zx5Xs95V56g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jur15Zf4JMlsvJ5OEP3knFjm8MVRCJ6QpEgmKUpE+6TSORjrCxsPvI8kNGUO1ACdU149zL1EZvy4pLnZc9W/lEQd0D5NA6Pw85uzTlwmDjlAnmuxt3+tpaDMS2dbnIR/Qz3i0m0CW0jSiuMqaE4FfmMnD+ej0FwljWlKT/9OjNp/cELK4Wzsz+7vTYhriOEfkZO6Ty+yl8gLkjiWrr1HuBN4rJi40TBiK+oT6W7b3YdgLz2J1ZvG7yqqr3AlULznNu7174PMjHOryQbgmy4864qkNA3vjXjp91i7D6RYWil6Q2GEndVdkCT8QxemXJxCwCsvfHU5VrJrkrC6wSF5AAn0w+mYnXALi0ODfAlaARunEe/+rQKlAwUrG34r+MvXsHVkSUDWfqRVocNAiF20CWgYw3AqXjW196yRKRkgULDlkeb2cIl382LGSr15YTQx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 06:42:29.3560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0d8fc7-a191-4f2b-2a64-08debc8449db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8584
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

This initializes SDMA IP version 6.4.0.

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 5364b0540613..e23eda0c4ea5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2542,6 +2542,7 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(6, 1, 2):
 	case IP_VERSION(6, 1, 3):
 	case IP_VERSION(6, 1, 4):
+	case IP_VERSION(6, 4, 0):
 		amdgpu_device_ip_block_add(adev, &sdma_v6_0_ip_block);
 		break;
 	case IP_VERSION(7, 0, 0):
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index bf09ac841a68..d894b7599c18 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -55,6 +55,7 @@ MODULE_FIRMWARE("amdgpu/sdma_6_1_1.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_1_2.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_1_3.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_1_4.bin");
+MODULE_FIRMWARE("amdgpu/sdma_6_4_0.bin");
 
 #define SDMA1_REG_OFFSET 0x600
 #define SDMA0_HYP_DEC_REG_START 0x5880
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 69facc5a544a..57b40f4d035c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -106,6 +106,7 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 	case IP_VERSION(6, 1, 2):
 	case IP_VERSION(6, 1, 3):
 	case IP_VERSION(6, 1, 4):
+	case IP_VERSION(6, 4, 0):
 	case IP_VERSION(7, 0, 0):
 	case IP_VERSION(7, 0, 1):
 	case IP_VERSION(7, 1, 0):
-- 
2.43.0

