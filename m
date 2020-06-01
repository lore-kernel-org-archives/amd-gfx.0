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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB5EC433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A63F420B80
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujw0GkIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63F420B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 630E089B98;
	Mon,  1 Jun 2020 18:03:23 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9908B89A5C
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:21 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id s1so9925126qkf.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OaYefb3+EGwqctY6TUCEVuawpnwYYi1ab6ep1P7PSAU=;
 b=ujw0GkIYSG8U3CP48kO+3QZbGLW+KyC02dvDWQGy/ERg9vvDKWgGtRjnaGrkd7Sk3Q
 mLS5CDJ9eLQFuuiyQxduRZcwHZRydv7PZvXjdUzzWNIg8ExkMh/7+51w6cp+lFVuMLgF
 vNa2+TOPm0nWp0PwY5sWe8m3O6MiNv5qMAi26u8ub5Xmlhz9eIjK1iEPhB1fonKzlDqE
 LS/xglSRxkYkX1a4oKGApValuCZA+5zn89pvL4+G+IhGBXtPdI1/uw05HZfZf4gVs54F
 xg9fA4A+ReoWDpxY6HliwM9gjr96H3py+eIwX2kiqCJFOrTdGweNaSYH4TBgcvoCOXGE
 O7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OaYefb3+EGwqctY6TUCEVuawpnwYYi1ab6ep1P7PSAU=;
 b=Fb68i8R6U5hkhugmDqXCsWFfXday8DFQy9qCIWI0A7eSyqoWy04Xi1SN23Uyk2FT9O
 cxR/RuKvSftkHIfLd6iEoE7xg1VO043nH3Ch1Aqok9V7eW7NB30b8Ky9YDL3IpJKscuJ
 mDBzIOIqxy5R4Xlzk4PYs5PW6ZUOS4b929xsJAgpoiQXDnTZ0l8ORgxr2dlmFFJKMadn
 yK58a+DxU/a1styyQXLO+Q4U1xPwisQCNnETJrtLIj90/RquJAX5TfdXJbo7Y48i5HT5
 9XmXHtJcYNj/xeWwdrDWXqHxhg9DrSJmIyCJp715WOdToz+bDdGifh4MSzZtiQIiSSSx
 vteQ==
X-Gm-Message-State: AOAM531USMgopn0qWDIj7tSM+mTJX4ZXOCECeQXiSF+hBCsu0HYKSt5/
 6obHOQjC5HzL7/fkkpHvDwZBob5Q
X-Google-Smtp-Source: ABdhPJx/7bykYAV1wMIOfnDXvWdt9Tl3HhleYnymDb81xwcVoALJrFOiAtXfY4LfR2BHmnY7fGF0LA==
X-Received: by 2002:a05:620a:2287:: with SMTP id
 o7mr20488762qkh.238.1591034597322; 
 Mon, 01 Jun 2020 11:03:17 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:13 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 022/207] drm/amdgpu: correct SDMA3 IH clinet id for
 sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:34 -0400
Message-Id: <20200601180239.1267430-19-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c          | 4 ++--
 drivers/gpu/drm/amd/include/soc15_ih_clientid.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index b9b218ba01ba..5a47f105cd14 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1166,7 +1166,7 @@ static int sdma_v5_2_sw_init(void *handle)
 		return r;
 
 	/* SDMA trap event */
-	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_SDMA3,
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_SDMA3_Sienna_Cichlid,
 			      SDMA3_5_0__SRCID__SDMA_TRAP,
 			      &adev->sdma.trap_irq);
 	if (r)
@@ -1408,7 +1408,7 @@ static int sdma_v5_2_process_trap_irq(struct amdgpu_device *adev,
 			break;
 		}
 		break;
-	case SOC15_IH_CLIENTID_SDMA3:
+	case SOC15_IH_CLIENTID_SDMA3_Sienna_Cichlid:
 		switch (entry->ring_id) {
 		case 0:
 			amdgpu_fence_process(&adev->sdma.instance[3].ring);
diff --git a/drivers/gpu/drm/amd/include/soc15_ih_clientid.h b/drivers/gpu/drm/amd/include/soc15_ih_clientid.h
index 1794ad1fc4fc..fb67bb55ed79 100644
--- a/drivers/gpu/drm/amd/include/soc15_ih_clientid.h
+++ b/drivers/gpu/drm/amd/include/soc15_ih_clientid.h
@@ -66,6 +66,7 @@ enum soc15_ih_clientid {
 	SOC15_IH_CLIENTID_VCN1		= SOC15_IH_CLIENTID_UVD1,
 	SOC15_IH_CLIENTID_SDMA2		= SOC15_IH_CLIENTID_ACP,
 	SOC15_IH_CLIENTID_SDMA3		= SOC15_IH_CLIENTID_DCE,
+	SOC15_IH_CLIENTID_SDMA3_Sienna_Cichlid    = SOC15_IH_CLIENTID_ISP,
 	SOC15_IH_CLIENTID_SDMA4		= SOC15_IH_CLIENTID_ISP,
 	SOC15_IH_CLIENTID_SDMA5		= SOC15_IH_CLIENTID_VCE0,
 	SOC15_IH_CLIENTID_SDMA6		= SOC15_IH_CLIENTID_XDMA,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
