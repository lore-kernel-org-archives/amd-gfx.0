Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1ECC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D84FB10F423;
	Fri, 21 Aug 2026 19:51:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F1tfrRgN";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013007.outbound.protection.outlook.com
 [40.107.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D6E010F423
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:51:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpLwdzEr1iBpAEwKu5Xk2zHnLQaekbEJ+St3RjDaHzNof8XbqFVtjwFNFfqDy0mHEHJTNn0VUe5Mol5f/jFznuwGgJqYAm/y92FtmEztwhOWNDn0/VYFXqew1Oi7vmJTsVCM6iqtLT7oFFfA52PgrEoZWbUzUsgC4bAXRXwnRKmaZKhkpcnZaSvOyGLnAhBLYgUH+EDWm9T9/kxEgfwZE0Zh3mnwyiqnF3xBwRgECrPPq7n8aE/PkeUjVsJiUS3evMagUCB/A5ZGZzFuHD068r+cVa6YusfWzUvK85AULnWAZJjPfO3Nj6jO4YZu2O/VMzi602E1rP6pjcQ9nlf8xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jvc4A3jaiPE5tRwnszD6uz6gIVYqKeYduZbgosGu8zc=;
 b=yle3EJtgUDHLS11V7tEaFgiSRo4Zw2SKg05qMam/rPk5nkYJphbCFUJmyRZYFzTyhlxUDvizTKAnQYRc3t8IKml/iVJVWqGyW8dlbCx3w3JZdghseo6ST0Gg7C6UAXDc2QvXJscjajboFA6VexcD6gn6RhKfwWpFqxEzknmeSf4By/xAnv/F+Yy+lttYe5KQvfjb+D6VeuJr4b/s1KEoay3vWJMxNMWg/utWQ26womIpP/cAXC7F2QZc6UzTn+yECSZ4JegnFzH+0G4Mt63jehTyMih0lALfkpTZ9pgRxRBgg/lxpxdd9s3UY3EpzbO5SJ+/sUK9vDAN9qlaSqdRDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jvc4A3jaiPE5tRwnszD6uz6gIVYqKeYduZbgosGu8zc=;
 b=F1tfrRgNjhZ13Pq7I7aqfy/M0Tv1EJ4omjoQ6ECaJsS+Hfl92wtI8pSztsOUi+7KDx0Z1XFVwi76J2kfF3YEROfF/t1Cgy4kzIizCfBZwiFkWRQyGzMVCtW6uG9K9SGYTXhPq5GJR6m8dWER4MLcuNcjC22q0uquM8IokLU/CTk=
Received: from CH0PR04CA0010.namprd04.prod.outlook.com (2603:10b6:610:76::15)
 by SJ1PR12MB6316.namprd12.prod.outlook.com (2603:10b6:a03:455::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:47 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::3f) by CH0PR04CA0010.outlook.office365.com
 (2603:10b6:610:76::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:47 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:40 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:40 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 47/95] drm/amdgpu: Implement UALink handle export
Date: Fri, 21 Aug 2026 15:34:10 -0400
Message-ID: <20260821193458.808626-48-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|SJ1PR12MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 52882551-c8d2-49e6-7975-08deffbb6696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MAdyUc2njyI1sElo4suWqLMpTYZ+uSYy+L6MHtxoWZv6FYFiE4qRa+p3ALuSFxjlyuFMIKP/wEZx1JMEWrJJ+nAuoJZxo1UU1BSY7vVTg3dGJOlmBsAoV5TCaBzUUbgTE142idc7UnhlrZ5D9BGGZURByuX7KQoyXaqKfgGLwB+YjJS6EuoTosgVjoQHSrITyt8loCNJAAwAjg50154a+9aX7m4AYoSttJJ2OKYG5F35tdSb/PsDvUVigQJRykNG7JgoPXWDY3jGiScca/Z2t7WCbdlpvU1tUttMcX/y4G+m1OBljm3Fbu4hMVYz/r9wNQc/2wyY1dWuRq9oXrpFuEvS9nUZY0fc8C/vSU6Yu7Bmal3FHHbklPULbeifYgSdCs4xCN8zdi8e9TubEYe1smsd+W6cy3JvMPtqJQXdiz25jwSwByBo/xANA1okPAwk/ozenJ11ODraN6WhXtPlgKURnGTcSZpB1HtDHzsqsIEFlxpi1qIF194NEF2NBxWtkf0PRPiQ8k7FG70OsZGOavBDdm7QUPp1SAga+it/9sJ8UpXy/IqFkZ+z7K+6YTlfKGLv8xDUoanRHBnmriv2IYzGo4kIykU/xHRX9Yw3VE7qal0V5P8PdsP+HWfmnY9qtw3tKZa7YD+SggjLZd6q482WWsQKiz7aQ8VtFh5l8cGPcV+p9R3KNRcpdT7Ko7RPsJV3HW4GLJqIy4puCEytFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DJNepdjsFY57IQYlxKjZe9k5APTLzJwyTXTE3c7N5/sAo5t1eQklFxxrAwrbIqgVu1LHc5fXeTAaxBehg3gTkbjQIy2q3RoGKpPgwjzTfh6M+QVnChsZnFNqEJx6mCbxXBvVHwKeQQZr8gMWacRWeoteoTcqd6czpSJD33BzCWCLWmD+XCDu9+ou7PFZ/Y/lyMTUZezCJ2BHs16fRNbhv93jmRNifeTaueDOZTkINpPJSCRfc6mvv2p5LUisCO5Mzu0shb0zU5/qYkIbdauJamgMMYoDJ6FCKgrAasksONiGdVkuGH8Nirh8McoqCljoP/FF/SteaifhN2dMiLQwEhE2n5TupYu5mSne6uahQUvF4qHzxiaGHZlJXXkTP2rR+mJPzrvOXEnHA2IGoM9FCNWphASl6XyEttjmF6/x4IFDhXWX8B+GFJSD2IeF2aoo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:47.7925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52882551-c8d2-49e6-7975-08deffbb6696
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6316
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

This patch adds the implementation for exporting a ualink
handle associated with a BO. If the BO doesn't have a
ualink handle generated yet, we first allocate a unique
ualink handle, add it to a lookup table and return the
handle to user-space.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 131 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  67 +++++++++++
 2 files changed, 198 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 059ba29d9b5cc..34c69de06e48d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -24,6 +24,7 @@
 
 #include <linux/xarray.h>
 #include <drm/drm_mm.h>
+#include <linux/random.h>
 #include "amdgpu.h"
 #include "amdgpu_ualink.h"
 #include "amdgpu_xgmi.h"
@@ -1175,6 +1176,136 @@ static void amdgpu_ualink_npa_mm_fini(struct amdgpu_device *adev)
 	drm_mm_takedown(&adev->ualink.npa_mm.mm);
 }
 
