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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0744AC4741F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9799A23A31
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYFTbygB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9799A23A31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DF7F6ED79;
	Fri, 25 Sep 2020 20:11:39 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 122406ED78
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:38 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id q10so2059297qvs.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9elA3tDSaXFhoR/9Y5GM28w7nwHtaX9Rwct412zr/3k=;
 b=iYFTbygBfx7cMEXgNBufqm6rIZ0K1WsZOQhZ1obYLl28XGpS3D2FLn1SE2Y4yi9Csg
 qXrGRpQ4l6QkPYOf0kdyk8MiJ7NKhlG/9WiAt/EQ+lpWiM7Fg1HigM2m73xpGfn6afjA
 G1WsxAwO2x/R8bNZ0+rYXG08bx+82MnooIqzbQ+9b94P1U/gr1O+3WOUOSCxtmv9vnmK
 xyIcs3xGq1XP9clnXkmtZXWtLtNNcwxKAgzEWxxkwC/rMUjgtJRr/7f+zhhr6eJDxql7
 XvskR4PO/gzG5cLyKy5/OP+jmhPa5AV1zVzFVVQh9IpeogP0srU+d/qgVdukeDFlFHs7
 c10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9elA3tDSaXFhoR/9Y5GM28w7nwHtaX9Rwct412zr/3k=;
 b=BQ6nviOpk4nALzOJBt2ak6Q0ICsw2tSVElxJJd0QEurarzMCFxxXt4KtHBelc486v8
 hO4eiwUUiI27ho7oa2+LkpVRn+moM+eXzMGaS4ifD0ToZwtZhlKSnavGX12iVQOXgip2
 Bk2Pp4yRCq+xpC0zsjJawdaDZZmf6dwi76Qa1ZvIZaZ2V99K31EtkbiZFayTyatf+VVy
 pS7x5sryL4rdyFQF7AWKfi9woEgMPkE3iBC18JPd01qhvplkl+Aa4H53F0RajhiJMUgS
 aPN1fTD5uYUXKgwEgK5fQAa7jj9Ve7uvtmaC9cA9QvcoB7Eu7ft42ejDi7hCwdxbOlxr
 gJog==
X-Gm-Message-State: AOAM530Gu9V4/xhTCfU9qb+1V787vR8eckc6JSkbLM/skDhnDrPCvow3
 ayicWqAw4kWFZSTSv5dYRAL26RmgSR8=
X-Google-Smtp-Source: ABdhPJxrVH86mfmvxcmSzS4yju7RfHcYFWdLhEuI3Ul931m1gsjhDwopSpZJwMK1rkWhGPUQkj4aCA==
X-Received: by 2002:a05:6214:929:: with SMTP id
 dk9mr351678qvb.60.1601064697101; 
 Fri, 25 Sep 2020 13:11:37 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:36 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 30/45] drm/amdgpu/powerplay: add vangogh asic name in smu v11
 (v2)
Date: Fri, 25 Sep 2020 16:10:14 -0400
Message-Id: <20200925201029.1738724-30-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 Huang Rui <ray.huang@amd.com>, Xiaojian Du <xiaojian.du@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaojian Du <xiaojian.du@amd.com>

This patch is to add vangogh asic name in smu v11.

v2: drop smu firmware name (N/A for VG)

Signed-off-by: Xiaojian Du <xiaojian.du@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h         | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 03198d214bba..f57dc586649a 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -32,6 +32,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV14 0x36
 #define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x39
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x5
+#define SMU11_DRIVER_IF_VERSION_VANGOGH 0x01
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index d8ca6d968813..effa4391b577 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -244,6 +244,9 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
 	case CHIP_NAVY_FLOUNDER:
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Navy_Flounder;
 		break;
+	case CHIP_VANGOGH:
+		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_VANGOGH;
+		break;
 	default:
 		dev_err(smu->adev->dev, "smu unsupported asic type:%d.\n", smu->adev->asic_type);
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_INV;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
