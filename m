Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A045C5DF7E
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 12:49:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E28B410EAFF;
	Tue, 18 Aug 2026 12:49:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NKuG5bfl";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BACA10E407
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 10:32:36 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-499a4d1d7f1so3760515e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 03:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787049155; x=1787653955; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AaTdQTQ5KDHtFKgVM7cEDQIq5HDLA+lElYs4fROzZ+c=;
 b=NKuG5bflyMeHeEmPqw0vzp3Ik7ne/my91kfce4tCKV5KifYUnmXMW8a3hOIeJDr6q1
 qGR5tR2nssEq7Lu1dGO29NWfi2uvnepBN+iT4V9qW9e1qs8xnUGQHn2D4U9kIuTAz0X5
 u4LgsRckfIKxS0uA9mcAOKMf9DX74coMKri4LELzMhIbVHRzFAe+CVvrRq0S9d9AgjtE
 R21BOQxL1uRpD4w83UPTRFS7Gl07cHQFD2NyQl8W09dsnKQ/FrDIY1k5Cq4F/5NvX3dG
 Sq4v2o4knQgRcDVvCWiP6hAAQrbUL6fPC386CvKYc+0dcFfMhllZQkxysNeuiBrKH1AG
 OboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787049155; x=1787653955;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AaTdQTQ5KDHtFKgVM7cEDQIq5HDLA+lElYs4fROzZ+c=;
 b=AqbBGv73NO92NSMGar3zVmogmOIrSz+VlSca8gFuyCO29DFaqEqbt/hUKAI5u7+1Cf
 QyuWzJcTN+Z1R+jtEBpjjf+J7SQeSCjtyL5/FCUN8T2pIMJ8KjDXz6Y1O+WPOH4hpW2f
 rZ1kXQun6Lr0b8vdT5Ao2irl5HeVfadtfP9rSBYXA4Oj0jwBDBRz1kYork8N70GkDM3u
 6s4EYx3n2weeuw3lC7GuCN17RjjgWbGcNBpiesPdM4gf/qFXZof0Q2fa714ibomIuwLK
 nlzPPgmMBINLdgGqI1wInPyV/lnfY0pKYgpjlqDbqQ4RP/d5/WaTeCtLWeXC5LzVk8eO
 h4sg==
X-Gm-Message-State: AOJu0YxCdVBvXqkSr2GKBu/mxkZQv2GFAVhP9bjSRng42+Zi34rRLox8
 lZiuvrwNZFpmeSO8NpbQxFHYRLcQzByR7mLz/I+G5q7ZyVPv4WIs1pgn
X-Gm-Gg: AR+sD13vk+eixtxpfRMgPwzuuycN2nB3B4VMcz8q96yDvYoLof3PR9hteCAbn+hAWME
 Q8fieMgVu2IA7BOhtZwcdawjB8viuCglFXoCarSi/GcOExEudJBLGC2oOYiODNdJ82+wSO883YP
 gd4BO10z0ujX4UAKqoL93xaxcGJZrNoInBu7DQHYg7G/iP2Iv+UAjs143lOr1jL/QSjqhwq/VDC
 OGnLVmBkYhz3sPKaFCFUmW2J/GmMdgVFK3bR3GQouM0f8SjWm83U0k/guUsmBp1pM1BjJrXBV/N
 og8KyogPZ/KBYji21x+QBl/7WCiupEPSnByS0Lrabtmy74nFeCZfS6IrFtreP1tQKWVfBjKHDdp
 2EX1QRLjiZz6pHrvvcnSsyDazjX6tWcvqtEJ9KAP8pTmn78YCM+eJdqyK+Xf2N0S0BfGSihoJ2m
 Jc/n7Xusb9t88pTc1cVR7oNiW3c+Mdovi/DmgD1/6YBD9zyNn9wBBwT/j6avcf8xXj8hBKuFhXs
 4yhU6mTW4/pWD+eFnLTI7sAVzqtZdLeZjT/gE3QwhhEfCrrByMCa2Fx
X-Received: by 2002:a05:600c:5306:b0:498:952:e276 with SMTP id
 5b1f17b1804b1-4999fafdb79mr142980085e9.8.1787049154516; 
 Tue, 18 Aug 2026 03:32:34 -0700 (PDT)
Received: from [127.0.1.1]
 (2a01cb0007c59900868885f119326717.ipv6.abo.wanadoo.fr.
 [2a01:cb00:7c5:9900:8688:85f1:1932:6717])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996183b89sm286950535e9.12.2026.08.18.03.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 03:32:34 -0700 (PDT)
From: Amin Gattout <amin.gattout@gmail.com>
Date: Tue, 18 Aug 2026 12:32:00 +0200
Subject: [PATCH] drm/amdgpu: Replace deprecated strcpy with strscpy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-amdgpu-strcpy-v1-1-3ee9b111fafe@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJ80hGoC/yXMQQ5AMBBA0avIrDVpu5DWVcSCdjASNB2EiLsrl
 m/x/wWMkZChzC6IuBPTMieoPAM3NHOPgnwyaKkLaZQRzeT7sAleowunkGi1V0Zb6wpITYjY0fH
 9qvo3b+2Ibn0ncN8PgUo2VnEAAAA=
X-Change-ID: 20260818-amdgpu-strcpy-0e92d18299c6
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Amin Gattout <amin.gattout@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787049153; l=2002;
 i=amin.gattout@gmail.com; s=20260818; h=from:subject:message-id;
 bh=Z9rg6SsGzP7wm590tdNj/0vQ4mbnDFtBl6dpCEg6CDs=;
 b=9xpeH0/D3c0TwnMtjtVQSYoVw0OGC2Mm2rbnA+SzNRcXNiA2RICYmkzbS1cQm5NFbPQv+KFiX
 Dh8hhR4CfEKBrVrHn4sGbn5JTaAPvfHw0loe+4seB43vcRLZgS/+H+S
X-Developer-Key: i=amin.gattout@gmail.com; a=ed25519;
 pk=MSIqDPkCOkwtyP8Fns1m+KFU9SgqoDl2mpLe18vL+hQ=
X-Mailman-Approved-At: Tue, 18 Aug 2026 12:49:26 +0000
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

strcpy() has been deprecated because it performs no bounds checking
on the destination buffer, which can lead to buffer overflows. Replace
it with the safer strscpy().  No functional changes.

Signed-off-by: Amin Gattout <amin.gattout@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index cc6d1a4e4c3a..1caa393c44d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -97,7 +97,7 @@ int amdgpu_mca_mp0_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "mca.mp0");
+	strscpy(ras->ras_block.ras_comm.name, "mca.mp0");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MCA;
 	ras->ras_block.ras_comm.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MP0;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
@@ -122,7 +122,7 @@ int amdgpu_mca_mp1_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "mca.mp1");
+	strscpy(ras->ras_block.ras_comm.name, "mca.mp1");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MCA;
 	ras->ras_block.ras_comm.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MP1;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
@@ -147,7 +147,7 @@ int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "mca.mpio");
+	strscpy(ras->ras_block.ras_comm.name, "mca.mpio");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MCA;
 	ras->ras_block.ras_comm.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MPIO;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;

---
base-commit: 0f23d56f17fdfc7db69d51f64c8b91bbab947aa9
change-id: 20260818-amdgpu-strcpy-0e92d18299c6

Best regards,
--  
Amin Gattout <amin.gattout@gmail.com>

