Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA28C761A6
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 17:16:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FA9710E1DE;
	Fri, 31 Mar 2023 17:16:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA13510E08C
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 16:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680280850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=S5srYW34Gq6Rc0mPy9hqCIRWz9WH4Jy0yDiTUMwyFoY=;
 b=GZO1jJkp/VbbiwwhG4md7LWiiSb3oB6sZAbdfBBnvgByUBDJO/sA/+xtLajQG7RZIXHRE4
 4uwNfSEbWRuKU6hNLMxnOO3l6OBp0qFwb8wkCQpjSzxxcl0QdKlqZAqdos/+B0mI4qACiQ
 eO1FshtRS+I+nt3xghseZJi3xp13qpA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-I4VKiLhAOiKOoyMisZZYQg-1; Fri, 31 Mar 2023 12:40:46 -0400
X-MC-Unique: I4VKiLhAOiKOoyMisZZYQg-1
Received: by mail-qt1-f199.google.com with SMTP id
 h6-20020a05622a170600b003e22c6de617so15033449qtk.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 09:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680280845;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S5srYW34Gq6Rc0mPy9hqCIRWz9WH4Jy0yDiTUMwyFoY=;
 b=rvnqqvIRUDVXvQ8GIL5/KC5Vin5++9NYfqIUGfrrhAKWarwmNWGPv74t+XXU/xnzbo
 Je9ty6Ij+/hfKGy1kJZo0d47zegs2/M0fftQfiHREx5/qhVKCDzSNe0IBCfKqIfoOmdX
 k17lmap1AWI+YZG8RCd4kUGPnnkg9ISVPaMKkLOHfp0Nxnu3s70rJh5fjtnYruqMXuIA
 xRiUsztu8OwfJeK28mLcINSj5dLiDJvu3b91wEkHl8prfYp1oFQKkeBIaXEWwcbf7TL6
 Y84981cQ3OysikveVL3FTOQ9AlaQZLJixObXsqsNtk/ZLQb4KnvMJasNQVHl7FP+Tpvg
 63Iw==
X-Gm-Message-State: AAQBX9fIEl5yL+7M92mn8qRhGMh/qZz4JcXpdRlQdlaeus6nfwbe2Wq0
 yPCy5RA/vm9drk3c/EWK0NEjQ5Ge7VS1uvHJY1aEJ1WeQSajh35wxzshyWezQLx4bDg9ug30PF3
 YMsdzwg0vEPAqdJFn3nRHkoGUjg==
X-Received: by 2002:a05:622a:1a20:b0:3e3:9041:3f6e with SMTP id
 f32-20020a05622a1a2000b003e390413f6emr46722897qtb.7.1680280845097; 
 Fri, 31 Mar 2023 09:40:45 -0700 (PDT)
X-Google-Smtp-Source: AK7set9AlG21wz/QX/2UqrS1W/pPfMtig2JbymMss4of37EbHIk5FJiRqMt3PBrL7AF9Ryxd9BM1Yg==
X-Received: by 2002:a05:622a:1a20:b0:3e3:9041:3f6e with SMTP id
 f32-20020a05622a1a2000b003e390413f6emr46722869qtb.7.1680280844887; 
 Fri, 31 Mar 2023 09:40:44 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 c70-20020a379a49000000b00746ae84ea6csm797194qke.3.2023.03.31.09.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Mar 2023 09:40:44 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: evan.quan@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
 ndesaulniers@google.com, Hawking.Zhang@amd.com, kenneth.feng@amd.com,
 lijo.lazar@amd.com, KevinYang.Wang@amd.com, tim.huang@amd.com,
 andrealmeid@igalia.com, Kun.Liu2@amd.com, mario.limonciello@amd.com
Subject: [PATCH] drm/amd/pm: remove unused num_of_active_display variable
Date: Fri, 31 Mar 2023 12:40:41 -0400
Message-Id: <20230331164041.1859088-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Fri, 31 Mar 2023 17:16:49 +0000
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
Cc: Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

clang with W=1 reports
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:1700:6: error: variable
  'num_of_active_display' set but not used [-Werror,-Wunused-but-set-variable]
        int num_of_active_display = 0;
            ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b5d64749990e..f93f7a9ed631 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1696,8 +1696,6 @@ static int smu_display_configuration_change(void *handle,
 					    const struct amd_pp_display_configuration *display_config)
 {
 	struct smu_context *smu = handle;
-	int index = 0;
-	int num_of_active_display = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
@@ -1708,11 +1706,6 @@ static int smu_display_configuration_change(void *handle,
 	smu_set_min_dcef_deep_sleep(smu,
 				    display_config->min_dcef_deep_sleep_set_clk / 100);
 
-	for (index = 0; index < display_config->num_path_including_non_display; index++) {
-		if (display_config->displays[index].controller_id != 0)
-			num_of_active_display++;
-	}
-
 	return 0;
 }
 
-- 
2.27.0

