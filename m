Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2595CC5DF85
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 18:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0D2810EC65;
	Wed, 19 Aug 2026 18:53:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qVEc/0Am";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4547610E4D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 18:53:55 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-499a4d1d7f1so12070885e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 11:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787165634; x=1787770434; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LeaiBk7jtPj1JV25dNEYhySyvqZDMBq0LxTmZgiU7l8=;
 b=qVEc/0AmaRFJetyb5ehO2lsMwC14fKhHXEsescnnXQKTtm/N0Od4pPjXiHJaRt+KUu
 IsPyOZY7uImuSe569quyO+HjRiu3XMVOs8gMH1a3qcQRJXYOdyUK55Ce4ktvG28tfRB/
 /Jyb7pWG26iEKlgNNB+ecvejt/hpLynEeyG8IUX5RJwPt+tHtTMleyzXTi1ygFpX8U/T
 9mW0TJpVIx0vZVPVIfqxUtJIFWszq+bGi70AAkBg2Uiag4t3RxlpjsiPRVMEy5HFuiYO
 8dYRJfW1mq5h9PFeMYp/14gHdg+osz3v2crHfZe+zfEqW0t1lin5K2gKJa8qPDgaBX6X
 P3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787165634; x=1787770434;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LeaiBk7jtPj1JV25dNEYhySyvqZDMBq0LxTmZgiU7l8=;
 b=Sg9RMZ+hI2CKbNKSuOs0974ql0JEw9SF7T1w6eHXa9Ogmqodd88PiEdMAZizqsQC9+
 RxFTzP3IVr1bskJ+VY/vHSHbDW3aKeySOkRvcdBYzXuhTvWODHOoWVGbi7h6OD94g5oy
 u2u9kZkRXe0HUbwC0DPS9fZQubbCIsQouawasl7QUCw6jNTn40r1gb9MZrT/1IiKBdTb
 /Ne0QWYxG60KPrKigMyCBR82M8Nr0m+Tm8qCkXezpS8cDEAITLHIN4+mziqzlb0Ou+Ri
 MV4dLiJqeTXf17yB/wtBJZrUf9hJ0gtjaFTCC3j4/Wv3H9EH/GjB7VOt9XH9IjSRaTzF
 6oag==
X-Gm-Message-State: AOJu0YzcdNZK18SYJfbiMLhqTFExBQpfcYHOZAg2n1jh6nVUA+xSLZQJ
 BP6wettO27X/tsREm6tpJBycJU+3BG0sKyX++8L4UliqCWh9Qz7sB3Cx1Ap6DMRAUxE=
X-Gm-Gg: AR+sD127do/pw11gDgU77Lgn5Gy8IEagkiXFstqMNyYNbw3Yaxy91+jPmR1Z38ggwqL
 GNMPZix73+22wOnE3etpu+zFEpJLFj5gh1Mdtmatp/fbNOrIbxs7QaYaczB5Nn90oPmrJWSH9mq
 x/Ap0D6fK3nLiZCpFuZPQs911y+JztpANdfaR+Q4HR2FUYaJJxWtmHq/Gkzs+ff+T/yuxG1SpqP
 lLJ2sNOIbs5VD54hmLFdv7O/FzQ8l+LBuK4GXyzY0FWV5Tnde0hR5nRXaauPA8Z1mgkrgf7mZSw
 hqUytu42FmpLfBbQxVRPqs8LYyjW5DyI4kLzuwiSSQ8fzdLkzAgD0EuO4qRT5aXbrOdcO+jnReN
 Z92gAvs1nn2Hd/lb73zd85u4Hhx29mDebFR+90lcHzTGNHSLv0o8MYavcmi5o/7Iq3ynzpeFjmm
 oHWUvLyyy8bYNlPYOJws2StdyWUGstQC7Pw7QgYNYBFZLWCHUs4PBEeYPoRD98mWfcLQUBahIve
 yOQNJukvQBvQHtwLLMwUf6Yl88YgPQDSx2rwgyPizklylAyRN1gSM8MFILDuhMbMRuyzwTQnT0u
 igKHvkb2PMKlpI+r
X-Received: by 2002:a05:600c:4ec9:b0:495:6e68:5df2 with SMTP id
 5b1f17b1804b1-499aa1e33femr110408125e9.12.1787165633486; 
 Wed, 19 Aug 2026 11:53:53 -0700 (PDT)
