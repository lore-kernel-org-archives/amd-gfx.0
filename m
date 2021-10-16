Return-Path: <SRS0=O5Im=PE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8D8C433FE
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Oct 2021 18:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F148C6115C
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Oct 2021 18:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F148C6115C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=net-c.es
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 655476E4AD;
	Sat, 16 Oct 2021 18:42:51 +0000 (UTC)
Received: from msg-4.mailo.com (ip-15.mailobj.net [213.182.54.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D71746E48E;
 Sat, 16 Oct 2021 18:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=net-c.es; s=mailo;
 t=1634409762; bh=EXkDekAufK6goeabnufaLKQbzyG9y1fY1+pkrXICOg0=;
 h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding;
 b=qWMmjH05MZ99u0QzP1jsb3bV5W9QkmDNt3HAlUwgzvNmB0smEmrVfLmMri224Thrb
 NrAJIYPZcF67Mj8w7gaCfl+3X1h2CzQG5pGveKTS6PUncSNN6tUbM7TbmEAgrDDLJo
 7Ik9Dy/5vJzWwn+NYQFlkpoW3W2kq7c4iUrPz77c=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
 via ip-206.mailobj.net [213.182.55.206]
 Sat, 16 Oct 2021 20:42:41 +0200 (CEST)
X-EA-Auth: ZT1bvVRSjwCXyJ5qMQMpI8DA5jiJfebeNQk7aKCzUT6lHLRx6DdXNzuri4BaUl0RTnbERGE8xabipPmjWqZr3BWIZk+ARf74
From: Claudio Suarez <cssk@net-c.es>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Pan Xinhui <Xinhui.Pan@amd.com>, Emma Anholt <emma@anholt.net>,
 Maxime Ripard <mripard@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Jingoo Han <jingoohan1@gmail.com>, Rob Clark <robdclark@gmail.com>,
 Sean Paul <sean@poorly.run>, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 Sandy Huang <hjc@rock-chips.com>, heiko@sntech.de,
 Neil Armstrong <narmstrong@baylibre.com>,
 Robert Foss <robert.foss@linaro.org>, Ben Skeggs <bskeggs@redhat.com>,
 nouveau@lists.freedesktop.org, ville.syrjala@linux.intel.com
Cc: Claudio Suarez <cssk@net-c.es>
Subject: [PATCH v2 02/13] drm/vc4: replace drm_detect_hdmi_monitor() with
 drm_display_info.is_hdmi
Date: Sat, 16 Oct 2021 20:42:15 +0200
Message-Id: <20211016184226.3862-3-cssk@net-c.es>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211016184226.3862-1-cssk@net-c.es>
References: <20211016184226.3862-1-cssk@net-c.es>
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

Once EDID is parsed, the monitor HDMI support information is available
through drm_display_info.is_hdmi. Use this value instead of calling
drm_detect_hdmi_monitor() to avoid a second parse.

This is a TODO task in Documentation/gpu/todo.rst

Signed-off-by: Claudio Suarez <cssk@net-c.es>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index b4b4653fe301..d531e4c501eb 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -182,7 +182,8 @@ vc4_hdmi_connector_detect(struct drm_connector *connector, bool force)
 
 			if (edid) {
 				cec_s_phys_addr_from_edid(vc4_hdmi->cec_adap, edid);
-				vc4_hdmi->encoder.hdmi_monitor = drm_detect_hdmi_monitor(edid);
+				vc4_hdmi->encoder.hdmi_monitor =
+						connector->display_info.is_hdmi;
 				kfree(edid);
 			}
 		}
@@ -212,10 +213,9 @@ static int vc4_hdmi_connector_get_modes(struct drm_connector *connector)
 	if (!edid)
 		return -ENODEV;
 
-	vc4_encoder->hdmi_monitor = drm_detect_hdmi_monitor(edid);
-
 	drm_connector_update_edid_property(connector, edid);
 	ret = drm_add_edid_modes(connector, edid);
+	vc4_encoder->hdmi_monitor = connector->display_info.is_hdmi;
 	kfree(edid);
 
 	if (vc4_hdmi->disable_4kp60) {
-- 
2.33.0



