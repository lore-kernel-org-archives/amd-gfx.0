Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01F8C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jun 2022 01:21:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D954113A81;
	Thu, 16 Jun 2022 01:21:33 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C53FF113A81
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 01:21:32 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 m125-20020a1ca383000000b0039c63fe5f64so84537wme.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jun 2022 18:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=froggi.es; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DBv2gHBV2sdesSP92d3b4kvM+uKtkyY978Itk5xSnXM=;
 b=AirjPwQEloFjWyXc/5Sm1LL0/d7Il2/zIlWipFlyDqThLmzm8Ar0jNtsVaZBHGeiv/
 1l8m92Va/+0OPjXptsmCg+8JT+a9zHisylhBW0mfeL3095Swpa0tdYXyu/9JjeRsmVgl
 snCWySAL5B33fBXWS5W3pZ4vyKcoU3vnKKJA2YhIR25jcSWBZtVEyfRBeY8ThRhv+Ebs
 dZtwTfh1YBJAa3J2Lc229coX2O5GF45EMhcrS27X0e44dfYOwz8GAXipyP9BboygZNXH
 520pKxWizGdsHHAAoyJkfyIoX7lMYzJf3PyzwtNujvkC+0TDX0mJTv78JkNwSZ/C5z48
 njeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DBv2gHBV2sdesSP92d3b4kvM+uKtkyY978Itk5xSnXM=;
 b=KC1e+J6bdj0ifu0iI8JRFZ6oVtZb9nfv+I6CIiXwekHhcCdbhsehB3W8tEd5dyMxqP
 GwzCUEtriPHNS43CXbgZuuBHPkIfk1OtT2GkSyMBd3p42pR496xAGrabIsz1UnxlqMDR
 GxWsM8JNdQtOEr5bpAWcJ6uznSjulpEeYBY8J6RD/kfV3dymcqeaDpaegJqufk7SA/Sg
 soFi1YsRvB6nonJjc47hSmG1c77nPnWI0ZG22Q6ihMyYBTQXjdNP2b4scXcaurGD3PVh
 kbp6YXNp6E71oBtnPZ55SSaV1ByYuM6ioZD5IelAvdf4T/G5xQZA2x5brogsMDItq8om
 GYjw==
X-Gm-Message-State: AOAM533Du5QEYqoXGE46zev3GVLmZUPqYyRMkv1WfkBySlqPMZnICt+v
 s8V/V7p2c84zoPKWlwAjLm/onePsxL/tXw==
X-Google-Smtp-Source: ABdhPJwIgScPRw2xDmsQadieIDLTv/4d0cRkGOllIx36VToT7dJXMjlucQVmLoDtu2i/hgVTEnggWA==
X-Received: by 2002:a1c:28b:0:b0:39c:48ce:88c8 with SMTP id
 133-20020a1c028b000000b0039c48ce88c8mr12532091wmc.7.1655342491308; 
 Wed, 15 Jun 2022 18:21:31 -0700 (PDT)
Received: from localhost.localdomain
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 j19-20020a05600c1c1300b0039c5645c60fsm9487922wms.3.2022.06.15.18.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jun 2022 18:21:30 -0700 (PDT)
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] amd/display/dc: Fix COLOR_ENCODING and COLOR_RANGE doing
 nothing for DCN20+
Date: Thu, 16 Jun 2022 01:21:27 +0000
Message-Id: <20220616012127.793375-1-joshua@froggi.es>
X-Mailer: git-send-email 2.36.1
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
Cc: Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For DCN20 and above, the code that actually hooks up the provided
input_color_space got lost at some point.

Fixes COLOR_ENCODING and COLOR_RANGE doing nothing on DCN20+.
Tested using Steam Remote Play Together + gamescope.

Signed-off-by: Joshua Ashton <joshua@froggi.es>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c   | 3 +++
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c | 3 +++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c   | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
index 970b65efeac1..eaa7032f0f1a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
@@ -212,6 +212,9 @@ static void dpp2_cnv_setup (
 		break;
 	}
 
+	/* Set default color space based on format if none is given. */
+	color_space = input_color_space ? input_color_space : color_space;
+
 	if (is_2bit == 1 && alpha_2bit_lut != NULL) {
 		REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT0, alpha_2bit_lut->lut0);
 		REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT1, alpha_2bit_lut->lut1);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
index 8b6505b7dca8..f50ab961bc17 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
@@ -153,6 +153,9 @@ static void dpp201_cnv_setup(
 		break;
 	}
 
+	/* Set default color space based on format if none is given. */
+	color_space = input_color_space ? input_color_space : color_space;
+
 	if (is_2bit == 1 && alpha_2bit_lut != NULL) {
 		REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT0, alpha_2bit_lut->lut0);
 		REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT1, alpha_2bit_lut->lut1);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
index 9cca59bf2ae0..3c77949b8110 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
@@ -294,6 +294,9 @@ void dpp3_cnv_setup (
 		break;
 	}
 
+	/* Set default color space based on format if none is given. */
+	color_space = input_color_space ? input_color_space : color_space;
+
 	if (is_2bit == 1 && alpha_2bit_lut != NULL) {
 		REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT0, alpha_2bit_lut->lut0);
 		REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT1, alpha_2bit_lut->lut1);
-- 
2.36.1

