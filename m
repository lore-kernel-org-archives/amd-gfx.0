Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFA3606A321
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dmmGP3OU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 134C410F400;
	Mon,  9 Nov 2026 15:59:41 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EEC010F3EA
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 15:59:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7KYnBrRyfFuuK1I/EqSv0rNrqmarWQcTqoXOPve277R8eTDmNHKAYPumsB9d9qxHoHAIMq9HumxXVunDKBWg3Ezm2xhevNGLCQNe8X9G5zoCXncLReHKuXawaeUC+NLmq/6FrQtw/htKWqvDFm4bt1IUabXs0XOcQuS+Vrsp0+VTepC4MXoduJLC2+S3EeVskA6/Wyxh2Fyg8golj3RrxoF9PKoJqrjE9XjtISCa2QXuEDM23//nwiKHN0THA0UnLk0CGZ3GmcEzx5mxWp6BKQ2br/IjrbMDk7IMUDpo5wJkiTYnp6c/gsVahh74i5++sYmdwpLd6/jo8RfLNHdzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xs3pHI8Ns/w0OxGSLnEvT906UaA5JjY05cK6jAr5VIo=;
 b=HjAOlmcqByKwHYwa0bAzXdlfqbffUASOHTuumaj339ycHML1e4utR6YS6WASWrIWt1HS+ewcmTlceg2UJjBQl9bs5NlUf7yULW32raPXUMPb1XlJFKYNMEH6wLG8W2tuyIMVWxK5K6iuGncwa/Vt5yx44E/LW1EAkV0aomx7o7aZL/VXQyySySq42wkVlNwfYtj/e+I/o47GDUxM3SG57z4KsyBUOtYafDR1Rqt3DatuvAxjKe03B1eHTa0q7OdLKPfwawzov7oEANcHtha0BU1bCmORG4ocARHICd9pj3UqjNjRG2yg/piDQnCSFeN7A03utSFKTArrOWplNiEOJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs3pHI8Ns/w0OxGSLnEvT906UaA5JjY05cK6jAr5VIo=;
 b=dmmGP3OUNYOrY73nAZAIZKZdAV7u4rc/S9hwqOrKHyJ985tCBpYCb/Zew4ZNGbRZSddSaTi6TEis4wz3w+2zJd0BOYHzny71WwnDF9BVmU8gX+PKY6rwObP0qKGzumT3Ucd0d5BNeHj6JkJgQJBJfAC/aU2+J6dKMB4S47Z/Sdo=
