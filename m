Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC15C79F85
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2026 07:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBE2310F8EE;
	Fri,  4 Sep 2026 07:30:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DPTyrF4l";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B697910E0FD
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2026 00:20:43 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2d560775ca2so3618695ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Sep 2026 17:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788481243; x=1789086043; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FHlgj/dkKpC6zxE1oJxCqsVN4/80OFta20KY1XPRKnc=;
 b=DPTyrF4lYgmLOojjnlZkZun/wQLZPRMp9chc3w2Li7YzNbMtG0bWCKTxXrV7FZPMlU
 8AplbsDUezmVfyvPF+wVqaB9qUjm9FO2XFz7nl9kvz0vBTan4az1VOXsifsI4yiCvTUR
 jqGnUd6xpiGC2xiT3PiLyY6DcbuvAHTLVKlkPzhuvNyb2c8TSvFxQv4BuxCw8R7VgK17
 qd3c5qeKKRz6pa9mkSjAiDD0pIlnNDJy3Id+srXomzq10BGzKq2fXKPadL+ZV0uD+FcP
 HN/8Gminmj3fh52zj+idzX9+zvYl8zKUws5Ct4IVzlVlYMeFfS1ewk1RtpOvQpqQgOkM
 sPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788481243; x=1789086043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FHlgj/dkKpC6zxE1oJxCqsVN4/80OFta20KY1XPRKnc=;
 b=N4AEWRxIbibI8huTcflOgleQcHnzd+6JhcqxWxy90/enCUqnFRanH5m6zyg/9uhrO4
 o09j/uCCXO8YfflOUKs06k+hW/xq2dgktSivh0TJYFfI0kUQ5ytm+Smzhq00BvUMX8zZ
 X306JQ3g7zAgbEVQamWWsYePXPfQKjR7jf88e5Ctxb7EnOgFBwdg1NiKHLZnzw0HYZTi
 Dwz5iv1ts2JSPu4iolFJOZbbXBAZbYW3bvhu0vsVk/9p/vvL3Fi/dIGxVbu6CDeh3jvb
 2ue9OkSqYVlVMQQ7/L8r1UNK1MJpV1Jhqe3GfD/QK/2ZwlWvylDLwtUVWwFXTfZB47Mj
 kptw==
X-Gm-Message-State: AFuF++mtEYtYBYdnyhpW9mOxYMEKjOkiG3XbGI6EB7CcVNNb0OOBZGS4
 SUxXJUvqJASx47a7JS5mP9liZqaj5w/88ni4wmtlszvSF3UpvtiISCTxUb5cKlPnHmo=
X-Gm-Gg: AYBFou3eI5nu4aM5kwy5EW0eCYIBdXlWiAeoGBEjFJa8zone0GJ6wppCPIdSdOGsBUS
 uk8CBmjtowzr41I7CKsmoHjnIAj/h9iNomcy6sC7SyttjhjJdq+6LZdFuBX7FdwYPA/k4Z1Lv4T
 an/wBvnmN1zv+cbpSJ6dRY9SKrOBMh9MiYY7DvSNo+g6Z0Ji+rIugfsRgHaaMXuyxbbFsxDkhBa
 vTgnwiaE2tbOqD01AInzobNKcp2fEga/D0/TXyCU5iHkPnwVY3hObmjRjBoAFg3AX2EGiNdEtWi
 I5R46o7GqZCKslU1F14i1OA7Jp8PERMyaMB/+72s2eP48mxS6wZIY/huPGkzbfZutAT35fbfnwa
 b+ki3mK9hgeGIVb/i1MDd+d4NmvXMS9UMW9P2qMNNm9IP5Ez4t/qPlmS/APFMLUQg+JLRvHZw6P
 t5xCOySfe0cLvGKGhgC1j8DgnBCXvMJkq3dOiHGwf/A3xP9FA49QGFPDGNeyzbLxP/REkkd6nXb
 01uydMVRQux09DaCY5G7V9wapmdn+d270yRO5k4oPRSxQmRcJiIdFhbPgS5LEBOfbEmIA==
X-Received: by 2002:a17:90a:fc47:b0:398:9c0c:7c72 with SMTP id
 98e67ed59e1d1-39b2627fe24mr3310678a91.25.1788481242997; 
 Thu, 03 Sep 2026 17:20:42 -0700 (PDT)
