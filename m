Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA8FC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 13:05:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14D911134A6;
	Fri,  3 Jun 2022 13:05:09 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93A9A1134A0
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 13:05:07 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id s6so4243825eja.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Jun 2022 06:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OM4UkC68c61HiPbQiKbgtyI119SLGp5pkzfA9eJcOUk=;
 b=DSY59Cm53E/RCsjP2hu4WFD7NRbnd6b+9KGP4VKwFvcB2IzhrMSOsMR3DkSLAscehe
 MSs0f1Ctb9zrFHXfJb3g0xuJSb/PDYxsRwesk8k+xu9H4+XW55RlyfrXnJmHhPQ4osHU
 t+2SQJEv1jb+2Pt7CvK39HzPAy7HdXwXiZ1UvYoZCThvsfME/3G0YtXYkzzwaqoffsrN
 TmSqTJXINhlAZLm0gqXRUeU2YgEJXrKreHyKQ90YXHaeNel7R9cMwhNGaFY1G+xDF7Nc
 q7a8OSgqwkFL7EEFN+AqJODka6IxxVHqipbYsfj8vMntz+UCZTsZHkcwCwvC8Y91T05n
 61GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OM4UkC68c61HiPbQiKbgtyI119SLGp5pkzfA9eJcOUk=;
 b=P4TRw1Mq7xpNwkt6PE+y08fWD4bJt9NLYWnBhlY0cMFTaPtvgoW470DiZRtRvPx7Lx
 QNzBVv0IH7XpLhxWteqDaf2nzEIzGy0ubwwUY/OmXt8sPTfNv36fSwGEyPkceKAq4hzQ
 xs+cL1hIxRgDa9T2NIrHA4d3yHDwFbJ9A94sMd97KiyElczvxTCGldIxg5sOIbPKzT5C
 hoDlsrFJS7g9FE+NDcdXSX5LY6L2nL1dItqGw1AMdk+dVQ18AIcN6Ghjk0CzLOqJqsud
 SfQKsQ4m3ttZYVMv67Hso2wC8u3qoZj5qLylWClBIycKs+ITKZYAvGBdu6w497ZHWDHL
 oRYw==
X-Gm-Message-State: AOAM530YcO/2MmXMj9XCejFmb/eez1Ly8P0342J2pd8A7zf13myLpvzt
 pnZBA2jS49tIbofF5nMyvFQYM7LuK1grFA==
X-Google-Smtp-Source: ABdhPJyKAcgZXP0AJPmlxytJLYOL28ZqIC20hyvQjYZ7bjldR8JvttVM5cB6kBgFcHi8lvKRy9Zb1Q==
X-Received: by 2002:a17:907:7282:b0:6fa:9365:f922 with SMTP id
 dt2-20020a170907728200b006fa9365f922mr8427495ejc.262.1654261506038; 
 Fri, 03 Jun 2022 06:05:06 -0700 (PDT)
Received: from baker.fritz.box (p5b0ea02f.dip0.t-ipconnect.de. [91.14.160.47])
 by smtp.gmail.com with ESMTPSA id
 fx3-20020a1709069e8300b007072dc80e06sm2750455ejc.190.2022.06.03.06.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jun 2022 06:05:05 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Arunpravin.PaneerSelvam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: always flush the TLB on gfx8
Date: Fri,  3 Jun 2022 15:05:04 +0200
Message-Id: <20220603130504.81147-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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

The TLB on GFX8 stores each block of 8 PTEs where any of the valid bits
are set.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 9596c22fded6..b747488c28ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -847,6 +847,11 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	flush_tlb |= adev->gmc.xgmi.num_physical_nodes &&
 		     adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 0);
 
+	/*
+	 * On GFX8 and older any 8 PTE block with a valid bit set enters the TLB
+	 */
+	flush_tlb |= adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 0, 0);
+
 	memset(&params, 0, sizeof(params));
 	params.adev = adev;
 	params.vm = vm;
-- 
2.25.1

