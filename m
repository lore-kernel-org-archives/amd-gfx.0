Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE275C0219E
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 15:29:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 330C310EB4C;
	Fri,  7 Feb 2025 15:29:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="q9WVA0gH";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E61610E8D6
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 16:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3AxffSIWn7Gr6SZEfWKOfHI67IxzOfSa/OVqeKH8n+I=; b=q9WVA0gHe/gtzYwv8WJy93zFgX
 mJ3YzEEZLgd0sz3lvx2Aekwr0TioiqQd7aLf600EnnYjfpT3pofpt9l9MEnfad7sZNn8BPlYZD0xu
 bmghPk1/RMjwApyqdxH83tiYRR8SAzBp69/EJDde+JCLueK6b24w5VbKGniQyKSr9u8Kmpb4rgFhu
 xc1Jh+HgIc+GH+8Dv/lbsD7t6sk9wahPE9DWmuep57vPUw2VayTRUI4B/aHoL9/8H+qz/E7L7Kh67
 OqBHdym+5Z1UDuBEPSocOqkZuYnbbX6VTncE6JkM/RbjliTghhPNRcyi4x7FVGTNXClLRdjHkdH0D
 re3ho25A==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tg4vU-0055Zp-UK; Thu, 06 Feb 2025 17:40:34 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH v3 0/3] drm/sched: Job queue peek/pop helpers and struct job
 re-order
Date: Thu,  6 Feb 2025 16:40:28 +0000
Message-ID: <20250206164031.43413-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 07 Feb 2025 15:29:43 +0000
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

v2:
 * Add header file for internal scheduler API.
 * Add helper for peeking too. (Danilo)
 * Add (temporary?) drm_sched_cancel_all_jobs() helper to replace amdgpu
   amdgpu_job_stop_all_jobs_on_sched().

v3:
 * Settle for a copy of __drm_sched_entity_queue_pop in amdgpu for now.

Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>

Tvrtko Ursulin (3):
  drm/sched: Add internal job peek/pop API
  drm/amdgpu: Pop jobs from the queue more robustly
  drm/sched: Remove a hole from struct drm_sched_job

 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 22 +++++++++--
 drivers/gpu/drm/scheduler/sched_entity.c   | 11 +++---
 drivers/gpu/drm/scheduler/sched_internal.h | 43 ++++++++++++++++++++++
 drivers/gpu/drm/scheduler/sched_main.c     |  7 ++--
 include/drm/gpu_scheduler.h                | 38 ++++++++++---------
 5 files changed, 90 insertions(+), 31 deletions(-)
 create mode 100644 drivers/gpu/drm/scheduler/sched_internal.h

-- 
2.48.0

