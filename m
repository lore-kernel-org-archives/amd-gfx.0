Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B66C44507
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 12:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAFED10E5F2;
	Mon, 13 Jul 2026 12:58:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F4lVsG5h";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DCC610E5F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 12:58:45 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47de008b020so1592238f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 05:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783947523; x=1784552323; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZEPgwlcf1b0C/5ZQTnIOEuUOqgn32RYMmChcW9UnRgk=;
 b=F4lVsG5hT+ecAAD+xA350kARMu0PUhUqHCE1WfsqMInqI3uvbAKlFEmYONjbvyirSu
 bHveWmfdEdL936QyYwzzkHC3+DV6IyB8kCq/ILyZEj0+Jkg1hDW2yQbt+Px3f8BwCw0I
 iC76XyqYkMuJWMaK/7I0b+UF1tqfnv2yUWx07hSG7c16VxJmO4nwj2p5Qrf3CPl/Bk84
 Et/m+z6RKpZkTMBJXA5SoavDTv1b2LGRAd6CJR0ss/C+P5lz+Jk8YKOhlEaU9xM41TIU
 U0MefxrVf+y2oRAzwRAG0rcWh+wDC+HxosszNvJ5FbLlrD3kP3VNI3YnS97h5QwOjakv
 VC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783947523; x=1784552323;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZEPgwlcf1b0C/5ZQTnIOEuUOqgn32RYMmChcW9UnRgk=;
 b=SWkUCZMVGJqwYn6OvoQwcVf3jJWW8cFXLkU5goW3aXAZUE3ja3dsV8HftHgtQp8BG3
 IQrx7rE3MbUmIqu82942i902+i4w1H8bKutBcsF0eBJlLd8p18e4nw5IvCFZkwUUglN4
 6ZFAf/aCR6wYGuSuJLdKUlzLd9NolzgGKNYUXZne2vv5Wrg6QSEhqTrSBywb3ADBp37W
 WtimYmbcwyaClOkfEx29t3VLucu9+JMS/yd6I/ozbNoFBiHcesUsCAB8hXoCvvuZlOU2
 VpVaRnCpmS5wFkofYK3XW3k2swRCLsIyTsP1He9SZnr999vDSAoUr5As26sXPienLhZj
 enXw==
X-Gm-Message-State: AOJu0YxmID6/UHpA9ImeNExTXAr+JF42qTDDtEX4C9vQGH0Zx1iNUeXG
 JeTpBjbE2FCkAQLQVlqpaW9GJhEDU68xL+Mdnsldof1oUTACdqN7caXFT8w0Sw==
X-Gm-Gg: AfdE7ck7tejJY4EIHK13Di9px8y7m6TRqrlmw1UVG9Cate0VM9cXluz35+uqx4ED8pk
 cASbSygDdd0dES0q5oOhOzTfw4D4pCg4ZJEnTOmITzdsfaUxpOau8bo4JHtrU/Gq40C7IEURAom
 fh8g7A8y2dQeFSFYWBfxl1Nr5IJF5f5lWOGGd1mYP3FWjco3f2AsHJ2FPiNuh5cKwy3krXbN9t2
 AiHrqRNXIfFnj5DREAK9VFWNs2LBrQEZg1JpkNlB/lmKzsIY8y1yh96jBdQ23wDh2PO/Lnh0Pxo
 F4elRZX+oTke2IlcOvhNOWHovf+DTuyGzFROW54mqcO9LsfxrODcOUxjUKXppPgXbtkEQ2DMT6Z
 Y1qWnHFse8fYLwZyf1Sev+by6A1brIzyQlFZN1NkUIDh+90AGeC+qxG7OH89N26PQYIlAD744Sk
 saiTKs6Y/L6oWv1b1Hk9wx2/LNufFnPjYRszjutw3WMln1aWA/0lVhSA==
X-Received: by 2002:a05:6000:430c:b0:472:8043:f00b with SMTP id
 ffacd0b85a97d-47ef697ecfemr16597774f8f.14.1783947523503; 
 Mon, 13 Jul 2026 05:58:43 -0700 (PDT)
Received: from Timur-Hyperion.home (54001386.dsl.pool.telekom.hu.
 [84.0.19.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d6e4csm80456918f8f.10.2026.07.13.05.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:58:42 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Tvrtko Ursulin <tursulin@ursulin.net>,
 pierre-eric.pelloux-prayer@amd.com, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/9] drm/amdgpu/gfx7: Make amdgpu_gfx_mqd_sw_init() usable on
 GFX7
Date: Mon, 13 Jul 2026 14:58:30 +0200
Message-ID: <20260713125838.30607-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713125838.30607-1-timur.kristof@gmail.com>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
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

We don't use KIQ on GFX7 but otherwise MQD works the
same way as GFX8 and newer.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 96c9d4f00b27..0f142c156afa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -420,7 +420,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 #endif
 
 	/* create MQD for KIQ */
-	if (!adev->enable_mes_kiq && !ring->mqd_obj) {
+	if (adev->asic_type >= CHIP_TOPAZ && !adev->enable_mes_kiq && !ring->mqd_obj) {
 		/* originaly the KIQ MQD is put in GTT domain, but for SRIOV VRAM domain is a must
 		 * otherwise hypervisor trigger SAVE_VF fail after driver unloaded which mean MQD
 		 * deallocated and gart_unbind, to strict diverage we decide to use VRAM domain for
-- 
2.55.0

