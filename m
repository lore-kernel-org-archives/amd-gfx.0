Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05ED9C05027
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 21:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85D1010E3BC;
	Thu, 26 Jan 2023 21:01:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F94210E2B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 20:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674766194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oGi4tyQZKR9EF1nkoMYIGWcX8cZ8bAVtY0RE3pjhZwE=;
 b=dPHieeAt8oj941OD8AhMfDCLwdZAUpBXIkZ4FsAdN30VHnCncVNwibdiam+z46C7OV0w5x
 mr73DuewG7hFd+U7J7klEEAnyfq3z+E0gG2qu1s6KKKW7fV3fSf2F0WMzGjLtbl97EK+bZ
 khuhGYe6bGLtYEHdCKjdhWlAdINz+e0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-124-iNNIVYTpNDm8lkt6N5j1tw-1; Thu, 26 Jan 2023 15:49:50 -0500
X-MC-Unique: iNNIVYTpNDm8lkt6N5j1tw-1
Received: by mail-qt1-f198.google.com with SMTP id
 br26-20020a05622a1e1a00b003b62dc86831so1318221qtb.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 12:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oGi4tyQZKR9EF1nkoMYIGWcX8cZ8bAVtY0RE3pjhZwE=;
 b=8DaoHPyri4jwS2BcF2qlcO0O1/KHycvLGWL8cnsNkn0DdCjK3DF1sO8htOz0TxmINf
 WADKnmGE+HVHqRwHQlSeSIwADUrwrU7jKLAZt1xjcUxctwJKGurzj8zUG8pl7yqXbNLt
 qUcTmSfdQFg22VX0mmx5h5PhGcExKFdzdBdqCMIDN1zZJKJllvGoIUIYKf+563Ut/ds4
 AcjaA7fEamz9KzwmvCdeXoa9iqN644IrGCNpKg4lA5LckHcSDL0PwrUKdZRxLTa+iHzQ
 lBhCofrAvTRb9orb2o9RWMyaUWpXr0uEY9/nlIG7qjTHVOVf3b+uFnZJBSLWdvvprtOa
 /2Zw==
X-Gm-Message-State: AO0yUKUGUBhVdiNzWPq3F7eXZkWwRFigH8DL8o37/HsI+1sZ/Z9ptVm2
 +930jIWojA1rajUMeXGZmpbvS+e9yzV2HN/1mQohndE36hasffE1Bd6uUn62gAANTo8iQQpKyUU
 tce6rc6ixPV/ai+fyYyyGYCsdmQ==
X-Received: by 2002:a05:6214:192c:b0:537:708d:3fef with SMTP id
 es12-20020a056214192c00b00537708d3fefmr11926909qvb.38.1674766190522; 
 Thu, 26 Jan 2023 12:49:50 -0800 (PST)
X-Google-Smtp-Source: AK7set+ugItgaazXYqO9kQT722ufZwbkvuzBNI79A9vAf2gUEGkugVHZxtq7UGpUs+gPeO2hRZ5rIA==
X-Received: by 2002:a05:6214:192c:b0:537:708d:3fef with SMTP id
 es12-20020a056214192c00b00537708d3fefmr11926871qvb.38.1674766190258; 
 Thu, 26 Jan 2023 12:49:50 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com.
 [24.205.208.113]) by smtp.gmail.com with ESMTPSA id
 b24-20020a05620a0f9800b006fafaac72a6sm1544573qkn.84.2023.01.26.12.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jan 2023 12:49:49 -0800 (PST)
From: Tom Rix <trix@redhat.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, jun.lei@amd.com, Alvin.Lee2@amd.com,
 Nevenko.Stupar@amd.com, Dillon.Varone@amd.com, george.shen@amd.com,
 rdunlap@infradead.org, David.Galiffi@amd.com
Subject: [PATCH] drm/amd/display: reduce else-if to else in
 dcn32_calculate_dlg_params()
Date: Thu, 26 Jan 2023 12:49:35 -0800
Message-Id: <20230126204935.819030-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Thu, 26 Jan 2023 21:01:17 +0000
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
Cc: Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

cppcheck reports
drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c:1403:76: style:
  Expression is always true because 'else if' condition is opposite to previous condition at line 1396. [multiCondition]
   } else if (context->res_ctx.pipe_ctx[i].stream->mall_stream_config.type == SUBVP_PHANTOM) {
                                                                           ^
drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c:1396:69: note: first condition
   if (context->res_ctx.pipe_ctx[i].stream->mall_stream_config.type != SUBVP_PHANTOM) {
                                                                    ^
drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c:1403:76: note: else if condition is opposite to first condition
   } else if (context->res_ctx.pipe_ctx[i].stream->mall_stream_config.type == SUBVP_PHANTOM) {

It is not necessary to explicitly the check != condition, an else is simplier.

Fixes: 238debcaebe4 ("drm/amd/display: Use DML for MALL SS and Subvp allocation calculations")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 0dc1a03999b6..c96cbd88e20d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1400,7 +1400,7 @@ static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 					/* SS PSR On: all active surfaces part of streams not supporting PSR stored in MALL */
 					context->bw_ctx.bw.dcn.mall_ss_psr_active_size_bytes += context->res_ctx.pipe_ctx[i].surface_size_in_mall_bytes;
 				}
-			} else if (context->res_ctx.pipe_ctx[i].stream->mall_stream_config.type == SUBVP_PHANTOM) {
+			} else {
 				/* SUBVP: phantom surfaces only stored in MALL */
 				context->bw_ctx.bw.dcn.mall_subvp_size_bytes += context->res_ctx.pipe_ctx[i].surface_size_in_mall_bytes;
 			}
-- 
2.26.3

