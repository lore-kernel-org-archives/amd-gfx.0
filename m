Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B80C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 17:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F224207F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 17:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARyz644W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F224207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E786B6E5C0;
	Wed, 29 Jul 2020 17:34:54 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 845B26E5BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 17:34:53 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id s15so6790701qvv.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 10:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lz7dW/1kK0V3gbWbqa5AaOYossl9+WMU7HM6RMMbuio=;
 b=ARyz644W4ba4nqeXu7IHqMPfbuzbJ14+dY9+RuIz74VNkBGVgTWKad9utZACV249Xh
 OXNsSF83AzEVfqG6HLrAcV688DEIVIGEaRLXpBcMc4K3xd0WgsbHpYOCFOfdTbP8NqHC
 hpYXYifZ1SvleujVfDeDQYEDLl9Ii71rX1bMfjUEFh+kqwOAe8E08rhkpbylsfKAz6E6
 FQVGq12zi+WPFzR6t5jo+wuWvFXAf1PUmyUp9ICuvNhpoH8OeIWb/qPvervyulfZY1hb
 XW4aXUBcTBfckVAenqnLosEyQ+p1nDiM9mDgR95/OE9lACOjg1CfSMxS03nluZC3KeEx
 R5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lz7dW/1kK0V3gbWbqa5AaOYossl9+WMU7HM6RMMbuio=;
 b=GxXjVUH6OQLFIGTBfj+RH2Ozhi1pjrcFzebEYHcNkmONVKLwAS78LHyqkh89AfOBQY
 IN5XJTxDSsuBFe2LklhbM7DyjfLi7XMEVee3B0fgKEU7e37UVW9udK4Dw7l4IPprVOz8
 gdCEnpxJIN38PZks26ey1sMsKddEr3CzowdmzGfoRimMlS+BW/PT691AahVy/PhjTPYP
 GMJwDo9ZUlhIuRmRnNFcGEw30pIpG780Zl4rQCuM1U/4AB1w2uz82StpQJCReMpngO2L
 TDXjBubB6q8UsydpH9ncAwKSCyniqWDcBtXgYYMgWvz5lyJTW5XM5TLqWtFC7hynGq//
 tsBA==
X-Gm-Message-State: AOAM531vl6gW0mE7Kvtf0/wim1gikp8JPGvePQifQp8bv0YIeNUuv0gz
 g6vKf5szc0hRLv1ozE1h9+dwP0Tz
X-Google-Smtp-Source: ABdhPJzT3jHR+G6P8XaBwK5VdH3l0h4jEOrVeD4MpI8PsK2BPrFtpDt8XnShDlyooAAAfku/c3ki2w==
X-Received: by 2002:a05:6214:a0a:: with SMTP id
 dw10mr34576279qvb.200.1596044092469; 
 Wed, 29 Jul 2020 10:34:52 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id z72sm2132956qka.107.2020.07.29.10.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 10:34:51 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/17] drm/amdgpu: add support for extended stolen vga memory
Date: Wed, 29 Jul 2020 13:34:28 -0400
Message-Id: <20200729173439.3698-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200729173439.3698-1-alexander.deucher@amd.com>
References: <20200729173439.3698-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This will allow us to split the allocation for systems
where we have to keep the stolen memory around to avoid
S3 issues.  This way we don't waste as much memory and
still avoid any screen artifacts during the bios to
driver transition.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 13 +++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 0cf18f01e67a..8f4af955d72c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -215,6 +215,8 @@ struct amdgpu_gmc {
 	bool			prt_warning;
 	uint64_t		stolen_vga_size;
 	struct amdgpu_bo	*stolen_vga_memory;
+	uint64_t		stolen_extended_size;
+	struct amdgpu_bo	*stolen_extended_memory;
 	bool			keep_stolen_vga_memory;
 	uint32_t		sdpif_register;
 	/* apertures */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index fd61769202b3..ec975251b171 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1915,7 +1915,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	uint64_t gtt_size;
 	int r;
 	u64 vis_vram_limit;
-	void *stolen_vga_buf;
+	void *stolen_vga_buf, *stolen_extended_buf;
 
 	mutex_init(&adev->mman.gtt_window_lock);
 
@@ -1985,6 +1985,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 				       &stolen_vga_buf);
 	if (r)
 		return r;
+	r = amdgpu_bo_create_kernel_at(adev, adev->gmc.stolen_vga_size,
+				       adev->gmc.stolen_extended_size,
+				       AMDGPU_GEM_DOMAIN_VRAM,
+				       &adev->gmc.stolen_extended_memory,
+				       &stolen_extended_buf);
+	if (r)
+		return r;
 
 	DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
 		 (unsigned) (adev->gmc.real_vram_size / (1024 * 1024)));
@@ -2041,11 +2048,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
  */
 void amdgpu_ttm_late_init(struct amdgpu_device *adev)
 {
-	void *stolen_vga_buf;
+	void *stolen_vga_buf, *stolen_extended_buf;
 
 	/* return the VGA stolen memory (if any) back to VRAM */
 	if (!adev->gmc.keep_stolen_vga_memory)
 		amdgpu_bo_free_kernel(&adev->gmc.stolen_vga_memory, NULL, &stolen_vga_buf);
+	amdgpu_bo_free_kernel(&adev->gmc.stolen_extended_memory, NULL,
+			      &stolen_extended_buf);
 }
 
 /**
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
