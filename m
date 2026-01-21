Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EBCD6260D
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 08:36:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1887810E935;
	Thu, 22 Jan 2026 08:36:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="S5+ZkMcH";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9F7910E834;
 Wed, 21 Jan 2026 14:48:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1769006892; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GRAq2EuTac6Mq6i0t+LyJMc7NglhbkgdhY9zkk+h8JURXr8zLYMzbtvSxbITyjSkOhrZK4N3eOqNjWhZvTBbd9BvI8VN53b2tDzYrMRYd6NcC1t2pg3P7wNFhD9ToYo8Wx/btaGGKu7Ii5qw+TxV6a40tM57fia4fl6msBkjJVE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1769006892;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=RSXhbmC3n6qv4fmbrHo/VYnmC01w0SpCKpxl71nPUq4=; 
 b=ccZcs+LpjWcyC0wPrr+pT6obmlIHpIht5naqvc0KJv2wNO8rBiHCHY+hhec7EjJDv2uMJJPlL+aEK+aSIOXUmLtWeeICoxMklEQWEOw58Ks5MDH4N9mz9tjcGKDZVz1RtvfsedgZTdsrlUSkb5BpbOKrf3yrAgyDN7J2937vjKU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769006892; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=RSXhbmC3n6qv4fmbrHo/VYnmC01w0SpCKpxl71nPUq4=;
 b=S5+ZkMcHjoohd3WfGKo9QzA0/sYp1/VYdj2z98zvmyqDNz9vmNPol7P68IKSExGM
 NMQ1yvUqnwhrEGG53K+IXzTOFii2rwj7uD+C1SPm/a/LC4Jy3ePBmZMeghMuqCLQg9T
 Vqe41P8HS0iWS2L8Zlyl6/vH9U2f8QE9vayouOqk=
Received: by mx.zohomail.com with SMTPS id 1769006890778410.0564390583087;
 Wed, 21 Jan 2026 06:48:10 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 21 Jan 2026 15:45:27 +0100
Subject: [PATCH v7 20/22] drm/tests: edid: Add __maybe_unused attribute to
 EDID definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-color-format-v7-20-ef790dae780c@collabora.com>
References: <20260121-color-format-v7-0-ef790dae780c@collabora.com>
In-Reply-To: <20260121-color-format-v7-0-ef790dae780c@collabora.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Dmitry Baryshkov <lumag@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: kernel@collabora.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Thu, 22 Jan 2026 08:36:26 +0000
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

It's normal for a test suite to need an EDID, but not all EDIDs across
every test. Silence compiler warnings caused by unused definitions by
using the appropriate attribute.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/tests/drm_kunit_edid.h | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_kunit_edid.h b/drivers/gpu/drm/tests/drm_kunit_edid.h
index f4923157f5bf..18bb7043d7e8 100644
--- a/drivers/gpu/drm/tests/drm_kunit_edid.h
+++ b/drivers/gpu/drm/tests/drm_kunit_edid.h
@@ -54,7 +54,8 @@
  *
  * EDID conformity: PASS
  */
