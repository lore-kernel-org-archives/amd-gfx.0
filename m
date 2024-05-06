Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FB7C25B4F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 17:00:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 764E310FF35;
	Mon,  6 May 2024 17:00:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="sxOqirbp";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F92E10EF60
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 17:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ANCZObwNAnQlsIwB5UvVfWfWF4yqeZu9ld71UDUiWuw=; b=sxOqirbp0PZAyiA3ku20YSPmK+
 4KmXfqGWRlApQbjGmMBiqButwUGszZmqxQuyTNgyMK2eJZXIsVRAgIhSBJO1d30FsYw8KQ1tB9WPZ
 4RnD88zWbD3MriQvV/KjFmRXNjqYupXoWugqzqkF3nAbyCjbYaAdQ+TGGiqJlsMu4UzUJabM3HKtX
 ZbSO/P07Q4rp/42RSRFknSU+dbbv4gFtsj9pMwbBj1mdVigLyHHcjUoSftPrWr+0OgD4UvtlKc5nt
 GH4KDKVRFKv69+EtKKbzgdzxh6kjJ9Lv8a5JybalwPZj2DLloFojQDUg3Sr3/pHqGxMhvJFvCUGJP
 Jj74jz5A==;
Received: from [84.69.19.168] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1s41h3-001Qf1-VK; Mon, 06 May 2024 19:00:02 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Rob Clark <robdclark@chromium.org>
Subject: [PATCH 0/5] Fdinfo memory stats clarification and amdgpu refactor
Date: Mon,  6 May 2024 17:59:54 +0100
Message-ID: <20240506165959.50648-1-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Following on from the recent discussion from:
  https://lore.kernel.org/dri-devel/ZjjTaeZYNqVSj2y-@phenom.ffwll.local/T/#mb8105d8d7de055d3068975d27c428525e55cff84

I included some old three patches to start with, since the last in the series
depends on first, plus first had a bug which is now fixed.

Apart from extending drm-usage-stats.rst with some more information on what
various keys should contain, on a suggestion from Alex, in the last patch I also
attempt to refactor amdgpu to use DRM common drm_print_memory_stats.

There are perhaps a couple discussion points there so see what you think please.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rob Clark <robdclark@chromium.org>

Tvrtko Ursulin (5):
  drm/amdgpu: Add amdgpu_bo_is_vm_bo helper
  drm/amdgpu: Reduce mem_type to domain double indirection
  drm/amdgpu: Describe all object placements in debugfs
  Documentation/gpu: Document the situation with unqualified drm-memory-
  drm/amdgpu: Use drm_print_memory_stats helper from fdinfo

 Documentation/gpu/drm-usage-stats.rst       |  25 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c  |  47 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 126 +++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  35 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  61 ++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |   5 +-
 9 files changed, 189 insertions(+), 116 deletions(-)

-- 
2.44.0

