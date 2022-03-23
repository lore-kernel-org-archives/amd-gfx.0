Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E05AC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Mar 2022 21:42:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3381010E145;
	Wed, 23 Mar 2022 21:42:49 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C97E110E096
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 21:08:43 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id bg10so5379624ejb.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 14:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nPs/KXk9bNlz6KcCUSilPopkztq0KM88w4irv21SSNE=;
 b=p0gAKgscOHnWyh6NSgJWGt/w6Zw8KDJ9S9a1aIabPl+6H19PRPTGI/SgAthTwo0Xie
 ZRlTUg31bjBHSY5BgvijRQrecGYAbpoIeUWVPwoddPhaV7CCoqKJbhnP5adlvYuQhmRJ
 jhBTSvsyW5KQsqyDFRHpT02J4Zsrv/uyotp+me1eDQR3kPDtATfBTWRWI7ZwerwFnf6H
 ieEgHw/4wSg1xPal2oxalsY7RoDO1ifB3cdkCRqwpjtRpNNpcpDrkWw0UkdEdc3JepUQ
 OgpNLXB+/VHhNj5XdeIzns4IIeiiRThGxnqwmOvrD7XktVjA5B0GjKsp+aRTWmie3coM
 d9ig==
X-Gm-Message-State: AOAM531LBhCpChGotJrjKVPgQwoTNOFDNN/RNSTTR7uWQNRboS6GnzAQ
 JiOPOeUw9XzcwEkS0ro5+HXFAn56qxQ=
X-Google-Smtp-Source: ABdhPJygXBSManYhkDKmCR0GWQXsHSQsDON36jhBe+IIvroRBL9+CQjNaKEJZQAg3EYxI7EvvCSWpA==
X-Received: by 2002:a17:906:2ac9:b0:6ce:dc0f:9139 with SMTP id
 m9-20020a1709062ac900b006cedc0f9139mr2267694eje.206.1648069722303; 
 Wed, 23 Mar 2022 14:08:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:168:d80b:0:d89e:fddc:5f2f:1a25])
 by smtp.gmail.com with ESMTPSA id
 d24-20020a1709067a1800b006e021f4c1c3sm355877ejo.166.2022.03.23.14.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 14:08:41 -0700 (PDT)
From: Benjamin Marty <info@benjaminmarty.ch>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: change pipe policy for DCN 2.1
Date: Wed, 23 Mar 2022 22:08:26 +0100
Message-Id: <20220323210826.1559499-1-info@benjaminmarty.ch>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 23 Mar 2022 21:42:48 +0000
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
Cc: Benjamin Marty <info@benjaminmarty.ch>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes crash on MST Hub disconnect.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1849
Fixes: ee2698cf79cc ("drm/amd/display: Changed pipe split policy to allow for multi-display pipe split")
Signed-off-by: Benjamin Marty <info@benjaminmarty.ch>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index e5cc6bf45743..ca1bbc942fd4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -873,7 +873,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
 		.min_disp_clk_khz = 100000,
-		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
+		.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
-- 
2.35.1

