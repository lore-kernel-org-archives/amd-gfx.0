Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1168AC2D0CD
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 16:37:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB28B10E3FF;
	Mon, 19 May 2025 16:37:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="M4GTnxpK";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07CF610E26F
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 16:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qg98CSYirw+4ou040rNzNGy1pCuwWEHNDKQhb1XBwYw=; b=M4GTnxpKFUKw0OgZeWD/JSzo4T
 jVz0w64e8QcGwoS5fyJL/NmP0gPafTtRzwJPeFx9ShWHwMFmc6PLMo37/Z9Ino5xzwYwfvA24GX3L
 ZlUnySackUKgeULJSBbIv20Z3vfpjpdT/ETdvoS2+2jBLG1ptO9dz8f5/bm7UaK+InnHlbwEmA6iA
 nm1KGXOt5B1+9AanR35tP9r2wtaHjkyM0Z6y1DMh184BsGKhV6sDOzkgEXW3JnZdNx/czEERpGcZC
 zpxqw4rktYjNIwJL9UktqlBvORGRMCDk2fBPCluQk6sv0ESYIiHukDxP7h3KHFfC6HuKPeTU0jqhn
 3Yu70CMg==;
Received: from [81.79.92.254] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uH3UQ-00AKIw-6E; Mon, 19 May 2025 18:37:22 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [RFC 0/3] Potential context entity destroy race
Date: Mon, 19 May 2025 17:37:10 +0100
Message-ID: <20250519163713.11367-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
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

One weird KASAN failure observed one time only. More details in the last patch.

If plausible I will need to fix the commit message in the last patch.

First two should be non-controversial cleanups, hopefully.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>

Tvrtko Ursulin (3):
  drm/amdgpu: Make amdgpu_ctx_mgr_entity_fini static
  drm/amdgpu: Remove duplicated "context still alive" check
  drm/amdgpu: Add locking to amdgpu_ctx_mgr_entity_fini()

 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 16 +++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 -
 2 files changed, 3 insertions(+), 14 deletions(-)

-- 
2.48.0

