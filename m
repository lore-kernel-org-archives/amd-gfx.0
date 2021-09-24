Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C71C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 06:52:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22F8D610C7
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 06:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 22F8D610C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=u92.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 530526EE5E;
	Fri, 24 Sep 2021 06:51:04 +0000 (UTC)
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32A2A6EDFF;
 Fri, 24 Sep 2021 06:50:54 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 045FF58106B;
 Fri, 24 Sep 2021 02:43:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Fri, 24 Sep 2021 02:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm3; bh=1GQDtrRIicUub
 XM4IWgOJW9q6Bt3kzDCmFE/H911f9o=; b=vC//lO1+z0VVvmhCk8N79w2Dl8lQ9
 cXpR2rVFnqVxheLTqN+E4gSrqjM6fW5ZP2oK21GRIU4Gupb/6wZ8w9ldtAcNlEXb
 HZN6kNI0Wsi1oZNuHAaZcq/1070PFdpHkqTVgJq1Dt/eS8WggI/XvZX9HdsYzniJ
 8AwmByFirKsSMm/2m4pZh7igRULL3mxpmzmGVzg1DoiCp+S0ZbTpoaJ+cXJUGX0M
 ipKHysndOhu1w6dV1Dy3doZisqh8Jqf1Cz/PuVcoSqN36HbD22hy3fF7DXxlnXqx
 cKpASshr2vIE+eboVbdi5xltzRt0bsH8Qih3CoLeFVxlrKv+gKZY3Vs+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=1GQDtrRIicUubXM4IWgOJW9q6Bt3kzDCmFE/H911f9o=; b=DsRJvDlt
 J4JO1onitIN+FLdlAhKxr4RZdF6fJDW5MWN41teKOGiEnc7krlCNQKLoOuRheXOg
 pdXhxPV4ptiJfozRHiRSZYDsXsP8UE5hXVSHVfzUzLhCq7zftvFFxhhYJZz1j04m
 diIHgxUlS+hKLH7HT9b2CknP0Hq/UbhuV9I5Rr8X00YGzbPtTvMBdgVBMZaHPF/6
 Y7RhxPbCrclmi+Lz1bxqqnNRIuCEBzcIaQ6W3W4VyEL3rl1MBxqCC/CetcS19FfE
 R5CPNUmKT6f0CruwKAgAG8WSMQJbvjaWVXzr64DXOvPvWtNYfbDEdh9fmEOsgeKH
 l9/XD5zJhH714g==
X-ME-Sender: <xms:pXNNYdKAoX66yYyEHcbN8NNYhBDTP8Sg0J8mulkPzzO3XXWevFGf3w>
 <xme:pXNNYZKhDirWA8ovknJfTNNbyDZDfhS5bHpXMs3DgSzc38vqcVAav2FKUEOHTfX1b
 tlBf3vUFjCcqV2Ajw>
X-ME-Received: <xmr:pXNNYVtPXJMxgCQCYqE-8PD_NtsxB1CQQVy1_lBVQDlkYmOpuX8NB8u0y0dXNanNpXry>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejtddguddtlecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
 ertdertddtnecuhfhrohhmpefhvghrnhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhho
 ohesuhelvddrvghuqeenucggtffrrghtthgvrhhnpeekleekjedtheejheekfefggeevvd
 fgueegffeuveduhfehueegkeeijedvvdejfeenucevlhhushhtvghrufhiiigvpedtnecu
 rfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:pXNNYeb3YASQCt4hl_X2DvQZ5UH7B5WneH1Oqke31A9UyKiMrtMYWA>
 <xmx:pXNNYUb1TTSrMoMHcZei3qqVOnm1KkTs3LRxWhatlj9P33nHTJFHfw>
 <xmx:pXNNYSDv_KBzKEvH4uFLbnwS2OMP4G4S9EOmNMbrqwjDArW5-tr5XQ>
 <xmx:pnNNYSne249MeN7deZnjVZQq1wlnt9qO3JN9nQd6HN1JzLjMrRBX-g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Sep 2021 02:43:47 -0400 (EDT)
From: Fernando Ramos <greenfoo@u92.eu>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, sean@poorly.run, linux-doc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-tegra@vger.kernel.org
Subject: [PATCH v2 06/17] drm/tegra: cleanup: drm_modeset_lock_all() -->
 DRM_MODESET_LOCK_ALL_BEGIN()
Date: Fri, 24 Sep 2021 08:43:13 +0200
Message-Id: <20210924064324.229457-7-greenfoo@u92.eu>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924064324.229457-1-greenfoo@u92.eu>
References: <20210924064324.229457-1-greenfoo@u92.eu>
MIME-Version: 1.0
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

