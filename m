Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B516C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 18:50:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C201711AA18;
	Thu, 30 Jun 2022 18:50:34 +0000 (UTC)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8650C11AA18
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 18:50:33 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx0.riseup.net (Postfix) with ESMTPS id 4LYnTN5jyDz9sSd;
 Thu, 30 Jun 2022 18:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1656615033; bh=nSCOT1DD58jQwqlCjkRUEtYtFzgOgAcIKRrxunM5WaM=;
 h=From:To:Cc:Subject:Date:From;
 b=caM6QXu1PpsdGLkcsQs6ObyHWYYVeM0GNL4qz9yhnkJLmnqlGwXjddxrQTqKftFD0
 i4t3we9blCXyTdO65SHBio+BjO3XaMU9LfGLBzZdCQwXDQTshw0/EglFDH331d18Be
 Y2rIlKeUEkLpBXBdO8xeKZA3Hk8L0riK/T2enPtI=
X-Riseup-User-ID: 339BBADFF3DC1BF0303D044F0A237A340824BC022CE0114F3C19DA29713ABCB4
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4LYnTJ3PWWz5vLd;
 Thu, 30 Jun 2022 18:50:28 +0000 (UTC)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/amd/display: Remove return value of
 Calculate256BBlockSizes
Date: Thu, 30 Jun 2022 15:50:05 -0300
Message-Id: <20220630185005.908140-1-mairacanal@riseup.net>
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
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The function Calculate256BBlockSizes always returns true, regardless of
the parameters. As any file checks the return of the function, this
commit changes the return value to void.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c | 3 +--
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 2676710a5f2b..ed23c7c79d86 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -957,7 +957,7 @@ static void recalculate_params(
 	}
 }
 
-bool Calculate256BBlockSizes(
+void Calculate256BBlockSizes(
 		enum source_format_class SourcePixelFormat,
 		enum dm_swizzle_mode SurfaceTiling,
 		unsigned int BytePerPixelY,
@@ -995,7 +995,6 @@ bool Calculate256BBlockSizes(
 		*BlockWidth256BytesY = 256 / BytePerPixelY / *BlockHeight256BytesY;
 		*BlockWidth256BytesC = 256 / BytePerPixelC / *BlockHeight256BytesC;
 	}
-	return true;
 }
 
 bool CalculateMinAndMaxPrefetchMode(
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 10ff536ef2a4..25a9a606ab6f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -169,7 +169,7 @@ bool get_is_phantom_pipe(struct display_mode_lib *mode_lib,
 		unsigned int pipe_idx);
 void PixelClockAdjustmentForProgressiveToInterlaceUnit(struct display_mode_lib *mode_lib);
 
-bool Calculate256BBlockSizes(
+void Calculate256BBlockSizes(
 		enum source_format_class SourcePixelFormat,
 		enum dm_swizzle_mode SurfaceTiling,
 		unsigned int BytePerPixelY,
-- 
2.36.1

