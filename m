Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22B1C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Mar 2022 21:18:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89B9610E12E;
	Wed, 23 Mar 2022 21:18:16 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7F4910E12E
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 21:18:15 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id r22so5369456ejs.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 14:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nPs/KXk9bNlz6KcCUSilPopkztq0KM88w4irv21SSNE=;
 b=rWh8GTfnwjtE/UEZMiBC+AN74PQsr3sFTUs1JDXT3NUNYMMVk/znKTWECBiZ16KknZ
 5JkCnOSDjARTi3CNq7z5mADohm9ZWGQmXsG2PisA8BvxRag342nOPQSjVE9nDM0U+PK6
 /ErJCqAzU8q34wbn5QAcGVZLVAfJ97NXGlgQceTipfe5qXubXe5aH3MIg2/Uo8v/+bxl
 KTpKHjqRYs4teRsidK/eDExdStTaMfd7PugW5HuAAubN8MUSkjfkh9cpYy98xAv8QcQp
 zxXS4Zl/5SY1Q/5SlVag+dEaYXd1HR4ll5nZECPoxdl7EwaNryn/MSN30JnuXLwD8Zup
 lfAw==
X-Gm-Message-State: AOAM531xjqIeRc4JU8+zr9HEOwYF1X9g6QTWV0zHaNoWT62pED9y11Ba
 tQrP8ddHoEFr2YNWEpOqUeKi//oBSNg=
X-Google-Smtp-Source: ABdhPJxtwlETZTgwVelnYFqjtttbBoNkTdBAVFaweoz4HEIbCrjbvGuoaG+6b7o2rCjwgSi9zotYlQ==
X-Received: by 2002:a17:906:c149:b0:6df:f047:1698 with SMTP id
 dp9-20020a170906c14900b006dff0471698mr2315364ejc.16.1648070294517; 
 Wed, 23 Mar 2022 14:18:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:168:d80b:0:d89e:fddc:5f2f:1a25])
 by smtp.gmail.com with ESMTPSA id
 m20-20020a056402431400b00419315cc3e2sm481595edc.61.2022.03.23.14.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 14:18:14 -0700 (PDT)
From: Benjamin Marty <info@benjaminmarty.ch>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: change pipe policy for DCN 2.1
Date: Wed, 23 Mar 2022 22:18:01 +0100
Message-Id: <20220323211801.1569848-1-info@benjaminmarty.ch>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

