Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B76C4741F
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 15:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87342207C4
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 15:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYOMDvcN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87342207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 919FD6E4D4;
	Tue, 29 Sep 2020 15:28:03 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A0A56E4D4
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 15:28:02 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id k25so3848014qtu.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 08:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vXflWJBXxnXxCtcmLMPp+SgEVmB3JTbSpdHQat0hcbY=;
 b=fYOMDvcNd/DC7jbPjZQC3QciJYFLwL0eV3ioSQOxOaEW2eLrFESmqbLmav86G4LaPP
 UAmhRIzjuSaodZoRXkwgFWruSx8XqZGEsTS4nq+diXMR0YMlhrc9OxGxn4/9AlY96hwB
 Fb/2wYXEz0FPVl2DCEXMfeBn0mrA4mtnCTq7Ij5OOq2s5/ZcYL0sULNw2QTArOk1kbvZ
 nGyYWkRnYC59QZcMchPnEQGo9hoyIchfZNFmYdTWWyAWGziALAqNhIQNbZ2wYGI3+6uE
 r14xgg8pMea2BxQMEvG5fIuND/KTGYn9jYDy/rxVoXHakt53DsahjAM+7esly0Md0pya
 RzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vXflWJBXxnXxCtcmLMPp+SgEVmB3JTbSpdHQat0hcbY=;
 b=kGUxsOqWTclPhEl0jobzAD9gOL8XjYaNE8B/nIiYF/iZuhHfEVVUBhLHXoL3f9i82u
 uyfzmg6GAKL+IXtW+qyWUqPcYmCDUTJFk2Hi9iXnmzTHrpMWn2nQmG2N8xzPj87mvWZE
 lq6l70/epwSBFIS45SvuAbDlj6QBKKSjVS++RAJ9nC9PWTDQ/sn6Dw2o7Hn4Jlip1mkf
 lhwpagtVWY39BDELn7lM5XPeCQJduLtAZyPI7v0Nc5b21Ul0l61n7gm7pA7gL11xlI/G
 N8ZsAAoR8oEg6QMN9zRcUdbLWB+OYbC/PshOvwEwCKnWHtbRojvfeQ9VX+0wDVu3IttS
 BhbA==
X-Gm-Message-State: AOAM531wbCZF6mccK8UmpwuzorXKuob9S1DEn7q5t2jQswfJQrfddezi
 g3KeCG7OuLQungSaln12N+Q3NEurlVM=
X-Google-Smtp-Source: ABdhPJxbLKbsqafuIELcXQWjclEnRgANNuEelyiNoQmdTA2jiTk5vOCRp6Z3MczuOLBO9qj/8S7UDg==
X-Received: by 2002:ac8:7650:: with SMTP id i16mr3956774qtr.268.1601393281245; 
 Tue, 29 Sep 2020 08:28:01 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id r187sm4669007qkc.63.2020.09.29.08.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 08:28:00 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/45] drm/amdgpu: use gpu virtual address for interrupt
 packet write space for vangogh
Date: Tue, 29 Sep 2020 11:27:48 -0400
Message-Id: <20200929152749.2442370-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200929152749.2442370-1-alexander.deucher@amd.com>
References: <20200929152749.2442370-1-alexander.deucher@amd.com>
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

v2: make condition more readable

Signed-off-by: Huang Rui <ray.huang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index ce4a974ab777..53ea83c08e8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -661,8 +661,11 @@ static int navi10_ih_sw_init(void *handle)
 	/* use gpu virtual address for ih ring
 	 * until ih_checken is programmed to allow
 	 * use bus address for ih ring by psp bl */
-	use_bus_addr =
-		(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) ? false : true;
+	if ((adev->flags & AMD_IS_APU) ||
+	    (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
+		use_bus_addr = false;
+	else
+		use_bus_addr = true;
 	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, use_bus_addr);
 	if (r)
 		return r;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
