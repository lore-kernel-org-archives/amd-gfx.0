Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F7BC433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 04:19:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6044D2054F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 04:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0ktcmQ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6044D2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9858C6E899;
	Thu, 20 Aug 2020 04:19:48 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49D936E899;
 Thu, 20 Aug 2020 04:19:48 +0000 (UTC)
Received: by mail-qk1-x735.google.com with SMTP id 77so550837qkm.5;
 Wed, 19 Aug 2020 21:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RvULETJwk2IiB74XHTw5W59pe9nQWPqMJW+Etxr1Xvk=;
 b=E0ktcmQ4k6AYDLklJby5K+wdsdQi9EIQUG5bf71N0CJaOeQm3hm87zarc9K+Up9RoK
 uVCIs5x1VNQbR/zpdZy8dZCHRbq8+rNSxgnUk4RJNGHJdJ6BFmV4F+8qhq19v5qmTCXY
 8upVw3pUTJ9NWjTGf23KXEXoX/LKFedi+dso4Mjm0KqOniYB5lDW+YxcAZ+8o1yr8pMA
 7yhQqJOKjZyCM5ve32/8ok5BJ5M1q1JcNnSykhyRj2JpsSLAwEYRZkDOWO1PIAJT4QJr
 QZZEALu+DxwfYwmjgoEkPLzTckYqOUfe02uEvHNdHYb6K1yNheWaQKhqj8up80hbRfk6
 GoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RvULETJwk2IiB74XHTw5W59pe9nQWPqMJW+Etxr1Xvk=;
 b=VPRtaNmYYNPyohMFLe14fw98Rk1j/merBD4GT65sSCLr2yFaQEKNJDsVWgTLz7fbNc
 /XEuVUtmYiEVeVTJS5N06A4t9tGywlsc5HPqaEwegW5fIig2lr2I9EYeDd58eBc8X+e5
 UFBrmyvf7OOjj+cHW1El9z51CBLrKqag65/XpLxVXOoBoozbe3F6MqbVAEaW4fqIj8do
 2kW2EvLNAIXweIVv026Ez6dJgKzDyEPOt8BxYQdwehR0hfgxp03/3doCujS1HkhO6lOc
 mAbkfRcKTqtFII/9xXKddJah1FWLxL+t1k1nQkuyaw977h4OE58fKipwUUfnkcvYW3Ds
 m4Vw==
X-Gm-Message-State: AOAM531jFFdBBcMLw8/0BpOhNZQwxwCXChmRzVzvDVKXlQno8EdBnqO1
 aV6mM3cYpV1YF6GJhk6icX/NUgvOKjc=
X-Google-Smtp-Source: ABdhPJzxGikdqhJbioGXeRUj4mgQGOFfA/Y6pbgDHXWHqVvI03lfwesRDHXAmppNctHbLFtZklZl/Q==
X-Received: by 2002:a37:7407:: with SMTP id p7mr1144311qkc.350.1597897187079; 
 Wed, 19 Aug 2020 21:19:47 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id w2sm963034qkf.6.2020.08.19.21.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 21:19:46 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, daniel.vetter@ffwll.ch
Subject: [pull] amdgpu, amdkfd drm-fixes-5.9
Date: Thu, 20 Aug 2020 00:19:38 -0400
Message-Id: <20200820041938.3928-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Dave, Daniel,

Fixes for 5.9.

The following changes since commit f41ed88cbd6f025f7a683a11a74f901555fba11c:

  drm/amdgpu/display: use GFP_ATOMIC in dcn20_validate_bandwidth_internal (2020-08-10 18:09:46 -0400)

are available in the Git repository at:

  git://people.freedesktop.org/~agd5f/linux tags/amd-drm-fixes-5.9-2020-08-20

for you to fetch changes up to da2446b66b5e2c7f3ab63912c8d999810e35e8b3:

  Revert "drm/amdgpu: disable gfxoff for navy_flounder" (2020-08-19 23:55:04 -0400)

----------------------------------------------------------------
amd-drm-fixes-5.9-2020-08-20:

amdgpu:
- Fixes for Navy Flounder
- Misc display fixes
- RAS fix

amdkfd:
- SDMA fix for renoir

----------------------------------------------------------------
Bhawanpreet Lakha (1):
      drm/amdgpu: parse ta firmware for navy_flounder

Chris Park (3):
      drm/amd/display: Call DMUB for eDP power control
      drm/amd/display: Assign correct left shift
      drm/amd/display: Reset scrambling on Test Pattern

Dmytro Laktyushkin (1):
      drm/amd/display: fix dcn3 wide timing dsc validation

Guchun Chen (1):
      drm/amdgpu: fix NULL pointer access issue when unloading driver

Huang Rui (1):
      drm/amdkfd: fix the wrong sdma instance query for renoir

Jiansong Chen (2):
      drm/amdgpu: disable gfxoff for navy_flounder
      Revert "drm/amdgpu: disable gfxoff for navy_flounder"

Kevin Wang (1):
      drm/amdgpu: fix uninit-value in arcturus_log_thermal_throttling_event()

Krunoslav Kovac (1):
      drm/amd/display: fix pow() crashing when given base 0

Paul Hsieh (1):
      drm/amd/display: Fix DFPstate hang due to view port changed

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  | 31 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |  2 --
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |  3 +--
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 16 ++++++++++-
 .../gpu/drm/amd/display/dc/bios/command_table2.c   | 28 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/bios/command_table2.h   |  3 ++-
 drivers/gpu/drm/amd/display/dc/dc_bios_types.h     |  4 +++
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    | 24 +++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |  4 +--
 .../drm/amd/display/dc/dcn20/dcn20_link_encoder.h  |  4 ++-
 .../amd/display/dc/dcn30/dcn30_dio_link_encoder.h  |  5 +++-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c  |  1 +
 .../amd/display/dc/dml/dcn30/display_mode_vba_30.c |  4 +++
 .../drm/amd/display/include/bios_parser_types.h    |  7 +++++
 drivers/gpu/drm/amd/display/include/fixed31_32.h   |  3 +++
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       |  9 ++++---
 16 files changed, 126 insertions(+), 22 deletions(-)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
