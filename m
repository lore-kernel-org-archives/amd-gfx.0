Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095F8C4727F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 946752064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QasMpToZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946752064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29E446E960;
	Wed,  7 Oct 2020 16:32:50 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC3D56E973
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:48 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id r8so2367016qtp.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Y4NCJgc7fAgvkuvAf9T5egooj1CZo+SsObCGstyKhIU=;
 b=QasMpToZbLtHjXMZYT5cjZrlaISxoon3TXcLQW54UHH2y8vlAyHXxnZjCSesNu70ac
 EbqrVIMrgCTKaGpJwofbRdS8/0OGYR7m5VtJMmlk/2xASmJSI0bZBM02eRueYiesVndj
 wAqC1UMEls0yOx7GMvSPEtCknaZ3pBTlvlaJ090Uk9nzCvVLUw7EmhP+69Pn3++tfQvH
 34eUIgLQFy9proH31LiLCT6BClNiyTrZLkDmmQrZ7kjDLgzIWtPeZPCnzg9qepscjYP0
 4s4pImEzua+AF8Ws2JrizhTxZMByUl+/b5XUaVDzkmiL1OlC1Ny6qLt5wfPqPq94W9Xz
 DZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Y4NCJgc7fAgvkuvAf9T5egooj1CZo+SsObCGstyKhIU=;
 b=IKgwujOFNE2vHUbm/R/guVyAynyyUHBKnFN+9aP8TpZVZJR8UQP5McRD8YDRcXdTkD
 F4qxWaA5yZcZlEEJwfK8ZITCC5qlDzZgf+luR3zvR1X2G/+D/l0UzkpLjUWTqNtJT0WY
 PUFvS1u51kINyiAthqH/aQ4yzK1Z/QvpdxoWYYlbbBH+vwR8iRzJrUBTC8eqzC11SHkN
 gcpE/8IwanAA31eM8TUsaMyOUeRZtSvYFvcZJvpIMJP8CvJpczEJNWUeAvSn6uq5j3Ot
 dNeMg4Xea/C6OCx4P3d4whbe1WhOiq5x58AngD9Ba4laipI2qKFyO+XCswsuKIxXqLXJ
 ZvHQ==
X-Gm-Message-State: AOAM531FiPIB5ExJdE8xT1zfvhv7FWPdoPN1wWoVOAdM7R8cA3AEowov
 alzU4hXnanbPnkR9t/s36+8gs5/sK10=
X-Google-Smtp-Source: ABdhPJxLJWsunkF+5qJDbrYFwrsSJccesgh78Hwj4Y3HLMFbbGAV3GtSgfXo+1sA2XD0Kba1Xu5g9w==
X-Received: by 2002:ac8:488e:: with SMTP id i14mr4151808qtq.386.1602088367794; 
 Wed, 07 Oct 2020 09:32:47 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:47 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 43/50] drm/amdgpu/swsmu: update driver if version for
 dimgrey_cavefish(v2)
Date: Wed,  7 Oct 2020 12:31:28 -0400
Message-Id: <20201007163135.1944186-44-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201007163135.1944186-1-alexander.deucher@amd.com>
References: <20201007163135.1944186-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Per PMFW 59.5.0.

v2: refine subject and commit message, fix typo

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 84211c620417..ee13dad65e7b 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -33,7 +33,7 @@
 #define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x39
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x5
 #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x01
-#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0x6
+#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0x7
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
