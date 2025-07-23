Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391DFC83F34
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 15:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D09B010E7FE;
	Wed, 23 Jul 2025 15:58:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IGURjucX";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFCAB10E801
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 15:58:24 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4563cfac19cso60804275e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 08:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753286303; x=1753891103; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=10Z8Bc2iy7D7nHIZP9z8on6JisDTZN/BNS6Mp11XQHc=;
 b=IGURjucXdVvI49YJyXxn7o6QSUobTRm60Tk8BvdvVHJbEUp0tGfSaO6/f2vgmrI8Su
 U14OlMMKwMe2FIPdu3AKGfKedrlmJbQMp8J0vnQEPFN+cwwyQS9i8yua2rGDyAG4O2Vk
 OEqpbByKYE55USa4CSDp84bDh/SOmKhBx26hz5/0Hx6uCZ4UXqLuxcLgE7uMGycYDmp7
 vFw+p1OJGfpPzeKAwL8EaJewyJmSFHidiybOyiw4x9QndcxAqcMRBM6dmgjRbniLFIaJ
 OiDUEyKKp1KGjygC6O/mMt+zDTo1ZUDyqAdXEitxLOb5j7IW6zCZ9PfDFXbRIi50t0Q4
 CAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286303; x=1753891103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=10Z8Bc2iy7D7nHIZP9z8on6JisDTZN/BNS6Mp11XQHc=;
 b=bMUu85w5P8QxuCyA2vci3dhG/mggE47/OUQArQBsK6GLCE4JT0ieQQyhHFENQ5NnDJ
 fdYt/501sCPaMFsm83lLLJsZhR6LdlK6jspwlvqY2REC2OOeFL/C5UBgbxrHCoKCTDUh
 BPHQ672X8w2JqRwgMGaqs4DgpjAqCYns7El9iUtzUYwTQ0NxdEhjeTEuI+gw6J4XS2hF
 t4inNcQxuQVoFpFMhD/NNvYS2GASSCD8cim6nQAV/NE5ARfGaMdhV5kSYSKUtfMCuy/J
 BZqimOt4A7cPBr8C3OSZVb4Anal0ZDdVt94tBvBwOnkpMcm7SIwDfJbxhBfm1gdGZdrS
 5pQA==
X-Gm-Message-State: AOJu0YzlTN7x8h0K/NH6LwkW6kk7oLzEFKlc72DNAvSC3bvaxghrkovF
 wArJkBthKxd5OGd/YZFy5rgLdK/gFKKiK+pYLayBzSd16T0lW0EpYWdQvmVNpQ==
X-Gm-Gg: ASbGncuN2sLMvR6oLd4DiRNN18CF9g9iXmHMDtAtCQPGD/UyFBLjZHZYlo5XCijgxC+
 sGhE+JZAmXJesEIM1GS38x08B7eH7Hn+ZFqaF/Ka4doWvUy3WmS0GU2GzG/CdugJO1BI5TLuYty
 FCSnL8WQ5AgQLHLDUgduxxceZcWDzCzxb+uW6l8fHyyzFyjJECDOGBJnD6nL/Tufal2KQHlejWx
 pxk41LIn5NP8AxKDLkPRTkTtp9KmPdGbNh/6/Qwdyp4atmZTH34UQhiRSJ2I6EQI4IeKNxpXy4u
 rKDb135auspSXR+oVk/iYPVSBVlQsCecK329ejsPJpbG+tpCcET8v593WU9W1nzAW85D6EoXwsr
 6XLy4ytOrGIuAKw03FKTXVWkJH3oNTRN6tBTmRI4LAbGEordy2s3zCYBTwui9/0msPA/2m71/oT
 pfdWjrtpbSatJ3kpNCa3kb+9djFY7AB+AcY0SB
X-Google-Smtp-Source: AGHT+IFx9PGmjBRpavAtiFuvt2BPJ7l41C0aNjJ20wAAoiA+KjPlDxSJaxIZTdKmc2IEHMDS9eAJxg==
X-Received: by 2002:a05:600c:4586:b0:453:2433:1c5b with SMTP id
 5b1f17b1804b1-4586a8cb052mr26568565e9.5.1753286302955; 
 Wed, 23 Jul 2025 08:58:22 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4D24D8FC008443E005DD6C3C62.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:8443:e005:dd6c:3c62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2bf99sm16710468f8f.32.2025.07.23.08.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:58:22 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 03/20] drm/amd/display: Introduce MAX_LINK_ENCODERS
