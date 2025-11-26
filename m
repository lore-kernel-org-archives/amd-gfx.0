Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884A5D10F45
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AD4B10E607;
	Wed, 26 Nov 2025 13:30:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fRmfo/Pl";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 153BB10E57A
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:30:03 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-42b32a5494dso3531813f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 05:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764163801; x=1764768601; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2TTNPN9c+xpmcv7z8GEF87sbgHV8iLe4+uO4pfyKZPI=;
 b=fRmfo/PlxZw5PNfPfgeI9ehBX+dY1fO1ccsU8rFBjgvqoOXb8R7nP6uvVtyCQJlLzx
 HXOfRacLLvdDdTDjcSP6d5eVsYXMnaKEwV0qUSbR1NkC45dFNukjbtwpNjpgopijQNLA
 L35jd2VnOxkJmJiVzEqpX9txdBT9ypMYsDkB3m9U9/RGMxx8BtElgSLq7T0DmPNcqmHn
 fvgSiu6cLXh8QuPWSeou0X/9qus22hGmnNwV3smwD4aoDnHsn8qEtLVZo9ltBNdraLMt
 lmA2sR7zrRTZYSXOQhUC94Hipv9LezzQqe+SgekBr70/2wEkBvB7/AwbPrRNhNlLc85a
 dYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764163801; x=1764768601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2TTNPN9c+xpmcv7z8GEF87sbgHV8iLe4+uO4pfyKZPI=;
 b=qkThIZrvndHevWNTRbXq8InbE1G1zxJxCB4h9Jw81s9WypAjIStREw+mXI8I4cGVOC
 Z011q5j9ogDEcVZWTmTlu59hQik2AzK5zBxdIHPOUGA1MNxcZuzvnI4KEPt9y9FlUnwc
 LAeqL8mYPLwmM1pm5z2LRLqrhXR6VM9uNK2vR4GLA0QLRmsRNIGw7qz8eNMYf3Z4mXll
 yl0rdOBpx5JnDhOYfNqAYiEch4QP+3G1Of3bfaBL7pLRiPD0xco5h5Ou0Y/FHmuZZiwZ
 xf1bc9JHzKfq077n61zyBFZfmnpJuO4lmh22CmQ6CXLzN2EY7CWgVgjC7Evk/h/AAEfQ
 iiqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+zwm2PIzu6LgNJipXQ+XrkqiHxwlKZGR2GNcaGqGiF+wpJFXA4pesHOHBxxipmrxS7qNbTwOR@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzyEgpWhwlL2iOqYJ5wI0Wvw2EDma8aLnDoRNuzAoEkzkyeB9Eb
 0jazXOqCqdkuBftKy7BJFNbalMj5hok581rfNKt+rYfgAu5bp3/vLrkb
X-Gm-Gg: ASbGncv2tICUE+KPYtmDHJhBqz+LpRnyuWlTDlg8NzRcZcBO7/hxJuQYrLWNgM+yDX6
 fsucjPb3lyoTB2GDGLdJa3AvTu66z2VXnxIl6B5OcYoYNmrBgWlP+N5lZzaX5Y8vjeC4MN5a2OE
 MO2O+1VVhjy4tk+D6DwNH918rRIK/DB0uu+tXYXrgTi5vY/Blfwd6Xl9gsixHOmKBJM2vg69jJy
 SG9HEfYX3wdDhfsj9qHc4ex8lLTlcpYjKnv19qt6/+H8fpoH8/S6hKH9XTZrmhNgbIsHfSF0gVs
 RJaD8MVRiSxK9Zmxho75cS8Qu5pLTZpR8jq09GlHAY5Z8KPpdyKdeYG1Hl1tubk+f2jaVLbFfLF
 rBX3MT3FMDJPHT6GcWuFrx2TpgS+wRGtsNCo7j2Fzkq/Cl/8DkvRv6HF+q93Gtw8M/23x/FtZJT
 fPo7XYxlhpTc5DaVzzCa03tW48+r4H1hklQvOS7m7bxu6ImCAWTkjN6l2rXUFrG8bmnjEVQz+/X
 IkOHa4JCj4RrwVfhKA=
X-Google-Smtp-Source: AGHT+IHHsqVF5+jd84QUQfIcaHwbUotTq49IepNwj/TEYNft1WlnWtq/XL5tZlTxTxcB6Ghh7VBgHQ==
X-Received: by 2002:a05:6000:4203:b0:42b:3dbe:3a55 with SMTP id
 ffacd0b85a97d-42cc1cee3dbmr19314792f8f.14.1764163801483; 
 Wed, 26 Nov 2025 05:30:01 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24D8E6005908B7D279C7B6B2.dsl.pool.telekom.hu.
 [2001:4c4e:24d8:e600:5908:b7d2:79c7:b6b2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e454sm40537696f8f.2.2025.11.26.05.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 05:30:00 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 06/10] drm/amdgpu/gmc6: Don't print MC client as it's unknown
Date: Wed, 26 Nov 2025 14:29:48 +0100
Message-ID: <20251126132952.150452-7-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251126132952.150452-1-timur.kristof@gmail.com>
References: <20251126132952.150452-1-timur.kristof@gmail.com>
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

The VM_CONTEXT1_PROTECTION_FAULT_MCCLIENT register
doesn't exist on GMC v6 so we can't print the MC client as a
string like we do on GMC v7-v8. However, we still print the
mc_id from VM_CONTEXT1_PROTECTION_FAULT_STATUS.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 499dfd78092d..f6715648b08a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -610,23 +610,21 @@ static void gmc_v6_0_gart_disable(struct amdgpu_device *adev)
 }
 
 static void gmc_v6_0_vm_decode_fault(struct amdgpu_device *adev,
-				     u32 status, u32 addr, u32 mc_client)
+				     u32 status, u32 addr)
 {
 	u32 mc_id;
 	u32 vmid = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS, VMID);
 	u32 protections = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 					PROTECTIONS);
-	char block[5] = { mc_client >> 24, (mc_client >> 16) & 0xff,
-		(mc_client >> 8) & 0xff, mc_client & 0xff, 0 };
 
 	mc_id = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			      MEMORY_CLIENT_ID);
 
-	dev_err(adev->dev, "VM fault (0x%02x, vmid %d) at page %u, %s from '%s' (0x%08x) (%d)\n",
+	dev_err(adev->dev, "VM fault (0x%02x, vmid %d) at page %u, %s from %d\n",
 	       protections, vmid, addr,
 	       REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			     MEMORY_CLIENT_RW) ?
-	       "write" : "read", block, mc_client, mc_id);
+	       "write" : "read", mc_id);
 }
 
 static const u32 mc_cg_registers[] = {
@@ -1089,7 +1087,7 @@ static int gmc_v6_0_process_interrupt(struct amdgpu_device *adev,
 			addr);
 		dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
 			status);
-		gmc_v6_0_vm_decode_fault(adev, status, addr, 0);
+		gmc_v6_0_vm_decode_fault(adev, status, addr);
 	}
 
 	return 0;
-- 
2.51.1

