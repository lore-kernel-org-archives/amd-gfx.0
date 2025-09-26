Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7F5CAC5B8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:03:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60ED510EABE;
	Fri, 26 Sep 2025 18:03:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dHUaGTZI";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 617A810EABE
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:03:03 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-27d2c35c459so20776545ad.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758909783; x=1759514583; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0CmQAX5VySAeKHxve81s5DIMn4iA7YT4A84DBI6/h40=;
 b=dHUaGTZIH05tOINndgRWtCe5pXAo3sjNjbKv2c3Q2h1f329l0ohwdbOud89d5VChMd
 b7sWi/sY14Tsns3pEFvF+7nOY+y9denN1Qc7xhF/yXotN5H1LTEVcU/Cp4JodYIJG7xc
 6yQEjRVp7SmWA1hu7Jdx1TDIVss85WmEHkLuYbkPaoKJpivhifUALNjHOC6Z+OPnm7R6
 dwM8G2ePtynignNPVBHeOdvJCUN/ZN79yqbMrl3g0+8oXc5AwFVOw35+NDuTP6rmNWAB
 rzYKPEzkZm/2w5g+P1HbNahBmsaZkhgdq+zcHh9VImviQHSyT9TJh4mnIge6B1n46xPO
 DZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758909783; x=1759514583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0CmQAX5VySAeKHxve81s5DIMn4iA7YT4A84DBI6/h40=;
 b=TJ0af6i757jyn/JAajwYfMAhBndC/rY/5SX4o60i5odeoRQDK5F19dZpA61CppWPdS
 Y93rkRin7dmtieTm5g4yHJdILgta1TpkVkzj3jg/TNjAaXZY/On31Jw5vcd4BKALP2a0
 RHUkLU+3GQnwnVY4yT5Q9skf26ZAHcjTUH1AzkLLX+8ZdTJ98oHWESfW3GPiFcEY/tTi
 PmmMzxDMhIxoVPadjUtPJDWtasRr9n4tYaxfh/HVPD/UnM+es8mg+1uI6zNWDO196Fo1
 pdj427OsCICgd5Zn4w7XNZ55QseqByopEgFcGuTfptZzCps9u2xBDKLdarUd1/yk2hAj
 zkJg==
X-Gm-Message-State: AOJu0YwBDMExwnjMJD8aPKhb3ZlqLPNXMTMKyY89VSN1kCPDzKyjpsjE
 BdEFPoDQLNh68tVZ/yGLj2PNc1oq6EbvqdeQg0AI3vCL2mgzmeeNRXWIA8kFwg==
X-Gm-Gg: ASbGncs1z5/CbXM+rbVRsdSeX5tifIHf2Xbd0oDTETZXiLKmsl0Iqmku7O+phQtlrfP
 5JVgBL5U55sjjAWh/QJb+MHSaaryTgOyDdfftowRClmMgfMfnMSZX+5bb94DWJK0dUHPM6WfZ7l
 8QiCt2JRYD9ISAARlg5IaNMPOB/WXGf5yEOAsu7AGM5iArC6KYJKSgvF6sPcuXvnhEd+UA52x3C
 X9LjzaTW/mFN/3egnLjvPWkymNMxWgPo2U70qdgQPURNiHb0+7f5lEnLN0rB/p8WJ1Xk1eA6hor
 x8kXjo2KyfhSRfMdk//RI052BbvW+hOetEudrDe68sY0xEo0uf1ZeKiPDizWwIzMLf9/BbXJCIo
 NDfWwVOxbznnoE3LpFCIbOMoH9dVrR79/5fPjJoVpNN+JuiKAAD0HQ+idhUN2MB1MmA0xJKOBeY
 5p089vUyvM3VSVwJx8ATYvRVqTC0CPWxffvqrE0HVj
X-Google-Smtp-Source: AGHT+IFPKLxQrlIJm6B68Kq4ZfpO7N76JkAVE1KyYllXxWwhX8c4H5m6FbEJf7mGJMZfK1RF4EwyDQ==
X-Received: by 2002:a17:902:c949:b0:27e:da7d:32f5 with SMTP id
 d9443c01a7336-27eda7d37d0mr79668795ad.24.1758909782644; 
 Fri, 26 Sep 2025 11:03:02 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27f1d2ef8c5sm22186835ad.151.2025.09.26.11.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:03:02 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 09/23] drm/amd/display: Determine early if a link has
 supported encoders (v2)
Date: Fri, 26 Sep 2025 20:01:49 +0200
Message-ID: <20250926180203.16690-10-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926180203.16690-1-timur.kristof@gmail.com>
References: <20250926180203.16690-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Avoid initializing DDC, HPD, etc. when we know that the link is
not going to be constructed because it has no supported encoders.

This is mainly useful for old GPUs which may have encoders such
as TRAVIS and NUTMEG that are not yet supported by DC.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../drm/amd/display/dc/link/link_factory.c    | 23 +++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 31a73867cd4c..dd636a994bd6 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -451,6 +451,14 @@ static enum channel_id get_ddc_line(struct dc_link *link)
 	return channel;
 }
 
+static bool transmitter_supported(const enum transmitter transmitter)
+{
+	return transmitter != TRANSMITTER_UNKNOWN &&
+		transmitter != TRANSMITTER_NUTMEG_CRT &&
+		transmitter != TRANSMITTER_TRAVIS_CRT &&
+		transmitter != TRANSMITTER_TRAVIS_LCD;
+}
+
 static bool construct_phy(struct dc_link *link,
 			      const struct link_init_data *init_params)
 {
@@ -482,6 +490,17 @@ static bool construct_phy(struct dc_link *link,
 	link->link_id =
 		bios->funcs->get_connector_id(bios, init_params->connector_index);
 
+	/* Determine early if the link has any supported encoders,
+	 * so that we avoid initializing DDC and HPD, etc.
+	 */
+	bp_funcs->get_src_obj(bios, link->link_id, 0, &enc_init_data.encoder);
+	enc_init_data.transmitter = translate_encoder_to_transmitter(enc_init_data.encoder);
+
+	if (!transmitter_supported(enc_init_data.transmitter)) {
+		DC_LOG_WARNING("link_id %d has unsupported encoder\n", link->link_id.id);
+		return false;
+	}
+
 	link->ep_type = DISPLAY_ENDPOINT_PHY;
 
 	DC_LOG_DC("BIOS object table - link_id: %d", link->link_id.id);
@@ -611,16 +630,12 @@ static bool construct_phy(struct dc_link *link,
 		dal_ddc_get_line(get_ddc_pin(link->ddc));
 
 	enc_init_data.ctx = dc_ctx;
-	bp_funcs->get_src_obj(dc_ctx->dc_bios, link->link_id, 0,
-			      &enc_init_data.encoder);
 	enc_init_data.connector = link->link_id;
 	enc_init_data.channel = get_ddc_line(link);
 	enc_init_data.hpd_source = get_hpd_line(link);
 
 	link->hpd_src = enc_init_data.hpd_source;
 
-	enc_init_data.transmitter =
-		translate_encoder_to_transmitter(enc_init_data.encoder);
 	link->link_enc =
 		link->dc->res_pool->funcs->link_enc_create(dc_ctx, &enc_init_data);
 
-- 
2.51.0

