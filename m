Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA91CC9EC65
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 10:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9A0E10E332;
	Mon, 12 Jan 2026 10:22:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="An9rnTEK";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E97410E0C1
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 10:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JRzja2r43IUJiu/8tm7D2LPEwd2IL1vy/slVwxPvr8E=; b=An9rnTEKPUrhJG97Iq7KZG1oVc
 R+Li91mfS9s2y+h3ct4PrFZS00syghKzFCkMl+2sXxtDnPrh1E+/YJSxnYcIyYSR7gWzFSCa//wg7
 xOz23d5Zr6CXBO+oqzTALIRaSvE7OrgJPKuw+fJr/hYKIOVTBYZ2QuWZlYrGMHW+JI7WU0PBry4I0
 60ZPmLP3qUnb41DnCOZmqbwUFr5TpsKMQfl0QYq/O0uG9Ce3QHb54FHHk6ccoLPkConfNE46uRDny
 3ApziYkc9dOOwZ0/yPFsdJn0Bw9nA7tWK5c5nBoX+EIQm1oXXE5HkRzI6vR4YxmVI6Q+9uIcHfOnA
 7yQQFspQ==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vfF4R-004Lc8-8Q; Mon, 12 Jan 2026 11:22:47 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v4 00/12] IDR to xarray conversion and some small cleanups
Date: Mon, 12 Jan 2026 10:22:32 +0000
Message-ID: <20260112102244.63308-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
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

Context conversion patches need a lot of scrutiny (and passing through the
automated test suites), while the bo list changes are perhaps a bit of a bike
shed, although they do result in less lines of code and hopefully easier to
read.

BO list sorting is really independent, as is the IDR MES cleanup (which could as
well have the warnings removed). Just say the work and I can easily split them
out.

Series has been smoke tested, including lockdep and game + desktop workloads so
at least shouldn't be too obviously broken.

v2:
 * Re-order to pull reviewed to the head.
 * Added more patches, some suggested by Christian, some I spotted new issues
   or cleanup opportunities.
 * No need for kref_get_unless_zero when under the xa_lock.
 * RCU is no longer needed for bo list free.

v3:
 * Handle NULL bo list in amdgpu_bo_list_put.
 * Use separate variable for drm_dev_enter for readability.
 * Applied r-b's received so far.

v4:
 * Improved commit text in 3/12.
 * Added fpriv removal TODO to 6/12.
 * Keep amdgpu_ctx_init_entity() separate.
 * Recorded more r-b's.

Tvrtko Ursulin (12):
  drm/amdgpu/mes: Remove idr leftovers
  drm/amdgpu: Simplify sorting of the bo list
  drm/amdgpu: Drop support for variable struct drm_amdgpu_bo_list_entry
    size
  drm/amdgpu: Remove the bo list mutex
  drm/amdgpu: Remove a few holes from struct amdgpu_ctx
  drm/amdgpu: Remove duplicate struct member
  drm/amdgpu: Remove arbitrary number of contexts limitation
  drm/amdgpu: Consolidate ctx put
  drm/amdgpu: Remove live context error log and skip
  drm/amdgpu: Replace idr with xarray in amdgpu_bo_list
  drm/amdgpu: Remove output parameter in bo list handling
  drm/amdgpu: Convert context manager to xarray

 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 179 ++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h |  22 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |  67 +++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c     | 177 ++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h     |  27 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c     |   9 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h     |   3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c   |   8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  18 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  18 +-
 12 files changed, 186 insertions(+), 358 deletions(-)

-- 
2.52.0

