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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9778C4741F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 445272064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXUUIyse"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445272064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D58276E978;
	Wed,  7 Oct 2020 16:32:45 +0000 (UTC)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA2306E977
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:44 +0000 (UTC)
Received: by mail-qk1-x729.google.com with SMTP id q63so3489230qkf.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gMKXb9y2pcFt7ZwCWR99ou4t9bx1UmoJOv7+6jSGOoc=;
 b=SXUUIyseCPQovLmG4O2P7JotnMkU+R3DcQscHMnZUSgnhiehxAV0OTQ2GDCLM2PL0h
 jdRLsnZI9cLALMHn2IsSaoWAHuOnj6Q9XGwxpAZpF/H6k7rLVWBLw9ifnxzvLcvTc4Yu
 l8TBYxtw3hOQnBO4B99QuF1Zzw6dSFxXa0HN61AvYSYQHLU9oadGaE2J46LH4K9ar4Ft
 YGQ2aqhjBjEc3wYATp+IkmexQpEg7d8Wo4qgLhN3pV1ZoH5AEIzvb32Pv9Kj7pdWLmk1
 R1dCPpvIWBr099wJP5R1dQtAdLPcFPmgaObv6eumvqCd4LNUHsOvJtMkSeZg5RX4EEb0
 IJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gMKXb9y2pcFt7ZwCWR99ou4t9bx1UmoJOv7+6jSGOoc=;
 b=j4zN3qOLtBYG2+y+V1Q4Ka5Z8fuuL9RL8mksNtPOpTxxNqsFv6JDjvrkl+zZ64a2uP
 +NdYD9nndZIaRekkLE5Kql0jSrQ85wLNCtntl9qy15tby5RBr4EksRdoTuEPOQ3NsSbQ
 wtcTJhXeAbo43lOLFdnjLMDG1YwTN+f4Znpx6MFf/7BBWx1hvQM84w6wvQ0XnVouH432
 8ZygxNdgf2X7sUchnixvmcNVfPw7rHf0TwhpT1zH87wqqE9c9a7E+nKuBnJASDV29SRV
 Z/ge4xhBM2/4eah7pBC8yy76kkC135o9VVKSI442ycPm+nNWT3SsdTRt/rksjZGO46S5
 aoog==
X-Gm-Message-State: AOAM530vb60GRurV9ODcTBIkwce98k0NGqJTkfL5pPhaoZsfR9fj5MHS
 fPVlHPMWyeIU1pNSMDWey/kYnhDFlo0=
X-Google-Smtp-Source: ABdhPJzzBBh9MwLPqx9xQsp3nbkyrwG+KpDgGGRDBC6c3nsSaDdpMQT+NRA6Cw2w7KGIuqb6MO67vw==
X-Received: by 2002:a37:988:: with SMTP id 130mr3644777qkj.313.1602088363784; 
 Wed, 07 Oct 2020 09:32:43 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:43 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 40/50] drm/amdgpu: enable vcn3.0 for dimgrey_cavefis
Date: Wed,  7 Oct 2020 12:31:25 -0400
Message-Id: <20201007163135.1944186-41-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Enable vcn3.0 ip block for dimgrey_cavefis.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 229ec1d88bb6..b96b42e4264c 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -634,6 +634,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
+		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
 		break;
 	default:
 		return -EINVAL;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
