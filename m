Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127DEC04A6A
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Aug 2023 07:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 884D810E69B;
	Fri,  4 Aug 2023 07:18:44 +0000 (UTC)
X-Greylist: delayed 398 seconds by postgrey-1.36 at gabe;
 Thu, 03 Aug 2023 14:18:00 UTC
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D67510E0CB;
 Thu,  3 Aug 2023 14:18:00 +0000 (UTC)
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1691071876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Wwx6Ta6AHqq3TcGW8bDS4dyENTyGmjacKacctkGambU=;
 b=SVNHybaDXO7SxMWdFbZblKTdyyFkRoiYZQcaKlUxbxzbcVAdbKxYxPGC5CPwCH2clX7nhS
 picfAtFTw01T80c7e1s2RP/e1bbR16gQsGvSdfYdGy0sftTwtP4e8AsPCNdIbU0+FQsjGh
 ZnIjvQUSnrniQv3p+J8kgTlGv0ex0bs=
To: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Return value of function
Date: Thu,  3 Aug 2023 17:11:16 +0300
Message-Id: <20230803141116.58883-1-arefev@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 04 Aug 2023 07:18:41 +0000
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
Cc: trufanov@swemel.ru, lvc-project@linuxtesting.org,
 Leo Li <sunpeng.li@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, vfh@swemel.ru,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 David Airlie <airlied@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Added return value check hpd_enable

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index fa314493ffc5..bf2f620aeb66 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -1645,7 +1645,7 @@ void dce110_link_encoder_enable_hpd(struct link_encoder *enc)
 	uint32_t hpd_enable = 0;
 	uint32_t value = dm_read_reg(ctx, addr);
 
-	get_reg_field_value(hpd_enable, DC_HPD_CONTROL, DC_HPD_EN);
+	hpd_enable = get_reg_field_value(hpd_enable, DC_HPD_CONTROL, DC_HPD_EN);
 
 	if (hpd_enable == 0)
 		set_reg_field_value(value, 1, DC_HPD_CONTROL, DC_HPD_EN);
-- 
2.25.1

