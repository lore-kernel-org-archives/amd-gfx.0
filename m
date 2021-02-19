Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FBCC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 18:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A077564EB3
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 18:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A077564EB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32D306E07D;
	Fri, 19 Feb 2021 18:58:02 +0000 (UTC)
Received: from mail2.protonmail.ch (mail2.protonmail.ch [185.70.40.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F7E86E07D
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 18:58:01 +0000 (UTC)
Date: Fri, 19 Feb 2021 18:57:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1613761078;
 bh=LCCh8m0Natx98HjwB7VBwIvHk++P57FhBPzorUfmhD8=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=BtZuQoEjmw+KL6ArzM0oAEY+zNxJXWbyU8MARG57aarQuo0JZJZ+VHPvJmsv7H/Ot
 2naKw8qwJSd5Wzsba/oz9ChTvHhDfkf0aZboR/CIdoZ1q7KcVmP+j/cQS373G9kPXy
 VrN3U+i+rDfUSzWqPwy/ct9bQ8xUSvihDtd2ThJUcn6ebvFaF7K3fwdhMTCJQWbUyg
 i5CvTwltlCpyhbwtmqeTie7vBRKsxGIHQdj8qrLFlqFmAGise/clmajeaxAcJIvoS/
 jbxC16vRZ562qGBt3mc81bLicL/WYGsuXvSCGidVjHD7ZpWTB70Q+BD1aTrtdUAstP
 s+t84BVUIJctA==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH 1/6] amd/display: convert DRM_DEBUG_ATOMIC to drm_dbg_atomic
Message-ID: <SHjyOdF2R3qhIdLJXN7VgUq8cq8Fner9qpxaIxR5NNM@cp3-web-020.plabs.ch>
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

This allows to tie the log message to a specific DRM device.

Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 519080e9a233..4548b779bbce 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9235,7 +9235,7 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
 
 	if (cursor_scale_w != primary_scale_w ||
 	    cursor_scale_h != primary_scale_h) {
-		DRM_DEBUG_ATOMIC("Cursor plane scaling doesn't match primary plane\n");
+		drm_dbg_atomic(crtc->dev, "Cursor plane scaling doesn't match primary plane\n");
 		return -EINVAL;
 	}
 
-- 
2.30.1


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
