Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6530EC8303F
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 21:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E75E10E594;
	Mon, 25 Aug 2025 21:56:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TIVlp3G6";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D856E10E588
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 21:56:35 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-3c73d3ebff0so888687f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 14:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756158994; x=1756763794; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t4nX18GyEB5NaO4Oom+5TgaO5wyRSZYtwm4QWAXzUuI=;
 b=TIVlp3G6aniQh4Ubt+fg2VUUMzkjsitnhBpapEi82TLjIs2+O2ZsXiknt6nPOfncUp
 uMGlzjpE37Y60wjxUtybgSVvqwZN+X5z06MHXb9/fsI//Fcc8V4gS3/oPzk6mMx5JloC
 FVodlXl5ymeLb1pyHizxzQAiPy2KjgzGimiOZLT4S9EzTxxYL6oRzl7LaOhEtQNllw7c
 lA+xenP+dvFFrSa8od9ohDNERs7WQLfqesMpjUYk7S9kW0qhvV8sUIR8DaXoxcGp4Zpt
 xsc4GloWDDqAfhNkkVScdDIHUFNLmMaFo4W1aCDmBfcB+CRaj8lUOj9MStpTUUfc0CZ8
 fMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756158994; x=1756763794;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t4nX18GyEB5NaO4Oom+5TgaO5wyRSZYtwm4QWAXzUuI=;
 b=UPNEldMdBJu6WcPzq/V/RcsCb+6DOatEJKDwpHkNtDmu68PFkVvZyPNpnoYifywXg+
 gOHtmU0bgju4WhdokFQtWO/8R8kuFT6RbVX6KxixamYew8f4smHHv7gK5ZdG67kiNGiS
 c0cWdrsw1KgyhwESMHFJ/ad0dR6CZCyLuvTy/BtBCKm/mHZHxMG/rjRxhWURmeLIsdeR
 lcuw5uowKDTNfr7xLvBWBZPgNO9rhS8/Pu/kFMfIhTNSwxQ7IbHQjx4WEp98rUmJMfgn
 5rN4b5H/2jgjACkX+9X1oUytPve3yv19QgnblC3qkfK3Bv9YimAqXJl/B3L/ISUnn5kQ
 VfMQ==
X-Gm-Message-State: AOJu0YxYXrZ1ttBELYW+TE1M6ej31aTARaZdS3cuhWuWy4A1C7IHsGY3
 a6biZERjqaUdQo2teODDMyCiTX8EPFjrqa7157R6TN6tgihJ0+fQWeiWqRJh0w==
X-Gm-Gg: ASbGnctVMDNam0rU6kq4Iw4TF7EpLToWMlZ7DK1amX4V/ow/QXjLb7uMzKNyec/x/VO
 LB1g/BvtMZSuiqYnjTtC/Nyx6gT4/PNPRpOY3fTYqxTKL0HzMjlKFxHiOhmeSB2luhbBpNSeXTX
 lzTTwP98WkaPC6R4Oghig5Bjj+LJDyte4gYp/O2w/PwoXal88XicAHKsuv+I3xCEmWVrkR+7R6J
 wqNgy+5DrlaCX8g7mt37EaGqhgIeNfQV73vaUYRTeJiohdkVbPjTtNT6uipFaXMkiRDMEj7OuzI
 Xjd0CI4VM47WlJCz7S1pTu1M/QlLdQLFzCV/WeAdl4WHW9RLeiNtSWhCysj5E0qwHADijoQgRRz
 jzZNaJF8D++CbXUyKlRcGL8ohwKt2nc9c8J2iMx6Jy2wbJTD5xY6MIgrC9Fiw0zCnkTF+oDeZ5o
 nOp/ylv46K/jzbQZqXcKu4Po30HA==
X-Google-Smtp-Source: AGHT+IFO+4f54zWPhp36KEfgyTqPN9r9+TvDM+vuEGmj3IPejGkduP9LRlIhmX6otMNwqVd46g+cqw==
X-Received: by 2002:a5d:64e7:0:b0:3ca:ca52:ad82 with SMTP id
 ffacd0b85a97d-3cb5ba6eeb5mr23613f8f.11.1756158994338; 
 Mon, 25 Aug 2025 14:56:34 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b57499143sm121827575e9.26.2025.08.25.14.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 14:56:33 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com, alexander.deucher@amd.com, harry.wentland@amd.com,
 alex.hung@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/4] DC: Fix page flip timeouts on DCE 6 (v2)
Date: Mon, 25 Aug 2025 23:56:27 +0200
Message-ID: <20250825215631.628949-1-timur.kristof@gmail.com>
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

Compared to the previous version of this series, v2 fixes
the rebase conflicts on amd-staging-drm-next and includes
an additional patch to address page flip timeouts when the
displays are blanked.

Currently when using DC on DCE 6, it produces pageflip timeouts:

1. When displays are blanked
This is caused by (mistakenly) turning off the display engine
clock on DCE 6.0 and 6.4 which is also the DP clock.

2. After suspend/resume
The root cause is that DC assumes that the VUPDATE interrupt
is always present, when in fact it isn't supported by DCE 6,
which also doesn't support VRR.

Finally, there is also a patch to disable fast boot mode
on DCE 6. The rationale is that this already didn't work
on DCE 8, and even if it did I have no means to test it.

Timur Kristóf (4):
  drm/amd/display: Keep PLL0 running on DCE 6.0 and 6.4 (v2)
  drm/amd/display: Disable fastboot on DCE 6 too
  drm/amd/display: Disable VRR on DCE 6
  drm/amd/display: Don't use non-registered VUPDATE on DCE 6 (v2)

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 26 ++++++++++++-------
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 16 +++++++-----
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |  5 ++++
 drivers/gpu/drm/amd/display/dc/dm_services.h  |  2 ++
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  6 ++---
 .../dc/resource/dce60/dce60_resource.c        | 11 +++++++-
 6 files changed, 46 insertions(+), 20 deletions(-)

-- 
2.50.1

