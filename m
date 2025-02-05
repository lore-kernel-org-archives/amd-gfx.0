Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CE7C02194
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 22:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0448A10E211;
	Wed,  5 Feb 2025 22:38:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="rVq6VX/0";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A8AE10E7DC
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 15:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=P38JkCfYW07hHqVurUpAE64KJhaN6iMeZYO+sgT/6UE=; b=rVq6VX/0Q6Mpc1vjvOhem8wZrx
 CPnxjJ9JnyC7bSfvuEL5qPEai+aP8bh3hfUlWiXnLOKXZkmkYAE09As5VkvwRhv/mw4jcSq9bTMGI
 BRangLJ72K8kQYjuKftHT/6UOpZ5eOlX/Z9jE98xxNl8IY+GYqs4tLJiwl+5kuI8v+ksiKDdTYp3V
 uOKpgMOBcor+BEh0ldMLbPufT/ma2OQkDIyZKstwsl7Csgt3V8zOrhAW17oFk0dV4Y3DTeuCPheT0
 3TnV2feTBwEd9MuIoXL6j+CRfLoRZ3jUcd6AhDTvhRNJ72zQnnSTeOCxQ1JEX0/qhlnakBBUFnWtA
 XzAjxtSA==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tfhP6-0041OS-Vy; Wed, 05 Feb 2025 16:33:34 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH v2 0/4] Decouple amdgpu from the scheduler, a bit
Date: Wed,  5 Feb 2025 15:33:28 +0000
Message-ID: <20250205153332.14852-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Feb 2025 22:38:15 +0000
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

General idea is to try and access scheduler data structures less from the
drivers so the series basically adds some helpers to move closer towards that
goal.

Three copies of the same to_drm_sched_job macro get removed and by the end of
the series, as a bonus, we can now re-order members of struct drm_sched_job and
eliminate a hole.

I did not here from folks on which direction we want to take this after v1 so
I went ahead and sketched up a different flavour in v2. The
drm_sched_cancel_all_jobs() helper can be removed if (or when) amdgpu can change
the approach of implementing its permanently wedged state. But until then I see
no harm to clean up that, and even more so the to_drm_sched_job and its hidden
dependency on queue_node being the first element.

v2:
 * Add header file for internal scheduler API.
 * Add helper for peeking too. (Danilo)
 * Add (temporary?) drm_sched_cancel_all_jobs() helper to replace amdgpu
   amdgpu_job_stop_all_jobs_on_sched().

Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>

Tvrtko Ursulin (4):
  drm/scheduler: Add drm_sched_cancel_all_jobs helper
  drm/amdgpu: Use drm_sched_cancel_all_jobs helper
  drm/sched: Add internal job peek/pop API
  drm/sched: Make the type of drm_sched_job->last_dependency consistent

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 34 ---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |  2 -
 drivers/gpu/drm/scheduler/sched_entity.c   | 11 +++--
 drivers/gpu/drm/scheduler/sched_internal.h | 43 ++++++++++++++++++
 drivers/gpu/drm/scheduler/sched_main.c     | 51 ++++++++++++++++++++--
 include/drm/gpu_scheduler.h                | 39 +++++++++--------
 7 files changed, 118 insertions(+), 65 deletions(-)
 create mode 100644 drivers/gpu/drm/scheduler/sched_internal.h

-- 
2.48.0

