Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED59EC352BE
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 19:38:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF15921BE5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 19:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JitrBImG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF15921BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85B816EB52;
	Thu, 16 Apr 2020 19:38:07 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 345EE6EB50
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 19:38:06 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id y3so22659514qky.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 12:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AWUEXLA2bVIyrpkmE95K7T3+yiUuTEp9d3ByBJLKGmw=;
 b=JitrBImGI9N6ygd70vN4b5106XwKOwCcFfOL7y2EfviPe6WqiiQbcMV9IAqNPrnP3p
 Dc6YsArROoXOfpSE6e4Db1hD38OBtNPDVhJ1KpU7tt0ePZz+QQDAUEPkdoiXFAOYpMrn
 dduo0bshtiAWehCzsWSquV/NDe+S07HARqKjt088zNfYvgMsHgvuBE6QDpCP0Uszs27/
 acFCRiHEde29ePjy12fxgjc8cLHqJ+AKYAyZ8yU7khg7+oDbm8LgjjlOS3QL4X9yzfnm
 kbwi5v4hIgHsAZBEQ9aGTSI3eejDHd4vIA6lxugAnGw0u30N5+JwgRsfTozkh0NAgwF9
 zVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AWUEXLA2bVIyrpkmE95K7T3+yiUuTEp9d3ByBJLKGmw=;
 b=kxQRyLA55OJ2gM0+TR991tqYpOvITRpbYvVJwLR1gRk1rHq7C54gGMqRRwQaHqwdgX
 tfQZ0T99wz8jlmCg5epYelUX3+rQZqZFc1q1OfU2DBIrJERr1hbBsc/y0+KCzA4/Ber1
 WxzzEeHVj1It4L1arpJuFU8sFLFls7omn9BnXMVRj4fFGHMuAoH+VPOMvDOr7/TbLxeI
 0XPwWAF6I8PH/QFqKwXg3bCRkhvenlAgsSlJkeixJVp6TFa2lQHnG5J+V576F9G5sfSY
 nsbh+qysZ0oh1MROz/XKifjNWBTERrqlyzVlqDGaJfLKHK4CUGWNh80dO6a5d67GrKEw
 GPOg==
X-Gm-Message-State: AGi0Pub4YrQxAxjbVhDTpPKAxBqoT9nm1Xg2WPlzjPCz8fNex9fmK3/m
 sTfOo6Aulc4hWn2PHFZnQggFhUQs
X-Google-Smtp-Source: APiQypJ/gzxYHKgp4ILkwRZb77qYlK8lfduQFu8X+NL48QS02WyI/zII+sK6sMWSv1O2zJLQk2NeUg==
X-Received: by 2002:a37:a3d3:: with SMTP id
 m202mr22100469qke.338.1587065885128; 
 Thu, 16 Apr 2020 12:38:05 -0700 (PDT)
Received: from localhost.localdomain ([71.219.72.172])
 by smtp.gmail.com with ESMTPSA id g14sm16578881qtb.24.2020.04.16.12.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2020 12:38:04 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/display: give aux i2c buses more meaningful
 names
Date: Thu, 16 Apr 2020 15:37:54 -0400
Message-Id: <20200416193754.3702-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200416193754.3702-1-alexander.deucher@amd.com>
References: <20200416193754.3702-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Mirror what we do for i2c display buses.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c          | 3 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 7 +++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    | 3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c113b676218d..735c01171d90 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4679,6 +4679,7 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 		i2c_del_adapter(&aconnector->i2c->base);
 		kfree(aconnector->i2c);
 	}
+	kfree(aconnector->dm_dp_aux.aux.name);
 
 	kfree(connector);
 }
@@ -6118,7 +6119,7 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 
 	if (connector_type == DRM_MODE_CONNECTOR_DisplayPort
 		|| connector_type == DRM_MODE_CONNECTOR_eDP)
-		amdgpu_dm_initialize_dp_connector(dm, aconnector);
+		amdgpu_dm_initialize_dp_connector(dm, aconnector, link->link_index);
 
 out_free:
 	if (res) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 7d28b0482127..69056660672d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -429,9 +429,12 @@ static const struct drm_dp_mst_topology_cbs dm_mst_cbs = {
 };
 
 void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
-				       struct amdgpu_dm_connector *aconnector)
+				       struct amdgpu_dm_connector *aconnector,
+				       int link_index)
 {
-	aconnector->dm_dp_aux.aux.name = "dmdc";
+	aconnector->dm_dp_aux.aux.name =
+		kasprintf(GFP_KERNEL, "AMDGPU DM aux hw bus %d",
+			  link_index);
 	aconnector->dm_dp_aux.aux.transfer = dm_dp_aux_transfer;
 	aconnector->dm_dp_aux.ddc_service = aconnector->dc_link->ddc;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index d6813ce67bbd..d2c56579a2cc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -32,7 +32,8 @@ struct amdgpu_dm_connector;
 int dm_mst_get_pbn_divider(struct dc_link *link);
 
 void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
-				       struct amdgpu_dm_connector *aconnector);
+				       struct amdgpu_dm_connector *aconnector,
+				       int link_index);
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 bool compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
