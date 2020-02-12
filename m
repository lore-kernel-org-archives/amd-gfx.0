Return-Path: <SRS0=l6GN=4A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76222C2BA83
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 13:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 480432082F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 13:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXbc92BD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480432082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7D7D6E0F0;
	Wed, 12 Feb 2020 13:53:39 +0000 (UTC)
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com
 [IPv6:2607:f8b0:4864:20::b43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81AEC6E0F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 13:53:38 +0000 (UTC)
Received: by mail-yb1-xb43.google.com with SMTP id b6so1105092ybr.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 05:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wBV3Lr612Yw8It6cmcc2VadLyutKR7fPcNV9O7rEgSM=;
 b=iXbc92BDGn8EuO9WZQHciSdpeq4z6KMe6qXHvha0g1Gn96ZvKkOoXeEo85r6YWL4R2
 JBlVcyzoXuzKFc/ioEWjyFIZ5V4JRB2tI4sOd87S6IMXehVhgv+CBgpU7uj2SqXUCwnk
 EVMNjSDVnMobzyp9gsNZ0j+akQ7ALBslNHcuY59T1o7mq4qCecA9QkF5zc36ffownGAU
 EW3uZtqa250d/Wj1a4yv8v967Huz4GQSwjM8L9B9GemEuoZ/kbawfkoXAWU+zd/1eX0g
 GnEukVI6Cc7F2qULtHoJb5ZZsOBHd3Cs8Eusf85+vjSAZYWBMy6BQvfO8VyHNcCIBbT5
 u/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wBV3Lr612Yw8It6cmcc2VadLyutKR7fPcNV9O7rEgSM=;
 b=deRT0vAQXpL7hSu+TRvm8IFAZbtKxSUKFy7q/T+1wtPpNZISIgmKPU30+c9716HmZV
 iHQzsXbtwvD8fBn0CyImBdpgZKWDTXDsOicgLVXpAHyfCRcMyN78Oegj962FPkjzXxyA
 oNwY0LIfwddTDMaDmwtbMaoWd6QID22rAC/+i629iwENvTWic6cimeYWuoTus8oG/4Zg
 QdOKKJxcL7bKWOgsysalJ7AgB0WQHgGGBJRM+qQ0VpmAXE4y6/1DgI7QG8Qtn7manFzG
 XfBLZ9Hx46o4ed6l56/bL6wn5uDYfo5t8YhKR5tA+NQLGDeKEkZwKB4gOeSbLr7I46NT
 yMiw==
X-Gm-Message-State: APjAAAWIpOn3IBPKryLtxZJvDQL3k/m6HFgrWBHeVJ7v4MUJEygkOPOD
 6vRzB3gn/juJLKPTKenMiFGPbe+K
X-Google-Smtp-Source: APXvYqz8uiLFTLZD6dYiqdl+2vk3d/MKTaytlkvfgQXDIrPFOY+63uCKy7HaTnpqYOX7xo2dLFGIOw==
X-Received: by 2002:a25:26c6:: with SMTP id m189mr11465659ybm.33.1581515617525; 
 Wed, 12 Feb 2020 05:53:37 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id j184sm185309ywa.39.2020.02.12.05.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 05:53:36 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/gfx10: disable gfxoff when reading rlc clock
Date: Wed, 12 Feb 2020 08:53:26 -0500
Message-Id: <20200212135326.1165548-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200212135326.1165548-1-alexander.deucher@amd.com>
References: <20200212135326.1165548-1-alexander.deucher@amd.com>
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

Otherwise we readback all ones.  Fixes rlc counter
readback while gfxoff is active.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 4e25b39ac14f..0eff2e7d33fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3924,11 +3924,13 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
 	uint64_t clock;
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	mutex_lock(&adev->gfx.gpu_clock_mutex);
 	WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
 	clock = (uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_LSB) |
 		((uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_MSB) << 32ULL);
 	mutex_unlock(&adev->gfx.gpu_clock_mutex);
+	amdgpu_gfx_off_ctrl(adev, true);
 	return clock;
 }
 
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
