Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63211C71155
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 23:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C75052075F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 23:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tPiQOUqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75052075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F4589C7F;
	Mon, 30 Nov 2020 23:59:03 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3659C89C7F
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Nov 2020 23:59:02 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id f15so9654695qto.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Nov 2020 15:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CzlZbooDRucv471GoFQc/uLy2zLSLzmrjk8jfvv4aIU=;
 b=tPiQOUqxKmy5VQ6n3yTxYu5iTOYmK3eD79nn0qgJfEwCU0uBXWl1kRzuR+7lTvDqsH
 XS3GeyquIo/8OL1QSvVKvB51/kwDbduFbCww5J2ULAxjdd6XNAO8tSPxVzbZ88M311eW
 Vl2iDR+xsJtROIw6PT9RjsWjOar5scaquXnjzeJMC+HL+E466MEX3KBBxUycWLXY+tPe
 ls2jPfmcr4jAKfMSMVx/SPQx2KhitGihC46vljvGdllBla92uGe68Dv6Kmf2poR6y/6a
 XwZ6Tk9e3loM7leTpqrlCqBD5kOYmVg6nwgvkJltIdHoKeC8Ri5zCV8CGPBFaAAEoUiJ
 bdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CzlZbooDRucv471GoFQc/uLy2zLSLzmrjk8jfvv4aIU=;
 b=pNsdY1uIpWlJFKlt6qCswpXsOkSxWVhhEoGNCajEdz5F6GZN54x2YCVKqMazDkloz3
 bmc+i2xyttp59blp+3BKkaWWkdZgGq1a03NOMrjy5rJXbQNKVn1l6vaNFUKG4dp7Nwtp
 lIXaVXgs4rlEoxRYKEq3WCGzZWb8xar4iqL7680cOn0nHpvXr3QssdLK7A2MAEng2NDk
 bEG4aQI2Y5W3AnVc26xdfZeFQXGaDsY/TFL+JrwAXzvjZb12is36qeBnIRc6IrVHkTtf
 tuOdoBlYauFR6WbXuU6fciRYu7y/ztv+4kCPTvFXtWV+pWMGEISCdstnUMTG4czbD8JH
 H27g==
X-Gm-Message-State: AOAM533iOXwc6yHE8rRnOEhzCZRTIZdwfycDsvXAliyuXvT5UGzVGJCo
 lqDUFFocpePUEmxYW7ykHuS073I1q6M=
X-Google-Smtp-Source: ABdhPJyL+22inFZ9WXXqm4s4gq9zaPw1A1eoufPK1LLO3GVITOSSqD4swCMYT3419GGp3rmHjAfEtw==
X-Received: by 2002:ac8:370e:: with SMTP id o14mr24799796qtb.195.1606780741251; 
 Mon, 30 Nov 2020 15:59:01 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id o21sm44885qko.9.2020.11.30.15.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Nov 2020 15:59:00 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: move link_bandwidth_kbps under
 CONFIG_DRM_AMD_DC_DCN
Date: Mon, 30 Nov 2020 18:58:52 -0500
Message-Id: <20201130235852.457569-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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

It's only used when CONFIG_DRM_AMD_DC_DCN is set.  Fixes and set but
not used warning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 08539f431586..c0e61c13b3fc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5076,9 +5076,8 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	int preferred_refresh = 0;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct dsc_dec_dpcd_caps dsc_caps;
-#endif
 	uint32_t link_bandwidth_kbps;
-
+#endif
 	struct dc_sink *sink = NULL;
 	if (aconnector == NULL) {
 		DRM_ERROR("aconnector is NULL!\n");
@@ -5160,11 +5159,9 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 				      aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.raw,
 				      aconnector->dc_link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.raw,
 				      &dsc_caps);
-#endif
 		link_bandwidth_kbps = dc_link_bandwidth_kbps(aconnector->dc_link,
 							     dc_link_get_link_cap(aconnector->dc_link));
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 		if (aconnector->dsc_settings.dsc_force_enable != DSC_CLK_FORCE_DISABLE && dsc_caps.is_dsc_supported) {
 			/* Set DSC policy according to dsc_clock_en */
 			dc_dsc_policy_set_enable_dsc_when_not_needed(
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
