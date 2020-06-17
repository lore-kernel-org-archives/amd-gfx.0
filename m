Return-Path: <SRS0=VPxi=76=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40DBC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 19:02:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAF942073E
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 19:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzSuUUFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF942073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 683126E906;
	Wed, 17 Jun 2020 19:02:26 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 667846E8E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 19:02:25 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id cv17so1551170qvb.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 12:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f+XPvBP9rlqohjm76URPiz83GkswNNwro03LWjPnZm8=;
 b=tzSuUUFLQWzaqpNFF54lN5Y6enex/fGxfJlt/cIlhzKHSDIJOszreh3mjn+yJQWD2B
 lRQftkHM/IqAA2/IEWkDaEf2+wSbAPUNR2jfNTxcJ/Nv1B5TvJtYuf2ScTW2CIUG1ADq
 L84AexKqces0HhhMm+knExfQyV2vlpT72mcyvEFDDcp2mP4Ii3gQkit5uro8aBhoyTln
 bn3xyNtdVSlb6ipsXWOU8w1ZA1owebxn5WAUHtMzFZuluLWMLPNM05YVp/UIgxM5+x1q
 7rj0uC4Esg4wwgAD3p2MPUyu2yedyjl/0tHyj5NMs8s205C/XJryjNuMeebzhPPRaH7D
 eq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=f+XPvBP9rlqohjm76URPiz83GkswNNwro03LWjPnZm8=;
 b=RyKzDDzSfzpmIp+n4GOJ7RgUqyfoSGGYu6RKsx28sKuLycnL+XP5ALAMWmbTU2nnbl
 Rl1j9s2IbO5oYvkQtn65fEipswzViVbY4gQpgcy2CdGRd6u0wJgQPg/iCWV9BOq/BZdc
 PA0q0bIFzFoFAte1bVZWc437Pw6bFxcSsUgfdHxzJhxDRjesakfunXwHzP64VoeL/r18
 umc1L2iMeCUQc+CAgukcsP/c4x7K7FjGh396iW5dxuFn86SmOUr9oOE33Oer2/JrR3QP
 jYz4EdPQdGuGwC9qSG08kz8bXkuVnihLFKq2duvblBY5HKOhDPdotAN+bzekDhSwGIEy
 2Lpw==
X-Gm-Message-State: AOAM532tpxjUn1W14ZqWUjcPbtK2+aM0JQq9SrVX12UvUuRPFPEUXI10
 Vmna82a5EqW7dYLpp5J98UIGwTcv
X-Google-Smtp-Source: ABdhPJxICANjF/iuJ3mRQd9WNwdxbCyqoHuGAPisWpgWcBOI6meXlszG3p+iU3dOPgKeneUWZPpIzA==
X-Received: by 2002:a05:6214:594:: with SMTP id
 bx20mr72257qvb.131.1592420544344; 
 Wed, 17 Jun 2020 12:02:24 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id v59sm705056qte.96.2020.06.17.12.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 12:02:23 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdkfd: fix ref count leak when pm_runtime_get_sync
 fails
Date: Wed, 17 Jun 2020 15:02:12 -0400
Message-Id: <20200617190212.3519907-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200617190212.3519907-1-alexander.deucher@amd.com>
References: <20200617190212.3519907-1-alexander.deucher@amd.com>
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

The call to pm_runtime_get_sync increments the counter even in case of
failure, leading to incorrect ref count.
In case of failure, decrement the ref count before returning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index a9a7f5aa2710..0b4f40905f55 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1116,8 +1116,10 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
 	 */
 	if (!pdd->runtime_inuse) {
 		err = pm_runtime_get_sync(dev->ddev->dev);
-		if (err < 0)
+		if (err < 0) {
+			pm_runtime_put_autosuspend(dev->ddev->dev);
 			return ERR_PTR(err);
+		}
 	}
 
 	err = kfd_iommu_bind_process_to_device(pdd);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
