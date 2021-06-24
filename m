Return-Path: <SRS0=nR5r=LT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D711C49EAB
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jun 2021 07:28:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 318FA6141A
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jun 2021 07:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318FA6141A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 690E56ECDE;
	Fri, 25 Jun 2021 07:28:43 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4107D6E084
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Jun 2021 19:54:13 +0000 (UTC)
Received: by mail-qk1-x72f.google.com with SMTP id c23so16632789qkc.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Jun 2021 12:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yLU/znLEYcMatLvsNLPxqHr+hLgDBPcs6sZq6gszBjg=;
 b=GQbv7pRK0BnAbmi0dbOfDIfyOww+e6i3XhyjehX6SPR4oipgAUrJveJSK3UwZb3aC0
 wh9veSVnT1OOviK4NmDD6bu9SUxgr0Jx8os+6VCEAitgkNQdBPx65/0UfkhXD8hrSZDk
 Uood+37czLlByvNi+TV4mJ68VrXGDp0yeYr/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yLU/znLEYcMatLvsNLPxqHr+hLgDBPcs6sZq6gszBjg=;
 b=QIACtfcL03odp9hlhAX+DDe+OAOwsQ+2RD4REcDbfjba0Ydg7TaeEBfUWhCjpNDRN4
 Imn9JFxhPXvICWLWxsq2qyq97x3/2h/kChued3HW91qI1s847oqTgDlzDACt7fpcEEkj
 6MUSoYf2QcQP3gYT6y1ePXqkf5J1eu4x7/h7ORn1gzVPFpIGtekkwjYsPEzMnvy48d39
 hE7LChkPchQ9qL94vmb8caQSBwtmP2Bm3rO2hkyjNGdZ5dg3a9QO+GXgL30weZ5PlWhj
 huMh+5mPE5gvmhOTaFBs5SjJlq8h+tIrlu5kcO2LtDe5e3ka58/WOkbcMxEkirtoarzQ
 J+2Q==
X-Gm-Message-State: AOAM530jwJqhFFEc1aD6q5C97gZX5OYCdtgh6jg0b3Adh4PjiktW72aa
 ukp28oEsktObg1gk+gnHVWNl0HvmDQR8Vg==
X-Google-Smtp-Source: ABdhPJztKqcMb0v95sMPx7DTu8CCq0Hfd1OWdIvL1I+D4kvV3S6vcRrooHytimFLHkfruxfHlmKGMg==
X-Received: by 2002:a05:620a:414a:: with SMTP id
 k10mr7303374qko.37.1624564452264; 
 Thu, 24 Jun 2021 12:54:12 -0700 (PDT)
Received: from markyacoub.nyc.corp.google.com
 ([2620:0:1003:416:6bf4:ce97:2a5a:b53c])
 by smtp.gmail.com with ESMTPSA id h5sm3298458qkg.122.2021.06.24.12.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jun 2021 12:54:11 -0700 (PDT)
From: Mark Yacoub <markyacoub@chromium.org>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Remove assignments in if clauses.
Date: Thu, 24 Jun 2021 15:54:03 -0400
Message-Id: <20210624195403.1050871-1-markyacoub@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 25 Jun 2021 07:28:40 +0000
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
Cc: alexander.deucher@amd.com, Mark Yacoub <markyacoub@chromium.org>,
 seanpaul@chromium.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes Commit a46b6bd5 (drm/amd/display: Verify Gamma & Degamma LUT sizes
in amdgpu_dm_atomic_check)

Tested on Zork: IGT:kms_color

Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c       | 3 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 91e13ae388b7f..c0cc4ca5fdf60 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7792,7 +7792,8 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		    old_crtc_state->vrr_enabled == new_crtc_state->vrr_enabled)
 			continue;
 
-		if ((ret = amdgpu_dm_verify_lut_sizes(new_crtc_state)))
+		ret = amdgpu_dm_verify_lut_sizes(new_crtc_state);
+		if (ret)
 			goto fail;
 
 		if (!new_crtc_state->enable)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 9543b10e7e0bf..6acc460a3e982 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -342,7 +342,8 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
 	bool is_legacy;
 	int r;
 
-	if ((r = amdgpu_dm_verify_lut_sizes(&crtc->base)))
+	r = amdgpu_dm_verify_lut_sizes(&crtc->base);
+	if (r)
 		return r;
 
 	degamma_lut = __extract_blob_lut(crtc->base.degamma_lut, &degamma_size);
-- 
2.32.0.93.g670b81a890-goog

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
