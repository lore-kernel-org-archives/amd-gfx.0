Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A819C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 03:16:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E90086E073;
	Wed,  8 Dec 2021 03:16:42 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4257E6E1F3
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 01:32:47 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4J7zz16gtnzF4mq;
 Tue,  7 Dec 2021 17:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1638926797; bh=JNoxR21PQiBNJRuryUCluQBm4Oc3DOPSL6HmrujMG+U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lypwYLWSIFaQEs6WavcvAf8/nfkcqwyQCRciSKIiPGESmfpgDx2FxPIQ+3HmIAN9W
 uewdLervpMz0eFXSRvNpX/9AgL3CzUrOeGs4NSzJpRRLWfsw0EQUSRVACyNkYTXDHp
 BdRY/85c2IOAB+2+cvd+uO+v38OqLLKhs5tJBw2U=
X-Riseup-User-ID: AE7E11D54F415D9AD0765CD6CED82314789F6E3D67F5AC78F663812A8E3E1AB7
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4J7zyz4HKjz5vkY;
 Tue,  7 Dec 2021 17:26:35 -0800 (PST)
From: Isabella Basso <isabbasso@riseup.net>
To: alexander.deucher@amd.com, christian.koenig@amd.com, daniel@ffwll.ch,
 harry.wentland@amd.com, Rodrigo.Siqueira@amd.com, Felix.Kuehling@amd.com
Subject: [PATCH 07/10] drm/amd: append missing includes
Date: Tue,  7 Dec 2021 22:25:26 -0300
Message-Id: <20211208012529.372478-8-isabbasso@riseup.net>
In-Reply-To: <20211208012529.372478-1-isabbasso@riseup.net>
References: <20211208012529.372478-1-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Dec 2021 03:16:41 +0000
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
Cc: ~lkcamp/patches@lists.sr.ht, Isabella Basso <isabbasso@riseup.net>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This fixes warnings caused by global functions lacking prototypes:, such as:

 warning: no previous prototype for 'dcn303_hw_sequencer_construct'
 [-Wmissing-prototypes]
 12 | void dcn303_hw_sequencer_construct(struct dc *dc)
    |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 ...
 warning: no previous prototype for ‘amdgpu_has_atpx’
 [-Wmissing-prototypes]
 76 | bool amdgpu_has_atpx(void) {
    |      ^~~~~~~~~~~~~~~

Signed-off-by: Isabella Basso <isabbasso@riseup.net>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c                | 1 +
 .../drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c    | 2 ++
 .../gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c | 2 ++
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c     | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c               | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c               | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c               | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c             | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_init.c             | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c             | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c               | 2 ++
 11 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
index c2be6ad62308..d6d986be906a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 
+#include "amdgpu.h"
 #include "amd_acpi.h"
 
 #define AMDGPU_PX_QUIRK_FORCE_ATPX  (1 << 0)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
index fe18bb9e19aa..06bab24d8e27 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
@@ -28,6 +28,8 @@
 #include "reg_helper.h"
 #include <linux/delay.h>
 
+#include "rv1_clk_mgr_vbios_smu.h"
+
 #define MAX_INSTANCE	5
 #define MAX_SEGMENT		5
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
index 0c963fc0523f..8161a6ae410d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
@@ -33,6 +33,8 @@
 #include "mp/mp_12_0_0_offset.h"
 #include "mp/mp_12_0_0_sh_mask.h"
 
+#include "rn_clk_mgr_vbios_smu.h"
+
 #define REG(reg_name) \
 	(MP0_BASE.instance[0].segment[mm ## reg_name ## _BASE_IDX] + mm ## reg_name)
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index a6bc3c7673ba..abef132fa016 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -69,6 +69,8 @@
 
 #include "dcn10/dcn10_hw_sequencer.h"
 
+#include "dce110_hw_sequencer.h"
+
 #define GAMMA_HW_POINTS_NUM 256
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index 5cfd4b0afea5..91e4885b743e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -27,6 +27,8 @@
 #include "dcn10/dcn10_hw_sequencer.h"
 #include "dcn20_hwseq.h"
 
+#include "dcn20_init.h"
+
 static const struct hw_sequencer_funcs dcn20_funcs = {
 	.program_gamut_remap = dcn10_program_gamut_remap,
 	.init_hw = dcn10_init_hw,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index 54c11ba550ae..b270f0b194dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -28,6 +28,8 @@
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn21_hwseq.h"
 
+#include "dcn21_init.h"
+
 static const struct hw_sequencer_funcs dcn21_funcs = {
 	.program_gamut_remap = dcn10_program_gamut_remap,
 	.init_hw = dcn10_init_hw,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index 93f32a312fee..4926771ddeee 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -29,6 +29,8 @@
 #include "dcn21/dcn21_hwseq.h"
 #include "dcn30_hwseq.h"
 
+#include "dcn30_init.h"
+
 static const struct hw_sequencer_funcs dcn30_funcs = {
 	.program_gamut_remap = dcn10_program_gamut_remap,
 	.init_hw = dcn30_init_hw,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
index e85b695f2351..3d42a1a337ec 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
@@ -30,6 +30,8 @@
 #include "dcn30/dcn30_hwseq.h"
 #include "dcn301_hwseq.h"
 
+#include "dcn301_init.h"
+
 static const struct hw_sequencer_funcs dcn301_funcs = {
 	.program_gamut_remap = dcn10_program_gamut_remap,
 	.init_hw = dcn10_init_hw,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_init.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_init.c
index d88b9011c502..eb375f30f5bc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_init.c
@@ -29,6 +29,8 @@
 
 #include "dc.h"
 
+#include "dcn302_init.h"
+
 void dcn302_hw_sequencer_construct(struct dc *dc)
 {
 	dcn30_hw_sequencer_construct(dc);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
index aa5dbbade2bd..f499f8ab5e47 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
@@ -9,6 +9,8 @@
 #include "dcn30/dcn30_init.h"
 #include "dc.h"
 
+#include "dcn303_init.h"
+
 void dcn303_hw_sequencer_construct(struct dc *dc)
 {
 	dcn30_hw_sequencer_construct(dc);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
index e175b6cc0125..e5885f62a764 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
@@ -31,6 +31,8 @@
 #include "dcn301/dcn301_hwseq.h"
 #include "dcn31/dcn31_hwseq.h"
 
+#include "dcn31_init.h"
+
 static const struct hw_sequencer_funcs dcn31_funcs = {
 	.program_gamut_remap = dcn10_program_gamut_remap,
 	.init_hw = dcn31_init_hw,
-- 
2.34.1

