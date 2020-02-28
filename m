Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF048C3F2CD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 21:36:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DE6421927
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 21:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1dqAmT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE6421927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 378206F43B;
	Fri, 28 Feb 2020 21:36:21 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A553B6F43B;
 Fri, 28 Feb 2020 21:36:20 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id z15so4766891wrl.1;
 Fri, 28 Feb 2020 13:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zOJXiTH0nMZgWutdcz6NzHUVI1jO4JZQmKz4LEVAunM=;
 b=j1dqAmT0ztM3MWtgoZHUS7Y1FP7zxYnsEYVIZNleESpwaj0T+E61IJ+rABhnBZo98B
 KDBWF2P1UjWM00Fh5xMBb+uBfzIXZO2qwXaIK1Y3/rqHoKPQEbCDKaNlqhLunyMCSRxU
 e08TurVwc4qyzHrkVNucPOQdyhCDwg746FPhhktTMLFfrSQiovY0ywFR7QJBWnSkfvY5
 +1srW7TaVrMvgpQQbIcXjXdJK83K9mMxG3oskNYMqdDXLTA5Dwa6irWyr0DyZalEOX2+
 /GpW/6KX/W2hCg7TPs7kfDVpE2C+3LRufTd6FE9rxJQIrlCfj9JlrGZQVMKdSpiZOeaB
 RqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zOJXiTH0nMZgWutdcz6NzHUVI1jO4JZQmKz4LEVAunM=;
 b=WKW2asMngTpIUGPsJlf37Qu02XI6EgMy4o4i2o7rhJGt1DSggM6Qartsp19xEWtvMz
 1RKhi86OpEDB0/PBLJ1CZjJDSVicmW5TGnZ3p2ivGvRk8kmD97HVMimS18dNYeMP1BhU
 lpw9bwHCyG05w2okEsZcSud07jGypieXed1JNHmGKt2fkkdGPM5l6GlNt7w3+BKq0RY2
 /V9YTziO4/KlHLvEB1r7Pcsn3dB3BgSlGhmji1obWpDCrlfupZgMkWZ6j3Np9WMaOSI1
 03xdYA3O0/leDS6CHI4F/MVtAhD8275XQS7scdYEJIId8ExgJSXbSHOSWm8reQ/EN0BE
 oEZw==
X-Gm-Message-State: APjAAAWxQ0X6mvFz69EgUkhOiWUsa6QNlqZYTeG7ZKxgjtiigecwv9PE
 Vt6Lz15Zc1vWoZs6wBGYys+eQxoM
X-Google-Smtp-Source: APXvYqzyVsNM6YknQS4Lbd2P+fUd2F3Rkfw+/P81p8ZixqS+VutnO8DA5Zwu0emGZ4AGSa5kD68J0Q==
X-Received: by 2002:adf:b1d4:: with SMTP id r20mr6362976wra.303.1582925779068; 
 Fri, 28 Feb 2020 13:36:19 -0800 (PST)
Received: from groovy.localdomain
 (dynamic-2a01-0c23-842e-e900-c83a-d23d-162a-2310.c23.pool.telefonica.de.
 [2a01:c23:842e:e900:c83a:d23d:162a:2310])
 by smtp.gmail.com with ESMTPSA id x8sm1426397wro.55.2020.02.28.13.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 13:36:18 -0800 (PST)
From: Mario Kleiner <mario.kleiner.de@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Add link_rate quirk for Apple 15" MBP 2017
Date: Fri, 28 Feb 2020 22:36:07 +0100
Message-Id: <20200228213607.23784-1-mario.kleiner.de@gmail.com>
X-Mailer: git-send-email 2.20.1
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
Cc: alexander.deucher@amd.com, mario.kleiner.de@gmail.com, hwentlan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This fixes a problem found on the MacBookPro 2017 Retina panel:

The panel reports 10 bpc color depth in its EDID, and the
firmware chooses link settings at boot which support enough
bandwidth for 10 bpc (324000 kbit/sec aka LINK_RATE_RBR2
aka 0xc), but the DP_MAX_LINK_RATE dpcd register only reports
2.7 Gbps (multiplier value 0xa) as possible, in direct
contradiction of what the firmware successfully set up.

This restricts the panel to 8 bpc, not providing the full
color depth of the panel on Linux <= 5.5. Additionally, commit
'4a8ca46bae8a ("drm/amd/display: Default max bpc to 16 for eDP")'
introduced into Linux 5.6-rc1 will unclamp panel depth to
its full 10 bpc, thereby requiring a eDP bandwidth for all
modes that exceeds the bandwidth available and causes all modes
to fail validation -> No modes for the laptop panel -> failure
to set any mode -> Panel goes dark.

This patch adds a quirk specific to the MBP 2017 15" Retina
panel to override reported max link rate to the correct maximum
of 0xc = LINK_RATE_RBR2 to fix the darkness and reduced display
precision.

Please apply for Linux 5.6+ to avoid regressing Apple MBP panel
support.

Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index cb731c1d30b1..fd9e69634c50 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3401,6 +3401,17 @@ static bool retrieve_link_cap(struct dc_link *link)
 		sink_id.ieee_device_id,
 		sizeof(sink_id.ieee_device_id));
 
+	/* Quirk Apple MBP 2017 15" Retina panel: Wrong DP_MAX_LINK_RATE */
+	{
+		uint8_t str_mbp_2017[] = { 101, 68, 21, 101, 98, 97 };
+
+		if ((link->dpcd_caps.sink_dev_id == 0x0010fa) &&
+		    !memcmp(link->dpcd_caps.sink_dev_id_str, str_mbp_2017,
+			    sizeof(str_mbp_2017))) {
+			link->reported_link_cap.link_rate = 0x0c;
+		}
+	}
+
 	core_link_read_dpcd(
 		link,
 		DP_SINK_HW_REVISION_START,
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
