Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D88CF9C77
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 09:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE30410E6A1;
	Tue, 24 Sep 2024 09:51:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="WJWxkxI1";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89C3F10E69C
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 09:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pMyOLw0gqGz8DM9UT37iKZ4eJxI+RLXUKxlBXZ8Wf6o=; b=WJWxkxI1XIFbz07MWsYbXc8wAq
 4J5Yz8n8AC/tCc5xWjxhhj2BkRCQyZLozURzHXCJ9RbcTRYu8yfSL+BEn3ciaWawbwDEEAB+RMklo
 dyzQI2gUE7t6XEA7fY6lL4PNAqgbEj/bUV7DkhXReGxEN7CMExLlZEovCpkxxewdFKnzrL5illEfg
 YKymGNLOnWL3dOag+SdY5ixpw+TCYJnjtE6AYJKP2SNAHAIFL1QaKdt1AFlRPRatCsgN3Dc1jZcsL
 1Y8rhIYgX7pacTlPFJIT/YdFzMYkhtjZAk4g/j9Tul1EsbQmfvds+vkIiF+KOzYGV3hpGRKDuVlRR
 iHHCp17Q==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1st2D4-000KQa-NA; Tue, 24 Sep 2024 11:51:54 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Drop impossible condition from
 amdgpu_job_prepare_job
Date: Tue, 24 Sep 2024 10:51:44 +0100
Message-ID: <20240924095145.2281-2-tursulin@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240924095145.2281-1-tursulin@igalia.com>
References: <20240924095145.2281-1-tursulin@igalia.com>
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Fence has been initialised to NULL so no need to test it.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 570820edcfda..d11cb0ad8c49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -353,7 +353,7 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched_job,
 	if (r)
 		goto error;
 
-	if (!fence && job->gang_submit)
+	if (job->gang_submit)
 		fence = amdgpu_device_switch_gang(ring->adev, job->gang_submit);
 
 	while (!fence && job->vm && !job->vmid) {
-- 
2.46.0

