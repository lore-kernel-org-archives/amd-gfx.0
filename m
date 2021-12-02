Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37021C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 21:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 667866E0E6;
	Thu,  2 Dec 2021 21:43:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54E006E0E6
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 21:43:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIx5WTXtPqCqyj7spVK2gK6EztQPUh6LvX2aARTfTHcm4/OFJl6MZx+SuMa70CicQ70U6nTkZBeAtRR64/e8zuAJz1sm/nzWeNu20LkGGaamFPomIoUasoOcIR/z5V2XM3R5YSnUF/HiCoSJR10lGGixDh43TBFjCUmG4NvpluQc6ENIHPbl99WEwN5TmHuBONzCLFn6XvVM63iSUHuPJRRlZ6+sb23kiDQge5dDj2FKyP/npthEIHMXEag2k9Bp9LQwGao0WOmz31PkVyvjKxwaPakO8ZFk8Zx95/OYGy4B21w9EB8XjJRFEYle7eWGz92b64cevhbR7A+LGSEUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCHhLAL00sEoEgYDfTQ+dtFIpo6XuyIjDoxEjbLA3Pw=;
 b=hsjXdDNgV4FllE2RmzRAzNovpQOW5+bu5PZAVMrknihTMaOmHmpRV+FpFHqZqfXIiC4SJfDBYWpIGJU1erZKuCxgQY0cPr0F58rBunrySWUBq+mcT7Z8aKx1U4IBfxn4cEupm2+kuNblrYPw0LmME3e6ESUU3dY87gdDlj1dF7oywG6GdQpmVnrirfIDM49doUx7MBrG7DBVrMEfNCQBIMeTcHsHS+0DztMHnCMJKGOV58pJrRQ6W1x7eE8GyjzAYoO7swbjp6bAWYpoD0qy4WSOz1tXED9dXX77WO+kAwgO+AlgTg29UCfSicX9OFSIuyxEr59i2BBSqIsDnYxDcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCHhLAL00sEoEgYDfTQ+dtFIpo6XuyIjDoxEjbLA3Pw=;
 b=pcwT3jHas6CB7R6qGmCRXnWjtUpZFXn0qiJIJIOd6kKomFTlBzU/oMr9P8dg/j5ZtSOvoTPimTDcoTbVZBNK7Y2Itc2+by/kvBc4jupWnoGZL4wqHrdDTwSkq+0722XhFUew9ckGpsIgisogxcZ3xCVM1kiHpMiUrGkXGJKSgoM=
