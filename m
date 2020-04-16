Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9804AC2BB55
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 19:38:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677B621BE5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 19:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jqenksqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677B621BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0812D6EB50;
	Thu, 16 Apr 2020 19:38:07 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DE966EB50
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 19:38:05 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id q17so17203283qtp.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 12:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8rsdXPKGwK1XwTC81gBwOKEv60tM4J6GkTU8dcIrQwc=;
 b=Jqenksqm532nAqcoVV/r4uAQuZdx1YCx031Uv/H3dz9hSXZer0twjLQGpIQefznkiQ
 6NAN9jzRE1sa1U28IhswXBGZoET/xhJpGO9QOgbHXz+rEKBtinF84X6BMfMnjSPjFsLl
 uw+3ZsqYjoiMdf/KEH5wtG0YWMkSibLrgS9w2ZGvYrLwDEfNjqZpoFGKpWyvCHGYm6ZZ
 yhv81pzdeH+jbMpyuYZYErx3++3zq+MCH+QFoXUJ2FwMqoNIQ7wuB9+//mBz5pTjpgX7
 BhhNiUaQ8ToIsSM41J30xLa/Dh7AoqFT0e+NxDQTTVEmSl08o9ZBSOrt2BJOZ+/b3N7p
 ZaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8rsdXPKGwK1XwTC81gBwOKEv60tM4J6GkTU8dcIrQwc=;
 b=sgYInX0153tghuDQ27Dw5oRfcNBo028X1ThkMxgCNtp4KAosHf3qHDR92I2AzY6wIK
 oMAH+FcOywoOLkWO9VCaBtbpgbyhfPt/IIOLBpq17OOrUcvD91Or4GO6MqFXaSgHH47D
 7Yyjxr/m7yABbM067PAGs2e0GqTmFEs1qcesvOptANJn/L03OJGF+Ny0DgAI/Z9yzU0K
 RW7e66LN8jXriPrkwCPfQ1f32nvL4mHuPtrVdRjDHGXr0eEqKSVHZ7jyaPhS0jNuuuEq
 WbJqR4i4FhILF+uAVjel55EsWRIbatCHfahWOmMHqk+xwwMMLttGja4fcfBHAZE3bAeC
 aEsA==
X-Gm-Message-State: AGi0PuZJYVIzq7iGWkYosB/x168oAsmNQem6WlQ4zakRurmM/XAvENP/
 OY+K0rICKIV9iQzaJH9wHvdAt23v
X-Google-Smtp-Source: APiQypL2ycciKu24VlvjUhsmgmwTdIAoUH4HgBDqyGmnJubL2k8w3GVn92WnoTobUTGV1MHKyWTfWQ==
X-Received: by 2002:ac8:7a84:: with SMTP id x4mr21752378qtr.28.1587065884308; 
 Thu, 16 Apr 2020 12:38:04 -0700 (PDT)
Received: from localhost.localdomain ([71.219.72.172])
 by smtp.gmail.com with ESMTPSA id g14sm16578881qtb.24.2020.04.16.12.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2020 12:38:03 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/display: fix aux registration
Date: Thu, 16 Apr 2020 15:37:53 -0400
Message-Id: <20200416193754.3702-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We were registering the aux device in the MST late_register
rather than the regular one.

Fixes: 405a1f9090d1ac ("drm/amdgpu/display: split dp connector registration (v4)")
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1100
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      | 10 +++++++++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  8 ++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 417925a0d739..c113b676218d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4738,10 +4738,18 @@ amdgpu_dm_connector_atomic_duplicate_state(struct drm_connector *connector)
 static int
 amdgpu_dm_connector_late_register(struct drm_connector *connector)
 {
-#if defined(CONFIG_DEBUG_FS)
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
 		to_amdgpu_dm_connector(connector);
+	int r;
 
+	if (connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort) {
+		amdgpu_dm_connector->dm_dp_aux.aux.dev = connector->kdev;
+		r = drm_dp_aux_register(&amdgpu_dm_connector->dm_dp_aux.aux);
+		if (r)
+			return r;
+	}
+
+#if defined(CONFIG_DEBUG_FS)
 	connector_debugfs_init(amdgpu_dm_connector);
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index cb49f13c1548..7d28b0482127 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -113,16 +113,16 @@ amdgpu_dm_mst_connector_late_register(struct drm_connector *connector)
 		to_amdgpu_dm_connector(connector);
 	int r;
 
-	amdgpu_dm_connector->dm_dp_aux.aux.dev = connector->kdev;
-	r = drm_dp_aux_register(&amdgpu_dm_connector->dm_dp_aux.aux);
-	if (r)
+	r = drm_dp_mst_connector_late_register(connector,
+					       amdgpu_dm_connector->port);
+	if (r < 0)
 		return r;
 
 #if defined(CONFIG_DEBUG_FS)
 	connector_debugfs_init(amdgpu_dm_connector);
 #endif
 
-	return r;
+	return 0;
 }
 
 static void
-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
