Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C43C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62D6C10F483;
	Fri, 21 Aug 2026 19:53:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SYTPdKNm";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010000.outbound.protection.outlook.com
 [40.93.198.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84C9810F483
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:53:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ml+IKoXsHZceYG/XuBr50SGlFCqafwCJEPfaLwnPHocWVV1lZYQ2W2kErYeo+KwryjN3yk4kVu5efpHjTTi0qGkh0Q/vW5o8IAPWlQAdqx35epOkJzQNRbjF95ntND1rIvNhKkCllfZ+TE9U/FvfFMEFkX/ZZVMR8K73H6AZE2AVvqsLKJ6414E9Sqe9Bgu18XiIDYHD2+aRS9+9A5q2ozyj8iLP2xHO52G8yI/4t8xDZalm/rwy+4oa4GjwJ9F8gzTgQgeKVcIMX9URp7xKCsnuoaW8VsoA/vZxMlXQ9V/2uVGwQwSmpUQcN5PfYWAGtvp4fHAjZijbRQJ8IK7ryw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXdY2nVrfUOMK3e1cKCwqXpw/G85++Aa7GmorS3fU3g=;
 b=hFhYXXpmoWvCsCab9KtjA0MQjZ7CMs3ZCQXsam0A2IqW6BN9DRCtwvMWPwoXkZ01mkNGrkgb2S68bBK2/yeV9p/c44kD8S6G3gEsmBvYpfCwSZXdJoTsHwteOmsYcjtC719IJwghK0VPOD3KWmeFsEmn1qTOJG6qoTckLGfQVttHgTVzjZXb/zZTIxidciUGyhfLZBSKL5fpSrVFtu0OGqLhV388IEx5Ouw/eJ/dZzggdXagDDsLITgshOCQMTp4+bZ7FyVUuADLlf99TAtrGmcl6MlL+RH8XEEhCS33UAhQb30OR0LNcwkUHmBz6ncIBKFtpAW6pfzOeDkkUvTsfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXdY2nVrfUOMK3e1cKCwqXpw/G85++Aa7GmorS3fU3g=;
 b=SYTPdKNmbmKpwT/LR090nVz+wnpvp/NazNgRw+5pTXUMArOABQi3xUWRJY2GhfNi0F1cwdKG3rAmNn3zZEN+hBYbL3lN/X6pE0a91BLAtdguYLpa777hyhFzXiVrw73sKvcyTlkIzg7Az0q/K7GnpGs92pBD9JYobUPEILhDwbI=
Received: from MW4PR04CA0037.namprd04.prod.outlook.com (2603:10b6:303:6a::12)
 by PH7PR12MB9255.namprd12.prod.outlook.com (2603:10b6:510:30c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:35:20 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::8b) by MW4PR04CA0037.outlook.office365.com
 (2603:10b6:303:6a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:17 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:16 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:15 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/95] drm/amdgpu: Add UALink manager core infrastructure
Date: Fri, 21 Aug 2026 15:33:30 -0400
Message-ID: <20260821193458.808626-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|PH7PR12MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: 672613a2-c36b-406b-caa7-08deffbb54ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /a5YB2o89AZ+4ujeAosOtb95ESd7h+6GsgibuSQq2QnKU3kaIG1EdWht561yyt/OHsZW1oMyEL4OYFmI7D2tFUx0ZOJtR75LYUK3lMOb3BgCc39ZlzaM3sBkDz6UD5E954GIe+mM3YENlcWc2Y4f1wDFhAOAAP356HqzUETtSwUoijkJ9bp20AI5l1qh7jxlxhN/k4hIb6EROOVifGGkGmJae4Y1gO0bkJmTGsvRen/AuCMuUNPAamVZ0rmYehRoUak8xrJGgr+/ALpMe7TlJtaTQDxw3nu4UosFHknYXddTMVK7Jrd3ootGUoEEHPp/ss+dpIRXVRLDffVQhi7o9PTM9XX2MMFI90KRiycnfwHOTxf9Qr8Z/KFfCOVCezDoZGPcYxcg3BheV1ShhE4v7/Js1SQAoGD/w8B9AHB17KIas08+nlphoX+LmmHeHisk/FDyPZ6lpMT3KV2FVkB+1ZzHTByyuMRbO+ykFBgAidlNz/Sy/pMYiJ7qUUScGi8DTjKzJLEQbkZsGqj3yetuDfZ3hb4U5cYtx9JS5bNlKErAPKKEWEHoMHjtQ/TAjkGriWOQB3xwofy3OhXW9mIAWh0sPxx8drE5VHASJsI/Yg39r/m58L48NeNnwMsDg5Zdm1/CEMBodsb72u0wfoP+Vg8r7WpV9t/z2aiNIFx3LDf2RowWb9K/yt0sOYqV2d+ICqbgHfV7+jtc5ApWatSZqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JT7SqiE7Ps6FxVA+UfONJLVwUhzKnvY133azLQYeFD8AuykBuIzq4ZaVwQyhqkhzTrX1yWlojtBZjXYI4S0kWeA4QgXLURAuWHx+sMLZ8Msmuf86FPh0GUUGkOl4sjkwO/MsJQBBCSowmX56ulHaK/7k9HWjC4hCZs9u8VOtNrQFRHzrEcxAvrzx9Jdqqk7PadeqsYtAsTDDkYdnP034UfD/mNlSx5xTjSeAZFBLuxAj0P6PGNC88GgoMfksAMJYV3gvl9Dwj+FMRjqjHjGmHtYODW0/mn/ElmHP/mYZPQHYCf6k07AVILemHtWpOIKXClqQzFgBaFBlJDJ1uFTqmtOI2i0QCWROTlOJP0UwRKu2GvMyNomqPMApUP7BYRRmZT2LROUMjQH/6tjd593y2TIJpkmOe2DSDrizMN/v1jHGW4i4XeGz0tvSy6Tx4BwQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:17.6367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 672613a2-c36b-406b-caa7-08deffbb54ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9255
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

From: Mukul Joshi <mukul.joshi@amd.com>

This patch introduces AMDGPU UALink manager core infrastructure
which will be responsible for sharing buffer objects across
multiple GPUs, with each GPU running their own OS, in a rack scale
setup. The core infrastructure of the ualink manager will include:
- Store BOs exported from a GPU.
- Store BOs imported by a GPU.
- Store connection state with different GPUs.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 42 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h | 41 ++++++++++++++++++++-
 2 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 4f50040a99256..f5ff9f1e9ce0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -22,9 +22,10 @@
  *
  */
 
+#include <linux/xarray.h>
+#include "amdgpu.h"
 #include "amdgpu_ualink.h"
 #include "amdgpu_xgmi.h"
-#include "amdgpu.h"
 #include <linux/sysfs.h>
 #include <linux/string.h>
 
@@ -958,3 +959,42 @@ void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev)
 		adev->ualink.info = NULL;
 	}
 }
