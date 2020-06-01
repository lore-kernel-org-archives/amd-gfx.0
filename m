Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985BBC433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 693CF206E2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iz0hzBII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693CF206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F056E29A;
	Mon,  1 Jun 2020 18:03:56 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AFF36E296
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:55 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id c12so8385195qtq.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Djz+zvZNsCcOjPCUP/r+h6MWpEtjSS6H25dA5OIq/zU=;
 b=Iz0hzBIIRdI8iTmyzQY5g025Pm+HcvDarm/fVIGE/3Ceqr3x4MMVu35DE/SLbY70xk
 XmbwhJrYHAqXxb8U99Yk/MkzTFAAVNT/EvPxN9Krp76tRk/Xfgdt9al1rLFR9+xejBz4
 1CqoaIfY7WwdWKsOu1H8ILKUemY+KaMNyTRLdStbaS3kT0mzk8vFXtM9wGDipHX3BHnE
 KLKBV6s8cuiW5U2pXEUQ7UbmB4kuV/CZZBcMHYbVYjkJqXX1bf4KfGzKua3YHJ6/NnMr
 ZWR1qoUKv5MFC/699Qp9uxEbkGoiEHB7vNbosMxmilYGe7b9qSVxNvhVm68CPKemUkVV
 V8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Djz+zvZNsCcOjPCUP/r+h6MWpEtjSS6H25dA5OIq/zU=;
 b=HAGAN0EZNaTgjMpu6pUlwB/tB1DbTyF7920fZABRCRcecYzD9FFf44Ccsk+ix2Mi9p
 gw5q7WNK6ABvwms8PJpb0d6KDz09Xypc3iNbBMcmq/l70O4HK5J/iCG43d6tGAHLvXGJ
 0QPD6ZAo90p3ca4i9094faJTngaesHpYDkSj24BEOwJ1UBPuw5cSU1ofLwxMUHec8CsA
 R8SV/lBGfINxT9HyXkZlGk/bHzLBj12avwLldO8zDNk6BfTWkOtDLFGq/LvnEyBO82q7
 0LAE9IHf7iJstq1mLGjmPfLRDu2rhyX1I8twehPYIdk7jxR1upHvnFPMRaKqr5t5fXWS
 gUEg==
X-Gm-Message-State: AOAM530JtEtxPO4WqaGogd5NkpnAom91gJWQjLRMprBLJ448MQg1c8Pl
 B8CC+S5M9kgCHEmnc0fKD6QdnHOE
X-Google-Smtp-Source: ABdhPJwH6N90Tbc7zRLovEI+1lfDQKLJWvGKAAfwasnC3HOCwuGBWRiNHu/NyEraP2fW7FrHrcU74Q==
X-Received: by 2002:ac8:23e3:: with SMTP id r32mr23435395qtr.268.1591034634396; 
 Mon, 01 Jun 2020 11:03:54 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:53 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 048/207] drm/amdgpu: enable psp ip block for sienna_cichlid
Date: Mon,  1 Jun 2020 14:00:00 -0400
Message-Id: <20200601180239.1267430-45-alexander.deucher@amd.com>
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
 Jack Xiao <Jack.Xiao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Jack Xiao <Jack.Xiao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index e2d97bcdf328..a4a80aed4b96 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -488,6 +488,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+		amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
 		    is_support_sw_smu(adev))
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
