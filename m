Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A66C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 21:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C3620748
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 21:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPwLea+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C3620748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 487E46EA66;
	Thu, 20 Aug 2020 21:05:16 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FAC86EA66
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 21:05:15 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id j10so1584346qvo.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 14:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Mxrs+rEyOM/oKwKOc1sEJ7DXTwDwaRq343pfEwja/Hs=;
 b=sPwLea+4XcnW2ImRtIYmSoRcfEEg0AFnTIxBtoG0NdLhulalCz5GQoMVaF7mQ8y0ev
 fkVSURUGbDiHMqWhMiGXXE/je6wblaVr3elBbpL7CfEzj2+T8CkebWXNN801ee3Sja8a
 JReofH98+9eqDvr6vIEbTJVVTPT0lnkZXf7NgnSx81YQJwuNpDwPivNagPfSQZSc4n1a
 NvRYjB+6US/7Ms6VScBAITSIKTMlqQsm2h4HFVfRKT3qVVETTmm4NX8OeeXzSgD/aSPb
 JYvf6B6pZpMG/jE/AKMmZqMF6BTZatCox0W9qTTwG1dzUlxLaaDn4Mw4psOc1FFQDGOq
 EAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Mxrs+rEyOM/oKwKOc1sEJ7DXTwDwaRq343pfEwja/Hs=;
 b=bkswBHPRln/T1zgI+wO/Rq+5hY8po1pVLPp6aRvhJFYLowrvBEzt1dix1W733TIo6p
 72du0ZG/mKnBdfLk/OPMH+qLE1BmfpgSq1unbmO7xTuqREf2YrakqRNFDQxKMT2XiN+Z
 i9uX4drzbiRs04UQnJO2MtspHk0Il3JaruPr4tBoyhERBhXshSqciGhbt4jq3SS7FAks
 c1kn1URpw5+7jR/wrqyGjjB/5XUTE9foFY/MfwmL7QjWPYE5/Db6XGZKWdsynovXv6I6
 dUd7P6w3PpkVQ28mHbiJk7qbJLHVG3cOUOBNVbve1+dg0IU0ncerghEKfhsJPJAp7LiD
 RVdA==
X-Gm-Message-State: AOAM530wPLOskvLzn9RkDJuQyzE3invmgFn2PT1568jta9T0AHXfW43q
 kiNJvpfOqzCEKi80mHfrfjPiMguTkV0=
X-Google-Smtp-Source: ABdhPJwX3kWnfw+fazBX9Eo0j660+Xus62lkXX0Jh7V+3EaA3JKGcA3F1LGlzTELEKUixS0QswSjgw==
X-Received: by 2002:ad4:52e3:: with SMTP id p3mr767646qvu.70.1597957514114;
 Thu, 20 Aug 2020 14:05:14 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h23sm3161747qkl.38.2020.08.20.14.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 14:05:13 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: enable ATHUB clock gatting
Date: Thu, 20 Aug 2020 17:05:03 -0400
Message-Id: <20200820210504.1311186-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 "Prike.Liang" <Prike.Liang@amd.com>, Evan Quan <evan.quan@amd.com>,
 Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Prike.Liang" <Prike.Liang@amd.com>

Enable ATHUB clock gatting set in Renoir series.

Signed-off-by: Prike.Liang <Prike.Liang@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/athub_v1_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c
index 847ca9b3ce4e..3ea557864320 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c
@@ -73,6 +73,7 @@ int athub_v1_0_set_clockgating(struct amdgpu_device *adev,
 	case CHIP_VEGA12:
 	case CHIP_VEGA20:
 	case CHIP_RAVEN:
+	case CHIP_RENOIR:
 		athub_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		athub_update_medium_grain_light_sleep(adev,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
