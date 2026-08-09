Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A76CC5AC82
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 053FF10E6AB;
	Mon, 10 Aug 2026 06:42:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="icJ0yLkq";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4864810E10B
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Aug 2026 08:49:00 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso1248280a91.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Aug 2026 01:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786265339; x=1786870139; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qSsyx07rdbg9BS6CDdvM5aa6FHTdoOSpWof0piChyTs=;
 b=icJ0yLkq6XRywZnrAA6KOci2aj0FcU7CWc1t/0745qrdQ4q0qKmKVi4/qBWz3Q+oGg
 7+hcr1PBJV55udWS6/cmKMwxsrFo8bYarpEXsPtmUlhsHBWeGyff7P5ALIiNDi0/8U8c
 fag9iNCt1cFxagaBSKFEX/IZk00y25oZP2Tw50L5uzUSQAWt9HckUAAkDEj2uvWsfiwN
 J7d7Swq8tYyUeG8kZF01MfOknVVlSUGHok20MjP67z0tksjUtvtI51HUJq3yktI5ynEq
 yrmH8eiq/CLlQSJV2Qk1ti4CAGvFdGQIopFU5eyUzucXZ8ZTSt2i2Qchn8hsNWhLXLSE
 8p8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786265339; x=1786870139;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qSsyx07rdbg9BS6CDdvM5aa6FHTdoOSpWof0piChyTs=;
 b=j0yJ2jjwlCkCVAEbJcfjrYWdyAXSWKOKxzJ8+iH+nS9QrF+NkNdXoev+eMjszXo4fp
 rXpuOzp0Y62tmQkD51PZbOn9LXSod63WuyusMgIOlxKN5UyMoN1bYMNgwqNLHUw+aiUj
 RvswRAdfUzxg2px/sDwhedA6CQ25nPVvut4d0kNNhcP66fEx/DoFj/4GBL3SDGxRA1uB
 P0GtgR+WoG77twFVB5//JkRnbSrFA8r/ymtTfMBcKZ73cYYs0bb5M21NxcB/6p+RKCDs
 Crs/i67Re6hCGJ3iZUL3nI96sLcNJTvsq8CQH1z7naUH16xElWesHGm2N+dQpWDOn/yz
 WytA==
X-Gm-Message-State: AOJu0YzOFFGA1LLZxrpjX/7h9P9EpJC1Ukb/v2b0fSc5v7kMy0WY9ai4
 jzCDetXYcxcHv4qk2IoCe1u3EjlK3nQZPU+i94qLF+Cc7b6kmF7zTpnN
X-Gm-Gg: AR+sD11RGr5Ypv3tS3FdVhRaZcPH9s9infFETaYk/m5jLtUwglq5NaCcTvimTPwQ/CW
 Ttnj4AOJ+L2CEY7d/1t/bP4NKXDcnzesKpvkZr5mAFaxbjv8os9FFwUbFzg9XHa1tnIpYan+JeY
 WpmNCcB/NxuQ+P9sbj4czF3L5Aib2XULCJo0sCWAHqw2xeIhrYjFayXd01FeVrxY2tsL9rwi3HU
 P0xT9BE7H4tJXXjPM0VOqw8yV+vV3TXvc3nBJJsu2Ng5SeHQO3cBX4iZGCTPPyhWjH+ARLTf+Cn
 wXvo+xDC+FVlBRlLau1gYX3YxICgYd7X0ZgSSkFe65AivXOlrcchHWCS6pGtlC5+U/2vwjCj1y8
 jPop7pn7zPAju9ZlyxQdSMUAXYSKJUlmrS1P4RdHeXwFtdyHlvsdLv3i5FTAlYUVbQWO01GMCN5
 fBCDdkcFvoglJo4j0Ra62HuxvcMGToWHxGQtNaa+11meDOo/4TTXz6MDEk8yEZsCLLHzH1Pp3ee
 lc7FIMmolM=
X-Received: by 2002:a17:90b:2585:b0:38e:bbf1:de34 with SMTP id
 98e67ed59e1d1-39261fdab5amr18507599a91.7.1786265339360; 
 Sun, 09 Aug 2026 01:48:59 -0700 (PDT)
Received: from localhost.localdomain ([103.178.205.91])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86fc7bsm28800025eec.1.2026.08.09.01.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 01:48:58 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v4 0/6] drm/amdgpu: Robustness and safety fixes for ACA and
 RAS drivers
Date: Sun,  9 Aug 2026 08:47:29 +0000
Message-ID: <20260809084735.9743-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:03 +0000
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

This patch series addresses several race conditions, boundary check
bugs, logic inversions, NULL pointer checks, and buffer size
parameters across the AMDGPU ACA (Accelerated Compute Architecture)
and RAS driver subsystems.

v3 -> v4:
  - Patch 3: Wrapped list_del_init() inside mgr->lock in
    remove_aca_handle() and moved node unlinking prior to
    aca_fini_error_cache(). This prevents infinite loops during
    concurrent list traversal and stops background queries from
    referencing destroyed error cache mutexes during teardown.
  - Patch 6: Updated subject and moved cancel_work_sync() and
    cancel_delayed_work_sync() prior to
    mutex_destroy(&con->page_rsv_lock) in amdgpu_ras_recovery_fini()
    to prevent work executing after lock destruction.

v2 -> v3:
  - Patch 3: Updated amdgpu_aca_get_error_data() to return 0 instead
    of -EOPNOTSUPP for invalid handles, ensuring global RAS error
    queries safely pass through non-ACA blocks without breaking
    telemetry.
  - Patch 6: Moved cancel_delayed_work_sync() in amdgpu_ras_fini()
    prior to ACA subsystem and lock cleanup to avoid teardown races
    and UAF.

v1 -> v2:
  - Patch 3: Updated remove_aca_handle() to use list_del_init()
    instead of list_del(), ensuring list_empty() properly evaluates
    removed handles and avoiding potential UAF during device
    teardown.

Sreeraj S Kurup (6):
  drm/amdgpu/aca: Fix race condition and UAF in error cache logging
  drm/amdgpu/aca: Add upper bounds check in aca_bank_hwip_is_matched
  drm/amdgpu/aca: Fix inverted validation logic and list cleanup
  drm/amdgpu/aca: Add missing NULL check for banks parameter in
    aca_banks_add_bank
  drm/amdgpu/aca: Fix off-by-one buffer size parameter in add_aca_sysfs
  drm/amdgpu/ras: Fix delayed work cancellation order during teardown

 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 41 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 11 +++----
 2 files changed, 24 insertions(+), 28 deletions(-)

-- 
2.54.0

