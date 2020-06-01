Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EAFC433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F66A2073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AabKN/N3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F66A2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1943E6E338;
	Mon,  1 Jun 2020 18:22:08 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F34DE6E338
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:06 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id l3so485673qvo.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CSpmQAAaVsylHU0coaBxAwUCoDbUOQ+gZhi3JCMfh+Q=;
 b=AabKN/N3cuPVoUaTsPvRWOPmy+j9HSlTyMi8K0Btj0xBX6INyjlIDrVg8bDgw1KWlK
 RSe4zMrGK/x2b9TzhNmyuyBBx2B3NFSGSDRxM/FbqlVGMJWi4SQhgbhZBcutRCNZOp8G
 uEJaHN11c6i5uOKBwrAiNiRCHaUE7JwaDmcHSWzn3BCdrqKta3+tP4SAE773toGw1gSy
 DC/9XxzcOiDFmg7phdR5XZuePPe4jtV135EDMDrhGgkDwdg3tCmLrB89U7tKyG65LNGx
 E3n67zFOpv//ZaMuefoTrV9AlQHdoCGjXZi1PhYt1t/izHYx45oebZDNK1OqDvpLWUiC
 QQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CSpmQAAaVsylHU0coaBxAwUCoDbUOQ+gZhi3JCMfh+Q=;
 b=EFWRjW0wNM7jIY4rvIdF8QgBVz/oi99PZzAnIl1C2VlmZklRAhNQdiLj5YRBkU3Cau
 YJDvpKtS0sWHm8jvjJNDjzTEujhdOEvyX2T9dS93VG5jCO7qg8Bi4ngIg800P+rQ3/XP
 c/UogbqZh6dFr44vW6VqD5AIzMkx7jyf+ekWrTcsqMiFXocyrYMIBd/DTh0BWZff9D+r
 iu4MRcQw3sfJaDb0LFDK7HnMFc/DQHKVobkEZ2rIpT6MNXtPXEcDRQBa8YKroQRUt1mL
 bc4d2oa1nWGg7cyJb3LoACuegIn2FXPlRsgjBiD4Rm30vLyRhCxPYY3FFbwS23by43Kf
 bfNQ==
X-Gm-Message-State: AOAM532fCz6pDe9DyZaIyOZk6AHGPlf4fP34auOb58tyO32JYXft3v2r
 XTMH+FJDeqGW5V+WNc4HJw6TvAsb
X-Google-Smtp-Source: ABdhPJxpVuHiYnJBqXEsjoYXN22oYbnVc8Xlz5vrI4rl19CdRBitoRJuIDkqiTHNksmZSCuXzoegbQ==
X-Received: by 2002:a0c:e7c2:: with SMTP id c2mr22670130qvo.118.1591035725977; 
 Mon, 01 Jun 2020 11:22:05 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:05 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 137/207] drm/amdgpu: update golden setting for sienna_cichlid
Date: Mon,  1 Jun 2020 14:19:44 -0400
Message-Id: <20200601182054.1267858-48-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Update golden setting for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 6c52363d5662..8935b9b81d68 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3104,7 +3104,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER8_SELECT, 0xf0f001ff, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER9_SELECT, 0xf0f001ff, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x01030000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffbfffff, 0x00800000)
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffbfffff, 0x00a00000)
 };
 
 static const struct soc15_reg_golden golden_settings_gc_10_3_sienna_cichlid[] =
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
