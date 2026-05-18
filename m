Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0B3CD4F4A
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 14:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F0AC10E8B2;
	Mon, 18 May 2026 14:45:24 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7464E10E8AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 14:45:20 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 64IEjAIf3697667; Mon, 18 May 2026 20:15:10 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 64IEjAc63697666;
 Mon, 18 May 2026 20:15:10 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v3 0/8] Fix some clean up during userq create/destroy 
Date: Mon, 18 May 2026 20:14:57 +0530
Message-Id: <20260518144505.3697615-1-sunil.khatri@amd.com>
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

v3: Add two more patches

Sunil Khatri (8):
  drm/amdgpu/userq: Fix doorbell cleanup on queue creation fail
  drm/amdgpu/userq: Fix the mutex_init cleanup for fence_drv_lock
  drm/amdgpu: simplify return value in amdgpu_userq_get_doorbell_index
  drm/amdgpu/userq: dont override return value of xa_alloc
  drm/amdgpu/userq: clean up wptr_obj along with mqd_destroy
  drm/amdgpu/userq: add amdgpu_bo_unpin when amdgpu_ttm_alloc_gart fails
  drm/amdgpu/userq: reserve root bo without interruption
  drm/amdgpu/userq: make sure queue is valid in the hang_detect_work

 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 49 +++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  3 --
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  4 +-
 3 files changed, 32 insertions(+), 24 deletions(-)

-- 
2.34.1

