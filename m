Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72596CD5BD2
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 09:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F8FB10FB82;
	Fri, 29 May 2026 09:09:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jkR6Om/b";
	dkim-atps=neutral
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B110310FB82
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 09:09:14 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-bd2087858c4so2432396466b.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 02:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780045753; x=1780650553; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ll5NgMFGV7hWTMvlsS7RQlkEUyuLtxD4Rp0ttbIEByQ=;
 b=jkR6Om/bkl0XN/ZVNqAAHp68BoI1CIUNM44bNs0PdikSrl1QTm2x1KiWA3DciYwVcm
 R1l2eSA7Zd9w/S4xxYHwmRI0tsV+O90cmfq/jlBbOiUeajhVQhpDehVeZ8VXqnt0JElT
 KJ8aCuba3u/NUgJwqgWzbJzHN4efI0nj+bgs6OHewNEaCd73SFG382kqPNEv4tEOVhcR
 Rdrt22doPLpwIDbNpAPvHCn4wcatACkWJECN0p0N7UssiWLmlr/71V3fd78sUZKA/+vC
 CODn7Hr/wEz3NOW7R4jJ9JmJhgIpknJyIfdaDlqeYij6n52YJRkmB2mY4xvXj/aP1nGo
 mWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780045753; x=1780650553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ll5NgMFGV7hWTMvlsS7RQlkEUyuLtxD4Rp0ttbIEByQ=;
 b=atkNB8VKJ/IVSClHtNq2OrlowmMsTwwL1U7uGVLyPSmhaJnOO4o1gva7Mg7uJcESwC
 1CXFDE+pSQUGC/qbHZuvO4MtznF3Ru8VmGtDIZX9MVxbCsU1gsMERN+VUqDK2g6gYVIc
 3lLzozSDnwk2xy8kybstW5jba4DYF3WWVWWinjjiJ7CmOB+GL5PcDcdSvh832KibhWfK
 I+YMLkyiyDCL6iB+y7hGB4/+iI+Vqqyk7LXVn+DAN8fY06cK0uN7eVxP/gnb6GwF4g7c
 1e8YtzkK34YXB+t6thbVrScIq5Kpxb2Tb3Zc6v5pU60p7W/widpMvLfjeCl4nuFrEqJC
 vhHA==
X-Gm-Message-State: AOJu0Yxg/jv8CEccpH/da821RItWKHhmMgvbA1l06H9m5YNk+HyTQv9p
 tnymN6zs6ObMLTD/qJpUdb/C9C254XlJC+iteuXEL/uVVFf0c1VGGezi97GW4ALaI7g=
X-Gm-Gg: Acq92OFXPxD11LXvCFpp53Sb3yiY8PrJmSF2xyb2ff3X8wxuTBnT6iEmsC3gYtNj0m4
 LUxKC56WFiw6VzIH/Jrg8mx/VTeKje+xoeGLpQDG7rDqWdDsmTLWuEOakzHTRsGPnVA55sTC4ew
 hr+JMtnRhoG/GU+eMWa6PgV49uRgMnriUK8WhsnQidbD+iz/9vv00Wl9ti21xFhqFyZR8VLhIh9
 AzOSdRaYBZou8x6HVU+b5+CgYcMigt9EvNmJSyeZSTvqbcSMSfbDi1nCdS4XYsXpqg4Q4xDJdKm
 XnzcIU0K0uvA0j+c9HmaF/xIZEJScauv1ETRCou+HkvRkKRoJv9/KiI9sslP+SRWVS+fZPB8ZsO
 hWPgppUqHJMbXeWxZ7MnHFdw0/NmUip+JAJCZL+QV208PsEZflklGbn1fF1qq2+40NepZMLGXMV
 qiHTn48SlpDZ/PGo9eeZlyQLUxJuDjnLIWji/2xvxDz6lrIVCztnF8dVVmVnS+6ZQZa0tHd37Kh
 PW8ZxOs396LYud0
X-Received: by 2002:a17:907:1c20:b0:bd0:6e7:7a7 with SMTP id
 a640c23a62f3a-be9c869427dmr113757666b.9.1780045752957; 
 Fri, 29 May 2026 02:09:12 -0700 (PDT)
Received: from Timur-Max.c.hoisthospitality.com (184.31.0.109.rev.sfr.net.
 [109.0.31.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354bb7asm2200645f8f.20.2026.05.29.02.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 02:09:12 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Alex Hung <alex.hung@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Roman Li <roman.li@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/2] drm/amd/display: Add dp_skip_rbr flag for NUTMEG
Date: Fri, 29 May 2026 11:09:09 +0200
Message-ID: <20260529090909.13206-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529090909.13206-1-timur.kristof@gmail.com>
References: <20260529090909.13206-1-timur.kristof@gmail.com>
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

No functional changes. Just clean up a conceptual mismatch.

Based on feedback on the NUTMEG code in DC, the
preferred_link_setting is meant to force the DP link to a
specific setting, meaning both the link rate and lane count
should be locked to an exact value. What NUTMEG needs is
a lower bound on the link rate, which is not the same concept.

Implement this as a HW workaround flag instead.

Suggested-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                         | 2 ++
 drivers/gpu/drm/amd/display/dc/link/link_detection.c        | 2 +-
 .../drm/amd/display/dc/link/protocols/link_dp_capability.c  | 6 +++---
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 75f59ca927ffe..3fb97860722df 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1731,6 +1731,8 @@ struct dc_scratch_space {
 		bool dp_skip_DID2;
 		bool dp_skip_reset_segment;
 		bool dp_skip_fs_144hz;
+		/* Some DP bridges don't work with RBR and must use HBR. */
+		bool dp_skip_rbr;
 		bool dp_mot_reset_segment;
 		/* Some USB4 docks do not handle turning off MST DSC once it has been enabled. */
 		bool dpia_mst_dsc_always_on;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 1ac6a22fecfee..9f4e90493fed5 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -621,7 +621,7 @@ static bool detect_dp(struct dc_link *link,
 		link->dpcd_caps.sink_count.bits.SINK_COUNT = 1;
 		/* NUTMEG requires that we use HBR, doesn't work with RBR. */
 		if (link->dpcd_caps.branch_dev_id == DP_BRANCH_DEVICE_ID_00001A)
-			link->preferred_link_setting.link_rate = LINK_RATE_HIGH;
+			link->wa_flags.dp_skip_rbr = true;
 	}
 
 	return true;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index f44c13300a59c..708dd6f336d8c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -750,9 +750,9 @@ static bool decide_dp_link_settings(struct dc_link *link, struct dc_link_setting
 	if (req_bw > dp_link_bandwidth_kbps(link, &link->verified_link_cap))
 		return false;
 
-	if (link->preferred_link_setting.link_rate != LINK_RATE_UNKNOWN) {
-		initial_link_setting.link_rate = link->preferred_link_setting.link_rate;
-		current_link_setting.link_rate = link->preferred_link_setting.link_rate;
+	if (link->wa_flags.dp_skip_rbr) {
+		initial_link_setting.link_rate = LINK_RATE_HIGH;
+		current_link_setting.link_rate = LINK_RATE_HIGH;
 	}
 
 	/* search for the minimum link setting that:
-- 
2.53.0

