Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E820CC54E60
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Mar 2024 09:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0206610E5D1;
	Sat, 16 Mar 2024 09:45:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Mr/B79zO";
	dkim-atps=neutral
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com
 [209.85.167.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E8AB10E573
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Mar 2024 09:28:13 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-512ed314881so2298406e87.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Mar 2024 02:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710581291; x=1711186091; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aohr4d7BClKxelEDFFKHCRuY2eGHwzyMDzY2KtCl00o=;
 b=Mr/B79zO2450rREBZK9OSogeY3jh7KqKmtU0fH4ZHrwfmUb1NkTiX/EeFjC1S3TVbf
 f85GNLaKkgS3xI1TDjIW47BnUNIeyrj1BcJlr1GZV2USEphS/2nxnJ+rd+EREUnc8jOg
 SJ7CVAvXFTOHBlkKiFwIt7m5u/UIa7YRWz4uFBkfCYH+DtjQzMwqZFtWrkD/+pEQj1d9
 C0UGMzNRc3dfVWGvoVs2vtXY2UQsseE2rf9CIZ8C6KwwabaF/NFUuNBFFLu2+UGoa5b3
 cATtaxd/z6MVcBJs6KYKILh2XGBv4MgrJvioOObRSQ2PGxfVX0H8T1T2JYPkaBGc7qSl
 Q4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710581291; x=1711186091;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aohr4d7BClKxelEDFFKHCRuY2eGHwzyMDzY2KtCl00o=;
 b=T0ZlisdK98I/8MFyY1OtlRACKEmxP+Ehl8mhAXUCpnEJaEGbEYg3z40SKjUA1k3rym
 KVCOv7BZBy7hcZ/ChEEYfzXYN2ajthv8DyC4pg6DZeo3XL+YKVeFeOehk0R5mP0x5BxQ
 ne6NmuTTmGiUs6wcl/UEjOXlaRROJTgZAL5/406uQFDVybV+J9fyD4hB+yBjXA/V/EGH
 r4im7O6MTHdY0yyacGPxwRgZII+tIjJLXL7eYpH5iq2FsNgUWgDVdNpsCIVv/Scpo+Nt
 lQx54UeX7rdvukPbyz+TqhIz6O0QCIY6kzz6PllBQJ2OhhZVUa4CvtXfsH3gm7U4VDAn
 NVYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1kA6eSUBMxYa7O3NS8O4R1xLyAU98/tLU/N180omNZK5BuUQPd+flrlN7ZgvwiWMGkLrjp1icKXUYgI9qFCmyUWHiQZWpL8wHjxfiaQ==
X-Gm-Message-State: AOJu0YwXL/MCsTMukQKKucIo9cbMTwjiIXgz7ntJonkBKbaHVxCq0bSp
 Aif0iPN5254CdmOTPqUmLM+pncGEbqiOr+lPTZRv6Fv38hJQkZgNmcV4DtBW+Jg=
X-Google-Smtp-Source: AGHT+IEcnp7qiM6IXTp0ox63XBBssfGbXKm5O93H133J9J0QTjrgFwKlcFwMjSWaSlH8P9wUdPdZJQ==
X-Received: by 2002:a19:4353:0:b0:513:cc34:342a with SMTP id
 m19-20020a194353000000b00513cc34342amr4706454lfj.14.1710581290898; 
 Sat, 16 Mar 2024 02:28:10 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 n20-20020a05600c4f9400b00412f8bf2d82sm11391125wmq.28.2024.03.16.02.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Mar 2024 02:28:10 -0700 (PDT)
Date: Sat, 16 Mar 2024 12:28:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Charlene Liu <charlene.liu@amd.com>, Jun Lei <jun.lei@amd.com>,
 Alex Hung <alex.hung@amd.com>, Daniel Miess <daniel.miess@amd.com>,
 Sung Joon Kim <sungkim@amd.com>,
 Yang Li <yang.lee@linux.alibaba.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amd/display: delete unnecessary check in
 dcn35_set_long_vblank()
Message-ID: <56712ad5-ed41-4d64-a317-10cc1275137a@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Sat, 16 Mar 2024 09:45:22 +0000
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

"timing" is "&pipe_ctx[i]->stream->timing" where ->timing is not the
first struct member of ->stream.  So it's the address which points into
the middle of a struct.  It can't be NULL so delete the NULL check.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 2e8ec58a16eb..87cfd9f1cec9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1411,10 +1411,7 @@ void dcn35_set_long_vblank(struct pipe_ctx **pipe_ctx,
 		if (pipe_ctx[i]->stream) {
 			struct dc_crtc_timing *timing = &pipe_ctx[i]->stream->timing;
 
-			if (timing)
-				params.vertical_blank_start = timing->v_total - timing->v_front_porch;
-			else
-				params.vertical_blank_start = 0;
+			params.vertical_blank_start = timing->v_total - timing->v_front_porch;
 
 			if ((pipe_ctx[i]->stream_res.tg != NULL) && pipe_ctx[i]->stream_res.tg->funcs &&
 				pipe_ctx[i]->stream_res.tg->funcs->set_long_vtotal)
-- 
2.43.0

