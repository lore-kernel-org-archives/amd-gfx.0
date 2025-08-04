Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E18CA0EC0
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 13:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0557A10E53A;
	Mon,  4 Aug 2025 13:42:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MTSUT2J/";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 390AE10E54C
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 13:41:59 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so38560675e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 06:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754314918; x=1754919718; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Idoy5WwLKWF+SBzDY9k8s7PPcESyZCL2yK9T80XtUqU=;
 b=MTSUT2J/WGQ8nZNn8kpQeXhYIWk7tc8yq0gyqdlyVfe3mNqyjqPA3vWUazUOe7vgM0
 05SYHrFm5zSavQ8VYkfQ5q849whnfroSa8kX35SckjygOv/jDoLhWUbekQSWXohfOwvD
 Rd9lrM46T04rWRfQOuVwXUnawSwAr26BNTAvhDXC9GJXkFookH2MBqXXGGJqElpmLUpl
 QZJaSOyFxlUe2IrfObv89FT1YxYPmL+MrUnXTYuzIGPw/qwKH1yAv+HOyJOCmpPezNwT
 mSODEiBzKV1u7sqK2TJnhwIi0T4dlG/i9nFF/Bw6sxNzFrvOqh9TsmO9XfaN5YlKZqcU
 ZFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754314918; x=1754919718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Idoy5WwLKWF+SBzDY9k8s7PPcESyZCL2yK9T80XtUqU=;
 b=KvDd3ybWkIA6GOO0708MccV7flpNuanRim0WX1Jq5diIR12blwjqtOllDvuRTeZa3C
 CxhnP+rAa8eqq8+txfrGGSSUO7cMVHvMgEhq7N59+ih4rzP+zFDNzm5FQ7z7rFkKvZw+
 XypTh48q32Mx60h5aQA584pwlFa3Ckqt9S5wl3j4RumDh/US1gVISw6GhYA1Uibm2c4b
 vFKKVaSXgR8j5HnUg2k544euWqm1u+eVB+tvoYSQAAQOH+iNLaDXCUyg81ltFclXknOH
 jSdmmpX+O0mN20J0r9XJ6dtR5AU0wKxViNoIehxCRz8dPuqHFa47BtYe9r84UVM5MFf0
 HFew==
X-Gm-Message-State: AOJu0YxrkkkMJnSLFfd0heWgq+jKoLWogY7e6MXS4fxVdVw1VbX6AzSX
 MtvYQTL91o5VqIN6T7rgTbcR28IbHdDv1zR/tbUed4Q2rzCGW4vFSq5aiAMrTw==
X-Gm-Gg: ASbGnctI3p8TgEZ0V9y3CZMO+26PVPOM8T9qYkzoipRZJtMB/fXkH7njOZ6OAVqnokY
 uqzlpVJdrl5INIcaU+YjnCIsxMiHABEI27UHhDiIYAfY21PP8IFH5E29mgIWvRi+1b5XuOHkoVE
 nJi02boVKtGJP3A7yR8kqF43KcU8LwUrVOuZTVfSWV3JU9ylGYKibVimv6an2KKvphiw01++4j8
 2SBsjtovQh8ApQGV+lilrXbylimPP8ijFw+8Nx3/1gNi2k5W9Y4NOXQrryThS11KFV/f3YaItc0
 nZEJVm/Pk/PmREDqhOAJiZvVSf3Rs0PKb3aOCNK44rvVuCkgB5CRF9JBS5RHMHvp03TuyShZU/O
 o4z/s6euQfWLsFwaC3Wg0g5eR3RTDsU0UxKD4rKq861BuZDcXkcHfp//Qcc//P4tjPjWVZNglf6
 h1d84yN18gX6Of8h8qdhgSKGV914oAHIlk7wvY
X-Google-Smtp-Source: AGHT+IGhgENgPrFMkZOOo7xCfujzJs59/G80uHn0SsUcASYg9YgGPzybduF1dO7yFBc2qMq7Ed3hVQ==
X-Received: by 2002:a5d:584c:0:b0:3b6:46d:fb70 with SMTP id
 ffacd0b85a97d-3b8d9486654mr7237167f8f.25.1754314917464; 
 Mon, 04 Aug 2025 06:41:57 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24DABD00A4734C1D2078832B.dsl.pool.telekom.hu.
 [2001:4c4e:24da:bd00:a473:4c1d:2078:832b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589ee621adsm172056395e9.30.2025.08.04.06.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 06:41:57 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/6] drm/amdgpu: Power up UVD 3 for FW validation
Date: Mon,  4 Aug 2025 15:41:49 +0200
Message-ID: <20250804134154.95875-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250804134154.95875-1-timur.kristof@gmail.com>
References: <20250804134154.95875-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Unlike later versions, UVD 3 has firmware validation.
For this to work, the UVD should be powered up correctly.

When DPM is enabled and the display clock is off,
the SMU may choose a power state which doesn't power
the UVD, which can result in failure to initialize UVD.

Fixes: b38f3e80ecec ("drm amdgpu: SI UVD v3_1 (v2)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 5dbaebb592b3..9ad06c1e150d 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -633,6 +633,12 @@ static int uvd_v3_1_hw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 
 	uvd_v3_1_mc_resume(adev);
+	uvd_v3_1_enable_mgcg(adev, true);
+
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_uvd(adev, true);
+	else
+		amdgpu_asic_set_uvd_clocks(adev, 53300, 40000);
 
 	r = uvd_v3_1_fw_validate(adev);
 	if (r) {
@@ -640,9 +646,6 @@ static int uvd_v3_1_hw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 	}
 
-	uvd_v3_1_enable_mgcg(adev, true);
-	amdgpu_asic_set_uvd_clocks(adev, 53300, 40000);
-
 	uvd_v3_1_start(adev);
 
 	r = amdgpu_ring_test_helper(ring);
-- 
2.50.1

