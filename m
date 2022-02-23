Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA728C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Feb 2022 13:38:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2383E10F5F9;
	Wed, 23 Feb 2022 13:38:34 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A455710F5F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 13:38:32 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id bg10so52505856ejb.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 05:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5682uRM3a6sZFeJ8gU76eOhLupqMx54mCrt2NB5EfFg=;
 b=hacfccuuTNhNIYddfA8dLks+/8kF3VDJpdBM4osih0IaOqi9zAEuybsUgkwT+/1IZ7
 ugx+9Gpo4+GEw3FkwO81nJnRH0U4huz9W+nTnP2u/G0e41lVJ1lgy0VgNgk2zUifSxNB
 7ZyiOuOiZe4YSAlVlRfvE8HwNknIlcLUCkiFYxlNeCVbX3QAhD9Y2+pNEacCifM7pC/W
 CuHVgh0AkOtYfThaR02QJvFgcyWqU/SjeveZYaR2bxYx5h44lTHsQYLtupM2Ctc3pqWF
 up4qX4TFmE1Zm1UdgukpcEmIyIkVK3uAoCEYwhtbJqgClE+fUNQ70ySkJK4zwxIEPfgz
 rhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5682uRM3a6sZFeJ8gU76eOhLupqMx54mCrt2NB5EfFg=;
 b=IanHjyKLCpjmH2L2HfiIGQrDHiTdHE/kCnuJTHRqvmJua20HsmV1yEsOMxhecHtvwV
 XX9X+6RZz8cup2PoEXLEMfVFonW3m+bWlq637aOt8WZoeVugkjSCrQCPNyBLbfjyKt7S
 12v114qKawu1sf9noWfHSduFRtWy5nXDHtyO1SQoWjr3WKrvnlX1Zy2t4YmAw9McU5Hj
 +KgcT/D69T6kwJRssfgCTounHG/xrbROOIPNWVuZbJ8v3P1pyuqF12qP0oV7mtUP4VEZ
 F0imfhJW7v9xz8wCs7rkX1kZTHf/gjyW5WowFL3jBTznlNZcJQvsNpEvkFfMgEVYqpew
 Pm3Q==
X-Gm-Message-State: AOAM533d3hnv0L4Qoxo9EtWT/TbalHp4yzVi5vNwUy1el5hK1L6pnJlg
 tGCJID6StGDTHuJMWEEIE3xd6N7kKNk=
X-Google-Smtp-Source: ABdhPJyjR98Ki/cxtatYXi6kMtp6Z/5MBMWJSYoIou2zwFEHQ5EDtT6a7gQPhg8pokROSCEMK7FTyQ==
X-Received: by 2002:a17:906:278f:b0:6d0:432:2bbb with SMTP id
 j15-20020a170906278f00b006d004322bbbmr23128701ejc.160.1645623511140; 
 Wed, 23 Feb 2022 05:38:31 -0800 (PST)
Received: from able.fritz.box (p57b0bff8.dip0.t-ipconnect.de. [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id g16sm7378764ejf.218.2022.02.23.05.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Feb 2022 05:38:30 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: install ctx entities with cmpxchg
Date: Wed, 23 Feb 2022 14:38:29 +0100
Message-Id: <20220223133829.21443-1-christian.koenig@amd.com>
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Ken.Xue@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since we removed the context lock we need to make sure that not two threads
are trying to install an entity at the same time.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: e68efb27647f ("drm/amdgpu: remove ctx->lock")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index f522b52725e4..16eb1ee600ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -204,9 +204,15 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 	if (r)
 		goto error_free_entity;
 
-	ctx->entities[hw_ip][ring] = entity;
+	/* It's not an error if we fail to install the new entity */
+	if (cmpxchg(&ctx->entities[hw_ip][ring], NULL, entity))
+		goto cleanup_entity;
+
 	return 0;
 
+cleanup_entity:
+	drm_sched_entity_fini(&entity->entity);
+
 error_free_entity:
 	kfree(entity);
 
-- 
2.25.1

