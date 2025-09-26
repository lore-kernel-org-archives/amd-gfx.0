Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D02CAC5B8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:26:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEBB910E4CF;
	Fri, 26 Sep 2025 18:26:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i1noTvkE";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7095110E4CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:26:32 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-267f0fe72a1so20535475ad.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758911192; x=1759515992; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L3HtOgH/frn7EfY61J1CJLDBkqJO/1iaEkVBK/X3hoA=;
 b=i1noTvkE1Ar4uoHcJ61TSeOQP+77rqS4jPe/RKYPeld2+9J10tpywpW0Z5XtdVUmIb
 jmxwzZuRTp0uq91bDYDBDEDTCKleO/10iFE2DcN58LrIsIS24KUA2LmsG+STOse78L6R
 IIe7KJCvpHCnt1F7Lz8cs0M2x6l1zK3aftvo91JfKV9zIDblrO1B8qMPFxaGctJcH7nJ
 dIX8GxCLuPavvtKJkYlzZOJB2CJjFGQHcX+forrdQYmNytsJBJnvzGg3CPYRhZEAIeBM
 rT6BYeflDTG2+Tz5koknz1qXBcKTnludP1OG0e1UEhXMeGemG7XJ4LWYUSL/FwyFwU1H
 Qs7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758911192; x=1759515992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L3HtOgH/frn7EfY61J1CJLDBkqJO/1iaEkVBK/X3hoA=;
 b=teyaCK+wgb10jWnsMy3sbc9gFFxgiQ7QZzXgcY9r/B7tGBsyrFN7OpZ1g+5Wrdth9F
 tXr0EhXv5Kq0W2t2NokkP2RQ7T9+sTIdnNpB3gs6h5IlES2hU+beTG705wnUJ9pFM88l
 09sVvKp4Tq4uZT5vmKqD3tvN1VWr6P6lzCRX5lWslSUBhdNmiQXEfj9ho0mT7LEcfmYm
 jCDwaEqUlnoMUVPMzkI4A34csiUwKZOGHvFuwFl/c+fEp8wHG4EoaMqN1forwgEv6ALy
 sYNaf+gvHCnUBttSADdbi2GkE8YdLaZaeMHsuwg2hXLcBPJHUSg53hjOiuc82RN7K6re
 TQoA==
X-Gm-Message-State: AOJu0YwUkgwcBIropWz2x1BVMVBbvhpnDoZPr39xS1YbmiRRfR3uB0Oh
 TRfl8lWTzeSohTtdTqh1bdvEXIItyAg+qDdszeuTLrswUaniW7/gsuf/pF1ANBt/
X-Gm-Gg: ASbGncvB3QZ9oNEU7K8MtVubVU1xgQWqaZe6uhkt2o0kmCVdLHsYmnr9OeofMwETJl/
 0FFiaZCHunSwJI2Dk5JbaUHU7tjfw5+0OZL1fljc2A/YM+SFZx3kpMTI5J0RSbnUISu7NWtb9Wi
 7GZxYwAtqqUU2Cv0ctH4BNAb0DfAr9bnKkccpi3Tl44nxNuSpN024jkRfsgLthgD4Om47qGhUrz
 JLDfuwOaxusFYufTOSpjaBF/6b3Rf5weQtI3SOTs33mfHP0JsSpGQuaxrFKSgkA5AoQj4i5RDLo
 qnifMABvDIzDjlde7mVAjKQl9YfjDYOppZBA65NrRGbXPvu+NPDP3QU2w7igzZu4Rkosj45WIww
 a36Pz4a0mCR9sDBOF2LsWhjaY4uVy59CmNF5KkwKqRLwwzR1egDZmU7EHE9J5iQVUAUc5ACnYd4
 FS/G4p32lcCuf8sx+tW8vl/l2wREghPA==
X-Google-Smtp-Source: AGHT+IGHI7UkMUir7nCwL5T1YqqER2PQIuOaah/4euw3MUkzWH/iGX33v+HnhzjV+gsVs6gddl2Cvg==
X-Received: by 2002:a17:903:3bc4:b0:25c:abb3:9bae with SMTP id
 d9443c01a7336-27ed4a474ffmr84000035ad.48.1758911191903; 
 Fri, 26 Sep 2025 11:26:31 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb255sm5352131a12.5.2025.09.26.11.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:26:31 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/3] drm/amd/pm: Disable MCLK switching on SI at high pixel
 clocks
Date: Fri, 26 Sep 2025 20:26:12 +0200
Message-ID: <20250926182614.26629-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926182614.26629-1-timur.kristof@gmail.com>
References: <20250926182614.26629-1-timur.kristof@gmail.com>
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

On various SI GPUs, a flickering can be observed near the bottom
edge of the screen when using a single 4K 60Hz monitor over DP.
Disabling MCLK switching works around this problem.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index cf9932e68055..3a9522c17fee 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -3500,6 +3500,11 @@ static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 	 * for these GPUs to calculate bandwidth requirements.
 	 */
 	if (high_pixelclock_count) {
+		/* Work around flickering lines at the bottom edge
+		 * of the screen when using a single 4K 60Hz monitor.
+		 */
+		disable_mclk_switching = true;
+
 		/* On Oland, we observe some flickering when two 4K 60Hz
 		 * displays are connected, possibly because voltage is too low.
 		 * Raise the voltage by requiring a higher SCLK.
-- 
2.51.0

