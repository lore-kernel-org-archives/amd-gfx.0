Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4DDBFD374D
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Feb 2026 12:19:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6029910E757;
	Wed, 25 Feb 2026 12:19:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="iUOcJUI5";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0455810E759;
 Wed, 25 Feb 2026 12:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5Bn02jxj+MmEcOxOxKuNHPzguqyBy4fPH5QAH3ukJE0=; b=iUOcJUI5cZ8QUpIIgkJnNzJQ5x
 cnRe7YJCCWLc7a/ueoHv2sW8QHicwbx8RtIJSw6JAK5QAiBHoaNcAaG2v+PMWI1QZJ1VY3p02TDbv
 jRkw9nGFf5L9ssG8I0JG9b/kkU0v2p+eNAbXmtPNUotvLniMQMB0OUQb+tGjdjQxo0IlIA/nGfNbx
 2bd8xsoRKqz+NMD20B/hwQcEpzk47pYBSE/fArtYpdTerf5wpdxO2Ro8SPfMQdMWnOsIwpQpAagDu
 VIGuouM/3cB3XsrwjRC/T4txKSRfAXmQzg0ylpFoZMhbUh8elOILfrOlL6ycUsrfmfxRffhyl7hkZ
 Zd6nnWvA==;
Received: from [186.208.68.119] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vvDrK-005DpP-TP; Wed, 25 Feb 2026 13:19:19 +0100
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, alex.hung@amd.com,
 andrzej.hajda@intel.com, christian.koenig@amd.com, harry.wentland@amd.com,
 jernej.skrabec@gmail.com, jonas@kwiboo.se,
 Laurent.pinchart@ideasonboard.com, maarten.lankhorst@linux.intel.com,
 mario.limonciello@amd.com, mripard@kernel.org, mwen@igalia.com,
 neil.armstrong@linaro.org, rfoss@kernel.org, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Michel Daenzer <michel.daenzer@mailbox.org>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com
Subject: [PATCH v8 1/8] drm/amd/display: make sure drm_edid stored in
 aconnector doesn't leak
Date: Wed, 25 Feb 2026 09:04:30 -0300
Message-ID: <20260225121903.236115-2-mwen@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225121903.236115-1-mwen@igalia.com>
References: <20260225121903.236115-1-mwen@igalia.com>
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
index 50a10b4fbb3f..845069c9ce85 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7729,6 +7729,8 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 		dc_sink_release(aconnector->dc_sink);
 	aconnector->dc_sink = NULL;
 
+	drm_edid_free(aconnector->drm_edid);
+
 	drm_dp_cec_unregister_connector(&aconnector->dm_dp_aux.aux);
 	drm_connector_unregister(connector);
 	drm_connector_cleanup(connector);
-- 
2.51.0

