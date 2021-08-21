Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99408C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 13:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B89B6126A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 13:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B89B6126A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E885A89D86;
	Mon, 23 Aug 2021 13:07:52 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7451B6EB4C;
 Sat, 21 Aug 2021 08:21:53 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id w5so25044730ejq.2;
 Sat, 21 Aug 2021 01:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DLNxIQ4b36nOK8YiQqh9tj6nRfmDkfjYUObbVW/rzuE=;
 b=Fr6EEYIqKzlYJL29Bk6kAN0wVc2ohjHDeSEBJJ3s89jdf/bzRME8wKYuaxRVpDvTSr
 Pa/dLXpP5vKCZaSha5zbjNYyynxqvwGWy2/6TlZmVK6YSIiD3oYytqubmQZfh7RpGovV
 6LYX4aOeXx5pavlsuD+yrLBrQQ4AyPo8SmrZMPzO9ViEAqDtNmRrzd90PMStPy608oEi
 1suZXYDqceKxL83xTQcSWZ+8QBWDy5Z/tilnWr4cUWTl8fbXU1cKmtrn/jY9Qd7WXrM9
 ZT6LwHr39F8K7aJSOtu91mjN+c28v96xOW93LJjj5mS6SpVDhXsbVP1rtCb99SNx39oy
 RVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DLNxIQ4b36nOK8YiQqh9tj6nRfmDkfjYUObbVW/rzuE=;
 b=ShKAHCLuoiBBg602BNYieSBOkk44dxH8H1d2BDuX4AOlKpGM7UQ6ZWrDqQHtEXOYGE
 EsokfwKZls34FshKdY1LAVo4UWKZCorUvgiVTMXqx5kE8V2JSAQuzXxrSUjK4AgQVmDf
 o7rgdBr5poxUuWXrs9GMBnOQ6ZGAI1/kyf8kA9cb8NSLCRUWX9Tz4zPF2kBPE5om4c9M
 PsNkDvxO5nHFUm9vrpzrZhIqSiBmwQFG0VOE4fyRbqKe9TzcGHpcXMCjS14lSzMlSNHl
 vzB8YxarhEHt3I/w2XF6LdXTeMgtK3o6IDk245wJ3CPVw9WDsJD65z3PzTdq49F7xy/F
 siqQ==
X-Gm-Message-State: AOAM5311wRrHdMmISqy/rmHZd9Vho11XXBqVshLHktjx+2NPxYXG3I5i
 XUJCS4ne4gqPIGopKEyeauoIOwemEMnIDg==
X-Google-Smtp-Source: ABdhPJxkIkynxwDeHi53+v+uOYVEfg0/kL1L316cPovUVthOvnCB/ud9O4FzhIVP8auxpcmvbFQzUA==
X-Received: by 2002:a17:907:2b09:: with SMTP id
 gc9mr26430452ejc.49.1629534112230; 
 Sat, 21 Aug 2021 01:21:52 -0700 (PDT)
Received: from robot.. ([2a02:2f0d:b800:ab00:6398:283c:6862:f51e])
 by smtp.gmail.com with ESMTPSA id r27sm4888327edb.66.2021.08.21.01.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Aug 2021 01:21:51 -0700 (PDT)
From: Liviu Cheru <liviucheru@gmail.com>
X-Google-Original-From: Liviu Cheru <liviu.cheru@gmail.com>
To: airlied@linux.ie
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 liviu.cheru@gmail.com
Subject: [PATCH] gpu: drm: amd: amdgpu: Fixed a few warnings
Date: Sat, 21 Aug 2021 11:21:41 +0300
Message-Id: <20210821082141.8608-1-liviu.cheru@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Aug 2021 13:07:52 +0000
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

Fixed warnings regarding SPDX license, using "unsigned" instead
of "unsigned int", wrong function parameter name for the
documentation and a space between the function name and "(".

Signed-off-by: Liviu Cheru <liviu.cheru@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 795fa7445abe..af1abb281c6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright 2009 Jerome Glisse.
  * All Rights Reserved.
@@ -129,7 +130,7 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 	u32 c = 0;
 
 	if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
-		unsigned visible_pfn = adev->gmc.visible_vram_size >> PAGE_SHIFT;
+		unsigned int visible_pfn = adev->gmc.visible_vram_size >> PAGE_SHIFT;
 
 		places[c].fpfn = 0;
 		places[c].lpfn = 0;
@@ -731,7 +732,7 @@ int amdgpu_bo_validate(struct amdgpu_bo *bo)
 /**
  * amdgpu_bo_add_to_shadow_list - add a BO to the shadow list
  *
- * @bo: BO that will be inserted into the shadow list
+ * @vmbo: BO that will be inserted into the shadow list
  *
  * Insert a BO to the shadow list.
  */
@@ -957,7 +958,7 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 		bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 	amdgpu_bo_placement_from_domain(bo, domain);
 	for (i = 0; i < bo->placement.num_placement; i++) {
-		unsigned fpfn, lpfn;
+		unsigned int fpfn, lpfn;
 
 		fpfn = min_offset >> PAGE_SHIFT;
 		lpfn = max_offset >> PAGE_SHIFT;
@@ -1175,7 +1176,7 @@ void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *bo, u64 *tiling_flags)
  * Returns:
  * 0 for success or a negative error code on failure.
  */
-int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void *metadata,
+int amdgpu_bo_set_metadata(struct amdgpu_bo *bo, void *metadata,
 			    uint32_t metadata_size, uint64_t flags)
 {
 	struct amdgpu_bo_user *ubo;
-- 
2.30.2

