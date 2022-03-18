Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4996C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 13:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52CB410E7EB;
	Fri, 18 Mar 2022 13:28:23 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09A8589057
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 08:29:26 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id s11so8825189pfu.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 01:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qYSHS1HMX6eMTWBoPQekbY/LnrHx+hVCf+4KGrQDYmc=;
 b=IFSSe8csUXjGGDosRHCGn3fO+VYoniE9x8J42lOZEudFDsNsV98ZesN6bj9YZHlSGx
 rzUUSNDgAqKWsCISlWsWoXZJ4+na9/zRejmLQtAxJeL750XBykhjuPYp5PtgjzXaioRP
 W6K8uKY7G1XRI6cPC4FJKf4UJipGp1a8UxVkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qYSHS1HMX6eMTWBoPQekbY/LnrHx+hVCf+4KGrQDYmc=;
 b=e7gbD7myP6CYxNo9xny/WAgXLy7DU0I9wpvPj68TVmZGvkKN31hIQdBt/P+8XxgkDB
 ux8WZpnYVEcILynoby87XVp68vYM7Lm0XBqx7iosusIaVTF+gSu5ZdSOU0O9syqP/mBX
 Y9HyXPgqSRPCvSQUPDGxVqUI7wkuEEgrPcqCUMvNcfxmdGPeZJUaxvbPHMiaQjVA4hJS
 EfaIORQG9/AITzV5XCtXqP8BaPlDfeXYSsxA/h/mS7EMccUoL+yQpH+jeKgj2DyDXW95
 SOLrdS5KHLzoBRyNxWP/k3o5pQlVq94ttIuSEFoIvNAADgxSREUZkGlZpTcIH/yuzfYm
 9Iiw==
X-Gm-Message-State: AOAM532a2Xys3LHoNq/91X6jYYQ81GXGLn6tF9j0xKJ7XmtLOiJDYA93
 +btBCfXJcn1GB4OH8HPXLHtRBg==
X-Google-Smtp-Source: ABdhPJzDLKDOl+pmopyHHP4KLg/0fWOsTqeY58M7BYm1nfrAKzxakmXqooCP00hA6BSnGX9OcZh/qg==
X-Received: by 2002:aa7:8385:0:b0:4f6:ef47:e943 with SMTP id
 u5-20020aa78385000000b004f6ef47e943mr9052216pfm.38.1647592165505; 
 Fri, 18 Mar 2022 01:29:25 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com
 ([2401:fa00:1:10:435a:ce78:7223:1e88])
 by smtp.gmail.com with ESMTPSA id
 q2-20020a056a00084200b004f761a7287dsm9404044pfk.131.2022.03.18.01.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Mar 2022 01:29:25 -0700 (PDT)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Subject: [PATCH v9 4/4] arm64: dts: mt8183: Add panel rotation
Date: Fri, 18 Mar 2022 15:48:25 +0800
Message-Id: <20220318074825.3359978-5-hsinyi@chromium.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
In-Reply-To: <20220318074825.3359978-1-hsinyi@chromium.org>
References: <20220318074825.3359978-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 18 Mar 2022 13:28:22 +0000
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
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Emil Velikov <emil.l.velikov@gmail.com>,
 devicetree@vger.kernel.org, Simon Ser <contact@emersion.fr>,
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
index 0f9480f91261..c7c6be106e2e 100644
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
2.35.1.894.gb6a874cedc-goog

