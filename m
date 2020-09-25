Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C738AC4727E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D59D2399A
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+KCJuAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D59D2399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C0CB6ED58;
	Fri, 25 Sep 2020 20:11:12 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E6C86ED5C
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:10 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id k25so3087151qtu.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9w7D2OHeUwidpEGmBmMfuYOTci6ib6I90EHLrGp5chk=;
 b=J+KCJuASEng9gKebPsLalkaBGBdmpsRAzC9KUnUHtj2aTzzvHhyB58ai7ITWCwIdgR
 BeN6L1C+mqwUYF6KNDtgDZc9ai7MCdkOKCztrANJbJYyI7Z1lmvsh/u66RlHeVq3HxJO
 NXXCuxxIbYqGXeU4eIlfYqznaXrJLcTfelG+DmyO1tTROWd2YhAuDauH5F/BKew0OAnI
 VGedfkP48W8XQ6vxWylKdq1T7kP3HoS6E1hrAunb3s6fJlyvC94x/1a2FYDAQTgaa18g
 V+L1eUzvdl7lxgWycCEdD2vcifJscGKVjG2hdI3WfRrHJZIfsekxS9pK8CA3hlt6TOBM
 M06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9w7D2OHeUwidpEGmBmMfuYOTci6ib6I90EHLrGp5chk=;
 b=KS56w4s7Yoa0GoYCu4JfsGqlSBFq5fF95m/CaXESejaTxbwXDxxffKup1T03UQE+iN
 JXUUsIImGD+FJcFdGx4HU+VAx0WBi/L8buBJRl+2V7F8QCrighblj94AsKFlW+FQBEiW
 qwk13Fy5WCxoUTDWtr4+p87GOCK2TkniTNQ+k2cJ7c+g+OVuw7oyI0QzQQq2kXlApNfM
 Jf9zfFZGEbWtOZ9OJ84hLvzfxf9jG8McJDyPZhRugndpHwGUEeAn+eVgWDfgekcV6PLW
 bg89Nq/Atj5g7f9twF5YCY3YDiZyDx27VDrcdkkip53+UZVscNRgHzhwoG9AA6MjqEOT
 A85w==
X-Gm-Message-State: AOAM531OsCRQPRwXFG5DeB8gASLo+DF2Icxwk6SzcYqG2hhUCrB5Jb/4
 2jMdnjg3K0FNMx9b6yFTDZw2jBeO52c=
X-Google-Smtp-Source: ABdhPJwXC8+UG4ACneAG+G6sX4PGvO6XEYaP3v1XvUP9p6MQPTK1c6ZY26wYAhLgLYGG87eIwJCdzQ==
X-Received: by 2002:ac8:4658:: with SMTP id f24mr1463701qto.158.1601064668129; 
 Fri, 25 Sep 2020 13:11:08 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:07 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/45] drm/amdgpu: use gpu virtual address for interrupt
 packet write space for vangogh
Date: Fri, 25 Sep 2020 16:09:53 -0400
Message-Id: <20200925201029.1738724-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200925201029.1738724-1-alexander.deucher@amd.com>
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

The interrupts are not stable while uses guest physical address (GPA)
for interrupt packet write space even on direct loading case.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index ce4a974ab777..b66414998c90 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -661,7 +661,10 @@ static int navi10_ih_sw_init(void *handle)
 	/* use gpu virtual address for ih ring
 	 * until ih_checken is programmed to allow
 	 * use bus address for ih ring by psp bl */
-	use_bus_addr =
+	if (adev->flags & AMD_IS_APU)
+		use_bus_addr = false;
+	else
+		use_bus_addr =
 		(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) ? false : true;
 	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, use_bus_addr);
 	if (r)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
