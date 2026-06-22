Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8FCCD98F6
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03E0810E474;
	Mon, 22 Jun 2026 04:42:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FOjV1NbK";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18FCA10E470
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAuPiMWDyNhITMxocVn1zfA0R9rT+tXTtjL5T4eRlZK7r7CabuLjKTb33x+oY+L3TynFFVa58HJKw6Rv7890pjr2meIH67jL1ocdCEj798oaRZ310z7FtZSUWFYX3/p8xFVmYC5tliTtasD2oJ49qHwb517XTy+5V2ScFACS8dAyIyNhiMojB9wl5jFjo/VvQQT3xre7xXqM9/P+0eZgU/qYSRr41+jh8bm8qD1olqFG7sYGc01ZRYEFZaxUN/FX0N1SIqu7MddjOzP/ss9eP9xpcKE1nIfcSkam0t9Z5wpQeIiupwj4zqyUfLnh5DgXmGAIjM3Z9dVlumekHZSk8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbyajliIhSzLX+8O8rR6EFXc0Xk+rXGUaChd/B/Drkw=;
 b=hDe89d5lcOm+0EheFUQfJvCIkSnCbxFiCO6I3G4ofnqeaMpLmT7bRbkLh+9hzugvKg4pTeS6aOKYJ8+3AMLRMH2c+n6txKUYMmw9/DNGaS8qcohOwJsefsB+ToSC22eHkhrnNluVmdaKdlSoKrh85r4DApRk0WAGD9F7CdhRcM2kJ8J+Ih0oA1cWZB6DbxQq6eZde3I3ODTbC4n6F/7rhqiEzMIUrSsFf32OxljBzZFQH6+ue/L/OV9QoO8RNz3PBUyjkzuGrcxZCAh37WWXv5FVjuhJgMu4e9CSn9KpquRERxMrMOzh8T5oW6d73QzVCTsVuYMAhtes8/vOe3bSZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbyajliIhSzLX+8O8rR6EFXc0Xk+rXGUaChd/B/Drkw=;
 b=FOjV1NbKFbwpqi3ZTCKt71gFB5PbI9m0xhjs9L6Gm/WnuNUDykSunUem6rYyPyWXoiIAorLDhsJaPh41XwACoR8UEcUAqQ+4EnB6wQmkmP7jL6UmPGG8LeXAmpv4KGLcTyAjFMLqztST/lfRmjh31ZdVA2iWBtxcUwX7chtyBNQ=
Received: from BLAPR05CA0002.namprd05.prod.outlook.com (2603:10b6:208:36e::12)
 by PH7PR12MB6835.namprd12.prod.outlook.com (2603:10b6:510:1b5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 04:42:32 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::4c) by BLAPR05CA0002.outlook.office365.com
 (2603:10b6:208:36e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Mon,
 22 Jun 2026 04:42:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:42:32 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:42:29 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 15/48] drm/amdgpu: retire legacy ACA support
Date: Mon, 22 Jun 2026 12:40:04 +0800
Message-ID: <a0613bcf129d07f0595bf8428289d6c876155b1c.1782103073.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|PH7PR12MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: 15d011b2-13da-4bc0-a2e4-08ded018ac72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|22082099003|18092099006|18002099003|10086099003|3023799007|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: SxMPmvoRYYxhPHSW8hogG7SviZ0un+FCmVhBTy24gKqZ38DUUodPj1P6/Ex88yCzsWQT+bOhWn5wDx/j/4Sg+AbdE/b9eeOez3M/yFB9otW72LAzk3rFJs++fzq9JN8IJMt1HymnUYAOep4eGHNOt/L0ry7F616rzB8AhqLnnRd6ybN7BGL1y8Bi9DpWaFZocq2pBfg2xK/dRBQhJLhB8n5gnk4GOKknCbzix+FEMgjeMv26drOFt7YaAF7SK1sdbp33FaTtcdqFM9c937/Aoh58vpDK9NLqP1ZIuJvzJhwlcsBFouhmSAMheamNW0blhhKVUZokKBqu+BLQtLKX3+7My2nfkhCTSyY11tJ5uNaJRkq2j0l3E/ZuLe55x8hHvxV6KyfQpcpr0tIxR+lNdtUkEIOgEgI4873MBOdS+m37NeI4IcdBbu0DA/gCbtG54kcbhAqCSApEQd//TC+3obYpEo4lNmuTZoFPDkVIG6fJ8wm9eMZ3GEwxLk0PGMZ0hn+MVNHT/b/IC5yBDFY7FOXbXM3LxuWOf3UcSLPIDp2okIRHAVc02tuqF+t81ho3MqNkyMdnk00TiaOONNmXblCN5f4ckXo0SeA/D4ZkQvUFwGgQei6oyV5ft3oq+yiePCkWTa23mR6uiEsjBJd8dGwBX3XVjkPK8xQYFe79lrwfsK3KM1F4hItNOl2+Qdtnr8p418UdRsUQzmEHn6cgMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(22082099003)(18092099006)(18002099003)(10086099003)(3023799007)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5OBipbvSn0ro2cbzbwNF5Vhp5P7IbgZVdIY4F2JygPL8EhrtUywcNXNxNAV5gvBNtnGlCO5CjgtOQXAkXFf/tRzPkw3WsXD6XuFfuGGiN5/TylpEGQS6PoDAJJG9FOrHnEyyHETLaGYaXYV5nIFwUlHYB28yLLO1eLs4+sK1s1EakEwqrxnjChscINjApv+9qA30tlnKFhi9ugzYHgz8RhgczZ4wF+UZxdjbM5aW+yRZUyI8sKjj01zQefdMA2sm84MbmoiHXOGEJ4ti0lADvV/1tFrKoQaOPvYrJxjD6SN8JV2Pu7W0HedKR2HKP8wbi1qQFHCKbrnzMrqbWsRRe6ZK2VQPwp+kY2KgX8SmB4MyKOovrxKG/HPl7aDgA+o+WXGWBmZ3z6bDvvpRYTBJp9gKWTeErRY6/NPHuxgLAog0ZG9IkWEdUhcrVztFjJWm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:42:32.3741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d011b2-13da-4bc0-a2e4-08ded018ac72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6835
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

