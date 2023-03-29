Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86875C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 18:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D18A610EC07;
	Wed, 29 Mar 2023 18:06:00 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF20A10E52C
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 18:05:56 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-17683b570b8so17048358fac.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 11:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1680113156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dogo3BF2L9vBC4AT6xgMxoTJFXvXmfhOs0Wm2IXvUoA=;
 b=L0HwYwO3L/MNP7MmWs2RcJbpPDw4+LjAB6LZUkRjGQGTcOAeJV74uov52Ekfpp5dmx
 s9lGs7hbWkvuFTUwneVaHXamZVEnm4xDfnGAUPal58PW25X0ImisVK6cetvN9lnDxxpB
 S14152RBp3zDsK3rafFd6eeNnYPrDzXt3KSOf/f8/tH+QAuum8S3zUYAVtXz29+H3Ysr
 +JJmJ+SZm+bax72OFXXBsTF/JNpymn0AgJeQej1Hzg2/4mgEwTNsa5oo41F6HWUq2+Kg
 AkSmdqdvYDrjPRkHg8UO1RD3UssIXsf/yezuTeWy91kkBOGVueLttPUm9Jmt2+Nf3SDi
 QqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680113156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dogo3BF2L9vBC4AT6xgMxoTJFXvXmfhOs0Wm2IXvUoA=;
 b=Jppt7Jrgn7HOg3X7deAWyHwK7OMBfmxpgoTnkFoyyRwZAsbFKuZn0f8+cSOtLpoupb
 73QQR3lG7Q4Wao5uSevXAwY4g1/5LI5oi1o3s4lQI2rMY1ml6zPaaDH6aDLtlxcnlnET
 IGJCyE1gscW5IZ0DYq6N5jv23hFdjt9i97BJJp6H6QwY+j648qutkf0OA0r7SX0nMB46
 s+aTU2F4O4syG1oJGmnUwmdiSxW794/rumSDfyUbfx2OMaeNKjOVoyORb7lL1WHjzgd3
 o/FQwj8hoEY7yZFwD4QknzpUYj8OYJ8Cfff4EqZqwxHHIc3V5bYICe1kPkPxO0KUbGrK
 D+6Q==
X-Gm-Message-State: AAQBX9eHMWakld9AgT5FBFNuI+8lAoslgM7S03BHt3x5+z6DPJMfGoBk
 omEyvfAhvscbc8fELN+OCVVvxvsfFG7jY51eNkRkIg==
X-Google-Smtp-Source: AKy350Y5nATzpWAejjs20Se142ta9u/ME/7RWzY7Q28O0MbOueyG/JtjDWUShvoc2IoJ5SkqvG6ZWg==
X-Received: by 2002:a05:6871:282:b0:177:a8a8:65c with SMTP id
 i2-20020a056871028200b00177a8a8065cmr13194714oae.4.1680113155874; 
 Wed, 29 Mar 2023 11:05:55 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
 by smtp.gmail.com with ESMTPSA id
 yo7-20020a05687c018700b001777244e3f9sm12098767oab.8.2023.03.29.11.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Mar 2023 11:05:55 -0700 (PDT)
From: Caio Novais <caionovais@usp.br>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drm/amd/display: Mark function
 'optc3_wait_drr_doublebuffer_pending_clear' as static
Date: Wed, 29 Mar 2023 15:05:34 -0300
Message-Id: <20230329180534.99151-3-caionovais@usp.br>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230329180534.99151-1-caionovais@usp.br>
References: <20230329180534.99151-1-caionovais@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 Wesley Chalmers <Wesley.Chalmers@amd.com>, Gabe Teeger <gabe.teeger@amd.com>,
 Leo Li <sunpeng.li@amd.com>, David Airlie <airlied@gmail.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <roman.li@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Deepak R Varma <drv@mailo.com>,
 "Lee, Alvin" <Alvin.Lee2@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Caio Novais <caionovais@usp.br>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Compiling AMD GPU drivers displays a warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.c:294:6: warning: no previous prototype for ‘optc3_wait_drr_doublebuffer_pending_clear’ [-Wmissing-prototypes]

Get rid of it by marking the function as static

Signed-off-by: Caio Novais <caionovais@usp.br>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index 08b92715e2e6..c95f000b63b2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -291,7 +291,7 @@ static void optc3_set_timing_double_buffer(struct timing_generator *optc, bool e
 		   OTG_DRR_TIMING_DBUF_UPDATE_MODE, mode);
 }
 
-void optc3_wait_drr_doublebuffer_pending_clear(struct timing_generator *optc)
+static void optc3_wait_drr_doublebuffer_pending_clear(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
-- 
2.40.0

