Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58BCCCFA05
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 16:56:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B694710E968;
	Thu,  6 Nov 2025 16:56:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="jSJg1lz3";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97FD510E95E;
 Thu,  6 Nov 2025 16:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=X9eHW0cZFIDsfUQJ3jcp28tbgfDmPhkEHTHq8afJuvI=; b=jSJg1lz3a2rBSXDljqWdQ20P1+
 3pFk7qLbh+07G6/jZbrZVrNmr/mi0ofFersaVbwkFiRQX25IaZqkIlV+sVBErs99vNapilp471ars
 6UPZjLlFqydYGnLUAS03sS2ijXFpSTDHiPEI8WKpdHK+wMtfp9m+wLn7OuebOIpPgV9Zn0KDYUlAG
 xbAj5x+nXXFb4kW5V4sHGjM+ruC+LEbMJVuLofJ6MMWHb2oZcd7Iy9i30QluGVaPgqO2FeGdJh9tb
 w3Eceans4VczPa1ASUAcqD8IZVRLF8ZWv9eRMRnUxV6hq9xPOL/ap9kJ9IZ0wIwk0VQ1dOXMP/m4a
 WHClb/mA==;
Received: from [186.208.74.26] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vH3H4-0035jh-CU; Thu, 06 Nov 2025 17:55:50 +0100
From: Melissa Wen <mwen@igalia.com>
To: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, andrzej.hajda@intel.com,
 christian.koenig@amd.com, jernej.skrabec@gmail.com, jonas@kwiboo.se,
 Laurent.pinchart@ideasonboard.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, mwen@igalia.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, simona@ffwll.ch, sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Michel Daenzer <michel.daenzer@mailbox.org>,
 Jani Nikula <jani.nikula@linux.intel.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
Subject: [PATCH v7 01/15] drm/amd/display: make sure drm_edid stored in
 aconnector doesn't leak
Date: Thu,  6 Nov 2025 13:49:04 -0300
Message-ID: <20251106165536.161662-2-mwen@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106165536.161662-1-mwen@igalia.com>
References: <20251106165536.161662-1-mwen@igalia.com>
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

Make sure the drm_edid container stored in aconnector is freed when
destroying the aconnector.

Fixes: 48edb2a4256e ("drm/amd/display: switch amdgpu_dm_connector to use struct drm_edid")
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ba11421332da..a62f18ecd439 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7565,6 +7565,8 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 		dc_sink_release(aconnector->dc_sink);
 	aconnector->dc_sink = NULL;
 
+	drm_edid_free(aconnector->drm_edid);
+
 	drm_dp_cec_unregister_connector(&aconnector->dm_dp_aux.aux);
 	drm_connector_unregister(connector);
 	drm_connector_cleanup(connector);
-- 
2.51.0

