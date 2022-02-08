Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AA4C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 14:38:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0D6E10E4DF;
	Tue,  8 Feb 2022 14:38:03 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD5DB10E5C3
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 08:42:46 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id p43so124927pfw.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Feb 2022 00:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RKltf19DtHiRc15a3iaZ/NnDb+6ppKujiVxWZQto3YU=;
 b=O2UDOpBeBJRbX3+DaQG7mIxxaEO05L1HTD48WquGaDuYWsSttm9JTTNF7a+lc8KdMj
 tJRuDchff9o48V7UXFNQVgoxZ/rNJPLVl8KQxtPWFS7zVK0sOis64KFrKb3J8stVpjkN
 Pk7y7Sj69FXDSqgG4hJ/qiPJrJRpnz6L6YEME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RKltf19DtHiRc15a3iaZ/NnDb+6ppKujiVxWZQto3YU=;
 b=UbczhzCn9CgUVhn8IZAgIsWkrAzhufv5OV1EeAhqZ7xCfmcY2Mbi0tg90knUKPcC7Y
 Wb/PTm86zy5Cso+hDg7V0r0/aeLWTnPwv7xY1gukyUb6i3hdWwxCjaxoxt4/kpArLWqR
 TW34AikJhMxpzUzBXvdoGfcgC67NIiLUZEToM5LEVxK43iLwnrbesb6vbbtD8UbCS37X
 2ZrPSFDwn7KUopBfg4csWSH4yGdlCwIdhYx8YQx3oqRI7SIdJ6LF9Dasqlj4CBr6mCwq
 kCkiMH1MBmMqecP8ZdhN/UDs14Y7dWy31u322kSDlRui/o5w+p0E+2uYnOfUK3DGP3Ga
 VCeg==
X-Gm-Message-State: AOAM5300cszjIRU+Sgv+GyjaN5vRPTnAPXBSRjxUPyhEeN08uU62Pq7o
 vuDsE5mGQ9CzLX9czyya+ISjWg==
X-Google-Smtp-Source: ABdhPJxJuhyNGgn/8M1tkfbfnImy5ANlW87FCMT9C5ygmikEd8cwYFifi2WHJ+zYaY+iMKeTEIBo9Q==
X-Received: by 2002:a63:2ad6:: with SMTP id q205mr2651010pgq.46.1644309766435; 
 Tue, 08 Feb 2022 00:42:46 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com
 ([2401:fa00:1:10:7d9a:166e:9d34:ff4f])
 by smtp.gmail.com with ESMTPSA id m14sm15362390pfc.170.2022.02.08.00.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Feb 2022 00:42:46 -0800 (PST)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Subject: [PATCH v8 3/3] arm64: dts: mt8183: Add panel rotation
Date: Tue,  8 Feb 2022 16:42:34 +0800
Message-Id: <20220208084234.1684930-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208084234.1684930-1-hsinyi@chromium.org>
References: <20220208084234.1684930-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Feb 2022 14:38:02 +0000
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
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, devicetree@vger.kernel.org,
 Simon Ser <contact@emersion.fr>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Harry Wentland <harry.wentland@amd.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Sean Paul <sean@poorly.run>,
 linux-arm-kernel@lists.infradead.org
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
index b42d81d26d7211..d29d4378170971 100644
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
2.35.0.263.gb82422642f-goog

