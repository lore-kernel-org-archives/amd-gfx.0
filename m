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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F18C433E2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC312074B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViEyVJxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC312074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C4516E279;
	Mon,  1 Jun 2020 18:03:58 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF2186E279
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:57 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id 205so9961023qkg.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gwXfF8p6c/h2/30v7Uj029fBXMx/HL/ppXWVJD/1+OA=;
 b=ViEyVJxT5tip/ztD7E20GGXgesNqQWc7HjuUsukNZYYic3VEB9p45+wvrA3mwseMwi
 7SSzlvX7G8c7rhR//o3ng0BqNF9dA2QUbioC2FJ/EZ9DdbeSEPYPS3AIm3MWFdxmA7y/
 I25C9QxfEUxqJ+u2onhigPk8XI8pi8YKVCKz/HzWUATSzKxcCCbbPChPTMmpZTB5tTmi
 cSSW+4oq6A+JGEY+gXBWZ8j+tkwqV9K1Q7/hnayoXZpGxGRO0Uh6rJTSPbr+lxZgl5+y
 ANs6esERJ7XqVPFi/TNoOWreiXcWhy6ROk1f8x5SJCO2o/oDXM66zcvqOcZqGx1L65lg
 X/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gwXfF8p6c/h2/30v7Uj029fBXMx/HL/ppXWVJD/1+OA=;
 b=grtRchEHET7RPffvy8zqcmhLY0lIpzvI4UJyGpb7rvyzbJGMsWZki6YNhlVo+EATp8
 OMkWNdUmzbVcYUJE+Fc+wdcBiOyGpwkZG05FPBUxqWvl8OJCN19IbZEaK2NGzPfk0xOB
 oqjS9Kg+MxyRL9BUPlpVouF18ZTOSOAug2SA0vVciDqPplBOp72/Mp/bQSFmvmTTqKRb
 gy7gLDIRBfGN+Mtj/QRKrUYdVpx+eRpd8ahghDCwEGy5wgRvoUS3zn/IfSiuxhA77/so
 N0DUaoMBvUuWC6P8/Az+/ZJU8HUUlp8mwU0oYmSNU9MukzHtfcl/jfQBFZ4liwaK9AxW
 tclA==
X-Gm-Message-State: AOAM5306kEGL49XvhPrn3ljMr3+GYuiM56wUkRi4pAHlK46lO0gVzTAr
 iMQpDZML2dbO+c8sJoVH+/XIjf2U
X-Google-Smtp-Source: ABdhPJx+pXXFGwwWX/gukNpLehJMfOF9YQeQkFJIm+5ANTLBtrqq11xAanz9ywhI9xvAj4Kwa1iP6g==
X-Received: by 2002:a37:a6c2:: with SMTP id
 p185mr21304281qke.474.1591034636926; 
 Mon, 01 Jun 2020 11:03:56 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:56 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 050/207] drm/amdgpu: Use variable instead of constant for sdma
 doorbell range
Date: Mon,  1 Jun 2020 14:00:02 -0400
Message-Id: <20200601180239.1267430-47-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yong Zhao <Yong.Zhao@amd.com>

Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 82145572e5a3..52206050adb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -673,7 +673,8 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL_OFFSET), doorbell_offset);
 
 		adev->nbio.funcs->sdma_doorbell_range(adev, i, ring->use_doorbell,
-						      ring->doorbell_index, 20);
+						      ring->doorbell_index,
+						      adev->doorbell_index.sdma_doorbell_range);
 
 		if (amdgpu_sriov_vf(adev))
 			sdma_v5_2_ring_set_wptr(ring);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
