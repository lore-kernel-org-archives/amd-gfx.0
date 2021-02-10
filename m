Return-Path: <SRS0=kdbD=HM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B027C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 21:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A1164EDA
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 21:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A1164EDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 068196EC7E;
	Wed, 10 Feb 2021 21:23:35 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE4F6EC7E;
 Wed, 10 Feb 2021 21:23:33 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8865A64E25;
 Wed, 10 Feb 2021 21:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612992213;
 bh=k3bbAR+QQBOR7zd9whmQpQntZ79/acFM/RObzEoAatE=;
 h=Date:From:To:Cc:Subject:From;
 b=BqgEJkVCl0KGcfVOtXDwLivOod3poKWl51r6qsc1KvoGcbt2+SMFUVP7Pn33CoPtx
 4BTBUxGWmk3jirdxVDFeqeLr0lYHm9c3MYOANm+2xiL4KBiSY7gseZEAIDdm92aSQ1
 5NISc/OT1CVUYEmOJ5d2WHKsGYUDvC5QlSc7n7s/7+67IVg3k00gFYjyuDwA7lm5Gu
 1dTeSOnBYXVLq2ZKlqalDU+mZOXAvb6TvObkSKCHqtR1MIxnvWsDkrkwWE/lEB7th0
 6YSOov/V1LzFUuSQrmkQbr+mBDrX8YiAq9nUhn5/xJGwOOHYrevHtdMMxn0vZXoTgM
 cksH2GFNWTrpg==
Date: Wed, 10 Feb 2021 15:23:30 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Huang Rui <ray.huang@amd.com>, Anson Jacob <Anson.Jacob@amd.com>,
 Lang Yu <Lang.Yu@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Subject: [PATCH][next] drm/amd/display: Fix potential integer overflow
Message-ID: <20210210212330.GA880153@embeddedor>
MIME-Version: 1.0
Content-Disposition: inline
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
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix potential integer overflow by casting actual_calculated_clock_100hz
to u64, in order to give the compiler complete information about the
proper arithmetic to use.

Notice that such variable is used in a context that expects
an expression of type u64 (64 bits, unsigned) and the following
expression is currently being evaluated using 32-bit arithmetic:

actual_calculated_clock_100hz * post_divider

Fixes: 7a03fdf628af ("drm/amd/display: fix 64bit division issue on 32bit OS")
Addresses-Coverity-ID: 1501691 ("Unintentional integer overflow")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index bc942725b9d8..dec58b3c42e4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -240,7 +240,7 @@ static bool calc_fb_divider_checking_tolerance(
 		pll_settings->calculated_pix_clk_100hz =
 			actual_calculated_clock_100hz;
 		pll_settings->vco_freq =
-			div_u64(actual_calculated_clock_100hz * post_divider, 10);
+			div_u64((u64)actual_calculated_clock_100hz * post_divider, 10);
 		return true;
 	}
 	return false;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
