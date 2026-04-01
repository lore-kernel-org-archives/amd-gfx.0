Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F3910FCAC9
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 18:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B615110ED7E;
	Wed,  1 Apr 2026 18:19:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GUkkw9c/";
	dkim-atps=neutral
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF3E310EB00
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 00:39:34 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2c54c68db4dso5251144eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 17:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775003974; x=1775608774; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=izF33sGDSHxUIsJEwsnSvCBwPxbglhEjEwQBj49A0mg=;
 b=GUkkw9c/ku15DU4/NWm7EuqHKcUF6DUHVUV4FlUEKK3LHEmZJxSltx+nnMGBg5/hfb
 8UTy0JvLPeQYSxY3My5GzRMBudhQXIvoUInYgt00oOU8DUfM95EV2B9jwT9VbdpQFh5f
 hiYoMgr02GxoVaOb7zS2HjeosuV63MKkYTOztsM6Y8Tv3NioVVsqPLFh9K8hVsrg1Z/j
 QlIFGx0bIcNkMKlV3txA9G3Lrd1X9H9Hxzty8Mc8Pbq7e/tVXXGHyxWd49odhqXp/T0h
 rZVvCb60YZ0XVwb4xE7djN3q/1PGKC3H+7EEEGoJIgzvy5gnaBImfiCiukEG4m1z1OpY
 iQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775003974; x=1775608774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=izF33sGDSHxUIsJEwsnSvCBwPxbglhEjEwQBj49A0mg=;
 b=NJL2bcP6sVLlz3XZYeeNANguOrfhC/Yloo17AJ5knHJv4wr1I2qmbB8fy4BW+FViHJ
 5TIkMpQ+4i4ZJU1TorrnxyS/zpPSClQurv8mlUWdGM5Isy53CV5RY5sCbfKhJbcB7iHr
 q8ByaQ5kjuQRZpxeNUU7Mxz8c5tskEwCnXlyCwTyaVtdmbNResvTU5Ib5q+sJsdqpJT4
 bZIQxlm7bgLX0b6iOpk3orDONvgEIKnnK+Ms3Qdcgwb3YyIlUJXrjoquqNrePfQ3xlmH
 1L6kgpnaCvJtuRwb9AtukYtm5vJMFNmak1kveNZJZSn09opzKG9aWgpZuJXvVUAEMmuS
 Bf0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9wYGziCaec9IEPWK3OHeaz8S1O0c7v/kdihxs0YY/XxEYMltHXRPRl1ckedbN74qTE/tZqxhQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzaDX5ZZT0DjQFbRkoArn06h6duK9fdZW6o8YWyCTRDDg85E9TO
 bErkSnmuhMJtu1Z5VOhYW+ea3oQRuYukkzYhGzJEYy1sTngZdryCxRhk
X-Gm-Gg: ATEYQzzFOJQH06lcRoqWu6+bWMK3VD1PsBvJxVJctkO5Eta/rs75P9/0/XSvTymFAGW
 gTfh2ZCns6FA0i1WrbWyy9UxcspiNizxFYxUeAT1jwjBKkttOU2/qr4AShYxb2a2mpRQdrwb2MW
 eholaZ0XSQ6rbANP7TtMsRjtBWyljhsryNdGfbSiH/KZmhnnbTNWhF368HeQ8r53sxDZaXwqnjX
 Y5ndww8y6fXT0OsXGgncxHMYkTykK7FFc7xrs8+ds9LXeN23GI0zcB/feVpXxszYeb+tK8UYb82
 D3w1Tpynx7DE381Ma6vj+fsbKa4o0Ri0574lmwDtZYoWWEnjLNJb16/JWuRPh3zwYZwH7HpFj76
 wGUYGPp1az92brhs9XTuXlyZwz1SC+F+EhkAxMSydSitPnqPo6HSfzqlY4gqwrjmNlu1NNIwsDf
 d5v+SN2Pntcp/J/+Bmuvw3I/JqUNx0uWeRaQ9B3nTRH8Iw7HWfWjgQuNU=
X-Received: by 2002:a05:7300:5b83:b0:2c1:6cfd:73dc with SMTP id
 5a478bee46e88-2c9327a1ac9mr827510eec.17.1775003973981; 
 Tue, 31 Mar 2026 17:39:33 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 17:39:33 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Ray Wu <ray.wu@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Hung <alex.hung@amd.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 for 6.12 03/10] drm/amd/display: Disable fastboot on DCE 6
 too
Date: Tue, 31 Mar 2026 17:39:01 -0700
Message-ID: <20260401003908.3438-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401003908.3438-1-rosenp@gmail.com>
References: <20260401003908.3438-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 01 Apr 2026 18:19:20 +0000
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

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 7495962cbceb967e095233a5673ea71f3bcdee7e ]

It already didn't work on DCE 8,
so there is no reason to assume it would on DCE 6.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index df69e0cebf78..7dc99c85b8ea 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1910,10 +1910,8 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 
 	get_edp_streams(context, edp_streams, &edp_stream_num);
 
-	// Check fastboot support, disable on DCE8 because of blank screens
-	if (edp_num && edp_stream_num && dc->ctx->dce_version != DCE_VERSION_8_0 &&
-		    dc->ctx->dce_version != DCE_VERSION_8_1 &&
-		    dc->ctx->dce_version != DCE_VERSION_8_3) {
+	/* Check fastboot support, disable on DCE 6-8 because of blank screens */
+	if (edp_num && edp_stream_num && dc->ctx->dce_version < DCE_VERSION_10_0) {
 		for (i = 0; i < edp_num; i++) {
 			edp_link = edp_links[i];
 			if (edp_link != edp_streams[0]->link)
-- 
2.53.0

