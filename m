Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6CDCC6B2D
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 00:24:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5182510EB58;
	Thu, 15 Oct 2026 00:24:18 +0000 (UTC)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com
 [209.85.222.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C60310EB58
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 00:24:12 +0000 (UTC)
Received: by mail-ua1-f53.google.com with SMTP id
 a1e0cc1a2514c-98c786605e7so501319241.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 17:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792023851; x=1792628651; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sRi2ZkH0cqeF76lnycKi5TJ2g+qZsmxD4so7+Rdq55w=;
 b=d5eTP6rbN53jz6Oyuc+jd+ifNG9inH8cPLmKgVZ2Hamoytyi9mtiF7ooTUx6JY2TF0
 3qzMwrxs0TG2tK9ZmrB/OOq6VTZlsJmYC/JlSvh3MroVueHvhaYmKZgUz9fLVxHpEs/t
 Vx6xieqAoHahTrxuyqmgqP5/3qP2tHQOpoT8diJ98clpTaQJIv5KpCikY4C3Kip+4ujl
 K0bDNu5QRb0qI4UJ5FRN05X1D1h23Uh6INhAQWMyoUO8axLapp5g2QOOrzZicBJ1hv8m
 UDjZ5G1GCqkc2z0/lcUOhB3laGaICN3Je8fbeKTKb7xNCIEVkhDIucxgeHR8jfZXXJxN
 Dj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792023851; x=1792628651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sRi2ZkH0cqeF76lnycKi5TJ2g+qZsmxD4so7+Rdq55w=;
 b=sdt7jUTNsyM2cqb/z1l1qzGYGXyFCw7NoHnWBTJCbDjMjVm2OXUnb/V2RrV7xP6rco
 y3hvgjbHOMlnZjf9NnZ0xZuVaC9DFVZDwoIabeTVBL0A0lW/1nhg6Tc4qK7q/Ig/puzI
 JwduI29+p27t/hXHUsmsTZ8S+pHI8gYd2fUxIHnx22Z5H67hYrTYrHxT1SiVi4IyhhYn
 hRZSpPuIc2esCA77f4i29c327zl/tQLwDH3j2IvQ4OXDYSrSHc3UCynCkEG2BSm7wXsG
 LBRNwERhOT2Mzxw+FD+ovkeyQhdvwgnw5lU2RetNNiMaPDbWLHfenPC33RiMrXppnmg4
 dGAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTHR6bMTrEy00IyyZoQ41zfIGI2a8OZzB+qVSf9ZE8pYGonIlDF3z64OkTWKM3ZnUwAh7RXfAw@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL+BIZfzVqFRhHpX00m0oIOD3rHbaTXjSnekqAm/Ret0XXwzM/8
 o0X4DIaHEOpxBWZMYZ9vlexIec/GK4VExXKeofXUmkB0GTYJ0TzF8hEy
X-Gm-Gg: AYBFou3rmsYgRLkjekLKtaxcQ86UMzqpb3S0ggP4VqnB/dNevYk5YGtJJGOdIUXFDV+
 FvjaGEUTgl4xZ2fdrLUnh7VWoJP/a+NwOncreptKQnGya8Ez3bylMu/KtQpi3IlEATymRWLIO7+
 OFj1Moo3FcDHumRr3guqWmlKti2Jyw2EDtywRnbWmwbfcqLEcpcXKotxIaXhJf6FpJuIprJyy3r
 S3HoSMpp7aywLEMQneepy5XfWgnEFQLm2EuOa7wEJ1rZSZPibHP3GbphZFDh1W/jmfZVhrX60Ms
 mkWgmwbmpxSTiR6sprh3fu3letGnehpvpyEcgLEhdaAqbrST+Csk7aJhpz3iFJxTv5TFQwbhyky
 mcvUQ+NI/yJ7s0Y4CrU+tbZK8Z+oyVALpt4beUlYxU+Op6TR8F9EE/9eLdhCCa3GIcq8ONei0l2
 7H9IkkjYPuT7H7c1JWzelxrwy/bAHVnvuRfgXTGVq3gmCkvSaUmL64B4p8XktmnoqcM40R0K36B
 ZRnezJ1GuXWpt5C13CVWAaKU0Uf3fTqPczjNfPW
X-Received: by 2002:a05:6102:f9f:b0:7bb:a70:4708 with SMTP id
 ada2fe7eead31-7cb372f5c52mr5241177137.17.1792023850833; 
 Wed, 14 Oct 2026 17:24:10 -0700 (PDT)
Received: from localhost.localdomain
 ([2804:5698:10de:1f00:932f:8780:96fa:a0f5])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7cbbd178e4csm6445671137.2.2026.10.14.17.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 17:24:10 -0700 (PDT)
From: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
To: alexander.deucher@amd.com
Cc: christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Willian Oliveira <williandossantosdeoliveira287@gmail.com>
Subject: [PATCH v2] drm/amdgpu/gfx7,8: remove redundant RLC cleanup
Date: Wed, 14 Oct 2026 21:23:44 -0300
Message-ID: <20261015002344.98683-1-williandossantosdeoliveira287@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CADnq5_O=kVgSZoqe_ZVQDmVTWNb+OZ2XhmVx=0CPQQfCaf2idg@mail.gmail.com>
References: <CADnq5_O=kVgSZoqe_ZVQDmVTWNb+OZ2XhmVx=0CPQQfCaf2idg@mail.gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

gfx_v7_0_sw_fini() and gfx_v8_0_sw_fini() already call
amdgpu_gfx_rlc_fini(), which releases the RLC objects used by these
IP blocks.

Remove the duplicated explicit frees of clear_state_obj and
cp_table_obj.

Signed-off-by: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
---
v2:
- Keep amdgpu_gfx_rlc_fini() and remove the explicit RLC object frees
  as suggested by Alex Deucher.
- Apply the same cleanup to gfx7.

 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 8 --------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 9 ---------
 2 files changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 5fc19fefca81..7c56e36665c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4454,14 +4454,6 @@ static int gfx_v7_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_gfx_mqd_sw_fini(adev, 0);
 	amdgpu_gfx_rlc_fini(adev);
 	gfx_v7_0_mec_fini(adev);
-	amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
-				&adev->gfx.rlc.clear_state_gpu_addr,
-				(void **)&adev->gfx.rlc.cs_ptr);
-	if (adev->gfx.rlc.cp_table_size) {
-		amdgpu_bo_free_kernel(&adev->gfx.rlc.cp_table_obj,
-				&adev->gfx.rlc.cp_table_gpu_addr,
-				(void **)&adev->gfx.rlc.cp_table_ptr);
-	}
 	gfx_v7_0_free_microcode(adev);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 7f91186ef1d1..27fbb5b59645 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -2060,15 +2060,6 @@ static int gfx_v8_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	gfx_v8_0_mec_fini(adev);
 	amdgpu_gfx_rlc_fini(adev);
-	amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
-				&adev->gfx.rlc.clear_state_gpu_addr,
-				(void **)&adev->gfx.rlc.cs_ptr);
-	if ((adev->asic_type == CHIP_CARRIZO) ||
-	    (adev->asic_type == CHIP_STONEY)) {
-		amdgpu_bo_free_kernel(&adev->gfx.rlc.cp_table_obj,
-				&adev->gfx.rlc.cp_table_gpu_addr,
-				(void **)&adev->gfx.rlc.cp_table_ptr);
-	}
 	gfx_v8_0_free_microcode(adev);
 
 	return 0;
-- 
2.47.3

