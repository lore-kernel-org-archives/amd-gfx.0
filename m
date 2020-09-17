Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B59C433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 07:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34F62083B
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 07:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7GljKPK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34F62083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 244496E0D8;
	Thu, 17 Sep 2020 07:33:43 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A3CC6E0D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 07:33:42 +0000 (UTC)
Received: by mail-ej1-x643.google.com with SMTP id z22so1842531ejl.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 00:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5mNR2/ooYXSVXL92VfFJ3F6Ynnuh7NgUGj2yCNEIGL8=;
 b=D7GljKPKshfFziYf4mzgd+hBsgkQsQPgTBBmvheGTFi7jNQJoneoeztowXPOtNR2oE
 OWY11bpG7v+erhnpot6hNB6PF+LtcLG14wnVkQFk1l46KqxWvDIu0pKnn4c18c4XZxue
 KjGePAV096hwVhIkgQZqSbPcA0HKiUJcgforl7wN5TSTvblA4afS6fjamahgjujRg4oY
 JFz0wQABudmrDIbbvIb2zvbmeVk/2/DMRvoKUWEpQjOfNcV6rs4pdVTaQcYC5VqsDnxT
 j6HRMuYIdoZ+SpQuvJFNz/JuvlGXbd0gll1mkwSmf2wCSCg6Vk8ATrhaS/zG57KZYRJh
 U6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5mNR2/ooYXSVXL92VfFJ3F6Ynnuh7NgUGj2yCNEIGL8=;
 b=h0yyW95+z3Gi6qZ9nEACwR/30mNFVMyaxtNf7dR2/kEY1O8pS0R+gY/SbCdnOiku5K
 DZUGxJ5lljqpZO98SwX3bA+YE+03Zfo96Szz0sqeZtHX5981yRzNtnuU097b3WnRnKrD
 m1h1rfyqz+I2eE9vnf6CQ9cPNj2ka3SlyNt26188a3ShkLPsZatmDNXziWSCZMt467cV
 ObK1+DTp8QlHfl3MHoSFGMaBqO5dFkv+lHHdSuk/wkWy/I8+Aao2oUtNcb6ekdSdWUo8
 ZWZe0QoViCQvJCSWd/NzC6p6Rq9MtUruvTiJg8nUe/RLgrODSj2pRgEdJitVnSUJ1rBG
 pOgQ==
X-Gm-Message-State: AOAM531atC5XzK2OuwkVx/g80wQPPjtWH14xFNgY6VbZY4Cp0bAfyUGh
 X3N1d8KpAdJxo52rsm2W0V+iwmDaYuM=
X-Google-Smtp-Source: ABdhPJw6+IMtAEhBK4VI6X5goxV/i5ssTbCZ26rzuBdHdKAAgZ+/e5znixRKDNK9o9KgyWbsFZMILw==
X-Received: by 2002:a17:906:c309:: with SMTP id
 s9mr31206966ejz.167.1600328020304; 
 Thu, 17 Sep 2020 00:33:40 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-40-11-15.business.telecomitalia.it. [79.40.11.15])
 by smtp.googlemail.com with ESMTPSA id q1sm10325937ejy.37.2020.09.17.00.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 00:33:39 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: dc/clk_mgr: add support for SI parts (v3)
Date: Thu, 17 Sep 2020 09:33:31 +0200
Message-Id: <20200917073331.440434-1-issor.oruam@gmail.com>
X-Mailer: git-send-email 2.25.1
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
Cc: alexander.deucher@amd.com, Mauro Rossi <issor.oruam@gmail.com>,
 harry.wentland@amd.com, christian.koenig@amd.com,
 kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

(v1) Changelog

[Why]
After commit c69dd2d "drm/amd/display: Refactor clk_mgr functions"
dc/clk_mgr requires these changes to add SI parts support
Necessary to avoid hitting default: ASSERT(0); /* Unknown Asic */
that would cause kernel freeze

[How]
Add case statement for FAMILY_SI chipsets

(v2) Changelog

[Why]
DCE6 has no DPREFCLK_CNTL register

[How]
Add DCE6 specific macros definitions for CLK registers and masks
Add DCE6 specific dce60/dce60_clk_mgr.c for DCE6 customization
Code style: reuse all the public functions in dce100/dce_clk_mgr.h header
Code style: use dce60_* static functions as per other DCE implementations
Add dce60_get_dp_ref_freq_khz() w/o using DPREFCLK_CNTL register
Use dce60_get_dp_ref_freq_khz() function in dce60_funcs
Add DCE6 specific dce60_clk_mgr_construct
dc/clk_mgr/dce_clk_mgr.c: use dce60_clk_mgr_construct for FAMILY_SI chipsets
Add Makefile rules for dce60_clk_mgr.o target conditional to CONFIG_DRM_AMD_DC_SI

(v3) Changelog

[Why]
linux-next kernel test robot reported the following problem:
warning: no previous prototype for 'dce60_get_dp_ref_freq_khz' [-Wmissing-prototypes]

[How]
mark dce60_get_dp_ref_freq_khz() as static

Fixes: 3ecb3b794e2 "drm/amd/display: dc/clk_mgr: add support for SI parts (v2)"
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
index c11c6b3a787d..0267644717b2 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
@@ -80,7 +80,7 @@ static const struct state_dependent_clocks dce60_max_clks_by_state[] = {
 /* ClocksStatePerformance */
 { .display_clk_khz = 600000, .pixel_clk_khz = 400000 } };
 
-int dce60_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
+static int dce60_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	int dprefclk_wdivider;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
