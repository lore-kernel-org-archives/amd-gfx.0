Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDADCA0FFD
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Sep 2025 10:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D379410E3FB;
	Mon,  1 Sep 2025 10:00:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vjg/gRuR";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F77210E3F2
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Sep 2025 10:00:19 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-3d3f46e231fso830897f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Sep 2025 03:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756720818; x=1757325618; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TTY/7V+u1Zf1MbiYH6GnmoJBA/B/ZovnZ5bMMwwETXw=;
 b=Vjg/gRuRGJ1qRrJ9VcyuyHx6A+meZZNMmEo2Giq8MaBhwvGm6z0IXuOba6fOUU7t+O
 6fz4LFUDCJeuc/zhHJSkH5niWJFRaCBWZcHQ1A+7ZhqtuPTYbPYHUuaNVPXc6DqQ9Y7c
 nDNJju3QjEnoqOvDSEAFPhpftKRFPmQdcXDaA1IAGV4BqY5FcxZ2uOa4yzPUopn9V4ih
 JBpczO6/qCidOhgfbOOwZw6nVcpYREa2oeRsVyRWOkNAu6FJKJaKPplo1iw3OAabAI1q
 VENv3l+gmKj+698Rd2r43xeBOTXgWHP7FvhvaFyXdjlMvNxVA6HLWnN7iA/x5+AP1v/4
 qE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756720818; x=1757325618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TTY/7V+u1Zf1MbiYH6GnmoJBA/B/ZovnZ5bMMwwETXw=;
 b=Txu6SVYxA8yEk4/JM4QUZnvjm274XNGZD3+yUVf+29lrPWRb6/i20N7XbaT2TaBiwB
 zH8Gt4170WYZylPa4Bfxt4DIcLykjkN+MZkN714kObE0038zMgqk5FFKbiK/hNup9ZV0
 ez6bHctA17pA5bc5LsLLdVELpydUefRCv8p8rShUq3L02rLGGiu8CY+T74SARBWaJr8O
 IhZFGvA1weXJ5l6MWCityecD7ydsQyJ9Ryl4NCKOxrngv77dzcDhNrziwq44a7Houd/2
 bd8nXT8+pn4M/gYniMS9E/m/oi0SAEGyAzJtjPuWTt7jMGLm+f8O+OmlJxl4DTMzp/ss
 GKHw==
X-Gm-Message-State: AOJu0Yzppw02xWySps1LlgcJjSj6GRTfIOv2MGLGAagXwOmMChTQPTlQ
 mFezJKbIqaW2oeMOTr4WovlpYxjIiux8wKWPMr/kx/mG6WjNLdasEOW3dPerjA==
X-Gm-Gg: ASbGncs4Pc+YM8pZOU6Q2nFRj56lKzgSse+UrQjV6MAvYVYClq0gj9tfJYRCxIi2VLX
 BBZtAE0Q96fnplyH4QyK4uSBbXb1OkMyny4nUTGC1h+tWjLNxqchkslrVrBOJ6srtpyDxvjOZJH
 P1OMFFSz1Fx/yyKN8oRMOStzLv5+MOheHXTS3tx0aahRp+nOV733o02Z3sQNTmoUlt6ob/JPgGs
 jkMnJIvFVvDiaBiqBE4TnLMB5gNwTSXoz3dXIewqCz5IyVChgWmP7E32hTyoH/Pvj5Ujrho7kEo
 0PSzAqjdIc5mXUseNMbOEud0UaacncIv1r6ovHOKX9vGL0Wqg9wuHj9m+P8x7f6xARpUqo3x/TL
 7QZW1Hp6kbrFB6PPADL4AQ29QU5qTmltalfV0yVd2XW6cNf4LbA6K7hecJOpOANIIeWD6SEGKP7
 cYrIoduaKlIA0IZih4cPEW8A/sHrxDfVr/mddN
X-Google-Smtp-Source: AGHT+IHLoH6qju34pctBMnd8+td/SpPFooSSXypOHx+Px7bnqJZRT7IhGHezQfPmMzmTHfJOep8X1g==
X-Received: by 2002:a05:6000:290d:b0:3cf:3f1:acdd with SMTP id
 ffacd0b85a97d-3d1dcb781ffmr5640977f8f.17.1756720817619; 
 Mon, 01 Sep 2025 03:00:17 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24C19400D6AB39BC9D60A351.dsl.pool.telekom.hu.
 [2001:4c4e:24c1:9400:d6ab:39bc:9d60:a351])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf3458a67esm14679142f8f.62.2025.09.01.03.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 03:00:17 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/4] drm/amdgpu: Set	SDMA v3 copy_max_bytes to 0x3fff00
Date: Mon,  1 Sep 2025 12:00:12 +0200
Message-ID: <20250901100012.439155-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901100012.439155-1-timur.kristof@gmail.com>
References: <20250901100012.439155-1-timur.kristof@gmail.com>
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

SDMA v3-v5 can copy almost 4 MiB in a single copy operation.
Use the	same value as PAL and Mesa for copy_max_bytes.

For reference, see oss2DmaCmdBuffer.cpp	in PAL:
"Due to HW limitation, the maximum count may not be 2^n-1,
can only be 2^n - 1 - start_addr[4:2]"

See also sid.h in Mesa:
"There is apparently an undocumented HW limitation that
prevents the HW from copying the last 255 bytes of (1 << 22) - 1"

Fixes: dfe5c2b76b2a ("drm/amdgpu: Correct bytes limit for SDMA 3.0 copy and fill")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 1c076bd1cf73..9302cf0b5e4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1659,11 +1659,11 @@ static void sdma_v3_0_emit_fill_buffer(struct amdgpu_ib *ib,
 }
 
 static const struct amdgpu_buffer_funcs sdma_v3_0_buffer_funcs = {
-	.copy_max_bytes = 0x3fffe0, /* not 0x3fffff due to HW limitation */
+	.copy_max_bytes = 0x3fff00, /* not 0x3fffff due to HW limitation */
 	.copy_num_dw = 7,
 	.emit_copy_buffer = sdma_v3_0_emit_copy_buffer,
 
-	.fill_max_bytes = 0x3fffe0, /* not 0x3fffff due to HW limitation */
+	.fill_max_bytes = 0x3fff00, /* not 0x3fffff due to HW limitation */
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v3_0_emit_fill_buffer,
 };
-- 
2.51.0

