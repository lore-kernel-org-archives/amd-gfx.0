Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38963CD4F39
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2026 12:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE2E910F19F;
	Thu, 14 May 2026 12:46:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="SSKmkPjx";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F29B10E0EE
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2026 10:38:26 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-448528f4e69so4524954f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2026 03:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778755105; x=1779359905; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xH2MsNAwWrhYQsE2/lBrkUnmS1ax7tifBlnFAGvQnY4=;
 b=SSKmkPjxM5h3RJgqZ1100XxdkiWk/v9xm+9elZc1pDtNr7yJdSnk36cpQG63qRaf+E
 m2Rcg5+QXkTkf42CsqiV7T+1y2EZCD6O1xgGvw8qro+BT9OtIj1kUDwmgjM15WU2RiIz
 ihvsGzTov7vrM3OM8x1zNBfu4NWeC7oEgqQedjuTbcMukahZu3/rJYxJKL56qA9BlJgX
 143AlW5PZHStMbLwBP6d1sSHmobNkqZdFIe+AQw9Q8DS1d6X6/Cdss9fBenXfSHAz/LQ
 rSaxO59iFMf+SHoyK8QRdPEQFSddzWquSppvzEy57672XlebQV2W1Xoht+ngoAy8nR1g
 KUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778755105; x=1779359905;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xH2MsNAwWrhYQsE2/lBrkUnmS1ax7tifBlnFAGvQnY4=;
 b=sYKD0GPJ9ImSBH5vxM5hLuYi2vBe4p8fhJJra/n2gsr4iw3ChzTwVNQF6hoE2H2Q0m
 GR/i6w7JTApoO96K8Kj8GDHtAtou+YHxShlO7yD6lgQOjbs47D747kM/H/ig9d/G9p3t
 3AF6OiqZBSx6i/vb07RrAH7X+FHHYY22059S96DaOZU6RulGU99IyLr5qGphxVC+/KpA
 KVD2ATWcrj3+ftfUH4C+55Ve4D5IzEhRj+RXNBLKpIn/eJTd4gwO7OUK17MKAfVOADt5
 q/700KV/CmZT29uv//y7HtITvYpw23gUI5zG6cNg2Bw7qKGS6w989uVtp4lLBD80GaGG
 bCNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+OUfJY0COvOxzQt6McOiIuss241v5VauiAmTo3RKG/szqQ6jl5OqE20p4vSgDBs9W/FKvk/LGL@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwOn6hPfb3soXZpbS6pEhRzZQFae+m0vr40pWPJKY+2DlbGrwQv
 lNPgXvDJ7EeUVfiFdlSu6iStF1zVsZkVa8zWe7JvxR+Xs/8mmkQqzAGNhgJAsQvbh1w=
X-Gm-Gg: Acq92OFLh57mo2o450wSyU78NWLNYHjuQd4xEC2FCQkqkzRlIJK03NWIxKBK397bGvR
 RhetnIbxuWdUGgqQmdka19Pu9+NbVYqlLLHoh/OG1PC5joB6wjIdf2mt9VWuzLXwqsr3qPtIC9P
 QdwZ8oJRJHgWwCa0cNlLhn1smxsu1Aa1uC40vcYEaKk+61XOG0j5AUyuMeZwFSTXz5al4c+dlr3
 DJ8X1k7LyvYeVBF25yRi50IOUlWUQQ78N02xveeu3wR7y2nbMn+Z2ZQ+R3Gaa6iPWu6KghlSFDg
 URagwEzCiYnGGZRIv0U+PmoD7DSxefoBgdY+LnYHQYEvhpCnm1DvwybNz6kpPoEYM4Sf7+cUZw7
 yyXCjVQJdy8FUkBjFkXWH/G/ZCo9njWuRtSSscn7aAA9fJNOC/3EuRb0UFebhWxOabnLjeHsks7
 2/bPkOWWUqhnE33nlxPi70YR3lpvnHtbOZjVadOK7ui0fRLOQ=
X-Received: by 2002:a05:600c:37ce:b0:48e:62ec:f264 with SMTP id
 5b1f17b1804b1-48fc9a30cfamr126340005e9.17.1778755104690; 
 Thu, 14 May 2026 03:38:24 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd64e2132sm57788365e9.15.2026.05.14.03.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 03:38:24 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Ray Wu <ray.wu@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 0/2] drm/amd: Replace system_unbound_wq with system_dfl_wq
Date: Thu, 14 May 2026 12:38:07 +0200
Message-ID: <20260514103815.190628-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 14 May 2026 12:46:16 +0000
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

Hello,

Months ago we started a refactoring work about workqueue, still ongoing.
Recent changes in drm/amd/ code still uses the old workqueue names instead
of the newer added. This series addresses this, without introducing
change of behavior.

=== Changes to the WQ API ===

The following, address the recent changes in the Workqueue API:

- commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
- commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The old workqueues will be removed in a future release cycle.

=== Introduced Changes by this series ===

Replace system_unbound_wq with system_dfl_wq, without change of behavior.
system_unbound_wq will be removed in a future release cycle.


Thanks!

Marco Crivellari (2):
  drm/amd/display: Replace use of system_unbound_wq with system_dfl_wq
  drm/amdgpu: Replace use of system_unbound_wq with system_dfl_wq

 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c      | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.54.0

