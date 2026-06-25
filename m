Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232F1CDB47F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B378410F191;
	Thu, 25 Jun 2026 08:21:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="28tZL/7W";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0795910F188
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:21:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CznDbShPd8KFc/ctO39KDqiaUobrmc00flwctl6aoxYsET5YvCkD++WXCazR4GI4KuBOHKu7C9EAgjbjJKAIQvleNQzML1DIhKxHmRvVWGFMMeyRcR8QPpc29GmhHnSlbNaTdkX8fqPGZNQdbgUiHAV0biNrk/FRidh1o0cAmVy+Wbl4+i6C5PJnMZk5zWfQbFNzRDgNqXr90MWssvKqAVE617SpIS05JkZrY2F0Dw8rfZkZrVg7627zHFrn6wlPiGWOnIl7fBEz5+eya5HFtS8xbJVqROOH32LEr1cobCYUDDgsA2j4oh44Q/IT0KPhIkLa2uVS1QbNmPDFyrtPmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11qDiBHzRDmQt2dsL0v4dNCldRq6uJlWbgDYuTK3R7A=;
 b=mRbaUHrqia407oaISzfSmu3pHvRd2FH8WF00XgPbiN92gGojdPub+H6x3wbD2Jn0WoNxESnPKhaOAqffkGmSLyTGbMN06+sqj53NYbVxgEZErFIcKM5D+rsLxo7SCgeR0va+ejgXSetaNa4Ng95XUfOJM3clGdq9IdRjqF/NGaQjitDdc5Eym7J60N1UeMPQqcsEesirauhKxk0pxl0j06FH8t9iziC6ercEw6yAbgOE+vHI3a4XTyiakVAwWwstE0pgDU8Il0lp2O6CtcGhyJgK1MWuTE5LAOkaNnQ4bnh7brTTblqpI3kGCUvmnFF0BIIk0MVdXd8JzZOc3RTyyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11qDiBHzRDmQt2dsL0v4dNCldRq6uJlWbgDYuTK3R7A=;
 b=28tZL/7W8INW/ryxmlvrFP3R4zV+l0nyLCAYAeyPzYqIUS0PFk1C1pi+fZLlzS2FIhleM8ZzLKI0afsbkG9mbaz2CN9BZ2mpuAxlsz53EK2CSzYECBqxOjZ5G6eNBl8COCoklLL3KAJraEpYB44Zy2ke9UhFMGSO5hthCbsQxOk=
Received: from CYZPR14CA0001.namprd14.prod.outlook.com (2603:10b6:930:8f::11)
 by CH3PR12MB8753.namprd12.prod.outlook.com (2603:10b6:610:178::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Thu, 25 Jun
 2026 08:20:58 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:8f:cafe::66) by CYZPR14CA0001.outlook.office365.com
 (2603:10b6:930:8f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 08:20:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:20:58 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:20:55 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 24/44] drm/amdgpu: remove interface for updating umc v12_0
 ecc
Date: Thu, 25 Jun 2026 16:19:17 +0800
Message-ID: <94065f154364dcefdaaffc22f3f98eec0813f32f.1782373702.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|CH3PR12MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 38de9a52-fe0c-4158-8791-08ded292af55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|3023799007|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: KlnYAi1LvIN28usd8d/AOGinxvBp1+kbQ9KbHOBvjZR5l4UueST8dfvMyLCwr6RT9y1jcJViUPE9RGGBEo1pStONPcID2NvE3GaJUBklHo71iFtgGGWlBcYCAJmMHPoE8SHbrllzNtvumv3L2gwPRjEd92GvsoTQi59wJ/tjyw4mLYJgbgAu90nCO3SamXgf5An5jowEQ8fMkwE9WYxXX+3Fo32a0nKKoDv8WjIdX83PDxPPDVBCxfGUY8Zn0g0kwSxkhnW+UuMeLb5LMrnDimPPbHdgF4HpPdbsV0M3pcSOvokJy74/dG+lM14tbXNSr3vObjjZsXxmubiBGhsJ+VaAQONzFzMJzs7LE39s8f5gnspmYPYJwYuAovcsaJeG3TrsX1Ivo+9IN4kyLzm+uk9i/qlZWoEXstrTxDP9WJfUJd2ffjcvfM6SV/OAX/WDF7k83lVNsj+VJuow+f1dqz+fvlSoQz58LSPRd3pgEE2MFaz+KS9S75GwRuweZKbG6rdwK/OOPYr6/31Ap8WSJWl7S3T3cMq/tgTyyXsO1tZ4+4rmLjdvUmYjOPxnYVIQsBpZrc0oJTkqQx0bZgpwYYxAYZ+wHeG20XDulBgZjO9ymlQ1/0JzXj8zLVLxERDz6wjo5iKOexnOuyWkj0VaNjb3Q85Bz35sSka/4Z0p9eQFJiaRUUMxMQQJSAaxN/LjTJGsba1Afh6vEnOzn877Fw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ziDXg1Sw0M3Mnhwi7VcHlfatJ2VgjfZjlatw73Y19t7tBGSEo3F3ku67F0CBfL/Mm5FPji7l4+v9uBLeWh/lgokVdaIzDceV8sJYmoftl1WBmpyQpvzm1cTgjyNgbHVG1WA8msX73J9KmHbLskhaKk0FMQTeIZ4KPBcfcgKdtQ+mPEfahpY/4fGZts28maWfztcQR5l3zjmPohmReGA/5qYDHZ4vJX6Lvp8YdFfgJb9h/qJF7jdtMY4rQqD1xvgagxCa4z9slwwMrAyapr4weiBvVIJr7DMrOVHCkRtgRUSQ/UM1choJhFd1Vx1OEyYHkg+jfSCH34OQ6ZByicdir/PeZASG3IVEcnbSWU1mvGBib/B7T1jBUSo7vZG0uk0uUSTYxaLX0izGcoPbJxiYo4ltA9R+6Tnd5HOjruMxPUL2Jjmv+gnLbwlHDs4y+HbV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:20:58.0991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38de9a52-fe0c-4158-8791-08ded292af55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8753
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

