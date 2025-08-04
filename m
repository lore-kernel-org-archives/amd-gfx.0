Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D923C87FD1
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 13:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02CAD10E218;
	Mon,  4 Aug 2025 13:42:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J8+SF4xW";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFF9410E547
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 13:41:59 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-459ddada9b1so6055175e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 06:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754314918; x=1754919718; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JaSdc0BSgIHLfjLQqOtSaVAqfWc35w9KEE/WEn80kFA=;
 b=J8+SF4xWosBc+95SwPTx7hINCisIqiSRJ2ukVIyVY6W+/uJuLn4ZClVQL0dhWLqp2F
 JDrbo1A8dujPu5FitEw6BiTuDlB40dpummvqPd5eVA23/yEBS7UF94h+zuSLxfsOZmEL
 77KPcNRG1f3qWQWScu17LBzg/bU6JzCtUTgxy0TJCvNEe+55GtchIKD+avGpRHR+DlYv
 3d5Z6NIft1h+dUobciHHMavrOpoZb9lYrmRSNNaIoKQwUPXK2aPpz8OTOatWaRFQdgVw
 6XE7xDzISZl7izaCcq9YrDK9/Rjqmy/DxmekO6dTzOjE4sE/VrSyIe40TyBO9Ts3pfgN
 lj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754314918; x=1754919718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JaSdc0BSgIHLfjLQqOtSaVAqfWc35w9KEE/WEn80kFA=;
 b=WJonDZu2tEJSpXIv/2A/d27ePRlySXWJD5YjbU5zGvQYdjnZ/ji/7VSTjUdrrfS+ql
 qs95E8fMbhjN+8saw8q+vghRXS5yLlpvELwCjsKdP2dhZUSXJ4H7gQx94mjwYllcljge
 VMLo7HUMliSNnT2Xz43gBU0lmq/Ww9DsIKfCw0goo5LTn9F0gVivGpUmc8N5s99AZl4E
 8iiZpfgQoQvWvmi7F2kCtbEwEei3Bx7grekE4lwrIphG9vPTlYt31u3a9nd6tlPqoZ58
 pLmxgSvJu//ppQCsXWRO5atCKVzCgCUoD9hxmTZg7GoLR5gOqlPbtWE/ClXKs1kHM0cD
 mymA==
X-Gm-Message-State: AOJu0Yz2h3+aczxv53dU6ssDKtmTKSg64kIcqy1nLnTgmLHawNynMW0A
 akG/BkpahsfSszwSJDr3ouKGVWkVnWXmoZgFByUfXBvoXHMYlQMFKkEgCERm8Q==
X-Gm-Gg: ASbGncvFhG5t1SGuLqSJf1Bw/7PIy4EZyyI8C9VtcH+NSeIIcqxuQqiSZRH91MLLaaU
 ZJYZ0O/GI/Z3aiyUt97UVSDLPyETJ3AUcQpJvAYFfmWjPxKq5YJ1lzDbcDFx/AWKpWf5cyms7kf
 X+FLuFINf9rLZOeup0+tnHuufJ2oxNaPuMVXnLEGtOWKRHJkcHDMsANNJXqxE7smKKbUFJfJrkX
 albKIC+1xXY603byZ+nyl8S/rdYDgfljOKYy0qLS5JyNUI2t41srwa3b2+qLEpyI8nOrmdrnAEt
 kubAltUv+sUDMZdvr2rBbFHjUL1RA0Oko0Fvqdmqv2g/2jJ4BwO75al788B6M3ZSlDnaTmM+8b7
 6d+CxlsnlKcasMWNCxei+Zx1y/wQeccHofDEfdbytsfTtR8Io7l8//sNp/nYqH5dHLAH2fSc9lv
 IADbf0fF2ciZoMo1IGF+xNz1rifQ==
X-Google-Smtp-Source: AGHT+IHkBIajBr+b6sQ73Qlw4p5ku+Fpt0yE+HQQPA0gwiansdT0h103p27wQ5B4BaKQS0iLCq0EmQ==
X-Received: by 2002:a05:600c:1e8c:b0:456:11cc:360d with SMTP id
 5b1f17b1804b1-458b69de114mr73441415e9.9.1754314918221; 
 Mon, 04 Aug 2025 06:41:58 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24DABD00A4734C1D2078832B.dsl.pool.telekom.hu.
 [2001:4c4e:24da:bd00:a473:4c1d:2078:832b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589ee621adsm172056395e9.30.2025.08.04.06.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 06:41:57 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/6] drm/amd/pm: Disable ULV even if unsupported
Date: Mon,  4 Aug 2025 15:41:50 +0200
Message-ID: <20250804134154.95875-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250804134154.95875-1-timur.kristof@gmail.com>
References: <20250804134154.95875-1-timur.kristof@gmail.com>
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

This commit fixes some instability on Tahiti.

Sometimes UVD initialization would fail when using DC.
I suspect this is because DC doesn't immediately turn on the
display clock, so it changes how DPM behaves.

Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 52e732be59e3..33b9d4beec84 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -5639,10 +5639,13 @@ static int si_disable_ulv(struct amdgpu_device *adev)
 {
 	struct si_power_info *si_pi = si_get_pi(adev);
 	struct si_ulv_param *ulv = &si_pi->ulv;
+	PPSMC_Result r;
 
+	r = amdgpu_si_send_msg_to_smc(adev, PPSMC_MSG_DisableULV);
+
+	/* Only care about SMC reply when ULV is supported. */
 	if (ulv->supported)
-		return (amdgpu_si_send_msg_to_smc(adev, PPSMC_MSG_DisableULV) == PPSMC_Result_OK) ?
-			0 : -EINVAL;
+		return (r == PPSMC_Result_OK) ? 0 : -EINVAL;
 
 	return 0;
 }
-- 
2.50.1

