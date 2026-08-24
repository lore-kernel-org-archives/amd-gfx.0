Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857F6C5DF94
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 15:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2A4D10E155;
	Mon, 24 Aug 2026 15:35:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TEeRMA7M";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A11010E572
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 15:35:48 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c20e70a0962so548551766b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 08:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787585747; x=1788190547; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7BQk+VaXHqbBwCEiciR9Pe8CWGZKMc/0gaA8PUIi/5A=;
 b=TEeRMA7MXFozA/4bwYz05ZO2CW6Lq7oys1xU/mjFIM8LcP3oYgMjr2jcDVLujFZhJP
 ik7aCSE4OK9DA2N6Paxw5o152a6wpCIw/K6kkdO/O/G7B3XaK/Ib4InWiEiwfIiM+j9p
 w7TZmjEsRJWbvmTgIxhZR5rZAq0QzRqJqtVDU5hA/ZXytDZyxliKXMSqSDi6LRfJte/W
 WzSWzCiIUF5C7YrieZOaAZOAWcXI/rOHJY+gJTvfLBQDnMz41nSUYPP+vrAS4CshPrFT
 6uiaiGLePBl9XlegFkc0MCKHoWQPv+Cbyjx5op4imoN0m+taE5oQq28mt6GOQhXJFE0/
 Rnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585747; x=1788190547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7BQk+VaXHqbBwCEiciR9Pe8CWGZKMc/0gaA8PUIi/5A=;
 b=He3Eedtpq3Z1azJXtdBuh0k0czctaSqzlScfU7cqXK4xJh1aCBmJv+J71ZQwuFYBv8
 yHX8Bh/W8muxnEXwS+jvujx54uOtpNQ8d7nGxKheS6IK7sIRc6WHMNCR4gTT2hmcbnsJ
 KTBwAF7AN5q1NGxLQo5qC+L1VCSLN61/EcPkdF6a3rJ+Qd5n20q5KRNZOv2+5va/e9U5
 rrVHgbPC8XBNU1/JYmEyKB9ZfwNVhxkweOV4rkt/hDiRsc9VjFYf/4yAp5CVt61yIQLi
 G5cc6UAnOlE+gRHwtFy1J22up7F3fg71X2wDx/1Ut75Oswa3ykcDvqc+r07EcftZ6fRg
 SZcg==
X-Gm-Message-State: AFuF++l55qwLaxv05n2+LlK6LTQsxb4Bb6EEfewHMNO05Ap6t8ETrvgO
 TYnOuJsIDsbo0oQygsOf7P/jgz9cGtNY2hh9rk6jT3wdWTkUricMRFUe9p97CHToL93FZQ==
X-Gm-Gg: AR+sD13/kNvgGrdWB5oUWnl75PIzNY9lVawd+DbXbJ35ZCdmAkGztQBgfnV2dJGi9mV
 ccMNqi+8/hc6q6LRhEeENgMZvSYQJtfCD6SB+rd/X72wxJJAnB5TX8tFXfL/YClqQYo+/qxmoQI
 GNvVgjIcQQbKFfx1HaIrNJ7CF6CQXR2Rpn9OI7o9y5qwDmUasTefvi/3PvhCohk30a67FFy5qhA
 w9q2Ml3ShUrgY9I4J8JwcQaQCTk+2r1e7Inx8tNZK9MSe1xxdUaFbqwmkZc4IiZ/tDByTx0rfs5
 Fh/BjikfGwXJBpmm/RsBkQBxNVccSED4VKT8NjxUjRWW8w2jxbmbAEx7ZcyzbPzYZOxOgVCBtMr
 bc7kJKEoCuEy2s0x5XxXtIYFmGuKWVJmz4AvANVsuNMj4Aq65iPgXx4slEJ1rSHykcH69ERwvRX
 5qmnvL8DGv2vvoz5oScH045+xPYkwrh7q0ZcX+5aNgICR1Ktlq/ZNBA++YnO2xef3pFYaggM1uz
 rrVm1YcDphbY6myNX8qWzpn2/Up3WviIlCM+R94VM1IWnV4WxFTtsPenWQBRONKx4znP1RBaUKw
 x6TCJRQ1x1LWgkqifE3mxQrLTbNR2XY=
X-Received: by 2002:a17:907:3d0a:b0:c20:74db:50c7 with SMTP id
 a640c23a62f3a-c246a697ac4mr3198662366b.13.1787585746578; 
 Mon, 24 Aug 2026 08:35:46 -0700 (PDT)
Received: from horsehead.monster-haddock.ts.net
 (p548c9e2a.dip0.t-ipconnect.de. [84.140.158.42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606a8edsm1298978666b.6.2026.08.24.08.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:35:45 -0700 (PDT)
From: Denis Pisarev <pisarevden@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 mario.limonciello@amd.com, ionut_n2001@yahoo.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Denis Pisarev <pisarevden@gmail.com>
Subject: [RFC PATCH v3 0/1] drm/amdgpu: MMIO TLB invalidation fallback when
 KIQ is wedged after S4 resume
Date: Mon, 24 Aug 2026 17:35:41 +0200
Message-ID: <20260824153542.491012-1-pisarevden@gmail.com>
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

v3 addresses the two findings from the sashiko-bot review of v2.
Failure data and trigger isolation are unchanged (bugzilla 219492):
S4 resume on Cezanne (gmc_v9, GFXOFF) wedges KIQ TLB flushes at
80-140/hour for 9+ hours with sched.ready true throughout; holding
GFXOFF off across the S4 cycle produces zero errors.

1. [High] "VFs and interrupt contexts silently drop TLB flushes once
   the threshold is reached" - correct, and fixed. In v3 the latch
   only reroutes bare metal process context to MMIO. VFs and IRQ
   contexts keep submitting to KIQ exactly as before this patch, with
   per-failure logging, because they have no MMIO alternative; there
   is no longer any code path that drops a flush without attempting
   and logging.

2. [High] "KIQ and MMIO race on the same invalidation engine if KIQ
   recovers" - this remains the documented open question; no code
   change in v3. Our analysis: once latched, this path submits no new
   KIQ commands, so the exposure is limited to already-queued stale
   commands and the recovery transition window. The engine serializes
   requests internally, so the realistic worst case is a lost flush
   request caught by the existing ACK timeout ("Timeout waiting for VM
   flush ACK!"), not silent state corruption. If maintainers consider
   a fence necessary (or a dedicated invalidate engine for the MMIO
   path), guidance on the preferred mechanism would be welcome.

Full patch history: v1 (initial fallback+counter), v2 (GFXOFF hold,
per-instance counter, irqsave, VF/IRQ restrictions, MES error
propagation) - all from bot review; v3 (this one) fixes the VF/IRQ
drop regression the bot found in v2.

Also still open from the cover letters: the alternative direction of
fixing the S4 resume ordering itself (RLC/ME vs GFXOFF) instead of a
runtime fallback. Happy to run tracing on the affected hardware.

Patch 1/1 follows.

Denis Pisarev

Denis Pisarev (1):
  drm/amdgpu: fall back to MMIO TLB invalidation when KIQ is
    unresponsive

 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  18 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 123 +++++++++++++++++++-----
 5 files changed, 114 insertions(+), 33 deletions(-)

-- 
2.55.0

