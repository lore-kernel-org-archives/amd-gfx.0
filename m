Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E89E9A03E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 08:09:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B65B710E580;
	Wed, 18 Feb 2026 08:09:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="Xl6v2xvn";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4FFE10E549
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Feb 2026 22:36:04 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so791117466b.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Feb 2026 14:36:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771367762; cv=none;
 d=google.com; s=arc-20240605;
 b=dPNSUHLpL6Bwy3GWOdu6+yKVmHwTRluse5K1YmtToLKwrS10mQUbDIEyuM21lTQnTy
 Ut24iKMdJ1P0sg7BKCOpfW9K0xt+XnDEfn6SLJQBW5sN0Akvvsx0y/sd578B7WF2C6AE
 GfG+PtVGB1ELWwidB1Z5ZCfY2dMkk3r9B7C1KC7kLa713uMUdk/hiM80F6WxljUW9eFr
 53P3zTJCP+uQeF3JqHbd1H3ANagkhraBFfvpxh1v8Me7wuEtR6JgxLMP/DP45Qw9jwoW
 ck1SBRUm4J16SAd+wvSG2xoKlGZtGCMa/vJDW9CwhsP2Q1bUK84lZtHBMi+QUv5Lmzfv
 8nog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=s97S9QYC27wvlPQAhSqz0+mo94ezXIoGg3PTwcdlXc0=;
 fh=zX2aDyqaFZDsfnyUxl4M4Lkr+VHC/u7YlhvflJzKB2I=;
 b=Vj7oJa1tWa2gv7vOuOmFgDjpuZ0F3N4msQ/19t4siki5ZZV28nlW7ZsjTeSEVJb3z+
 zOjif5241QwGBPPeAoVn/ZegOmdLR8ONu2OuAYBXdq/DMmNIPbNvkcSDCZ09KikXhhmH
 z5ovFk2OgfWTeePgpIYE+JRGpLw/X+CoMJqD3MmWX2tE/W60yDBGaxD2GaogtEByNwGZ
 5ic6bTnziqkVP2Wak+/a/cuoUF3UHou7rSlmZF54b5axLv4HKOIpKEzuj9e91fS6/iI1
 6iWFglJVUX+TZVWBo9kn+1yaXwdidpS5S0DWjS8AzbGIkvusKZxNRW19mX5pEo0WGbf9
 PWnw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1771367762; x=1771972562; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=s97S9QYC27wvlPQAhSqz0+mo94ezXIoGg3PTwcdlXc0=;
 b=Xl6v2xvnknJ8j9Mz/IKschqzYAZyPE2X05nh0Rc3OrqSCKjN6CQtrXwjMfBN2tIlrV
 ZyflDbFnd3vNTHkAFNlVIGwzXH2EwtMLQfGEJv00QAA8YJDWXs142ZrtRZHk4ntaYOIN
 Lzt7CjMv3v/13BDOSYRY0Dv0vn5wQ40FjLIfkgn4mhIgWSNtCpvC1vpYxgcrpwCaS3G+
 +USLRG6GWBNl08FeQ6+jy7YsqyVa9ircEKUEvz6jiXa9Gm8eUDdYD3tn8OGKfRqUJlJT
 dFd2m4mApb7pSWTOVI6z4YA5DKm8qlJCZhjVQy6TpCGucUDjPOvT+29ZfxLMsA2Z/tHU
 mLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771367762; x=1771972562;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s97S9QYC27wvlPQAhSqz0+mo94ezXIoGg3PTwcdlXc0=;
 b=GB2PnA1zmYEbrFjyg8QmUPVoB0edlQlO9dSky7LLKGWF7Ti3r6RMXQJAHuOrzPEaUx
 1rziBlL2EftOyPI3OM9WBGAftbyMBvkY0R9wQOq+aZw3vI3hd3E8gAw8CwvrnCJ79aMu
 u4Tc9ula8PhLNy8MDMcycqezW8m2xDsop3lNSMQ3eIYCWmLoC59aGdmqxBpvNHQ/dcgG
 khPE48KG7VnVzn/donTsZozYrLjomeFPP+CbgnRIZ48j6gifnUaWvxy1bAmxnhoSzcDY
 O0Y8oHvwnUq1cREhea02f/ysIyEE8vqyPcFC2NBtk+T44ddBAXveWjD7xiMcfzIN0Hi/
 QWTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ7nvO6XbGdF2SmBCXTgu7HrMyRWVS/bcFjzBVjH0lNRSaEgTBEK3FaRT2BVoBJ2wRxPcYpqQ6@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzkrlOPLSSiw0u8JLuLyQjQmBNKxeOB7udfjCYSZq2BGFlrztEH
 uHzBTmJze27O19L6ch84n35broqFHpwYh9Hj5mPzdqAALsGf4w67rdzq6XWx0XmyZOb5HnmA9Us
 fKFILLKRnrRcOqDdEe1nbhh8cSJHriaxOEnROL91wZg==
