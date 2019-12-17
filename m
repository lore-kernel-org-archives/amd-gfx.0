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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2577BC43603
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 14:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC17E2053B
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 14:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UflOCDBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC17E2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B299C89CDF;
	Tue, 17 Dec 2019 14:55:21 +0000 (UTC)
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com
 [IPv6:2607:f8b0:4864:20::b42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AB7289CD3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 14:55:18 +0000 (UTC)
Received: by mail-yb1-xb42.google.com with SMTP id i3so4474993ybe.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 06:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MIz/oS2ZbeuWAGeZSP2dAC2C7OWTmsDuzlzEETOlymw=;
 b=UflOCDBNcP+FLG/whwddr1JZe11BwplTopb+oAUEB6OzOKK/NczPiRWgsTtl78wSwJ
 XdqfOTPiztc7ASBAfbm25up207iFmFt7ByGm/+6R6Trp0wNZI4ktD5LWZJxQ/KecXg/P
 d4yz3E9X5cE0uxZ7kEB2L+6VuBGpOKWssL44HmIRbPieje/mwENLT8Q5rbGRnlP5/Kit
 yjJZfUFsA+uxuD5pNgw8pJCwnwoIy61knJpiVqp8XyOmZc/L0J0eedgkN467Y86pdvvU
 KouEiAHjZvTpFUTB0mroH2hGUHtyCU+Ws62Bl/QBeBJtyRDhhQ11DFPKaE/uiSz1IO+4
 Cf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MIz/oS2ZbeuWAGeZSP2dAC2C7OWTmsDuzlzEETOlymw=;
 b=AddiZGbJaFLv6fw5FUB/moxhVfWS0PUTnohFoY9s6EYl7O/EvwsJ+ksAzXZsARNiPY
 r+lzH3uCnOF9DI4HgzfpSE1uxtqQn+qxsVVuIRn4cnSZV9wic4pt6xi/jtKtHbbmMoxH
 xwN/IToocpR62LiNEdBsLDFcKvjQTQloyzaib9lUxIn1mZwyuicMtLR7OAW4t+W9pAEo
 HZuSltL6t9NSr7+N+/fpDx0d6bNWNSHNhEDrE0OS5za19ct/CmQ4BJ87aZh3KFyL/9ML
 svD30M/9sceoMiLzqg48kQNDHfMW3LwQtVRs5brh1BI45GFo2CZTqQpL0aF+NC4WlAb2
 zNug==
X-Gm-Message-State: APjAAAV+wYwRMGBnydLfCNoNFYBLgxYLEaMkhNSj0WLR5k2JHQOGFCfO
 HtKaGNKWcV7/zqF++Yk7VSJ8OKv6
X-Google-Smtp-Source: APXvYqwavGyrnN09AHmL07o+PKGgQfN05Ldbv4QY4YCvk/oUujjvQmfW7bIm6rT8htPciZ7i9OUspg==
X-Received: by 2002:a25:8684:: with SMTP id z4mr8814798ybk.396.1576594517655; 
 Tue, 17 Dec 2019 06:55:17 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id j11sm9978146ywg.37.2019.12.17.06.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 06:55:17 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] drm/amdgpu/smu: add metrics table lock for renoir
Date: Tue, 17 Dec 2019 09:55:04 -0500
Message-Id: <20191217145505.1319348-4-alexander.deucher@amd.com>
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
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 81520b0fca68..8e723022be3e 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -171,6 +171,7 @@ static int renoir_get_metrics_table(struct smu_context *smu,
 	struct smu_table_context *smu_table= &smu->smu_table;
 	int ret = 0;
 
+	mutex_lock(&smu->metrics_lock);
 	if (!smu_table->metrics_time || time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(100))) {
 		ret = smu_update_table(smu, SMU_TABLE_SMU_METRICS, 0,
 				(void *)smu_table->metrics_table, false);
@@ -182,6 +183,7 @@ static int renoir_get_metrics_table(struct smu_context *smu,
 	}
 
 	memcpy(metrics_table, smu_table->metrics_table, sizeof(SmuMetrics_t));
+	mutex_unlock(&smu->metrics_lock);
 
 	return ret;
 }
@@ -239,8 +241,7 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 
 	memset(&metrics, 0, sizeof(metrics));
 
-	ret = smu_update_table(smu, SMU_TABLE_SMU_METRICS, 0,
-			       (void *)&metrics, false);
+	ret = renoir_get_metrics_table(smu, &metrics);
 	if (ret)
 		return ret;
 
-- 
2.23.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
