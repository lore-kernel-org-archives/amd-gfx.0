Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F7BC48BE6
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 20:50:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4BE76128C
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 20:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4BE76128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1C906E823;
	Wed, 16 Jun 2021 20:50:39 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 650B56E822;
 Wed, 16 Jun 2021 20:50:38 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79C5461076;
 Wed, 16 Jun 2021 20:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623876637;
 bh=KkBcxHtMW6CBQsdymw0nRgRZKWfSKaSXE49m9JbgpYE=;
 h=Date:From:To:Cc:Subject:From;
 b=qXnPj6G3RKf7L2+/RLuinTQjlA3QWCDZ554IK6ZPFRQppgKgKFSUClx1VVOmgjlsr
 WaghoO6kQ91hnYp5qeFWWb5b/i5K5a4Q5SySnJTccORLZqWyM4IINHEGLm+Y2zWs5K
 5cK5pKrVrsg5TS7DBFpnT/bggwlweazVrWsnUdflGJnuJlc7RZ+T8COCNbRAPOUyQj
 nNI1idYlTTck2lq0ivA9mS/41skVbtGrD7dXdViemS7MTC0r4rH39A3tf+TQdRGy0f
 tV89BKnLTOXUpo4CWo3nYPhzECd26PG5He23JiYZtwW6vKJ0dMqJi5ZaPaDJ+OMI9D
 WxvQpE731ufJQ==
Date: Wed, 16 Jun 2021 15:52:06 -0500
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH][next] drm/amd/display: Fix fall-through warning for Clang
Message-ID: <20210616205206.GA17547@embeddedor>
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
 linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In preparation to enable -Wimplicit-fallthrough for Clang, fix
the following warning by replacing a /* fall through */ comment
with the new pseudo-keyword macro fallthrough:

rivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c:672:4: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
                        case AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER:
                        ^

Notice that Clang doesn't recognize /* fall through */ comments as
implicit fall-through markings, so in order to globally enable
-Wimplicit-fallthrough for Clang, these comments need to be
replaced with fallthrough; in the whole codebase.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
JFYI: We had thousands of these sorts of warnings and now we are down
      to just 15 in linux-next. This is one of those last remaining
      warnings.

 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 28631714f697..2fb88e54a4bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -668,7 +668,7 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 				/* polling_timeout_period is in us */
 				defer_time_in_ms += aux110->polling_timeout_period / 1000;
 				++aux_defer_retries;
-				/* fall through */
+				fallthrough;
 			case AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER:
 				retry_on_defer = true;
 				fallthrough;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
