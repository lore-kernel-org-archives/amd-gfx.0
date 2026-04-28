Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88412FF885D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 11:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06A4510E404;
	Tue, 28 Apr 2026 11:40:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KN66ZuEb";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00C4D10EB48
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 11:40:53 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so149370495e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 04:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777376452; x=1777981252; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SdhUEt8WdezyJn2O98A0/2SXStsM9qK5vkIGE0GCskA=;
 b=KN66ZuEb5+FCjs9vu7nmvF68aQ1ebqpOJio4OMIoerGRz5k6Q1fvevZZWKvx/UNNCN
 YCsNTr11JfnTAx2MxuUCnQasGN/qgeqFvK88OsS7iIQejUNwe6U7QWo2qIGqwga+jFEB
 vW4utVk84u5BPMtm0mvecCx0XFv08kNs6ije6EXaaw5PT2dbl9AzaDZip3AX79zBmmrb
 4A/90r1Ayi6OS8xE4JzyR6hS3j8kzU4QFA0AmatpCFPhgOpr90kIexwerOgiruUtndZS
 sjF2l63laCecPIDRHFwPG2H5nqWxWLF94knM8vfX3KWZhb+ViM09K5hPwJQe9nOnxMrL
 zeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777376452; x=1777981252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SdhUEt8WdezyJn2O98A0/2SXStsM9qK5vkIGE0GCskA=;
 b=FSAAAfOTHQ77lJ34I3/Sqe+Zh4y7yT3k5vhh1FYd2jKDGfju/scuJs+BJS12DnqE4u
 l5oX5Hj2lO7Uf5J7G+DF3IynUk9lQ9YYiD5ZPcGXylVJE62vn1/kBEXwjoffH9hYg6fs
 cyKtF88LPn52H+K5j6cjY98MFL2QPR6z1qhjH+cdd4qok7SY3N8ht+cXG08fPzlEdRT/
 ltPJIVzqD425neNwfx3PN3Xh1rnBHE83ykfXBCKjCxpBYtMyFW5vdEocxyF6X7afYrxB
 yzE+QMH90UD3tveIVwoPS9i/z+wdcp0Gtf653T599kUofXOIVtAazbLyc3uUHts+Zicm
 EV1A==
X-Gm-Message-State: AOJu0YxKSUN5ZGvEXfAEQoWSVwviRtmyIfArP7OrfEZcUZZPWxYd10Cj
 5m/hLjZEmB5KGqj0a3N6q3dqAG/ZIiBJbATtkIOh+Z9YIZ41hzGmlM5XSXy2fbLR
X-Gm-Gg: AeBDietmZzDfkGCLR/ct66VqhpIFv5PopPo9eWchG0+Upet3PKKkXbVE7YMXchmkVZu
 ngvALLLMOhGu5Y7N46oOVcpcbsbHFHVMUt0zLcculNrbIRePnfDNu6qLYR9E2tV1VaVaBO2f8mA
 ZHQX4CtP5WH3RxmavzdMYEdi14FYbMV7dVlAAbO21zPjTMO3w8io4w9sAMFeUn+kf8MbW6Cu5vt
 vrf6GKeyfmyxJwOSL947X0w9JH5FIqI5FC2WbYnJfW65A0Kp4V7VDbU8H50sFhCVbMRUeD+iynY
 MZUekZcsuaT1WclvdVFZt7bZgCFnNuBS6rUEok7Otj99EPzO1g6leghfC0L5kil+l8T68sUjj44
 fENfY+dQw7JiGyJrtcdc/A52jzz3ZyJFOj60PwAr/mxnJ6AabBtXFfBW+DROUGAiPVtNsvqg+Lu
 XvIKZkL3dm4jUc1uZO4nn3PZzNInElzD47+GrptgtyEcW4bvd8La5db6IdmPIk6kMNPqqa6tgu2
 OzE
X-Received: by 2002:a05:600c:c4a5:b0:489:1c5f:3a9e with SMTP id
 5b1f17b1804b1-48a77aea521mr41570355e9.13.1777376452051; 
 Tue, 28 Apr 2026 04:40:52 -0700 (PDT)
Received: from Timur-Hyperion.home (5401DFC2.dsl.pool.telekom.hu.
 [84.1.223.194]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a775e4bd0sm25048275e9.8.2026.04.28.04.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 04:40:51 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/6] drm/amd/display: Allow constructing DCE6 link encoder
 without DDC
Date: Tue, 28 Apr 2026 13:40:42 +0200
Message-ID: <20260428114045.40710-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428114045.40710-1-timur.kristof@gmail.com>
References: <20260428114045.40710-1-timur.kristof@gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When the DDC channel ID is set to CHANNEL_ID_UNKNOWN,
pass NULL to the AUX regs array.

This is necessary to support embedded connectors without DDC.

Fixes: 7c15fd86aaec ("drm/amd/display: dc/dce: add initial DCE6 support (v10)")
Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5192
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
index 2f5ee9d8536af..9bc97e708478c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -754,7 +754,8 @@ static struct link_encoder *dce60_link_encoder_create(
 				     enc_init_data,
 				     &link_enc_feature,
 				     &link_enc_regs[link_regs_id],
-				     &link_enc_aux_regs[enc_init_data->channel - 1],
+				     enc_init_data->channel == CHANNEL_ID_UNKNOWN ?
+				     NULL : &link_enc_aux_regs[enc_init_data->channel - 1],
 				     enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs) ?
 				     NULL : &link_enc_hpd_regs[enc_init_data->hpd_source]);
 	return &enc110->base;
-- 
2.53.0

