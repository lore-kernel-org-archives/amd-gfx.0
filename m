Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625F4C77B7E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 20:38:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E52FE10E75D;
	Thu, 25 May 2023 20:38:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DA1D10E75F
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 20:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685046935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3mE/fckEZuR9c9fPTu4FUL0ylsLmFraWECVvvXZLruc=;
 b=Uiutlln23m268hRLGJVExw72K0lt9owuu3WEtQ6oaYByHfSIvqgJ8Vs1tgJudk2aZK4JJf
 2gieL4IGUvpInllJUJmbX03csb63nZPgnLrrku2nl3tIg78zzgT3YiT380ADWYExOLPHyD
 bPMt09iTCJw0tir5UIx84lOKFdJc8F8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-3jFtcIkqMJO8d_LGvB5Cjg-1; Thu, 25 May 2023 16:35:34 -0400
X-MC-Unique: 3jFtcIkqMJO8d_LGvB5Cjg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6213569ba95so2862576d6.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 13:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685046934; x=1687638934;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3mE/fckEZuR9c9fPTu4FUL0ylsLmFraWECVvvXZLruc=;
 b=HzH5DYYS/xNszBw3p3QxxS0vCmrWb4N5y0Us41ePAaH4xPKv1O0B7cymj4GRpWTKmy
 ygKOWxshpAvqPWXDD1fPfNl/J+FHQU0z/WggbAW0Asc8pCF6N0c3o3kygH/NZ9xDuKJh
 ukFAr3MUGcNt1zTP8oFzWUWZuS0PUaiic9p6/mUhWwSermxmasFApr7VvoCadgQSPb3b
 d2xq68ZR7iJvWAQE/3G9sK6TrIdfUhWW3eq639ezgr+IHPWg99ZVrtNFPk+sKZB0zv3Y
 MGTjVVafOVpiIxwRLwyAd5ZfySobJveVbqsMaAgl+27I7vk9H1yTZGAdJ2DCHjLMIBbB
 o5uQ==
X-Gm-Message-State: AC+VfDxX85TsCasGq9SB5L6bI6UuUZOvul4pveEMKMWD1p0zagTOWy1G
 FwPsFuPcoT5+z0moEaREkwfvTskXFV6ZfCZ3pVoRDTom4A5jQKOQ0r/r+WN6y+rZ0lKa4JbuYbj
 M9j97L5y5kOfEiqu0mI3manvVmw==
X-Received: by 2002:a05:6214:e6e:b0:625:ccca:328b with SMTP id
 jz14-20020a0562140e6e00b00625ccca328bmr2860149qvb.19.1685046934260; 
 Thu, 25 May 2023 13:35:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ45euEwzTp2G5RGMPSK3fbgDMQGjQu3VHUmMrVMif+hhFqBfdVa/ja2Hs14iGliwKoExaQfdA==
X-Received: by 2002:a05:6214:e6e:b0:625:ccca:328b with SMTP id
 jz14-20020a0562140e6e00b00625ccca328bmr2860132qvb.19.1685046934059; 
 Thu, 25 May 2023 13:35:34 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 a4-20020a05620a124400b0075b1c6f9628sm650389qkl.71.2023.05.25.13.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 13:35:33 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, Hawking.Zhang@amd.com, le.ma@amd.com,
 jesse.zhang@amd.com, Jiadong.Zhu@amd.com, mario.limonciello@amd.com,
 Likun.Gao@amd.com
Subject: [PATCH] drm/amdgpu: move gfx9_cs_data definition
Date: Thu, 25 May 2023 16:35:31 -0400
Message-Id: <20230525203531.3233040-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 25 May 2023 20:38:42 +0000
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
Cc: Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

gcc with W=1 reports
In file included from drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:32:
drivers/gpu/drm/amd/amdgpu/clearstate_gfx9.h:939:36: error:
  ‘gfx9_cs_data’ defined but not used [-Werror=unused-const-variable=]
  939 | static const struct cs_section_def gfx9_cs_data[] = {
      |                                    ^~~~~~~~~~~~

gfx9_cs_data is only used in gfx_v9_0.c, so move its definition there.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/clearstate_gfx9.h | 4 ----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/clearstate_gfx9.h b/drivers/gpu/drm/amd/amdgpu/clearstate_gfx9.h
index 567a904804bc..6de4778789ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/clearstate_gfx9.h
+++ b/drivers/gpu/drm/amd/amdgpu/clearstate_gfx9.h
@@ -936,7 +936,3 @@ static const struct cs_extent_def gfx9_SECT_CONTEXT_defs[] =
     {gfx9_SECT_CONTEXT_def_8, 0x0000a2f5, 155 },
     { 0, 0, 0 }
 };
-static const struct cs_section_def gfx9_cs_data[] = {
-    { gfx9_SECT_CONTEXT_defs, SECT_CONTEXT },
-    { 0, SECT_NONE }
-};
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 8bf95a6b0767..c97a68a39d93 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -56,6 +56,11 @@
 #include "asic_reg/pwr/pwr_10_0_sh_mask.h"
 #include "asic_reg/gc/gc_9_0_default.h"
 
+static const struct cs_section_def gfx9_cs_data[] = {
+    { gfx9_SECT_CONTEXT_defs, SECT_CONTEXT },
+    { 0, SECT_NONE }
+};
+
 #define GFX9_NUM_GFX_RINGS     1
 #define GFX9_NUM_SW_GFX_RINGS  2
 #define GFX9_MEC_HPD_SIZE 4096
-- 
2.27.0

