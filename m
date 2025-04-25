Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26893C369C2
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 20:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE6BF10E9D1;
	Fri, 25 Apr 2025 20:52:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Z5tUm2/O";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A462910E9D1;
 Fri, 25 Apr 2025 20:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=F+POhOomwByFeS7kcR+6NCbtAJWfCbOcxddWyhPISq0=; b=Z5tUm2/OL8qctSmbpTFkehUt9W
 b1ffFoKY7StlyvyxN2rIB5S2nGpUA3Rs3vQ9SKxfK2F6mZEI7caSe/mQQOGtNWeTYKQGZN4upy8Ad
 jJcRwv+tTI8dGc88Ev0M6Vr6G3nuDZxfTNjjs6v58xqX+BM2P5BHqDnDnbIw5LhwWp7rDuI2voHPN
 CQq0ySCW5S06HYdvtFh7buGMkR+BTVozrctLm1Ai90VaarJ16erMuYAYW9tttE79VwupdFuSV3/JU
 6UWfpDbd8Warn/uVsF7mAzhpWbZdKBsS0tRvKEa+VjXqUWR9x5SZPmcYIXtqWI4QpZKACxrRxK2QJ
 XyRbE46A==;
Received: from [189.6.35.67] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1u8Q2M-008V5C-Q3; Fri, 25 Apr 2025 22:52:43 +0200
From: Melissa Wen <mwen@igalia.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch
Cc: Michel Daenzer <michel.daenzer@mailbox.org>,
 Simon Ser <contact@emersion.fr>, Xaver Hugl <xaver.hugl@gmail.com>,
 kernel-dev@igalia.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: no 3D and blnd LUT as DPP color caps for
 DCN401
Date: Fri, 25 Apr 2025 17:52:30 -0300
Message-ID: <20250425205236.318520-1-mwen@igalia.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
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

Match what is declared as DPP color caps with hw caps. DCN401 has MPC
shaper+3D+blnd LUTs that are movable before and after blending (get from
plane or stream), but no DPP shaper+3D+blend LUTs.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c  | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 5b7148bb1701..3b142e662c7b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1937,8 +1937,8 @@ static bool dcn401_resource_construct(
 	dc->caps.color.dpp.gamma_corr = 1;
 	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
 
-	dc->caps.color.dpp.hw_3d_lut = 1;
-	dc->caps.color.dpp.ogam_ram = 1;
+	dc->caps.color.dpp.hw_3d_lut = 0;
+	dc->caps.color.dpp.ogam_ram = 0;
 	// no OGAM ROM on DCN2 and later ASICs
 	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
 	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
-- 
2.47.2

