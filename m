Return-Path: <SRS0=Eo1a=4F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14514C3B185
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 10:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8FE020679
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 10:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1Vr47Sy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FE020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A4A56E1D2;
	Mon, 17 Feb 2020 10:16:01 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D8CB6E1D2;
 Mon, 17 Feb 2020 10:16:00 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id c9so18976661wrw.8;
 Mon, 17 Feb 2020 02:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XNf3nnZ3J+/7Wlkqj+8Jz31wzpdWyNZQu1oztoQy7+M=;
 b=h1Vr47Sylz3AHKgjDG9V4RZl4wkzsWch2TikEg8MYthZKM5X+3RdOoXAdlV4xySjbP
 lkgMohEU6svQGD/vH64/aK7Mzx+bA5XdcK4u3TbDlPmEHmDQjECVpgq5pF37nAhxDm15
 4AOS6qrSP7qxeLIXaslptJ4zqQdYiBMaKWLS5GocueDNZiV1sEr4Z7uIIz1Jg14c1clq
 AaVyISA+Zo2c9il/aE2w5o3w1lvcvWExGCBmU6YnIfjpSMLECBqVF4u7adrtxURmnVBT
 RyRVbjrBxqkrr4KcDcg95VX0Fx6uKw/TMVf7iO8OfUMhMH4paVPJfk4+8fJUORGS2vR3
 anBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XNf3nnZ3J+/7Wlkqj+8Jz31wzpdWyNZQu1oztoQy7+M=;
 b=LJlj28IvqgCbGA5Lc3XtuWN2b/ChEUjN9P+J+UEXEdvHGY1OfSzpS5Ogcb977fThcR
 ffo3VIb6gIaor3ZCbIIkvW5u6cdid1JIE0oeZD7S3aosR1Ok7THv2Iu6cxn6/+Nx9g9N
 YJ3fZz/HU8eKvUKpoZs/MtKppcZmLsiytisdK2VryXRiuTNpDpk1y8nIFmEA5lfP5vQ9
 4ZMJ4ExpHTi5G/kDUa2mLaIT0YdkPT1dIBEY8yIdPOtP+R/lCZ+LmqFHJEGqdFOnLcJL
 NDbmTHoiDo3rn7yn3O1EY7J90m2oWNC3gj86gVB2pxivXA+f9ri5+n1pIijT942sIFWj
 p2lw==
X-Gm-Message-State: APjAAAVe1hSj0HCRgkcN7SexMu/r+Eg4JbAQS+Q/pFHF/FPm1asLLPej
 WE+wS2+z2/OKLjzTsJKDoxQ1eCaFepoHPw==
X-Google-Smtp-Source: APXvYqyp66rhMnbjhYDPhvlcPncDjqrNyKvwsM6UgEx2sljR6/556Y+57esNeh4Ho9cYxNiJol4LNw==
X-Received: by 2002:adf:db84:: with SMTP id u4mr21697515wri.317.1581934558607; 
 Mon, 17 Feb 2020 02:15:58 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F261400BC111EAD619EC67C.dip0.t-ipconnect.de.
 [2003:c5:8f26:1400:bc11:1ead:619e:c67c])
 by smtp.gmail.com with ESMTPSA id a16sm278487wrt.30.2020.02.17.02.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 02:15:57 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 0/6] do not store GPU address in TTM
Date: Mon, 17 Feb 2020 11:18:34 +0100
Message-Id: <20200217101841.7437-1-nirmoy.das@amd.com>
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


Nirmoy Das (7):
  drm/amdgpu: move ttm bo->offset to amdgpu_bo
  drm/radeon: don't use ttm bo->offset
  drm/vmwgfx: don't use ttm bo->offset
  drm/nouveau: don't use ttm bo->offset
  drm/qxl: don't use ttm bo->offset
  drm/bochs: don't use ttm bo->offset
  drm/ttm: do not keep GPU dependent addresses

 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 22 ++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 29 ++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  1 +
 drivers/gpu/drm/bochs/bochs_kms.c           |  3 ++-
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
 drivers/gpu/drm/qxl/qxl_drv.h               |  5 ++--
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
 35 files changed, 100 insertions(+), 75 deletions(-)

--
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
