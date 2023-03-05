Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824BCC61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 08:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E190710E12F;
	Mon,  6 Mar 2023 08:28:13 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAEF510E047;
 Sun,  5 Mar 2023 05:22:00 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DC629B80924;
 Sun,  5 Mar 2023 05:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FF3C433D2;
 Sun,  5 Mar 2023 05:21:55 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>
Subject: [PATCH] drm/amdgpu: Use uncached ioremap() for LoongArch
Date: Sun,  5 Mar 2023 13:21:37 +0800
Message-Id: <20230305052137.4030323-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 06 Mar 2023 08:28:13 +0000
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
Cc: Xuefeng Li <lixuefeng@loongson.cn>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Huacai Chen <chenhuacai@loongson.cn>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

LoongArch maintains cache coherency in hardware, but its WUC attribute
(Weak-ordered UnCached, which is similar to WC) is out of the scope of
cache coherency machanism. This means WUC can only used for write-only
memory regions. So use uncached ioremap() for LoongArch in the amdgpu
driver.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index c5ef7f7bdc15..c6888a58819a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1750,8 +1750,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 
 	else
 #endif
+#ifdef CONFIG_LOONGARCH
+		adev->mman.aper_base_kaddr = ioremap(adev->gmc.aper_base,
+				adev->gmc.visible_vram_size);
+#else
 		adev->mman.aper_base_kaddr = ioremap_wc(adev->gmc.aper_base,
 				adev->gmc.visible_vram_size);
+#endif
 #endif
 
 	/*
-- 
2.39.1