retire legacy ACA support

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   4 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c  | 450 -----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h  | 229 ------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 170 +--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h  |  14 +-
 7 files changed, 13 insertions(+), 861 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index ba80542ead9d..5100e35027ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -70,7 +70,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o amdgpu_lockdep.o \
-	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
+	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_dev_coredump.o \
 	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4c3e933ff6d5..13d6f31344c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -104,7 +104,6 @@
 #include "amdgpu_smuio.h"
 #include "amdgpu_fdinfo.h"
 #include "amdgpu_mca.h"
-#include "amdgpu_aca.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_lockdep.h"
 #include "amdgpu_cper.h"
@@ -990,9 +989,6 @@ struct amdgpu_device {
 	/* MCA */
 	struct amdgpu_mca               mca;
 
-	/* ACA */
-	struct amdgpu_aca		aca;
-
 	/* CPER */
 	struct amdgpu_cper		cper;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
deleted file mode 100644
index a5d053b20911..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ /dev/null
@@ -1,450 +0,0 @@
-/*
- * Copyright 2023 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- */
-
-#include <linux/list.h>
-#include "amdgpu.h"
-#include "amdgpu_aca.h"
-#include "amdgpu_ras.h"
-
-static struct aca_bank_error *new_bank_error(struct aca_error *aerr, struct aca_bank_info *info)
-{
-	struct aca_bank_error *bank_error;
-
-	bank_error = kvzalloc(sizeof(*bank_error), GFP_KERNEL);
-	if (!bank_error)
-		return NULL;
-
-	INIT_LIST_HEAD(&bank_error->node);
-	memcpy(&bank_error->info, info, sizeof(*info));
-
-	mutex_lock(&aerr->lock);
-	list_add_tail(&bank_error->node, &aerr->list);
-	aerr->nr_errors++;
-	mutex_unlock(&aerr->lock);
-
-	return bank_error;
-}
-
-static struct aca_bank_error *find_bank_error(struct aca_error *aerr, struct aca_bank_info *info)
-{
-	struct aca_bank_error *bank_error = NULL;
-	struct aca_bank_info *tmp_info;
-	bool found = false;
-
-	mutex_lock(&aerr->lock);
-	list_for_each_entry(bank_error, &aerr->list, node) {
-		tmp_info = &bank_error->info;
-		if (tmp_info->socket_id == info->socket_id &&
-		    tmp_info->die_id == info->die_id) {
-			found = true;
-			goto out_unlock;
-		}
-	}
-
-out_unlock:
-	mutex_unlock(&aerr->lock);
-
-	return found ? bank_error : NULL;
-}
-
-static void aca_bank_error_remove(struct aca_error *aerr, struct aca_bank_error *bank_error)
-{
-	if (!aerr || !bank_error)
-		return;
-
-	list_del(&bank_error->node);
-	aerr->nr_errors--;
-
-	kvfree(bank_error);
-}
-
-static struct aca_bank_error *get_bank_error(struct aca_error *aerr, struct aca_bank_info *info)
-{
-	struct aca_bank_error *bank_error;
-
-	if (!aerr || !info)
-		return NULL;
-
-	bank_error = find_bank_error(aerr, info);
-	if (bank_error)
-		return bank_error;
-
-	return new_bank_error(aerr, info);
-}
-
-int aca_error_cache_log_bank_error(struct aca_handle *handle, struct aca_bank_info *info,
-				   enum aca_error_type type, u64 count)
-{
-	struct aca_error_cache *error_cache = &handle->error_cache;
-	struct aca_bank_error *bank_error;
-	struct aca_error *aerr;
-
-	if (!handle || !info || type >= ACA_ERROR_TYPE_COUNT)
-		return -EINVAL;
-
-	if (!count)
-		return 0;
-
-	aerr = &error_cache->errors[type];
-	bank_error = get_bank_error(aerr, info);
-	if (!bank_error)
-		return -ENOMEM;
-
-	bank_error->count += count;
-
-	return 0;
-}
-
-static void aca_error_init(struct aca_error *aerr, enum aca_error_type type)
-{
-	mutex_init(&aerr->lock);
-	INIT_LIST_HEAD(&aerr->list);
-	aerr->type = type;
-	aerr->nr_errors = 0;
-}
-
-static void aca_init_error_cache(struct aca_handle *handle)
-{
-	struct aca_error_cache *error_cache = &handle->error_cache;
-	int type;
-
-	for (type = ACA_ERROR_TYPE_UE; type < ACA_ERROR_TYPE_COUNT; type++)
-		aca_error_init(&error_cache->errors[type], type);
-}
-
-static void aca_error_fini(struct aca_error *aerr)
-{
-	struct aca_bank_error *bank_error, *tmp;
-
-	mutex_lock(&aerr->lock);
-	if (list_empty(&aerr->list))
-		goto out_unlock;
-
-	list_for_each_entry_safe(bank_error, tmp, &aerr->list, node)
-		aca_bank_error_remove(aerr, bank_error);
-
-out_unlock:
-	mutex_unlock(&aerr->lock);
-	mutex_destroy(&aerr->lock);
-}
-
-static void aca_fini_error_cache(struct aca_handle *handle)
-{
-	struct aca_error_cache *error_cache = &handle->error_cache;
-	int type;
-
-	for (type = ACA_ERROR_TYPE_UE; type < ACA_ERROR_TYPE_COUNT; type++)
-		aca_error_fini(&error_cache->errors[type]);
-}
-
-static int add_aca_handle(struct amdgpu_device *adev, struct aca_handle_manager *mgr, struct aca_handle *handle,
-			  const char *name, const struct aca_info *ras_info, void *data)
-{
-	memset(handle, 0, sizeof(*handle));
-
-	handle->adev = adev;
-	handle->mgr = mgr;
-	handle->name = name;
-	handle->hwip = ras_info->hwip;
-	handle->mask = ras_info->mask;
-	handle->bank_ops = ras_info->bank_ops;
-	handle->data = data;
-	aca_init_error_cache(handle);
-
-	INIT_LIST_HEAD(&handle->node);
-	list_add_tail(&handle->node, &mgr->list);
-	mgr->nr_handles++;
-
-	return 0;
-}
-
-static ssize_t aca_sysfs_read(struct device *dev,
-			      struct device_attribute *attr, char *buf)
-{
-	struct aca_handle *handle = container_of(attr, struct aca_handle, aca_attr);
-
-	/* NOTE: the aca cache will be auto cleared once read,
-	 * So the driver should unify the query entry point, forward request to ras query interface directly */
-	return amdgpu_ras_aca_sysfs_read(dev, attr, handle, buf, handle->data);
-}
-
-static int add_aca_sysfs(struct amdgpu_device *adev, struct aca_handle *handle)
-{
-	struct device_attribute *aca_attr = &handle->aca_attr;
-
-	snprintf(handle->attr_name, sizeof(handle->attr_name) - 1, "aca_%s", handle->name);
-	aca_attr->show = aca_sysfs_read;
-	aca_attr->attr.name = handle->attr_name;
-	aca_attr->attr.mode = S_IRUGO;
-	sysfs_attr_init(&aca_attr->attr);
-
-	return sysfs_add_file_to_group(&adev->dev->kobj,
-				       &aca_attr->attr,
-				       "ras");
-}
-
-int amdgpu_aca_add_handle(struct amdgpu_device *adev, struct aca_handle *handle,
-			  const char *name, const struct aca_info *ras_info, void *data)
-{
-	struct amdgpu_aca *aca = &adev->aca;
-	int ret;
-
-	if (!amdgpu_aca_is_enabled(adev))
-		return 0;
-
-	ret = add_aca_handle(adev, &aca->mgr, handle, name, ras_info, data);
-	if (ret)
-		return ret;
-
-	return add_aca_sysfs(adev, handle);
-}
-
-static void remove_aca_handle(struct aca_handle *handle)
-{
-	struct aca_handle_manager *mgr = handle->mgr;
-
-	aca_fini_error_cache(handle);
-	list_del(&handle->node);
-	mgr->nr_handles--;
-}
-
-static void remove_aca_sysfs(struct aca_handle *handle)
-{
-	struct amdgpu_device *adev = handle->adev;
-	struct device_attribute *aca_attr = &handle->aca_attr;
-
-	if (adev->dev->kobj.sd)
-		sysfs_remove_file_from_group(&adev->dev->kobj,
-					     &aca_attr->attr,
-					     "ras");
-}
-
-void amdgpu_aca_remove_handle(struct aca_handle *handle)
-{
-	if (!handle || list_empty(&handle->node))
-		return;
-
-	remove_aca_sysfs(handle);
-	remove_aca_handle(handle);
-}
-
-static int aca_manager_init(struct aca_handle_manager *mgr)
-{
-	INIT_LIST_HEAD(&mgr->list);
-	mgr->nr_handles = 0;
-
-	return 0;
-}
-
-static void aca_manager_fini(struct aca_handle_manager *mgr)
-{
-	struct aca_handle *handle, *tmp;
-
-	if (list_empty(&mgr->list))
-		return;
-
-	list_for_each_entry_safe(handle, tmp, &mgr->list, node)
-		amdgpu_aca_remove_handle(handle);
-}
-
-bool amdgpu_aca_is_enabled(struct amdgpu_device *adev)
-{
-	return (adev->aca.is_enabled ||
-		adev->debug_enable_ras_aca);
-}
-
-int amdgpu_aca_init(struct amdgpu_device *adev)
-{
-	struct amdgpu_aca *aca = &adev->aca;
-	int ret;
-
-	atomic_set(&aca->ue_update_flag, 0);
-
-	ret = aca_manager_init(&aca->mgr);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-void amdgpu_aca_fini(struct amdgpu_device *adev)
-{
-	struct amdgpu_aca *aca = &adev->aca;
-
-	aca_manager_fini(&aca->mgr);
-
-	atomic_set(&aca->ue_update_flag, 0);
-}
-
-int amdgpu_aca_reset(struct amdgpu_device *adev)
-{
-	struct amdgpu_aca *aca = &adev->aca;
-
-	atomic_set(&aca->ue_update_flag, 0);
-
-	return 0;
-}
-
-void amdgpu_aca_set_smu_funcs(struct amdgpu_device *adev, const struct aca_smu_funcs *smu_funcs)
-{
-	struct amdgpu_aca *aca = &adev->aca;
-
-	WARN_ON(aca->smu_funcs);
-	aca->smu_funcs = smu_funcs;
-}
-
-int aca_bank_info_decode(struct aca_bank *bank, struct aca_bank_info *info)
-{
-	u64 ipid;
-	u32 instidhi, instidlo;
-
-	if (!bank || !info)
-		return -EINVAL;
-
-	ipid = bank->regs[ACA_REG_IDX_IPID];
-	info->hwid = ACA_REG__IPID__HARDWAREID(ipid);
-	info->mcatype = ACA_REG__IPID__MCATYPE(ipid);
-	/*
-	 * Unfied DieID Format: SAASS. A:AID, S:Socket.
-	 * Unfied DieID[4:4] = InstanceId[0:0]
-	 * Unfied DieID[0:3] = InstanceIdHi[0:3]
-	 */
-	instidhi = ACA_REG__IPID__INSTANCEIDHI(ipid);
-	instidlo = ACA_REG__IPID__INSTANCEIDLO(ipid);
-	info->die_id = ((instidhi >> 2) & 0x03);
-	info->socket_id = ((instidlo & 0x1) << 2) | (instidhi & 0x03);
-
-	return 0;
-}
-
-static int aca_bank_get_error_code(struct amdgpu_device *adev, struct aca_bank *bank)
-{
-	struct amdgpu_aca *aca = &adev->aca;
-	const struct aca_smu_funcs *smu_funcs = aca->smu_funcs;
-
-	if (!smu_funcs || !smu_funcs->parse_error_code)
-		return -EOPNOTSUPP;
-
-	return smu_funcs->parse_error_code(adev, bank);
-}
-
-int aca_bank_check_error_codes(struct amdgpu_device *adev, struct aca_bank *bank, int *err_codes, int size)
-{
-	int i, error_code;
-
-	if (!bank || !err_codes)
-		return -EINVAL;
-
-	error_code = aca_bank_get_error_code(adev, bank);
-	if (error_code < 0)
-		return error_code;
-
-	for (i = 0; i < size; i++) {
-		if (err_codes[i] == error_code)
-			return 0;
-	}
-
-	return -EINVAL;
-}
-
-int amdgpu_aca_smu_set_debug_mode(struct amdgpu_device *adev, bool en)
-{
-	struct amdgpu_aca *aca = &adev->aca;
-	const struct aca_smu_funcs *smu_funcs = aca->smu_funcs;
-
-	if (!smu_funcs || !smu_funcs->set_debug_mode)
-		return -EOPNOTSUPP;
-
-	return smu_funcs->set_debug_mode(adev, en);
-}
-
-#if defined(CONFIG_DEBUG_FS)
-static int amdgpu_aca_smu_debug_mode_set(void *data, u64 val)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)data;
-	int ret;
-
-	ret = amdgpu_ras_set_aca_debug_mode(adev, val ? true : false);
-	if (ret)
-		return ret;
-
-	dev_info(adev->dev, "amdgpu set smu aca debug mode %s success\n", val ? "on" : "off");
-
-	return 0;
-}
-
-static int aca_dump_show(struct seq_file *m, enum aca_smu_type type)
-{
-	return 0;
-}
-
-static int aca_dump_ce_show(struct seq_file *m, void *unused)
-{
-	return aca_dump_show(m, ACA_SMU_TYPE_CE);
-}
-
-static int aca_dump_ce_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, aca_dump_ce_show, inode->i_private);
-}
-
-static const struct file_operations aca_ce_dump_debug_fops = {
-	.owner = THIS_MODULE,
-	.open = aca_dump_ce_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static int aca_dump_ue_show(struct seq_file *m, void *unused)
-{
-	return aca_dump_show(m, ACA_SMU_TYPE_UE);
-}
-
-static int aca_dump_ue_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, aca_dump_ue_show, inode->i_private);
-}
-
-static const struct file_operations aca_ue_dump_debug_fops = {
-	.owner = THIS_MODULE,
-	.open = aca_dump_ue_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-DEFINE_DEBUGFS_ATTRIBUTE(aca_debug_mode_fops, NULL, amdgpu_aca_smu_debug_mode_set, "%llu\n");
-#endif
-
-void amdgpu_aca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root)
-{
-#if defined(CONFIG_DEBUG_FS)
-	if (!root)
-		return;
-
-	debugfs_create_file("aca_debug_mode", 0200, root, adev, &aca_debug_mode_fops);
-	debugfs_create_file("aca_ue_dump", 0400, root, adev, &aca_ue_dump_debug_fops);
-	debugfs_create_file("aca_ce_dump", 0400, root, adev, &aca_ce_dump_debug_fops);
-#endif
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
deleted file mode 100644
index 93a70a350f34..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ /dev/null
@@ -1,229 +0,0 @@
-/*
- * Copyright 2023 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- */
-
-#ifndef __AMDGPU_ACA_H__
-#define __AMDGPU_ACA_H__
-
-#include <linux/list.h>
-
-struct ras_err_data;
-struct ras_query_context;
-
-#define ACA_MAX_REGS_COUNT	(16)
-
-#define ACA_REG_FIELD(x, h, l)			(((x) & GENMASK_ULL(h, l)) >> l)
-#define ACA_REG__STATUS__VAL(x)			ACA_REG_FIELD(x, 63, 63)
-#define ACA_REG__STATUS__OVERFLOW(x)		ACA_REG_FIELD(x, 62, 62)
-#define ACA_REG__STATUS__UC(x)			ACA_REG_FIELD(x, 61, 61)
-#define ACA_REG__STATUS__EN(x)			ACA_REG_FIELD(x, 60, 60)
-#define ACA_REG__STATUS__MISCV(x)		ACA_REG_FIELD(x, 59, 59)
-#define ACA_REG__STATUS__ADDRV(x)		ACA_REG_FIELD(x, 58, 58)
-#define ACA_REG__STATUS__PCC(x)			ACA_REG_FIELD(x, 57, 57)
-#define ACA_REG__STATUS__ERRCOREIDVAL(x)	ACA_REG_FIELD(x, 56, 56)
-#define ACA_REG__STATUS__TCC(x)			ACA_REG_FIELD(x, 55, 55)
-#define ACA_REG__STATUS__SYNDV(x)		ACA_REG_FIELD(x, 53, 53)
-#define ACA_REG__STATUS__CECC(x)		ACA_REG_FIELD(x, 46, 46)
-#define ACA_REG__STATUS__UECC(x)		ACA_REG_FIELD(x, 45, 45)
-#define ACA_REG__STATUS__DEFERRED(x)		ACA_REG_FIELD(x, 44, 44)
-#define ACA_REG__STATUS__POISON(x)		ACA_REG_FIELD(x, 43, 43)
-#define ACA_REG__STATUS__SCRUB(x)		ACA_REG_FIELD(x, 40, 40)
-#define ACA_REG__STATUS__ERRCOREID(x)		ACA_REG_FIELD(x, 37, 32)
-#define ACA_REG__STATUS__ADDRLSB(x)		ACA_REG_FIELD(x, 29, 24)
-#define ACA_REG__STATUS__ERRORCODEEXT(x)	ACA_REG_FIELD(x, 21, 16)
-#define ACA_REG__STATUS__ERRORCODE(x)		ACA_REG_FIELD(x, 15, 0)
-
-#define ACA_REG__IPID__MCATYPE(x)		ACA_REG_FIELD(x, 63, 48)
-#define ACA_REG__IPID__INSTANCEIDHI(x)		ACA_REG_FIELD(x, 47, 44)
-#define ACA_REG__IPID__HARDWAREID(x)		ACA_REG_FIELD(x, 43, 32)
-#define ACA_REG__IPID__INSTANCEIDLO(x)		ACA_REG_FIELD(x, 31, 0)
-
-#define ACA_REG__MISC0__VALID(x)		ACA_REG_FIELD(x, 63, 63)
-#define ACA_REG__MISC0__OVRFLW(x)		ACA_REG_FIELD(x, 48, 48)
-#define ACA_REG__MISC0__ERRCNT(x)		ACA_REG_FIELD(x, 43, 32)
-
-#define ACA_REG__SYND__ERRORINFORMATION(x)	ACA_REG_FIELD(x, 17, 0)
-
-/* NOTE: The following codes refers to the smu header file */
-#define ACA_EXTERROR_CODE_CE			0x3a
-#define ACA_EXTERROR_CODE_FAULT			0x3b
-
-#define ACA_ERROR_UE_MASK		BIT_MASK(ACA_ERROR_TYPE_UE)
-#define ACA_ERROR_CE_MASK		BIT_MASK(ACA_ERROR_TYPE_CE)
-#define ACA_ERROR_DEFERRED_MASK		BIT_MASK(ACA_ERROR_TYPE_DEFERRED)
-
-#define mmSMNAID_AID0_MCA_SMU		0x03b30400	/* SMN AID AID0 */
-#define mmSMNAID_XCD0_MCA_SMU		0x36430400	/* SMN AID XCD0 */
-#define mmSMNAID_XCD1_MCA_SMU		0x38430400	/* SMN AID XCD1 */
-#define mmSMNXCD_XCD0_MCA_SMU		0x40430400	/* SMN XCD XCD0 */
-
-#define ACA_BANK_ERR_IS_DEFFERED(bank)                                \
-	(ACA_REG__STATUS__POISON((bank)->regs[ACA_REG_IDX_STATUS]) || \
-	 ACA_REG__STATUS__DEFERRED((bank)->regs[ACA_REG_IDX_STATUS]))
-
-enum aca_reg_idx {
-	ACA_REG_IDX_CTL			= 0,
-	ACA_REG_IDX_STATUS		= 1,
-	ACA_REG_IDX_ADDR		= 2,
-	ACA_REG_IDX_MISC0		= 3,
-	ACA_REG_IDX_CONFIG		= 4,
-	ACA_REG_IDX_IPID		= 5,
-	ACA_REG_IDX_SYND		= 6,
-	ACA_REG_IDX_DESTAT		= 8,
-	ACA_REG_IDX_DEADDR		= 9,
-	ACA_REG_IDX_CTL_MASK		= 10,
-	ACA_REG_IDX_COUNT		= 16,
-};
-
-enum aca_hwip_type {
-	ACA_HWIP_TYPE_UNKNOW = -1,
-	ACA_HWIP_TYPE_PSP = 0,
-	ACA_HWIP_TYPE_UMC,
-	ACA_HWIP_TYPE_SMU,
-	ACA_HWIP_TYPE_PCS_XGMI,
-	ACA_HWIP_TYPE_COUNT,
-};
-
-enum aca_error_type {
-	ACA_ERROR_TYPE_INVALID = -1,
-	ACA_ERROR_TYPE_UE = 0,
-	ACA_ERROR_TYPE_CE,
-	ACA_ERROR_TYPE_DEFERRED,
-	ACA_ERROR_TYPE_COUNT
-};
-
-enum aca_smu_type {
-	ACA_SMU_TYPE_INVALID = -1,
-	ACA_SMU_TYPE_UE = 0,
-	ACA_SMU_TYPE_CE,
-	ACA_SMU_TYPE_COUNT,
-};
-
-struct aca_hwip {
-	int hwid;
-	int mcatype;
-};
-
-struct aca_bank {
-	enum aca_error_type aca_err_type;
-	enum aca_smu_type smu_err_type;
-	u64 regs[ACA_MAX_REGS_COUNT];
-};
-
-struct aca_bank_node {
-	struct aca_bank bank;
-	struct list_head node;
-};
-
-struct aca_banks {
-	int nr_banks;
-	struct list_head list;
-};
-
-struct aca_bank_info {
-	int die_id;
-	int socket_id;
-	int hwid;
-	int mcatype;
-};
-
-struct aca_bank_error {
-	struct list_head node;
-	struct aca_bank_info info;
-	u64 count;
-};
-
-struct aca_error {
-	struct list_head list;
-	struct mutex lock;
-	enum aca_error_type type;
-	int nr_errors;
-};
-
-struct aca_handle_manager {
-	struct list_head list;
-	int nr_handles;
-};
-
-struct aca_error_cache {
-	struct aca_error errors[ACA_ERROR_TYPE_COUNT];
-};
-
-struct aca_handle {
-	struct list_head node;
-	enum aca_hwip_type hwip;
-	struct amdgpu_device *adev;
-	struct aca_handle_manager *mgr;
-	struct aca_error_cache error_cache;
-	const struct aca_bank_ops *bank_ops;
-	struct device_attribute aca_attr;
-	char attr_name[64];
-	const char *name;
-	u32 mask;
-	void *data;
-};
-
-struct aca_bank_ops {
-	int (*aca_bank_parser)(struct aca_handle *handle, struct aca_bank *bank, enum aca_smu_type type, void *data);
-	bool (*aca_bank_is_valid)(struct aca_handle *handle, struct aca_bank *bank, enum aca_smu_type type,
-				  void *data);
-};
-
-struct aca_smu_funcs {
-	int max_ue_bank_count;
-	int max_ce_bank_count;
-	int (*set_debug_mode)(struct amdgpu_device *adev, bool enable);
-	int (*get_valid_aca_count)(struct amdgpu_device *adev, enum aca_smu_type type, u32 *count);
-	int (*get_valid_aca_bank)(struct amdgpu_device *adev, enum aca_smu_type type, int idx, struct aca_bank *bank);
-	int (*parse_error_code)(struct amdgpu_device *adev, struct aca_bank *bank);
-};
-
-struct amdgpu_aca {
-	struct aca_handle_manager mgr;
-	const struct aca_smu_funcs *smu_funcs;
-	atomic_t ue_update_flag;
-	bool is_enabled;
-};
-
-struct aca_info {
-	enum aca_hwip_type hwip;
-	const struct aca_bank_ops *bank_ops;
-	u32 mask;
-};
-
-int amdgpu_aca_init(struct amdgpu_device *adev);
-void amdgpu_aca_fini(struct amdgpu_device *adev);
-int amdgpu_aca_reset(struct amdgpu_device *adev);
-void amdgpu_aca_set_smu_funcs(struct amdgpu_device *adev, const struct aca_smu_funcs *smu_funcs);
-bool amdgpu_aca_is_enabled(struct amdgpu_device *adev);
-
-int aca_bank_info_decode(struct aca_bank *bank, struct aca_bank_info *info);
-int aca_bank_check_error_codes(struct amdgpu_device *adev, struct aca_bank *bank, int *err_codes, int size);
-
-int amdgpu_aca_add_handle(struct amdgpu_device *adev, struct aca_handle *handle,
-			  const char *name, const struct aca_info *aca_info, void *data);
-void amdgpu_aca_remove_handle(struct aca_handle *handle);
-int amdgpu_aca_smu_set_debug_mode(struct amdgpu_device *adev, bool en);
-void amdgpu_aca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root);
-int aca_error_cache_log_bank_error(struct aca_handle *handle, struct aca_bank_info *info,
-				   enum aca_error_type type, u64 count);
-#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index 34a70e479f60..6fb129025761 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -481,8 +481,7 @@ int amdgpu_cper_init(struct amdgpu_device *adev)
 
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_ras_cper_en(adev))
 		return 0;
