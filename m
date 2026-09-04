Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC0CC79F80
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2026 07:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 991A010E541;
	Fri,  4 Sep 2026 07:29:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RGnN3iiU";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBA9810E541
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2026 07:29:00 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49b0dbfbf7bso5229235e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Sep 2026 00:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788506939; x=1789111739; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hlYWKu8qckH0jcnpeKQvuhf7f9JKsNbWwcJv5wsbHcg=;
 b=RGnN3iiUiM0TDK/Ma+v9xyb4vof3EvsPpAqmtcey5WbJlYNneh6Eh0XpgNF/YOJ4DZ
 M0kU+VF2QKMF6Y6JuLclwxsXiOLJ/as/uaf8ijiEYxdN5okK+M347/fI/E4EjbjoIKTi
 4qg5s5nnpERLIwoghu7XQGv6GG55kw+igAx+6+j0vVOZpGEnv50H/kPmfqsC8gBKknki
 4yDU+AmJmkHzfZXeDpJoZ8zRjrcenVKqI7Xou4upQVmYguVWA5H22Ytr/66glnQjZ/lW
 wbnfHIoYBu/M+6oCZCeUWC9qOUKxoWrmygjq8V671p0VkFUKwnTrqaZjXF0bg7ZHBMyE
 oaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788506939; x=1789111739;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hlYWKu8qckH0jcnpeKQvuhf7f9JKsNbWwcJv5wsbHcg=;
 b=cp8E2CRyLEeBOVp6GEdTNJYHfJ3vmRpQjryT4+R+K8jWeyNXkw4ai6diTmSCtBPDfM
 aOMMXTu4dCpFKpl4xup7uAb5/zxRAsf5nJ0b+fDzYs4rSmzvkbiwLckpHqWcDwrAE6Do
 IVng0+pMXmrCo/bv8PNns/4+RHj8cBbyOcR3+zrrPSbXy8pzQnmCP1z9SBYSkjNhlX15
 PGjpDFowqAz7GQFI0QMJc4rmWdsIyFhC7wl0N0OlonKjwoNp++i0WA+nXGd4IisBHeos
 c/Kww1bd7dPeXOU1+yTDQZe7ZpDE4oz1+ZLPZkNBPuXmzF/2Q5sTE2XMmey0T2HthXrl
 sqUA==
X-Gm-Message-State: AFuF++lkkPpS1wGapb/ctPyvUCBgt47hTnPfF072LfS92qVAzr5DVyHA
 9v1h6KtsW4Zgf8tKvvS/nul5nyA8XP21GB9PJLUrvAETqxcztWzmWY/zn8iDeJD7aKA=
X-Gm-Gg: AYBFou20bKgRBecge/F0OBjvTe8XouskaMEhkXfXMeZArJJU5GeUrrMzIHbMVVqRLkK
 MqalTbEo+WHjO4S9t3KHW3uVR93EIG0VzoKcIlZ52PC/nqwo1gNKzAp86kswq7pnkChcO52tGML
 G0Opuspn+vDSY2LcZpAj7q7vAObfidiY2ZlBmyPLr1sCn/5uKTyLzCBda+VNShhiZxxnnwVpEVk
 SC1XRwCpNvAW9ZoiwmOJfh8h1BU1mCRsKEbnvcQYxGdKoOnsf+SUhbKREHW3/p6PjhzawAw0NQ7
 kMfl0ZFrdFY54YyfRjfFZaNO3PLnZPBAIIml4wnDKEJmgJTJJ4p/pJKa1tY7aidlA1PY57m+11/
 Fb1zAWAQL9L3/W48i2Xc/h/NM5EJbWypw7hsIzlzKO04wZFaTDn1+svKjxVBMWGiKgbptRpToVo
 SRXJ2cES72HV1kSPAT18GrZ5s1JSk04mPpV8E+v6xrdajTm2PdoElF4ILUu2BYmBLWhlO+nPu68
 /RhlZC2SWVcAjqB9ILt
X-Received: by 2002:a05:600c:4515:b0:49a:252d:52f5 with SMTP id
 5b1f17b1804b1-49cf8241ab8mr53912215e9.11.1788506938853; 
 Fri, 04 Sep 2026 00:28:58 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf75ce49esm86698155e9.1.2026.09.04.00.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 00:28:58 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/8] drm/amdgpu/sdma: Improve existing SDMA queue resets (v3)
Date: Fri,  4 Sep 2026 09:28:42 +0200
Message-ID: <20260904072850.321759-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Improve SDMA queue reset for SDMA v4.4.2, v5.0, v5.2
and also moves some functionality from backend-specific
code to common code in the amdgpu_sdma.c file.

This prepares for implementing SDMA recovery
on more generations, as the same logic can be shared
with all SDMA HW generations that don't use the MES.
The actual recovery implementation for various
older SDMA versions will come in subsequent patch series
after this one is accepted.

Changes in v2:

* Added a fix for an issue in SDMA v4.4.2
* Further simplified some code

Changes in v3:

* Fixed typo (wrong scheduler for page ring)

Timur Kristóf (8):
  drm/amdgpu/sdma: Remove unimplemented soft_reset() for SDMA and SI DMA
  drm/amdgpu/sdma: Remove superfluous rlc_resume and rlc_stop functions
  drm/amdgpu/sdma: Fix executing duplicate commands after recovery on
    SDMA v4.4.2
  drm/amdgpu/sdma: Remove unnecessary guilty tracking of SDMA queues
  drm/amdgpu/sdma: Clear SDMA rings after reset before starting them
  drm/amdgpu/sdma: Move SDMA v5.x queue reset to common code
  drm/amdgpu/sdma: Always handle kernel queues in
    amdgpu_sdma_reset_engine()
  drm/amdgpu/sdma: Use common SDMA legacy queue reset on SDMA v4.4.2

 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |   2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |   2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      | 109 ++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      |  11 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |  32 ----
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |  30 ----
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |  38 +----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |  40 +----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      | 158 ++----------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |  60 +------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  52 +-----
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  27 ---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |  27 ---
 drivers/gpu/drm/amd/amdgpu/si_dma.c           |   7 -
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   2 +-
 15 files changed, 109 insertions(+), 488 deletions(-)

-- 
2.55.0

