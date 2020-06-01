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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA446C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4A3E207D0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnoHZ+/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A3E207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B0BD6E29E;
	Mon,  1 Jun 2020 18:04:04 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 064E86E29E
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:03 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id v79so9908752qkb.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bCSvsIGRIarH/lnslL0wOSix5qaUpa9L9feO8m1324Y=;
 b=fnoHZ+/d2QUAht/lnprGurIb6H1lz1u0QZfJXHR6LX021snHd7nB/6kN+h2+i/7sXe
 15wccFTm2MEvwOH1CXBCfn+WCG8GAtnZ7cpwM4T3qOwcOmbZ5RY2B5fVsFhFyq2tjR5S
 Rm9xUfASgVIUy6sPX2xA4LwIsjyxW1b/j3MYh2SByPdk5PhEjN7OPkUxhOgYYqsWAB37
 MoB6bVia1F/YyiIaw+9KqEpUJ/SdL7U/K79xMqGRGsBFYda/u8SUp7R8shmokNxKZx2r
 8Qf6eYlm2Y6xPutw8IbjaKFQrP2pHHiqwxBx1pCUvty39JHbYbfN7mK6e0tFIr/72gFt
 RmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bCSvsIGRIarH/lnslL0wOSix5qaUpa9L9feO8m1324Y=;
 b=JIi+HDskQ04nWSjINhb8fVO8DZVW1ng361UwSbu2fvoWJOHzR8ecYDnZ1U8mmpnHL4
 Infx4GzEE4AH+NHwh8z/Nbl/RpwT4ZO5VRvlghAJnLxfurRB2ONDtANtjDHQVoLhHDki
 S+oQPyoX9xCGMd27qIuc5p3auaA1wrO/7bKksMsIZn0CCT6iF9PmAPrK+MBwXllltoh/
 1NEd3pnZzs6KY6RcMl5Amd2BWFgGDPWoooL2zJcm4vFptzZH2h5/nOKD7KtscSAuD5nz
 uHt4U/Rkk/Plq9gWqu8a3aOnm9p5FhObs9paORcNbugeM0nMFyBJOn4keso4nE2vAHJs
 ksEg==
X-Gm-Message-State: AOAM530pbr4QWwjVWFo7ZkaGSMmRV+fjWDfBkGF8a0+Xed7wm80N8FDw
 C41OUyucbGwvrhQ0dpblgrIPPsWY
X-Google-Smtp-Source: ABdhPJwYH5XDpOiMJWpES1woOIrz3i1GaO8f1tEtl/vvrXvs8aQG4qswXjBx3Om5hy9BIliSjDYXSg==
X-Received: by 2002:a37:e85:: with SMTP id 127mr20872670qko.178.1591034641992; 
 Mon, 01 Jun 2020 11:04:01 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:01 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 053/207] drm/amdgpu: add psp block load condition for
 sienna_cichlid
Date: Mon,  1 Jun 2020 14:00:05 -0400
Message-Id: <20200601180239.1267430-50-alexander.deucher@amd.com>
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

Enable PSP block for firmware loading and other security
setup only when amdgpu use PSP load type to load ucode.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index a4a80aed4b96..b4178ce267f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -488,7 +488,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
-		amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
+		if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
+			amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
 		    is_support_sw_smu(adev))
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
