Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E75C77B73
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 07:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A43E10E250;
	Mon, 22 May 2023 07:20:20 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6398B10E16E
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 May 2023 13:41:50 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-38c35975545so3190871b6e.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 May 2023 06:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684590108; x=1687182108;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QDjL71PEC6Tb+XtxTyBLheXSk1UAk9Ru/+e5aEBaUME=;
 b=jBrxFKg2cKrHx/DouwqP32x7wpJiJU9aigiEjHeTTqgp4UPiC/eAtJQllwFa5z6uC0
 EdjiNsZrLqCKLeLd4alN4n/NLZGYw04QrKgaJNvV9YsCuRVGTJP3TAm4U1j3ZnvZDDKJ
 zgL3SDSrjnD2/Il3oDnStv492zzBKHglXwWVi1SZmH2fjgaF3GA6ukEUn0Cv+k4rSQd3
 5DCqAj4syCcuaWfcQiihHBj58RFQh0DP7hwq77I9Gq1SRur5azsA+d0whoZyjwdBb6cu
 VpRf+ctb2iHGWjTeCBeOLGfIZO6AdPqo1UDARxVfqmCkDemdBfC8AY8UOX26hgDWK+O0
 lzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684590108; x=1687182108;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QDjL71PEC6Tb+XtxTyBLheXSk1UAk9Ru/+e5aEBaUME=;
 b=kW96UZSS7AubqCrFAgUOVN2Ic4GeRd3EScjXhJKsg5VtQ1BShSbuHNXW/WMTKu9D/f
 66p6csJ0e5NPr3uttM/Q4F01RHnsygKTLTwByX77P2IlmkTECACOR70aD9pIauHc2SGA
 EZF3JrpodWDT4I4x26kMsShqsVmCBWI7919a02Phttl/jDjPgvk7Hm2qFcMr7RJ9T3Bc
 wX7lJc78ufrQUvZBX/LTuMIAf4qsCew4+ZA8D7cCjZ6F0SCw3Z+BwYvN7rrRcrAP33rY
 NM8/uF7+r838mQPIT/nJGO2p99eeRaMdSGTfKjDo9ORHzn6OdQ7ZLGPLKALkjG2oS9E0
 bJWQ==
X-Gm-Message-State: AC+VfDy4nTwi07bRYfGScKfoEODbmhxCG5MQB+I5+dcnpHPDuXBCEhuD
 lljrwJBk5hGTNNWa6muNT97tt384Z90Lmw==
X-Google-Smtp-Source: ACHHUZ71lN59Rpri09NQzDWxkLeu7s2m0KjQiJj18LqcT4nmmGRHukcZ+05VT7dEqLOuuPTXANe5hg==
X-Received: by 2002:a05:6808:8dc:b0:38e:c2a4:3530 with SMTP id
 k28-20020a05680808dc00b0038ec2a43530mr2704094oij.9.1684590108154; 
 Sat, 20 May 2023 06:41:48 -0700 (PDT)
Received: from toolbox.spo.virtua.com.br
 ([2804:14c:1af:8457:4af4:4759:2c9e:18c9])
 by smtp.gmail.com with ESMTPSA id
 c14-20020a544e8e000000b0038cabdbe3a7sm617356oiy.3.2023.05.20.06.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 06:41:47 -0700 (PDT)
From: Jonatas Esteves <jntesteves@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: Fix output of pp_od_clk_voltage
Date: Sat, 20 May 2023 10:39:52 -0300
Message-Id: <20230520133951.172823-1-jntesteves@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 22 May 2023 07:20:19 +0000
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
Cc: Jonatas Esteves <jntesteves@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Printing the other clock types should not be conditioned on being able
to print OD_SCLK. Some GPUs currently have limited capability of only
printing a subset of these.

Since this condition was introduced in v5.18-rc1, reading from
`pp_od_clk_voltage` has been returning empty on the Asus ROG Strix G15
(2021).

Fixes: 79c65f3fcbb1 ("drm/amd/pm: do not expose power implementation details to amdgpu_pm.c")
Signed-off-by: Jonatas Esteves <jntesteves@gmail.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 58c2246918fd..f4f40459f22b 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -871,13 +871,11 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 	}
 	if (ret == -ENOENT) {
 		size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
-		if (size > 0) {
-			size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK, buf + size);
-			size += amdgpu_dpm_print_clock_levels(adev, OD_VDDC_CURVE, buf + size);
-			size += amdgpu_dpm_print_clock_levels(adev, OD_VDDGFX_OFFSET, buf + size);
-			size += amdgpu_dpm_print_clock_levels(adev, OD_RANGE, buf + size);
-			size += amdgpu_dpm_print_clock_levels(adev, OD_CCLK, buf + size);
-		}
+		size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK, buf + size);
+		size += amdgpu_dpm_print_clock_levels(adev, OD_VDDC_CURVE, buf + size);
+		size += amdgpu_dpm_print_clock_levels(adev, OD_VDDGFX_OFFSET, buf + size);
+		size += amdgpu_dpm_print_clock_levels(adev, OD_RANGE, buf + size);
+		size += amdgpu_dpm_print_clock_levels(adev, OD_CCLK, buf + size);
 	}
 
 	if (size == 0)
-- 
2.40.1

