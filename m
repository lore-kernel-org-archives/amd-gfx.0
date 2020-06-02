Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109E2C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 21:25:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B34206A2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 21:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzm0CywD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B34206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37AD36E212;
	Tue,  2 Jun 2020 21:25:42 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 742C36E212
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 21:25:41 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id j32so208206qte.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jun 2020 14:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AxGCzxzy/LxqX2dIPjJY57gp7FV4/+16zEdvlNpi3yw=;
 b=tzm0CywDKu+2Z+0x1/PqpNTD2tkWMOBfOQfd3Kjfeb+A7xM+38eYDNpLkNiqqdv722
 ghRjph9Ak7u+pX0FUXM1IQzUNwsGDWAP8t0FXdhDMAmnvdoTplP6zYlxFobNOVHMBus/
 pXFaij/ge+K1DYyzzOg7R4WWhcm00ARvXxhinjE5c9GLqCIihUW6ZJdgt2o3uDxW1N8D
 j9pGY7XUOjE+k8K35eZJsevehPu5TBUoBCSq3E7tgkgF+j7PN2IZ4pqNe2SPfHp5Yw4Z
 EafaC6zJ0oKWR4NFkKdDKCkGYVVIgln5ftm0u386iyK3C1q6nOxojLM1gbnx4cEaMJJB
 Gzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AxGCzxzy/LxqX2dIPjJY57gp7FV4/+16zEdvlNpi3yw=;
 b=R/8UiwvYgz4ptbOmf9HxlIHlqycD6zCJenEQP6JEH04jmky39/CZzIoxDKUTdwjIGz
 RWxzMGz5LG3SwCyCjHs0ZLpbjI0s1ZEheq1qbqesRFkipxNAfDnMU6uZES1trARRB9o0
 3hZtzF6SWzeiHjEZqmKq5IKtLohnfKzGI2PvvRTCg8MvgtnhQTI6ph3UArj8jQ+GIner
 Tl8YWb1uD7sPo2APzlPsNiSCfqpcoxWQ238PstQwvP69AuVrUlDjXWDfQh/eAjRgTCCZ
 /N5U34BsMBQ5Se8imjhYc0sS3WS4a7wgzNrpX7CvPgmTaRQmj2Pd75aNgE45YBJdIhtm
 OqgQ==
X-Gm-Message-State: AOAM531jTxdGDeJCRUbJk6eOOGabGoZxZMmtolJJLfAnTv8qcTYOP3yh
 iJH2O1mrT9JYXryJQoeOIORHqlsN
X-Google-Smtp-Source: ABdhPJw5Ov9uP34WkYzbT6Ywpv1vcGIMO3/zB7gqtzAIYercozIhd87PtrWLIiz3lwjnwxuvXPeQsA==
X-Received: by 2002:ac8:1a6f:: with SMTP id q44mr29574072qtk.372.1591133140309; 
 Tue, 02 Jun 2020 14:25:40 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id a5sm117146qtw.22.2020.06.02.14.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 14:25:39 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: use blanked rather than plane state for
 sync groups
Date: Tue,  2 Jun 2020 17:25:33 -0400
Message-Id: <20200602212533.1621557-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We may end up with no planes set yet, depending on the ordering, but we
should have the proper blanking state which is either handled by either
DPG or TG depending on the hardware generation.  Check both to determine
the proper blanked state.

Bug: https://gitlab.freedesktop.org/drm/amd/issues/781
Fixes: 5fc0cbfad45648 ("drm/amd/display: determine if a pipe is synced by plane state")
Cc: nicholas.kazlauskas@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 04c3d9f7e323..7fdb6149047d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1017,9 +1017,17 @@ static void program_timing_sync(
 			}
 		}
 
-		/* set first pipe with plane as master */
+		/* set first unblanked pipe as master */
 		for (j = 0; j < group_size; j++) {
-			if (pipe_set[j]->plane_state) {
+			bool is_blanked;
+
+			if (pipe_set[j]->stream_res.opp->funcs->dpg_is_blanked)
+				is_blanked =
+					pipe_set[j]->stream_res.opp->funcs->dpg_is_blanked(pipe_set[j]->stream_res.opp);
+			else
+				is_blanked =
+					pipe_set[j]->stream_res.tg->funcs->is_blanked(pipe_set[j]->stream_res.tg);
+			if (!is_blanked) {
 				if (j == 0)
 					break;
 
@@ -1040,9 +1048,17 @@ static void program_timing_sync(
 				status->timing_sync_info.master = false;
 
 		}
-		/* remove any other pipes with plane as they have already been synced */
+		/* remove any other unblanked pipes as they have already been synced */
 		for (j = j + 1; j < group_size; j++) {
-			if (pipe_set[j]->plane_state) {
+			bool is_blanked;
+
+			if (pipe_set[j]->stream_res.opp->funcs->dpg_is_blanked)
+				is_blanked =
+					pipe_set[j]->stream_res.opp->funcs->dpg_is_blanked(pipe_set[j]->stream_res.opp);
+			else
+				is_blanked =
+					pipe_set[j]->stream_res.tg->funcs->is_blanked(pipe_set[j]->stream_res.tg);
+			if (!is_blanked) {
 				group_size--;
 				pipe_set[j] = pipe_set[group_size];
 				j--;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
