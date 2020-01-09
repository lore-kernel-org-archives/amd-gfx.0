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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FF0C33CA2
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 15:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F2DC206ED
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 15:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p99COeC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2DC206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15E6E6E916;
	Thu,  9 Jan 2020 15:20:52 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77E766E90D;
 Thu,  9 Jan 2020 15:20:50 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id u2so3271704wmc.3;
 Thu, 09 Jan 2020 07:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nhq4oOb9sAd3YH/kEf0sSIFnHXBezziGw7mK9MGTa/M=;
 b=p99COeC5K21BT9fmsDH0y8L+/8/VUyX0wLlabhi8C3+bxMIk/bT88Nt56AVQCldgZD
 KkoCz7XyznI2Y97hsE/8CYwLN/8YG8x6ZBy9Kw3ghJrPXkXf/mKBNRrXygI0DY6FO9++
 EepEdeybqM3h3dYZHvQitv5y/LA8Bn77CltZTRaeRnzCsWh94DGVhmicfk+dJD8W1060
 Izfx0DLUA/op03IcklQZF3SDHjITHeiGSg8cYSRAs87OGBIM+eBC9klsf9MWiCWd0CwE
 OxgB2KaN5W/qRg1tX9mIH1OX55C24MDWjDotrYyGesvqiPmGwIOtIRiPDGS7bTVnqlPP
 F2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nhq4oOb9sAd3YH/kEf0sSIFnHXBezziGw7mK9MGTa/M=;
 b=isqVcsgCIi10RtbWRlEtrnMeaAdH+7LjIOYzzhmbwpjrjq7/zk6hB3h9AnhMqJUVvl
 oZAkBKEoYpx5aEG6BzpsjoDJE+UbZIqQFJDm61znVOBQBZnY4s/lfP85oqmsiDeRK6MD
 LunWY55JuzNTE//vbgB/T+vv5nRSuSePQu/Oe4izat506EmusUltuhuZLsIVHv23beFP
 Vh/maFKO36pC29F7yDRcKJopwcR0gWp5BIzkKNqh9BTuSQO+eiWUBnITsB56gZNIa8bu
 iirHW7bMl9r6T3Vg2Q885gcAfVax7hs1/SMXdnO8WJxrFJj3Euc5JqBkQoqc+ydG0ZyW
 Nd2w==
X-Gm-Message-State: APjAAAVTUNOqXwORXb3sIROq1eM67c5Gjx8e4or9yuiu0eidi40eoL+Q
 ER68OMqdSZ9FbHABw2UdZkv/kGZG8/k=
X-Google-Smtp-Source: APXvYqzNL4VLQG755cSbZij4BeAr7YM7w28kRhf6cJcqFUi2VZXUVcFcCr18apGMp57+Wm3aB4OISA==
X-Received: by 2002:a1c:28d4:: with SMTP id o203mr5508402wmo.123.1578583248988; 
 Thu, 09 Jan 2020 07:20:48 -0800 (PST)
Received: from twisty.localdomain ([2a01:c23:7c40:600:59fe:915f:cac1:6580])
 by smtp.gmail.com with ESMTPSA id r62sm3309872wma.32.2020.01.09.07.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 07:20:48 -0800 (PST)
From: Mario Kleiner <mario.kleiner.de@gmail.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/display: Reorder detect_edp_sink_caps before link
 settings read.
Date: Thu,  9 Jan 2020 16:20:27 +0100
Message-Id: <20200109152028.28260-2-mario.kleiner.de@gmail.com>
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
 Mario Kleiner <mario.kleiner.de@gmail.com>,
 Martin Leung <martin.leung@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

read_current_link_settings_on_detect() on eDP 1.4+ may use the
edp_supported_link_rates table which is set up by
detect_edp_sink_caps(), so that function needs to be called first.

Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Cc: Martin Leung <martin.leung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index cef8c1ba9797..5ea4a1675259 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -817,8 +817,8 @@ static bool dc_link_detect_helper(struct dc_link *link,
 		}
 
 		case SIGNAL_TYPE_EDP: {
-			read_current_link_settings_on_detect(link);
 			detect_edp_sink_caps(link);
+			read_current_link_settings_on_detect(link);
 			sink_caps.transaction_type = DDC_TRANSACTION_TYPE_I2C_OVER_AUX;
 			sink_caps.signal = SIGNAL_TYPE_EDP;
 			break;
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
