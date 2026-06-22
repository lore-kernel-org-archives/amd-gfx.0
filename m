Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3238ECDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C96F110E47A;
	Mon, 22 Jun 2026 04:42:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="COwjzxC1";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB11610E47C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:42:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbf04lFPBcLm9SB0diL5v4PmgZO4OgIeUPa0fi2by2/8273kxIo9R/zBoRHwRplxrh85LxgGHcvevv5/zdV7Bi1rlTkL25sU6GUYPGc5pkp0WxSfjpEtX3ZQNu/BeDdGmkb0vT3gCzGnvdiHy7AU5G9RodVUl4CR5s1cEjEw1IUjwZge2Y36sOxwIAd9hEERKJMm7mzJu3fVzeGWb5AGYs8sO4O67ek1k3dpBJ37bn7UqSkWUDm4gxrWVnP1VM9ALPMDvdxwLYuXYJZv8AumszfGdeFqGoVD72ghFFkXCojycH2J8kSzrrZ0jmCTgqMzh839H4a/4G2fiufzE4+VbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11qDiBHzRDmQt2dsL0v4dNCldRq6uJlWbgDYuTK3R7A=;
 b=OjaDoWQlp7mX63UfjDytfvGH6EXEyHgZeKOZF/F4ho0B2IXN+V2LuIAWxwh8Yl/iESnXmq/heAGwyoh7to2nNcHzQVMhNpxWTNXCbK/jKUjW+WE2v0sgykMLtCHaEPfKdD8Ac+gYl8DdkuLo3sKq2EtNjWE0QUBNICmRBhgkLip5eZ873jr9lMpP7UNwkQzM8N+EY4jl/DAlSyaPLTCmPgYj5DtvcEdgM4GUZMxcut4XtyNcvIieK+etcVUTe24a94eRRRpJEqvXd9scFgx25kcylfFIkWk71kaSqUe1DN86YRWJB8gED0BtL0gVtObR8oNQsH3S/OPFGGCXV0EBfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11qDiBHzRDmQt2dsL0v4dNCldRq6uJlWbgDYuTK3R7A=;
 b=COwjzxC1z1NJvpwQPUp/iclBYpyocm4aYznH+J7d7dagWN6Bmj/FjxmuC76objkPn+vxxUScWjm1oQNQEot72y0J7xP1GJZ+686TEVnemBgLtcz/5L9IipWb3YcWVLZMaFLcv7BGWU63vj4XsdIxc7giHdnJz56To3u66kgBlic=
Received: from MN2PR08CA0023.namprd08.prod.outlook.com (2603:10b6:208:239::28)
 by SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 04:42:53 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::82) by MN2PR08CA0023.outlook.office365.com
 (2603:10b6:208:239::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 04:42:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:42:52 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:42:49 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 26/48] drm/amdgpu: remove interface for updating umc v12_0
 ecc
Date: Mon, 22 Jun 2026 12:40:15 +0800
Message-ID: <1c5e7b31c255b88a5908d52624e23dd63f02c8ab.1782103074.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|SA1PR12MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: 69464c89-d365-458d-7c01-08ded018b878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|11063799006|56012099006|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lsfH5HRAy8jGRgtDdzSq1d2CQRS9KaGc0XdU204TbLpl8+LGGkh/k4wsgETUu5qUEio0k1y7RI8BTzlESsUwCWSJ0fQ7FNuganFGvDKzZtC1LFyE/tAwk6iwguCg0avIclnVnreqU7wXPC4E9CF/19PhJ7HEum6g38WyPygpRMN0iBUJ7Ap6wtzpWqq3amtKRXWOr81g5cLbUYpcoM2zxtr0aC5x8BOYAh8/g3IEPAKdK44B8o6q7NLlQfqYfM+eyD7hgo65gJYiqMzxwkTpyBugbN67il5D+ZB4Z1M2zX09SBI+6AG5MOFRn/knHEIEGBteMEeVLWwheHZCV4DO+KYn3paTqGjFBXk8jQj/2OFBqNq5KNTVOygUYZ8i8wZl2Azi0t50Tu7Y7p33zRtUn/uPc/9+g1BsP2BWDOHgOIssqtTNIDwObHJNbzp5DlZ53K98qsVsK1PC4Nv4ln0VKt39pydruQaarJ3gkuGos1P99DQxV5YMWScwW9RfKOHvEwn318JfS4EoEc5bwKXJUEGp8BAxrmal8qaVkCcRHwatGin+tFWIqBi9zZbUJ57MdPUu3/98luyptqQZFS2iAgoUrX4lKyI3irmiOc/GKA69ASvE+2tI5efPDPpsNnbY/JdZrPAZLorpNF3CH3hPOONpYpWfwHHzYhvuf26gr3Z6NR9uALSfJ4fyPISusj7c9+jKB19nYVwcbXGMmyHXQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(11063799006)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: frRMxLofUafCylgYf8LExS2CfzUP6EP4Cp6Bys+vXUO73NvTHVfW1ic8Cq1bvC+nt4dXvCKunpYyY2B5+4+OB7rxC07J5WxHzYYMv8vwXwnQ3x4vU8JhANf25oDfs9ezT9PA8wtu7oo7pD8wCBu7Jzu1kj7kNamK8XuBc0a7+siIAP3pSS8VY71FylxhCL7D9B32OlKPEAHaxLv+tO+MV33r5lNKbE9/F8JhXPda6AAeSLHsZTEkjk3E6BANcGcYdym9ZTYZ0RMPgqIS2Fj6/tx5b9o3U2GT2UH8KG6uk19MZaG0nPHwO5Al03LV7I7yxMiyy52fj/l62VYdDNzE1Hpu3pa3E7SCvF5jfHGtCjqRYYyIOv/tcHU+l4t9MNWbE6h+aLKmK+5P2UCyNPq5NPRa8gNQMJ5H1CN2txwpZMqj0/4QZB2NrWo4ZteKJB6X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:42:52.5438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69464c89-d365-458d-7c01-08ded018b878
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296
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

