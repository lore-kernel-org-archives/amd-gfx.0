Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328CBC28B25
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Mar 2025 14:27:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99E7110E1BC;
	Sat,  8 Mar 2025 14:27:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="I3DNU3qS";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08C6410E1BC
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Mar 2025 14:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=evnWeds//1Rr+cRwVo4W+C14IASh2j8mM2cBhuURawg=; b=I3DNU3qSA/UYR57pBZIhp31nCI
 Anf+vuMYqi1FWx3BWV1uxdiTit+Iu81IKxiTpWKL4trjRnFIwyAQio3t7qWcaS2GtqbQaJ8EI/Ruq
 33Xok12qGf9EMdSMvTxtDPa1pGjxCDP7VvyS++qFs/yiQn6iY9bodSso22krFj+JXGHbnn+pfeLV4
 PEGiasoAzn4n7oQ1HJbymXmUqmbl/aI0pYyhiboT6imx/MM+uJc+PZMPVmJdqedCCAoYEgl8XOOv/
 N8Q60X/rqkd6o/1cksOY3eY4Ke4IhZwO4OnSIEpipuIUxlIwRWDVBtCig7lXeKLJB2T9JBXkOHBdk
 vhOLESBQ==;
Received: from [189.6.35.67] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tqv8g-005pIP-Sn; Sat, 08 Mar 2025 15:27:01 +0100
From: Melissa Wen <mwen@igalia.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, mario.limonciello@amd.com, alex.hung@amd.com,
 siqueira@igalia.com
Cc: amd-gfx@lists.freedesktop.org,
	kernel-dev@igalia.com
Subject: [RFC PATCH 1/7] drm/amd/display: make sure drm_edid stored in
 aconnector doesn't leak
Date: Sat,  8 Mar 2025 11:26:05 -0300
Message-ID: <20250308142650.35920-2-mwen@igalia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250308142650.35920-1-mwen@igalia.com>
References: <20250308142650.35920-1-mwen@igalia.com>
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
detroying the aconnector.

Fixes: 48edb2a4 ("drm/amd/display: switch amdgpu_dm_connector to use struct drm_edid")
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5939796db74c..dacb8b92c0d6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7271,6 +7271,8 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 		dc_sink_release(aconnector->dc_sink);
 	aconnector->dc_sink = NULL;
 
+	drm_edid_free(aconnector->drm_edid);
+
 	drm_dp_cec_unregister_connector(&aconnector->dm_dp_aux.aux);
 	drm_connector_unregister(connector);
 	drm_connector_cleanup(connector);
-- 
2.47.2

