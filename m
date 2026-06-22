Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAE9CD98F6
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FF6110E47B;
	Mon, 22 Jun 2026 04:43:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RWmg5CRn";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C98C10E47C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:42:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RyubqcU0OCrPUl2sXgPYdeqD/xZSMX/PCJpfYiCZ1T3HjKrFqVidrEj0PvQNB3qskUmLQOFxCe5J8O4zrWiYGTUe4OCto0riIkPnAXjpBCvCXYUsXjny1xrzkxYogWJk2cPF9rOxgO7RvT0TaLQ4M2eEIVxz/RdIxhnlAzghXE0VGHw5nI5C5qtj/7/StfWUhPwSxeu5HJKDtALBpj9/BY7NcfXzUPK7sUFhG5f/oaTlRUXBI6JwftuTL3GLaxmAXgC/Koto991V8HPyLFCYVd2PAszL3qSsIVki/hl3A8VzUQurx61/UlAoD0O40b/7UuEt8YZEyAWSkYDtlTg+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iYAhIMTuH78/KGM13jHCfTU9vpO5qYFBPRnqztZy2s=;
 b=NPx2jOL5aWFxfHtO6tzexh2+Ug0CmFeDjhSSeskiT5Cuv0s5jAX5zv/bGxTqTk1lNkXfhmc72BR224phzsECoXPj8fyOL8j74Il2hfdfsfa7pBuxzGD2weLrBf6J/VEY4dT/7znVVkHlsRh97Tl1M1b2BeZtWfYvEouY19I6pc+EHkJiyPDEIy6XQoYu1wbylMFWBWJ4N9fN7PotD57luc2LjiCrVa9ilF+/IAad5FQ9QKG95DRmCTiu/6OJavi3wLJq/N19wCcL1mtDa+WbSwoADawny7dAg2JwlfdTtFwnnGQ/gVVe2CzSZsgWIdcFAcMKWzk1OWRwn42mt8c41g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iYAhIMTuH78/KGM13jHCfTU9vpO5qYFBPRnqztZy2s=;
 b=RWmg5CRnwtyyUDrFjpkyT6inAjJpK6SoY/gfGmX6OCz0DM43BaUiGKZUXnR8ft6OUFMJ52nell4O8A+JFvSAtFJTVOAcEgxiuhj88yGO/COnZo1FbtrWPW6TpGDUfcTab2D+fQSIsg6NPkJ5bzqLxEWbaCdNvjCN8fOu/t5g2KI=
Received: from MN2PR08CA0001.namprd08.prod.outlook.com (2603:10b6:208:239::6)
 by DS0PR12MB6414.namprd12.prod.outlook.com (2603:10b6:8:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 22 Jun
 2026 04:42:53 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::6) by MN2PR08CA0001.outlook.office365.com
 (2603:10b6:208:239::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 04:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:42:53 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:42:51 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 27/48] drm/amdgpu: Remove the legacy bad page retirement
