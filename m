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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A11C35E01
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 19:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB9AC2082F
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 19:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ldj84iUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB9AC2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7227F6EB9F;
	Tue, 25 Feb 2020 19:12:45 +0000 (UTC)
Received: from mail-yw1-xc42.google.com (mail-yw1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55B7D6EB9E
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 19:12:41 +0000 (UTC)
Received: by mail-yw1-xc42.google.com with SMTP id b186so602255ywc.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 11:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VPWrn0iMfFfxq7z7XZ7qYMU8GmZQXH+m9CErvrxJ+gQ=;
 b=Ldj84iULApM66NRv6wLfvZBf6FdRxrNdpu+F5/ZwpqEbYVC18z3UqU+j5/xm2+NlJt
 dfqHwn1v4fgQiGULxFrG9GH6L7mYxEQNLyd9HkV2AsvQxbz51NKaUNaI4XW7V99uoSmj
 TR/CAk3OXEMtSU86iRV1baP2gx3EK5IOjQIDMy5wNJAn9mjwDxoDyu97HkNAZo7zPm4t
 8ixjKT/eBfAAeR7MuV1vpMK01+eqdQRxr/oNZrrwS/L8ygX5UH+h9WFj98V/4C7TgAmP
 h4M2NdrQSyQzHXgmvbTH41pcbf/XVn2uFYFhnaqsAW6jQ5i2kuoPRQqHFo3nzmWvDwJK
 YxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VPWrn0iMfFfxq7z7XZ7qYMU8GmZQXH+m9CErvrxJ+gQ=;
 b=OaqUotxVhh2u9BeacmvbHtWGhHODPdhmzDKv2iDdhMLnUq7P40FNF92SXsXtZvDsQU
 eC3Zy3GQ0C1ikFjGbr1s5jHZhj9/1Hch50hf+2Y9YDJQo69f1jcBiWiAs8F7aDvacXO5
 Mklo1vn17VCq0Kly0GoXt269uqKLaFTiZqJaT6JYPNLi10GXlNWnBZIVhTdpC2hWW1uO
 2V/3X7QLXbexjddvtipl7nPIoNd+FXj86VMzzP1FDHKLjxAAn+uA2jxSWSKoptdVXUY+
 tieKVqr8/ltoPVzvP+2mB79c7s0VZwpEdgE+MKNYizQ3F5WUCGZNOme32vvTw33hv/PU
 MSMw==
X-Gm-Message-State: APjAAAXkUR9U85CmqLvhtkKUr8Go1H2Kjati/KmkRqBaoC7v/sMFVCui
 njggelrHMh4h4awmwQubeenlOnp2
X-Google-Smtp-Source: APXvYqzeOocuegGHD1svVGwcTPlwoN4vRXwAroiCcnTpvYPSbZA8E4Ve1lNzX3h6g4twc18HrwiEXg==
X-Received: by 2002:a81:301:: with SMTP id 1mr197527ywd.405.1582657960275;
 Tue, 25 Feb 2020 11:12:40 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id p2sm7318853ywd.58.2020.02.25.11.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 11:12:39 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/display: don't call
 drm_dp_mst_connector_late_register (v2)
Date: Tue, 25 Feb 2020 14:12:31 -0500
Message-Id: <20200225191231.1058817-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200225191231.1058817-1-alexander.deucher@amd.com>
References: <20200225191231.1058817-1-alexander.deucher@amd.com>
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

Nothing else calls it.  Not sure it's necessary.

v2: remove unused port variable.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index d7a7dc0c256e..0ef0eeb16778 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -154,7 +154,6 @@ amdgpu_dm_mst_connector_late_register(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
 		to_amdgpu_dm_connector(connector);
-	struct drm_dp_mst_port *port = amdgpu_dm_connector->port;
 	int r;
 
 	amdgpu_dm_connector->dm_dp_aux.aux.dev = connector->kdev;
@@ -166,7 +165,7 @@ amdgpu_dm_mst_connector_late_register(struct drm_connector *connector)
 	connector_debugfs_init(amdgpu_dm_connector);
 #endif
 
-	return drm_dp_mst_connector_late_register(connector, port);
+	return r;
 }
 
 static void
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
