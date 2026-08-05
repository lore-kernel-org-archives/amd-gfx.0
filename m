Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B35C55ABF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 06:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BADB10F0EA;
	Thu,  6 Aug 2026 06:55:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VbLayuLL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7D6610EE34
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 12:14:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1E1E360A79;
 Wed,  5 Aug 2026 12:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FF81F000E9;
 Wed,  5 Aug 2026 12:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1785932090;
 bh=3F+dBVVZWb5taIf3pVSXxwjQ8OVn7StJMzqp6zW3CTY=;
 h=Subject:To:Cc:From:Date;
 b=VbLayuLL3AX6HL8YRPdFTYj2cpnnme04a7VV+v9qMDu1Mc59yRSMkSdN3XZ/rMmmh
 D7iNSBAZSoGZIehxJLM/tL4+n3RX2xxvme/YvhW4+K2lDHyZXIeRE69IKhxp3V2UyJ
 mbFsPXQzzt/5C8CpN//Mb97kULsdi+eQBeeo8q5k=
Subject: Patch "drm/amd/display: use proper context for logging" has been
 added to the 6.18-stable tree
To: Bhawanpreet.Lakha@amd.com, airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, bhawanpreet.lakha@amd.com,
 christian.koenig@amd.com, gregkh@linuxfoundation.org, harry.wentland@amd.com,
 jirislaby@kernel.org, simona@ffwll.ch, siqueira@igalia.com, sunpeng.li@amd.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 14:14:11 +0200
Message-ID: <2026080511-blatantly-caress-962f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
X-Mailman-Approved-At: Thu, 06 Aug 2026 06:55:48 +0000
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


This is a note to let you know that I've just added the patch titled

    drm/amd/display: use proper context for logging

to the 6.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-amd-display-use-proper-context-for-logging.patch
and it can be found in the queue-6.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 114b42507b6a23d9d24e24e4ef165233332c64d4 Mon Sep 17 00:00:00 2001
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Date: Thu, 23 Jul 2026 06:25:48 +0200
Subject: drm/amd/display: use proper context for logging
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jiri Slaby (SUSE) <jirislaby@kernel.org>

commit 114b42507b6a23d9d24e24e4ef165233332c64d4 upstream.

The same as the rest of the code, get_ss_info_from_atombios() uses
calc_pll_cs->ctx->logger for logging. But calc_pll_cs->ctx is
initialized only later in calc_pll_max_vco_construct(). Therefore, any
output using DC_LOG_SYNC() leads to a NULL pointer deference in
get_ss_info_from_atombios().

According to Sashiko, the very same problem exists in
dce112_get_pix_clk_dividers() and dcn3_get_pix_clk_dividers() too.

To avoid accessing the NULL context, use clk_src->base.ctx->logger
everywhere. That context in base is initialized earlier in
dce110_clk_src_construct() and dce112_clk_src_construct(). Before
get_ss_info_from_atombios() or Sashiko's get_pix_clk_dividers functions
above are actually called. This is done by redefining DC_LOGGER to
CTX->logger.

Before:
dce110_clk_src_construct() did:
 -> sets clk_src->base.ctx = ctx;
 -> ss_info_from_atombios_create()
   -> get_ss_info_from_atombios()   <- uses calc_pll_cs->ctx  # BOOM
 -> calc_pll_max_vco_construct()    <- sets calc_pll_cs->ctx

After:
dce110_clk_src_construct() does:
 -> sets clk_src->base.ctx = ctx;
 -> ss_info_from_atombios_create()
   -> get_ss_info_from_atombios()   <- uses clk_src->base.ctx

Closes: https://bugzilla.suse.com/show_bug.cgi?id=1271175
Closes: https://lore.kernel.org/all/a9ee54e6-2413-4156-9bde-d528ae3c63a3@kernel.org/
Fixes: 1296423bf23c ("drm/amd/display: define DC_LOGGER for logger")
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 6f16fcbb0c46a87e3d9685407e906573d60104b0)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c |   20 ++++++++----------
 1 file changed, 9 insertions(+), 11 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -45,9 +45,7 @@
 	clk_src->base.ctx
 
 #define DC_LOGGER \
-	calc_pll_cs->ctx->logger
-#define DC_LOGGER_INIT() \
-	struct calc_pll_clock_source *calc_pll_cs = &clk_src->calc_pll
+	CTX->logger
 
 #undef FN
 #define FN(reg_name, field_name) \
