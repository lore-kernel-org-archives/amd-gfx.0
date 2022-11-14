Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8CDC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Nov 2022 01:57:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 613A510E35F;
	Tue, 15 Nov 2022 01:57:04 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8293010E343
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Nov 2022 23:13:46 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id n205so13119247oib.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Nov 2022 15:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uZw4zTbszAqZMAVQgIrACApePoZPvNVewr/Ag05BY6I=;
 b=EqRkDQ7x0/2Mtgkve4O1/JC9JSkNvzidedyELGp2wVGtcg7tdtdpY3J3YCUMcS/byC
 /TK9Yw7Cjug5cZdu7qgk+41vxekL8G3d/WbR3GB9IaY0x/wPHZgEy0zdyUW0OuJgEpp7
 k0u7BCKfBZMY4trmE4IMOXQB4+et12e7x0ah3ATChIOKb4GjQhW2xo0P0u9tLW2Kes9A
 7yP/ba+bql1ZXQbUOV6QQegm5ZHIKB0phu7FLP0Xk5yiPh0z0l7vyw77O3lEii/JUNwx
 IqG08vMcEnySYgyVEY3md8iLzynbueMxhW9rZYqRV63EFEesU+mVqyURf3J4URiEwyAG
 7NKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uZw4zTbszAqZMAVQgIrACApePoZPvNVewr/Ag05BY6I=;
 b=H2vdQlPsuRz/8mj3awImy0LQnJCyDW86HWjF6By0duk6pLOHJ75T6VRuEaTd7iynHG
 Ki7Wpc/zDXEIIU1ZVmtdUu8wQgZQdLXMp3tZDBmyC9zEJ4izNgus5MIt435oTEH/+BES
 GMAQSCfXer2mRr+l3MDF1O5747vHURk+4231kXVIQbV9S2XItYs1eHeEglBauPmfLm6U
 gFNG8hvSrc6ch50SZPaYaYRr8x75jcvReKgnoT3eQ80F9X6DcTEsRDLsx7neQ4twCZxA
 kF489JKzgM7b/tZ5uaXOgxpKAqjpDRRYuAV1jtvMoQTEVKozO4kTLCeyX08AlMmw0LLs
 nnBg==
X-Gm-Message-State: ANoB5pnhvqQT8ndxqBzHPyCnjjK+RczNu0BGv0QVlWddndYCZRZEWQ56
 7Gfeo6DbFMX5gLXL6rCC12WA6aIIvM/7tQ==
X-Google-Smtp-Source: AA0mqf6IzzS9vBb9EWiBj5sQSIFCGaccj3vNuTsVCo8aDoz/qsv4/dKDvEkbYE8Na1+9QUn7qWcBtQ==
X-Received: by 2002:a05:6808:17a1:b0:355:51ec:36c9 with SMTP id
 bg33-20020a05680817a100b0035551ec36c9mr7104561oib.245.1668467625355; 
 Mon, 14 Nov 2022 15:13:45 -0800 (PST)
Received: from toolbox.spo.virtua.com.br
 ([2804:14c:1af:8457:8708:7bfb:88c2:95cd])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a056870538c00b0013ae39d0575sm5617135oan.15.2022.11.14.15.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Nov 2022 15:13:44 -0800 (PST)
From: Jonatas Esteves <jntesteves@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: Fix output of pp_od_clk_voltage
Date: Mon, 14 Nov 2022 20:13:25 -0300
Message-Id: <20221114231325.18698-1-jntesteves@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 15 Nov 2022 01:56:59 +0000
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
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 236657eece47..9d364bbc78e1 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -869,13 +869,11 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
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
2.30.2

