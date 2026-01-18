Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B87C9832F
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jan 2026 17:32:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 779AD10E2DC;
	Sun, 18 Jan 2026 17:31:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q80djQTo";
	dkim-atps=neutral
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18B3810E2D8
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 17:31:58 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-b87693c981fso620434066b.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 09:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768757516; x=1769362316; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=et2Gn6/BzTMDEKFkGhTrTx2M+zHi9nvrS6lnuhf/27g=;
 b=Q80djQTotxOaZLFPLx5n0y88q7Uxv7UqWmjogC5L/a2+6muH30fPE0cS06X9wDT+t2
 20KQ0x4I8ev/oaqgXJ1bPtG/+6zvoj/ASGRYA6jF4MkcPDox9wxFzu1NLNn1PqcPQ081
 MCrVB7xnqVTKQaal9c37l5b1z9wWB9PbYryRfv+z+5veYNptuV8juiGtOWqSMO2kIeH0
 Mu9s7gRp6BOVljPgitYX9votXNDGnU5TZBXr3eoz4L8/ngO/Gkmj/9UUwBoAs91Y0ob5
 ZfMw7izlahJiXLqYtLMSIv1hcibGmrnqeEBvRLDSXhGJsGMebsenVqAgxQee7e1RvQkP
 uWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768757516; x=1769362316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=et2Gn6/BzTMDEKFkGhTrTx2M+zHi9nvrS6lnuhf/27g=;
 b=qDufk6RVVzFQh43S0pQ2jmyIbnkM5ge1hQqkZDWoIc9016BtE5nn9sdIja9fIOwzo1
 NxXiV4y7kmg6rRYCUSScI6C/JLFNAbl3O+0rnov1TGUn53Ets9BkJiJdII2yMR8Nxq5v
 1FcSVbwQ9EU+F4deAGWUXoDsKFdz7rV7oQyWgUuEbBSFyfKALqx51KjTiTUHCE8Ksksn
 +vzGk5r2APt4LQtTC9siG5FC/gpNDLQenbkuCZSRAAG7npkPhMaQVMq3f4if4uEsJISk
 H6HihgjWMHKQUTRKqfMZt4sk10z19Ib1/ywa7ldxN3EJinV40kMcS1a7h5FNv/lL4dSe
 LPlA==
X-Gm-Message-State: AOJu0Yxyz82BhJ1JPbWr6lkn0VBM7lLndz5iZxt58UdkEhv3axyzkDzU
 mLnAvTMNvK4KuzULTFSzs4asy6yXxuTpVV68ehm/hj9jwdexG9BbFgWLuHXDXw==
X-Gm-Gg: AY/fxX4nEivUOtSerylnhIGiiwRbHx0wH9uc3SYGDno1OintxIYd9S1CdkJb3RnZlaf
 WrumiwMoQargrR7AnfiKnCFs5LkjzHCmyOA/M8ktEedgi3qH0E5oTALatLCFdY1PpKEcHim6kB8
 PGcR0+GpYd4ceWWh9gT+tzwzfvw/3SlY84rYkYS5qHHd+LLt4y/L8qIAQhy0oBxclXLrsC3xYFH
 ZAkp6PKZaGpFAo90fEZE8ihPxpHzjG/GnFh+WwM41yRXjE/ShxQjmKkNyEqfrYu4Ff9AImloR8v
 hSZoFqWoTjDh9CIMqhadY392r+oUSXV0JzeFwYEQT0YZTew6E9AW82BcIrVeW6bfQYWCr3/N1WD
 eZitTkqcV5EFuMx2rjp9GMQb3WhnklVMXHLHQu1BkrSQy4EGnOhsVsx9iQl+/qek8rdQ6OzqrwC
 dLLlGyXf7tvMRy9BQFcTuAAT5EqH6cgrRsSM1dmq5WoRKI0HMUWGor7vkpBfeSj2ysJq/o8SPdO
 X11QDr5Ek9M
X-Received: by 2002:a17:906:ee8a:b0:b73:6998:7bcd with SMTP id
 a640c23a62f3a-b8792d59933mr804526066b.23.1768757516244; 
 Sun, 18 Jan 2026 09:31:56 -0800 (PST)
