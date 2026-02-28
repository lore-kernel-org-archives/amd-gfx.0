Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0D3FEE4EE
	for <amd-gfx@archiver.kernel.org>; Sat, 28 Feb 2026 09:19:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C04A610E252;
	Sat, 28 Feb 2026 09:19:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WVYRPjio";
	dkim-atps=neutral
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A773E10E038
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Feb 2026 04:54:19 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-79863ab8478so28060297b3.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 20:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772254458; x=1772859258; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SWHLiQPGuLNOIoRU+H9lZYNm5Ub8L3rxXj707dfRdFk=;
 b=WVYRPjio0rgWrk5fq893sAQ9rYd/GrwXImR8qKrzXiW/Z6nsSWWXoi8rTNSWikpoYY
 REEu2TlFe18ZbytfKu3t0w8uAgapeCvMnEYleP1IUdtYjcY9ECgWLqWkJdutBVa+tTQg
 ZKS0GORoGIqKExhUZRVU4l4o0GRVAhHJg1/ZVrYJ1FvnQ84PssF4qZVxolB60WoZDK9k
 s8OGQXSuHfzclBDmf1gy6UI77CFNTiChUdyywHduXEJks40UqKEWSFkhN4jRLSlfOREX
 k8S70mUtIDbnFQogoPC5UCIwvcVc5BQcznDvjhiq+6SEMjtiLjq6sHzGYLlkS/jBwdz8
 /+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772254458; x=1772859258;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SWHLiQPGuLNOIoRU+H9lZYNm5Ub8L3rxXj707dfRdFk=;
 b=JGwhmeMeH6uOKLppe+68yt0yivOvU/8bb7O6ZPng0PTylHWIQM0dpw+n/sWSuJ0rDy
 QbKqDK08csUzwL9NpUXuABBBZqEmVmXtkU3HTjjWEVv3GTjReatHf3e1sR+tw1o/7d7J
 jsoH0tlbInSkvSn5xq4PSxGvNg8r3lugsWJQCdAQJGJ9OBsgwRvBIETkerzkycUK6yYf
 lk9z46oprqCL8dkzI3sfBYX0bv98Sj9x4dQmzEi0TzW+b+h5oy7zpudMVAq4Q3QbbaaM
 /YD8ds2frJVNlzeSjpv7habvQNTMmOXMpBnxhb/8BcAXqn95MoPCXjlV5rr0lYPG7bAt
 NiGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhcuAh1hIhgk1DRfhOE9mTalAaMEl7Zs32dGUJG/NyfM/5G2EEoF9rHYiknPMFSLGpX9PrMCTg@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzxuVsNRm/8edSKpGIcfswQJweLXD8ftcMvjLVGnW+3ASCWvPgj
 wJMEmZk/EkSFU56vGrB/1/MV9e22o4DoiGU9J9jKAj8OEqoP7cpgX9sj
X-Gm-Gg: ATEYQzyd8WSUvgVefbgC3JyPuzxo6qdM/hHoV/+pX/gkj1FPdzD1IsjCnvHHAN+xP3Y
 mkz3Jvv3llsOKiy4OoPD2cfA8faWheDtALdt57o3DPiUgxUoVNtB1rwAhRRWcFnPhZxDGf88DCs
 CkeH2/nR+OtiCBiq4sWt8sq23fohvKnBNNuNT6DD60of9aGuPZ11Z/gPNC3RvyKNjRDIqHwGqWB
 xMG88Qo0y0zdC57NaYOZSiy0CG++ETj/4W33kqoGHh1kbJmsWTWn8xv5SQQHPpTKFRVtYKbCvgd
 XK4NSd2NnmaZjJJcMZtnV/3hx8ZrG7CMNkXKHHNLZ6pNPV9D2PSxx8IY0ClwpUZvCm0lZukGExu
 loAQuNyOwOmfqOzex9iscwZnqWC1QEUsewyBJH1kuLNPHXwDBwZq++TKWAu/NEOC1HqWdvPGS/b
 xJIirC1Ce5kdMavKC95klUTccUHScyeRVuRVKeodD5Bffl/DOW5tjmnA==
X-Received: by 2002:a05:690c:c50b:b0:796:2dfb:4af1 with SMTP id
 00721157ae682-798854690f5mr45220647b3.9.1772254458385; 
 Fri, 27 Feb 2026 20:54:18 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-79876bf8103sm29865967b3.27.2026.02.27.20.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 20:54:17 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kenneth Feng <kenneth.feng@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Hung <alex.hung@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lijo Lazar <lijo.lazar@amd.com>, "chr[]" <chris@rudorff.com>,
 Sasha Levin <sashal@kernel.org>, Wentao Liang <vulab@iscas.ac.cn>,
 amd-gfx@lists.freedesktop.org (open list:AMD DISPLAY CORE),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 for 6.112 and 6.6 0/2] amdgpu: fix panic on old GPUs
Date: Fri, 27 Feb 2026 20:53:54 -0800
Message-ID: <20260228045356.3561-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 28 Feb 2026 09:19:10 +0000
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

Because of incomplete backports to stable kernels, DC ended up breaking
on older GCN 1 GPUs. This patchset adds the missing upstream commits to
at least fix the panic/black screen on boot.

They are applicable to 6.12, 6.6, and 6.1 as those are the currently
supported kernels that 7009e3af0474aca5f64262b3c72fb6e23b232f9b got
backported to.

6.1 needs two extra backports for these two commits to be cherry-picked
cleanly. Those are

96ce96f8773da4814622fd97e5226915a2c30706
d09ef243035b75a6d403ebfeb7e87fa20d7e25c6

v2: Add Signed-off-by.

Timur Kristóf (2):
  drm/amd/display: Add pixel_clock to amd_pp_display_configuration
  drm/amd/pm: Use pm_display_cfg in legacy DPM (v2)

 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  1 +
 .../dc/clk_mgr/dce110/dce110_clk_mgr.c        |  2 +-
 .../drm/amd/display/dc/dm_services_types.h    |  2 +-
 drivers/gpu/drm/amd/include/dm_pp_interface.h |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c  | 67 +++++++++++++++++++
 .../gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h  |  2 +
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  4 +-
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    |  6 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 65 ++++++------------
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 11 +--
 10 files changed, 101 insertions(+), 60 deletions(-)

--
2.53.0