+
+int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
+{
+	int i, r;
+
+	adev->ualink.npa_wq = alloc_workqueue("NPA WQ", WQ_UNBOUND, 0);
+	if (unlikely(!adev->ualink.npa_wq)) {
+		dev_err(adev->dev, "Failed to allocate NPA WQ\n");
+		return -ENOMEM;
+	}
+
+	xa_init_flags(&adev->ualink.exp_xa, XA_FLAGS_LOCK_BH);
+	xa_init_flags(&adev->ualink.imp_xa, XA_FLAGS_LOCK_BH);
+	xa_init_flags(&adev->ualink.handle_invalid_xa, XA_FLAGS_LOCK_BH);
+
+	for (i = 0; i < AMDGPU_UALINK_ACCEL_MAX; i++) {
+		init_completion(&adev->ualink.conn_state[i].hello_done);
+		mutex_init(&adev->ualink.conn_state[i].lock);
+		adev->ualink.conn_state[i].state = AMDGPU_UALINK_CONN_NOT_READY;
+		INIT_LIST_HEAD(&adev->ualink.exp_handles_list[i]);
+		INIT_LIST_HEAD(&adev->ualink.imp_handles_list[i]);
+	}
+
+	return 0;
+}
+
+void amdgpu_ualink_manager_stop(struct amdgpu_device *adev)
+{
+	int i;
+
+	xa_destroy(&adev->ualink.exp_xa);
+	xa_destroy(&adev->ualink.imp_xa);
+	xa_destroy(&adev->ualink.handle_invalid_xa);
+
+	for (i = 0; i < AMDGPU_UALINK_ACCEL_MAX; i++)
+		mutex_destroy(&adev->ualink.conn_state[i].lock);
+
+	destroy_workqueue(adev->ualink.npa_wq);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 384959fbb36fb..f2be71232813d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -31,6 +31,12 @@
 #define AMDGPU_UALINK_LOCAL_ACCELS_MAX 8
 #define AMDGPU_UALINK_STATIONS_MAX 64
 
+enum amdgpu_ualink_conn_state {
+	AMDGPU_UALINK_CONN_NOT_READY			= 0,
+	AMDGPU_UALINK_CONN_IN_PROGRESS			= 1,
+	AMDGPU_UALINK_CONN_ESTABLISHED			= 2
+};
+
 enum amdgpu_ualink_type {
 	AMDGPU_UALINK_TYPE_UALOE = 0,
 	AMDGPU_UALINK_TYPE_UALINK = 1,
@@ -115,14 +121,47 @@ struct amdgpu_ualink_station_config {
 };
 #define to_ualink_station_config(ko) container_of(ko, struct amdgpu_ualink_station_config, kobj)
 
+struct amdgpu_ualink_connection {
+	struct completion hello_done;
+	struct mutex lock;
+	u32 generation_count;
+	enum amdgpu_ualink_conn_state state;
+};
+
 struct amdgpu_ualink_mgr {
 	struct amdgpu_ualink_info *info;
 	struct amdgpu_ualink_ppod_setup *setup;
 	struct amdgpu_ualink_vpod_config *config;
 	struct amdgpu_ualink_station_config *stations;
+
+	/* Xarray to store info about exported BOs */
+	struct xarray	exp_xa;
+
+	/* Xarray to store info about imported ualink handles */
+	struct xarray	imp_xa;
+
+	/* Xarray to store handles to be deleted */
+	struct xarray	handle_invalid_xa;
+
+	/* Array to store connection state per remote GPU */
+	struct amdgpu_ualink_connection conn_state[AMDGPU_UALINK_ACCEL_MAX];
+
+	/* List of exported ualink handles per GPU. Used to quickly traverse
+	 * the list of all handles exported to a remote GPU.
+	 */
+	struct list_head exp_handles_list[AMDGPU_UALINK_ACCEL_MAX];
+
+	/* List of imported ualink handles per GPU. Used to quickly traverse
+	 * the list of all handles imported from a remote GPU.
+	 */
+	struct list_head imp_handles_list[AMDGPU_UALINK_ACCEL_MAX];
+
+	/* WQ to manage revocation of exported memory. */
+	struct workqueue_struct *npa_wq;
 };
 
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev);
-
+int amdgpu_ualink_manager_start(struct amdgpu_device *adev);
+void amdgpu_ualink_manager_stop(struct amdgpu_device *adev);
 #endif
-- 
2.55.0