X-Gm-Gg: AZuq6aIBx3VhwXVnPQyJI9CIs7ZzOb5UzA4axfb524Cv0xzJu0XV3u5FyH481zrIA3y
 KYCnPe+I4SAYpy1zMfD2+swRS1mP3cM8DziaqHaxJpgZUaHqX3jYbFetsrzf/WQTdWLObjupeK9
 Kun8N/FIeuo/hdrrzbPhX2jmjP4Snz1yBMO1BZLzRJ7NxL9zLpvjQ9/39x1ING+4wWAc2glo18B
 Rw4qZIgV4+YjwilqDFez/BlcACMxTCDABrOkqb3t9aYvrSiQsXm/pjGCG//C1RPpgt/Y7LMaIgZ
 2Ds1nQk8v+p9d4vpFrjX2ztTZastYyrrSkRygzBzz1JzLAIsj2qHWTDY4QYIoi4XVGeow0BG4f6
 kwYst2TvhCXNKDdXjdRr+AGk=
X-Received: by 2002:a17:906:c10d:b0:b7a:2d:71af with SMTP id
 a640c23a62f3a-b8fb4462eb2mr863091166b.38.1771367762496; Tue, 17 Feb 2026
 14:36:02 -0800 (PST)
MIME-Version: 1.0
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Date: Tue, 17 Feb 2026 19:35:51 -0300
X-Gm-Features: AaiRm50eWXdylCtKwCo4zH2z-fDALcCZF8JGW4FEyAH0tN9-aIjmLRR0XFK8Iww
Message-ID: <CAJgF-xs=3fbKQO5Mj=coPMXq0ecWmV0bJDNFN44coEHV3WS=wg@mail.gmail.com>
Subject: [PATCH] drm/amd/display: Deduplicate DCN DDC register assignment
To: harry.wentland@amd.com, sunpeng.li@amd.com
Cc: siqueira@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com, 
 airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 18 Feb 2026 08:09:39 +0000
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

From b61fa578ecb3800b4b0391c8d86f6d67c48a7cd9 Mon Sep 17 00:00:00 2001
From: Guilherme Bozi <guilherme.bozi@usp.br>
Date: Tue, 17 Feb 2026 17:49:26 -0300
Subject: [PATCH] drm/amd/display: Deduplicate DCN DDC register assignment

Several DCN generations implement identical define_ddc_registers()
functions to assign DDC register, shift and mask pointers based on
GPIO ID.

Introduce a shared inline helper,
dcn_define_ddc_registers_common(), and convert all DCN
implementations to use it.

This reduces duplication and improves maintainability without
changing behavior.

No functional changes intended.

Signed-off-by: Guilherme Bozi <guilherme.bozi@usp.br>
---
 .../display/dc/gpio/dcn20/hw_factory_dcn20.c  | 27 ++++---------
 .../display/dc/gpio/dcn21/hw_factory_dcn21.c  | 27 ++++---------
 .../display/dc/gpio/dcn30/hw_factory_dcn30.c  | 27 ++++---------
 .../dc/gpio/dcn315/hw_factory_dcn315.c        | 27 ++++---------
 .../display/dc/gpio/dcn32/hw_factory_dcn32.c  | 27 ++++---------
 .../dc/gpio/dcn401/hw_factory_dcn401.c        | 26 ++++---------
 .../amd/display/dc/gpio/hw_factory_dcn_ddc.h  | 39 +++++++++++++++++++
 7 files changed, 86 insertions(+), 114 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/hw_factory_dcn_ddc.h

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_factory_dcn20.c
b/drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_factory_dcn20.c
index e0bd0c722e00..905d14079b91 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_factory_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_factory_dcn20.c
@@ -32,6 +32,8 @@
 #include "../hw_hpd.h"
 #include "../hw_generic.h"

+#include "../hw_factory_dcn_ddc.h"
+
 #include "hw_factory_dcn20.h"


@@ -182,25 +184,12 @@ static void define_ddc_registers(
         struct hw_gpio_pin *pin,
         uint32_t en)
 {
-    struct hw_ddc *ddc = HW_DDC_FROM_BASE(pin);
-
-    switch (pin->id) {
-    case GPIO_ID_DDC_DATA:
-        ddc->regs = &ddc_data_regs_dcn[en];
-        ddc->base.regs = &ddc_data_regs_dcn[en].gpio;
-        break;
-    case GPIO_ID_DDC_CLOCK:
-        ddc->regs = &ddc_clk_regs_dcn[en];
-        ddc->base.regs = &ddc_clk_regs_dcn[en].gpio;
-        break;
-    default:
-        ASSERT_CRITICAL(false);
-        return;
-    }
-
-    ddc->shifts = &ddc_shift[en];
-    ddc->masks = &ddc_mask[en];
-
+    dcn_define_ddc_registers_common(
+        pin, en,
+        ddc_data_regs_dcn,
+        ddc_clk_regs_dcn,
+        ddc_shift,
+        ddc_mask);
 }

 static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_factory_dcn21.c
