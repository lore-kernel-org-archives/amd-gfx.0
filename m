Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C460CA600E
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 07:43:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B34FC10FCEC;
	Thu,  8 Oct 2026 07:43:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iyuTOvzV";
	dkim-atps=neutral
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 061F310E5BB
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 13:26:37 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id
 38308e7fff4ca-3a771ad2a9aso16528851fa.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2026 06:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791379595; x=1791984395; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NfnoS6laDtDOjlhPtBWxVPWGkEBbm6NCgizgXhR32xk=;
 b=iyuTOvzVVBIJ8xK4M+83Crw+yoOt3rWdVRN0QCi20WYE8YwTvWoA3TlW5I/cfVZ48E
 13tMFsdicRE3rUxtm3O4iwkf14X+mtSR0982aafInYH1FfJ8Dr8lxEFcVaT2fDcDK5ZG
 aYVOIRTUmntAlW+EQh8e2sbHwOORzVJjMaWZvBkMLNcRcRvEDOWBrGZU8hEVmdvHYI4k
 ijMBCaZqpz/SQ/BCXld7q1ANd0alqLexSobWABiU+3H0p5oJCpccuEwTPOjiluKRinvV
 S0Fmv9veSIS8L93vUPD4IWs6TZ61AoAkUxAcvbSLbmty12e3qVfEi0kBCL35Ela594Uc
 IW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791379595; x=1791984395;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NfnoS6laDtDOjlhPtBWxVPWGkEBbm6NCgizgXhR32xk=;
 b=SEhtIPRqM0ZmShCSgt0GPdXahkLwiD1+T7rQUdMqTgCQEVu1Errb4LTICf0PsBbZDf
 byFf3MfRmKe7/KgCLvclRiEBdNw6EQ/T4YhCunb5FJrf6yef2YvrX36yVxXzzWm8z+AB
 O+eDqhIXszE8VQLWa+eXYSO7cttrOPyZ4dJE8rmlDPZGvXKM9kzaifoZaGf4MUrrOzRe
 11+t0SWH6uS8vDvCE0Wm64ZMtOYaMuDiiU2oRc2TMP+J+e8URAPOT99ZZDr/CzfyQj79
 FqsF6JjEdv10WwQ8XD0kRvwIwYz/HujBeRTirv1oWsohlhJvMGAjvyZ92VNXd4IHWX5u
 IiEA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYxjJ1uum3P378BvJdCc4cOnrRqKn8OtERVAfc8wgMVrq8nEbesHTUmqzue0zjX1QG3Afh+D/Y@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIwIoFkqncOkMxtAstVv8x+Txwd5N+9N61ZoA0mkPs4IkUynCYb
 Q9eBD/o8QsAwuTG64rc1rD+Kr5hhD3sRQvMmMsDOjGTPSTxTZshyJC3s
X-Gm-Gg: AYBFou1amqL/Fd1PsF2rSLjEDTbBGgbdw5yw+R61pJ2SzOOlBbihxUAynTwuKB+jRXQ
 5Wr2m956ic1eBt0uyptZd9gr/RUcABBFk+20CQV13IPQDrkd6Mgza/77so5rOo1/8AjidWITz64
 Z9KIXM/CDfYt3/RYAmlg6GQiW969aue+Lbg8qIkxIl1CoGowBivSOvAG8Tj77O4R386hEhx3WiI
 gAj88A23Q290xVAz/P+kdfGleJzeM0xvUg/UfVd4ZeWdAe9tRyDiOHqgdv8V9DSFZ8rNac0piH2
 jRDhnFMoCmeTyeCfYcR/w8GYmlz5OwPTnzyF1I9hGmFQEo8Z2dno3i9JjM521+pdKrR7zc2EOVD
 HpGeuEHor20YhJvyjBmcQDsxQeymaCZcDQXGO1w1JzqB88KTs9oshtNDhc8ugjzblQn/9E/s/L6
 k9b/sLJ63ys6ylFgQ9J9EBQVkr56TxIFfv9vKf4nbExCTmDAsMhAeBvvzMd6dV8Oh+0YWFb/48p
 q5TMrBLAxsRx7VrEdC4XhzOGes=
X-Received: by 2002:a05:651c:b12:b0:3a6:5c8f:857 with SMTP id
 38308e7fff4ca-3a9941d9654mr13497871fa.8.1791379595005; 
 Wed, 07 Oct 2026 06:26:35 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9a1d33f1asm6191851fa.11.2026.10.07.06.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 06:26:32 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Leo Liu <leo.liu@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, Yinjie Yao <yinjie.yao@amd.com>,
 Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10] drm/amdgpu/jpeg: set no_user_fence for JPEG v2.5 ring
Date: Wed,  7 Oct 2026 16:26:18 +0300
Message-ID: <20261007132619.121324-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 08 Oct 2026 07:43:00 +0000
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

From: Yinjie Yao <yinjie.yao@amd.com>

commit 79405e774ede411c6b47ed41c651e40b92de64a2 upstream.

JPEG rings do not support 64-bit user fence writes, reject CS
submissions with user fences.

Fixes: 14f43e8f88c5 ("drm/amdgpu: move JPEG2.5 out from VCN2.5")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 3216a7f4e2642bda5fd14f57586e835ae9202587)
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Roman: Version 5.10 does not yet support JPEG2.6, so the fix is being
applied only to JPEG2.5 ]
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-63847

 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 8c84e35c2719..dfb96f052f6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -566,6 +566,7 @@ static const struct amd_ip_funcs jpeg_v2_5_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.vmhub = AMDGPU_MMHUB_1,
 	.get_rptr = jpeg_v2_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_5_dec_ring_get_wptr,
-- 
2.53.0

