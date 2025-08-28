Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA52BCA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 15:11:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DCD910EA1C;
	Thu, 28 Aug 2025 15:11:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G2Qj4mNa";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76AEA10EA1E
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 15:11:25 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-45a1b066b5eso6052475e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 08:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756393884; x=1756998684; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2xpJxMo/MnG9+KjOlWSrCfrXtFTPcXu1brgtidgdOLc=;
 b=G2Qj4mNaYPJ0YL4wy8Gwl998ICOJP4YeAb/ydtA0uKUcnabzGHSPDmmEXHsw8GQ+fG
 t88j2czRHTMN/CjiswxQ7pmc2aKwuB+tvyaOnMYRb9ASGdmYpGPH41qyvDJAlVq7uYot
 j98mM79Pw+yXs489tsgKErlaXJYofGxNEbr+s4yOKZnaWYBDB52CUtgaw+WdKytcbM6H
 HfOK6VEjaEmYejvQh73Hg55G5RpJ8/k8kroG+kaBV2VxFlGrWucf6fUf3JNF79LsZ5iX
 OuoUp3iAU3jeIolk7hcj8VTaqArZpKWtc/lfuggVN7Eog7H0gkhwLotIUYatrZvNm14L
 WNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756393884; x=1756998684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2xpJxMo/MnG9+KjOlWSrCfrXtFTPcXu1brgtidgdOLc=;
 b=ncefNF5o0s35ggBKpraDHpCJGIf9lr6jmXzGdM5frVupVIGK70Pqwg6peVJrLxSImW
 0fPgvR7jk7Wh1knWP1OL/OZkyiSXo1+n3JGd1F12JVm6WvbsnyXAipOF9RtIuWs21QdH
 vQRAY2amK7Yc4B2Omm/wScHyyXUTonvclOJ2xqMSJAaBgcnTkcuPy+ejgZMIMEfy12Lq
 6LjASHoquQgHZvcqy3bDlp2HM72zVtvsDRBWNRVZT4832pGum6zSHts6njftQA3IJxa/
 SQ9z45BlY0OwXuXV6bZmIoxwuY7tqKWYjWxATO7rh1vI5tMi4T0tc8F7oocGbYUA8s+l
 Oi+Q==
X-Gm-Message-State: AOJu0YwzPWqWJxnUrq8vp0gluY4H1lq6rzVPmh3IparIFdvDOM0/x05F
 RhPYsv9RyvP6zl0u6kgh1ghOxsoILMH98RsmlbmfFYja4J6Bq48ERLf5174xOw==
X-Gm-Gg: ASbGncvN4Fq3UJ3KPCQCER0Dqv9RCx8QUk79IoHJ3ADncfwy0UOlUQD91FP9RRqpULZ
 OBLwCmcpmA/JBrsiy0zXKOgGSDcFSksle1fglCHoXfu37J1LG1IRcXILzED5HavSpayYeD3obdG
 y52cJ5YqAJKMRUxezKHtbt0kzpE+4XOJ4dKmIogijmcSGMRQwCJKU8hi/k8NQrjsGH6wRV38+F+
 Xhw+9haQ6VDTtFQJRgjEx7idJNs2XB62bpOKONJ8pgAU+67aimC2qIzLsfdcMA3c5dLyhVEisqg
 cbKGgqJo952hrdhvDyj7u4wFN7SYIO1qiReiN5G+svL90R0In8TDMNJCm5Yk9Gn8ZDkRnW0graD
 U1cJ+mwl/Pveliq3tfnKVg0frkp3MNOAsAkkCbeXpCoQdzCWzoY5X2i/2OFzXFebICW7EyBiMdS
 ZNQXXKVPWi7JxwjsCmWL4Yj8lxkA==
X-Google-Smtp-Source: AGHT+IHlE7CmDS+w7XhlVTECnHw14txLnC44iDOYXKj1t0yoeFip2AwpJ6EFSkRSIZHs67Z8pdM/Aw==
X-Received: by 2002:a05:600c:1c9d:b0:45b:6684:9e07 with SMTP id
 5b1f17b1804b1-45b685d740emr74249535e9.32.1756393883867; 
 Thu, 28 Aug 2025 08:11:23 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306bffsm77448875e9.16.2025.08.28.08.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 08:11:23 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 10/10] drm/amd/pm: Print VCE clocks too in si_dpm (v3)
Date: Thu, 28 Aug 2025 17:11:12 +0200
Message-ID: <20250828151112.15965-11-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250828151112.15965-1-timur.kristof@gmail.com>
References: <20250828151112.15965-1-timur.kristof@gmail.com>
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

They are part of a power state too and should be printed
alongside the rest of the data from the power state.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 4236700fc1ad..6595a611ce6e 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7992,6 +7992,7 @@ static void si_dpm_print_power_state(void *handle,
 	amdgpu_dpm_dbg_print_class_info(adev, rps->class, rps->class2);
 	amdgpu_dpm_dbg_print_cap_info(adev, rps->caps);
 	drm_dbg(adev_to_drm(adev), "\tuvd    vclk: %d dclk: %d\n", rps->vclk, rps->dclk);
+	drm_dbg(adev_to_drm(adev), "\tvce    evclk: %d ecclk: %d\n", rps->evclk, rps->ecclk);
 	for (i = 0; i < ps->performance_level_count; i++) {
 		pl = &ps->performance_levels[i];
 		drm_dbg(adev_to_drm(adev), "\t\tpower level %d    sclk: %u mclk: %u vddc: %u vddci: %u pcie gen: %u\n",
-- 
2.51.0

