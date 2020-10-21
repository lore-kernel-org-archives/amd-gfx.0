Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14500C4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 23:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DACD22225F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 23:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="hCfitiwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DACD22225F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E89F26EEAF;
	Wed, 21 Oct 2020 23:31:36 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D43CE6EEAF
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 23:31:35 +0000 (UTC)
Received: by mail-ej1-x642.google.com with SMTP id ce10so5672776ejc.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 16:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Z8QwRD7QRbDjnmDQgcE9lLbUKe0alAiyUE4CGqYySJU=;
 b=hCfitiwYcnWpn/NqIjHp+mxx276k5ljbXO5MPTDWOtv1zouBLBEQg/nXfSJXNfmD0m
 MQHkFxcVFkPDvQZi+yuT//zCkEsd/7ZGAzE+J3PseQgSkU8nlsGvdy+kqdUGVnT3qoXD
 JYTDoH5UNCqrNVxxYbE0aLfT10zeyP9swkS9TlSHH1I/pmjJSWF40uDWgOA97tBgyGza
 dyh2SMQhMtDJ2dnYH6u6pcO4PU/ea7iwkvAXwx9JB+ATNMXw23FIaBkevfLBJgHD4lnA
 8tDl2S5w0k5YkYPphQXRaPl8Z/q70BLHAuNYl9P3emWW6UW/ulG++YrMgxsOFhRvByab
 Mt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Z8QwRD7QRbDjnmDQgcE9lLbUKe0alAiyUE4CGqYySJU=;
 b=EIh7BkxfwD20BlCMPDYYxhMlow1D10j1u1AlkVFv1fl4R/iSDernT6zcvkZOi+rAZD
 dKK3ViIbNv99Q4QMnb+KP/JgwKDQJEO8bcHRxqqoYFj/CSSXNUtNeHlELjSE7m41U3YQ
 tt7Ltv2O7k+xyMOcCI9hMIxcNqlUtFkzIlFf3S6HGuSRlNO/Qrsj3WWhSfwfdhUisWu/
 wWv0vSJO9pj36OORyD2FGelvPm5kzs27fi+iVi57LMLQmmjnfgoEJbjqRAqSxy/1ZrnR
 F7eC2zy7K23SWEQtcxT9BEszku2weEddaXu52o5fmH4XTkKxGbUCeQ/iBPRuhKLRrA3P
 QrBg==
X-Gm-Message-State: AOAM532leBLG2VukGysKLO4k7p8wgkrbq0eOe0TIdBg8ghVy07/CY+3+
 HmkKGFXrifg667ZFreu46Kgx9aENNemOT+rP
X-Google-Smtp-Source: ABdhPJylq41WCYfWjQMjZKk/2cn52gwuUrj2IdxxqBGIB0BUJSoy10DuKK0iv/Pi24UfcR325ZFCmQ==
X-Received: by 2002:a17:906:eb18:: with SMTP id
 mb24mr78915ejb.172.1603323093998; 
 Wed, 21 Oct 2020 16:31:33 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id k23sm2845236ejs.100.2020.10.21.16.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 16:31:33 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 00/11] amd/display: Add GFX9+ modifier support.
Date: Thu, 22 Oct 2020 01:31:19 +0200
Message-Id: <20201021233130.874615-1-bas@basnieuwenhuizen.nl>
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
Cc: maraeo@gmail.com, sunpeng.li@amd.com, daniel@ffwll.ch,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, alexdeucher@gmail.com,
 harry.wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This adds modifier support to the amdgpu kernel drivers for GFX9 and
later GPUs. It has been tested on

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

which has been reviewed and is ready for submission once these kernel
patches land.

v2:

Per suggestion from Daniel Vetter I added logic to get the tiling_flags at
addfb2 time and convert them into modifiers for GFX9+.  Furthermore, the DCC
constant econding modifers only get exposed on RAVEN2 and newer.

v3:

Fixed some typos, rebased and CCing more people to actually get a review.

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
