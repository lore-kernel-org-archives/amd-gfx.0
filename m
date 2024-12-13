Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB92E7717D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 08:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F07010EF62;
	Fri, 13 Dec 2024 08:52:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hze0bm4+";
	dkim-atps=neutral
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B4A210EF62
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 08:52:59 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385d7f19f20so692209f8f.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 00:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734079977; x=1734684777; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Cr3DmktarIL8ep3LtsWOY7HkGHM/fJL+lGthxxsNVnk=;
 b=hze0bm4+lZx4l43BgBCI4idq3PmsMM0R/C6M6S8pPao94czJnSS/szf0jNVFq9Oj2T
 YkTQPlGX3PaV45/A90kLEO/Cnn4k2f0Dw8G+6dnH9MjCv9SkRJOfiHyvEWq8IQkmFtlq
 qkUYebhZf73GoBMEVNbJfjOM2bRKBjmTvQeYDlQvY5RLk3VUm/pdSWen8WQsPpb8wF2W
 0uzuKrKEvSNVZ7uaxEsTsShy2M7rwRHsezlVPFeinhgo2oBw/9HEJ6shb3GxEwvbDoRh
 ZQvT40uGiI9gGc1OolqGlFru8gyqvMJMx4yAEmFCOA4+Cs1Yggf3zqyvIOfvLLRqklsG
 hAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734079977; x=1734684777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cr3DmktarIL8ep3LtsWOY7HkGHM/fJL+lGthxxsNVnk=;
 b=gM8cVlXPNhli99Rn/kPjMOwP+1rGWCXN6GqKlyQOGIvkJ1sO7FCk/+uEIKGafeGBI8
 XqcGWKyLXx7I1/FZqx9uiTOIcqJ6zYwuwO9NPtPDkIxa1iVDRA49Fs1WXY/6RG6LXNQO
 aGFQ+nT1MUNVKliyN3nMxnYg2q2x41DuMWRMEvzau/9Br+OUflO+gti3ux3jn/T+A1RI
 2dH4IJg1S+Ttw/FCtLPYi0oqYJHU/WV/eyqhVRg6j/U6zIR4n5c7v3G2EOvXssuu59yY
 h3B2DBJyIJMmMSlOh7dc0tTpoI853Hmho9yVoIGliUhmnTQM5Yzu0cYPP5GXxobeZ9eD
 J//Q==
X-Gm-Message-State: AOJu0YzqcispSQVa2WZ3I4doP8r/GcU/I21m0MW/qDPYOiEbpl9xqauC
 m9fLluSs0AmgpnzXgV3jzJ+9A526uF0lgoA4tElb81u+0FSK5wuGBo9DJg==
X-Gm-Gg: ASbGnct3fSrjobu+5NokS5hPAFAtY4FM0+KCEJNx9QFonzZb1c0vlBQOsYLjxfez0Qi
 n8zZNk41n/WnTOmQPcG1++SpqS/MJrotaGhqxJSkrYORFvbYB+2HCjKtJvsEV0iZ7ug/R7oW4UG
 ypoCVK3nS1O4jtiryF4gHtLT01vVrOmIAZ2+5yBNdN+22NhPFI+LWTOZpAy5luOiICjlhZEA+ro
 Mm/ybv7UB5t4ULlW4m1VaZAG56fY1d9GaXfOLlhJXESHbEqLn8MwC1e0sxPUk2QYwg4gg==
X-Google-Smtp-Source: AGHT+IFrT26KhU+2KAihXJXXnIpP2IZA9/obcPetHL7+2zg+4u/zVBf3cQ3Jp7KKz2+A36ddSiPxdg==
X-Received: by 2002:a5d:6481:0:b0:386:4277:6cf1 with SMTP id
 ffacd0b85a97d-3888e0b5977mr1222496f8f.39.1734079977268; 
 Fri, 13 Dec 2024 00:52:57 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15a3:f300:e495:bece:6ecb:efbd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824cab97sm6392473f8f.62.2024.12.13.00.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 00:52:56 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
Subject: [PATCH 1/3] drm/amdgpu: fix amdgpu_coredump
Date: Fri, 13 Dec 2024 09:52:53 +0100
Message-Id: <20241213085255.1449-1-christian.koenig@amd.com>
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

The VM pointer might already be outdated when that function is called.
Use the PASID instead to gather the information instead.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 946c48829f19..824f9da5b6ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -343,11 +343,10 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 	coredump->skip_vram_check = skip_vram_check;
 	coredump->reset_vram_lost = vram_lost;
 
-	if (job && job->vm) {
-		struct amdgpu_vm *vm = job->vm;
+	if (job && job->pasid) {
 		struct amdgpu_task_info *ti;
 
-		ti = amdgpu_vm_get_task_info_vm(vm);
+		ti = amdgpu_vm_get_task_info_pasid(adev, job->pasid);
 		if (ti) {
 			coredump->reset_task_info = *ti;
 			amdgpu_vm_put_task_info(ti);
-- 
2.34.1

