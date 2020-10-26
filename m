Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71F4C2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 15:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 706D1217A0
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 15:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4RcA6qp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706D1217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13DC489DE5;
	Mon, 26 Oct 2020 15:57:52 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E892589DE5
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 15:57:50 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id s14so8773694qkg.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 08:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EblfvKtPvB44mQIHrmbIZe68et6Vzps5yYjVo0mWc1Q=;
 b=Q4RcA6qp18jKm7CCpfLvnX38AdF+aoA5nGVnCntLIXu8rOrB6/d+8qSIMGe5fBc6Ej
 6PaQgq7x2uK1KfIYzzVQoXqAgBG1xjxNt6RxQPLEAItdY0BQAAdTt5qXFnAewpttNPJp
 9RxUQOt+QMNXo3ShqmfnMCa/eWnz3/LbLEeqme1I+gEazF+GI+3k2KURBgPAntcKPjH/
 YRXLDlX62aN1dYP0yBKCEG/71z+1eDaxO13tH13oDbEelbGoqeZHrJNH+VUD0/GC2l+I
 qjYCqr9V+ZAd7QyocFUa/3ltKXi4tEiceVLx1ZbAlsR3GzZkxZc7J5qsJvp4xz7cRBoT
 r26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EblfvKtPvB44mQIHrmbIZe68et6Vzps5yYjVo0mWc1Q=;
 b=bGze3KE9Sa/JI9SNobbr8OOdSPVXqMNRrnQEjtH12QNwgUQl5bCOQ50epa+VY3iVIN
 z6mS5tpU/ylcIrqjFS+HrauW9TeMdK2yuX5waHYF1ReXqXo0ZfK53/zFisT2U1DNsCsY
 zbn8/6Ygt6Oo/XG87sAL2zIJtlUkXUoR8r1uWEGq+NvLX8ErZUch8c1Hr0wAr7V+rVSA
 oFQQbvYC46lDWKpOCi07k0BiveDakUN+ieNUpMSAOrUC1/tI8w4/YkbgpQ3/OrgP6fB6
 h5925gzp6n0cRi2PtQUnU8bJ4qOW+pDuKmtg2r+axWPztoOBFoFS+nUzwxMDb8mK5YGN
 pnMw==
X-Gm-Message-State: AOAM531kSNAfCUtCi0n4kIsbUABJ9jIyaaO/+aZFAF0zuUOCdxIQb1YK
 Fhr2guQZft51A3UrLKF31zMsj3gCgYs=
X-Google-Smtp-Source: ABdhPJzsSHJDJwDVwA5RDO1l278Q49woE2IweslORMHLbEviLaKoqjdCOwCr4Ippffy0SerhBbboUg==
X-Received: by 2002:a37:c49:: with SMTP id 70mr15205569qkm.345.1603727868209; 
 Mon, 26 Oct 2020 08:57:48 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id 82sm6776489qke.130.2020.10.26.08.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 08:57:47 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/display: fix abm shift and mask lists for
 DCN3.01/3.02
Date: Mon, 26 Oct 2020 11:57:37 -0400
Message-Id: <20201026155738.964136-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Updating these were missed.

Fixes: 2c8193fc72b1c5 ("drm/amd/display: Refactor ABM_MASK_SH_LIST_DCN301 naming")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index fe46a0b911fc..5a47b4106b7b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -363,11 +363,11 @@ static const struct dce_abm_registers abm_regs[] = {
 };
 
 static const struct dce_abm_shift abm_shift = {
-		ABM_MASK_SH_LIST_DCN301(__SHIFT)
+		ABM_MASK_SH_LIST_DCN30(__SHIFT)
 };
 
 static const struct dce_abm_mask abm_mask = {
-		ABM_MASK_SH_LIST_DCN301(_MASK)
+		ABM_MASK_SH_LIST_DCN30(_MASK)
 };
 
 #define audio_regs(id)\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 38e807f22060..c4ffed95d35e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -1276,11 +1276,11 @@ static const struct dce_abm_registers abm_regs[] = {
 };
 
 static const struct dce_abm_shift abm_shift = {
-		ABM_MASK_SH_LIST_DCN301(__SHIFT)
+		ABM_MASK_SH_LIST_DCN30(__SHIFT)
 };
 
 static const struct dce_abm_mask abm_mask = {
-		ABM_MASK_SH_LIST_DCN301(_MASK)
+		ABM_MASK_SH_LIST_DCN30(_MASK)
 };
 
 static bool dcn302_resource_construct(
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
