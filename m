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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534B2C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CF6F2077D
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCDvRWrd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF6F2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D049D6E262;
	Mon,  1 Jun 2020 18:03:27 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 742686E262
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:26 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id cv17so429981qvb.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JeP5PXohrqCKXvDUAXsygN/a1zGk60cVntcnwps0T+c=;
 b=jCDvRWrdYgzrE0nyJT6CcT8RoxtRbQEEYREBwYjwsjcHSVOeVWSpf5o0u/H2Qnk/6Z
 d06xe0vilMTNYyphAp5iAOf4PrjK7nChfE/jLgcx+P63+f24mvNgUPJY2pXVwgLOL3KX
 EotCZw4FLbArpj6yH0go9HiscgcMzqgx2R344bqUcq1ACqksxBm9Pa0s1+6ojaJdHSpD
 pVw0T6Rd4xKs12JjBnbhWNVCJYYvYamEL+g8hHiCK5bmDsfl93xVMK+/5YrDDyd5c0Fe
 tO5fEbWJbtL6KUdcPbi5GRxR1QHakDzSHwBHubPS9+XfOjUU2FazkRF93/ngBwuqQ3L8
 iaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JeP5PXohrqCKXvDUAXsygN/a1zGk60cVntcnwps0T+c=;
 b=e690+RW+tauKYp82eMvlScN5opL5ya4wh6tlbItkrWaiB2ZVeYuzmoK04Na3TUzgRT
 1qR6fulEyERT4pBX04w1YvMA1rh2iZSRRs4IWjyYGCB+qisixjdxPV4WyMi5AFfKrvpQ
 0uPI4FdPPVh8an49g6jB5y69WbLbZlG+UAvzl092//WjCbQQcDZrIz4K3q53JkTyAz4B
 Wlxx9YPQWo1LeShWlYNWJulQI5NHbSH9MSsEQvEG6ZQScrABTfqiZ/KdkGg1fwsMZiLp
 vuiPKoolaBQS0fCMtv4I8DtZ40yrUjt0HXNXjMCwIjLPdCkuul7ufNDhMug4s6QdgAf7
 9I2g==
X-Gm-Message-State: AOAM533/yLNSPyR1tpieb1Cqn8EspiC2HezvXROD/YMap+sIi3Kjcs/s
 Y94qkXXPysPIADlFFhp5lU1Nb8r6
X-Google-Smtp-Source: ABdhPJzArLRWMz+2JyJT0bjCzhxK1QtJYRLpeOCx4W4wYw90kveZX8fNGC+yJ7Rx7T6sQTk9qdzzOg==
X-Received: by 2002:a0c:910c:: with SMTP id q12mr19586935qvq.22.1591034602369; 
 Mon, 01 Jun 2020 11:03:22 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:21 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 024/207] drm/amdgpu: add virtual display support for
 sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:36 -0400
Message-Id: <20200601180239.1267430-21-alexander.deucher@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 860c69cccf94..1b17fca98fef 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -488,6 +488,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
+			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
 		break;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
