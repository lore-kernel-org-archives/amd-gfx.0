Return-Path: <SRS0=K/ap=KL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3BDC433ED
	for <amd-gfx@archiver.kernel.org>; Sun, 16 May 2021 12:13:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3410461075
	for <amd-gfx@archiver.kernel.org>; Sun, 16 May 2021 12:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3410461075
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E43789C48;
	Sun, 16 May 2021 12:13:20 +0000 (UTC)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C756789B0B;
 Sun, 16 May 2021 12:13:18 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 44806B11D;
 Sun, 16 May 2021 12:13:17 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@linux.ie, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, alexander.deucher@amd.com, christian.koenig@amd.com,
 sakari.ailus@linux.intel.com
Subject: [PATCH 1/4] drm/amdgpu: Use %p4cc to print 4CC format
Date: Sun, 16 May 2021 14:13:12 +0200
Message-Id: <20210516121315.30321-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210516121315.30321-1-tzimmermann@suse.de>
References: <20210516121315.30321-1-tzimmermann@suse.de>
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
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace use of struct drm_format_name_buf with %p4cc for printing
4CC formats.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 8a1fb8b6606e..49f73b5b89b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1077,12 +1077,9 @@ int amdgpu_display_gem_fb_verify_and_init(
 	/* Verify that the modifier is supported. */
 	if (!drm_any_plane_has_format(dev, mode_cmd->pixel_format,
 				      mode_cmd->modifier[0])) {
-		struct drm_format_name_buf format_name;
 		drm_dbg_kms(dev,
-			    "unsupported pixel format %s / modifier 0x%llx\n",
-			    drm_get_format_name(mode_cmd->pixel_format,
-						&format_name),
-			    mode_cmd->modifier[0]);
+			    "unsupported pixel format %p4cc / modifier 0x%llx\n",
+			    &mode_cmd->pixel_format, mode_cmd->modifier[0]);
 
 		ret = -EINVAL;
 		goto err;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
