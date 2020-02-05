Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAE5C35249
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 03:49:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7105B2072B
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 03:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvpXgnt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7105B2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D0FE6F46D;
	Wed,  5 Feb 2020 03:49:21 +0000 (UTC)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA2186F469;
 Wed,  5 Feb 2020 03:49:20 +0000 (UTC)
Received: by mail-pg1-x541.google.com with SMTP id 6so278456pgk.0;
 Tue, 04 Feb 2020 19:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lFpfk0LO6j/KbpaQJmrUVbhYieQwFi3dFY7IvFTLRdc=;
 b=hvpXgnt7+5JikUjBNlpUMUvJE2KgUbalhxZFUoHjqv9/NSudR2nIKvNbk+HnoQkT/J
 Xlt4kdWUuqfwMI9RimMTJcVNs58N90FSp6WQVo31j2bORJgEEb2g++Ie0LpCvx37Dw7e
 jUksvzWKwMTuCJT1WFS7pwZegE/32Zoq8Jja4oyTdK/BoCifhSMENd4M3NkSaKU5Fq28
 2JqGQP4ijhhu8qZNIHJZyZQwo7WofGaLiAxRv8qvRUQpkMLdXlBJPzVV0db0FQj4y4oL
 4Mg12RHbDiqvhf9G5G868nWCoJlk60XbypO9v4Gf2kdQ2hCnnw8NU4XM3BioCmgbbX5h
 CqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lFpfk0LO6j/KbpaQJmrUVbhYieQwFi3dFY7IvFTLRdc=;
 b=A0vvP+N8Qojja/opnA1+TDvivBDEQS+LUvhKr7RODq4kkFAq+jofiezdVKZsDa8Exd
 R5Ye0XMB4FfOjvEdmhI7vxZqoqJrvqpiRk3BaBpIceAHNI4MuHRBYFDSPGY4oabqZLWS
 17H4sl63YE7ItSBUrAAYHSUqU6jv0AwhaniFZ50PwdV7WSzrnwKoVwPGYjk8lXInycCo
 ffEeT4ZyIRmGtngmh/14SkVuojmQ9MtwfZcmNSR8RJGj92TDsRkeQpYoRBlIvzUPGSPX
 3CXhv9l0qVbmJpVU7cxo8BmSkdI98FYPz68RUUvaszUxXQSYRJRpFwZVVy3BjICheeaG
 fEHA==
X-Gm-Message-State: APjAAAV1l36eAiVFc2fFNmspt6fqTYOk8ELL/nuBA6hYljl2puAiQE5U
 +QL9R8JymMmfkNYfIfm0lxjjw5Kg
X-Google-Smtp-Source: APXvYqwLszKA+6Sle4k05CzybyE5Eev9F46zdB4kRWBt3PPyO8EoC193whqq7b5RftijYxf9TnTE2g==
X-Received: by 2002:a63:d441:: with SMTP id i1mr36318377pgj.426.1580874559980; 
 Tue, 04 Feb 2020 19:49:19 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id 200sm25320292pfz.121.2020.02.04.19.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 19:49:19 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 12/14] drm/amdgpu/display: add a late register connector
 callback
Date: Tue,  4 Feb 2020 22:48:50 -0500
Message-Id: <20200205034852.4157-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205034852.4157-1-alexander.deucher@amd.com>
References: <20200205034852.4157-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To handle debugfs setup on non DP MST connectors.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5b9154ecc690..1d86b9d53a61 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4486,6 +4486,19 @@ amdgpu_dm_connector_atomic_duplicate_state(struct drm_connector *connector)
 	return &new_state->base;
 }
 
+static int
+amdgpu_dm_connector_late_register(struct drm_connector *connector)
+{
+	struct amdgpu_dm_connector *amdgpu_dm_connector =
+		to_amdgpu_dm_connector(connector);
+
+#if defined(CONFIG_DEBUG_FS)
+	connector_debugfs_init(amdgpu_dm_connector);
+#endif
+
+	return 0;
+}
+
 static const struct drm_connector_funcs amdgpu_dm_connector_funcs = {
 	.reset = amdgpu_dm_connector_funcs_reset,
 	.detect = amdgpu_dm_connector_detect,
@@ -4495,6 +4508,7 @@ static const struct drm_connector_funcs amdgpu_dm_connector_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.atomic_set_property = amdgpu_dm_connector_atomic_set_property,
 	.atomic_get_property = amdgpu_dm_connector_atomic_get_property,
+	.late_register = amdgpu_dm_connector_late_register,
 	.early_unregister = amdgpu_dm_connector_unregister
 };
 
@@ -5834,10 +5848,6 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 	drm_connector_attach_encoder(
 		&aconnector->base, &aencoder->base);
 
-#if defined(CONFIG_DEBUG_FS)
-	connector_debugfs_init(aconnector);
-#endif
-
 	if (connector_type == DRM_MODE_CONNECTOR_DisplayPort
 		|| connector_type == DRM_MODE_CONNECTOR_eDP)
 		amdgpu_dm_initialize_dp_connector(dm, aconnector);
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
