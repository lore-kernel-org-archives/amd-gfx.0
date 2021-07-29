Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B423C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 13:56:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E659260EB2
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 13:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E659260EB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 349C96ECE4;
	Thu, 29 Jul 2021 13:56:15 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C456D6ECC5
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 13:53:21 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id t21so7015572plr.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 06:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aAVeohC8Zb1P0slBgD8gi8FAQTZUN+m4NlZ2IA+vPgY=;
 b=D7dBwGXnI2eVSbvlw3qFJNGjQtW5IG2lZZRruwfT/w/RrjRheUbtR3rGbGDgryTXIJ
 HO0ljZXha58uKgGsu5XaXaN+hyE5KrIeV5fbaPgx7+JFn/NuNQ6Vo1qf1iw6bvqaEx33
 KlAUMkDe+ODsDTh1pFOOwYB6KatE5cPbSeCmt+4cJtfLnoHds38Si19YSGniA+8dOujO
 QngF9SH+boXZbCBtXDA7RPNILqdbXYVgQCY9FSBy5DQwloYEguA/HWawlc/E7Xz/wJQe
 f9yJqTSYCeePNpNou8cSXKKyxTq4zJYdT0RgOc0XN/LZJmuTc5q7rEqrknXIth8PShkP
 GN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aAVeohC8Zb1P0slBgD8gi8FAQTZUN+m4NlZ2IA+vPgY=;
 b=Z6iinrBvky+KO+/EruL2BeqgrgbKhrbwV7auqdln2J4XY6dW70UJshyeBqa0Y8eKgu
 RFISFKi8X5m6ofhUHTB4MxCvJRSFZt3ibPE6RqGszmBmI9znR/uqWqfEBADMteI333ZY
 VV84p/nq3H2AAmzg80DcCjJHZ5PsHARLb9gk4kOGVuTYNenesWOv8J2G2RcKEkljS5oz
 tZKGPpSUqtC1SW7yt0PHuOqsnatAKYt6W2F0Gyi4gQ5m0veSeYPz4bYBIc0J9aa8i7hf
 Q5shJ/Fp631cCVRZbqFyUOP86HZ7fl9AGTI4YOBumOJy8abEJxM1clr1nsrgxPsvaMP4
 dTKQ==
X-Gm-Message-State: AOAM5314ae9yKTS3l1gqCU1UPaRzXaw6R/ZLw9F+Wp44IgX+ww8zz0Jp
 cnJWyN2AOfLxEk/TWmN1jTM=
X-Google-Smtp-Source: ABdhPJy2KYe7jP/YHWOgw5zxo53AaWMW3fc9FKhCkHdrgoN5i8sINMlUSYVw0N/zRRxMqAMi7r+zWg==
X-Received: by 2002:a17:90b:514:: with SMTP id
 r20mr5415108pjz.80.1627566801437; 
 Thu, 29 Jul 2021 06:53:21 -0700 (PDT)
Received: from masabert ([202.12.244.3])
 by smtp.gmail.com with ESMTPSA id e16sm3406155pja.14.2021.07.29.06.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jul 2021 06:53:20 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
 id 58177236056A; Thu, 29 Jul 2021 22:53:18 +0900 (JST)
From: Masanari Iida <standby24x7@gmail.com>
To: linux-kernel@vger.kernel.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com,
 amd-gfx@lists.freedesktop.org, rdunlap@infradead.org
Subject: [PATCH] drm/amdgpu/powerplay/smu10: Fix a typo in error message
Date: Thu, 29 Jul 2021 22:53:14 +0900
Message-Id: <20210729135314.661858-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 29 Jul 2021 13:56:14 +0000
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
Cc: Masanari Iida <standby24x7@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch fixes a spelling typo in error message.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 43c3f6e755e7..7dd92bdf7ffb 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1580,7 +1580,7 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
 		}
 
 		if (smu10_data->gfx_actual_soft_min_freq > smu10_data->gfx_actual_soft_max_freq) {
-			pr_err("The setting minimun sclk (%d) MHz is greater than the setting maximum sclk (%d) MHz\n",
+			pr_err("The setting minimum sclk (%d) MHz is greater than the setting maximum sclk (%d) MHz\n",
 					smu10_data->gfx_actual_soft_min_freq, smu10_data->gfx_actual_soft_max_freq);
 			return -EINVAL;
 		}
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