Retire the interface to update umc v12_0 ecc status and
its related code,since this interface is no longer needed.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 32 ---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 55 ---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h | 11 ---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 92 -------------------------
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h  |  3 -
 6 files changed, 195 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index fa0f0df2d32c..1fe4f191c76f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3410,35 +3410,6 @@ static void amdgpu_ras_validate_threshold(struct amdgpu_device *adev,
 	}
 }
 
-static void amdgpu_ras_ecc_log_init(struct ras_ecc_log_info *ecc_log)
-{
-	mutex_init(&ecc_log->lock);
-
-	INIT_RADIX_TREE(&ecc_log->de_page_tree, GFP_KERNEL);
-	ecc_log->de_queried_count = 0;
-	ecc_log->consumption_q_count = 0;
-}
-
-static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log)
-{
-	struct radix_tree_iter iter;
-	void __rcu **slot;
-	struct ras_ecc_err *ecc_err;
-
-	mutex_lock(&ecc_log->lock);
-	radix_tree_for_each_slot(slot, &ecc_log->de_page_tree, &iter, 0) {
-		ecc_err = radix_tree_deref_slot(slot);
-		kfree(ecc_err->err_pages.pfn);
-		kfree(ecc_err);
-		radix_tree_iter_delete(&ecc_log->de_page_tree, &iter, slot);
-	}
-	mutex_unlock(&ecc_log->lock);
-
-	mutex_destroy(&ecc_log->lock);
-	ecc_log->de_queried_count = 0;
-	ecc_log->consumption_q_count = 0;
-}
-
 int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
@@ -3535,7 +3506,6 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev, bool init_bp_info)
 	mutex_init(&con->page_rsv_lock);
 	mutex_init(&con->page_retirement_lock);
 
-	amdgpu_ras_ecc_log_init(&con->umc_ecc_log);
 #ifdef CONFIG_X86_MCE_AMD
 	if ((adev->asic_type == CHIP_ALDEBARAN) &&
 	    (adev->gmc.xgmi.connected_to_cpu))
@@ -3575,8 +3545,6 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_device *adev)
 
 	cancel_work_sync(&con->recovery_work);
 
