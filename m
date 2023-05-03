Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B841C77B75
	for <amd-gfx@archiver.kernel.org>; Wed,  3 May 2023 09:01:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 306DD10E0BC;
	Wed,  3 May 2023 09:01:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C217E10E0BC
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 May 2023 09:01:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNc2wqPugWWC6VvBuZcE3cbbh7K8IaVREh2LI5JZCh2oJ4KmKnmKV3Kwk8RNUYk0GljXmO1BEEhpMzSShe5Vx0wVdxXxrLqaNGN8pspB5EBAmp3mIGrdGvw2seVZqyCwDngRtyrbMw/gXT3s6RCM/Hy8irKfrQJjm24dO+qnf7hKmG+EeDJ4ciqZnKZZU1RCZwAsJYnC1EqyQs/ddOAfBtAcsb6bnW+HeB21DrlS1SqRRfB0jYH+Zku4NJrTBmXbvPxq8ECHuKB+0YHI8QiVlAdOl3bqiK2ciTDSZNv8gvCl1pGJp8zRU75Fjta0lllJK0p/YCoIUehQTy5D+zvFlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJtVVH/1qVXlik+cx1fczWPkTpaoYm5VsEfn15tEEWg=;
 b=MOiMAhiVROCOLmBkOzrtdY0zbpyj6UXyxRfVL7cRKzzM6S7CGcMMMzVhz5NQ0POLqHZ+P6qQS+iRTSFoNHTjZJ9UFKVZtu9YjK2YXft2sHB3XXq8KczOt/y6SAph0+845eMgKxU8rhGaA7HTNC9NdW6LV+dgdTalwtBdPqTdtq6iPsL/zr3U3T142yID1wBHHrndU9TBcv99wPtfhudvYrrvUxwaqZSBoqmHoSJoelIWjv9A3H0kWgCHWm6goqngzVNhWk2fDav2Ux3dN07A9NZseQTUhTGGYahkYBwP75SgkTJc0eFK5Lkac7VWhM/JB2Vk/rsysu6RgE95rvV+BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJtVVH/1qVXlik+cx1fczWPkTpaoYm5VsEfn15tEEWg=;
 b=Ykmku/S00zThuaU6vGJBnKHiQBHzDXKIChPbZ0B1jIYPcjdIIRNdZPqums/2nGHcGRCMaWuhYvqPlLRj54rBjaI5Np2+jgBll3pk/zs0ae7tOVkxn4tJWpBJVWZo5Zgk9EGxYyUtkBRM4B9hM/nb2KfgLlReHrYLE2j93pWmWJk=
Received: from MW4PR03CA0024.namprd03.prod.outlook.com (2603:10b6:303:8f::29)
 by MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 09:01:01 +0000
