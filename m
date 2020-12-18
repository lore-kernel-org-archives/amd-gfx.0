Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EFBC4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 16:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CBB423B28
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 16:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBB423B28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C149189829;
	Fri, 18 Dec 2020 16:54:11 +0000 (UTC)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3FFC89829
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 16:54:10 +0000 (UTC)
Received: by mail-qk1-x730.google.com with SMTP id p14so2581144qke.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 08:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=B32lwGGAXP02bc+XBjUl8C69eXlpzaa3a1x2e8JrMM0=;
 b=RZ3zmcOdyB1RbrkWtebOmDtb3/ojcEAOOWdrfk/4IaA5RoJ2PhDWdesm9MQ42fusXJ
 hxFPPbbYL+6zSy5xIXdKqD/0h6QqYtwifZI4sA+my9vaZw71xBLKH+IAwRamoRgsg5gP
 yxiGvollQ6ZD55Prsm33RxKBIn6qu/LlUdq6IMkOV+uNN3zYBB+22CqULL3GZkrm11MV
 j6+0XQS9GHpwV3ZE+jBtRLqy9F6Fa7rLltfuhZesn+7VIHW7icyD0MZk4JXKZ8jC1led
 DclEi8nnpthJ7NrTu/SYkPvrmEmruKekOjuZk8HyKVvpzFC4W66mLKpinNWyegsEHb8J
 Sn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=B32lwGGAXP02bc+XBjUl8C69eXlpzaa3a1x2e8JrMM0=;
 b=E5QD5WdNN1jLJlKnwFtU+s6sdwc+Q4tfeWu0sMeG6/oJEauGlhK0XusOsPnUzvqp/n
 +5k2jASN9XqhXuLyKAHzao+FRCrKtmJ8BYw/0ll6mYWRpZtvL8L9888QAvYiYUQhs9Z+
 b701OZuDy34GPzmWLb3G1TrdegY1mET5rY3xqY80JzHktQO8idatf6rPEevESXpK2W0e
 hYs4Y22px20LGHQ7CvFTqR37aCyPBqEnauRpkKcaPiYjFT8kcl7XV/YQtsI12fB6+WSh
 Hb7aOarw2dkw7N0XfOJ4+Jzt4GAc8ZiQqVHCeNLeitZo51d71SNA1rq5DbSYy9hreObM
 Ea3A==
X-Gm-Message-State: AOAM5304HwZLcJu96tRRmW785Xjl5OA2wkSQFnmekp62XrKazCafv/mQ
 JHowiyNExod3+cwC+jpCT3NV4nY7aXA=
X-Google-Smtp-Source: ABdhPJxQeh1U8C+VdaGmcJ9s1WNzayOhzHPIA5W7iDKc1l/2YCQqYk/vtPOy04q/SCybls/1f0TruA==
X-Received: by 2002:a37:ef10:: with SMTP id j16mr5653004qkk.129.1608310449979; 
 Fri, 18 Dec 2020 08:54:09 -0800 (PST)
Received: from localhost.localdomain ([204.111.139.145])
 by smtp.gmail.com with ESMTPSA id b14sm5324905qtx.36.2020.12.18.08.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Dec 2020 08:54:09 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix handling of irq domains on soc15 and newer
 GPUs
Date: Fri, 18 Dec 2020 11:53:53 -0500
Message-Id: <20201218165353.35509-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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

We need to take into account the client id otherwise we'll end
up sending generic events for any src id that is registered.

We only support irq domains on pre-soc15 parts so client is
always legacy.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index bea57e8e793f..afbbec82a289 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -444,7 +444,8 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
 	} else	if (src_id >= AMDGPU_MAX_IRQ_SRC_ID) {
 		DRM_DEBUG("Invalid src_id in IV: %d\n", src_id);
 
-	} else if (adev->irq.virq[src_id]) {
+	} else if ((client_id == AMDGPU_IRQ_CLIENTID_LEGACY) &&
+		   adev->irq.virq[src_id]) {
 		generic_handle_irq(irq_find_mapping(adev->irq.domain, src_id));
 
 	} else if (!adev->irq.client[client_id].sources) {
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
