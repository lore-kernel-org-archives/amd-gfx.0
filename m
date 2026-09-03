Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394E0C79F84
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 07:35:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52EA510F448;
	Thu,  3 Sep 2026 07:34:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qmsXz3rP";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2698B10E063
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 06:00:15 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so1831177a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Sep 2026 23:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788415214; x=1789020014; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HzzL67kEz0bnJKJn5x2elMmqvdhT7A2m7DuMV5KAKeU=;
 b=qmsXz3rPPddAG74tiDAeYk2da7YElsXozcmgvS97c+Qyi39eSksVwJZhGJnjBgpLUk
 3mb1iZ3ynOB6p/Rw40GC8lTYocx10HQCAwcMWmyMbob2HYpMdrz7GBCbywvUUxuSx/wU
 oyLLSQhm3lZRnoecgpTvcEttIvbF4uQ2qQDrnLJBKvJgtzUkSwL8CnhcJmj04GXzQ4kJ
 GXs014gg4NZppd/FfuwZgvzO6V7EJyRSljVwZ2a2NPtyqQ703CHGEQblA8I45JLbXBVS
 MT3IP/pQXa02nHOZm2o/xsEontY7b6v7nRB2ESjJW4uudXyiIQEpzamsNlaJMmsDjFXN
 b2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788415214; x=1789020014;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HzzL67kEz0bnJKJn5x2elMmqvdhT7A2m7DuMV5KAKeU=;
 b=Qd3j/iB89B7hVcNsLIwUoIw1OxOdk3HIlMdBbZGyBhLy+50Zwrei0otRszBJ+B4RZE
 sYcvlkdwYvfGNbDulsHwKNcu2f42KThan0fuJ9A35JBAWE/SZ/+T65CYcM0krDvDTFus
 CuPS+J/8n0FrzC9dTBcFqhthR/E97HgqI0Htry3A1t2i5s5cVYtJ+1ZeVIVARYRUDfqV
 ARNT/TeMPJFd4IJAuluHvqiVlAEIHTzbwhItGfmO63wogtUXvjHByv5s/Nrf0f7qSfNi
 cJyynuaX+m3hu/3Ly1w3zrzuKvneVR2jqo8QqO2wvzpZW5mOSxwJ2JijFOznC+3e2xeB
 uSaQ==
X-Gm-Message-State: AFuF++nKUD0KFJ/wSPSwhVXt3QiCooHo6N0kF/HA56O/6Q4/hd0m7/l5
 F445QZD+1ocyQDMR7VagobZyZ3wxheFLknR/X0cPmW1kSXmSJkheRoNeShdHB5Fxa50=
X-Gm-Gg: AYBFou3pT3U/ILmDj6kcUvsVA7YXLw77wnD/uO0FMSAPjq7mU5IWbzyGMBqwlXigUf0
 lSW5dopEaXmXhji9qlAYeuWsnz1XFsNIEuw1ig7dPPFEbZurL7GD/NN8uCIr+wypWXryZ/HwoBH
 lQAF0zESYhKlpFRk7aHRgTh5qpM1Ir+OxyUeV26ZgMDDWOcFhXRv6ZykPoM6pOa7S8U2dVy10uo
 eSyPnDE4X3HMrOH04ufHkyniGTGvTyYdln8zBy3cevP1g0d7mSxnc9kcPnalcLxf7RKNu4Iz+7h
 DPqn4LUkf1WDJs4UArtgIXa6S8Eqpar3T/LQ8nVKWSBGqDUsVyOKUdn7g5B5chBCWCqSPFIazWc
 vqd+WF1/rpqVaOtH1klX/rhrxQIQxJdA9sxmXThE2nrz3vviIDuijfhAwoCZ36dJBXkwUs2k0VF
 Y5gaxKwHWGcjSylDSD5gzBplJXrRBT+CzN9fdp3qA62+2rkNtk56NWv9mh7lhJ62rr1/+27S5kv
 hXufni6t9pK9sxcefjQ52g7iJi1/4NTvXlfly/qdik9BGUnU9d/h7Y/OnsOWuUHgqaosQ==
X-Received: by 2002:a17:90b:4b89:b0:398:c3ca:1ebc with SMTP id
 98e67ed59e1d1-39aee105a46mr13805147a91.18.1788415214370; 
 Wed, 02 Sep 2026 23:00:14 -0700 (PDT)
