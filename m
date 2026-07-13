Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A18EC43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 13:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEA9B10E9A0;
	Mon, 13 Jul 2026 13:07:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W52PDAqk";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B721210E9A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 13:07:35 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-493c52cde9eso28327745e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 06:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783948054; x=1784552854; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zGEYf9FyRhQ1gY9Bval6DyAvzYkmhrm9wLXY3OYj4oM=;
 b=W52PDAqkqQgDjKTkZ5jzqC0qGqu4AG1lJWW+zXAxzS5oBAUao9FE3jeoyLaw8EUalm
 rf5ygF/PmKz9UgGTbZMgfrTgNiGtRWZqB4/q/YzLxnkDENuytoz2x2uyzKYXUDqZn7BU
 go7C/xRGX1i7LJAs7pNwXgdjJiYlhtPs5GTVkgDJLD220qXD82628QMe7ld7GwokotqG
 VzOuTer69J7mICdgJ6GjDrva6gBcLfvH1fXC8S1SqdhL2R3Op8nMz43+aV4qNOJVX46N
 6wfjt714/OZXmGvE3EYeQy+Kz7FltJviToVyIsBhNX/l5RN5fwm9CEwF2L/lI/8rfUqg
 caYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783948054; x=1784552854;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zGEYf9FyRhQ1gY9Bval6DyAvzYkmhrm9wLXY3OYj4oM=;
 b=X/tNsEJYNwuTDCZWWzp/1IcPNtwdCKrjF2i3NftkoOYLxAefd+I6Pkow8Q8MayOiO/
 9wCHj97rVIvm7LxdRCbDtZHfTcsi+oOC7FpX2WTZXYXd9G1W6AiNiNNbQcQy63ADWLeL
 daGBsvdp8gmdKGuUtvzmoMUsTh32SmLOO7kOuZ1vwmexkdg7cY9XsuuYHhrXgDOCQQDl
 NfyU7TcpJ1OQ7LnNFx2kdjgYA2UXsn5NW8m7IAEpdDxEMNBAtCZvLwL8upDocGuVpQSs
 1EEPAdhFdWhB8BmpA8/adrCm10AuaqYCDmoozgNQADBW0l7X4XZ/TkrZrJx5cBBMJ05a
 Fgyg==
X-Gm-Message-State: AOJu0Yw1WHjaqXwyGZxQbbkKGYg0QV+zMxJGOvYOgYJDYrzt/hX+SNyW
 Rza9byFGBLQSyul0DrTByEz+EvwZ20DH6o2WL6eCJsqD86SvSzjp8+bNkz0V/g==
X-Gm-Gg: AfdE7cnYldmBp3BV7tR75stnqdIfm2dc7XVam0dGVe/7K0iTTJMh1iR0s/7uiRHDLMR
 ZAUJ68oC3Jv7M1OOW/666zz/2lOAPcCRosfq/foilxkgnW8pLlx09etRnfJ/0Vd4cpXWpFCHH+k
 V3A1kA0F5UIXs5TrZfpg/XoMy/ueyHM0qoiuT2LuPaWJMMN+GHLGNYusx0a3tcPamzmEr0qWiQe
 oo3qleU/X2kky3/g6mvU3CzCAzZUNOppDX5jxg9pOijIvjs6N8c+J70qWOz9Eo2J1VMW8YPrJfT
 HYRi7VlilyNoMrMdWxlY4NGuKsv5xT1dg/T+P6qhkUYNLN3HWO2m1MBhzE5Fedt+mkttFizdj54
 YGByjZD1OU879/cgLi4I77gJ6pu2jFbudJpWTUD1CAvIKaGjiA4csPxj8CPzJL1lCmVyw8rlB6q
 KH/Aesd+asgRW1PUrFN+A/nQFToHSBVLr87c0ay+qmqeRyE/V+tk63YQ==
X-Received: by 2002:a05:600c:3e8e:b0:493:d216:ed8a with SMTP id
 5b1f17b1804b1-493f87e9db6mr98068045e9.16.1783948054001; 
 Mon, 13 Jul 2026 06:07:34 -0700 (PDT)
Received: from Timur-Hyperion.home (54001386.dsl.pool.telekom.hu.
 [84.0.19.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6df417sm387974995e9.8.2026.07.13.06.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 06:07:32 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Tvrtko Ursulin <tursulin@ursulin.net>,
 pierre-eric.pelloux-prayer@amd.com, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 08/11] drm/amdgpu/gfx6: Adjust how harvested TCCs are set up
Date: Mon, 13 Jul 2026 15:07:06 +0200
Message-ID: <20260713130709.34262-9-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713130709.34262-1-timur.kristof@gmail.com>
References: <20260713130709.34262-1-timur.kristof@gmail.com>
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

Adjust gfx_v6_0_setup_tcc() to keep it working after
a GFX IP block soft reset. On a soft reset, the
TCP_CHAN_STEER_LO/HI registers are not cleared so
the function needs a slight adjustment to how the
number of active TCCs are calculated.

Additionally, let's expose the disabled TCC mask
in the tcc_disabled_mask field, like on other GPUs.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 1c7cd265fbca..3e0cd46cd091 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -1596,7 +1596,7 @@ static void gfx_v6_0_setup_spi(struct amdgpu_device *adev)
  */
 static void gfx_v6_0_setup_tcc(struct amdgpu_device *adev)
 {
-	u32 i, tcc, tcp_addr_config, num_active_tcc = 0;
+	u32 i, tcc, tcp_addr_config, num_active_tcc = 0, num_max_active_tcc;
 	u64 chan_steer, patched_chan_steer = 0;
 	const u32 num_max_tcc = adev->gfx.config.max_texture_channel_caches;
 	const u32 dis_tcc_mask =
@@ -1610,6 +1610,8 @@ static void gfx_v6_0_setup_tcc(struct amdgpu_device *adev)
 	if (!dis_tcc_mask)
 		return;
 
+	num_max_active_tcc = num_max_tcc - hweight32(dis_tcc_mask);
+
 	/* Each 4-bit nibble contains the index of a TCC used by all TCPs */
 	chan_steer = RREG32(mmTCP_CHAN_STEER_LO) | ((u64)RREG32(mmTCP_CHAN_STEER_HI) << 32ull);
 
@@ -1622,9 +1624,12 @@ static void gfx_v6_0_setup_tcc(struct amdgpu_device *adev)
 			patched_chan_steer |= (u64)tcc << (u64)(4 * num_active_tcc);
 			++num_active_tcc;
 		}
+
+		if (num_active_tcc == num_max_active_tcc)
+			break;
 	}
 
-	WARN_ON(num_active_tcc != num_max_tcc - hweight32(dis_tcc_mask));
+	WARN_ON(num_active_tcc != num_max_active_tcc);
 
 	/* Patch number of TCCs used by TCPs */
 	tcp_addr_config = REG_SET_FIELD(RREG32(mmTCP_ADDR_CONFIG),
@@ -1634,6 +1639,8 @@ static void gfx_v6_0_setup_tcc(struct amdgpu_device *adev)
 	WREG32(mmTCP_ADDR_CONFIG, tcp_addr_config);
 	WREG32(mmTCP_CHAN_STEER_HI, upper_32_bits(patched_chan_steer));
 	WREG32(mmTCP_CHAN_STEER_LO, lower_32_bits(patched_chan_steer));
+
+	adev->gfx.config.tcc_disabled_mask = dis_tcc_mask;
 }
 
 static void gfx_v6_0_config_init(struct amdgpu_device *adev)
-- 
2.55.0

