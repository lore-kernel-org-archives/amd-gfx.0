Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6C2C35E01
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 19:12:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F342082F
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 19:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuLGapph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F342082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0A686EB9E;
	Tue, 25 Feb 2020 19:12:41 +0000 (UTC)
Received: from mail-yw1-xc42.google.com (mail-yw1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6569B6EB9E
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 19:12:40 +0000 (UTC)
Received: by mail-yw1-xc42.google.com with SMTP id i126so555551ywe.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 11:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3hIY/qR/n5+zEA4poXAI3jc8yLsBgVmZ7lUzJCl9zK0=;
 b=TuLGapphpTHZTFxsURCm6yUckCGKEIrnMLgPKppa5p+7+FX6HtwQB0yIeWz6qu8Kq+
 DirzlP3yHDoKpt6h4g7SgIE+nF0nsg5u5+Hu2Vb64jQsnrMEUz1V6zB4Ky85zdYxKUhw
 OCCaMWvz7ejRlEpcKFScewsr/xrugkOfANxH1inJgXONGIoWGg34tbnrcAdLsfqOU/IO
 taSAn2QQyHSB0S031aqhwWpA5eZet8avjpvcB7+42pwhS7oI1HtEOacmDJ8Oh9Nke3wk
 F96CBkxYZ9LmfC4tvloT8YjT0AV56CH4vhYDeQSdBpJM/KoVzrMqh6DTH8oG1PYHeXQH
 1DGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3hIY/qR/n5+zEA4poXAI3jc8yLsBgVmZ7lUzJCl9zK0=;
 b=IbcN83rHpvRdAlwWV8P5S3y/U8swE7GNQhDNMJvBQ8w9/eGV+43mJF/+wMdwloYNa2
 QmipPb3cs23pI4aj27E2Nhl0OTAbdubpyNBt0+Zs5BehbzEexg6Biidu+7vAxU1+k0fD
 Zm9LaowG1vp5lg+YcBfWC+wyi7+CzG+Dz1NkrA+9EqDhgM+XYo7h1QLIYgSzmafEn/hx
 UMPe4fM8YnrUMTrMNU/UEsn7ar9AJobX7LFCf0RaoNmGr+AJT4S6BUFmLesjejZ899R4
 Umut9YShLp/EsQId5iOODdVql2U2nsB27PIaByGSbFgm1GbZIicFMHzf0Q+SU5PBnq1Y
 UpzQ==
X-Gm-Message-State: APjAAAU7nW58Ihf1wX+YM2tPIfOGHOjTL2m+HAWWbjxDAhEqJBomiUSR
 QbOVZoAhB9OwnJa1WKA6JVEt/to2
X-Google-Smtp-Source: APXvYqwv03ExS+Vz5gJtK/iCN9FozGaY0RJNByrttl+yvzXLP+1pJwAm1c4wHlF7wD2fnM7bOuknzA==
X-Received: by 2002:a25:18c4:: with SMTP id 187mr881056yby.207.1582657959444; 
 Tue, 25 Feb 2020 11:12:39 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id p2sm7318853ywd.58.2020.02.25.11.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 11:12:38 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/display: move the setting of the aux dev
Date: Tue, 25 Feb 2020 14:12:30 -0500
Message-Id: <20200225191231.1058817-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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

We need to move this into late init to avoid it being NULL
once we switch the init order.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index d5b9e72f2649..d7a7dc0c256e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -157,6 +157,7 @@ amdgpu_dm_mst_connector_late_register(struct drm_connector *connector)
 	struct drm_dp_mst_port *port = amdgpu_dm_connector->port;
 	int r;
 
+	amdgpu_dm_connector->dm_dp_aux.aux.dev = connector->kdev;
 	r = drm_dp_aux_register(&amdgpu_dm_connector->dm_dp_aux.aux);
 	if (r)
 		return r;
@@ -485,7 +486,6 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
 				       struct amdgpu_dm_connector *aconnector)
 {
 	aconnector->dm_dp_aux.aux.name = "dmdc";
-	aconnector->dm_dp_aux.aux.dev = aconnector->base.kdev;
 	aconnector->dm_dp_aux.aux.transfer = dm_dp_aux_transfer;
 	aconnector->dm_dp_aux.ddc_service = aconnector->dc_link->ddc;
 
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
