Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D871C30659
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 18:32:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 322BE10E99E;
	Wed, 26 Jun 2024 18:32:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g4PdBiPu";
	dkim-atps=neutral
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBE2F10E999
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 18:32:07 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-700cc388839so1207232a34.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 11:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719426726; x=1720031526; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VvM8D0F3punaFk4qHd2u5+pBLWvs5V0Z9xgYljZT/VQ=;
 b=g4PdBiPu8RdysyrmcnuznVqgU7NnjCjaqbPKjhB9EYi3G14gKuHkqAciJsDbNqLTti
 fmXjPKPSMYzk1Oyqk8R5/NQKbx4uY4daLb6MyUCx9/FFH7Y57ksCuDyf9YOUcj8C8suq
 HEVrRAkJgtjX2haF2hGi4ljDXm6zPACeJy3ttvYK3SbGngZvoVa/D3SfbspI6jHDoYte
 fGn8P8QZN5IY/3hRr2QbRTVpuRfcRaxGfz9/5Tmc+2e3bPWXj3ALr/1FZk3rIbp/A7cJ
 F/wAmmwCVq2EMsB5bamJdMwUlVrgjUHuX8SeQeCxAVnoGVBBSDMRJJrtiiPQZSXCN3zX
 Za+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719426726; x=1720031526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VvM8D0F3punaFk4qHd2u5+pBLWvs5V0Z9xgYljZT/VQ=;
 b=gwFua5IAXaBC1WdPlb1Aecqr4abqBn0aJiYpufTZPrTOto3NoPDGW1HFxW9EnKGhHP
 SzI3RA2gaM4IbAQiQrPgLODd8qWa2QMFOESh3uDbMePah0SUnL2jE7DGeb76WqNwuRlf
 A5GdF/4vKYuyZVw7mQmTYYIfgOUStFelM7UIh7bnV4unLHGQkxVnDz3iSGmBu+Qq2kWw
 md7LDePKLiiCcBc2f5YY+Ob/9gwo5rXZTvu0amieCHFBxsAJ6tiWpWuDHhYuicdnjrxN
 IYbRj41NHZ4b3d0mTfmmfK1hqa2lP8hWR02RupaskOa5quUgrmTQJVXcURJnnCzk65oD
 WNuw==
X-Gm-Message-State: AOJu0Yxhyc7ifhrutTzc9NVXvWLFKT2NShmTBYQX1WUQQgKyAKjM+EIp
 izjOzf+ZnFBK68ffJm4mjAG4A3el0l9en4T66IeZczhlHDDfLdNreczMWw==
X-Google-Smtp-Source: AGHT+IE1KdzqswlNgekdHgQjmxWyN4ZIE8e9ZUp1kWTJYBEedjkE1IbHSoBZy6Wbt3AhRxbakbgmTg==
X-Received: by 2002:a9d:65c4:0:b0:6fa:c6f:2237 with SMTP id
 46e09a7af769-700afa0772bmr12244122a34.25.1719426725909; 
 Wed, 26 Jun 2024 11:32:05 -0700 (PDT)
Received: from localhost.localdomain ([142.188.138.70])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b538092644sm42209276d6.39.2024.06.26.11.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 11:32:05 -0700 (PDT)
From: "=?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=" <maraeo@gmail.com>
X-Google-Original-From: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=
 <marek.olsak@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>
Subject: [PATCH 09/13] drm/amdgpu: handle gfx12 in amdgpu_display_verify_sizes
Date: Wed, 26 Jun 2024 14:31:31 -0400
Message-Id: <20240626183135.8606-9-marek.olsak@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626183135.8606-1-marek.olsak@amd.com>
References: <20240626183135.8606-1-marek.olsak@amd.com>
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

It verified GFX9-11 swizzle modes on GFX12, which has undefined behavior.

Signed-off-by: Marek Olšák <marek.olsak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 27 ++++++++++++++++++++-
 include/uapi/drm/drm_fourcc.h               |  2 ++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 3a7f6e77806a..ec0299c5918e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1082,6 +1082,30 @@ static int amdgpu_display_verify_sizes(struct amdgpu_framebuffer *rfb)
 			block_width = 256 / format_info->cpp[i];
 			block_height = 1;
 			block_size_log2 = 8;
+		} else if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) >= AMD_FMT_MOD_TILE_VER_GFX12) {
+			int swizzle = AMD_FMT_MOD_GET(TILE, modifier);
+
+			switch (swizzle) {
+			case AMD_FMT_MOD_TILE_GFX12_256B_2D:
+				block_size_log2 = 8;
+				break;
+			case AMD_FMT_MOD_TILE_GFX12_4K_2D:
+				block_size_log2 = 12;
+				break;
+			case AMD_FMT_MOD_TILE_GFX12_64K_2D:
+				block_size_log2 = 16;
+				break;
+			case AMD_FMT_MOD_TILE_GFX12_256K_2D:
+				block_size_log2 = 18;
+				break;
+			default:
+				drm_dbg_kms(rfb->base.dev,
+					    "Gfx12 swizzle mode with unknown block size: %d\n", swizzle);
+				return -EINVAL;
+			}
+
+			get_block_dimensions(block_size_log2, format_info->cpp[i],
+					     &block_width, &block_height);
 		} else {
 			int swizzle = AMD_FMT_MOD_GET(TILE, modifier);
 
@@ -1117,7 +1141,8 @@ static int amdgpu_display_verify_sizes(struct amdgpu_framebuffer *rfb)
 			return ret;
 	}
 
-	if (AMD_FMT_MOD_GET(DCC, modifier)) {
+	if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) <= AMD_FMT_MOD_TILE_VER_GFX11 &&
+	    AMD_FMT_MOD_GET(DCC, modifier)) {
 		if (AMD_FMT_MOD_GET(DCC_RETILE, modifier)) {
 			block_size_log2 = get_dcc_block_size(modifier, false, false);
 			get_block_dimensions(block_size_log2 + 8, format_info->cpp[0],
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 4168445fbb8b..2d84a8052b15 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -1506,6 +1506,8 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
  *    6 - 64KB_3D
  *    7 - 256KB_3D
  */
+#define AMD_FMT_MOD_TILE_GFX12_256B_2D 1
+#define AMD_FMT_MOD_TILE_GFX12_4K_2D 2
 #define AMD_FMT_MOD_TILE_GFX12_64K_2D 3
 #define AMD_FMT_MOD_TILE_GFX12_256K_2D 4
 
-- 
2.34.1

