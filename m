Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA3ECAC5B8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B31010EAC6;
	Fri, 26 Sep 2025 18:03:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kzzttGKT";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCAED10EAC6
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:03:44 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-26983b5411aso18355585ad.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758909824; x=1759514624; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FiV+Vf88JsaXYYr545IC+IevzBXuT7a8hAu6Jo3LjWw=;
 b=kzzttGKTK43+M/0Tk+6IrOOzMQilRqORd1JvI7NnEuFndmO9SSRnmgfKy9W//AkISo
 8kUz0hPddFmoubM0O6nB03SvkeV+F7GHGMY/KIz0nhY3uM9w+V6c0e38QDm63GiNlmbl
 Wj+gQyX688TcWquNh0TuMuXTQa6N1t6BBdlNxs3xnOkjhpYCTuDl58VWv+pDBYqOvCHk
 +WWOWoyXLnURyJQmuNufdWrrN9XuWR+X4Lpl9V6xZT+71JZjgSH5+E4YcIQerX9Mug0o
 85YvG/QYM1s/L34m2XeNEOlxN70uWXylXKLd1vtC0sIslS/MdfBlhr5EXQWWedZNFso7
 iBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758909824; x=1759514624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FiV+Vf88JsaXYYr545IC+IevzBXuT7a8hAu6Jo3LjWw=;
 b=UaRkLCauoK9cVqDmDQCXIAKZA6QWdWU17DPSwlOLq1QuIjX2rk3PlwTvQ7FEv1MmTD
 5rA3rGv4E/2I5aoJ0tX9sM5HPgEvtu415O77CQPyO32nUqLu0VvnFQ9iBaFyNp009S0F
 UX6+3W7pRC9RwmV0szvFUWmu6w+bSw+nROu16VaS5njk3Aju16gPD/0xt2/m9zxov9kX
 zUM7Q3GvfzUct/zAqJmV6Je44x4gxIFv4L11v6guuFMBHP6dAJt3HClh5NJklie8vaaU
 yzOrtaucdJxtpRteX2sQs4KXSImkczbqHAsWFsH7gF4kgy3mhhI1CKJTkhRWzKRFE8lk
 5MXw==
X-Gm-Message-State: AOJu0YwogD05PzZ9ZjZUrbrMldONi9sKre+gC56pTGzVNeuZbiyYuMZl
 WaumXSdMlhH8OnOkNzjK/xOjKoLuC3JJ8l1FgyrLDEAUSXZiUxHNG6uWrGdbxg==
X-Gm-Gg: ASbGncvYAyCqcHzJJTIRG4GaaG1U+CA/x9WGcvSwLueaZKlcYl/j+TwVxfGWVE4l/Vp
 3XMus5OTnjXPjX2UJkyYyKgjEDygO5bcIY5ta+lFOLtfIbSwLBcwXnWdjZvFbr7Q03Ri29KuR/2
 l/BT8ZxgpPBIMrPmr3TPTnPVEMmvII5RW5tRz3n5DCSNl9aSHyzBF1qsFx5/9BHSNXcEHqXjAXW
 5b/GSOgu60reKEmhalwaWNNPOahLd6gxS8VThcm1+CrxsjY/rGYQjvxblDWTwy6aXKd8wmFoqJM
 RYIOzThWRqCoh+rLfObZnCCV8Koh0jSKw1CJwUmA8GgjPb6iG/TYt/g/oNOs7b1gIWwu9Bpw5go
 zSneeeKLn/zOF47Kegs7eA/z9VVFAw6mj893tdUnhi8+MGe4Q8ON6x8W+KiKw80hDbzulP2s3x+
 RQMSSGGxnRF9tvVMw9POXcU64KOC0xRQ==
X-Google-Smtp-Source: AGHT+IHxaJP6ss652vNM36PK5xpIpaEPjURlovUtR+EWJZxKXwfCYoGz5HK1NFxb8HGcc44RwgD8Cw==
X-Received: by 2002:a17:902:ebc4:b0:262:4878:9dff with SMTP id
 d9443c01a7336-27ed4a09347mr89555025ad.12.1758909824234; 
 Fri, 26 Sep 2025 11:03:44 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27f1d2ef8c5sm22186835ad.151.2025.09.26.11.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:03:43 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 17/23] drm/amd/display: Add DCE BIOS_SCRATCH_0 register
Date: Fri, 26 Sep 2025 20:01:57 +0200
Message-ID: <20250926180203.16690-18-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926180203.16690-1-timur.kristof@gmail.com>
References: <20250926180203.16690-1-timur.kristof@gmail.com>
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

The BIOS uses this register to write the results of the
DAC_LoadDetection command, so we'll need to read this
in order to make DAC load detection work.

As a reference, I used the mmBIOS_SCRATCH_0 definition from
the amdgpu legacy display code.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dc_bios_types.h                  | 1 +
 .../gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c    | 2 ++
 .../gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c    | 2 ++
 .../gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c    | 2 ++
 .../gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c    | 1 +
 drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c  | 2 ++
 drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c  | 2 ++
 7 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
