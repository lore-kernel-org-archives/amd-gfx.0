Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39363C77B75
	for <amd-gfx@archiver.kernel.org>; Wed,  3 May 2023 08:47:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB02389C69;
	Wed,  3 May 2023 08:47:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6195F89C69
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 May 2023 08:47:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgDAsh0l2Oj1hTxvMIDeOiR4rvVfAeemE1JXTpeqccXc65yzHBsTLAu5yoOTPaT9asiAuLGWLHFRvHwUf2REtQ2qIvJrPC4Rf2JdhHk1ghGdEYk0qXA2/FdbsXj6Tj3D8I/o2DB5a3EcW1s2ST8ZygVBMNDrr2gZxukDE3nsWB/MHpn/OhNWgBl3B7wn2fFitNYDt1idga41MTk384xpvr3aO/DO1JqubA0S5hn3rbCHzpjVvN+CFTHm4PoCqgob4ZJA+EmnotobU1RY4NQUyHg0HuF4rkNDwSXVaR9j6b1EumcmA2EfQLi5bC4GkYbfpaRG6PIlLsIc1HRoXCzMKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhgGhtFr5j8U9NcihEBFJcW2KROZg8kH+wAZ2JHFI4k=;
 b=m7YgGrDonuMtkq4g23qYVy53Q0ix+lut6JB0QciaFED1VbDzIm9Cgt93BLlwMZ2sOMrxUtUXllqZvzJdcxGEUrmwI7JAKEDDAbesjr/axXkvqc/fAXXh8HwytyVQl9T1/q65fijCd6u1DQJg7URDazwRoVwajUZk26LiPF8Fb7Y3uizMYeyJvMwLjx8DwKmZdBG95Pn2f8McOgaMmAQiHxULBbjOTGKTfqARP8NVbA8R41AqT8LwJfMvb1b4l0YVnVKOJex8it0YkeO2ivKHkx7Rb1aLqkIyCcAxM/LMzk53034uBo/75uNPOfSb0ekNwS+R9emo+UHtGy4Bjl9X/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhgGhtFr5j8U9NcihEBFJcW2KROZg8kH+wAZ2JHFI4k=;
 b=rrvWEM3vwC7q5zHKC9RH3k7IVzRyuUrya94ZidLbSYCxyWNExriteM9uOhPy4373bzt3A6/Bb0t5Oh0Q0p60FejMf2KvHZkSFXSF//P8DNK7h8Jm7uu0/EpzvHtyC6Jluys7rpnib9833ZGrATWN6Ifjy4qpuSLMHd+KSAJH+34=
