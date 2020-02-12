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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7ECC2BA83
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 06:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FF5220661
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 06:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmdD1TJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF5220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77D2F6E8A2;
	Wed, 12 Feb 2020 06:51:14 +0000 (UTC)
Received: from mail-yw1-xc41.google.com (mail-yw1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 499776E8A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 06:51:13 +0000 (UTC)
Received: by mail-yw1-xc41.google.com with SMTP id f204so416892ywc.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 22:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lvtRr9O+SQE4yEJ8ub8megtgdbkObSt/mKrs5LZhIXQ=;
 b=ZmdD1TJx5wNhee3HC/5yn1GOdQtDCQ3Db02X2ZvkjlIqEvghaKrZU7Pz/616SclXj3
 t+TTtYw5O1AKiXE3jADkZLwmI/8sQVMVUzdxOAVbSCk0ZSRsFhOdgKGuo+8yQ1OVP9yd
 MrZGO7Gwxe3sv3SPsvUDEqvYPFBt3BqJu8JrN7trkVJdmJ8tWCwTYzyH2aN7bVUCGwBa
 1ENMnZ7KUwQM2wK4qWTgyrSCb3faPXlZumUWUJXmcipUwS/DMU5dK9vVs6ZwR1owpb/p
 aJGSkNZSksUkDvtQP9FJ0VEq0CwcgQVKLkw0lpnBvrDjdOiHBfw+j3clDPFojJ8KEA4o
 xnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lvtRr9O+SQE4yEJ8ub8megtgdbkObSt/mKrs5LZhIXQ=;
 b=I074D3zvJ0+8CsMAeSZaJHGyCjLU4d2eeH8NwqXlstQfIX8elw05tUKKswkWyuaIcP
 LSyYj28kGKHfYXQo17V01teDhYrzu6qGU33NDFTwi2G1Eak8UPRSMOWVLi5PMUGnneDB
 gpBfTW0RN9zHakrKzHi2aU0i3l2nTty5E7eAzHsRmMxAfLi6uZto1jltLHGbU0rnZj0/
 +J9KNmcQoc0ffDOVDj6ueJvBsPOwRfinLMRfyRxmpd7kPbVGzfOOkQTPt6s7bMpOYZx5
 679YXDTd+QDVZ80Z90x1H1k2jOOzVBoDm4VrDtB3w4OP0TpbcTDQXFL0hS5MbnvwoKvA
 oMDQ==
X-Gm-Message-State: APjAAAUa/YbtgIn47hosEE+CEL2bUWi8Nw2TtWtWO7xG8VIIbXY/UBIM
 9ciC+XHyESs9H4h5rnbp0Zb/ooxj
X-Google-Smtp-Source: APXvYqwilSwe6ukGnrWxeulz30B/33TfWbtYpVnQmxN1PuQzAH/FmerY9cIASuSmkiq3WrjG9E+fVQ==
X-Received: by 2002:a0d:d2c5:: with SMTP id u188mr8701516ywd.296.1581490272142; 
 Tue, 11 Feb 2020 22:51:12 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id z14sm2898847ywc.53.2020.02.11.22.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 22:51:11 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/soc15: fix xclk for raven
Date: Wed, 12 Feb 2020 01:50:54 -0500
Message-Id: <20200212065054.1144314-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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

It's 25 Mhz (refclk / 4).  This fixes the interpretation
of the rlc clock counter.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 15f3424a1ff7..2b488dfb2f21 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -272,7 +272,12 @@ static u32 soc15_get_config_memsize(struct amdgpu_device *adev)
 
 static u32 soc15_get_xclk(struct amdgpu_device *adev)
 {
-	return adev->clock.spll.reference_freq;
+	u32 reference_clock = adev->clock.spll.reference_freq;
+
+	if (adev->asic_type == CHIP_RAVEN)
+		return reference_clock / 4;
+
+	return reference_clock;
 }
 
 
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
