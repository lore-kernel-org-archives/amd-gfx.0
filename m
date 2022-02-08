Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8B2C43217
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 08:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC24410E59C;
	Tue,  8 Feb 2022 08:26:57 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CF7610E693
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 07:37:27 +0000 (UTC)
Received: by mail-pf1-x42e.google.com with SMTP id d187so17430115pfa.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Feb 2022 23:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RKltf19DtHiRc15a3iaZ/NnDb+6ppKujiVxWZQto3YU=;
 b=UQRrh4b2cYpExbUb5sYjfYPmvD9zbPX49JL8Al9S0glKbqkZ0dmzb/DWvs20vFsU4I
 O/YgtlkeyONvN4ODXkKbAwbVKcjSXwNHy1KNIzNLS8S85I1c3k2dDioajk+vyYjTK0vr
 kVR0Zgv0Jb0jFEIXVFA9s6SyAAU+51lA2FXMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RKltf19DtHiRc15a3iaZ/NnDb+6ppKujiVxWZQto3YU=;
 b=IobdSvDdI2OmHe1dId4IKEjwO7piWsJMhRlmBfjAa72COfjZHDy2Z4pv3mVAwRggIm
 +hHN6ufeklnqe2n/L7wrTcIFC1tGJFa/7Z6Ci7yl0ACU9CFDgHmLxAtJ5hJlSRrR1vEu
 Wd6ZVogheb7qjgYMTDRZ3kDb4QKFitj/2ShyQIKun9ObZwSuOVGV+JniTbzQXWQVrRlW
 6LBE1HIr01xCK065KW8hFOcSyyZI8//kr8KwM196IDCpUXRyri1UtmR79TwC0S5xK99m
 f6AobfRYYWawBoMOFRopRiRlJTcl+VKHxyaYSFbQ9SusjXuhg/zIcj+KKlNBs7dNOn+s
 581w==
X-Gm-Message-State: AOAM5316k1SbD2Ng2+JirT0WV23URt0siKG5fDWD/f7TXzPOeBkdqa6b
 HCGZ007KSZVlBKyniRZZtdMsHg==
X-Google-Smtp-Source: ABdhPJx2727H/bIFB7AiNJuAQfngpGnHTMQX3kn1wApGZnVIxbe2t19Z6gDkwdss+b2K2QYmV7K1CQ==
X-Received: by 2002:a63:8a44:: with SMTP id y65mr2554451pgd.590.1644305846835; 
 Mon, 07 Feb 2022 23:37:26 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com
 ([2401:fa00:1:10:7d9a:166e:9d34:ff4f])
 by smtp.gmail.com with ESMTPSA id ip5sm1677243pjb.13.2022.02.07.23.37.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Feb 2022 23:37:26 -0800 (PST)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Subject: [PATCH v7 3/3] arm64: dts: mt8183: Add panel rotation
Date: Tue,  8 Feb 2022 15:37:14 +0800
Message-Id: <20220208073714.1540390-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208073714.1540390-1-hsinyi@chromium.org>
References: <20220208073714.1540390-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Feb 2022 08:26:44 +0000
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

