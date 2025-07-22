Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892FCC83F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 15:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AB8189BEC;
	Tue, 22 Jul 2025 15:58:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BvtOzeLj";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9E5689BEC
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 15:58:45 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so43408265e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 08:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753199924; x=1753804724; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GrbihPN9MAxE9yUdOsYT7NbRyZLFYtKUypgZMqXB3ik=;
 b=BvtOzeLjKW+AbyGC1Y9tFyQw25op5Fp6sSSCdecvZwb4ugjFAHYFbqi1s6NDp2GScT
 oq4LFHAPmsrkabUIfRS0tDZmmkdATBKpojkFswRHUhnQ6+4X9FLfdW/UtAMMv1kXg+Ai
 zhtR/mMQ5y1BDaCiwzzFFJbWZhru9vBHUDXqfulfjDdH1VzvZ01gBcq0/hwOwsOHqn9f
 ZSz00oy64E9GO0Tg7t8OeMuAnqEmODddG4FNe5X931coYwMO+3nnNJM5pJUDxhLXGRlP
 xUX5Ri0xbBa2rdjOLsstS51g3NuVQ/DA5LePPpny6FzZTI1zKZfk3uvM6xXkZ19ZZpHZ
 cf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753199924; x=1753804724;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GrbihPN9MAxE9yUdOsYT7NbRyZLFYtKUypgZMqXB3ik=;
 b=ecSRj08xH7ybEs8GJiae8CHPGK/G+yPoDcJuyFY1iweNStHwzpipdGRgXrpeBHqp0G
 ujefnkjqmaBUCc7mPkdwoy8ezIAuiq5Okm03uxLK1JoK3mediVR7RmGh9sQBHLQuG9bg
 ScsbtacUuSwCUIRJtjFa8aypBwMNXTNg6OmTFexkmJcQ3ysfsRpH/AFsgTG7A+I57tsC
 xoFO2aRdApbXVW7wA1dwPAyzcrOZZa7WeFJEvua69ybWpCogOTatr0kNTdNh4UGzey62
 DePN3298mK11oUGU8xjwj5/PSJCQn0SUYZUVVWozOZHPXi1OrmQJaH8SZ9sbnmtXcq54
 WU7g==
X-Gm-Message-State: AOJu0Ywro/8DcyybRnfmv4Hn0HZvRxWP5y2ya9ba4zCUOC2XDesQ2jfi
 pq0MqZEJGRTDvULIF5iTuKWLSS4+4tzg5cDZYTQNQtUR1JieK4wqdUy/vXftFQ==
X-Gm-Gg: ASbGnctWkUa5+gAxZ7A6PBF0VcsuflTriuhnN8nv2R0e5wJQuKdnEsmvNo5yy2HnGIU
 wJW+CeLVTSnSaIX7u41dZ6CQoznOrfYYJdbk2rzjViZXaeoHInTWqlAvexsXZU+1Db3hI7LQfn+
 9sfHEhrmCQFNoJ78MA31npy05WnNN6D7gPOwTau9IORZgqN5Y3koUzGBgmwFIimi3r5QXOW+Lzx
 soOXBVw67VTEu04R3YmnNWWKFTFx8QLLA6Z/jVYMRIamBTDZuRwof7RBR5h8P3ehYeRqMMI02VA
 QQrHMFIQaUwVdYrs6PdkU6Jln8/UJTJyBct7s0hwmc3dd7CUtfcimj2UtCzL5pqjffKukmA5jQf
 1A0AiGYOPxiCkGHpw0wPq7REIEFaVRQ+5u2TtsBSi14A=
X-Google-Smtp-Source: AGHT+IFMYCdpYyhlXXc81JaEEjUP3EXpFsVhbimFZUJvHXr86TAZUC1R0igGLGF1kbCqKLlSw5tlqQ==
X-Received: by 2002:a05:600c:4ecd:b0:456:fdd:6030 with SMTP id
 5b1f17b1804b1-4562e373d83mr242508695e9.19.1753199923767; 
 Tue, 22 Jul 2025 08:58:43 -0700 (PDT)
Received: from Timur-Hyperion ([2a0a:f640:1810:c696:604:c93:8102:bad7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4893fsm13948241f8f.52.2025.07.22.08.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 08:58:43 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/3] Fix some DC regressions on DCE 6-8
Date: Tue, 22 Jul 2025 17:58:27 +0200
Message-ID: <20250722155830.67401-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
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

This series fixes some regressions in DC, mainly on DCE6-8.

There is a fix for a recent regression caused by refactoring
the DSC cap calculation that affects DCE8-10,  as well as
some fixes related to clock sources in DCE 6.

Timur Kristóf (3):
  drm/amd/display: Fix refactored DSC cap calculation
  drm/amd/display: Don't overwrite dce60_clk_mgr
  drm/amd/display: Fix DCE 6.0 and 6.4 PLL programming.

 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  1 -
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |  5 +++
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 17 +++++-----
 .../dc/resource/dce60/dce60_resource.c        | 34 +++++++++++--------
 4 files changed, 34 insertions(+), 23 deletions(-)

-- 
2.50.1

