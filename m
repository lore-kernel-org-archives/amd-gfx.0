Return-Path: <SRS0=NjTA=G7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45912C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 19:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF83D64E34
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 19:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF83D64E34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 456376E9B8;
	Thu, 28 Jan 2021 19:16:13 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 317CB6E9B8;
 Thu, 28 Jan 2021 19:16:12 +0000 (UTC)
Received: by mail-qk1-x72d.google.com with SMTP id 19so6406241qkh.3;
 Thu, 28 Jan 2021 11:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uKWppjoyPlKvDPCM4nZgYRlU6HkJoizZjnD/VkClUGg=;
 b=uWTKE8oGboFk26+37k1DBX9S6S/ANxtTjOXcYorIn34Abv5PYNhYPNccJDOZvZaI6+
 mN9MRTABnbL8w1aNh112u2m/h770MkcTcH/W0uC9jyXWnrXngdh7XIDtpuBm5n7MBokB
 PPs7h82Fsq7xQubGbJQ8lUL9MSRWKwqQ1XgekD/lv4l/A5k750rqr72JDVZZcKB0oo/a
 haVNvXjRIWROlOrm1sVn3HwIW6LxtxKHGKpONQlch4m5p4SyopJ3rLkaoQ7zZnB0p3MW
 Bc7oDNeNNfFYE7Ij4HukkSwjSaQ1bGkQlH/PMzWTyHtxXgr708OZ5McCGwxV4jgVK65y
 lp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uKWppjoyPlKvDPCM4nZgYRlU6HkJoizZjnD/VkClUGg=;
 b=hXDw6Uix2ljDFXSUXwSyO5dF7O3HjnEDqFOF5leid+puUd79HMYidgCkVhNRFdgiqT
 GAgMi88IkTlOziiNFMLmhDcv6wUdIuEM2zqwIgTgysIKFlmWu79BDN/0nd3061iamgvi
 W/E+WWjhcLRl+fPwYR7h5kVo5hrLuwC6olzmnwS9Kpm6uhaEZ4V01vXyTklO1ds8qYag
 qahkVybzFOIit45cu67Xx1wXkiqeukGfOwEdOsC8CeGxwd+g9C1Q9RO52gPySPGLARd9
 HQUAaIbSsTuaO+sSxg9P1u08nLTWMV1rnicGyeT6zfc/BKQ8DssvujXysZ+bEZzyBuOJ
 b99w==
X-Gm-Message-State: AOAM531cKi37HWBypPcXVwwExU8dQNKfaaCSKdgOC1PZQMoqAK8vVF4w
 tQCcfRQSw379WeDR4whOUBwMYjJUGME=
X-Google-Smtp-Source: ABdhPJybyzTvD/I9LqJ0Gv5DTRWc6yEa075sLMNpLkvSyUjwBvPGSXLDnqnTFtm2jTkg2I1K6qARtA==
X-Received: by 2002:ae9:e602:: with SMTP id z2mr713948qkf.403.1611861371279;
 Thu, 28 Jan 2021 11:16:11 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id c12sm4064284qkg.118.2021.01.28.11.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Jan 2021 11:16:10 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, daniel.vetter@ffwll.ch
Subject: [pull] amdgpu drm-fixes-5.11
Date: Thu, 28 Jan 2021 14:15:58 -0500
Message-Id: <20210128191558.3821-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
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

A couple of fixes for 5.11.

The following changes since commit 06ee38dc2aab3b5a09feb74128cf7326a490b788:

  Merge tag 'amd-drm-fixes-5.11-2021-01-21' of https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2021-01-22 09:43:21 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-5.11-2021-01-28

for you to fetch changes up to 00190bc087e795290502dc51c5d32de85cb2c2b8:

  amdgpu: fix clang build warning (2021-01-28 13:40:48 -0500)

----------------------------------------------------------------
amd-drm-fixes-5.11-2021-01-28:

amdgpu:
- Fix a fan control regression on some boards
- Fix clang warning

----------------------------------------------------------------
Alex Deucher (1):
      Revert "drm/amdgpu/swsmu: drop set_fan_speed_percent (v2)"

Arnd Bergmann (1):
      amdgpu: fix clang build warning

 drivers/gpu/drm/amd/display/dc/dcn30/Makefile      |  6 +++--
 drivers/gpu/drm/amd/display/dc/dcn301/Makefile     |  3 ++-
 drivers/gpu/drm/amd/display/dc/dcn302/Makefile     |  3 ++-
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h            |  1 +
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h             |  3 +++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  9 ++-----
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |  1 +
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     | 31 +++++++++++++++++++++-
 10 files changed, 47 insertions(+), 12 deletions(-)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
