Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168CFCA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 15:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A662110EA19;
	Thu, 28 Aug 2025 15:11:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X81l9DyO";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4255710EA15
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 15:11:18 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-45b49f7aaf5so6271585e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 08:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756393877; x=1756998677; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8kCV6DEtNpGYfTeZwFpb3+RBLqhq+sIozoAje9AnV3A=;
 b=X81l9DyO577yUS1YO2SWdjNt/iQoJ1eqLtfMoapjWsUcOpcj3OShpgEqivFxaDSlAm
 puAwsjfiiFAWe/tgZiYKqLSHhAnQ9QEcSjUf0/RZbalxh/8bkQGlHtuHAD9WTmjRaehZ
 AwihqT2Mr3QsrgGnk8rWE6SqnrDNE04QKJ9z2KB7KcdO97bHskoXQXX3jU1Hy18Qnqj2
 hgYow19u1pjiT1zz9i/58FjkqJ8xHX3er7y3W/U5ZkTDRJn3WJLVE7O9mYGTnhVRyc9M
 m5qx1AlVyxkSN6GGekbMKH/pHYrsCU5cy8PG85dMDn1BcN7/gxfFXedW/8K/vC5/uetn
 mRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756393877; x=1756998677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8kCV6DEtNpGYfTeZwFpb3+RBLqhq+sIozoAje9AnV3A=;
 b=jol+Q4Y209uMJ1ra/e/iiOW6KL4tqOb3D7vrsSZ+9dn3QpiJYiXQLRg9YMX3nyIlMd
 SH54FKNNu6Zo5oB8FM4PwQjVLE1fGbaMzRaaBCVJxSmtUVSy5Og6IS0+3kaFguptdXXr
 nJ/sKQYfkUOVwxGsVChVXZEp0WOb/7azpvR9yTL8BdCJNimzYBNG3uwzC3/+olFynyXR
 U4KxT/XQiH/o90szvt5S4Bezt7/NoalcKY4CnXGeLyUtlxFSwtBnp17+JoZkiat/UCuq
 JJQrGaRbqzTiqcFaj+I2PunK4ddMFCWExAr45kdWdm9BKjW+QJ3OXNf53McMbGtmn1mi
 kS3A==
X-Gm-Message-State: AOJu0YxufcAXCFmjdD5S4rr4G4hL0j2QC58127iEPzK8IBq9F7syULha
 vv3JLBzk4S79e3vOo8VY1a1gI6WOeO6wNaKIeKVLfkQjQcxYb5hGlrJIJ8bHmA==
X-Gm-Gg: ASbGncvwL8kU2sGO/G4poiNiojsFAxlV9ZNdwM/TVQ7S5f6JJAuRSyAQ/WMOkbZ0x6i
 oS5cwnXk+5QfCgWXbuAKQ6rbAQPhqfuU3PtEadBp3x6K6O6rTqoXrQfOJquev41UGldKk1bI0JL
 NREZSQUxVMCNYa592348/qY2t+pt560fiYtAN0Jcm4fFQ+WJUfSENF0n9TMT5VJuwcSNH6Mywn2
 5iTbYH7k3h1VoUoKG+dphnl/XePzor5zMFVMVAcI758FjZxoECAbXD4PNOb1v5Yqg7aMD53U3KN
 rQZrfDTjoExodwwGo1nu1PpADMm5rGVMROzM1rsVgVNMyRgFqsIledzDiGtnK9RPfMdHXpDeHX7
 TFRBfCsi1YRADPVYBJU4sZNFxyXm/Ng0Hr6nYGkWxT/U2MIP8DvZlLXh9ifeV875YBLfS9KuO5l
 /BjiztRYUcnVZfw+KEkifaCW4Khc4fBQKEGuaB
X-Google-Smtp-Source: AGHT+IEzID93HDQz5W+a57nm2Z23sjjgMufMTc4mD0X9fHFCYof5+t+9Qj3xN36sjdQbAI1jvYicVQ==
X-Received: by 2002:a05:600c:154c:b0:45b:6269:d25b with SMTP id
 5b1f17b1804b1-45b67440939mr86886705e9.37.1756393876610; 
 Thu, 28 Aug 2025 08:11:16 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306bffsm77448875e9.16.2025.08.28.08.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 08:11:16 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 02/10] drm/amd/pm: Disable ULV even if unsupported (v3)
Date: Thu, 28 Aug 2025 17:11:04 +0200
Message-ID: <20250828151112.15965-3-timur.kristof@gmail.com>
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

Always send PPSMC_MSG_DisableULV to the SMC, even if ULV mode
is unsupported, to make sure it is properly turned off.

v3:
Simplify si_disable_ulv further.
Always check the return value of amdgpu_si_send_msg_to_smc.

Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 52e732be59e3..e71070a23b91 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -5637,14 +5637,10 @@ static int si_populate_smc_t(struct amdgpu_device *adev,
 
 static int si_disable_ulv(struct amdgpu_device *adev)
 {
-	struct si_power_info *si_pi = si_get_pi(adev);
-	struct si_ulv_param *ulv = &si_pi->ulv;
+	PPSMC_Result r;
 
-	if (ulv->supported)
-		return (amdgpu_si_send_msg_to_smc(adev, PPSMC_MSG_DisableULV) == PPSMC_Result_OK) ?
-			0 : -EINVAL;
-
-	return 0;
+	r = amdgpu_si_send_msg_to_smc(adev, PPSMC_MSG_DisableULV);
+	return (r == PPSMC_Result_OK) ? 0 : -EINVAL;
 }
 
 static bool si_is_state_ulv_compatible(struct amdgpu_device *adev,
-- 
2.51.0

