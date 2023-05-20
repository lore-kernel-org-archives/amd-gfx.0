Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D73AC77B7D
	for <amd-gfx@archiver.kernel.org>; Sat, 20 May 2023 18:00:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C93D10E08A;
	Sat, 20 May 2023 18:00:40 +0000 (UTC)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A96BF10E08A
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 May 2023 18:00:38 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-53482b44007so1786206a12.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 May 2023 11:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684605638; x=1687197638;
 h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n/w9xABIfUj6Dl4/qFa1pCSYIiL8B2Gh1Bv0+XJyaLg=;
 b=N8L1hdpmePzAhgQ+Ob47tLL3IRB6FCvBr4dMK8UEnsLU68O9eBsSuE2TGy/L4NdMse
 U65SMoxO73eAC1b4bEdEjjbP/2bc7Jh8rYkj8RVVA7o+FBboO4xeGFtSDCI/zgZv3YfH
 Hy7w6tUr3Z3efFxaoWi/tubjqPhO4hv/6uObSjPuFtOlnirpLc6rtthxmpruvOHG/oiS
 dEWDvUc28sEMf5eT/Wb3XniNldGaYAMEfZlt6qPsH/4kC6Gdgv4NG9bgbzrD0DVza+4K
 d/cQylSZ41Kdeg+H5lfbp+0IOLZTYn8oCbIrSMlSf9BeHr21ZlghjzPH6PWKBKzcp3iM
 Z6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684605638; x=1687197638;
 h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n/w9xABIfUj6Dl4/qFa1pCSYIiL8B2Gh1Bv0+XJyaLg=;
 b=H3zkKFdliA1JTlE6wz0HnPKThwxei7eeXRWoppgq20aN9wfGA860aGY4LS7pqks5kT
 e6UnEOxvOQRuRVFMUjIDVrwilNtxnz0jNoS24m7H0VYT+TVD1Wp41MtdO0mbUuiQ4eAn
 bbdvt707aOGQ+Dl8Oaj/N2rwy4mQQcgCcA3yRbXmh++i40aqs8VzLFR750zZKf58+0tQ
 0W1zyWWHlkhWe6Hg1Mi+GAo7gdh4F3g7C18ddGloMaVCgpOjdDZ/giwhqi7Iu6euYTQ6
 T1/ilzJtrbmwEP2Ea+5JHlg8hNk06qnrkNv24GQaHb2hjLQT71wf0MK344EoOAq6+5XM
 1Buw==
X-Gm-Message-State: AC+VfDzA/rF/MAFqf0zArDwz962rRGHrehBg6q2OD6bSsNQ0o7wRUArX
 4a3qkWIZjbWnOBgWgXZi8+U=
X-Google-Smtp-Source: ACHHUZ7VX15xvIk9IjlTdopKTebyozL9mjDmdwEDVDwn8YHkJZYF/JOTz2sNj9RspZm/0KavfCxOAQ==
X-Received: by 2002:a17:902:c407:b0:1ac:451d:34b with SMTP id
 k7-20020a170902c40700b001ac451d034bmr8470317plk.9.1684605637889; 
 Sat, 20 May 2023 11:00:37 -0700 (PDT)
Received: from localhost ([123.56.124.140]) by smtp.gmail.com with ESMTPSA id
 bj6-20020a170902850600b001a183ade911sm1800688plb.56.2023.05.20.11.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 11:00:37 -0700 (PDT)
Message-ID: <64690ac5.170a0220.92bb3.2e7a@mx.google.com>
From: ghostfly233 <ghostfly23333@gmail.com>
Date: Sat, 20 May 2023 19:59:40 +0800
Subject: [PATCH] drm/amdgpu: Rearrange WREG32 operations in gfxhub_v2_1.c
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com
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
Cc: ghostfly23333@gmail.com, daniel@ffwll.ch, airlied@gmail.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In gfxhub_v2_1_setup_vmid_config(), the GCVM_CONTEXT1_CNTL reg is
written before related GCVM_CONTEXT1_PAGE_TABLE_START_ADDR and
GCVM_CONTEXT1_PAGE_TABLE_END_ADDR regs are written, which may
cause undefined behavior.

This patch rearranges WREG32 operations in gfxhub_v2_1_setup_vmid_config(),
so that it can ensure the addresses are initialized before CNTL is enabled
and reduce the risk of encountering undefined behavior.

Signed-off-by: Zibin Liu <ghostfly23333@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 4aacbbec31e2..6d094e7315eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -321,8 +321,6 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
 				    !adev->gmc.noretry);
-		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL,
-				    i * hub->ctx_distance, tmp);
 		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
 				    i * hub->ctx_addr_distance, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
@@ -333,6 +331,8 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
-- 
2.34.1

