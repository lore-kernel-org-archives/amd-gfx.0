Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FA9C2D0BF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 14:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 274BC2053B
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 14:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I995icmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274BC2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E630D89D43;
	Tue, 17 Dec 2019 14:55:22 +0000 (UTC)
Received: from mail-yw1-xc43.google.com (mail-yw1-xc43.google.com
 [IPv6:2607:f8b0:4864:20::c43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8639F89CDF
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 14:55:19 +0000 (UTC)
Received: by mail-yw1-xc43.google.com with SMTP id h126so4045498ywc.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 06:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rZsu75NBfWTx14ro0HiJsxtsj38IdrsYfX6/ARdL+PQ=;
 b=I995icmoHUqSDfckNkkTFfYONlkyBu3Q3o/FZ/fG21p5upyeHyD1W0Z3zVg7SZROfe
 /R7qOGBxDAaHXLjZIw58W3ihikR2P70W4abC8GRQdxU8pF6hw+jypizPQ2s4jnp+exhS
 g59s1MVqQs6m8JhuA4x++O//Fmhre/5QWmjDgMf4yBL6fSDt5I9Fg6F/dDV2dxXYhkPI
 LxAcfsIglhucywQqhkXB8s0qfGsmUhtNoCR6YwrLAtcvRydKvz/NzD7T82ofN6/KjZai
 8gmqGcdbsFDXcJfB0Bv1uvok5ixEXlyBczFT4v64ceYe7zZDk7BQT5gDnGwxC2u7l3iZ
 jafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rZsu75NBfWTx14ro0HiJsxtsj38IdrsYfX6/ARdL+PQ=;
 b=HsA7fpwpaKbJV7MRHZRK2Y0j9wCAWXXh3lC1Z0EA+1TtRyaXkh9My+gh8Kja5ufXdN
 yXhEBixevvAzuKepdp5WLnhQreK4paxrYB6oz3pJuO/S6zpeyU2lku1blMvkJKzTvMHT
 /dsmu1GqyF/DeTxwAgSO5ykLlf6tRgEVu5eM+WIgFTXxi/A8nE+fVWQNV1yr/PX7ABmu
 Eyb0euPS53mzH3WhnryiQID+iqzsuW/5PdEgikbyKIwyE9ECZk5t3cwyc3VO91GmzAtk
 xgqCxWlmLgEN3dEb2pExgBRIDg9XmDAE3GYPdl2nU1Ooy2puieAT52d+c6P4aOtw1IME
 dEXA==
X-Gm-Message-State: APjAAAVFUZL9wnsg7Iz18l5mK5FBwbtlV9TI9NL3V/zmijXJl2tDexft
 7yNuNf+ptcIZ33O8WH3ppX/KpIZl
X-Google-Smtp-Source: APXvYqznXlGHgSA7ixKN/Zj74yjYI8qd0InyiLj0tPvc6rBZQlZDcEnsyUMLj7eM2A0Ymx0eled7aA==
X-Received: by 2002:a81:70a:: with SMTP id 10mr22541105ywh.362.1576594518530; 
 Tue, 17 Dec 2019 06:55:18 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id j11sm9978146ywg.37.2019.12.17.06.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 06:55:18 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/5] drm/amdgpu/smu: add metrics table lock for vega20
Date: Tue, 17 Dec 2019 09:55:05 -0500
Message-Id: <20191217145505.1319348-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217145505.1319348-1-alexander.deucher@amd.com>
References: <20191217145505.1319348-1-alexander.deucher@amd.com>
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

To protect access to the metrics table.

Bug: https://gitlab.freedesktop.org/drm/amd/issues/900
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
index 12bcc3e3ba99..740cf62e74f3 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -1678,6 +1678,7 @@ static int vega20_get_metrics_table(struct smu_context *smu,
 	struct smu_table_context *smu_table= &smu->smu_table;
 	int ret = 0;
 
+	mutex_lock(&smu->metrics_lock);
 	if (!smu_table->metrics_time || time_after(jiffies, smu_table->metrics_time + HZ / 1000)) {
 		ret = smu_update_table(smu, SMU_TABLE_SMU_METRICS, 0,
 				(void *)smu_table->metrics_table, false);
@@ -1689,6 +1690,7 @@ static int vega20_get_metrics_table(struct smu_context *smu,
 	}
 
 	memcpy(metrics_table, smu_table->metrics_table, sizeof(SmuMetrics_t));
+	mutex_unlock(&smu->metrics_lock);
 
 	return ret;
 }
-- 
2.23.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
