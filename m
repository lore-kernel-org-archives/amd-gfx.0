Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CDEC3DA7A
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 11:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45C7D10E6E5;
	Thu,  5 Jan 2023 11:17:10 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F06610E033
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 11:17:07 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id fy8so25286092ejc.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Jan 2023 03:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L5uBKt8XCmTB27hNkSVL7ERdHhvPq0DawFV5YF7CmxM=;
 b=PldYWf8wDQegu1VwwvCaK0EzbLf7RBTI2BLtk0K9DKzk4evnea3s6I7tLoUiHzTntL
 SL3Qfj7pKTk+2NAfxZaLVcTcX6sVoyxH76yfHjLpWGQO4s9SbCuZ0bcdWjZ3Wr70f8uO
 cV2FkdiopggzNebGDoNr84VqcftkvqPYSr0MiY2oEEKWFx9/4pi/XEMOovDGPOLXKf8r
 sGnh1yNdG4K25+u9kwg1Fb8h7DXDJX3S4P9y1EjrmEivCLlNxz2DdnLMoZSaGPDJy7A5
 qMrngt8JU0wS5XUZig+OQ8ud252v2n6f19LnFtO79mMm30+yrZM6iuzAwwFnNGKSPWfT
 2EPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L5uBKt8XCmTB27hNkSVL7ERdHhvPq0DawFV5YF7CmxM=;
 b=x3sZzweCjn1HjuyYcVZSV8TVbQcDaow6Z4WtDAMGPJax+rq9iJjgxMJf3YPGCsA52b
 k2RHLNy0kcBGW0vIPChVh/UNnrTyvEyqKKHDXo8GO8/QwClV82w9ehYLTjj7HEZ6yjkO
 7dveEF60W6KpoFMNwIVFmXkyJF+HXLm5Q4oV7xmOCA6B6Z/VfSFxzGLl0CeuY8dfwe57
 mAPve3c9nQaBqFqUr6u6xA+O0drfNZ8aYvR23IDFeYHd4QkAxF2a/OPxyPz6Qvrno157
 5Ffc5zW1OV163JfD8gegRqMkR+IJ39IRRcT2sMVmR4vDbLo9lGczXugc7Nuoz7G9f1u1
 ziqg==
X-Gm-Message-State: AFqh2krC0NAbYyvxYZJjjJfBQbmXIdyunACheOyjlcEsVXA/u5DfyfbI
 jj6WCPnhBEuJ52EN4NdTQIyqV+HrvBY=
X-Google-Smtp-Source: AMrXdXswu7YfL4USjAZvbTwO+gONjO6Ge3HKwGN5rffZV1qhoVmpuGxdNVeaEBo7k0GckK76/37AmQ==
X-Received: by 2002:a17:906:7046:b0:7ae:8194:7e06 with SMTP id
 r6-20020a170906704600b007ae81947e06mr46259873ejj.56.1672917426241; 
 Thu, 05 Jan 2023 03:17:06 -0800 (PST)
Received: from able.fritz.box (p5b0ea2e7.dip0.t-ipconnect.de. [91.14.162.231])
 by smtp.gmail.com with ESMTPSA id
 ta13-20020a1709078c0d00b0077a201f6d1esm16328289ejc.87.2023.01.05.03.17.05
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jan 2023 03:17:05 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: fix missing dma_fence_put in error path
Date: Thu,  5 Jan 2023 12:17:03 +0100
Message-Id: <20230105111703.52695-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230105111703.52695-1-christian.koenig@amd.com>
References: <20230105111703.52695-1-christian.koenig@amd.com>
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

When the fence can't be added we need to drop the reference.

Suggested-by: Bert Karwatzki <spasswolf@web.de>
Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index bac7976975bd..dcd8c066bc1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -391,8 +391,10 @@ int amdgpu_sync_push_to_job(struct amdgpu_sync *sync, struct amdgpu_job *job)
 
 		dma_fence_get(f);
 		r = drm_sched_job_add_dependency(&job->base, f);
-		if (r)
+		if (r) {
+			dma_fence_put(f);
 			return r;
+		}
 	}
 	return 0;
 }
-- 
2.34.1

