Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D80C61DCB
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 11:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1156510F363;
	Fri, 28 Aug 2026 11:41:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qBr7joTx";
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5911C10F363
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 11:41:30 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c207cb16cf5so145090466b.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 04:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787917289; x=1788522089; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B1vGHNBRkCJsgKYB8+tXfh3qIvb3OZjGi6/UcxgjCgA=;
 b=qBr7joTx39CMi8AVLiN9LgoDZIs8k+3oA0Yt7u1QM3EPKYVSpt7x66b/J41hSgp8SN
 DWDU84BROteDw9v3IhvPmDE9jCKT6nTIcx1/16I9YvCwN5i4u16UGgJTIxBlw39QYT6R
 FL8nNma5/CRu1snQ/BWC01n3Xg+i1G50I+/JlQY+sMxJtjsW1LV0mNO4YxJG1ZbKhN67
 Vi5aefD1X1nddXX6PfFXKKCCbwW6UXGs0xHdUDaSfJfOytIkfpDcsLuck7LgTRmtLVPJ
 60PBdFQKtV/aPNktd0mzH/88omhC47DDUMDd/GfTavPn6nCVSN3FJodxswqp9tf4wZ+x
 8Bug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787917289; x=1788522089;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B1vGHNBRkCJsgKYB8+tXfh3qIvb3OZjGi6/UcxgjCgA=;
 b=sAQT78x43Vb3kYQJw6Z9nShvH0G9Ij5oJ/RgMgLIdHR88JyYo+Ga65z2FO8APZ+DfD
 C+GyO50KFucV+b67uv4zUfOMvZXXGbJnurnlOw1Dn0RpE1MhFCAdWXwGSo4bwEJZ1CvR
 CF2FJAl5wyy7NYfiOTpFU7P/0cna56xSOjITQuIYfpdOKAuN26S6GOvsi4J+O+6EMZix
 hYk5rmIEhgWqMzpGTDfbQzEaf9JqTAo1TA6f2kdZMtAj8BCU0N+iNaFwU4t2txk1TpJq
 QfM+ir5Zx49wGPesR72lBF+Rju3pUcuceCEEFGxBgOohqXtW1gRxhSrdbPw0nfN2HHDS
 kPnw==
X-Gm-Message-State: AFuF++lmtoZETfqPeUeZ9ef18NoeyCEXNtnxvrrRkF2omHutePiIasEU
 +FWp8XRJrbw5ctIx/bCbGEvdMvAKYgiqbR4N0CbW6qzAu+5fBKir6I90pragiyb/
X-Gm-Gg: AR+sD11CZhaCHC6odkAbgvQypki1YJ5RLMUn8cipDXB2zQfXdChjzuDo5WVCVbwlQ//
 uchASarZCTxpSYoHaUp70Gla7GYSAYEClnBLl+VmBmUSnjDrI2y39mBLIuju7vTmgiOX8U8qAgy
 qXFLaXnBahU0N+epovZdrN81ektBO5pbb+X1i1INIpFvrjKpFygWg+y6O6B4FMbYpK02dA+A9Xq
 /e//TA/riBlpokj0tIw4I1M3BDFi/uWbVSi5Rp89FnHmJ6DJdL6KplgUM/pju/abBt/gG+wjVBg
 RudR1aUF7W/Mv3k/yFtgu/vzn/K9Hs+qpAZngk4VVWMqhEcplacKytppDlo6XjmCk1HknvrxqX0
 Ndo01zMwb+7GnmpZV2bYzTHcOECwdxtFmEswXAOoND4FVS5ZKP3UYhTuYLBoPPiok4A/qzOrhsV
 ZxmkJk6VFqp1DQQCzBX5O3KmKJl3KxvhWE6frbtEMF/DSp3iebhx9htN0eAl70H8vQddmXHWTnR
 huvCn45INK11QZtNoolwduKzQ==
X-Received: by 2002:a17:907:6094:b0:c25:1b4f:6d95 with SMTP id
 a640c23a62f3a-c2556c0e240mr377287266b.6.1787917288591; 
 Fri, 28 Aug 2026 04:41:28 -0700 (PDT)
Received: from Timur-Hyperion (5E1B9A5E.dsl.pool.telekom.hu. [94.27.154.94])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee288a4sm72549566b.16.2026.08.28.04.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:41:28 -0700 (PDT)
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
Subject: [PATCH 08/11] drm/amdgpu/gmc12: Use AMDGPU_PTE_IS_PTE flag for
 init_pte_flags on GFX12.0
Date: Fri, 28 Aug 2026 13:41:10 +0200
Message-ID: <20260828114113.13523-9-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828114113.13523-1-timur.kristof@gmail.com>
References: <20260828114113.13523-1-timur.kristof@gmail.com>
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

This flag seems to work around a "fault priority problem"
and is necessary for handling faults on GFX12.
The kernel seems unable to mitigate retry faults on GFX12
without this flag.

For reference see:
amdgpu_vm_pte_update_flags() that explains the problem
svm_range_get_pte_flags() that uses the flag on GFX12

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 988dc74642b6..18511e7995ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -644,6 +644,8 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 		adev->gmc.xgmi.connected_to_cpu =
 			adev->smuio.funcs->is_host_gpu_xgmi_supported(adev);
 
+	adev->gmc.init_pte_flags = AMDGPU_PTE_IS_PTE;
+
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(12, 1, 0):
 		gmc_v12_1_set_gmc_funcs(adev);
-- 
2.55.0