Received: from Timur-Hyperion
 (20014C4E24E47400AD77F2CC91C9A6FE.dsl.pool.telekom.hu.
 [2001:4c4e:24e4:7400:ad77:f2cc:91c9:a6fe])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879513e735sm876868466b.13.2026.01.18.09.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 09:31:55 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Leo Li <sunpeng.li@amd.com>, Alex Hung <alex.hung@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/5] drm/amd/display: Remove unused dce60_clk_mgr register
 definitions
Date: Sun, 18 Jan 2026 18:31:48 +0100
Message-ID: <20260118173150.19790-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260118173150.19790-1-timur.kristof@gmail.com>
References: <20260118173150.19790-1-timur.kristof@gmail.com>
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

It turned out that these were actually not necessary.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../display/dc/clk_mgr/dce60/dce60_clk_mgr.c  | 30 ++-----------------
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  | 11 -------
 2 files changed, 3 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
index 69dd80d9f738..1fdf344efe1a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
@@ -43,30 +43,6 @@
 #include "dce/dce_6_0_d.h"
 #include "dce/dce_6_0_sh_mask.h"
 
-#define REG(reg) \
-	(clk_mgr->regs->reg)
-
-#undef FN
-#define FN(reg_name, field_name) \
-	clk_mgr->clk_mgr_shift->field_name, clk_mgr->clk_mgr_mask->field_name
-
-/* set register offset */
-#define SR(reg_name)\
-	.reg_name = mm ## reg_name
-
-static const struct clk_mgr_registers disp_clk_regs = {
-		CLK_COMMON_REG_LIST_DCE60_BASE()
-};
-
-static const struct clk_mgr_shift disp_clk_shift = {
-		CLK_COMMON_MASK_SH_LIST_DCE60_COMMON_BASE(__SHIFT)
-};
-
-static const struct clk_mgr_mask disp_clk_mask = {
-		CLK_COMMON_MASK_SH_LIST_DCE60_COMMON_BASE(_MASK)
-};
-
-
 /* Max clock values for each state indexed by "enum clocks_state": */
 static const struct state_dependent_clocks dce60_max_clks_by_state[] = {
 /* ClocksStateInvalid - should not be used */
@@ -155,9 +131,9 @@ void dce60_clk_mgr_construct(
 		dce60_max_clks_by_state,
 		sizeof(dce60_max_clks_by_state));
 
-	clk_mgr->regs = &disp_clk_regs;
-	clk_mgr->clk_mgr_shift = &disp_clk_shift;
-	clk_mgr->clk_mgr_mask = &disp_clk_mask;
+	clk_mgr->regs = NULL;
+	clk_mgr->clk_mgr_shift = NULL;
+	clk_mgr->clk_mgr_mask = NULL;
 	clk_mgr->base.funcs = &dce60_funcs;
 
 	base->clks.max_supported_dispclk_khz =
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index bac8febad69a..836a28134d41 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -89,11 +89,6 @@ enum dentist_divider_range {
 	.DPREFCLK_CNTL = mmDPREFCLK_CNTL, \
 	.DENTIST_DISPCLK_CNTL = mmDENTIST_DISPCLK_CNTL
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
-#define CLK_COMMON_REG_LIST_DCE60_BASE() \
-	SR(DENTIST_DISPCLK_CNTL)
-#endif
-
 #define CLK_COMMON_REG_LIST_DCN_BASE() \
 	SR(DENTIST_DISPCLK_CNTL)
 
@@ -119,12 +114,6 @@ enum dentist_divider_range {
 	CLK_SF(DPREFCLK_CNTL, DPREFCLK_SRC_SEL, mask_sh), \
 	CLK_SF(DENTIST_DISPCLK_CNTL, DENTIST_DPREFCLK_WDIVIDER, mask_sh)
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
-#define CLK_COMMON_MASK_SH_LIST_DCE60_COMMON_BASE(mask_sh) \
-	CLK_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, mask_sh),\
-	CLK_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_DONE, mask_sh)
-#endif
-
 #define CLK_COMMON_MASK_SH_LIST_DCN_COMMON_BASE(mask_sh) \
 	CLK_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, mask_sh),\
 	CLK_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_DONE, mask_sh)
-- 
2.52.0

