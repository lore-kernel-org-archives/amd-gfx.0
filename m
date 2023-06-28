Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DED7EB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jun 2023 13:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8914D10E046;
	Wed, 28 Jun 2023 13:45:12 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8171210E046
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jun 2023 13:45:10 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-311367a3e12so7138509f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jun 2023 06:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687959907; x=1690551907;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T3t/wW5fk3PRGdIqBreXOJYKawBkpfPasDaYifJOFGs=;
 b=RJy4vnWF+ir+rvrrCUzZloA0XZGu+/m3SxQjhuJr7kfluW55XaK6ZuFL8FFRehYhTM
 U1wKxDFoMqKjkbgHgbvWUK0UQ9RA1YecjMq9p0vB2kHXVtOY7cUFP15T2phZvwTOQprD
 ghHLSo1l5kyINWzjLoQ0LA9eqDaWpYRMrjR246idZLbHwDrdh1HGrzwEOX2xFEWTp+nm
 OS+p3n9TmhS5ha0075e6WB8Yj5Q/rakrcMr+b7HEha2f1FloG23Gdt/MwbaM1VasEB1D
 FeVtthBvROfMXViF93MKoIHd4FZrN+v4S1gsG97ktzwlJiwSZUhre9miPdusAYnq1VeK
 xwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687959907; x=1690551907;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T3t/wW5fk3PRGdIqBreXOJYKawBkpfPasDaYifJOFGs=;
 b=SI+qVWHY93jFjKVwGKtF2AT4U8h1vgPOQscvN4HvBGenL0a764m12MBrpqshqw1M87
 CaqRFwUh3h/47UgEDmxzlUbt95UsbDnNtmuwivc2//Dc6bsmCZ/V3VCAEZFjycsbx4H4
 94sK2Ag8ijvIN+gc66V57KOb8slcUgW9o48NU+mwYSazTEy19zEwGQo6MuzApypYqbvo
 DDuECWTW2cpnF5XJz5LZOPKjLZuRRNqngfPNyea5OqeqM2vRnHSEMUO2ClHw6EXIiVME
 aCFhPlsPHxWZwF0upAPxNAAY0jflRj+cKZ4+Oxvku06wJZHYwo/oEJ4TNACLKc4PH2GZ
 t92g==
X-Gm-Message-State: AC+VfDxo2BiXDP3PqP1iH76CD+b8u/GUxUZiop9hghglTzwm6s2x6jDD
 VQLkD/BXdohm7PnggaM1kekTnLCN0Z2eEQ==
X-Google-Smtp-Source: ACHHUZ5w8C15vPiF01EE5Yweli8Q2L+YXlk2DgIpCV3/d/3r7Q8vyCm4fF2IqIHGfwTLonS6yxyK4g==
X-Received: by 2002:a5d:49cc:0:b0:314:4db:e0ba with SMTP id
 t12-20020a5d49cc000000b0031404dbe0bamr2852071wrs.11.1687959907180; 
 Wed, 28 Jun 2023 06:45:07 -0700 (PDT)
Received: from EliteBook.amd.com (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 j14-20020adfff8e000000b003112dbc3257sm13180037wrr.90.2023.06.28.06.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 06:45:06 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Fix potential fence use-after-free v2
Date: Wed, 28 Jun 2023 15:45:00 +0200
Message-Id: <20230628134500.24444-1-christian.koenig@amd.com>
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
Cc: shanzhulig <shanzhulig@email.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 shanzhulig <shanzhulig@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: shanzhulig <shanzhulig@gmail.com>

fence Decrements the reference count before exiting.
Avoid Race Vulnerabilities for fence use-after-free.

v2 (chk): actually fix the use after free and not just move it.

Signed-off-by: shanzhulig <shanzhulig@email.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 2eb2c66843a8..71a9c4ab905f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1624,15 +1624,15 @@ static int amdgpu_cs_wait_all_fences(struct amdgpu_device *adev,
 			continue;
 
 		r = dma_fence_wait_timeout(fence, true, timeout);
+		if (r > 0 && fence->error)
+			r = fence->error;
+
 		dma_fence_put(fence);
 		if (r < 0)
 			return r;
 
 		if (r == 0)
 			break;
-
-		if (fence->error)
-			return fence->error;
 	}
 
 	memset(wait, 0, sizeof(*wait));
-- 
2.34.1

