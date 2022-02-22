Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43763C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 14:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2DBB10E82E;
	Tue, 22 Feb 2022 14:06:43 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A57E10E627
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 13:18:01 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id q5so14402876oij.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 05:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=usp.br; s=usp-google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ayEiTJoQMQ+jcjp3UMRNd5LwLeFycUhnaRc8GdLvEdk=;
 b=Wqh8WVyaB3/ePOUVG3qDmLXtRM2V02SqDxNeuWJZyWdRv9S3nWuGPgBol8HVCWBq8s
 DhdiEThHMeaf3oShHr2vzPZEF1glAHISZfrq3028oU3ta8gBcyG3ZW7qCSSEyHOTI3lB
 BnxvSUxinY/c3tq9cibM8S6EyjPjwHVN8UdKR268Zwpzc9EZjOU39PEj/kwRRPUwIzMC
 TJoaaWdEK9eQzLpnFNJIlDEy9QqLPUYMg7l3IH3RF7db55PMl9T1tKhWeuWn2GGMES0C
 X+a0prpgsJLlkvgbGmBRL1Skefle02K+m9wUWk7PYw5kkYDqo0dRaW0HX71nR2+EcEzY
 Q1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ayEiTJoQMQ+jcjp3UMRNd5LwLeFycUhnaRc8GdLvEdk=;
 b=XtXPJPwZmh3LbE18oM+WcZqy2fRhihExy8hQR4leDKEaeOM3H/ualy8GA2bb9/APq6
 rSxXLtyuNytuqUon9p1lWgbOHcqiyUo9rADyvnyFn923fFViPZUfllRfyaZU752Jv4KU
 F4yaC5jnToG2uYwbw947NC9jNdwRET8b/wa2OR8CPB8aCclvEcamfJ9HHDbbBvsCGIRO
 qF/uzvY7EGcnJPb5PMPbICf+VVRoEdK1nOM+tzwDp5wKPMSrWfBMkL7zemBK+6mRdoUy
 DvkB2D+EpwcqWBPiIrAexTQGixXzFq5bvlz2k4ixsZGEHXoEgnkssVFST7KeXJf1V/zk
 dzMw==
X-Gm-Message-State: AOAM532ie0/tj8A5mYXZWPArdFY2PmLq+1Eo2QmZlWlAyea0vuHvLA2r
 9sZpGa+evoyqW4BddCIMnpktYQ==
X-Google-Smtp-Source: ABdhPJwWSQJbsP6uAkrMylNazH+1ImSjAqTPKRnK19++tCqd6JrQXsgHYiKgvyoSEEmR6fmGiVSzTQ==
X-Received: by 2002:a05:6808:f0f:b0:2cf:3d64:2333 with SMTP id
 m15-20020a0568080f0f00b002cf3d642333mr1897906oiw.23.1645535880803; 
 Tue, 22 Feb 2022 05:18:00 -0800 (PST)
Received: from fedora.. ([187.36.236.204])
 by smtp.gmail.com with ESMTPSA id c9sm6325050otd.26.2022.02.22.05.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Feb 2022 05:18:00 -0800 (PST)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 Hawking.Zhang@amd.com, john.clements@amd.com, tao.zhou1@amd.com,
 YiPeng.Chai@amd.com, luben.tuikov@amd.com, Stanley.Yang@amd.com,
 Dennis.Li@amd.com, mukul.joshi@amd.com, harry.wentland@amd.com,
 sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, Anthony.Koo@amd.com
Subject: [PATCH 04/10] drm/amd/display: Remove unused temp variable
Date: Tue, 22 Feb 2022 10:16:55 -0300
Message-Id: <20220222131701.356117-5-maira.canal@usp.br>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222131701.356117-1-maira.canal@usp.br>
References: <20220222131701.356117-1-maira.canal@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Feb 2022 14:06:42 +0000
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
Cc: magalilemes00@gmail.com,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, mwen@igalia.com,
 amd-gfx@lists.freedesktop.org, isabbasso@riseup.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove unused temp variable from the dmub_rb_flush_pending function by
using arithmetic to remove the loop.

The -Wunused-but-set-variable warning was pointed out by Clang with the
following warning:

drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2921:12: warning:
variable 'temp' set but not used [-Wunused-but-set-variable]
    uint64_t temp;
             ^

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index fb01ff49e655..d3088836d4e4 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2918,11 +2918,8 @@ static inline void dmub_rb_flush_pending(const struct dmub_rb *rb)
 	while (rptr != wptr) {
 		uint64_t volatile *data = (uint64_t volatile *)((uint8_t *)(rb->base_address) + rptr);
 		//uint64_t volatile *p = (uint64_t volatile *)data;
-		uint64_t temp;
-		uint8_t i;
 
-		for (i = 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i++)
-			temp = *data++;
+		*data += DMUB_RB_CMD_SIZE / sizeof(uint64_t);
 
 		rptr += DMUB_RB_CMD_SIZE;
 		if (rptr >= rb->capacity)
-- 
2.35.1

