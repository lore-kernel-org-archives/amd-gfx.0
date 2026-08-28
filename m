Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4732FC61DB9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 12:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD3F510F370;
	Fri, 28 Aug 2026 12:07:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fupafl3S";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5347B10F371
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 12:07:41 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c2544ff970dso118944666b.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 05:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787918860; x=1788523660; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ijqRJJu+ZUGUDeLGZkUidBGehvRgsqeJd0qsuVn1RyY=;
 b=Fupafl3SnCchTB4Jh20nbUrqKWSA7MWdOwMdjkJjCupmjtgbKehDZbydIgeAlMv1MU
 5S2WD6S76bWFBGUGxIGCF97D62gFOOBz2YQDlba+z06LvbEnTY5PptIX9BwsFsm1tjou
 dH6hGM84+fBgRQxcG5fgGMViulYSPDPEIb9z/AQz8czob1jj9lh+7/NxlErsBYywTIVh
 OUTdNnq7MoSJcCyYTrxTOaYBxuL2WYpQ+fFXR3URdLCZkwFc01FVjlSmlmhzigiAcab2
 wN3zNgjC46K7aI9zea3LaKQLp0q3u0K529LRAQRxaMIk3ryPNFjNOAcXfqdBuAy4XCeS
 fBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787918860; x=1788523660;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ijqRJJu+ZUGUDeLGZkUidBGehvRgsqeJd0qsuVn1RyY=;
 b=H8DFwDGv/CgXTGSp6KJ7Igvop0jvn6GBO3X3a1y18IQFdF4wfADjzYwkCuGIYMKi2Q
 6SWv1n3eaL407YBauvHk0a+NAYixKP7qGQEAB+Cdjc5G0QtZ4bg1nW6PsXLVY4CKVix8
 QLfcNakQMO0VaDBQDbZMheXNR5hdi/Gy3378ZArEWYlcQFFlgcoKP3bqYNQbP+Mct120
 /c7c/OQhOMqWx/rBo8bkzwSyNuaHrc6+hn5NxGpUl09Z42Q3kblwWkWkoyXeBVHtwEwx
 Jk5CrZAqK1iCbBNMFqj37tJceGhvH7s9svuzbPHCvseTaiJFjLSlmU3cUCXQWphnRjbT
 A7sw==
X-Gm-Message-State: AFuF++nk+q13o7CcBjIyn0BLvzo5d4E/hsy7VWJTijGVtVSKg/lWyBKC
 sStpwgmbHyFVzTCA9hoIfWdEgeYgDS5OUJibfnqJq+qYQPcwTW9YbvkyO29sk81r
X-Gm-Gg: AR+sD10OpM6imBT2CvNnOgzAiX+t81rF2/O2LMNG5tJ9k40vsZaXIthhWVnZxr1YpFF
 4Or6TkVetpa5ZGaXXImttD0afhyl68T4dego4BN2Xr6mEhG1IMR4le98txIYsnA6gyNUnGF1yCn
 dgYp+YCMPFB9F3eAFWM5Cw55UyoqyJ9TkKSt0WPoQM9DSfsjYbO1V8OoTBlzr6JQMBvSoJL0cBu
 Ik6a11fgZ+6wvDW0somMn4n+lh2se/wCGkYPTt5jOjt4/VdfulwMJT8Da7axUqyDiFP4lhiPN6m
 UG3Q3+dJSoMIzk8LJDmEuvuughQV35xl7l+RGoefPKd0uEQxhdsUjJhHIURxs01xEfCqdTWZC7T
 oEx42ecaDATJZ0DqO2fBK0suo4Lia19x1RpeBsR1z9symvG3Pvi8t0iUr+fq41ZIFPOl630gBE3
 nuEYG4D5qOWQF8nHa5eSN92iZkXkeGyuSpyhaH//Tcev387sC9pOi1y7R4z4tB/lgAsm79zUG7O
 HLbaXeYdGf+B9nNAa1wsNxq
X-Received: by 2002:a17:907:9b8c:b0:c20:fda7:1856 with SMTP id
 a640c23a62f3a-c2556c42933mr483764466b.8.1787918859293; 
 Fri, 28 Aug 2026 05:07:39 -0700 (PDT)
Received: from Timur-Hyperion (5E1B9A5E.dsl.pool.telekom.hu. [94.27.154.94])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255f29a9dfsm75364066b.63.2026.08.28.05.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 05:07:38 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/5] drm/amdgpu/sdma: Use common SDMA legacy queue reset on
 SDMA v4.4.2
Date: Fri, 28 Aug 2026 14:07:28 +0200
Message-ID: <20260828120729.25908-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828120729.25908-1-timur.kristof@gmail.com>
References: <20260828120729.25908-1-timur.kristof@gmail.com>
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

Besides sharing code, this additionally adds support for
restoring queue contents after the reset.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 72ea9db939b4..023821848531 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1655,20 +1655,6 @@ static bool sdma_v4_4_2_is_queue_selected(struct amdgpu_device *adev, uint32_t i
 	return (context_status & SDMA_GFX_CONTEXT_STATUS__SELECTED_MASK) != 0;
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
-	r = amdgpu_sdma_reset_engine(adev, id, false);
-	amdgpu_amdkfd_resume(adev, true);
-	return r;
-}
-
 static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -2133,7 +2119,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
-	.reset = sdma_v4_4_2_reset_queue,
+	.reset = amdgpu_sdma_reset_queue_legacy,
 };
 
 static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
@@ -2165,7 +2151,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
 	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
-	.reset = sdma_v4_4_2_reset_queue,
+	.reset = amdgpu_sdma_reset_queue_legacy,
 };
 
 static void sdma_v4_4_2_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.55.0

