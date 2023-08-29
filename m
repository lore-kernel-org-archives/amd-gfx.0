Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08AAC6FA8F
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Aug 2023 11:20:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C75310E21A;
	Tue, 29 Aug 2023 11:20:56 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4A7A10E21A
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Aug 2023 11:20:53 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5230a22cfd1so5460841a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Aug 2023 04:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693308052; x=1693912852;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=OhkCNjY6COmeNg5k/2/ynIGph/3WLGEZHjRw+qZFYIc=;
 b=VasRa4NPYi+0jA/XUl7pt0SYdRDEw7tRVa3HLOz5Yy8u9pZkJv1SPWS6LhO0ED6pHT
 vaGdjiqSQDpY5F33c/esWDoPPnpHzLCFAZwrIIPNXOKhNnSGlYrVbowXWtfzECv8ikM8
 rNxG4NvRe199LuvBV37fGU2FWEQMVo+t6gxhpa8OyabOgVtnuYD4sY188ozmXIyB8fyG
 jx02XB7kyWxTQvXlimzU08jc/RiZITOM7Bb8/PHHEC/OSEWhshs2VGiji5Z2p812Wp5b
 ZFtNi+q3MVQrDjFVbQlrpnxCzpR4naVX3PGqfAglfrZ4WhpcjK+rPwrJhY1xSIc5GEN5
 pBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693308052; x=1693912852;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OhkCNjY6COmeNg5k/2/ynIGph/3WLGEZHjRw+qZFYIc=;
 b=U2bAR5IKeCc+eIqpQISq8sf2EWn3l1xJN5kj4tCI4THFo9WVTG+8srixSgQxcdx7kb
 DIql6ei8W45aMlbqnj1czpj7j4rVlxU53v8Hz5NFuv4YuMaGUjzOrzzxhOuDaeMfJZvy
 Htunz0DoIVsbOsvnrWYRTy9RYzQOgvuUqrMMqOgIabP4ojHh3ji8JD/TenlLbZL9vu9D
 7ddHnr8VSEV6Gxl/8PqsbSOWpCsFIi0XagawMxXXNq+3ghFTEDP0zuNRSlXqg9I7hqKs
 491RFJYkjNalAc4mIBFwLNAAHCfpLUO/6Ag95n2PSXwt1/LOeQ18PHidLcW7lX7FWesQ
 RrkQ==
X-Gm-Message-State: AOJu0YyCH5Mr/DhmC0her5h8fdxGUDmrWSXohQO1/VvXS6FBxQSOSJCt
 0+2X/kaIJAY8nUTQE79mjkm1tl7o+gDXS1x7
X-Google-Smtp-Source: AGHT+IHcEhu5Gl88toxNqqH62P8jzO14korHfSsmfCyi2BkE+9FfEGFDcbWsCOrWaAJO4sqWTT0GCA==
X-Received: by 2002:a17:906:5391:b0:9a1:da38:5691 with SMTP id
 g17-20020a170906539100b009a1da385691mr12909986ejo.74.1693308052130; 
 Tue, 29 Aug 2023 04:20:52 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:158b:d500:cd84:8e32:621d:b36b])
 by smtp.gmail.com with ESMTPSA id
 a1-20020a17090640c100b0099bcf9c2ec6sm5801476ejk.75.2023.08.29.04.20.51
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 04:20:51 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix amdgpu_cs_p1_user_fence
Date: Tue, 29 Aug 2023 13:20:50 +0200
Message-Id: <20230829112050.4024-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
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

The offset is just 32bits here so this can potentially overflow if
somebody specifies a large value. Instead reduce the size to calculate
the last possible offset.

The error handling path incorrectly drops the reference to the user
fence BO resulting in potential reference count underflow.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index f4b5572c54f2..5c8729491105 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -139,23 +139,14 @@ static int amdgpu_cs_p1_user_fence(struct amdgpu_cs_parser *p,
 	drm_gem_object_put(gobj);
 
 	size = amdgpu_bo_size(bo);
-	if (size != PAGE_SIZE || (data->offset + 8) > size) {
-		r = -EINVAL;
-		goto error_unref;
-	}
+	if (size != PAGE_SIZE || data->offset > (size - 8))
+		return -EINVAL;
 
-	if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm)) {
-		r = -EINVAL;
-		goto error_unref;
-	}
+	if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm))
+		return -EINVAL;
 
 	*offset = data->offset;
-
 	return 0;
-
-error_unref:
-	amdgpu_bo_unref(&bo);
-	return r;
 }
 
 static int amdgpu_cs_p1_bo_handles(struct amdgpu_cs_parser *p,
-- 
2.34.1

