Return-Path: <SRS0=dIjB=7B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C267C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 15:44:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1388920657
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 15:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tWSZnhgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1388920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDF526E354;
	Tue, 19 May 2020 15:44:43 +0000 (UTC)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F1146E353
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 15:44:42 +0000 (UTC)
Received: by mail-qk1-x733.google.com with SMTP id i5so15653153qkl.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 08:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+DH47d6lZ1FmFBdGI8/8FqBgidQmxEabtmKFMAE5sdo=;
 b=tWSZnhggH/Iqng787nuABVcWwY/KFAsx2ggd4xgq/pygI2fAOaiz1l6S3np3Rb9RUN
 TJnhYYpuNbSowReqeOcvx8NMc0cJX41mTi5xPq22sFldOiJTUmbc49hmIwzxyuZCl6I/
 /xrwsQXF0vTrk6npxYkUDCSSiO/Y6JNh0h8+PODEHbFGloSfXdFrk+dRBIieo2esc6nY
 iWOjyU7BU19x9liVhENSuixPFLlGhbhXnbE8hynJnO+V53O0uUBexz189BI9pIX4oCR4
 oVWou5hN85SfXjyZFU48YBbDS74BjO1Z3rLRzsCEO+woJ6RAbytg8h8k8ebI9MMd1kNC
 XaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+DH47d6lZ1FmFBdGI8/8FqBgidQmxEabtmKFMAE5sdo=;
 b=mJ8FkEHmy5U8acxut1imjU5ojfuG/v0tx8pu/7K6NB3iRFjyOmPKrIn+ZXUIbpvyPz
 6EUEB1EFZ7hz8M5mEu5ZhqIUhLpaUIDD2TJzYUjOxY1VHPyYBNRBPZeSI+i7NtAC1Jtj
 yvcGgBV7Gv3ThnuECtsjvz8E0qckZmYCo0ZNwEoOM9NcriCVvz3HOiq2Y1Y+eofOQzde
 l9mJ0pF3aDB59GrMHsAGMUKvD468t8zPdHY/76yZZl7hgGHdYHoABQSwzPzSJKR5vvoc
 mr/U3DjE1a+1eUF0H2LBUU2B2077cU/dLGiyyJ+48RW95uXD7QiRwTQjntifX2wFTmrA
 ySjA==
X-Gm-Message-State: AOAM531NAjfluZHZ1FyVwccCtfXxqSsZASe4Gr3BRKQsJFY2t6dVY9Ex
 r48IQYHh62Y8uolu2n3YDjCf8zCF
X-Google-Smtp-Source: ABdhPJwWsDTuuuMsNelDIA3o4w5ZP/MxighbTHXxdsGJqDHpbvEwuo7QEBD3LegLDWEF3dqxKLh+7g==
X-Received: by 2002:a37:9fd5:: with SMTP id
 i204mr22148505qke.191.1589903081358; 
 Tue, 19 May 2020 08:44:41 -0700 (PDT)
Received: from localhost.localdomain ([71.51.180.250])
 by smtp.gmail.com with ESMTPSA id l133sm10819975qke.105.2020.05.19.08.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 08:44:40 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/7] drm/amdgpu/gfx10: add navi12 to gfxoff case
Date: Tue, 19 May 2020 11:44:21 -0400
Message-Id: <20200519154426.1752937-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200519154426.1752937-1-alexander.deucher@amd.com>
References: <20200519154426.1752937-1-alexander.deucher@amd.com>
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

Looks like it should be handled here as well.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

Can someone test this on navi12?

 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index bd5dd4f64311..19de77cea890 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7118,6 +7118,7 @@ static int gfx_v10_0_set_powergating_state(void *handle,
 	switch (adev->asic_type) {
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
+	case CHIP_NAVI12:
 		amdgpu_gfx_off_ctrl(adev, enable);
 		break;
 	default:
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
