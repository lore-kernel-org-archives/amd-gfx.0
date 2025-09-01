Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EB7CA0FF0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Sep 2025 10:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0FEF10E3F2;
	Mon,  1 Sep 2025 10:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pagj6u6w";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9960510E321
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Sep 2025 10:00:18 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-3cbb0df3981so2014739f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Sep 2025 03:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756720817; x=1757325617; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dbXsbzz9twqY/pNn21/MxDCZvDY3JreP+UiVwQ/9lAA=;
 b=Pagj6u6wEhiZSLFF5zXgqoWPITpkDWVl2pxwLu/i5+x5wdRDPNxkzRYv7x3PaHp+5W
 tJlGbYWCbACxdsfbbeo4WMEvXLBjhNg9hdDzVJgxC8RzklfiX+COyPicW8FST+hBAmw8
 uFns05jLuXXepkH6fcdpthRlyOv6HSsaBOf5gxCmeAPlpUEZPJ6JTuO3egCAheVfHaKV
 b+U9DcwWRyXQLisUDUDgDxW2xFErOynDkz6TSNdeHkvXEZehLqYD7ggAP8gt55gQI/l/
 Cd1BwJuxKY9HMwgQ3nTm/MLgl64fh8dwXJafkdYvjJn+L29STPe2xCfoGmMl8vVjnFQp
 dsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756720817; x=1757325617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dbXsbzz9twqY/pNn21/MxDCZvDY3JreP+UiVwQ/9lAA=;
 b=EE9FX/CfJKS4ZDZd4xe2M+K9rCLV/CBM/uHF0UfN9KHqSH+7UbNT5pa5ck2+9shyJV
 Nei+xZM+sKldkatW8kcAwT3m1Dl7Ey2X/gEdCj077p5V3+RgxjbW75fPMNI/4Lph2U7B
 6E8DiiWPag5l6JRzT6xNEs2pPfE8kPvlC0+6DUirPLlzcgU9Thf6Vc8PPRhnNFHSB0g1
 wxfggpfH7f+ElnkMJqJCSXh2mLGdVeFGkFnZyvp43T5LHXGMK6aUT300VXyYsv+E5WPE
 EguUNne7n73yM1FvzapwN4qLkfGIM2sCe8f2Ut4aSWOWkcGxoyrK1118xlJoD8mPV5g6
 AdTA==
X-Gm-Message-State: AOJu0YxOqkwVb/fsVxjl4wU806pOAj8L55AaUnF4Jch1c9J65U61Q+dz
 8z4T/fktS4a/gDQgxTWXw71EMGV7VC1FtFt3Z/UxWhx8jNc5yLwUj3s9/SKMbQ==
X-Gm-Gg: ASbGncvkwCnsuXoe1PsTYFT5ilq9iYupzUy3aFMfLisA5TIcVrTDyBxHgC542TLJM7E
 53wVLfILTrPSTVqQgXkZz7vE7d616jHHx1NJF+bwk3wtioBFbYcP0GCYHqkySklNSFdbyp+OiEU
 tVqooPY4uHOfmDThrROZnoyAm56YrvlYvLjYr8ZCedFCAYTRfebVe/FvtcExXXJ5ruq2aMk9wJr
 t8w/A4IkXhtyJ3T9Cxfww7BjA79P0DIG+7vhaqzBTlRIOMYLZSEmuyMnd+RAa9aKSbSOZkeTfNV
 LusqXARgt2qUCaNMCxYl+YgEubvxheEBw+mSfuYKZtUlRU8pWbPsAypl2CnyIywZ9dZPdEEtjWJ
 8OJ1Zb2o4C96Od1PnLdEXJ8nfEora2aMZrbr9xiD9ed2iKizmBWS724yk8ByZicPfERd4//ftI+
 GzRvo/WbIcsPb8fGk44MA1MILiz9gLWDvznmAK
X-Google-Smtp-Source: AGHT+IEuUInlGhtiMtIkpiEzOu+9VYkIjW2LFwdZIHrJFD1ggNYiy7by08anpgC+EOcbxOt+lH+1Cw==
X-Received: by 2002:a5d:5f4c:0:b0:3c4:2a56:14db with SMTP id
 ffacd0b85a97d-3d1dfb11144mr5191625f8f.41.1756720816833; 
 Mon, 01 Sep 2025 03:00:16 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24C19400D6AB39BC9D60A351.dsl.pool.telekom.hu.
 [2001:4c4e:24c1:9400:d6ab:39bc:9d60:a351])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf3458a67esm14679142f8f.62.2025.09.01.03.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 03:00:16 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/4] drm/amdgpu: Fill extra dwords with NOPs
Date: Mon,  1 Sep 2025 12:00:11 +0200
Message-ID: <20250901100012.439155-3-timur.kristof@gmail.com>
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

Technically not necessary, but clear the extra dwords too,
so that the command processors don't read uninitialized memory.

Fixes: c8c1a1d2ef04 ("drm/amdgpu: define and add extra dword for jpeg ring")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 7670f5d82b9e..6a55a85744a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -474,6 +474,11 @@ static inline void amdgpu_ring_clear_ring(struct amdgpu_ring *ring)
 	while (i <= ring->buf_mask)
 		ring->ring[i++] = ring->funcs->nop;
 
+	/* Technically not necessary, but clear the extra dwords too,
+	 * so that the command processors don't read uninitialized memory.
+	 */
+	for (i = 0; i < ring->funcs->extra_dw; i++)
+		ring->ring[ring->ring_size / 4 + i] = ring->funcs->nop;
 }
 
 static inline void amdgpu_ring_write(struct amdgpu_ring *ring, uint32_t v)
-- 
2.51.0

