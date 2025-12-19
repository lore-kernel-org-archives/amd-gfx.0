Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80A2D78776
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 13:42:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AF5010E48E;
	Fri, 19 Dec 2025 13:42:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="KXR2/Aeu";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F66D10E1D1
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 13:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yT0mtCim4uL4shK+Y43vgIZ4pCLxHzsx54xRzL27AlU=; b=KXR2/Aeu3fx7VBnb2+PLycoVA7
 ZWy+57AbwFdMBzuuNss/oIEUbwzw1/4rGZ5RM3Y+iM9RLIoTt2G3WmlHiqNnV9S9GQELBoZcaSAzT
 VA+kFaixjXm0NhqRI8FaA2mm+XpPtL5Akg1BUqLSwg/BWJa0Sg81eK+Pk2C23KJU4pf63hGFt9tis
 qnSd4r6Q1KFQAt+ebHEBSsmnWB0Iw+2esEHT8lIH1NZOvOyL8WDsKqVUOysrfY6q4kReaz+oXa35z
 5PAMIz8TeF2LapFUNxmylJT4LY5VrkSlTWoZEk85dw9Il3hbJSyoqE9g+E/ChsYb24s1v0dmn0FnC
 btlT+ijg==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with utf8esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vWakB-00EeQL-KT; Fri, 19 Dec 2025 14:42:07 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v2 00/12] IDR to xarray conversion and some small cleanups
Date: Fri, 19 Dec 2025 13:41:53 +0000
Message-ID: <20251219134205.25450-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.51.1
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

Tvrtko Ursulin (12):
  drm/amdgpu/mes: Remove idr leftovers
  drm/amdgpu: Simplify sorting of the bo list
  drm/amdgpu: Remove unneccessary memset in bo list creation
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 153 ++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h |  22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |  67 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c     | 225 ++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h     |  27 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c     |   9 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h     |   3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c   |   8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  18 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  18 +-
 12 files changed, 205 insertions(+), 361 deletions(-)

-- 
2.51.1