Received: from MWHPR17CA0063.namprd17.prod.outlook.com (2603:10b6:300:93::25)
 by DM6PR12MB4943.namprd12.prod.outlook.com (2603:10b6:5:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 21:43:18 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::89) by MWHPR17CA0063.outlook.office365.com
 (2603:10b6:300:93::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Thu, 2 Dec 2021 21:43:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 2 Dec 2021 21:43:17 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 2 Dec
 2021 15:43:16 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: use sdma to optimize debugged non-visible device
 memory access
Date: Thu, 2 Dec 2021 16:43:04 -0500
Message-ID: <20211202214304.1155207-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 961f53a6-8d42-47ab-e96f-08d9b5dcc0a9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4943:
X-Microsoft-Antispam-PRVS: <DM6PR12MB494364C10E1C7AA8FB3CBD1085699@DM6PR12MB4943.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: runaHTaFr9ZkuHmxiv1qj/m0xt1pbJHBColbJ5zXsJyNHA68e9WNh+l33G3ujoSpZWkzcIio/5cQsyleokDjnzLmZEfqTts6d5PDGHAomfINUAdicQrxomVXX61K4c4lhlAlZ2e0D1uTVtVgMF+x4Bb8DiMYzLRY0DvNB8vEa31rhzphM8+4azhEebnSfKJs2Q+kzOMtMzy48ad8b/oJ6xqhBwASSRVhl0oT4FpTpkDiE1htgMLshnvS4wN5/xMe4C6T9xm1LlCVI5VtND7Y7DJI3UnoVBbsaTyA11ywXLasRoSeWkKRKzlcObT/w1SEhELhwxuqjGxQbIKUjxvfupy/cmITsM0b2N8xnG/M7yUqXzg+W8QNsERGYiqRWcfbLrdoJzpVm4cZFSJkMD9B/oIlzmlPI9+nNUnjrYIff8FCW60CyS9BjchGWBD1jpyhHeFvqeNq4d3UulctLZgKIM/1WwGbidR/4o0IwCS7KVsfER8orJubulO4w5LgR4gov63c88VBvjzSXn/d1RRyzsoRYijGT0U5OAhBTvVh9To/h44cLir6jhmJRvjT9Eb6IOl8QhCnqMzP399D1hz9s9e6Uxs+Vu9forIgNcTHyccu038DWQv8nkHWTxHO5a+JoZLr5YKRpQkOnmxdYX+SZf9OpAc+pFrUc7CBipqp2B+0OlXbuZIKbQ/p1LSHBeH1qN/Fqzmy64JDrkKPNuwfZgcHfx2OgzP9/sz2hej1ygk10Ojj1pYMND7W7kChTmSzpyyz15fj66UD8sdGIVFHX7ti/ALztMhcHmd8W1u5fPY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(8676002)(8936002)(36860700001)(7696005)(336012)(2616005)(54906003)(6666004)(36756003)(4326008)(508600001)(2906002)(16526019)(86362001)(5660300002)(82310400004)(81166007)(44832011)(83380400001)(47076005)(70206006)(70586007)(426003)(316002)(186003)(40460700001)(26005)(356005)(1076003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 21:43:17.7710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 961f53a6-8d42-47ab-e96f-08d9b5dcc0a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4943
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>,
 Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To support better memory access performance on non-Large BAR devices, use
SDMA copies instead of MM access.

SDMA access is restricted to PAGE_SIZE'd access to account for the PTRACED
process memory r/w operation use case.  Any other access size will use
MMIO.

Failure to do an SDMA copy will result in a fallback to MM access.

Note: This is an attempt readdress patch request
'drm/amdgpu: extend ttm memory access to do sdma copies'
with the addition of restrictions and fallbacks.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 97 +++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 23fc57506a20..1cb984252f58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1741,6 +1741,91 @@ static void amdgpu_ttm_vram_mm_access(struct amdgpu_device *adev, loff_t pos,
 	}
 }
 
+/**
+ * amdgpu_ttm_access_memory_page_sdma - Read/write page of memory that backs a buffer object.
+ *
+ * @bo:  The buffer object to read/write
+ * @offset:  Offset into buffer object
+ * @buf:  Secondary buffer to write/read from
+ * @write:  true if writing
+ *
+ * This is used to access a page of VRAM that backs a buffer object via SDMA
+ * access for debugging purposes.
+ */
+static int amdgpu_ttm_access_memory_page_sdma(struct ttm_buffer_object *bo,
+					unsigned long offset, void *buf,
+					int write)
+{
+	struct amdgpu_bo *dst_bo, *abo = ttm_to_amdgpu_bo(bo);
+	struct amdgpu_device *adev = amdgpu_ttm_adev(abo->tbo.bdev);
+	struct ttm_operation_ctx ctx = {.interruptible = true};
+	struct amdgpu_copy_mem src, dst;
+	struct drm_gem_object *gobj;
+	struct dma_fence *fence;
+	struct page *dst_page;
+	struct ttm_tt *dst_ttm;
+	int ret;
+
+	/* Create an SG BO to dma map the target buffer for direct copy. */
+	ret = amdgpu_gem_object_create(adev, PAGE_SIZE, PAGE_SIZE, AMDGPU_GEM_DOMAIN_CPU,
+				0, ttm_bo_type_sg, NULL, &gobj);
+	if (ret)
+		return ret;
+
+	dst_bo = gem_to_amdgpu_bo(gobj);
+	dst_ttm = dst_bo->tbo.ttm;
+	dst_ttm->sg = kmalloc(sizeof(*dst_ttm->sg), GFP_KERNEL);
+	if (unlikely(!dst_ttm->sg)) {
+		ret = -ENOMEM;
+		goto free_bo;
+	}
+
+	dst_page = virt_to_page(buf);
+	ret = sg_alloc_table_from_pages(dst_ttm->sg, &dst_page, 1, 0,
+					1 << PAGE_SHIFT, GFP_KERNEL);
+	if (unlikely(ret))
+		goto free_sg;
+
+	ret = dma_map_sgtable(adev->dev, dst_ttm->sg, DMA_BIDIRECTIONAL, 0);
+	if (unlikely(ret))
+		goto release_sg;
+
+	drm_prime_sg_to_dma_addr_array(dst_ttm->sg, dst_ttm->dma_address, 1);
+
+	amdgpu_bo_placement_from_domain(dst_bo, AMDGPU_GEM_DOMAIN_GTT);
+	ret = ttm_bo_validate(&dst_bo->tbo, &dst_bo->placement, &ctx);
+	if (ret)
+		goto unmap_sg;
+
+	src.mem = bo->resource;
+	src.offset = offset;
+	dst.bo = &dst_bo->tbo;
+	dst.mem = dst.bo->resource;
+	dst.offset = 0;
+
+	/* Do the direct copy and wait for fence response. */
+	ret = amdgpu_ttm_copy_mem_to_mem(adev, write ? &dst : &src, write ? &src : &dst,
+					1 << PAGE_SHIFT, amdgpu_bo_encrypted(abo),
+					bo->base.resv, &fence);
+	if (!ret && fence) {
+		if (!dma_fence_wait_timeout(fence, false, adev->sdma_timeout))
+			ret = -ETIMEDOUT;
+
+		dma_fence_put(fence);
+	}
+
+unmap_sg:
+	dma_unmap_sgtable(adev->dev, dst_ttm->sg, DMA_BIDIRECTIONAL, 0);
+release_sg:
+	sg_free_table(dst_ttm->sg);
+free_sg:
+	kfree(dst_ttm->sg);
+	dst_ttm->sg = NULL;
+free_bo:
+	gobj->funcs->free(gobj);
+	return ret;
+}
+
 /**
  * amdgpu_ttm_access_memory - Read or Write memory that backs a buffer object.
  *
@@ -1765,7 +1850,19 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
 	if (bo->resource->mem_type != TTM_PL_VRAM)
 		return -EIO;
 
+	/*
+	 * Attempt SDMA access over non-visible VRAM first.
+	 * On failure, fall back to MMIO access.
+	 *
+	 * Restrict this to PAGE_SIZE access for PTRACED memory operations.
+	 * Any other access size should use MM access.
+	 */
 	amdgpu_res_first(bo->resource, offset, len, &cursor);
+	if (adev->gmc.visible_vram_size < cursor.start + len && len == PAGE_SIZE &&
+			!amdgpu_in_reset(adev) &&
+				!amdgpu_ttm_access_memory_page_sdma(bo, offset, buf, write))
+		return len;
+
 	while (cursor.remaining) {
 		size_t count, size = cursor.size;
 		loff_t pos = cursor.start;
-- 
2.25.1