Received: from PH0PR07CA0071.namprd07.prod.outlook.com (2603:10b6:510:f::16)
 by SJ2PR12MB9192.namprd12.prod.outlook.com (2603:10b6:a03:55d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 15:59:16 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:510:f:cafe::66) by PH0PR07CA0071.outlook.office365.com
 (2603:10b6:510:f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 15:59:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 15:59:15 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Mon, 9 Nov 2026 09:59:14 -0600
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Philip.Yang@amd.com>, Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: fix kfd drm_file race condition for dmabuf
Date: Mon, 9 Nov 2026 10:58:54 -0500
Message-ID: <20261109155855.20471-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|SJ2PR12MB9192:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bde5745-56ab-4a68-b1b3-08df3e7a67f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|261028144727099003|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261026140227099003|261102130727099003|261026121527099003|261102123227099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 882Vj14XzS8oFlcz7BCsBR+TH3SUTMnzRdo5Oa8cHlF5Z+5wnHDLVQf0CXrYflM2SJ6LHjlAwUoXgvh+ZP6rACJdWcd4Fcftxlg6o9ZXE39GxsAgNN0RVjQGiFvLGpWINuZ3nc19CgIxTaYsmd60l+DxDfeCJ4SWodUvR+4SWOWFdheGe9YSvAF9JbvD5ChS+6I2pUGVzyHgk80rhHPsUhse/S/OeO6LDdrjbNpEnhdos3BPfoFWNisR4ojNBROzZfqgbfe5Cwc3lD6xcePEYjKrSogBvVYI6+A1NLsXkuSbHB5tY1v8WB7r2XQaVJSL3SkPYeYVs6rdoeW+wTN9CXcBffdsek34ee7rEcpYLXiPPMNLB1kgOIQCyVnzMh+OjfwCRATnQ/HtR1Nf/grhpNOXP+1PuTDX8mJlS6fLAQ3u4o+X4gDNL3AUlMAKUdcuZK80tX1pllYTLaa3ObWVEIjCa3mwUQQvEN4FGnKF9f7F20JMO1Al5M86Jw9tF2/KfpE3rHMnUNA4or6nXYnAuiUsw09DKd/9zsuQ72CyhRh2Ddi7BPs9UHKsJ2i8TtFLgJ2sqgzarVS7dJnFFH+/21CdL0jE4cBsIhGHXNBFv6X4F1Ul24HbwlP/ZhBJiGvrA9QaIlah5ia86GzXzEN0O0yLlCZaxh4lUNtmZWQ/Dg/3aF5EwJ8d2GzhP93ghBOaAWvhu7kZhk1M8exsc2zc0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(261028144727099003)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261026140227099003)(261102130727099003)(261026121527099003)(261102123227099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E2QqXDdWHcK1ImcEowSY6weipFaMeMg3TFoYdbh+mDESmCsjpd8ar4ivapGH+fkyQsXEaQfd+EshwzIdQTWqdDOpA3DxOi2u4EFM9Jm9g1Y4ZyXmwog8evL5B75tjolC/c63K7Udo1JXQELWvg4ZYD4QSQwYe/Y9cMJ7KjAHlIMYIfbpSV2K60zsey01RcUqOvQGVowwfjNaEJ0QwqgUIowbmCe88iaHirV7KdsH+aS5RDAgDMMD0aDO0nCDvqbUcfOteeZRUXItjDWgTFXce2nUgTAbH3+UBh3ohFPHSAJIiYEly3O2Vs+sfM+s4Cec7mSo3b+hqyKXXc1xyloLZBqx8vGL20thZlkSagXN509sr7TAtqui9aY3NVs+puBDhr0fTPxbQsthy4//m39kfBEN32P364WTbXeQxssixyUfLSjkx2VLV88mz3v5pjUY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 15:59:15.9719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bde5745-56ab-4a68-b1b3-08df3e7a67f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9192
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Every KFD GEM-handle operation (create/delete/lookup, PRIME
handle<->dmabuf/fd conversion) is currently performed against
adev->kfd.client.file, a single struct drm_file created once per GPU
at probe time and shared by every process doing KFD memory ops on
that device. DRM's GEM-handle machinery (per-file handle_count, PRIME
dmabuf cache, idr) assumes one drm_file per process, so funneling all
processes through one shared drm_file breaks that isolation:

 - AMDKFD_IOC_IMPORT_DMABUF creates a GEM handle for the importer that
   does not survive the exporter's FREE_MEMORY_OF_GPU, since handle
   lifetime is tracked against the shared drm_file rather than per
   owner. The importer's BO can be torn down from under it.

 - Concurrent handle churn in the single shared idr/PRIME cache causes
   AMDKFD_IOC_EXPORT_DMABUF (hipIpcGetMemHandle) to intermittently fail
   on a buffer the process just allocated, under multi-process IPC
   pressure on the same GPU.

Each kfd_process_device already carries a genuine per-process,
per-device drm_file in pdd->drm_priv, established via
AMDKFD_IOC_ACQUIRE_VM and guaranteed non-NULL at every call site that
matters (kfd_bind_process_to_device() refuses to proceed otherwise).
Use that instead of the device-wide shared client file for all GEM
handle operations.

