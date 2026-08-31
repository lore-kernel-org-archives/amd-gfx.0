Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232C3C61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5800710EA6A;
	Mon, 31 Aug 2026 18:29:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="usNibD/U";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DB4010EA45
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2xq/0/RxiDxgVyW/7CtqeATOIW7794OSFs+Y+1WHpAEFeoZdpy5R3a1l80qJsevfz6U6JmRyE49/+H2B0kzU0egkOPdEbAxyuzyjTiYsoFVJJ0MiD/1OXwwKpEKefbmZqg8mkyZJ3aw9M6PGrqUrAzZNSviXQWTkF6PlW1XDL2NPu9azkBNvQB9BS+LKFymrG3ZATe43GZLc54IxiWr027tbJImlRiBBHKNSqgP301BOUcb6BLTfDbRMCtnWbbVr/y7uf5ieVgD9pI/5WJnCVHAWNNM+ArE6ReeEgpP7ecyI2KRL+6lUCUzUbU5kEzNicylsXLJB58+lxOpEtrBww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PlIpKDfo6R3iQypFVQI2OGPtwPO3rxoYL6o7TXKkiE=;
 b=sszj0nOB0+vl6CFVi0zsn3TsMfcRJ4VoJZ428+eN2SwQwx48gQMJ9EDBkZ1OUCC0MhacCzWxne+10lsIxwL62I9JTO9v0m/lotP2eC6RJd4/7jiAVDAGPDpdc969aSeVt3Vtak7sOLZovM0SrRUTqCDOgKjCpUQdMvSLKAN+X4GfglS1xYYHxZfKJIQ78q5qZruuHXfpRUTwyJBp8knoAzn8o7j5JwbDgJ8y8sr0pS9LeSeHlNSiWkSJE3uejkEmxkSjtOErj+Z1QLAjGs8MEkA4O1xi+eXDcTOTsQjS3kpYs2N1KnFTlCX3xgplJXjWjsTphPtfto4rZf3sHNyx5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PlIpKDfo6R3iQypFVQI2OGPtwPO3rxoYL6o7TXKkiE=;
 b=usNibD/UoCQ2UTf4blL4qsbFidUrk7mn1yhgFUQNdZAzoFbMB8cSArF9w+9NtAyTqC59WLSSIIOwWdMNNH31EY1Wv256h/gQ/sZn/im+oUgD5XJjUIqCgDt+DZgXBafVf6w49AXUxH1zq/+wS85yA9db2sculdiejdvRRu9KTbc=
Received: from BN9PR03CA0121.namprd03.prod.outlook.com (2603:10b6:408:fe::6)
 by LV0PR12MB999069.namprd12.prod.outlook.com (2603:10b6:408:32a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:52 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::29) by BN9PR03CA0121.outlook.office365.com
 (2603:10b6:408:fe::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:36 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 47/95] drm/amdgpu: Implement UALink handle export
