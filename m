Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F58C83F17
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Jul 2025 09:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 383A910E749;
	Thu, 31 Jul 2025 09:44:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JzKgpyKE";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A3C110E74C
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 09:44:22 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-3b78bca0890so494675f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 02:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753955060; x=1754559860; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCbAqeKmbFZK7y8CzLhyMkGwCSjDLloNr03rTiTxRcQ=;
 b=JzKgpyKEo4OBukMLHGMZgS50by2knwT7N1UYJBB1kslOOE8xI1CFY2hAMaxjPfNMEM
 kVg7Ota43nNJ7Hq3bbd92oUKO6z4Hg5NIsA9tlwRzbDFc43h5omHTArb6mqJT4aNRHAA
 cgZc8Am5Glh7U7McSq5P3ENW49L/hP/xmyCEhpEb2nxC5HvnAb7zbyQwvVr6saInvIYu
 /5tigq69NqJAxKOlMpqmSgidaTX/On4EW2LzsmXn26T5zpHmgsV7wl7A45hkE1I7To9+
 QMyiFMpkuoCAJv+MqRD1uVxoqRKCPOlrSRS+gM3lP5Nt2WP+cxHfVjoQd+lKWdKBje9s
 c6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753955061; x=1754559861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCbAqeKmbFZK7y8CzLhyMkGwCSjDLloNr03rTiTxRcQ=;
 b=POam0vlrEjELo25pYIGc6xHbdcJuid6Gzvri49wMrpcCT9wQBftl7z9RbXjlRFfNcb
 jNswEsPZ1qQN28r7VX2OZFfG4AcmbtwNL7PjnxHyRHsz9ANh3+RZ4DvceMvqMBxtkdof
 w0LXbDmxSjBDcLYn+nZNWn0XH57fIXXXJNiqPiQrR7wKanMfzvYMdoE6w0lQAjPgO5l8
 5BfjTq+aMCCY3otsN2bry3UNexK9KYS8K4vMYUOYh5IcG/yXHgVWlNJZkiuAPwujRsKU
 SpQQVVFzoiq6RyLahEnuIRJISCEO7UwZKOQdmVQNOQcVTeD0CjO70jCvvHJkeWNBDiJS
 yZQQ==
X-Gm-Message-State: AOJu0YzVXlKc0T0E85eSD8iohb/AFaLZS17WngEhuPWhVmMFW+7lvn5u
 xz984LSQC1CUhmA7duzF++FWIZYECmoNZlpG0PTs8zYOtXIkHpHqKl1nurYL5Q==
X-Gm-Gg: ASbGncs4fZ/+AzlVMa0CElqgVIjCjvZkiacUfdtlwJ8Biv3/UQW9VPDD1t8ob9lkZmu
 7nbhIf8Y2Ddx9ubLXeswWaWwaAZweMdw0vx3uiSSyOvnRchttjYPQUy1aModApdILJMeRu+M7YO
 X4FBs4fCIYzQHL0M6f64e1pxl4G8+lxKdCL2qwXoFwO9NEU3bcYkyLrIV+S1qjZLIisa40MY3AD
 AKpkRGHQj3YPzxWvorfI2L/GwvOkc29Tjs7Ws5KxeLD1fqTkagQvoAozmbqEMvsxeHR4zpREg8D
 Ybk3bQh6eaSCu87wLuRzBTKZHghT6L1SGPpqnHjjDcbxhz5BblNsRzM9cXG7iP5O7tZ3rRPfKLZ
 JAk+PHzE/YuwnOupySqvcTEM6ElSTRLeZMei4JsXnnAJtsmJzQ1iKnp+W70P9VVumpRo1dZm9e9
 eZ99jmicg5G9HX+Gfo6Dk=
X-Google-Smtp-Source: AGHT+IEMreyhdLeUlT861eqmKKEqgsSR5azWDUecKkRRYS7w4+LiPGR/uq7hRYU+xDGnRIHgQCsCew==
X-Received: by 2002:a05:6000:2282:b0:3b7:8ed7:9635 with SMTP id
 ffacd0b85a97d-3b794fb2d8emr4696307f8f.4.1753955060531; 
 Thu, 31 Jul 2025 02:44:20 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24DDB700267C66B850A0E369.dsl.pool.telekom.hu.
 [2001:4c4e:24dd:b700:267c:66b8:50a0:e369])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589536b3b4sm58252835e9.3.2025.07.31.02.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 02:44:20 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 5/7] drm/amd/display: Don't warn when missing DCE encoder caps
Date: Thu, 31 Jul 2025 11:43:50 +0200
Message-ID: <20250731094352.29528-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731094352.29528-1-timur.kristof@gmail.com>
References: <20250731094352.29528-1-timur.kristof@gmail.com>
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

On some GPUs the VBIOS just doesn't have encoder caps,
or maybe not for every encoder.

This isn't really a problem and it's handled well,
so let's not litter the logs with it.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index 4a9d07c31bc5..0c50fe266c8a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -896,13 +896,13 @@ void dce110_link_encoder_construct(
 						enc110->base.id, &bp_cap_info);
 
 	/* Override features with DCE-specific values */
-	if (BP_RESULT_OK == result) {
+	if (result == BP_RESULT_OK) {
 		enc110->base.features.flags.bits.IS_HBR2_CAPABLE =
 				bp_cap_info.DP_HBR2_EN;
 		enc110->base.features.flags.bits.IS_HBR3_CAPABLE =
 				bp_cap_info.DP_HBR3_EN;
 		enc110->base.features.flags.bits.HDMI_6GB_EN = bp_cap_info.HDMI_6GB_EN;
-	} else {
+	} else if (result != BP_RESULT_NORECORD) {
 		DC_LOG_WARNING("%s: Failed to get encoder_cap_info from VBIOS with error code %d!\n",
 				__func__,
 				result);
@@ -1798,13 +1798,13 @@ void dce60_link_encoder_construct(
 						enc110->base.id, &bp_cap_info);
 
 	/* Override features with DCE-specific values */
-	if (BP_RESULT_OK == result) {
+	if (result == BP_RESULT_OK) {
 		enc110->base.features.flags.bits.IS_HBR2_CAPABLE =
 				bp_cap_info.DP_HBR2_EN;
 		enc110->base.features.flags.bits.IS_HBR3_CAPABLE =
 				bp_cap_info.DP_HBR3_EN;
 		enc110->base.features.flags.bits.HDMI_6GB_EN = bp_cap_info.HDMI_6GB_EN;
-	} else {
+	} else if (result != BP_RESULT_NORECORD) {
 		DC_LOG_WARNING("%s: Failed to get encoder_cap_info from VBIOS with error code %d!\n",
 				__func__,
 				result);
-- 
2.50.1