b/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_factory_dcn21.c
index 2f57ee6deabc..f347b8c7e2b6 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_factory_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_factory_dcn21.c
@@ -32,6 +32,8 @@
 #include "../hw_hpd.h"
 #include "../hw_generic.h"

+#include "../hw_factory_dcn_ddc.h"
+
 #include "hw_factory_dcn21.h"

 #include "dcn/dcn_2_1_0_offset.h"
@@ -170,25 +172,12 @@ static void define_ddc_registers(
         struct hw_gpio_pin *pin,
         uint32_t en)
 {
-    struct hw_ddc *ddc = HW_DDC_FROM_BASE(pin);
-
-    switch (pin->id) {
-    case GPIO_ID_DDC_DATA:
-        ddc->regs = &ddc_data_regs_dcn[en];
-        ddc->base.regs = &ddc_data_regs_dcn[en].gpio;
-        break;
-    case GPIO_ID_DDC_CLOCK:
-        ddc->regs = &ddc_clk_regs_dcn[en];
-        ddc->base.regs = &ddc_clk_regs_dcn[en].gpio;
-        break;
-    default:
-        ASSERT_CRITICAL(false);
-        return;
-    }
-
-    ddc->shifts = &ddc_shift[en];
-    ddc->masks = &ddc_mask[en];
-
+    dcn_define_ddc_registers_common(
+        pin, en,
+        ddc_data_regs_dcn,
+        ddc_clk_regs_dcn,
+        ddc_shift,
+        ddc_mask);
 }

 static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
index 36a5736c58c9..25eef1ee10fe 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn30/hw_factory_dcn30.c
@@ -32,6 +32,8 @@
 #include "../hw_hpd.h"
 #include "../hw_generic.h"

+#include "../hw_factory_dcn_ddc.h"
+
 #include "hw_factory_dcn30.h"


@@ -199,25 +201,12 @@ static void define_ddc_registers(
         struct hw_gpio_pin *pin,
         uint32_t en)
 {
-    struct hw_ddc *ddc = HW_DDC_FROM_BASE(pin);
-
-    switch (pin->id) {
-    case GPIO_ID_DDC_DATA:
-        ddc->regs = &ddc_data_regs_dcn[en];
-        ddc->base.regs = &ddc_data_regs_dcn[en].gpio;
-        break;
-    case GPIO_ID_DDC_CLOCK:
-        ddc->regs = &ddc_clk_regs_dcn[en];
-        ddc->base.regs = &ddc_clk_regs_dcn[en].gpio;
-        break;
-    default:
-        ASSERT_CRITICAL(false);
-        return;
-    }
-
-    ddc->shifts = &ddc_shift[en];
-    ddc->masks = &ddc_mask[en];
-
+    dcn_define_ddc_registers_common(
+        pin, en,
+        ddc_data_regs_dcn,
+        ddc_clk_regs_dcn,
+        ddc_shift,
+        ddc_mask);
 }

 static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.c
b/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.c
index 5feebb3b95ca..571a6f1b0cf9 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.c
@@ -32,6 +32,8 @@
 #include "../hw_hpd.h"
 #include "../hw_generic.h"

+#include "../hw_factory_dcn_ddc.h"
+
 #include "hw_factory_dcn315.h"

 #include "dcn/dcn_3_1_5_offset.h"
@@ -191,25 +193,12 @@ static void define_ddc_registers(
         struct hw_gpio_pin *pin,
         uint32_t en)
 {
-    struct hw_ddc *ddc = HW_DDC_FROM_BASE(pin);
-
-    switch (pin->id) {
-    case GPIO_ID_DDC_DATA:
-        ddc->regs = &ddc_data_regs_dcn[en];
-        ddc->base.regs = &ddc_data_regs_dcn[en].gpio;
-        break;
-    case GPIO_ID_DDC_CLOCK:
-        ddc->regs = &ddc_clk_regs_dcn[en];
-        ddc->base.regs = &ddc_clk_regs_dcn[en].gpio;
-        break;
-    default:
-        ASSERT_CRITICAL(false);
-        return;
-    }
-
-    ddc->shifts = &ddc_shift[en];
-    ddc->masks = &ddc_mask[en];
-
+    dcn_define_ddc_registers_common(
+        pin, en,
+        ddc_data_regs_dcn,
+        ddc_clk_regs_dcn,
+        ddc_shift,
+        ddc_mask);
 }

 static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c
