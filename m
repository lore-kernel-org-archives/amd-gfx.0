Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693CFCDB466
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBFA110F18E;
	Thu, 25 Jun 2026 08:21:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dv/BfVHp";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010043.outbound.protection.outlook.com
 [52.101.193.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F76A10F188
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:21:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Okggl64FFiz1nnHBhvlL3GB5n7KceMEPrzlIUXX4ZdjWUU8zINouYSVxpDxDSJ6hjUlPFaVFmyGfwGEEOsxkp/aIlqQfx8dMGX1pIaJItTLLI+NnVqlpNJb2JzKl/4YKje/ysBHB7bdtDcgggTFVsikm92ih+B25pDukeysrBNp/p8M6SA3UJMM86cbf/AjuCf1jgQOoTpkPFxDdfZKPMZ4N3EPOW2dG20KNG9JNk8azXCoIzCKQEA9SaMz6UwvcNkO3ArxvF7L8vRqBJ+ndCqkEqsyDNkEmnTWC4Fgi45rSkf+mgQHAxOk5smL7ZEm3EmpTLYaM/KjJ1VIPqbQleg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iYAhIMTuH78/KGM13jHCfTU9vpO5qYFBPRnqztZy2s=;
 b=grCGnpLjg5nmqImwE/XoCIvUgSpwdAAF3eh6JsEMZ/ELug5oG9xtsbmU5qysSiPJUciwtag51WIf8vwTZctlm+P/LjvSffSAoV2hTKWB1wGdMvq7c6cW8KZCypUhv2rDHfryuD9lVE6aMACh+shZeqT5+ah1gjyyEEa8T3CBBoQiuNKDjuoHFa2m4EWREkFbYkfOg5oj4ZzOz9GaDtlf9aFDBQTGcg1pcx6KXgNy685MlJBB4NTpRL0qJ/+PBllh7/OTrR0wjucbSA//AgNTWbFXyDjdHL5Gw7T2AM0/W9izS4tZ05skAGg3qku2PKf26t4Ph6TRsgkdhe1Hyo0jWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iYAhIMTuH78/KGM13jHCfTU9vpO5qYFBPRnqztZy2s=;
 b=dv/BfVHpHruUi9r8pltCyqgvUuyd5e2HN1RBdpZQw30OV6OS7KiHTPVrcpyLmu/9TTe5uaw/tn3/1lWnLx9tckXfqjf9Z3iMrxkJrbuZnBuAxwprH0vNMXPcqXZmRbBdD2+cc7+9468ck2nlZjq5VTCdvROFQ6qQMg8KMpCLugI=
Received: from PH7P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::16)
 by PH7PR12MB6665.namprd12.prod.outlook.com (2603:10b6:510:1a7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 08:21:00 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:510:326:cafe::92) by PH7P220CA0004.outlook.office365.com
 (2603:10b6:510:326::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Thu,
 25 Jun 2026 08:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:21:00 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:20:57 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 25/44] drm/amdgpu: Remove the legacy bad page retirement
Date: Thu, 25 Jun 2026 16:19:18 +0800
Message-ID: <ba65f3564cbf90bcafacd43aa0a4a765cadf2f7e.1782373702.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|PH7PR12MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: 04636621-b6b8-4425-0fa6-08ded292b080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: Ju+282oSnEz1GmgiaQZ83etJBCqLg+rszfV5QrlfAWgPasteVQJBmKGusqQbKEBU2P9/BQINZw1Ls6+O9Md8qh6sDKMtOj4pRFhMOTnuJL+xBbLO5KFsoX06+HH+mXspCE15hzRU77rVRX/jOJVX3yeAq6Tzsia0+4ZQ8D6Q+NZyC66vqhX4EPB7G+SyAakwvstDB2rI8s+nRmzGI+PEBDuhPJWu1E04ql1YLeEButYKqPzREkZ+nBQvLq98sfKswfsM2Mrl+nizQfTIzJiJfRw0dwR1eTvIu8E8Bu2WDH6hGc0NYpZsmHoJXR5RHobyH/+9ww1XKf5YK1D5acG3PJ6wqaB2lct8d3phFcwrMmNOAzsSLsTq/smhsY0vhVWaPyN8N5rhQQrqSsji6B21A4X3JSrfoXDvCj31MJ1BPXWbvlKEFoPof9hEyz6GWCjBhF0h9PM90BH0Qd/bbXJz/jZCMGpm6dFTIGGCOsNmygTTpyDjyvI5ANTl89WCIh23KIPE4Cd6Qew3aBD2IzbXf2w9eAouDhHUZOU0AV9SPuKoP/pU7UTCDHmupwQornAjdIMuEt0M9jAOZAbUHKmrWlyiFDM1j6WgA9JdiDYZyv350ratPecp9r8U6rMo9TlPqm16syuvk/nJUBl13sK6LNlFD//G2wC82wnGLeZs+v2/FOi/uOUDsLOOXfAUouZDLx4mKSnvsY0FK7iD3X5P7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c/woV8dWc51MplT7W8J8s5oaq7Ns8hgyE2UhShRSfew2nhrHtvuiDThfp4us/ACm02mElQvlYpQsq0wqTs4g9IUUam7toAgBLjrJlt/9UwZamqD3+LjMWMuTAyo3vcdpDfrxMo/ThJRqMbyZxpFMajeEZIROgc6Lo1lwcvaHbbdSH/bTYfHJBvGZaZfWeZ/74M7ZS4XGzMgLhMDpFGsh7VSwGxse8GOQX7Yf+TFJbP0GDOywKjYcHvZQZ4h6GrTbQnPZKETqgCSUgNRrtyll40BbHODuEAg+vZGDzMbys+U2OMDaiWznXnAeyRRBIA4N5ORqNW9EWghz0C49YbU7W+kzM58xW5oVR1XkXlO95pjPVZF/dDrV6zFN2SLbCZMcW21DG/Vg01tqS1r9drq7NIZn0KfE6BZ8MNB8UdZeqQco7Nb6EXPtHuBHJug1ZNjZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:21:00.1021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04636621-b6b8-4425-0fa6-08ded292b080
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6665
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