-	amdgpu_ras_ecc_log_fini(&con->umc_ecc_log);
-
 	mutex_lock(&con->recovery_lock);
 	con->eh_data = NULL;
 	kfree(data->bps);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index fe167c8396f6..2608a248dbc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -483,8 +483,6 @@ struct ras_ecc_err {
 struct ras_ecc_log_info {
 	struct mutex lock;
 	struct radix_tree_root de_page_tree;
-	uint64_t de_queried_count;
-	uint64_t consumption_q_count;
 };
 
 struct ras_critical_region {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index f22d07e9c29c..0a4a8394489a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -502,34 +502,6 @@ int amdgpu_umc_loop_channels(struct amdgpu_device *adev,
 	return 0;
 }
 
-int amdgpu_umc_update_ecc_status(struct amdgpu_device *adev,
-				uint64_t status, uint64_t ipid, uint64_t addr)
-{
-	if (adev->umc.ras->update_ecc_status)
-		return adev->umc.ras->update_ecc_status(adev,
-					status, ipid, addr);
-	return 0;
-}
-
-int amdgpu_umc_logs_ecc_err(struct amdgpu_device *adev,
-		struct radix_tree_root *ecc_tree, struct ras_ecc_err *ecc_err)
-{
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	struct ras_ecc_log_info *ecc_log;
-	int ret;
-
-	ecc_log = &con->umc_ecc_log;
-
-	mutex_lock(&ecc_log->lock);
-	ret = radix_tree_insert(ecc_tree, ecc_err->pa_pfn, ecc_err);
-	if (!ret)
-		radix_tree_tag_set(ecc_tree,
-			ecc_err->pa_pfn, UMC_ECC_NEW_DETECTED_TAG);
-	mutex_unlock(&ecc_log->lock);
-
-	return ret;
-}
-
 int amdgpu_umc_pages_in_a_row(struct amdgpu_device *adev,
 			struct ras_err_data *err_data, uint64_t pa_addr)
 {
@@ -578,33 +550,6 @@ int amdgpu_umc_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 	return ret;
 }
 
-int amdgpu_umc_mca_to_addr(struct amdgpu_device *adev,
-			uint64_t err_addr, uint32_t ch, uint32_t umc,
-			uint32_t node, uint32_t socket,
-			struct ta_ras_query_address_output *addr_out, bool dump_addr)
-{
-	struct ta_ras_query_address_input addr_in;
-	int ret;
-
-	memset(&addr_in, 0, sizeof(addr_in));
-	addr_in.ma.err_addr = err_addr;
-	addr_in.ma.ch_inst = ch;
-	addr_in.ma.umc_inst = umc;
-	addr_in.ma.node_inst = node;
-	addr_in.ma.socket_id = socket;
-
-	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr) {
-		ret = adev->umc.ras->convert_ras_err_addr(adev, NULL, &addr_in,
-				addr_out, dump_addr);
-		if (ret)
-			return ret;
-	} else {
-		return 0;
-	}
-
-	return 0;
-}
-
 int amdgpu_umc_pa2mca(struct amdgpu_device *adev,
 		uint64_t pa, uint64_t *mca, enum amdgpu_memory_partition nps)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 8494a55ebf76..f65f3e082c64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -103,8 +103,6 @@ struct amdgpu_umc_ras {
 					void *ras_error_status);
 	bool (*check_ecc_err_status)(struct amdgpu_device *adev,
 			enum amdgpu_mca_error_type type, void *ras_error_status);
-	int (*update_ecc_status)(struct amdgpu_device *adev,
-			uint64_t status, uint64_t ipid, uint64_t addr);
 	int (*convert_ras_err_addr)(struct amdgpu_device *adev,
 			struct ras_err_data *err_data,
 			struct ta_ras_query_address_input *addr_in,
@@ -179,21 +177,12 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
 int amdgpu_umc_loop_channels(struct amdgpu_device *adev,
 			umc_func func, void *data);
 
-int amdgpu_umc_update_ecc_status(struct amdgpu_device *adev,
-				uint64_t status, uint64_t ipid, uint64_t addr);
-int amdgpu_umc_logs_ecc_err(struct amdgpu_device *adev,
-		struct radix_tree_root *ecc_tree, struct ras_ecc_err *ecc_err);
-
 void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 			void *ras_error_status);
 int amdgpu_umc_pages_in_a_row(struct amdgpu_device *adev,
 			struct ras_err_data *err_data, uint64_t pa_addr);
 int amdgpu_umc_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 			uint64_t pa_addr, uint64_t *pfns, int len);
-int amdgpu_umc_mca_to_addr(struct amdgpu_device *adev,
-			uint64_t err_addr, uint32_t ch, uint32_t umc,
-			uint32_t node, uint32_t socket,
-			struct ta_ras_query_address_output *addr_out, bool dump_addr);
 int amdgpu_umc_pa2mca(struct amdgpu_device *adev,
 		uint64_t pa, uint64_t *mca, enum amdgpu_memory_partition nps);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index b74275800795..ebceb933481e 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -29,7 +29,6 @@
 #include "mp/mp_13_0_6_sh_mask.h"
 
 #define MAX_ECC_NUM_PER_RETIREMENT  32
