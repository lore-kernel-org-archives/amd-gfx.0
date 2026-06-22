Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0ABACDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E01010E570;
	Mon, 22 Jun 2026 08:46:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OqPXAmKV";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012036.outbound.protection.outlook.com
 [40.107.200.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C5F710E570
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:46:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hS9jgbhvqzJXYZS6BOWuWqKFWuFDlRGtzUSSPcIvnoVnNFg0uBF8EG9goXunvlDfjDZgkQ3muhACsNWli4gLosZenfoop9t5Yk/3L8GeXfRgJoFbofnbSlFgFcR95mhGN9uPYvDgmeJPDoT0ag9Ad48zKtZYEhmvypRKDgLeh+cpZMHjEn9kidm//cUHDGZefB38d6cB+O3VVUrFqh7V3lEue5zo7gUBUzIiSog/R8ZjijXYHEY+u3h8rvQbDxaez0v8psOMeaQzU29yAxMzHxs6mP7OFGoBPaX6AxG08QvjglaXv7do9C/qbrUec8sYok115LANeUvVhnEI+H+pqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iYAhIMTuH78/KGM13jHCfTU9vpO5qYFBPRnqztZy2s=;
 b=Mkb0qXPTbXxTIvTr2RVbEyIAksE15UwNywoHKd5L2esH6ao5PEeODUpspGAkhMrryDSzHdfuEupZp0m5qAcqYU86zrP6PjC9VZd3aTNiS66jS5LzAeJVWEbkGobi/S73WSUh9EWoeOwAmZLYdorAbl7Z+E9LhGhBRxhca18+prV1htvx9cGthq696r+h6GFJfp23Ae1BqEuZTGuUf30Zo3bKDizgJvWT8t7n13tVPmelCApKUEP7qY18uAtkeZiJNruagc6cQM/eBgV2d351Aj5JEZMYKcE18asYZH74rfPqGW94ZpwQ+jb6vnEYdKzXU/MFrU1s07mlips2mVwO6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iYAhIMTuH78/KGM13jHCfTU9vpO5qYFBPRnqztZy2s=;
 b=OqPXAmKVflRZwYLDk36yQUK7alVUL5JzeFOOakwpzyGVbXnRMABaKd6XeIWx1b7iDkJSxOdw3XtLHddlrCdPn5vbLTyXgHmLblGOaejQ6Dv5o5rQF/kViwgfXmxy9ab8fHgKGp4katiKKy8zzvS3Q695JyXiXlxac42hhR9dMCs=
Received: from CY5PR16CA0004.namprd16.prod.outlook.com (2603:10b6:930:10::13)
 by LV8PR12MB9667.namprd12.prod.outlook.com (2603:10b6:408:297::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.21; Mon, 22 Jun
 2026 08:46:03 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:10:cafe::2c) by CY5PR16CA0004.outlook.office365.com
 (2603:10b6:930:10::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 08:46:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:46:02 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:46:00 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 27/48] drm/amdgpu: Remove the legacy bad page retirement
Date: Mon, 22 Jun 2026 16:44:29 +0800
Message-ID: <e2e5a04a70197dc7f53ca0db6a6bbc049298c87c.1782117608.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|LV8PR12MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ccc8a30-3481-4072-f44e-08ded03ab0f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: YS72BYOFba3LekeJRpEOqK/UDKfJYo6bAu29tuvxFz7RP/vgJPnXMNhDz0O6w/JKSspE5gvo34Jc4+/BQ33P6tOHSgMcpIIsn6emJhdsUUodfckXbApcE14N6AP++/EhrdNNF1oSb1SIzomxJHNNnOTCtYiSFDjam4pasZVhJEmLbms39tyXoHkotfjPgH1SULKjMBgy3iVodJB4YLHe67EwjI1uQ5QQVKOqNCE2byDYlBAlChCAosB83qtSGjJ6eTMKmuR94ARguh49R5YQKdoTZpwVkuslwEC4MVQCvNagIgYzXCWT/Fi5lziUlpmsPMxPYL1dq63Iymoux5RheaWeEPcP5/QHzJyz+C8tzMw3fqpxpWbo8Hb9/WzkjQ47sqlzS6Yih/+06WEx2HE2arUAx447w57dQ1ciiA9EfB73vzguLcoGdC8mIxsDL+fm4wrYF3nmGMssor28vKxy77WBX3ucJJDnKFIvjI0dHvG4UGpprSLOG3W3N71dFhOdF8aQ3oy3cZop3nWmRAz5noWOzK/V4iImQyjZIesXhzusUqZiR/UMu9CAXwi73oy5ihJXWzRuFymTYvP7a3TsLNCd740F+cjy3/755EGHgS4QyNJnmiZE56gGxv71ZfzdP7z7W33T9NxEjLHy3AbG3tq/W7e3s/4XO6kCtQK1yEvdpRwbtv1dmdMLuMF98t0ZCM0f8kqk4BHttx2+ELfdBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +x/+Etn/pnsW2g9tqLV71+qSU/9/orb2Dsaus6xaxR2J3ule/oOg/8fdDl3CjBLNICvA32pFUxz9LvAd0H0KGVKMZxgKSYIfwiOTvRRAO9xnDuZRKKU8meqwikl1vGNemUi98S2RKryXbyAx9LrG215MyDEQMOcLN2S6PsTOnVrr479nrPFx7s0ZPbCneTFVYncegkIhZXLzJJ0mNaexNziOc52oLt28elGRcNW5tFtGLQkhehEBVu/XfHnBwYvcfOd1RzCAi57QRy0Q0BkvRlWpKAtUeKJmzBV5Ljk3WRnlM7mnDrrXm+hpFE/rzAZR894iagQy9rYffMwWPF8kwTNtg8H5lKDxuuPDKWByruLi100A7HeWAvalnUpFzb1PZ9gmZ9hHze2ZlkVRrZbQPqU5ov/XVYPdPbR4aDI0c6b/tiaJP4kzeDPAtidjG1C0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:46:02.7895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ccc8a30-3481-4072-f44e-08ded03ab0f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9667
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

