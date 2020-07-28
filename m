Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90A5C433F4
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 22:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCBB4207E8
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 22:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOf/aa/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCBB4207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14EF26E439;
	Tue, 28 Jul 2020 22:46:45 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0CC26E432
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 22:46:41 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id x69so20465932qkb.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 15:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wAB7zG/9/MLCHUP6Mimawgkxs5Yp4U5nVAU+M5k6Tbo=;
 b=JOf/aa/jYBaW2oBz37sIruTp/FMI60Vn85/BNDxK23JHg/BXllkIG9myK5GIq/byJm
 UgNFAdDozFJ7W6nZsn83kh/UDg9P37wAt+i+DvJCpKwgKOGCUaYj25wxB6+0Xf/CGyZT
 vZFF2t3eQSg6kit3/614VTtq1LEYgXddrkq5d38J5E4oyY+5kAPYJl1V3gQ7yah1dDz/
 A7lTvQf/YdMffvRoOGF1u4jXET9pJGCfs4xyxSzf1VnGDWWYI9OLvTvLdq6rxDVDGOSh
 MP+C1aaHEpgegGQUy2V4v360ZwbGYEQmNK7cO23RpFWewnVdC7mI53PIL18P0WqU41Q2
 sLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wAB7zG/9/MLCHUP6Mimawgkxs5Yp4U5nVAU+M5k6Tbo=;
 b=BAqAFL48wSG7wIu+V4omPyUj2eAVuKqgLwnO3pQs2juBXvuW92VlpRXevxfDCtpCbp
 v/S3Yrw+RyNTBuIW6xbqd/zZ/l3rFwUCe33eSNo0jy6nRyZ72rXkmgUnjh6BD2T4b9De
 qHDCsKbPtgE1i9IMGzmDdbAwr1zWw/0QYdYtr1+ak241LKFeV5NJht+IpFVPz6PBzUiO
 gq+Iik4Oh6j9S/SOLAjgXMHgz3SKaWvZzrsknc8PVdOCb+lrwnJWn/2nNcf/zOX6XX3m
 9KouM5AAAV2t8rG/Inq83wX5ohkOJanPHe7Rmsh1flZ8eSkrVlE1Fnt0K1zV9WwO+sFX
 XtcA==
X-Gm-Message-State: AOAM5322/B8RvWZ939wb9zUe8J/vNqasYUvYk2rmcoUDXqgv5c3dno0K
 tMdjulDiU7sVkq4v8fH73Jdez6gM
X-Google-Smtp-Source: ABdhPJwVJolWTw7E6urljUxxfp8LsPkxW4CoKt40EKDG0y6LnOAxrgbI4u3kg4uiJv0qBkhhAsxGqA==
X-Received: by 2002:a37:5cc5:: with SMTP id
 q188mr15248465qkb.347.1595976400881; 
 Tue, 28 Jul 2020 15:46:40 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id o17sm189233qtr.13.2020.07.28.15.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 15:46:40 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/14] drm/amdgpu/gmc8: switch to using
 amdgpu_gmc_get_vbios_allocations
Date: Tue, 28 Jul 2020 18:46:01 -0400
Message-Id: <20200728224605.3919-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200728224605.3919-1-alexander.deucher@amd.com>
References: <20200728224605.3919-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The new helper centralizes the logic in one place.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 8e3763ec268f..9ab65ca7df77 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1094,9 +1094,7 @@ static unsigned gmc_v8_0_get_vbios_fb_size(struct amdgpu_device *adev)
 			REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_WIDTH) *
 			4);
 	}
-	/* return 0 if the pre-OS buffer uses up most of vram */
-	if ((adev->gmc.real_vram_size - size) < (8 * 1024 * 1024))
-		return 0;
+
 	return size;
 }
 
@@ -1160,7 +1158,7 @@ static int gmc_v8_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	adev->gmc.stolen_vga_size = gmc_v8_0_get_vbios_fb_size(adev);
+	amdgpu_gmc_get_vbios_allocations(adev);
 
 	/* Memory manager */
 	r = amdgpu_bo_init(adev);
@@ -1739,7 +1737,8 @@ static const struct amdgpu_gmc_funcs gmc_v8_0_gmc_funcs = {
 	.emit_pasid_mapping = gmc_v8_0_emit_pasid_mapping,
 	.set_prt = gmc_v8_0_set_prt,
 	.get_vm_pde = gmc_v8_0_get_vm_pde,
-	.get_vm_pte = gmc_v8_0_get_vm_pte
+	.get_vm_pte = gmc_v8_0_get_vm_pte,
+	.get_vbios_fb_size = gmc_v8_0_get_vbios_fb_size,
 };
 
 static const struct amdgpu_irq_src_funcs gmc_v8_0_irq_funcs = {
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
