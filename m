Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1177C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 07:45:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73FE710F57E;
	Tue, 31 May 2022 07:45:35 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66FAF10E048
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 08:19:38 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id v15so9505095pgk.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 01:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0FDANzoD+ved+kLqkfGfvHR/pdrWdYCkcffUnS1gfwU=;
 b=EGj3J9IVTCdQAdPBammRVILB8q1w15Xcl7B4hV147t6lruwgmdowastMDeg50FrM4A
 Ds9V3H86IryQlC6KV4iX5TGgLG04/0gOrc6j1Y31gCWhI534zZoCg93dEK211ACoOi5q
 2fxY2lyR/VS+yq2eiIqTUPtlHMbj067JlnVoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0FDANzoD+ved+kLqkfGfvHR/pdrWdYCkcffUnS1gfwU=;
 b=2yihe8VidLf6JNKQCVNFb6L5Wc2h5a6uLKPODoYkX/ub4HHqoGR6s1nTAgXcKFuAKu
 8amNJWX74ok8u0DCXPWpQebx1QKzjilRXiNtiidXsOUyGhxgGy4WvErVBtVyou00DBU4
 m4b47ZycQ08LeXq67fgUqAP90Sa7TJxh1II+MMJkTjNRow86nUBarcmnWslsLlCTWN6Y
 R/0Zm2FAYNvD9SckH1HaSNLLdYTkrPdvtoiB/fLf2BuSSBStj4MADwCdh8TLMHUIGO8c
 I9PZbbqEHiEwVfrqgeT84SCaAAmEPn5AFwYPcUNsci8W/MFZB2rXOAJ7TRASbLzOJzBj
 zPLg==
X-Gm-Message-State: AOAM532aAv7eCCTVjnYMslrStN48B8wNZchiPoyJL+N2rwIx7olgwOsE
 5dPs527UQ17ctUDKtEdJfZt2XQ==
X-Google-Smtp-Source: ABdhPJxC6hh+IA2nmnrMvgr7EIZHEawv5NbrZ/B9hfbxzJ5J4ENWWvjvBaWIFpEhTfiwlYPQDqCDTQ==
X-Received: by 2002:a65:4183:0:b0:3fc:1370:9c37 with SMTP id
 a3-20020a654183000000b003fc13709c37mr4005861pgq.4.1653898777736; 
 Mon, 30 May 2022 01:19:37 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com
 ([2401:fa00:1:10:ae1c:3d63:abec:1097])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a170902f64100b001618b70dcc9sm8537900plg.101.2022.05.30.01.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 May 2022 01:19:37 -0700 (PDT)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Subject: [PATCH v10 4/4] arm64: dts: mt8183: Add panel rotation
Date: Mon, 30 May 2022 16:19:10 +0800
Message-Id: <20220530081910.3947168-5-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220530081910.3947168-1-hsinyi@chromium.org>
References: <20220530081910.3947168-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 31 May 2022 07:45:33 +0000
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
Cc: Rob Clark <robdclark@chromium.org>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Emil Velikov <emil.l.velikov@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Douglas Anderson <dianders@chromium.org>, Maxime Ripard <mripard@kernel.org>,
 Stephen Boyd <swboyd@chromium.org>, Alex Deucher <alexander.deucher@amd.com>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simon Ser <contact@emersion.fr>,
 Matthias Brugger <matthias.bgg@gmail.com>, Sean Paul <sean@poorly.run>,
 Hans de Goede <hdegoede@redhat.com>, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

krane, kakadu, and kodama boards have a default panel rotation.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 8d5bf73a9099..f0dd5a06629d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -276,6 +276,7 @@ panel: panel@0 {
 		avee-supply = <&ppvarp_lcd>;
 		pp1800-supply = <&pp1800_lcd>;
 		backlight = <&backlight_lcd0>;
+		rotation = <270>;
 		port {
 			panel_in: endpoint {
 				remote-endpoint = <&dsi_out>;
-- 
2.36.1.124.g0e6072fb45-goog

