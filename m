Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A9B10A88F7
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 17:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F81B10EB62;
	Thu, 26 Mar 2026 17:45:22 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77A9C10EB6A
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 17:45:20 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 62QHjC7i3393973; Thu, 26 Mar 2026 23:15:12 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 62QHjBos3393972;
 Thu, 26 Mar 2026 23:15:11 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [Patch v3 0/4] Bunch of patches to fix fence timeout cleanup
Date: Thu, 26 Mar 2026 23:14:58 +0530
Message-Id: <20260326174502.3393880-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
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

v2: add more fixes as suggested by christian and update some logging.

v3: patch no 4 in amdgpu_userq_wait_for_last_fence to remove signalled
check.

Sunil Khatri (4):
  drm/amdgpu/userq: dont check return value in amdgpu_userq_evict
  drm/amdgpu/userq: add the return code too in error condition
  drm/amdgpu/userq: call dma_resv_wait_timeout without test for
    signalled
  drm/amdgpu/userq: use dma_fence_wait_timeout without test for
    signalled

 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 60 +++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 +-
 2 files changed, 24 insertions(+), 40 deletions(-)

-- 
2.34.1

