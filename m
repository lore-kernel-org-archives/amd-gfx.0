Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A321C10F1A
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 08:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D36511A27A;
	Thu, 25 Apr 2024 08:11:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c2Zzlnym";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FDC5113A89
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 11:41:54 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-41af6701806so5930275e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 04:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713958912; x=1714563712; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ELudIBLkjdgxS0elp1PUtkat+hOoPGI1SePmaBawDG4=;
 b=c2Zzlnymiz7GhpXUoMvkq1sThO7kz/P/ch5dcMn4uV9nf5CNK8igLpbz8xVns+zhFr
 CfNBEEUITypPt2iycGcJMQGQTF9rV7Tpra8HZbYwrjiy9EpuTuWhJHe2ErO83vRbetrh
 ErKmxRsZhJauukcoThs3P3EZZ9c4pFXlbAgqsrWQrpyG8MzV2Eo94MOOcxW3JNWcxkC7
 6KEpIKkmHn1CtwuiCL4TqCvuB/UURJ2wYtFkTm99OclOwR47Lll58+NZ7HVFsq1QFIAI
 3W0Ir7prmVjh0u06dcpGQrLo0NrsdSlcZT1+qd8Qc4f7Rpus5k0ahY4VmsJDxZgaqCJL
 RrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713958912; x=1714563712;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ELudIBLkjdgxS0elp1PUtkat+hOoPGI1SePmaBawDG4=;
 b=mGJYE2YboxOMsA8sAsnXl5OxvoHo9hjANJkH6QQ14lkuQ3iPqbe0QYce/4gO4v64nl
 VuCwLZUh6W+9NEL3IvFeBbn26t4zmd8MNawUl50GzrHFSzquhe+lLC/H3adydr51dels
 veX8L31ZfqyhE7PeWadLrr93QZz/5v2dMZvKSYLuQ+XV8BvnlebPvPj6uAN7sOnuqJjS
 GuwnjRZG0JxbD6I2GG2CpuFfM4NuFRmo0Qn8xp3koAsCpdZ5B5EYCl/wjN/cDODgk/d5
 Eu1HyN8slkJDyMDeVPkw3zwTS0exYIhIljpBXhvc9stMPI6mJFm8PGlS/wKoB7nLY4Ck
 5TDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeSrsMaYNgiQ6iLr7Lk1JG8u+1pcdpJX47DIATdHKSPDcXIcv/8NaLWsGWymubCWk++eKkpayl+NmQhJHtH7sEg4jVkFNptYqS5tGSPg==
X-Gm-Message-State: AOJu0Yz1o7jvkXhYfIoY5gzt/YeCSYmF4viFu8sv98IZqRYnU3W0itZI
 OF4xU0IUkTYPBonzNMM2Rywb6NNNfmiX2ysCHycE9mHNcru4luHIL5Qp4OajIs0=
X-Google-Smtp-Source: AGHT+IFC3Xn9CFwEPi+nZrUxwB85rOXzdnYEMUpkC1nwbPG2hnf4U7btQl9yxJcgwUfAxP5VTsmFNw==
X-Received: by 2002:a05:600c:450a:b0:41a:e5f5:9a4a with SMTP id
 t10-20020a05600c450a00b0041ae5f59a4amr1690065wmo.9.1713958912043; 
 Wed, 24 Apr 2024 04:41:52 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 h3-20020a05600c314300b0041abdaf8c6asm5404240wmo.13.2024.04.24.04.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 04:41:51 -0700 (PDT)
Date: Wed, 24 Apr 2024 14:41:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Harry Wentland <harry.wentland@amd.com>,
 Charlene Liu <charlene.liu@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alvin Lee <alvin.lee2@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 Jun Lei <jun.lei@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Dillon Varone <dillon.varone@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amd/display: re-indent dc_power_down_on_boot()
Message-ID: <e5f538ab-ebc8-400b-8104-4642b8089b4f@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Thu, 25 Apr 2024 08:11:24 +0000
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

These lines are indented too far.  Clean the whitespace.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8eefba757da4..f64d7229eb6c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5043,11 +5043,10 @@ void dc_interrupt_ack(struct dc *dc, enum dc_irq_source src)
 void dc_power_down_on_boot(struct dc *dc)
 {
 	if (dc->ctx->dce_environment != DCE_ENV_VIRTUAL_HW &&
-			dc->hwss.power_down_on_boot) {
-
-			if (dc->caps.ips_support)
-				dc_exit_ips_for_hw_access(dc);
+	    dc->hwss.power_down_on_boot) {
 
+		if (dc->caps.ips_support)
+			dc_exit_ips_for_hw_access(dc);
 		dc->hwss.power_down_on_boot(dc);
 	}
 }
-- 
2.43.0

