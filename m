Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37831C6FA83
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Sep 2022 16:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8910010E08C;
	Tue,  6 Sep 2022 16:46:47 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65A4310E08C
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Sep 2022 16:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eUiu9Wjf4cO16yZY2bNhlA8qvES7ZdJnbNszqoBABJk=; b=HJEfrw7ve1fWLHFEU+vC4hbdr1
 faYCqAwgoFhilLgJE7rmNNV8wZ3juHKuWJXpnCT8sDKUf02yyxHjI66CrrEKzEPqvRiW59dcjEUy6
 aLZlc9hFN45ZeLoayIgKDABKGdoXy9jsCBe2lRJOCFEe1n7Fz+CgoYs045cp398hiQ8U078nuvdLE
 NS1upXstWneuYS8QWSQAJigoJzJogkCMkq2Sb6V5oA2K7Ahada0O1vrIvZwpuHnMgQzdrOR/6oAS0
 Rqndyr+FU6X7xWs8jPuZ/p1a6NKpejpj4ciNEAbm6isctdzuSz+0pTwDRiR0KsaShbQMKPKAOXQGT
 dLGH+56w==;
Received: from [38.44.74.92] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1oVbil-00CALM-Ck; Tue, 06 Sep 2022 18:46:43 +0200
From: Melissa Wen <mwen@igalia.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 alex.hung@amd.com, harry.wentland@amd.com, sunpeng.li@amd.com,
 Rodrigo.Siqueira@amd.com
Subject: [RFC PATCH v2 1/9] drm/amd/display: remove unused regamma condition
Date: Tue,  6 Sep 2022 15:46:20 -0100
Message-Id: <20220906164628.2361811-2-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220906164628.2361811-1-mwen@igalia.com>
References: <20220906164628.2361811-1-mwen@igalia.com>
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
Cc: amd-gfx@lists.freedesktop.org, nikola.cornij@amd.com, kernel-dev@igalia.com,
 bhawanpreet.lakha@amd.com, nicholas.kazlauskas@amd.com, sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The function __set_output_tf is only called by
amdgpu_dm_update_crtc_color_mgmt() when using atomic regamma. In this
situation, func->tf == TRANSFER_FUNCTION_LINEAR (the original if
condition) and it never falls into tf != LINEAR (the else condition).
Therefore, remove unused condition to avoid misunderstandings here.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 32 ++++++-------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index a4cb23d059bd..10a29d131424 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -255,14 +255,13 @@ static int __set_legacy_tf(struct dc_transfer_func *func,
  * @func: transfer function
  * @lut: lookup table that defines the color space
  * @lut_size: size of respective lut
- * @has_rom: if ROM can be used for hardcoded curve
  *
  * Returns:
  * 0 in case of success. -ENOMEM if fails.
  */
 static int __set_output_tf(struct dc_transfer_func *func,
-			   const struct drm_color_lut *lut, uint32_t lut_size,
-			   bool has_rom)
+			   const struct drm_color_lut *lut,
+			   uint32_t lut_size)
 {
 	struct dc_gamma *gamma = NULL;
 	struct calculate_buffer cal_buffer = {0};
@@ -279,24 +278,13 @@ static int __set_output_tf(struct dc_transfer_func *func,
 	gamma->num_entries = lut_size;
 	__drm_lut_to_dc_gamma(lut, gamma, false);
 
-	if (func->tf == TRANSFER_FUNCTION_LINEAR) {
-		/*
-		 * Color module doesn't like calculating regamma params
-		 * on top of a linear input. But degamma params can be used
-		 * instead to simulate this.
-		 */
-		gamma->type = GAMMA_CUSTOM;
-		res = mod_color_calculate_degamma_params(NULL, func,
-							gamma, true);
-	} else {
-		/*
-		 * Assume sRGB. The actual mapping will depend on whether the
-		 * input was legacy or not.
-		 */
-		gamma->type = GAMMA_CS_TFM_1D;
-		res = mod_color_calculate_regamma_params(func, gamma, false,
-							 has_rom, NULL, &cal_buffer);
-	}
+	/*
+	 * Color module doesn't like calculating regamma params
+	 * on top of a linear input. But degamma params can be used
+	 * instead to simulate this.
+	 */
+	gamma->type = GAMMA_CUSTOM;
+	res = mod_color_calculate_degamma_params(NULL, func, gamma, true);
 
 	dc_gamma_release(&gamma);
 
@@ -450,7 +438,7 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
 		stream->out_transfer_func->tf = TRANSFER_FUNCTION_LINEAR;
 
 		r = __set_output_tf(stream->out_transfer_func, regamma_lut,
-				    regamma_size, has_rom);
+				    regamma_size);
 		if (r)
 			return r;
 	} else {
-- 
2.35.1

