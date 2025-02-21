Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296E3C021AA
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 12:19:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C44CC10EA66;
	Fri, 21 Feb 2025 12:19:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xxs2h+dR";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D93F010E2E4
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 12:19:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkWX58rhYMQMPuXR20xQuZ4sRQHz/guE/1kCBb17taz/IEc56eRxZUQrO2WZ9H1uJUQ6pDPA2HECSXvNvcCMEPNnA1Y13rsMM0xqAeDGQg/+5pnS6KKLQiRF6Ji3W3lvtzYAgKk4VkqcwZtYgmsGfjwd06lxaReXWcVBZPTr7ULiWECs/O/W4UaFitBUk94FIZJkTy2ICCpHF/OfzoRqMqOj3DGL1u6n9guJNOIn8qJOBm5Jph2OXx0UxWZL/ygZ6AtYv6KkY8sf3ndcAZVhiqNEB9U5RHaAEZencE9/hhEVQFFugfar4B6vjmRYiGUG41vBpT25h8UQLrd52YMGhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZS0cdd/wXp3B9+Lt+/gIPjoDsmeR2NyDeHv2Jv14i4=;
 b=TcxLwX9rQGXM5Nhxdb3R5wGQSDw6d+Z6uBhRx2jACs254sg412gGUhobk1ePgxwB7eVQLkvZdeMZ0Wfkdl5b0iym3lQnda+AaV8rFb+STAt0nMo1gIoWceVvd0mXyXcdt0KjhTOhCN3CzowN/JJnB4I1ijCu5ph9PVesp1nYs96y6uKwtEnBLrgsrZS9kYataqDSG430LO2ufftJYowKy54UfhPfBHTTrLHdJU7oOC48ayAQq7/4tsxKWCFu1UtVnNLgT0leMm3Z/HfULJrFWmc06BAFPutKMj+IYfAyDAVFR5tGUl8iwagy9h5DcjWHswo/4IbG/EJ6auz5+M5mOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZS0cdd/wXp3B9+Lt+/gIPjoDsmeR2NyDeHv2Jv14i4=;
 b=xxs2h+dR6plL+tsoXaVzX9/bkmH3ulrD/MRU6kYOnnlGaZP4+6LaTbZ0SHEq0pl7ZubkbELcIU6nOkCMU8pIssAKymy+t25q3zW8DsxYWSW+hZ/9o9C9P37t656Ha1hbY8CBTQHljncP7kXUi+kZGiXXJN55LsTniWnfLEukh9M=
Received: from BL1P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::27)
 by PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 12:19:43 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::b9) by BL1P222CA0022.outlook.office365.com
 (2603:10b6:208:2c7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 12:19:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 12:19:43 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 06:19:40 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 4/5] drm/amd/pm: Fetch fru product info for smu_v13_0_12
Date: Fri, 21 Feb 2025 20:19:18 +0800
Message-ID: <20250221121920.779576-4-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250221121920.779576-1-asad.kamal@amd.com>
References: <20250221121920.779576-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 59f2c173-c7b3-4b3d-7a04-08dd527205d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CB7kCmZur4z24Yl5TLuMMzAjkUTIs3yJeKKy0sELlumKDXldSMNOtoHQ+p74?=
 =?us-ascii?Q?Cs1c0QSoHlSq2ltq7xlnHP575kBt1lRwHQlpHcs+KGE9NnCWj6OI2aEXCwYz?=
 =?us-ascii?Q?zeSeXvfIqd+twNxpYjL5uILTuijymU5Un/u4noPAQEl4q0eRTOAFxVmPYZzv?=
 =?us-ascii?Q?TM6MAt/JYkMch0FCuTRmHyPJOmXMjoewAA9cHqLdOusl+GYHtX4EnGYV8+4z?=
 =?us-ascii?Q?JTNMlNgDy4eOzDZFG1yIjgAvA+KGjSRGGVQadqYoNQjdDktOi+qjPsX1B98P?=
 =?us-ascii?Q?Leew6v8Qj2nFyG66smxO3QnCxOPOpDLxgof3kcVXXBbebXo74sai7bISv/+B?=
 =?us-ascii?Q?hold5sgCldMfscMDyZuMHfTfJ9W36HsZfmbkz62DtRoKv1WYQt8vEySHaml1?=
 =?us-ascii?Q?9m2EOfAL8lbfz5CyD0ve4weuZoR+97kmRCqk8HDsehbVFOkmIoT2b3c40PgG?=
 =?us-ascii?Q?fTsBhjEGnK4pqN5RPKSz3TIP+AVFSvXl4gD6yOn4LSw+P8CCJ+p7LxKGG5hI?=
 =?us-ascii?Q?2AjVeTCxpnCSuO80tTJaSu5I4S64PS+c8PMe98L1im10FSAQ2bbk8BxQFZpU?=
 =?us-ascii?Q?MnwgwikXcxa2Lc9jkfir4aOSQe/galOZd+WPnwslZY8xITSm6wJZegqed88Y?=
 =?us-ascii?Q?+7nZb6PRMkspFbe6DX3PhVx+Myu43KRJhr6/vEJEYCXbVDvTGl7BMthmvLFw?=
 =?us-ascii?Q?MpaoWqUdo5iLnmrgX35GsQiFASNKYs+0VUumRlj684nrh3sKM6FQFQ7SUFIi?=
 =?us-ascii?Q?vbWSp0O8/VgziUdSGSz44wvVM1n4gGdL4N49QSKNu2WGd/f18mHGrIv8fqEV?=
 =?us-ascii?Q?4CIchY2atv0Z22xtBJvr6SopeADwpzMWKi32ANj7C2NhY5GRj1bfP6vYI8hm?=
 =?us-ascii?Q?nt3Q0ZbwZAqNI2uEoHNl3RF9rmvKsck1ne1qkVM0lP8eEpTUKfSiw9hRbLDx?=
 =?us-ascii?Q?sNZGWw2eJwl8ATdRD6W/KifzENKfLBC/ABZRrMFJnYXAJk4tKOTj/I0Gb26P?=
 =?us-ascii?Q?fDtXvAEKe0W4JDgrZqXYqak5W7batP7Kr7jo8LS/dQoKAFPSukQeZ7GXT3xb?=
 =?us-ascii?Q?AsztOLq9u2FVUjjYiLlCVKMejfMHZ6TrOcSr7XwHvdaYbOzFj7EK0080SgbR?=
 =?us-ascii?Q?0V+rY1TB6jrnKk25QZf2DDc7itLzHL8doM0gGH+4nRaJQM9xKxLki+wE3dtT?=
 =?us-ascii?Q?YahjIB4E06INe/CMmTPEyS5rUbPZvKcP9bP3keAy0Pcz931OHWegfO/f/BXJ?=
 =?us-ascii?Q?dub/qzObhyJI4tsbt1ybB1sBvktAgzC5dfiFAaLcJFqBSFU+8+nSZJOAzSGP?=
 =?us-ascii?Q?5FKLrilkiZyieX1V7eKhj1dCyUV4l5lp1YpNvJvpG01X8Bq0wP91X39458Lc?=
 =?us-ascii?Q?/fxnA1hshYwwslM00xKRQsqoLkfHlxxSHFVO/cYSB2RLwq0ioADZdcoLkImt?=
 =?us-ascii?Q?pG1o6AnG0H8oizovw5IteGeRzU1Ig8xQm51P08Gxy4Lbor/0y9s7hJWRrk6g?=
 =?us-ascii?Q?KWT/em/a1uNl37Q=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 12:19:43.3217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f2c173-c7b3-4b3d-7a04-08dd527205d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930
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

