Return-Path: <SRS0=eFkV=CN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279D9C433E2
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2020 16:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2AC32074D
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2020 16:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen-nl.20150623.gappssmtp.com header.i=@basnieuwenhuizen-nl.20150623.gappssmtp.com header.b="R4rzUvNS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2AC32074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAF476EC76;
	Fri,  4 Sep 2020 16:07:11 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7181D89394
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2020 16:07:10 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id x14so7231876wrl.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Sep 2020 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen-nl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dVLnBf+HCHWVdh9m6Z43Xg9vlvgeQWVYTf+jx0D/QhA=;
 b=R4rzUvNSDTzGTJq/6QMIDSc0vwZGx4NvSraeGnvwzk+4aMZUOarvXt0SUvQ79kK8tu
 tvMoiP4jxNfy/0W38n4aEBRKnU4ziXKQfgMoI854/wj4hgg/Td1+Xuk1ftl1419Ty9AW
 c/e1F7yqOXGBR4U7kA28rqkRk4XJ/qxtpnPmSO6b53XHmiS5EmRhFD7u4QYh2kElhAUD
 /m64njKdpOOIbLXRQUEtX25NzH4apsAzpkuBoCDlOpz8KhKbP3lF365UVTxqk89JmNdu
 FeFeQmCF+inRZ8tr8aE/VJdLIO4nVcaLYadDsCe/hgeoJ888EYTpBZB3N1ukeJ1W7ktJ
 SIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dVLnBf+HCHWVdh9m6Z43Xg9vlvgeQWVYTf+jx0D/QhA=;
 b=VR7lpXefEb3mlvuaXUE8j6YIxytJwelqZVJRgwI7eOh1zYwh0NPYVXCvokYaw7JY+s
 u43sxMAfC6Y+XZKDSL6m3xujl5Xmfx1ucyc4TULUORTvVZEzrJbt9v+D9bj7ZIClDmPM
 RAnoHihMV/KReXpopEMxghpNZZEXzVLoBxfOM/1LR1IEN3LUJN+HGACYJl5w0NlwdZHf
 rGUnNP/ZIOz6hmMPPIXONWaU1QibzN5iDBiBBp0YGdDL9RW7ilJmJzZ1AOAXpkcqauBl
 EUjXyDm0joEGbvE20luFXgwrKqg2rTMyrO7NAOqXdgHz/oTKb4hiEQT2+YRuwg7tyPsJ
 e07g==
X-Gm-Message-State: AOAM530CbaKMypD/FsxcCy3aQuQjO1bmCya4nepcw5GRLqXOJw0g3GG3
 5th7UBrF9SnOce9hQHx5NGWdv5XTqHx76M1B
X-Google-Smtp-Source: ABdhPJwA/BTMcEPzH72GJwHTTbUagnG1yVGFoQLpQ6ushKuS0WjcuGo4/RnRdoJyPLSL9izGJ21S6g==
X-Received: by 2002:adf:f3cd:: with SMTP id g13mr8276389wrp.298.1599235628671; 
 Fri, 04 Sep 2020 09:07:08 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id h185sm12467609wme.25.2020.09.04.09.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 09:07:07 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 00/11] amd/display: Add GFX9+ modifier support.
Date: Fri,  4 Sep 2020 18:06:58 +0200
Message-Id: <20200904160709.123970-1-bas@basnieuwenhuizen.nl>
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
 alexdeucher@gmail.com, harry.wentland@amd.com
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

v2:

Per suggestion from Daniel Vetter I added logic to get the tiling_flags at
addfb2 time and convert them into modifiers for GFX9+.  Furthermore, the DCC
constant econding modifers only get exposed on RAVEN2 and newer.

Bas Nieuwenhuizen (11):
  drm/amd/display: Do not silently accept DCC for multiplane formats.
  drm/amd: Init modifier field of helper fb.
  drm/amd/display: Honor the offset for plane 0.
  drm/fourcc:  Add AMD DRM modifiers.
  drm/amd/display: Store tiling_flags in the framebuffer.
  drm/amd/display: Convert tiling_flags to modifiers.
  drm/amd/display: Refactor surface tiling setup.
  drm/amd/display: Set DC options from modifiers.
  drm/amd/display: Add formats for DCC with 2/3 planes.
  drm/amd/display: Expose modifiers.
  drm/amd/display: Clean up GFX9 tiling_flags path.

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 169 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |   3 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 754 ++++++++++++++----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   2 -
 include/uapi/drm/drm_fourcc.h                 | 115 +++
 6 files changed, 880 insertions(+), 165 deletions(-)

-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
