Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EEBCAC5AE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:02:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1782210EAB6;
	Fri, 26 Sep 2025 18:02:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="it9F6BaN";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AA8010EAB6
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:02:32 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-27c369f898fso28122375ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758909751; x=1759514551; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jiOPL8U8vMdPauvFtb661o/s9XtZ0KsFdFlvHl9TSPQ=;
 b=it9F6BaNImLap57GjCWxzgl9AC3YR17+F7G+jsXxyXaddrBQajpk5gCwkD8pxY8bXC
 bTSZbzAdG+Y36eTA7K3HU7WAXp7v4Y1F2KhkVhatgA7dxWKa6KUadRIzdDJGKyki+aeE
 XY3sGfVFQzUuJ7TgRa7em59Sp7fyNTcdymZ/bMocmFat2YOXfEbdbWDGUJrbzwBXxIQ4
 AxqgrQfQ1AJReZGi2W06dHP67atGCOnCiy5eeav6SoW4TdWsTpQOjVibFNwMTRoRIgl9
 2n0WQcCmFuYCWrU1sOvZI16pQzitFyIoFD1VF7hgTDconMmGqOAvTcKKbIpR3xg5lA0A
 6tkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758909751; x=1759514551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jiOPL8U8vMdPauvFtb661o/s9XtZ0KsFdFlvHl9TSPQ=;
 b=banOnCrjmvUfsZvHgtI04yFrBVtHrt73mFd5Va3uClSXB/jexScWiyC6UKcW/x7BOB
 g2sPz1T2gBgkckrwqn6mZehuUJbH5n5p+m0KLhYZJFj1AYPfvtbciTK45h3wgMxrJ7QX
 fHHi5Mq0TuvUCj9K0b3slyIkPvFnj4flMhOsPz+a8WD0h6R885C4aIvBap+nAFWz40gW
 qrY2A/9jsQ8ujA0gtp3b61zL+5jeSS34qKVVM2Aotnpga22B/E/nPoGX8gn3eRfEPf/8
 SueavoCcO9ItA2SuWpL38qYpl4Pi2c/PvbzzxqHh9XOetGlC32/DQdsJQDxuGpygrkXf
 aScA==
X-Gm-Message-State: AOJu0YwjE0O6TN3AdCXDcTN6YQ3hXnM1ZC9muoZckmRbnTVkYjjg7I5u
 /0hbkQtNARJzgOeOCAKY7ggBOIqlnLGrmiU0ZM+dChjVxfyUogH9ilrDvDvk+g==
X-Gm-Gg: ASbGncv2bxmZLuZgQ/Gm9ux8ntOkNcJA2q2ujfOKqbGVh8UokKoj4GaVvDl0A0kcmiv
 wRIG8zNrGF/VW0d0DoOXyCBwahBJBZIrukqFyzNWBWeuAM3LkuRpWdr067+W/uFIS9OOYr9RKed
 XCgTV/RASA7iIoAs+ADjkxSxzSzIyK/lN/tLWLzEdEf8vV1+Kiu3EjXOCikw45qtw/im6g7oxpU
 NRFm0YEnoJ9zR3CePpnGsq0K2UR2zNR4dxqIZGDabSVQmbg77tA3eGjpfT32WHG6/BpgAN7d3Kw
 w/GJLmWGExG5YNLV2WfFoP6M0M0DiICtZcCyOWApvYKsAVUwHrYSXWcoxYSr76DP2PE8kSLCiSV
 pUPNZesnr4yxetCUxpRcNApo8KoYLxJt1K27/5M4nZqZfNxyS1F0zs5JQtX+fWflWfBvWa4GBe0
 aVW1Ft0KWzD/PShN7tf50=
X-Google-Smtp-Source: AGHT+IGyRtfodWF1+wWvQzXm41wDXcqsk7ssSKNa5ShzjcxqYRwz1J70P5mrV288Tq81pjNI62Sc+g==
X-Received: by 2002:a17:902:db04:b0:265:9878:4852 with SMTP id
 d9443c01a7336-27ed49ddab3mr104262615ad.15.1758909751335; 
 Fri, 26 Sep 2025 11:02:31 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27f1d2ef8c5sm22186835ad.151.2025.09.26.11.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:02:30 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 03/23] drm/amd/display: Introduce MAX_LINK_ENCODERS (v2)
Date: Fri, 26 Sep 2025 20:01:43 +0200
Message-ID: <20250926180203.16690-4-timur.kristof@gmail.com>
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

We are going to support analog encoders as well, not just digital,
so we need to make space for them in various arrays.

v2: Fix typo.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |  4 ++--
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  8 +++----
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h | 24 +++++++++++++++++++
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index a180f68f711c..deb23d20bca6 100644
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
index d11893f8c916..6992c11584c2 100644
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
@@ -514,7 +514,7 @@ struct pipe_ctx {
 struct link_enc_cfg_context {
 	enum link_enc_cfg_mode mode;
 	struct link_enc_assignment link_enc_assignments[MAX_PIPES];
-	enum engine_id link_enc_avail[MAX_DIG_LINK_ENCODERS];
+	enum engine_id link_enc_avail[MAX_LINK_ENCODERS];
 	struct link_enc_assignment transient_assignments[MAX_PIPES];
 };
 
@@ -526,8 +526,8 @@ struct resource_context {
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
index 41c76ba9ba56..7c6b20ea906e 100644
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
+ * define MAX_DAC_LINK_ENCODERS - maximum number of analog link encoders
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
2.51.0

