Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AFACD4F52
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 08:42:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E609010E393;
	Tue, 19 May 2026 08:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W8PbIrKi";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3C1810E393
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 08:42:02 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-48e82c23840so25404835e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 01:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779180121; x=1779784921; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JuTb9mrv6IYSWv7eR3Y+e7bQVnq6tTfGs37LJAnhhEw=;
 b=W8PbIrKiVNASeHXHVEE8ZMDafxf64x7vRQ4lKAASTlYd3HGSH1KHEeQPrdVB7vWTYo
 fkgpRbkvPMSxHHogMT2nPrkMOzcp/ABwFbQ4rGPu+kRB9FuGMCt7OgOFv1E7IH9DlAIm
 yeTdhnOz5zOihPMXUGCo2A2g4nMIaRNAEeg9PVgntqwWWUhq+4Q7RTGBmTLiJDo5DCD0
 dgrAUomw6fVY5Xc9jcEk3m7bYokK+5HlHNA0En5G3fq/E15ttdDlTsNH81r4ThbxzCiB
 jVosZK3q0z/z9suJbWi2ds7+frOU3WnpPzNc0fOYQn0cBHZhwQNaKyqcThrbmk2orfXv
 cp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779180121; x=1779784921;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JuTb9mrv6IYSWv7eR3Y+e7bQVnq6tTfGs37LJAnhhEw=;
 b=cA0aN+I4145EX/2GIfEI6dxJusy4gIpJM/zXvlKTqqo6ooicMxvn7islSTE1gSuKGG
 hbWBMobC7ZvAgrUPPa0YvNpiNtlXVRtd+1UQxbm7XegupDcrcTxbSYZ68WpiMKBwMkLa
 xfir1CrcPasUw/TVUxNh+8bczXCuDDwlUulaF1VnCjCWnGR0jiGNqW3XaGRbe+f4asnG
 aMWoJhbW83jRuy9MrbFoVPxhFc0hu3uyJ5OJ4dq4k0qmjIlPpIHIQsvhWUaV6CqAyyB+
 B322tMlASlnk0wZ1T4sIow0sCxHaZ5JY+8oTG5n23HK+RbNz8CN5WbVJ8uGyXbNu+7QW
 31Mw==
X-Gm-Message-State: AOJu0YyDnpJs1XZY+o4SR0flYSPPdlJjEU76mmeFlI8+K408iwsWvPGp
 ZeZILAsYQlw46LrF02DyR8wocSqQDMtgGA5wBS8Lkef28zd2gXNuGYBx2rR+Zw==
X-Gm-Gg: Acq92OGShL0emozWU79xPPSesnlZUTw1Q6YSbEhzQ3sObI+l78UXZuFrhynWYA4RESS
 R+O9GuTvzBRDKfibbzzXkylKQ6lBAjRBG1AzBMjksexFw8nnf+kWkty7WvZji53Jn9eGmcYc5Nk
 TGrUOLhNH6SPRrBGRFa5g9wGaiaFJQQlbcVytQwDRxzOiXQchhpQ841WKKEloSjpjAJq7vP+wvZ
 y19kmXmKXVqtne57SwheroV/4K5olKbHhuhBxGIpGO4Sq0szZMx4ya28AwlnMo027e++R6RPMbD
 3u6/ui48naOoeTHGNuL+eGHTFxFY9DxLgDoyalFXjPyScDEVgzJnr1UjH+zhBZSZFU9v0VaFuO6
 dWQg5WWy+28dnFesczdrnUS8o9xjTDNAj2f1/SzoAbYwaH5AZurFbl94vFjQp2mj68rH5++7KRt
 N3Qjejt/8t0O+Ti+g7vCiHsqE9QAAz1IUMumXF+nSFiuPzCbH3brE5TGukRNxB8TnKVC0LYR1KR
 Vo=
X-Received: by 2002:a05:600c:8189:b0:48e:89f9:9408 with SMTP id
 5b1f17b1804b1-48fe632374fmr284697035e9.20.1779180121214; 
 Tue, 19 May 2026 01:42:01 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48ff2cb4ae0sm141935945e9.0.2026.05.19.01.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 01:42:00 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Jeremy Klarenbeek <jeremy.klarenbeek99@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/5] drm/amd/pm: Fix laptop issues on SMU6-7
Date: Tue, 19 May 2026 10:41:53 +0200
Message-ID: <20260519084158.72960-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Fix various issues with the clocks stuck on SI
laptop dGPUs:

* vblank mistake when there are no displays connected
* forgot to notify SMU about DC->AC switch
* inconsistent values in VBIOS

While we are at it, also implement the DC->AC notification
for SMU7 as well, which is supposed to work the same way.

Jeremy Klarenbeek (2):
  drm/amd/pm/si: Fix updating clock limits from power states
  drm/amd/pm/si: Notify the SMC when switching to AC

Timur Kristóf (3):
  drm/amd/pm/si: Disregard vblank time when no displays are connected
  drm/amd/pm: Rename enable_bapm() to notify_ac_dc()
  drm/amd/pm/smu7: Notify SMU7 of DC->AC switch

 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  8 +--
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  6 +--
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 50 ++++++++++++++-----
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 12 +++++
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 15 ++++++
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |  1 +
 7 files changed, 74 insertions(+), 20 deletions(-)

-- 
2.54.0

