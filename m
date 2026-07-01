Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C5EC43458
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 16:17:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FB2C10F001;
	Wed,  1 Jul 2026 16:17:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FVGIUGxJ";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D868410F001
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 16:17:45 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so5935405e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jul 2026 09:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782922664; x=1783527464; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gNmKO7bTBHPEDNPCYgNJqNxmvpRc00WnpM/5JL11dLk=;
 b=FVGIUGxJxzAgg6FhfmY5D/1e9YXFUv/vORS0pywJLZs4gQXBSX5G8FAZHu+gI30w4d
 TP6Xq7WH54nbTDVbCuE/kJmcaLXMP0NqtB7mfNiS8DAVaerBp0sXR7ldXAz1Dujkyfim
 jqBbJSEodCIBypIu8Y91vyH5zBitrcp9eZ6kqql7F4VAt+yE2YEHyRlpSzaADcYQuOjY
 XG+lKMqp2x2UV2DebZFWVar2Kpz72yoPK/09ZIt+ZjnpT76PlSFhXq6GMiZ9siBvCVoN
 X7SBl2A/ae1Jw0lpjtGTIPZ8EauOuwcHz2Tt07qHdAJlPCNU6rqC50MTp23L3RaRkCIZ
 TmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782922664; x=1783527464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gNmKO7bTBHPEDNPCYgNJqNxmvpRc00WnpM/5JL11dLk=;
 b=A9ePR1aWZ2l2YebTr5F6ZyCYokdpqkJrWCb8zscDP42lRk0aQQW3onvnySBS2pky5M
 IulkO1ZdV7g7YczF+XiwJZDsihcuwUo0iNdY2Ozb1x4FQBqRVIF0WOO9/ESM0u/UQlB7
 wbcM3NWY/3/H20AxrGOAONowzuQC9aAm7d/nO6azLi6CaSrFa3r0u26jsKWtrAePSGWk
 6FhT3wsoEvJ6eC5x0xFhd3kG9c0rn8r+aBDGn4/TXdK7wqqKIgmXqtjw4KTJ7FOjCsfx
 cuePUQtKxdNzy8Nfl1FHORVBj+4d5gD9+2UvfLYVShEBls0SOAsRzMacvD1ffaURaCWL
 RwRA==
X-Gm-Message-State: AOJu0YwacLYLtRCqTVi5quJsOqP1j0XYFJraEylFZUFbGq9HcnzGDZ4R
 +OCZWsPpjn7XATTEuBj6+/ILCAYM7V2JSVgOgibOLiX/1GRTLcIby7dcvtHQbH8E
X-Gm-Gg: AfdE7cmxUWgQpWVl6tg/twE6TKu+RuWj40bKucC5Swgsclo2bBICcJiS1OezLDEpswe
 /dTRsdeXHjkVDcmDdZbTNgi3bfsWO6XoiJT7hHOh2CwHuw9ph40CgXXH2YZxqemnv1N1Odd9EHQ
 kpG1MRdhCigOWKEWtP1u+7Uun1wIoMbno1uKrN49g/JwiLsRZk1SWVoK6r6Vwp5bcqLEkLaJ/Se
 2PqEqfgZ9icN+RyeNazto/wMtPUmMpmZX/mCrKQ2IofJmXsdPWfUNvof4JYaRZv/r0dOsNsLhXu
 jHp5vNZGpQ7cdlyY/fd2kXYjihnfOhtnVaHD68s6xxX1SMUJ7Tuh5LvYFBJkW1XeIQCb7TDQSwE
 bnKqzQAt22p0JgeUgX7/rokYS81B51G7ekdCRcEMxB0JawkRBGL8S1iBDa56A8qboIT1SZcJ/Mr
 rx1aGHIGljYQ0K6bni
X-Received: by 2002:a05:600d:4452:10b0:493:bdde:e400 with SMTP id
 5b1f17b1804b1-493c2b38c42mr28614665e9.4.1782922664086; 
 Wed, 01 Jul 2026 09:17:44 -0700 (PDT)
Received: from Timur-Max ([212.108.193.106]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be81df2asm168812255e9.12.2026.07.01.09.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 09:17:43 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 09/14] drm/amdgpu/gmc12: Use AMDGPU_PTE_IS_PTE flag for
 init_pte_flags on GFX12.0
Date: Wed,  1 Jul 2026 18:17:16 +0200
Message-ID: <20260701161721.85681-10-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701161721.85681-1-timur.kristof@gmail.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
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

This flag seems to work around a "fault priority problem"
and is necessary for handling faults on GFX12.
The kernel seems unable to mitigate retry faults on GFX12
without this flag.

For reference see:
amdgpu_vm_pte_update_flags() that explains the problem
svm_range_get_pte_flags() that uses the flag on GFX12

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 299fe960b99e..c210e2463a27 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -644,11 +644,12 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 		adev->gmc.xgmi.connected_to_cpu =
 			adev->smuio.funcs->is_host_gpu_xgmi_supported(adev);
 
+	adev->gmc.init_pte_flags = AMDGPU_PTE_IS_PTE;
+
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(12, 1, 0):
 		gmc_v12_1_set_gmc_funcs(adev);
 		gmc_v12_1_set_irq_funcs(adev);
-		adev->gmc.init_pte_flags = AMDGPU_PTE_IS_PTE;
 		break;
 	default:
 		gmc_v12_0_set_gmc_funcs(adev);
-- 
2.54.0