-	else if (!amdgpu_sriov_vf(adev) && !amdgpu_uniras_enabled(adev) &&
-		!amdgpu_aca_is_enabled(adev))
+	else if (!amdgpu_sriov_vf(adev) && !amdgpu_uniras_enabled(adev))
 		return 0;
 
 	r = amdgpu_cper_ring_init(adev);
@@ -501,7 +500,7 @@ int amdgpu_cper_init(struct amdgpu_device *adev)
 
 int amdgpu_cper_fini(struct amdgpu_device *adev)
 {
-	if (!amdgpu_aca_is_enabled(adev) && !amdgpu_sriov_ras_cper_en(adev))
+	if (amdgpu_sriov_vf(adev))
 		return 0;
 
 	adev->cper.enabled = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 098731cf2bf4..05d65bf06c71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1375,63 +1375,6 @@ static void amdgpu_ras_mgr_virt_error_data_statistics_update(struct ras_manager
 	obj->err_data.de_count = err_data->de_count;
 }
 
-static struct ras_manager *get_ras_manager(struct amdgpu_device *adev, enum amdgpu_ras_block blk)
-{
-	struct ras_common_if head;
-
-	memset(&head, 0, sizeof(head));
-	head.block = blk;
-
-	return amdgpu_ras_find_obj(adev, &head);
-}
-
-int amdgpu_ras_bind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
-			const struct aca_info *aca_info, void *data)
-{
-	struct ras_manager *obj;
-
-	/* in resume phase, no need to create aca fs node */
-	if (adev->in_suspend || amdgpu_reset_in_recovery(adev))
-		return 0;
-
-	obj = get_ras_manager(adev, blk);
-	if (!obj)
-		return -EINVAL;
-
-	return amdgpu_aca_add_handle(adev, &obj->aca_handle, ras_block_str(blk), aca_info, data);
-}
-
-int amdgpu_ras_unbind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block blk)
-{
-	struct ras_manager *obj;
-
-	obj = get_ras_manager(adev, blk);
-	if (!obj)
-		return -EINVAL;
-
-	amdgpu_aca_remove_handle(&obj->aca_handle);
-
-	return 0;
-}
-
-ssize_t amdgpu_ras_aca_sysfs_read(struct device *dev, struct device_attribute *attr,
-				  struct aca_handle *handle, char *buf, void *data)
-{
-	struct ras_manager *obj = container_of(handle, struct ras_manager, aca_handle);
-	struct ras_query_if info = {
-		.head = obj->head,
-	};
-
-	if (!amdgpu_ras_get_error_query_ready(obj->adev))
-		return sysfs_emit(buf, "Query currently inaccessible\n");
-
-	if (amdgpu_ras_query_error_status(obj->adev, &info))
-		return -EINVAL;
-
-	return sysfs_emit(buf, "%s: %lu\n%s: %lu\n%s: %lu\n", "ue", info.ue_count,
-			  "ce", info.ce_count, "de", info.de_count);
-}
-
 static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev,
 						struct ras_query_if *info,
 						struct ras_err_data *err_data,
