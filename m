Return-Path: <SRS0=eFkV=CN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8FDC43461
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2020 16:07:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC1052074D
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2020 16:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen-nl.20150623.gappssmtp.com header.i=@basnieuwenhuizen-nl.20150623.gappssmtp.com header.b="PW2sZUbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC1052074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C07996EC7A;
	Fri,  4 Sep 2020 16:07:12 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36E136EC6C
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2020 16:07:11 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id c18so7247988wrm.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Sep 2020 09:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen-nl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s9z3Lxj3zSC/nTOfDdPH4GXZ9Y+PpYyQW23hCCaVZmY=;
 b=PW2sZUbASRAGYwaSgdedjDVJXpF96CEScDZIME+9uERmXTMT6H+8KluiCcAO/h9Cid
 XucJFMGHjT9Tlx9izJ552lYcxLis8krh2zcu3Ydf7eDIVK+iVLoEam5DlATCFlOEV5wd
 3xs8Bny3ig0LJNcZurtOCZIIXMIByKrHtftWVa/SKdIeBA9v3tDvsZ4OVeK7eDNRwXrX
 wxB7fsGPHFtDZnUSkdftPNQUQdTy2SNUU67vCKZXGJoIKI+tRF+rZHtv/Puc+GxeFe+0
 +KSF402HmDpWVgQx2dJaamKpy040RbFD6kbO8Baes8VOazOqrgpT4EsaH8ecz7zs/l2G
 lDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s9z3Lxj3zSC/nTOfDdPH4GXZ9Y+PpYyQW23hCCaVZmY=;
 b=Z9z7ELb8a8wS5u08uoe4Oe3ObCuVU9oDtYk73+KdJ2r8XB6cil5amt4EL/yB3AotaV
 Yz0ocTNvD7t0kNG1hEsvFKlxdeXROhb/16CXt6bJ7xnPhrkg9q0FLhHsaK+ovL7qoEbr
 CfiQsHunj2egZWU8SC5m4x7w4AF2lvdwefKZzTHWlZ6OaodDAelxMeA0bYJB4/sG/B++
 i3iob3kH2VpOK+Ia/Rk9MU5tnVn41kBJxsIL8hhSf2IbUrFmdn4tOeN0zW+Xbb/VRC8Y
 FxtnK8xMG4jBFbqe6+K8AHiue8xrolz+Q6mgrF7XD4kep2DMjB8kRN085vHgroDUWAuH
 8ROA==
X-Gm-Message-State: AOAM532SGg/T+Yu1+nvCOFi9EMNvVpYGiavc+iOyA/BCWr8kNmuLkx+a
 wGJO/n9ORGsRulACndNDigkiEobgLDjw5RdI
X-Google-Smtp-Source: ABdhPJw5S+gQH6BLnQFqpz89tPXuQPoPvzY65cNp61qZFTPwp3Wylfj4G8TMpxFWOlbR+IW1X/MxcA==
X-Received: by 2002:a5d:4d82:: with SMTP id b2mr7989105wru.232.1599235629594; 
 Fri, 04 Sep 2020 09:07:09 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id h185sm12467609wme.25.2020.09.04.09.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 09:07:09 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 01/11] drm/amd/display: Do not silently accept DCC for
 multiplane formats.
Date: Fri,  4 Sep 2020 18:06:59 +0200
Message-Id: <20200904160709.123970-2-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904160709.123970-1-bas@basnieuwenhuizen.nl>
References: <20200904160709.123970-1-bas@basnieuwenhuizen.nl>
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
Cc: maraeo@gmail.com, daniel@fooishbar.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 alexdeucher@gmail.com, harry.wentland@amd.com
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
index a025897e2962..cb31b5ed19f7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3756,7 +3756,7 @@ fill_plane_dcc_attributes(struct amdgpu_device *adev,
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
