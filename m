Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2644BC34026
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 18:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC9AD2070B
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 18:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnKFmgNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9AD2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 979796E378;
	Tue, 18 Feb 2020 18:02:18 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4521E6E378;
 Tue, 18 Feb 2020 18:02:17 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id a5so3732559wmb.0;
 Tue, 18 Feb 2020 10:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5/aGfmke5p7Ed/41ONpUn8RHbz5PHbPuoNq8nR97UqE=;
 b=UnKFmgNItIUiXTA9WVW0wZkxs8iNrOsLu3su/9inoASDCLmvmuLY353/NRedcr91cP
 MWtIJGFJz97C/JQpFrCIVpCURNIa/CLpxQPPZhWhO0OPgxvnqp8CDdfDvmkG1Sx/1OrK
 EfTovzJqHdvcd7YnbIIWmtoUKM03HQzWDzTZr2DuxQnEtHaoPOTcH9gsrxVHgzgvP7Wa
 z5M6CRSsGU4jGtplGrhlGvVcI9/hzkgK7NkqkmGZsvRxIAlFOPhbzUR9OD5PtFyLTz5O
 O/RjlE4Tzc/UfZdMlrRjFlgjBGquXd4DR57gJ1fBTpJLYYsdNzrSIGUiJa6MxtFQmBqB
 OIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5/aGfmke5p7Ed/41ONpUn8RHbz5PHbPuoNq8nR97UqE=;
 b=lX0v714ESVVuyPKACLjLqBhlAacSBleaZJDk/tXcYxat9dnRsbG9UFjuTg46yubyLr
 589cDWMj7f3+kVllhr3mGxZk5LHL8uG0iLdMK8DTFxtFY+wYAK0goW3OeP6WN6BtSsaB
 vK7debz1JhCZ6tEUKRbrF0sZjL/uUFr9iYhG1688FBU9dGxA4VZI2N671ZMixdGj8aIj
 T2idu7q1E/KfBdEHbRxp3cSqbg/QQ54TNNi3kJKIhdRooBZ3xmUCyAOEQHp+yTuUjx7C
 /n2lTbSOklUVL+4vBZl+c0aEHl/Zy+B1BBYPkscKuqqS/xp6WRXO6kz4DnVZm2EmxyCH
 MiVw==
X-Gm-Message-State: APjAAAUoBuMxAI7rDHQ6R4SVGbN0jLzOE2JKxj1Ky1PMDA66fZ4fXCyW
 UEi4Ddh9u+ySMpFLqO867VQQ4y3WN4pUew==
X-Google-Smtp-Source: APXvYqwjHiu5iN46HCCqStfHW6YD3jK1AybZxHcENnDeiXu+vzsWEZeQjpJvbgjRRHS4BIeq2VI3fA==
X-Received: by 2002:a7b:c8d2:: with SMTP id f18mr4139070wml.47.1582048935021; 
 Tue, 18 Feb 2020 10:02:15 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F2CE900751228326401B174.dip0.t-ipconnect.de.
 [2003:c5:8f2c:e900:7512:2832:6401:b174])
 by smtp.gmail.com with ESMTPSA id d16sm7872733wrg.27.2020.02.18.10.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 10:02:14 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/8] do not store GPU address in TTM
Date: Tue, 18 Feb 2020 19:04:46 +0100
Message-Id: <20200218180454.81866-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
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
Cc: David1.Zhou@amd.com, thellstrom@vmware.com, airlied@linux.ie,
 kenny.ho@amd.com, brian.welty@intel.com, maarten.lankhorst@linux.intel.com,
 amd-gfx@lists.freedesktop.org, nirmoy.das@amd.com,
 linux-graphics-maintainer@vmware.com, bskeggs@redhat.com, daniel@ffwll.ch,
 alexander.deucher@amd.com, sean@poorly.run, christian.koenig@amd.com,
 kraxel@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With this patch series I am trying to remove GPU address dependency in
TTM and moving GPU address calculation to individual drm drivers.

I tested this patch series on qxl, bochs and amdgpu. Christian tested it on radeon HW.
It would be nice if someone test this for nouveau and vmgfx.

v2:
set bo->offset = 0 for drm/nouveau if bo->mem.mm_node == NULL

Nirmoy Das (8):
  drm/amdgpu: move ttm bo->offset to amdgpu_bo
  drm/radeon: don't use ttm bo->offset
  drm/vmwgfx: don't use ttm bo->offset
  drm/nouveau: don't use ttm bo->offset
  drm/qxl: don't use ttm bo->offset
  drm/vram-helper: don't use ttm bo->offset
  drm/bochs: use drm_gem_vram_offset to get bo offset
  drm/ttm: do not keep GPU dependent addresses

 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 22 ++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 29 ++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  1 +
 drivers/gpu/drm/bochs/bochs_kms.c           |  2 +-
 drivers/gpu/drm/drm_gem_vram_helper.c       |  2 +-
 drivers/gpu/drm/nouveau/dispnv04/crtc.c     |  6 ++---
 drivers/gpu/drm/nouveau/dispnv04/disp.c     |  2 +-
 drivers/gpu/drm/nouveau/dispnv04/overlay.c  |  6 ++---
 drivers/gpu/drm/nouveau/dispnv50/base507c.c |  2 +-
 drivers/gpu/drm/nouveau/dispnv50/core507d.c |  2 +-
 drivers/gpu/drm/nouveau/dispnv50/ovly507e.c |  2 +-
 drivers/gpu/drm/nouveau/dispnv50/wndw.c     |  2 +-
 drivers/gpu/drm/nouveau/dispnv50/wndwc37e.c |  2 +-
 drivers/gpu/drm/nouveau/nouveau_abi16.c     |  8 +++---
 drivers/gpu/drm/nouveau/nouveau_bo.c        |  1 +
 drivers/gpu/drm/nouveau/nouveau_bo.h        |  3 +++
 drivers/gpu/drm/nouveau/nouveau_chan.c      |  2 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c      |  2 +-
 drivers/gpu/drm/nouveau/nouveau_fbcon.c     |  2 +-
 drivers/gpu/drm/nouveau/nouveau_gem.c       | 10 +++----
 drivers/gpu/drm/qxl/qxl_drv.h               |  6 ++---
 drivers/gpu/drm/qxl/qxl_kms.c               |  5 ++--
 drivers/gpu/drm/qxl/qxl_object.h            |  5 ----
 drivers/gpu/drm/qxl/qxl_ttm.c               |  9 -------
 drivers/gpu/drm/radeon/radeon.h             |  1 +
 drivers/gpu/drm/radeon/radeon_object.h      | 16 +++++++++++-
 drivers/gpu/drm/radeon/radeon_ttm.c         |  4 +--
 drivers/gpu/drm/ttm/ttm_bo.c                |  7 -----
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c          |  4 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c     |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c        |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c  |  2 --
 include/drm/ttm/ttm_bo_api.h                |  2 --
 include/drm/ttm/ttm_bo_driver.h             |  1 -
 35 files changed, 99 insertions(+), 76 deletions(-)

--
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
