Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B37AFA375B
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Sep 2024 16:06:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D0B510E0EA;
	Fri, 13 Sep 2024 16:06:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="XkSIXd4N";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C718010E07E;
 Fri, 13 Sep 2024 16:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wiVm/F8rxjDFoAz1kMuG4hGSmdJH20etP+rN8h5nsp4=; b=XkSIXd4NHfLkavN9XCizk08n2o
 rlt0Ii5gkiEFjDrG3E1sFBfiWBl1GZcAPCLZaVdAWdKIGtR+e1rRk7V8Aol1HLLMte2YFkRcp51yu
 /SJrZaoqQTudvTR7dSdOUVQKIhbBJB8YbdQ8Bu8YxBiJsC7zJqtvxi0RDAPRaSU6DgjjLux0OMDsl
 8V9DXGjMjv5aDQsiwK8fTuH3O0BG2jIVsvMAKE2Axmmur6PdPxETBviSdYPdcZ6FdFH8C9nQHrU3M
 hOtaclUmwN79ZcQORXKIQrPCkvCpIAv643ynCqZCf/A8fLxcW9yl4O9vzRVwXZQ9p4Xdkkv4Dr6Yw
 g5RfqW5w==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1sp8o5-00DOeQ-GY; Fri, 13 Sep 2024 18:06:01 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v3 0/8]  DRM scheduler fixes and improvements
Date: Fri, 13 Sep 2024 17:05:51 +0100
Message-ID: <20240913160559.49054-1-tursulin@igalia.com>
X-Mailer: git-send-email 2.46.0
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

Re-spin of the series from last week. Changelog is in individual patches.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Luben Tuikov <ltuikov89@gmail.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <pstanner@redhat.com>

Tvrtko Ursulin (8):
  drm/sched: Add locking to drm_sched_entity_modify_sched
  drm/sched: Always wake up correct scheduler in
    drm_sched_entity_push_job
  drm/sched: Always increment correct scheduler score
  drm/sched: Optimise drm_sched_entity_push_job
  drm/sched: Stop setting current entity in FIFO mode
  drm/sched: Re-order struct drm_sched_rq members for clarity
  drm/sched: Re-group and rename the entity run-queue lock
  drm/sched: Further optimise drm_sched_entity_push_job

 drivers/gpu/drm/scheduler/sched_entity.c | 49 ++++++++++++++++--------
 drivers/gpu/drm/scheduler/sched_main.c   | 37 ++++++++----------
 include/drm/gpu_scheduler.h              | 32 +++++++++-------
 3 files changed, 68 insertions(+), 50 deletions(-)

-- 
2.46.0

