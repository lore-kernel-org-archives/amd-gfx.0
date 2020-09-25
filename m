Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881AAC47420
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2616523A32
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+NqiA/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2616523A32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 713A26ED40;
	Fri, 25 Sep 2020 20:11:51 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C5E36ED1E
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:49 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id f142so4065143qke.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IuvjOnil0cU65rAkrNXxJBYw0HJFM8hgNHyEPLt1clc=;
 b=s+NqiA/gND8HHaMSe0FdXH7QGHUKZZk3pLavV+R44CxpfWFrMoLBJ+Xdy8Sljs9eaP
 HKx7WkYhIVymGhPbPqXT4x74G14mcTEfSDGnGh8gfSZdr2h1AE1e6vtX6aDKb5MrASPw
 U9hwhke65a3lAbEuHMv+v4eVYssTvaubMGJHeUoIAWfEl5EKiF2nJHBkwbe11a1PAXDV
 mwA+U5NudFr/J0uraFAy8f4O9cTUqNWW3iA7GSM+YOHWuEZOZXwaRBqXLh1pymoCy941
 cj6Ke/s0G19D/dE7Co2gBFC3f1V+Ca3F/tphXMhbIJYvGefP/hSIHP3iL9Jsx/2wg5UJ
 dkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IuvjOnil0cU65rAkrNXxJBYw0HJFM8hgNHyEPLt1clc=;
 b=bZRf7fZoxcThvy2nqCLsxbO4jwPEi+mpS40S7hKcCDWst3M9iz/m5XcY4gtymXshOf
 seD7Yss+VjJT1XAGRtVTAlM+oeP0aOXVgc8vO2tAzqU+fLsV3y75NDtDwD1WA0WF1kK3
 uxQ4lYq4poP7P8saUfT6lgiYfCNIQ5liXfAzCiXQfRn1ScLelqr156SlBZIOtcNfdHUr
 uszV1UJBnfjEIvmMjVeQyqPaZaAvpfxfcMUWD+RgPVr1Bdu6VYIn0jAtIG6W0QRYTB/E
 7Nkmso491qOOUZXdUHPQN560xSyGV+N95RApzLA0fuh6QFuCuc5mDH4WiXxxumxjbSlI
 9YFw==
X-Gm-Message-State: AOAM533QGUUHIHSeSVdilpc2ZmjeHbg+XBMT4+YAtpCQNjv8gYtsvUKo
 nWIY7Y6uph/fOtZVDGpwz7AJigmQu0I=
X-Google-Smtp-Source: ABdhPJwLusseInIXTrCI1S/eTcBRYRGXgq5nt1unG7ETTmFr988QODy1PDP7Bj437AwB3kiw/HzehQ==
X-Received: by 2002:a37:5fc6:: with SMTP id t189mr1653231qkb.78.1601064708671; 
 Fri, 25 Sep 2020 13:11:48 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:48 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 38/45] drm/amdgpu: disable gfxoff on vangogh for the moment
 (v2)
Date: Fri, 25 Sep 2020 16:10:22 -0400
Message-Id: <20200925201029.1738724-38-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200925201029.1738724-1-alexander.deucher@amd.com>
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

GFXOFF will be enabled once it's verified on real asic.

v2: move check into gfx10 module.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 83183541865f..fd29a6d7285b 100755
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3666,6 +3666,9 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdgpu_device *adev)
 		if (!gfx_v10_0_navi10_gfxoff_should_enable(adev))
 			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
 		break;
+	case CHIP_VANGOGH:
+		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
+		break;
 	default:
 		break;
 	}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
