Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80184C43327
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 16:17:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1939C10F024;
	Wed,  1 Jul 2026 16:17:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NB/y8GcI";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE24610F00E
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 16:17:48 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4939a809b24so8212255e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jul 2026 09:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782922667; x=1783527467; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HfA7GaPHEMYNzCZuVHbDrTBHMteXMlv5dC58xJLsnL0=;
 b=NB/y8GcIYUfIhngbxzS+B5EE/jxFnN6CRivOsbJhXlaAF05sjbgJuiUW43/6Xztz4o
 X7hqyBTaedzwDuDsPlpPFbLVn6sBqjX+lVIFHshzRLISWrVisPOPtZxQ1qxArLJa2yH7
 0Z/bA/FUorQJTIL1ZCgOJ7IZCufJZ0YrCxWqHWTUGhu7I1D5FsfmSoA1C6Y8WMemmUnY
 PUU7hUUw5woHjXeQJB7w83lemgS33kRZxdqYaLcnONWqgoxzule0jaVGZB8DKLqOWhF3
 BH61sdxG9pttyW7YhEgkszhFQiHu7zU8y9i+swbFoQlhLugm+dzuaKqxJGrcPt0A+KiO
 t2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782922667; x=1783527467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HfA7GaPHEMYNzCZuVHbDrTBHMteXMlv5dC58xJLsnL0=;
 b=QSFm06uQT2Yr1DZKH0bASgYI99apaO3Whn6isgro1bMf4vSqEHvoTIEnUFoFm9S87z
 c58XAcpUDK0bLzFDon7W9MorOc6f4/Byet2dQ3NijFlcsnPM8l9lFsdTOEe/5xiv8d6L
 RhkV8nCeeRTo9FubTDa5i7xtX0R86sR4Ik57Jq4bsGlcTxt/KmnskL2FFa5IOO/pZqQJ
 mcZtDG9TzA4EzpwSXSYG0z6Hq8dgx6KX4VbSVqR6EFBOyZpC4cuwZGM+YOShlb3gfK0t
 dlMYyGwG3l/3qBXKxPfbhYRJ49kyxeU+ZCAUkQtnpkrJMACggn6U1lzj9x9SuEXMaVyD
 h24A==
X-Gm-Message-State: AOJu0Yy7yu5AXaKoH1gMVP7x3u3XFmsnWgCbwYIAeaDOD7xnj0D8nNP5
 gfIv5ViujfIhrUJpeCUDQX4SYF7MbZoeRKPwvwpS8opKiFWEbhkzDklUDJ6XX1ib
X-Gm-Gg: AfdE7cmoEC0U0r8gGZFdBLD4G5eNvrmDJ3g+S6eWj8jJUrwKGHS6FXnX3ILjT2YXfdJ
 LT5hIafVv0jevZfp4HzTTw/9IDEDlP8KL7FXpRvRWOxKMX0YfQ6r+n5yx9YahHNtUO4qUA/JSgY
 d4rLVyiF7LUELkxuTScG2ZCkrD3A22ZqI0YOgGL7T61QOHhKbH7YFzv9W+HucYrOZTEuMm4fmJA
 0CrV9Hk9qOcJhggwjzH3tZ0ZRkM19zcMavKXHSlq88y+jIS5eg+AipPw9OtUVSAgVEyZJg7V5jP
 qECFSKPA0L6nZO9Gq8cu2MvFaOfVKaJVRlYIPC7oQ6nwQccMp5T5ad3kcfO+rsY86hWlQxk/cSm
 SkDMpZ6afKlurGcEHlWD81EzSE5VgWbIzWMYmQi0/XeXFAtgAH9VdOKtEZfvUniJBJuU08FVV3X
 rRtngBW0lzarTbWJ58
X-Received: by 2002:a05:600c:4f94:b0:493:adc3:cced with SMTP id
 5b1f17b1804b1-493c2b9826fmr34260765e9.34.1782922667125; 
 Wed, 01 Jul 2026 09:17:47 -0700 (PDT)
Received: from Timur-Max ([212.108.193.106]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be81df2asm168812255e9.12.2026.07.01.09.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 09:17:46 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 11/14] drm/amdgpu/ih6.0: Use MMIO ACK for retry CAM on IH 6.0
Date: Wed,  1 Jul 2026 18:17:18 +0200
Message-ID: <20260701161721.85681-12-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701161721.85681-1-timur.kristof@gmail.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
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

The doorbell is not working on Navi 31.
Use the IH_RETRY_CAM_ACK register.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index 65e5d21753f9..a97c85b0cb99 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -307,6 +307,11 @@ static int ih_v6_0_enable_ring(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void ih_v6_0_retry_cam_ack(struct amdgpu_device *adev, u32 cam_index)
+{
+	WREG32_SOC15(OSSSYS, 0, regIH_RETRY_CAM_ACK, cam_index);
+}
+
 /**
  * ih_v6_0_irq_init - init and enable the interrupt ring
  *
@@ -807,7 +812,8 @@ static const struct amdgpu_ih_funcs ih_v6_0_funcs = {
 	.get_wptr = ih_v6_0_get_wptr,
 	.decode_iv = amdgpu_ih_decode_iv_helper,
 	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
-	.set_rptr = ih_v6_0_set_rptr
+	.set_rptr = ih_v6_0_set_rptr,
+	.retry_cam_ack = ih_v6_0_retry_cam_ack,
 };
 
 static void ih_v6_0_set_interrupt_funcs(struct amdgpu_device *adev)
-- 
2.54.0

