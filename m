Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D448CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 13:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6239410F8B2;
	Thu, 14 Jul 2022 13:23:20 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F38F910E9FE
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 13:23:18 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id k30so2377270edk.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 06:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jjxoxmS5DvoidmwWcG7AW+9rJsz1oy8lI9ju8KewU8w=;
 b=ooPdS9uSGQBXbrdBMLoayIaqB20hiyF+97maLx53UQQwkYtUlybcamQLssrGpEB7ju
 FLWzTnowAM+z3yHus5OOp7o7+DY6y2k+g+h2K9hTPP/IHWkQMe1VzWPs1xSwB0WdwzAV
 5ikR7zKGP/AnrAJQJEWjRyNfE5E4rVQCG29h5HC9CttbKs0yg7fvI7czIldscIw9Kl9o
 ouXRgKyUVN78i2/a1SSgasewmW4asseGZWOcvzlVdIgboIKBxIN4Kh2Rnt3s/7Ybq6Sl
 F3TqZLv07FSPQGoDiV10W1l85CW6iT30Vpx0uwxsKKWOkFIwlYssD4IV0liMg1SgDlYW
 m/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jjxoxmS5DvoidmwWcG7AW+9rJsz1oy8lI9ju8KewU8w=;
 b=T8U5ivtfdkg0QiTRzmhzE4qmk/7TzYDwrh4E8ez9RhVSmIyIsVqvAOIyZh1Gv8YlVM
 iDLVFspIA5tQpzOPo9GVj3luprZLIRtBl0hijwdSkcuujgVBz3Yk6yT8OLRfR/HjEBzR
 IlGgF99CbDjl69Qbmh5cn50igK8M2hDU0rOkLma6tWJDEDyiNseteGhzS2iT2UpKkHDS
 hzLiVo2kTpxJLGIZBHGR8n7V+3MRnYrUOPYwp2Zkw9IPj/Z/xaM8e+/kWDCKmiogV4l7
 tdDjCFgsBuXvaIcZ3QRGxJ2YG3+x/tC2KtgWIzh0kRLDsJzchQ0KaQBrknKoYe5U0XtA
 qKjQ==
X-Gm-Message-State: AJIora/pGJQ69Nxh4TRn1qBwdKvj/oBjGbjbFti1VD5XPlqlBkX0MCHd
 R39o/NWKj5oqVA5JNn/6ZqJC5WqHdGw=
X-Google-Smtp-Source: AGRyM1siI1xRZEQms5GOzY5nP8/P6bpX3VmliwVMfrseW12OtzPPbT/2QCyk0h/hh8F1u010mTSprQ==
X-Received: by 2002:aa7:d60a:0:b0:43a:5795:b729 with SMTP id
 c10-20020aa7d60a000000b0043a5795b729mr12441805edr.230.1657804997456; 
 Thu, 14 Jul 2022 06:23:17 -0700 (PDT)
Received: from EliteBook.fritz.box (p57b0bd9f.dip0.t-ipconnect.de.
 [87.176.189.159]) by smtp.gmail.com with ESMTPSA id
 ek9-20020a056402370900b0042de3d661d2sm1035399edb.1.2022.07.14.06.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Jul 2022 06:23:16 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Arunpravin.PaneerSelvam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: reapply "fix start calculation in
 amdgpu_vram_mgr_new""
Date: Thu, 14 Jul 2022 15:23:14 +0200
Message-Id: <20220714132315.587217-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This re-applys commit 5e3f1e7729ec7a99e145e9d8ed58963d86cdfb98.

The original problem this was reverted for was found and the correct fix
will be merged to drm-misc-next-fixes.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 22 +++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 49e4092f447f..51d9d3a4456c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -496,16 +496,22 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 			list_splice_tail(trim_list, &vres->blocks);
 	}
 
-	list_for_each_entry(block, &vres->blocks, link)
-		vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
+	vres->base.start = 0;
+	list_for_each_entry(block, &vres->blocks, link) {
+		unsigned long start;
 
-	block = amdgpu_vram_mgr_first_block(&vres->blocks);
-	if (!block) {
-		r = -EINVAL;
-		goto error_fini;
-	}
+		start = amdgpu_vram_mgr_block_start(block) +
+			amdgpu_vram_mgr_block_size(block);
+		start >>= PAGE_SHIFT;
 
-	vres->base.start = amdgpu_vram_mgr_block_start(block) >> PAGE_SHIFT;
+		if (start > vres->base.num_pages)
+			start -= vres->base.num_pages;
+		else
+			start = 0;
+		vres->base.start = max(vres->base.start, start);
+
+		vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
+	}
 
 	if (amdgpu_is_vram_mgr_blocks_contiguous(&vres->blocks))
 		vres->base.placement |= TTM_PL_FLAG_CONTIGUOUS;
-- 
2.25.1

