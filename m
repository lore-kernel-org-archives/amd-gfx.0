Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04928CF9C6B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 10:19:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A035610E48D;
	Tue, 24 Sep 2024 10:19:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="FkGVHn2T";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2E2810E48D;
 Tue, 24 Sep 2024 10:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MrOPKCrcJ+Jsp3V9yN8CL1bVFu3CZEO/WtZWy2bIUX0=; b=FkGVHn2TTHyeaaE4E/kV6ZXxB4
 zClc0MRJQZOxxUJqn2bz0d7UOVlcodLUSXkR5Y0dy2H05Tbgq3zxVG97DHBnbdHDmDihglymHUmSw
 VyPljTH/SoyiBF3U1KFWzIVYKxZp8JOecMkkBBQno/gRAz61N75GsNfBd3tQNKjzgzGyQ5S+/r/P9
 wPCIShdAuyZIimvuqhOskqXiYMw7PKzhu4PdK8nKEAJrLQhkS2wsSkm0GwOllruRyfBgmZTbjV1Ux
 X9LCkysUwqUIyYADhYrn+n438HMtaRIEZt2Sh2iwVtFkBrdTOrEGO1YqrxX8UQW08Y9amtvYJz2sc
 H+p4pubA==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1st2db-000L2G-4O; Tue, 24 Sep 2024 12:19:19 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v3 0/8] DRM scheduler fixes and improvements
Date: Tue, 24 Sep 2024 11:19:06 +0100
Message-ID: <20240924101914.2713-1-tursulin@igalia.com>
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

All reviewed now, re-sending after rebasing on latest drm-tip so it is in a
mergeable state.

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

 drivers/gpu/drm/scheduler/sched_entity.c | 53 +++++++++++++++++-------
 drivers/gpu/drm/scheduler/sched_main.c   | 32 +++++++-------
 include/drm/gpu_scheduler.h              | 28 +++++++------
 3 files changed, 68 insertions(+), 45 deletions(-)

-- 
2.46.0

