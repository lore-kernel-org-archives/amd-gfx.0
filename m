Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66953CFD625
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 12:44:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3C3410E5AD;
	Wed,  7 Jan 2026 12:44:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="P+ncwWGB";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A3D110E5AF;
 Wed,  7 Jan 2026 12:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zgLLpyQAmyaiyeMztB6r3ywf0YQDgiHqyFsSWyvAPjU=; b=P+ncwWGBZ0Iyus7qgXxS9YJ0F7
 N0pi6g4K8FNJ2LNKY2exuTjYs+ntroWVQPsNJxIi9jIlCFPr3ps4nY8KYOZgriO6U+0j8TbGUYQdh
 PJj5PFbBAFYbewJ6BOAUjVeGG04HtdhIJZHEVJxZsw4jxl/rm/v/INMb3qVwgiQ4bRfCoHy35sZFC
 T8UOIUnz7jAF9X9HKus9ebjWTOP2iYaQ6cg0ZjP4hooQOqXdxpZ0zTA7p6sRI0KD39BrWOYapy/1F
 +77JNMw/JsueGiGTtuXg1lyZS1iT1gZKch3MEzakhT/9Toe6BI8tD4WrivzHOBi9v+4JkcSa+VRlZ
 gLZiFdFQ==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vdStK-002Yt6-PT; Wed, 07 Jan 2026 13:43:58 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 2/3] drm/amdgpu: Remove redundant missing hw ip handling
Date: Wed,  7 Jan 2026 12:43:50 +0000
Message-ID: <20260107124351.94738-3-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107124351.94738-1-tvrtko.ursulin@igalia.com>
References: <20260107124351.94738-1-tvrtko.ursulin@igalia.com>
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

Now that it is guaranteed there can be no entity if there is no hw ip
block we can remove the open coded protection during CS parsing.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: 55414ad5c983 ("drm/amdgpu: error out on entity with no run queue")
Cc: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index ecdfe6cb36cc..82bb70167f5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -84,13 +84,6 @@ static int amdgpu_cs_job_idx(struct amdgpu_cs_parser *p,
 	if (r)
 		return r;
 
-	/*
-	 * Abort if there is no run queue associated with this entity.
-	 * Possibly because of disabled HW IP.
-	 */
-	if (entity->rq == NULL)
-		return -EINVAL;
-
 	/* Check if we can add this IB to some existing job */
 	for (i = 0; i < p->gang_size; ++i)
 		if (p->entities[i] == entity)
-- 
2.52.0

