Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69CDC4345C
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F9DC223C6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMasEKg5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9DC223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5568F6E854;
	Tue, 14 Jul 2020 18:24:46 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78F446E853
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:24:45 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id 6so13610737qtt.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cCS7Y3wCq6DBaUJMouyE7ilC+D6FRTmnXjGYe6tG0i8=;
 b=eMasEKg5bDdn8vBLXtZvJJsd6DvrK7icojR1HMXyi7RJprw0s46oRWJFLbJ1EE22TY
 4PaYan0RuSffSXP1G+tZXt542QIFlUTWmA1UJTsrhT/Fl3vqrSDwRkxZ/Nw8mqz9rzq0
 gQw/Dtun8xSeucPMxVfWmASltrfWHcTSRkfVlDZ/HcwE7Qos2yrnpSkfD8Q9Yegx+f9Y
 Q7kwV/5r8pANUV2e9P7vh2OviqRpyodU4lsNs45JbxDorjedX9FH2FbeGxBpmuMLwpCG
 RyVw8G/OTXjDkGlswVAy6+eszNFLmC7t1BKZdLzM1e24lHkOaPzH0FV0Yn81+KobH0CP
 DV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cCS7Y3wCq6DBaUJMouyE7ilC+D6FRTmnXjGYe6tG0i8=;
 b=uZOLN1TRjDDAY4sYO0A5/zhQ/QX/cOHQ7a0ZvaCZiQ1MM12lCWj2NCruOdWOUXz/cG
 hXmZcUYDrUcP/FXGffUIp2hPtLRYoIPscEv/9794vkSR6k+DozIsLW0bFfQTnfIq/FcH
 cIa0lipUcR7c0A/KgOIj/J+tfsmY2rK/Fl3/xe3v2ojZ7FcAXa7HN/OnevG6j49NP44u
 uEsTyCOnlaeEgQfKmwH4/BCinYmlpW+ydmnyZSlDbmo9VfT1tQCgSyuoWegR16lq8PSr
 KDUb3y4Dekjd9EL6L7UnizHyg7XlObx64DVbeHZElAdckWTrnyVlgGTw7bBFCwP2Kzue
 mRHQ==
X-Gm-Message-State: AOAM53111WsfHe67O85gEzCI2cuH3kfJmmma8a859ll6A5EhRHvCzIvP
 k3l15/ksLFHidsqcp2qgjCjH1DSB
X-Google-Smtp-Source: ABdhPJyiQpiXnW8b8ZEzD48gzVvfWD1Cz9/nQ8LiPXRII08/+HK+NmwPzle9OSWmdRC+CBWt8mxfDA==
X-Received: by 2002:ac8:48c9:: with SMTP id l9mr5811826qtr.203.1594751084488; 
 Tue, 14 Jul 2020 11:24:44 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:43 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 27/42] drm/amdkfd: Add kfd2kgd_funcs for navy_flounder kfd
 support
Date: Tue, 14 Jul 2020 14:23:38 -0400
Message-Id: <20200714182353.2164930-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714182353.2164930-1-alexander.deucher@amd.com>
References: <20200714182353.2164930-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Chengming Gui <Jack.Gui@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Add callbacks to KGD for navy flounder.

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 82ac1b4886c7..4bfedaab183f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -74,6 +74,7 @@ static const struct kfd2kgd_calls *kfd2kgd_funcs[] = {
 	[CHIP_NAVI12] = &gfx_v10_kfd2kgd,
 	[CHIP_NAVI14] = &gfx_v10_kfd2kgd,
 	[CHIP_SIENNA_CICHLID] = &gfx_v10_3_kfd2kgd,
+	[CHIP_NAVY_FLOUNDER] = &gfx_v10_3_kfd2kgd,
 };
 
 #ifdef KFD_SUPPORT_IOMMU_V2
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
