Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BAAC19777
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 10:10:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 579F110E1BC;
	Wed, 26 Feb 2025 10:10:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="qQO7q/2b";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA9F210E203
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 10:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jsEJL/7dXrqjN5MPUMt798H/pMgQ50Y+EiVuo2IL9Y8=; b=qQO7q/2b49PezUlMTqf7fawAbB
 RZiuOwd3o1+go7LXifucIUySJY45mkaJ6ivrR7sgN16v5RQPHvBreeW/i7FGpe9Q4sukbh1l2wHSp
 4I2vSgC/MBV0yr6NnJbH6wjjV8KBJWsrQZ2RpC4NaNes+PV0XWA7n2z7VZgFIDIJHDEb6S+a2mRI4
 NrezCXsSfxohBOZWZqcCJ4qHnGSMEyoyET0WCRzqEh3iUAdVzRJIokPasEuuMhGdmVoZ3mcL3GC0I
 d6gbD6a37gJQyMTi7lOTyW5NWWD+PpvubamVOhTLdwTQJYOUfza8YG/kzB9PXyBYbe9IRrZ2Hc2EJ
 EJ1jXbdA==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tnEMl-000tOF-3b; Wed, 26 Feb 2025 11:10:17 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 0/3] Fit two IB struct amdgpu_job into a 512 byte slab
Date: Wed, 26 Feb 2025 10:10:12 +0000
Message-ID: <20250226101015.27117-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
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

A lot of the workloads create jobs with just one to two IBs, and if we re-order
some struct members and shrink some others we can stop those allocations
spilling into the 1k SLAB bucket.

Before:

  sizeof(struct amdgpu_job) + 2 * sizeof(struct amdgpu_ib) = 480 + 80 = 560

After:

  sizeof(struct amdgpu_job) + 2 * sizeof(struct amdgpu_ib) = 448 + 64 = 512

It is not a huge gain in the big picture but every little helps.

Tvrtko Ursulin (3):
  drm/amdgpu: Remove hole from struct amdgpu_ib
  drm/amdgpu: Reduce holes in struct amdgpu_job
  drm/amdgpu: Shrink struct amdgpu_job further

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 19 ++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  7 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c     | 29 ++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  6 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     | 41 ++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 17 +++++----
 12 files changed, 75 insertions(+), 58 deletions(-)

-- 
2.48.0