@@ -1591,7 +1534,6 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 {
 	struct amdgpu_ras_block_object *block_obj = amdgpu_ras_get_ras_block(adev, block, 0);
 	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
-	const struct aca_smu_funcs *smu_funcs = adev->aca.smu_funcs;
 
 	if (!block_obj || !block_obj->hw_ops) {
 		dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
@@ -1600,7 +1542,7 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 	}
 
 	if (!amdgpu_ras_is_supported(adev, block) ||
-	    !amdgpu_ras_get_aca_debug_mode(adev))
+	    !amdgpu_ras_get_mca_debug_mode(adev))
 		return -EOPNOTSUPP;
 
 	if (amdgpu_sriov_vf(adev))
@@ -1608,8 +1550,7 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 
 	/* skip ras error reset in gpu reset */
 	if ((amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) &&
-	    ((smu_funcs && smu_funcs->set_debug_mode) ||
-	     (mca_funcs && mca_funcs->mca_set_debug_mode)))
+	    mca_funcs && mca_funcs->mca_set_debug_mode)
 		return -EOPNOTSUPP;
 
 	if (block_obj->hw_ops->reset_ras_error_count)
@@ -2056,9 +1997,6 @@ int amdgpu_ras_sysfs_create(struct amdgpu_device *adev,
 {
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, head);
 
-	if (amdgpu_aca_is_enabled(adev))
-		return 0;
-
 	if (!obj || obj->attr_inuse)
 		return -EINVAL;
 
@@ -2096,9 +2034,6 @@ int amdgpu_ras_sysfs_remove(struct amdgpu_device *adev,
 {
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, head);
 
-	if (amdgpu_aca_is_enabled(adev))
-		return 0;
-
 	if (!obj || !obj->attr_inuse)
 		return -EINVAL;
 
@@ -2211,25 +2146,6 @@ static void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
 			    obj, &amdgpu_ras_debugfs_ops);
 }
 
