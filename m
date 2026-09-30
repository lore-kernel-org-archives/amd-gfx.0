Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187BDCA5FB3
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 07:17:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B318610F59E;
	Thu,  1 Oct 2026 07:17:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jUPNRH9e";
	dkim-atps=neutral
Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com
 [74.125.228.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACF3910F422
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 14:28:40 +0000 (UTC)
Received: by mail-pz2-f37.google.com with SMTP id
 41be03b00d2f7-cc7cadbe09dso703424a12.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 07:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790778520; x=1791383320; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ub3ItDFWWUJig/RVRQKmIzmWoY7xODGq9ETYrV07aDs=;
 b=jUPNRH9e8Mrjlkz4LAGWsKLgUZo7gZIEw4j5UC1bMyQe/Sso5pKH2+8BALx6EChMyz
 avFUha//MkjG1aWRqTxC7LCth4cGC1Ppud9ShhCgHEyV1mSler6Wtq+9Eoh0tNEisWpr
 vTMW1R1Md1zhcgL99qW6nP1GbEVYw8zBmrpTtGn6wq+oiRdk1uudHr6TM9W7afu9+X0T
 nE2hILvWR7KDhrf+9o3MH/C0FWJn3hJzUDRWifLt3JqhSyQlKMUzfMwV8QUCm/9Yr3Rq
 Vp/I1idt2aNCkXTtGzyGckn/yo36183NGDgjlsPt4UCiDG2dawyIcE55j+JQ+K5LD+N9
 0YdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790778520; x=1791383320;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ub3ItDFWWUJig/RVRQKmIzmWoY7xODGq9ETYrV07aDs=;
 b=mHQJa+b0aSXtLnmu1waTV/0X3Qc8LUU1ZvDTiXFbEvtk4FZ6WHgk/HHfagYMeyJzUc
 ZD+Pcl7QRb3sx+ctESp8tZqcz2F2ZRLRFcFFB7cl4yO43EuKaOS6oy8Pjcflq98lAJTN
 Kn85yKEYEQt6DAbLeRJ58z2ZPsfX73I32uG1DgMRpCtdrX5Y8avB4woses2NJLkoRdZS
 ikw8nYGJcWb64E+MskqPOsKAxzi1q8zaD7Mlh8/WgOCbBLJf0dx+tGhCxr/9aqsB//qN
 hailwHEIyti2VzeP9cRl2xnQ9vdnIpRRllexKiKRx3WyAsu7O77cN5hjDmMYmv29mfTm
 GQZA==
X-Gm-Message-State: AFq9FYIjuwUay0x3b6MrCLXGy2wF6m06yIqM6CtLxNuEWOaTnh04YGdC
 hgWoo6yPA9vHizFJyYJRzvzxYg57s3A24GjxKdScIg3u3KK1Kq35hKGZ/7sEv18Tl5k=
X-Gm-Gg: AYBFou3XVm6fDh2QRSVJ2hzeQET+RuOKvSSWt7Ne5E1vkS1WYA3kzwmhtQEJF8blaZJ
 mefgpMAZKFymStErTivtTU3dpVUONg1jXRAjFhJBO6All4gqGdOtvMfzWu0zZdT22isXlpCklXK
 jrwrM08e6mxkS9UDV6cNOQJX4Vf1sG+n/WQQfIUrmrWevSY0DPYEftnFUfFVxSAOYE7oxIhetZN
 TQ+21AkaAKrm07Va0AbAM50hN0DdVSUq6j0cs+geHOvxkk0L9e5W9nAusKrTyRjtmrGF2oPgfTD
 dpwRPAtXFBk6lDFwTUw7oFnPtFjbSyuN6KbrT/Ly3u2OBvh8ZKkoY3gSnZibntakJyS1DFT1V48
 /wbktKqVj1VXcQ66v1fDK/oPvPqksZgUcic3eMHhxfVPUeuo+WcIOig68pE9irKX2KOuSARW7qt
 PlpU74tN4glL22N2ws5VQ0wC32/vt79isT16n+92wCxIUfShkgayyJJwnBC2DdxVNQQ7Wn5ZgoE
 qdd1Wj4FF9+QtDcGw0oN+Pc2gIOOR1rOXhLpb5e7ZX3pjsO42Lp7Oq/FuBdzdCw13AU6iI29hF5
 e+fv
X-Received: by 2002:a17:903:3c26:b0:2dd:ad73:5b6c with SMTP id
 d9443c01a7336-2e2e49be8damr14622625ad.28.1790778520005; 
 Wed, 30 Sep 2026 07:28:40 -0700 (PDT)
Received: from francomeister ([138.84.137.76])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e2e5b89fd6sm8632405ad.26.2026.09.30.07.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 07:28:39 -0700 (PDT)
From: Francis Marlou Pacaro <pacaro.francis.marlou.n@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 Francis Marlou Pacaro <pacaro.francis.marlou.n@gmail.com>
Subject: [BUG] drm/amd/display: drm_crtc_vblank_get() WARN on resume in VRR
 off->on transition
Date: Wed, 30 Sep 2026 22:28:14 +0800
Message-ID: <20260930142814.142832-1-pacaro.francis.marlou.n@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 01 Oct 2026 07:16:44 +0000
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

Hi,

This looks like the same WARN as drm/amd issue #5883, which I can't
comment on, so reporting here. In my case it only shows up when
compositor VRR is enabled, which the issue doesn't mention.

  https://gitlab.freedesktop.org/drm/amd/-/issues/5883

Hardware / software:
  - RX 6600 (Navi 23, DCN 3.0.2), single DP monitor, 1920x1080 @ 240 Hz,
    HDR on
  - CachyOS, kernels 7.2.2 and 7.2.8 (linux-cachyos-bore-lto),
    KDE Plasma 6.7.5 / KWin Wayland

Same WARN, same resume path:

  WARNING: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:10219 at amdgpu_dm_atomic_commit_tail+0x1fcc/0x44f0 [amdgpu]
  Call Trace:
   commit_tail
   drm_atomic_helper_commit
   drm_atomic_commit
   drm_atomic_helper_commit_duplicated_state
   drm_atomic_helper_resume
   dm_resume [amdgpu]
   amdgpu_ip_block_resume [amdgpu]
   amdgpu_device_resume [amdgpu]
   amdgpu_pmops_resume [amdgpu]

(Reported as amdgpu_dm.c:10114 on 7.2.2 -- the same statement.)

Unlike the GitLab report, it is intermittent here (3 WARNs across ~30
resumes in my retained logs, counting "PM: suspend exit"), the monitor
always comes back, and nothing follows it (no vblank refcount,
flip-timeout or put-underflow messages).

VRR correlation:

All three WARNs were on days when KWin's VRR setting was enabled
("Always" for the first two, "Automatic" for the third). On the two
dates in between when I checked the setting it was "Never", and no
resume between those WARNs produced it.

That fits the code. In 7.2.8, line 10219 is

  WARN_ON(drm_crtc_vblank_get(new_state->base.crtc) != 0);

in amdgpu_dm_handle_vrr_transition(), inside the VRR off->on branch.
With the compositor's vrr_enabled = 0 (and freesync_video = 0),
get_freesync_config_for_crtc() leaves the state at VRR_STATE_INACTIVE,
so that branch -- and the WARN -- can't be reached. Presumably it
triggers when the resume commit restores a pre-suspend state that had
VRR active.

If it helps confirm a shared trigger: it would be useful to know
whether VRR/FreeSync is enabled in the GitLab reporter's setup, and
whether disabling it also stops their black screen.

Thanks,
Francis