Received: from BN9PR03CA0180.namprd03.prod.outlook.com (2603:10b6:408:f4::35)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 08:46:58 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4::4) by BN9PR03CA0180.outlook.office365.com
 (2603:10b6:408:f4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20 via Frontend
 Transport; Wed, 3 May 2023 08:46:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.22 via Frontend Transport; Wed, 3 May 2023 08:46:57 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 3 May
 2023 03:46:55 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix errors & warnings in amdgpu _bios, _cs,
 _dma_buf, _fence.c
Date: Wed, 3 May 2023 14:16:40 +0530
Message-ID: <20230503084640.1460565-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 070258c1-03ec-4760-750e-08db4bb2f457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2mW601EBINbqGlkXq6/+I/XydXL5fgZt7MZNy9J9VFEe2EU+OKW5PCPtbjgWRwkN/IqibNSbXrihmYKIk0qXJ5s4/nc+6CQd56q9UsjYnekoXaPVudP+AGXVVAs015r/A0xx5sWuzKRRD0+XCAgHKaVaR4Ev++KtWqvTUEuGR8d5jAHTxNgPf0NKbfq0eZef9UkgSzlUyQ+Awl/3WP/ojQNdKS+Jz9DkYQ8JAh94KwS1PSLpewDD60KBzWzR0rIkSeOZ3s986gOFI1XDrv6cIu9tSaxH3TaIovHUve/ZyWNZmHKYgxHGEs3vLKAOLUQ0m9M8u03Vor3O50bs0l+/mhC8gSc33AEol+CxzPJpmqb6RyyEeFtPvXnFiBklbh5kb7BgiLpMRpKMD/9RcGeHaTPim9yGQ8dPDy20EZaHLe1VOCmBHFDXVrxhxX28duVvx7pn4I3LPqTbX/la3HzRkDjD6N4NWWtzbq4Xjva/RDKGkyCeBK+rOZ8k6jUufCgsLy7TcUFE8PT2TkRW1y1X+htkJACK2tX8A4/XLITtRbRYI6iSLaK7Ws+NFs4Vgv7jq7Z//6J79iQP1/alWjbMdxox/KqkTYhgfaBqXc0QPx5LPfxW46wvqNGMXX1fQtKTLH0v3OBaTKopPvAgzPgMnimmjSORsN5r8zdYxEsZhJWVjgJjdJb21V5i6Oqg2coS1nlrNSbH7be9Ye8kQxSKgSOlUTI4f9g22DDvjVOFI/61EhL/Mp4UQQvWkn5xH8CRWdwh6W7JI0O76vz2npGn9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(36840700001)(46966006)(40470700004)(86362001)(70206006)(4326008)(70586007)(6636002)(82740400003)(41300700001)(5660300002)(36756003)(8676002)(8936002)(82310400005)(6666004)(7696005)(1076003)(316002)(44832011)(110136005)(2906002)(2616005)(40480700001)(40460700003)(478600001)(54906003)(26005)(81166007)(356005)(36860700001)(16526019)(186003)(426003)(336012)(83380400001)(66574015)(47076005)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 08:46:57.8222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 070258c1-03ec-4760-750e-08db4bb2f457
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c    | 16 +++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 16 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 15 +++++++++------
 4 files changed, 25 insertions(+), 24 deletions(-)

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
index a7627cc0118d..d6e35a3904c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -43,7 +43,7 @@
 
 /*
  * Fences
- * Fences mark an event in the GPUs pipeline and are used
+ * mark an event in the GPUs pipeline and are used
  * for GPU/CPU synchronization.  When the fence is written,
  * it is expected that all buffers associated with that fence
  * are no longer in use by the associated ring on the GPU and
@@ -140,7 +140,7 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
  * Returns 0 on success, -ENOMEM on failure.
  */
 int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amdgpu_job *job,
-		      unsigned flags)
+		      unsigned int flags)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct dma_fence *fence;
@@ -174,11 +174,11 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
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
@@ -396,7 +396,7 @@ signed long amdgpu_fence_wait_polling(struct amdgpu_ring *ring,
  * Returns the number of emitted fences on the ring.  Used by the
  * dynpm code to ring track activity.
  */
-unsigned amdgpu_fence_count_emitted(struct amdgpu_ring *ring)
+unsigned int amdgpu_fence_count_emitted(struct amdgpu_ring *ring)
 {
 	uint64_t emitted;
 
@@ -475,7 +475,7 @@ void amdgpu_fence_update_start_timestamp(struct amdgpu_ring *ring, uint32_t seq,
  */
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
 				   struct amdgpu_irq_src *irq_src,
-				   unsigned irq_type)
+				   unsigned int irq_type)
 {
 	struct amdgpu_device *adev = ring->adev;
 	uint64_t index;
@@ -653,6 +653,7 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
 
 	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
 		struct amdgpu_ring *ring = adev->rings[i];
+
 		if (!ring || !ring->fence_drv.initialized)
 			continue;
 
@@ -865,6 +866,7 @@ static int amdgpu_debugfs_fence_info_show(struct seq_file *m, void *unused)
 
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		struct amdgpu_ring *ring = adev->rings[i];
+
 		if (!ring || !ring->fence_drv.initialized)
 			continue;
 
@@ -938,6 +940,7 @@ static void amdgpu_debugfs_reset_work(struct work_struct *work)
 						  reset_work);
 
 	struct amdgpu_reset_context reset_context;
+
 	memset(&reset_context, 0, sizeof(reset_context));
 
 	reset_context.method = AMD_RESET_METHOD_NONE;
-- 
2.25.1

