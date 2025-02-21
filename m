Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB071C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 13:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1091D10EA6F;
	Fri, 21 Feb 2025 13:52:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="pxoxVBCV";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D87510E24A;
 Fri, 21 Feb 2025 10:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kEQ28sdBzLgsDKUH8AhRUDPdFZQcLwSAMN859Zgt+Oo=; b=pxoxVBCVd4H2lsmalaAQfRjoY6
 Y3HoG5+PXVWdGKhi4GA5jK4vnFgVQhtn6XlmxQHJRAjpKAin3uK6ZdfrUwCyFHj6pKDJGBjT/kKYY
 cTxnHynLkhNUGlSRdmvQshKMtt7qKDBr0ImfnohAHkRvI1oJHRvLMhxvx0okMZ/vZS/Gh56JHRYNA
 Wf8PqgcxI/uWIemUHKJqhumGgYnxxNgWXx0E3IZ1VAWe4cdh8ZVtCpinNySdEuRprtU8O9QzXTHPi
 P28E96dsajVeSFuSgucYcGdoLbBOyEBUx1RMn2cclPb5CCCJ5PyRFjeYNdGcGR/SBJ3dxqXDE+TM9
 3y/m22zA==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tlQc8-00G3SE-8B; Fri, 21 Feb 2025 11:50:42 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH v6 0/6] drm/sched: Job queue peek/pop helpers and struct job
 re-order
Date: Fri, 21 Feb 2025 10:50:32 +0000
Message-ID: <20250221105038.79665-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Feb 2025 13:52:39 +0000
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

Lets add some helpers for peeking and popping from the job queue which allows us
to re-order the fields in struct drm_sched_job and remove one hole.

As in the process we have added a header file for scheduler internal prototypes,
lets also use it more and cleanup the "exported" header a bit.

v2:
 * Add header file for internal scheduler API.
 * Add helper for peeking too. (Danilo)
 * Add (temporary?) drm_sched_cancel_all_jobs() helper to replace amdgpu
   amdgpu_job_stop_all_jobs_on_sched().

v3:
 * Settle for a copy of __drm_sched_entity_queue_pop in amdgpu for now.

v4:
 * Expand the series with some more header file cleanup.

v5:
 * Rebase for drm_sched_init changes.
 * Tweak kerneldoc format.

v6:
 * Added SPDX to the new header file.

Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>

Tvrtko Ursulin (6):
  drm/sched: Add internal job peek/pop API
  drm/amdgpu: Pop jobs from the queue more robustly
  drm/sched: Remove a hole from struct drm_sched_job
  drm/sched: Move drm_sched_entity_is_ready to internal header
  drm/sched: Move internal prototypes to internal header
  drm/sched: Group exported prototypes by object type

 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  22 +++-
 drivers/gpu/drm/scheduler/sched_entity.c   |  23 +---
 drivers/gpu/drm/scheduler/sched_fence.c    |   2 +
 drivers/gpu/drm/scheduler/sched_internal.h |  91 +++++++++++++++
 drivers/gpu/drm/scheduler/sched_main.c     |   7 +-
 include/drm/gpu_scheduler.h                | 122 +++++++++------------
 6 files changed, 171 insertions(+), 96 deletions(-)
 create mode 100644 drivers/gpu/drm/scheduler/sched_internal.h

-- 
2.48.0

