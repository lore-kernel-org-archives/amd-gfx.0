Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0215C36000
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 13:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B58510E7CB;
	Fri, 21 Mar 2025 13:02:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=swemel.ru header.i=@swemel.ru header.b="rSjeqTRt";
	dkim-atps=neutral
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CBC010E787;
 Fri, 21 Mar 2025 10:52:41 +0000 (UTC)
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1742554359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MYBXdsWrAF4XCKt8xl9DU8RcwjIds3O8UdltDFshuKk=;
 b=rSjeqTRt0mTYpqOTR0+1Vu5QEr94xolka6rqV4VbnE5GmqKCydNSZgOZS+tlC1ZC3qtjZR
 FmeonyU2Fx/nw/BBvRPXc4c/wxvU2PnYW00x7Qjf58khxdbvqp3Qjxg9u50FIP1tqpuf7D
 7flH1Ehi9gu375DpWFNwHMpzHekQu9M=
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lijo Lazar <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: [PATCH 0/5] drm/amd/pm: Prevent division by zero
Date: Fri, 21 Mar 2025 13:52:30 +0300
Message-ID: <20250321105239.10096-1-arefev@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Mar 2025 13:02:22 +0000
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

This series of patches prevents possible division by zero.

The user can set any speed value.
If speed is greater than UINT_MAX/8, division by zero is possible.

Found by Linux Verification Center (linuxtesting.org) with SVACE. 

Denis Arefev (5):
  drm/amd/pm: Prevent division by zero
  drm/amd/pm: Prevent division by zero
  drm/amd/pm: Prevent division by zero
  drm/amd/pm: Prevent division by zero
  drm/amd/pm: Prevent division by zero

 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c   | 6 +++---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c | 4 ++--
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c          | 2 +-
 5 files changed, 10 insertions(+), 7 deletions(-)

I did not change these files, because the functions you are 
interested in are not used there for a long time.
drivers/gpu/drm/radeon/si_dpm.c
drivers/gpu/drm/radeon/ci_dpm.c

-- 
2.43.0

