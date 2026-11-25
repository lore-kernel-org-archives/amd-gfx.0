Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54827606A321
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 08:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PsBq0cSI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84B73112116;
	Thu, 26 Nov 2026 08:09:55 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E476F10E012
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 19:38:17 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-386bd881d39so5317296eec.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 11:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795635497; x=1796240297; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XBqtxBo/Ovy/9j4ojA/2y1YO0FF3mv74qI20iGeveCY=;
 b=PsBq0cSIZmhrvAjE/BnSVotnYSui/lORDAB9QawCReZMN0t4XetfGJn1sha9lanJGT
 XAKyeg3vszTzDVMfF6/trMOxIlQDU362+YDBEgM02vDebHtBLulHhNuth8gMwMI/x38o
 mCzZeycP9qmJhZN890E+BJy20J5Ycb3K/dBs2q0UjKOrL7BE2JcOF2v7rTcM6+BnZZ5y
 AI1SkoPDDMJ1jorAFwDP3BkeTryZHloZe5taGqiLqUIBIyIG8nfIszHV4wKzBplu1mfr
 uYotN6cBH56dSSG1DBQHtkIRob3sQQAFGe/ihg+xC4wkDoTcecx+nLu6L0KAXXSMmXR2
 xIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795635497; x=1796240297;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XBqtxBo/Ovy/9j4ojA/2y1YO0FF3mv74qI20iGeveCY=;
 b=Sd19PPSkX/T+Ef9snoy4uouA9aUE1eMmXygew/T8SgXYmVtrMkIqtEjnCxxYSitwob
 VdzHsjxmlv/au2gtEQLbEK9DAVyWo4GVOBP3BvjTf/G/c6gYzLqFJ/A7RA4BnY9MVqPu
 OM7p8kfaIPGGx1OyCjJkp8jH7sRKxxG7TA78pKEDSjAIzkIvzNtigQhraQ/2DWFtlNEk
 hTAPIHRVfgnCqHO84mRuKz7MIicHX2qWYLUck7c/9PzzQPzE7GZ9sHVf8rF3Vpo/QSev
 F02dCQzUrapZ3f+Ja0IY9+mbzJN6FyCN1FP+f634El+tCTKLHpvxDD3WbCX28NCInJnc
 Um3g==
X-Forwarded-Encrypted: i=1;
 AL+hErGSMkQCu3aKHb47YgXQLG5NFLA7El0D2pwAF9P3eIgBL71A+rwPV2sIoY2r0pqCDqXLO38qBvsz@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+Tbkpo9/xOzPvDUykprB8VEjL0xWDwPczXIX0BFRe8BWYfNsDe
 qjffBT6ujHg+PGScMgdyNG0kVu/CBmsAGHThF5dMNUOfW7HYtSTuGNGV
X-Gm-Gg: AZFdTZc4q8l9q7VBRVvsr1wFfQZcjEn93NHDXHvb+OOA6yWdCZtHrH94rdSG90DvcpV
 i6LxAxyVe4vsDzd5kP8Quag9JnMw6Py2FR+5U2KZAu/erjXVgHnlPZBdJ+MlmtVq7VGvAM4sify
 to/6fOR9om/+Fy4PNG7Cx3r3hefpwDPR6xSTzmPdMRy3QHMUD0uwB3KN4cbzLntUfKTamXj5ukM
 Hd4pVKIuWoz9o1e7nX5Hotwy88siCVAAplCbKlqhQL6y95jk23jJvi/Z+eswML83hI/hhfBb9Lu
 T2AjBqbXbYems3tVDSi4pjPpsjhHE1cGFqr2HcnVE09418riekZsKyN7qZvEMdQTrpY1SKhb2X1
 uDwPFo8JH/WIvtIq8PDW87aXrJF7K8SlUIdK7QIPZ+sOtrJEU0qYUtyGdinbBohS5P/zqVdhBXE
 TU2PuxnyeTu+0eWIGNWwa8LxoZvpWXUtl1hdfUMB/9vDvqKQlSYGQtPeJsITt0ENYm2KdxONDuE
 QnKXooIyjKZRzob0kIu7kMupR7T/AxjqI5Ywkx9nWjdX5LCl67Purn21gh/suWZhoCJfyX7BZvj
 cD+wpOMCMOkblZuWVZs3
X-Received: by 2002:a05:7300:c00f:10b0:36c:a321:9fbc with SMTP id
 5a478bee46e88-3856c9a6858mr21963682eec.1.1795635497037; 
 Wed, 25 Nov 2026 11:38:17 -0800 (PST)
Received: from a1-free ([2603:c021:8021:f000:0:1865:8c38:18fc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38567cafec4sm63408730eec.26.2026.11.25.11.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 11:38:16 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>,
	amd-gfx@lists.freedesktop.org
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH] drm/amd/display: Fix three kernel-doc warnings in dc.h
Date: Wed, 25 Nov 2026 19:38:13 +0000
Message-ID: <20261125193813.2444470-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:09:32 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kernel-doc reports three problems in the DC interface header:

  Warning: dc.h:329 struct member 'max_gamut_remap_coeff' not described
  in 'mpc_color_caps'
  Warning: dc.h:2225 struct member 'u' not described in
  'dc_probe_status'
  Warning: dc.h:3883 This comment starts with '/**', but isn't a
  kernel-doc comment.

Describe the two members, and turn the comment above the panel
polarity helpers into a plain one, since it documents no symbol.

Verification: kernel-doc -none drivers/gpu/drm/amd/display/dc/dc.h
prints three warnings before the change and nothing after it.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d3c484f45333..b8b2af988b71 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -314,6 +314,7 @@ struct lut3d_caps {
  * @mcm_3d_lut_caps: HW support cap for MCM LUT memory
  * @rmcm_3d_lut_caps: HW support cap for RMCM LUT memory
  * @preblend: whether color manager supports preblend with MPC
+ * @max_gamut_remap_coeff: largest coefficient the gamut remap matrix allows
  */
 struct mpc_color_caps {
 	uint16_t gamut_remap : 1;
@@ -2207,6 +2208,7 @@ struct dc_probe_latencies {
  * @valid: true if a measurement was latched.
  * @measuring: true if the hardware counter is currently running.
  * @type: type of the probe that produced this result.
+ * @u: the result, whose member depends on @type.
  * @u.bandwidth_mbps:         peak BW in Mbps (DC_PROBE_PEAK_MEM_BW).
  * @u.latency:                min/max/avg memory latency in ns (DC_PROBE_MEM_LATENCY),
  *                            stored as struct dc_probe_latencies.
@@ -3880,7 +3882,7 @@ unsigned int dc_override_memory_bandwidth_request(
 		struct dc *dc,
 		unsigned int bw_mbps);
 
-/**
+/*
  * Panel Polarity Control
  */
 void dc_link_set_panel_polarity_enable(struct dc_link *link, bool enable);

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.53.0