Most of the affected functions already receive drm_priv as a
parameter and can use it directly. kfd_mem_export_dmabuf() does not,
and is called both for genuine cross-process export and for
same-process peer/XGMI GPU mapping, where the in-scope drm_priv
belongs to the peer device rather than the device that originally
created the GEM handle. To keep it correct in both cases, cache the
owning drm_priv on struct kgd_mem at allocation/import time, mirroring
how gem_handle itself is already stored once per kgd_mem and never
reassigned.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h      |  8 ++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c    | 17 ++++++++++-------
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 74dc307e5140..3c2734c9a3f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -95,6 +95,14 @@ struct kgd_mem {
 	struct amdgpu_sync sync;
 
 	uint32_t gem_handle;
+	/* Owning per-process drm_file for gem_handle (the allocating pdd for
+	 * native BOs, the importing pdd for imported BOs). Set once at
+	 * alloc/import time; used instead of the device-wide
+	 * adev->kfd.client.file so GEM handle lifetime is scoped to the
+	 * correct per-process drm_file rather than one shared across all
+	 * processes on the device.
+	 */
+	void *drm_priv;
 	bool aql_queue;
 	bool is_imported;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index f060b206c255..eab1eac831f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -833,7 +833,8 @@ static int kfd_mem_export_dmabuf(struct kgd_mem *mem)
 		struct dma_buf *dmabuf;
 
 		bo_adev = amdgpu_ttm_adev(mem->bo->tbo.bdev);
-		dmabuf = drm_gem_prime_handle_to_dmabuf(&bo_adev->ddev, bo_adev->kfd.client.file,
+		dmabuf = drm_gem_prime_handle_to_dmabuf(&bo_adev->ddev,
+					       (struct drm_file *)mem->drm_priv,
 					       mem->gem_handle,
 			mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ?
 					       DRM_RDWR : 0);
@@ -1857,7 +1858,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		pr_debug("Failed to allow vma node access. ret %d\n", ret);
 		goto err_node_allow;
 	}
-	ret = drm_gem_handle_create(adev->kfd.client.file, gobj, &(*mem)->gem_handle);
+	ret = drm_gem_handle_create((struct drm_file *)drm_priv, gobj, &(*mem)->gem_handle);
 	if (ret)
 		goto err_gem_handle_create;
 	bo = gem_to_amdgpu_bo(gobj);
@@ -1874,6 +1875,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	(*mem)->domain = domain;
 	(*mem)->mapped_to_gpu_memory = 0;
 	(*mem)->process_info = avm->process_info;
+	(*mem)->drm_priv = drm_priv;
 
 	add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, user_addr);
 
@@ -1911,7 +1913,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 err_pin_bo:
 err_validate_bo:
 	remove_kgd_mem_from_kfd_bo_list(*mem, avm->process_info);
-	drm_gem_handle_delete(adev->kfd.client.file, (*mem)->gem_handle);
+	drm_gem_handle_delete((struct drm_file *)drm_priv, (*mem)->gem_handle);
 err_gem_handle_create:
 	drm_vma_node_revoke(&gobj->vma_node, drm_priv);
 err_node_allow:
@@ -2027,7 +2029,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 
 	/* Free the BO*/
 	drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
-	drm_gem_handle_delete(adev->kfd.client.file, mem->gem_handle);
+	drm_gem_handle_delete((struct drm_file *)mem->drm_priv, mem->gem_handle);
 	if (mem->dmabuf) {
 		dma_buf_put(mem->dmabuf);
 		mem->dmabuf = NULL;
@@ -2463,6 +2465,7 @@ static int import_obj_create(struct amdgpu_device *adev,
 	add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, false);
 	amdgpu_sync_create(&(*mem)->sync);
 	(*mem)->is_imported = true;
+	(*mem)->drm_priv = drm_priv;
 
 	mutex_lock(&avm->process_info->lock);
 	if (avm->process_info->eviction_fence &&
@@ -2495,11 +2498,11 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device *adev, int fd,
 	uint32_t handle;
 	int ret;
 
-	ret = drm_gem_prime_fd_to_handle(&adev->ddev, adev->kfd.client.file, fd,
+	ret = drm_gem_prime_fd_to_handle(&adev->ddev, (struct drm_file *)drm_priv, fd,
 					 &handle);
 	if (ret)
 		return ret;
-	obj = drm_gem_object_lookup(adev->kfd.client.file, handle);
+	obj = drm_gem_object_lookup((struct drm_file *)drm_priv, handle);
 	if (!obj) {
 		ret = -EINVAL;
 		goto err_release_handle;
@@ -2517,7 +2520,7 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device *adev, int fd,
 err_put_obj:
 	drm_gem_object_put(obj);
 err_release_handle:
-	drm_gem_handle_delete(adev->kfd.client.file, handle);
+	drm_gem_handle_delete((struct drm_file *)drm_priv, handle);
 	return ret;
 }
 
-- 
2.43.0

