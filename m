Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639E8C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 14:33:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F37D364EC3
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 14:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37D364EC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 835616E161;
	Thu, 25 Feb 2021 14:33:49 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 103C06E0C2;
 Thu, 25 Feb 2021 14:33:48 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01B5A64F06;
 Thu, 25 Feb 2021 14:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614263626;
 bh=Z2omBoic64a0PUjdoMoaR0OyACh47HBLzcZeuDlhik8=;
 h=From:To:Cc:Subject:Date:From;
 b=t3TA/rm0jyHEsX+ESwjyhby/pDRYG3VklwLyJpX0uy51tUHf2D1aAk3gFhefN5AmN
 bP40IIn9Xx242Od2pE3asN7aDZUH4QNpY29v9tmXGvJhaFUkGDNdRngzXXoJwZn/d/
 wyjYp/IuzPKbI/AZ4ejInh1oPSKcKx4zpreV6UFKgW5JIV2NyA5eXwlxpj1d5ye6gv
 QeI/8E9ClzOrLxqMWAVWpLTdisDpKvehJ8gIdeyLWxnyPVCFGsiHX10MqE2zJ1Wagv
 DAHTSLBQGsYkfnNyggAxWFNuO67gIgl/17ZV/jewll5cdSmd05VjUsJWomko8ZeBWt
 FPOY8rKDhWuVQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Bindu Ramamurthy <bindu.r@amd.com>,
 Vladimir Stempen <vladimir.stempen@amd.com>
Subject: [PATCH] drm/amd/display: fix 64-bit integer division
Date: Thu, 25 Feb 2021 15:33:10 +0100
Message-Id: <20210225143339.3693838-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
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
Cc: Arnd Bergmann <arnd@arndb.de>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Arnd Bergmann <arnd@arndb.de>

The new display synchronization code caused a regression
on all 32-bit architectures:

ld.lld: error: undefined symbol: __aeabi_uldivmod
>>> referenced by dce_clock_source.c
>>>               gpu/drm/amd/display/dc/dce/dce_clock_source.o:(get_pixel_clk_frequency_100hz) in archive drivers/built-in.a

ld.lld: error: undefined symbol: __aeabi_ldivmod
>>> referenced by dc_resource.c
>>>               gpu/drm/amd/display/dc/core/dc_resource.o:(resource_are_vblanks_synchronizable) in archive drivers/built-in.a
>>> referenced by dc_resource.c
>>>               gpu/drm/amd/display/dc/core/dc_resource.o:(resource_are_vblanks_synchronizable) in archive drivers/built-in.a
>>> referenced by dc_resource.c
>>>               gpu/drm/amd/display/dc/core/dc_resource.o:(resource_are_vblanks_synchronizable) in archive drivers/built-in.a

This is not a fast path, so the use of an explicit div_u64/div_s64
seems appropriate.

Fixes: 77a2b7265f20 ("drm/amd/display: Synchronize displays with different timings")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c    | 12 ++++++------
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c    |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 0241c9d96d7a..49214c59c836 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -441,15 +441,15 @@ bool resource_are_vblanks_synchronizable(
 		if (stream2->timing.pix_clk_100hz*100/stream2->timing.h_total/
 				stream2->timing.v_total > 60)
 			return false;
-		frame_time_diff = (int64_t)10000 *
+		frame_time_diff = div_s64(10000ll *
 			stream1->timing.h_total *
 			stream1->timing.v_total *
-			stream2->timing.pix_clk_100hz /
-			stream1->timing.pix_clk_100hz /
-			stream2->timing.h_total /
-			stream2->timing.v_total;
+			stream2->timing.pix_clk_100hz,
+			stream1->timing.pix_clk_100hz *
+			stream2->timing.h_total *
+			stream2->timing.v_total);
 		for (i = 0; i < rr_count; i++) {
-			int64_t diff = (frame_time_diff * base60_refresh_rates[i]) / 10 - 10000;
+			int64_t diff = div_s64(frame_time_diff * base60_refresh_rates[i], 10) - 10000;
 
 			if (diff < 0)
 				diff = -diff;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 6f47f9bab5ee..85ed6f2c9647 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1013,9 +1013,9 @@ static bool get_pixel_clk_frequency_100hz(
 			 * not be programmed equal to DPREFCLK
 			 */
 			modulo_hz = REG_READ(MODULO[inst]);
-			*pixel_clk_khz = ((uint64_t)clock_hz*
-				clock_source->ctx->dc->clk_mgr->dprefclk_khz*10)/
-				modulo_hz;
+			*pixel_clk_khz = div_u64((uint64_t)clock_hz * 10 *
+				clock_source->ctx->dc->clk_mgr->dprefclk_khz,
+				modulo_hz);
 		} else {
 			/* NOTE: There is agreement with VBIOS here that MODULO is
 			 * programmed equal to DPREFCLK, in which case PHASE will be
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
