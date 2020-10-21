Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E00C2D0A3
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 23:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FF9A2225F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 23:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="gs4rqj6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF9A2225F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E589A6EEB1;
	Wed, 21 Oct 2020 23:31:38 +0000 (UTC)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CC666EEB1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 23:31:37 +0000 (UTC)
Received: by mail-ed1-x541.google.com with SMTP id x1so4285817eds.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 16:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yqKif7fNSaIjOBAq0E9p3LgCvbNOBj0aJZDMDBqIxgM=;
 b=gs4rqj6bOqd9Tdp6NASMXM+I2P9fKABXmJLxWw9zgrY/DMG4a+3SGnpPFRUiCvca1H
 iaw9lP5B0w7sVU1DSfY6Glv91yAlOFyScMQrbSjkBRDI1VqlJC8LNZG/zGcnpFo25I2C
 6Kgp1G0kJ5otZ1+hL/Bc2eEshi61xktTXJMslQms26kFqZPIly3s7UHTQFck1BAkZ5pn
 o51zFgpq2rNg7u5R2XITZeFCZ2FQAWjLg3LSPbfwHpM3Itv9X+GO1+9O458wj7+C2IL1
 h7tmCoPXXhJNL57glJSATJeNJ3MaLiCpxJSAA5zNZ3+8LBj23AkvV/XVbHdDLTLT1MPb
 Ocgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yqKif7fNSaIjOBAq0E9p3LgCvbNOBj0aJZDMDBqIxgM=;
 b=EZhsMCjc2CMlU+2/sbzdGDzKnGsvMROTSK4F2NDgo54sZPbGcmeGqsiL5cM3REhjZC
 NzGFFI+oQOMDtDQOeKYrXfT2tMLO9FUz26k+Y5eM5XtaQvfrj2SCphgb7qf/Llc/sGo0
 H5KiChcg8eGL0uLwJeYQuYJkl//QWbHp/l0zqjrE+U0hfhGdMinrsl2s62ZX/ayIgzr7
 vh3monDRAA2OJSDTGJqWlYo1WahuPdbdqYkMOot+SthytHF4IwZnovz0sk8CfuulWuPk
 zBdpOw+mdzTELW0aujg0hnuQ/ghCCm2YpfPXihMl+KmiCS2IsinIYIAkZq5/yduugC5B
 XO/w==
X-Gm-Message-State: AOAM530XnYAGwvEscxc6riIekXaZUh1QlUfgGdRkxvlUi19m+3Cl6q1E
 /aeuJjMI+P5qvi4KwsaCT58Wctys26d5S3iG
X-Google-Smtp-Source: ABdhPJx4yECMEHWDSqjPf/74hPwu0rygeakwLvfk3he1b74vAS7GgI6Tl7QSjj7u0JemPiM+fCKpXQ==
X-Received: by 2002:a05:6402:7c8:: with SMTP id
 u8mr5454175edy.153.1603323095414; 
 Wed, 21 Oct 2020 16:31:35 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id k23sm2845236ejs.100.2020.10.21.16.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 16:31:34 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 01/11] drm/amd/display: Do not silently accept DCC for
 multiplane formats.
Date: Thu, 22 Oct 2020 01:31:20 +0200
Message-Id: <20201021233130.874615-2-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021233130.874615-1-bas@basnieuwenhuizen.nl>
References: <20201021233130.874615-1-bas@basnieuwenhuizen.nl>
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
Cc: maraeo@gmail.com, sunpeng.li@amd.com, daniel@ffwll.ch,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, alexdeucher@gmail.com,
 harry.wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Silently accepting it could result in corruption.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2713caac4f2a..73987fdb6a09 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3908,7 +3908,7 @@ fill_plane_dcc_attributes(struct amdgpu_device *adev,
 		return 0;
 
 	if (format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN)
-		return 0;
+		return -EINVAL;
 
 	if (!dc->cap_funcs.get_dcc_compression_cap)
 		return -EINVAL;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