+/* The caller of this function is expected to hold the XA lock when calling
+ * this function.
+ */
+static void amdgpu_generate_ualink_handle(struct amdgpu_device *adev,
+				   struct amdgpu_ualink_handle *handle)
+{
+	bool unique;
+
+	do {
+		handle->handle_lo = get_random_u64();
+		/* Replace bottom 10 bits in handle_lo with accId */
+		handle->handle_lo &= ~AMDGPU_UALINK_HANDLE_ACCID_MASK;
+		handle->handle_lo |= adev->ualink.info->ppod.accel_id;
+
+		/* Don't generate/store a Handle with value 0. */
+		if (!handle->handle_lo)
+			continue;
+
+		/* Find if the handle already exists in the exporter xarray.
+		 * If it already exists, then regenerate the handle since we
+		 * want the handle to be unique.
+		 */
+		unique = !xa_load(&adev->ualink.exp_xa, handle->handle_lo);
+	} while (!unique);
+
+	handle->handle_hi = get_random_u64();
+	dev_dbg(adev->dev, "GENERATE-HANDLE: generated handle: %llx:%llx\n",
+		handle->handle_hi, handle->handle_lo);
+}
+
+static void amdgpu_ualink_exp_cleanup_worker(struct work_struct *work)
+{
+}
+
+int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
+				u32 gem_handle,
+				struct amdgpu_ualink_handle *handle_out)
+{
+	struct amdgpu_ualink_exp_xa_node *exp_xa_node;
+	struct amdgpu_ualink_handle handle;
+	struct drm_gem_object *gobj;
+	struct amdgpu_device *adev;
+	struct amdgpu_bo *robj;
+	int r = 0, i;
+
+	gobj = drm_gem_object_lookup(filp, gem_handle);
+	if (!gobj)
+		return -ENOENT;
+
+	robj = gem_to_amdgpu_bo(gobj);
+	adev = amdgpu_ttm_adev(robj->tbo.bdev);
+
+	if (!(robj->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM)) {
+		dev_err(adev->dev, "Only VRAM BOs can be exported\n");
+		r = -EOPNOTSUPP;
+		goto out;
+	}
+
+	if (!robj->ualink_handle_lo) {
+		/* If no ualink handle generated for BO, then generate one and
+		 * add it to the exporter Xarray.
+		 */
+		exp_xa_node = kzalloc(sizeof(*exp_xa_node), GFP_KERNEL);
+		if (!exp_xa_node) {
+			dev_err(adev->dev, "Failed to allocate exp_xa_node\n");
+			r = -ENOMEM;
+			goto out;
+		}
+
+		amdgpu_bo_ref(robj);
+		exp_xa_node->bo = robj;
+		init_completion(&exp_xa_node->npa_done);
+		bitmap_zero(exp_xa_node->importers_bitmap,
+			    AMDGPU_UALINK_ACCEL_MAX);
+		bitmap_zero(exp_xa_node->npa_release_bitmap,
+			AMDGPU_UALINK_ACCEL_MAX);
+		kref_init(&exp_xa_node->refcount);
+		mutex_init(&exp_xa_node->node_lock);
+		INIT_WORK(&exp_xa_node->cleanup_work,
+			  amdgpu_ualink_exp_cleanup_worker);
+		for (i = 0; i < AMDGPU_UALINK_ACCEL_MAX; i++) {
+			INIT_LIST_HEAD(&exp_xa_node->importer_entries[i].list);
+			exp_xa_node->importer_entries[i].parent = exp_xa_node;
+		}
+		/* DMABuf handle for local import of fabric handles */
+		exp_xa_node->dmabuf = drm_gem_prime_handle_to_dmabuf(&adev->ddev, filp,
+						gem_handle, DRM_CLOEXEC | DRM_RDWR);
+		if (IS_ERR(exp_xa_node->dmabuf)) {
+			r = PTR_ERR(exp_xa_node->dmabuf);
+			dev_err(adev->dev, "Failed to generate DMABuf for the BO\n");
+			kfree(exp_xa_node);
+			goto out;
+		}
+
+		xa_lock(&adev->ualink.exp_xa);
+		amdgpu_generate_ualink_handle(adev, &handle);
+		exp_xa_node->handle = handle;
+		r = __xa_insert(&adev->ualink.exp_xa, handle.handle_lo,
+				exp_xa_node, GFP_KERNEL);
+		xa_unlock(&adev->ualink.exp_xa);
+		if (r) {
+			dev_err(adev->dev, "Failed to insert exp_xa_node into XA: %d\n", r);
+			dma_buf_put(exp_xa_node->dmabuf);
+			amdgpu_bo_unref(&robj);
+			kfree(exp_xa_node);
+			goto out;
+		}
+
+		robj->ualink_handle_lo = handle.handle_lo;
+		/* Return the generated handle back to the caller */
+		*handle_out = handle;
+	} else {
+		handle_out->handle_lo = robj->ualink_handle_lo;
+
+		/* Do a sanity check to ensure the handle exists in the XA */
+		xa_lock(&adev->ualink.exp_xa);
+		exp_xa_node = xa_load(&adev->ualink.exp_xa,
+				      robj->ualink_handle_lo);
+		xa_unlock(&adev->ualink.exp_xa);
+		WARN(!exp_xa_node, "Exp XA: Handle_Lo: %llx not found",
+		     robj->ualink_handle_lo);
+		if (exp_xa_node)
+			handle_out->handle_hi = exp_xa_node->handle.handle_hi;
+	}
+
+out:
+	drm_gem_object_put(gobj);
+	return r;
+}
+
 int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
 {
 	int i, r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 333de2058f5b4..cf9522e4f8a74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -31,6 +31,8 @@
 #define AMDGPU_UALINK_LOCAL_ACCELS_MAX 8
 #define AMDGPU_UALINK_STATIONS_MAX 64
 
+#define AMDGPU_UALINK_HANDLE_ACCID_MASK			GENMASK_ULL(9, 0)
+
 enum amdgpu_ualink_conn_state {
 	AMDGPU_UALINK_CONN_NOT_READY			= 0,
 	AMDGPU_UALINK_CONN_IN_PROGRESS			= 1,
@@ -121,6 +123,16 @@ struct amdgpu_ualink_station_config {
 };
 #define to_ualink_station_config(ko) container_of(ko, struct amdgpu_ualink_station_config, kobj)
 
+struct amdgpu_ualink_handle {
+	union {
+		struct {
+			u64 handle_lo;
+			u64 handle_hi;
+		};
+		u64 handle[2];
+	};
+};
+
 struct amdgpu_ualink_npa_mm {
 	struct drm_mm			mm;
 	u64				va_start;
@@ -128,6 +140,58 @@ struct amdgpu_ualink_npa_mm {
 	struct mutex			mm_lock;
 };
 
+struct amdgpu_ualink_importer_entry {
+	struct drm_mm_node			*mm_node;
+	u64					npa_addr;
+
+	/* Keep track of if the connection got reset */
+	u32					generation_count;
+
+	/* Used to connect all handles exported to a particular importer */
+	struct list_head			list;
+
+	/* Pointer to the parent XA node. */
+	struct amdgpu_ualink_exp_xa_node	*parent;
+};
+
+struct amdgpu_ualink_exp_xa_node {
+	/* 128-bit handle for the BO */
+	struct amdgpu_ualink_handle		handle;
+
+	/* Pointer to the BO thats exported.*/
+	struct amdgpu_bo			*bo;
+
+	/* Dmabuf corresponding to the BO */
+	struct dma_buf				*dmabuf;
+
+	/* Mutex to protect the node from concurrent access */
+	struct mutex				node_lock;
+
+	/* Used for storing importer info in source identification mode */
+	struct amdgpu_ualink_importer_entry	importer_entries[AMDGPU_UALINK_ACCEL_MAX];
+
+	/* Used to track all importers of this BO. This is set when the
+	 * exporter sends back the NPA-RSP message.
+	 */
+	DECLARE_BITMAP(importers_bitmap, AMDGPU_UALINK_ACCEL_MAX);
+
+	/* This bitmap is used to send NPA-REVOKE messages to all the importers.
+	 * And to track the NPA-RELEASE response for each NPA-REVOKE message sent.
+	 * A bit is cleared in this bitmap when the NPA RELEASE message is
+	 * received in response to the NPA-REVOKE message.
+	 */
+	DECLARE_BITMAP(npa_release_bitmap, AMDGPU_UALINK_ACCEL_MAX);
+
+	/* Use to signal responses received from all importers */
+	struct completion			npa_done;
+
+	/* Refcount to track lifetime of this node */
+	struct kref				refcount;
+
+	/* Work to cleanup the node. */
+	struct work_struct			cleanup_work;
+};
+
 struct amdgpu_ualink_connection {
 	struct completion hello_done;
 	struct mutex lock;
@@ -199,4 +263,7 @@ int amdgpu_ualink_init(struct amdgpu_device *adev);
 void amdgpu_ualink_fini(struct amdgpu_device *adev);
 int amdgpu_ualink_manager_start(struct amdgpu_device *adev);
 void amdgpu_ualink_manager_stop(struct amdgpu_device *adev);
+int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
+				u32 gem_handle,
+				struct amdgpu_ualink_handle *handle_out);
 #endif
-- 
2.55.0

