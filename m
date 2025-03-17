Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D73C35FF7
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 06:07:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E8C610E2E4;
	Mon, 17 Mar 2025 06:07:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i14Fm3rb";
	dkim-atps=neutral
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15CE310E2E4
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 06:07:31 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-4769bbc21b0so41201701cf.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Mar 2025 23:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742191650; x=1742796450; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R8YYtZEuRtY0eHendlCNc74EX/5YmXe/3PuXaM5iN4Q=;
 b=i14Fm3rbRxshWWXg2Q4brZihKPMLBggRtMv2zoJQJfyMtbBnBU1ptI738hL9mNjMHe
 v9tKp69Ja1QlZI89cl2xAmWglvmaDeXCb6oR3LMnjzH5jhaNXH/DKVr+0Mwo1DJ5I5cb
 BQSnCYHkYD4LUgq/dSC12mg+Z/ImcK6WjX/HPircSlGR0iowKAIoFNs0i3ObpLMv2pG+
 5Kd7b0Mur86kQ3QNO6XQXSF1HVs8CWMg3MY+WTmsSUv4yVPUAHaTSdjsY0CGj5Cc5vu9
 p5mT5c4aEkguVDsN93hc/ZTnQnVJq04XZBRBX8Wv/vOg3h0Q6Ku0uXN8pgEGtdMnfUTl
 2pBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742191650; x=1742796450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R8YYtZEuRtY0eHendlCNc74EX/5YmXe/3PuXaM5iN4Q=;
 b=opKVVx+mva0Vetugs5WYEaFnMapBb5ojiIJQSB6OFPkj8XIHF41N9L6NwZAv9ksREP
 J+HJBENhMh64iVv76Hvmm8LQiwrTeoN2wJkZ1VllQr8NUIWi7JBGVGSkbmOSKCALay+1
 wgHQF8RaV5bvYNP9KCfLBXuTHFSZazZUZXn6xxfuiYidTs/lVTxIzd6091ezTDksj0i+
 MhoOStVngDNyFpERKP6h5hPfs98rczaj14j0bsbxznmL+MVrd7Yi8cT296FJTir3mp8V
 QWQm3C/Q5VeldT2Vd82AqQPWo/Bzyn17lSSRcKlQxQMmhPgJGPPNup4c5IiRbbILKBgF
 0xxA==
X-Gm-Message-State: AOJu0YwcXelGAPeCsg8AwaCBnsRD2fncQhmyy061DHvCNKxgZs0rc3nq
 8CRlLOtMlthO52zeD+RxS+1buoYhAEfsOu4a8liqobsBC/cj1LH9Wu9HTQ==
X-Gm-Gg: ASbGnctCct2nZCaLqkAWXU6O5EX9gt358w2GUA7aWxOka2GfCu16bXvsOc9/tXi0uO8
 BjBAtihKSipBBiywlwEbzK7LNKYURTCYFGOfGuZ4ry4CcfzJeUpYAjKRsKu+lceVHFDwF5ZiFiw
 vy0YGj95VE/+Xv83gdEML+bGyQa9+MX9UQ0SNV1ES/UTagTTaGJgIwH6OMZ65g+CuHv6ClJZF+T
 OF8Wn+pC3xC3PhZaeHzWHsj3Q+jw9B0+0LWy1ISFiJm7LHh8MUE+o0MdJZm4/vA10vH9ucF1KGB
 7hGD9iWHoQgsuDmBTOvYwutooSJ2hinMVxNx9O0b3u6Gnq0aNAmRf042D8EMH7sn7XE=
X-Google-Smtp-Source: AGHT+IHRe23tSBSwe8vVxT+ijsHWDbk7ddJ3bWMxoQbuy1jwl/ojnvk8I8LUXxYicM/qpFUeZN8yMQ==
X-Received: by 2002:a05:622a:95:b0:476:8595:fa09 with SMTP id
 d75a77b69052e-476c81c331cmr144466621cf.40.1742191650083; 
 Sun, 16 Mar 2025 23:07:30 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb7f4f08sm50605931cf.56.2025.03.16.23.07.29
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 23:07:29 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/18] drm/amdgpu: add missing GFX6 defines
Date: Mon, 17 Mar 2025 02:06:53 -0400
Message-ID: <20250317060702.5297-10-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250317060702.5297-1-alexandre.f.demers@gmail.com>
References: <20250317060702.5297-1-alexandre.f.demers@gmail.com>
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

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/include/asic_reg/gca/gfx_6_0_d.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_6_0_d.h b/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_6_0_d.h
index c75aee25619e..a1240dd430aa 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_6_0_d.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_6_0_d.h
@@ -1779,6 +1779,8 @@
 #define mmRLC_TTOP_D                                    0x3105
 #define mmRLC_CLEAR_STATE_RESTORE_BASE                  0x30C8
 #define mmRLC_PG_AO_CU_MASK                             0x310B
+#define	mmSPI_STATIC_THREAD_MGMT_1			0x2438
+#define	mmSPI_STATIC_THREAD_MGMT_2			0x2439
 #define mmSPI_STATIC_THREAD_MGMT_3                      0x243A
 
 #endif
-- 
2.48.1

