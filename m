Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93282C4363A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 21:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E05B20829
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 21:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzUdhLcP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E05B20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A78516EA6A;
	Mon, 26 Oct 2020 21:00:47 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92C896EA6A;
 Mon, 26 Oct 2020 21:00:46 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.30.34.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9B36520B1F;
 Mon, 26 Oct 2020 21:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603746046;
 bh=igjkUN6wESAd/DH60fWZ+VmAdJIU5sWPvyCPO5XJN48=;
 h=From:To:Cc:Subject:Date:From;
 b=VzUdhLcPpA/VYtY4oGcXxakGk/klmGlbWxN7jUe4lHINDG2OR0v498DkIilt3SKQx
 9EgiYQT80bpyfptSqnLQC0nlOAwQ27biV7F2UzJBbeJzhw12tMcXZhs3tumDFTCB5/
 EPQlB8+1RK2gG1f7tadgZIZl9RITJf45G3X7XF84=
From: Arnd Bergmann <arnd@kernel.org>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 1/5] drm/amdgpu: fix enum mismatches
Date: Mon, 26 Oct 2020 22:00:29 +0100
Message-Id: <20201026210039.3884312-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Arnd Bergmann <arnd@arndb.de>

gcc -Wextra warns about an incorrect prototype causing multiple
mismatched enums:

display/dc/gpio/gpio_service.c: In function 'dal_gpio_service_create':
display/dc/gpio/gpio_service.c:70:50: warning: implicit conversion from 'enum dce_environment' to 'enum dce_version' [-Wenum-conversion]
display/dc/gpio/gpio_service.c:71:4: warning: implicit conversion from 'enum dce_version' to 'enum dce_environment' [-Wenum-conversion]
display/dc/gpio/gpio_service.c:76:46: warning: implicit conversion from 'enum dce_environment' to 'enum dce_version' [-Wenum-conversion]
display/dc/gpio/gpio_service.c:77:4: warning: implicit conversion from 'enum dce_version' to 'enum dce_environment' [-Wenum-conversion]

display/dc/core/dc.c: In function 'dc_construct':
display/dc/core/dc.c:718:10: warning: implicit conversion from 'enum dce_version' to 'enum dce_environment' [-Wenum-conversion]
display/dc/core/dc.c:719:10: warning: implicit conversion from 'enum dce_environment' to 'enum dce_version' [-Wenum-conversion]

Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c           | 2 +-
 drivers/gpu/drm/amd/display/include/gpio_service_interface.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
index 92280cc05e2d..67bb5cc67255 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
@@ -54,7 +54,7 @@
 
 struct gpio_service *dal_gpio_service_create(
 	enum dce_version dce_version_major,
-	enum dce_version dce_version_minor,
+	enum dce_environment dce_version_minor,
 	struct dc_context *ctx)
 {
 	struct gpio_service *service;
diff --git a/drivers/gpu/drm/amd/display/include/gpio_service_interface.h b/drivers/gpu/drm/amd/display/include/gpio_service_interface.h
index 9c55d247227e..5f0f94e83d19 100644
--- a/drivers/gpu/drm/amd/display/include/gpio_service_interface.h
+++ b/drivers/gpu/drm/amd/display/include/gpio_service_interface.h
@@ -43,7 +43,7 @@ void dal_gpio_destroy(
 
 struct gpio_service *dal_gpio_service_create(
 	enum dce_version dce_version_major,
-	enum dce_version dce_version_minor,
+	enum dce_environment dce_version_minor,
 	struct dc_context *ctx);
 
 struct gpio *dal_gpio_service_create_irq(
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
