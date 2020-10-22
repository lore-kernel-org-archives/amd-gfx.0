Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B5DC388F7
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 04:03:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6F882225D
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 04:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsWMI+oo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F882225D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F157E6E18E;
	Thu, 22 Oct 2020 04:03:33 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED0896E18E;
 Thu, 22 Oct 2020 04:03:32 +0000 (UTC)
Received: by mail-qv1-xf31.google.com with SMTP id g13so274067qvu.1;
 Wed, 21 Oct 2020 21:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=l+7AwfbO8zo/GHK8p648ueOLCnO6Qs6eToeKKf6rMpY=;
 b=OsWMI+oomYhVJvpGOL2M3FBhIBx4FMfOeDHEo1G9mUFJVKru3aEZmKHJ6ZNaqMW71p
 4pmIeNTOuRml6ndxD9SvQPc95iwsacSj7akqHxIDplprM3OVZNx2vNuFboo3TrcIt+ey
 EDQgYz+LTmHIJsLK3Y3DgrZuQXBxReoa/SlRLPs+LwtghLqMKBdxR1ZWMbYejbo4eabn
 5IF479Sh/h/Oppi8dEfEJiL95IkCb5QqIH7dNCxIRYumJnZCUfLJ4L7GJcW8/AvLQ26X
 pLaFXmi0bx8Ze++xvklRe8QUsixb6mnb4fY+urDk1RduZ3U9Sk9cOf9CTVZBtJYpnI5D
 i31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=l+7AwfbO8zo/GHK8p648ueOLCnO6Qs6eToeKKf6rMpY=;
 b=P6buSIbzOaNJbWInRp9csuauXQ/WHRYggTEcfyfc8708zQ/3ku5sEmQLrc/vg6UsrZ
 v0nN6V1D0Rw1HWbfvuRk8XPfs5nKhwtN74hJU1ua++48VPHwjiHWn8II7QzKHWjKvw5q
 hIWTqFljecGY6ZTIyDiirS6i38m2dRZyh95uiiw+vldGIW7wKyMtAkqDFLEmX2owuCOd
 HktbRMveC7WlzCKi21K1wJcb9JZga8D9sWFsyNuB9b/Rvfv3gTQzkQ0ZGmS2vt837Z2f
 O5xM8gyyGXno6x82lY5xuNeUoYtZAGp/TZDdEvCzX40trCmeMWGQOaiDAcQIZDr5g6Fx
 q/aQ==
X-Gm-Message-State: AOAM530IujgBPzaNEQxI2eLIVEHQKE0P/MVch7x2dLteHffGUIeUI3XN
 aHFdACdoBQMqjdkAcm6uN4E7dDKUju8=
X-Google-Smtp-Source: ABdhPJyoTP/G0TK40pmZYxVNWWcwNSRqExB80tD01iWXzVHOdO4KfxfJoLGjbdkI87YN6AUhalo8Iw==
X-Received: by 2002:ad4:458d:: with SMTP id x13mr558471qvu.4.1603339411643;
 Wed, 21 Oct 2020 21:03:31 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id n206sm359335qke.72.2020.10.21.21.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 21:03:31 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, daniel.vetter@ffwll.ch
Subject: [pull] amdgpu, amdkfd drm-fixes-5.10
Date: Thu, 22 Oct 2020 00:03:22 -0400
Message-Id: <20201022040322.4183-1-alexander.deucher@amd.com>
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

Fixes for 5.10.

The following changes since commit 40b99050455b9a6cb8faf15dcd41888312184720:

  Merge tag 'drm-intel-next-fixes-2020-10-15' of git://anongit.freedesktop.org/drm/drm-intel into drm-next (2020-10-19 09:21:59 +1000)

are available in the Git repository at:

  git://people.freedesktop.org/~agd5f/linux tags/amd-drm-fixes-5.10-2020-10-21

for you to fetch changes up to 687e79c0feb4243b141b1e9a20adba3c0ec66f7f:

  drm/amdgpu: correct the cu and rb info for sienna cichlid (2020-10-21 23:06:23 -0400)

----------------------------------------------------------------
amd-drm-fixes-5.10-2020-10-21:

amdgpu:
- Sienna Cichlid fixes
- MST manager resource leak fix
- GPU reset fix

amdkfd:
- Luxmark fix for Navi1x

----------------------------------------------------------------
Andrey Grodzovsky (3):
      drm/amd/display: Revert "drm/amd/display: Fix a list corruption"
      drm/amd/display: Avoid MST manager resource leak.
      drm/amd/psp: Fix sysfs: cannot create duplicate filename

Evan Quan (1):
      drm/amdgpu: correct the gpu reset handling for job != NULL case

Jay Cornwall (1):
      drm/amdkfd: Use same SQ prefetch setting as amdgpu

John Clements (1):
      Revert drm/amdgpu: disable sienna chichlid UMC RAS

Kenneth Feng (2):
      drm/amd/pm: fix pp_dpm_fclk
      drm/amd/pm: remove the average clock value in sysfs

Kevin Wang (2):
      drm/amd/swsmu: add missing feature map for sienna_cichlid
      drm/amd/swsmu: correct wrong feature bit mapping

Likun Gao (5):
      drm/amdgpu: add function to program pbb mode for sienna cichlid
      drm/amdgpu: add rlc iram and dram firmware support
      drm/amdgpu: update golden setting for sienna_cichlid
      drm/amd/pm: fix pcie information for sienna cichlid
      drm/amdgpu: correct the cu and rb info for sienna cichlid

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h            |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |  10 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h          |  11 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             | 111 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h            |   4 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager_v10.c  |   5 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   8 +-
 drivers/gpu/drm/amd/pm/inc/smu_types.h             |   1 +
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  22 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |  27 +++--
 13 files changed, 187 insertions(+), 31 deletions(-)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
