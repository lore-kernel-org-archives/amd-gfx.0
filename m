Return-Path: <SRS0=+yFv=57=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBACC2BA2B
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 22:16:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC30C20784
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 22:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMIwcIz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC30C20784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7261F6EA9C;
	Wed, 15 Apr 2020 22:16:46 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E64996EA9C;
 Wed, 15 Apr 2020 22:16:44 +0000 (UTC)
Received: by mail-qk1-x72e.google.com with SMTP id t3so15495242qkg.1;
 Wed, 15 Apr 2020 15:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=spCyqynhDluy496NZnvbXF3CDsF0fzY7DF2oe/sZn/4=;
 b=ZMIwcIz5N/IUsU56uUjEWMC/6RS9baF2je39UzzJ8glXSWifwnpaSQXljPahxDyOXy
 +cZOMVevIsICjpitoJOwg9g3gQfIJuUPBDUwXHsasDCIxTDdI0GwV3voiTwO6jFT5uRV
 zsjeIMRd/r54oxWJljZjc4WSwDlwgoJqCzqJ3zBL+46uYCimkGT3K/wlTDVPBQtmtxXt
 BdPo0agVrErs59vkC62oigUj59iedFBtJ1OOzxa05rb6t8Mffu4XSy8zqzvr6V0YHhsw
 LLi9X6yc+WmWrxvwjYq2OUgaj4g/8UvxPirsIC/4IhOD6LGzqJP9r5FxTj9YsZ7Id6xY
 YqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=spCyqynhDluy496NZnvbXF3CDsF0fzY7DF2oe/sZn/4=;
 b=EYQYWvnhVQf73GdRvA4Tg436wpnfq5ofPWm74biBJEgKOgwiiT9Mw0rf78tphNMD3u
 U41/zzq7p/YptzZVXmkzuWDCuV2BsIfypiniprTv5Tzf4+MhIckJYdh4LG6MzCp5BGep
 NwiP57BoYwjzxXQxw0kmDdK0OcgnnD1VrCzvs/NNklOrGIEfMBYSFl/8mAXWA6IBvcyA
 pIxgKhgF5gZikL+DvAvkgROekiRf3LjP3hOiXoOYImhxvLr9MenSBUNLZS0szaehCisA
 LHanppZ2mnOvIglAyZER3i7BnSUn7G+mAeTm79xbvVIIvX3quDKB4zAzKGRnWlIEcdtJ
 74AQ==
X-Gm-Message-State: AGi0PuZlyifKDW6N5kuq27JIvXEPIeyo+bMz7e80A39mYi7VjbhXh9Bv
 5ZJHV22KdnxooSmVyMWdzkbHx4m0
X-Google-Smtp-Source: APiQypIv1OuIW6JaCdd+NnGt/HRZopuuX9tSJ94rgNmGZll/TI8vXXAThgjmgemdVp1RglAwutEk4w==
X-Received: by 2002:a37:ad0b:: with SMTP id f11mr28109793qkm.125.1586989002400; 
 Wed, 15 Apr 2020 15:16:42 -0700 (PDT)
Received: from localhost.localdomain ([172.58.187.145])
 by smtp.gmail.com with ESMTPSA id o13sm13278057qkg.111.2020.04.15.15.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2020 15:16:41 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, daniel.vetter@ffwll.ch
Subject: [pull] amdgpu drm-fixes-5.7
Date: Wed, 15 Apr 2020 18:16:31 -0400
Message-Id: <20200415221631.3924-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.2
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

Fixes for 5.7.

The following changes since commit 7e7ea24f0b46cd3078bc9af29d1c1aced89d1c8e:

  drm/amdgpu/display: fix warning when compiling without debugfs (2020-04-08 17:53:11 -0400)

are available in the Git repository at:

  git://people.freedesktop.org/~agd5f/linux tags/amd-drm-fixes-5.7-2020-04-15

for you to fetch changes up to 974229db7e6c1f2ff83ceaf3022d5128bf62caca:

  drm/amdgpu/gfx9: add gfxoff quirk (2020-04-14 12:48:43 -0400)

----------------------------------------------------------------
amd-drm-fixes-5.7-2020-04-15:

amdgpu:
- gfx10 fix
- SMU7 overclocking fix
- RAS fix
- GPU reset fix
- Fix a regression in a previous s/r fix
- Add a gfxoff quirk

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/gfx9: add gfxoff quirk

Evan Quan (2):
      drm/amd/powerplay: unload mp1 for Arcturus RAS baco reset
      drm/amdgpu: fix wrong vram lost counter increment V2

Likun Gao (1):
      Revert "drm/amdgpu: change SH MEM alignment mode for gfx10"

Prike Liang (1):
      drm/amdgpu: fix the hw hang during perform system reboot and reset

Sergei Lopatin (1):
      drm/amd/powerplay: force the trim of the mclk dpm_levels if OD is enabled

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       | 22 ++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/cik.c                 |  2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c            |  2 ++
 drivers/gpu/drm/amd/amdgpu/nv.c                  |  4 ----
 drivers/gpu/drm/amd/amdgpu/soc15.c               |  4 ----
 drivers/gpu/drm/amd/amdgpu/vi.c                  |  2 --
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c |  5 ++++-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c        |  6 ++++++
 9 files changed, 33 insertions(+), 16 deletions(-)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
