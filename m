Return-Path: <SRS0=xwQz=A3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A565EC4345A
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7707C20787
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxT2VsYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7707C20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4D396ED00;
	Thu, 16 Jul 2020 21:23:37 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69FF86ECFD
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:23:35 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id o8so11722384wmh.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 14:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gjPABkw0SFio5RxcMqGewI4z+tsK1lN1GscIxb0PtOg=;
 b=mxT2VsYwx71luHqPze3GeJ5LLTCCxjOe9ftF5Zq9I8zuO9wV4riCtxHsuSkxIztPDD
 95n1A2lkNfBalMl+W1IDd4v0KBx4IN9/+YveXo3TdwOZ8t1smuK+StyYP4PvOHXicfJb
 IIABUfBbEvM/57Cv77Oo77r0Evian0c3kGSTofx/UQinrTypmcFG431D5stw6QhZl9cp
 Cg00ArX+TnC4EWLjYnof/9mDSgyQknauNOL2hB5wHWgN1Qi/AH2NQoZvU+Pz3LCLLOfH
 q6mZa5CtyVRoC7mLbgjbS66bBoLy7yDOeKNvKmIIRWcP0ogCXb9c2ohkmj04T3bBXNqn
 It8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gjPABkw0SFio5RxcMqGewI4z+tsK1lN1GscIxb0PtOg=;
 b=SrsPwY0IHaLELKbwjMBsdPo25E2R/OGHlwitGb2zuQN0pxsikEnPWbMiNi9aZrY5m9
 ex3iI7dOxCptnyaZltPWc9jMU/9VvkJMtOvuxvCCqnWzTFMcW5L9ThIjp2aOjreGP1dl
 251GsA+QMl7SaOMStjq2ju0Dgcc8gdkLykL4Bv5I1Z+xgLgmrN6KpwmYsRlaHCGRj8uu
 EkIfy2hasqWpwVVW6xl5uzvUMCethQBS4IL0+kQ88qGaYJL4VEzwLn+gevhqfAwEQoYZ
 MmFjV5ZLfR1dhUF2oE3gOUD/adSEHWBauhtyAaWN0eGiamy2buW2OBa+GM1wm4cNvlGK
 6eYw==
X-Gm-Message-State: AOAM532IzrY377lizYTeRjfA5EARGvBXADHDVh4PgV12DI6UYqA28qV9
 s1gIGm00gWvc7EcUWftKFBT8I6hE4rE=
X-Google-Smtp-Source: ABdhPJyC4pRJ5vgI92++6ky3xWQ2QZGP+I+uTS7NP49mCHqdWyP290VwnQxusUFenlomM4qEjmKViQ==
X-Received: by 2002:a1c:5646:: with SMTP id k67mr6265659wmb.61.1594934613759; 
 Thu, 16 Jul 2020 14:23:33 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-21-65-179.retail.telecomitalia.it. [79.21.65.179])
 by smtp.googlemail.com with ESMTPSA id c15sm10288696wme.23.2020.07.16.14.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 14:23:33 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 25/27] drm/amd/display: create plane rotation property for
 Bonaire and later
Date: Thu, 16 Jul 2020 23:22:49 +0200
Message-Id: <20200716212251.1539094-26-issor.oruam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716212251.1539094-1-issor.oruam@gmail.com>
References: <20200716212251.1539094-1-issor.oruam@gmail.com>
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
Cc: alexander.deucher@amd.com, Mauro Rossi <issor.oruam@gmail.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
DCE6 chipsets do not support HW rotation

[How]
rotation property is created for Bonaire and later

Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index df46cf7cb374..25ffa89d5657 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6103,8 +6103,9 @@ static int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 		DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 |
 		DRM_MODE_ROTATE_180 | DRM_MODE_ROTATE_270;
 
-	drm_plane_create_rotation_property(plane, DRM_MODE_ROTATE_0,
-					   supported_rotations);
+	if (dm->adev->asic_type >= CHIP_BONAIRE)
+		drm_plane_create_rotation_property(plane, DRM_MODE_ROTATE_0,
+						   supported_rotations);
 
 	drm_plane_helper_add(plane, &dm_plane_helper_funcs);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
