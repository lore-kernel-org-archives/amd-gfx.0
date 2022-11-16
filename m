Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB55C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Nov 2022 16:01:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CB6210E4C7;
	Wed, 16 Nov 2022 16:01:17 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4596910E4C7
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 16:01:15 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id n12so45116422eja.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 08:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=HnBxJEPcjz3NTYNOA9EvG2Q2Rn362/QWcTen2V5gD7w=;
 b=VsFw5zXmZol2qrFaa+echhcPOfeh5/JRcICdlUGqueEZ8tLvfI37348d3vp85GXYij
 1lr1kZpF2NwQPFGlLjhBXOSG+T9yAfPYM7XOyIyLfANgu0HUinQndXIIO0xQGYL43qPE
 1EhDeNGTxZcbW59AicsIE6T4km0k3AC+DheVApG7FhcElaVNWf1s31TYXqxm4nbOT81l
 7LX/4JOP31SaduRHHapEEf5dpAHFKNDXfIiTTiMEieUYwQ1Nu6yLCEaCdKBaauzInEoq
 S/0YgLlnIYLcGOCwwEswkRl4tWStgcRsBfYiuym7dpgmc+OZUVT3H2w6LFymb8sEJiBM
 R0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HnBxJEPcjz3NTYNOA9EvG2Q2Rn362/QWcTen2V5gD7w=;
 b=HkUBTIlDx/l45uulVxjHuqz2ZjJH2DRYeXGPTqUkfqGFPHKGOwl6Vl+7o4jjJSNRzD
 AGiQe8LNqxM9cPB7Gk1TBbIsGTyckX3xERo2O6KKaFx9OlT+ttvYy2AjuED+zZiGYLtk
 vfHEiZANRpdQl4I430GVs6rkMl+ILEF7nBXj1XKzGIVtWEfcN/ttTCs+RaE/uZh/IzfO
 2qOvwW8nOxXq01/INwcfTvd76CmXNUbgWok8DgMzdQK57Kijg8V7AAcz9poys0m4bLrZ
 M6Oi2DTj/b5enlM0g8T16AdlrGMkvAKuYOn5B34WB2ME+GKc2kIZwivfZvqR7a2C88yl
 OsUQ==
X-Gm-Message-State: ANoB5plfrdGjKMLm7l8sHh8kyFcZ0jIP52OnpKVxe0EuhSLIHug6Z01e
 qXTY0vF3bQ2SCwP3/T2b+M7o+wL2r4U=
X-Google-Smtp-Source: AA0mqf5mvtgBx27yGB55G52gaAUa1+lPKj5iFmA+uer91D0g9+jlVuCdB8KZ+ulSQWQUrZDAONKXDQ==
X-Received: by 2002:a17:906:b2ca:b0:7ad:92c5:637a with SMTP id
 cf10-20020a170906b2ca00b007ad92c5637amr18483157ejb.87.1668614473737; 
 Wed, 16 Nov 2022 08:01:13 -0800 (PST)
Received: from able.fritz.box (p5b0ea229.dip0.t-ipconnect.de. [91.14.162.41])
 by smtp.gmail.com with ESMTPSA id
 lb17-20020a170907785100b00734bfab4d59sm7139097ejc.170.2022.11.16.08.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Nov 2022 08:01:13 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, arunpravin.paneerselvam@amd.com,
 alexdeucher@gmail.com
Subject: [PATCH 1/3] drm/amdgpu: don't pin kernel objects multiple times
Date: Wed, 16 Nov 2022 17:01:09 +0100
Message-Id: <20221116160111.3226-1-christian.koenig@amd.com>
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

Some kernel buffers can only be allocated after asking the firmware how
large they should be. But since this happens on every resume don't pin
them multiple times.

Also bail out with an error if the requested size should ever change.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 90eb07106609..d0d53e83a318 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -258,6 +258,9 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
 			return r;
 		}
 		free = true;
+	} else {
+		if ((*bo_ptr)->tbo.base.size != size)
+			return -EINVAL;
 	}
 
 	r = amdgpu_bo_reserve(*bo_ptr, false);
@@ -266,10 +269,12 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
 		goto error_free;
 	}
 
-	r = amdgpu_bo_pin(*bo_ptr, domain);
-	if (r) {
-		dev_err(adev->dev, "(%d) kernel bo pin failed\n", r);
-		goto error_unreserve;
+	if (free) {
+		r = amdgpu_bo_pin(*bo_ptr, domain);
+		if (r) {
+			dev_err(adev->dev, "(%d) kernel bo pin failed\n", r);
+			goto error_unreserve;
+		}
 	}
 
 	r = amdgpu_ttm_alloc_gart(&(*bo_ptr)->tbo);
@@ -292,7 +297,8 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
 	return 0;
 
 error_unpin:
-	amdgpu_bo_unpin(*bo_ptr);
+	if (free)
+		amdgpu_bo_unpin(*bo_ptr);
 error_unreserve:
 	amdgpu_bo_unreserve(*bo_ptr);
 
-- 
2.34.1

