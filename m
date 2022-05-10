Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6818C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 11:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86E5810F4B7;
	Tue, 10 May 2022 11:36:53 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 674E810F81B
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 11:36:52 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 a14-20020a7bc1ce000000b00393fb52a386so1192543wmj.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 04:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ljK8W7qtz1Q4kYB8efmWIvbTYiW7stsIZKIpswwFLnU=;
 b=h48ce/3LhcwW+6kt3g3rJOD2FhXXdmYjIqzJhLUpsbHb6A9YEqAgNreuOLyDftDYR1
 yHda+VaD9UpoiP6kyHUy8vJEeNDkK43rsQpkSGzPkg+N2gGT5p+7Wo3yHhuqUSqNj2mM
 Bey/VoNztePXBf1LmZy69DXkJTZ8ZcNk9SKRmOvr5CRb6ItViZKCjuhmwou4CJaDN759
 n3kDToKEDjFaGkIN+/H5rQwQBHpUu3lPEq/A7OV/VPbsRqgWVDzPhywgChOaqLpzyWdF
 lpBlz0VlF5Irn+YyOVPb9bkCBCS9OCNs0i36EP62JHVSywou/LiacfbU3A3L7D9QroqG
 WgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ljK8W7qtz1Q4kYB8efmWIvbTYiW7stsIZKIpswwFLnU=;
 b=oASOYGCINqU+A9vdPy8YeIi2jk3f2V00tdcJv8tpQeyIPTqml2QjuPoZOw6Wy/gWbz
 9MKbAOWcmE5K80XnZ1vCe5Qza5Dw2zdwUK2q49oMMAYr1Up9BodxwT96rXetRaot8Aej
 2q5oJ3uz7RMj00hicGe1TfYoruHvbQKAdtJPK9TW157thSalHuyCnckuXWnungCC2P/N
 cJdRIMjNdxum8OUk6XvB+36b68nLG6YE0+Yjt/B3FDLDQiOFgr2Q80aTaCepYFaG3o1Y
 XaoxQ6UFCewmaQWN8MVFFWhARWPjIA9qsCzWjfR3Cr51JxGKD5ZLJWML+l0rpnwQuJhb
 Wenw==
X-Gm-Message-State: AOAM532qjLYznyyxweoMqxsIvgnS56GqpsLe7Hr2DNiurlMQSkm85SCn
 8oRBP66e8tvzcJTqxTtdYVoTovq7b0c=
X-Google-Smtp-Source: ABdhPJzhh3HgfSx2rNyBKJquyOEUi11FvIH3zhM2cf4pbdeOCZ/sCAuSTTd4adqv/A40KHTQFg8yuQ==
X-Received: by 2002:a05:600c:4346:b0:394:1a53:c8ba with SMTP id
 r6-20020a05600c434600b003941a53c8bamr27743310wme.173.1652182610871; 
 Tue, 10 May 2022 04:36:50 -0700 (PDT)
Received: from able.fritz.box (p57b0b3fd.dip0.t-ipconnect.de. [87.176.179.253])
 by smtp.gmail.com with ESMTPSA id
 g9-20020a1c4e09000000b003942a244ec1sm2308924wmh.6.2022.05.10.04.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 May 2022 04:36:50 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: arunpravin.paneerselvam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: fix start calculation in amdgpu_vram_mgr_new
Date: Tue, 10 May 2022 13:36:48 +0200
Message-Id: <20220510113649.879821-1-christian.koenig@amd.com>
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

We still need to calculate a virtual start address for the resource to
aid checking of it is visible or not.

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

