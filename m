Return-Path: <SRS0=bavc=6T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90ABC47254
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 14:30:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75F65206A5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 14:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3giufVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F65206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4056289CC1;
	Tue,  5 May 2020 14:30:21 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C4EE89CC1
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2020 14:30:20 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id fb4so1061876qvb.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 May 2020 07:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PIoM2uL8A4Uh4CHUrXMCs6xlTekZ0buffPHKViZhjm0=;
 b=A3giufVDKn8OtlnQ/A+cCnz/DeFu2x37uvgq37kzzYWSvptblClLfloX4PfOTxcQGk
 XX50vaOIPIhu2unRqW07CcC3E7Fudb+2TfHX6JQ5oZKWP4Oj1+8DlFD8IKpwzYUjvqv2
 oFWbjTyqmAKfbJ3mWPbHBquch852WaDtx4raFNyiE4vmAwXUkTV6tUchQXSl9YUc8etn
 ZI0nR0ya+rzLhTByIIywIXZTT67QauN903BGtIPA6C6Eux6hWDYvLGgRR1OJgUbVn9cv
 7nL/PpZ/DrkxNqN3aC8ibRyyH1uyL5bqEvLZwejUluHUCxiDzM7XX7+WviCkDOl8Ku8k
 avGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PIoM2uL8A4Uh4CHUrXMCs6xlTekZ0buffPHKViZhjm0=;
 b=rWmyMrxtTCEOcJJ+NE+W4gp4IpJSdVTVKisuUzC4FyhzwARVHjSE07dlfxGXfw5OM9
 Y6PsYnJECl752gg3ASvUb/AgffQRQGEzs9XEyZsWtZb0lef+l9RVh4yAj0rINA/B0bCx
 HJg2SkOfJcerFRNOf5pyh6Dakd98eokwIsglBINpQ4ireRGbqKRc9wGmoO37SAaxHzH1
 PiPhYTeZTvVSeGT3DtUyip2R2zMPAR0LIqw37RBNr9iYzJGe56HfvjoTpoyr3BWsxepT
 i2kGPwkzW+REEr/v8Pnjtj7N7ck4iD5vYqDZVF63Yx47/9miHoetJtnKd9cQUSJ7Ioar
 bUuw==
X-Gm-Message-State: AGi0PuaXIvpNtnbrbicyP/jsWbgPjiF8OHeiX4zsfYXAyKELsCIrFhUe
 JQHf4Kh18nLJgCyDizHzo4TFhrN4
X-Google-Smtp-Source: APiQypIuF7Pau9a3z7neTRLRQAn+Sm5pEQ/aNksYvJgwIkO9B6HeeDhgooZfVhX6sHl17iSAKWd+4Q==
X-Received: by 2002:a0c:eb50:: with SMTP id c16mr2833570qvq.151.1588689018978; 
 Tue, 05 May 2020 07:30:18 -0700 (PDT)
Received: from localhost.localdomain ([71.219.37.167])
 by smtp.gmail.com with ESMTPSA id o68sm1855740qka.110.2020.05.05.07.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 07:30:18 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/fb: use virt_to_phys to get smem_start
Date: Tue,  5 May 2020 10:30:06 -0400
Message-Id: <20200505143006.5608-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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

We set the fb smem pointer to the offset into the BAR which doesn't
handle framebuffers in system memory. Use virt_to_phys which should
handle both BARs and system memory.

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=207581
Fixes: 6c8d74caa2fa33 ("drm/amdgpu: Enable scatter gather display support")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
index 25ddb482466a..caef156fbd1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
@@ -205,7 +205,6 @@ static int amdgpufb_create(struct drm_fb_helper *helper,
 	struct drm_gem_object *gobj = NULL;
 	struct amdgpu_bo *abo = NULL;
 	int ret;
-	unsigned long tmp;
 
 	mode_cmd.width = sizes->surface_width;
 	mode_cmd.height = sizes->surface_height;
@@ -245,8 +244,7 @@ static int amdgpufb_create(struct drm_fb_helper *helper,
 
 	info->fbops = &amdgpufb_ops;
 
-	tmp = amdgpu_bo_gpu_offset(abo) - adev->gmc.vram_start;
-	info->fix.smem_start = adev->gmc.aper_base + tmp;
+	info->fix.smem_start = virt_to_phys(amdgpu_bo_kptr(abo));
 	info->fix.smem_len = amdgpu_bo_size(abo);
 	info->screen_base = amdgpu_bo_kptr(abo);
 	info->screen_size = amdgpu_bo_size(abo);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
