Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB10FCAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 11:39:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 837F510E70B;
	Wed, 24 Sep 2025 11:39:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QdJScsJf";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5500810E70D
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 11:39:02 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-b55115148b4so4420319a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 04:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758713942; x=1759318742; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLqgn9uc1t92h9xpwttL7yvW2qYUY8pIW1DpwBHd/d0=;
 b=QdJScsJfJi85xKz9UuwQqjXBg3I7hLWowq4fD4tNf/VkEbUduyshbTUL8C+VsRBOPk
 08dY+W63rRegKW1wh12jFufyLUGPfL+AKuEko+X4LYMZdkPX/h8Bj5jSJ3PJyFrFfApY
 TaCXy9IyQq3qCMe9QUwBQse+iELAPfslBhzKhw8mb+XUwxWhfJfHC6P9ERBg4R06EjYl
 e380yID/sjlEdsh+BWtX5EFRDaVGEChvOqesJuTvViGnQmsBDsPwMf2zv4zL3BsHZcpd
 Bd2rNJNmTH2zKEI6IF7wKJrZ/gAaUS2Dl/tfbsmJcDRSAh9cdk+EUSzAExrOZnHl9EbJ
 LbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758713942; x=1759318742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zLqgn9uc1t92h9xpwttL7yvW2qYUY8pIW1DpwBHd/d0=;
 b=Ze1qI5qWU2/It/t8srcegYlvQjXEhuRG2crFzI0ZUEV8I4OXMcUtTHNAL3ShUdV114
 GoFXnBD1iAJ0kakkKjAscxoSngkz5i7XS/DOOyNAmNUP4IGwl1ySTq23SncH1rtyAek/
 03OtWNHkuPptTUjeCFx65LtsHMNuoMDfc3JjAqc0Tv2TAsAMgbHzruu3NdUYth2YUGwr
 +hxnZtZfF4+xav/nqjgsm9OWKtnYy7w3mXYFsLfN/N8lwgRuQUjcbSvgjhvNdH5PdrSg
 /Bcw22yPhWW0IjCdhXmUoRqe1tNuK70pUF7ac7qRp8Mjq/2ZxBXTFBESLQw4y9BOxsPP
 xKVQ==
X-Gm-Message-State: AOJu0YxlUZunO9GpEH3rp2Myz74mCGI60W3CUrK/VqLO9Fw533MfxuN6
 of4mtmi1XPvZN1xEuGSFZjm2lELN7KTf4qz7gnwV0cU8VlOIwCKNSpChXL1X7ozf
X-Gm-Gg: ASbGncsoFCVJ5FKDOYZaQXzn7PJB0HD+fOJ3pTv/pEc6yGthSqbyO2KDq3MvjEEo1Dv
 Qvo3edi5UCDMoT+EcTFriNtZlEkKcEihHEDBRO28rWHwKFu/guP+wxsBJAXH44jCjLnPMe1T2m8
 fbhefXVtnFDD9FhaXQP/iYnpmpbsq0vHfL9NIkmN6TlDBiyTKbKQJ3WEsF3NORUWEPg6B2w4sLP
 ZJDx5ZgFYmSROUm3Tp2NUDq6VxcU0oRd9dAnj/U+k71uomahmLAMa663H3wzgctGOgNB92NUy3s
 Bii4JeeoWd8HwU4essVJCjQEMb/BjEQVKhzKxScgKl9V9Gq8aPoh2Qo6tmUZdwY9FDhciDqGGCg
 +jkaasusbkrnfRUkZVlz0QyfAe7fbJCv4vtVpD5yGT0w5AVf3mJukwdHp0A0eYr2Yo5b8DHh2Gp
 QgKZUIWMWPOOCx7Ee/mmq2KA154A==
X-Google-Smtp-Source: AGHT+IFCTdDdvauYI8YZPRPamA11DbukUH+YaHE0ZrMNof1em6fj+qix/iDoDkiTxRlWHfG/bLWlKg==
X-Received: by 2002:a17:903:252:b0:26c:87f9:9ea7 with SMTP id
 d9443c01a7336-27cc8b26a12mr71857705ad.59.1758713941775; 
 Wed, 24 Sep 2025 04:39:01 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3341be38382sm2142548a91.25.2025.09.24.04.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 04:39:01 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/3] drm/amd/display: Share dce100_validate_global with DCE6-8
Date: Wed, 24 Sep 2025 13:38:36 +0200
Message-ID: <20250924113836.57013-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924113836.57013-1-timur.kristof@gmail.com>
References: <20250924113836.57013-1-timur.kristof@gmail.com>
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

