Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24050C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:30:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC59F20776
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUb1bZM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC59F20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93F756E9ED;
	Mon,  1 Jun 2020 18:30:20 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 821876E9ED
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:30:18 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id 205so10048618qkg.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xV5LYC2ntqUBh5Qb/8Gu60NmtZLVWqRyp/VPikjxHBc=;
 b=fUb1bZM89iBrTFtJuAgqiH3h8phw9DTwDnF2htvjzDVAozxnmDccAPFsQ9loLUT2is
 0GWvDoDWBDTLvOc49AuBVW3QaQBb8P+hu+K/LqaDF9PkvuCS8/8Bkh8y4I4dUkI3Reqx
 zVKsGNA0k08Rbb9pQqcALFEvrI8zdMiA6blm2ZDTxIljD0VaTW50koNYN5AoNzC7xiDd
 4y8RTcGCDTA7qXK+sYqVX7sxgekB6fj0kosriQ4EJhASXIHIYQu0MIciAs6oCh+ZI+3c
 0tB99odagXXvI68rWy5uW4MFup0VJ3mplN3vkiG6nIDnWKogEPY2O+CftWV9wmKiTbRM
 GsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xV5LYC2ntqUBh5Qb/8Gu60NmtZLVWqRyp/VPikjxHBc=;
 b=PwhlMC7zy1EVWzh++5asDBgMF0WKPv5wd9sQUFGbkMPjqkURa3egbrOZO9XYqM+GXE
 1/Gbo8hzFG7LRfosOWxziQVP+l2vm/XXm7TsbFUYZLGkVa2vE1YtiMEDoRZx2yp90oKx
 MyOFRS0urffMAJ81Nq3geDL/+d2HdgkfZeyPNgiKMsW2Ebgd6sKRtEfwHZDMvs65eXYS
 fsof8bfeqA3rTZCU+zizvVFm+ZXGOnoGKA4IZg9VNT9FLYJf6bLS8E45hJXxcm1OnfCG
 4U9SIWqkngLNmrRtZpaQQHfEh5dpxzydLQ9Em/CZsLc2mu84I1mXYjw/F2A4rAE9OKBx
 dBmg==
X-Gm-Message-State: AOAM530Jk3u2UpRVprZuZuDfqBKwtKDGLq1u0TG4B6zMKcRkFab7oLj0
 cxoNzsKZyjhOKUOfEam4govPGfuj
X-Google-Smtp-Source: ABdhPJwHKvYn3lmlDDDT+xBWlLB4z8c3R3uZBX1lUPa9m/Q3OKK0LQgUVd0VhXkpu7Fgi01/IZGOTQ==
X-Received: by 2002:a05:620a:2290:: with SMTP id
 o16mr21626305qkh.205.1591036217435; 
 Mon, 01 Jun 2020 11:30:17 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id z194sm8592qkb.73.2020.06.01.11.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:30:16 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 203/207] drm/amd/display: Remove Unused Registers
