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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168B6C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E38BE2073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKYPzuly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38BE2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AABD16E301;
	Mon,  1 Jun 2020 18:21:23 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95F256E2F2
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:21:22 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id w3so9991758qkb.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v0q2z/BDSS3GVdjngKXR9Yqd0qHFQOvmyvHmXnjvbVQ=;
 b=QKYPzulyzTDNWQydHWcm+07cOuJtPOOP9UAjP78Wo+4QSnNGkIyN1bx2OxGHuNbsbM
 41din5i65NH/AwwecrrItyxftEz4moxRy6/v9S+73CAj15EmCcHH3OMBnLbdfhPlSixj
 mJZ3dk1mAUmhhPgWWdDYg9BYJKX7LsMKHtQ3WebXGIIT3Y3XnA+heWd8Ru7FGtKh2cAI
 WSDyCMKsvc5AFwZIxfv8jssqrjqLcNoWfDYPuhP/JvR7mFa2UXX38IAufzeti2QUJB7w
 FfPN4CzDGKdUOH1Z/wD1iV1ZfvV63IRpbp5aSiYsCczxp33ErcW4tlwupaeQZQwDsvzv
 wx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v0q2z/BDSS3GVdjngKXR9Yqd0qHFQOvmyvHmXnjvbVQ=;
 b=RIA7ot/6Wqc3BQ2Tym3p7GdDBRsmfe4XQakv2ybGOBS/A5EMKBpgJWZgLqdwvVsiPs
 QZjduzjV+8Cdeb88hcRx4L46dFWvUmeY7vF2PxhrZxJoHL3yBgUWsonMhaMVFb3hWy+t
 8yN4dY1tzKdTB+5pKzAHarwwS/gI2EgYAjFXv+WI83CER4gVoui5bkhervOUGWd6fkm7
 av/GYxRnQ6pmvWJYOW82Xl1UGcVAZhD+Oh/xCm+H3s60wupFDhA3WugtWt1zm6SR0oDZ
 y5wBKF0nYK91xq8+WcRO1Ay/HygdL7sewZ632Mar4mrAgIjH+TWd6BZWCt3lhbC/zXpr
 hHlw==
X-Gm-Message-State: AOAM533aF0QExAIj+Qyx+AJO8THcWedCqdoHB/9GQFyGFebpfvW+J+9f
 9rubCB60J8p/CN62xN+oDgDyXP90
X-Google-Smtp-Source: ABdhPJyHV+Hr3dMrzUgcUmkrarne4SccglawWK8hg/gzV8wU0B9B13wfqhW+ikNx1UN0rr2IxkCd2Q==
X-Received: by 2002:a37:845:: with SMTP id 66mr20758698qki.67.1591035681585;
 Mon, 01 Jun 2020 11:21:21 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:21:21 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 103/207] drm/amdgpu: change the offset for VCN FW cache window
Date: Mon,  1 Jun 2020 14:19:10 -0400
Message-Id: <20200601182054.1267858-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Liu <leo.liu@amd.com>

The signed header is added

Signed-off-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 011edbdd4e55..371c70a1e611 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -356,11 +356,8 @@ static void vcn_v3_0_mc_resume(struct amdgpu_device *adev, int inst)
 		WREG32_SOC15(VCN, inst, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
 			upper_32_bits(adev->vcn.inst[inst].gpu_addr));
 		offset = size;
-		/* No signed header for now from firmware
 		WREG32_SOC15(VCN, inst, mmUVD_VCPU_CACHE_OFFSET0,
 			AMDGPU_UVD_FIRMWARE_OFFSET >> 3);
-		*/
-		WREG32_SOC15(UVD, inst, mmUVD_VCPU_CACHE_OFFSET0, 0);
 	}
 	WREG32_SOC15(VCN, inst, mmUVD_VCPU_CACHE_SIZE0, size);
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