-static bool amdgpu_ras_aca_is_supported(struct amdgpu_device *adev)
-{
-	bool ret;
-
-	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
-	case IP_VERSION(13, 0, 6):
-	case IP_VERSION(13, 0, 12):
-	case IP_VERSION(13, 0, 14):
-	case IP_VERSION(13, 0, 15):
-		ret = true;
-		break;
-	default:
-		ret = false;
-		break;
-	}
-
-	return ret;
-}
-
 void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
@@ -2256,13 +2172,6 @@ void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
 			amdgpu_ras_debugfs_create(adev, &fs_info, dir);
 		}
 	}
-
-	if (amdgpu_ras_aca_is_supported(adev)) {
-		if (amdgpu_aca_is_enabled(adev))
-			amdgpu_aca_smu_debugfs_init(adev, dir);
-		else
-			amdgpu_mca_smu_debugfs_init(adev, dir);
-	}
 }
 
 /* debugfs end */
@@ -3876,15 +3785,6 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 	adev->ras_enabled = amdgpu_ras_enable == 0 ? 0 :
 		adev->ras_hw_enabled & amdgpu_ras_mask;
 
-	/* aca is disabled by default except for psp v13_0_6/v13_0_12/v13_0_14 */
-	if (!amdgpu_sriov_vf(adev)) {
-		adev->aca.is_enabled =
-			(amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
-			amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12) ||
-			amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14) ||
-			amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 15));
-	}
-
 	/* bad page feature is not applicable to specific app platform */
 	if (adev->gmc.is_app_apu &&
 	    amdgpu_ip_version(adev, UMC_HWIP, 0) == IP_VERSION(12, 0, 0))