index 545ce1e15eae..50c8906b74c5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
@@ -168,6 +168,7 @@ struct dc_vbios_funcs {
 };
 
 struct bios_registers {
+	uint32_t BIOS_SCRATCH_0;
 	uint32_t BIOS_SCRATCH_3;
 	uint32_t BIOS_SCRATCH_6;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index 075815e4041a..891416e0423f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -78,6 +78,7 @@
 #endif
 
 #ifndef mmBIOS_SCRATCH_2
+	#define mmBIOS_SCRATCH_0 0x05C9
 	#define mmBIOS_SCRATCH_2 0x05CB
 	#define mmBIOS_SCRATCH_3 0x05CC
 	#define mmBIOS_SCRATCH_6 0x05CF
@@ -369,6 +370,7 @@ static const struct dce_abm_mask abm_mask = {
 #define DCFE_MEM_PWR_CTRL_REG_BASE 0x1b03
 
 static const struct bios_registers bios_regs = {
+	.BIOS_SCRATCH_0 = mmBIOS_SCRATCH_0,
 	.BIOS_SCRATCH_3 = mmBIOS_SCRATCH_3,
 	.BIOS_SCRATCH_6 = mmBIOS_SCRATCH_6
 };
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
index cccde5a6f3cd..42b0068b1c05 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
@@ -82,6 +82,7 @@
 #endif
 
 #ifndef mmBIOS_SCRATCH_2
+	#define mmBIOS_SCRATCH_0 0x05C9
 	#define mmBIOS_SCRATCH_2 0x05CB
 	#define mmBIOS_SCRATCH_3 0x05CC
 	#define mmBIOS_SCRATCH_6 0x05CF
@@ -377,6 +378,7 @@ static const struct dce110_clk_src_mask cs_mask = {
 };
 
 static const struct bios_registers bios_regs = {
+	.BIOS_SCRATCH_0 = mmBIOS_SCRATCH_0,
 	.BIOS_SCRATCH_3 = mmBIOS_SCRATCH_3,
 	.BIOS_SCRATCH_6 = mmBIOS_SCRATCH_6
 };
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
index 869a8e515fc0..328d784ac4c8 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
@@ -76,6 +76,7 @@
 #endif
 
 #ifndef mmBIOS_SCRATCH_2
+	#define mmBIOS_SCRATCH_0 0x05C9
 	#define mmBIOS_SCRATCH_2 0x05CB
 	#define mmBIOS_SCRATCH_3 0x05CC
 	#define mmBIOS_SCRATCH_6 0x05CF
@@ -385,6 +386,7 @@ static const struct dce110_clk_src_mask cs_mask = {
 };
 
 static const struct bios_registers bios_regs = {
+	.BIOS_SCRATCH_0 = mmBIOS_SCRATCH_0,
 	.BIOS_SCRATCH_3 = mmBIOS_SCRATCH_3,
 	.BIOS_SCRATCH_6 = mmBIOS_SCRATCH_6
 };
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
index 540e04ec1e2d..efc92381c98d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
@@ -491,6 +491,7 @@ static struct dce_i2c_hw *dce120_i2c_hw_create(
 	return dce_i2c_hw;
 }
 static const struct bios_registers bios_regs = {
+	.BIOS_SCRATCH_0 = mmBIOS_SCRATCH_0 + NBIO_BASE(mmBIOS_SCRATCH_0_BASE_IDX),
 	.BIOS_SCRATCH_3 = mmBIOS_SCRATCH_3 + NBIO_BASE(mmBIOS_SCRATCH_3_BASE_IDX),
 	.BIOS_SCRATCH_6 = mmBIOS_SCRATCH_6 + NBIO_BASE(mmBIOS_SCRATCH_6_BASE_IDX)
 };
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
index 5fa84c622282..1077c59cad39 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -80,6 +80,7 @@
 
 
 #ifndef mmBIOS_SCRATCH_2
+	#define mmBIOS_SCRATCH_0 0x05C9
 	#define mmBIOS_SCRATCH_2 0x05CB
 	#define mmBIOS_SCRATCH_3 0x05CC
 	#define mmBIOS_SCRATCH_6 0x05CF
@@ -368,6 +369,7 @@ static const struct dce110_clk_src_mask cs_mask = {
 };
 
 static const struct bios_registers bios_regs = {
+	.BIOS_SCRATCH_0 = mmBIOS_SCRATCH_0,
 	.BIOS_SCRATCH_3 = mmBIOS_SCRATCH_3,
 	.BIOS_SCRATCH_6 = mmBIOS_SCRATCH_6
 };
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index 902209a17fe4..e10e70360d0a 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -78,6 +78,7 @@
 
 
 #ifndef mmBIOS_SCRATCH_2
+	#define mmBIOS_SCRATCH_0 0x05C9
 	#define mmBIOS_SCRATCH_2 0x05CB
 	#define mmBIOS_SCRATCH_3 0x05CC
 	#define mmBIOS_SCRATCH_6 0x05CF
@@ -369,6 +370,7 @@ static const struct dce110_clk_src_mask cs_mask = {
 };
 
 static const struct bios_registers bios_regs = {
+	.BIOS_SCRATCH_0 = mmBIOS_SCRATCH_0,
 	.BIOS_SCRATCH_3 = mmBIOS_SCRATCH_3,
 	.BIOS_SCRATCH_6 = mmBIOS_SCRATCH_6
 };
-- 
2.51.0

