Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B80DC77B6E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 14:25:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 066AA10E66B;
	Thu, 13 Apr 2023 14:25:06 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C93910EAEC
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 14:25:04 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-2f4d0fc8df4so150790f8f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 07:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1681395902; x=1683987902;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t4GiI1Y6X0arfTi5zX1oiZUc+r0/kJNGIyRqLEl6qkQ=;
 b=gjUp+DlXWIrpITKiUScODTYL7zO8JBo4TmFdEi1kXI9sKaieXJy2uBcthZJxzUIxf2
 3SJvRUqIPayMoSG0Pe929Vm6eKSrjse5JqRRvtlk2Rc39RLMApkqz2ZU0Zwvcn9kvG5Z
 Wq5/yiN3/BOW+XFITqgzESDXfXP49BfREk6inKUJgO4HLjC5V8ceu8BvvEnfkO2suqbX
 /gmT58PVb2l5FznVNN1YSZex71z1hrdnd3VZLGUVTOcUW0fo9ZJe1yoi2nGdRkjuWTbl
 Xvy/1u27zWzCKbQKIZfsJlRIDRdReNvgISPw/wcn9AbnAOzAkWEfy6Bn6T0VhGuGvQXx
 /Stg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681395902; x=1683987902;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t4GiI1Y6X0arfTi5zX1oiZUc+r0/kJNGIyRqLEl6qkQ=;
 b=Rlt1GG06CXfgfIXkm8BV6T6AMlnWjO98wYpt6mvaM8zbsHvULRCh+tWempkPrX4VHV
 DISfkfZncfAOFfmz9glhi5Ib65ggC1R0LYKNv9wGn+9S65A02EDEP1HbMsmdO06cF04i
 D2I6qGZ4CKf8GiiR1QOS2pVD9qN0dg6IuvzZb86MMiNZZ92aAgyVftg9TfOlroj+omsm
 CG66qZfojpsD6PlsiJuado4VtkmQHBKCGpIkGmA+gyZ2ltFh2PPr5oz1kwGwTMdW+Hx8
 P9kuUqOq6lWF2HlRTXVzk+iVlaHHe8MmW48PDW/YjHjymSz/Mro7b2v+MVb2si51n2sC
 Vdnw==
X-Gm-Message-State: AAQBX9e9EkMzSZzUGAwABMVZGmyckl8jmbsJKjz6+9TMmmGip8RDQBqf
 wr4P/I4hZAH1wKXhE2rd5C5wXjnx66tv89HTiSau7Q==
X-Google-Smtp-Source: AKy350b/UnIilLxMKNBJB7Pn7yH5x+52sTSaSSRX8b6ASCQqccWW5PsGOSodCNr5fnvUTvsfLQm06A==
X-Received: by 2002:a5d:4533:0:b0:2f3:dfce:3768 with SMTP id
 j19-20020a5d4533000000b002f3dfce3768mr1465402wra.2.1681395901961; 
 Thu, 13 Apr 2023 07:25:01 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a782:cc00::ab])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a056000120b00b002e45f6ffe63sm1401186wrx.26.2023.04.13.07.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Apr 2023 07:25:01 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 1/3] drm/amdgpu: Increase GFX6 graphics ring size.
Date: Thu, 13 Apr 2023 16:22:51 +0200
Message-Id: <20230413142253.414333-1-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 christian.koenig@amd.com, maraeo@gmail.com, timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To ensure it supports 192 IBs per submission, so we can keep a
simplified IB limit in the follow up patch without having to
look at IP or GPU version.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index c41219e23151..d9ce4d1c50e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3073,7 +3073,7 @@ static int gfx_v6_0_sw_init(void *handle)
 		ring = &adev->gfx.gfx_ring[i];
 		ring->ring_obj = NULL;
 		sprintf(ring->name, "gfx");
-		r = amdgpu_ring_init(adev, ring, 1024,
+		r = amdgpu_ring_init(adev, ring, 2048,
 				     &adev->gfx.eop_irq,
 				     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,
 				     AMDGPU_RING_PRIO_DEFAULT, NULL);
-- 
2.40.0