Received: from francomeister ([138.84.137.76])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b07ac1174sm3242616a91.0.2026.09.02.23.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 23:00:13 -0700 (PDT)
From: Francis Marlou Pacaro <pacaro.francis.marlou.n@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org,
 Francis Marlou Pacaro <pacaro.francis.marlou.n@gmail.com>
Subject: [PATCH] drm/amd/display: fix MALL hysteresis timer underflow at high
 refresh rates
Date: Thu,  3 Sep 2026 13:59:52 +0800
Message-ID: <20260903055952.62906-1-pacaro.francis.marlou.n@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:34:48 +0000
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

dcn30_apply_idle_power_optimizations() derives the MALL frame cache
hysteresis timer with

	tmr_delay = (uint32_t)(div_u64(..., denom) - 64LL);

div_u64() returns a u64, so when the quotient is smaller than 64 the
subtraction wraps instead of going negative and tmr_delay ends up huge.
The loop that follows tries to squeeze it into the 6 bit register field
by doubling denom, but that only makes the quotient smaller, so tmr_delay
can never converge.  tmr_scale is bumped past 3 and the function gives up
with

	/* Delay exceeds range of hysteresis timer */
	ASSERT(false);

even though the requested delay is too *short* to encode, not too long.

With mall_additional_timer_percent left at its default of 0, the quotient
drops below 64 once the refresh rate used for the calculation goes above
~243 Hz.  Every DCN 3.0 display above that loses MALL static screen
entirely and splats a WARN once per boot.  Reproduced on Navi 23
(RX 6600) driving 1920x1080, resetting /sys/kernel/debug/clear_warn_once
between modes:

	refresh   MALL       ASSERT
	144 Hz    enabled    no
	240 Hz    enabled    no
	280 Hz    skipped    yes
	360 Hz    skipped    yes

Commit 3bb68cec4db8 ("drm/amd/display: Add Overflow check to skip MALL")
already covered the other end of the range, where a large stutter period
makes the delay too long to encode.  Cover the short end by clamping to
0, which selects the shortest hysteresis the register can express,
65.28us * 64 = ~4.18ms.  That is marginally longer than what the formula
asks for at these refresh rates, and erring long is the safe direction:
it only delays MALL entry, it can never enter early.

The numerator does not change between iterations, only denom does, so
compute it once and keep both call sites inside 100 columns.

The genuinely out of range case at very low refresh rates still reaches
the ASSERT, which is where it belongs.

Fixes: 52f2e83e2fe5 ("drm/amdgpu/display: add MALL support (v2)")
Signed-off-by: Francis Marlou Pacaro <pacaro.francis.marlou.n@gmail.com>
---
Compile tested only: vanilla v7.2.2 built with clang 22.1.8 on x86_64
using a CachyOS .config, full amdgpu module, no new warnings.  The WARN
reproduction described above was observed on unpatched 6.18.48 and
7.2.2; I have not yet booted a kernel with this patch applied.

 .../gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -1064,10 +1064,12 @@
 				 */
 				unsigned int denom = refresh_hz * 6528;
 				unsigned int stutter_period = dc->current_state->perf_params.stutter_period_us;
+				u64 num = (1000000LL + 2 * stutter_period * refresh_hz) *
+					(100LL + dc->debug.mall_additional_timer_percent);
+				u64 tmr_ticks;
 
-				tmr_delay = (uint32_t)(div_u64(((1000000LL + 2 * stutter_period * refresh_hz) *
-						(100LL + dc->debug.mall_additional_timer_percent) + denom - 1),
-						denom) - 64LL);
+				tmr_ticks = div_u64(num + denom - 1, denom);
+				tmr_delay = tmr_ticks > 64 ? (u32)(tmr_ticks - 64) : 0;
 
 				/* In some cases the stutter period is really big (tiny modes) in these
 				 * cases MALL cant be enabled, So skip these cases to avoid a ASSERT()
@@ -1089,9 +1091,8 @@
 					}
 
 					denom *= 2;
-					tmr_delay = (uint32_t)(div_u64(((1000000LL + 2 * stutter_period * refresh_hz) *
-							(100LL + dc->debug.mall_additional_timer_percent) + denom - 1),
-							denom) - 64LL);
+					tmr_ticks = div_u64(num + denom - 1, denom);
+					tmr_delay = tmr_ticks > 64 ? (u32)(tmr_ticks - 64) : 0;
 				}
 
 				/* Copy HW cursor */
-- 
2.51.0

