Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D671BF4487B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 06:22:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7278410E31B;
	Mon, 13 Apr 2026 06:22:05 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C64310E316
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 06:22:01 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 63D6LumY4051019; Mon, 13 Apr 2026 11:51:56 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 63D6LuWp4051018;
 Mon, 13 Apr 2026 11:51:56 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v3 0/6] Never take root bo reservation locks with userq_mutex
Date: Mon, 13 Apr 2026 11:51:47 +0530
Message-Id: <20260413062153.4050981-1-sunil.khatri@amd.com>
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

v1: Fixes the locks issue in all the places where userq_mutex is taken
and then vm->root.bo reservation lock is next.
v2: Fix the minor comment on the patches.
v3: Add some more userq fixes found during testing

Sunil Khatri (6):
  drm/amdgpu/userq: caller to take reserv lock for vas_list_cleanup
  drm/amdgpu/userq: hold root bo lock in caller of input_va_validate
  drm/amdgpu: add job->pasid in check as amdgpu_job could be NULL
  drm/amdgpu/userq: use pm_runtime_resume_and_get and fix err handling
  drm/amdgpu/userq: unmap is to be called before freeing doorbell/wptr
    bo
  drm/amdgpu/userq: unmap_helper dont return the queue state

 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 86 ++++++++++---------
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    | 21 +++++
 3 files changed, 69 insertions(+), 40 deletions(-)

-- 
2.34.1

