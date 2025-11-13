Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71712CD8CA4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 16:33:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1217210E8AB;
	Thu, 13 Nov 2025 16:33:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P/Wt5r7D";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6003210E8AB
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 16:33:52 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4777a9aeedaso9038715e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 08:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763051631; x=1763656431; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HT02VC5z4xZ5i1RzcAP/CPZxFEMnVgC9b/o+LpQKW0M=;
 b=P/Wt5r7DhI9B+EwWD3IqEFpkwulxUAEhu1/n6sfF9UdnnU4ZOyASSfJvqs82mAPUKX
 mSFVSmFn4AfS1/4UGV3YzalrBvN8uh9HPEXJiT6oQqwGTmouGNARFua83bYXl+ly4jS0
 xyQ+3DUeVjUPYPC6xHnRQGmfCiN1FBY/L3iEBJR0TDq89jkFaGwodro4JWkhtLjxWnwp
 D2VBr4YGaDBfWZf79fYeU+MR0lqIOFDgRiS4nLhMAW2HS53rF/djZZHLDIfU1YXtRny5
 61Xn4pq2d6a802wsGQnukrL4n0LFk8vY3owrplXUX3CgJ8u3W+R3ZhKx6mLiGnHUeSmL
 H8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763051631; x=1763656431;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HT02VC5z4xZ5i1RzcAP/CPZxFEMnVgC9b/o+LpQKW0M=;
 b=pN5+gkjVUzomqlCbnTNVNE8+R7YmMYBTbraOtcPkRQV6wi59AKNPeSnrALBvHkRKlV
 VxRgMiGWIBcCKLxhQAT+BTyBW6WgRvFKBzswMJZsbg0dL/rE4JBGVqaScYreeLR4FwhQ
 L8IvBEhLZDxv7FhDxhOUGO6nhTkp7MJTr6qbsdmyNcOkLMSXf0mplyvdpE+vF0VtCbeL
 BNlWd0ItEmcZqJaVKR6gir58mJyxyCublqNox6mBoivT8j2EZnp1mlOS8RkaxT811ZVA
 8uV1T28mWM2rFpHdeMRebPS2EPB24XPZZozAxcksVxK7Ga83Kp59OT0ceGT7ZfYNgI8Z
 lYKw==
X-Gm-Message-State: AOJu0YwEQ+pxF2LC5m5Ly01/vQgnhScp0UL7BWWR8me1jctQn8NaaUJR
 FfRkBA4TwhR5h/tu7EJH2UI2RWnT2ETQHT2bZzNQ1gixB9rv7NHAEn1bXRUxOw==
X-Gm-Gg: ASbGnctACvRsqlRMNabreBenImNY6m/8Qw15hsSkOip/BJJI4x53xZHLrFhpYT0YMnq
 AZbQLp0kU7N61HNG7ww7lKxKEbrQMioTq8BQcLfl8Ed7iW0PuTGZ8whZH5ItPzOZHLJaJY05dSK
 LX7zyd04DjukAcSLbB2R5Tw6b2rCV1wn5WhJFrF+U6JBm0AOTDLxq1ixKF+yEJ76Nr7hvghZqWi
 DmGu97SoJnJ/MuIhPY3Ycy2SPxw8ohG5pHoSrLy+P0b+VBGF95e6kfsTt5h6rnLkS3BVBBCF+Um
 xXNj9TTcEEuqOqy4fg19j1xhyXe6l6QVP8UHRRFwsL4kpL0E5GPbCUjw+U1xnJf9mDx4aX0M4ds
 iEOWtdGLx7ZOvZj/G9eetUTAi+lMo8qvPs+Os5+mUcpB06+1qArh3xZChc/WZn0K8tvMQF6l0Xu
 pRPA+9CxSpUJkRW3ZH7rNnQ5a//nrwj8fSa7h7s+DbsjRU+JpTrf5eralAjBFUGZ1Bry3YTtl/8
 fs8M3h4dKoFQb4Yk4BnzHefuggiYQ==
X-Google-Smtp-Source: AGHT+IETcQ0QqjtX+j0cbOpZU8qnpSbynNsJtGLpi8eUxdTxv2XZAP2dZQyHb00p+uKW4ITvO1Gc6A==
X-Received: by 2002:a05:600c:8b43:b0:477:fcb:2267 with SMTP id
 5b1f17b1804b1-4778fe521d6mr1333055e9.8.1763051630636; 
 Thu, 13 Nov 2025 08:33:50 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24E1AF00BA2088E69F553967.dsl.pool.telekom.hu.
 [2001:4c4e:24e1:af00:ba20:88e6:9f55:3967])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47789ffea1esm76376335e9.13.2025.11.13.08.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 08:33:50 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Ray.Wu@amd.com, Harry.Wentland@amd.com,
 Alex.Hung@amd.com, Wenjing.Liu@amd.com, Chris.Park@amd.com,
 Yu.Wang4@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/4] drm/amd/display: Follow-up patches to analog support
Date: Thu, 13 Nov 2025 17:33:44 +0100
Message-ID: <20251113163348.137315-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.1
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

This series addresses some feedback that I received after the DC analog
series support landed. Harry already gave a review to the patches.
Please feel free to let me know if you have any other feedback that I
should address regarding the analog connector support.

Timur Kristóf (4):
  drm/amd/display: Fix warning for analog stream encoders
  drm/amd/display: Cleanup uses of the analog flag
  drm/amd/display: Cleanup early return in construct_phy
  drm/amd/display: Move analog check to dce110_hwseq

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 ++++++++++++---
 .../drm/amd/display/dc/dce/dce_stream_encoder.c   |  2 +-
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c |  6 ++++--
 .../gpu/drm/amd/display/dc/link/link_detection.c  |  2 --
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c   |  3 +--
 .../gpu/drm/amd/display/dc/link/link_factory.c    | 13 +++++++------
 6 files changed, 25 insertions(+), 16 deletions(-)

-- 
2.51.1

