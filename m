Return-Path: <SRS0=ij9B=3O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DBFC2D0DB
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Jan 2020 18:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F29DD2071A
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Jan 2020 18:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UstTMPwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29DD2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACCE06E8E2;
	Sat, 25 Jan 2020 18:33:32 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83E326E8E2
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Jan 2020 18:33:31 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id j20so5546118qka.10
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Jan 2020 10:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Xui/cFvjG12J6fSCpItmVCyDY4ZPXzRAK7FtzZyxscY=;
 b=UstTMPwOaf7WFNnapPKrhs2wImGCA+zXHrPZ9m3LpUmVaJR8JNI9I2oUJlWAi/H2Ss
 VJ11nHFY1jUrYrY40xHDqsYnznyCXCcx1/Wm90pyuP+KQhyXErwFeqTPQ9zMEJeIV8NP
 QRedQ8RvQZMnxAFDhXhejkSBySTVq1mOPTvzHB1Qyh5CXsd7MPGY1P0mOh8PnB47Uatq
 W1qwkkWxUiAd0q09xexi2vMdybXBEJrS/SsoUsDbtA4QaoWHWEPGutMmw1fhdsLj87Bo
 fSOWxQpHYzaSqYDCAE9CdHAwQioxUjO1vW3NJiRRuf15PBgtGvVzv5/DcMpAjfP7xh5X
 jB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Xui/cFvjG12J6fSCpItmVCyDY4ZPXzRAK7FtzZyxscY=;
 b=DPW4e8hDUNIuz+MkfZGS5+dspFEIFkPZscBkqYKBFcFlMyGuIQK5Sms812SygzW4nq
 ADyW2sn4DZZsKTzPmfLumU3Txcbsgk4MOoTTq+g/VTLIhxV+9cdFt42uLPy30BxdVmog
 HxeCz9qsM4U1iTBu46rsHZOP1slp0m8gjHHxd96ln2m97oBS4MszNlylLvfhN92+1Lty
 tPIjog7i9VJbNGsMJy3T0vS7Y0Y33u+3xfSDyxWhgtseEU+WKZvrNAo6vykdoH1QetQQ
 huhl1zxO6jCbMdfU8ooitN8OnXoVx6MYfZ9sSMSriq9Qi0bHpSe06gSKLm+xUj1sx5me
 CH4g==
X-Gm-Message-State: APjAAAWZCx8YibvlVXJMoseB43yt4Hp6Z58eOkX7orr9m4lxbzJMClw+
 65HrOF34ju5YZwEGwLAOzDx6qMo7
X-Google-Smtp-Source: APXvYqxSyf1MBmDYq2oYwoRtymPCgB7H7Rs2qOZtjB/O22OE0JCVvOKPfM/IliaJhZZWEFPZ7pzCvg==
X-Received: by 2002:a37:905:: with SMTP id 5mr8556987qkj.404.1579977210301;
 Sat, 25 Jan 2020 10:33:30 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id y26sm2111395qtv.28.2020.01.25.10.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2020 10:33:29 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/navi10: add mclk to
 navi10_get_clock_by_type_with_latency
Date: Sat, 25 Jan 2020 13:33:21 -0500
Message-Id: <20200125183321.2315-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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

Doesn't seem to be used, but add it just in case.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 015f5ea38901..f60762f9b143 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1008,6 +1008,8 @@ static int navi10_get_clock_by_type_with_latency(struct smu_context *smu,
 	case SMU_GFXCLK:
 	case SMU_DCEFCLK:
 	case SMU_SOCCLK:
+	case SMU_MCLK:
+	case SMU_UCLK:
 		ret = smu_get_dpm_level_count(smu, clk_type, &level_count);
 		if (ret)
 			return ret;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
