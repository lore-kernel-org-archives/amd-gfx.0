Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115E1D2ECE4
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 20:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9824310E50D;
	Mon, 19 Jan 2026 20:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T7tKDlbi";
	dkim-atps=neutral
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71CC110E50D
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 20:36:32 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6505d3b84bcso7057105a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 12:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768854991; x=1769459791; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CBrd08rdxb/naClZANJSRSQTT9pksXGuvvMxfWxyhWs=;
 b=T7tKDlbipmEf/LkuPZ7y3Z6Tp6I3NqBNbjlvoW0mixgoKjJoIX5IZy1mVeboHNeBu/
 pYXj/SxVLluIWMXMB5gjk+Bx3h1uSX9R9027q+tJZ+7d0S+ka3iX8GDYExsT4RgZOo8M
 D1YWP2HzOlDYX6cKNyJVdOycZLiDba2NfsxEEZmgeE6jDklMxfvDmvwcMx3c1jx+58xX
 3X9uU/E7u2Xi4owz6K4iScNdpNGCteottgOArmAvf6DTj7jxlUX7+Xf6j5c68tgQO8rO
 6Kkc0xXZ1Iz2Bj8VQXUhmsLT8fCh/sOGNHBQpb1sIPdTziyLdYJsE7g0vPVjlNoAK6XO
 q+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768854991; x=1769459791;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CBrd08rdxb/naClZANJSRSQTT9pksXGuvvMxfWxyhWs=;
 b=dvkDkmuzJYksTQGtKiyoYOzy4eg9st0Fjv5RoAapn0Qd2ZpyJhgP0oLKn9HBYbaAXl
 bAeJ0UgTJ00KVqcNOX8xisaD3xUuNG3j8rpAzsbxn6xb116plx8UMPnKOqGHC0QrZLNL
 4cl9flM5ohiTctgQFd/pkjBl3Su5NlkkrJ3nnPFyo3YRLtMA5c9uZi6+j3esnCaroU3t
 m1GjYNAVgzLBriXP5dw549xPr69n17wCmAIlG87Cfr1wOdI5ZdF/HBb/SOMuB52GjPQ4
 rExHXLYvsb1Rits5dK803sUcPnzplpflmiCoMntpMEE9CEFqWsda1ekuY6XPLIBCh8U1
 4J5g==
X-Gm-Message-State: AOJu0YwXbIViBZHfG5Wqp7+w/kiPNG8s2svJ5JDKMBp6BTYamRQR17dD
 A8jQagh0sRGtrcgV+wleScKtcKfD+2HwYNoZOllvfUGMC79x7YHxOnTNQa9pAQ==
X-Gm-Gg: AZuq6aJsfMHogNVJOY4M0Am/ync1WDkgKS65bvImBdiNeXj4plxkEzHJY4N5aiV62k4
 S169H88i11yrYax4soJ5JWpTaVBj29h0GL3vp1G1bj0H7TlW0Y9GFNEcvM3tb6ydq2Qvb4PruWF
 JydqklD+37MkLprNa9+0RZeVoWyJeAPp2Z5jIB5e7tX7qOOj8G3bUTgTtL0NCJc//20Po64uq7e
 fp4adFHoroVf7jJp+pk06g77WfleC4ddQlFSdKNLiBXTGcUSlMryInfhZybDWt4RWDo5Cvz0Q0N
 mLy7ZqzCNcuwmyVbuqjK9JyrM7VxSdHYa27oI9IhXxFH7cWoDN/AAp+ie/On6wkLV2NQUb59lmq
 mwCqiLJmaoT2KGLafaH61himokcohNMZyIviBAt8iAZHPTrh78YuhMQDpssvjFI8XyxC80n3ARH
 f1DSYc0xQXCKMwHevQpdMhEAAAvHP2TUvU3aG5R6rLxS8eEOk04ssw/OTBcxUDbzgjen+FSUnsr
 hG19Znm5/Ju
X-Received: by 2002:a05:6402:5215:b0:64b:48b4:d71f with SMTP id
 4fb4d7f45d1cf-654524d41dcmr9405731a12.7.1768854990767; 
 Mon, 19 Jan 2026 12:36:30 -0800 (PST)
Received: from Timur-Hyperion
 (20014C4E24E47400AD77F2CC91C9A6FE.dsl.pool.telekom.hu.
 [2001:4c4e:24e4:7400:ad77:f2cc:91c9:a6fe])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65452bce213sm11375492a12.2.2026.01.19.12.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 12:36:29 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Prike Liang <Prike.Liang@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/5] Various SI power management fixes
Date: Mon, 19 Jan 2026 21:36:21 +0100
Message-ID: <20260119203626.16070-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
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

This is another attempt at fixing a few SI power management
related issues, including the Radeon 430 powertune issue
as well as an issue with power2_cap that regressed recently.

Timur Kristóf (5):
  drm/amd/pm: Fix si_dpm mmCG_THERMAL_INT setting
  drm/amd/pm: Don't clear SI SMC table when setting power limit
  drm/amd/pm: Workaround SI powertune issue on Radeon 430 (v2)
  drm/amd/pm: Return -EOPNOTSUPP when can't read power limit
  drm/amd/pm: Correct comment above power2_cap attributes

 drivers/gpu/drm/amd/pm/amdgpu_dpm.c        |  2 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c         |  2 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 31 +++++++++++-----------
 3 files changed, 18 insertions(+), 17 deletions(-)

-- 
2.52.0