@@ -4105,15 +4005,6 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 		goto release_con;
 	}
 
-	if (amdgpu_ras_aca_is_supported(adev)) {
-		if (amdgpu_aca_is_enabled(adev))
-			r = amdgpu_aca_init(adev);
-		else
-			r = amdgpu_mca_init(adev);
-		if (r)
-			goto release_con;
-	}
-
 	con->init_task_pid = task_pid_nr(current);
 	get_task_comm(con->init_task_comm, current);
 
@@ -4341,24 +4232,6 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 
 	amdgpu_ras_event_mgr_init(adev);
 
-	if (amdgpu_ras_aca_is_supported(adev)) {
-		if (amdgpu_reset_in_recovery(adev)) {
-			if (amdgpu_aca_is_enabled(adev))
-				r = amdgpu_aca_reset(adev);
-			else
-				r = amdgpu_mca_reset(adev);
-			if (r)
-				return r;
-		}
-
-		if (!amdgpu_sriov_vf(adev)) {
-			if (amdgpu_aca_is_enabled(adev))
-				amdgpu_ras_set_aca_debug_mode(adev, false);
-			else
-				amdgpu_ras_set_mca_debug_mode(adev, false);
-		}
-	}
-
 	/* Guest side doesn't need init ras feature */
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_ras_telemetry_en(adev))
 		return 0;
