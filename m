Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA1BC433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 19:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C4D5610C9
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 19:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4D5610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 373EB6E20C;
	Thu,  8 Apr 2021 19:57:47 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3ED06E1A5
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 19:55:26 +0000 (UTC)
Received: by mail-qk1-x72a.google.com with SMTP id x14so3528605qki.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Apr 2021 12:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2WI115VsuVItfr2BpF98BtkUGHktbIekuswgNtc/yWQ=;
 b=KxbRTTY6af3VKPp4S2HqE7Tp2o+8O01vqFeP8r7RbXDM/wa790hnS+UPp/y47uRqfC
 4mKjkQufJ8Yj+39Qk4PEdJDcwDihNL0in5uZ6C8Ycw32/bSew72cEdXDSkASLbOzho1+
 VSdQgKPHbdIB3+EAixCiDnzmctFhyuyEdw4PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2WI115VsuVItfr2BpF98BtkUGHktbIekuswgNtc/yWQ=;
 b=bXoAkABwvyzkcAh8DFG4QUxQ8/RsDk7gDiTzOlSF+3QzFMwvTDVTXcVYuul6m65oqb
 hlY5GB+Ba6AVzV8rkAF402nDczWdxVzIt+gYiOXUdbaTU1Mp3cgeC5zhGcd4jZSk2vD+
 lWn0vVIfIuqVmhl8MwWiZbCuGvruHB0/pLq/F1t7bmEQWJeeHGW5mJm3l/YLNyBQGmKK
 lj7sYAv9Q1FvoEJixwj8b5uHZcjh6cYUtzbfrkSYMUeIV7XpBOXpbJflTh7lqiQt+bEp
 FHn8SKWf34POH75pQaDm6YOU35rL3Eo3eGIm5xNFAjKn2YSPVAHv+9NnlwR4P9HDLogp
 tuJQ==
X-Gm-Message-State: AOAM533Q/HJs8kxziVgKHROCdZL4IjORUMXGoFKuetQHnzFa+1+syMLM
 pY9hzNLcycmoI0UF4bUnKt3nwMyVWfLcPg==
X-Google-Smtp-Source: ABdhPJzY7r9AOqkMC5XamcJKlr8gz45ogTkiXpeO5D1cebA8+pUW0m6PHsieZZ+brHlOKRMPNZGyYg==
X-Received: by 2002:a05:620a:135a:: with SMTP id
 c26mr10226725qkl.110.1617911725823; 
 Thu, 08 Apr 2021 12:55:25 -0700 (PDT)
Received: from markyacoub.nyc.corp.google.com
 ([2620:0:1003:513:b9ea:a4f6:c7ad:d4c4])
 by smtp.gmail.com with ESMTPSA id n1sm355753qtp.76.2021.04.08.12.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Apr 2021 12:55:25 -0700 (PDT)
From: Mark Yacoub <markyacoub@chromium.org>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Report the Frame number at beginning of CRC
 calculation
Date: Thu,  8 Apr 2021 15:55:12 -0400
Message-Id: <20210408195512.2236336-1-markyacoub@chromium.org>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 08 Apr 2021 19:57:45 +0000
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
Cc: alexander.deucher@amd.com, harry.wentland@amd.com, seanpaul@chromium.org,
 Mark Yacoub <markyacoub@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mark Yacoub <markyacoub@google.com>

On reporting back the frame number of the CRCs through
drm_crtc_add_crc_entry(), send back the vblank count at the time the frame
CRC starts calculating rather than when the CRCs are ready to be
reported.

Tested by running IGT module: kms_plane::capture_crc()

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h   |  1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c   | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 8bfe901cf2374..b1e7af435b440 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -461,6 +461,7 @@ struct dm_crtc_state {
 	int update_type;
 	int active_planes;
 
+	u64 vblank_at_crc_init;
 	int crc_skip_count;
 	enum amdgpu_dm_pipe_crc_source crc_src;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 66cb8730586b1..abf9dcefadbe6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -305,6 +305,17 @@ void amdgpu_dm_crtc_handle_crc_irq(struct drm_crtc *crtc)
 	 * first two CRC values.
 	 */
 	if (crtc_state->crc_skip_count < 2) {
+		/*
+		 * Save the vblank count at the time when the CRC calculation starts and comes here
+		 * for the first time (crc_skip_count=0).
+		 * drm_crtc_add_crc_entry() reports the number of the frame these CRCs are about,
+		 * which should be the vblank_count of the frame rather than when the CRCs are
+		 * ready.
+		 */
+		if (crtc_state->crc_skip_count == 0) {
+			crtc_state->vblank_at_crc_init =
+				drm_crtc_accurate_vblank_count(crtc);
+		}
 		crtc_state->crc_skip_count += 1;
 		return;
 	}
@@ -315,6 +326,6 @@ void amdgpu_dm_crtc_handle_crc_irq(struct drm_crtc *crtc)
 			return;
 
 		drm_crtc_add_crc_entry(crtc, true,
-				       drm_crtc_accurate_vblank_count(crtc), crcs);
+				       crtc_state->vblank_at_crc_init, crcs);
 	}
 }
-- 
2.31.0.208.g409f899ff0-goog

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
