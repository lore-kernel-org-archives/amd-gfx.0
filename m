Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF43C76188
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Apr 2023 19:41:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FFAE10E177;
	Mon,  3 Apr 2023 19:41:16 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 998FB10E176
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Apr 2023 19:41:15 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 bg16-20020a05600c3c9000b003eb34e21bdfso20550191wmb.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Apr 2023 12:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1680550874;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=orMdBEc3/RmwPvEOZPHju61Hcg5STsDr6ot7AN4t8dw=;
 b=Cs+8iiOkPMVQqjr1dTG42pLCMG/idCBMT+RzTM+FSwtEYqlYmaY1btysclzLkFZccI
 OpgkgUsUkT/sQOPVP36lZbqiyyFXhBeYn8NjeqlKa93SDLFh2xOUaRMSpDZXReyG7pBb
 01q6WwofKPyJy28k6p/Gg4p4Y2jQzndp/HICiTetGhkrH2GTatcVNynOTpLefu8P1AlX
 /UvbxeqU3q0FUcFXAkjpj+hwFgWsr5RKjtOmMBgcDZDdHt/QsGThDUFdb1DbmkaEKkAB
 TT5UWZbvZZRU+Qw/JXfGrImsV+bPJofZx5DwssLDXWt0Nst7ZSyoFbYWgf4F8AB7G56W
 D3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680550874;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=orMdBEc3/RmwPvEOZPHju61Hcg5STsDr6ot7AN4t8dw=;
 b=cupcWzjAnFOC6We5W/HaqqH+qwL+fBdVIzyO9skzvE8ZB/135axQHKd/m6WDrptMVE
 k+N1nnOO5StGZK0RCnv1TW3/ZU67ck8wPIGe0FzCxQYGpHzTBsFxMLDfFbmML51NpX/G
 PtrhbxTA7jyGVVexXTObETr8CehzFH1zEKvPMFHZ3NSFvFzGbUNZConF2fkUfsDkNA2M
 kq2SrnUD9q20WNytYRkn2iFgBvaP7VZrhoihqHjNDmQkGU2JrcKZycHDSiI9/h8F7LBe
 EoBobuuZyr+1xPVLl49PsnC5nhlMhklSm12ft122wuSMH+BLfGUL5kvGn4uyY2ZaGtjf
 3Tbw==
X-Gm-Message-State: AAQBX9c5lGbhTwO+jNiZw/TDftUWfSIdGVcEvpF2056AJ9H3zZ80ahsd
 8bVHpFDKTHUwIPEnfxoJibUVfQ==
X-Google-Smtp-Source: AKy350YMooipic8wGoMCR1fAHCdpyNNsyJhW0YLp85S1PDNq3G3+uBw99GFalgjrELqeQk4R5BNueA==
X-Received: by 2002:a05:600c:2255:b0:3ed:711c:e8fe with SMTP id
 a21-20020a05600c225500b003ed711ce8femr466489wmm.2.1680550873854; 
 Mon, 03 Apr 2023 12:41:13 -0700 (PDT)
Received: from localhost.localdomain
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a7bcb11000000b003ef5db16176sm13036342wmj.32.2023.04.03.12.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Apr 2023 12:41:13 -0700 (PDT)
From: Joshua Ashton <joshua@froggi.es>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 0/4] uapi, drm: Add and implement RLIMIT_GPUPRIO
Date: Mon,  3 Apr 2023 20:40:54 +0100
Message-Id: <20230403194058.25958-1-joshua@froggi.es>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
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
Cc: Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello all!

I would like to propose a new API for allowing processes to control
the priority of GPU queues similar to RLIMIT_NICE/RLIMIT_RTPRIO.

The main reason for this is for compositors such as Gamescope and
SteamVR vrcompositor to be able to create realtime async compute
queues on AMD without the need of CAP_SYS_NICE.

The current situation is bad for a few reasons, one being that in order
to setcap the executable, typically one must run as root which involves
a pretty high privelage escalation in order to achieve one
small feat, a realtime async compute queue queue for VR or a compositor.
The executable cannot be setcap'ed inside a
container nor can the setcap'ed executable be run in a container with
NO_NEW_PRIVS.

I go into more detail in the description in
`uapi: Add RLIMIT_GPUPRIO`.

My initial proposal here is to add a new RLIMIT, `RLIMIT_GPUPRIO`,
which seems to make most initial sense to me to solve the problem.

I am definitely not set that this is the best formulation however
or if this should be linked to DRM (in terms of it's scheduler
priority enum/definitions) in any way and and would really like other
people's opinions across the stack on this.

Once initial concern is that potentially this RLIMIT could out-live
the lifespan of DRM. It sounds crazy saying it right now, something
that definitely popped into my mind when touching `resource.h`. :-)

Anyway, please let me know what you think!
Definitely open to any feedback and advice you may have. :D

Thanks!
 - Joshie

Joshua Ashton (4):
  drm/scheduler: Add DRM_SCHED_PRIORITY_VERY_HIGH
  drm/scheduler: Split out drm_sched_priority to own file
  uapi: Add RLIMIT_GPUPRIO
  drm/amd/amdgpu: Check RLIMIT_GPUPRIO in priority permissions

 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 13 ++++++--
 drivers/gpu/drm/msm/msm_gpu.h           |  2 +-
 fs/proc/base.c                          |  1 +
 include/asm-generic/resource.h          |  3 +-
 include/drm/drm_sched_priority.h        | 41 +++++++++++++++++++++++++
 include/drm/gpu_scheduler.h             | 14 +--------
 include/uapi/asm-generic/resource.h     |  3 +-
 7 files changed, 58 insertions(+), 19 deletions(-)
 create mode 100644 include/drm/drm_sched_priority.h

-- 
2.40.0

