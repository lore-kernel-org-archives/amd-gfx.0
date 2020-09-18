Return-Path: <SRS0=nko/=C3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82B4C43464
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 13:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E6821D24
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 13:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="G7OaI49U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E6821D24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 664726E182;
	Fri, 18 Sep 2020 13:25:13 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CEEB6E182
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2020 13:25:12 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id g4so5621172wrs.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2020 06:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UBx1PEmn0W4aDiCsFb5YFigHJoHIwLLzOZ1tXmUxyJc=;
 b=G7OaI49UWbNUKXHTKQeo5alyNmun03V6bN+GnHogC+Ep7LFe1X2G4zGD/dhLy1SgRu
 gW9EvNLJGZiorbCOUuBCvgz4sw0q9XlemKqMrCrjV0FzRw7LajzE5RerIUud29d4RSvR
 QSyz3t3+hPmRBcFwvSizUKafcAbYNNiIWOCMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UBx1PEmn0W4aDiCsFb5YFigHJoHIwLLzOZ1tXmUxyJc=;
 b=A4QWNgA8NUn6taJqSEW3Unydrr+gOSrJ4IwU4rNWUOSi8VFtpaDrFZGtUFrVIUSz9E
 uFsjENTSicVdZMo0ybWZYK4ex0Lnk7YR50LHjvG1xmy4sqi+fxZV3wbnBZGPsdSsvHjv
 MrLrljzV3sE550GSp3TmWM+K1/hhe/5aZl9d1sU7aMCKV/wDG5F8pNsrc83LCXcHD4bG
 SNLuQFygUvtwmfyfAU1Kuf8GWGvc4dpziKhPUKTSQmddVykZwA2pJ8uIZJkE7DjLHO/I
 zImCJGlnnVOvatRoLSOvPpaxph/N27vjreJr2Gb7SpKlLIU/qThJ+iafun+ado6Qux59
 OLFQ==
X-Gm-Message-State: AOAM531NZ99BWAf/vsktP9fUxkWSKPBBKgtVUgdsIHNATu7WdPQOY8pC
 21nvQpTr+mvRo7V7jFuXGxaOpy+sie3x9Uj3
X-Google-Smtp-Source: ABdhPJzi29RcoloJdDY7B+Pk6hmy9TeacocMO63nWs80KfgVLp4l18Ve5k6EzSNBv5IQwFlhykY9/Q==
X-Received: by 2002:adf:e6c2:: with SMTP id y2mr40238845wrm.117.1600435510935; 
 Fri, 18 Sep 2020 06:25:10 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id k6sm4872693wmi.1.2020.09.18.06.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 06:25:10 -0700 (PDT)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Subject: [PATCH 0/4] managed drm_device, absolute final leftover bits
Date: Fri, 18 Sep 2020 15:25:01 +0200
Message-Id: <20200918132505.2316382-1-daniel.vetter@ffwll.ch>
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
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi all,

These are the leftovers of the leftovers of my initial drmm series to
manage drm_device.

Changes:
- bugfixed i915 selftests
- patch from Luben to finalize the admgpu conversion

Alex & i915 maintainers, pls ack for merging this all through
drm-misc-next since otherwise the final patch (and the resulting confusion
with outdated docs) is held up another round.

Cheers, Daniel

Daniel Vetter (3):
  drm/i915/selftest: Create mock_destroy_device
  drm/i915/selftests: align more to real device lifetimes
  drm/dev: Remove drm_dev_init

Luben Tuikov (1):
  drm/amdgpu: Convert to using devm_drm_dev_alloc() (v2)

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 16 ++----
 drivers/gpu/drm/drm_drv.c                     | 41 ++--------------
 drivers/gpu/drm/drm_internal.h                |  1 +
 drivers/gpu/drm/drm_managed.c                 | 13 -----
 .../gpu/drm/i915/gem/selftests/huge_pages.c   |  2 +-
 .../drm/i915/gem/selftests/i915_gem_context.c |  2 +-
 .../drm/i915/gem/selftests/i915_gem_dmabuf.c  |  2 +-
 .../drm/i915/gem/selftests/i915_gem_object.c  |  2 +-
 .../drm/i915/gem/selftests/i915_gem_phys.c    |  2 +-
 drivers/gpu/drm/i915/gt/selftest_timeline.c   |  2 +-
 .../gpu/drm/i915/selftests/i915_gem_evict.c   |  2 +-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c |  2 +-
 drivers/gpu/drm/i915/selftests/i915_request.c |  2 +-
 drivers/gpu/drm/i915/selftests/i915_vma.c     |  2 +-
 .../drm/i915/selftests/intel_memory_region.c  |  2 +-
 .../gpu/drm/i915/selftests/mock_gem_device.c  | 49 ++++++++++++-------
 .../gpu/drm/i915/selftests/mock_gem_device.h  |  2 +
 include/drm/drm_drv.h                         |  4 --
 18 files changed, 51 insertions(+), 97 deletions(-)

-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