Date: Wed, 23 Jul 2025 17:57:56 +0200
Message-ID: <20250723155813.9101-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723155813.9101-1-timur.kristof@gmail.com>
References: <20250723155813.9101-1-timur.kristof@gmail.com>
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

We are going to support analog encoders as well, not just digital,
so we need to make space for them in various arrays.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |  4 ++--
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  8 +++----
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h | 24 +++++++++++++++++++
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index 814f68d76257..d86482611b3f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -522,10 +522,10 @@ struct link_encoder *link_enc_cfg_get_link_enc_used_by_link(
 struct link_encoder *link_enc_cfg_get_next_avail_link_enc(struct dc *dc)
 {
 	struct link_encoder *link_enc = NULL;
-	enum engine_id encs_assigned[MAX_DIG_LINK_ENCODERS];
+	enum engine_id encs_assigned[MAX_LINK_ENCODERS];
 	int i;
 
-	for (i = 0; i < MAX_DIG_LINK_ENCODERS; i++)
+	for (i = 0; i < MAX_LINK_ENCODERS; i++)
 		encs_assigned[i] = ENGINE_ID_UNKNOWN;
 
 	/* Add assigned encoders to list. */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index f0d7185153b2..55daf348293e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -274,7 +274,7 @@ struct resource_pool {
 	/* An array for accessing the link encoder objects that have been created.
 	 * Index in array corresponds to engine ID - viz. 0: ENGINE_ID_DIGA
 	 */
-	struct link_encoder *link_encoders[MAX_DIG_LINK_ENCODERS];
+	struct link_encoder *link_encoders[MAX_LINK_ENCODERS];
 	/* Number of DIG link encoder objects created - i.e. number of valid
 	 * entries in link_encoders array.
 	 */
@@ -508,7 +508,7 @@ struct pipe_ctx {
 struct link_enc_cfg_context {
 	enum link_enc_cfg_mode mode;
 	struct link_enc_assignment link_enc_assignments[MAX_PIPES];
-	enum engine_id link_enc_avail[MAX_DIG_LINK_ENCODERS];
+	enum engine_id link_enc_avail[MAX_LINK_ENCODERS];
 	struct link_enc_assignment transient_assignments[MAX_PIPES];
 };
 
@@ -520,8 +520,8 @@ struct resource_context {
 	uint8_t dp_clock_source_ref_count;
 	bool is_dsc_acquired[MAX_PIPES];
 	struct link_enc_cfg_context link_enc_cfg_ctx;
-	unsigned int dio_link_enc_to_link_idx[MAX_DIG_LINK_ENCODERS];
-	int dio_link_enc_ref_cnts[MAX_DIG_LINK_ENCODERS];
+	unsigned int dio_link_enc_to_link_idx[MAX_LINK_ENCODERS];
+	int dio_link_enc_ref_cnts[MAX_LINK_ENCODERS];
 	bool is_hpo_dp_stream_enc_acquired[MAX_HPO_DP2_ENCODERS];
 	unsigned int hpo_dp_link_enc_to_link_idx[MAX_HPO_DP2_LINK_ENCODERS];
 	int hpo_dp_link_enc_ref_cnts[MAX_HPO_DP2_LINK_ENCODERS];
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
index 41c76ba9ba56..dc9b9f22c75b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
@@ -45,7 +45,31 @@
 #define MAX_PIPES 6
 #define MAX_PHANTOM_PIPES (MAX_PIPES / 2)
 #define MAX_LINKS (MAX_PIPES * 2 +2)
+
+/**
+ * define MAX_DIG_LINK_ENCODERS - maximum number of digital encoders
+ *
+ * Digital encoders are ENGINE_ID_DIGA...G, there are at most 7,
+ * although not every GPU may have that many.
+ */
 #define MAX_DIG_LINK_ENCODERS 7
+
+/**
+ * define MAX_DIG_LINK_ENCODERS - maximum number of analog link encoders
+ *
+ * Analog encoders are ENGINE_ID_DACA/B, there are at most 2,
+ * although not every GPU may have that many. Modern GPUs typically
+ * don't have analog encoders.
+ */
+#define MAX_DAC_LINK_ENCODERS 2
+
+/**
+ * define MAX_LINK_ENCODERS - maximum number link encoders in total
+ *
+ * This includes both analog and digital encoders.
+ */
+#define MAX_LINK_ENCODERS (MAX_DIG_LINK_ENCODERS + MAX_DAC_LINK_ENCODERS)
+
 #define MAX_DWB_PIPES	1
 #define MAX_HPO_DP2_ENCODERS	4
 #define MAX_HPO_DP2_LINK_ENCODERS	4
-- 
2.50.1

