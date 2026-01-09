Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5E2D1A61D
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 13:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A978C10E8C1;
	Fri,  9 Jan 2026 13:33:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="iNW6LFcx";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79BEF10E8C2
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 13:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CqbVXQHQaQsd/QMHd8u6ezgQVz7y6llQ9tgFZEaSKnk=; b=iNW6LFcxkT6QaRMYSf+YMwOZq5
 xM2oLU5FdBULjimXzNLfUN/L1NyijH2K/Rvqx5VQ7rgKoIk8PIzBdSgnDW3M90cA/YTblhLoDzxIb
 f/SAa/7gRc+4K/HW3Uf5UwRvybLEofk1LKS43upjaOlEk/IDz+mXJ8s/DkeOCPdenDR1XM7oKOVOZ
 L3Ke47WL23he1xSV4bEOJhKYBp1rv4HG653Tq92iGhtPpLUDdV7e2mUs4srts9HmZWxHCkNReF2mN
 AZwQgHJCyVWyCIumzsLsu1RU5+m1OnixP1eBnjGRNQ5wL/MO2xFqe1kaQBAFgxER/g4Wc8+GTylBJ
 Zqc5mk7A==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1veCcE-003Qb9-My; Fri, 09 Jan 2026 14:33:22 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v3 02/12] drm/amdgpu: Simplify sorting of the bo list
Date: Fri,  9 Jan 2026 13:33:04 +0000
Message-ID: <20260109133314.88548-3-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109133314.88548-1-tvrtko.ursulin@igalia.com>
References: <20260109133314.88548-1-tvrtko.ursulin@igalia.com>
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

Sort function only cares about the sign so we can replace the conditionals
with a single subtraction.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 66fb37b64388..87ec46c56a6e 100644
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
 
 int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
-- 
2.52.0

