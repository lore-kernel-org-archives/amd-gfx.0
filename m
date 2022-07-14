Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D0FC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 16:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 169F6113BF1;
	Thu, 14 Jul 2022 16:45:41 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EEDF113BF1
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 16:45:40 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4LkL2q44zBzDrYb;
 Thu, 14 Jul 2022 16:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1657817139; bh=xdr173yUdV6H2bOcR/HCbsRH65xbrytPimpZaF7SsCc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BnfGHZ8gM0pzSDfFhHbfVTxMFY1PgM86vQ7U3srnzhrb33via26qQHvYkwFuo9Lfp
 8iEtPvTaPfp86wDHfRbwRw/ggoXWrJKxkprp2Q7m80yWjtIvhoTlRP6TetTCbESuag
 rTY++c7wnOYbomPmODh0d3NsmzxrahoNSHPmVAvI=
X-Riseup-User-ID: EB11A1FD491C23ABBAA526948F24A2E75E803645CC4D17DBD835B8F691E7EC88
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4LkL2j2SXcz5wCk;
 Thu, 14 Jul 2022 16:45:33 +0000 (UTC)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH 03/12] drm/amd/display: Remove unused clk_src variable
Date: Thu, 14 Jul 2022 13:44:58 -0300
Message-Id: <20220714164507.561751-3-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-1-mairacanal@riseup.net>
References: <20220714164507.561751-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: magalilemes00@gmail.com, tales.aparecida@gmail.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, mwen@igalia.com,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
 Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove the variable clk_src from the function dcn3_get_pix_clk_dividers.

This was pointed by clang with the following warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:1279:25: warning:
variable 'clk_src' set but not used [-Wunused-but-set-variable]
        struct dce110_clk_src *clk_src;
                               ^
1 warning generated.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 5cc7cc0b2f2d..d55da1ab1ac2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1276,9 +1276,7 @@ static uint32_t dcn3_get_pix_clk_dividers(
 		struct pll_settings *pll_settings)
 {
 	unsigned long long actual_pix_clk_100Hz = pix_clk_params ? pix_clk_params->requested_pix_clk_100hz : 0;
-	struct dce110_clk_src *clk_src;
 
-	clk_src = TO_DCE110_CLK_SRC(cs);
 	DC_LOGGER_INIT();
 
 	if (pix_clk_params == NULL || pll_settings == NULL
-- 
2.36.1

