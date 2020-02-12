Return-Path: <SRS0=l6GN=4A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102AEC2BA83
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 04:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C0A20848
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 04:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MajzqVIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C0A20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 663C26E5D3;
	Wed, 12 Feb 2020 04:33:17 +0000 (UTC)
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com
 [IPv6:2607:f8b0:4864:20::b42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 492746E4AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 04:33:16 +0000 (UTC)
Received: by mail-yb1-xb42.google.com with SMTP id x191so458746ybg.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 20:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7PJ/r1K24eno9F0izEkDsLH2/2KQLBSSH8pPy9GMptI=;
 b=MajzqVIgq/Sc0DsSe2PCEdQ0z5aKqtnv4xkf50KX4Kf9TO2BQfrTI0g0f6OhE9/RWi
 kvq3m/n5YQ2uzzhc909NkmBcN0/dyURXzEO9J2qcfooe9GQ7eqsFDh7wx8r46AIQeyXN
 ts6LerIG1KXq1WcID38MS07DwVV9CGemkSP23bs6GRoTmjYQeU1d/2I7VMmOHgUx47gd
 QIHhxNc4GbkN4s8+dfvpBjIOeqYkTRJzBHt4sCo5KacuL1RZ2/wyYbwazGSGfqg7rEz1
 enBEh/vx7e5evsvfa6R32XbX8mKyXhFDpY6R1XgHlBcVfy4naxQK8edrVGQW10bQgFOf
 A23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7PJ/r1K24eno9F0izEkDsLH2/2KQLBSSH8pPy9GMptI=;
 b=lT0uI4i8NeUohvyo6NHbg03iWZYE6HtxRDAHs48U4rsaD/s1gjopZVNDvXy1Db1qeg
 sPIw+S9DvBiFGhO2sOgav+j1vT1xv4CyX2gTLhCBhKSuiNNNsg9pDSIF+Va5furc/8oq
 nVx5B/840OXDD2nTmXsZkGN+j9zTbEisfIdecDXjgvKuPjFPO/L/YcKMqjUcuGH7oFek
 qJfQhxuIHRo9WXlGhB+sdgXm6jmlW2LEG50hnAkZ2EeQrOhblMtVY/F/Bt1vN1PRT8F8
 1z4XFkS53wgA7l+CfzuktzBKtvwHwWUvKugcK7IqjrRmjES3xdMKUcH871mUiIKooLAc
 ziRA==
X-Gm-Message-State: APjAAAUnO3gqgkr7jG/1AuEDTR6j7T19x3+Xu8q4NbOMb86EOstYOynN
 Mbe/v23VX62LTUXipSL19yOmQgwi
X-Google-Smtp-Source: APXvYqwytJsaVzoK1ZAexntE9y/u/O92XkB5whlZpUeZwUiTqfBzp3Q/FMs1CJIVj28MLi7F1z0keA==
X-Received: by 2002:a81:3ad0:: with SMTP id h199mr8234387ywa.37.1581481995145; 
 Tue, 11 Feb 2020 20:33:15 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h23sm2966676ywc.105.2020.02.11.20.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 20:33:14 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu/display: extend DCN guard in
 dal_bios_parser_init_cmd_tbl_helper2
Date: Tue, 11 Feb 2020 23:32:56 -0500
Message-Id: <20200212043258.1123758-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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

To cover DCN 2.x.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/bios/command_table_helper2.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
index 7388c987c595..204d7942a6e5 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
@@ -53,25 +53,18 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
 
 	case DCE_VERSION_11_2:
 	case DCE_VERSION_11_22:
+	case DCE_VERSION_12_0:
+	case DCE_VERSION_12_1:
 		*h = dal_cmd_tbl_helper_dce112_get_table2();
 		return true;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	case DCN_VERSION_1_0:
 	case DCN_VERSION_1_01:
-		*h = dal_cmd_tbl_helper_dce112_get_table2();
-		return true;
-#endif
-
 	case DCN_VERSION_2_0:
-		*h = dal_cmd_tbl_helper_dce112_get_table2();
-		return true;
 	case DCN_VERSION_2_1:
 		*h = dal_cmd_tbl_helper_dce112_get_table2();
 		return true;
-	case DCE_VERSION_12_0:
-	case DCE_VERSION_12_1:
-		*h = dal_cmd_tbl_helper_dce112_get_table2();
-		return true;
+#endif
 
 	default:
 		/* Unsupported DCE */
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
