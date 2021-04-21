Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CF3C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 09:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E27FD61440
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 09:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27FD61440
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47BF16E96E;
	Wed, 21 Apr 2021 09:50:53 +0000 (UTC)
X-Greylist: delayed 1515 seconds by postgrey-1.36 at gabe;
 Wed, 21 Apr 2021 09:50:51 UTC
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 842DA6E96E
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 09:50:51 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (unknown [217.70.183.193])
 by mslow1.mail.gandi.net (Postfix) with ESMTP id 17522C886E
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 09:17:04 +0000 (UTC)
X-Originating-IP: 86.238.178.59
Received: from haruko.lan (lfbn-idf2-1-947-59.w86-238.abo.wanadoo.fr
 [86.238.178.59]) (Authenticated sender: schroder@emersion.fr)
 by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id AF01A240006;
 Wed, 21 Apr 2021 09:16:36 +0000 (UTC)
From: Simon Ser <contact@emersion.fr>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] amdgpu: fix GEM obj leak in
 amdgpu_display_user_framebuffer_create
Date: Wed, 21 Apr 2021 11:16:35 +0200
Message-Id: <20210421091635.77483-1-contact@emersion.fr>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This error code-path is missing a drm_gem_object_put call. Other
error code-paths are fine.

Signed-off-by: Simon Ser <contact@emersion.fr>
Fixes: 1769152ac64b ("drm/amdgpu: Fail fb creation from imported dma-bufs. (v2)")
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 48cb33e5b382..1953223ecdba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -944,6 +944,7 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 	domains = amdgpu_display_supported_domains(drm_to_adev(dev), bo->flags);
 	if (obj->import_attach && !(domains & AMDGPU_GEM_DOMAIN_GTT)) {
 		drm_dbg_kms(dev, "Cannot create framebuffer from imported dma_buf\n");
+		drm_gem_object_put(obj);
 		return ERR_PTR(-EINVAL);
 	}
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
