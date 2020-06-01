Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193BCC433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E79F7206E2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPn57E7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79F7206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEC9A6E2D7;
	Mon,  1 Jun 2020 18:04:48 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2C046E2D7
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:47 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id er17so450288qvb.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=87aPMup3yMZUKJNE4KLrpZo6Dw2Bf+RbgZq+2dUpmqo=;
 b=QPn57E7I2igCYy9n9w65gcWbycQRsQCfHOo88UWTKZczQltuatgA3I79z5JhLFSoEF
 Ke6dxBFL/rSZm59N/WApyURgoWWNagVQVZnL2PnvAr55oHezsSEZJaiCeVOW+CPGoPCT
 djVim83T5JPoMf71OX0d24rscMgQuuGQw8otP6n8hvx3PfJ7unYxFt/C6APmvPrO6hsk
 8lYsKWXd8bW1MQ8cfavIOWUviL99oP5b5im70qD4hO8i0S4UhJj9ujBFjVrb2EVIGlkA
 /l5xRc0blf9VjIe4ZsYwBEB0yAOj2hXgR2xtm2xfVSFWRlZ3uyysXO/x7jixt7TV1G54
 QEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=87aPMup3yMZUKJNE4KLrpZo6Dw2Bf+RbgZq+2dUpmqo=;
 b=jiOIJlweP71l1WsSf+MzaQfSissh+rLQuUggqG1hkv5R4lFjhBRhmn4ENrx0D+GN7H
 sQHGTz95rZd0MzOiHg6/Wq6eGcp+R9mH2IDSvVgnKIwIun0wOvsgKwPPbO5BNwteF+1z
 cTIh6DexthlJ2Im2+GNkfg9TG3pt2660SPC/RgTKC9Gu0tSpEYgLliAn36K6LStiEnsr
 mG6v9BnmjmqIeaeBSDY4DOmKNtWp7cs5xHcFU3umRhl9gGg3tSfQgXBpvRvNZZrolyNk
 h9RVKbbEQztqy4Q1uN+Rx5aQ720Y3YET+zywwbch/CUR1Vxup2QP2Vzt2XJSA4uPxucR
 YXXg==
X-Gm-Message-State: AOAM530KSVUU/adU+why691Bez7AdcZ583n2rewFhA85ZY2IYfg16qFe
 rd9rPX05Dc50OMgApSUbB33pqr7V
X-Google-Smtp-Source: ABdhPJwiuOw8BF3VhV13jynKhwA6IjBMdcNUR9RX5xiiShPamgh//fGfN26XWsoU0DUCsvMHGlXpnw==
X-Received: by 2002:a0c:910c:: with SMTP id q12mr19593493qvq.22.1591034686879; 
 Mon, 01 Jun 2020 11:04:46 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:46 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 084/207] drm/amdgpu: enable VCN3.0 PG and CG for Sienna_Cichlid
Date: Mon,  1 Jun 2020 14:00:36 -0400
Message-Id: <20200601180239.1267430-81-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Liu <leo.liu@amd.com>

By setting up the flags to the ASIC

Signed-off-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 587d0b6821f8..80428ae470c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -710,8 +710,8 @@ static int nv_common_early_init(void *handle)
 		adev->external_rev_id = adev->rev_id + 0xa;
 		break;
 	case CHIP_SIENNA_CICHLID:
-		adev->cg_flags = 0;
-		adev->pg_flags = 0;
+		adev->cg_flags = AMD_CG_SUPPORT_VCN_MGCG;
+		adev->pg_flags = AMD_PG_SUPPORT_VCN;
 		adev->external_rev_id = adev->rev_id + 0x28;
 		break;
 	default:
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
