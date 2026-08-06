Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48498C56208
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 13:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CA2910F1D3;
	Thu,  6 Aug 2026 13:47:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="DnIOz/p1";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB37F10F1EF
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 13:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=LYzYo3HXpYYQoUlVx0MPDmD1WlA7G+B3jpve4QJ4upk=; b=DnIOz/p1rPVUluiM4naEgBD/2o
 rp/IzrdHp2oFH6OnWQoxKqJXZAB9ZqS1Lj7/dkqBJlqq1asOD0N190SYxkYcv6utSSpjnRkH3pbwe
 QSz4tIYNUHTPWOy4Hw5M0WE/bsPOFTLrPX6JtXU/fU/+Vhf9/mTSnJsuCs6aUzbHkCQ+kJ0Mcebxc
 DTkJwcrTQ/8DLApHdcs0LeOUi308a/Zogn/oaNn1C7u/pX3fmcjbf36Jm/h/E6nJEgUHlq7t9gPAU
 0Ny6utW5/HtXRBC/zTnjpsVEgSqg3Gr83TjzB+T1+FSauf1HCA+354NctKdDlFS8sNEgdBXmK35dv
 MaN0hV1w==;
Received: from [83.105.121.4] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wryRO-00Ewqa-29; Thu, 06 Aug 2026 15:47:22 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v3 1/7] drm/amdgpu: Check correct field in
 amdgpu_ttm_tt_is_userptr()
Date: Thu,  6 Aug 2026 14:47:06 +0100
Message-ID: <20260806134712.91816-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806134712.91816-1-tvrtko.ursulin@igalia.com>
References: <20260806134712.91816-1-tvrtko.ursulin@igalia.com>
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

Presence of a task is a better indicator whether something is a userptr
than the address of an userspace VMA.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 91b7bf6e65f5..f4cc1d8ac4c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1401,7 +1401,7 @@ bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm)
 {
 	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 
-	if (gtt == NULL || !gtt->userptr)
+	if (gtt == NULL || !gtt->usertask)
 		return false;
 
 	return true;
-- 
2.54.0