Date: Mon, 22 Jun 2026 12:40:16 +0800
Message-ID: <6d525ae57b3d7c8653658270446ee04a5a35af20.1782103074.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782103073.git.cesun102@amd.com>
References: <cover.1782103073.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|DS0PR12MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 8590fb74-9a17-4135-d11d-08ded018b8f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2HhHdkEnkhvbW05G3ODed6yGgk6YjlTaN3whGhf7eYZkT6uXDzp1LU/1McEE3FP460cGQ0dxYsT0iFSHUzhw+Q4cUolYm6sz1ek8EOz/Z7X4nZbl72usbIFR4uOtgBaQ6GLyOEDWAPF5rPuxE/exY5/mKS8EvOet2Wk3fdHWXVTcRJr8r/5F1ov0OKK1NkqcyWcGP5SxFDB9Eu6KOYU13Nc6Tz0vZcIaLDgku0L5YJAdhTWDVl+aip1W6NqDV6p/GZCaGy70BtvvlBvcn7fOfBfS+i9e2ovgkxB95QVfmWfm2XuTcL898X6813OWkjK7dA60H+iHOd87AqBiQDmKodI6FaXyH/jHIeuG0f3DTECnrJM0iUvUnfNImzzTfOB/lDXJX8aajsNsUtl4fmcuxxd+9z3+qQr0ZQVdhRJnkjXNTj0clw6SD4sb4yQqPHYP0gTbmZ2U077IQd6OLdBVKqUSdWobsEDY/hbiRVbjFWVaONSFTnGC9QWmH82xmPdr3WmHdHyJFLSf8Y82ZawP7QRt8eMELKRIhJp0TYsdWnsoxU6DaqkmFVsSI2cLesGEL9whryD4OBLyxjc9WIlFf59Tdq9ExiOfeGFLhKIJymXoCAXxR4uZ2AuvyLB7EmGml05pl7zVj1qFm4ZeJPvC47YQ3oOqKJ2qOcpSk+eJEnNry0T/tLa0+fgiX/8otVmOocpQv07SZx87geWS+P+qkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1PQS2N03wGW+noReonHaNg1KykqH/mkdDCpOsXsO+E+A0HlnnS8xMEzm0e7xe22LM2MxY3sIDZx+OHRCLcw1b2LPx7vJIFQdZheT1o/JATTTq0gN8578EA8heQ+MFld7MY6Q7sLNcQAyyjpFtsD+jU5aOSm78bImzMSPEh8Tl+eJvi8EKpKZ/q65Urh3DRZSWoSqyaGhHDg4cJuGS92qUdXvYBc6BLkDRmFdMWA+X6rWHzPcZvGo08SLPUT+iorwW5wEwkSyXDY29hVhCVF4/GOrg5xxCuu0GvU4JBVXxm23tQ/RH6tWgy2iqucFh9Tfaed/UxDdf3Xh1wCUInGGnek5j228D5jF2zZAPpWbbtMHHfeOGOrBBCv+uWvXeTAR00jaeYUMqJByN83n51BfKaAQga6dikOfykbUpFD00wAs0YHDoa3eZv1A4e+CiQb0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:42:53.3485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8590fb74-9a17-4135-d11d-08ded018b8f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6414
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

Remove the legacy bad page retirement handling for UMC v12_0

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 16 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 31 -------------
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 61 -------------------------
 3 files changed, 6 insertions(+), 102 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1fe4f191c76f..e7156b85e727 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -243,16 +243,12 @@ static int amdgpu_check_address_validity(struct amdgpu_device *adev,
 	    (address >= RAS_UMC_INJECT_ADDR_LIMIT))
 		return -EFAULT;
 
-	if (amdgpu_uniras_enabled(adev)) {
-		if (amdgpu_sriov_vf(adev))
-			count = amdgpu_virt_ras_convert_retired_address(adev, address,
-				page_pfns, ARRAY_SIZE(page_pfns));
-		else
-			count = amdgpu_ras_mgr_lookup_bad_pages_in_a_row(adev, address,
-				page_pfns, ARRAY_SIZE(page_pfns));
-	} else
-		count = amdgpu_umc_lookup_bad_pages_in_a_row(adev,
-				address, page_pfns, ARRAY_SIZE(page_pfns));
+	if (amdgpu_sriov_vf(adev))
+		count = amdgpu_virt_ras_convert_retired_address(adev, address,
+			page_pfns, ARRAY_SIZE(page_pfns));
+	else
+		count = amdgpu_ras_mgr_lookup_bad_pages_in_a_row(adev, address,
+			page_pfns, ARRAY_SIZE(page_pfns));
 
 	if (count <= 0)
 		return -EPERM;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 0a4a8394489a..516ae7a5cfeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -519,37 +519,6 @@ int amdgpu_umc_pages_in_a_row(struct amdgpu_device *adev,
 		return -EINVAL;
 }
 
