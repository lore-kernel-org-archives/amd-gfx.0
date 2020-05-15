Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0ABDC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 05:19:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3116205CB
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 05:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfO7EfIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3116205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC16C6EBCC;
	Fri, 15 May 2020 05:19:44 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B948C6EBCC;
 Fri, 15 May 2020 05:19:43 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id n5so1126671wmd.0;
 Thu, 14 May 2020 22:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZhJjRoQlrxeH31jU7r9OqB6c2UK7PY7P/7IIUIeP13o=;
 b=XfO7EfIqgGavFdtsqgo4kjdnDkMBvLVQrgb5Sy8DAp1DxTyQ0eRTvTt2zGgSGs4egc
 xw2zVl5jX9eP0IfNkXi5Nt0L0AZXtlTDrbbDQlJJgmUtwOg80ui7YhHjj+1FxQ56ZF9P
 HHEnyuBlxppbmhw+pCB2m2o7ldmfCfFDGlSNg8wthFiVByuJs2WudTa7/lwPjXxtlm6R
 5IhuiTuAyRxpoXXIH3+/jkCKRf2YtpRU1GypcJB/aFWXU4FzOOrMxq95EeI7fRDr4uOk
 K4E40bfmGRxOtyCbOIPIH2iPfSlkDYD0STwC+qGV+JMXwPgGnNk0da45imm9MVENVYLV
 64DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZhJjRoQlrxeH31jU7r9OqB6c2UK7PY7P/7IIUIeP13o=;
 b=hQMIRnHwlFQfcH0epbq4GkfOR2qgH/SqM7KxHMFY7lTwukPPKd+M0ONIRMuqGg7EyY
 3qyzUb+NfbR0j+JmiQrHtos9cwsDXOXw8MoDfni5Xw+sqNB7Uc6yWjg2Jl59k1cSRO/3
 rLfrwJ1v/wHFPB3sWg5/nYerzdg8pc7v212ZzbPn+ZKHSBZsNbmNx16vCnZUhjT1vd8q
 V8QVg8pHRUceQ/vGEpcS+MN9MD3WzTHK2tX0YL3lLxMe0xwULyi3HZF2+R0Q9OM6O+yQ
 sBTFo2QB7B7f3PhyTWyO8X89cAFcerRryf5rWr/ZjAw9qBfWTrwaFOa9bhM/5a4YB23Q
 /76A==
X-Gm-Message-State: AOAM532OIv0LuvWjHsnKPDwCfw96lUONGqh9ZCtcd+LEKSps11qfIBJl
 K/knBclPhuj1eGA5CZqA1iYv9AGwKok=
X-Google-Smtp-Source: ABdhPJyV78T+GkOaH0KrJvWVTOcs38rft5fVcDVnHF5+kfY9h11ztC37dXx7FCnqZVxdCZpr2jvdWA==
X-Received: by 2002:a1c:9d17:: with SMTP id g23mr1902961wme.38.1589519982178; 
 Thu, 14 May 2020 22:19:42 -0700 (PDT)
Received: from twisty.localdomain
 (dynamic-2a01-0c22-c877-2100-f914-43b7-6b66-02cf.c22.pool.telefonica.de.
 [2a01:c22:c877:2100:f914:43b7:6b66:2cf])
 by smtp.gmail.com with ESMTPSA id s8sm1554631wrt.69.2020.05.14.22.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 22:19:41 -0700 (PDT)
From: Mario Kleiner <mario.kleiner.de@gmail.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/display: Enable fp16 also on DCE-11.0 - DCE-12.
Date: Fri, 15 May 2020 07:19:24 +0200
Message-Id: <20200515051924.12331-3-mario.kleiner.de@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200515051924.12331-1-mario.kleiner.de@gmail.com>
References: <20200515051924.12331-1-mario.kleiner.de@gmail.com>
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com, mario.kleiner.de@gmail.com,
 nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Testing on a Polaris11 gpu with DCE-11.2 suggests that it
seems to work fine there, so optimistically enable it for
DCE-11 and later.

Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
index 9597fc79d7fa..a043ddae5149 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
@@ -410,7 +410,7 @@ static const struct dc_plane_cap plane_cap = {
 		.pixel_format_support = {
 				.argb8888 = true,
 				.nv12 = false,
-				.fp16 = false
+				.fp16 = true
 		},
 
 		.max_upscale_factor = {
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index 4a7796de2ff5..51b3fe502670 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -411,7 +411,7 @@ static const struct dc_plane_cap plane_cap = {
 	.pixel_format_support = {
 			.argb8888 = true,
 			.nv12 = false,
-			.fp16 = false
+			.fp16 = true
 	},
 
 	.max_upscale_factor = {
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
index 9a9764cbd78d..8f362e8c1787 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
@@ -516,7 +516,7 @@ static const struct dc_plane_cap plane_cap = {
 	.pixel_format_support = {
 			.argb8888 = true,
 			.nv12 = false,
-			.fp16 = false
+			.fp16 = true
 	},
 
 	.max_upscale_factor = {
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