Date: Mon,  1 Jun 2020 14:29:22 -0400
Message-Id: <20200601182926.1267958-25-alexander.deucher@amd.com>
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
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c    | 17 -----------------
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h    | 12 ------------
 .../amd/display/dc/dcn20/dcn20_link_encoder.h   |  3 +--
 3 files changed, 1 insertion(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
index 1b1ae9ce2799..3c6ecfe141bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
@@ -717,22 +717,5 @@ static void dsc_write_to_registers(struct display_stream_compressor *dsc, const
 		RANGE_MAX_QP14, reg_vals->pps.rc_range_params[14].range_max_qp,
 		RANGE_BPG_OFFSET14, reg_vals->pps.rc_range_params[14].range_bpg_offset);
 
-	if (IS_FPGA_MAXIMUS_DC(dsc20->base.ctx->dce_environment)) {
-		/* It's safe to do this as long as debug bus is not being used in DAL Diag environment.
-		 *
-		 * This is because DSCC_PPS_CONFIG4.INITIAL_DEC_DELAY is a read-only register field (because it's a decoder
-		 * value not required by DSC encoder). However, since decoding fails when this value is missing from PPS, it's
-		 * required to communicate this value to the PPS header. When testing on FPGA, the values for PPS header are
-		 * being read from Diag register dump. The register below is used in place of a scratch register to make
-		 * 'initial_dec_delay' available.
-		 */
-
-		temp_int = reg_vals->pps.initial_dec_delay;
-		REG_SET_4(DSCC_TEST_DEBUG_BUS_ROTATE, 0,
-			DSCC_TEST_DEBUG_BUS0_ROTATE, temp_int & 0x1f,
-			DSCC_TEST_DEBUG_BUS1_ROTATE, temp_int >> 5 & 0x1f,
-			DSCC_TEST_DEBUG_BUS2_ROTATE, temp_int >> 10 & 0x1f,
-			DSCC_TEST_DEBUG_BUS3_ROTATE, temp_int >> 15 & 0x1);
-	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h
index 9855a7ed0387..667640c4b288 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h
@@ -78,7 +78,6 @@
 	SRI(DSCC_RATE_CONTROL_BUFFER1_MAX_FULLNESS_LEVEL, DSCC, id),\
 	SRI(DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL, DSCC, id),\
 	SRI(DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL, DSCC, id),\
-	SRI(DSCC_TEST_DEBUG_BUS_ROTATE, DSCC, id),\
 	SRI(DSCCIF_CONFIG0, DSCCIF, id),\
 	SRI(DSCCIF_CONFIG1, DSCCIF, id),\
 	SRI(DSCRM_DSC_FORWARD_CONFIG, DSCRM, id)
@@ -95,8 +94,6 @@
 	DSC_SF(DSC_TOP0_DSC_TOP_CONTROL, DSC_CLOCK_EN, mask_sh), \
 	DSC_SF(DSC_TOP0_DSC_TOP_CONTROL, DSC_DISPCLK_R_GATE_DIS, mask_sh), \
 	DSC_SF(DSC_TOP0_DSC_TOP_CONTROL, DSC_DSCCLK_R_GATE_DIS, mask_sh), \
-	DSC_SF(DSC_TOP0_DSC_DEBUG_CONTROL, DSC_DBG_EN, mask_sh), \
-	DSC_SF(DSC_TOP0_DSC_DEBUG_CONTROL, DSC_TEST_CLOCK_MUX_SEL, mask_sh), \
 	DSC_SF(DSCC0_DSCC_CONFIG0, ICH_RESET_AT_END_OF_LINE, mask_sh), \
 	DSC_SF(DSCC0_DSCC_CONFIG0, NUMBER_OF_SLICES_PER_LINE, mask_sh), \
 	DSC_SF(DSCC0_DSCC_CONFIG0, ALTERNATE_ICH_ENCODING_EN, mask_sh), \
@@ -249,10 +246,6 @@
 	DSC_SF(DSCC0_DSCC_RATE_CONTROL_BUFFER1_MAX_FULLNESS_LEVEL, DSCC_RATE_CONTROL_BUFFER1_MAX_FULLNESS_LEVEL, mask_sh), \
 	DSC_SF(DSCC0_DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL, DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL, mask_sh), \
 	DSC_SF(DSCC0_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL, DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL, mask_sh), \
-	DSC_SF(DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE, DSCC_TEST_DEBUG_BUS0_ROTATE, mask_sh), \
-	DSC_SF(DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE, DSCC_TEST_DEBUG_BUS1_ROTATE, mask_sh), \
-	DSC_SF(DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE, DSCC_TEST_DEBUG_BUS2_ROTATE, mask_sh), \
-	DSC_SF(DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE, DSCC_TEST_DEBUG_BUS3_ROTATE, mask_sh), \
 	DSC_SF(DSCCIF0_DSCCIF_CONFIG0, INPUT_INTERFACE_UNDERFLOW_RECOVERY_EN, mask_sh), \
 	DSC_SF(DSCCIF0_DSCCIF_CONFIG0, INPUT_INTERFACE_UNDERFLOW_OCCURRED_INT_EN, mask_sh), \
 	DSC_SF(DSCCIF0_DSCCIF_CONFIG0, INPUT_INTERFACE_UNDERFLOW_OCCURRED_STATUS, mask_sh), \
@@ -427,10 +420,6 @@
 	type DSCC_UPDATE_PENDING_STATUS; \
 	type DSCC_UPDATE_TAKEN_STATUS; \
 	type DSCC_UPDATE_TAKEN_ACK; \
-	type DSCC_TEST_DEBUG_BUS0_ROTATE; \
-	type DSCC_TEST_DEBUG_BUS1_ROTATE; \
-	type DSCC_TEST_DEBUG_BUS2_ROTATE; \
-	type DSCC_TEST_DEBUG_BUS3_ROTATE; \
 	type DSCC_RATE_BUFFER0_FULLNESS_LEVEL; \
 	type DSCC_RATE_BUFFER1_FULLNESS_LEVEL; \
 	type DSCC_RATE_BUFFER2_FULLNESS_LEVEL; \
@@ -503,7 +492,6 @@ struct dcn20_dsc_registers {
 	uint32_t DSCC_RATE_CONTROL_BUFFER1_MAX_FULLNESS_LEVEL;
 	uint32_t DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL;
 	uint32_t DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL;
-	uint32_t DSCC_TEST_DEBUG_BUS_ROTATE;
 	uint32_t DSCCIF_CONFIG0;
 	uint32_t DSCCIF_CONFIG1;
 	uint32_t DSCRM_DSC_FORWARD_CONFIG;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
index a6c8493001a6..db09f40075c2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
@@ -147,8 +147,7 @@
 	LE_SF(DPCSTX0_DPCSTX_TX_CNTL, DPCS_TX_DATA_SWAP, mask_sh),\
 	LE_SF(DPCSTX0_DPCSTX_TX_CNTL, DPCS_TX_DATA_ORDER_INVERT, mask_sh),\
 	LE_SF(DPCSTX0_DPCSTX_TX_CNTL, DPCS_TX_FIFO_EN, mask_sh),\
-	LE_SF(DPCSTX0_DPCSTX_TX_CNTL, DPCS_TX_FIFO_RD_START_DELAY, mask_sh),\
-	LE_SF(DPCSTX0_DPCSTX_DEBUG_CONFIG, DPCS_DBG_CBUS_DIS, mask_sh)
+	LE_SF(DPCSTX0_DPCSTX_TX_CNTL, DPCS_TX_FIFO_RD_START_DELAY, mask_sh)
 
 #define DPCS_DCN2_MASK_SH_LIST(mask_sh)\
 	DPCS_MASK_SH_LIST(mask_sh),\
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
