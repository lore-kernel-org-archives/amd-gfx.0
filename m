Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024A8CA0EC1
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 13:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4017B10E53B;
	Mon,  4 Aug 2025 13:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k1I0p9Lr";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABFFD10E218
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 13:42:00 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-458b8a63233so12186675e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 06:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754314919; x=1754919719; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BgID7r2e1HOELUTuEe87CZpD6N+mj0w0DAsthC3kwYw=;
 b=k1I0p9LrxpK6kYlAv3hYRKwS+fS/uOxSNaY/lVF04sHlhHY2GuVZTkp/i2kRn9PtLb
 XhwOyk4Bcp54vOj2ngvEnZ/zXMK3Iu66Ik22aPlFtdARh0lK36jHAw7u/gbc6eSBZfCy
 gHGNZcK/lIfovLZk0/OumoEmi4Xig3JCiROW8RnP//meNwe8oimNCC0CyPLVxszA149d
 EqjGPRtFwhy3Q4bKm5oIW7Q4GWnEjkGk9+dNMfY1m8niBrNC/yjHH3vgR7P9KW+BJW1E
 Fo3mSy8lQrFuCSyVa/BRm30g/iQD7dUJzAdSj2e6T4cl13cqj9dHCBFX7pRyX07RPp6T
 tj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754314919; x=1754919719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BgID7r2e1HOELUTuEe87CZpD6N+mj0w0DAsthC3kwYw=;
 b=U+O0tyWl2qY0fBQHVk9NAQ45z4T6XZq0A1PlKop/IVhNm3SYtNyK2ORpMmpWz14gLA
 we+mXC0QxQZOeAioISOn7X4keQ6HVF+0b4Ax0Bk+vBCDB/UBOfpoGm/9DdAbnnhYZ6Eq
 omHoLO7hzIyJ0+WyUj7LDMoo/FViGndvdvnNk2VXntP6tp4gl5ZGhU0vsWliJCs+p0rm
 zKAcS4O5veWlw/tpOAjOy58mj6Aa1xkDeQMRwbhPO3OLHD3xTTttnlBNnbplwCtcpiXO
 ilkeBX7EK7GaH2U7DmdEd/8nhv7CaSTG7DDFWI8gRvDkx2mpjUzIGgb9pXnGifNyvlQb
 5EJg==
X-Gm-Message-State: AOJu0YxZa/YAj1c4rnxTxgGVf9VzWGJi/e9C684h5g14gXjgpttFBHS6
 YE6CJ+oQ04eIaqUa9rAvmHDPxf+HKHNREUymi6IkXNkSJ5H3Evda9QWahtGg1g==
X-Gm-Gg: ASbGncsYHYuS4vgIeMsiOuu7/gs+LlTaRmpvBmmIM5Vfcv25Xo+Fuh1eUk3vr/cUd0S
 x8iCunDSRKXPBRiek1zg+hbfTK1LTFFDgQhz0pxm/UkLlLXAFXK8hyGTtXxqmB3prmhOEe2P3xf
 6mxvZXNOIDHC8diqDtimXn3m1T8+NMGUCz1eDNPmaDJxBT1pujjAVcHr7dMh9kPDENv96mzM235
 IsCiXLNmAgpmJFVcxZ6SPK5F4vVUl/L7dv8bcOPUNzMvGkdyzqzIwkCnTlUuDXVinTHreeefimn
 3YvgI4PF+E/cQ+/9E93AIbgNJ/LcEfxIqYqRU6dNQVMYwWrypWzPVRB+dM2fELLQwj1zztOwxaY
 XlKLJkCdP5uY22rqh4iVVi16JGAfsJvn8YGx6j05O4uLe43d7ZXEux6XMPoMshS3nWxPf2Svv7w
 1EXdQpcVx8fMck0sh0pntj2+LGzg==
X-Google-Smtp-Source: AGHT+IHnqjwqzieWHMkePxnJQzJZGlzeppF3UlkndYeMYzPMuI/8dLYJaq4Quy6UAFhq2l05Ult6MA==
X-Received: by 2002:a05:600c:35ce:b0:459:dba8:bb7b with SMTP id
 5b1f17b1804b1-459dba8bc0fmr21473845e9.13.1754314919028; 
 Mon, 04 Aug 2025 06:41:59 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24DABD00A4734C1D2078832B.dsl.pool.telekom.hu.
 [2001:4c4e:24da:bd00:a473:4c1d:2078:832b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589ee621adsm172056395e9.30.2025.08.04.06.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 06:41:58 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/6] drm/radeon: Disable ULV even if unsupported
Date: Mon,  4 Aug 2025 15:41:51 +0200
Message-ID: <20250804134154.95875-4-timur.kristof@gmail.com>
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

Backport of the same commit to amdgpu.
This commit fixes some instability on Tahiti.

Fixes: a9e61410921b ("drm/radeon/kms: add dpm support for SI (v7)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/radeon/si_dpm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index 9deb91970d4d..47fba85436a7 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -5073,10 +5073,13 @@ static int si_disable_ulv(struct radeon_device *rdev)
 {
 	struct si_power_info *si_pi = si_get_pi(rdev);
 	struct si_ulv_param *ulv = &si_pi->ulv;
+	PPSMC_Result r;
 
+	r = si_send_msg_to_smc(rdev, PPSMC_MSG_DisableULV);
+
+	/* Only care about SMC reply when ULV is supported. */
 	if (ulv->supported)
-		return (si_send_msg_to_smc(rdev, PPSMC_MSG_DisableULV) == PPSMC_Result_OK) ?
-			0 : -EINVAL;
+		return (r == PPSMC_Result_OK) ? 0 : -EINVAL;
 
 	return 0;
 }
-- 
2.50.1