The dce100_validate_global function was verbatim exactly the
same as dce60_validate_global and dce80_validate_global.

Share dce100_validate_global between DCE6-10 to save code size.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../dc/resource/dce100/dce100_resource.c      |  2 +-
 .../dc/resource/dce100/dce100_resource.h      |  4 +++
 .../dc/resource/dce60/dce60_resource.c        | 32 +------------------
 .../dc/resource/dce80/dce80_resource.c        | 32 +------------------
 4 files changed, 7 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index 6421a56ffd23..c4b4dc3ad8c9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -898,7 +898,7 @@ static bool dce100_validate_surface_sets(
 	return true;
 }
 
-static enum dc_status dce100_validate_global(
+enum dc_status dce100_validate_global(
 		struct dc  *dc,
 		struct dc_state *context)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.h
index 08e045601a77..dd150a4b4610 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.h
@@ -41,6 +41,10 @@ struct resource_pool *dce100_create_resource_pool(
 
 enum dc_status dce100_validate_plane(const struct dc_plane_state *plane_state, struct dc_caps *caps);
 
+enum dc_status dce100_validate_global(
+		struct dc  *dc,
+		struct dc_state *context);
+
 enum dc_status dce100_validate_bandwidth(
 		struct dc  *dc,
 		struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
index 61ad3703461e..53c67ebe779f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -864,36 +864,6 @@ static void dce60_resource_destruct(struct dce110_resource_pool *pool)
 	}
 }
 
-static bool dce60_validate_surface_sets(
-		struct dc_state *context)
-{
-	int i;
-
-	for (i = 0; i < context->stream_count; i++) {
-		if (context->stream_status[i].plane_count == 0)
-			continue;
-
-		if (context->stream_status[i].plane_count > 1)
-			return false;
-
-		if (context->stream_status[i].plane_states[0]->format
-				>= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN)
-			return false;
-	}
-
-	return true;
-}
-
-static enum dc_status dce60_validate_global(
-		struct dc *dc,
-		struct dc_state *context)
-{
-	if (!dce60_validate_surface_sets(context))
-		return DC_FAIL_SURFACE_VALIDATE;
-
-	return DC_OK;
-}
-
 static void dce60_destroy_resource_pool(struct resource_pool **pool)
 {
 	struct dce110_resource_pool *dce110_pool = TO_DCE110_RES_POOL(*pool);
@@ -910,7 +880,7 @@ static const struct resource_funcs dce60_res_pool_funcs = {
 	.validate_bandwidth = dce100_validate_bandwidth,
 	.validate_plane = dce100_validate_plane,
 	.add_stream_to_ctx = dce100_add_stream_to_ctx,
-	.validate_global = dce60_validate_global,
+	.validate_global = dce100_validate_global,
 	.find_first_free_match_stream_enc_for_link = dce100_find_first_free_match_stream_enc_for_link
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index 0c9a39bf7ff4..5b7769745202 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -870,36 +870,6 @@ static void dce80_resource_destruct(struct dce110_resource_pool *pool)
 	}
 }
 
-static bool dce80_validate_surface_sets(
-		struct dc_state *context)
-{
-	int i;
-
-	for (i = 0; i < context->stream_count; i++) {
-		if (context->stream_status[i].plane_count == 0)
-			continue;
-
-		if (context->stream_status[i].plane_count > 1)
-			return false;
-
-		if (context->stream_status[i].plane_states[0]->format
-				>= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN)
-			return false;
-	}
-
-	return true;
-}
-
-static enum dc_status dce80_validate_global(
-		struct dc *dc,
-		struct dc_state *context)
-{
-	if (!dce80_validate_surface_sets(context))
-		return DC_FAIL_SURFACE_VALIDATE;
-
-	return DC_OK;
-}
-
 static void dce80_destroy_resource_pool(struct resource_pool **pool)
 {
 	struct dce110_resource_pool *dce110_pool = TO_DCE110_RES_POOL(*pool);
@@ -916,7 +886,7 @@ static const struct resource_funcs dce80_res_pool_funcs = {
 	.validate_bandwidth = dce100_validate_bandwidth,
 	.validate_plane = dce100_validate_plane,
 	.add_stream_to_ctx = dce100_add_stream_to_ctx,
-	.validate_global = dce80_validate_global,
+	.validate_global = dce100_validate_global,
 	.find_first_free_match_stream_enc_for_link = dce100_find_first_free_match_stream_enc_for_link
 };
 
-- 
2.51.0

