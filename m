Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84271CDB471
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C93710E56B;
	Mon, 22 Jun 2026 08:46:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o9Sj8G3U";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C760F10E565
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:46:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIsKR7GDn5he+JEYRR3wL4ZSAIgwBTn/PKbDoMA7hqiSVANPZBFnycyIMM5ro9HzMrmsr8rBxh6tGqGFloTbym0+vaLPL0h04veDmyaPO6mxLM55JsOFuaqv467id5IcTcybyYqA/3q+ZCm7xdLh6JLCfERLRh3qB3yH2mIWvr7vdAzzlP9Pw9jU2/MsArL+TnxM9NKqRZkp/9D/tJ8jgx0AyZwAwu7gLiTwPLUVYSpuVrhgz2VNOR8OdcqAyVxY0+AbYM1nBZMHli8/odoaW1F9CAgCmgWJcT4XQkXQlfHA65+Q/orwugghXbMj/E2vaNTduKKbfb+KT4JrwUfueQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11qDiBHzRDmQt2dsL0v4dNCldRq6uJlWbgDYuTK3R7A=;
 b=OVylNJzQXDjFnB7v7d1jZDsd51F6E8xWhQdHemej/gYBQFD7e/BlElXixQuQ36Sp6XgFkgKUnmNpdl9A7pSG+kSwB8JlAfAry0ZE3Nwfjns6Mwss3XESVuTKOKjGVxPAGy6i3UNsNLyJ9aIsDo/TX2aeBnzyq+mzP9HAPXwpQsOyGflBkHMbArGTvhbUNdIwWoP3b2t7d7ZxDdrCpv99RfsDx4v+4VyVhur2kEjoQwujtA4JPjrT3ujeTRc1fnGnPMNgr7fEt+I0Jp+yTssKuHz7bJCTbw2bdZCYcvfD4aJd+qjp2ut4XTnMp+RubJ8BxpfaNRkzcAz1mKdAi4zy3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11qDiBHzRDmQt2dsL0v4dNCldRq6uJlWbgDYuTK3R7A=;
 b=o9Sj8G3U02FPn4NuLEXvJQg6XsxinDLIpfmMu1bagPCGEe2pc8cpPN7S2QLC6Km5H3+nW1CJARiFjY2HQ3a5sFrMax3J8OlxaeB5pZZfuzUIETr7w2sYEaNwdhLmBDleMxPWaZQUOuUhTNvmLujOL0kYYWrXX+1vMDYZWorrM3w=
Received: from CY5PR16CA0006.namprd16.prod.outlook.com (2603:10b6:930:10::35)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 08:46:01 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:10:cafe::5a) by CY5PR16CA0006.outlook.office365.com
 (2603:10b6:930:10::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 08:46:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:46:01 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:45:58 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 26/48] drm/amdgpu: remove interface for updating umc v12_0
 ecc
Date: Mon, 22 Jun 2026 16:44:28 +0800
Message-ID: <cccfe5f606d8e3ba286787f05556877bef338dd7.1782117608.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|BY5PR12MB4306:EE_
X-MS-Office365-Filtering-Correlation-Id: 3958fae7-3fc6-4c47-bce3-08ded03ab017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|3023799007|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: DEKZs7Vbr4MHfSF2U67E0T/Ux2CX5WL/VP4yTcvmEYUIq6+xvg02TGkfHj8QXAOTHv/p20omCgxiWbDhR07YkiVsevPRGXPWSpAXxZdOYNk53vajAMTemlRbkX4GU3s5qCcWTIpPP4K+H6qLfWPqp54hhvXRhGpajp7wEFocWf6aunsOu4NvaIYD0p9lYQGsCqKGVIwAjc/KcX+kn9FSeuJqWwXJpF09+ipwAhJZlxb7dtBpm6nAmsm+uF3WU7+Bdl7OgNkuy9tSTP5IhR9BYas1PdaJPpJPJSpjhnAftebl+u6vlH+415fFgsElEYCLc07+WnRXimLJbywVSjsLprdfknnqh215S0EwoogIgWWntSKrLkkdLJxmoK8mAcC2PYSr8iGoHNwgWIyQwC4kQXFdoX3e4x071OtNGsJaeb+4VPrjny9XYcZy7fcpK+6YZWn8iSE+I2EWOohUIDjDlumbGVyacLEHt0wkMnSW+oaYAQbU10ZqcF6b8B/vqMtW32GgdbDwSwo3LA8mENmWw+q/v+SadGd2ZjZH3VzazjHG3NtVIB2jx1aQtsI/yGCUWGdceOOMPjQpDopsHvSerdQoSn7VfluoFuUak6oRuvyc6cYQC046b1iGI1XoddtxAsQOuwUEYan1JIoegFwhtGjQZLqYOaibGRPDz5ReeViya3VAAnjYZ3wBOMF7iPu2ezM15bSiP409ubgv9JljoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UnktKC1ORdq/3Mz1TU+5oxu0VbR5AJ4Y4iHGkWIS5Cal2TROTrgYnp0LQAY3oWN+mDEC2EfCeqEA4mVY3cOPWHR5yxAaLfnkF6AxIOk4jKqB7bVygLErzEPVyZdNGGEtuZNdsi2SI/076htdm0GZB8xBeLnVWlip2UGwYIdacXOU+JP4pe3Lj5JVv2UIEVabpkz5aOAD3jys7Y3HMFTeNs1hILNQ7e6jJ1BHpn0wRwkQ1nzwdXDKeqFs+SpVvdfJ3yRkV/WJzfI7oQWiYhwtA64NfToJumTLMGpf1atHc2709TMafweSS/JflSlckYTIM0oVwoeshALtLlfpp8YWoglZ7aeRROaemUgi+uV2QJ4wjE5hyq8v3VzN1t8hQzCrShod3BIkd5BUgOGOwOaNtLYH43JGv+f8kdjSpoaaqJ2ue4YJcaYAb1OqzNGtu9Nu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:46:01.3586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3958fae7-3fc6-4c47-bce3-08ded03ab017
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
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

