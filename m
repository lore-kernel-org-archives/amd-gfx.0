Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72910FF886D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 11:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DAEB10EB21;
	Tue, 28 Apr 2026 11:40:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XKT7O6gb";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43E3110EB38
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 11:40:55 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso115205275e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 04:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777376454; x=1777981254; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=870u0ACvWUgOS7tRZnIzo07v6hi9BLEIdZIQdyC7hBc=;
 b=XKT7O6gbIWuo27Xk0vdiQWDR2HTtG4f+q1N3LfdWqMn9wYtMpYnbzvBh6RJpcw4CY/
 DYn17m2MD7ynxddMGb91x2kAuyxl3R2bahq3KmQ3EUg82XpzxtLFfIviigAT5xwNQhFF
 h+yjW4Jm/0ncTbc3la19rCmSLrZ387FZiwsrfan/kJPn6s0JIFYebRQPMqlfkZmXhNor
 t9WFtMnAjy8qJmBnjXdH4gyOJfIDrzz2t4oN6a+GgLIPEA/pgIEg2jBjYXtA152v79zy
 SA6Aqyjbiq5cu7w0NVYh1LRPjJvydFPn3CeeCLIRnr9plOmCC6jJnhBStiyrvTc0NGqT
 aZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777376454; x=1777981254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=870u0ACvWUgOS7tRZnIzo07v6hi9BLEIdZIQdyC7hBc=;
 b=tR1iAGLCBC1FQ7kkxYhZZFc0JQJG/Ty3Siz4tPHZMtv3xioDqjMdxTceX5zKcjD67U
 3Ak3sAEsOPWJdFNjkLqOahwF5nVx3FwMBBPU6kl1NNh2DXFobDuPxnavahs0Dh2Dcv7F
 gsdB9448CjCKUGEcaJEqMUEwv2RX6R5jDSSCdOf3N+qJOmZyywsaXrHfKO6vXf7CzQHk
 5vkHiKxWfMF72M2rgZC0hb7J4sDBnj5bL/4kzhIpSI0cjUz23JWE9e3Vd8qDXkLjviAW
 FMOS6aVQV9+VhMn1rPuIu+BSo/fKFPrSsBUREQNEplYZkrQMDtFStJ7kxuuSAjMe9yJd
 ZjTA==
X-Gm-Message-State: AOJu0Yxn2vUmQ/FO6RZUpA0EO1xaq9b4V9W3rvrc9U5ZmCLvV/REc8fn
 oiP+AOMyU6Jck5gtut3BTUhOiSo6t+N37YoL9pEr8EfLb5Fn0RZNQ3j25Y/htDOx
X-Gm-Gg: AeBDiesUFQpGnKTPv+rvZHmDeanUjjJXFhtcR3aEX+QuHl1625rGhBXBgmUDi9udK2V
 KJwkIpt2+PRHmIKNJL/fx1qu0mQRd+ciTD/zpFa+Z4HZlhGwkJwrPLJ/ioDlcCG3RSnzKMv9TyN
 udza13DO7Jt77nECmIuP/yEnRSyz7YDFUAzYLpJ/zvy+oRAdMw8gLcUSnX7TaccnfXyrn2RDwun
 Pw1mu3W2BLtSwC6LSWVg2/43h9vsJui6JDfhzkOG5af3qmSClqIoBzb/U9PnuG6IPsYhPpqUd5o
 9GHTfHHFXYMxQ9Pg1hR863P7T/OlR3/dAKQq4mybHtkJK1LpWNY209kRLsfgtQ7FXWNUiBZf6//
 aCTfB+4J+VmFP3T8yCPUYKtF/GuHm6Mo75qoDtL7qRrOmsLBWCLJFcP+1VeHrUMc0pqBFvzLZ/b
 TnVrCnhqOnpo6iGVCJNK+3HAaVwKSpFNTGHhKCnNt+BFn+UAvQo0OqsPdCpt4GUJObw17Amuzcc
 ViaEBW3Q521GmQ=
X-Received: by 2002:a05:600c:3ba6:b0:489:1baf:8c03 with SMTP id
 5b1f17b1804b1-48a78a43734mr34630755e9.11.1777376453744; 
 Tue, 28 Apr 2026 04:40:53 -0700 (PDT)
Received: from Timur-Hyperion.home (5401DFC2.dsl.pool.telekom.hu.
 [84.1.223.194]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a775e4bd0sm25048275e9.8.2026.04.28.04.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 04:40:53 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/6] drm/amd/display: Allow constructing DCE8 link encoder
 without DDC
Date: Tue, 28 Apr 2026 13:40:43 +0200
Message-ID: <20260428114045.40710-5-timur.kristof@gmail.com>
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

Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5192
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index edc4cc560539c..22d6ad298a3b8 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -761,7 +761,8 @@ static struct link_encoder *dce80_link_encoder_create(
 				      enc_init_data,
 				      &link_enc_feature,
 				      &link_enc_regs[link_regs_id],
-				      &link_enc_aux_regs[enc_init_data->channel - 1],
+				      enc_init_data->channel == CHANNEL_ID_UNKNOWN ?
+				      NULL : &link_enc_aux_regs[enc_init_data->channel - 1],
 				      enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs) ?
 				      NULL : &link_enc_hpd_regs[enc_init_data->hpd_source]);
 	return &enc110->base;
-- 
2.53.0