@@ -4443,13 +4316,6 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 	amdgpu_ras_fs_fini(adev);
 	amdgpu_ras_interrupt_remove_all(adev);
 
-	if (amdgpu_ras_aca_is_supported(adev)) {
-		if (amdgpu_aca_is_enabled(adev))
-			amdgpu_aca_fini(adev);
-		else
-			amdgpu_mca_fini(adev);
-	}
-
 	WARN(AMDGPU_RAS_GET_FEATURES(con->features), "Feature mask is not cleared");
 
 	if (AMDGPU_RAS_GET_FEATURES(con->features))
@@ -4866,41 +4732,22 @@ int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable)
 	if (con) {
 		ret = amdgpu_mca_smu_set_debug_mode(adev, enable);
 		if (!ret)
-			con->is_aca_debug_mode = enable;
-	}
-
-	return ret;
-}
-
-int amdgpu_ras_set_aca_debug_mode(struct amdgpu_device *adev, bool enable)
-{
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	int ret = 0;
-
-	if (con) {
-		if (amdgpu_aca_is_enabled(adev))
-			ret = amdgpu_aca_smu_set_debug_mode(adev, enable);
-		else
-			ret = amdgpu_mca_smu_set_debug_mode(adev, enable);
-		if (!ret)
-			con->is_aca_debug_mode = enable;
+			con->is_mca_debug_mode = enable;
 	}
 
 	return ret;
 }
 