@@ -291,6 +289,7 @@ static bool calc_pll_dividers_in_range(
 }
 
 static uint32_t calculate_pixel_clock_pll_dividers(
+		struct dce110_clk_src *clk_src,
 		struct calc_pll_clock_source *calc_pll_cs,
 		struct pll_settings *pll_settings)
 {
@@ -479,7 +478,7 @@ static uint32_t dce110_get_pix_clk_divid
 {
 	uint32_t field = 0;
 	uint32_t pll_calc_error = MAX_PLL_CALC_ERROR;
-	DC_LOGGER_INIT();
+
 	/* Check if reference clock is external (not pcie/xtalin)
 	* HW Dce80 spec:
 	* 00 - PCIE_REFCLK, 01 - XTALIN,    02 - GENERICA,    03 - GENERICB
@@ -522,12 +521,14 @@ static uint32_t dce110_get_pix_clk_divid
 		/*Calculate Dividers by HDMI object, no SS case or SS case */
 		pll_calc_error =
 			calculate_pixel_clock_pll_dividers(
+				        clk_src,
 					&clk_src->calc_pll_hdmi,
 					pll_settings);
 	else
 		/*Calculate Dividers by default object, no SS case or SS case */
 		pll_calc_error =
 			calculate_pixel_clock_pll_dividers(
+					clk_src,
 					&clk_src->calc_pll,
 					pll_settings);
 
@@ -572,7 +573,6 @@ static uint32_t dce110_get_pix_clk_divid
 {
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(cs);
 	uint32_t pll_calc_error = MAX_PLL_CALC_ERROR;
-	DC_LOGGER_INIT();
 
 	if (pix_clk_params == NULL || pll_settings == NULL
 			|| pix_clk_params->requested_pix_clk_100hz == 0) {
@@ -604,7 +604,6 @@ static uint32_t dce112_get_pix_clk_divid
 		struct pll_settings *pll_settings)
 {
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(cs);
-	DC_LOGGER_INIT();
 
 	if (pix_clk_params == NULL || pll_settings == NULL
 			|| pix_clk_params->requested_pix_clk_100hz == 0) {
@@ -1370,8 +1369,6 @@ static uint32_t dcn3_get_pix_clk_divider
 	unsigned long long actual_pix_clk_100Hz = pix_clk_params ? pix_clk_params->requested_pix_clk_100hz : 0;
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(cs);
 
-	DC_LOGGER_INIT();
-
 	if (pix_clk_params == NULL || pll_settings == NULL
 			|| pix_clk_params->requested_pix_clk_100hz == 0) {
 		DC_LOG_ERROR(
@@ -1441,7 +1438,6 @@ static const struct clock_source_funcs d
 	.get_pixel_clk_frequency_100hz = get_pixel_clk_frequency_100hz
 };
 
-
 static void get_ss_info_from_atombios(
 		struct dce110_clk_src *clk_src,
 		enum as_signal_type as_signal,
@@ -1454,7 +1450,7 @@ static void get_ss_info_from_atombios(
 	struct spread_spectrum_info *ss_info_cur;
 	struct spread_spectrum_data *ss_data_cur;
 	uint32_t i;
-	DC_LOGGER_INIT();
+
 	if (ss_entries_num == NULL) {
 		DC_LOG_SYNC(
 			"Invalid entry !!!\n");
@@ -1589,6 +1585,7 @@ static void ss_info_from_atombios_create
 }
 
 static bool calc_pll_max_vco_construct(
+			struct dce110_clk_src *clk_src,
 			struct calc_pll_clock_source *calc_pll_cs,
 			struct calc_pll_clock_source_init_data *init_data)
 {
@@ -1740,6 +1737,7 @@ bool dce110_clk_src_construct(
 	ss_info_from_atombios_create(clk_src);
 
 	if (!calc_pll_max_vco_construct(
+			clk_src,
 			&clk_src->calc_pll,
 			&calc_pll_cs_init_data)) {
 		ASSERT_CRITICAL(false);
@@ -1754,7 +1752,7 @@ bool dce110_clk_src_construct(
 
 
 	if (!calc_pll_max_vco_construct(
-			&clk_src->calc_pll_hdmi, &calc_pll_cs_init_data_hdmi)) {
+			clk_src, &clk_src->calc_pll_hdmi, &calc_pll_cs_init_data_hdmi)) {
 		ASSERT_CRITICAL(false);
 		goto unexpected_failure;
 	}


Patches currently in stable-queue which might be from jirislaby@kernel.org are

queue-6.18/drm-amd-display-use-proper-context-for-logging.patch
