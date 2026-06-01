Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C109CD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 14:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 988211133B2;
	Mon,  1 Jun 2026 14:08:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="qJeSZlrB";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 174711133B2
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 14:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+0fDYClMtimCpWRX1UcDQtBPVMG4bOeKIneX6HinhVQ=; b=qJeSZlrBjURDK+KakAq4E4dzEW
 WbMPGwbGXpQJcN2lrVL60vWicCKRgNX3ZfY64jvKxs7z/tWSEAgwUsy3bweFfg1YDfRQj2dYRY7PJ
 yP5ErM99t3yKCu4BoOOrX0t59HnVKAaagdS0ke1wNlN6423VLkEl7vq1Z+THZ27J1gTuJ49hnJaLG
 +9glVmQNuhjXdo+Q0vOY9BTR3XfdISnXqpxiieAl+ZRrhbVacpbhp9gzX0XWaD8b2TtkULIFfOgjr
 4sz5G+fUBxa+y1YlUDOWA5CbKVkn9VzhlV0pRLVN18SWVLzX4xDJqJZq6ulgw8eHOvgrWZ28xEVni
 +f7ajooQ==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wU3Jo-00B2vo-Ck; Mon, 01 Jun 2026 16:08:40 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 7/7] drm/amdgpu: Clarify odd behaviour of
 AMDGPU_CTX_OP_GET_STABLE_PSTATE
Date: Mon,  1 Jun 2026 15:08:28 +0100
Message-ID: <20260601140828.27779-8-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601140828.27779-1-tvrtko.ursulin@igalia.com>
References: <20260601140828.27779-1-tvrtko.ursulin@igalia.com>
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

AMDGPU_CTX_OP_GET_STABLE_PSTATE is an unusual uapi - it will check whether
the context id exist, but otherwise does nothing with it. In other words,
the uapi has historically been implemented as being able to query the
global device state, as long as the caller supplies a random valid context
id.

Lets just document this and later figure out if it can be changed to
either more permissive (don't check context id), or more restrictive
(only allow queries from contexts which have overriden the performance
state).

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 941cb80cab4e..a1ef7c67b87a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -614,6 +614,14 @@ static int amdgpu_ctx_stable_pstate(struct amdgpu_device *adev,
 	if (!ctx)
 		return -EINVAL;
 
+	/*
+	 * The get path is odd in this uapi - it will check whether the context
+	 * id exist, but otherwise does nothing with it. In other words, the
+	 * uapi has historically been implemented as being able to query the
+	 * global device state, as long as the caller supplies a random valid
+	 * context id.
+	 */
+
 	if (set)
 		r = amdgpu_ctx_set_stable_pstate(ctx, *stable_pstate);
 	else
-- 
2.54.0

