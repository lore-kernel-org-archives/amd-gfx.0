Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC44C43458
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jul 2026 11:30:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46FCA10E329;
	Sat, 11 Jul 2026 11:30:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HRd7S6J2";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A680B10E12D
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jul 2026 11:30:14 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-493b7612475so14532465e9.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jul 2026 04:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783769413; x=1784374213; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5QOYuBuFYonksMICuOqLNIqvdCeFDaeT9j663AOIOPE=;
 b=HRd7S6J2KnPM3fqyoS+DUh4lbDyMvPGGT+dosxSAqjG1DNIAhR67tjY94YhSfAYNIF
 cqclNjnf19bCR6Uqj+ogFtWT1SwNk8L0UWZ0N63QhwAkgIyIffrhsEnOAtF4bH56IoKi
 /5m63PtFu4FWxsM8dEERuzNz3kFZNWCQwhIhd36NLLB4selAygAOn+Xw7DEFrsXJQLcb
 QYAJU3RQGFs/+u3jGczTV4jidHWzl/3ChxRAs9qjQUivQ2ooWS4FkKhysWDBtvDIw5N8
 9NRd+vAp0lBCj2YPkJFf6rL8bdJeS+NCQBAlQnCNyWbpy+OAu1/15UDOr3fz9Oy+sBbw
 5c2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783769413; x=1784374213;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5QOYuBuFYonksMICuOqLNIqvdCeFDaeT9j663AOIOPE=;
 b=gF32a5TWxYbJ7hkdfVIUtX31kicaKdYQFfIP4EJ15KKP+Wh+cXKs2U+ShKLaMPYikq
 U2P9An85NQq8f+qWXaPAXOVgYBiAZe2lD5tx9SsMHxrdlFpahJ7NDI/jn2PF1qoyUwCr
 ES6+cIXbly916Q9986Qf45I4aRggkIbGvDtAonEFrGSn9BA98PG/w6bL5sHpngBeHCJF
 /pZ0OvS3vYBrMnLUf7LmDm4TNqfCUAmlOZ+Hu9V68HfNGZyNSFATiW0jMFI+kqBWNwbk
 A6b82MbHV0/S+FLdDe5NGd5Jgh/qmDIMi9wNvS4tgMCrJMbLbTtEZrUGpNL1NwwTRvNU
 edoA==
X-Gm-Message-State: AOJu0YyBApMOpSjqTdFoTWtgwPpijYn2OuQHwWQKKT/h/mPgeAyCaqEb
 qsajR7Q+v3tA0a8DZ8vV8A1G9r/8sc6Y41ahxq72FTIiY/5bCiR8CdgwYzTLww==
X-Gm-Gg: AfdE7clBiTZdWfK9vjJN1+lF4ldtsVpvy/IX/PCOmktSpXpDNXWEHqTtr0ubXFKiGDH
 YBRCTzY1QkRaO4fxA66ewPCx+ohE7MbZqsijMSyBjzFBoAhOb6QYWXdzNrC01lMPqHbSx2Z0FMg
 jOiOd58kROcfSqpdU7SvdiYuQcmrOMQXXS2MVt9M0kvOoi4EyVfSxTCkuEvCxtP/j42BAbZOAML
 eAcwPHbAZHEVCNqw6GEMSBDZfR0lrMVrDOzq7grzhvVuB7ePBXq1oMlUFuiYdZbKzNRNvoaQYq6
 eLugD1KWHJgZ0W1RIA27SLsP3a9D9oXujQIEKfED/Hmonf5U/gqv0dxocVMVZGCA0x2RLB/nEUQ
 5uvNMnaqVWrBOdIpwr3jl2umOI9m1LZEaHL26vG8uAU+CakLe0DyQOecdchTCRxMRDsl+CfgllJ
 Ofbj0V8d58ikxNWuv6f5luqTYV7RdekMF+6kevWejKzNjHNtoCBQo0PQ==
X-Received: by 2002:a05:600c:c16e:b0:493:f734:f121 with SMTP id
 5b1f17b1804b1-493f881d3b6mr21986445e9.23.1783769412953; 
 Sat, 11 Jul 2026 04:30:12 -0700 (PDT)
Received: from Timur-Hyperion.home (54001386.dsl.pool.telekom.hu.
 [84.0.19.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f373csm349931035e9.14.2026.07.11.04.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2026 04:30:12 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <natalie.vock@gmx.de>,
 Melissa Wen <mwen@igalia.com>, mario.limonciello@amd.com,
 alex.hung@amd.com, harry.wentland@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/2] drm/amd/display: Check HDMI FRL support before creating
 polling workqueue
Date: Sat, 11 Jul 2026 13:30:09 +0200
Message-ID: <20260711113009.26512-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260711113009.26512-1-timur.kristof@gmail.com>
References: <20260711113009.26512-1-timur.kristof@gmail.com>
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

The workqueue is not necessary when FRL is not supported or
when it's disabled. Add a helper to tell when the current
board has any HDMI FRL capable connectors and call that
before creating the workqueue.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 26 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 ++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6299f0e384f1..87d7b60ceb3f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -827,7 +827,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 		dc_init_callbacks(adev->dm.dc, &init_params);
 	}
-	if (adev->dm.dc->caps.max_links > 0) {
+	if (dc_is_hdmi_frl_supported(adev->dm.dc)) {
 		adev->dm.hdmi_frl_status_polling_wq =
 			create_singlethread_workqueue("hdmi_frl_status_polling_wq");
 		if (!adev->dm.hdmi_frl_status_polling_wq)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1b6627a92d24..1a7073abb8ba 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6592,6 +6592,32 @@ void dc_mclk_switch_using_fw_based_vblank_stretch_shut_down(struct dc *dc)
 		dc->current_state->bw_ctx.bw.dcn.clk.fw_based_mclk_switching_shut_down = true;
 }
 
+/**
+ * dc_is_hdmi_frl_supported() - Check HDMI FRL support
+ *
+ * @dc: [in] dc structure
+ *
+ * Return:
+ * True if the current board has any HDMI FRL capable connectors,
+ * False otherwise.
+ */
+bool dc_is_hdmi_frl_supported(struct dc *dc)
+{
+	int i;
+
+	if (!dc->config.enable_frl)
+		return false;
+
+	for (i = 0; i < dc->link_count; ++i) {
+		if (dc->links[i] &&
+		    dc->links[i]->link_enc &&
+		    dc->links[i]->link_enc->features.flags.bits.IS_HDMI_FRL_CAPABLE)
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * dc_is_dmub_outbox_supported - Check if DMUB firmware support outbox notification
  *
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 13c1f7cd9d7d..d27c7437ee7a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -3056,6 +3056,8 @@ bool dc_set_ips_disable(struct dc *dc, unsigned int disable_ips);
 void dc_z10_restore(const struct dc *dc);
 void dc_z10_save_init(struct dc *dc);
 
+bool dc_is_hdmi_frl_supported(struct dc *dc);
+
 bool dc_is_dmub_outbox_supported(struct dc *dc);
 bool dc_enable_dmub_notifications(struct dc *dc);
 
-- 
2.55.0

