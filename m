Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E30ACD98ED
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 07:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 054EF10ECA2;
	Thu, 18 Jun 2026 07:15:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cFkfjMml";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53FB610F0F1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 19:33:41 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2c40397e3caso1973075ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 12:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781724821; x=1782329621; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=iQZtMnehaDPaW/1htcuGu1b4iDiFaXM/HgU9tJx9XaY=;
 b=cFkfjMmlX5TmPxmOR6QDqmiShCqSi4gxgvRkMatokxOS0xvDeKgAjHvPvjb+5CvW5U
 NI2iBMG5fP+8ZjWjie3Yc98yHI19At9/Kl0obWt+bVtmJCSgv8xKvTUhleoQFki1sAqZ
 X5pPebezk8vOAEESoWs9XfyaOLUtWy2/8I4ZzwkGW5IQfBqRmqr/drJF2CH23nchvFhk
 YPLu1S2aF3p63FW+Aki/bTHEX1fulARCCMYN6gX4aoEc9B/C66jOueAwEf0F/fD6Rqr1
 tK2dZbef+jSWXUwDUcam1OnMrM45yTc2wRr1IwLbSbHOzpx3ua1mSnw7kDIdm1Px9GhD
 LS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781724821; x=1782329621;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iQZtMnehaDPaW/1htcuGu1b4iDiFaXM/HgU9tJx9XaY=;
 b=VUFf0l2R+72ahU0ILmekHWTbPo+b7NNBBrDaWknQgxLRTuZtTTy2p/wt8orzjNNUKX
 kxOdFcPWZskSRrI0wT4OYO2btCKh2vseiSClvHGREQWnwY60dyTpaGQGDmIeaHpVQiYo
 T7vENRBF1e2fhM2Gi3g9ndkvhDvegGu03uwt98aVyuNkz8EojbiBNf6DncI80NBPQLAI
 4sQO/U15PdekBEf46zX0sva5lXas0X3PTAIJeDCOnwPwp7rtt5CV6KnRR1QlvV1KBP6n
 ssME3GnRY3ftYLdrFDQjsQNKjZIZVyz20Q4lvXz3I9R4O0GUYAwMavQn+kpg6AjQJwLe
 YeXQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Kzm1fZjxQ5rf4cByU4vGEGNkYHi6DC/6I3ochpPqonxhYGiL/p31FCvrc/eW8Q8D7ucqbKexZ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyfWs9icIyVemucvAYs/VM8cRWzUKyoi2gntZfUjWn4UvtAk2kN
 M5hgYSqzQ+XGCszRymq8P485xjVJtXcFRR0htTfE5TJ7MlEMlTKSf370
X-Gm-Gg: AfdE7cnaZ4B8G3uxO/FO6u6bzRwYLEqQniz9YYQU1puL7kjmFVK4a5vvq3awbC/h/a6
 ZrgYtBBiH+QtH1eEuuVRlmajMlcC7p4Z0XQdcZxCRipg8upD/g+7UCMmWE2VQRc6v8Vh9fYFDTR
 uD7Rm5pE/djUfsiyNIT+2/IgFOb7LBrHI+PgTpXY3sm7H0pfKsEINU6evCIFI+LU2DD4Pgk+IYc
 NPjsE/SeLAQT2we6uZANTENJLvOA4zAdR6X4iYdVzknyI+X7K78lXsw5O2Th45EwLm8b2ApkP8n
 60HPPFSjI/8nVmuFWOup53j88AYmBx554OY+NPpaFLSO0i/6kG5w/42C1l4qtXiQScIMaVrObby
 7VZisQE5mx4pAX1dSsI+bbPhCPJIIJ5mDV5tvVTZuwRDYxQURCx9FR7KUN7GRiExStBTbp7lFQ1
 S87AKgxkxWG7avQsjXaHMYNZmbXuRNJFsd
X-Received: by 2002:a17:902:e892:b0:2c2:bd7f:ccd4 with SMTP id
 d9443c01a7336-2c6bc20a970mr50252375ad.21.1781724820880; 
 Wed, 17 Jun 2026 12:33:40 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:1886:6b7a:3e78:272c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c4327aca78sm182035555ad.54.2026.06.17.12.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 12:33:40 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/amdgpu: initialize ret before UMC error record loop
Date: Thu, 18 Jun 2026 03:33:35 +0800
Message-ID: <20260617193335.1662613-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 18 Jun 2026 07:15:16 +0000
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

umc_v12_0_fill_error_record() returns ret after walking the pages
reported by amdgpu_umc_lookup_bad_pages_in_a_row(). That helper can
return zero entries, leaving the loop skipped and ret uninitialized.

Set ret to 0 immediately before the loop so the zero-page path reports a
deterministic status instead of returning stack data.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
v2:
- Set ret immediately before the loop instead of initializing it in the
  declaration, as suggested by Christian.
- Avoid describing the zero-entry case as an allocation-failure fix.

 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 14092150336a5..4842340d9d65f 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -690,6 +690,7 @@ static int umc_v12_0_fill_error_record(struct amdgpu_device *adev,
 	count = amdgpu_umc_lookup_bad_pages_in_a_row(adev,
 				ecc_err->pa_pfn << AMDGPU_GPU_PAGE_SHIFT,
 				page_pfn, ARRAY_SIZE(page_pfn));
+	ret = 0;
 
 	for (i = 0; i < count; i++) {
 		ret = amdgpu_umc_fill_error_record(err_data,
-- 
2.51.0
