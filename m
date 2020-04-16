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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CCCC3815B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 19:43:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7861921BE5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 19:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHXl+shS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7861921BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC8D16EB55;
	Thu, 16 Apr 2020 19:43:35 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 204FD6EB52
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 19:43:35 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id l78so7012645qke.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 12:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E7Z44gGQufsJi8zb3swPGrsgPc5A+yauKaaqOqx/Ne4=;
 b=KHXl+shSfY/QIS5Il2Eq04TTcKF6GZV1iXRXIKLdFzlDnexvIzlET97MBR2u0unvNA
 YM4dfYNVLwwucEKJUoMECTFc66oq3Z0NLqlfeQ7stJZVihO0SP0lrO++SYvOeEU4l+8A
 Vhi7ZBGM6pGvKWKpB51RMBYl3ichcV7f1+n/L3LxKhswoS0Oq7Ed6AhlFFsNnJCWO7Db
 Bg83Cbh7GT/7UOSxFKGiy289meKX9PHCTDoVM/9BMGESxDwKyOAzzLUc43aEMzB7OVv4
 cuOxRqeawV9vD2w1c9IcJ0lRwUEd8iAFNb44/gPph6MLELVulLRYflTjP1Tm/Wky6UCR
 LyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E7Z44gGQufsJi8zb3swPGrsgPc5A+yauKaaqOqx/Ne4=;
 b=I8ZCbqQiziYuG570s7ZXeJng8pqP2tyFuEgOnmBf2JxZiefX/Hmiv7MW4C7MpqvUSs
 LfMF/kYg02qg+B80/7IDEeNNlb3aCW7rOwXU6VyAgIPP87829Rh7k89uaYJvaqB7U5N7
 2/yPcRyNPVFiN5xwVXIOWUKdNVXq7OteopgNgJotDZC+DCr2rOtkfC/zcS4xN2sWiM3J
 Qkmb0Iyhyh18e8IfsvLCAnDpTvUsgGfCZI0K2DIt2BWk+wLVu6HQyxt4bkt1Ed6mmDVi
 whd6EiW32jz4Vdw8ouQXCqfn6Dgnv8vBmC2rNjGFPCE0TZ971Zy9ASi4sFdW7LnwxJXB
 byJg==
X-Gm-Message-State: AGi0PuY+W71JsIFeLBTB+JT8jne98NMszY/VNETF5ZhWVCQVfwLkCwVX
 edwbFSAgihQzhQvzYxZp8cveU2VT
X-Google-Smtp-Source: APiQypKKVuL8WUMj9Wu/RpIRx9ZWctxhVYdcTcFCtKa2zqDTPQAQkuxavKgG97ThqhdcT5I6pZN/Jw==
X-Received: by 2002:a37:9a12:: with SMTP id c18mr5211932qke.455.1587066214087; 
 Thu, 16 Apr 2020 12:43:34 -0700 (PDT)
Received: from localhost.localdomain ([71.219.72.172])
 by smtp.gmail.com with ESMTPSA id z2sm3337364qkc.28.2020.04.16.12.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2020 12:43:33 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/display: give aux i2c buses more meaningful
 names
Date: Thu, 16 Apr 2020 15:43:25 -0400
Message-Id: <20200416194325.21755-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200416194325.21755-1-alexander.deucher@amd.com>
References: <20200416194325.21755-1-alexander.deucher@amd.com>
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

Mirror what we do for i2c display buses.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c          | 3 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 7 +++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    | 3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fc81788f24b4..4a85076c36ab 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4679,6 +4679,7 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 		i2c_del_adapter(&aconnector->i2c->base);
 		kfree(aconnector->i2c);
 	}
+	kfree(aconnector->dm_dp_aux.aux.name);
 
 	kfree(connector);
 }
@@ -6119,7 +6120,7 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 
 	if (connector_type == DRM_MODE_CONNECTOR_DisplayPort
 		|| connector_type == DRM_MODE_CONNECTOR_eDP)
-		amdgpu_dm_initialize_dp_connector(dm, aconnector);
+		amdgpu_dm_initialize_dp_connector(dm, aconnector, link->link_index);
 
 out_free:
 	if (res) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 7d28b0482127..69056660672d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -429,9 +429,12 @@ static const struct drm_dp_mst_topology_cbs dm_mst_cbs = {
 };
 
 void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
-				       struct amdgpu_dm_connector *aconnector)
+				       struct amdgpu_dm_connector *aconnector,
+				       int link_index)
 {
-	aconnector->dm_dp_aux.aux.name = "dmdc";
+	aconnector->dm_dp_aux.aux.name =
+		kasprintf(GFP_KERNEL, "AMDGPU DM aux hw bus %d",
+			  link_index);
 	aconnector->dm_dp_aux.aux.transfer = dm_dp_aux_transfer;
 	aconnector->dm_dp_aux.ddc_service = aconnector->dc_link->ddc;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index d6813ce67bbd..d2c56579a2cc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -32,7 +32,8 @@ struct amdgpu_dm_connector;
 int dm_mst_get_pbn_divider(struct dc_link *link);
 
 void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
-				       struct amdgpu_dm_connector *aconnector);
+				       struct amdgpu_dm_connector *aconnector,
+				       int link_index);
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 bool compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
