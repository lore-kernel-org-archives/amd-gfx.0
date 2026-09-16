Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A03EC982C1
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 07:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C153110EB2F;
	Thu, 17 Sep 2026 07:07:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lxf9+HGN";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 762C010E8E6
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 14:23:37 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254f560398so163741566b.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 07:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789568616; x=1790173416; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=B6QT3yGLHL6iAKp7l+6TCtIqZRata/HBJzcHAfxOozE=;
 b=Lxf9+HGNhRNgHTg4S9zZx0HarFzTCbFXECgjrcPEtD5WcJmTZ99TxdocbFPxjnrdIx
 zglJtMO7LN6cFJ/IBhgxux5DRemLcYg2k4BNLlE2x4BKs4FTkEdtdj5Fp7wEpfmDW4as
 CzfopFHcf398gufO6483ukjtijMppTJtVF3rIi+3yH4Jx6nbOwxgMvLnBlzA0fEFmoPi
 uebUVo1YEYUPnvg8fgL/cs3s40EzZTUqmLpOnys75iV+e2hHUxeI3YSMAazazEoII03o
 UOaAjr6d3ukQ8ItBfLN2z34DteK3zRrAx/Bs8bzse1CpaNuGg8VWPSJHwm5/Z9+s/8co
 8COQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789568616; x=1790173416;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B6QT3yGLHL6iAKp7l+6TCtIqZRata/HBJzcHAfxOozE=;
 b=iJDyZ4EgILIuLoUrGQDjiQjzp2B+a/gZp7bx0MxdwqNohH8ptTcZIpTOgKzkUl2Zwt
 SlZd6jKU4u1d4Gd1xm3klAaezF+ZNHtg5OB9Jm74ltUSBNTf1ew8Uvu7XluuUIheWPCB
 EFXJrYoOE0ocEu6spVSn+eLoMVlVXa5Vkr7Rinywpwkc5ywTdTnatfOAmT0noyLeHS4b
 88tZzEbWhnUnwUL1SVMXTMLqrCT2j56J2/yjW63S3ZTupxemvvPiUG279Yjmxhei4IKp
 2aUGZBjbE4W9hwzlQ8agfGcbQbygBrrL9QUkV5haXWT1a9MWAAooq6XQ1a25Lkvp5kjd
 QMSg==
X-Forwarded-Encrypted: i=1;
 AKwUvByRjMF3LzlL3EM7J9Q9yG9eWTdyYDoc2vuL7myRyX6V6jQHy6TvpqG1g9ZH3en5Y1khnJeBOr5M@lists.freedesktop.org
X-Gm-Message-State: AFuF++n9yWbsiNUtAQhzFudKVy8UTGJTnNQcJzC8AriK3ZoxxreadooW
 NDXUrU023VYJlhUKLvWLdwFqwEa2Cknz4/AIM6uryZ0UuJDuRtYpS4sC
X-Gm-Gg: AYBFou0Wc15om2V4TaJfcEy6ypqoexoLogZ/ol/Q0MBl7QVup7xVnZxvHzJp8FbQac2
 RAMsSBO2+4Leq6idsRbuYh8ltsLzn8hrMZWGKFfhuIfZugeEgUOoId2lgNBeFvsyZZbVan3lCNm
 aLSH7pCZV4SrX+700qJiS9/EEuwn0eZ0yFnnYLEtbsVdUwtLWpt5vJrnx0bqisAGDQQga20AiFq
 0OiVhR58Lp3bZCyRVtdpx2ivK9alyKGY7kMotoPMyAUF2h1Ba6mb2D9Ijp8hFhoQWvYrfjy/KoK
 uojf98xW1S/81Ifr5ouTEGOiQsDzibVBrwYX/EZYnIrcpbeB2XGL0Top4WV/ziywcFfB/wU6AJm
 hpx4ThEYhenLXyvWujUok5M0fa7dNtra2QrXwRWTH1sArI7R7k0vK6xyA3nJy+s8pVoLNVTJN//
 UqdlzPtncZ28vBHnKs/oBEStibOko0wVwnrpMUEvqO/nzkOiFEB0xCdt6gLj5FeSKp8OgESz9ol
 V5omd/QdiSLaWjlvgJTgZ7hKlhsUAegz74BoJkUUVMHb7QRr7+cAwfmNPfy
X-Received: by 2002:a17:907:7241:b0:c26:19de:9138 with SMTP id
 a640c23a62f3a-c29e5351a04mr213058866b.43.1789568615501; 
 Wed, 16 Sep 2026 07:23:35 -0700 (PDT)
Received: from misharu.home
 (2a02-a463-a071-0-1562-51d1-d5f-82bb.fixed6.kpn.net.
 [2a02:a463:a071:0:1562:51d1:d5f:82bb])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29e801cdfesm105216566b.58.2026.09.16.07.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 07:23:34 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: siqueira@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 airlied@gmail.com, simona@ffwll.ch, hersenxs.wu@amd.com, Jerry.Zuo@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 Hari Mishal <harimishal1@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] drm/amd/display: guard dc_sink dereferences in MST mode
 validation
Date: Wed, 16 Sep 2026 16:23:32 +0200
Message-ID: <20260916142332.10394-1-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 07:07:03 +0000
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

dm_dp_mst_is_port_support_mode() reads
aconnector->dc_sink->dsc_caps... for the DSC branch-throughput check,
and get_conv_frl_bw()'s HDMI-PCON FRL-bandwidth path reads
aconnector->dc_sink->edid_caps.max_frl_rate, both without a NULL
check. dc_sink is cleared asynchronously on MST unplug, and both
functions run from paths that the driver's own comments document as
racing that teardown: the connector probe worker's ->mode_valid
callback and a compositor's atomic check, neither of which holds the
MST manager lock that the teardown path uses. The former does have an
existing dsc_aux NULL check, but dsc_aux isn't reliably cleared in
every path that clears dc_sink, so it doesn't cover this.

Fail the port-support check and skip the FRL conversion path when the
sink is already gone.

Fixes: f04d275d94e1 ("drm/amd/display: add mst port output bw check")
Fixes: 5c9b8b27a883 ("drm/amd/display: Tie FRL support into amdgpu_dm")
Cc: stable@vger.kernel.org
Assisted-by: gkh_clanker_t1000
Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 045a7f88b754..7261317d4c0f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1231,7 +1231,8 @@ static bool get_conv_frl_bw(struct amdgpu_dm_connector *aconnector,
 	unsigned int max_sink_bw_in_kbps = 0;
 	unsigned int dsc_max_sink_bw_in_kbps = 0;
 
-	if (aconnector->dc_link->dc->caps.dp_hdmi21_pcon_support &&
+	if (aconnector->dc_sink &&
+	    aconnector->dc_link->dc->caps.dp_hdmi21_pcon_support &&
 	    aconnector->mst_downstream_port_caps.bytes.byte0.bits.DWN_STRM_PORTX_TYPE == DOWN_STREAM_DETAILED_HDMI) {
 		max_conv_bw_in_kbps = dc_link_bw_kbps_from_raw_frl_link_rate_data(
 				aconnector->dc_link->dc,
@@ -1996,6 +1997,9 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 	struct dc_dsc_config_options dsc_options = {0};
 	uint32_t stream_kbps;
 
+	if (!aconnector->dc_sink)
+		return DC_FAIL_BANDWIDTH_VALIDATE;
+
 	/* DSC unnecessary case
 	 * Check if timing could be supported within end-to-end BW
 	 */
-- 
2.43.0

