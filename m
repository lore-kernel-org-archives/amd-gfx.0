Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7C3C5DF88
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 10:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0308E10EFDE;
	Thu, 20 Aug 2026 10:57:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rHHapAKZ";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F8DA10EFE4
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 10:57:23 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-499b57cf2f3so1110425e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 03:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787223441; x=1787828241; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h/HhSZtTG2M/MhbMK/mYTVAf7lwkJQIPzztoCbrat6E=;
 b=rHHapAKZ+9ycAx2TWkC4Hvc/FiKfINFn91Zs3+1VbSmi3x6K84e8BFiMpSxDy8bZ4Y
 UQIa1FR2avSlXVjf/iruza3KdAu39U3qCpc13Wn479kKWEDmPDvVNp2y1es/9e1YYIKb
 R91CYVVD5LV/Vn5yLj3ARJ+2Go0moJrZgeXJFh/8o/EOHqFmnnu/KL8qBsOh58riDEwr
 qPWikLG2Y/8S+0pdngOWHz4YmePXn5lQZaoUa9xue1eZZYOPgTtwaV9vmn+xgns0Ki1H
 b94oEbdeC816lfgrgmW8m74eKuz3jOB5l+Jrns25Ca5hwBq+jVk68SgYZFeW9psKUCI2
 WbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787223441; x=1787828241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h/HhSZtTG2M/MhbMK/mYTVAf7lwkJQIPzztoCbrat6E=;
 b=QqORBo+/uEMEGOY82mhErk8MFKO08M7UzvYwJjRe7hv1vZ3tDKcEAvMff1TI44TR59
 EJBcmIPI7aGm7vMzVsHwBv/rnVr6sbG5tKLlaUeTjEOUZBmWhZbe5wUCZhdx0XnLo0Y+
 dW2TmUBCxxvkakpS0GoZHT9EOlbqBmBa6WKsryAqtkDHY37/ICKRkQTfqrmDGgEUQpxa
 Uzs6NB3tRJsjwEdoJafIdhaihaKXX1zaR5COYH68F2R8Ac/V2Ku5ZxQKUjWhfPBdgTvg
 MwDfe2KadGYTXDyTvJSop53CjJ41pjPhGfi+GnED/g9R8ogHgfz0tf2D2cjqSj0ulXhs
 xLTg==
X-Gm-Message-State: AOJu0YxFyqhfdIJfXCmEHXkhDixHQlt6ln1xwG5uHFWZ4CClVaO7++wz
 1xB8yTD5/rTxU10rF3lNTGV4JoA7YhiYJxcItHD/bokeJJadK2QyVdsHPOI/ag62RYQ=
X-Gm-Gg: AR+sD11pkwJrgGweplCZST/5/S19WYigpFnDjt3dMua1HsqeZ6rJoamB0Uv+h6P6Cs0
 GzdljCQDXj0t2vyXD5n3j2WaEZCxG9CgtVKHoFkEFjDXeydmw7zosT2eGb9iCnXfqfcahlh2n+W
 wlg+TYWEZLy62irk3M8rqe4JN4IXRkRzJi5e9l2ej3VHm6pdGKFAwScJAOZnmVsUDxmOVHPFSd7
 97RXipEg9vDD4LnSeT5cT/OmRp7UtL4EpuT9Vzx7mtDm0PCPqNLQayIsFApF0NjTpWy8MdzkZS9
 nQwJuCaI1ken9Bs1azT/r/Rlsqn83fo9uAseodG3tCiZs6bNYT4k8Zej7Xo0Z4qijGZ1bPQJHMp
 9tsDqnjLD+Llg/fSaSoVAEnD+VqA5VLyVw9vxqneLRad+/MndliOxPMUZ0tvqGkEBXqidDL+EJs
 exef7Fz0nntGGWAV7YBxgKmDKnwkD10eAsizLv9jYy03w3sgQRU3ykVYnKd6lgblGwS4iUkEAgS
 YZRhAsPBuFsuDS74jSsecR3qQg9xe4jQp0wC/EcxLR1dwjG/QfdL92vCDllTZm3U+PZPb0NKBnM
 Zz+dQdwwG0DawawO
X-Received: by 2002:a05:600c:3487:b0:495:5d6d:9cc1 with SMTP id
 5b1f17b1804b1-499b0633f1bmr82252225e9.0.1787223441255; 
 Thu, 20 Aug 2026 03:57:21 -0700 (PDT)
Received: from horsehead.lan (p548c9e2a.dip0.t-ipconnect.de. [84.140.158.42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b4568a65sm13872775e9.2.2026.08.20.03.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:57:20 -0700 (PDT)
From: Denis Pisarev <pisarevden@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 mario.limonciello@amd.com, ionut_n2001@yahoo.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Denis Pisarev <pisarevden@gmail.com>
Subject: [RFC PATCH v2 0/1] drm/amdgpu: MMIO TLB invalidation fallback when
 KIQ is wedged after S4 resume
Date: Thu, 20 Aug 2026 12:57:15 +0200
Message-ID: <20260820105716.148732-1-pisarevden@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819185349.29407-1-pisarevden@gmail.com>
References: <20260819185349.29407-1-pisarevden@gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

v2 of this RFC, addressing the automated sashiko-bot review of v1.
The failure data and trigger isolation are unchanged from v1
(bugzilla 219492):

- S4 resume on Cezanne (gmc_v9, GFXOFF) -> KIQ TLB flush reg failures
  at 80-140/hour for 9+ hours, sched.ready true throughout; each
  failure burns the ~5 s retry window and the invalidation is dropped
- GFXOFF held off across S4: 0 errors (vs ~70-140/30 min stock);
  re-enabled 40 min after a clean resume: 0 errors in 15 min
- so the wedge forms in the S4 resume window while GFXOFF is allowed

Changes since v1 (all from the bot review, all reasonable):

1. [Critical] the runtime MMIO fallback now holds the GC block awake
   with amdgpu_gfx_off_ctrl(adev, false) across the direct register
   access - the unguarded v1 could touch power-gated registers.
   Because that call may sleep, the fallback is restricted to process
   context.
2. [High] failure counter moved from a global in amdgpu_gmc to the
   per-instance struct amdgpu_kiq - no cross-talk between XCCs.
3. [High] SR-IOV VFs never take the runtime MMIO fallback (they lack
   privileges for direct GMC invalidation register writes).
4. [Medium] gmc_v9_0_flush_gpu_tlb_mmio() (extracted helper) takes
   invalidate_lock with irqsave since the path is now
   runtime-reachable.
5. [High, pre-existing] the MES branch now propagates
   amdgpu_mes_reg_write_reg_wait()'s error instead of hardcoding
   success.
6. [Medium] threshold warning no longer claims a fallback that
   gmc_v10/v11/v12 do not implement.

Open question kept from v1: a KIQ command that timed out remains
queued in the ring; if the ring recovers late, a duplicate
(idempotent) invalidation could race a CPU MMIO flush. Input on
whether the req/ack handshake needs protection for that case is
welcome. Alternative direction also still open: fix the S4 resume
ordering itself (RLC/ME vs GFXOFF) instead of a runtime fallback -
happy to run tracing on the affected hardware.

Patch 1/1 follows.

Denis Pisarev

Denis Pisarev (1):
  drm/amdgpu: fall back to MMIO TLB invalidation when KIQ is
    unresponsive

 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  18 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 111 ++++++++++++++++++------
 5 files changed, 102 insertions(+), 33 deletions(-)

-- 
2.55.0

