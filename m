Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E06C2BA83
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:19:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F720246C3
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+bbTb8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F720246C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B1E6FCF7;
	Fri,  7 Feb 2020 15:19:23 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AAAE6FCFB
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 15:19:21 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id b7so2511475qkl.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Feb 2020 07:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pES7Dzm9sSVh8UYtez+RnlymnaGVbXHhfy0cOL6/MR4=;
 b=W+bbTb8JJKerAf0wvk/+A9/gVYwYmsJ3NsleZ3524GsUG49tJihq8OnPZcDqoQFWHl
 ygbk4bkE4kNMNH8MrjqYphyRY3dkJ3ZgSaNSjlaYVtMKV6UI5xELu2ob8WkzZd8qwRcG
 LUj1kMEz5Qi7YaP7eQLWt/fO05merbarM8jWGv2QJMhRDcWYtFnXz8pJGt+iXoSIJ+pI
 G6eMjIor54/N4jAErKnhi+tDxoI55cIfObu5Yg/ig3GocHpEHzSlXSeutRpov88s0Qlu
 wc3rkOoFVuLgitWDSeNviDwq2CfOH0Oaby1i5kG2//Rw541rlDiCQZJNMZVboPyuheMM
 eFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pES7Dzm9sSVh8UYtez+RnlymnaGVbXHhfy0cOL6/MR4=;
 b=FjXu9zNfYW/gYctbJK68RdF0DRD27XsVH35aYlOVer36gTlyux+89QVALjiYXvUkjd
 BDQ6NBkB5sTZuB3W9sdQIEaYfHmHgTmbWZt7yNmCW3ECqT0vDjtTiGnQeM0Iojprdokf
 X9i3OcqxAA8O1XVj8bzoBwtkJ+vO/qz4m1rav4OjR9wOOetCBDgZoW41cwDrAk9AbJpc
 kt7tswXKc/uuWZ4zY4JJdTtsjAx3Bq8nsnlubLrIGSwWUDSxesuyJ/Rwbg8nBRA/fDFP
 3Hqp9TrrfhBPS3XBJyYy6Prq+kXhM/pbbMiKg7gi7JHqqsUIn1cbVx+ql/skKAJonl2i
 r6lA==
X-Gm-Message-State: APjAAAXFC/M+42C+2UzF0+oRIE9th/uwmHc+sKQFYIROmZqtZW97CPgs
 aouh3vYsVBbgs9w8zVRU1m/ds3Je
X-Google-Smtp-Source: APXvYqwbVJXSC2rlm7bdEcexNoJnUPr9By13yWEKZxqAbYU3CjOMOV0Fybg1Ab5jK8yOU0GWxF8VsQ==
X-Received: by 2002:a37:6897:: with SMTP id d145mr7595440qkc.398.1581088760278; 
 Fri, 07 Feb 2020 07:19:20 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id t29sm1445619qkt.36.2020.02.07.07.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 07:19:19 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu/powerplay: fix baco check for vega20
Date: Fri,  7 Feb 2020 10:18:42 -0500
Message-Id: <20200207151842.802638-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207151842.802638-1-alexander.deucher@amd.com>
References: <20200207151842.802638-1-alexander.deucher@amd.com>
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

We need to handle the runpm case as well as GPU reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index 3b3ec5666051..08b6ba39a6d7 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
@@ -487,15 +487,16 @@ static int vega20_setup_asic_task(struct pp_hwmgr *hwmgr)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
 	int ret = 0;
+	bool use_baco = (adev->in_gpu_reset &&
+			 (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
+		(adev->in_runpm && amdgpu_asic_supports_baco(adev));
 
 	ret = vega20_init_sclk_threshold(hwmgr);
 	PP_ASSERT_WITH_CODE(!ret,
 			"Failed to init sclk threshold!",
 			return ret);
 
-	if (adev->in_gpu_reset &&
-	    (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) {
-
+	if (use_baco) {
 		ret = vega20_baco_apply_vdci_flush_workaround(hwmgr);
 		if (ret)
 			pr_err("Failed to apply vega20 baco workaround!\n");
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