Received: from CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::4b) by MW4PR03CA0024.outlook.office365.com
 (2603:10b6:303:8f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20 via Frontend
 Transport; Wed, 3 May 2023 09:01:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT079.mail.protection.outlook.com (10.13.175.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.20 via Frontend Transport; Wed, 3 May 2023 09:01:00 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 3 May
 2023 04:00:57 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH v2] drm/amd/amdgpu: Fix errors & warnings in amdgpu _bios, _cs,
 _dma_buf, _fence.c
Date: Wed, 3 May 2023 14:30:25 +0530
Message-ID: <20230503090025.1485900-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT079:EE_|MN0PR12MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: 79aff01c-0592-44f3-bf0f-08db4bb4eae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T2G22OCOzEg9YaFYFBjESXAvIn86BdYtuzt1Uqs/Gk41IaToIlDAEvLCyvutVsCE9HZ23tUcfD+yAtdOtg2sL83bR4AJQL+vLGPupBU3St5GLtSPsl+jj9mnW3XWNE952RpFW8dXc8hA2iwp68D4f6wVpKlpaBG99+8mFoGPvs0jUCSqHXALfZ44Nmwu7vUnV/4DM9nO8tpLfCRU8uFWSwYXJnYxCQ2Lxuv2aAsDNsK8Tx6GPAYL5z3rtBCtixpTANfPeGUVMRLgFM024Ry4r6GV5KmMU0KYZiW4KYfubvY/EFd8zE/Kr5/fAtqAmmRgqIhF4pYOxfput3w4aJoz7KNQ5KIdSjs/w9BWuMoWVKrdfKJwV5oI8uJHJoCrGV6G4ucjLefmvzGWhhW6uJorkLM1oKGKVQxgNnMs1r0g2KY3yES1R9+Iw6nZKT92D3hYH8HfPn+aUOlRwfCWR+Sc4xF2XzQQL5riYqFdZGY9m/LmglN2b4w7sKpWzB/KKj1BqHZ2f9eAbLraI+USoLj+/er5E32AZt8HL72Un2/AvoxdEyw4I0AB4AVhq1+141CswTvsd31Ew+3PAtuMzamNaOw6osJzA4zCybUak3JL/m9m/c4LLtaiCmnAbyUY/rpGhd9svDfh2uZh8zSyK4FDEZIksHrCP5Z9yJapK2swH0/Tv2LnRBltS43WpAyeYKlmyxy//BZypjz1FylVoefjUf0k5/vL9whpiZyp/tNTzUa7GjQ6YIyN8ZzHme6Xon3TDiCzjZtrkMuRPeWCHSujPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(81166007)(356005)(41300700001)(44832011)(82740400003)(316002)(4326008)(6636002)(70206006)(70586007)(36860700001)(82310400005)(36756003)(47076005)(336012)(66574015)(426003)(110136005)(54906003)(83380400001)(16526019)(478600001)(40480700001)(186003)(2616005)(6666004)(7696005)(26005)(1076003)(86362001)(2906002)(5660300002)(40460700003)(8936002)(8676002)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 09:01:00.8419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79aff01c-0592-44f3-bf0f-08db4bb4eae2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The following checkpatch errors & warning is removed.

ERROR: else should follow close brace '}'
ERROR: trailing statements should be on next line
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
WARNING: Possible repeated word: 'Fences'
WARNING: Missing a blank line after declarations
WARNING: braces {} are not necessary for single statement blocks
WARNING: Comparisons should place the constant on the right side of the test
WARNING: printk() should include KERN_<LEVEL> facility level

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v2:
 - Best to make the word "Fences" one line from that. E.g. "/* Fences mark an 
event...". (Christian)

 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c    | 16 +++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 16 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 14 ++++++++------
 4 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 30c28a69e847..b582b83c4984 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -104,9 +104,8 @@ static bool igp_read_bios_from_vram(struct amdgpu_device *adev)
 	adev->bios = NULL;
 	vram_base = pci_resource_start(adev->pdev, 0);
 	bios = ioremap_wc(vram_base, size);
-	if (!bios) {
+	if (!bios)
 		return false;
-	}
 
 	adev->bios = kmalloc(size, GFP_KERNEL);
 	if (!adev->bios) {
@@ -133,9 +132,8 @@ bool amdgpu_read_bios(struct amdgpu_device *adev)
 	adev->bios = NULL;
 	/* XXX: some cards may return 0 for rom size? ddx has a workaround */
 	bios = pci_map_rom(adev->pdev, &size);
-	if (!bios) {
+	if (!bios)
 		return false;
-	}
 
 	adev->bios = kzalloc(size, GFP_KERNEL);
 	if (adev->bios == NULL) {
@@ -168,9 +166,9 @@ static bool amdgpu_read_bios_from_rom(struct amdgpu_device *adev)
 	header[AMD_VBIOS_SIGNATURE_END] = 0;
 
 	if ((!AMD_IS_VALID_VBIOS(header)) ||
-	    0 != memcmp((char *)&header[AMD_VBIOS_SIGNATURE_OFFSET],
-			AMD_VBIOS_SIGNATURE,
-			strlen(AMD_VBIOS_SIGNATURE)))
+		memcmp((char *)&header[AMD_VBIOS_SIGNATURE_OFFSET],
+		       AMD_VBIOS_SIGNATURE,
+		       strlen(AMD_VBIOS_SIGNATURE)) != 0)
 		return false;
 
 	/* valid vbios, go on */
@@ -264,7 +262,7 @@ static int amdgpu_atrm_call(acpi_handle atrm_handle, uint8_t *bios,
 
 	status = acpi_evaluate_object(atrm_handle, NULL, &atrm_arg, &buffer);
 	if (ACPI_FAILURE(status)) {
-		printk("failed to evaluate ATRM got %s\n", acpi_format_exception(status));
+		DRM_ERROR("failed to evaluate ATRM got %s\n", acpi_format_exception(status));
 		return -ENODEV;
 	}
 
@@ -363,7 +361,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 	struct acpi_table_header *hdr;
 	acpi_size tbl_size;
 	UEFI_ACPI_VFCT *vfct;
-	unsigned offset;
+	unsigned int offset;
 
 	if (!ACPI_SUCCESS(acpi_get_table("VFCT", 1, &hdr)))
 		return false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index cb771c73cd07..c5521f9953a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -395,7 +395,7 @@ static int amdgpu_cs_p2_dependencies(struct amdgpu_cs_parser *p,
 {
 	struct drm_amdgpu_cs_chunk_dep *deps = chunk->kdata;
 	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
-	unsigned num_deps;
+	unsigned int num_deps;
 	int i, r;
 
 	num_deps = chunk->length_dw * 4 /
@@ -466,7 +466,7 @@ static int amdgpu_cs_p2_syncobj_in(struct amdgpu_cs_parser *p,
 				   struct amdgpu_cs_chunk *chunk)
 {
 	struct drm_amdgpu_cs_chunk_sem *deps = chunk->kdata;
-	unsigned num_deps;
+	unsigned int num_deps;
 	int i, r;
 
 	num_deps = chunk->length_dw * 4 /
@@ -484,7 +484,7 @@ static int amdgpu_cs_p2_syncobj_timeline_wait(struct amdgpu_cs_parser *p,
 					      struct amdgpu_cs_chunk *chunk)
 {
 	struct drm_amdgpu_cs_chunk_syncobj *syncobj_deps = chunk->kdata;
-	unsigned num_deps;
+	unsigned int num_deps;
 	int i, r;
 
 	num_deps = chunk->length_dw * 4 /
@@ -504,7 +504,7 @@ static int amdgpu_cs_p2_syncobj_out(struct amdgpu_cs_parser *p,
 				    struct amdgpu_cs_chunk *chunk)
 {
 	struct drm_amdgpu_cs_chunk_sem *deps = chunk->kdata;
-	unsigned num_deps;
+	unsigned int num_deps;
 	int i;
 
 	num_deps = chunk->length_dw * 4 /
@@ -538,7 +538,7 @@ static int amdgpu_cs_p2_syncobj_timeline_signal(struct amdgpu_cs_parser *p,
 						struct amdgpu_cs_chunk *chunk)
 {
 	struct drm_amdgpu_cs_chunk_syncobj *syncobj_deps = chunk->kdata;
-	unsigned num_deps;
+	unsigned int num_deps;
 	int i;
 
 	num_deps = chunk->length_dw * 4 /
@@ -756,6 +756,7 @@ static void amdgpu_cs_get_threshold_for_moves(struct amdgpu_device *adev,
 
 		if (used_vis_vram < total_vis_vram) {
 			u64 free_vis_vram = total_vis_vram - used_vis_vram;
+
 			adev->mm_stats.accum_us_vis = min(adev->mm_stats.accum_us_vis +
 							  increment_us, us_upper_bound);
 
@@ -1074,9 +1075,8 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p,
 
 		/* the IB should be reserved at this point */
 		r = amdgpu_bo_kmap(aobj, (void **)&kptr);
-		if (r) {
+		if (r)
 			return r;
-		}
 
 		kptr += va_start - (m->start * AMDGPU_GPU_PAGE_SIZE);
 
@@ -1390,7 +1390,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 /* Cleanup the parser structure */
 static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
 {
-	unsigned i;
+	unsigned int i;
 
 	amdgpu_sync_free(&parser->sync);
 	for (i = 0; i < parser->num_post_deps; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 271e30e34d93..e97b1eef2c9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -148,7 +148,7 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 	if (!bo->tbo.pin_count) {
 		/* move buffer into GTT or VRAM */
 		struct ttm_operation_ctx ctx = { false, false };
-		unsigned domains = AMDGPU_GEM_DOMAIN_GTT;
+		unsigned int domains = AMDGPU_GEM_DOMAIN_GTT;
 
 		if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM &&
 		    attach->peer2peer) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index a7627cc0118d..5d96f630a3aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -42,7 +42,6 @@
 #include "amdgpu_reset.h"
 
 /*
- * Fences
  * Fences mark an event in the GPUs pipeline and are used
  * for GPU/CPU synchronization.  When the fence is written,
  * it is expected that all buffers associated with that fence
@@ -140,7 +139,7 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
  * Returns 0 on success, -ENOMEM on failure.
  */
 int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amdgpu_job *job,
-		      unsigned flags)
+		      unsigned int flags)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct dma_fence *fence;
@@ -174,11 +173,11 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
 				       adev->fence_context + ring->idx, seq);
 			/* Against remove in amdgpu_job_{free, free_cb} */
 			dma_fence_get(fence);
-		}
-		else
+		} else {
 			dma_fence_init(fence, &amdgpu_fence_ops,
 				       &ring->fence_drv.lock,
 				       adev->fence_context + ring->idx, seq);
+		}
 	}
 
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
@@ -396,7 +395,7 @@ signed long amdgpu_fence_wait_polling(struct amdgpu_ring *ring,
  * Returns the number of emitted fences on the ring.  Used by the
  * dynpm code to ring track activity.
  */
-unsigned amdgpu_fence_count_emitted(struct amdgpu_ring *ring)
+unsigned int amdgpu_fence_count_emitted(struct amdgpu_ring *ring)
 {
 	uint64_t emitted;
 
@@ -475,7 +474,7 @@ void amdgpu_fence_update_start_timestamp(struct amdgpu_ring *ring, uint32_t seq,
  */
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
 				   struct amdgpu_irq_src *irq_src,
-				   unsigned irq_type)
+				   unsigned int irq_type)
 {
 	struct amdgpu_device *adev = ring->adev;
 	uint64_t index;
@@ -653,6 +652,7 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
 
 	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
 		struct amdgpu_ring *ring = adev->rings[i];
+
 		if (!ring || !ring->fence_drv.initialized)
 			continue;
 
@@ -865,6 +865,7 @@ static int amdgpu_debugfs_fence_info_show(struct seq_file *m, void *unused)
 
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		struct amdgpu_ring *ring = adev->rings[i];
+
 		if (!ring || !ring->fence_drv.initialized)
 			continue;
 
@@ -938,6 +939,7 @@ static void amdgpu_debugfs_reset_work(struct work_struct *work)
 						  reset_work);
 
 	struct amdgpu_reset_context reset_context;
+
 	memset(&reset_context, 0, sizeof(reset_context));
 
 	reset_context.method = AMD_RESET_METHOD_NONE;
-- 
2.25.1