Received: from horsehead.lan (p548c9e2a.dip0.t-ipconnect.de. [84.140.158.42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0d6721sm104205315e9.11.2026.08.19.11.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 11:53:53 -0700 (PDT)
From: Denis Pisarev <pisarevden@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 mario.limonciello@amd.com, ionut_n2001@yahoo.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Denis Pisarev <pisarevden@gmail.com>
Subject: [RFC PATCH 0/1] drm/amdgpu: MMIO TLB invalidation fallback when KIQ
 is wedged after S4 resume
Date: Wed, 19 Aug 2026 20:53:48 +0200
Message-ID: <20260819185349.29407-1-pisarevden@gmail.com>
X-Mailer: git-send-email 2.55.0
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

This RFC follows up on bugzilla 219492 ("failed to write reg 28b4 wait
reg 28c6" after hibernation) and on the resume_gpu_stable proposal
rejected in January:

  https://lore.kernel.org/amd-gfx/20260106125929.25214-6-sunlightlinux@gmail.com/

The rejection argued that (a) kiq sched.ready is managed correctly -
set false in suspend, set true again only after ring tests pass on
resume - and (b) the proposed flag would have disabled the KIQ flush
path permanently. Both points are correct, and this RFC takes a
different route: nothing is disabled proactively; the driver reacts to
observed failures.

MEASURED FAILURE MODE (Cezanne iGPU, Ryzen 7 PRO 5850U, 7.1.8, KDE
Wayland, no ROCm):

- S4 resume -> "failed to write reg 28b4/28c6" + "1a6f4/1a706" pairs
  begin in the same second as the thaw and continue at 80-140/hour
  for 9+ hours until reboot. kiq sched.ready is true throughout (the
  ring test at resume passed).
- Two user-visible consequences: each failed flush burns the ~5 s KIQ
  retry window (desktop-wide sluggishness), and the invalidation is
  then silently dropped (stale TLBs - correctness).

TRIGGER ISOLATION (single-variable tests, one hibernate cycle each):

- stock (GFXOFF allowed across S4):    ~70-140 errors / 30 min of use
- GFXOFF held off across S4:                    0 errors (30 min)
- GFXOFF re-enabled 40 min after the clean
  resume:                                      0 errors (15 min;
  gating resumption not independently verified)

So the wedge forms in the S4 resume window while GFXOFF is allowed,
and is consistent with the existing semaphore workaround comment in
gmc_v9_0.c about losing invalidate-acknowledge state across
power-gating cycles. A boot-time amdgpu.pg_mask=0 does not even
initialize on this part (probe -ETIMEDOUT), so runtime debugfs
control was used.

THE PATCH (1/1):

- amdgpu_gmc_fw_reg_write_reg_wait() returns -ETIME on failure and
  counts consecutive failures
- gmc_v9_0_flush_gpu_tlb() uses its existing MMIO path as fallback
  when the KIQ submit fails (invalidations no longer dropped), and
  after 3 consecutive failures skips the KIQ path entirely until the
  counter resets - so wedged systems stop paying 5 s per flush
- counter resets on every success and in gmc_v9_0_hw_fini(); each
  suspend/resume cycle re-arms KIQ. No proactive disabling anywhere.
- gmc_v10/v11/v12 call sites unchanged and compile-safe (int return
  used as statement); extending the fallback to them is trivial once
  the approach is agreed.

This mirrors what the sibling PASID path already does (KIQ submit,
-ETIME on timeout, MMIO variant as fallback), applied to the per-VMID
path.

OPEN QUESTIONS:

1. Root cause in the S4 window: RLC/ME not processing KIQ invalidates
   while GFXOFF is allowed? Happy to run tracing (amdgpu.vm_debug,
   VM_INVALIDATE ack registers) on the affected hardware on request.
2. Should the latch be per-xcc-inst?
3. Should amdgpu_gmc_flush_gpu_tlb_pasid()'s KIQ branch share the
   latch?

Patch 1/1 follows. Comments very welcome - especially on whether the
failure-driven fallback is the right shape vs. fixing the S4 resume
ordering directly.

Denis Pisarev

Denis Pisarev (1):
  drm/amdgpu: fall back to MMIO TLB invalidation when KIQ is
    unresponsive

 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 15 +++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  4 +++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 18 ++++++++++++++----
 4 files changed, 30 insertions(+), 9 deletions(-)

-- 
2.55.0

