Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17977D25B44
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 11:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71A2310E693;
	Wed, 28 Jan 2026 11:08:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="VojS+KkN";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BED010E66F;
 Wed, 28 Jan 2026 11:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4xj33rqoeOEGIlACIPZA79bATd+ipQjB9+w3hfaab+A=; b=VojS+KkNkRUBSJVZ1aRTb3r+Vh
 WZdli0OVTEwk0kPES4OoZiyqHVawe81hkQCVE6oNKTiCNfKQKhxRZhYceIdua9iNcZbdPuJsW+hcl
 UOsr6ajOKjut0sz3AswOvkTWFFJK4+eIXxvDWCxP0qlaDQD7TdkcCp5Xww5nj+Kpj+JJ9ok5Qfido
 yuRWVBR3GryekbW3zBm20D7qWeane5To2+/TGrpTWfu9sMW+NfBri8TQldrS6ZOXm6cXnQ4+Mz+Zu
 PVjc7JPnfEp4Zi3qVRNAqcLmLlEoSvJjF3E7/BseiUE3aY1YmH1i3VB6xmO3iWoxjtuhbXevxYmyH
 5ddbE52w==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vl3PP-00AqfI-GC; Wed, 28 Jan 2026 12:08:27 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 nouveau@lists.freedesktop.org
Subject: [PATCH v6 25/31] drm/nouveau: Remove drm_sched_init_args->num_rqs
 usage
Date: Wed, 28 Jan 2026 11:08:00 +0000
Message-ID: <20260128110806.38350-26-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128110806.38350-1-tvrtko.ursulin@igalia.com>
References: <20260128110806.38350-1-tvrtko.ursulin@igalia.com>
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

Remove member no longer used by the scheduler core.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: nouveau@lists.freedesktop.org
Reviewed-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_sched.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.c b/drivers/gpu/drm/nouveau/nouveau_sched.c
index a7bf539e5d86..dce8c5c9bec6 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sched.c
+++ b/drivers/gpu/drm/nouveau/nouveau_sched.c
@@ -407,7 +407,6 @@ nouveau_sched_init(struct nouveau_sched *sched, struct nouveau_drm *drm,
 	struct drm_sched_entity *entity = &sched->entity;
 	struct drm_sched_init_args args = {
 		.ops = &nouveau_sched_ops,
-		.num_rqs = DRM_SCHED_PRIORITY_COUNT,
 		.credit_limit = credit_limit,
 		.timeout = msecs_to_jiffies(NOUVEAU_SCHED_JOB_TIMEOUT_MS),
 		.name = "nouveau_sched",
-- 
2.52.0

