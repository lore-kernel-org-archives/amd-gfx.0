Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E1FC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 14:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA4261165
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 14:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9BA4261165
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0032F6EA08;
	Wed, 13 Oct 2021 14:42:40 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDD766EA02;
 Wed, 13 Oct 2021 14:42:39 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 563DD61165;
 Wed, 13 Oct 2021 14:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634136159;
 bh=qtuN71F2mOeUcWHCNSmjSBO9j7CrGEvPuhdVjbtcEXM=;
 h=From:To:Cc:Subject:Date:From;
 b=PppLkcWhmQMcUsDDMZNYA8XJrYgHKJLduHy/K88ME/Rl7/Oy6OzjH1AXPu8ZGw1rx
 U/K90vZksfK4Vr7V+9fO7RiAAIRIYIPBg/7OwnQdtoT/vv1r+u7CnY1zngjfUdmUoh
 LvJpTK6Ho9VhFrlRg8RlPQ6XUQzfnH62rEFbAemXw4Oao2Ai1Jlpj5qigFo/2/95Eq
 7dIm4kCpSm4wSG/08bDTshWYW1H7En6dS/Yj0m7IlA/Phwlc/K5NtPnaGz/H2/97ku
 Il7tXcn4HoL6PpUHaxfVPp0bnviOI26xIfuNQf5Obak5VhxTZuYyFbFEm+W1W4TW6K
 e6JAOmADkm6Vg==
From: Arnd Bergmann <arnd@kernel.org>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 Jaehyun Chung <jaehyun.chung@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Felipe <Felipe.Clark@amd.com>,
 Felipe Clark <felclark@amd.com>, Derek Lai <Derek.Lai@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: fix apply_degamma_for_user_regamma() warning
Date: Wed, 13 Oct 2021 16:42:07 +0200
Message-Id: <20211013144234.2224358-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
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

From: Arnd Bergmann <arnd@arndb.de>

It appears that the wrong argument was removed in this call:

drivers/gpu/drm/amd/amdgpu/../display/modules/color/color_gamma.c: In function 'apply_degamma_for_user_regamma':
drivers/gpu/drm/amd/amdgpu/../display/modules/color/color_gamma.c:1694:36: error: implicit conversion from 'enum <anonymous>' to 'enum dc_transfer_func_predefined' [-Werror=enum-conversion]
 1694 |         build_coefficients(&coeff, true);

Fixes: 9b3d76527f6e ("drm/amd/display: Revert adding degamma coefficients")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 64a38f08f497..4cb6617059ae 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -1691,7 +1691,7 @@ static void apply_degamma_for_user_regamma(struct pwl_float_data_ex *rgb_regamma
 	struct pwl_float_data_ex *rgb = rgb_regamma;
 	const struct hw_x_point *coord_x = coordinates_x;
 
-	build_coefficients(&coeff, true);
+	build_coefficients(&coeff, TRANSFER_FUNCTION_SRGB);
 
 	i = 0;
 	while (i != hw_points_num + 1) {
-- 
2.29.2