Fetch fru product info for smu_v13_0_12 from static metrics table

v2: Field by field copy for fru info(Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    |  9 ++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 31 +++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 89109eb2ce16..1ae88c459da5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -31,6 +31,7 @@
 
 #define FRU_EEPROM_MADDR_6      0x60000
 #define FRU_EEPROM_MADDR_8      0x80000
+#define FRU_EEPROM_MADDR_INV    0xFFFFF
 
 static bool is_fru_eeprom_supported(struct amdgpu_device *adev, u32 *fru_addr)
 {
@@ -104,6 +105,10 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev, u32 *fru_addr)
 			if (fru_addr)
 				*fru_addr = FRU_EEPROM_MADDR_8;
 			return true;
+	case IP_VERSION(13, 0, 12):
+			if (fru_addr)
+				*fru_addr = FRU_EEPROM_MADDR_INV;
+			return true;
 	default:
 		return false;
 	}
@@ -120,6 +125,10 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	if (!is_fru_eeprom_supported(adev, &fru_addr))
 		return 0;
 
+	/* FRU data avaialble, but no direct EEPROM access */
+	if (fru_addr == FRU_EEPROM_MADDR_INV)
+		return 0;
+
 	if (!adev->fru_info) {
 		adev->fru_info = kzalloc(sizeof(*adev->fru_info), GFP_KERNEL);
 		if (!adev->fru_info)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 1555fb954487..e153062adf77 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -31,6 +31,7 @@
 #include "smu_v13_0_12_ppsmc.h"
 #include "smu_v13_0.h"
 #include "amdgpu_xgmi.h"
+#include "amdgpu_fru_eeprom.h"
 #include <linux/pci.h>
 #include "smu_cmn.h"
 
@@ -145,6 +146,33 @@ static int smu_v13_0_12_get_enabled_mask(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v13_0_12_fru_get_product_info(struct smu_context *smu,
+					     StaticMetricsTable_t *static_metrics)
+{
+	struct amdgpu_fru_info *fru_info;
+	struct amdgpu_device *adev = smu->adev;
+
+	if (!adev->fru_info) {
+		adev->fru_info = kzalloc(sizeof(*adev->fru_info), GFP_KERNEL);
+		if (!adev->fru_info)
+			return -ENOMEM;
+	}
+
+	fru_info = adev->fru_info;
+	strscpy(fru_info->product_number, static_metrics->ProductInfo.ModelNumber,
+		sizeof(fru_info->product_number));
+	strscpy(fru_info->product_name, static_metrics->ProductInfo.Name,
+		sizeof(fru_info->product_name));
+	strscpy(fru_info->serial, static_metrics->ProductInfo.Serial,
+		sizeof(fru_info->serial));
+	strscpy(fru_info->manufacturer_name, static_metrics->ProductInfo.ManufacturerName,
+		sizeof(fru_info->manufacturer_name));
+	strscpy(fru_info->fru_id, static_metrics->ProductInfo.FruId,
+		sizeof(fru_info->fru_id));
+
+	return 0;
+}
+
 int smu_v13_0_12_get_max_metrics_size(void)
 {
 	return sizeof(StaticMetricsTable_t);
@@ -208,6 +236,9 @@ int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu)
 		/* use AID0 serial number by default */
 		pptable->PublicSerialNumber_AID =
 			static_metrics->PublicSerialNumber_AID[0];
+		ret = smu_v13_0_12_fru_get_product_info(smu, static_metrics);
+		if (ret)
+			return ret;
 
 		pptable->Init = true;
 	}
-- 
2.46.0