Received: from francomeister ([138.84.137.76])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b260cd2aasm1339128a91.3.2026.09.03.17.20.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 17:20:42 -0700 (PDT)
From: Francis Marlou Pacaro <pacaro.francis.marlou.n@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: sunpeng.li@amd.com,
 Francis Marlou Pacaro <pacaro.francis.marlou.n@gmail.com>
Subject: [PATCH v2] drm/amd/display: fix MALL hysteresis timer underflow at
 high refresh rates
Date: Fri,  4 Sep 2026 08:20:21 +0800
Message-ID: <20260904002021.9883-1-pacaro.francis.marlou.n@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <YOUR-V1-MESSAGE-ID>
References: <YOUR-V1-MESSAGE-ID>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 04 Sep 2026 07:30:06 +0000
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
Reviewed-by: Leo Li <sunpeng.li@amd.com>
---
v2: s/u64/uint64_t/ to follow DC convention (Leo Li).

    Leo - I also restored the two (uint32_t) casts while I was in there.
    v1 had drifted those from the (uint32_t) the replaced line used, and
    leaving uint64_t declarations beside (u32) casts looked worse than
    fixing both; dcn30_hwseq.c is back to zero u64/u32 uses.  Say the
    word if you would rather that were its own patch and I will drop it
    from this one.

    No functional change.  checkpatch --strict reports "Prefer kernel
    type 'u64' over 'uint64_t'" on the two declarations; that is the
    known DC false positive.  0 errors otherwise.

Boot tested since v1, on the hardware named above: Navi 23 (RX 6600),
DCN 3.0.2, 1920x1080 over DisplayPort, VRR 48-360 Hz.  Same v7.2.2 tree
and .config either way, clang 22.1.8 / LLD 22.1.8:

	7.2.2 build     boot at greeter    360 Hz
	unpatched       WARN               WARN
	patched         none               none

Three boots of the patched build produced no WARN at all; the unpatched
build warned once per boot at the login greeter, where v_total is
briefly inconsistent across the handover and the computed refresh lands
just above the cliff.  ASSERT() is WARN_ON_ONCE, so each 360 Hz test
reset /sys/kernel/debug/clear_warn_once immediately beforehand, which
keeps the negatives independent rather than one suppressed warning.

No regression below the cliff: 240 Hz still idles at 96 MHz memory clock
and ~5 W package power, unchanged from the unpatched build.  MALL entry
itself is not instrumented, so this shows the ASSERT is gone and that
nothing regressed at or below the cliff, not that the frame cache now
engages above it.

 .../gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 2d3587a..2ecd3a4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -1058,10 +1058,12 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 				 */
 				unsigned int denom = refresh_hz * 6528;
 				unsigned int stutter_period = dc->current_state->perf_params.stutter_period_us;
+				uint64_t num = (1000000LL + 2 * stutter_period * refresh_hz) *
+					(100LL + dc->debug.mall_additional_timer_percent);
+				uint64_t tmr_ticks;
 
-				tmr_delay = (uint32_t)(div_u64(((1000000LL + 2 * stutter_period * refresh_hz) *
-						(100LL + dc->debug.mall_additional_timer_percent) + denom - 1),
-						denom) - 64LL);
+				tmr_ticks = div_u64(num + denom - 1, denom);
+				tmr_delay = tmr_ticks > 64 ? (uint32_t)(tmr_ticks - 64) : 0;
 
 				/* In some cases the stutter period is really big (tiny modes) in these
 				 * cases MALL cant be enabled, So skip these cases to avoid a ASSERT()
@@ -1083,9 +1085,8 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 					}
 
 					denom *= 2;
-					tmr_delay = (uint32_t)(div_u64(((1000000LL + 2 * stutter_period * refresh_hz) *
-							(100LL + dc->debug.mall_additional_timer_percent) + denom - 1),
-							denom) - 64LL);
+					tmr_ticks = div_u64(num + denom - 1, denom);
+					tmr_delay = tmr_ticks > 64 ? (uint32_t)(tmr_ticks - 64) : 0;
 				}
 
 				/* Copy HW cursor */