Date: Mon, 31 Aug 2026 14:27:06 -0400
Message-ID: <20260831182754.1089811-48-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|LV0PR12MB999069:EE_
X-MS-Office365-Filtering-Correlation-Id: 279ec846-0d2f-4b4d-0ab3-08df078db562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cWV4BFs+8dRcwb6ggcVENh0DlDldvgU8Gy0DvqAbSC2CJ8MjeoCUxsLG/go+LE2luOChKdwzYKkxmL9vsoZoyN6gx7KtbZFPTrl1jlbIvyMoIHweulrbBQ82bTsPd+SX8pxGEzxH6/lhZTo11ZFZWeyZICnlNi0yiARCknO9YO/m9BDIEBfSDfcOn7FAH+T2vD2DbxSxblJGxtV9Y0L2P15mcU64a0/OQqVPL5G5iL3WYMFZk20a3W1CjOdFdX+8ZHs5ZlkSr7H8MEWwQhnxutsf1haiNbmFXT9bEs9lQX/e+FsTneYP2BaJWYgOZXJ/NjJ7Ih/RHGvufqb/NN6M1+ksxO8bukmvQHJz0LpzXam0jsTmY4hjnVaQg6b412jPwGMF19A7a4M4vASmZjDLXmh0ZT5YnfexYeKc3XzLrrbRBZE3nFMnIaLA4Oeu8bb8WA6kKszBruZmn+FiRGFCg+RXtCFneIF9Qhzta7ujUdWdzI/HW12zTd6H6ccpUdxgI5Pm02ieJxU2U8h6f/v0sbhRbvfDh19f7YAVkWWx1sApYa+T1rBEgWYqcvMowSBsx3Cxtqx09i8Eb/VBxPYr66BG1rP2wMGCOmUxFlvd51tXpiv4lIXdTRAt9d3E37jEd/1Yndas5T+bs8ZkMn1sQdagk1GvNMdD9helF84gIVeLNbcKfCYUyXmGc1G0ms7r1U2sCrZ1tZdHy70R4PgPKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1H8mD7m2N5FIZaUbuFYpeZ9G7GfHNvkAfC4P365HAN8gWms1lSKAB7PS9cguF8dO9rO22ol793Zcjnq5dFB16E1u3ETan2AUjTilJsCQwSn1BcQzkOcJtMCD3d4UjTXNAw+ICOpPGLurXw240+ZREvayrB4ZbQqehIC6Ej0JdHlaPyrj6fCVDGzspi+JUVp8o2fCcsqf9jFuP+1hpzpxYAZ0k5vMQ6ZrcJxs2hNe3PuwmDwrBBigxV6MS636QtG6fO4tV6e2hbCxBELHui7kSqEkQaQiDJuqtY1DoSz0kNppgc3LptEdGTeMy2pzdqOURdzljvTPWLx3ufG3lLMCAc3HOKacFKT/BCRPOIRS0rSfWLpYkh7urJXzau3GePWy7WQanpreXBW77HCofWFjwNedrayyGIcaq4J4ivHXuoFNUtU9m7WKIik40t2fidYY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:52.4361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 279ec846-0d2f-4b4d-0ab3-08df078db562
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999069
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
index 51078e83e3e1a..fb698c15af909 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -24,6 +24,7 @@
 
 #include <linux/xarray.h>
 #include <drm/drm_mm.h>
+#include <linux/random.h>
 #include "amdgpu.h"
 #include "amdgpu_ualink.h"
 #include "amdgpu_xgmi.h"
@@ -1221,6 +1222,136 @@ static void amdgpu_ualink_npa_mm_fini(struct amdgpu_device *adev)
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
index cb971ac8bdd9e..4efb0ece4d113 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -35,6 +35,8 @@ struct amdgpu_device;
 #define AMDGPU_UALINK_LOCAL_ACCELS_MAX 8
 #define AMDGPU_UALINK_STATIONS_MAX 64
 
+#define AMDGPU_UALINK_HANDLE_ACCID_MASK			GENMASK_ULL(9, 0)
+
 enum amdgpu_ualink_conn_state {
 	AMDGPU_UALINK_CONN_NOT_READY			= 0,
 	AMDGPU_UALINK_CONN_IN_PROGRESS			= 1,
@@ -125,6 +127,16 @@ struct amdgpu_ualink_station_config {
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
@@ -132,6 +144,58 @@ struct amdgpu_ualink_npa_mm {
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
@@ -203,4 +267,7 @@ int amdgpu_ualink_init(struct amdgpu_device *adev);
 void amdgpu_ualink_fini(struct amdgpu_device *adev);
 int amdgpu_ualink_manager_start(struct amdgpu_device *adev);
 void amdgpu_ualink_manager_stop(struct amdgpu_device *adev);
+int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
+				u32 gem_handle,
+				struct amdgpu_ualink_handle *handle_out);
 #endif
-- 
2.55.0

