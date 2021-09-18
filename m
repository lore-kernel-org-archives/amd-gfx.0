Return-Path: <SRS0=Av9g=OK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3FBC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Sep 2021 07:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D64610CE
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Sep 2021 07:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D9D64610CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34B396E3F4;
	Mon, 20 Sep 2021 07:19:16 +0000 (UTC)
X-Greylist: delayed 431 seconds by postgrey-1.36 at gabe;
 Sat, 18 Sep 2021 09:49:56 UTC
Received: from qq.com (smtpbg558.qq.com [183.3.226.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38D3D6E055
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Sep 2021 09:49:55 +0000 (UTC)
X-QQ-mid: bizesmtp39t1631958120t47jr2rw
Received: from localhost.localdomain (unknown [124.126.19.250])
 by esmtp6.qq.com (ESMTP) with 
 id ; Sat, 18 Sep 2021 17:41:59 +0800 (CST)
X-QQ-SSF: 0140000000200070B000B00B0000000
X-QQ-FEAT: /rrU+puPB7Tk5bnqdyL8tUxn9Y8rEAEEEI4wjYzKXbUhAmg5fth3vv7XnXEfL
 wlFd7G4YZzmF7uGuI+yAhU/XKJ4GOAQFiTyYwASs3tQngyH62gP83ym/Mfy6yPISSJPhRjy
 9oTTArd5BAzubAY+xjfYFTDanuBSF2FmJK+32vDAmt9u25XG0Aq+mtUPTThiu1IpRxkQ4Qh
 d97mmSNb7ZhH4XcGFYbQRI3DwWcIs2jM/r16ylriQ/3nB7vPbnLhUhjDFwf1bVCZjmbDEPQ
 3X4vgnmTCT5+vwU2Ec7tVjfkcrrpKBalaB5Hlj3fOYVcfc4FTzFHtqzvkmA9AcebZiZSUC3
 nf2JmkHq9DTcMEEJXd5DMh8kYprmYDeHo64bevX
X-QQ-GoodBg: 2
From: Zhiwei Yang <yangzhiwei@uniontech.com>
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Zhiwei Yang <yangzhiwei@uniontech.com>
Subject: [PATCH] drm/radeon: fix uninitialized bool variable
Date: Sat, 18 Sep 2021 17:41:57 +0800
Message-Id: <20210918094157.4770-1-yangzhiwei@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Mailman-Approved-At: Mon, 20 Sep 2021 07:19:15 +0000
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

The bool variable detected_hpd_without_ddc in struct radeon_connector
is uninitialized when first used, that may cause unnecessary ddc ops.
Make it as false when a new connector is alloced.

Signed-off-by: Zhiwei Yang <yangzhiwei@uniontech.com>
---
 drivers/gpu/drm/radeon/radeon_connectors.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index fe12d9d91d7a..c1987a66373f 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -1866,6 +1866,7 @@ radeon_add_atom_connector(struct drm_device *dev,
 	bool shared_ddc = false;
 	bool is_dp_bridge = false;
 	bool has_aux = false;
+	bool detected_hpd_without_ddc = false;
 
 	if (connector_type == DRM_MODE_CONNECTOR_Unknown)
 		return;
@@ -1923,6 +1924,7 @@ radeon_add_atom_connector(struct drm_device *dev,
 	radeon_connector->shared_ddc = shared_ddc;
 	radeon_connector->connector_object_id = connector_object_id;
 	radeon_connector->hpd = *hpd;
+	radeon_connector->detected_hpd_without_ddc = detected_hpd_without_ddc;
 
 	radeon_connector->router = *router;
 	if (router->ddc_valid || router->cd_valid) {
@@ -2384,6 +2386,7 @@ radeon_add_legacy_connector(struct drm_device *dev,
 	struct radeon_connector *radeon_connector;
 	struct i2c_adapter *ddc = NULL;
 	uint32_t subpixel_order = SubPixelNone;
+	bool detected_hpd_without_ddc = false;
 
 	if (connector_type == DRM_MODE_CONNECTOR_Unknown)
 		return;
@@ -2414,6 +2417,7 @@ radeon_add_legacy_connector(struct drm_device *dev,
 	radeon_connector->devices = supported_device;
 	radeon_connector->connector_object_id = connector_object_id;
 	radeon_connector->hpd = *hpd;
+	radeon_connector->detected_hpd_without_ddc = detected_hpd_without_ddc;
 
 	switch (connector_type) {
 	case DRM_MODE_CONNECTOR_VGA:
-- 
2.20.1



