Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2ECCC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 13:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E4C811A43C;
	Thu, 25 Apr 2024 13:04:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cqPdFADT";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B396110FBDD
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 11:21:29 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4155819f710so6691165e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 04:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714044088; x=1714648888; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cXBdVhclN8iRuqar3CwvdUJWpfJdsgIEIzFUbTS5W/4=;
 b=cqPdFADT48HyK7R3ukI+2zSIw1OjCPjHfnvtcX30aKo1YRNsCmeglL/l7hRJ70rdfC
 HY263e7L354fDbj9JdeuJguwV3MNozr/ilX8YPq4hu/sVHzZ1iXecRgho+i/sgUMd3ad
 oID4dar2SXNCOTv149e1UsClU00pBfjMIrzsIHpfyFT6ez2LCp8MAjQJsph01ykk62bl
 psbwuPSn9/lTD5J5UMfNK3WjChDqAeX2/tIrZtXeg7oHu3pHoYJ2RkEaMhLZvDZ8TTEz
 L9a4b/xaM94VoSWV5jtbY23cqbkznjaA+yURRFjPYsoe3Kq1Ififm+mjJJPeS110A3oX
 8QDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714044088; x=1714648888;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cXBdVhclN8iRuqar3CwvdUJWpfJdsgIEIzFUbTS5W/4=;
 b=spU3K6QCvAt0+/d84iDQGnOrUUra36M9Ndi7IanNK39SA0JDiPrVgHbWUSTI5UkOKx
 LrSVP6tbRPRXZuitHhACjJGYwR5wig9AGE6YSWyCCTa5eIJPJiM19UA4ApWxsGf1r3h3
 B2uwJbwQAB4V9ns/eSy+88kHSELGULMuKDAdrYBk5qAvpeFLFbwanMjDcIrICWIilk3N
 xQzRcnb1sIZGZlX+7Bo6M+ZMTxedS7bIrwBscM//K2eWTXHPCwYmbPRuBuP1jXoRkjX/
 Uyp4IqwJ/t8joi8I2fq/dp+HjwXvXIV/EG2V5bs4/9qxZjdQjXRc8YF+AKhCeKtwYMuW
 8r1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVODopH2RzovzB7WuX3io4zdNjzfBRYVNauqUNB2w7HGoXP/pVpvxWEhEVE6CD4IvcJHJxcR4/aSSekASi4wm/DtYgAydwK93UmLcow6A==
X-Gm-Message-State: AOJu0YyIcNA8U3hQxmyM+4O828B+q0JMwKp2BmEd9/NWVFd2eMFahteS
 RB2g0chZLYAjO+lZUoGfMlbNBoGfW42oE8/Xvo1OK3qsbutyPIOv6lWD1OSinpo=
X-Google-Smtp-Source: AGHT+IEkRzF902REA9b5+gdCdVfVhX1mEE+4IWBK9dgathGvN8Vw5Fx6OzS2pvtmCTAMrqcKfcYtzA==
X-Received: by 2002:a05:600c:470d:b0:418:5e80:b7af with SMTP id
 v13-20020a05600c470d00b004185e80b7afmr5104977wmo.36.1714044087693; 
 Thu, 25 Apr 2024 04:21:27 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 d15-20020adffbcf000000b0034b1bd76d30sm9826105wrs.28.2024.04.25.04.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 04:21:27 -0700 (PDT)
Date: Thu, 25 Apr 2024 14:21:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alvin Lee <alvin.lee2@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 Jun Lei <jun.lei@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Dillon Varone <dillon.varone@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] drm/amd/display: re-indent dc_power_down_on_boot()
Message-ID: <ad54bf29-cb70-49bd-a89f-c51ef7abb3ee@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Thu, 25 Apr 2024 13:04:37 +0000
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
v2: Delete another blank line (checkpatch.pl --strict).

 drivers/gpu/drm/amd/display/dc/core/dc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 3e16041bf4f9..5a0835f884a8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5192,11 +5192,9 @@ void dc_interrupt_ack(struct dc *dc, enum dc_irq_source src)
 void dc_power_down_on_boot(struct dc *dc)
 {
 	if (dc->ctx->dce_environment != DCE_ENV_VIRTUAL_HW &&
-			dc->hwss.power_down_on_boot) {
-
-			if (dc->caps.ips_support)
-				dc_exit_ips_for_hw_access(dc);
-
+	    dc->hwss.power_down_on_boot) {
+		if (dc->caps.ips_support)
+			dc_exit_ips_for_hw_access(dc);
 		dc->hwss.power_down_on_boot(dc);
 	}
 }
-- 
2.43.0

