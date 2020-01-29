Return-Path: <SRS0=fmWI=3S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E480C2D0DB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2020 18:01:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C5E1206D4
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2020 18:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FI11zZ4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5E1206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B9D089E11;
	Wed, 29 Jan 2020 18:01:43 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0605C89DD3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2020 18:01:40 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id g195so68727qke.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2020 10:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/AX5SIWmveyNDwwxZFTOBj/Pe9QepHmy+0fUCBeNEWM=;
 b=FI11zZ4QSnz1Efo57J1WNSP6kxm6IVmPewt1EvyJfD19yLUD3OE3CBChG0MaREpHWq
 ZgiTSUTblEmoFeFS+5/w8JCE/YDz0XCAE2N7rMOGtMwhcxeOqERFYzYEKKfG9U4NgbOA
 f0Gi7g3fN3C5rKmPPsdAP3apYye7xV6zqH0qHO7w5oAXxxWHp37McjzsCRNeM/UMIA+U
 x9Z4J4CcsIcn4nerYw4BzFKH0+GwcXG4+7CFnwTy94d6MrIwjRlR1pVbtWwyxlRZ8+ZQ
 W4dOlyiEoVTHyT0UDfc7xBKYTTONjfBAYTFVKRllMQ5FZjklMYKP1Z9lgSb0NzyYUAMQ
 nlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/AX5SIWmveyNDwwxZFTOBj/Pe9QepHmy+0fUCBeNEWM=;
 b=ViJ9NRUp8iEeMAvds0utZXhViIs7joEdmQkAgL3GBS/y01hEIEy5I32WKZGfuCQFJN
 5pCUsIztireRWMXFV990eayvRrZkL/ChijK8r7MnTo3CRgc/7K01exG5ndQgQKJaUPyJ
 DwRtuTB19FeYDHiisGrinketWEzOZ6aD6Y23Ln9Ny+iJ7WcaqLo+KSm42jju7VKlUIYv
 tY1w/jOBSkr6svi/P0Ej+qo3k0rd2DXgGp/qEgNVKa4Fvr/+3Lt+BsmdsvOx2ZuQl4FL
 NMjJrGqVyMnfX7WQRHtjNZlQgE52KrgQX8DLe3GRh/2DQ4fUhSl7O8zMB09j11Sl8XEQ
 TtIA==
X-Gm-Message-State: APjAAAXQH3ofo5+HeeznSPfdCjE7leEdiAh9gsdfpsClgrxlY8QK60MC
 ap67ihaArkIvs+RQ8ZNgbRkqhUFU
X-Google-Smtp-Source: APXvYqxkhVRSx4STulWOXS/m47bS0HPylDdFQGZSRsgOKcOwmWMya/nD4HszMq8tIofErYgWdhyEqA==
X-Received: by 2002:a37:f514:: with SMTP id l20mr846192qkk.421.1580320899960; 
 Wed, 29 Jan 2020 10:01:39 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id f5sm1322648qke.109.2020.01.29.10.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 10:01:39 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu/smu10: fix smu10_get_clock_by_type_with_latency
Date: Wed, 29 Jan 2020 13:01:29 -0500
Message-Id: <20200129180130.585870-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129180130.585870-1-alexander.deucher@amd.com>
References: <20200129180130.585870-1-alexander.deucher@amd.com>
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

Only send non-0 clocks to DC for validation.  This mirrors
what the windows driver does.

Bug: https://gitlab.freedesktop.org/drm/amd/issues/963
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index 4e8ab139bb3b..273126cfc37d 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -1026,12 +1026,15 @@ static int smu10_get_clock_by_type_with_latency(struct pp_hwmgr *hwmgr,
 
 	clocks->num_levels = 0;
 	for (i = 0; i < pclk_vol_table->count; i++) {
-		clocks->data[i].clocks_in_khz = pclk_vol_table->entries[i].clk * 10;
-		clocks->data[i].latency_in_us = latency_required ?
-						smu10_get_mem_latency(hwmgr,
-						pclk_vol_table->entries[i].clk) :
-						0;
-		clocks->num_levels++;
+		if (pclk_vol_table->entries[i].clk) {
+			clocks->data[clocks->num_levels].clocks_in_khz =
+				pclk_vol_table->entries[i].clk * 10;
+			clocks->data[clocks->num_levels].latency_in_us = latency_required ?
+				smu10_get_mem_latency(hwmgr,
+						      pclk_vol_table->entries[i].clk) :
+				0;
+			clocks->num_levels++;
+		}
 	}
 
 	return 0;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
