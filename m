Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002DAC4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 23:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA1C32071A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 23:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="cATGe3p6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1C32071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23E836E81A;
	Wed, 28 Oct 2020 23:52:42 +0000 (UTC)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 141606E81A
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 23:52:40 +0000 (UTC)
Received: by mail-ed1-x543.google.com with SMTP id v19so1273680edx.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 16:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sBKS5W6Qfd3E+vFbxnk6rQl20c3PMgFSFAhdfMtzT4M=;
 b=cATGe3p6bhezRdsUcp5KzVfZo5bobZAARmbEY2/eu3biuYSUIWzrTyPUSf8xmf2ac/
 yWai1rHgIlI5hztTX4r5hy745XBXsWqSLP8JtiXzbS4PXvwMiKKLZbypKMT3BdY9uV7a
 +3s/I4KZ+ejsHkLzqG39MPkm/dglZ64YXzfXrqfYsvEQs3bEYnLkAoVv/RngvNaS+XU5
 h54XGs0zhk0bpYSufnrAEpkgWFD60DN6Q+foIgX2mRSv6dEARV4e2nIHsqWD1V/rBKKb
 mRAt/e+vt4FrgpBa0Q6M3iIQbfovVcorcimYAvyMBMfvcR/kfBSALdwz5D3NmzEjV6O8
 y7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sBKS5W6Qfd3E+vFbxnk6rQl20c3PMgFSFAhdfMtzT4M=;
 b=ZHci+G2fyiVyJ86B1yyLqyr7MSVN+o/FjywsOmBEy2R0JGbukf6IVGSGMHHA8ihm4h
 3W9JAZx76UONAq7tOgLTGLyNTzzWx5iLeflKNRNRM/UAKiw15QQI/xMJX4pjOTLfJwa3
 cd8sgKwBzYc919RfZJmLSeTHsxyjkIHo0RePz04GA1J/gYkCeOgKN/NQQmTNXl1c7qum
 BF3Oazqz4iimzFBdX4pVnbxRESOXCSTba45GJuMfWSFna2nBb233cUR6jM8u+HFDWSxt
 MYsACR7OfqeHJsk7wHKiyLxUac25Rz9sG+v/q8LDqE6CxeGCN2FdcrMSW4WQ+9x3/Mte
 kogQ==
X-Gm-Message-State: AOAM530MkzCS/fLM3ebKxK91V9GebM1ESpH1vyK8zB/X6nUHZkvkP337
 IzLO/brt6e0QdLJOIqzHo8YxuaZPahFh+A==
X-Google-Smtp-Source: ABdhPJwn7TbkObWp8B56tzoNmJpa8FhOkyKrKBzCITlVXyJ1CxHglYyOZGO+uySqa//TR6SSwjJVgw==
X-Received: by 2002:a50:9e0b:: with SMTP id z11mr1419818ede.341.1603929159177; 
 Wed, 28 Oct 2020 16:52:39 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id o13sm479174ejr.120.2020.10.28.16.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 16:52:38 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 00/11] amd/display: Add GFX9+ modifier support.
Date: Thu, 29 Oct 2020 00:52:30 +0100
Message-Id: <20201028235241.3299-1-bas@basnieuwenhuizen.nl>
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
Cc: alexdeucher@gmail.com, harry.wentland@amd.com, nicholas.kazlauskas@amd.com,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
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

v4:

Changed an initialization from {0} to memset, fixed a missing switch case
in the modifier enumeration and added review tags.

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
