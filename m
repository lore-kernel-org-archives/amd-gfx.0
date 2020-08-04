Return-Path: <SRS0=+8vs=BO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0C1C433E1
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 21:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 070B922BED
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 21:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen-nl.20150623.gappssmtp.com header.i=@basnieuwenhuizen-nl.20150623.gappssmtp.com header.b="X5Hetv2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070B922BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FE006E096;
	Tue,  4 Aug 2020 21:32:11 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C52096E03E
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2020 21:32:09 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id d190so3957280wmd.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Aug 2020 14:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen-nl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DF5yKzOPMXVYngQSBfD05wSpsfrYcHWC8kfD4ia0he8=;
 b=X5Hetv2i20phNPeysBMxrpvbCw1680QQcLa9h94KZpQN+puvrnT2Vt+tz59KPZLvst
 d7nxvSsNM980eMV3iuwL3f9MoryemPn4GwFytGIxtCBWDEh4ZR4QIIXvU112pZBrHXdw
 VGsUFwCinb3qG4QdVLVokiEBOeMGFknnSzvbj5XJ9w7FNMczQkMZC7CRU+JfHYiW4uNQ
 JrAMlNa7jwd0mdbtu593vZjlK3k+k8fiIsAQALmzchn+CqCTJFBQRirizzWwAnEmhnha
 oR8zBjHSRpD0+Z1NLI5n/B/Yv7EwnBmKcfrIZSU7Arm7oUvPSjQQEDEz20qdiSscZ8JZ
 kjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DF5yKzOPMXVYngQSBfD05wSpsfrYcHWC8kfD4ia0he8=;
 b=UpxPIvwpQJQ1nZCKT8suR46zXdLjHnBttJt6necwDlL0RXPSmm+TBvSitK4S7gRDqx
 Hqwum8VUCXCaPkNKk7dOeA9BQREFE6nDVBA9S1izZM4VnfC5aOlczxaPk+mIbt4jkooe
 fW1etYLBJ201xWEDwb92HCpF1jgZghEuhqXHuEYtm7hJcSVPgutr++aL8MW9Zy5jcYSG
 hcaT15q8bPayXk7HLzjeZ8+JdzhxHRHFYFqjPzqIZn/ULkzk0Wp3FW6hWJm87byCcwsF
 aVXfJnK9SWCU9qk8qSvUWX0zDL6t0NURbN3tFu9dgMUOaKl7zGpvboRzwVAer6qT2oHw
 wjZw==
X-Gm-Message-State: AOAM532des7udMmQ+f8E2wZqsgQCjjIhY1VRtcSdonWLaE9+H0Y5LDpn
 LjsaOQmkZi670+B+UwFC1TZmrJ6nns+o0A==
X-Google-Smtp-Source: ABdhPJyqjoYqAxdILDMHmmRCdSipij570vuqXhhbIObdvyHI//y80TnursbmM7JKudu5PlcObRw/AA==
X-Received: by 2002:a1c:9803:: with SMTP id a3mr323249wme.57.1596576728200;
 Tue, 04 Aug 2020 14:32:08 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:ce92:471f:873f:fc56])
 by smtp.gmail.com with ESMTPSA id x11sm97612wmc.33.2020.08.04.14.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 14:32:07 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/8] amd/display: Add GFX9+ modifier support.
Date: Tue,  4 Aug 2020 23:31:11 +0200
Message-Id: <20200804213119.25091-1-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.28.0
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
Cc: maraeo@gmail.com, daniel@fooishbar.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This adds modifier support to radeonsi.
It has been tested on

- VEGA10, RAVEN, NAVI14
- weston, sway, X with xf86-video-amdgpu (i.e. legacy path still works)

and includes some basic testing of the layout code.

The main goal is to keep it somewhat simple and regression free, so
on the display side this series only exposes what the current GPU
can render to. While we could expose more I think that is more
suitable for follow-up work as the benefit would be minimal and
there are some more design discussion there to discuss that are
orthogonal from the initial implementation.

Similarly this series only exposes 32-bpp displayable DCC in the cases
that radeonsi would use it and any extra capabilities here should be
future work.

I believe these are by far the most complicated modifiers we've seen
up till now, mostly related to

- GPU identification for cases where it matters wrt tiling.
- Every generation having tiling layout changes
- Compression settings.

I believe the complexity is necessary as every layout should be different
and all layouts should be the best in some situation (though not all
combinations of GPU parameters will actually have an existing GPU).

That said, on the render side the number of modifiers actually listed for
a given GPU is ~10, and in the current implementation that is the same
for the display side. (we could expose more actually differing layouts
on the display side for cross-GPU compatibility, but I consider that
out of scope for this initial work).

This series can be found on
https://github.com/BNieuwenhuizen/linux/tree/modifiers

An userspace implementation in radeonsi can be found on
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/6176

Bas Nieuwenhuizen (8):
  drm/amd/display: Do not silently accept DCC for multiplane formats.
  drm/amd: Init modifier field of helper fb.
  drm/amd/display: Honor the offset for plane 0.
  drm/fourcc:  Add AMD DRM modifiers.
  drm/amd/display: Refactor surface tiling setup.
  drm/amd/display: Set DC options from modifiers.
  drm/amd/display: Add formats for DCC with 2/3 planes.
  drm/amd/display: Expose modifiers.

 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c        |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 758 +++++++++++++++---
 include/uapi/drm/drm_fourcc.h                 | 115 +++
 3 files changed, 775 insertions(+), 100 deletions(-)

-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