b/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c
index 985f10b39750..d6e97b246bae 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c
@@ -32,6 +32,8 @@
 #include "../hw_hpd.h"
 #include "../hw_generic.h"

+#include "../hw_factory_dcn_ddc.h"
+
 #include "hw_factory_dcn32.h"

 #include "dcn/dcn_3_2_0_offset.h"
@@ -203,25 +205,12 @@ static void define_ddc_registers(
         struct hw_gpio_pin *pin,
         uint32_t en)
 {
-    struct hw_ddc *ddc = HW_DDC_FROM_BASE(pin);
-
-    switch (pin->id) {
-    case GPIO_ID_DDC_DATA:
-        ddc->regs = &ddc_data_regs_dcn[en];
-        ddc->base.regs = &ddc_data_regs_dcn[en].gpio;
-        break;
-    case GPIO_ID_DDC_CLOCK:
-        ddc->regs = &ddc_clk_regs_dcn[en];
-        ddc->base.regs = &ddc_clk_regs_dcn[en].gpio;
-        break;
-    default:
-        ASSERT_CRITICAL(false);
-        return;
-    }
-
-    ddc->shifts = &ddc_shift[en];
-    ddc->masks = &ddc_mask[en];
-
+    dcn_define_ddc_registers_common(
+        pin, en,
+        ddc_data_regs_dcn,
+        ddc_clk_regs_dcn,
+        ddc_shift,
+        ddc_mask);
 }

 static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn401/hw_factory_dcn401.c
b/drivers/gpu/drm/amd/display/dc/gpio/dcn401/hw_factory_dcn401.c
index 928abca18a18..06a4d7a8a1ac 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn401/hw_factory_dcn401.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn401/hw_factory_dcn401.c
@@ -12,6 +12,7 @@
 #include "../hw_hpd.h"
 #include "../hw_generic.h"

+#include "../hw_factory_dcn_ddc.h"

 #include "dcn/dcn_4_1_0_offset.h"
 #include "dcn/dcn_4_1_0_sh_mask.h"
@@ -195,25 +196,12 @@ static void define_ddc_registers(
         struct hw_gpio_pin *pin,
         uint32_t en)
 {
-    struct hw_ddc *ddc = HW_DDC_FROM_BASE(pin);
-
-    switch (pin->id) {
-    case GPIO_ID_DDC_DATA:
-        ddc->regs = &ddc_data_regs_dcn[en];
-        ddc->base.regs = &ddc_data_regs_dcn[en].gpio;
-        break;
-    case GPIO_ID_DDC_CLOCK:
-        ddc->regs = &ddc_clk_regs_dcn[en];
-        ddc->base.regs = &ddc_clk_regs_dcn[en].gpio;
-        break;
-    default:
-        ASSERT_CRITICAL(false);
-        return;
-    }
-
-    ddc->shifts = &ddc_shift[en];
-    ddc->masks = &ddc_mask[en];
-
+    dcn_define_ddc_registers_common(
+        pin, en,
+        ddc_data_regs_dcn,
+        ddc_clk_regs_dcn,
+        ddc_shift,
+        ddc_mask);
 }

 static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory_dcn_ddc.h
b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory_dcn_ddc.h
new file mode 100644
index 000000000000..1f2bc7eea82e
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory_dcn_ddc.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc.
+ */
+
+#ifndef __DAL_HW_FACTORY_DCN_DDC_H__
+#define __DAL_HW_FACTORY_DCN_DDC_H__
+
+static inline void dcn_define_ddc_registers_common(
+        struct hw_gpio_pin *pin,
+        uint32_t en,
+        const struct ddc_registers *data_regs,
+        const struct ddc_registers *clk_regs,
+        const struct ddc_shift *shift,
+        const struct ddc_mask *mask)
+{
+    struct hw_ddc *ddc = HW_DDC_FROM_BASE(pin);
+
+    switch (pin->id) {
+    case GPIO_ID_DDC_DATA:
+        ddc->regs = &data_regs[en];
+        ddc->base.regs = &data_regs[en].gpio;
+        break;
+
+    case GPIO_ID_DDC_CLOCK:
+        ddc->regs = &clk_regs[en];
+        ddc->base.regs = &clk_regs[en].gpio;
+        break;
+
+    default:
+        ASSERT_CRITICAL(false);
+        return;
+    }
+
+    ddc->shifts = &shift[en];
+    ddc->masks = &mask[en];
+}
+
+#endif /* __DAL_HW_FACTORY_DCN_DDC_H__ */
-- 
2.47.3