-static const unsigned char test_edid_dvi_1080p[] = {
+static const unsigned char __maybe_unused
+test_edid_dvi_1080p[] = {
 	0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x31, 0xd8, 0x2a, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x21, 0x01, 0x03, 0x81, 0xa0, 0x5a, 0x78,
 	0x0a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -160,7 +161,8 @@ static const unsigned char test_edid_dvi_1080p[] = {
  *
  * EDID conformity: FAIL
  */
-static const unsigned char test_edid_hdmi_1080p_rgb_max_100mhz[] = {
+static const unsigned char __maybe_unused
+test_edid_hdmi_1080p_rgb_max_100mhz[] = {
 	0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x31, 0xd8, 0x2a, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x21, 0x01, 0x03, 0x81, 0xa0, 0x5a, 0x78,
 	0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20,
@@ -268,7 +270,8 @@ static const unsigned char test_edid_hdmi_1080p_rgb_max_100mhz[] = {
  *
  * EDID conformity: PASS
  */
-static const unsigned char test_edid_hdmi_1080p_rgb_max_200mhz[] = {
+static const unsigned char __maybe_unused
+test_edid_hdmi_1080p_rgb_max_200mhz[] = {
 	0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x31, 0xd8, 0x2a, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x21, 0x01, 0x03, 0x81, 0xa0, 0x5a, 0x78,
 	0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20,
@@ -387,7 +390,8 @@ static const unsigned char test_edid_hdmi_1080p_rgb_max_200mhz[] = {
  *
  * EDID conformity: PASS
  */
-static const unsigned char test_edid_hdmi_1080p_rgb_max_200mhz_hdr[] = {
+static const unsigned char __maybe_unused
+test_edid_hdmi_1080p_rgb_max_200mhz_hdr[] = {
 	0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x31, 0xd8, 0x2a, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x21, 0x01, 0x03, 0x81, 0xa0, 0x5a, 0x78,
 	0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20,
@@ -495,7 +499,8 @@ static const unsigned char test_edid_hdmi_1080p_rgb_max_200mhz_hdr[] = {
  *
  * EDID conformity: PASS
  */
-static const unsigned char test_edid_hdmi_1080p_rgb_max_340mhz[] = {
+static const unsigned char __maybe_unused
+test_edid_hdmi_1080p_rgb_max_340mhz[] = {
 	0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x31, 0xd8, 0x2a, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x21, 0x01, 0x03, 0x81, 0xa0, 0x5a, 0x78,
 	0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20,
@@ -609,7 +614,8 @@ static const unsigned char test_edid_hdmi_1080p_rgb_max_340mhz[] = {
  *
  * EDID conformity: PASS
  */
-static const unsigned char test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz[] = {
+static const unsigned char __maybe_unused
+test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz[] = {
 	0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x31, 0xd8, 0x2a, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x21, 0x01, 0x03, 0x81, 0xa0, 0x5a, 0x78,
 	0x1a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20,
@@ -723,7 +729,8 @@ static const unsigned char test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz[] = {
  *
  * EDID conformity: PASS
  */
-static const unsigned char test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz[] = {
+static const unsigned char __maybe_unused
+test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz[] = {
 	0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x31, 0xd8, 0x2a, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x21, 0x01, 0x03, 0x81, 0xa0, 0x5a, 0x78,
 	0x0a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20,
@@ -841,7 +848,8 @@ static const unsigned char test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz[] = {
  *     VIC  95:  3840x2160   30.000000 Hz  16:9     67.500 kHz    297.000000 MHz
  * Checksum: 0xca
  */
-static const unsigned char test_edid_hdmi_1080p_rgb_yuv_4k_yuv420_dc_max_200mhz[] = {
+static const unsigned char __maybe_unused
+test_edid_hdmi_1080p_rgb_yuv_4k_yuv420_dc_max_200mhz[] = {
 	0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x31, 0xd8, 0x34, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0xff, 0x23, 0x01, 0x03, 0x80, 0x60, 0x36, 0x78,
 	0x0f, 0xee, 0x91, 0xa3, 0x54, 0x4c, 0x99, 0x26, 0x0f, 0x50, 0x54, 0x20,
@@ -955,7 +963,8 @@ static const unsigned char test_edid_hdmi_1080p_rgb_yuv_4k_yuv420_dc_max_200mhz[
  *   YCbCr 4:2:0 Video Data Block:
  * Checksum: 0x84
  */
-static const unsigned char test_edid_hdmi_4k_rgb_yuv420_dc_max_340mhz[] = {
+static const unsigned char __maybe_unused
+test_edid_hdmi_4k_rgb_yuv420_dc_max_340mhz[] = {
 	0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x31, 0xd8, 0x34, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0xff, 0x23, 0x01, 0x03, 0x80, 0x60, 0x36, 0x78,
 	0x0f, 0xee, 0x91, 0xa3, 0x54, 0x4c, 0x99, 0x26, 0x0f, 0x50, 0x54, 0x20,

-- 
2.52.0

