Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18885C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 18:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF5DB64E77
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 18:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5DB64E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67B7C6E0C9;
	Fri, 19 Feb 2021 18:58:29 +0000 (UTC)
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch
 [185.70.40.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB95B6E0C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 18:58:27 +0000 (UTC)
Date: Fri, 19 Feb 2021 18:58:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1613761106;
 bh=F6uj8VFe3iwUFLbZPlLw6VGjlaMlelQ9IYw8LId5yek=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=OAcBMejAeYATLTXmi8neil2RUP70JlYvWSZCnEJeHmUeiayqKJvxJGAguAA2RVcxc
 9HXlE3+cmhxSYJm9Zgev8ylDXfs7olAEDpYDbGgkguJwBnCCcGoFlgUQPgUmuRyB6p
 IbsTmUjtF1pJwq+cmB0sww6zktQ33E1zsarbfKMuH00TwNXgo+WuLLM9rXV3Uf/3am
 FWldkqXJrBbKEFm8plFOMaM9arlGYg14r1BrtRHPmMC9+rco9ObZ9V8RdyJn3TZgmn
 U/hmVTKAItuqKOnf2TkoG2rw6fb6k0kgyaTKSL1ZIwOqt85z5Cnp2oo59qFJCZvzkp
 mpSkk/NSea1bQ==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH 4/6] amd/display: add cursor check for YUV underlying pipe
Message-ID: <Jz5GoxkabIxmxlcd8cgr4IK13ro7Zg39DZZITtFb0@cp4-web-040.plabs.ch>
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The cursor plane can't be displayed if the underlying pipe isn't
using an RGB format. Reject such atomic commits so that user-space
can have a fallback instead of an invisible cursor.

In theory we could support YUV if the cursor is also YUV, but at the
moment only ARGB8888 cursors are supported.

Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a5d6010405bf..6e7f4a182e89 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9250,6 +9250,13 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
 		return -EINVAL;
 	}
 
+	/* In theory we could probably support YUV cursors when the underlying
+	 * plane uses a YUV format, but there's no use-case for it yet. */
+	if (new_underlying_state->fb->format->is_yuv) {
+		drm_dbg_atomic(crtc->dev, "Cursor plane can't be used with YUV underlying plane\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.30.1


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