-bool amdgpu_ras_get_aca_debug_mode(struct amdgpu_device *adev)
+bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	const struct aca_smu_funcs *smu_funcs = adev->aca.smu_funcs;
 	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
 
 	if (!con)
 		return false;
 
-	if ((amdgpu_aca_is_enabled(adev) && smu_funcs && smu_funcs->set_debug_mode) ||
-	    (!amdgpu_aca_is_enabled(adev) && mca_funcs && mca_funcs->mca_set_debug_mode))
-		return con->is_aca_debug_mode;
+	if (mca_funcs && mca_funcs->mca_set_debug_mode)
+		return con->is_mca_debug_mode;
 	else
 		return true;
 }
@@ -4910,7 +4757,6 @@ bool amdgpu_ras_get_error_query_mode(struct amdgpu_device *adev,
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
-	const struct aca_smu_funcs *smu_funcs = adev->aca.smu_funcs;
 
 	if (!con) {
 		*error_query_mode = AMDGPU_RAS_INVALID_ERROR_QUERY;
@@ -4919,9 +4765,9 @@ bool amdgpu_ras_get_error_query_mode(struct amdgpu_device *adev,
 
 	if (amdgpu_sriov_vf(adev)) {
 		*error_query_mode = AMDGPU_RAS_VIRT_ERROR_COUNT_QUERY;
-	} else if ((smu_funcs && smu_funcs->set_debug_mode) || (mca_funcs && mca_funcs->mca_set_debug_mode)) {
+	} else if (mca_funcs && mca_funcs->mca_set_debug_mode) {
 		*error_query_mode =
-			(con->is_aca_debug_mode) ? AMDGPU_RAS_DIRECT_ERROR_QUERY : AMDGPU_RAS_FIRMWARE_ERROR_QUERY;
+			(con->is_mca_debug_mode) ? AMDGPU_RAS_DIRECT_ERROR_QUERY : AMDGPU_RAS_FIRMWARE_ERROR_QUERY;
 	} else {
 		*error_query_mode = AMDGPU_RAS_DIRECT_ERROR_QUERY;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 1629a242d58e..fe167c8396f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -31,7 +31,6 @@
 #include "ta_ras_if.h"
 #include "amdgpu_ras_eeprom.h"
 #include "amdgpu_smuio.h"
-#include "amdgpu_aca.h"
 
 struct amdgpu_iv_entry;
 
@@ -572,7 +571,7 @@ struct amdgpu_ras {
 	/* Indicates smu whether need update bad channel info */
 	bool update_channel_flag;
 	/* Record status of smu mca debug mode */
-	bool is_aca_debug_mode;
+	bool is_mca_debug_mode;
 	bool is_rma;
 
 	/* Record special requirements of gpu reset caller */
@@ -683,8 +682,6 @@ struct ras_manager {
 	struct ras_ih_data ih_data;
 
 	struct ras_err_data err_data;
-
-	struct aca_handle aca_handle;
 };
 
 struct ras_badpage {
@@ -945,8 +942,7 @@ struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu_device *adev);
 int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras *ras_con);
 
 int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable);
-int amdgpu_ras_set_aca_debug_mode(struct amdgpu_device *adev, bool enable);
-bool amdgpu_ras_get_aca_debug_mode(struct amdgpu_device *adev);
+bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev);
 bool amdgpu_ras_get_error_query_mode(struct amdgpu_device *adev,
 				     unsigned int *mode);
 
@@ -987,12 +983,6 @@ int amdgpu_ras_error_statistic_de_count(struct ras_err_data *err_data,
 					struct amdgpu_smuio_mcm_config_info *mcm_info,
 					u64 count);
 void amdgpu_ras_query_boot_status(struct amdgpu_device *adev, u32 num_instances);
-int amdgpu_ras_bind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
-			       const struct aca_info *aca_info, void *data);
-int amdgpu_ras_unbind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block blk);
-
-ssize_t amdgpu_ras_aca_sysfs_read(struct device *dev, struct device_attribute *attr,
-				  struct aca_handle *handle, char *buf, void *data);
 
 void amdgpu_ras_set_fed(struct amdgpu_device *adev, bool status);
 bool amdgpu_ras_get_fed_status(struct amdgpu_device *adev);
-- 
2.34.1

