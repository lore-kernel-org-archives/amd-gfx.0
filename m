Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1437BD1951E
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 21:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90AE810E4A0;
	Mon, 26 Jan 2026 21:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Uvp7G+Gk";
	dkim-atps=neutral
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD21B10E49F
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 21:08:42 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id
 ffacd0b85a97d-432d2c7a8b9so4846007f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 13:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769461721; x=1770066521; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lf9y7KarB/3fZVa4J67AgQ/cY2Nzb9psGrBda49t4Cg=;
 b=Uvp7G+GkmkV+x8TGq4ymmlJsOJZLh+Yn2PFci8bFfhTvvwV/JRtlkSnPrtfu4RfeW9
 F/7270zXKQMUabQU+y0O7OsmPjhTTRui2fJb+XLCADr6rhg4+etreC3D+VO/5RXMk2c+
 cJUIxsy5fCHWv6DvocJGs17yzlo7CJwRKpkYtl/ML4UQvlF5pMt/5bGW0Z7dVdO647Th
 aY3tuGRqAQ5LY+1m+WnhzOqhnCaF57iEy7zPPMgiCOVtdzcuLQ1EIcepQ1kiRhcQvy2R
 yFELKhIWiyzmD3SNV6sctt6PTP1DIbm/UiKB91OjhII9cqe2v2AboSE4IfE6rOW08xyj
 XwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769461721; x=1770066521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lf9y7KarB/3fZVa4J67AgQ/cY2Nzb9psGrBda49t4Cg=;
 b=Sxpw5Nv/BGd0HF5f1GdF1Ff6QBf+F9rIEAYPD3qwPQEn/FYqBv+ANpIngRPOF1Ok44
 gJ5k52xuKAWS1WuNAUdPqbpPILOXtTJAEgw1PU9Z2maxdbJ7gEYG8KT+pX/FYWM1gplj
 rSFj3t+ZMZ20A/9kxZBzs01e3OlMPW66tKwnLjbkW08tFvwNExCATOKFhNSPaMbroAZg
 tohaBJRKqXhkrEDMAdZpHX/VvkkgH+ETuls0Tklfmjs2gMSiNzhtszTOJTz6Kp0a2CZ/
 jzulq9l+cdYa6YC75nQFMXFWaGDyqC10s+oKmL/cTfSgoz2J8acrXwWKaUJLpthFkKeS
 qrEA==
X-Gm-Message-State: AOJu0YxILdCXxxzgA7J5K224xexP7DPx8jVr8XdFxzjaOND46FFumFgz
 40EXQ/3c2GLSM8lukQ2lTvJkXLrnDeAE+5t+2UXuhGAvvnXDWcSF4EGp2svo0Lpn
X-Gm-Gg: AZuq6aIg8BgThsUSV8OIgkKLXoy0/wP7y9vBFMp6PdMtamJRwS45oF43lv5v9U59ZTg
 Vj7m0MNtIsJX/IdYE/aj2isLCwGXFk1xol1pBGk7baHO9RUAzZ8PqOSDyLx1IP87USqAuP5+ge3
 kyQPfvdlKw35aj9+Uv5zKxQ827zxQDp0tWsJoT3+kaigW0PSIft/IdFXt+66LTxLOqaLMaHaaxC
 dL9B5/9WtulNeU83OGJgLMj5u5NlWxyXDZ2ASzIfj2obQ+dbngt1FTZJBIuzxt/YnbRqaHWhMit
 VC472H8tYSOqHbmY6B8Dz55JuWqlFct/u3foHzCOhat2cKASQrIiu7qDRhTRfBQLncoT6rKyZrd
 1xtzxSj3zfAX9sX3M4xOWeSvCDFpg1hzMi8p+iHeCBxVafCaHmpsAy9bjk8uB75dA68McZl74zV
 w84y1YPnUg8pfpVRUeAUKCZf8BFsJltKJq5Ii+dDGVKVtFrltcNmUH
X-Received: by 2002:a05:6000:4308:b0:435:9a50:bbb4 with SMTP id
 ffacd0b85a97d-435ca3a93e6mr7142402f8f.59.1769461721343; 
 Mon, 26 Jan 2026 13:08:41 -0800 (PST)
Received: from Timur-Hyperion.home (54001FF2.dsl.pool.telekom.hu.
 [84.0.31.242]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24acdsm33940275f8f.13.2026.01.26.13.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 13:08:41 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Prike Liang <Prike.Liang@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, siqueira@igalia.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 02/14] drm/amd/display: Only use analog link encoder with
 analog engine
Date: Mon, 26 Jan 2026 22:08:25 +0100
Message-ID: <20260126210837.21885-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126210837.21885-1-timur.kristof@gmail.com>
References: <20260126210837.21885-1-timur.kristof@gmail.com>
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

Some GPUs have analog connectors that work with a DP bridge chip
and don't actually have an internal DAC: Those should not use
the analog link encoder code path.

Fixes: 0fbe321a93ce ("drm/amd/display: Implement DCE analog link encoders (v2)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c   | 3 ++-
 drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index d40d91ec2035..a916872db7bd 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -638,7 +638,8 @@ static struct link_encoder *dce100_link_encoder_create(
 	if (!enc110)
 		return NULL;
 
-	if (enc_init_data->connector.id == CONNECTOR_ID_VGA) {
+	if (enc_init_data->connector.id == CONNECTOR_ID_VGA &&
+	    enc_init_data->analog_engine != ENGINE_ID_UNKNOWN) {
 		dce110_link_encoder_construct(enc110,
 			enc_init_data,
 			&link_enc_feature,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
index 068fb1df8d88..90d826237cf0 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -733,7 +733,8 @@ static struct link_encoder *dce60_link_encoder_create(
 	if (!enc110)
 		return NULL;
 
-	if (enc_init_data->connector.id == CONNECTOR_ID_VGA) {
+	if (enc_init_data->connector.id == CONNECTOR_ID_VGA &&
+	    enc_init_data->analog_engine != ENGINE_ID_UNKNOWN) {
 		dce60_link_encoder_construct(enc110,
 			enc_init_data,
 			&link_enc_feature,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index 8687104cabb7..cde2c2cba1dd 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -740,7 +740,8 @@ static struct link_encoder *dce80_link_encoder_create(
 	if (!enc110)
 		return NULL;
 
-	if (enc_init_data->connector.id == CONNECTOR_ID_VGA) {
+	if (enc_init_data->connector.id == CONNECTOR_ID_VGA &&
+	    enc_init_data->analog_engine != ENGINE_ID_UNKNOWN) {
 		dce110_link_encoder_construct(enc110,
 			enc_init_data,
 			&link_enc_feature,
-- 
2.52.0

