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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD302C433E2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D6720C56
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZd4zCYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D6720C56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60BF76E2D5;
	Mon,  1 Jun 2020 18:04:40 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4265E6E2D1
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:39 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id v79so9910750qkb.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vq2aoFLI1UfToqEi62Mo2I/J6LXqYlT3n2HD60UPvFU=;
 b=iZd4zCYYtM2xG3sWF2qB/r20y741BspjZoYaU3mWPlc9fA9qL8tNEU4riGFQ3fZ7fF
 M6xsMqD0Zo+PzxVpjYUxyWjZwg0WyFASL6vmVGYkjvMfF293bTN86CnxamAd1jvrpZ81
 MSIl1sAeF/En74FtB6VgJvrnGDyt+dKJWHRBuPogniWPsv94B6NeiO+jO6mDcU2FzWXD
 emlP5gkCvE/TGd6/FEHdw2aWy+i/8X0//WmyePQhtv0eH6CS0H5KHQDmOkO8mkpq7Nmg
 Mm3lfXziACofeZOP4ex50DuSEyMeDzTKtC1qAwb2sLh7Oc6HGWzWyLQ88Ksjw+ND5TNQ
 Ppwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vq2aoFLI1UfToqEi62Mo2I/J6LXqYlT3n2HD60UPvFU=;
 b=cTf2p9GXog45bDyaJlQymtgG+EhTG9AYeBTZQm0zNMOsJPdLS53iErr0kBTsPJCHxr
 LLSsMGMU99Goo7ZIdCQ3WSSmK6qlJEx16VSnR5vbBmk8kkElVsD8wlW4FQeUkVXS1GQR
 w3fqIBwx+TMFDTJ8gYgbVHSc9CO1d7k7PyPkifcTVQ9hGL2BQwSwWkj9bTZmwD71gknW
 aArpaSFnA0DaWJ3ovo0MX1oZe6BNLvXjpoJ8Fk1fqDQ+RYYgMemQXyCNRbviT8+IELaN
 T2h1F+bJlN91KhlOfF0wbPjiRgsxIcRO+/c5nRUSf/F/6GV5k9nicw64A5G1fjthCCQh
 ormA==
X-Gm-Message-State: AOAM530d8OcdKDwDJlhSMZ4DHb+MIHHX5s5cuPUHqZzdi9YB8GOPp0Vr
 GpZ1h1V9ZVp4NEfaujSMCOvU2AuK
X-Google-Smtp-Source: ABdhPJx4A5cb2JiYt+6IABU6iC5M/L2Y80sRgYo4G8b7A5a+rf/4VWOOSZarKjfa/VTknAodon25NQ==
X-Received: by 2002:a37:650:: with SMTP id 77mr22154261qkg.369.1591034678240; 
 Mon, 01 Jun 2020 11:04:38 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:37 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 078/207] drm/amdgpu/mes10.1: update mes initialization
Date: Mon,  1 Jun 2020 14:00:30 -0400
Message-Id: <20200601180239.1267430-75-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Update mes initialization sequence.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index a0fd3c3c7397..8d2469fe2174 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -825,6 +825,7 @@ static int mes_v10_1_sw_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	adev->mes.adev = adev;
+	adev->mes.funcs = &mes_v10_1_funcs;
 
 	r = mes_v10_1_init_microcode(adev);
 	if (r)
@@ -875,20 +876,29 @@ static int mes_v10_1_hw_init(void *handle)
 			DRM_ERROR("failed to MES fw, r=%d\n", r);
 			return r;
 		}
-	} else {
-		DRM_ERROR("only support direct fw loading on MES\n");
-		return -EINVAL;
 	}
 
 	mes_v10_1_enable(adev, true);
 
 	r = mes_v10_1_queue_init(adev);
+	if (r)
+		goto failure;
+
+	r = mes_v10_1_set_hw_resources(&adev->mes);
+	if (r)
+		goto failure;
+
+	r = mes_v10_1_query_sched_status(&adev->mes);
 	if (r) {
-		mes_v10_1_hw_fini(adev);
-		return r;
+		DRM_ERROR("MES is busy\n");
+		goto failure;
 	}
 
 	return 0;
+
+failure:
+	mes_v10_1_hw_fini(adev);
+	return r;
 }
 
 static int mes_v10_1_hw_fini(void *handle)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
