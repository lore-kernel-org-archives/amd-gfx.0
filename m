Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6CEC54F50
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2026 07:30:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF41B10F30E;
	Fri, 24 Jul 2026 07:30:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i7EHKYGh";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F99110E117
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 18:46:02 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so774467a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 11:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784832362; x=1785437162; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4ythMD/8HygMBBur9HX2jCV0xO6Blk6zNXYU5eF8R0o=;
 b=i7EHKYGhO+3WN/IEAd7bTsL+OaFHgwILUIcoz8/ejDBrbf0OrFV9oi1rIaeN6ioJiz
 +9bGT4Dbc4N+XCfyOcYQaMEBVY6S3/ZjoRBUXrByFoqG0/28+D72DA9YRMbJMhk0H6kI
 JnUi1S8fqv5DeC8pPQPrQy7TyBvgQo1qQB7jQuibxcok6YdHOvvxDBGBMIPV1T8B+7En
 a1FgyV8eTZtgtUMoWElZoSohX7+YmN/40MaLd0X1lc9oqfBIniDzAvDBm38+IfljZuSs
 seulrVgYvhpxJIbTorZ1RQTrqj2IkSVU2pV97S/WEmPbavXCskfYsN5K9j5UjtREETxl
 GVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784832362; x=1785437162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4ythMD/8HygMBBur9HX2jCV0xO6Blk6zNXYU5eF8R0o=;
 b=tF7DrFSqnGS0m1bjEzterviE7cVN4uBpVirahh4b8OC8OGd/DGl7RYP12FZLrXhAMs
 8YMilKJXwj27n6IQBoEOHcendG559H9pwA5y36fHr/J4ZfxORQh+hdAuaNP/fpQcyJ19
 fYP+ATtFLDTUOrjUHghbHLiErGggr5ULQVwXxw21S1Tml6Q57v43duPquhkeU48bpocs
 IRo+bi2gRwVEgnGCieGCUmslZld3ty7xBx+/P0DlVZyC633mq3FcccALP3Vo6asnpS8Q
 e0aFFWP1EoVs9n3cUu1PUZRJPYUwkPAWorO5BvoMRgXuI8IAD+e9w6vX0irTZYGhPtgK
 THsw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqp89RxvRw4ip58MgJ14kySjx2RI1Gju9d3D25NYsRzLPDBbJe90gsLZOvxU7yk5zR29csn0nA5@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxT5LbTSQFZcIEEx4As+Bw0Xex/8dBCbkgXWaVpuOEQbNmeq45k
 yHbRhrD03hRbR05hFm88YwGvpUFGG2h/wFKbQF4bLU1YeGrR6a7PP4SH
X-Gm-Gg: AR+sD12NvN+NB8wvA5RyrBiX/dmeR6im83qis1W+gEmUdSRnaFnCu7PhcVRoSu3lAsd
 cYnvwUK1KyIzKSPqQm197/xNZ+tPgLv3zFOoBmthIk9bSL2+3+ZiKRtwt/orwDjc4QhZSl9NAk6
 7YkZn5BwF6yiiE5CaQGhYOrwEgMXPzRQNzUuA8cpqtIJqlvHlK9AKkDgvByZ389RT82zxCq3AMX
 FMnvbo3fgS0ThO6fTyUe8EbD7dlVzRiCf+cZSTanprFj1mW4A2/lAjlmRTL+9PgUjbJOd0calG1
 hdREKYXPJQ+j9etGvH2ec/zR20+zIFB00PjgQXJtzvKXNc0aahffzwtZXndulKVtGVsMc9MsWSt
 O0G7ppoL8/Zf17Ii3fEhmUM9BQKeKPBjuDcI3U7oJv5LWeXWJOuOd40MNzdutq2m1XNLfoaik
X-Received: by 2002:a17:90b:524b:b0:38e:250b:122f with SMTP id
 98e67ed59e1d1-38ec6461d6dmr4058236a91.16.1784832361816; 
 Thu, 23 Jul 2026 11:46:01 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 11:46:01 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: cocci@inria.fr, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/36] drm/radeon: remove conditional return with no effect
