Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA20C3DA7F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 01:09:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8316C10E029;
	Thu,  8 Aug 2024 01:09:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="YBL7HwX3";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9EB610E029
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 01:09:09 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-36841f56cf6so45867f8f.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Aug 2024 18:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1723079347; x=1723684147;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7Gt6mVJjqK7cy7GvQhYTy2j6uVoBdtC53Q/87RLgI9M=;
 b=YBL7HwX3Di4UaqsFeHPyvrxprHgRlrCPKCAtCOiGckMww1mRGb+FH3TOx8frBCRNyY
 VzwqMtNNMCBlt5qOgqZJNLO+J27XMmje4/5qEmEwabcQTJLJ9iuxf/m2IBpa+buwf+Kv
 mXq+RnzQ2zAphD49mpXMZ4UgMXUuXnpo2Zs2IZXtDb6ePrSQTXJHPY0rMLG1r95nO66R
 lp6q2tYVeJOJxxN/eaC+sCnt6mV+ZmL0LnpCF1Bqh6HWSmkn640SlvE2TC4aeQHbdPwh
 MJws6L8M3gIfR93E7jgZF3/FYUo1cH+esrSLzNBesmvJP5LwB2o8iJI9+qAL7X0GgcHN
 mdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723079347; x=1723684147;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Gt6mVJjqK7cy7GvQhYTy2j6uVoBdtC53Q/87RLgI9M=;
 b=qeLdEx8jsqFHrQfsTfTulnpWvIY3KKAhpzmTAR/b1xOfwNZthaZoFi3dp9u2VEHQBT
 OgBldHaWH1iu0C/gxCzE1AKJ9f7JAJOutK7W5saeckzuMBkHuevFQNffkOf2TjzT525T
 wtjQ5pxU5MvqEqYqkbNBprxXlhli82TQxFS8piduzw6zvHEYjYixBwiRdAn0ZT+fGLBN
 +97l7d3Dg5NWefXNX4E6EREtl3EBqWivJQaMe0gQijRRYz4J0mof2tdqoqoQSIusPsM0
 YZ1DltZ143jwDB6jOLkuM+S83OKWOFQ5qmgoJcRWXHUnpaJB0pdsOtSGO1plaSW5rAGB
 6a1w==
X-Gm-Message-State: AOJu0YwbjxmCeM2jWV4e8RcU2K3+IcCGQsn6nXkw6CTihGqrVzAR0Sdk
 YNt0CDMPJTE2l854fJvH4uVtkMSW3euZv9fKjSdeXNJGRAk/giOId6tj9Vu/4InL1LwPUe5RU4F
 dXPg=
X-Google-Smtp-Source: AGHT+IE5JJVfAwuRjo12I4pchWcInDbDe0qQGlSsjG8Yh3F3zgCQx0e8w2esg7tZh4ZtlXSQrVTlwA==
X-Received: by 2002:a5d:5988:0:b0:364:8215:7142 with SMTP id
 ffacd0b85a97d-36d273cf802mr115779f8f.1.1723079347380; 
 Wed, 07 Aug 2024 18:09:07 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a781:a500:aaa1:59ff:feea:fd4f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36d272095b9sm240753f8f.68.2024.08.07.18.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 18:09:06 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, airlied@gmail.com, faith@gfxstrand.net,
 friedrich.vock@gmx.de, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: [PATCH 0/6] Add submission flag to disable implicit sync.
Date: Thu,  8 Aug 2024 03:08:59 +0200
Message-ID: <20240808010905.439060-1-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For the rationale see the earlier RFC by Faith: https://lists.freedesktop.org/archives/amd-gfx/2024-August/112273.html

This mainly makes two changes:

1. Uses a submission flag rather than a context creation flag.
2. Uses DMA_RESV_USAGE_BOOKKEEP to avoid adding implicit fences still.

Note that this doesn't disable implicit sync wrt VM ops (map/unmap), I know we have series for that going around,
but I believe doing just submissions here is less involved and doesn't really complicate doing VM ops later.

As of now this has received a limited set of testing, no full CTS runs etc yet.

For Userspace see:

libdrm: https://gitlab.freedesktop.org/bnieuwenhuizen/drm/-/commits/basic-explicit-sync

mesa: https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/commits/basic-explicit-sync

(Still missing a bunch of the version bumps & version checks, would like to postpone that till we know the actual version)

Bas Nieuwenhuizen (6):
  amdgpu: Add usage argument to amdgpu_sync_resv.
  amdgpu: Ignore BOOKKEEP fences for submissions.
  drm/amdgpu: Check cs flags.
  drm/amdgpu: Add UAPI for disabling implicit sync per submission.
  drm/amdgpu: Implement disabling implicit sync per submission.
  drm/amdgpu: Bump the driver version for the new flag.

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        | 21 ++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c      |  7 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h      |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |  3 ++-
 include/uapi/drm/amdgpu_drm.h                 |  6 ++++++
 9 files changed, 37 insertions(+), 12 deletions(-)

-- 
2.45.2

