Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F07C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 20:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00F4F22CB1
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 20:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F4F22CB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FE2B6E226;
	Fri,  4 Dec 2020 20:44:48 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE6FA6E226
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 20:44:47 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id v11so4912385qtq.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Dec 2020 12:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mGHly5aEmV+bKYF+vsd65fpcr0QkOtwtXhQbE29hj5I=;
 b=vEAyN8lJhdZvH619uyRKjw4GyRC5l0VKiwRcuekVu9ntxfK9kcqL2VH44nUv1yOdse
 bxC2u4hxsok+swhWdnzoBROZfWURK2uUYJOng4M/rlgqNEDdTG15eQLxYKQSi4Wq994W
 I7AJGdu6uwFnNHPp9QSNPpcQrYXmzZZvPT4mDGkvcDprOG/6MBxvmQFsNgDQzYdRUS2i
 MU7jy+0/RtIBglLVl6qgq7AIz6d8K6O4+VSrUKwJ6qsceKI23B5UXzq9YvcKbYiXC9G0
 CaQ1aOOyYnQZ8qHHT4SDcW2AjdUb9yPrjFld7qQslf6AF1Deb+/TD4h7aVUuFMJGraQ7
 rTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mGHly5aEmV+bKYF+vsd65fpcr0QkOtwtXhQbE29hj5I=;
 b=twZ9Ggu1KfhPNcV10hCZI2wsUWE06FyNIL7HFmiFENVL73wwduK7y3U0XjK8iA1O/g
 lRtU3R9n087/zhlhz8ZI1Q9rJFmWQVtkPor/44+90Or810FojSE+DNh5TOzJYRekBveZ
 6nSlTOpN3yBKcIYjT6B9K5Q2WgU9r0yyfdfST1lNPBsPrMaTkPr5PRKDPIig3IFMrqTV
 bZ1whUAsJuznk4p3Eh7PwwNCXDrq2Ag/As+X7kbPGUxwAfrTDw852lv8EBRZuKFup4PG
 oEgjUaOUbD3PlHipicHmWY7rkKw2n9ZcwMOyQu0uoLz98tZ5ijR0hkvobC6mJpuRuIhN
 eUWQ==
X-Gm-Message-State: AOAM531lbCda5YrK3uuXXuJD4fA9FL+efw9O7zF/ywpSt3Av1Ydvhurp
 3bT9e61zj0p+C1FrWaehtFjX6qaiA7Y=
X-Google-Smtp-Source: ABdhPJzNuqGy6PoS5SvPqwe7dRD+9NU8/cRbHPIoMzWUyu9GaCcUnxAfcv4BOzBE7QqeS6qnACTXkw==
X-Received: by 2002:ac8:7c83:: with SMTP id y3mr11247603qtv.201.1607114686770; 
 Fri, 04 Dec 2020 12:44:46 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id o13sm5646581qkm.78.2020.12.04.12.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Dec 2020 12:44:46 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: enable runtime pm using BACO on CI dGPUs
Date: Fri,  4 Dec 2020 15:44:36 -0500
Message-Id: <20201204204437.3845-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201204204437.3845-1-alexander.deucher@amd.com>
References: <20201204204437.3845-1-alexander.deucher@amd.com>
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

Works using BACO.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 705b65353c75..daa89bfe25ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -163,10 +163,6 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 	} else if (amdgpu_device_supports_baco(dev) &&
 		   (amdgpu_runtime_pm != 0)) {
 		switch (adev->asic_type) {
-#ifdef CONFIG_DRM_AMDGPU_CIK
-		case CHIP_BONAIRE:
-		case CHIP_HAWAII:
-#endif
 		case CHIP_VEGA20:
 		case CHIP_ARCTURUS:
 		case CHIP_SIENNA_CICHLID:
@@ -181,7 +177,7 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 				adev->runpm = true;
 			break;
 		default:
-			/* enable runpm on VI+ */
+			/* enable runpm on CI+ */
 			adev->runpm = true;
 			break;
 		}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
