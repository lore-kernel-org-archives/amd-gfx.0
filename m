Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBD6CD6E55
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 14:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7889B10E867;
	Mon,  1 Jun 2026 14:08:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="a1GpPWv/";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D10C010E867
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 14:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EQMMv8FYgrZCM1dSGeJcSnFm5+pnVPVvW7Zhdy8tvsE=; b=a1GpPWv/+eh0NhRD8Epks6iYRY
 t8fUFnaCeST1kQh55PULwtRAnjbIz3QP/PJO28b3E4cbr/g4MiNFhCr+el1WCrgLHI4sBlniWkK1M
 Z1kXG2kxPqqRINQQCMvIBj+U+hZtpGemhLbPuuKBJlM3jfuHIzGsL5QJmtKhCzS52SKjd3GzBdXtA
 BPlXixc69MWzX/WoIfqQEm8GPgUyTlJ72W1r2/MpBVcybRAX46eMDf2iTx5CTmnPzpwwEMAERRqz/
 8gqjuy90iiy9UcLqlk+5abjYzFLiJoD3+vPg1xS+hXOmnEF/bJBM2gZT2rcdD2bWZs5qaJpdWzTxm
 nxyxWNQg==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wU3Jj-00B2v4-1j; Mon, 01 Jun 2026 16:08:35 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 0/7] Grab bag of context handling stuff
Date: Mon,  1 Jun 2026 15:08:21 +0100
Message-ID: <20260601140828.27779-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
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

In some semblance of order, the series starts with a fix and then continues with
some old cleanup patches, and a couple of new ones.

Only lightly tested so giving it a spin in AMD's CI would be essential.

First patch probably deserves immediate attention and if no mistakes or
regressions are present can be merged before the rest.

Tvrtko Ursulin (7):
  drm/amdgpu: Fix context pstate override handling
  drm/amdgpu: Remove arbitrary number of contexts limitation
  drm/amdgpu: Consolidate ctx put
  drm/amdgpu: Remove live context error log and skip
  drm/amdgpu: Simplify amdgpu_ctx_get_stable_pstate()
  drm/amdgpu: Convert context manager to xarray
  drm/amdgpu: Clarify odd behaviour of AMDGPU_CTX_OP_GET_STABLE_PSTATE

 drivers/gpu/drm/amd/amdgpu/amdgpu.h       |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   | 278 ++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h   |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c |   8 +-
 4 files changed, 117 insertions(+), 184 deletions(-)

-- 
2.54.0

