Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D09D6D22E
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 15:04:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2860710E3E7;
	Thu, 18 Dec 2025 15:04:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="qSgnSXU5";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08EB410E3E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 15:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VEud+3AOCc3+eeLHSIZXcIgWTBtXQhZt9oWQuJnoYE4=; b=qSgnSXU5t/ZCZXiwSTfRlhRWNr
 Pjr6eWpf497fSloYzJ8lKa2XBF8zshd6zCjW0fPnkKLuVJ8Ptrp/VchdRY6uOrF6Tux9PK80Ae/nw
 obD2aYQMC17pyLXomjRapouvRbQXLCdCDARDmIrpwX9MXSg2AJ8nT4j7/27l3m/42Gba4YfZ7tDlp
 xi/ZanenxApnjo/49bd5artWOMt2/oSDZrHHBk0Fa59bNn+KIIlQ4jvnuctrUhUAUzZpBpSH/jaAV
 mD1a5tSVxp4h/fJqtpRJpIipLiX/4j5J5rE9pzZnO2aHlw1wh4irDHBD9vHvpbJtin5cFAPRFzkTY
 +DPVntPA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with utf8esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vWFY9-00EI1W-5U; Thu, 18 Dec 2025 16:04:17 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 0/5] IDR to xarray conversion and some small cleanups
Date: Thu, 18 Dec 2025 15:04:00 +0000
Message-ID: <20251218150405.80502-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.51.1
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

RFC because the context conversion needs a lot of scrutiny (and passing through
the automated test suites), while the bo list changes are perhaps a bit of a
bike shed, although they do result in less lines of code and hopefully easier to
read.

BO list sorting is really independent, as is the IDR MES cleanup (which could as
well have the warnings removed). Just say the work and I can easily split them
out.

Series has been smoke tested, including lockdep and game + desktop workloads so
at least shouldn't be too obviously broken.

Tvrtko Ursulin (5):
  drm/amdgpu: Replace idr with xarray in amdgpu_bo_list
  drm/amdgpu: Remove output parameter in bo list handling
  drm/amdgpu: Simplify sorting of the bo list
  drm/amdgpu: Convert context manager to xarray
  drm/amdgpu/mes: Remove idr leftovers

 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 140 +++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h |  17 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |  58 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c     | 117 ++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h     |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c     |   9 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h     |   3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c   |   8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  18 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  18 +--
 12 files changed, 160 insertions(+), 248 deletions(-)

-- 
2.51.1
