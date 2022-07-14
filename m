Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A03BC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 16:45:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF4EE1139F9;
	Thu, 14 Jul 2022 16:45:36 +0000 (UTC)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FEDB113827
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 16:45:35 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx0.riseup.net (Postfix) with ESMTPS id 4LkL2f73xZz9svP;
 Thu, 14 Jul 2022 16:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1657817134; bh=oTt/xCCD/UUmSHwReWaxrUI1n297jYtleCZ9PTN2bMw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oikR8EA/PoKgRr+eQggjmUFyAVPka3BT4fG06Rei9Sqi8g2JdsxmT1tXPLUaSS7kW
 se5emkQw1QzmgahtP+fX73LwM8uJAfV7bC1VAtmLEGKV0FaHwbXIzzLPuNTwE5tyJ2
 Z2waUMi0utT9UzX3ql1mJMZQkgw0dcoxkf4uzMjc=
X-Riseup-User-ID: 78BA2B3056E721CAACDA863D27ED1DF81F1CA3751B3B5D38A9AACD4C31E50681
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4LkL2X4Zf5z5vW1;
 Thu, 14 Jul 2022 16:45:24 +0000 (UTC)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH 02/12] drm/amd/display: Change get_pipe_idx function scope
Date: Thu, 14 Jul 2022 13:44:57 -0300
Message-Id: <20220714164507.561751-2-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-1-mairacanal@riseup.net>
References: <20220714164507.561751-1-mairacanal@riseup.net>
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
Cc: magalilemes00@gmail.com, tales.aparecida@gmail.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, mwen@igalia.com,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
 Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Turn previously global function into a static function as it is not used
outside the file.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 39f93072b5e0..c5a0a3649e9a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -251,7 +251,7 @@ unsigned int get_total_surface_size_in_mall_bytes(
 	return size;
 }
 
-unsigned int get_pipe_idx(struct display_mode_lib *mode_lib, unsigned int plane_idx)
+static unsigned int get_pipe_idx(struct display_mode_lib *mode_lib, unsigned int plane_idx)
 {
 	int pipe_idx = -1;
 	int i;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 47b149d4bfcf..6e61b5382361 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -165,7 +165,6 @@ unsigned int get_total_surface_size_in_mall_bytes(
 		struct display_mode_lib *mode_lib,
 		const display_e2e_pipe_params_st *pipes,
 		unsigned int num_pipes);
-unsigned int get_pipe_idx(struct display_mode_lib *mode_lib, unsigned int plane_idx);
 
 bool get_is_phantom_pipe(struct display_mode_lib *mode_lib,
 		const display_e2e_pipe_params_st *pipes,
-- 
2.36.1

