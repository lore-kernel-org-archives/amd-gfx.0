Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3E4C4167B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 21:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D721C23DE3
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 21:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D721C23DE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54C5D6EB72;
	Thu, 10 Dec 2020 21:45:40 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C89036EB71
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 21:45:38 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id j18so1306075qvu.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 13:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VEWsBhAB2DPdOwd1ORZITkKFsFwAfEyxwnxAkQnb29s=;
 b=iSfuih9wJODqM1qF1syFnwfh1L1ub6pGqZW1rRlE7/4DR/bi02s1UwzPRGxR62Wd5e
 fmn+McwxJP50SaNdpF1Jxhwd0mHk/Iimkdz0dgak1a5grOT+5NpnXX7DBJNP98lIdY0W
 4FqNPxewITPyVoWqDNi5wmZgzMlm2L/8h9SuJIT6TPKi5cqd58rsgfErFMA50pnVxEky
 M1Ql0n4ihzs+sht12nNI+VL0GCE0FGqFEZZKRrbGPHRXaH9V8odCaiNW1QZATmVWnTZv
 sd4xZfW3oerWSKtFT3AMde3V2MODWwQH2HRiitGdVJf3DDN2kywcmdcld9kHIjMyUuWd
 +GLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VEWsBhAB2DPdOwd1ORZITkKFsFwAfEyxwnxAkQnb29s=;
 b=TtYcjMjcPJ6McDqEfT9XSq/IwV93nZ4YNjnjiUZb5znd3LdQLFvygqaK5tjTOs3Ee3
 9LjeWcsj2eGVH4lOUk4YK0GOniPr3xIytYTN+WRwbU/WhATfdh8dVQLy3KJQnWTSUu+U
 xQ5/8YLAQnJbQGm2Ddr6zKMZMznu/BMoZRr4ci72geR8sT5MOprPnSEfW8pTSQJfKhJ7
 8ubnL4Y9OyJmQXllSlXpG7L9ZX/AY25elzNkeYBtGQV8XS7IwC8tamFeW1R33mVN1yXq
 2yOnx9aBUkPjrlF4wHLq0mahzT4tH6M5CkGcgxuzOvXJSbrOg5cu8aQvlX4tNQn4nf7f
 cUsw==
X-Gm-Message-State: AOAM531c2BN5jl1WXzuFMZqXIiH8Y2rg1Pad1AVH3mWAo9p1G+BJbDYv
 C7cfVv0B4k04fApUep01iYGU66xL90U=
X-Google-Smtp-Source: ABdhPJywPidhL+GmpPQoxA6cxR9FUqNUKn1BWk4YJaLI7Y6ZfgBnG4yn7bCpHDcqkOITrx+Vz4qWzA==
X-Received: by 2002:a0c:d80e:: with SMTP id h14mr11726778qvj.13.1607636737857; 
 Thu, 10 Dec 2020 13:45:37 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id y9sm4776989qtm.96.2020.12.10.13.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Dec 2020 13:45:37 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/7] drm/amdgpu: update amdgpu_device_supports_boco()
Date: Thu, 10 Dec 2020 16:45:14 -0500
Message-Id: <20201210214518.704305-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201210214518.704305-1-alexander.deucher@amd.com>
References: <20201210214518.704305-1-alexander.deucher@amd.com>
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

Change it to check if the device has ACPI power resources.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e243490462d8..6637b84aeb85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -229,7 +229,7 @@ bool amdgpu_device_supports_atpx(struct drm_device *dev)
 }
 
 /**
- * amdgpu_device_supports_boco - Is the device a dGPU with HG/PX power control
+ * amdgpu_device_supports_boco - Is the device a dGPU with ACPI power resources
  *
  * @dev: drm_device pointer
  *
@@ -240,7 +240,7 @@ bool amdgpu_device_supports_boco(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
-	if (adev->flags & AMD_IS_PX)
+	if (adev->has_pr3)
 		return true;
 	return false;
 }
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