-#define DELAYED_TIME_FOR_GPU_RESET  1000  //ms
 
 bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t mc_umc_status)
 {
@@ -292,96 +291,6 @@ static bool umc_v12_0_check_ecc_err_status(struct amdgpu_device *adev,
 	return false;
 }
 
-static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
-			uint64_t status, uint64_t ipid, uint64_t addr)
-{
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	uint16_t hwid, mcatype;
-	uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
-	uint64_t err_addr, pa_addr = 0;
-	struct ras_ecc_err *ecc_err;
-	struct ta_ras_query_address_output addr_out;
-	uint32_t shift_bit = adev->umc.flip_bits.flip_bits_in_pa[2];
-	int count, ret, i;
-
-	hwid = REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
-	mcatype = REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType);
-
-	/* The IP block decode of consumption is SMU */
-	if (hwid != MCA_UMC_HWID_V12_0 || mcatype != MCA_UMC_MCATYPE_V12_0) {
-		con->umc_ecc_log.consumption_q_count++;
-		return 0;
-	}
-
-	if (!status)
-		return 0;
-
-	if (!umc_v12_0_is_deferred_error(adev, status))
-		return 0;
-
-	err_addr = REG_GET_FIELD(addr,
-				MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
-
-	dev_dbg(adev->dev,
-		"UMC:IPID:0x%llx, socket:%llu, aid:%llu, inst:%llu, ch:%llu, err_addr:0x%llx\n",
-		ipid,
-		MCA_IPID_2_SOCKET_ID(ipid),
-		MCA_IPID_2_DIE_ID(ipid),
-		MCA_IPID_2_UMC_INST(ipid),
-		MCA_IPID_2_UMC_CH(ipid),
-		err_addr);
-
-	ret = amdgpu_umc_mca_to_addr(adev,
-			err_addr, MCA_IPID_2_UMC_CH(ipid),
-			MCA_IPID_2_UMC_INST(ipid), MCA_IPID_2_DIE_ID(ipid),
-			MCA_IPID_2_SOCKET_ID(ipid), &addr_out, true);
-	if (ret)
-		return ret;
-
-	ecc_err = kzalloc(sizeof(*ecc_err), GFP_KERNEL);
-	if (!ecc_err)
-		return -ENOMEM;
-
-	pa_addr = addr_out.pa.pa;
-	ecc_err->status = status;
-	ecc_err->ipid = ipid;
-	ecc_err->addr = addr;
-	ecc_err->pa_pfn = pa_addr >> AMDGPU_GPU_PAGE_SHIFT;
-	ecc_err->channel_idx = addr_out.pa.channel_idx;
-
-	/* If converted pa_pfn is 0, use pa C4 pfn. */
-	if (!ecc_err->pa_pfn)
-		ecc_err->pa_pfn = BIT_ULL(shift_bit) >> AMDGPU_GPU_PAGE_SHIFT;
-
-	ret = amdgpu_umc_logs_ecc_err(adev, &con->umc_ecc_log.de_page_tree, ecc_err);
-	if (ret) {
-		if (ret == -EEXIST)
-			con->umc_ecc_log.de_queried_count++;
-		else
-			dev_err(adev->dev, "Fail to log ecc error! ret:%d\n", ret);
-
-		kfree(ecc_err);
-		return ret;
-	}
-
-	con->umc_ecc_log.de_queried_count++;
-
-	memset(page_pfn, 0, sizeof(page_pfn));
-	count = amdgpu_umc_lookup_bad_pages_in_a_row(adev,
-				pa_addr,
-				page_pfn, ARRAY_SIZE(page_pfn));
-	if (count <= 0) {
-		dev_warn(adev->dev, "Fail to convert error address! count:%d\n", count);
-		return 0;
-	}
-
-	/* Reserve memory */
-	for (i = 0; i < count; i++)
-		amdgpu_ras_reserve_page(adev, page_pfn[i]);
-
-	return 0;
-}
-
 static int umc_v12_0_fill_error_record(struct amdgpu_device *adev,
 				struct ras_ecc_err *ecc_err, void *ras_error_status)
 {
@@ -484,7 +393,6 @@ struct amdgpu_umc_ras umc_v12_0_ras = {
 	},
 	.ecc_info_query_ras_error_address = umc_v12_0_query_ras_ecc_err_addr,
 	.check_ecc_err_status = umc_v12_0_check_ecc_err_status,
-	.update_ecc_status = umc_v12_0_update_ecc_status,
 	.convert_ras_err_addr = umc_v12_0_convert_error_address,
 	.get_die_id_from_pa = umc_v12_0_get_die_id,
 	.get_retire_flip_bits = umc_v12_0_get_retire_flip_bits,
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
index d470775be308..9d9e84d8d3bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -50,9 +50,6 @@
 /* row bits in MCA address */
 #define UMC_V12_0_MA_R0_BIT 10
 
-#define MCA_UMC_HWID_V12_0     0x96
-#define MCA_UMC_MCATYPE_V12_0  0x0
-
 #define MCA_IPID_LO_2_UMC_CH(_ipid_lo) (((((_ipid_lo) >> 20) & 0x1) * 4) + \
 			(((_ipid_lo) >> 12) & 0xF))
 #define MCA_IPID_LO_2_UMC_INST(_ipid_lo) (((_ipid_lo) >> 21) & 0x7)
-- 
2.34.1

