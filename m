Return-Path: <SRS0=HxPN=NY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFF2C432BE
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Sep 2021 07:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66115600CD
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Sep 2021 07:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 66115600CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1014789733;
	Thu,  2 Sep 2021 07:50:32 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D1E289733
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Sep 2021 07:50:30 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id x11so2341883ejv.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Sep 2021 00:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ptsiWmJ3REZ+TxIg9IEdN89n1Hy/1BXt2HF8envKx84=;
 b=JYavfl0AJh5+aLDmgMIc4nQjOfOzuVxVG6cNHfItv4QO+UqG90yqSCqLCevkxv06iF
 HxEPTTD9uF0MYr4b5UH2ju2u/ZQLpivWS9dI9XwcnPb8IeFBSsaePMZvTtVRYdqANjLj
 g8us6IAC2T4IghWbsxl7nGImmKcgY7hgmlqTtpFMvR3y4FGsTmVyi8D9mr0U8ReKpCjY
 Gk8E63rtboR760NvSEJsvqaj4sJ5LeZx2g2tAkxTPHiinW5WgwNtF9g1qmcbY4ZxBzWX
 4dl2ri0QilGyFloitN3D+5r+CThS9mPGNeGYXD1iA7qrergMP+Bk/3kKAIalbSADnztc
 Jxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ptsiWmJ3REZ+TxIg9IEdN89n1Hy/1BXt2HF8envKx84=;
 b=WmnEBBgLLhG4hk/rPdITwl+doou5ERJLLd3oav2adY5Jf/73WEww8l46/onU2sXG2O
 I6hvguU5fOLCI3ly8C+b5o/Trw2KUribwUuhGJgq+Ks54IA20nka4J1FVEGnoZVJLfVf
 JBr7RfNGn0rL9YD52cljFF9issCevs4aiIkF+g7OY2aAZJii5u/3zQ5PQrVITgCuIRH5
 KmWcxMwHZfslFa/yzpKCkYRU0Pxny3LFA5h8sQ8usgIgnlCUDc/b499sIy3SPL7P/TQP
 Q135sS7uQexbKE2o3UJkr44NKAU6rAkUtdiPN3/QOCXmN8pRJfLnCT6IEsvarG8m2eHL
 Ygqw==
X-Gm-Message-State: AOAM530KL8LwcYBSr0md6xmSNVFaN7R7DdZsPCapYl5l/ULn+KHbw9uv
 OZ5bY9Uq70RZbVXpK3EzIwTSR8SDWVM=
X-Google-Smtp-Source: ABdhPJzmYctG6jLLs+PB4OtBM0H4GiviJlsKcDsOabH7+hC5xvUrvvT8dZgJ1tdASnS8zERd7l7Qjw==
X-Received: by 2002:a17:906:7217:: with SMTP id
 m23mr2377677ejk.466.1630569028768; 
 Thu, 02 Sep 2021 00:50:28 -0700 (PDT)
Received: from mammut.. (c83-254-134-100.bredband.tele2.se. [83.254.134.100])
 by smtp.gmail.com with ESMTPSA id 4sm583002edw.45.2021.09.02.00.50.27
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Sep 2021 00:50:28 -0700 (PDT)
From: =?UTF-8?q?Ernst=20Sj=C3=B6strand?= <ernstp@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: Increase HWIP_MAX_INSTANCE to 10
Date: Thu,  2 Sep 2021 09:50:27 +0200
Message-Id: <20210902075027.8155-1-ernstp@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Seems like newer cards can have even more instances now.
Found by UBSAN: array-index-out-of-bounds in
drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:318:29
index 8 is out of range for type 'uint32_t *[8]'

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1697
Cc: stable@vger.kernel.org
Signed-off-by: Ernst Sjöstrand <ernstp@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index dc3c6b3a00e5..d356e329e6f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -758,7 +758,7 @@ enum amd_hw_ip_block_type {
 	MAX_HWIP
 };
 
-#define HWIP_MAX_INSTANCE	8
+#define HWIP_MAX_INSTANCE	10
 
 struct amd_powerplay {
 	void *pp_handle;
-- 
2.30.2

