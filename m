Return-Path: <SRS0=uap9=5Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AADC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 12:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E125820848
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 12:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmKJzhLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E125820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADCE56E2FF;
	Tue, 31 Mar 2020 12:50:30 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50DB46E2FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 12:50:29 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id s1so25744609wrv.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 05:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NbJufFMOaT9Yc0FI2nUL1WarjNeur5eI0HflmrFiKZk=;
 b=RmKJzhLpDitmDPtb7Q8vBdHwAHwl6oXOXwx1KIwoDMBRll7sGOEWU9ExGOIM1ReIx+
 UozyuqV3204/HYFTIzzwt8Hcgot7r47US7OEUK99EZaThgWSzjnKXqAvD1Q9NQB15tSP
 efD/DeXR6I2vsZJ0Uwa0jd6RVGYB8t0E57gfICTpAGZczKGDGMs9H1hYprc4uJ0vKQKV
 cEZoT6+F9+4Ca9gDfSmqz5De3P/hbpOFkUYKIFXDZMUiBitAvFNBFA1sK87HqhsaP+4Y
 IdZxrzcUnbgildABgzUIQyKFcoLj40YzcP2PHl9pgiLYvt8i1ycRFz7BBboS+fjsVMZY
 4aqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NbJufFMOaT9Yc0FI2nUL1WarjNeur5eI0HflmrFiKZk=;
 b=dtcn8esFnpUcpEzmzYbN8kycWDo9G4cO5xvgW5x9gYX5cu8cIYR+HdcA1/jFG04C4q
 xkg3UjLVwotWP7knstFGywK+IujVLreQdBwo0FWWO4QIajv985dz8lgcE00uOc9M+Yjy
 IZJ3ghquB4I4LUdOgkA5pyaClw+J+ZMenW0Lf99IDElaElkxpIhT979VAheS03ApsCq1
 QB1paJ6gD1hp6Ph4MBf3MulQHXxjE2P9qM2d9QayhmqOqjGAGheBrjYMzCRL1c+v0Mka
 HyqXiqJHgwkRggEdD7ER8TT1PVr9DlI0eAuR49V+x/zIwfj5oQgchISJ6PR5tQv8SEzE
 YmpQ==
X-Gm-Message-State: ANhLgQ0jGrZXHVSH0BX6ZO3q8nsx0lhCm29ULLZV3nFmjNRlpifEms29
 X3od1cz3fMAFT412RbB5ooCDPSV+
X-Google-Smtp-Source: ADFU+vs3kMgg5ru4VWBpMoz7KyCybxipIwaOUL+ul6+RBF0/mfK2VE9Oa+S4Hb0rnYUjVDH6wtZI+g==
X-Received: by 2002:adf:afcb:: with SMTP id y11mr19526127wrd.141.1585659027221; 
 Tue, 31 Mar 2020 05:50:27 -0700 (PDT)
Received: from brihaspati.fritz.box
 (p200300C58F2E74000298C664B0CADE76.dip0.t-ipconnect.de.
 [2003:c5:8f2e:7400:298:c664:b0ca:de76])
 by smtp.gmail.com with ESMTPSA id b203sm3760946wmc.45.2020.03.31.05.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 05:50:26 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: sync ring type with drm hw_ip type
Date: Tue, 31 Mar 2020 14:54:47 +0200
Message-Id: <20200331125448.47874-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.1
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
Cc: alexander.deucher@amd.com, ray.huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move AMDGPU_RING_TYPE_KIQ at the end of amdgpu_ring_type enum
to sync amdgpu_ring_type values with AMDGPU_HW_IP_*

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 080024d21d3e..121041369c42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -52,11 +52,11 @@ enum amdgpu_ring_type {
 	AMDGPU_RING_TYPE_SDMA,
 	AMDGPU_RING_TYPE_UVD,
 	AMDGPU_RING_TYPE_VCE,
-	AMDGPU_RING_TYPE_KIQ,
 	AMDGPU_RING_TYPE_UVD_ENC,
 	AMDGPU_RING_TYPE_VCN_DEC,
 	AMDGPU_RING_TYPE_VCN_ENC,
-	AMDGPU_RING_TYPE_VCN_JPEG
+	AMDGPU_RING_TYPE_VCN_JPEG,
+	AMDGPU_RING_TYPE_KIQ
 };

 struct amdgpu_device;
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
