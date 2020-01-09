Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD88C282DD
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 15:20:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CAE3206ED
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 15:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzrU3tLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CAE3206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B72216E914;
	Thu,  9 Jan 2020 15:20:56 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57EDD6E914;
 Thu,  9 Jan 2020 15:20:55 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id m24so3344788wmc.3;
 Thu, 09 Jan 2020 07:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HVmcjsQ4CK4Dh4FAXO7O8QfRWUhREJ70mgUGQmInyOw=;
 b=tzrU3tLvFIv4t8yFUPMr2exQ8u60/2njo7AlY5raTAJPU8vzcgRIV7rj3hz60qbde2
 DharD1t/tEqNFJD3A5ycq74QZvRSTB3D1GB40+cccogmW1SD/8s35ELuBY8zhFDcWRRq
 Vy+cktSi5rXqagQ3sFScwEDDKKY9CS4sgdPTthOKVplkC+q1i34gg9gfBrpDWpygZDbf
 isrYlWbPxH9bPn9/gIP6FfPa/XqTvTP9Y47axI0IUbPNtHTyGkdXiuy2sBa8zJrPr9QG
 ak3y2tJwbAg6rofXvG9146mPb7YIzuTgth/l9fjxXrCnrQp18m6/jilZ9NZa6HSzIGAl
 AYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HVmcjsQ4CK4Dh4FAXO7O8QfRWUhREJ70mgUGQmInyOw=;
 b=c1hhKN1VzLxOYHdP2AqOIxDHHfysNd1NYJtKFjqmk2pske29BHy6GmD5H166nCCLlq
 8vYgrV8zyMvOXKZ3vUwJOYx0Qe34iNad4ZO0tJAt2u8VrAY482y9mNberVe6mNrUU6Uq
 Vfliy7BmtEI9+oIcnSu0RBLoxAtEK6lOBzJKxMQY0ot4UXyHlVo9DubFhJRiS6LM1SyC
 rsWChgPO5CA/rv935Gpx+UrX2pwBWBLp5nNdV/3Oc6B35bj0BenmDTzJUKQeJb+5XHK1
 xSNQU0p08ckV56jFQ8OOx7EobXC87oaOuvcoRfvrRpu/4CC72l7XDal6Uc09SulvkvjM
 46qg==
X-Gm-Message-State: APjAAAXBi7QnuMPkJV7bX3V3U6lIUrYCX/8+xCpNmfNzwI2o6sPpOrS4
 h2m7efcL8tnue6UnBcGVxXe6CSMQ+wc=
X-Google-Smtp-Source: APXvYqxATA133zpHm/kEqxSsCx0yrbj8Jg7uWTU5FgWAFe69ir1WuVn8XAk0mFA4Q2s7ZBpgy4TJ4w==
X-Received: by 2002:a1c:1fc5:: with SMTP id f188mr5867919wmf.55.1578583253772; 
 Thu, 09 Jan 2020 07:20:53 -0800 (PST)
Received: from twisty.localdomain ([2a01:c23:7c40:600:59fe:915f:cac1:6580])
 by smtp.gmail.com with ESMTPSA id r62sm3309872wma.32.2020.01.09.07.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 07:20:53 -0800 (PST)
From: Mario Kleiner <mario.kleiner.de@gmail.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/display: Allow current eDP link settings to
 override verified ones.
Date: Thu,  9 Jan 2020 16:20:28 +0100
Message-Id: <20200109152028.28260-3-mario.kleiner.de@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200109152028.28260-1-mario.kleiner.de@gmail.com>
References: <20200109152028.28260-1-mario.kleiner.de@gmail.com>
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
Cc: alexander.deucher@amd.com, mario.kleiner.de@gmail.de,
 Mario Kleiner <mario.kleiner.de@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If the current eDP link settings, as read from hw, provide a higher
bandwidth than the verified_link_cap ones (= reported_link_cap), then
override verified_link_cap with current settings.

These initial current eDP link settings have been set up by
firmware during boot, so they should work on the eDP panel.
Therefore use them if the firmware thinks they are good and
they provide higher link bandwidth, e.g., to enable higher
resolutions / color depths.

This fixes a problem found on the MacBookPro 2017 Retina panel:

The panel reports 10 bpc color depth in its EDID, and the
firmware chooses link settings at boot which support enough
bandwidth for 10 bpc (324000 kbit/sec aka LINK_RATE_RBR2),
but the DP_MAX_LINK_RATE dpcd register only reports 2.7 Gbps
as possible, so verified_link_cap is only good for 2.7 Gbps
and 8 bpc, not providing the full color depth of the panel.

Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 5ea4a1675259..f3acdb8fead5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -819,6 +819,27 @@ static bool dc_link_detect_helper(struct dc_link *link,
 		case SIGNAL_TYPE_EDP: {
 			detect_edp_sink_caps(link);
 			read_current_link_settings_on_detect(link);
+
+			/* If cur_link_settings provides higher bandwidth than
+			 * verified_link_cap, then use cur_link_settings as new
+			 * verified_link_cap, as it obviously works according to
+			 * firmware boot setup.
+			 *
+			 * This has been observed on the Apple MacBookPro 2017
+			 * Retina panel, which boots with a link setting higher
+			 * than what dpcd[DP_MAX_LINK_RATE] claims as possible.
+			 * Overriding allows to run the panel at 10 bpc / 30 bit.
+			 */
+			if (dc_link_bandwidth_kbps(link, &link->cur_link_settings) >
+			    dc_link_bandwidth_kbps(link, &link->verified_link_cap)) {
+				DC_LOG_DETECTION_DP_CAPS(
+				"eDP current link setting bw %d kbps > verified_link_cap %d kbps. Override.",
+				dc_link_bandwidth_kbps(link, &link->cur_link_settings),
+				dc_link_bandwidth_kbps(link, &link->verified_link_cap));
+
+				link->verified_link_cap = link->cur_link_settings;
+			}
+
 			sink_caps.transaction_type = DDC_TRANSACTION_TYPE_I2C_OVER_AUX;
 			sink_caps.signal = SIGNAL_TYPE_EDP;
 			break;
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
