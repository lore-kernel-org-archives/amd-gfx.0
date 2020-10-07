Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17395C47095
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:31:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A21AF2064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0amBKBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21AF2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 307C16E23D;
	Wed,  7 Oct 2020 16:31:48 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE7FB6E0F7
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:31:46 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id 140so1739945qko.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bxMQLBbp8vlf4bMgdrcty28KgZAA4Y33TAXakKIT8GY=;
 b=K0amBKBPmL4D8nJ7tHmNyXKHIiCWzNcWXRqx1kz5+twmoJXaVsRuZQqsw2oQ35F2lm
 CkHntQ03IYhU3irXmxUQRuikr58YIQkjTTQIR6blO91TiVNX2WEUvLPanF44mTEbAoQa
 6fpYI07lkjlihO+Tz3a/u6g8fAgKcqNpN0LW1RgYsEchUNColUUr/3zk8o46JXJWCT2o
 swHPq5TzE9LGvowSpHpztRxIl0r2zgJD1T14lZwNChzSLSW4kwSU3lanta/7NCk6aT4e
 D3GCAago8ohnTIg4gxf+svsUQ/qEk6LMqSwSIFl7Qu/g4lOONbZ0XiiXF69gRDWodbgO
 ntmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bxMQLBbp8vlf4bMgdrcty28KgZAA4Y33TAXakKIT8GY=;
 b=TiGyIpSPkpnfMDGo9FFT2nou5/RNd8Vj745Y7+YueMmqQnoNwud85Bppoxrsi27lpG
 xQe+vWbSR6eD4j/bKy0Ym21j1kd1jRMqD0/ZP3p11OP3Qg63NTcN16Ml/McfwJMXaIhH
 4XXouXwFwbBUvgik+O9yLPurfpPUQ8YDxQIHqG3Q+eCwhAdN0O34GfdUfkPAgsRTQhic
 5QhYjyLWeBH87Y48lInv22QFHZSNXjBnTj76RDrpGN65IUL8SI72Cp0gsRxzhApIt4Kx
 HnFwt9Lm0xPIvxftZ5YA95Au9CRLC0z1aMGwKQB2m1i38TPupXz73aWpAs8iAjwwmi1/
 ohGw==
X-Gm-Message-State: AOAM530ZhReudOTMJAHRIe8fNYb1qVT+wxB9/GR2zD3rmCYJj9CoNtym
 d1XTvbvkUiZl0IWAL1oeQl6RUbBKcr8=
X-Google-Smtp-Source: ABdhPJwVxl6ycrsKHFBzE1tHG49pCjnM3vhNy+Sn7zlnm+wiCpU0c7cvbadjn6psdaDYIY7drzBVTA==
X-Received: by 2002:a37:54a:: with SMTP id 71mr3407409qkf.407.1602088305884;
 Wed, 07 Oct 2020 09:31:45 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:31:45 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/50] drm/amdgpu: add dimgrey_cavefish asic type
Date: Wed,  7 Oct 2020 12:30:46 -0400
Message-Id: <20201007163135.1944186-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201007163135.1944186-1-alexander.deucher@amd.com>
References: <20201007163135.1944186-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Add chip type for dimgrey_cavefish.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 include/drm/amd_asic_type.h                | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1cd1b9d8bc4d..0aef7ec21f01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -116,6 +116,7 @@ const char *amdgpu_asic_name[] = {
 	"SIENNA_CICHLID",
 	"NAVY_FLOUNDER",
 	"VANGOGH",
+	"DIMGREY_CAVEFISH",
 	"LAST",
 };
 
diff --git a/include/drm/amd_asic_type.h b/include/drm/amd_asic_type.h
index 6d01cf04b77f..cde3c8c9f20c 100644
--- a/include/drm/amd_asic_type.h
+++ b/include/drm/amd_asic_type.h
@@ -57,6 +57,7 @@ enum amd_asic_type {
 	CHIP_SIENNA_CICHLID,	/* 28 */
 	CHIP_NAVY_FLOUNDER,	/* 29 */
 	CHIP_VANGOGH,	/* 30 */
+	CHIP_DIMGREY_CAVEFISH,	/* 31 */
 	CHIP_LAST,
 };
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
