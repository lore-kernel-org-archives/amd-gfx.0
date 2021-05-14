Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E50C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 13:47:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D80A6144C
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 13:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D80A6144C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D11F6EE85;
	Fri, 14 May 2021 13:47:31 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F5116EE0E;
 Fri, 14 May 2021 06:40:16 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B12661447;
 Fri, 14 May 2021 06:40:13 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>
Subject: [PATCH] drm/amdgpu: Fix GPU TLB update error when PAGE_SIZE >
 AMDGPU_PAGE_SIZE
Date: Fri, 14 May 2021 14:40:39 +0800
Message-Id: <20210514064039.1300558-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 14 May 2021 13:47:28 +0000
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
Cc: Yi Li <liyi@loongson.cn>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yi Li <liyi@loongson.cn>

When PAGE_SIZE is larger than AMDGPU_PAGE_SIZE, the number of GPU TLB
entries which need to update in amdgpu_map_buffer() should be multiplied
by AMDGPU_GPU_PAGES_IN_CPU_PAGE (PAGE_SIZE / AMDGPU_PAGE_SIZE).

Signed-off-by: Yi Li <liyi@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 3bef0432cac2..a376a993e474 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -225,7 +225,7 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
 	*addr += mm_cur->start & ~PAGE_MASK;
 
 	num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
-	num_bytes = num_pages * 8;
+	num_bytes = num_pages * 8 * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
 
 	r = amdgpu_job_alloc_with_ib(adev, num_dw * 4 + num_bytes,
 				     AMDGPU_IB_POOL_DELAYED, &job);
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
