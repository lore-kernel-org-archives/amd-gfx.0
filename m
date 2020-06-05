Return-Path: <SRS0=/kPV=7S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AC3C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 15:40:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 891932074B
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 15:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTw8KU3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891932074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 429A46E93D;
	Fri,  5 Jun 2020 15:40:45 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E80D6E93D
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2020 15:40:44 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id fc4so4904302qvb.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Jun 2020 08:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XGKLqR8tFVRO5q3ZMYLnxKvgLz8p/JwTRMP6Lmp8oKU=;
 b=kTw8KU3e9Letoi5fSyQ647Xu6+TRORtOzweIkt1TNJHYi6TiqX4hP7lZGXq98J3eFe
 y11tbsY7xfQSck5HbnfNI4aDtKFuDVT3/5iuVO8qdK7DKIFsJXP3gjYMhRxqohYDvzeX
 Fcu+fm7cXjNj/TGA+F9Zo5DE/hskfITGJ70pZkw55/UHjQNqhIzH8Yk2mFwA6EAqpLoG
 4hN7242HqtvSDEvfOGibmwrct1jY3prMoSdThK3YEdFiAW7UG3m7qCAwVzbc/zgOKacv
 QUSrW918j/H4KYKPgyrhq9V3CXil2Rtd5RB5SWx2ajX1hs0f1QDVUFjqCPKV1hk6vQh4
 XfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XGKLqR8tFVRO5q3ZMYLnxKvgLz8p/JwTRMP6Lmp8oKU=;
 b=pygQaxjKjqA6ZVgn7h5ioahKeM7iWRtYJEzClRkwz4ABKpuWvyVQYUUozCItMEA9Ny
 t+Uz4lQLBLWXbYZ1QTiL5fswu6qUtj9CHUM8NolJwXNZ1n6MaA0cWNbqoGs9iyFNcQBw
 kLKgmBAx++Mmxm+toBEJp/EwGq9BTfQ0EA8qcz6UmAIFT7OKDu/Tv7AW422Oj0LdoBQC
 w9kA6xfdJNCG6tRcfzo2OFS0Xn2x/VWL5joBK/x1XkYBJeO2SUEVfMuivpNyq3kriRtg
 kCOJHDWVFChBbiPeAwG4V9cBvqdEkZGn2sSkn7k8kEk8IAF9GAnB4bZ+6Sg1RoWbx1ER
 8Brg==
X-Gm-Message-State: AOAM530EApTLhP/S/1PXC+roAfUID+xvs2697uyuAJLXzUPU7unvz90v
 6qSteTS1rc7i9LBdjCs2DXuQSpgN
X-Google-Smtp-Source: ABdhPJzP93Gc0x9LwMe8FA02B1mYrC297sZVgqNg8PYCzfibu22My4aCDdWOndO1EM2Erzn9il7RLQ==
X-Received: by 2002:ad4:4e14:: with SMTP id
 dl20mr10589938qvb.101.1591371642936; 
 Fri, 05 Jun 2020 08:40:42 -0700 (PDT)
Received: from localhost.localdomain ([71.51.180.250])
 by smtp.gmail.com with ESMTPSA id r14sm87453qke.62.2020.06.05.08.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 08:40:42 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Prike.Liang@amd.com
Subject: [PATCH] drm/amdgpu/soc15: fix using ip discovery tables on renoir (v2)
Date: Fri,  5 Jun 2020 11:40:29 -0400
Message-Id: <20200605154029.118736-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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

The PWR block moved into SMUIO, so the ip discovery table
doesn't have an entry for PWR, but the register has the
same absolute offset, so just patch up the offsets after
updating the offsets from the IP discovery table.

v2: PWR became SMUIO block 1.  fix the mapping.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 623745b2d8b3..dd17a8422111 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -686,6 +686,9 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 				DRM_WARN("failed to init reg base from ip discovery table, "
 					 "fallback to legacy init method\n");
 				vega10_reg_base_init(adev);
+			} else {
+				/* PWR block was merged into SMUIO on renoir and became SMUIO block 1 */
+				adev->reg_offset[PWR_HWIP][0] = adev->reg_offset[SMUIO_HWIP][1];
 			}
 		}
 		break;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