Date: Fri, 24 Jul 2026 03:45:05 +0900
Message-ID: <20260723184538.3888637-4-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Jul 2026 07:30:26 +0000
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

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/gpu/drm/radeon/ci_dpm.c |  6 +-----
 drivers/gpu/drm/radeon/kv_dpm.c | 30 ++++++++++--------------------
 drivers/gpu/drm/radeon/si_dpm.c | 14 ++------------
 3 files changed, 13 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index 703848fac189..11707f5aaa6b 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -5244,11 +5244,7 @@ static int ci_set_temperature_range(struct radeon_device *rdev)
 	ret = ci_thermal_set_temperature_range(rdev, R600_TEMP_RANGE_MIN, R600_TEMP_RANGE_MAX);
 	if (ret)
 		return ret;
-	ret = ci_thermal_enable_alert(rdev, true);
-	if (ret)
-		return ret;
-
-	return ret;
+	return ci_thermal_enable_alert(rdev, true);
 }
 
 int ci_dpm_late_enable(struct radeon_device *rdev)
diff --git a/drivers/gpu/drm/radeon/kv_dpm.c b/drivers/gpu/drm/radeon/kv_dpm.c
index 1693b36fc52d..fc5252ff2a26 100644
--- a/drivers/gpu/drm/radeon/kv_dpm.c
+++ b/drivers/gpu/drm/radeon/kv_dpm.c
@@ -843,16 +843,11 @@ static int kv_populate_samu_table(struct radeon_device *rdev)
 	if (ret)
 		return ret;
 
-	ret = kv_copy_bytes_to_smc(rdev,
-				   pi->dpm_table_start +
-				   offsetof(SMU7_Fusion_DpmTable, SamuLevel),
-				   (u8 *)&pi->samu_level,
-				   sizeof(SMU7_Fusion_ExtClkLevel) * SMU7_MAX_LEVELS_SAMU,
-				   pi->sram_end);
-	if (ret)
-		return ret;
-
-	return ret;
+	return kv_copy_bytes_to_smc(rdev,
+				    pi->dpm_table_start + offsetof(SMU7_Fusion_DpmTable, SamuLevel),
+				    (u8 *)&pi->samu_level,
+				    sizeof(SMU7_Fusion_ExtClkLevel) * SMU7_MAX_LEVELS_SAMU,
+				    pi->sram_end);
 }
 
 
@@ -902,16 +897,11 @@ static int kv_populate_acp_table(struct radeon_device *rdev)
 	if (ret)
 		return ret;
 
-	ret = kv_copy_bytes_to_smc(rdev,
-				   pi->dpm_table_start +
-				   offsetof(SMU7_Fusion_DpmTable, AcpLevel),
-				   (u8 *)&pi->acp_level,
-				   sizeof(SMU7_Fusion_ExtClkLevel) * SMU7_MAX_LEVELS_ACP,
-				   pi->sram_end);
-	if (ret)
-		return ret;
-
-	return ret;
+	return kv_copy_bytes_to_smc(rdev,
+				    pi->dpm_table_start + offsetof(SMU7_Fusion_DpmTable, AcpLevel),
+				    (u8 *)&pi->acp_level,
+				    sizeof(SMU7_Fusion_ExtClkLevel) * SMU7_MAX_LEVELS_ACP,
+				    pi->sram_end);
 }
 
 static void kv_calculate_dfs_bypass_settings(struct radeon_device *rdev)
diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index 4b10715f951c..4323f86000ac 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -6418,22 +6418,12 @@ static int si_set_temperature_range(struct radeon_device *rdev)
 	ret = si_thermal_set_temperature_range(rdev, R600_TEMP_RANGE_MIN, R600_TEMP_RANGE_MAX);
 	if (ret)
 		return ret;
-	ret = si_thermal_enable_alert(rdev, true);
-	if (ret)
-		return ret;
-
-	return ret;
+	return si_thermal_enable_alert(rdev, true);
 }
 
 int si_dpm_late_enable(struct radeon_device *rdev)
 {
-	int ret;
-
-	ret = si_set_temperature_range(rdev);
-	if (ret)
-		return ret;
-
-	return ret;
+	return si_set_temperature_range(rdev);
 }
 
 void si_dpm_disable(struct radeon_device *rdev)
-- 
2.43.0

