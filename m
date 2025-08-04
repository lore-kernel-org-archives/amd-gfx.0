Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4171AC87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 13:42:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61D1310E544;
	Mon,  4 Aug 2025 13:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lz5yHpXW";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57ABB10E53E
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 13:42:02 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-459d40d16bdso9047555e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 06:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754314921; x=1754919721; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fEqKIZSQVI7rMhzXBrnNwBcDsTu4NQRum9OQeukKKs0=;
 b=Lz5yHpXWQ1DT8RgbtD/ncxKlWFZG/eHfWDJFJ5LldPOPGr/bwYasXt4mfseCZfRcAY
 JwQEQVeVr0Xi8MaxReq2GQaeABgWKgiv83+Njh3VRrqukre57dxB8k5pzQPDLq2sD9sg
 RYypj6G01sZy1DG+LcrjRrzVGek1lJFm57vCAhYruHNGF7kqVp9Gdweh0k6+fXT+1cVH
 m67gvbScY5qF4naAz7KtUEIaCOw7nuZug28/4RsuwlSBO6jQx0SbyYK4CeJTdmj5aha7
 5s3Aln9k6nDuFmhWf9IuU8tOuzeVWWT/I0pWWqc2W6wzU89CTT89+9T5hBpwfXZpj+LE
 7+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754314921; x=1754919721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fEqKIZSQVI7rMhzXBrnNwBcDsTu4NQRum9OQeukKKs0=;
 b=irGyScoMenudZrcs1K26rwFNX2o/BZgVfrYCLAo9n6Ln3TmFS4eqaIGJdQOjtB3HcT
 te5PyVoAI+4LMGR+tARUsr4heX0kjn1RGaUySm+kLjFu3IP2hT3oeUqSnwyEw6juNiFx
 QB0Noz+vPzWRb6ledNnA8VN34RBp8kQYYhNENAS7WmUd+xOY+vzDplM54oerzuapmvw1
 y8Th2A0bABD4Gg7YkrNKNS8tJtf3NpBvTtfcUU2DU+oIxV22XlToFYxXveJbMfkSGM4O
 O9nBanv8p5Tt/C8emvbmYfJ9wX/nXzhW/SDzZ+vbSnIGL+hRHqWzXyNZSTVyPsvEKpED
 walQ==
X-Gm-Message-State: AOJu0Yx+/Ji8monitJhASwKHVdh8ZR9LuhhVFa7Sl1JvyAq6KbWmT0r0
 YFrH4IOd3PD6aZp2h33Q6H7sQo+EOyTRzac4EsP9kAQtbbm5dKvUPco3krr2ig==
X-Gm-Gg: ASbGncsK1uwWlCASPQMaEL5TRzpBlGF3gwkQUikNhv6QFbhLy7sUYi2ddyk7ff1Vjfg
 sYvnQacF5tuyRWGwqe+Q7zDm0iPE9pqr1I0b7qfIo33Sh+drMC1xQ4V+qGt1XbsypJw4iSIfK4R
 +ljuNhyiixDOVGqkFSWgZ407aJ3RGbqofyuDBPBqBZUTMxYj+kPdCDGalbNBVd3e9sjc3pyEX2P
 K+uBZVd0Lg8q2azZwU6OT7Xi5CjCHzMPyeFsewNFvncw4ndGQNQo4y6qMAyFoNKvbb6QIHiwlql
 bXj8OSz1KJ0LGOrk6cRLEVDH2R37zaLpIFMXkmY3oUNdE4KK4FU6mkJykgMrpDH+mvqwpwgyKvt
 L+zGgXV6RuOhRYrWT0CIe6cin9yo4wzGNlHE6BjmDnAtIj7T3WYuI36uiSaynknrNHnf2RB9Nyb
 zjNvtmNEYxnb3J12/7IeSge2N62g==
X-Google-Smtp-Source: AGHT+IHoihj7mH0lPF5inIQ/JaQzSjuTaFrntOMwbYR3aIqjFKkB5PryKt7H/nyksizuxskQX08kxg==
X-Received: by 2002:a05:600c:1d06:b0:441:b698:3431 with SMTP id
 5b1f17b1804b1-458b6b7bb6bmr54716435e9.28.1754314920515; 
 Mon, 04 Aug 2025 06:42:00 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24DABD00A4734C1D2078832B.dsl.pool.telekom.hu.
 [2001:4c4e:24da:bd00:a473:4c1d:2078:832b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589ee621adsm172056395e9.30.2025.08.04.06.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 06:42:00 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 5/6] drm/radeon: Fix si_upload_smc_data
Date: Mon,  4 Aug 2025 15:41:53 +0200
Message-ID: <20250804134154.95875-6-timur.kristof@gmail.com>
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

Backport of the fix to the same amdgpu issue.

The si_upload_smc_data function uses si_write_smc_soft_register
to set some register values in the SMC, and expects the result
to be PPSMC_Result_OK which is 1.

The PPSMC_Result_OK / PPSMC_Result_Failed values are used for
checking the result of a command sent to the SMC.

However, the si_write_smc_soft_register actually doesn't send
any commands to the SMC and returns zero on success,
so this check was incorrect.

Fix that by correctly interpreting zero as success.
This seems to fix an SMC hang that happens in si_set_sw_state.

Fixes: a9e61410921b ("drm/radeon/kms: add dpm support for SI (v7)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/radeon/si_dpm.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index 47fba85436a7..8bda1e655468 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -5257,6 +5257,7 @@ static int si_upload_smc_data(struct radeon_device *rdev)
 {
 	struct radeon_crtc *radeon_crtc = NULL;
 	int i;
+	int ret;
 
 	if (rdev->pm.dpm.new_active_crtc_count == 0)
 		return 0;
@@ -5274,20 +5275,26 @@ static int si_upload_smc_data(struct radeon_device *rdev)
 	if (radeon_crtc->line_time <= 0)
 		return 0;
 
-	if (si_write_smc_soft_register(rdev,
-				       SI_SMC_SOFT_REGISTER_crtc_index,
-				       radeon_crtc->crtc_id) != PPSMC_Result_OK)
-		return 0;
+	ret = si_write_smc_soft_register(
+		rdev,
+		SI_SMC_SOFT_REGISTER_crtc_index,
+		radeon_crtc->crtc_id);
+	if (ret)
+		return ret;
 
-	if (si_write_smc_soft_register(rdev,
-				       SI_SMC_SOFT_REGISTER_mclk_change_block_cp_min,
-				       radeon_crtc->wm_high / radeon_crtc->line_time) != PPSMC_Result_OK)
-		return 0;
+	ret = si_write_smc_soft_register(
+		rdev,
+		SI_SMC_SOFT_REGISTER_mclk_change_block_cp_min,
+		radeon_crtc->wm_high / radeon_crtc->line_time);
+	if (ret)
+		return ret;
 
-	if (si_write_smc_soft_register(rdev,
-				       SI_SMC_SOFT_REGISTER_mclk_change_block_cp_max,
-				       radeon_crtc->wm_low / radeon_crtc->line_time) != PPSMC_Result_OK)
-		return 0;
+	ret = si_write_smc_soft_register(
+		rdev,
+		SI_SMC_SOFT_REGISTER_mclk_change_block_cp_max,
+		radeon_crtc->wm_low / radeon_crtc->line_time);
+	if (ret)
+		return ret;
 
 	return 0;
 }
-- 
2.50.1

