Return-Path: <SRS0=xwQz=A3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4A4C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F172E20787
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3FofJWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F172E20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 076916EC79;
	Thu, 16 Jul 2020 21:23:16 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B40489F07
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:23:13 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id 22so11731829wmg.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 14:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Nake6tZtvxt8rH5cDJXV/sNxKBCyoeviR3w6k0C6X+k=;
 b=Q3FofJWeQNxQ7FEH3AiIQekQLiWxCQII6fhlI8qrgFTGKw1C6eNZAsoAUFuZzlGe9s
 TS5cgKIp1eVpWkzV27TsGmiLvi68p3U7yfPA1IlG1MFzRyeVYFQ9oEFyqRJsfjGw/H6V
 cJBbEVJye30fNSKiOtq2015ub2ZgxQU0JDet+A+jyF28vMGsT1LPJoxtUwWSTcGrLoVL
 uTLApIAVllrz0z18TbN6rghtM29PvwB6elPmci6m4Z4E6NpPQVgGWXgWh3Ewm/ycBiMZ
 R9AzgGe7q0+voBPXCxwdx8iy7A7wvapqdwaclJmQj8N04gVJ4Ooem+jEeyej5rs0StuE
 1nJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Nake6tZtvxt8rH5cDJXV/sNxKBCyoeviR3w6k0C6X+k=;
 b=r+p1xNAtkykawjw2dU/reZYcbkKll8fx6SvU4VowN/hufo5eEVq5pyABwnDcZKENYU
 FQ9GlGrhHzLGADKkavBPJydGvJVO8630dCWCdj6/DkbnadpOvsFtIxsPqVQ7bt6W2Wyk
 7FQJbQW7hCKPD1f/GOOIfoaF2IomEeh1MU3cZ4VtZTHQMNqSg1gRQAYrxDyWMtid2vyb
 ur+/eBBcNUkXNno+jvYuFhVUHV9htfxHBDmYfnUCaQQ2I5Gte6YZad1FUxHK4rWOyWFL
 WM5Jtrt/HMfcAid57bbdypJQ6Uo1Yy+asivTnPBogiNgzRUI7lHHwCP4lKn114mJr/UP
 qNJw==
X-Gm-Message-State: AOAM531tVw9aAxv7umBUJN3jQqYP43uSzW2HpTe+XYZsYVKudXpWx/st
 zF2Df0vabvMPdBi3SmKsnviINEo3HR8=
X-Google-Smtp-Source: ABdhPJx6bWoEulG0r1ch4CWUERg6iMS04LGovw+147fEmRRjmPvbNcqcp6n29Xb6H+vfj01EXAeUrA==
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr6330889wmj.112.1594934591659; 
 Thu, 16 Jul 2020 14:23:11 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-21-65-179.retail.telecomitalia.it. [79.21.65.179])
 by smtp.googlemail.com with ESMTPSA id c15sm10288696wme.23.2020.07.16.14.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 14:23:11 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 04/27] drm/amd/display: dc/core: add SI/DCE6 support (v2)
Date: Thu, 16 Jul 2020 23:22:28 +0200
Message-Id: <20200716212251.1539094-5-issor.oruam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716212251.1539094-1-issor.oruam@gmail.com>
References: <20200716212251.1539094-1-issor.oruam@gmail.com>
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
Cc: alexander.deucher@amd.com, Mauro Rossi <issor.oruam@gmail.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
resource_parse_asic_id() and dc_create_resource_pool() are missing SI/DCE6 cases

[How]
SI/DCE6 cases support added using existing DCE8 implementation as a reference

(v2) updated due to following kernel 5.2 commit:
     d9673c9 ("drm/amd/display: Pass init_data into DCN resource creation")

Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 7b5f90ebb133..ca26714c800e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -42,6 +42,9 @@
 #include "virtual/virtual_stream_encoder.h"
 #include "dpcd_defs.h"
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+#include "dce60/dce60_resource.h"
+#endif
 #include "dce80/dce80_resource.h"
 #include "dce100/dce100_resource.h"
 #include "dce110/dce110_resource.h"
@@ -63,6 +66,18 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 	enum dce_version dc_version = DCE_VERSION_UNKNOWN;
 	switch (asic_id.chip_family) {
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+	case FAMILY_SI:
+		if (ASIC_REV_IS_TAHITI_P(asic_id.hw_internal_rev) ||
+		    ASIC_REV_IS_PITCAIRN_PM(asic_id.hw_internal_rev) ||
+		    ASIC_REV_IS_CAPEVERDE_M(asic_id.hw_internal_rev))
+		dc_version = DCE_VERSION_6_0;
+		else if (ASIC_REV_IS_OLAND_M(asic_id.hw_internal_rev))
+			dc_version = DCE_VERSION_6_4;
+		else
+			dc_version = DCE_VERSION_6_1;
+		break;
+#endif
 	case FAMILY_CI:
 		dc_version = DCE_VERSION_8_0;
 		break;
@@ -129,6 +144,20 @@ struct resource_pool *dc_create_resource_pool(struct dc  *dc,
 	struct resource_pool *res_pool = NULL;
 
 	switch (dc_version) {
+#if defined(CONFIG_DRM_AMD_DC_SI)
+	case DCE_VERSION_6_0:
+		res_pool = dce60_create_resource_pool(
+			init_data->num_virtual_links, dc);
+		break;
+	case DCE_VERSION_6_1:
+		res_pool = dce61_create_resource_pool(
+			init_data->num_virtual_links, dc);
+		break;
+	case DCE_VERSION_6_4:
+		res_pool = dce64_create_resource_pool(
+			init_data->num_virtual_links, dc);
+		break;
+#endif
 	case DCE_VERSION_8_0:
 		res_pool = dce80_create_resource_pool(
 				init_data->num_virtual_links, dc);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
