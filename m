Return-Path: <SRS0=uap9=5Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF20C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 10:57:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D175D20772
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 10:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uubu9Ksq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D175D20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 907E76E7EF;
	Tue, 31 Mar 2020 10:57:43 +0000 (UTC)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A7186E7EF;
 Tue, 31 Mar 2020 10:57:43 +0000 (UTC)
Received: by mail-ed1-x542.google.com with SMTP id u59so24508943edc.12;
 Tue, 31 Mar 2020 03:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=50njG3BRzhgqk7OU18IsJGY20KNwvqHHLF9KB0zfsgo=;
 b=Uubu9KsqB8aCbhmVIfpW06NMwyishZIZ2ihsBkeCXyNwiVNn0xzBG/t83sDY8fr1Op
 qrEMYSkr+0QcC0iR4AEETCyc3j6Cb0oC4l/9qmwEkkn4DOuEL3//xA/Z7Bo1LmNQJfbo
 r1g5SVaFr0kCEr/ygGrytLj2wEpQV5F3Jmn/4m0wf6l3DAOQXSyzqX3OIas/camKKxO4
 Qu2CROFOeCkgD5hClnp3CIXwQDzI0ujwZcotnH018B/3m+kJQZPss82uZyxPm+WtXVKj
 VO22dvOX6Seml5X4fPJxnspl/9+jyDDoWYyZ+4oGjRmHlz9M2GAu7aStN1xkns14W3ms
 ACpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=50njG3BRzhgqk7OU18IsJGY20KNwvqHHLF9KB0zfsgo=;
 b=qbLWR+z6RclilvvPKUWjN1dCuXiUcQI2DfGLozsHBCvDCBU6JndT1I51WmvkfvKuCr
 156gNTRdWOVTXPu7nfvWTmWbeIjOwP4XEVobt6tVFLXy9Z9XBNcO6UGgMSChhBMuVQZx
 6eh8wjUYucX4bVGVexCwp5QuLCuq/BDjkt90YhF/2jgRU3y0dl3aZCgnY5qNHKacQnhj
 irHtv43llPDRs2VCMklAhjqXyCYWqshYobmN9CBBIGpM91TradHM/NN3ZLmTdcSJ3OM6
 +Sc+Zz46qd7TBih1rPADmeXVA6VhAM7v8RBMKKEKzfWHOGWU/yD5/491QfUNjfht18Jt
 AdEg==
X-Gm-Message-State: ANhLgQ2HoJ++PuHTdglUfHu3mrMOQGauaUnP28t8f0dHd0sSJUCo5Mmu
 RKD5UuzENUb3/4/Tf0IxVb4=
X-Google-Smtp-Source: ADFU+vsWMpvsp0nEUUTlASEHri4BOKFbOh2sLTwceT3PcFHSP/2PEQLKrAyUTMhL1W2IflOao7aZSg==
X-Received: by 2002:a05:6402:351:: with SMTP id
 r17mr15613299edw.216.1585652261683; 
 Tue, 31 Mar 2020 03:57:41 -0700 (PDT)
Received: from smtp.gmail.com ([2001:818:e238:a000:51c6:2c09:a768:9c37])
 by smtp.gmail.com with ESMTPSA id j11sm335968ejk.39.2020.03.31.03.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 03:57:41 -0700 (PDT)
Date: Tue, 31 Mar 2020 07:57:34 -0300
From: Melissa Wen <melissa.srw@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>,
 David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, Rodrigo.Siqueira@amd.com
Subject: [PATCH 1/4] drm/amd/display: cleanup codestyle type
 BLOCK_COMMENT_STYLE on dc_link
Message-ID: <e353f1223561ccfa1ab3fc00a5ab996064a418f9.1585651869.git.melissa.srw@gmail.com>
References: <cover.1585651869.git.melissa.srw@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1585651869.git.melissa.srw@gmail.com>
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Solve comments alignment problems on dc_link file

Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 25 +++++++++++--------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 67cfff1586e9..f580b533db5f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -64,11 +64,11 @@
 enum {
 	PEAK_FACTOR_X1000 = 1006,
 	/*
-	* Some receivers fail to train on first try and are good
-	* on subsequent tries. 2 retries should be plenty. If we
-	* don't have a successful training then we don't expect to
-	* ever get one.
-	*/
+	 * Some receivers fail to train on first try and are good
+	 * on subsequent tries. 2 retries should be plenty. If we
+	 * don't have a successful training then we don't expect to
+	 * ever get one.
+	 */
 	LINK_TRAINING_MAX_VERIFY_RETRY = 2
 };
 
@@ -270,7 +270,8 @@ static enum ddc_transaction_type get_ddc_transaction_type(
 	case SIGNAL_TYPE_DISPLAY_PORT_MST:
 		/* MST does not use I2COverAux, but there is the
 		 * SPECIAL use case for "immediate dwnstrm device
-		 * access" (EPR#370830). */
+		 * access" (EPR#370830).
+		 */
 		transaction_type = DDC_TRANSACTION_TYPE_I2C_OVER_AUX;
 		break;
 
@@ -369,7 +370,8 @@ bool dc_link_is_dp_sink_present(struct dc_link *link)
 	/* Open GPIO and set it to I2C mode */
 	/* Note: this GpioMode_Input will be converted
 	 * to GpioConfigType_I2cAuxDualMode in GPIO component,
-	 * which indicates we need additional delay */
+	 * which indicates we need additional delay
+	 */
 
 	if (GPIO_RESULT_OK != dal_ddc_open(
 		ddc, GPIO_MODE_INPUT, GPIO_DDC_CONFIG_TYPE_MODE_I2C)) {
@@ -414,14 +416,16 @@ static enum signal_type link_detect_sink(
 		link->link_enc->id, link->link_id);
 
 	/* Internal digital encoder will detect only dongles
-	 * that require digital signal */
+	 * that require digital signal
+	 */
 
 	/* Detection mechanism is different
 	 * for different native connectors.
 	 * LVDS connector supports only LVDS signal;
 	 * PCIE is a bus slot, the actual connector needs to be detected first;
 	 * eDP connector supports only eDP signal;
-	 * HDMI should check straps for audio */
+	 * HDMI should check straps for audio
+	 */
 
 	/* PCIE detects the actual connector on add-on board */
 
@@ -432,7 +436,8 @@ static enum signal_type link_detect_sink(
 	switch (link->link_id.id) {
 	case CONNECTOR_ID_HDMI_TYPE_A: {
 		/* check audio support:
-		 * if native HDMI is not supported, switch to DVI */
+		 * if native HDMI is not supported, switch to DVI
+		 */
 		struct audio_support *aud_support = &link->dc->res_pool->audio_support;
 
 		if (!aud_support->hdmi_audio_native)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
