Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38000C64ED8
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 12:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2411710E8B5;
	Tue, 14 Feb 2023 12:14:19 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96A6A10E8B1
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 12:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HRjyoFpu7GFAe6CAKmDRcmxaj/ejcuirGwxv1Ez2c/s=; b=B1n2A2q6UyfUwztrpI+0BeRuRV
 TCJWB5u7vVRRck5mv0yTQ0cpUYWvehbSQh9J+g/Ta90ni86Pp05FgCxlkVdSRY5sdWO3o+YFoTg2Y
 QL7AAf6qhb3mhT40UcIPsNcblZkPPffefWWmNDwuRx9zg4uhfI+PWIh+IgHl5lWKwhoPTVcDOYVn5
 m8rfVXLp1quYRqk13qViJZUaBT/ZYE5aicvyjfTs3PRHD4Ah8XwQRRPSiRIr9z+Zj7avP5gejK/DO
 RzjnVQiUq8h3JobFvKl378LZ5TPlUaCTFI2orOHvnbub17H38UQLf7tVZjrfcbzhr0lP2VQtWql0S
 zb4gIyzQ==;
Received: from [38.44.66.31] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1pRuCJ-0022pF-CT; Tue, 14 Feb 2023 13:14:11 +0100
From: Melissa Wen <mwen@igalia.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/6] drm/amd/display: unset initial value for tf since it's
 never used
Date: Tue, 14 Feb 2023 11:14:04 -0100
Message-Id: <20230214121406.97750-5-mwen@igalia.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230214121406.97750-1-mwen@igalia.com>
References: <20230214121406.97750-1-mwen@igalia.com>
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
Cc: sunpeng.li@amd.com, Xinhui.Pan@amd.com, Rodrigo.Siqueira@amd.com,
 kernel-dev@igalia.com, alexander.deucher@amd.com, harry.wentland@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In mod_color_calculate_{degamma/regamma}_params(), a tf variable is
initialized as TRANSFER_FUNCTION_SRGB but tf is only used after tf =
input->tf, therefore, better to just remove this initial value and avoid
misleading interpretations.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index fdb20dfc70c9..6e606b11286a 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -1883,7 +1883,7 @@ bool mod_color_calculate_degamma_params(struct dc_color_caps *dc_caps,
 	struct pwl_float_data_ex *curve = NULL;
 	struct gamma_pixel *axis_x = NULL;
 	struct pixel_gamma_point *coeff = NULL;
-	enum dc_transfer_func_predefined tf = TRANSFER_FUNCTION_SRGB;
+	enum dc_transfer_func_predefined tf;
 	uint32_t i;
 	bool ret = false;
 
@@ -2125,7 +2125,7 @@ bool mod_color_calculate_regamma_params(struct dc_transfer_func *output_tf,
 	struct pwl_float_data_ex *rgb_regamma = NULL;
 	struct gamma_pixel *axis_x = NULL;
 	struct pixel_gamma_point *coeff = NULL;
-	enum dc_transfer_func_predefined tf = TRANSFER_FUNCTION_SRGB;
+	enum dc_transfer_func_predefined tf;
 	bool do_clamping = true;
 	bool ret = false;
 
-- 
2.39.0

