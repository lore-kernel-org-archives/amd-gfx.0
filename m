Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF6CCA0FE7
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 21:47:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E19CA10E589;
	Mon, 25 Aug 2025 21:47:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y71LLBM6";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F73210E588
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 21:46:59 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-45a1b0d231eso27965525e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 14:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756158418; x=1756763218; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nxF8C4v+5jFW/EL31aaItA+AWhQ6NS8nxAqBxqzd+wg=;
 b=Y71LLBM6mMUiiRWJxtBTDdUrLR+ZN75Hzvs33utWmxEcx3faqx7dFX2sTzOP07Ta0H
 8uvuyPxOw3M/8U0+G6Utfij6LobzQ6f+7bmIb53u2h+bAJcpVjbkwLAV40ki5H8omMmm
 RGarb69uu/yVyLT51eqXeetkOeWMXT+quwNt+Ok2YijlkhMAg2rzWhmRv6gkxQJ03wV8
 k8nyJfKK0Af8GuIqf0wj9qFl6UcCo+rpX+Zu3kkgxCvgs8NJN0mBCkPhFju3dgrrZWbv
 PMJ7qA/Z6MJ1SMZTFERy/BAR2pxF+4RPiNi8NmmpAes5Ih8XoR79KU4shvJG2OyvGvt7
 jr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756158418; x=1756763218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nxF8C4v+5jFW/EL31aaItA+AWhQ6NS8nxAqBxqzd+wg=;
 b=Y/BzhiQfgnhHHso7ffzSzjzO+WmxDAIM50yDPwQyhOcl+pgHJKzS1d5ulkGsjsJ9lx
 Gy6QkBVJk4/WuTQ2mP1mpCmL1nwFE5FCh4RGsIN/nL4gsJrGfMpAv3VzKAX38TTyS4PS
 RyNstZYLLYashsG5palGgrok9cazgH55e0q6ts/G0BP9ytdO2y3UxtNCueyNRo2MfkBy
 fjyrUXgVkBBHop9e1P9Xq2A32GHKwP+WR5at8HVY0DDav1hFAmRoseEWWi3HAfqtH7Na
 A3mrdgQMmtjPnxMmr4EQCN3sbecT+9yDKN/s5xrkBRu/SyyKfZ79rrK5ncOSnCsh4s55
 jTEg==
X-Gm-Message-State: AOJu0YyiHsa9yT6Y8qkrYfS/rH66tVXvDlaqD8V0zyX9UwOle1pKQZPQ
 qOtXFRi652g9lF6j36vUorrq5bPq7PHJMm0TRku3nPwztKW9M5JutlB6xOXkiQ==
X-Gm-Gg: ASbGncs9MQi1OhViTkPAW0Z5bad0e7BX2LF6fVWy/xtXoiuGE9R3Eho48gUu8x7LD3X
 jstBp5Hoz1nPdfXF9fnl9S6Rkv1ImQ5syGlFhCFC8dkYMcJew67Bd8/2D5rVIIuv9BwVqdzGXZW
 s7J0SUPe6XM8azAJb8i71/6Lg+mzb4mrWwXiUZNWchs+Y5ZhO7hsw2Cq6e3caof48EFOqyMUr0G
 GzCn6J7WTuoBp6A8eXF37hxTAsaU2elPyfxvX1yk+MjTYRO2VrFJlukitI8yDy/ftzJYuQJYK2l
 3rnRbICBfDylhYXFr5FDHXlc4tWOC/i/MuYLM2HMs9jbY29lVv+ZITPMVrxzkKXKeG8dy0hISqJ
 doX4qJWls3NMxlMGQPJ1JIDnqpseOH72Is7tFPEQVh5sNrx0nHIvByBDgwvoQ7agqfCO1QTNVin
 lWgicS8+Yf3VGPBQrxXLl5Esml+g==
X-Google-Smtp-Source: AGHT+IGVV+KvXzv8gPOkl7MnlEz7Wtv2ojYDpnmBGNCB/dwQTjhr0ZMxqRjTdxgnayh41MeTb8P0AA==
X-Received: by 2002:a05:6000:2203:b0:3ca:8b32:e43e with SMTP id
 ffacd0b85a97d-3ca8b32e887mr2091090f8f.11.1756158417935; 
 Mon, 25 Aug 2025 14:46:57 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c7117d5977sm13348110f8f.51.2025.08.25.14.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 14:46:57 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 alex.hung@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 6/8] drm/amd/pm: Disable MCLK switching with non-DC at 120 Hz+
 (v2)
Date: Mon, 25 Aug 2025 23:46:33 +0200
Message-ID: <20250825214635.621539-7-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825214635.621539-1-timur.kristof@gmail.com>
References: <20250825214635.621539-1-timur.kristof@gmail.com>
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

According to pp_pm_compute_clocks the non-DC display code
has "issues with mclk switching with refresh rates over 120 hz".
The workaround is to disable MCLK switching in this case.

Do the same for legacy DPM.

Fixes: 6ddbd37f1074 ("drm/amd/pm: optimize the amdgpu_pm_compute_clocks() implementations")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
index 42efe838fa85..2d2d2d5e6763 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
@@ -66,6 +66,13 @@ u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev)
 					(amdgpu_crtc->v_border * 2));
 
 				vblank_time_us = vblank_in_pixels * 1000 / amdgpu_crtc->hw_mode.clock;
+
+				/* we have issues with mclk switching with
+				 * refresh rates over 120 hz on the non-DC code.
+				 */
+				if (drm_mode_vrefresh(&amdgpu_crtc->hw_mode) > 120)
+					vblank_time_us = 0;
+
 				break;
 			}
 		}
-- 
2.50.1

