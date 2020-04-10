Return-Path: <SRS0=F+/f=52=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4F7C2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 12:52:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54F2D20769
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 12:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owYtuIux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F2D20769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A1AD6ECDC;
	Fri, 10 Apr 2020 12:52:09 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B363F6ECDA
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2020 12:52:07 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id z90so1299784qtd.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2020 05:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rVPLXT75hgLNDz/K0BdMYjqq9Upn/5VIlCP5NQ5+Uq0=;
 b=owYtuIuxVwFv4bkpnG/lJkSsmxEM8LteBkrfXlGPWKS3fogg01s3N2gdcnVP/RSavV
 JLaiN73EgfJVxY/3Y2pcMrOfXZKTLusvLvk+m1E8Aso/oJMjizbEUh8q5SQB/tDCIb+N
 F42O2GPYXlaVevzWuBbV/kfiL7Sqy7KKvFY2tLF51Wa8XyTmSI6UKu2N99ZGat3HMfRz
 2rOPZG+14GKk9HVKLWEPWf8vXmOExThssl9hrIM5ALbFKfZ4ivvZR3xt+nun1rqdNbo1
 nlv2yc19qXRz2/BMZzowlLsSd8GHBFSJgpyfJNGtNhbAoMwjmpSZNlvlQm3h7B3Ru8Nv
 2+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rVPLXT75hgLNDz/K0BdMYjqq9Upn/5VIlCP5NQ5+Uq0=;
 b=sbLMEOQfHwqTCgCP5gwpzgwZm+oErQStoLA7q7zbM5OrxvUso4p4lNEu1myL2kSRPJ
 NdSiUO8aoTfFlTpS6i8bCW2Cb/4NAnB49FGFMKkA5MGqdlH6Op2YpfWapllS74v8Ch3m
 98t/KOjM6VmHn9CZQZkYMW+2niNwWkHjSJnQHitYhyZVmkpZ2tb8u6HybC3uHUt+AJHJ
 0iEo0AaTYFx+PtT0qTCeK2OyBIX4vYEDlASOkSolP+IRG/4g47tAlOz8vXp75zoRSV03
 CKL/3KF8G1Bh3acyNmNKBxPFl9kEEcXkrT/Zk3SPHNAhaK+uDPihQpIOD8fU9xVzjARw
 iWJg==
X-Gm-Message-State: AGi0PuZUqlnWZnjhckYjKvTb29VlEQ6BmleP0RZSPmW54OgmLZECfwxU
 oB3KdGoH6zig8cAP7Cv+EtQLpAQt
X-Google-Smtp-Source: APiQypLpZQB/gGQpAJ0WfLmcVR03nSIaEFxJ5tKY1Xw1L79GFTB79G2NaSvFJQrf1IfhTyWnzh6IOg==
X-Received: by 2002:ac8:2ac6:: with SMTP id c6mr4371150qta.35.1586523126736;
 Fri, 10 Apr 2020 05:52:06 -0700 (PDT)
Received: from localhost.localdomain ([71.219.40.23])
 by smtp.gmail.com with ESMTPSA id g21sm1524536qtq.26.2020.04.10.05.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2020 05:52:06 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu/ring: simplify scheduler setup logic
Date: Fri, 10 Apr 2020 08:49:59 -0400
Message-Id: <20200410124959.1489394-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200410124959.1489394-1-alexander.deucher@amd.com>
References: <20200410124959.1489394-1-alexander.deucher@amd.com>
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
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set up a GPU scheduler based on the ring flag rather
than the ring type.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 4863e91c5533..13ea8ebc421c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -260,9 +260,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	ring->priority = DRM_SCHED_PRIORITY_NORMAL;
 	mutex_init(&ring->priority_mutex);
 
-	if (ring->funcs->type >= AMDGPU_RING_TYPE_GFX &&
-	    ring->funcs->type <= AMDGPU_RING_TYPE_VCN_JPEG &&
-	    !ring->no_scheduler) {
+	if (!ring->no_scheduler) {
 		hw_ip = ring->funcs->type;
 		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
 		adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] =
-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
