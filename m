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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B82CC4727F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF2342399A
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBkDI7x8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2342399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C5D76ED5D;
	Fri, 25 Sep 2020 20:11:13 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 211DE6ED13
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:08 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id 19so3100235qtp.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VE+FJj85L5N7J2s/AP1JfWuSqMPiw/pQONGJQssRQFs=;
 b=BBkDI7x8gMEcvLw/+VdHOwMsVm2rd07/jviBiBM+w9hTxU2CAYZ6otySdZci0DJOQv
 Tmh6NHlR1QM+CK+6PxM/2T3FA7bgkImpN8H23K2uYyIgOXogFGHM82oo12C4b4viQScS
 1wUBjvGS8P/0lWqNSfI922yd+qYeEA2vfvZJsP+OlSG/Ee70JaQhHVqbAFpl2FEKtENC
 FlQN6XXMajcxG2Ei57nb587fbYdjLQxC7kjDEF6oeJTO6+lUuzYHLYnz7WK/DDvK1McG
 d9lyV83yadX5O3s1muPwnsUbV3XaxsxDYt7EyZwh3uFNCo7KolRqAL8SMXwOdF4ihWA7
 Xk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VE+FJj85L5N7J2s/AP1JfWuSqMPiw/pQONGJQssRQFs=;
 b=edVxxsNV73/efGhVvLZv0KmZBzIcsRj4NelgdR/V97TXKyMVGvJGy47azUjbtKcm26
 5BTCXyCWQ3aunlKsPbBHQFREONS/FTw3RmfLbMYdn8uTPWAJ1bX9lTf+Mgswc4pFJiMn
 XPrtjbKde7tZHgPAhtSjox5esP8AhTj1o2eZa3k9quy5Tj3fr7njmO854HGQuyGN/jrH
 r/w9oSt4EpnMXDz1eIRsP+DAJI3uIRkKynirai4ZW3TzbBYQGDNJg5BvCdeuSiriTPJN
 mUM0pFU/h1xqfZJLfnBhTWMQgHHswsvVA8Y3IaY8d1oSCLGqpR8C0RmofQRUdz7DWcZv
 rlgg==
X-Gm-Message-State: AOAM532VOTQSs/oFQkgTXEUmNOJfT9FahNJ1b+FpwXPKY+DprmLWkQjw
 HwAEqUMfUDRfxjaNmw9j/Y5hN/dU6Ws=
X-Google-Smtp-Source: ABdhPJyk9rXYK65qgEE29jn2MnGiP79H7w/145g6K2f66jLasMHgy6tU4rMT2qA0RwLY87lgtPjWaA==
X-Received: by 2002:ac8:39a7:: with SMTP id v36mr1542940qte.140.1601064667089; 
 Fri, 25 Sep 2020 13:11:07 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:06 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/45] drm/amdgpu: add van gogh support for ih block
Date: Fri, 25 Sep 2020 16:09:52 -0400
Message-Id: <20200925201029.1738724-8-alexander.deucher@amd.com>
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

This patch adds the support for van gogh ih block.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 74b1e7dc49a9..ce4a974ab777 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -314,6 +314,7 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 			switch (adev->asic_type) {
 			case CHIP_SIENNA_CICHLID:
 			case CHIP_NAVY_FLOUNDER:
+			case CHIP_VANGOGH:
 				ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN_Sienna_Cichlid);
 				ih_chicken = REG_SET_FIELD(ih_chicken,
 						IH_CHICKEN, MC_SPACE_GPA_ENABLE, 1);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
