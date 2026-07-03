Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C65C4450C
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jul 2026 15:40:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71D2910E6E3;
	Sat,  4 Jul 2026 15:40:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="IXQcMrbG";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 945CC10E63D
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2026 16:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1783096366; x=1783701166; i=natalie.vock@gmx.de;
 bh=dOiEmPjqRcrjGrVzsNnvOBpOdQqIv/F4ix5tJlX0Tms=;
 h=X-UI-Sender-Class:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:To:Cc:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=IXQcMrbGzShLopUGpK4Z4rXm9UrcclTgD+9j/+TcJa58EMM+D3OyI2DEM6e5eBTd
 Z3DNWG2mG4ifRI30SNIjcPcOR87agz9ITZ8pE4f7kTUvMuX//rBNJTRjLEp5JnmPw
 POfL6DCUoYC7BT2qtZA8OBofwuqMyKxIZXI1puMtlDpPEwlMrRXQSbq9Avh77bh1h
 ifih5kCGv3Bv9sXMywlBnem7EWqdDpkihMFMLrBzgQmu5nge5YIU/SWIBmdzwICgF
 BYc8eSaWN1KFkJXVED4jiwgYeuQBX8WoqPEXIzvTIFxSDtlOszT3NmnE6Jtd9Jdfp
 opUI48+IrgNkbAKmkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8ykg-1wiSF61HFu-007wDA; Fri, 03
 Jul 2026 18:32:46 +0200
From: Natalie Vock <natalie.vock@gmx.de>
Subject: [PATCH 00/10] Use drm_exec to lock TTM buffers, respin
Date: Fri, 03 Jul 2026 18:31:20 +0200
Message-Id: <20260703-ttm_2_drm_exec-v1-0-43685ac1286b@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0auEWTcQo1TqVaQEkxntCMYySYsg3
 t3YLt/i/x0SCVOCTu0g9OXEayyobgrCa4gTacZisMbeTWtqnfPirENZHG0UtEWPvhr9A5saSvQ
 WGnn7Dfvn3+njZwr5usBxnKMa8ShyAAAA
X-Change-ID: 20260703-ttm_2_drm_exec-2dbdb1fb9d43
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Provags-ID: V03:K1:qAcwaYTUzWuvjmKxyscHk11KPq/0Jr4tRMlVI42NCs1I6tXD9dE
 4Q/d5xZZ2Spg+xnIyLbBYCRImZuEX0E4zNif27P98LSDLMNElAmxY9t7DLh87I+BXyku7Br
 HQaV5UVlWZSWw+Uzf0MQmc02ZFRLMuhc7Tb+FUeyx/YNa3gkuEVHpN3yVoSkObdzbejyOS3
 iktqxVFK5eue8A/dqeZnA==
UI-OutboundReport: notjunk:1;M01:P0:tyfNahk5Gbc=;6+fHL13FZjtVkwfMALB7MWRrxN+
 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
 tzch1Q==
X-Mailman-Approved-At: Sat, 04 Jul 2026 15:40:15 +0000
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

Hi all,

this is a respin of Christian's patchset to make TTM use drm_exec for
evicting buffers.

I've been investigating VRAM management for amdgpu quite a bit in recent
times, and under really strong VRAM contention I observed frequent
instabilities/random crashes that I traced back to TTM being unable to
evict buffers properly. The typical failure case was one game squatting
more or less all of VRAM while also being rather spammy with submits.
In that case, trylocking fails because concurrent submits from the game
already hold buffer locks, and since there isn't much else to evict,
allocation just fails.

The original patchset ended up fizzling out in previous attempts to
upstream it, but I think it's worth retrying to upstream this, so I took
over and rebased it on top of current drm-misc-next. Aside from
that, while testing the patchset I found two bugs causing rather random
issues ranging from kernel crashes to random GPU hangs in it, which I fixe=
d
for this respin. The two bugs were:
1. The ttm_buffer_object duplication in ttm_buffer_object_transfer did
   not alter the GEM object's driver function pointers, so the
   transferred object erroneously inherited the free() function of the
   source buffer. When the transferred object was freed, the driver's
   free function was invoked and treated the transferred TTM bo as if it
   was a driver BO. Hilarity ensued.
2. drm_exec LRU walks were missing handling for already-locked objects.
   If the incoming exec object was created without
   DRM_EXEC_IGNORE_DUPLICATES, drm_exec_lock_obj would return -EALREADY
   and the buffer would be skipped even if ctx->allow_res_evict was set
   (funkiness level: moderate).
   If the exec did have DRM_EXEC_IGNORE_DUPLICATES
   set, the buffer would be processed, and then unlocked, silently
   dropping the lock of some random object that the caller expected to
   stay locked (funkiness level: off the charts).

With those two bugs fixed, VRAM overcommit works considerably more
stable - there are no random eviction failures and related fallouts at
all anymore.

Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
Christian K=C3=B6nig (9):
      drm/ttm: replace TTMs refcount with the DRM refcount v4
      drm/ttm: remove ttm_lru_walk_ops
      drm/ttm: grab BO reference before locking it
      drm/ttm: switch to ttm_bo_lru_for_each_reserved_guarded for swapout
      drm/ttm: move zombie handling into ttm_bo_evict
      drm/ttm: use ttm_bo_lru_for_each_reserved_guarded in evict_all
      drm/xe: remove workaround for TTM internals
      drm/ttm: support using drm_exec during eviction v4
      drm/amdgpu: use drm_exec during BO validation

Natalie Vock (1):
      drm/exec: Add helper to bypass IGNORE_DUPLICATES flag

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  80 +++----
 drivers/gpu/drm/drm_exec.c                       |  52 +++--
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c          |  35 ++-
 drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c |   8 +-
 drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c    |   2 -
 drivers/gpu/drm/ttm/ttm_bo.c                     | 272 +++++++-----------=
=2D----
 drivers/gpu/drm/ttm/ttm_bo_internal.h            |  17 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c                |  58 +++--
 drivers/gpu/drm/ttm/ttm_device.c                 |  19 +-
 drivers/gpu/drm/ttm/ttm_resource.c               |  22 +-
 drivers/gpu/drm/xe/xe_bo.c                       |  32 +--
 include/drm/drm_exec.h                           |   2 +
 include/drm/ttm/ttm_bo.h                         |  50 ++---
 13 files changed, 296 insertions(+), 353 deletions(-)
=2D--
base-commit: 44d19b8a7548aa25cbc6ebd5f27e958f7142c36b
change-id: 20260703-ttm_2_drm_exec-2dbdb1fb9d43

Best regards,
=2D- =20
Natalie Vock <natalie.vock@gmx.de>