-int amdgpu_umc_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
-			uint64_t pa_addr, uint64_t *pfns, int len)
-{
-	int i, ret;
-	struct ras_err_data err_data;
-
-	err_data.err_addr = kcalloc(adev->umc.retire_unit,
-				sizeof(struct eeprom_table_record), GFP_KERNEL);
-	if (!err_data.err_addr) {
-		dev_warn(adev->dev, "Failed to alloc memory in bad page lookup!\n");
-		return 0;
-	}
-
-	ret = amdgpu_umc_pages_in_a_row(adev, &err_data, pa_addr);
-	if (ret)
-		goto out;
-
-	for (i = 0; i < adev->umc.retire_unit; i++) {
-		if (i >= len)
-			goto out;
-
-		pfns[i] = err_data.err_addr[i].retired_page;
-	}
-	ret = i;
-	adev->umc.err_addr_cnt = err_data.err_addr_cnt;
-
-out:
-	kfree(err_data.err_addr);
-	return ret;
-}
-
 int amdgpu_umc_pa2mca(struct amdgpu_device *adev,
 		uint64_t pa, uint64_t *mca, enum amdgpu_memory_partition nps)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index ebceb933481e..e1d900818a81 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -28,8 +28,6 @@
 #include "umc/umc_12_0_0_sh_mask.h"
 #include "mp/mp_13_0_6_sh_mask.h"
 
-#define MAX_ECC_NUM_PER_RETIREMENT  32
-
 bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t mc_umc_status)
 {
 	dev_dbg(adev->dev,
@@ -291,64 +289,6 @@ static bool umc_v12_0_check_ecc_err_status(struct amdgpu_device *adev,
 	return false;
 }
 
-static int umc_v12_0_fill_error_record(struct amdgpu_device *adev,
-				struct ras_ecc_err *ecc_err, void *ras_error_status)
-{
-	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
-	uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
-	int ret, i, count;
-
-	if (!err_data || !ecc_err)
-		return -EINVAL;
-
-	memset(page_pfn, 0, sizeof(page_pfn));
-	count = amdgpu_umc_lookup_bad_pages_in_a_row(adev,
-				ecc_err->pa_pfn << AMDGPU_GPU_PAGE_SHIFT,
-				page_pfn, ARRAY_SIZE(page_pfn));
-
-	for (i = 0; i < count; i++) {
-		ret = amdgpu_umc_fill_error_record(err_data,
-				ecc_err->addr,
-				page_pfn[i] << AMDGPU_GPU_PAGE_SHIFT,
-				ecc_err->channel_idx,
-				MCA_IPID_2_UMC_INST(ecc_err->ipid));
-		if (ret)
-			break;
-	}
-
-	err_data->de_count++;
-
-	return ret;
-}
-
-static void umc_v12_0_query_ras_ecc_err_addr(struct amdgpu_device *adev,
-					void *ras_error_status)
-{
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	struct ras_ecc_err *entries[MAX_ECC_NUM_PER_RETIREMENT];
-	struct radix_tree_root *ecc_tree;
-	int new_detected, ret, i;
-
-	ecc_tree = &con->umc_ecc_log.de_page_tree;
-
-	mutex_lock(&con->umc_ecc_log.lock);
-	new_detected = radix_tree_gang_lookup_tag(ecc_tree, (void **)entries,
-			0, ARRAY_SIZE(entries), UMC_ECC_NEW_DETECTED_TAG);
-	for (i = 0; i < new_detected; i++) {
-		if (!entries[i])
-			continue;
-
-		ret = umc_v12_0_fill_error_record(adev, entries[i], ras_error_status);
-		if (ret) {
-			dev_err(adev->dev, "Fail to fill umc error record, ret:%d\n", ret);
-			break;
-		}
-		radix_tree_tag_clear(ecc_tree,
-				entries[i]->pa_pfn, UMC_ECC_NEW_DETECTED_TAG);
-	}
-	mutex_unlock(&con->umc_ecc_log.lock);
-}
-
 static uint32_t umc_v12_0_get_die_id(struct amdgpu_device *adev,
 		uint64_t mca_addr, uint64_t retired_page)
 {
@@ -391,7 +331,6 @@ struct amdgpu_umc_ras umc_v12_0_ras = {
 	.ras_block = {
 		.hw_ops = NULL,
 	},
-	.ecc_info_query_ras_error_address = umc_v12_0_query_ras_ecc_err_addr,
 	.check_ecc_err_status = umc_v12_0_check_ecc_err_status,
 	.convert_ras_err_addr = umc_v12_0_convert_error_address,
 	.get_die_id_from_pa = umc_v12_0_get_die_id,
-- 
2.34.1