As requested in Documentation/gpu/todo.rst, replace driver calls to
drm_modeset_lock_all() with DRM_MODESET_LOCK_ALL_BEGIN() and
DRM_MODESET_LOCK_ALL_END()

Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
Reviewed-by: Sean Paul <sean@poorly.run>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/tegra/dsi.c  |  6 ++++--
 drivers/gpu/drm/tegra/hdmi.c |  6 ++++--
 drivers/gpu/drm/tegra/sor.c  | 11 +++++++----
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index f46d377f0c30..28050c188c1c 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -23,6 +23,7 @@
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_simple_kms_helper.h>
+#include <drm/drm_drv.h>
 
 #include "dc.h"
 #include "drm.h"
@@ -202,10 +203,11 @@ static int tegra_dsi_show_regs(struct seq_file *s, void *data)
 	struct tegra_dsi *dsi = node->info_ent->data;
 	struct drm_crtc *crtc = dsi->output.encoder.crtc;
 	struct drm_device *drm = node->minor->dev;
+	struct drm_modeset_acquire_ctx ctx;
 	unsigned int i;
 	int err = 0;
 
-	drm_modeset_lock_all(drm);
+	DRM_MODESET_LOCK_ALL_BEGIN(drm, ctx, 0, err);
 
 	if (!crtc || !crtc->state->active) {
 		err = -EBUSY;
@@ -220,7 +222,7 @@ static int tegra_dsi_show_regs(struct seq_file *s, void *data)
 	}
 
 unlock:
-	drm_modeset_unlock_all(drm);
+	DRM_MODESET_LOCK_ALL_END(drm, ctx, err);
 	return err;
 }
 
diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index e5d2a4026028..a62de7f92414 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -22,6 +22,7 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_simple_kms_helper.h>
+#include <drm/drm_drv.h>
 
 #include "hda.h"
 #include "hdmi.h"
@@ -1031,10 +1032,11 @@ static int tegra_hdmi_show_regs(struct seq_file *s, void *data)
 	struct tegra_hdmi *hdmi = node->info_ent->data;
 	struct drm_crtc *crtc = hdmi->output.encoder.crtc;
 	struct drm_device *drm = node->minor->dev;
+	struct drm_modeset_acquire_ctx ctx;
 	unsigned int i;
 	int err = 0;
 
-	drm_modeset_lock_all(drm);
+	DRM_MODESET_LOCK_ALL_BEGIN(drm, ctx, 0, err);
 
 	if (!crtc || !crtc->state->active) {
 		err = -EBUSY;
@@ -1049,7 +1051,7 @@ static int tegra_hdmi_show_regs(struct seq_file *s, void *data)
 	}
 
 unlock:
-	drm_modeset_unlock_all(drm);
+	DRM_MODESET_LOCK_ALL_END(drm, ctx, err);
 	return err;
 }
 
diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index 0ea320c1092b..3d1c8b3d1358 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -23,6 +23,7 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_scdc_helper.h>
 #include <drm/drm_simple_kms_helper.h>
+#include <drm/drm_drv.h>
 
 #include "dc.h"
 #include "dp.h"
@@ -1490,10 +1491,11 @@ static int tegra_sor_show_crc(struct seq_file *s, void *data)
 	struct tegra_sor *sor = node->info_ent->data;
 	struct drm_crtc *crtc = sor->output.encoder.crtc;
 	struct drm_device *drm = node->minor->dev;
+	struct drm_modeset_acquire_ctx ctx;
 	int err = 0;
 	u32 value;
 
-	drm_modeset_lock_all(drm);
+	DRM_MODESET_LOCK_ALL_BEGIN(drm, ctx, 0, err);
 
 	if (!crtc || !crtc->state->active) {
 		err = -EBUSY;
@@ -1522,7 +1524,7 @@ static int tegra_sor_show_crc(struct seq_file *s, void *data)
 	seq_printf(s, "%08x\n", value);
 
 unlock:
-	drm_modeset_unlock_all(drm);
+	DRM_MODESET_LOCK_ALL_END(drm, ctx, err);
 	return err;
 }
 
@@ -1652,10 +1654,11 @@ static int tegra_sor_show_regs(struct seq_file *s, void *data)
 	struct tegra_sor *sor = node->info_ent->data;
 	struct drm_crtc *crtc = sor->output.encoder.crtc;
 	struct drm_device *drm = node->minor->dev;
+	struct drm_modeset_acquire_ctx ctx;
 	unsigned int i;
 	int err = 0;
 
-	drm_modeset_lock_all(drm);
+	DRM_MODESET_LOCK_ALL_BEGIN(drm, ctx, 0, err);
 
 	if (!crtc || !crtc->state->active) {
 		err = -EBUSY;
@@ -1670,7 +1673,7 @@ static int tegra_sor_show_regs(struct seq_file *s, void *data)
 	}
 
 unlock:
-	drm_modeset_unlock_all(drm);
+	DRM_MODESET_LOCK_ALL_END(drm, ctx, err);
 	return err;
 }
 
-- 
2.33.0

