Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0ADC433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:30:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A686E2074B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSvsIdCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A686E2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BC6A6E9E8;
	Mon,  1 Jun 2020 18:30:17 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F232B6E9E6
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:30:16 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id 205so10048548qkg.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tBINmlmam8kXQqEoXmXJRz1H7SmtD1BeQjHwCcE2hiM=;
 b=mSvsIdCDUwrv5gXVLgy1of4Af1KwG9Ow+2HATrtF8GzP4Tj0fiCO9KlpTfJINpkB/u
 XqSTxgqmHWFZeAhlWJ6T3BAZLVDZhunq5FKwXVyeFnP1IvEF8Jmcfloeo44wpCJ1Ma5V
 AuLW5lDoN9YIuy96mKkP6TzXGbLIQedca3SRzekEZ/1QhGEK7uJUiRfyPYe2LmiCvTwK
 WSqUzbG3OOHjzg7urrf3GleisjDPGuqbCq/5hyYmx7HTiA67moSLXWR5VjDnglzxUymR
 hFeK7vxrDLLqYy91EkLpIYgMuNpRDT70TyIkMj+5zXCgghD8m1Q5oOz2gxHGfDjLpg1l
 RLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tBINmlmam8kXQqEoXmXJRz1H7SmtD1BeQjHwCcE2hiM=;
 b=DjhIBkQQ4Tfp4u+Vo9OmeRpZ8htXE2IGHfpxBywiN0W32uVzCfbVsNHXmDAbPb0dHR
 t3RFPvshfqRrVFC2bt5oz90AhwU+xD8sCQN3Su4Jdue1+luJVqhia7JKS0w5ey4KIvsz
 7uWPhqLzMZffre1zjxzeZzSFkBNyKz7QZqu5nFPML29WdlOwTD7+fmliYA+dIxkIwf/9
 P8wG2OZMKSU4ZiuEhI0CnnB84llzQT61E0mR/1RX7tO7SmGE1INxiOhtPBTXFOVthtwO
 DhL1AsqTFW9kcWMHBANNHgtgx96gRIxJ4gaD2BJCue3R1cV0OVnk73s/f4JCMC2ywtoK
 4LuA==
X-Gm-Message-State: AOAM531X4j777HYCuBeJUwSyuJzmo8S8paUBem2eMpnXzRPmMQyv4a19
 OkWDtNWFICirr4y5kGahyvb2aiq9
X-Google-Smtp-Source: ABdhPJyGMJ7dIL0mpl0gRhR+xY1R4xNCune7ZL3s+hF3Pn0pa/GmrdahuF79FMUfVfzari13AHNYCg==
X-Received: by 2002:a37:a4ca:: with SMTP id
 n193mr20169326qke.261.1591036215849; 
 Mon, 01 Jun 2020 11:30:15 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id z194sm8592qkb.73.2020.06.01.11.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:30:15 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 202/207] drm/amd/display: Handle RGBE_ALPHA Pixel Format
Date: Mon,  1 Jun 2020 14:29:21 -0400
Message-Id: <20200601182926.1267958-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182926.1267958-1-alexander.deucher@amd.com>
References: <20200601182926.1267958-1-alexander.deucher@amd.com>
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
index 1e5a92b192a1..555af29565aa 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
@@ -374,6 +374,13 @@ static void pipe_ctx_to_e2e_pipe_params (
 		input->src.viewport_width_c    = input->src.viewport_width;
 		input->src.viewport_height_c   = input->src.viewport_height;
 		break;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA:
+		input->src.source_format = dm_rgbe_alpha;
+		input->src.viewport_width_c    = input->src.viewport_width;
+		input->src.viewport_height_c   = input->src.viewport_height;
+		break;
+#endif
 	default:
 		input->src.source_format = dm_444_32;
 		input->src.viewport_width_c    = input->src.viewport_width;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
