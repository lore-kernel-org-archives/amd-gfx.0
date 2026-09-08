Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5CAC79F9E
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 18:11:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C228010ED13;
	Tue,  8 Sep 2026 18:11:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AvwQ3ZfR";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B258410ED13
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 18:11:24 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-49b8687630fso42346075e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Sep 2026 11:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788891083; x=1789495883; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uP0h08cJg0UNU8c9ugw0e491cNAE70S7nyPdBugFBkQ=;
 b=AvwQ3ZfR7rdJeOAvvzgtxhBdI4VrxxCdw1kJJ4IF7KxlLCen/5W564YTeNfqzskjVB
 H3eRYZmuOzn58eJEGu93VdEU+1r1xv4pEOzi01TvPiV2ThI55gNwYfOH7G983MPy7oCd
 uRdvFP7+suWjAU7c36G2iW8EPyc3IFG+Lj0unF+MFec5sL8OaW3yfpORs/rLUliCtrH3
 4vzFlJq8ALdwzPYcuLv6RCD4neJLeHNxMarfy0hJJtwLlUZKFOXmHLSN+YjcWi1siZJ3
 cady8/Yj6FS3aZHnCSA3Jv9ttDUXQ3Jp8AIdPpvI1FdcsTtxRnuR5zFee4VoDUZ+TWAO
 ocVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788891083; x=1789495883;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uP0h08cJg0UNU8c9ugw0e491cNAE70S7nyPdBugFBkQ=;
 b=hD6DBpg2ZtvFm3gOM4vD+cVbY5FEVY85xZ0PHze8IR3B0wcp6lRlt+evNwlHQju9yK
 Lthho8P6LcSeYmvxqm4s2UV3Wd5eoNvWkXTg72tRQ0Xb4DFbmHRVXz7/AJlocti2vCfz
 7QdijZ3LoHnpM/qT6hxIP9j+bZga7yA/y5Mi1ErzzkVHgyrjolwKiouD+iSjoJpbZY15
 j6x3O7ypf1f7ugjJPzcAX/ENwrqWgnGTYHhajd3PqyTLQuQk2r/Gr/kLHzNs+obAlBmG
 xWNxv66s5a+g7i7D1mAYNbxEEdwl+F5yJvKOZrZvEukZ5LIxM5kinHYIBCONnPqmQh4i
 w8fQ==
X-Gm-Message-State: AFuF++kBElntDmWrc1IjbuwFymMGNMs+M1u7MKCA6piX8NIWGBqYTQhS
 wK3eZyaXlUqueGrut+B+JdAa6jzaZn1TCKmCpthD+24KISqWv2uMx0oylX1IjEyY
X-Gm-Gg: AYBFou3Jy0koma7d8xXxE4qpHHgtGWMS69ZIfklmQV6iYmrWc2jKhsVSxkLSQkkMnPv
 +RBUaoqOJESGil0porRGNyao9ZdwQIhSXXZTcyUCV95bPvGv98pvFmD/SOdZpJbs9EMUALPfqX9
 GUeRSh8h9AKKyffqdJxglwa0V2BU6EhPdpNUYaVPzHGu5VlGfmjzRqCMiR6//toPSexAywcSBKe
 bqqITqP5v9NYRmQWoOJmMPpuVA5ORPQqbE36GtK5zMBzMxAW9JybaFS2hLhJWxZpcambk6bHBPD
 4GlYYKwAvY9s6hOmqmBAB00hFWq1WYDSDQnbup9gavpn1sPQwc4+C9UYZeeuk3Qqp0NyNHu+U8d
 pPjCAvDb//qQOIUEGZ19mkhYOCCOxoe8lWREwet7gqts/cu/eMVl9zeCom9hKD9b+7QPyb9kNdl
 KJrlmEvMN+qI0ueSGqxn1SVAhjq7V8rcjXvwRDiD3Kg4PZ5qVrHmp8YsJumpdYF4UigC1Ik65FO
 +mdvPRUdL/nb10IoOEy
X-Received: by 2002:a05:600c:6819:b0:49c:de80:b833 with SMTP id
 5b1f17b1804b1-49cf81fb1acmr292242325e9.2.1788891082937; 
 Tue, 08 Sep 2026 11:11:22 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d1fb1e4e4sm5190125e9.2.2026.09.08.11.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 11:11:22 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 9/9] drm/amdgpu/sdma: Use common SDMA legacy queue reset on
 SDMA v4.4.2
Date: Tue,  8 Sep 2026 20:10:52 +0200
Message-ID: <20260908181052.381126-10-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908181052.381126-1-timur.kristof@gmail.com>
References: <20260908181052.381126-1-timur.kristof@gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Now, sdma_v4_4_2_reset_queue() does basically the same
as amdgpu_sdma_reset_queue_legacy() so let's use that.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 4a1e941cfe2b..738341e889aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1579,20 +1579,6 @@ static int sdma_v4_4_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
-				   unsigned int vmid,
-				   struct amdgpu_fence *timedout_fence)
-{
-	struct amdgpu_device *adev = ring->adev;
-	u32 id = ring->me;
-	int r;
-
-	amdgpu_amdkfd_suspend(adev, true);
-	r = amdgpu_sdma_reset_engine(adev, id);
-	amdgpu_amdkfd_resume(adev, true);
-	return r;
-}
-
 static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -2036,7 +2022,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
-	.reset = sdma_v4_4_2_reset_queue,
+	.reset = amdgpu_sdma_reset_queue_legacy,
 };
 
 static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
@@ -2068,7 +2054,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
 	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
-	.reset = sdma_v4_4_2_reset_queue,
+	.reset = amdgpu_sdma_reset_queue_legacy,
 };
 
 static void sdma_v4_4_2_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.55.0

