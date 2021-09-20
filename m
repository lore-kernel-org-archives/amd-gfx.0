Return-Path: <SRS0=Av9g=OK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A3DC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Sep 2021 12:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D55156108E
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Sep 2021 12:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D55156108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B9326E4BA;
	Mon, 20 Sep 2021 12:16:14 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BED5D6E4B5;
 Mon, 20 Sep 2021 12:16:12 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2797961040;
 Mon, 20 Sep 2021 12:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632140172;
 bh=aSGPmPDRLP16GIl3fPiwaIaI2XvPbLSEi9QZQZG0BZY=;
 h=From:To:Cc:Subject:Date:From;
 b=FBRLyWZcK8iMM9gQEg0Jk86YoAgzLk5VU2iSBVgom1MMQIVrPrtpkBbfOnpqdGwiS
 ikF4EBcBk/dj7+wO6GUnDEyqgjALDkkH0aA2DIxIVX0JcBEwDtNMklwsomq+TH+eWl
 ubqm5bClcaOR8SxpHUdcTS8tyl5tC5VmoP5FcKx9GRi/fVFlAiwyNe5QIoP1Vd9Ekm
 rGvl9pm/pfWEqvlIcFl4Y3iyZlqxYB+OuyyQjeUwIXumDW7wr8XTfXEkCBjnEzMS0m
 +PJhWJy+p8ejrIY9+Y+bKJUUQL4H0SprG6tBEX21XYyErKxObCgpDI8UCG+yoKXjBp
 3WZkK31iPrZdQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Zhan Liu <zhan.liu@amd.com>,
 Ashley Thomas <Ashley.Thomas2@amd.com>, Anson Jacob <Anson.Jacob@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jun Lei <Jun.Lei@amd.com>,
 Wesley Chalmers <Wesley.Chalmers@amd.com>,
 Lee Jones <lee.jones@linaro.org>,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 Wyatt Wood <wyatt.wood@amd.com>, Jude Shih <shenshih@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: fix empty debug macros
Date: Mon, 20 Sep 2021 14:16:00 +0200
Message-Id: <20210920121606.93700-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Arnd Bergmann <arnd@arndb.de>

Using an empty macro expansion as a conditional expression
produces a W=1 warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c: In function 'dce_aux_transfer_with_retries':
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c:775:156: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  775 |                                                                 "dce_aux_transfer_with_retries: AUX_RET_SUCCESS: AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER");
      |                                                                                                                                                            ^
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c:783:155: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  783 |                                                                 "dce_aux_transfer_with_retries: AUX_RET_SUCCESS: AUX_TRANSACTION_REPLY_I2C_OVER_AUX_NACK");
      |                                                                                                                                                           ^

Expand it to "do { } while (0)" instead to make the expression
more robust and avoid the warning.

Fixes: 56aca2309301 ("drm/amd/display: Add AUX I2C tracing.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index e14f99b4b0c3..3c3347341103 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -42,7 +42,7 @@
 #define DC_LOGGER \
 	engine->ctx->logger
 
-#define DC_TRACE_LEVEL_MESSAGE(...) /* do nothing */
+#define DC_TRACE_LEVEL_MESSAGE(...) do { } while (0)
 #define IS_DC_I2CAUX_LOGGING_ENABLED() (false)
 #define LOG_FLAG_Error_I2cAux LOG_ERROR
 #define LOG_FLAG_I2cAux_DceAux LOG_I2C_AUX
@@ -76,7 +76,7 @@ enum {
 #define DEFAULT_AUX_ENGINE_MULT   0
 #define DEFAULT_AUX_ENGINE_LENGTH 69
 
-#define DC_TRACE_LEVEL_MESSAGE(...) /* do nothing */
+#define DC_TRACE_LEVEL_MESSAGE(...) do { } while (0)
 
 static void release_engine(
 	struct dce_aux *engine)
-- 
2.29.2

