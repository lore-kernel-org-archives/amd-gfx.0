Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E079DC83F17
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 15:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AED710E7FF;
	Wed, 23 Jul 2025 15:58:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lq1ALp+g";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2B7F10E7FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 15:58:33 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4561ed868b5so47297285e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 08:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753286312; x=1753891112; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8wT/i5v3HFSZf2cyvj3Bbnb0mDDwWZfh8EsphnCwTGw=;
 b=Lq1ALp+gtvM19jcNTLDXMNqsPdMOPNPvZU3JzUZMfcLxotzbzM+qN71jTjqtClFIoW
 KYYXUVcV1mdGXTRjafg/xTYu7kfOfe9M1zmcOFZmxt4RDZs8oniKNA+8ZWsQ0Nyt5SZR
 5cvjfIcL6E+fDk9zm0cNhVP2FPNwczp5L3np2Ejtx45DN82Fnyqe1R+5vNpY1ZB/4QCp
 9UIfxBA31aLuaDvtA84Xkp/6bVkjhpWm7D9l7AtUOTqMooQN2c/YVihtGoLyrYbXsRdm
 8PG3EhSWEzuN+a9tgZKlko90FlpUn6QrWbUCaybhGsWlvR5cs4col4XtarbdE3VKq5c8
 nZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286312; x=1753891112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8wT/i5v3HFSZf2cyvj3Bbnb0mDDwWZfh8EsphnCwTGw=;
 b=MujdNIb10UeTu0Z1GVtLHEkx+Z24KceNGaJaV9ssF5CX7cgkovm5b7Qjw3mKb0Vh7s
 HMX7VoYvpm41tK5SShYTpkov9dr0eqn+/ja9wD5w0q+Xecxxq2+gR9dTWsL6e8bdMsZ4
 aM9gUiAnrqUAD5I6rbEapdGOTl/7ipvJ9uftm8jufJGpPWbZo7kweiNSo/q5OT7yjT5P
 akbjc54zNEtwqGYkzLEZYEHW5mCHoN7+hd61HTCg2pAK8IemIstacVV6mSyfS+fWvQ8p
 PFXXQubZtWIOLhoeTIgvPUwIMO8s2Bh3qwewdeGjQtFXTXrIQYqSxfAputS3b50BRD+y
 Oxeg==
X-Gm-Message-State: AOJu0YzW6ow8YUfcaACOO7rlYvpzMhwUOkT0mtaGJ/rZQUENHUcPkUZr
 iubcqzIibPHvziHICvbfAj9FRgdqka9lu63WSKzBmGAbDySQTPcEboto1qRW7w==
X-Gm-Gg: ASbGncsdZxF/CX7tG4y68xHGizn8r/AbnGXemHvZCbYpkbnN58UwnAp1QQoNLRjhaFV
 9i3NLjL3LIqKWWRDZ8oUvDY8JAFK374+fWPUiLbdqgbnVnoOEhn3GRwVV4B5htGEEifOIWWCFZg
 fQRG0nePiIHyMDmDYm5sX198CvmnYWBFEzbCpoP+sQvZbK3ypLd5JUc+h04bbWMd2yWLPJceMYO
 AvilYcN28TRrbdT0213XrdS+TqaTzKAq90bfHIQlIeJI527TyUn2UUEGi3rju7gAG9X1KND3IBQ
 dyQS4s+vMY9vZp9/YPc5nAEVYNoeozwZwl/RLJiAjSN1uYyRtHHU81nYrPprqz8vFpOG3bsuVTM
 deoQ26wKmtVnKiv7bLIbuojncsC5GUzHG97tHPPFKfurwEDR9U0Ame0IafjMFHdEP8Pb+S5xfPK
 p3RZ4KaHOrj9BhhWfLSVDzbnpOHw==
X-Google-Smtp-Source: AGHT+IGHvy49k+UY6AGK8WS+o1iTeK2EAswaGL6SyEVWUv5NAO55WW4XOBMrLHvxNPKYS9FXnPzyug==
X-Received: by 2002:a05:6000:430e:b0:3a6:d967:380c with SMTP id
 ffacd0b85a97d-3b768ef5bf6mr3152977f8f.36.1753286311882; 
 Wed, 23 Jul 2025 08:58:31 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4D24D8FC008443E005DD6C3C62.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:8443:e005:dd6c:3c62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2bf99sm16710468f8f.32.2025.07.23.08.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:58:31 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 15/20] drm/amd/display: Add DCE BIOS_SCRATCH_0 register
Date: Wed, 23 Jul 2025 17:58:08 +0200
Message-ID: <20250723155813.9101-16-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723155813.9101-1-timur.kristof@gmail.com>
References: <20250723155813.9101-1-timur.kristof@gmail.com>
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
index 6a4c1b47f80d..3b6f330d27b4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -77,6 +77,7 @@
 #endif
 
 #ifndef mmBIOS_SCRATCH_2
+	#define mmBIOS_SCRATCH_0 0x05C9
 	#define mmBIOS_SCRATCH_2 0x05CB
 	#define mmBIOS_SCRATCH_3 0x05CC
 	#define mmBIOS_SCRATCH_6 0x05CF
@@ -368,6 +369,7 @@ static const struct dce_abm_mask abm_mask = {
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
index 164ba796f64c..62babc9dfca0 100644
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
index eb1e158d3436..4998f45ace11 100644
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
index 98775e5ef0bf..3e1032d5cae3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -79,6 +79,7 @@
 
 
 #ifndef mmBIOS_SCRATCH_2
+	#define mmBIOS_SCRATCH_0 0x05C9
 	#define mmBIOS_SCRATCH_2 0x05CB
 	#define mmBIOS_SCRATCH_3 0x05CC
 	#define mmBIOS_SCRATCH_6 0x05CF
@@ -367,6 +368,7 @@ static const struct dce110_clk_src_mask cs_mask = {
 };
 
 static const struct bios_registers bios_regs = {
+	.BIOS_SCRATCH_0 = mmBIOS_SCRATCH_0,
 	.BIOS_SCRATCH_3 = mmBIOS_SCRATCH_3,
 	.BIOS_SCRATCH_6 = mmBIOS_SCRATCH_6
 };
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index 7fde2b8719c7..1462adf7df70 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -77,6 +77,7 @@
 
 
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
-- 
2.50.1

