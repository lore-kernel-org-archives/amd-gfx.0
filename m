Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CC1D6D22C
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 15:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FD0C10E455;
	Thu, 18 Dec 2025 15:04:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="pVg/lTbH";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C76D10E3E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 15:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xrfVrGvSgZigSIlNfPZgzHIzKlbED244bBxFv0ZcLn8=; b=pVg/lTbHx+EcJtk9hbQhckxrcg
 lvlwtkkrjyQY0w3KoxQEWF6cntMsVjPZea6/qh8OYN9spkBt/lAMXIdenmSy7PnrZviw8ucHyv42l
 Gw1swPi8oXkiKTxTqDI4uhp8imBDpKokYAIfg+AaPSOd8EW9CSqehSRX4mApTYDvcL0/f3379Csyn
 53MjikdEDD/bjxvqVSS+8GiKwPTL9qG+Jnlh1JbJlqA5HJ6DdUb4+lxRkM6M40L77KCd8JTbkyk8f
 d7Ut3N1oEDLRBoxTnDW64rgGdzIT1pZfbAvMoC8khSqqM3Rr8f9hhtr0AKVlLAlF709m8UmnWfGyi
 lQEvIlCw==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with utf8esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vWFYB-00EI1i-Br; Thu, 18 Dec 2025 16:04:19 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 3/5] drm/amdgpu: Simplify sorting of the bo list
Date: Thu, 18 Dec 2025 15:04:03 +0000
Message-ID: <20251218150405.80502-4-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251218150405.80502-1-tvrtko.ursulin@igalia.com>
References: <20251218150405.80502-1-tvrtko.ursulin@igalia.com>
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

Sort function only cares about the sign so we can replace the conditionals
with a single subtraction.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 0ab307317145..16b647b42b0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -60,11 +60,9 @@ static int amdgpu_bo_list_entry_cmp(const void *_a, const void *_b)
 {
 	const struct amdgpu_bo_list_entry *a = _a, *b = _b;
 
-	if (a->priority > b->priority)
-		return 1;
-	if (a->priority < b->priority)
-		return -1;
-	return 0;
+	BUILD_BUG_ON(AMDGPU_BO_LIST_MAX_PRIORITY >= INT_MAX);
+
+	return (int)a->priority - (int)b->priority;
 }
 
 struct amdgpu_bo_list *
-- 
2.51.1

