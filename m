Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAC8C47074
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Dec 2023 17:43:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C7C910E2B5;
	Fri, 29 Dec 2023 17:43:38 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D55E110E2B5
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Dec 2023 17:43:36 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3bbd1fab03cso1249441b6e.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Dec 2023 09:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703871816; x=1704476616; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qDufuT7vZj4Umhun9tFfnF0kGRVjSLPZdAR8VKzLYBo=;
 b=i8OGk6wkDQu+Yoe+/WWeYLT2bUS0TgNlWXwazWDU+SP5O0NWInMNGm4M8xxkDm/5iw
 M6SResrD2MAy3+z/dGLxsQYlTyum4AN9Gtdfw2XETA0pdaAfaTvviQ0i6IWeDXfCZlga
 dNnwYa8UjyEz017v4yeQUzHtzTQrBCn+duiRMPqeaKORl80u3+UUH7dUlmCVJCrb9GTZ
 sl1Eh4hVkgXDOe3VJUg2W70ihE9XxYgeX7c62wxM7DMxskC42EMAj6GnfbDUCLrN6tjZ
 WKHFD09IPjGHYiYEZA7/0Up3SISr0+vAgch82fPeHgb9eWigiogSfC6nglek130ck2oi
 wkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703871816; x=1704476616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qDufuT7vZj4Umhun9tFfnF0kGRVjSLPZdAR8VKzLYBo=;
 b=a63w+dE4FFISEfy/3b5NjWNjy9yL9VJIl/FQ240Cke2SQtCrWBySttGZTM696EQjGr
 ZifKPN1enThl9gtwLMc1XEZrdt16PDf+qum+wtvOlndEJzYybFsaRIhbxRFqSR2ETdOF
 G/kClk2IiOmQQxnf+3cwC6x4rw6nSVL08QYYUReFDcGCkaU2pUZTYY10ak69cRuymTzU
 hsIjnoFfK+XKJM/B8TE9Fg+S50mcBUcLObfacx3O5n28su6SO+XvSJuMuA/8+eu1mVwW
 ZtrDUy1wUNjoGHmWBnCSK2TcV+8OtX/Nq8ygxp7e570NtEFJvrWD6zY/mYytsngf17My
 BBKg==
X-Gm-Message-State: AOJu0Yyk8ZsEO0RfbYbP6yf75SzbKqiQ4lmDiM9pmfRcZtxaDicHqqZ3
 d3TW2Pp6wg86IyrUMpNjhjc=
X-Google-Smtp-Source: AGHT+IEpaqCQ9IbPC2JrAt+IoN/xg8Q02xnTfKbyZ2yAuOrD0UABf8HBoFjjXO0/lXdylPdXyPqoIg==
X-Received: by 2002:a05:6358:99a0:b0:170:4ac0:f9ef with SMTP id
 j32-20020a05635899a000b001704ac0f9efmr14453008rwb.15.1703871815946; 
 Fri, 29 Dec 2023 09:43:35 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a8c2:13af:e16c:ee4d:83e4:91a0])
 by smtp.gmail.com with ESMTPSA id
 m25-20020aa78a19000000b006d9b38f2e75sm10056424pfa.32.2023.12.29.09.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 09:43:35 -0800 (PST)
From: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com
Subject: [PATCH 3/7] drm/amd/display: Fix freesync.c codestyle
Date: Fri, 29 Dec 2023 14:41:52 -0300
Message-Id: <20231229174156.1800-4-marcelomspessoto@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231229174156.1800-1-marcelomspessoto@gmail.com>
References: <20231229174156.1800-1-marcelomspessoto@gmail.com>
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
Cc: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove braces for single statement if expression for freesync.c file

Signed-off-by: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 47296d155..3955b7e4b 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -81,6 +81,7 @@ struct mod_freesync *mod_freesync_create(struct dc *dc)
 void mod_freesync_destroy(struct mod_freesync *mod_freesync)
 {
 	struct core_freesync *core_freesync = NULL;
+
 	if (mod_freesync == NULL)
 		return;
 	core_freesync = MOD_FREESYNC_TO_CORE(mod_freesync);
@@ -278,9 +279,8 @@ static void apply_below_the_range(struct core_freesync *core_freesync,
 		}
 	} else if (last_render_time_in_us > (max_render_time_in_us + in_out_vrr->btr.margin_in_us / 2)) {
 		/* Enter Below the Range */
-		if (!in_out_vrr->btr.btr_active) {
+		if (!in_out_vrr->btr.btr_active)
 			in_out_vrr->btr.btr_active = true;
-		}
 	}
 
 	/* BTR set to "not active" so disengage */
-- 
2.39.2

